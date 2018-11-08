.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
	level dd ?
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	askVal db "Set level to: ", 0

.code

setLevel PROC, hProcess: DWORD

	mov edx, OFFSET askVal
	call WriteString

	call ReadInt
	mov level, eax

	invoke ReadProcessMemory, hProcess, 6A9EC0h, OFFSET offset1, 4, NULL
	add offset1, 82Ch

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 24h

    invoke WriteProcessMemory, hProcess, offset2, OFFSET level, 4, NULL
	ret
setLevel ENDP

END