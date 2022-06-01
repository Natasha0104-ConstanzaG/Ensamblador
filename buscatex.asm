PAGE 60,132
TITLE buscatex (EXE) Programa que lee textos y busca el caracter
pila SEGMENT PARA STACK 'Stack'
	DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
                msj1 DB 'Introduce un  Texto: $'
                msj2 DB 'Introduce un caracter: $'
                msj3 DB ' El caracter EXISTE $'
                msj4 DB ' El caracter NO EXISTE $'
	dato1 LABEL BYTE
	  max1 DB 21
	  real1 DB ? 
	  cad1 DB 21 DUP (0)
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
      LEA DX,dato1
      INT 21H
       MOV AH,02H
      MOV BH,00H
      MOV DX,0405H
      INT 10H
      MOV AH,09H
      LEA DX,msj2
      INT 21H
      MOV AH,01H
      INT 21H
      MOV AH,02H
      MOV BH,00H
      MOV DX,0605H
      INT 10H
      CLD
      LEA DI,cad1
      SUB CX,CX
      MOV CL,real1
      ;REPNE SCASB
ciclo:
      CMP AL,[DI]
      JE igual
      INC DI
      LOOP ciclo
      MOV AH,09H
      LEA DX,msj4
      INT 21H
      JMP fin

igual:
      MOV AH,09H
      LEA DX,msj3
      INT 21H

fin:
      MOV AX,4C00H
      INT 21H

inicio ENDP
codigo ENDS
END inicio