.data
base: .half 5
.text 
.globl main
main:
    la x1,base
    lh x2,0(x1)
    addi x3,x1,2
    li x4,0x55
lazo:
    beq x2,x0,fin
    addi x2,x2,-1
    sh x4,0(x3)
    addi x3,x3,2
    j lazo
fin:
    li a0,10
    ecall