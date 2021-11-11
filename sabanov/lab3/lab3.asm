DOSSEG
.MODEL SMALL
.STACK 100h

.DATA

a   DW    1
b   DW    2
i   DW    3
i1  DW    0
i2  DW    0
k   DW    4

.CODE

abs PROC NEAR

@abs:
    neg ax
    js @abs

    ret
abs ENDP

max PROC NEAR

    cmp ax, dx
    jnl max_exit

    mov ax, dx

max_exit:

    ret
max ENDP

;f1(int a, int b, int i) {
;    if (a > b)
;        return -(4*i + 3);
;    return 6*i - 10;
;}
;return in ax
f1  PROC NEAR

    push bp
    mov bp, sp
    push bx

    mov bx, [bp+4]
    mov ax, [bp+8]
    cmp bx, [bp+6]
    jng f1_2

    mov bx, 4
    mul bx
    add ax, 3
    neg ax
    jmp f1_exit

f1_2:
    mov bx, 6
    mul bx
    sub ax, 10

f1_exit:
    pop bx
    mov sp, bp
    pop bp
    ret 6

f1  ENDP


;f2(int a, int b, int i) {
;    if (a > b)
;        return -(6*i - 4);
;    return 3*(i+2);
;}
;return in ax
f2 PROC NEAR

    push bp
    mov bp, sp
    push bx

    mov bx, [bp+4]
    mov ax, [bp+8]
    cmp bx, [bp+6]
    jng f2_2

    mov bx, 6
    mul bx
    sub ax, 4
    neg ax
    jmp f2_exit

f2_2:

    add ax, 2
    mov bx, 3
    mul bx

f2_exit:
    pop bx
    mov sp, bp
    pop bp
    ret 6

f2 ENDP


;f3(int i1, int i2, int k) {
;    if (k < 0)
;        return |i1| + |i2|;
;    return max(6, |i1|);
;}
;return in ax
f3 PROC NEAR

    push bp
    mov bp, sp
    push bx

    mov ax, [bp+4]
    call abs

    cmp word ptr [bp+8], 0
    jnl f3_2

    mov bx, ax
    mov ax, [bp+6]
    call abs
    add ax, bx

f3_2:
    mov dx, 6
    call max

f3_exit:
    pop bx
    mov sp, bp
    pop bp
    ret 6

f3 ENDP

Main PROC FAR
    mov ax, @data
    mov ds, ax

    mov ax, a
    mov bx, b
    mov cx, i
    push cx
    push bx
    push ax
    call f1
    mov i1, ax

    mov ax, a
    mov bx, b
    mov cx, i
    push cx
    push bx
    push ax
    call f2
    mov i2, ax

    mov ax, i1
    mov bx, i2
    mov cx, k
    push cx
    push bx
    push ax
    call f3

    mov ah, 4ch
    int 21h
Main ENDP
END Main
