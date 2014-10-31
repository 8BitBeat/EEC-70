;Christopher Chan (998005560) 
;Fourth version, cut down to 2 variables and cut down plenty of lines of code, 4th version accounted for when user inputs x = 0
TITLE Lab2              (Lab2.asm)

INCLUDE Irvine32.inc

.data
answer	DWORD	?
tempX	DWORD	?
str1	BYTE	"Enter the value for x	: ",0
str2	BYTE	"The value of y is	: ",0

.code
main PROC
	mov edx, OFFSET str1
	call WriteString
	call ReadHex
	mov tempX, eax		;tempX used to store the orginal input x value
	mov ecx, eax
	inc ecx
	loop xIsNotZero		;if input x was 0 then it would not jump to the procedures because x(0)^n is still 0
	
	mov eax, 1
	mov edx, OFFSET str2
	call WriteString
	call WriteHex
	exit

xIsNotZero:
	mov ecx, 2		;set counter to 2 to solve for 3x
	mov answer, eax	
ThreeX:	add eax, answer
	loop ThreeX
	mov answer,0

	push eax		;stack = 3x

	mov eax, tempX
	call xToFifth
	push eax		;Stack = x^5 ,3x
	

	mov eax, tempX
	call xCubed		;Stack = x^3, x^5, 3x
	push eax

	mov eax, tempX
	call ThreeXSq
	push eax		;Stack = 3x^2, x^3, x^5, 3x
	
	mov eax, 1
	mov ecx, 4		
fX:	pop ebx
	add eax, ebx		
	loop fX
COMMENT @
 f(x) after first pop: 1 + 3x^2
 f(x) after second pop:1 + 3x^2 + x^3
 f(x) after third pop:1 + 3x^2 + x^3 + x^5
 f(x) after fourth pop:1 + 3x^2 + x^3 + x^5 + 3x
@
	mov edx, OFFSET str2
	call WriteString
	call WriteHex
	exit

main ENDP


xToFifth PROC
	mov ecx, 4 		;Outer loop is set to 4 so we can loop through 5x as we are making x to the FIFTH
L1:	push ecx		;store outer loop count stack
	mov ecx, tempX		;move x into inner loop count as we are multiplying x by itself, meaning we add x to itself x amount of times
L2:	add answer, eax	
loop L2
	pop ecx			;restore outer loop counter
	mov eax, answer		;move answer to eax
	mov answer, 0
loop L1
ret
xToFifth ENDP			;all other procedures are basically similar so no need for comments


xCubed PROC
	mov ecx, 2
L1:	push ecx
	mov ecx, tempX
L2:	add answer, eax
loop L2
	pop ecx
	mov eax, answer
	mov answer, 0
loop L1
ret
xCubed ENDP


ThreeXSq PROC
	mov ecx, 1
L1:	push ecx
	mov ecx, tempX
L2:	add answer, eax
loop L2
	pop ecx
	mov eax, answer
	mov answer, 0
loop L1
	mov answer, eax
	mov ecx,2		;store 2 into ecx to multiply by 3
L3:	add eax, answer
loop L3
ret
ThreeXSq ENDP

END main