---
nombre: Arquitectura de Computadoras — Teoria (Parte 1)
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: arquitectura
fuente: raw/clases_teoricas/4.teo_arquitectura_parte_1.pdf
paginas_relacionadas:
  - "[[arquitectura_teoria_pt2]]"
  - "[[arquitectura_cpu_guia]]"
  - "[[programacion_risc_v_guia]]"
---

# Arquitectura de Computadoras — Teoria (Parte 1)

## Concepto y definicion

**Arquitectura de un procesador:** todo aquello con lo que se puede trabajar al escribir un programa — instrucciones, registros y forma de acceder a la memoria. Define la estructura logica y comportamental del procesador.

- La arquitectura NO es la implementacion fisica. Puede haber varias implementaciones de una misma arquitectura (diferentes empresas, distintas familias de chips) que son intercambiables para el programa siempre que respeten la arquitectura.
- Elementos que constituyen una arquitectura: conjunto de instrucciones, conjunto de registros, forma de acceder a la memoria.

**Interaccion con la arquitectura:** escribiendo programas en el lenguaje ensamblador de esa arquitectura (RISC-V en la materia).

---

## Lenguajes de alto y bajo nivel

| Nivel | Descripcion |
|-------|-------------|
| Alto nivel (C, Python) | Independiente de la arquitectura; abstrae variables, estructuras de control, funciones |
| Bajo nivel (ensamblador) | Especifico de la arquitectura; opera directamente con registros, memoria, instrucciones atomicas |

**Cadena de compilacion:**
```
Codigo de alto nivel
       ↓ Compilador
Codigo de bajo nivel (ensamblador .S)
       ↓ Ensamblador
Codigo objeto (.o)
       ↓ Enlazador + bibliotecas
Codigo binario ejecutable (.bin)
```

---

## Cuando se aplica

- Programacion directa en RISC-V (aparece en los parciales historicos rotulados 2P; con el programa vigente entra en tu **parcial unico**)
- Analisis de codigo maquina (decodificacion de instrucciones)
- Comprension del ciclo fetch-decode-execute
- Implementacion de funciones con convencion de llamada

---

## RISC-V — Registros

RISC-V cuenta con **32 registros de 32 bits** implementados como un banco de registros (register file).

| Nombre | Alias | Uso |
|--------|-------|-----|
| x0 | zero | Siempre 0, no escribible |
| x1 | ra | Return address (direccion de retorno) |
| x2 | sp | Stack pointer |
| x5–x7, x28–x31 | t0–t6 | Variables temporarias |
| x8–x9, x18–x27 | s0–s11 | Variables a preservar entre llamadas |
| x10–x17 | a0–a7 | Argumentos / valores de retorno |

**Regla clave:** operaciones aritmetico-logicas solo operan sobre registros. Para operar con datos en memoria, primero cargarlos a registros (`lw`), luego operar, luego guardar (`sw`).

---

## RISC-V — Instrucciones

### Aritmeticas basicas

| Instruccion | Semantica | Ejemplo |
|-------------|-----------|---------|
| `add rd, rs1, rs2` | `rd = rs1 + rs2` | `add s0, s1, s2` |
| `sub rd, rs1, rs2` | `rd = rs1 - rs2` | `sub s0, t0, s3` |
| `addi rd, rs1, imm` | `rd = rs1 + imm` (imm 12 bits con signo) | `addi s0, s0, 4` |
| `mv rd, rs` | `rd = rs` (pseudoinstruccion) | `mv a0, t0` |
| `li rd, imm` | carga inmediato (pseudoinstruccion) | `li t0, 0` |

### Valores inmediatos

- Los inmediatos son de **12 bits** y se extienden en signo a 32 bits antes de operar.
- Se pueden escribir en decimal, hexadecimal (`0x`) o binario (`0b`).

**Cargar constante de 32 bits:** requiere dos instrucciones.
```asm
lui  s2, 0xABCDE    # s2 = 0xABCDE000   (20 bits altos)
addi s2, s2, 0x123  # s2 = 0xABCDE123   (12 bits bajos)
```

**Caso con parte baja negativa** (bit 11 = 1 → extension de signo suma -1 a parte alta):
```asm
# Cargar 0xFEEDA987:
lui  s2, 0xFEEDB    # sumar 1 a parte alta para compensar
addi s2, s2, -1657  # 0x987 = -1657 en C2 de 12 bits
```

### Instrucciones logicas

| Instruccion | Semantica | Uso tipico |
|-------------|-----------|------------|
| `and rd, rs1, rs2` | AND bit a bit | Enmascarar (limpiar bits) |
| `or rd, rs1, rs2` | OR bit a bit | Combinar parte alta + baja |
| `xor rd, rs1, rs2` | XOR bit a bit | Negacion: `xori rd, rs, -1` niega todos los bits |
| `andi rd, rs, imm` | AND con inmediato | `andi s2, t0, 0xFF` → extrae byte bajo |
| `ori rd, rs, imm` | OR con inmediato | |
| `xori rd, rs, imm` | XOR con inmediato | `xori s1, s2, -1` = NOT s2 |

