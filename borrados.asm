PAGE 60,132
TITLE borrados (EXE) Programa que borra pantalla
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
   MOV AH,06H
   MOV BH,07H
   MOV CX,1828H
   MOV DX,184FH
   INT 10H
   MOV AH,06H
   MOV BH,57H
   MOV CX,0029H
   MOV DX,184FH
   INT 10H
   MOV AH,02H
   MOV BH,00H
   MOV DX,0C23H
   INT 10H
   MOV AH,09H
   LEA DX,cad
   INT 21H
   MOV AX,4C00H
   INT 21H
 inicio ENDP
codigo ENDS
  END inicio