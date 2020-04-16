 ;Programa que limpia pantalla y muestra una rejilla, en ella solo se puede
;utilizar fecha arriba, imprimiendo un asterisco
DATOS SEGMENT PARA 'DATA'
  REN     DB      10
  COL     DB      10
  RESTO    DB    '__________________________','$'
  RESTO0   DB    '|    |    |    |    |    |','$'
  RESTO1   DB    '|    |    |    |    |    |','$'
  resto2   DB    '|____|____|____|____|____|','$'
                
DATOS ENDS

PILA SEGMENT PARA STACK 'STACK'
  DW      100     DUP(0)
PILA ENDS

CODIGO SEGMENT PARA 'CODE'
  ASSUME  CS:CODIGO, DS:DATOS, SS:PILA, ES:NOTHING

  LIMPIA_PANTALLA PROC NEAR
     MOV AX, 0600H
     MOV BH, 07H     ; 71H Fondo=blanco frente=AZUL, 07 Fo=negro Fr=blanco
     MOV CX, 0000H   ; 35h  Fo=cian  fr=lila?  26h fo=verde fr=amarillo
     MOV DX, 184FH
     INT 10H
     RET
  LIMPIA_PANTALLA ENDP

  POSICIONA_CURSOR PROC NEAR
     MOV DH,REN
     MOV DL,COL
     MOV AH,02
     MOV BH,00
     INT 10H
     RET
  POSICIONA_CURSOR ENDP

  LEE_SIN_ECO PROC NEAR
     MOV AH,10H
     INT 16H
     RET
  LEE_SIN_ECO ENDP

  ESCRIBE_AST PROC NEAR
     MOV DL,'*'
     MOV AH,02
     INT 21H
     RET
  ESCRIBE_AST ENDP

  FLECHA_ARRIBA PROC NEAR
            ;  ARRI 48, ABAJO 50, DER 4D, IZQ 4B, ESC 01 1B 
     CALL ESCRIBE_AST
     CMP REN,5
     JNE FIN1
     MOV REN,17
     JMP POSI
 FIN1:
     SUB REN,3
 POSI:CALL POSICIONA_CURSOR
     RET
  FLECHA_ARRIBA ENDP

  FLECHA_ABAJO PROC NEAR
     RET
  FLECHA_ABAJO ENDP

  LETRERO  PROC NEAR
     MOV AH,09
     INT 21H
     RET
  LETRERO ENDP

  REJILLA PROC NEAR
     mov col, 5
     mov ren, 3
     CALL POSICIONA_CURSOR
     LEA DX,resto
     CALL LETRERO
     MOV CX,5
  CC1:MOV COL,5
     INC REN
     CALL POSICIONA_CURSOR
     LEA DX,RESTO0
     CALL LETRERO
     INC REN
     CALL POSICIONA_CURSOR
     LEA DX,resto1
     CALL LETRERO
     INC REN
     CALL POSICIONA_CURSOR
     LEA DX,resto2
     CALL LETRERO
     LOOP CC1
     RET
   REJILLA ENDP

  PRINCIPAL PROC FAR
     PUSH DS
     XOR AX, AX
     PUSH AX
     MOV AX, DATOS
     MOV DS, AX
     MOV ES, AX
     CALL LIMPIA_PANTALLA
     CALL REJILLA
     MOV REN,5
     MOV COL,7
     CALL POSICIONA_CURSOR
 CICLO:
     CALL LEE_SIN_ECO
     CMP AL,00
     JE SIGCOMP
     CMP AL,0E0H
     JE SIGCOMP
     CMP AL,1BH  ;CODIGO PARA EL 'ESC'
     JE SIG2
     JMP CICLO
SIGCOMP:
     CMP AH,48H
     JNE SIG
     CALL FLECHA_ARRIBA
     JMP CICLO
 SIG:CMP AH,50H
     JNE SIG2
     CALL FLECHA_ABAJO
     JMP CICLO
SIG2:CMP AH,01
     JNE CICLO
FIN: RET
  PRINCIPAL ENDP

CODIGO ENDS
  END PRINCIPAL
