include console.inc

    .data
        max_len equ 512
        text_1 db max_len dup (?)
        text_2 db max_len dup (?)
        len_unic_1 db ?
        len_unic_2 db ?
        len_1 dw ?
        len_2 dw ?

    .code
input proc
        push ebx     
        mov ebx, [esp+2*4]
        mov ecx, 256
        xor eax, eax
        xor edx, edx

null_stack:
        push 0
        loop null_stack

enter_symbol:
        inchar al
h:      
        cmp al, '\'
        je slash

hh:
        cmp al, '_'
        je check_first_end

check:
        inc ecx
        cmp ecx, max_len
        jae wrong_text
        mov byte ptr [ebx], al
        mov dword ptr[esp+4*eax], 1
        inc ebx
        jmp enter_symbol

slash:
        inchar al
        jmp check

check_first_end:
        inchar al
        cmp al, '@'
        je check_second_end
        inc ecx
        cmp ecx, max_len
        jae wrong_text
        mov byte ptr [ebx], '_'
        inc ebx
        jmp h

check_second_end:
        inchar al
        cmp al, '_'
        je end_enter
        inc ecx
        cmp ecx, max_len
        jae wrong_text
        mov byte ptr [ebx], '_'
        inc ebx
        inc ecx
        cmp ecx, max_len
        jae wrong_text
        mov byte ptr [ebx], '@'
        inc ebx
        jmp h

end_enter:
        cmp ecx, 0
        je  wrong_text
        mov byte ptr [ebx], '0'
        mov eax, ecx
        mov ecx, 256

unic_len:
        pop ebx
        add edx, ebx
        loop unic_len	    
        mov ecx, eax
	    mov eax, 1
        jmp end_input        
	
wrong_text:
        mov eax, 0

end_input:
        pop ebx
        ret 4
input endp
;---------------------------------------------------
;procedure first_rule(ebx: integer {^array[1..n] of char}; ecx: word {n});

first_rule proc
        push eax
        push ebx
        push ecx
        mov ebx, [esp+4*4]
        mov ecx, [esp+4*5]
      
replacing_letter:
        cmp byte ptr [ebx], 'a'
        jb small_letter
        cmp byte ptr [ebx], 'z'
        ja small_letter
        mov al,[ebx]
        sub al, 'a'
        add al, 'a'
	    mov [ebx], al
        jmp end_replacing

small_letter:
        cmp byte ptr [ebx], 'A'
        jb end_replacing
        cmp byte ptr [ebx], 'Z'
        ja end_replacing
        mov al,[ebx]
        sub al, 'a'
        add al, 'a'
	    mov [ebx], al

end_replacing:
        inc ebx
        loop replacing_letter
      
end_first_rule:
        pop ecx
        pop ebx
        pop eax
        ret 4*2
first_rule endp
;---------------------------------------------------
;procedure second_rule(ebx: integer {^array[1..n] of char}; ecx: word {n});

second_rule proc
        push eax
        push ebx
        push edx      
        mov ebx, [esp+4*4]
        mov ecx, [esp+4*5]
        mov edx, ecx

removal:
        cmp ecx, 0
        je end_second_rule
        cmp byte ptr [ebx], 10
        je next_symbol
        cmp byte ptr [ebx], ' '
        je next_symbol
        cmp byte ptr [ebx], '0'
        jb large_symbol
        cmp byte ptr [ebx], '9'
        jbe next_symbol

large_symbol:
        cmp byte ptr [ebx], 'a'
        jb small_symbol
        cmp byte ptr [ebx], 'z'
        jbe next_symbol

small_symbol:
        cmp byte ptr [ebx], 'a'
        jb removal_symbol
        cmp byte ptr [ebx], 'z'
        jbe next_symbol

removal_symbol:
        dec edx
        dec ecx
        push ecx
        push ebx
        jecxz null

moving:
        mov ah, [ebx+1]
        mov [ebx], ah
        inc ebx
        loop moving
   
null:
        pop ebx
        pop ecx
        jmp removal

next_symbol:
        inc ebx
        dec ecx
        jmp removal

end_second_rule:   
        mov ecx, edx
        pop edx
        pop ebx
        pop eax
        ret 4*2
second_rule endp
;---------------------------------------------------
output proc
        push eax
        push ebx
        push ecx
        mov ebx, [esp+4*4]
        mov ecx, [esp+4*5]
        xor eax, eax
        outstrln '"""'
	    jecxz end_output

printing_symbol:
        outchar byte ptr [ebx][eax]
        inc eax
        loop printing_symbol

end_output:
    	outstrln ' '
        outstrln '"""'  
        pop ecx
        pop ebx
        pop eax
        ret 2*4
output endp
;---------------------------------------------------
start:
        outstrln 'введите первый текст: '
        push offset text_1
        call input
        mov len_unic_1, dl
        mov len_1, cx    
        cmp eax, 0
        jne second_text
        outstrln 'введен неправильный текст'
        jmp end_program

second_text:    
        outstrln 'введите второй текст: '
        flush
        push offset text_2
        call input 
        mov len_unic_2, dl
        mov len_2, cx
        cmp eax, 0
        jne change_1
        outstrln 'введен неправильный текст'
        jmp end_program
  
change_1:
        mov al, len_unic_1
        cmp al, len_unic_2
        jb change_2
        outstrln 'Длина первого текста больше'
        outstrln 'В первом тексте каждая строчная латинская буква заменяется '
        outstr 'соответствующей прописной буквой, а прописная – строчной'
        outstrln 'Во втором тексте удаляются все знаки припинания'
        movzx eax, len_1
        push eax
        push offset text_1
        call first_rule	
        movzx eax, len_2
        push eax
        push offset text_2
        call second_rule
        mov len_2, cx
        jmp printing_texts
        
change_2:
        outstrln 'Длина второго текста больше'
        outstrln 'Во втором тексте каждая строчная латинская буква заменяется '
        outstr 'соответствующей прописной буквой, а прописная – строчной'
        outstrln 'В первом тексте удаляются все знаки припинания'
        movzx eax, len_2
        push eax
        push offset text_2
        call first_rule	
        movzx eax, len_1
        push eax
        push offset text_1
        call second_rule
        mov len_1, cx

printing_texts:
        outstrln 'Первый текст:'
        movzx eax, len_1
        push eax
        push offset text_1
        call output
        
        outstrln 'Второй текст:'
        movzx eax, len_2
        push eax
        push offset text_2
        call output

end_program:   
        pause
        exit
end start
