;Comparar dos cadenas que están en memoria.
DATOS SEGMENT PARA 'DATA'
    N DW 0ah
    MSJ1 DB 'CADENA 1: $		;Mensajes a imprimir
    MSJ2 DB 'CADENA 2: $'
    IG DB 'LAS CADENAS SON IGUALES.$'
    DIF DB 'LAS CADENAS SON DIFERENTES.$'
    CAD DB 20 DUP(' '),'$'		;Variables Para pedir cadenas a comparar
    CAD2 DB 20 DUP(' '),'$'
DATOS ENDS   

PILA SEGMENT PARA STACK 
  DW 100 DUP(0)
PILA ENDS

CODIGO SEGMENT PARA 'CODE'
  ASSUME CS:CODIGO,DS:DATOS,SS:PILA,ES:NOTHING
  MAIN PROC far
    PUSH DS					;Procedimiento para iniciar programa
		XOR AX, AX
		PUSH AX
		MOV AX, DATOS
		MOV DS, AX
		MOV ES, AX
		
		MOV SI,0			;Indice en 0
		MOV CX,N

INICIO: LEA DX,MSJ1			;Cargamos direccion de variable 
        MOV AH,09H			;Mandamos a imprmir
        INT 21H

        LEA SI,CAD			;Cargamos direccion de variable para mandarla apedir

        INGRESA1: MOV AH,01h		;Se manda a pedir cadena 1
                  INT 21h
                  MOV [SI],AL
                  INC SI
                  CMP AL,0DH ;PIDE CADENA HASTA QUE ENCUENTRE UN ENTER
                  JA INGRESA1
                  JB INGRESA1

      LEA DX,MSJ2				;Se manda a imprimir mensaje 2
      MOV AH,09H
      INT 21H 

      LEA SI,CAD2				;Cargamos direccion de cadena 2

        INGRESA2: MOV AH,01h	;Ingresar cadena 2
                  INT 21h
                  MOV [SI],AL
                  INC SI
                  CMP AL,0DH 
                  JA INGRESA2
                  JB INGRESA2
	    MOV CX,50
      MOV AX,DS
      MOV ES,AX

COMPARAR: LEA SI,CAD		;Cargamos dirección de ambas cadenas
          LEA DI,CAD2
          REPE CMPSB		;Comparamos cadenas
          JNE DIFERENTE		;Salto a cada etiqueta para mandar mensaje
          JE IGUAL

          IGUAL: LEA DX,IG	;Imprime mensaje de que son iguales
                MOV AH,09H
                INT 21H
                JMP FIN

          DIFERENTE: LEA DX,DIF		;Imprime cadena de que son diferentes
                    MOV AH,09H
                    INT 21H
                    JMP FIN

      FIN:RET

MAIN ENDP

CODIGO ENDS
  END MAIN

