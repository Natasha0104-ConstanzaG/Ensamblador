PAGE 60,132
TITLE primo (EXE) Programa primo
pila SEGMENT PARA STACK 'Stack'
  DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
  cad1 DB 'Es primo$'
  cad2 DB 'No es primo$'
  n   DB 23
  d   DB 1
  c   DB 0
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
   MOV AH,02H
   MOV BH,00H
   MOV DH,12
   MOV DL,36
   INT 10H
ciclo:
   SUB AX,AX
   MOV AL,n
   DIV d
   CMP AH,0
   JNE sigue
   INC c
sigue:
   INC d
   MOV AL,n
   CMP d,AL
   JBE ciclo
   CMP c,2
   JE primo
   MOV AH,09H
   LEA DX,cad2
   INT 21H
   JMP fin
primo:
   MOV AH,09H
   LEA DX,cad1
   INT 21H
fin:
   MOV AX,4C00H
   INT 21H
 inicio ENDP
codigo ENDS
  END inicio