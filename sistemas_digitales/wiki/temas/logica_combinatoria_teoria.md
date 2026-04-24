---
nombre: Logica Combinatoria — Teoria
parcial: 1P
tipo: teoria
tema: logica_combinatoria
fuente: raw/clases_teoricas/2.teo_logica_combinatoria.pdf
paginas_relacionadas:
  - "[[representacion_de_informacion_teoria]]"
  - "[[logica_combinatoria_guia]]"
  - "[[hdl_system_verilog]]"
  - "[[parciales_analizados/1P_1C_2025]]"
  - "[[parciales_analizados/1P_2C_2024]]"
  - "[[parciales_analizados/1P_2C_2024_recuperatorio]]"
---

# Logica Combinatoria — Teoria

Fuente: raw/clases_teoricas/2.teo_logica_combinatoria.pdf (93 pags, 1C 2025)
Extraccion: pdftotext (21966 chars). Diagramas de circuitos: ver PDF original (no extraibles).

---

## Concepto y definicion

Un **circuito combinatorio** es un circuito digital cuya salida en todo momento depende exclusivamente de la combinacion actual de entradas — sin memoria de estados previos. Las compuertas son modelos idealizados de dispositivos electronicos que realizan operaciones booleanas.

Los circuitos combinatorios pueden describirse mediante:
- **Tabla de verdad** — enumeracion de todas las combinaciones de entradas y sus salidas
- **Expresion algebraica** — formula booleana
- **Diagrama de compuertas** — representacion grafica
- **HDL** (Hardware Description Language), ej. SystemVerilog

---

## Algebra de Boole

### Axiomas

| Axioma | Enunciado |
|--------|-----------|
| A1 | Existen dos elementos: $X = 1$ si $X \neq 0$, o $X = 0$ si $X \neq 1$ |
| A2 | Existe el operador negacion: si $X = 1 \Rightarrow \overline{X} = 0$ |
| A3 | $0 \cdot 0 = 0$ ; $1 + 1 = 1$ |
| A4 | $1 \cdot 1 = 1$ ; $0 + 0 = 0$ |
| A5 | $0 \cdot 1 = 1 \cdot 0 = 0$ ; $0 + 1 = 1 + 0 = 1$ |

### Propiedades (derivadas de axiomas)

| Propiedad | AND | OR |
|-----------|-----|----|
| Identidad | $1 \cdot A = A$ | $0 + A = A$ |
| Nulo | $0 \cdot A = 0$ | $1 + A = 1$ |
| Idempotencia | $A \cdot A = A$ | $A + A = A$ |
| Inverso | $A \cdot \overline{A} = 0$ | $A + \overline{A} = 1$ |
| Conmutatividad | $A \cdot B = B \cdot A$ | $A + B = B + A$ |
| Asociatividad | $(A \cdot B) \cdot C = A \cdot (B \cdot C)$ | $(A + B) + C = A + (B + C)$ |
| Distributividad | $A + (B \cdot C) = (A + B) \cdot (A + C)$ | $A \cdot (B + C) = A \cdot B + A \cdot C$ |
| Absorcion | $A \cdot (A + B) = A$ | $A + A \cdot B = A$ |
| De Morgan | $\overline{A \cdot B} = \overline{A} + \overline{B}$ | $\overline{A + B} = \overline{A} \cdot \overline{B}$ |

### Notacion equivalente

$$A + B \equiv A \text{ OR } B$$
$$A \cdot B \equiv AB \equiv A \text{ AND } B$$
$$\overline{A} \equiv \text{NOT } A$$

---

## Compuertas basicas

### NOT
| A | NOT A |
|---|-------|
| 0 | 1 |
| 1 | 0 |

SystemVerilog: `assign o = ~a;`

### AND
| A | B | A AND B |
|---|---|---------|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

SystemVerilog: `assign o = a & b;`

### OR
| A | B | A OR B |
|---|---|--------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

SystemVerilog: `assign o = a | b;`

### XOR (OR-EXCLUSIVA)
| A | B | A XOR B |
|---|---|---------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

SystemVerilog: `assign o = a ^ b;`

---

## Entradas y salidas — Categorias

Los circuitos pueden verse desde dos perspectivas:
- **Caja blanca:** vista interna — se ven todas las compuertas
- **Caja negra:** vista externa — solo entradas y salidas (interfaz)

Las entradas y salidas se clasifican segun su funcion:
- **Datos:** valores sobre los que opera el circuito
- **Control:** seleccionan el comportamiento (ej. opcode de una ALU)

Ejemplo historico: ALU 74181 — entradas de datos (operandoZ, operandoY), entradas de control (opcode), salidas de datos (salida), salida de estado (overflow).

```systemverilog
module ALU #(parameter DATA_WIDTH = 16)
  ( input  [DATA_WIDTH-1:0] operandoZ,
    input  [DATA_WIDTH-1:0] operandoY,
    input  [2:0]            opcode,
    output [DATA_WIDTH-1:0] salidas,
    output                  overflow );
endmodule;
```

---

## Suma de Productos (SDP) — Mecanismo de traduccion

**Objetivo:** dada una formula logica $\varphi(x_1, \ldots, x_n)$, construir un circuito combinatorio equivalente.

**Procedimiento:**

1. Construir la tabla de verdad con $2^n$ filas
2. Tomar solo las filas donde $\varphi = 1$
3. Por cada fila $i$ con $\varphi = 1$: construir el **mintermino** $t_i$ como conjuncion (AND) de todas las variables — negada si su valor era 0, sin negar si era 1
4. La funcion es la disyuncion (OR) de todos los minterminos: $\varphi' = t_i \vee t_j \vee \ldots$

