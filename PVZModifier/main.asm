.386 
.model flat, stdcall
.STACK 4096
option casemap :none

include /masm32/include/windows.inc
include /masm32/macros/macros.asm
include /masm32/include/msvcrt.inc
includelib /masm32/lib/msvcrt.lib
 
  ; -----------------------------------------------------------------
  ; include files that have MASM format prototypes for function calls
  ; -----------------------------------------------------------------
    include /masm32/include/masm32.inc
    include /masm32/include/gdi32.inc
    include /masm32/include/user32.inc
    include /masm32/include/kernel32.inc
 
  ; ------------------------------------------------
  ; Library files that have definitions for function
  ; exports and tested reliable prebuilt code.
  ; ------------------------------------------------
    includelib \masm32\lib\masm32.lib
    includelib \masm32\lib\gdi32.lib
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib

include funcs.inc

.data 
   hwnd HANDLE ?
   FWID db "植物大战僵尸中文版", 0
   dwProcId dd ?
   founded byte "The Game has been founded", 0
   unrecCmd db "Unrecognized command. ", 0
   hProcess dd 0
   cmdBuffer db 30 DUP(0)
   cmdAccept BYTE 0
   setSunCmd db "setSun", 0
   killAllZombiesCmd db "killAllZombies", 0
   godBeanCmd db "godBean", 0
   freePlantsCmd db "freePlants", 0
   overlapPlantsCmd db "overlapPlants", 0
   invincibleZombiesCmd db "invincibleZombies", 0
   askCmd db "Enter command: ", 0
   freezeZombiesCmd db "freezeZombies", 0
   charmZombiesCmd db "charmZombies", 0
   setLevelCmd db "setLevel", 0
   autoCollectCmd db "autoCollect", 0
   noCoolDownCmd db "noCoolDown", 0
   clearFirstRoundCmd db "clearFirstRound", 0
   cmdList db "Command list: ", 10, 13, "    setSun", 10, 13, "    killAllZombies", 10, 13, "    godBean", 10, 13, "    freePlants", 10, 13, "    overlapPlants", 10, 13, "    invincibleZombies", 10, 13, "    freezeZombies", 10, 13, "    charmZombies", 10, 13, "    setLevel", 10, 13, "    autoCollect", 10, 13, "    noCoolDown", 10, 13, "    clearFirstRound", 10, 13, 10, 13, 0

   quitCmd db "quit", 0
 
.code
 
main PROC

	mov edx, OFFSET cmdList
	call WriteString
	
	invoke FindWindowA, NULL, ADDR FWID; 
    test eax, eax
    jz error
 
    invoke GetWindowThreadProcessId, eax, offset dwProcId
    invoke OpenProcess, PROCESS_ALL_ACCESS, NULL, dwProcId
    cmp eax, INVALID_HANDLE_VALUE
    je error
 
    mov hProcess, eax

L1:
	mov cmdAccept, 0
	mov edx, OFFSET askCmd
	call WriteString

	mov edx, OFFSET cmdBuffer
	mov ecx, SIZEOF cmdBuffer
	call ReadString

	INVOKE Str_compare, ADDR cmdBuffer, ADDR quitCmd
	.if ZERO?
		mov cmdAccept, 1
        jmp done
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR setSunCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE setSun, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR killAllZombiesCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE killAllZombies, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR godBeanCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE godBean, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR freePlantsCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE freePlants, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR overlapPlantsCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE overlapPlants, hProcess
    .endif
	
	INVOKE Str_compare, ADDR cmdBuffer, ADDR invincibleZombiesCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE invincibleZombies, hProcess
    .endif
	
	INVOKE Str_compare, ADDR cmdBuffer, ADDR freezeZombiesCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE freezeZombies, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR charmZombiesCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE charmZombies, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR setLevelCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE setLevel, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR autoCollectCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE autoCollect, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR noCoolDownCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE noCoolDown, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR clearFirstRoundCmd
	.if ZERO?
		mov cmdAccept, 1
        INVOKE clearFirstRound, hProcess
    .endif

	.if cmdAccept == 0
		mov edx, OFFSET unrecCmd
		call WriteString
	.endif

	jmp L1
	
    
    jmp done
                    
error:
    print "There was an error. Couldn't find the game. ", 10, 13, 0,0
    inkey
    ret
 
done:
	invoke CloseHandle, hProcess 
    ret
 
main ENDP

END main