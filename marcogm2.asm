PAGE 60,132
 borrar MACRO 
     MOV AX,0600H
     MOV BH,07H
     MOV CX,0000H
     MOV DX,184FH
     INT 10H
     ENDM
 cursor MACRO x,y
     MOV AH,02H
     MOV BH,00H
     MOV DH,y
     MOV DL,x
     INT 10H
     ENDM
 imprime MACRO str
     MOV AH,09H
     LEA DX,str
     INT 21H
     ENDM
TITLE macrogm2 (EXE) Programa que borra pantalla
pila SEGMENT PARA STACK 'Stack'
     DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
     cad DB '#$'
     r   DB 1
     c   DB 1
datos ENDS
codigo SEGMENT PARA  'Code'
 inicio PROC FAR
  ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
     MOV AX,datos
     MOV DS,AX
     MOV ES,AX
     borrar
 cicloren:
     cursor c,1
     imprime cad
     cursor c,23
     imprime cad
     INC c
     CMP c,78
     JBE cicloren
 ciclocol:
     cursor 1,r
     imprime cad
     cursor 78,r
     imprime cad
     INC r
     CMP r,23
     JBE ciclocol
     MOV AX,4C00H
     INT 21H
  inicio ENDP
 codigo ENDS
   END inicio