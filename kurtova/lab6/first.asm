.586p
.MODEL FLAT, C
.CODE

PUBLIC C first
first PROC C num: dword, N: dword, res: dword, xmin: dword

push esi
push edi

mov edi, num
mov ecx, N					; ���������� ��� ������ loop - �������� �� �������
mov esi, res				; ������������� ������

for_additional_res:
	mov eax, [edi]			; ����� ��������� ������� �� num
	sub eax, xmin			; ����� ������ ������, ��������������� ����� � ������������� �������
	mov ebx, [esi + 4*eax]	; ������� ������ � ���� �������� � ������������� ������� � �������� � � ebx
	inc ebx					; ����������� �������� �� 1
	mov [esi + 4*eax], ebx	; ����� ����� �������� ������� � ������������� ������
	add edi, 4				; ��������� � ���������� �������� � ������� num
	loop for_additional_res

pop edi
pop esi
ret
first ENDP
END