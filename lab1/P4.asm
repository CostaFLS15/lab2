.data
cantidad: .byte 0x03
base: .byte 0x55,0x55,0x55
resultado: .space 1
.text
.globl main
main:
    la x10,cantidad
    lbu x2,0(x10)
    la x10,base
    
    la x11,resultado
lazo:
    beq x2,x0,fin
    lbu x1,0(x10)
    addi x2,x2,-1
    add x3,x3,x1
    addi x10,x10,1
    j lazo
fin:
    sb x3,0(x11)
    li a0,10
    ecall