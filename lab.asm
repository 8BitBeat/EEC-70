TITLE Lab1              (Lab1.asm)

; This program solves for n!
; Last update: 2/8/14

INCLUDE Irvine32.inc

.data
temp	DWORD	?
answer	DWORD	10
count	DWORD	?

.code
main PROC

MOV ecx, 8
L1:
	mov count, ecx
	mov eax, answer
	mov temp, eax
	mov ecx, count
L2:	mov ebx, temp
	add answer, ebx
loop L2

	mov ecx, count
	mov edx, answer	; f(n) is displayed on the edx registry
call dumpregs
loop L1
	exit
main ENDP

END main