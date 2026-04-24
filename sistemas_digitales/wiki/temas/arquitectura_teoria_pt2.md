---
nombre: Arquitectura de Computadoras — Teoria (Parte 2)
parcial: 2P
tipo: teoria
tema: arquitectura, programacion_risc_v
fuente: raw/clases_teoricas/4.teo_arquitectura_parte_2.pdf
paginas_relacionadas:
  - "[[arquitectura_teoria_pt1]]"
  - "[[temas/microarquitectura_teoria]]"
---

# Arquitectura de Computadoras — Teoria (Parte 2)

Fuente: `raw/clases_teoricas/4.teo_arquitectura_parte_2.pdf` — 74 pags, slides Beamer 1C 2025.

Continua desde [[arquitectura_teoria_pt1]]. Temas: acceso a memoria y estructuras, interfaz binaria de aplicacion (ABI), uso de la pila (stack), pseudoinstrucciones.

---

## Concepto y definicion

### Acceso a memoria y estructuras

**Byte addressing.**
RISC-V usa indices de 32 bits (hasta $2^{32} = 4{.}294{.}967{.}296$ posiciones), donde cada indice apunta a un **byte** en particular. Entre dos palabras de 32 bits consecutivas, los indices avanzan en **4 unidades**.

**Direccion de palabra (word address):** corresponde al indice del byte menos significativo (LSB) de esa palabra. El LSB esta a la derecha (little-endian): el byte menos significativo tiene la direccion menor.

**Estructura de arreglos.**
Un arreglo ubica elementos del mismo tamaño en posiciones consecutivas de memoria. Para acceder al i-esimo elemento:

$$\text{dir}_{elem[i]} = \text{base} + \text{tamaño} \times i$$

Ejemplo: arreglo `scores[200]` de 32-bit (4 bytes/elem) con base `0x174300A0`. Elemento 199:

$$0x174300A0 + 4 \times 198 = 0x174303B8$$

En ensamblador, el patron es: `slli t0, i, 2` (multiplica por 4) + `add t0, t0, base` + `lw/sw`.

---

## Interfaz binaria de aplicacion (ABI)

### Que es la ABI

La **ABI (Application Binary Interface)** es el contrato que define como se realizan las llamadas a funcion para una arquitectura. Lo deben respetar:
- Programadores en ensamblador RISC-V
- Compiladores de lenguajes de alto nivel
- Llamadas al sistema y bibliotecas compartidas

### Registros de argumentos y retorno

| Registros | Uso |
|-----------|-----|
| `a0`–`a7` | Argumentos (la llamadora carga los argumentos antes de `jal`) |
| `a0` | Valor de retorno (la llamada copia el resultado a `a0` antes de `jr ra`) |
| `ra` | Direccion de retorno (la llamadora lo setea con `jal`) |

### Instruccion de llamada: `jal`

```asm
jal ra, funcion    # PC → ra (guarda PC+4), salta a etiqueta
jr ra              # salta a la direccion en ra (retorno)
```

`jal ra, foo` equivale a: guardar `PC+4` en `ra`, luego saltar a `foo`.

### Preservacion de registros

| Tipo | Registros | Responsable |
|------|-----------|-------------|
| Temporarios (caller-saved) | `t0`–`t6`, `a0`–`a7` | **Llamadora** los guarda antes de `jal` si los necesita al retornar |
| Permanentes (callee-saved) | `s0`–`s11`, `ra` | **Llamada** los guarda al inicio y restaura antes de `jr ra` |

**Regla critica:** la funcion llamada NO debe modificar los registros `s0–s11` ni `ra` sin guardarlos antes en la pila.

---

## Uso de la pila (stack)

### Que es la pila

La pila es:
- Una region de memoria entre una direccion alta y el **stack pointer** (`sp`).
- Semantica **LIFO** (Last In, First Out).
- Crece hacia **abajo** (cada push decrementa `sp`).

### Stack pointer (sp)

`sp` apunta siempre al **ultimo elemento cargado** (tope de la pila).

**Convencion RISC-V:** `sp` debe estar siempre alineado a **16 bytes**:

$$sp \mod 16 = 0$$

### Operaciones push y pop

**Push** (apilar — guardar en pila):
```asm
addi sp, sp, -16    # reservar espacio (multiplo de 16)
sw a0, 4(sp)        # guardar a0
sw ra, 0(sp)        # guardar ra
```

