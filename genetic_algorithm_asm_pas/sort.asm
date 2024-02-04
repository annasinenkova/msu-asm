.686
.model flat

    .code 
public S
    .code
S proc
        push ebp
        mov ebp,esp
        pushad
        mov ecx, [ebp+8]
        mov edi, [ebp+12]
        mov esi, 24      
L:
        push ecx
        mov eax, ecx
        mul esi
        mov ebx, eax
	    mov edx, eax
N:
        sub edx, 24
	    finit
        fld  qword ptr [edi+edx+16]
        fld  qword ptr [edi+ebx+16]
        xor eax, eax
        fcomi st(0), st(1)
        jae M
	    mov ebx, edx
M:
        loop N

        pop ecx
        mov eax, ecx
        mul esi; eax := eax*24
        mov edx, dword ptr[edi+eax]
        xchg edx, dword ptr[edi+ebx]
        mov dword ptr[edi+eax], edx
        mov edx, dword ptr[edi+eax+4]
        xchg edx, dword ptr[edi+ebx+4]
        mov dword ptr[edi+eax+4], edx
        mov edx, dword ptr[edi+eax+8]
        xchg edx, dword ptr[edi+ebx+8]
        mov dword ptr[edi+eax+8], edx
	    mov edx, dword ptr[edi+eax+12]
        xchg edx, dword ptr[edi+ebx+12]
        mov dword ptr[edi+eax+12], edx
        mov edx, dword ptr[edi+eax+16]
        xchg edx, dword ptr[edi+ebx+16]
        mov dword ptr[edi+eax+16], edx
	    mov edx, dword ptr[edi+eax+20]
        xchg edx, dword ptr[edi+ebx+20]
        mov dword ptr[edi+eax+20], edx

        loop L

	    popad
        pop ebp
        ret 4*2
S endp

end

