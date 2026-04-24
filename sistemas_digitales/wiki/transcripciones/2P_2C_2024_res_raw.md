---
tipo: transcripcion
fuente: raw/parciales/2P/2.parcial_2C_2024_resolucion.pdf
metodo: claude_vision
parcial: 2P
cuatrimestre: 2C
año: 2024
nota_visible: 10
---

# Transcripcion — 2do Parcial 2C 2024

## Hoja de enunciado (pag 1-2)

**Sistemas Digitales — Segundo Parcial — Segundo Cuatrimestre 2024**

### Ejercicio 1 (2 pts.)

Implementar la función que calcula el valor de un elemento en un triángulo de Pascal, definido en el siguiente bloque de código C:

```c
function pascal(fila, columna) {
    if (columna>fila) return 0;
    if (columna<=1 || fila<=1) return 1;
    return pascal(fila-1, columna) + pascal(fila-1, columna-1);
}
```

El triángulo de Pascal define una secuencia triangular de números enteros que comienza con un 1 (uno) en el vértice superior y se expande hacia abajo con números calculados a partir de los números de la fila superior. Cada número en el triángulo es la suma de los dos números directamente arriba de él.

Más allá de la interpretación de la función les recomendamos concentrarse en la traducción a código RISC V que respete la convención de llamada. Deben explicar en qué registros se almacenan los valores en cada paso y cómo se aseguran que se respeta la convención.

---

### Ejercicio 2 (2 pts.)

Implementar las siguientes funciones en lenguaje ensamblador de RISC V respetando la convención de llamada presentada en la materia. Describir el comportamiento y cómo se aseguran que se respete la convención.

- `int inv(int x) = -x` (inverso aditivo)
- `void invertirArreglo(int arr[], int largo)`: Dado un puntero a un arreglo de enteros de 32 bits y la cantidad de elementos, cambia cada valor del arreglo por su inverso aditivo.

---

### Ejercicio 3 (4 pts.)

Se tiene una estructura `BalanceDeudor` que contiene el ID del cliente como un entero sin signo de 8 bits, la suma de sus consumos como un entero en complemento a dos de 16 bits y la suma de sus pagos realizados como un entero en complemento a dos de 16 bits.

Ubicación de los datos de una estructura BalanceDeudor:

| Byte | 0x0000 | 0x0001 | 0x0003 |
|------|--------|--------|--------|
| Nombre | ID | Consumos | Pagos |

En memoria se encuentra un arreglo `balanceDeudores` del tipo BalanceDeudor con la forma:

| Direccion | 0x0000 | 0x0001 | 0x0003 | 0x0005 | ... | 0x0030 | 0x0031 | 0x0033 | 0x0035 |
|-----------|--------|--------|--------|--------|-----|--------|--------|--------|--------|
| Valor | 17 | 30020 | 1232 | 6 | ... | 9 | 5878 | 300 | 0 |

Donde el final del arreglo es demarcado por un ID nulo. Se pide:

1. Calcular cuántos bytes ocupa en memoria la estructura BalanceDeudor y cuántos bytes un arreglo de tipo BalanceDeudor de doce elementos.
2. Escribir una función `contarDeudores(balanceDeudores)` que dada una posición de memoria que indica el comienzo de un arreglo `balanceDeudores` de BalanceDeudor, devuelva la suma de estructuras donde la suma de los consumos (segundo elemento de la estructura) es mayor que la suma de los pagos realizados (tercer elemento de la estructura).

Codigo de declaracion del arreglo en RISC-V:

```asm
.data
balanceDeudores:    .byte 17
                    .half 30020
                    .half 1232
                    .byte 6
                    .half 200
                    .half 200
                    .byte 9
                    .half 5878
                    .half 300
                    .half 0     #Declaramos el final del arreglo
.text
contarDeudores:
    ...
```

Para este caso `balanceDeudores` debe devolver 2 ya que el usuario con id 17 y el usuario con id 9 tienen consumos mayores a sus pagos. Recuerden que el arreglo es pasado como dirección de memoria de su primer elemento a través del primer parámetro de la función.

---

### Ejercicio 4 (2 pts.)

Para una microarquitectura de ciclo simple para un procesador de RISC V, como la que vimos en clase, explicar qué componentes y señales de control están involucrados y cómo modifican el estado del procesador al ejecutar la instrucción `or x4, x5, x6`.

---

## Resolucion — Ejercicio 4 (pags 3-4)

**Diagrama de microarquitectura** (dibujado a mano):

Componentes: PCNext → PC → AD → Memoria de Instruccion → decodificacion → Banco de Registros (AD1=dir(x5), AD2=dir(x6), AD3=dir(x4), WE3, WD3) → Mux(AluSrc) → ALU(AluCon) → Mux(SelectRes) → WD3 del banco de registros. Extensor conectado a la instruccion. Mem de Datos con WE, AD, WD.

Senales de control marcadas en verde: OP, Func3, Func7 → Unidad de control.

**Texto de resolucion:**

Para `or x4, x5, x6`:

