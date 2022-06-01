PAGE 60,123
TITLE borra4i (EXE) Programa que borra pantalla en 4
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

   MOV BH,67H
   MOV CX,0000H
   MOV DX,0C28H
   CALL borra
   MOV DX,060EH
   CALL cursor
   LEA DX,cad1
   CALL imprime

   MOV BH,13H
   MOV CX,0029H
   MOV DX,0C4FH
   CALL borra
   MOV DX,0636H
   CALL cursor
   LEA DX,cad2
   CALL imprime

   MOV BH,20H
   MOV CX,0D00H
   MOV DX,1828H
   CALL borra
   MOV DX,120EH
   CALL cursor
   LEA DX,cad3
   CALL imprime

   MOV BH,71H
   MOV CX,0D29H
   MOV DX,184FH
   CALL borra
   MOV DX,1236H
   CALL cursor
   LEA DX,cad4
   CALL imprime

   MOV AX,4C00H
   INT 21H
 inicio ENDP
 borra PROC NEAR
   MOV AX,0600H
   INT 10H
   RET
 borra ENDP

 cursor PROC NEAR
   MOV AH,02H
   MOV BH,00H
   INT 10H
    RET
 cursor ENDP

 imprime PROC NEAR
   MOV AH,09H
   ;LEA DX,cad1
   INT 21H
   RET
 imprime ENDP
codigo ENDS
  END inicio