**Ejemplo:** $F = \overline{X + Y}$ (XNOR de X con Y)

| X | Y | F |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

Minterminos: $t_1 = \overline{x} \cdot \overline{y}$, $t_3 = x \cdot \overline{y}$, $t_4 = x \cdot y$

$$\varphi' = (\overline{x} \cdot \overline{y}) \vee (x \cdot \overline{y}) \vee (x \cdot y)$$

> **Propiedad:** La SDP siempre existe y es siempre implementable → cualquier funcion booleana es realizable con AND + OR + NOT.

---

## Circuitos combinatorios estandar

### Half Adder (Sumador de 1 bit)

Entradas: A, B (1 bit c/u). Salidas: Sum, Carry.

| A | B | Sum | Carry |
|---|---|-----|-------|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |

$$\text{Sum} = A \oplus B \qquad \text{Carry} = A \cdot B$$

### Full Adder (Sumador Completo)

Entradas: A, B, $C_{in}$. Salidas: S, $C_{out}$.

| $C_{in}$ | A | B | S | $C_{out}$ |
|----------|---|---|---|-----------|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |

Implementacion modular: 2 Half Adders + 1 compuerta OR.

$$S = A \oplus B \oplus C_{in} \qquad C_{out} = (A \cdot B) + (C_{in} \cdot (A \oplus B))$$

### Shift Izquierda-Derecha (Shift LR) de k bits

Circuito de $k+1$ entradas $(e_k, \ldots, e_0)$ y $k$ salidas $(s_{k-1}, \ldots, s_0)$:
- Si $e_k = 1$ (shift izquierda): $s_i = e_{i-1}$ para $0 < i < k$, $s_0 = 0$
- Si $e_k = 0$ (shift derecha): $s_i = e_{i+1}$ para $0 \leq i < k-1$, $s_{k-1} = 0$

Para 3 bits, implementacion con MUX (controlado por $e_3$):

$$s_2 = e_3 \cdot e_1 \qquad s_1 = e_3 \cdot e_0 + \overline{e_3} \cdot e_2 \qquad s_0 = \overline{e_3} \cdot e_1$$

Ejemplos: `shift_lr(1, 011) = 110`, `shift_lr(0, 011) = 001`, `shift_lr(1, 100) = 000`

### Multiplexor (MUX)

Las lineas de control $c$ seleccionan cual de las entradas $e$ se conecta a la salida $s$.
- $n$ lineas de control → $2^n$ entradas seleccionables

### Demultiplexor (DEMUX)

Las lineas de control $c$ seleccionan a cual de las salidas $s$ se dirige el valor de $e$.

### Codificador

Cada combinacion de las lineas de entrada corresponde a una unica linea de salida en alto.
(Inverso del decodificador.)

### Decodificador

Una y solo una linea en alto de entrada corresponde a una combinacion especifica en la salida.
Util para decodificacion de instrucciones, seleccion de memoria, etc.

---

## Timing — Propagacion de senales

**Las compuertas no son instantaneas.** Cada compuerta introduce una demora de propagacion.

**Latencia de un circuito combinatorio:** tiempo que tarda la salida en estabilizarse = profundidad maxima (numero de capas de compuertas en el camino critico) × demora por compuerta.

**Ejemplo Shift LR (3 bits, 10ps por compuerta):**
- Profundidad maxima: 3 capas
- Tiempo minimo de espera: $3 \times 10\text{ps} = 30\text{ps}$

> **Solucion al problema de timing:** circuitos **secuenciales** (con registros que sincronizan la lectura de salidas). Ver [[logica_secuencial_teoria]].

---

## Formulas clave

$$\text{SDP}: \varphi = \bigvee_{i : \varphi(i) = 1} \left(\bigwedge_{j=1}^{n} l_{ij}\right) \quad \text{donde } l_{ij} = \begin{cases} x_j & \text{si } x_j^{(i)} = 1 \\ \overline{x_j} & \text{si } x_j^{(i)} = 0 \end{cases}$$

$$\text{De Morgan: } \overline{A \cdot B} = \overline{A} + \overline{B} \qquad \overline{A + B} = \overline{A} \cdot \overline{B}$$

$$\text{Distributiva: } A \cdot (B + C) = A \cdot B + A \cdot C \qquad A + (B \cdot C) = (A + B) \cdot (A + C)$$

$$\text{Absorcion: } A + A \cdot B = A \qquad A \cdot (A + B) = A$$

$$\text{Inverso: } A + \overline{A} = 1 \qquad A \cdot \overline{A} = 0$$

---

## Demostracion de ejemplo (Ejercicio 0)

Demostrar: $\overline{X + Y} = \overline{(X \cdot Y)} \cdot Z + X \cdot Z + \overline{(Y + Z)}$

```
(X·Y)·Z + X·Z + (Y+Z)       ← De Morgan sobre (Y+Z) → Y·Z
(X·Y)·Z + X·Z + Y·Z          ← De Morgan sobre (X·Y) → (X+Y)
(X+Y)·Z + (X+Y)·Z            ← Factor comun
(X+Y)·(Z+Z)                   ← Inverso: Z+Z=1
(X+Y)·1                        ← Identidad
X+Y     ✓
```

---

## Ver tambien

- [[representacion_de_informacion_teoria]] — sistemas de representacion numerica
- [[logica_secuencial_teoria]] — circuitos con memoria (flip-flops, registros)
- [[parciales_analizados/1P_1C_2025]] — SDP + simplificacion algebraica + NOR
- [[parciales_analizados/1P_2C_2024]] — NAND/NOR universales, simplificacion booleana
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — (A+B)C con NAND, XNOR tabla
