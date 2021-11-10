ASSUME CS:CODE, DS:DATA, SS:STACK

STACK SEGMENT STACK
	DW 1024 DUP (?)
STACK ENDS

DATA      SEGMENT
	KEEP_CS DW 0 ; для хранения сегмента
    KEEP_IP DW 0 ; и смещения прерывания
DATA      ENDS

CODE      SEGMENT
    
SUBR_INT  PROC FAR
	PUSH AX    ; сохранение изменяемых регистров
	PUSH CX
		
            ;<действия по обработке прерывания>
	MOV CX, AX
	MOV AL, 10110110b
	OUT 43H, AL ; Код для установления канала 2 таймера-счетчика на работу в качестве делителя частоты
	MOV AX, CX ; Заносим в AX высоту звука
	OUT 42H, AL
	MOV AL, AH
	OUT 42H, AL ; Заносим поочередно 2 байта в порт 42h
	IN AL, 61H
	MOV AH, AL
	OR AL, 3
	OUT 61H, AL ; Установление битов 0 и 1 в единицу
	SUB CX, CX
	WORK_TIME:
	NOP
	NOP
	NOP
	NOP
	NOP
	LOOP WORK_TIME ; Цикл, пока динамик работает
	MOV AL, AH
	OUT 61H, AL ; Выключение динамика (изначальное значение порта 61h)
            ;<конец действий по обработке прерывания>
	POP CX
	POP  AX   ; восстановление регистров
	MOV  AL, 20H
	OUT  20H,AL
	IRET
SUBR_INT  ENDP

Main	PROC  FAR
	; <Запоминание текущего вектора прерывания>
	MOV  AH, 35H   ; функция получения вектора
	MOV  AL, 60H   ; номер вектора
	INT  21H
	MOV  KEEP_IP, BX  ; запоминание смещения
	MOV  KEEP_CS, ES  ; и сегмента
	
	; <Установка вектора прерывания>
	PUSH DS
	MOV  DX, OFFSET SUBR_INT ; смещение для процедуры в DX
	MOV  AX, SEG SUBR_INT    ; сегмент процедуры
	MOV  DS, AX          ; помещаем в DS
	MOV  AH, 25H         ; функция установки вектора
	MOV  AL, 60H         ; номер вектора
	INT  21H             ; меняем прерывание
	POP  DS
	
	MOV AX, 8000
	INT 60H

	; <Восстановление изначального вектора прерывания>
	CLI
	PUSH DS
	MOV  DX, KEEP_IP
	MOV  AX, KEEP_CS
	MOV  DS, AX
	MOV  AH, 25H
	MOV  AL, 60H
	INT  21H          ; восстанавливаем вектор
	POP  DS
	STI
	
	MOV AH, 4Ch                          
	INT 21h
Main      ENDP
CODE ENDS
	END Main