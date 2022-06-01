PAGE 60,132
TITLE concapri (EXE) Programa que convierte de cadena a numero
pila SEGMENT PARA STACK 'Stack'
     DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'DATA'
   VALOR LABEL BYTE
   max   DB 20
   real  DB ?  
   cad   DB 20 DUP (' ')
   pedir DB 'Introduce un Numero: $'
   suma  DW 0
   resul DW 0
   diez  DW 0
   aux   DW 0
   msj   DB 0,'$'
   cad1  DB ' Es Primo$'
   cad2  DB ' No Es Primo$'
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
   CMP suma,0
   JE sigue
   MOV aux,0
   MOV CX,suma

ciclo:
   SUB DX,DX
   MOV AX,suma
   DIV CX
   CMP DX,0
   JNE sigue
   INC aux

sigue:
   LOOP ciclo
   CMP aux,2
   JNE primo
   MOV AH,09H
   LEA DX,cad1
   INT 21H
   JMP fin

primo:
   MOV AH,09H
   LEA DX,cad2
   INT 21H
   JMP fin

etiqueta:
   MOV AH,09H
   LEA DX,msj
   INT 21H

fin:
   MOV AX,4C00H
   INT 21H
inicio ENDP
codigo ENDS
  END inicio