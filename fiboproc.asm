PAGE  60,132
TITLE fiboproc (EXE) Programa que imprime serie fibonaci con procedimientos
pila SEGMENT PARA STACK 'Stack'
   DB 32 DUP (' ')
pila ENDS
datos SEGMENT PARA 'Data'
    pide  DB 'Introduce numero: $'
    msj    DB 'La serie fibonacci es: $'
    suma   DW 0
    valor  DW 0
    aux    DW 0
    a      DW 0
    b      DW 1
    c      DW 0
    result DB 6 DUP (' ')
    DMIL   DW 10000
    MIL    DW 1000
    CIEN   DW 100
    DIEZ   DW 10
    entra  LABEL BYTE
    max    DB 6
    real   DB ?
    cad    DB 6 DUP (0)
datos ENDS
codigo SEGMENT PARA 'Code'
inicio PROC FAR
 ASSUME CS:codigo,SS:pila,DS:datos,ES:datos
    MOV AX,datos
    MOV DS,AX
    MOV ES,AX
    CALL borrar
    MOV DX,0505H
    CALL cursor
    LEA DX,pide
    CALL muestra
    LEA DX,entra
    CALL leer
    MOV DX,0705H
    CALL cursor
    LEA DX,msj
    CALL muestra
    CMP real,0
    JE vacia
    CALL anumero
vacia:
    SUB AX,AX
    CMP suma,0
    JBE sigue
    MOV AX,1
    CMP suma,1
    JE sigue
    ;CALL fibona
    CALL acadena
    LEA DX,result
    CALL muestra
    CALL fibona
sigue:
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
muestra PROC NEAR
    MOV AH,09H
    INT 21H
    RET
muestra ENDP
leer PROC NEAR
    MOV AH,0AH
    INT 21H
    RET
leer ENDP
anumero PROC NEAR
    SUB CX,CX
    MOV CL,real
    LEA BX,cad
cambia:
    MOV AH,00H
    MOV AL,[BX]
    SUB AL,48
    MOV valor,AX
    MOV AX,01
    MOV aux,CX
    DEC aux
    JZ numero
pot:
    MUL DIEZ
    DEC aux
    JNZ pot
numero:
    MUL valor
    ADD suma,AX
    INC BX
    LOOP cambia
    RET
anumero ENDP
acadena PROC NEAR
    LEA BX,result
    CMP AX,DMIL
    JB um
    SUB DX,DX 
    DIV DMIL
    ADD AL,48
    MOV [BX],AL
    INC BX
    MOV AX,DX
    JMP unm
um:
    CMP AX,MIL
    JB uc
unm:
    SUB DX,DX
    DIV MIL
    ADD AL,48
    MOV [BX],AL
    INC BX
    MOV AX,DX
    JMP unc
uc:
    CMP AX,CIEN
    JB ud
unc:
    SUB DX,DX
    DIV CIEN
    ADD AL,48
    MOV [BX],AL
    INC BX
    MOV AX,DX
    JMP und
ud:
    CMP AX,DIEZ
    JB un
und:
    SUB DX,DX
    DIV DIEZ
    ADD AL,48
    MOV [BX],AL
    INC BX
    MOV AX,DX
un:
    ADD AL,48
    MOV [BX],AL
    INC BX
    MOV [BX],' '
    INC BX
    MOV [BX],'$'
    RET
acadena ENDP
fibona PROC NEAR
    MOV CX,suma
    DEC CX
fibo:
    MOV AX,b
    ADD AX,a
    MOV BX,b
    MOV a,BX
    MOV b,AX 
    CALL acadena
    LEA DX,result
    CALL muestra
    LOOP fibo
    RET
fibona ENDP
END inicio