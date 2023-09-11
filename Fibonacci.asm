# Calcular los primeros doce números de Fibonacci y ponerlos en un array, luego imprimirlos
.data
fibonacci: .word   0 : 12        # "array" de 12 palabras para contener los valores de Fibonacci
size: .word  12             # tamaño del "array"
      .text
      la   $t0, fibonacci              # cargar la dirección del array en $t0
      la   $t5, size              # cargar la dirección de la variable size en $t5
      lw   $t5, 0($t5)            # cargar el tamaño del array
      li   $t2, 1                 # 1 es el primer y segundo número de Fibonacci
      add.d $f0, $f2, $f4         # calcular los siguientes números de Fibonacci
      sw   $t2, 0($t0)            # F[0] = 1
      sw   $t2, 4($t0)            # F[1] = F[0] = 1
      addi $t1, $t5, -2           # Contador para el loop, se ejecutará (size-2) veces
loop: lw   $t3, 0($t0)            # Obtener el valor del array F[n]
      lw   $t4, 4($t0)            # Obtener el valor del array F[n+1]
      add  $t2, $t3, $t4          # $t2 = F[n] + F[n+1]
      sw   $t2, 8($t0)            # Almacenar F[n+2] = F[n] + F[n+1] en el array
      addi $t0, $t0, 4            # incrementar la dirección de la fuente de números de Fibonacci
      addi $t1, $t1, -1           # decrementar el contador del bucle
      bgtz $t1, loop              # repetir si no ha terminado aún
      la   $a0, fibonacci         # primer argumento para imprimir (array)
      add  $a1, $zero, $t5        # segundo argumento para imprimir (size)
      jal  print                  # llamar a la rutina de impresión
      li   $v0, 10                # llamada al sistema para salir
      syscall                     # estamos fuera de aquí.

######### Rutina para imprimir los números en una línea.

.data
space:.asciiz  " "                # espacio para insertar entre los números
head: .asciiz  "Los números de Fibonacci son:\n"
      .text
print:add  $t0, $zero, $a0        # dirección de inicio del array
      add  $t1, $zero, $a1        # inicializar el contador del bucle con el tamaño del array
      la   $a0, head              # cargar la dirección del encabezado de impresión
      li   $v0, 4                 # especificar el servicio de impresión de cadena
      syscall                     # imprimir encabezado
out:  lw   $a0, 0($t0)            # cargar número de Fibonacci para la llamada al sistema
      li   $v0, 1                 # especificar el servicio de impresión de enteros
      syscall                     # imprimir número de Fibonacci
      la   $a0, space             # cargar la dirección del espaciador para la llamada al sistema
      li   $v0, 4                 # especificar el servicio de impresión de cadena
      syscall                     # imprimir cadena
      addi $t0, $t0, 4            # incrementar dirección
      addi $t1, $t1, -1           # decrementar contador del bucle
      bgtz $t1, out               # repetir si no ha terminado
      jr   $ra                    # regresar
