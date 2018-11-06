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
   hwnd      HANDLE ?
   FWID      db "植物大战僵尸中文版",0 
   MsgTitle  db "This is a messagebox",0
   dwProcId  dd ?
   founded   byte "The Game has been founded",0
   OpenP     db ?
   byteswritten dd ? 
   score     dword  100000
   Pointer   dword ?
   dwNewValue    dd 99
   dwOldProtect  dd 0
   hProcess      dd 0
   cmdBuffer db 21 DUP(0)
   sunVal  dd ?
   sunOldVal dd ?
   offset1 dd ?
   offset2 dd ?
   offset3 dd ?
   alTestCmd db "alTest", 0
   setSunCmd db "setSun", 0
   zombieCmd db "zombie", 0
   godBeanCmd db "godBean", 0
   freePlantsCmd db "freePlants", 0
   overlapPlantsCmd db "overlapPlants", 0
   invincibleZombiesCmd db "invincibleZombies", 0
   askCmd db "Enter command: ", 0


.data?
   buffer    dd 9876
 
.code
 
main PROC
	
	invoke FindWindowA, NULL, ADDR FWID; 
    test eax, eax
    jz error
 
    invoke GetWindowThreadProcessId, eax, offset dwProcId
    invoke OpenProcess, PROCESS_ALL_ACCESS, NULL, dwProcId
    cmp eax, INVALID_HANDLE_VALUE
    je error
 
    mov hProcess, eax

	
L1:
	mov edx, OFFSET askCmd
	call WriteString

	mov edx, OFFSET cmdBuffer
	mov ecx, SIZEOF cmdBuffer
	call ReadString

	INVOKE Str_compare, ADDR cmdBuffer, ADDR alTestCmd
	.if ZERO?
        call alTest
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR setSunCmd
	.if ZERO?
        INVOKE setSun, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR zombieCmd
	.if ZERO?
        INVOKE zombie, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR godBeanCmd
	.if ZERO?
        INVOKE godBean, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR freePlantsCmd
	.if ZERO?
        INVOKE freePlants, hProcess
    .endif

	INVOKE Str_compare, ADDR cmdBuffer, ADDR overlapPlantsCmd
	.if ZERO?
        INVOKE overlapPlants, hProcess
    .endif
	
	INVOKE Str_compare, ADDR cmdBuffer, ADDR invincibleZombiesCmd
	.if ZERO?
        INVOKE invincibleZombies, hProcess
    .endif
	

	jmp L1
	

    invoke CloseHandle, hProcess 
	;invoke dwtoa, hwnd, ADDR buffer; convert hwnd to string and store it into our buffer
    ;invoke MessageBox, NULL, addr MsgTitle, addr buffer, MB_OK ;dispay the handle in the window title bar
    ;invoke ExitProcess, NULL 
    jmp done
                    
error:
    print "There was an error",0,0
    inkey
    ret
 
done:
    ret
 
main ENDP

END main