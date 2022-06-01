PAGE 60,132
borrar MACRO  
  MOV AX,0600H
  MOV BH,71H
  MOV CX,0000H
  MOV DX,184FH
  INT 10H
  ENDM
iniraton MACRO
  MOV AX,00H
  INT 33H
  MOV AX,0001H
  INT 33H
  ENDM
cursor MACRO 
  MOV AH,02H
  MOV BH,00H
  MOV DH,ren
  MOV DL,col
  INT 10H
  ENDM
imprime MACRO 
  MOV AH,09H
  INT 21H
  ENDM
pausa MACRO
  MOV AH,00H
  INT 1AH
  ADD DX,1
  MOV BX,DX
pausar:
  INT 1AH
  CMP DX,BX
  JBE pausar
  ENDM
checacol MACRO 
  CMP b1,01H
  JE Otra
  INC col
  CMP col,69
  JB Et2
  MOV b1,01H
Otra:
  DEC col
  CMP col,01H
  JA Et2
  MOV b1,02H
Et2:
 ENDM
checaren MACRO
  CMP b2,01H
  JE Otra1
  INC ren 
  CMP ren,23
  JB Et3
  MOV b2,01H
Otra1:
  DEC ren
  CMP ren,01H
  JA Et3
  MOV b2,00H
  
Et3:
  ENDM
leeboton MACRO
   MOV AX,03H
  INT 33H
  MOV boton, BX
 ENDM
TITLE rebota (EXE) Programa rebota
pila SEGMENT PARA STACK 'Stack'
     DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'DATA'
  ren DB 1
  col DB 1
  car1 DB 'Hola Mundo$'
  car2 DB '          $'
  b1 DB 0 
  b2 DB 0
  boton DW 0
datos ENDS
codigo SEGMENT PARA 'Code'
  inicio PROC FAR
    ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
  MOV AX,DATOS
  MOV DS,AX
  MOV ES,AX
  borrar 
  iniraton
 
  Et1:
  cursor
  LEA DX,car1
  imprime 
  pausa
  cursor
  LEA DX,car2
  imprime
  checacol
  checaren
  leeboton
  CMP BX,01H
  JE fin
  JMP Et1
 
fin: 
  MOV AX,4C00H
  INT 21H
inicio ENDP
codigo ENDS
   END inicio
