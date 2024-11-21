/* SPDX-License-Identifier: GPL-2.0+ */
/*
 * (C) Copyright 2007 Semihalf
 *
 * Written by: Rafal Jaworowski <raj@semihalf.com>
 */

#if defined(CONFIG_PPC)

	.text
	.globl _start
_start:
	lis	%r11, search_hint@ha
	addi	%r11, %r11, search_hint@l
	stw	%r1, 0(%r11)
	b	main


	.globl syscall
syscall:
	lis	%r11, syscall_ptr@ha
	addi	%r11, %r11, syscall_ptr@l
	lwz	%r11, 0(%r11)
	mtctr	%r11
	bctr

#elif defined(CONFIG_ARM)

	.text
	.globl _start
_start:
	ldr	x16, =search_hint
   mov  x17,sp
	str  x17, [x16]
	b	  main


	.globl syscall
syscall:
   mov   x16, xzr
   mov   x17, xzr
	ldr	x16, =syscall_ptr
	ldr   x17, [x16]
   br	   x17

#elif defined(CONFIG_MIPS)
#include <asm/asm.h>
	.text
	.globl __start
	.ent __start
__start:
	PTR_S	$sp, search_hint
	b	main
	.end __start

	.globl syscall
	.ent syscall
syscall:
	PTR_S	$ra, return_addr
	PTR_L	$t9, syscall_ptr
	jalr	$t9
	nop
	PTR_L	$ra, return_addr
	jr	$ra
	nop
	.end syscall

return_addr:
	.align 8
	.long 0
#else
#error No support for this arch!
#endif

	.globl syscall_ptr
	.align	16
syscall_ptr:
	.quad	0

	.globl search_hint
	.align	16
search_hint:
	.quad   0
