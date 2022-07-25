.586
.MODEL FLAT, C
.CODE
func PROC C nums:dword, randNumCount:dword, leftBorders:dword, result:dword, intervalCount:dword

	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov ecx, randNumCount ; ���-�� �����
	mov esi, nums ; ��������������� �����
	mov edi, leftBorders ; ����� �������

	mov edx, 0 ; ������ �������� �����
	next:
	mov ebx, [esi+4*edx] ; ������� �����
	cmp ebx, [edi] ; ������� ����� �������
	jl continue

	mov eax, 0 ; ������ ���������
	searchInterval:
		cmp ebx, [edi+4*eax] ; ����� � ��������
		jl endSearch	
		cmp eax, intervalCount
		je endSearch
		inc eax
		jmp searchInterval

    endSearch:
    mov edi, result
    mov ebx, [edi+4*eax]
    inc ebx
    mov [edi+4*eax], ebx ; ������ &&&
    mov edi, leftBorders ; � ��� ����� �������

	continue:
	inc edx
	loop next

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
func ENDP
END