.586
.MODEL FLAT, C
.CODE

PUBLIC C func2
func2 PROC C res1:dword, GrInt: dword, res2: dword, x_max: dword, x_min: dword, n: dword

push esi
push edi

mov esi, GrInt
mov edi, res2
mov ecx, n

lp:
    mov eax, [esi] ; ����� ������� ���������
    mov ebx, [esi + 4] ; ������ �������

    cmp eax, x_min ; ���� eax >= x_min
    jge l2
    mov eax, 0 ; �����, eax = 0, ������ ������� res1

    sub ebx, x_min ; ���� ����� ��������� = 0
    jle l4
    jmp l5

    l2:
        sub ebx, eax ; ���������� ��������� � ���������
        cmp ebx, 0 ; ���� ����� ��������� = 0
        je l4
        sub eax, x_min ; ������ ������� �������� �� �������� ��������� � ������� res1

    l5:
        push esi 
        push ecx

        mov ecx, ebx ; ���������� ��������� �� res1 �� ������� ����� ������
        mov esi, res1 ; ������
        mov ebx, 0 ; ������� ����� ���������� ���������

    lp2: ; ����, ������� ����� ���������, �������� � ��������
       add ebx, [esi + 4*eax]
       inc eax
       loop lp2

    pop ecx


    cmp ecx, 0 ; ���� ������������ �� ��������� �������, �� ���������� ����� � ������ ���������
    jne l3
    add ebx, [esi + 4*eax] ; �����, ������ ���������� ��������� ���������, ������� ��������� ��� �������

    l3:

        mov [edi], ebx ; ���������� ���������
        pop esi
        jmp l1

    l4:
        mov [edi], ebx ; ���������� 0, ���� �������� ������

    l1:
        add edi, 4 ; ��������� � ����. ��������� ��������
        add esi, 4
    
    loop lp
   

pop edi
pop esi

ret
func2 ENDP
END