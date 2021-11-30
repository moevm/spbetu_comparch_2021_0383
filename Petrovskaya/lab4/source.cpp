/*Write a prog to process char info, following function realization is a must:

* - initialization in C (or other lang): title table output with kind of transformation and *autor of the prog
* - Char string input size <= Nmax(=80) from keyboard to the chosen memory location(in C); *if string size > Nmax - other chars are to be ignored
* - Transformation of the original string and write the result in the output string in ASM
* - Output of the result char string to the screen and write in file (in C)

* put the ASM part of prog using in-line
* DONT touch input string or change it
* when transforming using string commands is a must

* Transform VAR 1: Form result string from numbers and russian letters ONLY*/

/**PROG:**/

#include <iostream>
//#include <stdio.h>
#include <fstream>

	char s[81];
	char outs[81];

int main() {
	locale::global(locale("")); //so the russian chars are available

	std::cout << "Var 1: Form result string from numbers and russian letters ONLY" << std::endl;
	std::cout << "Petrovskaya Evgeniya, 0383" << std::endl;

	fgets(s, 81, stdin);
	s[strlen(s) - 1] = '\0';


	__asm {
		PUSH DS
		POP ES
		MOV ESI, OFFSET s
		MOV EDI, OFFSET outs

		loop:						;loop start
			LODSB 					;load byte at address DS:(E)SI into AL

				;check for 0-9
			CMP AL, '0'				;check if AL >= '0' if not - jmp to next check
			JA Acheck			
			CMP AL, '9'				;check if AL <= '9' if not - jmp to next check
			JB Acheck
			JMP write				;if '0' <= AL <= '9' - write it into outsting

				;check for A-я
			Acheck:
				CMP AL, 'А'			;check if AL >= 'А' if not - jmp to next loop iteraton
				JA loop
				CMP AL, 'я'			;check if AL <= 'я' if not - jmp to next loop iteraton
				JB loop
				JMP write			;if 'А' <= AL <= 'я' - write it into outsting

			write:
				STOSB				;save AL into address DS:(E)DI
			MOV ECX, '\0'
			CMP ECX, [ESI]			;check if EOL is reached
			JE exit					;if so - exit

		JMP loop
		exit:
	};

	std::cout << outs;
	std::ofstream out("output.txt");
	out << outs;


	return 0;
}