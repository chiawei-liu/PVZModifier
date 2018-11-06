.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	free BYTE 90h, 90h
	notFree BYTE 2Bh, 0F3h
	switch dd 0
.code

freePlants PROC, hProcess: DWORD

	.if switch ==0
		mov switch, 1
	    invoke WriteProcessMemory, hProcess, 41BA74h, OFFSET free, 2, NULL
	.else
		mov switch, 0
		invoke WriteProcessMemory, hProcess, 41BA74h, OFFSET notFree, 2, NULL
	.endif
	ret

freePlants ENDP

END