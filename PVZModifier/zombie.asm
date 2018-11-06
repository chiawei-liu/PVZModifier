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
	zomNum dd ?
	zomHp dd ?
	zomColdTime dd 5

.code

zombie PROC, hProcess: DWORD

	;mov edx, OFFSET askVal
	;call WriteString

	;call ReadInt
	;mov sunVal, eax

	invoke ReadProcessMemory, hProcess, 6A9EC0h, OFFSET offset1, 4, NULL
	add offset1, 768h

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 0A0h

    invoke ReadProcessMemory, hProcess, offset2, OFFSET zomNum, 4, NULL

	mov eax, zomNum
	call WriteInt

	.if zomNum == 0
		ret
	.endif

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 90h
L1:
	invoke ReadProcessMemory, hProcess, offset2, OFFSET offset3, 4, NULL
	add offset3, 0C8h

	mov eax, offset3
	call WriteInt

	; set raw to 1
	;invoke WriteProcessMemory, hProcess, offset3, 1, 4, NULL

	invoke ReadProcessMemory, hProcess, offset3, OFFSET zomHp, 4, NULL
	mov eax, zomHp
	call WriteInt

	invoke ReadProcessMemory, hProcess, offset2, OFFSET offset3, 4, NULL
	add offset3, 1CH

	invoke WriteProcessMemory, hProcess, offset3, OFFSET zomColdTime, 4, NULL

	add offset2, 15h
	sub zomNum, 1
	mov ecx, zomNum
	cmp zomNum, 1
	jge L1
	ret
zombie ENDP

END