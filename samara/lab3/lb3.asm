; Стек  программы
AStack SEGMENT  STACK
    DW 12 DUP(?)
AStack  ENDS
;Данные программы
DATA      SEGMENT
;Директивы описания данных
a      DW    1
b      DW    2
i      DW    3
k      DW    4
i1     DW    0
i2     DW    0
temp   DW	 0

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
	  
		;вычисление f2 и f8
	  mov cx, i		
	  mov ax, cx
	  shl cx, 1
	  shl cx, 1
	  mov temp, cx	;4i
	  mov bx, b
	  cmp a, bx    ; сравнение a и b
	  jle fsecond		
		add cx, 3	;a > b
		neg cx
		mov i1, cx
		mov cx, temp
		add cx, ax
		add cx, ax
		add cx, 8
        neg cx
		mov i2, cx
	  fsecond:		;a <= b
		add cx, ax
		add cx, ax
		add cx, -10
		mov i1, cx
		mov cx, i
		add cx, -1
        mov ax, cx
		shl cx, 1
		add cx, ax
        neg cx
        add cx, 9
		mov i2, cx  

		;вычисление f3
	  mov bx, k
	  cmp bx, 0
	  je f3Second ; k != 0
		cmp cx, i1
        jle min1
          mov cx, i1        ; i2 <= i1
		  jmp MainFinal
		min1:
		  jmp MainFinal
        
	  f3Second:  ; k = 0
        add cx, i1
	    cmp cx, 0
	    jge MainFinal     ; |i1 + i2|
	      neg cx
