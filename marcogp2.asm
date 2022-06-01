PAGE 60,132
TITLE marcogp2 (EXE) Programa que borra pantalla
pila SEGMENT PARA STACK 'Stack'
     DB 32 DUP ('0')

pila ENDS
datos SEGMENT PARA 'Data'
     cad DB '#$'
     r DB 1
     c DB 1
datos ENDS
codigo SEGMENT PARA 'Code'
 inicio PROC FAR
     ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
     MOV AX,datos
     MOV DS,AX
     MOV ES,AX
     CALL borrar
cicloren:
     MOV DH,1
     MOV DL,c
     CALL cursor
     CALL imprime
     MOV DH,23
     MOV DL,c
     CALL cursor
     CALL imprime
     INC c
     CMP c,78
     JBE cicloren
ciclocol:
     MOV DL,1
     MOV DH,r
     CALL cursor
     CALL imprime
     MOV DL,78
     MOV DH,r
     CALL cursor
     CALL imprime
     INC r
     CMP r,23
     JBE ciclocol
     MOV AX,4C00H
     INT 21H
inicio ENDP
borrar PROC NEAR
     MOV AX,0600H
     MOV BH,07H
     MOV CX,0000H
     MOV DX,184FH
     INT 10H
     RET
borrar ENDP
cursor PROC NEAR
     MOV AH,02H
     MOV BH,00H 
     INT 10H
     RET
cursor ENDP
imprime PROC NEAR
     MOV AH,09H
     LEA DX,cad
     INT 21H
     RET
imprime ENDP
codigo ENDS
   END inicio