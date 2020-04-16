;Obtener el promedio de n números que están en memoria, el resultado deberá quedar en ax.

datos segment para 'data'
  n dw 0005h					
  num db 01h,01h,01h,01h,41h	;Asignacion de numeros
datos ends

pila segment para stack
  dw 100 dup(0)					;Asignacion de memoria al segmento de pila
pila ends

codigo segment para 'code'
   assume ds:datos,ss:pila,cs:codigo,es:nothing

   main proc far				;Procedimiento necesario del programa
       push ds
       push ax
       mov ax,datos
       mov ds,ax
       mov es,ax

       mov dl,00				;Inicializamos registro en 0
       mov si,0					;Indice en 0
       mov cx,n					;movemos a cx tamaño de variable
ciclo: add dl,num[si]			;en dl se guarda elemento de variable num
       inc si
       loop ciclo				;se repite hasta ultimo elemento 

       mov ah,02h				;se manda a imprimir resultado
       int 21h
       ret
     main endp
   codigo ends
     end main
