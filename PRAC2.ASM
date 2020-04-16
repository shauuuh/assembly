;DADAS DOS CADENAS EN MEMORIA, OBTENER UNA CADENA QUE CONTENGA LA INTERSECCION DE AMBAS CADENAS.
DATA SEGMENT PARA 'DATA'
        N DB ?
        CADENA1 DB 'SIMON$'									;Se asigna cadena 1
        CADENA2 DB 'LIMON$'									;Se asigna cadena 2 
        CADENA3 DB 13,10,'EL VECTOR INTERSECCION ES: $'		;Se asigna cadena para mandar a imprimir
        N1 DW ?												;Variable para mandar a imprimir la intersección
DATA ENDS
STACK SEGMENT STACK PARA 'STACK'
    DW 100 DUP(0)											;Asignacion de memoria en la pila
STACK ENDS

CODE SEGMENT 
    ASSUME CS:CODE,DS:DATA,SS:STACK							
    MAIN PROC FAR
        PUSH DS
		XOR AX, AX
		PUSH AX
		MOV AX, DATA
		MOV DS, AX
		MOV ES, AX
PROLOGO: MOV AH,09H											;Función de int21 para mandar a imprimir cadena 3
         LEA DX,cadena3										;Se carga la dirección de la cadena 3 en dx
         INT 21H

         MOV N,05H											;Se asigna un numero de repeticiones
         MOV N1,0005H  										;Se asigna un tamaño para numero de repeticiones
		 MOV SI,0FH											
         MOV CX,N
         MOV SI,0

        IMPRIMIR3: MOV AL,CADENA1[SI]						;Mueve a al caracter por caracter de la cadena 1
                   MOV DI,0										
        R: MOV BL,CADENA2[SI]								;En la parte baja de bx guarda el caracter de la cadena 2
           INC DI											
           CMP AL,BL										;Compara lo que tiene al y bl
           JE INTER											;Salta a 'inter' si son iguales
           JMP REG											;Salta a 'reg' si no son iguales
        REG: CMP DI,N1										;Compara para ver que no haya elementos repetidos
             JNE R											
             JMP SA 
        INTER: MOV DL,AL									;Mueve lo que se ha guardado en dl
               MOV AH,02H									;Funcion de int21 para salida del caracterdepositado en dl
               INT 21H 
               JMP REG
        SA: INC SI 
            LOOP IMPRIMIR3									;Realiza lo que tiene 'imprimir' hasta que se hay impreso la intersección
        
    RET
    MAIN ENDP 
CODE ENDS 
    END MAIN





