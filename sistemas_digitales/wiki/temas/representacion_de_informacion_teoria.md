---
nombre: Representacion de la Informacion — Teoria
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: representacion_de_informacion
fuente: raw/clases_teoricas/1.teo_representacion_de_informacion.pdf
paginas_relacionadas:
  - "[[representacion_de_informacion_guia]]"
---

# Representacion de la Informacion — Teoria

Fuente: `raw/clases_teoricas/1.teo_representacion_de_informacion.pdf` (64 pags, Beamer, 1C 2025)

---

## Concepto y definicion

### Sistema de representacion

Queremos representar una magnitud a traves de un sistema de representacion con tres propiedades:

| Propiedad | Descripcion |
|-----------|-------------|
| **Finito** | Soporte fijo, cantidad de elementos acotados |
| **Composicional** | Diversas magnitudes se representan con un conjunto de elementos atomicos faciles de implementar y componer |
| **Posicional** | La posicion de cada digito determina univocamente en que proporcion modifica su valor a la magnitud total |

### Bases numericas

Una base determina la cantidad de simbolos distintos que podemos encontrar en un digito dado.

| Base | Nombre | Simbolos |
|------|--------|----------|
| 2 | Binario | 0, 1 |
| 8 | Octal | 0–7 |
| 10 | Decimal | 0–9 |
| 16 | Hexadecimal | 0–9, A–F |

Una misma magnitud puede tener distintas representaciones. Ejemplo: el cuatro es `100` en base 2, `11` en base 3, `4` en base 10.

---

## Cambio de Base: Teorema de la Division

### Enunciado

Sean $a, b \in \mathbb{Z}$ con $b \neq 0$. Existen $q, r \in \mathbb{Z}$ con $0 \leq r < |b|$ tales que:

$$a = b \times q + r$$

Ademas, $q$ y $r$ son unicos (de a pares).

### Como se usa para cambio de base

Aplicando divisiones sucesivas:

$$a = b \times q + r$$
$$a = (b \times q_1 + r_1) \times b + r$$
$$a = [(b \times q_2 + r_2) \times b + r_1] \times b + r$$

Continuamos hasta que $q_N < b$. Distribuyendo:

$$a = q_N \times b^{N+1} + r_N \times b^N + \ldots + r_1 \times b + r \times b^0$$

Los restos $r_i$ son los digitos de la representacion posicional en base $b$: $(q_N \, r_N \, \ldots \, r_1 \, r)_{(b)}$

### Ejemplo

$$27 = (27)_{10} = (11011)_2$$

Verificacion: $1 \cdot 2^4 + 1 \cdot 2^3 + 0 \cdot 2^2 + 1 \cdot 2^1 + 1 \cdot 2^0 = 16 + 8 + 0 + 2 + 1 = 27$

### Tecnica rapida: division sucesiva por 2

Ejemplo: $28 \to$ binario

```
28 / 2 = 14  resto = 0
14 / 2 =  7  resto = 0
 7 / 2 =  3  resto = 1
 3 / 2 =  1  resto = 1
 1 / 2 =  0  resto = 1
```

Leyendo restos de abajo a arriba: $28 = (11100)_2$

### Tecnica rapida: binario a hexadecimal

Agrupar de a 4 bits desde la derecha; convertir cada grupo:

```
10101100 → 1010 | 1100 → A | C → AC (hex)
```

---

## Representacion Finita y Rango

En soporte electronico cada dato se representa con una cantidad **finita** de bits. El **rango de representacion** depende del tipo y la cantidad de digitos:

$$\text{Rango} = b^k$$

donde $b$ es la base y $k$ la cantidad de digitos.

Ejemplo con 8 bits en base 2:

$$2^8 = 256 \quad \text{(valores: 0 a 255 para sin signo)}$$

### Overflow

Si una magnitud cae fuera del rango de representacion → **overflow** (desborde). No hay forma de representarla en el formato actual.

Ejemplo: con 8 bits en base 2, $770 = (1100000010)_2$ requiere 10 bits → overflow.

---

## Tipos Numericos