### Instrucciones de desplazamiento

| Instruccion | Semantica | Detalle |
|-------------|-----------|---------|
| `sll rd, rs1, rs2` | shift left logical | completa con 0 a derecha |
| `srl rd, rs1, rs2` | shift right logical | completa con 0 a izquierda |
| `sra rd, rs1, rs2` | shift right arithmetic | replica el MSB (preserva signo) |
| `slli rd, rs, imm` | sll con inmediato de 5 bits | `slli t2, t1, 2` = multiplicar por 4 |
| `srli rd, rs, imm` | srl con inmediato | |
| `srai rd, rs, imm` | sra con inmediato | |

**Trucos frecuentes:**
- `slli rs, rs, k` = multiplicar por $2^k$
- `srli rs, rs, k` = dividir por $2^k$ (sin signo)
- `srai rs, rs, k` = dividir por $2^k$ (con signo, redondeo hacia -∞)
- Extraer byte N: `srli t0, s1, 8*N` + `andi s2, t0, 0xFF`

---

## RISC-V — Memoria

La memoria se direcciona por **bytes** pero se accede tipicamente por **palabras de 32 bits** (4 bytes).

$$\text{word\_address} = \text{indice\_byte\_menos\_significativo}$$
$$\text{word\_number} \times 4 = \text{word\_address}$$

**Entre palabras consecutivas los indices avanzan en 4.**

### Instrucciones de carga/almacenamiento

```
direccion = base + desplazamiento
```
donde `base` = valor de un registro y `desplazamiento` = constante con signo de 12 bits.

| Instruccion | Semantica |
|-------------|-----------|
| `lw rd, offset(rs)` | carga palabra (32 bits) de memoria[rs+offset] en rd |
| `sw rs2, offset(rs1)` | guarda palabra de rs2 en memoria[rs1+offset] |
| `lb rd, offset(rs)` | carga byte (con extension de signo) |
| `lbu rd, offset(rs)` | carga byte (sin signo) |
| `lh rd, offset(rs)` | carga halfword (con extension de signo) |

**Ejemplo — leer arreglo de int:**
```asm
# C: int a = mem[2];
# s3 = puntero a mem, s7 = variable a
lw s7, 8(s3)   # offset = 2 * 4 = 8
```

**Ejemplo — escribir en arreglo:**
```asm
# C: mem[5] = 33;
addi t3, zero, 33
sw   t3, 20(s3)  # offset = 5 * 4 = 20
```

---

## Programa almacenado en memoria

**Principio fundamental:** las instrucciones se almacenan en la memoria del procesador (misma memoria que acceden `lw`/`sw`). Cada instruccion ocupa **32 bits (una palabra)** → las direcciones de instrucciones avanzan en multiplos de 4.

### Ciclo fetch-decode-execute

1. **Fetch:** el procesador lee la instruccion en la direccion indicada por el **program counter (PC)**
2. **Decode:** decodifica la instruccion para configurar el procesador segun su tipo
3. **Execute:** actualiza el estado (registros y/o memoria) segun la semantica de la instruccion
4. **Incrementar PC:** `PC += 4` para la proxima instruccion (salvo saltos)

---

## Control del flujo de ejecucion

Para implementar `if`, `while`, `for`: modificar el valor del PC.

### Saltos condicionales (branch)

Comparan dos operandos; si la condicion se cumple, reemplazan el PC con la direccion de la etiqueta.

| Instruccion | Condicion |
|-------------|-----------|
| `beq rs1, rs2, label` | salta si `rs1 == rs2` |
| `bne rs1, rs2, label` | salta si `rs1 != rs2` |
| `blt rs1, rs2, label` | salta si `rs1 < rs2` (con signo) |
| `bge rs1, rs2, label` | salta si `rs1 >= rs2` (con signo) |
| `bltu rs1, rs2, label` | salta si `rs1 < rs2` (sin signo) |
| `bgeu rs1, rs2, label` | salta si `rs1 >= rs2` (sin signo) |

**Etiquetas:** `nombre:` define la direccion de memoria de la instruccion siguiente. El ensamblador resuelve la etiqueta a una direccion concreta.

**Ejemplo — while:**
```asm
# C: while (pow != 128) { pow *= 2; x++; }
# s0=pow, s1=x, t0=128
addi s0, zero, 1
add  s1, zero, zero
addi t0, zero, 128
while:
  beq  s0, t0, fin
  slli s0, s0, 1    # pow *= 2
  addi s1, s1, 1    # x++
  j while
fin:
```

### Saltos incondicionales

| Instruccion | Semantica |
|-------------|-----------|
| `j label` | PC = address(label) (pseudoinstruccion de `jal zero, label`) |
| `jal rd, label` | rd = PC+4; PC = address(label) (guarda return address) |
| `jalr rd, rs, imm` | rd = PC+4; PC = rs + imm |
| `ret` | PC = ra (pseudoinstruccion de `jalr zero, ra, 0`) |

