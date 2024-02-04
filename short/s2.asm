F5 proc
        push ebp
        mov ebp,esp
        push ebx
        push ecx
        push edx
        mov edx,[ebp+8]
        mov ecx, 28
L:
        mov ebx, 31
        and ebx, edx
        shr edx, 1
        cmp ebx, 31
        je M
        loop L
        mov eax, 00h
        jmp N
M:
        mov eax, 0FFh
N:
        pop edx
        pop ecx
        pop ebx
        pop ebp
        ret 4
F5 endp

Start:
;-------------------
        push A
        call F5
        exit
        mov byte ptr B, al
;-------------------
end Start






