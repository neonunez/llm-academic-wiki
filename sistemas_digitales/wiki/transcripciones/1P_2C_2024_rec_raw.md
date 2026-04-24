---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_2C_2024_recuperatorio.pdf
metodo: claude_vision
paginas: 4
---

# Transcripcion — Recuperatorio 1P 2C 2024

## Encabezado

- **Alumno:** Giorgi Palazzini, Tomás Agustín
- **LU:** 795/23
- **Hojas:** 4
- **Examen:** Sistemas Digitales — Recuperatorio del Primer Parcial — Segundo Cuatrimestre 2024
- **Corrector:** EDGAR
- **Puntaje:** Ej1=3 | Ej2=1 | Ej3=2 | Ej4=4 | **Nota: 10/10**

---

## Pagina 1 — Enunciado

### Aclaraciones

- Anote apellido, nombre, LU y numere *todas* las hojas entregadas, entregando los distintos ejercicios en hojas separadas.
- El parcial **no es a libro abierto**, justifique sus respuestas.
- El parcial se aprueba con 6 y se debe tener un promedio de 7 y ambos parciales aprobados para aprobar la materia (promoción directa).

### Ejercicio 1 (3 pts.) Responder y justificar la respuesta:

- ¿Cuál es el rango de representación de un número de 8 bits con signo y magnitud donde el segundo bit más significativo fue cableado a 0? ¿Cuál es el rango de representación de un número negativo de 8 bits en complemento a dos?
- Calcular la suma binaria de -21 con -14 en notación complemento a dos de 8 bits. ¿Su resultado es representable?
- Repita lo anterior para -128 y -1. ¿Su resultado es representable?
- Para dos números *a* y *b* de *k* dígitos en complemento a dos, para una operación de suma cuyo resultado nombramos *c*, ¿qué condición deben cumplir *a* y *b* para que *c* sea par? ¿Y para que *c* sea negativo y no sea overflow?

### Ejercicio 2 (1 punto) Determinar la veracidad o falsedad de las siguientes afirmaciones. En caso afirmativo, escribir las fórmulas correctas:

1. Es posible representar la compuerta NAND solamente con compuertas NOR.
2. No es posible representar la compuerta NOR solamente con compuertas NAND.

### Ejercicio 3 (2 pts.) Dibujar circuitos que implementen las siguientes funciones booleanas:

1. $f(A,B,C) = (A+B) \cdot C$ usando 3 compuertas NAND.
2. $f(A,B) = A \cdot B + \overline{A} \cdot \overline{B}$ ¿Para qué valores de A y B la función devuelve 0?

### Ejercicio 4 (4 pts.) *Registro de desplazamiento de 4 bits con demora*

Diseñar un registro de cuatro bits que permita que en cada ciclo de reloj se desplace un bit a derecha o a izquierda con una demora de un ciclo. Este tipo de registros es un circuito con cuatro entradas (right, left, clk) y cuatro señales de entrada y salida ($d_0$ a $d_3$). Su funcionamiento es el siguiente: si la señal right/left vale *1* cuando clk alcanza su flanco ascendente, desplaza los valores almacenados una posición a la derecha (idem a izquierda si right/left vale *0*) los valores recibidos en $d_0$ a $d_3$ y los almacena internamente durante un ciclo para entregarlos por la salida **en el siguiente ciclo**.

---

## Paginas 2–4 — Resolucion (Giorgi Palazzini, Tomas)

### Ejercicio 1 — Hoja 1/4

**Parte a — Rangos:**

Un número de ocho bits con signo y magnitud con el segundo bit más significativo cableado a 0 tiene rango de (-63)₁₀ hasta (63)₁₀ que son 10111111 y 00111111 respectivamente.

Un número negativo de ocho bits en complemento a dos tiene un rango desde (-128)₁₀ hasta (-1)₁₀ que son 10000000 y 11111111 respectivamente.

**Parte b — Suma -21 + (-14):**

Para calcular la suma binaria entre (-21)₁₀ y (-14)₁₀, primero calculo (21)₁₀ y (14)₁₀ y los paso a negativo (invierto bit a bit y sumo 1 al resultado).

(21)₁₀ en binario de ocho bits: 00010101
→ Invierto sus bits: 11101010
→ Sumo uno: 00000001
= 11101011 = (-21)₁₀

(14)₁₀ en binario de ocho bits: 00001110
→ Invierto: 11110001
→ Sumo 1: 00000001
= 11110010 = (-14)₁₀

Ahora hago la suma binaria:
```
  11101011 = (-21)₁₀
+ 11110010 = (-14)₁₀
-----------
  11011101 = (-35)₁₀
```
Su resultado sí es representable ya que está en rango.

**Parte c — Suma -128 + (-1):**

Repetimos con (-128)₁₀ y (-1)₁₀:
```
  10000000 = (-128)₁₀
+ 11111111 = (-1)₁₀
-----------
  01111111
```
Su resultado no es representable ya que se produce un overflow, nos damos cuenta con el bit más significativo: la suma de dos negativos no puede dar un positivo.

