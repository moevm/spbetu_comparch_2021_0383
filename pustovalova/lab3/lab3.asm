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
T      DW    0

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
            
      mov cx, i
      mov ax, cx
      shl cx, 1
      shl cx, 1 ; cx = 4i
      mov T, cx ; T = 4i
      sub T, ax
      sub T, ax ; T = 2i
      mov bx, b
      cmp a, bx
      
      ; a>b
      jle f2f6
        add cx, 3
        neg cx
        mov i1, cx
        mov cx, T
        sub cx, 2
        mov i2, cx
        jmp final
        
      ; a<=b
      f2f6:
        mov cx, T
        add cx, ax
        sub cx, 5
        mov T, cx
        shl cx, 1
        mov i1, cx
        neg T
        sub T, 3
        mov cx, T
        mov i2, cx
      
      ; рассчет f5
      final:
      mov bx, k
      mov ax, i1
      cmp ax, 0
      jge gr1
      neg ax
      gr1:
      cmp bx, 0
      je f5second
      mov cx, i2
      cmp cx, 0
      jge gr2
      neg cx
      gr2:
      add cx, ax
      jmp MainFinal
      f5second:
      cmp ax, 6
      jge min
      mov cx, ax    ; |i1| < 6
      jmp MainFinal
      min:
      mov cx, 6     ; |i1| >= 6
      jmp MainFinal
      MainFinal:
      ret
      
Main      ENDP
CODE      ENDS
END Main
