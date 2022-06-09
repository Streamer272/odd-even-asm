SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

STDOUT equ 1
STDIN equ 2

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
	mov eax, 4
	mov ebx, 1
	mov ecx, askNumMsg
	mov edx, askNumMsgLen
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, input
	mov edx, 8
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, displayNumMsg
	mov edx, displayNumMsgLen
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, input
	mov edx, 8
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

