AStack SEGMENT STACK
    DW 1024 DUP(?) 
AStack ENDS
DATA SEGMENT
  KEEP_CS DW 0 ; ��� �࠭���� ᥣ����
  KEEP_IP DW 0 ; � ᬥ饭�� ����� ���뢠���

DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA, SS:AStack
SUBR_INT PROC FAR ; ��㪮��� ���뢠��� �� ⠩���
  jmp h_start
  save_ss dw 0000h
  save_sp dw 0000h
  ind_stack dw 512 DUP(?)
  h_start:


    mov save_ss, SS
    mov save_sp, sp
    mov sp, seg ind_stack
    mov ss, sp
    mov sp, OFFSET h_start
    PUSH CX ; ��࠭���� �����塞�� ॣ���஢
    PUSH AX

  MOV AL, 10110110b 	;楯�窠 ��� ���������� ॣ���� 8253
  out 43h, al
  MOV AX, 500      ;���� ��㪠
  OUT 42H, AL ;⠩��� 
  
  MOV AH, AL
  OUT 42H, AL 
  IN AL,61H ; ����砥� ���ﭨ� ��������
  OR AL, 00000011b 
  OUT 61H, AL ; ����砥��� �������
        
  mov cx, bx ;
  l: 
  NOP
  NOP
  NOP
  sub cx, 1
  cmp cx, 0
  jnz l ;��ࠥ��� ���, ���� �� ��������� 横�
  
  
  MOV AL, AH
  OUT 61H, AL ;������� �몫�砥���

  POP AX ;����⠭������� ॣ���஢
  POP CX
    mov ss, save_ss
  mov sp, save_sp
  MOV AL, 20H
  OUT 20H,AL ;�뢮� �� ����
  IRET
  SUBR_INT ENDP

Main PROC FAR
  MOV AH, 35H ; �㭪�� ����祭�� �����
  MOV AL, 08h ; ����� ����� ���뢠��� � ᮮ⢥��⢨� � ��������
  INT 21H ; ॠ������� ��楤�� ���뢠���
  MOV KEEP_IP, BX ; ����������� ᬥ饭��
  MOV KEEP_CS, ES ; � ᥣ���� ����� ���뢠���
  MOV BX, 1500 ; ���⥫쭮��� ���砭��
  PUSH DS
  MOV DX, OFFSET SUBR_INT ; ᬥ饭�� ��� ��楤��� � DX
  MOV AX, SEG SUBR_INT ; ᥣ���� ��楤���
  MOV DS, AX ; ����頥� � DS
  MOV AH, 25H ; �㭪�� ��⠭���� �����?
  MOV AL, 08h ; ����� �����
  INT 21H ; ���塞 ���뢠���
  POP DS

  mov ah, 0h
  int 16h

endInput:
  CLI ; ���� 䫠�� ���뢠��� IF - 0
  PUSH DS
  MOV DX, KEEP_IP
  MOV AX, KEEP_CS
  MOV DS, AX
  MOV AH, 25H
  MOV AL, 08h ;
  INT 21H ; ����⠭�������� ���� ����� ���뢠���
  POP DS
  STI
  MOV AH, 4Ch
  INT 21h
Main ENDP
CODE ENDS
END Main