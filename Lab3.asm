;Christopher Chan (998005560) 
;115 lines of code after removing new lines and placing code on the same line for destination

TITLE Lab3              (Lab3.asm)

Include Irvine32.inc

.data
strLab		BYTE	"Enter the six lab grades:",0
strLabInput	BYTE	"Lab1 : ",0
strHw		BYTE	"Enter the six Hw grades:",0
strHwInput	BYTE	"Hw1 : ",0
strExam		BYTE	"Enter the three exam grades:",0
strExamInput	BYTE	"Exam1 : ",0
strTotalGrade	BYTE 	"Total Grade = ",0
strLetterGrade	BYTE	"Letter Grade = ",0

labTotal	DWORD	0
hwTotal		DWORD	0
exam1		DWORD	0
exam2		DWORD 	0
exam3		DWORD	0
T		DWORD	0
L		DWORD	'A'

.code
main PROC
	mov edx, OFFSET strLab
	call WriteString
	call crlf
	mov ecx, 6 					;input 6 scores, counter is set to 6
	mov ebx, 100 					;this is used to compare and search for lowest score to reduce
;Lab input section;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
labInput:	
	mov esi, OFFSET BYTE PTR strLabInput+3 		;so the strLabInput can be recycled just by incrementing Lab #		
	mov edx, OFFSET strLabInput
	call WriteString 
	inc BYTE PTR [esi] 				;increment Lab # for next Lab input
	call ReadInt 					;prompt for score input
	cmp eax, ebx					;compare current score with lowest score

	JBE lowestLabScore 				;if lower than lowest score it will jump to get replaced
	JMP notDone					;otherwise we continue to either next Lab score input or Hw input depending on ecx
lowestLabScore:
	mov ebx, eax					;current score gets used as the lowest score indicator
notDone:
	add labTotal, eax				;add up the scores
loop labInput
	sub labTotal, ebx				;subtract the lowest score from the labTotal

							;the Homework Input Section is basically the same so no need for explanation
							;the Exam Input Section is similar other than the fact we don't subtract lowest score

;Homework Input Section;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	mov edx, OFFSET strHw
	call WriteString
	call crlf
	mov ecx, 6
	mov ebx, 100
hwInput:
	mov esi, OFFSET BYTE PTR strHwInput+2	
	mov edx, OFFSET strHwInput
	call WriteString 
	inc BYTE PTR [esi]
	call ReadInt
	cmp eax, ebx
	JBE lowestHwScore
	JMP notDone2
lowestHwScore:
	mov ebx, eax
notDone2:
	add hwTotal, eax
loop hwInput
	sub hwTotal, ebx
;Exam input Section;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov edx, OFFSET strExam
	call WriteString
	call crlf
	mov ecx, 3

examInput:
	mov esi, OFFSET BYTE PTR strExamInput+4	
	mov edx, OFFSET strExamInput
	call WriteString 
	inc BYTE PTR [esi]
	call ReadInt
	push eax
loop examInput
	
	pop exam3
	pop exam2
	pop exam1
	
;Calculating total score section
	mov eax, 5
	mul labTotal
	add T, eax
	mov eax, 3
	mul hwTotal
	add T, eax
	mov eax, 10
	mul exam1
	add T, eax
	mov eax, 20
	mul exam2
	add T, eax
	mov eax, 30
	mul exam3
	add T, eax

	mov eax, T
	mov ebx, 100
	div ebx
;Total score calculation
 	
	mov edx, OFFSET strTotalGrade
	call WriteString
	call WriteInt
	call crlf
	mov edx, OFFSET strLetterGrade
	call WriteString
	mov esi, OFFSET BYTE PTR L			;we base our letter grade on our total numeric score
	cmp eax, 86					
	JAE grade 	   ;A if >= 86				
	inc BYTE PTR [esi] ;B if >=76
	cmp eax, 76
	JAE grade	
	inc BYTE PTR [esi] ;C if >= 66
	cmp eax, 66
	JAE grade
	inc BYTE PTR [esi] ;D if >=60
	cmp eax, 60
	JAE grade
	inc BYTE PTR [esi]
	inc BYTE PTR [esi] ;else F
grade:	mov edx, OFFSET L
	call WriteString
	

exit
main ENDP

END main