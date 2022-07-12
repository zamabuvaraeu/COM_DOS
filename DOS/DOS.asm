	.file	"DosRTL.c"
	.code16gcc
	.intel_syntax noprefix
	.text

	.globl _ENTRYPOINT
	.def	_ENTRYPOINT;	.scl	2;	.type	32;	.endef
_ENTRYPOINT:
	mov    cx, ds
	call   _DOSMAIN
	mov    ah, 76
	int    0x21

	.section	.text$INPUTDOSSTRING,"x"
	.globl _INPUTDOSSTRING
	.def	_INPUTDOSSTRING;	.scl	2;	.type	32;	.endef
_INPUTDOSSTRING:
	mov    BYTE PTR [ecx], 253	# buffer capacity = 253 bytes
	mov    dx, cx
	mov    ah, 10
	int    0x21
	ret

	.section	.text$PRINTDOSSTRING,"x"
	.globl _PRINTDOSSTRING
	.def	_PRINTDOSSTRING;	.scl	2;	.type	32;	.endef
 _PRINTDOSSTRING:
	mov    dx, cx
	mov    ah, 9
	int    0x21
	ret

	.section	.text$PRINTSTRINGA,"x"
	.globl _PRINTSTRINGA
	.def	_PRINTSTRINGA;	.scl	2;	.type	32;	.endef
_PRINTSTRINGA:
	push   ebx
	mov    ah, 64
	mov    bx, 1
	mov    cx, WORD PTR [esp+12]
	mov    dx, WORD PTR [esp+8]
	int    0x21
	pop    ebx
	ret
