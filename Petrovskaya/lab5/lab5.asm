;Create your own interruption
;interruption = proc with certain functions
;By the end of the program make sure to return original vectors of interruptions
;VAR 26 - 4e: 16h - interrupr from keyboard(by pressing a key do E: read and input to screen real-time clock counting from memory CMOS(in BCD format)
;!should use more than 1Kb for stack
		;PROG:

ASSUME CS:CODE, DS:DATA, SS:STACK

STACK SEGMENT STACK
	DW 1024 DUP(?)		;Declare an array of 1024 unitialized Words (2 bytes) for stack
STACK ENDS

DATA	SEGMENT
	KEEP_CS DW 0 		;to store segment
	KEEP_IP DW 0 		;to store interruption vector shift
DATA	ENDS

CODE	SEGMENT

SUBR_INT PROC FAR		;port 70h is for input(stores addr) use it to get CMOS registers, port 71h - to read from them - if not using INT 1Ah
	JMP start
	ORIG_SS DW 0
	ORIG_SP DW 0
	ORIG_AX DW 0
	INT_STACK DB 40 DUP(?)
	
	read_CMOS PROC
		PUSH DX
			;hours
		MOV AL, CH		;in CX=HHMM,
		CALL print_bcd
		CALL colon
			;minutes
		MOV AL, CL
		CALL print_bcd
		CALL colon
			;seconds
		MOV AL, DH
		CALL print_bcd
		POP DX
		RET	
	read_CMOS ENDP
	
	colon PROC
		MOV DL, ':'
		MOV AH, 02h
		INT 21H		
		RET
	colon ENDP
		
	print_bcd PROC
		PUSH DX		;save initial registers
		PUSH CX
		MOV CL, 4
		MOV AH, AL		;now al = 43 = ah
		AND AL, 00001111b	;now al = 03 (as it is in BCD, each digit is xxxxb)
		SHR AH, CL		;now ah = 04 => ax = 0403
		ADD AL, '0'		;get ASCII value of '0' + shift in AL
		ADD AH, '0'
		MOV DL, AH
		MOV DH, AL
		MOV AH, 02h
		INT 21h
		MOV DL, DH
		INT 21h
		POP CX			;return initial values
		POP DX
		RET
	print_bcd ENDP
	
start:	
	MOV ORIG_SP, SP
	MOV ORIG_AX, AX
	MOV AX, SS
	MOV ORIG_SS, AX
	MOV AX, ORIG_AX
	MOV SP, OFFSET start
	MOV SS, AX
	

    	PUSH AX    ;save original registers
    	PUSH DX
;-------------------------------------------<process the interrupt>
	MOV AH, 02H		;read time from CMOS
	INT 1Ah		;returns CX:DX = clock count
	CALL read_CMOS
	
	POP DX			;restore registers
	POP AX
	MOV ORIG_AX, AX
	MOV SP, ORIG_SP
	MOV AX, ORIG_SS
	MOV SS, AX
	MOV AX, ORIG_AX
	
	MOV AL, 20H		;these lines allow to process lower level 
	OUT 20H, AL 		;interrupts than those we worked with
	IRET			;exit from iterrupt
SUBR_INT ENDP


Main	PROC FAR
	PUSH DS
	SUB AX, AX
	PUSH AX
	MOV AX, DATA		;DataSegment initialization
	MOV DS, AX
;-----------save current vector-
	MOV AH, 35H 		;get curr vector
	MOV AL, 60H		;get curr vector number
	INT 21H
	MOV KEEP_IP, BX	;store the shift
	MOV KEEP_CS, ES 	;store interruption vector segment

;-----------install new interrupt vector-
	PUSH DS
	MOV DX, OFFSET SUBR_INT	;shift fot the proc into DX
	MOV AX, SEG SUBR_INT	;procedure segment we save and
	MOV DS, AX		;put into DS
	MOV AH, 25H		;funtion to install new vector, it stores
				;segment and shift addresses into interrupt
				;vector with chosen number.
	MOV AL, 60H		;new vector number
	INT 21H		;change the interrupt
	POP DS
	
;-----------get key scan-code-(let`s it be 'Q')
	readkey:
		MOV AH, 0		;by pressing key in AH a BIOS scancode is stored, and in AL - an ASCII symbol
		INT 16H		;interrupt to get the key scancode
		CMP AH, 16		;16 is a scancode of 'Q'
		JNE readkey		;if it`s not 'Q' -> repeat reading, else continue
		
		INT 60H		;call changed interrupt

;-----------restore original interrupt vector-
	CLI
	PUSH DS
	MOV DX, KEEP_IP
	MOV AX, KEEP_CS
	MOV DS, AX
	MOV AH, 25H
	MOV AL, 60H
	INT 21H		;restore vector
	POP DS
	STI
	MOV AH, 4CH
   	INT 21H
Main ENDP
CODE ENDS
END Main