**Parte d — Condicion paridad y negativo sin overflow:**

Para que c sea par, a y b tienen que ser ambos pares o impares, ya que el bit menos significativo tiene que ser cero. Y para que c sea negativo y no haya overflow, la suma de los dos bits más significativos sea 1. Si a y b son negativos, c tiene que ser negativo (a caso contrario hay overflow). Sino con que uno de los dos sea positivo y el módulo del negativo sea mayor que el positivo, c va a ser negativo sin overflow.

---

### Ejercicio 2 — Hoja 2/4

**Afirmacion 1: Verdadero.** Sí es posible representar NAND solo con compuertas NOR.

Tabla de verdad (demuestra que NOR(NOR(a,a), NOR(b,b)) ↓ NOR(NOR(a,a), NOR(b,b)) = NAND(a,b)):

| a | b | a↓a | b↓b | (a↓a)↓(b↓b) | ((a↓a)↓(b↓b))↓((a↓a)↓(b↓b)) | a\|b |
|---|---|-----|-----|-------------|-------------------------------|------|
| 1 | 1 |  0  |  0  |      1      |              0                |   0  |
| 1 | 0 |  0  |  1  |      0      |              1                |   1  |
| 0 | 1 |  1  |  0  |      0      |              1                |   1  |
| 0 | 0 |  1  |  1  |      0      |              1                |   1  |

Son iguales ✓

**Afirmacion 2: Falso.** Sí es posible representar NOR solo con compuertas NAND.

Tabla de verdad (demuestra que NAND(NAND(a,a), NAND(b,b)) ↓ ... = NOR(a,b)):

| a | b | a\|a | b\|b | (a\|a)\|(b\|b) | ((a\|a)\|(b\|b))\|((a\|a)\|(b\|b)) | a↓b |
|---|---|------|------|----------------|-------------------------------------|-----|
| 1 | 1 |  0   |  0   |       1        |                 0                   |  0  |
| 1 | 0 |  0   |  1   |       1        |                 0                   |  0  |
| 0 | 1 |  1   |  0   |       1        |                 0                   |  0  |
| 0 | 0 |  1   |  1   |       0        |                 1                   |  1  |

Son iguales ✓

---

### Ejercicio 3 — Hoja 3/4

**3.1 f(A,B,C) = (A+B)·C con 3 NAND:**

Tabla de verdad construida con columnas: A, B, C, (A+B), (A+B)·C, Ā, B̄, Ā·C̄ (ilegible parcial), resultado.

Por tabla de verdad verifica que: $(A+B) \cdot C = (A \mid C) \mid (B \mid C)$
(NAND(A,C) NAND NAND(B,C) = (A+B)·C — distribución + doble negación)

Circuito: dos NAND en primera capa (NAND(A,C) y NAND(B,C)), una NAND final que recibe ambas salidas. ✓

**3.2 f(A,B) = A·B + Ā·B̄:**

Tabla de verdad:

| A | B | A·B | Ā | Ā·B̄ | (A·B)+(Ā·B̄) |
|---|---|-----|---|-----|-------------|
| 1 | 1 |  1  | 0 |  0  |      1      |
| 1 | 0 |  0  | 0 |  0  |      0      |
| 0 | 1 |  0  | 1 |  0  |      0      |
| 0 | 0 |  0  | 1 |  1  |      1      |

**La función devuelve 0 cuando A=0 y B=1.**

(Nota: también devuelve 0 cuando A=1 y B=0 — el alumno omite este caso pero el corrector no descuenta.)

Circuito: AND(A,B) en la parte superior; NOT(A), NOT(B) → AND(Ā,B̄); luego OR de ambas salidas. ✓

---

### Ejercicio 4 — Hoja 4/4

**Circuito:** cuatro multiplexores M0, M1, M2, M3 (2 entradas c/u, selector = RIGHT/LEFT) + cuatro flip-flops D (F1, F2, F3, F4). Entradas D0–D3 arriba, salidas Q0–Q3 abajo.

Conexiones:
- M0: entrada_1=D0, entrada_2=Q1 (salida del siguiente FF), selector=RIGHT/LEFT; constante 0 conectada al extremo para relleno de desplazamiento
- M1: entrada_1=Q0, entrada_2=Q2, selector=RIGHT/LEFT
- M2: entrada_1=Q1, entrada_2=Q3, selector=RIGHT/LEFT
- M3: entrada_1=Q2, entrada_2=D3, constante 0 al extremo; selector=RIGHT/LEFT
- Cada multiplexor → FF-D correspondiente (F1–F4) → salida Qi

**Descripcion escrita por el alumno:**
"Puse cuatro multiplexores (M0, M1, M2, M3) cada uno con dos entradas y RIGHT/LEFT como controlador de salida. A M0 y M3 los conecté con una constante cero para rellenar el bit en cada desplazamiento. A cada multiplexor los conecté a un flip-flop D que almacene el valor en cada clock y de el resultado en cada Q correspondiente."

Corrector: ✓ (doble tilde)
