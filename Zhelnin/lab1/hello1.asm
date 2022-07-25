
; HELLO1.ASM -  упрощенная версия учебной программы лаб.раб. N1
;               по дисциплине "Архитектура компьютера"
; *****************************************************************
; Назначение: Программа формирует и выводит на экран приветствие
;             пользователя с помощью функции ДОС "Вывод строки"
;             (номер 09 прерывание 21h), которая:
;              - обеспечивает вывод на экран строки символов,
;                заканчивающейся знаком "$";
;              - требует задания в регистре ah номера функции=09h,
;                а в регистре dx -  смещения  адреса  выводимой
;                строки;
;              - использует регистр  ax  и  не сохраняет его
;                содержимое.
; ******************************************************************

   DOSSEG                                      ; Задание сегментов под ДОС
   .MODEL  SMALL                               ; Модель памяти-SMALL(Малая)
   .STACK  100h                                ; Отвести под Стек 256 байт
   .DATA                                       ; Начало сегмента данных
Greeting  LABEL  BYTE                          ; Текст  приветствия
   DB 'Вас приветствует ст.гр.0383 - Желнин М.Ю.',13,10,'$'
   .CODE                                ; Начало сегмента кода
   mov  ax, @data                        ; Загрузка в DS адреса начала
   mov  ds, ax                           ; сегмента данных
   mov  dx, OFFSET Greeting              ; Загрузка в dx смещения
                                        ; адреса текста приветствия
DisplayGreeting:
   mov  ah, 9                            ; # функции ДОС печати строки
   int  21h                             ; вывод на экран  приветствия
   mov  ah, 4ch                          ; # функции ДОС завершения программы
   int  21h                             ; завершение программы и выход в ДОС
   END
