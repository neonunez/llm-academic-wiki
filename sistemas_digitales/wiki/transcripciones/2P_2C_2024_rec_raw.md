---
tipo: transcripcion
fuente: raw/parciales/2P/2.parcial_2C_2024_resolucion_recuperatorio.pdf
metodo: claude_vision
paginas: 6
alumno: Giorgi Palazzini / Tomás Agustín (LU 795/23)
---

# Transcripción — 2P Recuperatorio 2C 2024

## Hoja de carátula (pág. 1)

**SISTEMAS DIGITALES — Segundo Recuperatorio**
Segundo Cuatrimestre 2024

Puntajes por ejercicio: Ej.1: 4 | Ej.2: 2 | Ej.3: 4 | Ej.4: 2 | Nota: [ilegible/nulo]
Corrector: [firma]

### Aclaraciones

- Anote apellido, nombre, LU y numere todas las hojas entregadas, entregando los distintos ejercicios en hojas separadas.
- El parcial **no es a libro abierto** pero pueden consultar la hoja de referencia provista por la cátedra.
- Justifique sus respuestas explicando lo que considere necesario en lenguaje natural.
- El parcial se aprueba con 6 y se deben tener ambos parciales aprobados para aprobar la materia (promoción directa).

---

### Ejercicio 1 (2 pts.)

Implemente las funciones definidas en el siguiente bloque de código C en lenguaje ensamblador de RISCV.

```c
int function cantidad_divisores(int k){
    if(k <= 1) return 1;
    return cantidad_divisores_rec(k, k-1);
}
int function cantidad_divisores_rec(int k, int n) {
    if (n == 1) return 1;
    int cantidad = cantidad_divisores_rec(k, n - 1);
    if(k % n == 0){
        cantidad = cantidad + 1;
    }
    return cantidad;
}
int es_primo(int k){
    return cantidad_divisores(k) == 1;
}
```

La función `es_primo` llama a `cantidad_divisores` para devolver 1 si la cantidad de divisores es igual a 1 y 0 en caso contrario. Un número es primo si es divisible (la división entera no produce resto) solamente por el mismo número y por uno. Debe respetar la estructura de llamadas entre funciones incluyendo la implementación recursiva. Recomendamos concentrarse en la traducción a código RISC-V que respete la convención de llamada. Deben explicar en qué registros se almacenan los valores en cada paso y cómo se aseguran que se respeta la convención.

---

### Ejercicio 2 (2 pts.)

Implemente las siguientes funciones en lenguaje ensamblador de RISC-V respetando la convención de llamada presentada en la materia. Describir el comportamiento y cómo se aseguran que se respeta la convención.

- `int es_par(int x) = x % 2 == 0` (chequeo de paridad)
- `void arreglo_par(int arr[], int largo)`: Dado un puntero a un arreglo de enteros de 32 bits y la cantidad de elementos, cambia cada valor del arreglo por un 1 si el elemento era par y por un 0 en caso contrario, deben hacer uso de la función `es_par`.

---

### Ejercicio 3 (4 pts.)

Se tiene una estructura `BalanceDeudor` que contiene el ID del cliente como un entero con signo de 8 bits, la suma de sus consumos como un entero sin signo de 32 bits, la cantidad de pagos realizados como un entero sin signo de 16 bits, la suma de sus pagos realizados como un entero en complemento a dos de 16 bits. Ubicación de los datos de una estructura `BalanceDeudor`:

| Byte   | 0x0000 | 0x0001    | 0x0005      | 0x0007 |
|--------|--------|-----------|-------------|--------|
| Nombre | ID     | Consumos  | Cant. pagos | Pagos  |

En memoria se encuentra un arreglo `balanceDeudores` del tipo `BalanceDeudor` con la forma:

| Dirección | 0x000 | 0x001 | 0x005 | 0x007 | 0x009 | ... | 0x030 | 0x031 | 0x035 | 0x037 | 0x039 |
|-----------|-------|-------|-------|-------|-------|-----|-------|-------|-------|-------|-------|
| Valor     | 17    | 30020 | 2     | -1232 | 6     | ... | 9     | 5878  | 10    | 300   | 0     |

