---
tipo: transcripcion
fuente: raw/parciales/2P/2.parcial_1C_2025_resolucion_(1).pdf
metodo: claude_vision
fecha_transcripcion: 2026-04-18
nota_alumno: 10
---

# Transcripcion raw — 2do Parcial SD 1C 2025 (resolucion 1)

**Alumno:** ITTIG, Ernesto | LU: 685/24 | Turno: M | Hojas: 3
**Nota:** Ej.1: B | Ej.2: B | Ej.3: B | Total: 10 (Molteo [sic])
**Fecha:** 19/06/2025

---

## Pagina 1 — Enunciado

**SISTEMAS DIGITALES - 1C 2025 — 2do Parcial — 19/06/2025**

**Aclaraciones:**
- Anote apellido, nombre, LU y numere *todas* las hojas entregadas.
- Cada ejercicio sera calificado con una de las siguientes tres notas: Bien, Regular o Mal. La division de los ejercicios en incisos es meramente orientativa. Los ejercicios se calificaran globalmente.
- El parcial **no es a libro abierto**, solo se podran utilizar las hojas que son entregadas como enunciado.
- Un resultado sin suficiente justificacion equivale a un ejercicio no resuelto.
- El parcial se aprueba con al menos dos ejercicios Bien y uno Regular. Para obtener un Regular es necesario demostrar conocimientos sobre el tema del ejercicio.

---

**Ejercicio 1** — Implemente la funcion `rec` en el lenguaje ensamblador RISC V de forma recursiva, respete la convencion de llamada presentada en la materia, explique el uso que le dara a cada registro y como se asegura que sus valores se preservan antes y despues de cada llamada a funcion. No deben implementar la version iterativa, debe ser recursiva, en caso contrario se considera desaprobado el ejercicio. Pueden usar la instruccion `mul`.

$$rec(n) = \begin{cases} 0 & \text{si } n = 0 \\ 1 & \text{si } n = 1 \\ 2 * rec(n-1) + 3 * rec(n-2) & \text{si } n > 1 \end{cases}$$

Guia de resolucion (opcional):
- Escriba una version de pseudocodigo.
- Transforme cada caso a su equivalente de operaciones atomicas (descomponga las operaciones logicas, aritmeticas y llamadas a funcion).
- Identifique los registros a emplear para cada dato.
- Si debe preservar algun registro para respetar la convencion, indique que mecanismo utilizara.
- Defina un flujo de ejecucion tentativo.

**Importante:** Justifique sus respuestas.

---

**Ejercicio 2** — Para entender el balance del sistema previsional contamos con un arreglo que contiene una estructura de aportantes con su edad, cantidad de anos de aportes y pesos que aportaron al sistema.

Se cuenta con un arreglo `aportantes` que contiene una cantidad fija cuyo tamano esta definido por la constante `largo`. Cada aportante se define como una estructura de cuatro bytes, donde el primer byte determina la **edad** como entero sin signo, el segundo byte determina la cantidad de anos de aportes como un entero sin signo y los siguientes dos bytes (half word) determinan la cantidad de pesos que aportaron al sistema.

Escriba un programa que calcule el aporte promedio para las personas cuya edad sea mayor o igual a 65 anos.

Ejemplo:

| Direccion | 0x0000 | 0x0001 | 0x0002 | 0x0004 | 0x0005 | 0x0006 |
|---|---|---|---|---|---|---|
| aportantes | 66 | 43 | 5000 | 32 | 4 | -500 |
|  | 0x0008 | 0x0009 | 0x000A | 0x000C | 0x000D | 0x000E |
|  | 70 | 40 | -1000 | 25 | 5 | 200 |

Noten que las direcciones estan en hexadecimal (por eso el prefijo `0x`) y los valores en decimal. En este caso tendriamos que sumar los aportes del primer y tercer elemento por tener edades mayores a 65 y calcular el promedio que seria de 2000 pesos.

Esqueleto de programa:
```asm
.data:
aportantes:
    .byte 66, 43
    .half 5000
    .byte 32, 4
    .half -500
    .byte 70, 40
    .half -1000
    .byte 25, 5
    .half 200
largo: .byte 4

.text
# Escribir el programa aca.
```

**Importante:** Justifique sus respuestas.

---

**Ejercicio 3** — Dado el siguiente datapath de la instruccion `beq` que se detalla, explique como se calcula la salida del extensor de signo para este caso. Justifique cual seria la direccion de la proxima instruccion a ejecutar. ¿Que funcion cumplen las senales PCSrc, ImmSrc, ALUSrc, ALUControl[2:0]? ¿Que componente define los valores de estas senales? **Importante:** Justifique sus respuestas.

[Datapath diagram: PC=0x1000, PCNext MUX, Instruction Memory, Register File (A1=rs1=x4, A2=rs2=x4, WE3, RD1, RD2, WD3), ALU (SrcA, SrcB con MUX, Zero=1, ALUResult), ImmExt/Extend=0xFFFFFFF4, PCPlus4=0x1010, PCTarget=0x1000]

Senales mostradas: PCSrc=1, RegWrite=0, ImmSrc=10, ALUSrc=0, ALUControl[2:0]=001, MemWrite=0, ResultSrc=x

| Address | Instruction | Type | Fields | Machine Language |
|---|---|---|---|---|
| 0x100C | beq x4, x4, L7 | B | imm[12,10:5]=1111111 00100, rs2=00100, rs1=00100, funct3=000, imm[4:1,11]=10101, op=1100011 | FE420AE3 |

---

## Pagina 2 — Resolucion Ejercicio 2 (y enunciado continuacion)

*(continuacion enunciado Ej.2 ya transcripto arriba)*

