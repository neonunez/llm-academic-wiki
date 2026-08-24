---
nombre: HDL y System Verilog
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: logica_combinatoria   # secundario: logica_secuencial
fuente: raw/contenido_comunidad/resumen_sistemas_digitales.pdf
paginas_relacionadas:
  - "[[logica_combinatoria_teoria]]"
  - "[[logica_secuencial_teoria]]"
  - "[[microarquitectura_teoria]]"
---

# HDL y System Verilog

Fuente: `raw/contenido_comunidad/resumen_sistemas_digitales.pdf` (resumen estudiantil — Tomas Agustin Hernandez)

---

## Concepto y definicion

Los **Lenguajes de Descripcion de Hardware (HDL)** permiten describir la estructura y comportamiento de circuitos digitales de forma sintetica y escalable. Los dos dominantes son **VHDL** y **SystemVerilog**.

Un archivo HDL es fuente de dos procesos:
- **Simulacion:** verifica el comportamiento esperado del circuito ante distintas entradas (ondas).
- **Sintesis:** traduce el HDL a un conjunto de compuertas logicas reales.

---

## Modulos

Un **modulo** es el bloque basico de hardware: tiene un nombre, entradas y salidas.

```systemverilog
module nombre(
    input  logic [n:0] a, b,
    output logic [n:0] y
);
    // descripcion interna
endmodule
```

Dos estilos de descripcion:
- **Comportamental:** describe como cambian las salidas en funcion de las entradas.
- **Estructural:** describe la composicion de submodulos (instancias de otros modulos).

---

## Modelado Comportamental

### Tipos de asignacion

| Sintaxis | Tipo | Uso |
|----------|------|-----|
| `assign y = expr;` | Bloqueante (sincrona) | Circuito **combinatorio** |
| `q <= d;` (dentro de `always`) | No bloqueante (asincrona) | Circuito **secuencial** |

### Asignacion condicional (MUX 2:1)

```systemverilog
assign y = s ? d1 : d0;
// s: selector, d1: entrada 1, d0: entrada 0
```

Infiere un multiplexor de 2 entradas.

### Asignacion condicional compuesta (MUX 4:1)

```systemverilog
assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0);
```

Ternario anidado — infiere un MUX de 4 entradas.

### Operadores de reduccion

Colapsan todos los bits de una señal aplicando una operacion logica bit a bit:

```systemverilog
assign y = &a;  // AND de todos los bits de a
assign y = |a;  // OR de todos los bits de a
assign y = ^a;  // XOR de todos los bits de a
```

### Variables internas

```systemverilog
logic p, g;   // variables internas al modulo
```

### Valores numericos

Formato: `bits'base_valor`

| Ejemplo | Significado |
|---------|-------------|
| `8'b0000_0010` | 8 bits, binario, valor 2 |
| `4'hF` | 4 bits, hexadecimal, valor 15 |
| `8'd42` | 8 bits, decimal, valor 42 |

Siempre se almacena internamente en binario.

### Manipulacion de bits

```systemverilog
{a, b}          // concatenacion
{3{d[0]}}       // repeticion: d[0]d[0]d[0]
c[7:4]          // rango de bits (MSB:LSB, a > b siempre)
```

---

## Compuertas en SystemVerilog

```systemverilog
assign y1 = a & b;   // AND
assign y2 = a | b;   // OR
assign y3 = a ^ b;   // XOR
assign y4 = ~(a & b); // NAND
assign y5 = ~(a | b); // NOR
assign y6 = ~a;       // NOT
```

Nota: `logic[7:0]` = vector de 8 bits, bit 7 es el MSB, bit 0 el LSB.

---

## Alta Impedancia y Valores Especiales

### Alta Impedancia (Hi-Z)

```systemverilog
module buffer3(input logic [3:0] a, input logic en, output tri [3:0] y);
    assign y = en ? a : 4'bz;  // z = Hi-Z
endmodule
```

### Valores desconocidos

`x` indica un valor desconocido. Puede deberse a:
- Señal no inicializada.
- **Contension:** dos buffers tristate conectados al mismo bus enviando señales distintas — indica error de diseno.

---

## Precedencia de operadores

(De mayor a menor prioridad, similar a C)

1. `~` (NOT)
2. `*`, `/`, `%`
3. `+`, `-`
4. `<<`, `>>`
5. `<`, `<=`, `>`, `>=`
6. `==`, `!=`
7. `&` (AND)
8. `^` (XOR)
9. `|` (OR)
10. `?:` (ternario)

---

## Modelado Estructural

Para componer modulos se crean instancias:

```systemverilog
// instanciar mux2 tres veces para hacer mux4
module mux4(input logic [3:0] d0, d1, d2, d3,
            input logic [1:0] s,
            output logic [3:0] y);
    logic [3:0] low, high;
    mux2 lowmux  (d0, d1, s[0], low);
    mux2 highmux (d2, d3, s[0], high);
    mux2 finalmux(low, high, s[1], y);
endmodule
```

---

## Circuitos Secuenciales — Bloques Always

Los circuitos secuenciales se describen con `always_ff` (flip-flops) o `always_comb` (combinatorio):

### Flip-Flop D basico

```systemverilog
module flop(input logic clk, input logic [3:0] d, output logic [3:0] q);
    always_ff @(posedge clk)
        q <= d;
endmodule
```

`posedge clk`: flanco ascendente del clock — el estado se actualiza solo en ese instante.

### Reset asincronico vs sincronico

```systemverilog
// Reset asincronico: cobra efecto cuando cambia reset, independiente del clock
always_ff @(posedge clk or posedge reset)
    if (reset) q <= 0;
    else       q <= d;

// Reset sincronico: cobra efecto solo en flanco ascendente del clock
always_ff @(posedge clk)
    if (reset) q <= 0;
    else       q <= d;
```

### Always Comb — Circuito Combinatorio

```systemverilog
always_comb
    y = a & b;
```

### Case — Circuito Combinatorio

```systemverilog
always_comb
    case(data)
        0: segments = 7'b1111110;
        1: segments = 7'b0110000;
        default: segments = 7'bx;
    endcase
```

---

## Ejemplo completo: Full Adder

```systemverilog
module fulladder(input logic a, b, cin, output logic s, cout);
    logic p, g;
    assign p    = a ^ b;
    assign g    = a & b;
    assign s    = p ^ cin;
    assign cout = g | (p & cin);
endmodule
```

---

## Formulas clave

$$\text{MUX 2:1} \equiv \texttt{assign y = s ? d1 : d0;}$$

$$\text{Reduccion AND} \equiv \texttt{assign y = \&a;} \quad (y = a[n] \wedge a[n-1] \wedge \ldots \wedge a[0])$$

$$\text{FF-D en SV:} \quad \texttt{always\_ff @(posedge clk)} \; q \mathtt{<=} d$$

---

## Ver tambien

- [[logica_combinatoria_teoria]] — Compuertas, SDP, MUX, codificador/decodificador
- [[logica_secuencial_teoria]] — FF-D, FF-JK, registros, FSM Moore/Mealy
- [[microarquitectura_teoria]] — DataPath y señales de control
