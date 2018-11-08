.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	on dd 1

.code

clearFirstRound PROC, hProcess: DWORD
	
	invoke ReadProcessMemory, hProcess, 6A9EC0h, OFFSET offset1, 4, NULL
	add offset1, 82Ch

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 2Ch

	invoke WriteProcessMemory, hProcess, offset2, OFFSET on, 4, NULL

	ret

clearFirstRound ENDP

END