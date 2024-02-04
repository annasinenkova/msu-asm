SUM proc
        push ebp
        mov ebp,esp
        push eax
        push ebx
        push ecx
        push edx
        push esi

        mov esi,[ebp+8]
        mov ecx,[ebp+12]
        mov al, [esi]
        mov ebx, 1
        mov edx, ebx
L:
        cmp al, [esi]
        jae N
        mov al, [esi]
        mov edx, ebx
N:
        add esi, 1
        add ebx, 1
        loop L

        outwordln eax
        outwordln edx

        pop esi
        pop edx
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 2*4
SUM endp

Start:
;-------------------
        mov eax, N
        shr eax, 1
        push eax
        push offset A
        call SUM
        exit
;-------------------
end Start






