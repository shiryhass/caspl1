section	.rodata

format:
	DB	`%llX\n` ; Format string

section .bss

ANS:	RESB	8
NUM:	 RESB	 8


section .text
    
    global calc_func
    extern printf
    extern compare
    
    
calc_func:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	
	sub esp, 16		; locals: num of rounds(-4) , cur dig(-8) , pos in x(-12) , count (-16)
	
	pushad			; Save registers
	
	mov ecx, dword [ebp+8]	; Get argument (pointer to long long)
	mov edx, dword [ebp+12] ;Get argument (numOfRounds)
		
	


;       Your code should be here...
	
	
	
	mov [ebp-4], edx; numOfRounds in stack
l_rounds:

	cmp dword[ebp-4], 0 ;numOfRounds
	mov eax, dword[ebp-4]
l_check4:
	jz l_end
	
	mov dword[ebp-8], 0 ;cur dig
	
	
	
	l_digs: ;iterate digits 0 to 15

		cmp byte[ebp-8], 16 ;cur dig <0..15>
		je l_end_digs
		
		mov dword[ebp-12], 0; pos in x
		mov dword[ebp-16], 0;count for cur dig
		
		mov eax, [ebp-8]	
		l_cur_dig: ;count MOFAIM for cur dig 
		    
		    cmp dword[ebp-12], 8 ; pos is <0...7>
		    je l_end_cur
		    
		    mov edx, dword[ebp-12];get pos in x
		    mov ebx, 0
		    mov bl, [ecx + edx] ;cur byte [right to left, little end]
		    
		    and bl, 0x0F ;right dig
		    ;mov eax, [ebp-8]; cur dig
		    cmp ebx, eax
		   l_check3:
		   jnz l_left_dig
		    
		    l_inc_r:
			inc dword[ebp-16]	    
		    
		    l_left_dig:
			mov bl, [ecx + edx]
			and bl, 0xF0 ;left dig
			shr bl, 4
			;mov eax, dword[ebp-8]; cur dig
			cmp ebx, eax 
			jnz l_inc_pos
		    l_inc_left:
			inc dword[ebp-16]

		    l_inc_pos:
			inc dword[ebp-12] ;inc pos in x
			jmp l_cur_dig
			
		     
		l_end_cur:

		    ;determine pos in num
		    mov eax, 7
		    mov edx, dword[ebp-8] ;cur dig 
		    shr edx, 1
		    sub eax,edx 
		    
		    mov edx, dword[ebp-8] ;check dig even
		    shr edx, 1
		    mov bl, byte[ebp-16] ; copy count to ebx
		    
		    jnc l_even
		   
		    add [NUM + eax], ebx
		    jmp l_end_put
		 
		 l_even:
		    shl bl, 4 ;mov bits to left
		    mov [NUM + eax], bl
		
		l_end_put:  
		    inc dword[ebp-8]; next dig
		    jmp l_digs
	
	
	 l_end_digs:

	      dec dword[ebp-4]; dec numOfRounds	   

		    ;;;;;;;;but why???????????;;;;;;;;;;;
;		    mov ebx, dword[ebp-4]
;		    mov edx, dword[ebp-8]
;		    mov esi, dword[ebp-12]
;		    mov edi, dword[ebp-16]
		 
		    ;;;;;;;;;
		    
		    push NUM
		    push ecx
		    call compare
		    add esp, 8	; Clean up stack after call
		    
	      l_compare:            
		    
		    ;;;;;;;;;
		 
;		    mov  dword[ebp-4], ebx
;		    mov  dword[ebp-8], edx
;		    mov  dword[ebp-12], esi
;		    mov  dword[ebp-16], edi		    
		    ;;;;;;;;but why???????????;;;;;;;;;;;
	      
	      mov edx, eax ;save result for compare
	 
	      ;copy num to ans
	      mov eax, 0
	      l_copy:
		  
		  cmp eax, 2
		  je l_end_copy
		  mov ebx, [NUM + eax*4]
		  mov [ANS + eax*4], ebx
		  inc eax
		  jmp l_copy
	      
	      l_end_copy:
	      
	    
	    cmp edx, 1 ; x & y equal
	    je l_end
	      
		  mov ecx, ANS
		  jmp l_rounds
		  

l_end:		      
		    ;;;;;;;;but why???????????;;;;;;;;;;;
;		    mov ebx, dword[ebp-4]
;		    mov edx, dword[ebp-8]
;		    mov esi, dword[ebp-12]
;		    mov edi, dword[ebp-16]
		 
		    ;;;;;;;;;
	
	push dword[ANS+4]
	push dword[ANS]
	push format
	call printf
	add esp, 12

		    ;;;;;;;;;
		 
;		    mov  dword[ebp-4], ebx
;		    mov  dword[ebp-8], edx
;		    mov  dword[ebp-12], esi
;		    mov  dword[ebp-16], edi		    
		    ;;;;;;;;but why???????????;;;;;;;;;;;	
		    
	
	popad			; Restore registers
	mov	esp, ebp	; Function exit code
	pop	ebp
	
	mov eax, ANS ;return pointer ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	ret
	
	
