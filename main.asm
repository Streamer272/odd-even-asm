SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

STDIN equ 0
STDOUT equ 1
STDERR equ 2

section .data
	oddMsg db "Your number is odd", 0xA, 0x0
	oddLen equ $ - oddMsg
	evenMsg db "Your number is even", 0xA, 0x0
	evenLen equ $ - evenMsg
	quoteMsg db "'", 0x0
	quoteLen equ $ - quoteMsg
	askNumMsg db "Please enter a number: ", 0x0
	askNumLen equ $ - askNumMsg
	newLineMsg db 0xA, 0x0
	newLineLen equ $ - newLineMsg
	displayNumMsg db "You entered ", 0x0
	displayNumLen equ $ - displayNumMsg
	containsLetterMsg db "Your input contains a letter", 0xA, 0x0
	containsLetterLen equ $ - containsLetterMsg
	unexpectedErrorMsg db "Unexpected error occurred", 0xA, 0x0
	unexpectedErrorLen equ $ - unexpectedErrorMsg

section .bss
	input resb 8
	exitCode resb 1

section .text
	global _start

_start:
	mov r8, 0
	mov [exitCode], r8

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, askNumMsg
	mov rdx, askNumLen
	int 80h

	mov rax, SYS_READ
	mov rbx, STDIN
	mov rcx, input
	mov rdx, 8
	int 80h

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, displayNumMsg
	mov rdx, displayNumLen
	int 80h

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, input
	mov rdx, 8
	int 80h

	mov r8, 0
	inputLoop:
	cmp byte[input+r8], 0x0
	je end
	cmp byte[input+r8], 0xA
	je end

	;cmp byte[input+r8], 0x30
	;jl containsLetters
	;cmp byte[input+r8], 0x39
	;jg containsLetters

	inc r8
	jmp inputLoop

	end:
	dec r8

	cmp byte[input+r8], 0x30
	je even
	cmp byte[input+r8], 0x32
	je even
	cmp byte[input+r8], 0x34
	je even
	cmp byte[input+r8], 0x36
	je even
	cmp byte[input+r8], 0x38
	je even

	jmp odd

	odd:
	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, oddMsg
	mov rdx, oddLen
	int 80h
	jmp exit

	even:
	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, evenMsg
	mov rdx, evenLen
	int 80h
	jmp exit

	containsLetters:
	mov rax, SYS_WRITE
	mov rbx, STDERR
	mov rcx, containsLetterMsg
	mov rdx, containsLetterLen
	int 80h

	mov r8, 1
	mov [exitCode], r8
	jmp exit

	unexpectedError:
	mov rax, SYS_WRITE
	mov rbx, STDERR
	mov rcx, unexpectedErrorMsg
	mov rdx, unexpectedErrorLen
	int 80h

	mov r8, 1
	mov [exitCode], r8
	jmp exit

	exit:
	mov rax, SYS_EXIT
	mov rbx, [exitCode]
	int 80h

