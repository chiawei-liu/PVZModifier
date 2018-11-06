.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	overlap BYTE 0E9h, 20h, 09h, 00h, 00h, 90h
	notOverlap BYTE 0Fh, 84h, 1Fh, 09h, 00h, 00h
	switch dd 0

.code

overlapPlants PROC, hProcess: DWORD
	
	.if switch == 0
		mov switch, 1
		invoke WriteProcessMemory, hProcess, 40FE2Fh, OFFSET overlap, 6, NULL
	.else
		mov switch, 0
		invoke WriteProcessMemory, hProcess, 40FE2Fh, OFFSET notOverlap, 6, NULL
	.endif
	ret

overlapPlants ENDP

END