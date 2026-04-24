---
nombre: Recuperatorio 1P 2C 2024 — Analisis
parcial: 1P
cuatrimestre: 2C
año: 2024
instancia: recuperatorio
tipo_pdf: fotografiado
fuente: raw/parciales/1P/1.parcial_2C_2024_recuperatorio.pdf
transcripcion: "[[transcripciones/1P_2C_2024_rec_raw]]"
temas_evaluados:
  - representacion_de_informacion
  - logica_combinatoria
  - logica_secuencial
---

# Recuperatorio 1P 2C 2024

**Alumno:** Giorgi Palazzini, Tomás Agustín (LU 795/23) — **Nota: 10/10** (Ej1=3 | Ej2=1 | Ej3=2 | Ej4=4)

Paginas relacionadas: [[temas/representacion_de_informacion_teoria]] | [[parciales_analizados/1P_2C_2024]]

---

## Ejercicio 1 — Representacion de la Informacion (3 pts.)

### Enunciado

a) ¿Cuál es el rango de representación de un número de 8 bits con signo y magnitud donde el **segundo bit más significativo fue cableado a 0**? ¿Cuál es el rango de un número negativo de 8 bits en complemento a dos?

b) Calcular la suma binaria de **-21 + (-14)** en C2 de 8 bits. ¿Su resultado es representable?

c) Ídem para **-128 + (-1)**. ¿Su resultado es representable?

d) Para dos números *a* y *b* de *k* dígitos en C2, resultado *c*: ¿qué condición deben cumplir *a* y *b* para que **c sea par**? ¿Y para que **c sea negativo y no sea overflow**?

### Resolucion

**a) Rangos:**

*S+M 8 bits con segundo MSB cableado a 0:*

Formato: `S 0 XXXXXX` → 1 bit de signo, segundo bit fijo en 0, 6 bits de magnitud libre.
- Máximo positivo: $00111111_2 = +63$
- Máximo negativo: $10111111_2 = -63$
- Rango: $[-63,\, +63]$

*C2 8 bits, solo negativos:*
- Mínimo: $10000000_2 = -128$
- Máximo negativo: $11111111_2 = -1$
- Rango de negativos: $[-128,\, -1]$

**b) Suma -21 + (-14):**

Conversión a C2 8 bits:
$$21_{10} = 00010101_2 \xrightarrow{\text{NOT}+1} 11101011_2 = -21_{10}$$
$$14_{10} = 00001110_2 \xrightarrow{\text{NOT}+1} 11110010_2 = -14_{10}$$

Suma:
$$11101011_2 + 11110010_2 = 11011101_2 = -35_{10}$$

**Representable:** sí — $-35 \in [-128,\, +127]$ ✓

**c) Suma -128 + (-1):**

$$10000000_2 + 11111111_2 = 01111111_2 = +127_{10}$$

**No representable:** overflow — la suma de dos negativos dio positivo, lo cual indica que $C_k \oplus C_{k-1} = 1$ (carry entrante y saliente del bit de signo difieren). ✓

**d) Condiciones sobre c:**

*Para que c sea par:* el bit menos significativo de c debe ser 0. Como $\text{LSB}(a+b) = \text{LSB}(a) \oplus \text{LSB}(b)$ (sin considerar carry en el bit 0, que no afecta el LSB del resultado), c es par si y solo si $a$ y $b$ tienen el mismo bit menos significativo: **ambos pares o ambos impares**.

*Para que c sea negativo y no haya overflow:* dos casos:
1. Si $a < 0$ y $b < 0$: el resultado siempre es negativo; overflow ocurre si $|a|+|b| > 2^{k-1}$, es decir si el bit de signo del resultado se "voltea". Condición de no-overflow: $a + b \geq -2^{k-1}$.
2. Si uno es positivo y el otro negativo: no hay overflow posible; c es negativo si y solo si $|\text{negativo}| > |\text{positivo}|$.

### Explicacion

