; Стек  программы
AStack SEGMENT  STACK
    DW 12 DUP(?)
AStack  ENDS
;Данные программы
DATA      SEGMENT
;Директивы описания данных

a      DW    4
b      DW    3
i      DW    2
k      DW    1
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
    shl cx, 1
    mov ax, cx
    shl cx, 1;*4
    mov bx, cx
	  cmp a, b
	  jle f3second  ; a > bx
    neg cx;-4i
    mov i1, cx
    add i1, 7
		;add cx, 7;7-4i
		jmp f3result
	  f3second:       ; a <= bx
		  add bx, ax;-6i
      neg bx
      add bx, 8;8-6i
      mov i1, bx
	  f3result:
      ;вычисление f7
      mov cx, ax
      jle f7second  ; a > bx
      shl cx, 1;4i
	    sub cx, 5;4i-5
      neg cx;-(4i-5)
      jmp f7result
      f7second:  ; a <= bx
        add cx, i;3i
        neg cx;-3i
        add cx, 10;10-3i
        
      f7result:
      mov i2, cx   

	  ;рассчет f5
    mov ax, i1
	  cmp k, 0
	  je f5second 
      ; k != 0
      jmp negi
        mov cx, ax
        mov ax, i2
        jmp negi
          add cx, ax
          jmp MainFinal

        ;модуль i
        negi:
          cmp ax, 0
          jl negative
            negative:
              neg ax
		
	    f5second:  ; k = 0
        cmp ax, 0
        jl negi
          cmp ax, 6
          jle min1
            mov cx, 6 
            jmp MainFinal
            min1: 
              mov cx, ax
              jmp MainFinal
	  
		
	  MainFinal:           ; в cx лежит значение функции f5
      ret
Main      ENDP
CODE      ENDS
END Main