AStack SEGMENT  STACK
    DW 12 DUP(?)
AStack  ENDS
;������ ���������
DATA      SEGMENT
;��������� �������� ������
a      DW    0
b      DW    0
i      DW    0
k      DW    0
i1     DW    0
i2     DW    0

DATA      ENDS

; ��� ���������
CODE      SEGMENT
      ASSUME CS:CODE, DS:DATA, SS:AStack

; �������� ���������
Main      PROC  FAR
      push  DS
      sub   AX,AX
      push  AX
      mov   AX,DATA
      mov   DS,AX
      mov   CX, 0

      mov a, 2
      mov b, 1
      mov i, 1
      mov k, 0
	  
	  ;���������� f3
	  mov cx, i
	  shl cx, 1
	  mov ax, cx
	  shl cx, 1
	  mov bx, b    ;
	  cmp a, bx    ; ��������� a � b
	  jle f1second
		neg cx
		add cx, 7
		jmp f1final
	  f1second:
		add cx, ax
		neg cx
		add cx, 8
	  f1final:
	  mov i1, cx
	  
	  ;���������� f5
	  mov cx, ax
	  shl cx, 1
	  cmp a, bx
	  jle f2second
		neg cx
		add cx, 20
		jmp f2final
	  f2second:       
	    add cx, ax
		add cx, -6
		neg cx
	  f2final:
	  mov i2, cx
	  
	  ;������� res
	  mov bx, k
	  cmp bx, 0
	  jne resSecond
	    add cx, i1
		cmp cx, 0
		jge MainFinal
		neg cx
		jmp MainFinal
	  resSecond:
	    cmp cx, i1
		jl MainFinal
		mov cx, i1
	  MainFinal:           ; � cx ����� �������� res
      ret
Main      ENDP
CODE      ENDS
END Main 