Este ejercicio expande el Ej1 del parcial regular (1P_2C_2024) con variantes más complejas:
- **Parte a:** introduce la restricción de un bit cableado — reduce el rango de magnitud de 7 bits a 6 bits efectivos. El rango S+M ya no es $\pm 127$ sino $\pm 63$.
- **Partes b y c:** ejercitación directa de suma C2 con detección de overflow por signo del resultado (NEG+NEG=POS).
- **Parte d:** preguntas conceptuales sobre propiedades de la suma en C2. La condición de paridad es aritmética elemental ($a \oplus b$ en el LSB). La condición de negativo-sin-overflow requiere entender el interplay entre signo de operandos y overflow.

### Analisis de la resolucion

- **a)** Correcto. El alumno identifica que el segundo MSB=0 deja 6 bits de magnitud → rango ±63. ✓
- **b)** Correcto. Conversión C2 correcta, suma correcta, resultado -35 en rango. ✓
- **c)** Correcto. Detecta overflow por "NEG+NEG=POS". Identificación informal pero válida. ✓
- **d)** Correcto. La respuesta sobre paridad ("ambos pares o impares") es exacta. La respuesta sobre negativo sin overflow está bien planteada conceptualmente aunque sin formalización algebraica. ✓
- **Puntaje:** 3/3.

### Chuleta

> 1. **S+M con bit fijo:** si el bit $i$ está cableado a 0, los bits de magnitud efectivos son $k-2$ (sin el bit de signo y sin el bit fijo) → rango $\pm(2^{k-2}-1)$
> 2. **C2 negativos:** rango $[-2^{k-1},\, -1]$ (excluye el cero)
> 3. **Overflow por signo:** NEG+NEG=POS o POS+POS=NEG → overflow
> 4. **Paridad de c:** $c$ es par $\iff \text{LSB}(a) = \text{LSB}(b)$ (ambos pares o ambos impares)
> 5. **c negativo sin overflow:** ambos negativos (sin overflow de suma), o |negativo| > |positivo|

---

## Ejercicio 2 — Logica Combinatoria: Universalidad NAND/NOR (1 pto.)

### Enunciado

Determinar veracidad o falsedad (con fórmulas si afirmativo):

1. Es posible representar la compuerta NAND solamente con compuertas NOR.
2. No es posible representar la compuerta NOR solamente con compuertas NAND.

### Resolucion

**1) VERDADERO — NAND con NOR:**

$$a \downarrow a = \bar{a}, \quad b \downarrow b = \bar{b}$$
$$\bar{a} \downarrow \bar{b} = \overline{\bar{a}+\bar{b}} = a \cdot b \quad \text{(AND con NOR)}$$
$$\text{NAND}(a,b) = \overline{a \cdot b} = \overline{a \cdot b} \downarrow \overline{a \cdot b} = (a \cdot b) \downarrow (a \cdot b)$$

Fórmula completa (5 compuertas NOR):
$$\text{NAND}(a,b) = \bigl[(\bar{a} \downarrow \bar{b})\bigr] \downarrow \bigl[(\bar{a} \downarrow \bar{b})\bigr]$$
donde $\bar{a} = (a \downarrow a)$ y $\bar{b} = (b \downarrow b)$

Tabla de verdad verificada ✓

**2) FALSO — NOR sí es representable con NAND:**

$$a \mid a = \bar{a}, \quad b \mid b = \bar{b}$$
$$\text{OR}(a,b) = (\bar{a} \mid \bar{b}) \mid (\bar{a} \mid \bar{b}) = (\bar{a} \mid \bar{b}) \mid (\bar{a} \mid \bar{b})$$
$$\text{NOR}(a,b) = \overline{a+b} = \text{OR}(a,b) \mid \text{OR}(a,b)$$

Fórmula completa (5 compuertas NAND):
$$\text{NOR}(a,b) = \bigl[(\bar{a} \mid \bar{b})\bigr] \mid \bigl[(\bar{a} \mid \bar{b})\bigr]$$
donde $\bar{a} = (a \mid a)$ y $\bar{b} = (b \mid b)$

