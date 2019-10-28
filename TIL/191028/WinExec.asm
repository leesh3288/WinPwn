; https://idafchev.github.io/exploit/2017/09/26/writing_windows_shellcode.html
; https://docs.microsoft.com/windows/win32/debug/pe-format

format PE console
use32
entry start

start:
    push ebx
    push ebp
    mov ebp, esp
    sub esp, 4h
    call _locate_kernel32
    mov [ebp - 04h], eax  ; kernel32 base
    push 00636578h
    push 456e6957h  ; "WinExec\0"
    mov ebx, esp
    push ebx
    push eax
    call _locate_function
    add esp, 10h
    test eax, eax  ; WinExec function addr
    jz .end  ; not found
    xor ebx, ebx
    push ebx  ; null termination
    push 6578652eh
    push 636c6163h
    push 5c32336dh
    push 65747379h
    push 535c7377h
    push 6f646e69h
    push 575c3a43h
    mov ebx, esp  ; "C:\Windows\System32\calc.exe"
    push 10
    push ebx
    call eax
    add esp, 20h
    .end:
        leave
        pop ebx
        ret

_locate_kernel32:  ; args 0
    push ebx
    push ebp
    mov ebp, esp
    mov ebx, [fs:30h]  ; TEB -> PEB
    mov ebx, [ebx + 0Ch]  ; PEB -> PEB_LDR_DATA
    mov ebx, [ebx + 14h]  ; PEB_LDR_DATA -> LDR_MODULE
    mov ebx, [ebx]
    mov ebx, [ebx]
    mov eax, [ebx + 10h]  ; LDR_MODULE -> BaseAddress
    leave
    pop ebx
    ret

_locate_function:  ; args 2: dll base, function name pointer
    push ebx
    push ecx
    push edx
    push edi
    push esi
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 1Ch]  ; dll base
    mov ecx, [ebx + 3Ch]  ; RVA of PE Signature
    add ecx, ebx          ; addr of PE Signature
    mov ecx, [ecx + 78h]  ; RVA of Export Table
    add ecx, ebx          ; addr of Export Table
    mov edx, [ecx + 18h]  ; number of entries in name pointer table
    mov edi, [ecx + 20h]  ; RVA of Name Pointer Table
    add edi, ebx          ; addr of Name Pointer Table
    xor esi, esi          ; counter
    xor eax, eax
    .loop:
        cmp esi, edx
        jae .end
        push dword [edi + esi*4]
        add [esp], ebx
        push dword [ebp + 20h]
        call _strcmp
        add esp, 8h
        test eax, eax
        jz .found
        xor eax, eax
        inc esi
        jmp .loop
    .found:
        mov edi, [ecx + 24h]  ; RVA of Ordinal Table
        add edi, ebx          ; addr of Ordinal Table
        movzx esi, word [edi + esi*2]  ; ordinal number
        mov edi, [ecx + 1Ch]  ; RVA of Address Table
        add edi, ebx          ; addr of Address Table
        mov eax, [edi + esi*4]
        add eax, ebx
    .end:
        leave
        pop esi
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret

_strcmp:  ; args 2: s1, s2
    push ebx
    push edi
    push esi
    push ebp
    mov ebp, esp
    mov edi, [ebp + 14h]
    mov esi, [ebp + 18h]
    .loop:
        mov al, [edi]
        mov bl, [esi]
        test al, al
        jz .end  ; *s1 == '\0'
        cmp al, bl
        jnz .end ; *s1 != *s2
        inc edi
        inc esi
        jmp .loop
    .end:
        sub al, bl
        movsx eax, al
        leave
        pop esi
        pop edi
        pop ebx
        ret