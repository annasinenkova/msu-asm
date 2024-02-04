N equ 100000
ColPoint record Clr:10, X:11, Y:11
.data
Mas ColPoint N dup <>

.code
F proc
        push ebp
        mov ebp,esp
        push ebx
        push ecx
        push edx
        push edi
        mov edi, [ebp+8]
        mov ecx, [ebp+12]
        mov edx, [ebp+16]

        xor eax, eax
L:
        mov ebx, [edi]
        shr ebx, Clr
        cmp ebx, edx
        jne N
        add eax, 1
N:
        add edi,type ColPoint
        loop L

        pop edi
        pop edx
        pop ecx
        pop ebx
        pop ebp
        ret 3*4
F endp


