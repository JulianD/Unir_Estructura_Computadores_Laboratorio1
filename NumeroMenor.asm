.data
primero: .asciiz "Primer número: "
segundo: .asciiz "Segundo número: "
tercero: .asciiz "Tercer número: "

resultado: .asciiz "El número menor es: "

.text
.globl main

main:
# Pide el primer número
li $v0, 4
la $a0, primero
syscall

# Lee el teclado a la posición $v0
li $v0, 5
syscall

# Mueve el valor a $t0
move $t0,$v0

# Pide el segundo número
li $v0, 4
la $a0, segundo
syscall

# Lee el teclado a la posición $v0
li $v0, 5 
syscall

# Mueve el valor a $t1
move $t1,$v0 

# Pide el tercer número
li $v0, 4
la $a0, tercero
syscall

# Lee el teclado a la posición $v0
li $v0, 5 
syscall

# Mueve el valor a $t2
move $t2,$v0

# Realizamos la primera comparación. Si es falso, saltamos a la segunda
ble $t1, $t0, COMPARACION2
move $t1, $t0

COMPARACION2:
# Realizamos la segunda comparación.
ble $t1, $t2, RESULTADO 
move $t1, $t2


# Imprimimos el resultado
RESULTADO: 
li $v0, 4 
la $a0, resultado
syscall

# LLamamos al sistema para imprimir el valor
li $v0, 1 
move $a0, $t1 
syscall

# Llamos al sistema para salir
end: li $v0, 10 
syscall 

