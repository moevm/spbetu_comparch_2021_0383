#include <iostream>
#include <stdio.h>
#include <windows.h>

char s[81];
char outstr[161];

int main()
{

	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	fgets(s, 81, stdin);
	s[strlen(s) - 1] = '\0';
	__asm {
		push ds
		pop es
		mov esi, offset s
		mov edi, offset outstr
		L :
		lodsb // в al очередной символ

		cmp al, 192
		jl not_uppercase
		cmp al, 223
		jg not_uppercase
		// Чтобы конвертировать русские заглавные буквы в прописные,
		// необходимо сместиться на 32 бита вперед
		add al, 32
		stosb
		jmp final

		not_uppercase:

		cmp al, 'Ё'
		jne not_yo
		mov al, 'ё'

		not_yo:

		cmp al, 48
		jl not_between_zero_and_seven
		cmp al, 55
		jg not_between_zero_and_seven
		neg al
		add al, 103
		stosb
		jmp final

		not_between_zero_and_seven:

		stosb // кладем в выходную строку байт из al

			final:
			mov  ecx, '\0'
			cmp  ecx, [esi]
			je   LExit // выход из цикла, если текущий символ завершающий
			jmp  L
			LExit :
	};
	std::cout << outstr;
	FILE* f;
	fopen_s(&f, "out.txt", "w");
	fwrite(outstr, sizeof(char), strlen(outstr), f);
	return 0;
}