Tabla de verdad verificada ✓

### Explicacion

El enunciado es el mismo que en el parcial regular pero formulado como verdadero/falso en vez de demostración directa. El truco clave es que **tanto NAND como NOR son operadores universales** — cada uno puede simular NOT, AND y OR.

La afirmación 2 es un engaño clásico: formulada como "no es posible", el alumno debe reconocer que sí es posible y corregirla. El método de demostración es simétrico entre NAND y NOR.

### Analisis de la resolucion

Correcta en ambas partes. El alumno construye las tablas de verdad para verificar. Las fórmulas derivadas son correctas. La identificación de la afirmación 2 como falsa y su corrección son correctas. Puntaje: 1/1.

### Chuleta

> - **NAND con NOR:** $\text{NAND}(a,b) = [(a \downarrow a) \downarrow (b \downarrow b)] \downarrow [(a \downarrow a) \downarrow (b \downarrow b)]$
> - **NOR con NAND:** $\text{NOR}(a,b) = [(a \mid a) \mid (b \mid b)] \mid [(a \mid a) \mid (b \mid b)]$
> - Patron comun: AND/OR(a,b) → 3 compuertas; NOT del resultado → 2 mas → total 5 compuertas

### Comparacion con parcial regular 1P_2C_2024 — Ej2

| Aspecto | Parcial regular | Recuperatorio |
|---------|-----------------|---------------|
| Formulacion | Demostrar que NAND y NOR son universales | Verdadero/Falso sobre afirmaciones (una correcta, una incorrecta) |
| Trampa | Ninguna | Afirmacion 2 es falsa — el alumno debe detectarlo |
| Metodo alumno (regular) | Equivalencias directas + tabla de verificacion | Tabla de verdad completa |
| Metodo alumno (recuperatorio) | — | Tabla de verdad completa para ambas |
| Dificultad | Construccion directa | Deteccion + correccion de afirmacion falsa |

---

## Ejercicio 3 — Logica Combinatoria: Circuitos (2 pts.)

### Enunciado

1. $f(A,B,C) = (A+B) \cdot C$ usando **3 compuertas NAND**.
2. $f(A,B) = A \cdot B + \overline{A} \cdot \overline{B}$ — ¿para qué valores de A y B la función devuelve 0?

### Resolucion

**3.1 $(A+B) \cdot C$ con 3 NAND:**

Por distribución y doble negación:
$$(A+B) \cdot C = A \cdot C + B \cdot C$$
$$= \overline{\overline{A \cdot C} \cdot \overline{B \cdot C}} = \text{NAND}(\text{NAND}(A,C),\, \text{NAND}(B,C))$$

Verificacion por tabla de verdad (alumno construye la tabla completa y confirma igualdad columna a columna) ✓

Circuito con 3 NAND:
- Capa 1: $\text{NAND}(A,C)$ y $\text{NAND}(B,C)$ en paralelo
- Capa 2: $\text{NAND}(\text{NAND}(A,C),\, \text{NAND}(B,C))$ → salida $f$

**3.2 $f(A,B) = A \cdot B + \overline{A} \cdot \overline{B}$:**

Tabla de verdad:

| A | B | $A \cdot B$ | $\overline{A}$ | $\overline{A} \cdot \overline{B}$ | $f$ |
|---|---|-------------|----------------|-----------------------------------|-----|
| 1 | 1 |      1      |       0        |                0                  |  1  |
| 1 | 0 |      0      |       0        |                0                  |  0  |
| 0 | 1 |      0      |       1        |                0                  |  0  |
| 0 | 0 |      0      |       1        |                1                  |  1  |

$f = \overline{A \oplus B}$ (XNOR): devuelve 1 cuando A=B, devuelve 0 cuando A≠B.

**La función devuelve 0 cuando A=0 y B=1** (el alumno menciona este caso; también devuelve 0 cuando A=1 y B=0 — omisión sin penalización por el corrector). ✓

### Explicacion

