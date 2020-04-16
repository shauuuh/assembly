;Leer caracteres de la memoria, si es ‘@’ borrar el último elemento leído, si es ‘+’ borrar la
;última palabra leída (una palabra estará delimitada por la dirección inicial, por la dirección
;final o por el espacio), si ‘*’ borrar todo el texto insertado hasta el momento, si es ‘.’
;terminar el proceso y desplegar el contenido (en memoria).

comprobar:/100
	
  mov cl,0
	
  cmp dx,bx
	
/104  jle fin
1/108	
  mov cl,1
fin1:
/108	
  ret 

borrar:
/109	
  call comprobar
/100	
  cmp cl,0
	
/10f  jne final/123

  mov al,7f	
  mov [bx],al
final:/115	
	
  ret
 		

Principal:
/116	
  mov si,200

  mov dx,200
inicio:/11c	
	
  mov al,[si]
	
  cmp al,40
'@'	 
/120  jne 
/12a	
/122  call decre/178
/125  call borrar
/109	 
/128  jmp incremento
/174
et1:
/12a	
  cmp al,2b'+'
	
/12c  jne et2
/146	
  push si 

compara:/12f
  dec si
  mov al,[si]	
	
  cmp al,20' '
	
/134  je desempilar
/143
cmp si,199
/13a  je desempilar/143	
  mov bx,si
	
/13e  call borrar/
109
/141  jmp compara
/12f
desempilar:
/143	
  pop si
	
/144  jmp incremento/174	

et2:
/146	
  cmp al,2a
'*'	
/148  jne et3/15a
	
  push si

menor:/14b	
	
  cmp  si,200
	
/14f  jl desempilar
/143	
/151  call decre/178
/154  call borrar
/109	
  dec si
	
/158  jmp menor/14b

et3:
/15a	
  cmp al,2e
'.'	
/15c  jne incremento
/174	
  mov si,200
	
  mov bx,300

sig:/164
  mov al,[si]
  cmp al,7f''
/168  je siguiente/171
  cmp al,2e'.'
/16c  je fintodo/177
  mov [bx],al
  inc bx
siguiente:/171	
	
  inc si
	
/172  jmp sig/164
incremento:
/174	
  inc si
	
/175  jmp inicio/11c
fintodo:
 /177	
  nop
decre:/178
  mov di,si
  dec di
  mov bx,di
/17d  ret			