PAGE  60,132
TITLE fibonaci (EXE) Programa que imprime serie fibonaci con procedimientos
pila SEGMENT PARA STACK 'Stack'
   DB 32 DUP (0)
pila ENDS
datos SEGMENT PARA 'Data'
    VALOR  LABEL BYTE
    max   DB 6
    real  DB ?
    cad   DB 6 DUP (' ')
    pedir DB 'Introduce numero: $'
    suma  DW 0
    resul DW 0
    aux   DW 0
    msj   DB 'La serie fibonacci es: $'
    msj2  DB 'No es numero: $'
    ban   DB ?
    DMIL  DW 10000
    MIL   DW 1000
    CIEN  DW 100
    DIEZ  DW 10
    num   DB 7 DUP (0)
    a DW 0
    b DW 1
    c DW 0
datos ENDS
codigo SEGMENT PARA 'Code'
inicio PROC FAR
    ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
    MOV AX,datos
    MOV DS,AX
    MOV ES,AX

    CALL borrar
    MOV DX,0305H
    CALL cursor
    LEA DX,pedir
    CALL imprimir
    LEA DX,VALOR
    CALL recibe
    CALL esnum
    CMP ban,1
    JNE etiq1
    CALL cadnum
    MOV DX,0605H
    CALL cursor
    LEA DX,msj
    CALL imprimir
    MOV DX,0702H
    CALL cursor
    CMP suma,1
    JB etiq
    CALL numcad
    JB etiq
    CALL fib
    JMP fin
etiq:
    MOV AX,0
    CALL numcad
    LEA DX,num
    CALL imprimir
    JMP fin
etiq1:
	MOV DX,0605H
    CALL cursor
	LEA DX,msj2
    CALL imprimir
fin:
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

imprimir PROC NEAR
     MOV AH,09H
     INT 21H
     RET
imprimir ENDP

recibe PROC NEAR
    MOV AH,0AH
    INT 21H
    RET
recibe ENDP

esnum PROC NEAR
    SUB CX,CX
    MOV CL,real
    LEA BX,cad 
verif:
    MOV AH,[BX] ;primer caracter
    CMP AH,48   ;compara con 48
    JB noes    ;salto
    CMP AH,57  ;salta si es menor al 0 o si es mayor al 9
    JA noes   ;salta
    INC BX   ;incremento
    LOOP verif
    MOV ban,1
    JMP sies
    noes:
      MOV ban,0
    sies:
    RET
esnum ENDP

cadnum PROC NEAR 
    SUB  CX,CX
    MOV  CL,real
    LEA  BX,cad
Con:
     MOV AH,00H
     MOV AL,[BX]
     SUB AL,48
     MOV resul,AX
     MOV AX,01
     MOV aux,CX
     DEC aux
     JZ Numero
Pot:
    MUL diez
    DEC aux
    JNZ Pot
Numero:
    MUL resul
    ADD suma,AX
    INC BX
    LOOP Con
    CMP suma,1
    
    MOV CX,suma
    MOV c,1
    CMP CX,2
    ; salta si es menor
    DEC CX
    RET
cadnum ENDP

numcad PROC NEAR 
    LEA BX,NUM
	CMP AX, DMIL
	JB ESMIL
	SUB DX,DX
	DIV DMIL
	ADD AL,48
	MOV [BX], AL
	INC BX
	MOV AX,DX
	JMP SIGUE1
ESMIL:
	CMP AX,MIL
	JB ESCIEN
SIGUE1:
	SUB DX,DX
	DIV MIL
	ADD AL,48
	MOV [BX],AL
	INC BX
	MOV AX,DX
	JMP SIGUE2	
ESCIEN:
	CMP AX,CIEN
	JB ESDIEZ
SIGUE2:
	SUB DX,DX
	DIV CIEN
	ADD AL,48
	MOV [BX],AL
	INC BX
	MOV AX,DX
	JMP SIGUE3
ESDIEZ:
	CMP AX,DIEZ
	JB ESUNO
SIGUE3:
	SUB DX,DX
	DIV DIEZ
	ADD AL,48
	MOV [BX],AL
	INC BX
	MOV AX,DX
ESUNO:
	ADD AL,48
	MOV [BX],AL
	INC BX
    MOV [BX],' '
    INC BX
	MOV [BX],'$'
RET 
numcad ENDP

fib PROC NEAR
MOV CX,suma
  MOV AX,1
  CALL numcad
  LEA DX,num
  CALL imprimir
  CMP CX,2
  DEC CX
fibo:
    MOV AX,b
    ADD AX,a
    MOV BX,b
    MOV a,BX
    MOV b,AX
    ;MOV c,AX
    CALL numcad
    LEA DX,num
    CALL imprimir
    ;MOV AX,c
    LOOP fibo
    RET
fib ENDP

CODIGO ENDS
END INICIO