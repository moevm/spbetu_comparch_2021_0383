DATA SEGMENT
        KEEP_CS DW 0 ; ��� �������� ��������
        KEEP_IP DW 0 ; � �������� ������� ����������
        HELLO   DB 'Hello World!',10,13,'$' 
DATA ENDS

AStack    SEGMENT  STACK
          DW 512 DUP(?)    ;
AStack    ENDS


CODE      SEGMENT
          ASSUME CS:Code, DS:DATA, SS:AStack

SUBR_INT PROC FAR
        jmp start_proc

        ss_int dw 0
	    sp_int dw 0
        int_stack  DW 20 DUP(?)

start_proc:
    mov ss_int, ss
	mov sp_int, sp

    push dx
	push cx
	push bx
	push ax
	push ax

	mov al, 0
print_msg:
    MOV   AH,9
    MOV   DX, OFFSET HELLO
	int   21h  ; ����� ������� DOS �� ����������

delay_count:
    pop cx
	dec cl
	jz ending
	push cx

	cmp al, 0   ;al - ������� ��������
	je one

	shl al, 1
	jmp start

one: 
    inc al

start:
    mov bl, al  ;bl - ������ ������, bh - ������� ����� �������
	mov  ah, 2ch
	int  21h 
	mov bh, dh

Delay:
	nop
	mov  ah, 2ch
	int  21h 
	cmp dh, bh
	je Delay

    mov  bh, dh      
	dec  bl   
	jnz Delay
	jmp print_msg

ending:
	pop ax
	pop bx
	pop cx
	pop dx
	
	mov al,20h
	out 20h,al
       
	iret
SUBR_INT ENDP


Main      PROC  FAR

        push  DS       ;\  ���������� ������ ������ PSP � �����
        sub   AX,AX    ; > ��� ������������ �������������� ��
        push  AX       ;/  ������� ret, ����������� ���������.
        mov   AX,DATA             ; �������� �����������
        mov   DS,AX               ; �������� ������.

        MOV AH, 35H ; ������� ��������� �������
        MOV AL, 60H ; ����� �������
        INT 21H ; ���������� ������� �������� ������� ����������
        MOV KEEP_IP, BX ; ����������� ��������
        MOV KEEP_CS, ES ; � �������� ������� ����������

        PUSH DS
        MOV DX, OFFSET SUBR_INT ; �������� ��� ��������� � DX
        MOV AX, SEG SUBR_INT ; ������� ���������
        MOV DS, AX ; �������� � DS
        MOV AH, 25H ; ������� ��������� �������
        MOV AL, 60H ; ����� �������
        INT 21H ; ������ ����������
        POP DS
		
		mov al, 5
        int 60H; ����� ����������� ����������

        CLI
        PUSH DS
        MOV DX, KEEP_IP
        MOV AX, KEEP_CS
        MOV DS, AX
        MOV AH, 25H
        MOV AL, 60H
        INT 21H ; ��������������� ������ ������ ����������
        POP DS
        STI		

        RET
Main      ENDP
CODE      ENDS
          END Main 