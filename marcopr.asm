PAGE 60,132
TITLE borrar (EXE) Programa que borra pantalla
pila SEGMENT PARA STACK 'Stack'
     DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'DATA'
   cad DB '#$'
   r DB 0
   c DB 0
datos ENDS
codigo SEGMENT PARA 'Code'
  inicio PROC FAR
    ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
  MOV AX,DATOS
  MOV DS,AX
  MOV ES,AX
  CALL borrar

cicloren:
MOV DH,1
CALL cursor1
CALL imprime
MOV DH,24
CALL cursor1
CALL imprime

INC c
CMP c,78
JBE cicloren

ciclo1:
MOV DL,0
CALL cursor2
CALL imprime
MOV DL,79
CALL cursor2
CALL imprime

INC r
CMP r,23
JBE ciclo1


  MOV AX,4C00H
  INT 21H
inicio ENDP
borrar PROC NEAR 
  MOV AX,0600H
  MOV BH,71H
  MOV CX,0000H
  MOV DX,184FH
  INT 10H
RET 
borrar ENDP
cursor1 PROC NEAR 
  MOV AH,02H
  MOV BH,00H
  MOV DL,c
  INT 10H
RET 
cursor1 ENDP
cursor2 PROC NEAR 
  MOV AH,02H
  MOV BH,00H
  MOV DH,r
  INT 10H
RET 
cursor2 ENDP
imprime PROC NEAR 
  MOV AH,09H
  LEA DX,cad
  INT 21H
RET 
imprime ENDP
codigo ENDS
   END inicio
