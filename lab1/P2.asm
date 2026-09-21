.data
base: .byte 0x06,0x7A,0x7B,0x7C,0x00
.text
.globl main
main:
    la x1,base # cargo la direccion del primer elemento de la base
    li x7,2 # cargo el valor que voy a usar para hacer diviciones sucesivas
    li x6,0 # inicializo el registro donde guardo el valor de paridad, 1 impar, 0 par
lazo:
    beq x3,x0,fin # si el numero es 0 salto al fin, porque llegue al final del vector
    rem x5,x3,x7 # veo si el resto es 1 o 0 
    beq x5,x0,paridad # si es '0' no necesito que me lo cuente
    xori x6,x5,1 # si cambia guardo el cambio
    div x3,x3,x7 # guardo el resultado de la division para hacer divisiones sucesivas
    beq x3,x0,siguiente # si la division es 0 paso al siguiente numero
    j lazo
paridad:
    # caso si es 0 el resto
    div x3,x3,x7
    beq x3,x0,siguiente
    j lazo
siguiente:
    beq x6,x0,guardar
    ori x3,0x80 # si no le añado un 1 al inicio 
    sb x2,0(x1)
    addi x1,x1,1 # salto al siguiente byte
    lbu x2,0(x1) # cargo el primer elemento de base
    mv x3,x2 # copio el valor del primer elemento en x3
    beq x1,x0,fin
    j lazo
guardar:
    sb x2,0(x1)
    addi x1,x1,1
    j lazo
fin:
    li a0,10
    ecall


