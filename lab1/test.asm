# 1)
.data
resultado: .space 3 # reservo 2 bytes
base: .byte 0x11,0x22,0x33,0x44,0x00
.text
.globl main
main:
    la x1,resultado # cargo la direccion del resultado
    la x2,base # cargo la direccion donde estan los datos
    li x7,0x7F # numero a comparar, si es mayor a este es porque es negativo
    li x4,0 # registro para contar la cantidad de positivos
    li x6,0 # registro para la cantidad de negativos
lazo:
    lbu x3,0(x2) # cargo el valor de la direccion actual de base
    beq x3,x0,fin
    bltu x7,x3,sumar # si el numero es mayor a 7F es porque es un numero negativo en complemento a 2, no tengo que hacer nada
    addi x4,x4,1 # sumo el positivo detectado
    addi x2,x2,1 # voy a la direccion siguiente
    j lazo
sumar:
    addi x6,x6,1 # sumo el negativo detectado
    addi x2,x2,1 # como no tengo que hacer nada con el negativo paso al siguiente dato
    j lazo
fin:
    sb x4,0(x1) # guardo el positivo 
    addi x1,x1,1 # salto a la direccion resultado+1
    sb x6,0(x1) # guarop la cantidad de positivos
    li a0,10
    ecall

# 1b)
.data
resultado: .space 5 # reservo 4 bytes
base: .byte 0x11,0x22,0x33,0x44,0x00
.text
.globl main
main:
    la x1,resultado # cargo la direccion del resultado
    la x8,base # cargo la direccion donde estan los datos
    mv x2,x8 # copio el valor de direccion de base en x2
init_lazo:
    mv x2,x8 # copio el valor de direccion de base en x2
    li x7,0x7F # numero a comparar, si es mayor a este es porque es negativo
    li x4,0 # registro para contar la cantidad de positivos
    li x6,0 # registro para la cantidad total
lazo:
    lbu x3,0(x2) # cargo el valor de la direccion actual de base
    beq x3,x0,init_par # si termino de ver los positivos voy a analizar la paridad
    addi x6,x6,1
    bltu x7,x3,sumar # si el numero es mayor a 7F es porque es un numero negativo en complemento a 2, no tengo que hacer nada
    addi x4,x4,1 # sumo el positivo detectado
    addi x2,x2,1 # voy a la direccion siguiente
    j lazo
sumar:
    addi x2,x2,1 # como no tengo que hacer nada con el negativo paso al siguiente dato
    j lazo
init_par:
    sb x4,0(x1) # guardo el positivo 
    addi x1,x1,1 # salto a la direccion resultado+1
    sub x4,x6,x4 # dejo a x4 como la cantidad de negativos, haciendo total-positivos
    sb x4,0(x1) # guardo la cantidad de negativos
    addi x1,x1,2
    # estoy en resultado+3
    # ----------------
    mv x2,x8 # copio el valor de direccion de base en x2
    li x7,2 # numero para ver paridad
    li x4,0 # registro para contar la cantidad de pares
paridad:
    lbu x3,0(x2) # cargo el numero de la direccion actual
    beq x3,x0,fin # si el numero es 0 finalizo el programa
    rem x5,x3,x7 # guardo el resto de la division del numero actual y 2
    beq x5,x0,par # si el resto es 0 es par
    addi x2,x2,1 # es impar, paso a la siguiente direccion
    j paridad
par:
    addi x4,x4,1 # sumo el par encontrado
    addi x2.x2,1 # paso al siguiente dato
    j paridad
fin:
    sb x4,0(x1) # guardo los pares en resultado + 3
    addi x1,x1,1
    sub x4,x6,x4
    sb x4,0(x1) # guardo los impares en resultado + 4
    li a0,10
    ecall
# 2-a) 
.data
base: .byte 2,3 # el primer y segundo digito respectivamente
espacio: .space 5 # guardo para reservar hasta base + 6 +1
tabla:  .byte 0xFC,0x60,0xDA,0xF2,0x66
        .byte 0xB6,0xBE,0xE0,0xFE,0xF6
        