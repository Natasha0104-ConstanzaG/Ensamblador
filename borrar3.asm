PAGE 60,132
TITLE centrar (EXE) Programa que borra pantalla
pila SEGMENT PARA STACK 'Stack'
  DB 32 DUP ('0')
pila ENDS
codigo SEGMENT PARA 'Code'
  inicio PROC FAR
   ASSUME CS:codigo,SS:pila
   MOV AH,06H
   MOV BH,71H
   MOV CX,0000H
   MOV DX,074FH
   INT 10H

   MOV AH,06H
   MOV BH,52H
   MOV CX,0800H
   MOV DX,0F4FH
   INT 10H

   MOV AH,06H
   MOV BH,41H
   MOV CX,1000H
   MOV DX,184FH
   INT 10H
   MOV AX,4C00H
   INT 21H
 inicio ENDP
codigo ENDS
  END inicio