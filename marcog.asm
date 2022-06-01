PAGE 60,132
TITLE holarep (EXE) Programa que borra pantalla
pila SEGMENT PARA STACK 'Stack'
  DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
  cad DB '#$'
  r   DB 1
  c   DB 1
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
ciclor:
   MOV AH,02H
   MOV BH,00H
   MOV DH,1
   MOV DL,c
   INT 10H
   MOV AH,09H
   LEA DX,cad
   INT 21H
   MOV AH,02H
   MOV BH,00H
   MOV DH,23
   MOV DL,c
   INT 10H
   MOV AH,09H
   LEA DX,cad
   INT 21H
   INC c
   CMP c,79
   JBE ciclor
cicloc:
   MOV AH,02H
   MOV BH,00H
   MOV DH,r
   MOV DL,0
   INT 10H
   MOV AH,09H
   LEA DX,cad
   INT 21H
   MOV AH,02H
   MOV BH,00H
   MOV DH,r
   MOV DL,79
   INT 10H
   MOV AH,09H
   LEA DX,cad
   INT 21H
   INC r
   CMP r,23
   JBE cicloc
   MOV AX,4C00H
   INT 21H
 inicio ENDP
codigo ENDS
  END inicio