page 60,132
TITLE raton1 (EXE) Programa que indica que boton del mouse se pulso
pila SEGMENT PARA STACK 'Stack'
   DB 32 DUP (' ')
pila ENDS
datos SEGMENT PARA 'Data'
   msj1  DB 'Boton Izquierdo$'
   msj2  DB 'Boton Derecho  $'
   msj3  DB 'Boton Central  $'
   r     DW 0
   c     DW 0
   x     DB 0
   y     DB 0
   n     DW 8
datos ENDS
codigo SEGMENT PARA 'Code'
inicio PROC FAR
   ASSUME CS:codigo,SS:pila,DS:datos
   mov ax,datos
   mov ds,ax
   mov es,ax
   MOV AX,0600H
   MOV BH,07H
   MOV CX,0000H
   MOV DX,184FH
   INT 10H
   MOV AX,00H
   INT 33H
   MOV AX,01H
   INT 33H

ciclo:
   MOV AX,03H
   INT 33H
   MOV c,CX
   MOV r,DX
   SUB DX,DX
   MOV AX,r
   DIV n
   MOV y,AL
   SUB DX,DX
   MOV AX,c
   DIV n
   MOV x,AL
   INC x
   MOV AH,02H
   MOV BH,00H
   MOV DH,y
   MOV DL,x
   INT 10H
   CMP BX,01H
   JNE Etq1
   MOV AH,09H
   LEA DX,msj1
   INT 21H
   JMP sigue

Etq1:
   CMP BX,02H
   JNE Etq2
   MOV AH,09H
   LEA DX,msj2
   INT 21H
   JMP sigue

Etq2:
   CMP BX,04H
   JNE sigue
   MOV AH,09H
   LEA DX,msj3
   INT 21H

sigue:
   CMP BX,03H
   JNE ciclo
   MOV AX,02H
   INT 33H
   MOV AX,4C00H
   INT 21H

inicio ENDP
codigo ENDS
    END inicio