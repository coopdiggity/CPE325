;-------------------------------------------------------------------------------
; File       : Lab4_D1.asm (CPE 325 Lab4 Demo code)
; Function   : Counts the number of characters E in a given string
; Description: Program traverses an input array of characters
;              to detect a character 'E'; exits when a NULL is detected
; Input      : The input string is specified in myStr
; Output     : The port P1OUT displays the number of E's in the string
; Author     : A. Milenkovic, milenkovic@computer.org
; Date       : August 14, 2008
;-------------------------------------------------------------------------------
        .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
        .def    RESET                   ; Export program entry-point to
                                        ; make it known to linker.

myStr:  .string "HELLO WORLD, I AM THE MSP430!", ''
;-------------------------------------------------------------------------------
        .text                           ; Assemble into program memory.
        .retain                         ; Override ELF conditional linking
                                        ; and retain current section.
        .retainrefs                     ; And retain any sections that have
                                        ; references to current section.

;-------------------------------------------------------------------------------
RESET:  mov.w   #__STACK_END,SP         ; Initialize stack pointer
        mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
main:   bis.b   #0FFh,&P1DIR            ; configure P1.x output
        mov.w   #myStr, R4              ; load the starting address of the string into R4
        clr.b   R5                      ; register R5 will serve as a counter
gnext:  mov.b   @R4+, R6                ; get a new character
        cmp     #0,R6                   ; is it a null character
        jeq     lend                    ; if yes, go to the end
        cmp.b   #'E',R6                 ; is it an 'E' character
        jne     gnext                   ; if not, go to the next
        inc.w   R5                      ; if yes, increment counter
        jmp     gnext                   ; go to the next character

lend:   mov.b   R5,&P1OUT               ; set all P1 pins (output)
        bis.w   #LPM4,SR                ; LPM4
        nop                             ; required only for Debugger


;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
        .global __STACK_END
        .sect   .stack

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
         .sect   ".reset"               ; MSP430 RESET Vector
         .short  RESET
         .end
