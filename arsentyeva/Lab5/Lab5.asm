NUM_SYM equ 5 ; кол-во символов в строке для ввода

; Стек  программы
AStack    SEGMENT  STACK
          DW 1024 DUP(?)  ; Отводится 1024 слов памяти
AStack    ENDS

; Данные программы
DATA      SEGMENT
          KEEP_CS DW 0  ; для хранения сегмента
          KEEP_IP DW 0  ; и смещения прерывания
          ; возврат каретки с кодом 13 (0Dh), перевод строки с кодом 10 (0Ah).
          MES DB 0Dh, 0Ah, NUM_SYM dup("$"), '$'
          MES_END DB 0Dh, 0Ah, 'Finish', '$'
DATA      ENDS

; Код программы
CODE      SEGMENT
          ASSUME CS:CODE, DS:DATA, SS:AStack

SUBR_INT  PROC FAR
          PUSH  AX  ; сохранение изменяемых регистров
          PUSH  BX
          PUSH  CX
          PUSH  DX
                    
          ; действия по обработке прерывания
          mov  cx, NUM_SYM
          mov  bx, offset MES  ; получаем смещение на начало сообщения
          add  bx, 2
          mov  ah, 01h   ; ввод с клавиатуры
      lp:         
          int  21h
          mov  [bx], al  ; помещаем символ в строку
          inc  bx
          loop  lp
                
          ; вывод строк (сообщений)
          mov  ah, 09h
          mov  dx, offset MES
          int  21h
          mov  dx, offset MES_END
          int  21h
          
          POP  AX   ; восстановление регистров
          POP  BX
          POP  CX   
          POP  DX   
          MOV  AL, 20H  ; для разрешения обрабоки прерываний
          OUT  20H,AL  ; с более низкими уровнями, чем только что обработанное
          IRET
SUBR_INT  ENDP

; Головная процедура
Main            PROC  FAR
          push  DS       ;\  Сохранение адреса начала PSP в стеке
          sub   AX,AX    ; > для последующего восстановления по
          push  AX       ;/  команде ret, завершающей процедуру.
          mov   AX,DATA   ; Загрузка сегментного
          mov   DS,AX     ; регистра данных.
          
          ; Запоминание текущего вектора прерывания
          MOV  AH, 35H   ; функция получения вектора
          MOV  AL, 23H   ; номер вектора
          INT  21H
          MOV  KEEP_IP, BX  ; запоминание смещения
          MOV  KEEP_CS, ES  ; и сегмента
          
          ; Установка вектора прерывания
          PUSH DS
          MOV  DX, OFFSET SUBR_INT ; смещение для процедуры в DX
          MOV  AX, SEG SUBR_INT    ; сегмент процедуры
          MOV  DS, AX          ; помещаем в DS
          MOV  AH, 25H         ; функция установки вектора
          MOV  AL, 23H         ; номер вектора
          INT  21H             ; меняем прерывание
          POP  DS
          
          ;ожидание нажатия ctrl_c
          ctrl_c:  
                mov ah, 0
                int 16h ;Клавиатурный ввод (чтение клавиш)
                cmp al, 3
                jne ctrl_c
          
          int 23h
          
          ; Восстановление изначального вектора прерывания
          CLI
          PUSH DS
          MOV  DX, KEEP_IP
          MOV  AX, KEEP_CS
          MOV  DS, AX
          MOV  AH, 25H
          MOV  AL, 23H
          INT  21H          ; восстанавливаем вектор
          POP  DS
          STI
          
          RET

Main      ENDP
CODE      ENDS
          END Main