**3.1** usa la equivalencia algebraica:
$$\text{NAND}(\text{NAND}(A,C), \text{NAND}(B,C)) = \overline{\overline{AC} \cdot \overline{BC}} = AC + BC = (A+B)C$$

La clave es reconocer que $(A+B)C$ se puede expandir por distribución a $AC+BC$, y luego expresar como NAND-de-NAND.

**3.2** la función $AB + \bar{A}\bar{B}$ es XNOR — devuelve 1 cuando los operandos son iguales. La pregunta pide cuándo devuelve 0 (cuando son distintos: A=0,B=1 o A=1,B=0).

### Analisis de la resolucion

- **3.1:** Correcto. El alumno verifica por tabla de verdad y el circuito usa exactamente 3 NAND. ✓
- **3.2:** Correcto en tabla y circuito. La respuesta escrita menciona solo A=0,B=1 (omite A=1,B=0) pero el corrector no descuenta. ✓
- **Puntaje:** 2/2.

### Chuleta

> - **$(A+B) \cdot C$ con NAND:** expandir → $AC+BC$ → $\text{NAND}(\text{NAND}(A,C), \text{NAND}(B,C))$ — 3 NAND
> - **Patron NAND-de-NAND:** $\text{NAND}(x,y)$ como puerta final implementa OR de los complementos → suma de productos
> - **XNOR:** $AB + \bar{A}\bar{B}$ devuelve 1 si $A=B$, 0 si $A \neq B$
> - Respuesta a "¿cuándo devuelve 0?": listar TODOS los casos donde $f=0$ (no solo uno)

### Comparacion con parcial regular 1P_2C_2024 — Ej3

| Aspecto | Parcial regular | Recuperatorio |
|---------|-----------------|---------------|
| Funcion 3.1 | $A \cdot B \cdot C$ con 2 NOR | $(A+B) \cdot C$ con 3 NAND |
| Compuertas objetivo | NOR | NAND |
| Tecnica | De Morgan: $ABC = \text{NOR}(\bar{A},\bar{B}) $ encadenado | Distribucion: $(A+B)C = AC+BC$ → NAND-de-NAND |
| Funcion 3.2 | $f(A,B) = \overline{((AB)+(\bar{B}A))} \cdot \bar{B}$ — simplificacion algebraica compleja → NOR | $AB + \bar{A}\bar{B}$ — XNOR, tabla directa |
| Trampa 3.2 | Simplificacion por $A(B+\bar{B})=A$ oculta en la expresion | Respuesta incompleta si se lista solo uno de los dos casos donde $f=0$ |

---

## Ejercicio 4 — Logica Secuencial: Registro de Desplazamiento 4 bits con Demora (4 pts.)

### Enunciado

Diseñar un registro de 4 bits que en cada ciclo de reloj desplace los bits almacenados una posicion a derecha (si right/left=1) o izquierda (si right/left=0), con **demora de un ciclo** (los valores recibidos en $d_0$–$d_3$ se almacenan internamente y se emiten en el siguiente ciclo).

Entradas: right/left, clk, $d_0$–$d_3$
Salidas: $Q_0$–$Q_3$

### Resolucion

**Arquitectura:** 4 multiplexores (M0–M3) con 2 entradas cada uno + selector RIGHT/LEFT + 4 flip-flops D (F1–F4).

Conexiones por bit:
- **M0:** entrada_right=$Q_1$ (vecino derecho), entrada_left=0 (relleno), selector=RIGHT/LEFT → F1 → $Q_0$
- **M1:** entrada_right=$Q_2$, entrada_left=$Q_0$, selector=RIGHT/LEFT → F2 → $Q_1$
- **M2:** entrada_right=$Q_3$, entrada_left=$Q_1$, selector=RIGHT/LEFT → F3 → $Q_2$
- **M3:** entrada_right=0 (relleno), entrada_left=$Q_2$, selector=RIGHT/LEFT → F4 → $Q_3$

Las constantes 0 en M0 y M3 garantizan que los bits que "entran" por los extremos en cada desplazamiento sean cero.