Donde el final del arreglo es demarcado por un ID nulo. Se pide:

- Calcular cuántos bytes ocupa en memoria la estructura `BalanceDeudor` y cuántos bytes un arreglo de tipo `BalanceDeudor` de 32 deudores.
- Escribir una función `contarDeudores(balanceDeudores)` que dada una posición de memoria que indica el comienzo de un arreglo `balanceDeudores` de `BalanceDeudor`, devuelva un entero que indique para cuántas estructuras del arreglo vale que la suma de los consumos (segundo elemento de la estructura) es mayor que la suma de los pagos realizados (cuarto elemento de la estructura).

Ejemplo (con `.data`):
```asm
.data
balanceDeudores: .byte 17
                 .word 30020
                 .half 10
                 .half 1232
                 .byte 6
                 .word 200
                 .half 200
                 .half 200
                 .byte 9
                 .word 5878
                 .half 58
                 .half 300
                 .byte 0     #Declaramos el final del arreglo
.text
contarDeudores:
    ...
```

Para este caso `balanceDeudores` debe devolver 2 ya que el usuario con id 17 y el usuario con id 9 tienen consumos mayores a sus pagos. Recuerden que el arreglo es pasado como dirección de memoria de su primer elemento a través del primer parámetro de la función.

---

### Ejercicio 4 (2 pts.)

Para una microarquitectura de ciclo simple para un procesador de RISC-V, como la que vimos en clase, que debe ejecutar la instrucción `or x4, x5, x6`, ¿qué sucede si `ResultSrc` se encuentra siempre en 1? ¿Y si los bits 24 a 20 de la instrucción están en cero?

---

## Resoluciones (págs. 3–6)

### Ejercicio 1 — Resolución (Hoja 1/4)

Anotaciones del alumno: "para conservar el número, usar t6 o la misma en el stack", "recomendada 16", "convención de llamada", "usar t4/8"

```asm
ES_PRIMO:
    ADDI SP SP -4
    SW RA 0(SP)
    JAL CANTIDAD_DIVISORES      # a0=k → llama cantidad_divisores(k)
    LI T0 1
    BNE A0 T0 FALSE             # si resultado != 1, ir a FALSE
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA

FALSE:
    LI A0 0                     # el primer parámetro es a0
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA

CANTIDAD_DIVISORES:
    ADDI SP SP -4
    SW RA 0(SP)
    LI T0 1
    BLE A0 T0 CASO_UNO          # hasta a0 = 1
    ADDI A1 A0 -1               # [inferido del C: n = k-1]
    JAL CANTIDAD_DIVISORES_REC
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA

CASO_UNO:
    LI A0 1
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA

CANTIDAD_DIVISORES_REC:
    ADDI SP SP -8
    LI T0 1
    BEQ A1 T0 CASO_UNO_REC     # si n==1 → base case
    SW RA 0(SP)
    SW A1 4(SP)
    ADDI A1 A1 -1               # n-1
    JAL CANTIDAD_DIVISORES_REC
    LW A1 4(SP)
    LW RA 0(SP)
    REM A2 A0 A1                # k % n (A0=k, A1=n) [FORMULA ILEGIBLE — parte del stack]
    BEQ A2 ZERO CASO_CERO_REC
    ADDI SP SP 8
    JR RA

CASO_CERO_REC:                  # si k%n == 0
    ADDI A3 A3 1                # cantidad++  [nota: posible error — debería ser A0]
    ADDI SP SP 8
    JR RA

CASO_UNO_REC:
    [FORMULA ILEGIBLE — ver fuente]
```

Nota del corrector: calificación parcial por ejercicio (marcas de verificación visibles en instrucciones clave).

---

### Ejercicio 2 — Resolución (Hoja 2/4)

Anotación alumno: "Toma el valor de A0 y devuelve 1 si es par, 0 si es impar"

