Astack SEGMENT STACK
	DW 12 DUP(?)
Astack ENDS

DATA SEGMENT
a	DW	0
b	DW 	0
i 	DW	0
k	DW 	0
i1	DW 	0
i2	DW 	0
res  	DW 	0

DATA ENDS

CODE SEGMENT  
	ASSUME CS:CODE, DS:DATA, SS:AStack
Main 	PROC 	FAR
	push ds
	sub ax, ax
	mov ax, DATA
	mov ds, ax
		mov a, 2
 		mov b, 1
		mov i, 4
		mov k, 0
	mov cx, i
	shl cx, 1
	shl cx, 1
	mov ax, cx
	mov bx, b 
	cmp a, bx
	jle f1
		;a>b
		;i1
		neg ax
		mov cx, 3
		neg cx
		add cx, ax
		mov i1, cx
		;i2
		mov cx, i
		shl cx, 1
		neg cx
		add ax, cx
		mov i2, ax
		mov cx, 8
		neg cx
		add cx, ax
		mov i2, cx
		
		jmp f1end

	f1:	;a<=b
		;i1
		mov cx, i
		shl cx, 1
		add ax, cx
		mov cx, 10
		neg cx
		add cx, ax
		mov i1, cx
		;i2
		mov cx, i
		shl cx, 1
		add cx, i
		neg cx
		add cx, 12
		mov i2, cx
		
	f1end:
		mov bx, i2
		cmp k, 0
		je f2
		; k != 0
			cmp i1, bx
			jle f3
				;i1 > i2
				mov ax, i2
				jmp AllEnd	
			
			f3:	;i1 <= i2
				mov ax, i1
				jmp AllEnd	

		f2: ;k==0
			mov ax, i1
			add ax, i2
			cmp ax, 0
			jle f4
				; i1+i2 > 0					
				jmp AllEnd
			f4: ;i1+i2 <= 0					
				neg ax
			

	AllEnd:
		mov res, ax
		ret
Main ENDP
CODE ENDS
END Main

















































		
	
	f1end:
