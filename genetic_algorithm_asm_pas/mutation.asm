.686
.model flat

    .code 
extern SYSTEM_$$_RANDOM$LONGINT$$LONGINT:near
public Swap_bit
public Transposition_bits
public Reverse
    .code
Changing_bit proc
        push ebp
        mov ebp,esp
	    push ebx
        push ecx

        mov eax, 31
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov ebx, 1
	    mov ecx, eax
        shl ebx, cl
        mov eax, [ebp+8]
        xor eax, ebx
        
        pop ecx
	    pop ebx
        pop ebp
        ret 4
Changing_bit endp


Swap_bit proc
        push ebp
        mov ebp,esp
        push ebx
        push ecx
        push edx

        mov eax, [ebp+8]
        mov ecx, [ebp+16]
        mov ebx, 1
        shl ebx, cl
        and ebx, eax
        shr ebx, cl
        mov ecx, [ebp+12]
        mov edx, 1
        shl edx, cl
        and edx, eax
        shr edx, cl
        cmp edx, ebx
        je hhh
        mov edx, 1
        shl edx, cl
        mov ebx, 1
        mov ecx, [ebp+16]
        shl ebx, cl
        or edx, ebx
        xor eax, edx
hhh:
        pop edx
        pop ecx
        pop ebx
        pop ebp
        ret 4*3
Swap_bit endp


Transposition_bits proc
        push ebp
        mov ebp,esp

        mov	 eax, 31
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	    push eax
        mov	 eax, 31
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        push eax
        mov eax, [ebp+8]
        push eax
        call Swap_bit

        pop ebp
        ret 4
Transposition_bits endp

Reverse proc
        push ebp
        mov ebp,esp
        push ebx
        push ecx
        push edx

        mov	 eax, 31
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT        
        mov ecx, eax
        mov ebx, eax
        mov eax, [ebp+8]
        inc ecx        
        shr ecx, 1
        inc ecx
        xor edx, edx
hh:
        push ebx
        push edx
        push eax
        call Swap_bit
        inc edx
        dec ebx
        loop hh

        pop edx
        pop ecx
        pop ebx
        pop ebp
        ret 4
Reverse endp

end
