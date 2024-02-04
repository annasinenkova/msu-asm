    ZeroNeg macro X:req,N:=<0>
        local K
        local L
        K=0
        for i,<eax,ebx,ecx,edx,esi,edi,ebp,esp>
            ifidni <i>,<X>
                K=1
                exitm
            endif
        endm

        cmp N, 0
        jne L
        if K EQ 1
            sub X,X
        elseif type X EQ 1 or type X EQ 2 or type X EQ 4
            mov X, 0
        endif
        jmp V
L:
        neg X
V:
    endmы
















