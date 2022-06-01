PAGE 60,132
TITLE hola (EXE) Programa que borra pantalla
pila SEGMENT PARA STACK 'Stack'
  DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
  cad DB 'Hola Mundo$'
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
   MOV AH,09H
   LEA DX,cad
   INT 21H
   MOV AX,4C00H
   INT 21H
 inicio ENDP
codigo ENDS
  END inicio