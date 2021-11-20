; Стек  программы
AStack SEGMENT  STACK
	       DW 12 DUP(?)
AStack  ENDS
;Данные программы
DATA SEGMENT
	;Директивы описания данных
	a    DW 10
	b    DW 5
	i    DW 5
	k    DW 4
	i1   DW 0
	i2   DW 0
	temp    DW 0	; temp

DATA      ENDS

; Код программы
CODE SEGMENT
	       ASSUME CS:CODE, DS:DATA, SS:AStack
      
	; Головная процедура
Main PROC  FAR
	       push   DS
	       sub    AX,AX
	       push   AX
	       mov    AX,DATA
	       mov    DS,AX
	       mov    CX, 0
            
	       mov    cx, i
	       mov    temp, cx
	       add    temp, 1   ; temp = i+1
	       shl    cx, 1     ; C = 2i
	       mov    bx, b
	       cmp    a, bx
	       jle    fun16
         
	; a > b
	       mov    ax, cx
	       mov    cx, 15
	       sub    cx, ax
	       mov    i1, cx
	       mov    cx, temp
	       add    cx, temp
	       sub    cx, 4
	       mov    i2, cx
	       jmp    fin
		
	; a <= b
	fun16: 
	       add    cx, i
	       add    cx, 4
	       mov    i1, cx
	       mov    ax, temp
	       shl    ax, 1
	       add    ax, temp
	       mov    cx, 5
	       sub    cx, ax
	       mov    i2, cx
	  
	;f5
	fin:   
	       mov    bx, k
	       mov    ax, i1
	       cmp    ax, 0
	       jge    skip_i1     ; |i1|
	       neg    ax
	skip_i1: 
	       cmp    bx, 0
	       je     zero
	       mov    cx, i2  
	       cmp    cx, 0
	       jge    skip_i2
	       neg    cx
	skip_i2:  
	       add    cx, ax
	       jmp    result
	zero:  
	       cmp    ax, 6
	       jge    min
	       mov    cx, ax    ; |i1| < 6
	       jmp    result
	min:   
	       mov    cx, 6     ; |i1| >= 6
	       jmp    result
	result:
	       ret
Main ENDP
CODE      ENDS
END Main