PAGE 60,132
TITLE rebotah (EXE) Programa rebota
pila SEGMENT PARA STACK 'Stack'
	DB 32 DUP (0)
pila ENDS
datos SEGMENT PARA 'Data'
	ren  DB 1
        col  DB 1
        car1 DB 'Hola Mundo$'
        car2 DB '          $'
        b1   DB 0
        b2   DB 0
        boton DW 0
datos ENDS
codigo SEGMENT PARA 'code'
 inicio PROC FAR
        ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
        MOV AX,datos
        MOV DS,AX
        MOV ES,AX  
        CALL borra
        CALL raton
        CALL rebote
        CALL termina
 inicio ENDP

borra PROC NEAR 
    MOV AX,0600H
    MOV BH,07H
    MOV CX,0000H
    MOV DX,184FH
    INT 10H
    RET
borra ENDP

raton PROC NEAR
     MOV AX,0000H
     INT 33H
     MOV AX,0001H
     INT 33H
     RET
raton ENDP

ciclo PROC NEAR
     MOV AH,02H
     MOV BH,00H
     MOV DH,ren
     MOV DL,col
     INT 10H
     RET
ciclo ENDP
imprime PROC NEAR
    MOV AH,09H
    INT 21H
    RET
imprime ENDP

pausa PROC NEAR
      MOV AH,00H
      INT 1AH
      ADD DX,1
      MOV BX,DX
pausar:
      INT 1AH
      CMP DX,BX
      JBE pausar
      RET
pausa ENDP

checacol PROC NEAR
        CMP b1,01H
        JE Otra
        INC col
        CMP col,69
        JB Et2
        MOV b1,01H
Otra:
        DEC col
        CMP col,01H
        JA Et2
        MOV b1,00H
Et2:
      RET
checacol ENDP

checaren PROC NEAR
        CMP b2,01H
        JE Otra1
        INC ren
        CMP ren,23
        JB Et3
        MOV b2,01H
Otra1:
        DEC ren
        CMP ren,01H
        JA Et3
        MOV b2,00H
Et3:
       RET
checaren ENDP

leeboton PROC NEAR
        MOV AX,03H
        INT 33H
     MOV boton,BX
     RET
leeboton ENDP

rebote PROC NEAR
ET1:
    CALL ciclo
    LEA DX,car1
    CALL imprime
    CALL pausa
    CALL ciclo
     LEA DX,car2
     CALL imprime
        
     CALL checacol
     CALL checaren
     CALL leeboton
     CMP boton,01H
     JNE Et1
      RET
rebote ENDP

termina PROC NEAR
      MOV AX,4C00H
      INT 21H
   RET
termina ENDP
 codigo ENDS
END inicio