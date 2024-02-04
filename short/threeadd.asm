include console.inc

Addthree macro X,Y,Z
    if (type X EQ type Y or type X EQ 0) and (type Y EQ type Z or type Y EQ 0) and (type Z EQ 1 or type Z EQ 2)
        if type Z EQ 1
            mov al, Z
            add al, Y
            add al, X
            if type Y EQ 0
                mov Z, al
            elseif type X EQ 0
                mov Y, al
            else
                mov X, al
            endif
        else
            mov ax, Z
            add ax, Y
            add ax, X
            if type Y EQ 0
                mov Z, ax
            elseif type X EQ 0
                mov Y, ax
            else
                mov X, ax
            endif
        endif
    else
        .err <Bad arguments!>
        exitm
    endif
endm


.data
        b1 db ?
        b2 db ?
        b3 db ?
        w1 dw ?
        w2 dw ?
        w3 dw ?
        d1 dd ?
        d2 dd ?
        d3 dd ?

.code
Start:
        inint b1,"Enter b1 = "
        inint b2,"Enter b2 = "
        inint b3,"Enter b3 = "
        inint w1,"Enter w1 = "
        inint w2,"Enter w2 = "
        inint w3,"Enter w3 = "
        Addthree b1, b2, b3
        outintln b1, 20, 'b1 = '
        outintln b2, 20, 'b2 = '
        outintln b3, 20, 'b3 = '
        outintln w1, 20, 'w1 = '
        outintln w2, 20, 'w2 = '
        outintln w3, 20, 'w3 = '
        pause   
        exit
end Start

