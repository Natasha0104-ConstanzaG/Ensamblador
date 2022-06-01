PAGE 60,123
borra  MACRO esq1,esq2,color
   MOV AX,0600H
   MOV BH,color
   MOV CX,esq1
   MOV DX,esq2
   INT 10H
   ENDM
 
 cursor  MACRO x,y
   MOV AH,02H
   MOV BH,00H
   MOV DH,y
   MOV DL,x
   INT 10H
   ENDM
 
 imprime  MACRO str
   MOV AH,09H
   LEA DX,str
   INT 21H
   ENDM
 
TITLE borrar4m (EXE) Programa que borra pantalla en 4
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
   borra 0000H,0C28H,67H
   cursor 0EH,06H
   imprime cad1
   borra 0029H,0C4FH,13H
   cursor 36H,06H
   imprime cad2
   borra 0D00H,1828H,20H
   cursor 0EH,12H
   imprime cad3
   borra 0D29H,184FH,71H
   cursor 36H,12H
   LEA DX,cad4
   imprime cad4
   MOV AX,4C00H
   INT 21H
 inicio ENDP
codigo ENDS
  END inicio