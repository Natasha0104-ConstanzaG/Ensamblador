PAGE 60,132
TITLE borrar (EXE) Programa que borra la pantalla
pila SEGMENT PARA STACK 'Stack'
	DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
	cad DB '#$'
	r   DB 1
	c   DB 1
datos ENDS
codigo SEGMENT PARA 'code'
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
ciclor1:
	MOV AH,02H
	MOV BH,00H
	MOV DH,0
	MOV DL,c
	INT 10H
	MOV AH,09H
	LEA DX,cad
	INT 21H
	MOV AH,00H
	INT 1AH
	ADD DX,1
	MOV BX,DX
regreso:
	INT 1AH
	CMP DX,BX
	JNE regreso
	INC c
	CMP c,79
	JBE ciclor1
cicloc2:
	MOV AH,02H
	MOV BH,00H
	MOV DH,r
	MOV DL,79
	INT 10H
	MOV AH,09H
	LEA DX,cad
	INT 21H
	MOV AH,00H
	INT 1AH
	ADD DX,1
	MOV BX,DX
regreso2:
	INT 1AH
	CMP DX,BX
	JNE regreso2
	INC r
	CMP r,23
	JBE cicloc2
	MOV c,78
ciclor2:
	MOV AH,02H
	MOV BH,00H
	MOV DH,23
	MOV DL,c
	INT 10H
	MOV AH,09H
	LEA DX,cad
	INT 21H
	MOV AH,00H
	INT 1AH
	ADD DX,1
	MOV BX,DX
regreso3:
	INT 1AH
	CMP DX,BX
	JNE regreso3
	DEC c
	CMP c,1
	JAE ciclor2
	MOV r,23
cicloc:
	MOV AH,02H
	MOV BH,00H
	MOV DH,r
	MOV DL,0
	INT 10H
	MOV AH,09H
	LEA DX,cad
	INT 21H
	MOV AH,00H
	INT 1AH
	ADD DX,1
	MOV BX,DX
regreso4:
	INT 1AH
	CMP DX,BX
	JNE regreso4
	DEC r
	CMP r,1
	JAE cicloc
	MOV AX,4C00H
	INT 21H
 inicio ENDP
 codigo ENDS
END inicio

