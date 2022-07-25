.586p
.MODEL FLAT, C
.CODE
PUBLIC C second
second PROC C first_res: dword, N: dword, xmin: dword, borders: dword, Nint: dword, res: dword

push esi
push edi
push ebp

mov edi, first_res  
mov esi, borders  
mov ecx, Nint  

for_borders:  
	mov eax, [esi]				; ������ ��������� ������� ���������
	sub eax, xmin				; ������� ������ ������� � ������������� �������
	mov [esi], eax				; ����� �������
	add esi, 4					; ��������� � ���������� ��������
	loop for_borders

mov esi, borders
mov ecx, Nint
mov ebx, 0						; �������
mov eax, [esi]					; ������ ������� ������������ borders 

for_start:
	push ecx					; �������� �������� ecx		
	mov ecx, eax				; �������� � ecx �������� ������� �������
	push esi					; �������� esi
	mov esi, res				; ����� �������� � �������� res

    for_array:
		cmp ecx, 0
		je for_end				; ���� �������� ����� �������, ������� �� �����
        mov eax, [edi]			; ���� ������� � ������������� ������� ���������� ���������
        add [esi + 4*ebx], eax	; ��������� � ���������� ��� ������� ���������
        add edi, 4				; ��������� � ����������
        loop for_array

for_end:
    pop esi						; ������������ � ������� borders
    inc ebx						; ����������� �������
	mov eax, [esi]
	add esi, 4
	sub eax, [esi]				; �� ����������� �������� borders �������� ��������� - �������� ����� ���������� ��������� * -1
	neg eax						; ������ �������� �������������
	pop ecx						; ������������ � ��������� Nint
	loop for_start

mov esi, res
mov ecx, Nint
mov eax, 0

final_for:						; ������� ���������� �����, ������� �� ���� ����������
	add eax, [esi]
	add esi, 4
	loop final_for

mov esi, res
sub eax, N
neg eax

add [esi + 4*ebx], eax			; �������� ��� ���������� � ��������� ������ ����������

pop ebp
pop edi
pop esi

ret
second ENDP
END