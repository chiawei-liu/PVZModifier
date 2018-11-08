.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	zomNum dd ?
	zomBase dd ?
	zomValid BYTE ?
	zomFrozenTime dd ?
	askVal db "Frozen time: ", 0

.code

freezeZombies PROC, hProcess: DWORD

	mov edx, OFFSET askVal
	call WriteString

	call ReadInt
	mov zomFrozenTime, eax

	invoke ReadProcessMemory, hProcess, 6A9EC0h, OFFSET offset1, 4, NULL
	add offset1, 768h

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 0A0h

    invoke ReadProcessMemory, hProcess, offset2, OFFSET zomNum, 4, NULL

	mov zomNum, 1000

	.if zomNum == 0
		ret
	.endif

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 90h

	invoke ReadProcessMemory, hProcess, offset2, OFFSET offset3, 4, NULL
	mov ebx, offset3
	mov zomBase, ebx
L1:

	.if zomNum == 0
		ret
	.endif
	
	mov edx, zomBase
	add edx, 0ECh
	mov offset3, edx

	;invoke ReadProcessMemory, hProcess, offset3, OFFSET zomValid, 1, NULL
	;.if zomValid == 1
	;	add zomBase, 15Ch
	;	jmp L1
	;.endif

	; set frozen time
	mov edx, zomBase
	add edx, 0B4h
	mov offset3, edx
	invoke WriteProcessMemory, hProcess, offset3, OFFSET zomFrozenTime, 4, NULL

	add zomBase, 15Ch
	sub zomNum, 1
	jmp L1
	ret
freezeZombies ENDP

END