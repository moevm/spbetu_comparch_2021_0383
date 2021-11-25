AStack SEGMENT STACK
	DW 12 DUP(?)
AStack ENDS

DATA SEGMENT
a DW 0
b DW 0
i DW 0
k DW 0
i1 DW 0
i2 DW 0
DATA ENDS

; Код программы
CODE SEGMENT

ASSUME CS:CODE, DS:DATA, SS:AStack
; Головная процедура
Main PROC FAR
	push DS
	sub AX, AX
	push AX

	mov AX, DATA
	mov DX, AX

	mov a, 0
	mov b, 0
	mov i, 0
	mov k, 0

	mov cx, a
	sub cx, b
	cmp cx, 0
	jle L1

	;a > b
	;i1 = -(4 * i + 3)
	mov cx, i
	shl cx, 1
	shl cx, 1
	add cx, 3
	neg cx
	mov i1, cx

	;i2 = -(6 * i + 8)
	mov cx, i
	shl cx, 1
	add cx, i
	add cx, 4
	shl cx, 1
	neg cx
	mov i2, cx

	jmp L2


	;a <= b
	L1:

	;i1 = 6 * i - 10
	mov cx, i
	shl cx, 1
	add cx, i
	shl cx, 1
	sub cx, 10
	mov i1, cx

	;i2 = 9 - 3 * (i - 1)
	mov cx, i
	shl cx, 1
	add cx, i
	neg cx
	add cx, 12
	mov i2, cx

	L2:
	cmp k, 0
	jne L3

	;k == 0
	cmp i1, 0
	jl i10
	cmp i2, 0
	jl i20
	jmp endf3

	i10:
	neg i1
	cmp i2, 0
	jg endf3

	i20:
	neg i2
	
	endf3:
	mov ax, i1
	add ax, i2
	jmp endmain

	;k != 0
	L3:
	mov cx, i1
	sub cx, i2
	cmp cx, 0
	jl Li1
	mov AX, i2
	jmp endmain

	Li1:
	mov AX, i1
	jmp endmain

	endmain:
	ret
Main ENDP
CODE ENDS

END Main