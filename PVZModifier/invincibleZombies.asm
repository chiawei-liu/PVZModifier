.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include funcs.inc

.data
    offset1 dd ?
    offset2 dd ?
    offset3 dd ?
	invincible BYTE 90h, 90h, 90h, 90h
	notinvincible BYTE 2Bh, 7Ch, 24h, 20h
	switch dd 0

.code

invincibleZombies PROC, hProcess: DWORD
	
	.if switch == 0
		mov switch, 1
		invoke WriteProcessMemory, hProcess, 53130Fh, OFFSET invincible, 4, NULL
	.else
		mov switch, 0
		invoke WriteProcessMemory, hProcess, 53130Fh, OFFSET notinvincible, 4, NULL
	.endif
	ret

invincibleZombies ENDP

END