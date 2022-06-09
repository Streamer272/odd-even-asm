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

	mov rax, SYS_EXIT
	mov rbx, 0
	int 80h

