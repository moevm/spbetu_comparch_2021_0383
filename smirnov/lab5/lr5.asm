AStack  SEGMENT STACK
    DB 1024 DUP(?)
AStack  ENDS

DATA    SEGMENT
    KEEP_CS DW 0    ; ��� �������� �������� ������� ����������
    KEEP_IP DW 0    ; ��� �������� ������� ����������
DATA    ENDS

CODE    SEGMENT
    ASSUME CS:CODE, DS:DATA, SS:AStack

WriteMsg  PROC  NEAR
          mov AH, 9
          int 21h 
          ret
WriteMsg  ENDP

FUNC PROC FAR
	jmp process
	KEEP_SS DW 0
	KEEP_SP DW 0
	MESSAGE DB 'is it matrix?', 0dh, 0ah, '$'
	FINALLY DB 'yes ofc', 0dh, 0ah, '$'
	COUNTER DW 6
	func_stack DW 40 DUP (?)
	process:
		mov KEEP_SS, SS
    	mov KEEP_SP, SP
    	mov ax, SEG func_stack
    	mov ss, ax
    	mov sp, OFFSET process
		push ax
		push bx
		push cx
		push dx
		push ds
		mov ax, SEG func_stack
		mov ds, ax
		mov dx, OFFSET MESSAGE
		start:
			call WriteMsg
			sub COUNTER, 1
			cmp COUNTER, 0
			jnz start
		mov COUNTER, 6
		mov ax, DATA
		mov dx, ax
		mov cx, 0033h 
		mov dx, 00FFh
		mov ah, 86h
		int 15h
		mov dx, OFFSET FINALLY
		call WriteMsg
		pop ax
	   	pop bx
	   	pop cx
	   	pop dx
	   	pop ds
	   	mov ss, KEEP_SS
	   	mov sp, KEEP_SP
	   	mov al, 20h
	   	out 20h, al
		iret
FUNC ENDP

MAIN PROC FAR
    push ds
    mov ax, DATA
    mov ds, ax
    
    mov ah, 35h ; ������� ��������� �������
    mov al, 23h ; ����� �������
    int 21h
    mov KEEP_IP, bx ; ����������� ��������
    mov KEEP_CS, es ; � �������� ������� ����������
    
    push ds
    mov dx, OFFSET FUNC ; �������� ��� ��������� � DX
    mov ax, SEG FUNC ; ������� ���������
    mov ds, ax ; �������� � DS
    mov ah, 25h ; ������� ��������� �������
    mov al, 23h ; ����� �������
    int 21h ; ������ ����������
    pop ds
    
    begin:
    	mov ah, 0
		int 16h
		cmp al, 'q'
		je quit
		cmp al, 3
		jnz begin
		int 23h
		jmp begin
	quit:
    	cli
    	push ds
    	mov dx, KEEP_IP
    	mov ax, KEEP_CS
    	mov ds, ax
    	mov ah, 25h
    	mov al, 23h
    	int 21h ; ��������������� ������ ������ ����������
    	pop ds
    	sti
   		mov ah, 4ch
		int 21h    
MAIN ENDP
CODE ENDS
     END MAIN