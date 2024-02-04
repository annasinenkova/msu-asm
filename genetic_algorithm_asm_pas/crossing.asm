.686
.model flat

    .code 
extern SYSTEM_$$_RANDOM$LONGINT$$LONGINT:near
public Single
public Two_crossing
public Universal_crossing
public Uniform_crossing
    .code
Single proc
        push ebp
        mov ebp,esp
        push eax
        push ebx
        push ecx
	    push edx
	
        mov eax, 31
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov edx, 1
	    mov ecx, eax
        shl edx, cl
        sub edx, 1
        mov ebx, [ebp+16]
        and ebx, edx
        not edx
        mov eax, [ebp+20]
        and eax, edx
        or ebx, eax
    	mov eax, [ebp+12]
        mov [eax], ebx
        mov ebx, [ebp+16]
        and ebx, edx
        not edx
        mov eax, [ebp+20]
        and eax, edx
        or ebx, eax
	    mov eax, [ebp+8]
        mov [eax], ebx
        
	    pop edx
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 4*4
Single endp

Two_crossing proc
        push ebp
        mov ebp,esp
        push eax
        push ebx
        push ecx
	    push edx

        mov eax, 31
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov ebx, 1
	    mov ecx, eax
        shl ebx, cl
        sub ebx, 1
        mov eax, 31
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov edx, 1
	    mov ecx, eax
        shl edx, cl
        sub edx, 1
        xor edx, ebx
        mov ebx, [ebp+16]
        and ebx, edx
        not edx
        mov eax, [ebp+20]
        and eax, edx
        or ebx, eax
        mov eax, [ebp+12]
        mov [eax], ebx
        mov ebx, [ebp+16]
        and ebx, edx
        not edx
        mov eax, [ebp+20]
        and eax, edx
        or ebx, eax
        mov eax, [ebp+8]
        mov [eax], ebx
        
	    pop edx
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 4*4
Two_crossing endp


Universal_crossing proc
        push ebp
        mov ebp,esp
        push eax
        push ebx
        push ecx
        
        mov	ecx, 32
        xor ebx, ebx
hhh:    mov eax, 2      
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        shl ebx, 1
        or ebx, eax
        loop hhh
        mov ecx, ebx
        mov ebx, [ebp+16]
        and ebx, ecx
        not ecx
        mov eax, [ebp+20]
        and eax, ecx
        or ebx, eax
        mov eax, [ebp+12]
        mov [eax], ebx
        mov ebx, [ebp+16]
        and ebx, ecx
        not ecx
        mov eax, [ebp+20]
        and eax, ecx
        or ebx, eax
        mov eax, [ebp+8]
        mov [eax], ebx
        
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 4*4
Universal_crossing endp


Uniform_crossing proc
        push ebp
        mov ebp,esp
        push eax
        push ebx
        push ecx

        mov eax, 4294967295  
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov ebx, [ebp+16]
        and ebx, eax
        not eax
        mov ecx, [ebp+12]
        and ecx, eax
        or ebx, ecx
        mov eax, [ebp+8]
        mov [eax], ebx
        
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 4*3
Uniform_crossing endp

end