Todos en base 2. Distintos tipos para un mismo dato producen (potencialmente) distintas magnitudes.

### Sin signo (Unsigned)

Solo positivos. El dato $d_{k-1} \ldots d_0$ representa:

$$\sum_{i=0}^{k-1} d_i \cdot 2^i$$

Rango con $k$ bits: $[0, 2^k - 1]$

### Signo + Magnitud

El bit mas significativo indica el signo ($0=+$, $1=-$); el resto es el valor absoluto.

- Dos representaciones del cero: $+0$ y $-0$ (desnormalizado)
- Rango con $k$ bits: $[-(2^{k-1}-1), +(2^{k-1}-1)]$

### Exceso m (Excess-m / Bias)

El numero $n$ se representa como $m + n$. Desplaza el cero a la posicion $m$ del rango.

- Valores a izquierda de $m$ → negativos
- Extender bits: siempre con 0's

### Complemento a 2 (Two's Complement)

Representacion estandar para enteros con signo.

**Positivos:** igual que sin signo.

**Negativos:** dado un numero $n$, su complemento $\dot{n}$ se calcula como:

$$\dot{n} = 2^k_{(10)} - n$$

donde $k$ es la cantidad de bits.

**Metodo practico:** invertir todos los bits y sumar 1.

Ejemplo: $-4$ en 5 bits:
$$\text{inv}(01000) + 1 = 10111 + 1 = 11000$$

Ejemplo: $-2$ con $k=3$:
$$2^3 = 8 = (1000)_2 \quad \Rightarrow \quad \dot{2} = (1000)_2 - (10)_2 = (110)_2$$

**Rango con $k$ bits:** $[-2^{k-1}, 2^{k-1}-1]$

**Extension de bits:**
- Sin signo: extender con 0's a izquierda
- Signo + Magnitud: extender con 0's, mantener bit de signo
- Complemento a 2: extender con el valor del bit mas significativo (sign extension)
- Exceso m: extender con 0's

### Tabla comparativa (3 bits)

| Dato | Sin signo | Signo+Mag | Exceso 2 | Complemento a 2 |
|------|-----------|-----------|-----------|-----------------|
| 000 | 0 | 0 | −2 | 0 |
| 001 | 1 | 1 | −1 | 1 |
| 010 | 2 | 2 | 0 | 2 |
| 011 | 3 | 3 | 1 | 3 |
| 100 | 4 | −0 | 2 | −4 |
| 101 | 5 | −1 | 3 | −3 |
| 110 | 6 | −2 | 4 | −2 |
| 111 | 7 | −3 | 5 | −1 |

---

## Propiedades de los Datos

Algunos atributos observables directamente del dato (sin conocer la operacion):

| Propiedad | Como detectarla (C2, 4 bits) |
|-----------|------------------------------|
| Negativo | bit mas significativo = 1 |
| Par | bit menos significativo = 0 |

---

## Operaciones Logico-Aritmeticas

Todas se aplican **bit a bit** sobre el dato almacenado, independientemente del tipo.

### O logico (Disyuncion)

$$c_i = a_i \vee b_i$$

| $a_i$ | $b_i$ | $c_i$ |
|--------|--------|--------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

Nota: a veces se escribe con signo $+$ porque equivale a una suma sin acarreo.

### Y logico (Conjuncion)

$$c_i = a_i \wedge b_i$$

| $a_i$ | $b_i$ | $c_i$ |
|--------|--------|--------|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

### Xor logico

$$c_i = (a_i \wedge \neg b_i) \vee (\neg a_i \wedge b_i)$$

Exactamente uno de los bits vale 1.

| $a_i$ | $b_i$ | $c_i$ |
|--------|--------|--------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

### Negacion logica

$$c_i = \neg a_i$$

Invierte cada bit.

### Desplazamiento a izquierda ($\ll$)

$$c_i = a_{i-n} \quad \text{si } i \leq k-n-1, \quad 0 \text{ en caso contrario}$$

Efecto: multiplica por $2^n$ (para sin signo o C2).

### Desplazamiento logico a derecha ($\gg_l$)

