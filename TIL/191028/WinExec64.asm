; https://nytrosecurity.com/2019/06/30/writing-shellcodes-for-windows-x64/
; https://docs.microsoft.com/windows/win32/debug/pe-format

format PE64 console
entry start

section '.rodata' data readable
    fname_WE db "WinExec", 0
    exedir db "C:\Windows\System32\calc.exe", 0
    fname_EP db "ExitProcess", 0

section '.text' code readable executable
    start:
        sub rsp, 8h
        and rsp, 0xFFFFFFFFFFFFFFF0  ; align by 0x16
        
        sub rsp, 20h
        call locate_kernel32
        mov [rsp + 20h], rax
        
        mov rdx, fname_WE
        mov rcx, [rsp + 20h]
        call locate_function  ; find WinExec
        
        mov rdx, 0
        mov rcx, exedir
        call rax  ; WinExec(exedir, 0)
        
        mov rdx, fname_EP
        mov rcx, [rsp + 20h]
        call locate_function  ; find ExitProcess
        
        mov rcx, 0
        call rax  ; ExitProcess(0)

    locate_kernel32:  ; args 0
        mov rax, [gs:60h]     ; PEB
        mov rax, [rax + 18h]  ; PEB -> PEB_LDR_DATA
        mov rax, [rax + 20h]  ; PEB_LDR_DATA -> LDR_MODULE
        mov rax, [rax]
        mov rax, [rax]
        mov rax, [rax + 20h]  ; LDR_MODULE -> BaseAddress
        ret
    
    locate_function:  ; args 2: dll base, function name ptr
        push rbx
        push rdi
        push rsi
        push r8
        mov [rsp + 28h], rcx  ; dll base
        mov [rsp + 30h], rdx  ; function name ptr
        mov ebx, [rcx + 3Ch]  ; RVA of PE Signature
        add rbx, rcx          ; addr of PE Signature
        mov ebx, [rbx + 88h]  ; RVA of Export Table
        add rbx, rcx          ; addr of Export Table
        mov r8d, [rbx + 18h]  ; number of entries in name pointer table
        mov edi, [rbx + 20h]  ; RVA of Name Pointer Table
        add rdi, rcx          ; addr of Name Pointer Table
        xor rsi, rsi          ; counter
        xor rax, rax
        .loop:
            cmp rsi, r8
            jae .end
            mov ecx, [rdi + rsi*4]
            add rcx, [rsp + 28h]
            mov rdx, [rsp + 30h]
            sub rsp, 28h
            call strcmp
            add rsp, 28h
            test rax, rax
            jz .found
            xor rax, rax
            inc rsi
            jmp .loop
        .found:
            mov rcx, [rsp + 28h]
            mov edi, [rbx + 24h]  ; RVA of Ordinal Table
            add rdi, rcx          ; addr of Ordinal Table
            movzx rsi, word [rdi + rsi*2]  ; ordinal number
            mov edi, [rbx + 1Ch]  ; RVA of Address Table
            add rdi, rcx          ; addr of Address Table
            mov eax, [rdi + rsi*4]
            add rax, rcx
        .end:
            pop r8
            pop rsi
            pop rdi
            pop rbx
            ret
    
    strcmp:  ; args 2: s1, s2
        push rbx
        .loop:
            mov al, [rcx]
            mov bl, [rdx]
            test al, al
            jz .end  ; *s1 == '\0'
            cmp al, bl
            jnz .end ; *s1 != *s2
            inc rcx
            inc rdx
            jmp .loop
        .end:
            sub al, bl
            movsx rax, al
            pop rbx
            ret