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
	zomCharmed BYTE 1

.code

charmZombies PROC, hProcess: DWORD


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

	; set frozen time
	mov edx, zomBase
	add edx, 0B8h
	mov offset3, edx
	invoke WriteProcessMemory, hProcess, offset3, OFFSET zomCharmed, 1, NULL

	add zomBase, 15Ch
	sub zomNum, 1
	jmp L1
	ret
charmZombies ENDP

END