La **demora de un ciclo** está naturalmente implementada por los flip-flops D: almacenan la salida del multiplexor en el flanco ascendente de clk y la emiten en el Q del siguiente ciclo.

Nota: las entradas $d_0$–$d_3$ no se usan directamente como entradas de los MUX en la resolucion (el alumno las conecta indirectamente a través del diseño). El circuito implementa el desplazamiento con realimentacion de $Q_i$ a los multiplexores.

### Explicacion

El componente central es el **multiplexor**: selecciona entre "vecino de la derecha" (si right=1, desplazamiento hacia la derecha) o "vecino de la izquierda" (si right=0). El flip-flop D introduce la demora de un ciclo: el nuevo valor del bit $i$ se captura en el flanco de clk pero se emite recién en $Q_i$ en el siguiente ciclo.

Diferencia con el Ej4 del parcial regular (registro bidireccional con tristate): aquel usaba tristate para bidireccionalidad de las líneas de datos. Este ejercicio pide desplazamiento, no bidireccionalidad en el bus de datos.

### Analisis de la resolucion

Correcto. El diseño con MUX × 4 + FF-D × 4 implementa correctamente el registro de desplazamiento bidireccional con demora de un ciclo. Las constantes en los extremos garantizan relleno con 0. El corrector marca con doble tilde. Puntaje: 4/4.

### Chuleta

> - **Registro desplazamiento bidireccional:** MUX × N (selector=RIGHT/LEFT) + FF-D × N
> - **Desplazamiento derecha** (right=1): bit $i$ toma el valor del bit $i+1$ (vecino de la derecha del *proximo* ciclo, es decir $Q_{i+1}$)
> - **Desplazamiento izquierda** (right=0): bit $i$ toma el valor de $Q_{i-1}$
> - **Relleno en extremos:** constante 0 en M0 (extremo izquierdo) y M3 (extremo derecho)
> - **Demora inherente:** los FF-D implementan la demora de 1 ciclo automaticamente

### Comparacion con parcial regular 1P_2C_2024 — Ej4

| Aspecto | Parcial regular | Recuperatorio |
|---------|-----------------|---------------|
| Tipo de circuito | Registro bidireccional (leer/escribir por mismo bus) | Registro de desplazamiento bidireccional |
| Componente clave | Buffer tristate | Multiplexor 2:1 |
| Señal de control | load (escritura) / read (lectura) | right/left (direccion de desplazamiento) |
| Demora | No aplica (load/read inmediatos) | 1 ciclo de clk (implementada por FF-D) |
| Tema evaluado | Buses tristate, bidireccionalidad de líneas | Registros de desplazamiento, MUX como selector |

---

## Sintesis — Patrones nuevos detectados

1. **S+M con bit fijo:** cuando el bit $k-2$ (segundo MSB) es $0$, la magnitud disponible se reduce a $k-2$ bits → rango $\pm(2^{k-2}-1)$ en vez de $\pm(2^{k-1}-1)$. Generalizable: cualquier bit cableado reduce el espacio de representación.

2. **Condicion de paridad en suma C2:** c es par ↔ LSB(a) = LSB(b). El carry no afecta el LSB del resultado (el carry del bit 0 afecta el bit 1, no el bit 0).

3. **Condicion negativo sin overflow en C2:** si ambos operandos son negativos → resultado negativo salvo overflow; si operandos de distinto signo → sin overflow posible, negativo iff |negativo| > |positivo|.

4. **$(A+B)C$ con NAND:** distribuir → $AC+BC$ → $\text{NAND}(\text{NAND}(A,C), \text{NAND}(B,C))$. Patron: OR de productos = NAND de NAND.

5. **Registro desplazamiento con MUX:** patron recurrente — MUX bidireccional (selector=right/left) + FF-D por bit. Extremos rellenados con 0.

6. **Ej2 formulado como V/F:** detectar afirmacion falsa y revertirla (en vez de demostrar directamente). La afirmacion "no es posible X" suele ser la falsa — ambos NAND y NOR son universales.
