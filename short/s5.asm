PMat@0 proc
        push ebp
        mov ebp,esp
        push eax
        push ebx
        push ecx
        push edx
        push edi

        mov edi, [ebp+8]
        mov ecx, [ebp+12]
        mov eax, ecx
        xor edx, edx
        xor ebx, ebx
M:
        mov bx, [edi+edx*2]
        and ebx, 1
        cmp ebx, 1
        je N
        inc edx
        cmp edx, ecx
        jb M
        jmp E
N:
        mov word ptr [edi+edx*2], 0
        add edx, eax
        loop N
E:
        pop edi
        pop edx
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 2*4
PMat@0 endp
