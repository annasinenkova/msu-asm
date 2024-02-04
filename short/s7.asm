FLchar proc
        push ebp
        mov ebp,esp
        push edi
        push ecx
        push edx

        mov edi, [ebp+8]
        mov edx, [ebp+12]

        xor eax, eax
        xor ecx, ecx

        mov cl, [edi]
        sub cl, '0'
        jecxz N;
        
        cmp dl, [edi+1]
        jne L
        add edi, ecx
        cmp dl, [edi]
        jne L
N:
        mov eax, 0FFh
L:
        pop edx
        pop ecx
        pop edi
        pop ebp
        ret 2*4
FLchar endp

Start: 
-------------------
        xor eax, eax
        mov al, '#'
        push eax
        push offset A
        call FLchar
        mov R, al
-------------------
end Start

