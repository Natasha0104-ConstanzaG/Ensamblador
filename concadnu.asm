PAGE 60,132
TITLE concn (EXE) Programa que convierte de cadena a numero
pila SEGMENT PARA STACK 'Stack'
     DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'DATA'
   VALOR LABEL BYTE
     max DB 6
      real DB ?  
   cad DB 6 DUP (' ')
   pedir DB 'Introduce un Numero: $'
   suma DW 0
   resul DW 0
   diez DW 10
   aux DW 0
  msj DB 0,'$'
    
datos ENDS
codigo SEGMENT PARA 'Code'
  inicio PROC FAR
    ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
  MOV AX,DATOS
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
  MOV AX,suma
  MOV msj,AL
  MOV AH,02H
  MOV BH,00H
  MOV DX,0505H
  INT 10H
  MOV AH,09H
  LEA DX,msj
  INT 21H
  MOV AX,4C00H
  INT 21H
inicio ENDP
codigo ENDS
   END inicio
