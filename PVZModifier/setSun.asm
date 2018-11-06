.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
	sunVal  dd ?
	sunOldVal dd ?
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	askVal db "Set sun to: ", 0

.code

setSun PROC, hProcess: DWORD

	mov edx, OFFSET askVal
	call WriteString

	call ReadInt
	mov sunVal, eax

	invoke ReadProcessMemory, hProcess, 6A9EC0h, OFFSET offset1, 4, NULL
	add offset1, 768h

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 5560h

    invoke WriteProcessMemory, hProcess, offset2, OFFSET sunVal, 4, NULL
	ret
setSun ENDP

END