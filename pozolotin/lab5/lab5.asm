data segment
    seconds  db 120
    delay    db 0
    
    keep_cs dw 0  
    keep_ip dw 0 
data ends

astack segment stack
    dw 512 dup(0)
astack ends

code segment
    assume cs:code, ss:astack, ds:data
sound_start proc near
	push	ax
	
	mov     al, 10110110b    ;楯�窠 ��� ���������� ॣ���� 8253
	out     43h, al          ;���뫠�� � ॣ����

	mov     ax, bx


	out     42h, al          ;���뫠�� ����訩 ���� 
	mov     al, ah           ;���뫠�� � ॣ���� 
	out     42h, al          ;���뫠�� ���訩 ����


  
	in      al,61h          ;������� ���ﭨ� ��������
	or      al,03h          ;��⠭����� ���
	out     61h,al          ;������� �������
  
  
	pop	ax
  ret
sound_start endp

sound_end proc near
	push	ax
  
 
	in      al,61h          ;������� ���ﭨ� ��������
	and     al,0fch         ;��⠭����� ���
	out     61h,al          ;�몫���� �������
 

	pop	ax
	ret
sound_end endp


proc_delay proc near
push	ax
push 	dx
delaying:   
; ����砥� ��⥬��� �६�
  mov  ah, 2ch
  int  21h ; 
 
  cmp  dh, seconds ; �ࠢ������ ⥪�騥 ᥪ㭤� � secodns
  je   delaying
  mov  seconds, dh ; ��࠭塞 ᥪ㭤�
  dec  delay   ; ���⠥� 1 �� ����ન
  jnz  delaying  ; �᫨ ����প� �� ࠢ�� 0, �����塞 

pop	dx
pop	ax

ret 
proc_delay endp

proc_r proc near 
	push bx
	push cx

	mov bx, 20000		
	call sound_start

	mov delay, ah
	call proc_delay
	call sound_end

	pop cx
	pop bx

	iret;
proc_r endp

subr_int proc near
	; ��⠭�������� ���� ����� ����뢠��� 

  mov al,60h ; ����� �����
  mov ah,25h ; �㭪�� ��⠭���� �����
  push ds
  mov dx, offset proc_r ; ᬥ饭�� �� ��楤��� � dx
  mov ax, seg proc_r ; ᥣ����  ��楤���
  mov ds, ax ; ��६�頥� � ds
  mov ax, 2560h ; �㭪�� ��⠭���� 䫠��(25) � ����� ����� (60)
  int 21h ; ���塞 ���뢠���
  pop ds
  ret
subr_int endp

main proc far
  mov  ax, ds ; ����㧪� ᥣ���⭮�� 
  mov  ds, ax ; ॣ���� ������


  mov  ah, 35h  ; �㭪�� ����祭�� �����
  mov  al, 60h ; ����� ����� 
  int  21h ; �����頥� ⥪�饥 ���祭�� ����� ���뢠���
  mov  keep_ip, bx ; ����������� ᬥ饭��
  mov  keep_cs, es ; � ᥣ���� ����� ���뢠���



  call subr_int 
  mov ah, 10; ��⠭���������� ����প�
  int 60h;

	; ���⠭�������� ���� ����� ���뢠��� 

  cli ; �⪫�祭�� �����⠭�� ���뢠���
  push ds
  mov  dx, keep_ip
  mov  ax, keep_cs
  mov  ds, ax
  mov  ah, 25h ; �㭪�� ��⠭���� �����
  mov  al, 1ch ; ����� �����
  int  21h          
  pop  ds
  sti  ; ��⠭���� ���뢠��� 


  mov ax, 4c00h ; �����襭�� �ணࠬ��
  int 21h

main endp;
code ends
end main 