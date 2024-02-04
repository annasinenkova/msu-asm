include console.inc
    .data
        c1 db 0
        c2 db 0
        S dd 0
    .code
Start:
        xor eax, eax
L:
        inchar c2
        cmp c2, '.'
        je E
        cmp c2, '0'
        jb L
        cmp c2, '9'
        ja L
        mov al, c2
        cmp al, c1
        mov c1, al
        jb L
        sub al, '0'
        add S, eax
        jmp L
E:
        outint S, 20, 'Answer '
        exit
end Start


















