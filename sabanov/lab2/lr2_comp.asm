; ��������� �������� ������� ��������� ���������� IntelX86
EOL EQU '$'
ind EQU 2
n1 EQU 500
n2 EQU -50
; ���� ���������
AStack SEGMENT STACK
 DW 12 DUP(?)
AStack ENDS
; ������ ���������
DATA SEGMENT
; ��������� �������� ������
mem1 DW 0
mem2 DW 0
mem3 DW 0
vec1 DB 11,12,13,14,18,17,16,15
vec2 DB 10,20,-10,-20,30,40,-30,-40
matr DB 1,2,-4,-3,3,4,-2,-1,5,6,-8,-7,7,8,-6,-5
DATA ENDS
; ��� ���������
CODE SEGMENT
 ASSUME CS:CODE, DS:DATA, SS:AStack
; �������� ���������
Main PROC FAR
 push DS
 sub AX,AX
 push AX
 mov AX,DATA
 mov DS,AX
; �������� ������� ��������� �� ������ ��������
; ����������� ���������
 mov ax,n1
 mov cx,ax
 mov bl,EOL
 mov bh,n2
; ������ ���������
 mov mem2,n2
 mov bx,OFFSET vec1
 mov mem1,ax
; ��������� ���������
 mov al,[bx]
; mov mem3,[bx]
; ������������ ���������
 mov al,[bx]+3
 mov cx,3[bx]
; ��������� ���������
 mov di,ind
 mov al,vec2[di]
 mov cx,vec2[di]
; ��������� � ������������ � ���������������
 mov bx,3
 mov al,matr[bx][di]
 mov cx,matr[bx][di]
; mov ax,matr[bx*4][di]
; �������� ������� ��������� � ������ ���������
; ��������������� ��������
; ------ ������� 1
 mov ax, SEG vec2
 mov es, ax
 mov ax, es:[bx]
 mov ax, 0
; ------ ������� 2
 mov es, ax
 push ds
 pop es
 mov cx, es:[bx-1]
 xchg cx,ax
; ------ ������� 3
 mov di,ind
 mov es:[bx+di],ax
; ------ ������� 4
 mov bp,sp
; mov ax,matr[bp+bx]
; mov ax,matr[bp+di+si]
; ������������� �������� �����
 push mem1
 push mem2
 mov bp,sp
 mov dx,[bp]+2
 add sp, 4
 ret
Main ENDP
CODE ENDS
 END Main
