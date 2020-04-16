;SUMAR NUMEROS POSITIVOS DE 16 BITS QUE SE ENCUENTRAN EN MEMORIA, CUANDO APAREZCA '0' TERMINAR EL PROCESO
DATOS SEGMENT PARA 'DATOS'
	NUM DW 0041H, 0001H, 0002H, 0000H
	RES DW ?
DATOS ENDS

PILA SEGMENT PARA ACK
PILA ENDS

CODIGO SEGMENT PARA 'DATA'
	ASSUME DS:DATOS, SS:PILA, CS:CODIGO
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,DATOS
		MOV DS,AX
		
		MOV SI,0			;Indice en 0
		
CICLO:  MOV AX,NUM[SI]		;Movemos primer elemento de num
		CMP AX,0000H		;Verficacion de que sea diferente a 0 y salta a fin si es igual
		JE FIN
		MOV AX,NUM[SI]		;Vamos sumando elemento en nuestra variable	
		MOV AX,NUM[SI]
		MOV BX,7FFFH		
		CMP AX,BX			
		AND AX,AX			;Verficacion de bits de numeros
		JGE V
		ADD SI,0002			
		JMP CICLO
	  V:ADD RES,AX			;Se añade en variable lo que haya en ax
		ADD SI,0002			
		JMP CICLO		
	FIN:MOV DX,RES			;Finaliza imprimiendo el resultado que se encuentra en variable res
		MOV AH,02H	
		INT 21H
		RET
	MAIN ENDP
CODIGO ENDS
	END MAIN