**Hoja N° 2 de 3 — Ernesto ITTIG — 2° Parcial SD — 16/6/2025**

**Ejercicio 2:**

```
struct Aportante { uint8_t edad; uint8_t anos; int16_t aportes; }
Se accede con: 0(reg), 1(reg), 2(reg)
Se incrementa de a 4.
```

Algoritmo en PSEUDO-C:
```
Aportante* arr; int largo; int suma = 0, n = 0;
while (largo > 0) {
    if (arr->edad >= 65) {
        suma += arr->aportes;
        n += 1;
    }
    arr += 1;  // le sumo 4 bytes
    largo -= 1;
}
resultado = suma / n;
```

Registros:
- a0 ← arr
- a1 ← largo
- t0 ← suma
- t1 ← n

Resolucion en RISC-V:

```asm
.data
aportantes:
    # etc...
largo: .byte 4

.text
    la a0, aportantes       # arr → a0
    li t0,0  la a1, largo   # [li t0,0 y li t1,0]
    li t1,0  lbu a1, 0(a1)  # largo → a1
while_0:
    beqz a1, end_while_0    # while(largo > 0)
    li t2, 65
    lbu t3, 0(a0)           # arr->edad (1 byte sin signo)
    blt t3, t2, else_0      # if (arr->edad >= 65)
    lh t3, 2(a0)            # arr->aportes (half word, offset 2)
    add t0, t0, t3          # suma += arr->aportes
    addi t1, t1, 1          # n += 1
else_0:
    addi a0, a0, 4          # arr += 1 (cada Aportante son 4 bytes)
    addi a1, a1, -1         # largo -= 1
    j while_0
end_while_0:
    div a0, t0, t1          # resultado = suma/n, el resultado queda en a0
fin:
    j fin                   # halt
```

---

## Pagina 3 — Resolucion Ejercicio 1 y Ejercicio 3

**Hoja N° 1 de 3 — Ernesto ITTIG — 2° Parcial SD — 16/6/2025**

*(Nota: la numeracion de hojas del alumno no coincide con el orden del PDF)*

**Ejercicio 1:**

Algoritmo para rec en PSEUDO-C:
```c
int rec(int n) {
    if (n <= 1)
        return n;
    int resultado = rec(n-1);
    resultado = 2 * resultado;
    int tmp = rec(n-2);
    tmp = 3 * tmp;
    return resultado + tmp;
}
```

Registros: s0 para n, s1 para resultado.
"Como son registros permanentes, los guardare en el stack en el prologo y luego los restaurare en el epilogo."

```
12(sp) ← ra
8(sp) ← s0
4(sp) ← s1
```

Resolucion en ensamblador RISC-V:
```asm
rec:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    # Fin prologo
    li t0, 1
    bgt a0, t0, L_else_0    # if (n <= 1)
    j L_return_0             # return n
L_else_0:
    mv s0, a0               # s0 = n
    addi a0, s0, -1
    li t0, 2
    jal rec                 # a0 = rec(n-1)
    mul s1, a0, t0          # s1 = 2 * rec(n-1) = resultado
    addi a0, s0, -2
    jal rec                 # a0 = rec(n-2)
    li t0, 3
    mul a0, a0, t0          # a0 = 3 * rec(n-2)
    add a0, a0, s1          # a0 = 3*rec(n-2) + 2*rec(n-1) = return resultado+tmp
L_return_0:
    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    ret
```

---

**Hoja N° 3 de 3 — Ernesto ITTIG — 2° Parcial SD — 16/6/2025**

**Ejercicio 3:**

"Como la senal de ImmSrc vale 10, la instruccion se interpreta como Tipo B y el extensor la decodifica de la siguiente manera:"

Bits de instruccion:
```
posicion instruccion: [31] [30:25]    [11:8]  [7]
bits del inmediato:  [12] [10:5]     [4:1]   [11]
                      vale 0 si [12]=0    = 0 siempre
                      vale 1 si [12]=1
```

"En este caso:"
```
bit:  31 30        25      11    8  7  4
val:   1  1 1 1 1 1 1  ...  1 0 1 0  1  ...
```

"pasa a:"
```
(signo extendido) ... 1  1 1 1 1 1 1 1 1 1 0 1 0 0[bit0=0]  = 0xFFFFFFF4 = -12
```

"Como el valor de PCSrc es 1, el multiplexor antes del registro del PC selecciona el valor de PCTarget, que es la suma del PC actual con el inmediato extendido: 0x100C - 12 = 0x1000. La proxima instruccion a ejecutar sera la que se encuentre en la posicion 0x1000 de memoria."

**Las senales:**

- **PCSrc:** elige el proximo valor del PC (sumar 4 o saltar). En este caso elige PCTarget (saltar).
- **ImmSrc:** determina como decodificar y extender el inmediato. En este caso es instruccion tipo B.
- **ALUSrc:** determina el origen del segundo operando de la ALU (registro o imm). En este caso toma el registro.
- **ALUControl:** determina que operacion debe realizar la ALU. En este caso es una comparacion (==).

"La ALU tiene +, -, AND, OR. == lo hace restando y comparando a 0."

"Existe un componente, llamado controlador de senales, que obtiene el valor de las senales a partir de los bits de la instruccion proveniente de la memoria. Se subdivide en 2 partes:
- Un decodificador, que a partir del opcode [6:0] determina los valores de RegWrite, ImmSrc, ALUSrc, MemWrite y ResultSrc. Tambien da una senal de Branch y otra para el siguiente:
- Un controlador de ALU, que a partir de funct3 y funct7 (14:12 y 31:25) y la senal del decodificador, determina el valor de ALUControl."

"Finalmente PCSrc = Branch AND Zero (de la ALU)."
