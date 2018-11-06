.386 
.model flat, stdcall
.STACK 4096

include funcs.inc

.data
	helloWorld db "hello world", 0
.code

alTest PROC
	mov edx,OFFSET helloWorld
	call WriteString
	ret
alTest ENDP

END