PAGE 60,132
TITLE centrar (EXE) Programa que borra pantalla
pila SEGMENT PARA STACK 'Stack'
  DB 32 DUP ('0')
pila ENDS
codigo SEGMENT PARA 'Code'
  inicio PROC FAR
   ASSUME CS:codigo,SS:pila
   MOV AX,0600H
   MOV BH,91H
   MOV CX,0000H
   MOV DX,184FH
   INT 10H

   MOV AH,06H
   MOV BH,62H
   MOV CX,040DH
   MOV DX,1442H
   INT 10H

   MOV AH,06H
   MOV BH,41H
   MOV CX,081AH
   MOV DX,1035H
   INT 10H
   MOV AX,4C00H
   INT 21H
 inicio ENDP
codigo ENDS
  END inicio