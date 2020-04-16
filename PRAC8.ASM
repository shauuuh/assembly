;Leer caracteres de memoria cuyo límites es ‘.’ y almacenar en memoria solo palabras que
;contengan símbolos de la ‘a’ a la ‘z’ y de la ‘A’ a la ‘Z’. Se considera una palabra a aquel
;conjunto de caracteres limitados por el espacio o las direcciones inicial y final.

											;DECLARACION DE LA PILA
PILA SEGMENT PARA STACK 'STACK'
	DW 64 DUP(0)
PILA ENDS

APPENDS MACRO CAD, CHAR, TAM
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        LEA BX, CAD
        MOV DH, 00H
        MOV DL, TAM
        ADD BX, DX
        MOV BYTE PTR [BX], CHAR
        INC DX
        MOV TAM, DL
        POP DX
        POP CX
        POP BX
        POP AX
ENDM

													;DECLARACION DE VARIABLES
DATOS SEGMENT PARA 'DATA'
	CAD_INICIAL DB 'hoLi54##s)=h-{A}{u.','$'	    ;Cadena a evaluar
	MSG_INICIAL DB 'Cadena inicial: ','$' 
	MSG_FINAL DB '   Cadena final: ','$'
	TAM_CAD_1 DB 13H								;Tamaño de la cadena inicial a comparar
	CAD_FINAL DB '$$$$$$$$$$$$$$$$$$$$$$','$'		;cadena donde almacenara los caracteres x : x e [A, Z]U[a, z] xd
	TAM_CAD_2 DB 00H								;Varieble que ira guardado el tamaño de la cadena
DATOS ENDS

;CODIGO DEL PROGRAMA
CODIGO SEGMENT PARA 'CODE'
	
	;PROCEDIMIENTO PRINCIPAL
	MAIN PROC FAR 
		ASSUME CS:CODIGO, DS:DATOS, SS:PILA

		;--------------------
		PUSH DS
		XOR AX, AX				;CODIGO NECESARIO PARA QUE EL PROGRAMA SE
		MOV AX, DATOS			;INICIALICE DE MANERA CORREECTA, LIMPIA LOS
		MOV DS, AX				;REGISTROS Y PREPARA TODO.
		MOV ES, AX
		;--------------------

		LEA SI, CAD_INICIAL			;Asignamos al registro la direccion de la cadena a evaluar
		INCIO:						;etiqueta cool para el ciclo 
		MOV AH, [SI]				;Asignamos a ah el caracter de la posicion de si
		CMP AH, 2EH					; comparamos en el punto
		JE FIN						;si es igual saltamos a fin
		CALL COMP_MAYUS				;sino llamamos al procedimiento de comparar las mayusculas
		CALL COMP_MINUS				; y posterior al de comparar minusculas
		INC SI						; incrementamos el valor de si
		JMP INCIO					; y hacemos un cilco a incio. IMPORTANTE tener un punto en la cadena a evaluar o se ciclara.
		FIN:
									;Etiqueta de fin donde imprimimos los mensajes y las cadenas respectivas.
		LEA DX, MSG_INICIAL
		MOV AH, 09H
		INT 21H

		LEA DX, CAD_INICIAL
		MOV AH, 09H
		INT 21H

		LEA DX, MSG_FINAL
		MOV AH, 09H
		INT 21H

		LEA DX, CAD_FINAL
		MOV AH, 09H
		INT 21H

									;interupcion para finalizar el programa bien uwu
		MOV AX, 4C00H
		INT 21H

	MAIN ENDP

	COMP_MAYUS PROC				; procedimiento que compara si un caracter esta entre A y Z
		CMP AH, 41H				;Comparamos el caracter con A
		JL FIN_CMP_MAY			; si es menos salta al fin de la comparacion
		CMP AH, 5AH				; si no compara el caracter con Z
		JG FIN_CMP_MAY			; si es mayor salta al fin de la comparacion
		APPENDS CAD_FINAL, AH, TAM_CAD_2 ; si no concatena el caracter con la cadena final
		FIN_CMP_MAY:
		RET
	COMP_MAYUS ENDP

	COMP_MINUS PROC				; procedimiento que compara si un caracter esta entre a y z
		CMP AH, 51H				;Comparamos el caracter con a
		JL FIN_CMP_MIN			; si es menos salta al fin de la comparacion
		CMP AH, 7AH				; si no compara el caracter con z
		JG FIN_CMP_MIN			; si es mayor salta al fin de la comparacion
		APPENDS CAD_FINAL, AH, TAM_CAD_2 ; si no concatena el caracter con la cadena final
		FIN_CMP_MIN:
		RET
	COMP_MINUS ENDP

CODIGO ENDS
END MAIN
;FIN DEL CODIGO