PAGE 60,132
TITLE marcogpr (EXE) Programa que borra pantalla
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
   CALL borrar
ciclor:
   MOV DH,1
   CALL cursor1
   CALL imprime
   MOV DH,23
   CALL cursor1
   CALL imprime
   INC c
   CMP c,79
   JBE ciclor
cicloc:
   MOV DL,0
   CALL cursor2
   CALL imprime
   MOV DL,79
   CALL cursor2
   CALL imprime
   INC r
   CMP r,23
   JBE cicloc
   MOV AX,4C00H
   INT 21H
 inicio ENDS
borrar PROC NEAR
   MOV AX,0600H
   MOV BH,07H
   MOV CX,0000H
   MOV DX,184FH
   INT 10H
   RET
borrar ENDP

imprime PROC NEAR
   MOV AH,09H
   LEA DX,cad
   INT 21H
   RET
imprime ENDP

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
codigo ENDS
  END inicio