**Pop** (desapilar — restaurar desde pila):
```asm
lw a0, 4(sp)        # restaurar a0
lw ra, 0(sp)        # restaurar ra
addi sp, sp, 16     # liberar espacio
```

### Stack frame (marco de pila)

Cada llamada a funcion usa una porcion de la pila para preservar su estado. A ese bloque se lo llama **stack frame**. Al retornar (`jr ra`) el frame se libera restaurando `sp`.

---

## Formulas clave

### Acceso a elemento de arreglo

$$\text{dir} = \text{base} + 4 \times i \quad \text{(elementos de 32 bits)}$$

Implementacion tipica:
```asm
slli t0, i, 2         # t0 = i * 4
add  t0, t0, base     # t0 = base + i*4
lw   t1, 0(t0)        # t1 = mem[t0]
```

### Patron de llamada a funcion

```asm
# LLAMADORA: antes de jal
addi a0, zero, arg0   # cargar argumentos en a0..a7
addi a1, zero, arg1
jal ra, funcion        # llamar (guarda PC+4 en ra)
# a0 tiene el retorno

# LLAMADA: inicio
addi sp, sp, -16       # reservar stack frame
sw   ra, 0(sp)         # guardar ra (si llama a otra funcion)
sw   s0, 4(sp)         # guardar s0..sN si los usa
...                    # cuerpo
lw   ra, 0(sp)         # restaurar ra
lw   s0, 4(sp)         # restaurar s0..sN
addi sp, sp, 16        # liberar stack frame
jr   ra                # retornar
```

### Ejemplo recursivo: factorial

```c
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n-1);
}
```

```asm
factorial:  addi sp, sp, -16
            sw   a0, 4(sp)     # guarda n (a0)
            sw   ra, 0(sp)     # guarda ra
            addi t0, zero, 1
            bgt  a0, t0, else
            addi a0, zero, 1   # retorna 1
            addi sp, sp, 16
            jr   ra
else:       addi a0, a0, -1
            jal  factorial     # factorial(n-1) → a0
            lw   t1, 4(sp)     # restaura n en t1
            lw   ra, 0(sp)     # restaura ra
            addi sp, sp, 16
            mul  a0, t1, a0    # n * factorial(n-1)
            jr   ra
```

---

## Propiedades y teoremas

### Pseudoinstrucciones

Instrucciones que el ensamblador traduce a instrucciones reales. No son instrucciones de hardware — el procesador no las conoce directamente. Ejemplos frecuentes:

| Pseudoinstruccion | Expansion real |
|-------------------|----------------|
| `li rd, imm` | `addi rd, zero, imm` (si imm cabe en 12 bits) o `lui+addi` |
| `mv rd, rs` | `add rd, rs, zero` |
| `j label` | `jal zero, label` |
| `ret` | `jalr zero, ra, 0` (equivale a `jr ra`) |
| `call label` | `auipc ra, ...` + `jalr ra, ...` |
| `nop` | `addi zero, zero, 0` |

### Reglas de llamada resumidas

1. **Llamadora (antes de `jal`):** cargar argumentos en `a0`–`a7`; guardar en pila los temporarios (`t0`–`t6`, `a0`–`a7`) que necesite al retornar.
2. **Llamada (al inicio):** si usa registros permanentes (`s0`–`s11`, `ra`), guardarlos en pila.
3. **Llamada (al retornar):** restaurar permanentes; copiar resultado a `a0`; ejecutar `jr ra`.
4. **`sp` siempre alineado a 16 bytes** — reservar/liberar en multiplos de 16.

---

## Cuando se aplica

- **Programacion RISC-V con funciones:** toda funcion que llame a otra o que use registros permanentes necesita push/pop de la pila.
- **Funciones recursivas:** cada nivel de recursion crea un stack frame propio.
- **Acceso a arreglos y structs:** patron `slli + add + lw/sw`.
- **Parciales 2P:** ejercicios de traduccion C → RISC-V con funciones, recursion y estructuras.

---

## Ver tambien

- [[arquitectura_teoria_pt1]] — fundamentos RISC-V, instrucciones basicas, tipos R/I/S/B/U/J
- [[temas/microarquitectura_teoria]] — implementacion del datapath