```asm
ES_PAR:
    ANDI T0 A0 1        # T0 = A0 & 1 (bit menos significativo)
    XORI A0 T0 1        # A0 = T0 XOR 1 → 1 si par, 0 si impar
    JR RA

ARREGLO_PAR:
    # → habiendo cargado el arreglo en A0 y la cantidad en A1
    ADDI SP SP -8
    SW RA 0(SP)         # reservo espacio en stack pointer, cargo el RA
    LW T0 0(A0)         # y el elemento del arreglo, me fijo si hay elementos todavía
    SW T0 4(SP)
    ADDI A1 A1 -1
    BEQ ZERO A1 FIN_CICLO   # actualizo la dirección al próximo elemento y repito
    ADDI A0 A0 4            # hasta que no haya más
    JAL ARREGLO_PAR
    MV S0 A0            # guardo la dirección en S0
    LW A0 4(SP)         # cargo el elemento guardado en el SP a A0
    JAL ES_PAR          # veo si es par
    SW A0 0(S0)         # añado el resultado a la dirección en S0
    ADDI S0 S0 -4       # voy al elemento anterior
    MV A0 S0            # paso la dirección a A0
    LW RA 0(SP)         # cargo el RA del SP, lo actualizo y voy al RA
    ADDI SP SP 8
    JR RA

FIN_CICLO:
    JR RA
```

Anotación: "Cuando termina de ejecutarse queda en A0 la dirección [del primer elemento del] arreglo con los elementos actualizados"
Nota del corrector: calificación 2 para este ejercicio (al 1er elemento deja dirección en A0).

---

### Ejercicio 3 — Resolución (Hoja 3/4)

**Parte a):** La estructura `BalanceDeudor` ocupa **9 bytes**. Un arreglo de tipo `BalanceDeudor` con 32 deudores ocupa **289 bytes** (288 = 9·32 + 1 byte nulo).

**Parte b):** contarDeudores

Anotación alumno: "Cargo en A0 el arreglo. Veo si el bit es nulo, si no lo es reservo memoria en el SP, cargo el RA, los consumos y los pagos. Repito hasta llegar al ID nulo y ahí actualizo en cargo cero en A0 para inicializar el contador."

"Cargo los consumos y los pagos en T0 y T1 respectivamente. Si T1 es menor a T0, sumo al contador, cargo el RA guardado en el SP, actualizo el SP y retorno a la posición del [RA]."

```asm
CONTAR_DEUDORES:
    LB T0 0(A0)              # cargo el ID (byte en offset 0)
    BEQ T0 ZERO FIN_CICLO   # si ID es nulo, fin (centinela)
    ADDI SP SP -12
    SW RA 0(SP)              # guardo RA
    LW T0 1(A0)              # consumos (word en offset 1)
    SW T0 4(SP)              # los guardo en stack
    LH T0 7(A0)              # pagos (half en offset 7)  [o LW — ilegible]
    SH T0 8(SP)              # los guardo en stack
    ADDI A0 A0 9             # avanzo al siguiente elemento (struct = 9 bytes)
    JAL CONTAR_DEUDORES      # llamada recursiva
    LW T0 4(SP)              # recupero consumos
    LH T1 8(SP)              # recupero pagos
    BLT T1 T0 SUMADOR        # si pagos < consumos → sumar al contador
    LW RA 0(SP)
    ADDI SP SP 12
    JR RA

SUMADOR:
    ADDI A0 A0 1             # contador++
    LW RA 0(SP)
    ADDI SP SP 12
    JR RA

FIN_CICLO:
    ADDI A0 ZERO 0           # inicializar contador en 0 (retorno base)
    JR RA
```

---

### Ejercicio 4 — Resolución (Hoja 4/4)

**Parte a — ResultSrc siempre en 1:**

"Si ResultSrc está siempre en 1 entonces el multiplexor que decide entre tomar el dato de Data Memory o la ALU que calcula entre los dos registros fuente o el registro y el inmediato, decide siempre tomar de la ALU."

[Nota: la respuesta parece invertida — ResultSrc=1 selecciona Data Memory, no ALU. Posible error del alumno.]

**Parte b — Bits 24 a 20 en cero:**

"Si los bits entre 24 y 20 son todos ceros, se guarda en [el destino] el valor que hay [ilegible] en el registro que indican los bits entre 19 y 15, ya que es un OR entre un valor y cero."

[Los bits 24–20 codifican rs2. Si rs2=x0 (registro cero), `or x4, x5, x0` = x5 | 0 = x5.]
