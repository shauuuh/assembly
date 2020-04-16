;Dadas dos cadenas en memoria, obtener una cadena que contenga la unión de las cadenas de entrada pero sin elementos repetidos.
<DATOS SEGMENT PARA 'DATA'
    N DW 0ah					;Variable para reservar datos de cadenas de caracteres(16 bits).
    CAD1 DB 'SHAU.$'			;Guarda una cadena y al final se coloca $. 		
    CAD2 DB 'HOLA.$'
    ;CAD3 DB '$$$$$$$$','$'		;Cadena donde se coloca la union de ambas cadenas.
    CAD3 DB 10 DUP(?)			;Se reserva el numero de repeticiones en la variable.
DATOS ENDS   

PILA SEGMENT PARA STACK 
  DW 100 DUP(0)					;Asignación en la pila
PILA ENDS

CODIGO SEGMENT PARA 'CODE'
  ASSUME CS:CODIGO,DS:DATOS,SS:PILA,ES:NOTHING
  MAIN PROC far
    PUSH DS						
		XOR AX, AX				
		PUSH AX
		MOV AX, DATOS		
		MOV DS, AX
		MOV ES, AX

    MOV SI,0					;Se asigna 0 en registro si para el indice
	  MOV CX,N					

    LEA SI,CAD1					;Carga la dirección de la cadena 1 en el registro si
    LEA DI,CAD3					;Carga la dirección de la cadena 3 en el regustro di

    COPIAR: CMP SI,DI			;Compara lo que tiene si con di
            JNE CONC			;Salta a etiqueta 'conc' (donde va guardando la union) si no es igual.
            INC SI				;Incrementa si para avanzar al siguiente caracter
            INC DI				;Incrementa di
            CMP AL,24H			;24H es '$' para ver si ya ha llegado al fin de cadena
            JE IMPRIMIR			;Si ya ha llegado al fin se va a etiqueta 'imprimir'
            JA COPIAR			;Si no ha llegado al fin de cadena vuelve a regresar al inicio de copiar
            JB COPIAR
    CONC: MOV AL,[SI]			;Se guardan los caracteres que forman la union en el registro di
          MOV [DI],AL

    IMPRIMIR: LEA DX,CAD3		;Carga en dx la dirección de la cadena 3
              MOV AH,09H		;Función de int21 para imprimir una cadena
              INT 21H

            MOV AX, 4C00H		;Función de int21 para finalizar
		        INT 21H
            RET 

  MAIN ENDP

CODIGO ENDS
  END MAIN

