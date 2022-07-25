#include <iostream>
#include <stdio.h>
#include <windows.h>

char s[81];
char outstr[161];

int main()
{
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);  // ����� �� ���� � ����� �������� �� ��1251
	fgets(s, 81, stdin);
	s[strlen(s) - 1] = '\0';
	__asm {
		push ds
		pop es
		mov esi, offset s
		mov edi, offset outstr
		L :
		lodsb //����� ������ � al

			cmp al, 192
			jl nouppercase
			cmp al, 223
			jg nouppercase
			//�������� �� 32 ���� ����� ������� ����������
			add al, 32
			stosb
			jmp final

			nouppercase: //���� �� ���������, �� ��������� ��� ��� � � ��������� � ������

		cmp al, '�'
			jne noe
			mov al, '�'

			noe :

			cmp al, 48
			jl zeroseven
			cmp al, 55
			jg zeroseven
			//������� �����: � ����� � al, x-48 - ������� �� 0, 
			//55-(x-48) - ����� � ������� ���� �������������
			//(55 - (x - 48)) - x � ������� ����� x � ������, � ������� ���� ������������� => ���������� � x
			// x + ((55 - (x - 48)) - x) = 103 - x
			neg al       
			add al, 103
			stosb
			jmp final

			zeroseven:

		stosb // ������ � �������� ������ ���� �� al

			final:
		mov  ecx, '\0'
			cmp  ecx, [esi]
			je   LExit // ����� �� �����, ���� ������� ������ �����������
			jmp  L
			LExit :
	};
	std::cout << outstr;
	FILE* f;
	fopen_s(&f, "out.txt", "w");
	fwrite(outstr, sizeof(char), strlen(outstr), f);
	return 0;
}