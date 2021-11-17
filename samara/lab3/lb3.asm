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
	  
		;вычисление f2
	  mov cx, i		
	  mov ax, cx
	  shl cx, 1
	  shl cx, 1
	  mov bx, b
	  cmp a, bx    ; сравнение a и b
	  jle f2second		
		add cx, 3	;a > b
		neg cx
		jmp f2final
	  f2second:		;a <= b
		add cx, ax
		add cx, ax
		add cx, -10
	  f2final:
	  mov i1, cx
	  
		;вычисление f8
      mov cx, i
      mov ax, cx
      cmp a, bx
      jle f8second  
        shl cx, 1	; a > bx
		mov ax, cx
		shl cx, 1
		add cx, ax
		add cx, 8
        neg cx
        jmp f8final
      f8second:  ; a <= bx
        add cx, -1
        mov ax, cx
		shl cx, 1
		add cx, ax
        neg cx
        add cx, 9
      f8final:
      mov i2, cx   

		;вычисление f3
	  mov bx, k
	  cmp bx, 0
	  je f3Second ; k != 0
        mov bx, i1
		cmp bx, i2
        jle min1
          mov cx, i2        ; i2 <= i1
		  jmp MainFinal
		min1:
		  mov cx, bx       ; i2 > i1
		  jmp MainFinal
	  f3Second:  ; k = 0
        mov cx, i1
        add cx, i2
	    cmp cx, 0
	    jge skip1     ; |i1 + i2|
	      neg cx
		  mov i1, cx
          jmp MainFinal
	    skip1:
          jmp MainFinal
		
	  MainFinal:   ; в cx лежит значение функции f3
      ret
Main      ENDP
CODE      ENDS
END Main 