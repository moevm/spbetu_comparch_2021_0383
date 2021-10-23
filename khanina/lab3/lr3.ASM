; Стек  программы
AStack SEGMENT  STACK
    DW 12 DUP(?)
AStack  ENDS
;Данные программы
DATA      SEGMENT
;Директивы описания данных
a      DW    6
b      DW    4
i      DW    3
k      DW    -2
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
	  	  
	  ;вычисление f3
	  mov cx, i
	  mov ax, cx
	  shl cx, 1
	  shl cx, 1 ; 4i
	  cmp a, bx
	  jle f3second
	    mov ax, cx
		mov cx, 7
		sub cx, ax
		jmp f3final
	  f3second:       
	    add cx, ax
		add cx, ax
		mov ax, cx
		mov cx, 8
		sub cx, ax
	  f3final:
	  mov i1, cx
	  
	  ;вычисление f8
	  mov cx, i
	  mov ax, cx
	  mov bx, b    ;
	  cmp a, bx    ; сравнение a и b
	  jle f8second
		shl cx, 1
		shl cx, 1 ; 4i
		add cx, ax
		add cx, ax
		add cx, 8
		neg cx
		jmp f8final
	  f8second:
		add cx, -1
		mov ax, cx
		shl cx, 1
		shl cx, 1
		sub cx, ax
		neg cx
		add cx, 9
	  f8final:
	  mov i1, cx
	  
	  mov cx, i2
	  cmp cx, 0
	  jge skip2     
	    neg cx
		mov ax, cx
	  skip2:
	  
	  ;рассчет f6
	  mov bx, k
	  cmp bx, 0
	  jl f6Second
	    mov bx, ax
		cmp bx, 7
		jl max1
		  mov cx, bx       ; |i2| >= 7
		  jmp MainFinal
		max1:
		  mov cx, 7        ; |i2| < 7
		  jmp MainFinal
	    f6Second:
	    mov cx, i1
		sub cx, i2
		cmp cx, 0
		jge MainFinal
			neg cx
			jmp MainFinal
	  MainFinal:           ; в cx лежит значение функции f8
      ret
Main      ENDP
CODE      ENDS
END Main 