---

## Lenguaje de maquina — Tipos de instruccion

### Tipo R (Register)
Dos registros fuente `rs1`, `rs2`; un destino `rd`. Campos `op`, `funct7`, `funct3` determinan la instruccion.
```
| funct7[6:0] | rs2[4:0] | rs1[4:0] | funct3[2:0] | rd[4:0] | opcode[6:0] |
```
Ejemplos: `add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`

### Tipo I (Immediate)
Un registro fuente `rs1`, inmediato de 12 bits `imm`, un destino `rd`.
```
| imm[11:0]          | rs1[4:0] | funct3[2:0] | rd[4:0] | opcode[6:0] |
```
Ejemplos: `addi`, `andi`, `ori`, `xori`, `slli`, `srli`, `srai`, `lw`, `lbu`, `lh`, `jalr`

### Tipo S (Store)
Almacenamiento. Inmediato de 12 bits dividido entre bits altos y bajos.
```
| imm[11:5]  | rs2[4:0] | rs1[4:0] | funct3[2:0] | imm[4:0] | opcode[6:0] |
```
Ejemplos: `sw`, `sb`, `sh`

### Tipo B (Branch)
Saltos condicionales. Inmediato de 13 bits (desplazamiento relativo al PC, siempre par → LSB implicito = 0).
```
| imm[12|10:5] | rs2[4:0] | rs1[4:0] | funct3[2:0] | imm[4:1|11] | opcode[6:0] |
```
Ejemplos: `beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu`

### Tipo U (Upper immediate)
Inmediato de 20 bits en bits altos.
```
| imm[31:12]                    | rd[4:0] | opcode[6:0] |
```
Ejemplos: `lui`, `auipc`

### Tipo J (Jump)
Saltos incondicionales. Inmediato de 21 bits (relativo al PC, siempre par).
```
| imm[20|10:1|11|19:12] | rd[4:0] | opcode[6:0] |
```
Ejemplos: `jal`

**Nota de decodificacion:** el inmediato en instrucciones B y J siempre se desplaza 1 bit a izquierda antes de sumarse al PC (las instrucciones estan alineadas a palabras → bit 0 siempre 0, no necesita almacenarse).

---

## Mapa de memoria

El mapa de memoria organiza la memoria principal segun uso (de direcciones altas a bajas):

| Region | Uso |
|--------|-----|
| Direcciones altas | I/O (entrada/salida) |
| Datos dinamicos — stack | Pila (crece hacia abajo) |
| Datos dinamicos — heap | Memoria dinamica (`malloc`/`free`) |
| `.global` / `.data` | Variables y constantes globales |
| `.text` | Codigo binario del programa (instrucciones) |

### Directivas de ensamblado

| Directiva | Descripcion |
|-----------|-------------|
| `.section .text` | Inicio de la seccion de instrucciones |
| `.section .data` | Inicio de la seccion de datos |
| `.global nombre` | Exporta el simbolo `nombre` (visible al enlazador) |
| `.word valor` | Reserva una palabra de 32 bits con ese valor |
| `.byte valor` | Reserva un byte con ese valor |

**Ejemplo:**
```asm
.section .data
largo:   .word 0x4
caracter: .byte 10
arreglo: .word 0xc, 0x34d, 0x1, 0x0

.section .text
# instrucciones...
```

---

## Formulas clave

**Direccion de elemento i de arreglo de int (4 bytes):**
$$\text{offset} = i \times 4$$

**Cargar constante de 32 bits con bit 11 = 1:**
$$\text{lui\_imm} = \lfloor \text{valor} / 4096 \rfloor + 1 \quad \text{(compensar extension de signo)}$$

**PC en salto condicional:**
$$PC_{\text{nuevo}} = PC_{\text{actual}} + \text{offset\_inmediato} \quad \text{(si condicion verdadera)}$$

---

## Propiedades y teoremas

- **Arquitectura vs implementacion:** una arquitectura puede tener multiples implementaciones fisicas; el programa es portable entre ellas.
- **RISC-V es abierta y modular:** ISA libre de royalties, adoptada en industria.
- **Registros son mas rapidos que memoria:** siempre cargar datos de memoria a registros antes de operar.
- **x0 (zero) es hardware zero:** escribir a x0 se descarta. Util para `mv`, `li`, inicializaciones, comparaciones con cero.
- **Convencion de llamada:** argumentos en `a0-a7`, retorno en `a0`, return address en `ra`. Los registros `s0-s11` deben preservarse entre funciones; `t0-t6` son clobbered.

---

## Ver tambien

- [[arquitectura_teoria_pt2]] — Parte 2: llamadas a funcion, stack, structs
- [[programacion_risc_v_guia]] — Guia de ejercicios de programacion RISC-V
- [[representacion_de_informacion_teoria]] — Tipos numericos, C2 (usado en inmediatos con signo)
