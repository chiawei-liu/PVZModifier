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
	noCDOff BYTE 89h, 45h, 24h, 89h, 45h, 28h, 88h, 45h, 49h
	noCDOn BYTE 0C7h, 45h, 24h, 99h, 99h, 09h, 00h, 90h, 90h
	nowOn db "No CD now on. ", 13, 10, 0
	nowOff db "No CD now off. ", 13, 10, 0
	slotNum dd 10
	coolDown dd 0

.code

noCoolDown PROC, hProcess: DWORD

	invoke ReadProcessMemory, hProcess, 6A9EC0h, OFFSET offset1, 4, NULL
	add offset1, 768h

	invoke ReadProcessMemory, hProcess, offset1, OFFSET offset2, 4, NULL
	add offset2, 144h

	invoke ReadProcessMemory, hProcess, offset2, OFFSET offset3, 4, NULL

	mov slotNum, 10

L1:

	.if slotNum == 0
		jmp next
	.endif

	add offset3, 50h
	invoke ReadProcessMemory, hProcess, offset3, OFFSET coolDown, 4, NULL

	sub offset3, 4h
	invoke WriteProcessMemory, hProcess, offset3, OFFSET coolDown, 4, NULL

	add offset3, 4h
	sub slotNum, 1
	jmp L1
	jmp next


next:
	.if switch == 0
		mov switch, 1
	    invoke WriteProcessMemory, hProcess, 488E77h, OFFSET noCDOn, 9, NULL
		mov edx, OFFSET nowOn
		call WriteString
	.else
		mov switch, 0
		invoke WriteProcessMemory, hProcess, 488E77h, OFFSET noCDOff, 9, NULL
		mov edx, OFFSET nowOff
		call WriteString
	.endif
	ret

noCoolDown ENDP

END