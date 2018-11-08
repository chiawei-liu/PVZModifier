.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	atkBean dd 9999
	priceBean dd 0
	coolDownBean dd 0

.code

godBean PROC, hProcess: DWORD

    invoke WriteProcessMemory, hProcess, 69F1C8h, OFFSET atkBean, 4, NULL
	invoke WriteProcessMemory, hProcess, 69F2C0h, OFFSET priceBean, 4, NULL
	invoke WriteProcessMemory, hProcess, 69F2C4h, OFFSET coolDownBean, 4, NULL
	ret

godBean ENDP

END