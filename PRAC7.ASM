;SUMAR DOS MATRICES 3X4 CADA DATO ES DE 2 BYTES Y ESTARA EN MEMORIA. ALMACENAR EL RESULTADO EN MEMORIA
DATOS SEGMENT PARA 'DATA'
	N  DB 03H			
	M  DB 04H			;Numero de elementos de matriz
	FIL DB 00H
	COL DB 00H
	M1 DW 0041H, 0042H, 0043H, 0044H		;Numeros de cada matriz
	M2 DW 000CH, 000BH, 000AH, 0009H
	M3 DW ?									;Matriz donde se guardaran resultados
DATOS ENDS

PILA SEGMENT PARA STACK
	DW	100 DUP(0)
PILA ENDS

CODIGO SEGMENT PARA 'CODE'
	ASSUME DS:DATOS, SS:PILA, CS:CODIGO, ES:NOTHING
	
	MAIN PROC FAR
		PUSH DS				;Procedimiento necesario para iniciar programa
		PUSH AX
		MOV AX,DATOS
		MOV DS,AX
		MOV ES,AX
		
		MOV AX,0000H			
		
		MOV CX,0002H		;Asignamos 2 espacios para dos bytes
		MOV CX 0002H		
		c1: MOV SI,0000H	;Indice en 0
			c2: ADD SI,COL	;Incrementamos indice en columnas
				ADD SI,FIL	;Incrementamos indice en filas
				MOV M1[SI],00H	;Se va almacenando resultados
				ADD COL,01H 
			LOOP c2
			ADD FIL,01H
		LOOP c1
		RET
	MAIN ENDP
CODIGO ENDS
	END MAIN