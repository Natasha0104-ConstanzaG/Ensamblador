PAGE 60,132
TITLE borrar (EXE) Programa que lee un texto e imprime
pila SEGMENT PARA STACK 'Stack'
	DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
	msj1 DB 'Introduce Texto: $'
	msj2 DB 'El texto de entrada es: $'
	dato LABEL BYTE
	max DB 20
	real DB ? 
	cad DB 20 DUP (0)
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
	MOV DX,0205H
	INT 10H
	MOV AH,09H
	LEA DX,msj1
	INT 21H
	MOV AH,0AH
	LEA DX,dato
	INT 21H
	SUB BX,BX
	MOV BL,real
	MOV cad[BX],'$'
	MOV AH,02H
	MOV BH,00H
	MOV DX,0405H
	INT 10H
	MOV AH,09H
	LEA DX,msj2
	INT 21H
	MOV AH,09H
	LEA DX,cad
	INT 21H
	MOV AX,4C00H
	INT 21H
inicio ENDP
codigo ENDS
END inicio

