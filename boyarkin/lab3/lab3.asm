; Стек  программы
AStack SEGMENT  STACK
    DW 12 DUP(?)
AStack  ENDS
;Данные программы
DATA      SEGMENT
;Директивы описания данных
string DB    15, 15 DUP('$')
sign   DB    1
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
	  
	  	  
	  ;вычисление f4
	  mov cx, i
      mov ax, cx
      mov bx, b
	  cmp a, bx
	  jle f4second  ; a != bx
        shl cx, 1
		mov ax, cx
		shl cx, 1
		add cx, ax
		add cx, -4
		neg cx
		jmp f4final
	  f4second:       ; a = bx
	    add cx, 2
		mov ax, cx
		shl cx, 1
		add cx, ax
	  f4final:
	  mov i1, cx
	  
      ;вычисление f8
      mov cx, i
      mov ax, cx
      cmp a, bx
      jle f8second  ; a != bx
        shl cx, 1
		mov ax, cx
		shl cx, 1
		add cx, ax
		add cx, 8
        neg cx
        jmp f8final
      f8second:  ; a = bx
        add cx, -1
        mov ax, cx
		shl cx, 1
		add cx, ax
        neg cx
        add cx, 9
      f8final:
      mov i2, cx   

      
	  
	  ;рассчет f3
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
	    jge skip1     ;модуль i1 + i2
	      neg cx
		  mov i1, cx
          jmp MainFinal
	    skip1:
          jmp MainFinal
		
	  MainFinal:           ; в cx лежит значение функции f3
      ret
Main      ENDP
CODE      ENDS
END Main