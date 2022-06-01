PAGE 60,132
TITLE parimpar (EXE) Programa que determina si el numero ingresado es par o impar
pila SEGMENT PARA STACK 'Stack'
  DB 32 DUP (0)
pila ENDS
datos SEGMENT PARA 'Data'
   VALOR LABEL BYTE
   max   DB 20
   real  DB ?  
   cad   DB 20 DUP (' ')
   pedir DB 'Introduce un Numero: $'
   suma  DW 0
   resul DW 0
   diez  DW 10
   aux   DW 0
   d     DW 2
   msj   DB 0,'$'
   cad1  DB ' Es par$'
   cad2  DB ' Es impar$'
   ;cad3  DB '  El número es cero$'
datos ENDS
codigo SEGMENT PARA 'Code'
  inicio PROC FAR
    ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
  MOV AX,datos
  MOV DS,AX
  MOV ES,AX
  MOV AX,0600H
  MOV BH,07H
  MOV CX,0000H
  MOV DX,184FH
  INT 10H
  MOV AH,02H
  MOV BH,00H

  MOV DX,0305H
  INT 10
  MOV AH,09H
  LEA DX,pedir
  INT 21H
  MOV AH,0AH
  LEA DX,VALOR
  INT 21H
  SUB CX,CX
  MOV CL,real
  LEA BX,cad
Con:
  MOV AH,00H
  MOV AL,[BX]
  SUB AL,48
  MOV resul,AX
  MOV AX,01
  MOV aux,CX
  DEC aux
  JZ Num
Pot:
  MUL diez
  DEC aux
  JNZ Pot
Num:
  MUL resul
  ADD suma,AX
  INC BX
  LOOP Con
  MOV AH,02H
  MOV BH,00H
  MOV DX,0520H
  INT 10H
  MOV AX,suma
  SUB DX,DX
  DIV d
  CMP DX,0
  JNE impar
  
   MOV AH,09H
   LEA DX,cad1
   INT 21H
   JMP fin
impar:
   MOV AH,09H
   LEA DX,cad2
   INT 21H

Etiqueta:
  MOV AH,09H
  LEA DX,msj
  INT 21H

fin:
   MOV AX,4C00H
   INT 21H

inicio ENDP
codigo ENDS
   END inicio