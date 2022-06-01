    PAGE 60,132
 TITLE sumados  (EXE) Programa que realiza una suma de 2 numeros
 pila SEGMENT PARA STACK 'Stack'
      DB 32 DUP (' ')
 pila ENDS
 datos SEGMENT PARA 'Data'
   TECLA LABEL BYTE
     max  DB 6
     real DB ?
     cad  DB 6 DUP (' ')
     pide DB '> Introduce un numero:  $'
     msj  DB '> Resultado = $'
     msj2 DB '> No es numero$'
     suma   DW  0
     resul    DW  0
     aux      DW  0
     dm       DW  10000
     m         DW  1000
     cien     DW  100
     diez     DW  10
     ban      DB  ?
     tem      DW  0
     result   DB  6 DUP (0)
 datos ENDS
 codigo SEGMENT PARA 'Code'
 inicio PROC FAR
    ASSUME CS:codigo,DS:datos,SS:pila,ES:datos
    MOV AX,datos
    MOV DS,AX
    MOV ES,AX
    CALL borrar
    MOV DX,0305H
    CALL cursor
    LEA DX,pide
    CALL imprime
    LEA DX,TECLA
    CALL leer
    CALL esnum
    CMP ban,1
    JNE Et1
    CALL cadnum 
    MOV AX,suma
    MOV tem,AX
    MOV DX,0505H
    CALL cursor
    LEA DX,pide
    CALL imprime
    LEA DX,TECLA
    CALL leer
    CALL esnum
    CMP ban,1
    JNE Et1
    MOV suma,0
    CALL cadnum 
    MOV AX,tem
    ADD AX,suma
    JMP numero
   Et1:   
    MOV DX,0705H
    CALL cursor  
    LEA DX,msj2
    CALL imprime
    JMP fin
   numero:
    CALL numcad
    MOV DX,0705H
    CALL cursor
    LEA  DX,msj
    CALL imprime
    LEA  DX,result
    CALL imprime
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
 imprime PROC NEAR
    MOV AH,09H
    INT 21H
    RET
 imprime ENDP
 leer  PROC NEAR
    MOV AH,0AH
    INT 21H
    RET
 leer  ENDP
 esnum PROC NEAR
    SUB CX,CX
    MOV CL,real
    LEA BX,cad
   Cam:
    MOV AH,[BX]
    CMP AH,48
    JB noes
    CMP AH,57
    JA noes
    INC BX
    LOOP Cam
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
   CON: 
    MOV  AH,00H
    MOV  AL,[BX]
    SUB  AL,48
    MOV  resul,AX
    MOV  AX,01
    MOV  aux,CX
    DEC  aux
    JZ NUM
 POT: 
    MUL  diez
    DEC  aux
    JNZ  POT
 NUM: 
    MUL  resul
    ADD  suma,AX
    INC  BX
    LOOP CON
    RET
 cadnum ENDP
 numcad PROC NEAR
    LEA  BX,result
    CMP  AX,dm
    JB   MIL
    DIV  dm
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  AX,DX
    MOV  DX,0
    JMP  ETQ1
MIL:  CMP  AX,m
    JB   CENT
ETQ1: DIV  m
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  AX,DX
    MOV  DX,0
    JMP  ETQ2
CENT: CMP  AX,cien
    JB   DES
ETQ2: DIV  cien
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  AX,DX
    MOV  DX,0
    JMP  ETIQ
DES:  CMP  AX,diez
    JB   UNI
ETIQ: DIV  diez
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  AX,DX
UNI:  ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  [BX],'$'
    RET
 numcad ENDP
 codigo ENDS
    END inicio
