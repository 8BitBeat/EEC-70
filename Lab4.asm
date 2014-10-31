;Christopher Chan (998005560) 

TITLE Lab4              (Lab4.asm)

Include Irvine32.inc

.data
str1	BYTE	"Enter the value of n in Hex: ",0
str2	BYTE	"Hex value of F(n) using Fib1: ",0
str3	BYTE	"Hex value of F(n) using Fib2: ",0
str4	BYTE	"Execution time of Fib2 in ms: ",0

.code
main PROC
	mov edx, OFFSET str1
	call WriteString
	call ReadHex
	push eax		;for use in recursion call
	push eax
	push ebx		;for use in recursion call
	mov ecx, eax		;for use in loop call
	mov eax, 1
	mov ebx, 0
	call Fib1
	mov edx, OFFSET str2
	call WriteString
	call WriteHex
	call crlf
	pop ebx
	call getMseconds
	mov ecx, eax		;save ms before calling fib 2 into ecx
	call Fib2
	push eax		;save Fib2 answer so we can calculate amount of MS used to run Fib2
	call getMseconds	
	sub eax, ecx
	mov ebx, eax		;save MS in ebx
	pop eax			;restore Fib2 anwer
	mov edx, OFFSET str3
	call WriteString
	call WriteHex
	call crlf
	mov eax, ebx		;move amount of MS back into eax
	mov edx, OFFSET str4
	call WriteString
	call WriteDec

exit
main ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Fib1 PROC
	dec ecx
Fib1Formula:
	cmp ecx, -1		;for the case user inputs n=1
	je done
	push eax
	add eax, ebx
	pop ebx
loop Fib1Formula
done:
ret
Fib1 ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Fib2 PROC
	push ebp		;save ebp ins tack for a place to return to after recursion
	mov ebp, esp		
	push ebx		
	mov eax, [ebp+8]	;access eax for the fib(n-1) part
	cmp eax, 2		;if we have reached base case in which n = 1 or 2
	jbe baseCase
	dec eax			;otherwise decrease n to calculate fib(n-1)
	push eax		
	call Fib2		;recursive call to solve fib(n-1)
;;;;;;;;;;;;;;;;;Below is calculating fib(n-2), branches out like a tree
	mov ebx, eax		
	mov eax, [ebp+8]
	sub eax, 2		;solving for fib(n-2)
	push eax		
	call Fib2		;recursive call to solve for fib(n-2)
	add eax, ebx
	jmp done
baseCase:
	mov eax, 1		;base case fib(1 or 2) = 1
done: 	
	pop ebx
	pop ebp			;return to previous fib location
	ret 4
Fib2 ENDP
END main