PAGE 60,132
TITLE comptex (EXE) Programa que lee dos textos e indica si son iguales o no
pila SEGMENT PARA STACK 'Stack'
	DB 32 DUP ('0')
pila ENDS
datos SEGMENT PARA 'Data'
	msj1 DB 'Introduce Texto 1: $'
	msj2 DB 'Introduce Texto 2: $'
                msj3 DB ' El Texto es IGUAL a $'
                msj4 DB ' El Texto es DIFERENTE a $'
	dato1 LABEL BYTE
	 max1 DB 21
	 real1 DB ? 
	 cad1 DB 21 DUP (0)
                dato2 LABEL BYTE
	 max2 DB 21
	 real2 DB ? 
	 cad2 DB 21 DUP (0)
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
      MOV AH,0AH
      LEA DX,dato2
      INT 21H
      MOV AH,02H
      MOV BH,00H
      MOV DX,605H
      INT 10H
      SUB BX,BX
      MOV BL,real1
      MOV cad1[BX],'$'
      MOV BL,real2
      MOV cad2[BX],'$'
      CLD
      LEA SI,cad1
      LEA DI,cad2
      SUB CX,CX
      MOV CL,real1
      CMP CL,real2
      JAE mayor
      MOV CL,real2

mayor:
      ;REPE CMPSB

ciclo:
      MOV AL,[SI]
      ;MOV BL,[DI]
      CMP AL,[DI]
       JNE diferente
       INC SI
       INC DI
       LOOP ciclo

diferente:
      ;CMP CX,0
      JCXZ igual
      MOV AH,09H
      LEA DX,cad1
      INT 21H
      MOV AH,09H
      LEA DX,msj4
      INT 21H
      MOV AH,09H
      LEA DX,cad2
      INT 21H
      JMP fin

igual:
      MOV AH,09H
      LEA DX,cad1
      INT 21H
      MOV AH,09H
      LEA DX,msj3
      INT 21H
      MOV AH,09H
      LEA DX,cad2
      INT 21H

fin:
      MOV AX,4C00H
      INT 21H

inicio ENDP
codigo ENDS
END inicio