$$c_i = a_{i+n} \quad \text{si } i \geq n, \quad 0 \text{ en caso contrario}$$

Rellena con 0's por la izquierda.

### Desplazamiento aritmetico a derecha ($\gg_a$)

$$c_i = a_{i+n} \quad \text{si } i \geq n, \quad a_{k-1} \text{ en caso contrario}$$

Copia el bit mas significativo en las posiciones vacantes (preserva el signo).

Efecto: divide por $2^n$ para complemento a 2.

> **Propiedad:** $a \gg_l n = a/2^n$ solo cuando $a \geq 0$ (sin signo); $a \gg_a n = a/2^n$ para C2 (incluyendo negativos, con redondeo hacia $-\infty$).

---

## Adicion Binaria

### Suma de 1 bit con carry

| $a_i$ | $b_i$ | $c_{i-1}$ | $c_i$ (carry out) | $r_i$ (resultado) |
|--------|--------|------------|---------------------|---------------------|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 0 | 1 |
| 1 | 0 | 0 | 0 | 1 |
| 1 | 1 | 0 | 1 | 0 |
| 0 | 0 | 1 | 0 | 1 |
| 0 | 1 | 1 | 1 | 0 |
| 1 | 0 | 1 | 1 | 0 |
| 1 | 1 | 1 | 1 | 1 |

### Adicion de n bits

```
carry :   c_{n-1}  c_{n-2}  ...  c_0
a     :            a_{n-1}  ...  a_1   a_0
b     :            b_{n-1}  ...  b_1   b_0
a + b :   c_{n-1}  r_{n-1}  ...  r_1   r_0
```

El **carry final** $c_{n-1}$ es el flag de desborde para operaciones sin signo.

### Resta Binaria

Equivalente usando **borrow** $b_i$: se produce cuando el sustraendo es mayor que el minuendo y se "pide" al digito adyacente.

```
borrow:   b_{n-1}  b_{n-2}  ...  b_0
a     :            a_{n-1}  ...  a_1   a_0
b     :            b_{n-1}  ...  b_1   b_0
a - b :   b_{n-1}  r_{n-1}  ...  r_1   r_0
```

---

## Overflow y Carry en Complemento a 2

El **overflow** y el **carry** son propiedades de una **operacion** (no del dato aislado); requieren observar operandos y resultado.

### Deteccion de overflow (C2)

Si el bit de signo es igual en ambos operandos, el resultado debe preservar el signo. Overflow si no lo preserva:

$$\text{overflow} \iff (a_{n-1} = b_{n-1}) \wedge (a_{n-1} \neq c_{n-1})$$

### Ejemplos en C2 (4 bits)

```
5 - 3 = 5 + (-3) = 2
  0101
+ 1101
------
 10010   → resultado: 0010 = 2  ✓ (carry ignorado, sin overflow)

-5 - 3 = -8
  1011
+ 1101
------
 11000   → resultado: 1000 = -8  ✓

-5 - 4 = -9  → OVERFLOW
  1011
+ 1100
------
 10111   → resultado: 0111 = +7  ✗ (overflow: ambos negativos, resultado positivo)

5 + 4 = 9   → OVERFLOW
  0101
+ 0100
------
 01001   → resultado: 1001 = -7  ✗ (overflow: ambos positivos, resultado negativo)
```

---

## Formulas Clave

| Concepto | Formula |
|----------|---------|
| Rango de representacion | $b^k$ |
| Complemento a 2 | $\dot{n} = 2^k - n$ |
| Desplazamiento = multiplicacion | $a \ll n = a \times 2^n$ |
| Desplazamiento = division (C2) | $a \gg_a n = a / 2^n$ |
| Overflow en C2 | $(a_{n-1} = b_{n-1}) \wedge (a_{n-1} \neq c_{n-1})$ |
| Extension de signo (C2) | Rellenar con bit mas significativo |

---

## Ver tambien

- [[representacion_de_informacion_guia]] — Ejercicios de la guia practica
- [[logica_combinatoria_teoria]] — siguiente tema del programa (parcial unico)
