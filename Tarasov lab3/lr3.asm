; Стек  программы
AStack SEGMENT  STACK
    DW 12 DUP(?)
AStack  ENDS
;Данные программы
DATA      SEGMENT
;Директивы описания данных
a      DW    2
b      DW    1
i      DW    4
k      DW    -1
i1     DW    0
i2     DW    0

DATA      ENDS

; Код программы
CODE      SEGMENT
      ASSUME CS:CODE, DS:DATA, SS:AStack
	  
; Головная процедура
Main      PROC  FAR
      push  DS
      sub   AX,AX
      push  AX
      mov   AX,DATA
      mov   DS,AX
	  mov   CX, 0
	  
	  
	  ;f5 = 20 - 4*i , при a>b,  -(6*I - 6), при a<=b 
	  mov cx, i
	  mov ax, cx
	  shl cx, 1
	  shl cx, 1
	  mov bx, b   
	  cmp a, bx    
	  jle f5ch
		neg cx
		add cx, 20
		jmp f5chf
	  f5ch:
		add cx, ax
		add cx, ax
		add cx, -6
		neg cx
	  f5chf:
	  mov i1, cx
	  
	  ;f8 = - (6*i+8) , при a>b, 9 -3*(i-1), при a<=b 
	  mov cx, i
	  cmp a, bx
	  jle f8ch
	    shl cx, 1
		mov ax, cx
		shl cx, 1
		add cx, ax
		add cx, 8
		neg cx
		jmp f8chf
	  f8ch:       
	    add cx, -1
		mov ax, cx
		shl cx, 1
		add cx, ax
		neg cx
		add cx, 9
	  f8chf:
	  mov i2, cx
	
	  ;f6 = |i1 - i2|, при k<0 , max(7, |i2|), при k>=0 
	  mov bx, k
	  cmp bx, 0
	  jl f6ch
	    mov bx, i2
		cmp bx, 0
		jge temp1
		neg cx
		temp1:
		cmp bx, 7
		jl max1
		  mov cx, bx
		  jmp f6chf
		max1:
		  mov cx, 7
		  jmp f6chf
	  f6ch:
	    mov cx, i2
	    neg cx
		add cx, i1
		cmp cx, 0
		jge temp2
		neg cx
		temp2:
	  f6chf:           
      ret
Main      ENDP
CODE      ENDS
END Main
CODE ENDS
 END Main