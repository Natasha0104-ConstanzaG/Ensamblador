PAGE 60,123
TITLE borra4p (EXE) Programa que borra pantalla en 4
pila SEGMENT PARA STACK 'Stack'
  DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
  cad1 DB 'segmento uno$'
  cad2 DB 'segmento dos$'
  cad3 DB 'segmento tres$'
  cad4 DB 'segmento cuatro$'
datos ENDS
codigo SEGMENT PARA 'Code'
  inicio PROC FAR
   ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
   MOV AX,datos
   MOV DS,AX
   MOV ES,AX
   CALL borra1
   CALL borra2
   CALL borra3
   CALL borra4
   
   MOV AH,02H
   MOV BH,00H
   MOV DX,060EH
   INT 10H
   MOV AH,09H
   LEA DX,cad1
   INT 21H
   
   MOV AH,02H
   MOV BH,00H
   MOV DX,0636H
   INT 10H
   MOV AH,09H
   LEA DX,cad2
   INT 21H

   MOV AH,02H
   MOV BH,00H
   MOV DX,120EH
   INT 10H
   MOV AH,09H
   LEA DX,cad3
   INT 21H

   MOV AH,02H
   MOV BH,00H
   MOV DX,1236H
   INT 10H
   MOV AH,09H
   LEA DX,cad4
   INT 21H
   MOV AX,4C00H
   INT 21H
 inicio ENDP

 borra1 PROC NEAR
   MOV AX,0600H
   MOV BH,67H
   MOV CX,0000H
   MOV DX,0C28H
   INT 10H
   RET
 borra1 ENDP

 borra2 PROC NEAR
   MOV AX,0600H
   MOV BH,13H
   MOV CX,0029H
   MOV DX,0C4FH
   INT 10H
   RET
 borra2 ENDP

 borra3 PROC NEAR
   MOV AX,0600H
   MOV BH,20H
   MOV CX,0D00H
   MOV DX,1828H
   INT 10H
   RET
 borra3 ENDP

 borra4 PROC NEAR
   MOV AX,0600H
   MOV BH,71H
   MOV CX,0D29H
   MOV DX,184FH
   INT 10H
   RET
 borra4 ENDP

codigo ENDS
  END inicio