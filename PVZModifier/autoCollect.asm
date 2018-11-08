.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
	switch dd 0
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	autoOn BYTE 0EBh
	autoOff BYTE 75h
	nowOn db "Auto collect now on. ", 0
	nowOff db "Auto collect now off. ", 0

.code

autoCollect PROC, hProcess: DWORD

	.if switch == 0
		mov switch, 1
	    invoke WriteProcessMemory, hProcess, 43158Fh, OFFSET autoOn, 1, NULL
		mov edx, OFFSET nowOn
		call WriteString
	.else
		mov switch, 0
		invoke WriteProcessMemory, hProcess, 43158Fh, OFFSET autoOff, 1, NULL
		mov edx, OFFSET nowOff
		call WriteString
	.endif
	ret

autoCollect ENDP

END