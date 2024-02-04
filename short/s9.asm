    MaxDivMin macro X:req,Y:req
        local L
        if type X EQ 1 or type X EQ 2
            movzx eax,X
        elseif type X EQ 4
            mov eax,X
        endif

        if type Y EQ 1 or type Y EQ 2
            movzx ebx,Y
        elseif type Y EQ 4
            mov ebx,Y
        endif

        cmp eax, ebx
        jae L
        xchg eax, ebx
L:
        xor edx, edx
        div ebx
    endm
