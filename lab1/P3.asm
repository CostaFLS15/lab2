.data 
base: .space 1
cantidad: .byte 0x03
vector: .byte 0x3A,0xAA,0xF2

.text
.globl main
main:
    la x1,base
    li x4,0 # 
    la x2,x1 # copio direccion para el resultado
    addi x2,x2,1 # sumo un byte (paso a cantidad)
    lbu x3,0(x2) # cargo cantidad de datos
    addi x2,x2,1 # paso a vector sumando 1 byte a direccion
lazo:
    beq x3,x0,fin # si termino de ver todos los elementos termino
    lbu x4,0(X2) # cargo el dato de vector[0]
    lbu x5,1(x2) # cargo el dato de vector[1]
    bltu x4,x5,suma
    la x6,x5 # cargo la direccion del puntero mayor
    addi x2,x2,1
    j lazo 
suma:
    j lazo
fin:
    li a0,10
    ecall    