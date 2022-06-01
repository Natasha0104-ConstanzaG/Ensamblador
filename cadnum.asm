   page 60,132
 TITLE cadnum (exe)  Programa que convierte de numero a cadena
 pila SEGMENT PARA STACK 'Stack'
      DB 32 DUP (0)
 pila ENDS
 datos SEGMENT PARA 'Data'
    msj DB 'El numero es: $'
    suma DW  10000
    dmil DW 10000
    mil  DW 1000
    cien DW  100
    diez DW  10
    num DB 6 DUP (0)
 datos ENDS
 codigo SEGMENT PARA 'Code'
 inicio PROC FAR
      ASSUME  CS:codigo,DS:datos,SS:pila
      MOV  AX,datos
      MOV  DS,AX
      SUB  AX,AX
      
      MOV AX, 0600H
      MOV BH, 07H
      MOV CX, 0000H
      MOV DX, 184FH
      INT 10H 
       
     MOV AH, 02H
     MOV BH, 00H
     MOV DX, 0305H
     INT 10H
      
     MOV AH,09H
     LEA  DX,msj
     INT 21H

     LEA  BX,num
      MOV  AX,suma
      CMP  AX,dmil
      JB esmil
      SUB DX,DX
      DIV dmil 
      ADD  AL,48
      MOV  [BX],AL
      INC  BX
      MOV  AX,DX
      JMP  ETIQ1
esmil:  
      CMP  AX,mil
      JB   escien
ETIQ1: 
     SUB DX,DX
      DIV mil 
      ADD  AL,48
      MOV  [BX],AL
      INC  BX
      MOV  AX,DX
      JMP ETIQ2
escien:
     CMP AX,cien
     JB esdiez
ETIQ2:
      SUB DX,DX
      DIV cien
      ADD  AL,48
      MOV  [BX],AL
      INC  BX
      MOV  AX,DX
      JMP ETIQ
esdiez: 
     CMP AX,diez
     JB UNI
ETIQ:
      SUB DX,DX
      DIV diez
      ADD  AL,48
      MOV  [BX],AL
      INC  BX
      MOV  AX,DX
    
UNI: 
      ADD  AL,48
      MOV  [BX],AL
      INC  BX
      MOV  [BX],' $'
      MOV  AH,09H
      LEA  DX,num
      INT  21H
      MOV  AX,4C00H
      INT  21H
 inicio ENDP
 codigo ENDS
      END inicio