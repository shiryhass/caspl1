section	.rodata
LC0:
	DB	"%s", 10, 0	; Format string

section .bss
LC1:
	RESB	32

section .text
	align 16
	global my_func
	extern printf
	
	
my_func:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	mov ecx, dword [ebp+8]	; Get argument (pointer to string)

	pushad			; Save registers


;       Your code should be here...
	
	mov edx, 0 ;counter
	
label_loop:

	sub byte [ecx], 48
	inc ecx
	
	inc edx 		;increse count
	
	cmp byte [ecx], 0 ;; \n ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;????? 0?
	ja  label_loop 
	
	
	mov ebx, edx		 ;;ans size-1 for lc1 -> ebx
	shr ebx, 1

	jc label_loop1
	
	dec ebx ;even
	
	

label_loop1:
	
	dec edx
	dec ecx
	mov ah, [ecx]
	
	cmp edx, 0
	je l_uneven
	
	dec edx
	dec ecx
	mov al, [ecx]
	
	shl al, 2  ;;*4
	
	add ah, al
	
	cmp ah, 9
	ja l_letters

l_numbers:
	add ah, 48
	jmp label_put

l_letters:
	
	add ah, 55

label_put:
     
	mov [LC1 + ebx], ah
	dec ebx
	
	cmp edx, 0
	ja label_loop1
	
	jmp l_endloop
	
l_uneven:
      add ah, 48
      mov [LC1 + ebx], ah

    
l_endloop:
    
	push	LC1		; Call printf with 2 arguments: pointer to str
	push	LC0		; and pointer to format string.
	call	printf
	add 	esp, 8		; Clean up stack after call

	popad			; Restore registers
	mov	esp, ebp	; Function exit code
	pop	ebp
	ret
	