PAGE 60,132
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
 imprime MACRO str
    MOV AH,09H
    LEA DX,str
    INT 21H
    ENDM
 leer  MACRO dato
    MOV AH,0AH
    LEA DX,dato
    INT 21H
    ENDM
 esnum MACRO
    LOCAL cam,noes,sies
    SUB CX,CX
    MOV CL,real
    LEA BX,cad
   cam:
    MOV AH,[BX]
    CMP AH,48
    JB noes
    CMP AH,57
    JA noes
    INC BX
    LOOP cam
    MOV ban,1
    JMP sies
   noes:
    MOV ban,0
    sies:
    ENDM
 cadnum MACRO
    LOCAL CON,POT,NUM
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
    ENDM
 numcad MACRO
    LOCAL MIL,ETQ1,CENT,ETQ2,DES,ETIQ,UNI
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
MIL:
    CMP  AX,m
    JB   CENT
ETQ1: 
    DIV  m
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  AX,DX
    MOV  DX,0
    JMP  ETQ2
CENT: 
    CMP  AX,cien
    JB   DES
ETQ2: 
    DIV  cien
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  AX,DX
    MOV  DX,0
    JMP  ETIQ
DES:  
    CMP  AX,diez
    JB   UNI
ETIQ:
    DIV  diez
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  AX,DX
UNI:  
    ADD  AL,48
    MOV  [BX],AL
    INC  BX
    MOV  [BX],'$'
    ENDM
 TITLE sumadosm  (EXE) Programa que realiza una suma de 2 numeros
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
     resul  DW  0
     aux    DW  0
     dm     DW  10000
     m      DW  1000
     cien   DW  100
     diez   DW  10
     ban    DB  ?
     tem    DW  0
     result DB  6 DUP (0)
 datos ENDS
 codigo SEGMENT PARA 'Code'
 inicio PROC FAR
    ASSUME CS:codigo,DS:datos,SS:pila,ES:datos
    MOV AX,datos
    MOV DS,AX
    MOV ES,AX
    borrar
    cursor 05H,03H
    imprime pide
    leer TECLA
    esnum
    CMP ban,1
    JNE Et1
    cadnum 
    MOV AX,suma
    MOV tem,AX
    cursor 05H,05H
    imprime pide
    leer TECLA
    JMP seguir
   Et1:   
    JMP Etq1x
   seguir:
    esnum
    CMP ban,1
    JNE Etq1x
    MOV suma,0 
    cadnum
    MOV AX,tem
    ADD AX,suma
    JMP numero
   Etq1x:
    cursor 05H,07H  
    imprime msj2
    JMP fin
   numero:
    numcad
    cursor 05H,07H
    imprime msj
    LEA  DX,result
    imprime result
   fin:
    MOV AX,4C00H
    INT 21H
 inicio ENDP
 codigo ENDS
    END inicio
