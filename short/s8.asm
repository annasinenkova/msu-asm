N equ N=100000
FioA20 proc
        push ebp
        mov ebp,esp
        push ecx
        push edx
        push ebx
        push esi
        
        mov ebx, [ebp+8]
        mov ecx, [ebp+12]
        mov esi, [ebp+16]
        xor edx, edx

        assume ebx:ptr Pers
L:
        cmp [ebx].Age, 20
        jne N       
        cmp byte ptr [ebx].Fio,'A'
        jne N
        inc edx
N:
        add ebx, type Pers
        loop L
        assume ebx:nothing

        mov [esi], edx
        pop esi
        pop ebx
        pop edx
        pop ecx
        pop ebp
        ret 3*4
FioA20 endp
