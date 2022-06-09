SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

STDIN equ 0
STDOUT equ 1
STDERR equ 2

section .data
	askNumMsg db "Please enter a number: ", 0x0
	askNumMsgLen equ $ - askNumMsg
	displayNumMsg db "You have entered ", 0x0
	displayNumMsgLen equ $ - displayNumMsg
	containsLetterMsg db "Your input contains a letter", 0x10, 0x0
	containsLetterMsgLen equ $ - containsLetterMsg
	unexpectedErrorMsg db "Unexpected error occurred", 0x10, 0x0
	unexpectedErrorMsgLen equ $ - unexpectedErrorMsg

section .bss
	input resb 8

section .text
	global _start

_start:
	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, askNumMsg
	mov rdx, askNumMsgLen
	int 80h

	mov rax, SYS_READ
	mov rbx, STDIN
	mov rcx, input
	mov rdx, 8
	int 80h

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, displayNumMsg
	mov rdx, displayNumMsgLen
	int 80h

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, input
	mov rdx, 8
	int 80h

	mov r8, 0
	mov r9, input
	inputLoop:
	mov r10, 0

	numLoop:
	cmp byte[input+r8], 0x10
	je exit

	cmp byte[input+r8], 0x30
	je end

	inc r10
	cmp r10, 10
	jne numLoop

	inc r8
	jmp inputLoop

	end:
	add r9, r8
	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, r9
	mov rdx, 8
	int 80h
	jmp exit

	containsLetter:
	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, containsLetterMsg
	mov rdx, containsLetterMsgLen
	int 80h
	jmp exit

	unexpectedError:
	;mov rax, SYS_WRITE
	;mov rbx, STDOUT
	;mov rcx, unexpectedErrorMsg
	;mov rdx, unexpectedErrorMsgLen
	;int 80h
	jmp exit

	exit:
	mov rax, SYS_EXIT
	mov rbx, 0
	int 80h

