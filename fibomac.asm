PAGE  60,132
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
muestra MACRO str
    MOV AH,09H
    LEA DX,str
    INT 21H
ENDM
leer MACRO nmr
    MOV AH,0AH
    LEA DX,nmr
    INT 21H
ENDM
anumero MACRO real1,cad1,suma1
    LOCAL cambia,pot,numero
    SUB CX,CX
    MOV CL,real1
    LEA BX,cad1
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
    MUL diez
    DEC aux
    JNZ pot
numero:
    MUL valor
    ADD suma1,AX
    INC BX
    LOOP cambia
ENDM
acadena MACRO num1,result1
    LOCAL um,ciclo
    LEA BX,result1
ciclo:
    MOV AX,num1
    CMP AX,dmil
    JB um
    SUB DX,DX 
    DIV dmil
    ADD AL,48
    MOV [BX],AL
    INC BX
    MOV num1,DX
    ;JMP unm
um:
    SUB DX,DX
    MOV AX,dmil
    DIV diez
    MOV dmil,AX
    CMP dmil,10
    JAE ciclo
    ADD AL,48
    MOV [BX],AL
    ;INC BX
    MOV [BX],' '
    INC BX
    MOV [BX],'$'
ENDM
TITLE fibomac (EXE) Programa que imprime serie fibonaci con macros
pila SEGMENT PARA STACK 'Stack'
   DB 32 DUP (' ')
pila ENDS
datos SEGMENT PARA 'Data'
    pide   DB 'Introduce numero: $'
    msj    DB 'La serie fibonacci es: $'
    suma   DW 0
    valor  DW 0
    aux    DW 0
    a      DW 0
    b      DW 1
    c      DW 0
    result DB 6 DUP (' ')
    dmil   DW 10000
    mil    DW 1000
    cien   DW 100
    diez   DW 10
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
    borrar
    cursor 05H,05H
    muestra pide
    leer entra
    cursor 05H,07H
    muestra msj
    CMP real,0
    JE vacia
    anumero real,cad,suma
vacia:
    ;SUB AX,AX
    CMP suma,0
    JBE sigue
    MOV AX,1
    CMP suma,1
    JE sigue
    acadena b,result
    JMP imprime
sigue:
    JMP siguiente
imprime:
    muestra result
    CALL fibona
siguente:
    MOV AX,4C00H
    INT 21H
fibona PROC NEAR
    MOV CX,suma
    DEC CX
fibo:
    MOV AX,a
    ADD AX,b
    MOV BX,b
    MOV a,BX
    MOV b,AX 
    JMP fibo2
fibo1:
    JMP fibo
fibo2:
    acadena b,result
    muestra result
    LOOP fibo1
    RET
fibona ENDP
inicio ENDP
codigo ENDS
END inicio