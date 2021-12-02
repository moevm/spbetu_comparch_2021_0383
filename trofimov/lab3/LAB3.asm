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
      mov bx, b
	  cmp a, bx
	  jle f3second  ; a > bx
      shl cx, 1;*4
      neg cx;-4i
		add cx, 7;7-4i
		jmp f3result
	  f3second:       ; a <= bx
		mov ax, cx
		shl cx, 1
		add cx, ax;6i
        neg cx;-6i
        add cx, 8;8-6i
	  f3result:
	    mov i1, cx
	  
      ;вычисление f7
      mov cx, i
      mov ax, cx
      cmp a, bx
      jle f7second  ; a > bx
      shl cx, 1
      shl cx, 1;4i
	  sub cx, 5;4i-5
      neg cx;-(4i-5)
      jmp f7result
      f7second:  ; a <= bx
        mov ax,cx
        shl cx, 1;2i
        add cx, ax;3i
        neg cx;-3i
        add cx, 10;10-3i
        
      f7result:
      mov i2, cx   

	  ;рассчет f5
	  mov bx, k
	  cmp bx, 0
    mov ax, i1
	  je f5second 
        ; k != 0
        cmp ax, 0
        jl negi
          mov cx, ax
          mov ax, i2
          cmp ax, 0
          jl negi
            add cx, ax
            jmp MainFinal

        ;модуль i
        negi: 
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