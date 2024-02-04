P proc
        push ebp
        mov ebp,esp
        sub esp, 4

        push eax
        push ebx
        push ecx
        push edx

        mov ecx, [ebp+8]
        mov ebx, [ecx]
        mov eax, [ebp+12]
        add ebx, eax
        cdq
        mul ebx
        mov ebx, 15
        div ebx
        mov [ecx], dl

        pop edx
        pop ecx
        pop ebx
        pop eax

        mov esp, ebp
        pop ebp
        ret 2*4
P endp

Start:
        mov eax, A
        xor ecx, ecx
        mov cl, B
        div ecx
        push eax
        push B
        call P

        exit
end Start
