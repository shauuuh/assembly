;Crear su propio código de caracteres, de esta manera cuando el usuario teclee un carácter
;se escribirá en pantalla el que corresponda según su código creado. Es decir, si el usuario
;teclea ‘a’ que en su lugar aparezca ‘x’ por ejemplo.

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

		INICIO:
		CALL LEER_C
		CMP AL, 27H
		JE FIN
		ADD AL, 02H
		CALL IMP_C
		JMP INICIO
		FIN:
		MOV AX, 4C00H
		INT 21H

	MAIN ENDP

	LEER_C PROC
		MOV AH, 00H
		INT 16H
		RET
	LEER_C ENDP 

	IMP_C PROC
		PUSH AX
		PUSH DX
		MOV DL, AL
		MOV AH, 02H
		INT 21H
		;CALL INC_COL
		POP DX
		POP AX
		RET
	IMP_C ENDP

	INC_COL PROC
		PUSH AX
        PUSH DX
        MOV AH, 03H
        INT 10H
        MOV AH, 02H
        INC DL
        INT 10H
        POP DX
        POP AX
        RET
	INC_COL ENDP

CODIGO ENDS
END MAIN
;---

		;MOV AH,  ;
		;APPENDS CAD_3 AH, TAM_CAD_3
		;MOV AH, 48H
		;APPENDS CAD_3 AH, TAM_CAD_3
		;MOV AH, 41H
		;APPENDS CAD_3 AH, TAM_CAD_3