- Primero se carga la instruccion "or x4, x5, x6" desde la memoria de instruccion.
- De ahi se "parte" la instruccion: OP, Func3 y Func7 van a la unidad de control y la direccion de x5, x6 y x4 van a AD1, AD2 y AD3 respectivamente. El inmediato NO va al extensor.
- El valor de x5 sale por RD1 y el de x6 por RD2. De ahi el valor de RD2 va a un multiplexor (controlado por la unidad de control). La senal AluSrc tiene que estar en 0.
- Luego pasa por la ALU. De donde la unidad de control tiene que haber mandado por AluCon el valor correspondiente a un or.
- La salida de la ALU pasa por un multiplexor, controlado por la unidad de control. Notar que SelectRes debe estar en 0.
- La salida de dicho multiplexor va a WD3, con WE alta para que se escriba el resultado en la direccion que entra al banco de registros por AD3.

Aclaracion 1: Del esquema se omitio el mecanismo para actualizar el PC ya que no es relevante para lo que pide el ejercicio.
Aclaracion 2: Lo que marque en verde va a la unidad de control.

---

## Resolucion — Ejercicio 3 (pag 5)

**Tamano de la estructura BalanceDeudor:**
- 8 bits para el ID
- 16 bits para consumos
- 16 bits para pagos
- Total: 40 bits = **5 bytes**

**Arreglo de 12 elementos:** 5 bytes × 12 = 60 bytes + el ID nulo (1 byte) = **61 bytes**

**contarDeudores:**

```asm
li   t0, 0          # lo uso de acumulador
for:                # en a0 tengo el puntero al arreglo
lbu  t4, 0(a0)      # cargo el ID en t4
beqz t4, return     # si ID == 0, fin del arreglo
lh   t1, 1(a0)      # cargo el consumo en t1
lh   t2, 3(a0)      # cargo el pago en t2

sub  t3, t2, t1     # t3 <- PAGO - CONSUMO

bgez t3, no_hacer_nada   # si pago >= consumo, no contar

addi t0, t0, 1      # incremento mi acumulador

no_hacer_nada:
addi a0, a0, 5      # para ir al siguiente elemento

j for
return:
mv  a0, t0
ret
```

---

## Resolucion — Ejercicio 2 (pags 6-7)

**inv:**

```asm
inv:
xori a0, a0, -1     # doy vuelta los bits de a0
addi a0, a0, 1
ret
# no toco ninguno de los registros manejados y estoy tomando
# mi unico argumento por a0. Por tanto estoy respetando la convencion.
```

**invertirArreglo:** # a0 = puntero a arreglo, a1 = cant. de elementos

```asm
invertirArreglo:
addi sp, sp, -16    # reservo memoria en el stack
sw   ra, 0(sp)      # guardo ra (para poder respetar la convencion) [①]
sw   s1, 4(sp)      # para poder restaurarlos mas tarde y respetar la convencion
sw   s2, 8(sp)
sw   s3, 12(sp)

mv   s1, a0         # Segun la interfaz lineal de aplicacion luego de la llamada a
mv   s2, a1         # inv no tengo garantia de que [a0, a1] se mantengan [②]
li   s3, 0          # lo uso de indice

for:
beq  s3, s2, return
lw   t0, 0(s1)
mv   a0, t0
jal  inv

sw   a0, 0(s1)
addi s3, s3, 1
addi s1, s1, 4
j    for

return:
lw   ra, 0(sp)      # Restauro todos los registros manejados antes de salir de la funcion
lw   s1, 4(sp)
lw   s2, 8(sp)
lw   s3, 12(sp)
addi sp, sp, 16
ret
```

**① Segun la convencion los registros ra, [s0, s1, ...] son manejados. Esto implica que la funcion llamadora puede suponer que luego de la llamada a la funcion llamada van a tener el mismo valor que antes de entrar a dicha funcion.**

**② Esto lo hice porque mas abajo en el codigo hago una llamada a inv y por la razon mencionada en ①**

---

## Resolucion — Ejercicio 1 (pags 8-9)

**pascal:** # en a0 = Fila, a1 = columna

```asm
pascal:
addi sp, sp, -32
sw   s1, 0(sp)
sw   s2, 4(sp)
sw   s3, 8(sp)
sw   s4, 12(sp)
sw   ra, 16(sp)

bgt  a1, a0, return_0   # if (columna > fila) return 0
li   t0, 1
ble  a1, t0, return_1   # if (columna <= 1) return 1
ble  a0, t0, return_1   # if (fila <= 1) return 1

# caso recursivo
mv   s1, a0             # copio a0 (fila) a s1
mv   s2, a1             # copio a1 (columna) a s2
addi a0, a0, -1         # fila - 1

jal  pascal             # pascal(Fila-1, columna)
mv   s3, a0             # guardo el resultado en s3

addi a0, s1, -1         # fila - 1 (restaurado de s1)
addi a1, s2, -1         # columna - 1
jal  pascal             # pascal(Fila-1, columna-1)
add  a0, a0, s3         # a0 = pascal(fila-1, columna) + pascal(fila-1, columna-1)

j return

return_0: li a0, 0
j return
return_1: li a0, 1
j return

return:
lw   s1, 0(sp)
lw   s2, 4(sp)
lw   s3, 8(sp)
lw   s4, 12(sp)
lw   ra, 16(sp)
addi sp, sp, 32
ret
```
