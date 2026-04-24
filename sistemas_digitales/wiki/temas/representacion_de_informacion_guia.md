---
nombre: Representacion de la Informacion — Guia de Ejercicios
parcial: 1P
tipo: guia
tema: representacion_de_informacion
fuente: raw/guias_practicas/1.prac_representacion_de_informacion.pdf
paginas_relacionadas:
  - "[[representacion_de_informacion_teoria]]"
  - "[[logica_combinatoria_teoria]]"
  - "[[logica_combinatoria_guia]]"
---

# Representacion de la Informacion — Guia de Ejercicios

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Conversion entre bases (metodo cociente, agrupacion de bits) | ⚪ No |
| Ej. 2 | Sumas de precision fija con acarreo | 🔴 Si |
| Ej. 3 | Acarreo mayor que 1 en alguna base (pregunta conceptual) | ⚪ No |
| Ej. 4 | Interpretar binarios 8-bit en C2 y S+M | 🔴 Si |
| Ej. 5 | Codificar numeros en S+M y C2 con distintas precisiones | 🔴 Si |
| Ej. 6 | Comparacion de rangos C2 vs S+M (pregunta conceptual) | 🔴 Si |
| Ej. 7 | Interpretar sumas del Ej. 2 en C2 — overflow y corrección | 🔴 Si |
| Ej. 8 | Reordenar suma hex para evitar overflow en C2 4-digitos | 🔴 Si |
| Ej. 9 | Pares de numeros C2 4-bit con combinaciones carry/overflow/resultado | 🔴 Si |
| Ej. 10 | Demostrar que SignExtn preserva el valor en C2 | ⚪ No |
| Ej. 11 | Inverso aditivo en C2 — inversion de bits y metodo | 🔴 Si |
| Ej. 12 | Biyectividad de sistemas de representacion (V/F con justificacion) | ⚪ No |
| Ej. 13 | Ejemplo de sistema biyectivo con igual cantidad de positivos y negativos | ⚪ No |

---

## Ejercicios

### Ejercicio 1 — Conversion entre bases

**Enunciado**

a) Usando el metodo del cociente, expresar en bases 2, 3 y 5 los numeros $33_{10}$ y $511_{10}$.

b) Expresar en decimal los numeros $1111_2$, $1111_7$ y $\text{CAFE}_{16}$.

c) Expresar $17_8$ en base 5 y $\text{BABA}_{13}$ en base 6.

d) Pasar $(1010\ 1110\ 1010\ 1101)_2$, $(1111\ 1011\ 0010\ 1100\ 0111)_2$ y $(0\ 0110\ 1001)_2$ a base 4, 8 y 16 agrupando bits.

e) Expresar en decimal los numeros $\text{0x142536}$ y $\text{0xFCD9}$, y pasar a base 16 los numeros $7848_{10}$ y $46183_{10}$.

**Explicacion**

Ejercita el teorema de la division para cambio de base (metodo del cociente), la conversion posicional directa para pasar a decimal, y el truco de agrupacion de bits para bases que son potencias de 2 (base $4 = 2^2$ → grupos de 2 bits; base $8 = 2^3$ → grupos de 3; base $16 = 2^4$ → grupos de 4). La notacion `0x` indica hexadecimal.

**Resolucion paso a paso**

**a) Metodo del cociente — $33_{10}$:**

| Base 2 | Base 3 | Base 5 |
|--------|--------|--------|
| 33/2=16 r **1** | 33/3=11 r **0** | 33/5=6 r **3** |
| 16/2=8 r **0** | 11/3=3 r **2** | 6/5=1 r **1** |
| 8/2=4 r **0** | 3/3=1 r **0** | 1/5=0 r **1** |
| 4/2=2 r **0** | 1/3=0 r **1** | |
| 2/2=1 r **0** | | |
| 1/2=0 r **1** | | |

Leyendo de abajo a arriba: $33_{10} = 100001_2 = 1020_3 = 113_5$

**Metodo del cociente — $511_{10}$:**

| Base 2 | Base 3 | Base 5 |
|--------|--------|--------|
| 511 = 512−1 = $2^9−1$ | 511/3=170 r **1** | 511/5=102 r **1** |
| → $111111111_2$ | 170/3=56 r **2** | 102/5=20 r **2** |
| | 56/3=18 r **2** | 20/5=4 r **0** |
| | 18/3=6 r **0** | 4/5=0 r **4** |
| | 6/3=2 r **0** | |
| | 2/3=0 r **2** | |

$511_{10} = 111111111_2 = 200221_3 = 4021_5$

**b) Conversion a decimal:**

$$1111_2 = 8+4+2+1 = 15_{10}$$
$$1111_7 = 7^3+7^2+7+1 = 343+49+7+1 = 400_{10}$$
$$\text{CAFE}_{16} = 12{\cdot}16^3 + 10{\cdot}16^2 + 15{\cdot}16 + 14 = 49152+2560+240+14 = 51966_{10}$$

**c) Conversion indirecta via decimal:**

$17_8 = 1{\cdot}8+7 = 15_{10}$; en base 5: $15/5=3\ r0$, $3/5=0\ r3$ → $\mathbf{30_5}$

$\text{BABA}_{13}$: B=11, A=10. $= 11{\cdot}13^3 + 10{\cdot}13^2 + 11{\cdot}13 + 10 = 24167+1690+143+10 = 26010_{10}$

$26010$ en base 6: $26010/6=4335\ r0$, $4335/6=722\ r3$, $722/6=120\ r2$, $120/6=20\ r0$, $20/6=3\ r2$, $3/6=0\ r3$ → $\mathbf{320230_6}$

**d) Agrupacion de bits:**

$(1010\ 1110\ 1010\ 1101)_2$ a base 4 (grupos de 2 bits desde la derecha):
$$10|10|11|10|10|10|11|01 \to 2\ 2\ 3\ 2\ 2\ 2\ 3\ 1 = \mathbf{22322231_4}$$

$(1111\ 1011\ 0010\ 1100\ 0111)_2$ (20 bits) a base 8 (grupos de 3; pad a 21 con 0):
$$0\underline{11}\ \underline{111}\ \underline{011}\ \underline{001}\ \underline{011}\ \underline{000}\ \underline{111} \to 3\ 7\ 3\ 1\ 3\ 0\ 7 = \mathbf{3731307_8}$$

$(0\ 0110\ 1001)_2$ (9 bits) a base 16 (grupos de 4; pad a 12 con 0):
$$0000\ |\ 0110\ |\ 1001 \to 0\ 6\ 9 = \mathbf{069_{16}}$$

**e) Hexadecimal ↔ decimal:**

$\text{0x142536} = 1{\cdot}16^5 + 4{\cdot}16^4 + 2{\cdot}16^3 + 5{\cdot}16^2 + 3{\cdot}16 + 6 = 1048576+262144+8192+1280+48+6 = \mathbf{1320246_{10}}$

$\text{0xFCD9} = 15{\cdot}16^3 + 12{\cdot}16^2 + 13{\cdot}16 + 9 = 61440+3072+208+9 = \mathbf{64729_{10}}$

$7848_{10}$: $7848/16=490\ r8$, $490/16=30\ rA$, $30/16=1\ rE$, $1/16=0\ r1$ → $\mathbf{1\text{EA}8_{16}}$

$46183_{10}$: $46183/16=2886\ r7$, $2886/16=180\ r6$, $180/16=11\ r4$, $11/16=0\ rB$ → $\mathbf{B467_{16}}$

**Chuleta**
- **Decimal→base b:** dividir por b sucesivamente; leer restos de abajo a arriba
- **Base b→decimal:** sumar $d_i \cdot b^i$
- **Bases potencias de 2:** agrupar bits (base 4: 2 bits; base 8: 3 bits; base 16: 4 bits), siempre desde la derecha
- **Conversion indirecta:** pasar por decimal como pivote

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 2 — Sumas de precision fija con acarreo

**Enunciado**

Realizar las siguientes sumas de precision fija, sin convertir a decimal. Indicar en cada caso si hubo acarreo.

$$100001_2 + 011110_2$$

$$100001_2 + 011111_2$$

$$01111_2 + 01111_2$$

$$9999_{16} + 1111_{16}$$

$$\text{F0F0}_{16} + \text{F0CA}_{16}$$

**Explicacion**

Suma directa en binario y hexadecimal con precision fija. Se pide detectar carry-out (el bit que "escapa" del ancho de representacion). Es la base mecanica para luego interpretar el resultado en C2 (Ej. 7). Aparece frecuentemente en parciales como calculo previo a analisis de flags.

**Resolucion paso a paso**

**1) $100001_2 + 011110_2$ (6 bits):**
```
  100001
+ 011110
--------
  111111   carry = 0
```
$33 + 30 = 63 = 111111_2$ ✓ — **sin acarreo**

**2) $100001_2 + 011111_2$ (6 bits):**
```
  100001
+ 011111
--------
 1000000   carry = 1
```
$33 + 31 = 64 = 1000000_2$ — resultado 6 bits = $000000_2$, **con acarreo**

**3) $01111_2 + 01111_2$ (5 bits):**
```
  01111
+ 01111
-------
  11110   carry = 0
```
$15 + 15 = 30 = 11110_2$ — **sin acarreo**

**4) $9999_{16} + 1111_{16}$ (4 digitos hex):**
```
  9999
+ 1111
------
  AAAA   carry = 0
```
$9+1=A, 9+1=A, 9+1=A, 9+1=A$ — **sin acarreo** (resultado $= \text{AAAA}_{16}$)

**5) $\text{F0F0}_{16} + \text{F0CA}_{16}$ (4 digitos hex):**
```
  F0F0
+ F0CA
------
 1E1BA   carry = 1
```
Resultado de 4 digitos hex = $\text{E1BA}_{16}$, **con acarreo**

Verificacion: $0xF0F0 + 0xF0CA = 61680 + 61642 = 123322 = 0x1\text{E1BA}$ ✓

**Chuleta**
- Carry = 1 cuando la suma supera la capacidad del ancho de bits (sale un "1" por arriba)
- Binario: propagar el carry bit a bit de derecha a izquierda
- Hex: si la suma de un digito supera 15 (F), restar 16 y propagar carry 1

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/carry_y_overflow]] | [[parciales_analizados/1P_1C_2025]] (flags ALU 4-bit, carry en resta)

---

### Ejercicio 3 — Acarreo mayor que 1

**Enunciado**

¿Puede suceder en alguna base que la suma de dos numeros de precision fija tenga un acarreo mayor que 1? Exhibir un ejemplo o demostrar lo contrario.

**Explicacion**

Pregunta conceptual sobre el mecanismo del acarreo. El acarreo es siempre 0 o 1 independientemente de la base, porque la suma de dos digitos en base $b$ es como maximo $2(b-1)$, que produce acarreo 1 con residuo $b-2$. Testa comprension profunda del mecanismo posicional.

**Resolucion paso a paso**

**Si: el acarreo siempre es 0 o 1, en cualquier base.**

Demostracion: en base $b$, cada digito toma valores entre 0 y $b-1$. La suma de dos digitos mas un carry entrante es como maximo:

$$(b-1) + (b-1) + 1 = 2b - 1$$

Al dividir entre $b$: cociente = $\lfloor(2b-1)/b\rfloor = 1$ (ya que $b \leq 2b-1 < 2b$). El carry saliente es el cociente = **exactamente 1**.

Por lo tanto el carry siempre vale 0 (sin desborde de digito) o 1 (con desborde). Nunca puede ser 2 o mas.

Ejemplo verificador: base 10, digitos maximos 9+9+1=19=1·10+9 → carry=1, residuo=9. ✓

**Chuleta**
- Carry ∈ {0, 1} siempre, en cualquier base
- Maximo de dos digitos + carry entrante = $2(b-1)+1 = 2b-1 < 2b$ → cociente = 1

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — Interpretar binarios en C2 y S+M

**Enunciado**

Sean los siguientes numerales binarios de ocho digitos:
- $r = (1011\ 1111)_2$
- $s = (1000\ 0000)_2$
- $t = (1111\ 1111)_2$

¿Que numeros representan en complemento a 2? ¿Y en signo+magnitud?

**Explicacion**

Ejercita la interpretacion del mismo patron de bits bajo distintas convenciones. En C2, el MSB tiene peso $-2^{k-1}$; en S+M, el MSB solo indica signo. Los casos criticos son $s = (1000\ 0000)_2$ que es $-128$ en C2 pero $-0$ en S+M, y $t = (1111\ 1111)_2$ que es $-1$ en C2 pero $-127$ en S+M.

**Resolucion paso a paso**

$r = 1011\ 1111_2$ (8 bits)

**C2:** valor $= -2^7 + 0{\cdot}2^6 + 1{\cdot}2^5 + 1{\cdot}2^4 + 1{\cdot}2^3 + 1{\cdot}2^2 + 1{\cdot}2^1 + 1{\cdot}2^0 = -128 + 63 = \mathbf{-65}$

**S+M:** signo = 1 (negativo), magnitud = $0111\ 1111_2 = 127$ → $\mathbf{-63}$

---

$s = 1000\ 0000_2$ (8 bits)

**C2:** valor $= -2^7 = \mathbf{-128}$ (el minimo representable en C2 de 8 bits)

**S+M:** signo = 1 (negativo), magnitud = $000\ 0000_2 = 0$ → $\mathbf{-0}$ (equivale a 0)

---

$t = 1111\ 1111_2$ (8 bits)

**C2:** valor $= -2^7 + 2^6 + 2^5 + \ldots + 2^0 = -128 + 127 = \mathbf{-1}$

**S+M:** signo = 1 (negativo), magnitud = $111\ 1111_2 = 127$ → $\mathbf{-127}$

---

| Patron | C2 | S+M |
|--------|----|-----|
| $r = 10111111$ | $-65$ | $-63$ |
| $s = 10000000$ | $-128$ | $-0$ |
| $t = 11111111$ | $-1$ | $-127$ |

**Chuleta**
- **C2:** valor = $-b_{k-1} \cdot 2^{k-1} + \sum_{i=0}^{k-2} b_i \cdot 2^i$
- **S+M:** signo = MSB; magnitud = valor posicional de los $k-1$ bits restantes
- Casos criticos: $10000000$ → C2 = $-128$, S+M = $-0$; $11111111$ → C2 = $-1$, S+M = $-127$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/rangos_representacion_numerica]] | [[parciales_analizados/1P_2C_2024]] (Ej1 rangos S+M/C2), [[parciales_analizados/1P_2C_2024_recuperatorio]] (Ej1)

---

### Ejercicio 5 — Codificar numeros en S+M y C2

**Enunciado**

Codificar los siguientes numeros usando la precision y representacion indicada:

- $0_{10}$ → 8 bits, signo+magnitud y complemento a 2
- $-1_{10}$ → 8 bits y 16 bits, en ambos casos C2 y S+M
- $255_{10}$ → 8 bits sin signo y 16 bits C2
- $-128_{10}$ → 8 bits y 16 bits, en ambos casos C2
- $128_{10}$ → 8 bits sin signo y 16 bits C2

**Explicacion**

Ejercita la conversion de decimal a distintas representaciones. Casos interesantes: $-128$ en C2 de 8 bits es representable pero no en S+M de 8 bits (rango S+M: $-127$ a $127$); $255$ en 8-bit sin signo es `11111111` pero en C2 de 8 bits seria $-1$ → usar 16 bits. Extension de signo al pasar de 8 a 16 bits en C2.

**Resolucion paso a paso**

**$0_{10}$:**
- 8-bit S+M: $0000\ 0000$ (convencion $+0$; tambien existe $1000\ 0000 = -0$)
- 8-bit C2: $0000\ 0000$

**$-1_{10}$:**
- 8-bit S+M: $1000\ 0001$ (signo=1, magnitud=1)
- 8-bit C2: NOT($0000\ 0001$)+1 = $1111\ 1110 + 1 = 1111\ 1111$
- 16-bit S+M: $1000\ 0000\ 0000\ 0001$
- 16-bit C2: ext. de signo de $1111\ 1111$ → $1111\ 1111\ 1111\ 1111$

**$255_{10}$:**
- 8-bit sin signo: $1111\ 1111$ (rango [0, 255])
- 16-bit C2: $0000\ 0000\ 1111\ 1111$ (positivo, no requiere ext. de signo con 1s)

**$-128_{10}$:**
- 8-bit C2: $1000\ 0000$ (minimo representable; metodo: NOT($1000\ 0000$)+1 = $0111\ 1111+1 = 1000\ 0000$) ✓
- 16-bit C2: ext. de signo de $1000\ 0000$ → $1111\ 1111\ 1000\ 0000$
- *Nota: $-128$ no es representable en S+M de 8 bits (rango S+M: $[-127, 127]$)*

**$128_{10}$:**
- 8-bit sin signo: $1000\ 0000$
- 16-bit C2: $0000\ 0000\ 1000\ 0000$ (positivo)

**Chuleta**
- C2 positivo = representacion binaria normal (igual que sin signo)
- C2 negativo: NOT(magnitud) + 1
- Extension de signo C2: rellenar con el MSB a la izquierda
- S+M: MSB=signo, resto=magnitud; sin ext. de signo (siempre 0s)
- $-128$ cabe en C2 de 8 bits pero NO en S+M de 8 bits

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/rangos_representacion_numerica]] | [[parciales_analizados/1P_2C_2024]] (Ej1), [[parciales_analizados/1P_1C_2025]] (Ej1 tabla sin signo/CA2)

---

### Ejercicio 6 — Comparacion de rangos C2 vs S+M

**Enunciado**

¿Puede alguna cadena binaria de $k$ digitos, interpretada en C2, representar un numero que no puede ser representado por una cadena de la misma longitud en S+M? ¿Y al reves?

**Explicacion**

Pregunta conceptual sobre rangos:
- C2 de $k$ bits: $[-2^{k-1},\ 2^{k-1}-1]$
- S+M de $k$ bits: $[-(2^{k-1}-1),\ 2^{k-1}-1]$

C2 puede representar $-2^{k-1}$ que S+M no puede. S+M representa $-0$ que no existe en C2. La diferencia clave es que C2 tiene un negativo mas que S+M.

**Resolucion paso a paso**

Rangos de $k$ bits:
- **C2:** $[-2^{k-1},\ 2^{k-1}-1]$
- **S+M:** $[-(2^{k-1}-1),\ 2^{k-1}-1]$

**¿Puede C2 representar algo que S+M no puede?** → **Si.**

C2 incluye el valor $-2^{k-1}$ (p.ej. $-8$ en 4 bits = $1000_2$). S+M de 4 bits tiene rango $[-7, 7]$; el patron $1000$ en S+M es $-0$, no $-8$. Entonces $-2^{k-1}$ es representable en C2 pero no en S+M.

**¿Puede S+M representar algo que C2 no puede?** → **No** (en cuanto a valores matematicos distintos).

Los valores de S+M estan en $[-(2^{k-1}-1), 2^{k-1}-1] \subseteq [-2^{k-1}, 2^{k-1}-1]$ = rango C2. El patron $-0$ de S+M es matematicamente igual a 0, que C2 si representa. Ningun valor matematico distinto de los de C2 aparece en S+M.

**Resumen:**

| Pregunta | Respuesta | Ejemplo (4 bits) |
|----------|-----------|-----------------|
| ¿C2 tiene numeros que S+M no tiene? | Si | $-8 = 1000_2$ solo en C2 |
| ¿S+M tiene numeros que C2 no tiene? | No | El $-0$ es matematicamente 0 |

**Chuleta**
- C2 tiene un negativo extra: $-2^{k-1}$
- S+M tiene $-0$ (extra sintactico, no semantico)
- El rango de S+M es simetrico, el de C2 es asimetrico (un negativo mas)

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/rangos_representacion_numerica]] | [[parciales_analizados/1P_2C_2024]] (Ej1 rangos), [[parciales_analizados/1P_2C_2024_recuperatorio]] (Ej1)

---

### Ejercicio 7 — Overflow en las sumas del Ej. 2

**Enunciado**

Interpretar los operandos y resultados de las sumas del ejercicio 2 como representaciones en C2 y, para cada una, indicar cuales son correctas y cuales evidencian overflow.

**Explicacion**

Aplica la regla de overflow en C2: overflow ocurre cuando dos operandos del mismo signo producen resultado de signo opuesto. Equivalentemente: $V = C_k \oplus C_{k-1}$ (XOR de los dos carries superiores). Este ejercicio une la mecanica del Ej. 2 con la semantica de C2.

**Resolucion paso a paso**

Regla de overflow en C2: **overflow ocurre si y solo si dos operandos del mismo signo producen resultado de signo opuesto** (los signos de los operandos son iguales entre si y distintos al del resultado).

Usando los resultados del Ej 2:

**1) $100001_2 + 011110_2 = 111111_2$, carry=0 (6 bits C2)**

- $100001_2$ en C2 de 6 bits: $-2^5+1 = -31$
- $011110_2 = +30$
- Signos distintos → **nunca hay overflow**. Resultado: $-1 = 111111_2$ ✓

**2) $100001_2 + 011111_2$, resultado 6 bits = $000000_2$, carry=1**

- $-31 + 31 = 0$. Signos distintos → **sin overflow**. El carry se ignora en C2. ✓

**3) $01111_2 + 01111_2 = 11110_2$, carry=0 (5 bits C2)**

- Ambos = $+15$. Resultado esperado = $+30$, pero rango C2 de 5 bits = $[-16, 15]$. $30 > 15$ → **overflow**.
- $11110_2$ en C2 de 5 bits: $-2^4+14 = -2$. Ambos positivos, resultado negativo → confirma overflow. ✗

**4) $9999_{16} + 1111_{16} = \text{AAAA}_{16}$, carry=0 (16 bits C2)**

- $0x9999$: MSB=1 → negativo en C2. Valor: $39321 - 65536 = -26215$
- $0x1111 = +4369$
- Signos distintos → **sin overflow**. Resultado: $-21846 = 0x\text{AAAA}$ ✓

**5) $\text{F0F0}_{16} + \text{F0CA}_{16}$, resultado = $\text{E1BA}_{16}$, carry=1 (16 bits C2)**

- $0x\text{F0F0}$: negativo. $61680-65536=-3856$
- $0x\text{F0CA}$: negativo. $61642-65536=-3894$
- Ambos negativos. Resultado: $0x\text{E1BA}$, MSB=1 → negativo en C2. $57786-65536=-7750$. $-3856+(-3894)=-7750$ ✓
- Ambos negativos, resultado negativo → **sin overflow**. El carry se ignora.

| Suma | C2 (operandos) | Resultado | Overflow |
|------|----------------|-----------|---------|
| $100001+011110$ (6b) | $-31 + 30$ | $-1$ | No |
| $100001+011111$ (6b) | $-31 + 31$ | $0$ | No |
| $01111+01111$ (5b) | $+15 + 15$ | $-2$ (debia ser +30) | **Si** |
| $9999+1111$ (hex, 16b) | $-26215 + 4369$ | $-21846$ | No |
| $\text{F0F0}+\text{F0CA}$ (hex, 16b) | $-3856 + (-3894)$ | $-7750$ | No |

**Chuleta**
- Overflow en C2: signos iguales en operandos + signo diferente en resultado
- Equivalente: $V = C_{out}^{MSB} \oplus C_{in}^{MSB}$ (XOR de los dos carries del bit de signo)
- Signos distintos → nunca overflow
- Carry ≠ overflow: el carry puede existir sin overflow y viceversa

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/carry_y_overflow]] | [[parciales_analizados/1P_2C_2024]] (Ej1 overflow), [[parciales_analizados/1P_1C_2025]] (Ej1 flags CVZN), [[parciales_analizados/1P_2C_2024_recuperatorio]] (Ej1 overflow NEG+NEG=POS)

---

### Ejercicio 8 — Reordenar suma para evitar overflow

**Enunciado**

¿Como acomodar la siguiente suma de numeros hexadecimales de 4 digitos en C2 para que en ningun momento se produzca overflow?

$$7744_{16} + 5499_{16} + 6788_{16} + \text{AB68}_{16} + 88\text{BD}_{16} + 9879_{16} = 0003_{16}$$

**Explicacion**

La suma total da $0003_{16}$ (correcto), pero algunas sumas parciales intermedias producen overflow transitorio. El truco es intercalar positivos y negativos: $\text{AB68}_{16}$, $88\text{BD}_{16}$, $9879_{16}$ son negativos en C2 (MSB=1), los demas positivos. Reordenar para que los parciales no excedan el rango $[-32768, 32767]$.

**Resolucion paso a paso**

C2 de 4 digitos hex (16 bits): rango $[-32768, 32767]$.

Clasificar los sumandos (MSB=1 → negativo en C2):

| Numero | Hex | Decimal (C2) | Signo |
|--------|-----|--------------|-------|
| A | $7744$ | $+30532$ | + |
| B | $5499$ | $+21657$ | + |
| C | $6788$ | $+26504$ | + |
| D | $\text{AB68}$ | $-21656$ | − |
| E | $88\text{BD}$ | $-30531$ | − |
| F | $9879$ | $-26503$ | − |

Suma total: $30532+21657+26504-21656-30531-26503 = 3 = 0003_{16}$ ✓

**Problema con orden natural (A+B+C primero):**
$30532+21657 = 52189 > 32767$ → **overflow** ya en la primera suma parcial.

**Orden que evita overflow** (intercalar positivos y negativos):

| Paso | Operacion | Parcial |
|------|-----------|---------|
| 1 | $7744 + \text{AB68}$ | $30532 + (-21656) = 8876$ ✓ |
| 2 | $8876 + 5499$ | $8876 + 21657 = 30533$ ✓ |
| 3 | $30533 + 88\text{BD}$ | $30533 + (-30531) = 2$ ✓ |
| 4 | $2 + 6788$ | $2 + 26504 = 26506$ ✓ |
| 5 | $26506 + 9879$ | $26506 + (-26503) = 3$ ✓ |

Todos los parciales estan en $[-32768, 32767]$ → sin overflow en ningun paso.

**Chuleta**
1. Identificar positivos (MSB=0) y negativos (MSB=1) en C2
2. Ordenar intercalando: sumar un positivo, luego un negativo, alternadamente
3. Verificar que cada parcial no supere $2^{k-1}-1$ ni baje de $-2^{k-1}$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/carry_y_overflow]] — patron de overflow acumulado con multiples sumandos

---

### Ejercicio 9 — Pares con condiciones de carry/overflow

**Enunciado**

Dar ocho pares de numeros tales que la suma de sus representaciones en C2 de 4 bits provoque:

1. No acarreo ni overflow
2. Acarreo pero no overflow
3. Acarreo y overflow
4. No acarreo pero si overflow
5. Acarreo y resultado cero
6. No acarreo y resultado cero
7. Resultado negativo con overflow
8. Resultado negativo sin overflow

**Explicacion**

Ejercicio de diseño de casos de prueba para los flags de ALU. Requiere comprender que carry y overflow son ortogonales en C2: carry es un hecho aritmetico (hay bit extra), overflow es un error semantico (el resultado no cabe en el rango con signo). Los 8 casos cubren todas las combinaciones relevantes del espacio de flags $\{C, V, N, Z\}$.

**Resolucion paso a paso**

C2 de 4 bits: rango $[-8, 7]$. Carry: bit que sale del ancho de 4 bits. Overflow: dos operandos mismo signo → resultado signo opuesto.

| Caso | Par | Suma binaria | C out | Resultado C2 | Overflow | Notas |
|------|-----|--------------|-------|--------------|---------|-------|
| 1. Sin C, sin V | $+3\ (0011) + +4\ (0100)$ | $0111$ | 0 | $+7$ | No | |
| 2. Con C, sin V | $-1\ (1111) + +1\ (0001)$ | $1\ 0000$ | 1 | $0$ | No | Signos distintos |
| 3. Con C y V | $-7\ (1001) + -2\ (1110)$ | $1\ 0111$ | 1 | $+7$ | Si | NEG+NEG→POS |
| 4. Sin C, con V | $+5\ (0101) + +4\ (0100)$ | $1001$ | 0 | $-7$ | Si | POS+POS→NEG |
| 5. Con C, res=0 | $-4\ (1100) + +4\ (0100)$ | $1\ 0000$ | 1 | $0$ | No | Signos distintos |
| 6. Sin C, res=0 | $0\ (0000) + 0\ (0000)$ | $0000$ | 0 | $0$ | No | |
| 7. Res NEG con V | $+6\ (0110) + +5\ (0101)$ | $1011$ | 0 | $-5$ | Si | POS+POS→NEG |
| 8. Res NEG sin V | $-3\ (1101) + -4\ (1100)$ | $1\ 1001$ | 1 | $-7$ | No | NEG+NEG→NEG |

Verificaciones de los casos con overflow:
- Caso 3: $-7+(-2)=-9$, fuera de rango $[-8,7]$. Resultado truncado: $0111=+7$. ✓ overflow
- Caso 4: $+5+4=+9$, fuera de rango. Resultado: $1001=-7$. ✓ overflow
- Caso 7: $+6+5=+11$, fuera de rango. Resultado: $1011=-5$. ✓ overflow

**Chuleta**
- **Sin C sin V:** dos positivos pequenos (suma cabe en rango positivo)
- **Con C sin V:** positivo + negativo, suma modulo correcto (carry se ignora)
- **Con C y V:** dos negativos grandes; resultado desborda por abajo, aparece positivo
- **Sin C con V:** dos positivos grandes; resultado desborda por arriba, aparece negativo
- V = 1 siempre que mismo signo en operandos ≠ signo en resultado

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/flags_alu_cvzn]] | [[tipos_ejercicio/carry_y_overflow]] | [[parciales_analizados/1P_1C_2025]] (Ej1 flags CVZN), [[parciales_analizados/1P_2C_2024]] (Ej1 carry/overflow)

---

### Ejercicio 10 — SignExtn preserva el valor en C2

**Enunciado**

La funcion $\text{SignExt}_n$ convierte numeros de $k$ bits en numeros de $k+n$ bits:

$$\text{SignExt}_n(b_{k-1} \ldots b_0) = \begin{cases} 0\ldots 0\ b_{k-1} \ldots b_0 & \text{si } b_{k-1} = 0 \\ 1\ldots 1\ b_{k-1} \ldots b_0 & \text{si } b_{k-1} = 1 \end{cases}$$

Mostrar que para todo numero $x$ de $k$ bits, $x$ y $\text{SignExt}_n(x)$ representan el mismo numero en C2 de $k$ y $k+n$ bits respectivamente.

**Explicacion**

Demostracion algebraica de la extension de signo. Caso positivo ($b_{k-1}=0$): los $n$ ceros agregados no alteran el valor. Caso negativo ($b_{k-1}=1$): los $n$ unos agregados compensan exactamente el cambio en el peso del nuevo bit de signo. Usar la formula de valor en C2: $-b_{k-1} \cdot 2^{k-1} + \sum_{i=0}^{k-2} b_i \cdot 2^i$.

**Resolucion paso a paso**

Sea $x$ de $k$ bits con representacion en C2 $b_{k-1} \ldots b_0$.

**Valor de $x$ en C2 de $k$ bits:**
$$x = -b_{k-1} \cdot 2^{k-1} + \sum_{i=0}^{k-2} b_i \cdot 2^i$$

**Valor de $\text{SignExt}_n(x)$ en C2 de $k+n$ bits:**

*Caso positivo* ($b_{k-1}=0$): se agregan $n$ ceros al inicio. Los nuevos bits altos contribuyen $0 \cdot 2^{k}, 0 \cdot 2^{k+1}, \ldots, 0 \cdot 2^{k+n-1}$ (y el nuevo MSB $0 \cdot (-2^{k+n-1})$). Contribucion neta de los $n$ bits nuevos = 0. Queda el valor original $x$. ✓

*Caso negativo* ($b_{k-1}=1$): la nueva representacion tiene $n+1$ unos en las posiciones $k-1$ a $k+n-1$ (los $n$ unos agregados mas el MSB original), y el nuevo MSB con peso $-2^{k+n-1}$.

Valor en C2 de $k+n$ bits:
$$= -2^{k+n-1} + \underbrace{2^{k-1} + 2^k + \ldots + 2^{k+n-2}}_{n \text{ unos intermedios}} + \sum_{i=0}^{k-2} b_i \cdot 2^i$$

Los $n$ unos intermedios suman una serie geometrica:
$$2^{k-1} + 2^k + \ldots + 2^{k+n-2} = 2^{k-1}(2^n - 1) = 2^{k+n-1} - 2^{k-1}$$

Sustituyendo:
$$= -2^{k+n-1} + (2^{k+n-1} - 2^{k-1}) + \sum_{i=0}^{k-2} b_i \cdot 2^i = -2^{k-1} + \sum_{i=0}^{k-2} b_i \cdot 2^i = x\ ✓$$

En ambos casos, $\text{SignExt}_n(x)$ representa el mismo valor que $x$. $\blacksquare$

**Chuleta**
- Caso positivo: ceros agregados no suman nada
- Caso negativo: los unos intermedios y el nuevo bit de signo se cancelan algebraicamente, preservando $-2^{k-1}$
- La clave: $\sum_{j=k-1}^{k+n-2} 2^j = 2^{k+n-1} - 2^{k-1}$, que cancela exactamente al nuevo peso $-2^{k+n-1}$

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 11 — Inverso aditivo en C2

**Enunciado**

Representar $2$, $-5$ y $0$ en C2 de 4 bits. Luego:

a) Invertir todos los bits de cada representacion e indicar a que numero representa en C2.

b) Proponer un metodo para obtener la representacion en C2 del inverso aditivo de un numero.

**Explicacion**

El inverso aditivo en C2 se obtiene invirtiendo todos los bits y sumando 1 ($-x = \overline{x} + 1$). El punto (a) muestra experimentalmente que invertir bits da $\overline{x} = -(x+1)$, y (b) construye el metodo a partir de esa observacion. Caso especial: inverso de $-2^{k-1}$ no es representable en C2 de $k$ bits (overflow).

**Resolucion paso a paso**

Representaciones de partida en C2 de 4 bits:
- $2_{10} = 0010_2$
- $-5_{10}$: NOT($0101$)+1 = $1010+1 = 1011_2$
- $0_{10} = 0000_2$

**a) Invertir todos los bits (NOT) e interpretar en C2 de 4 bits:**

| Numero | C2 | NOT | C2 de NOT | Interpretacion |
|--------|-----|-----|-----------|----------------|
| $+2$ | $0010$ | $1101$ | $-3$ | NOT$(2) = -3$ |
| $-5$ | $1011$ | $0100$ | $+4$ | NOT$(-5) = +4$ |
| $0$ | $0000$ | $1111$ | $-1$ | NOT$(0) = -1$ |

Patron: $\text{NOT}(x) = -(x+1) = -x - 1$

**b) Metodo para el inverso aditivo:**

Del patron anterior: $\text{NOT}(x) = -x - 1$, entonces $-x = \text{NOT}(x) + 1$.

**Metodo:** invertir todos los bits y sumar 1.

Verificacion:
- $-2$: NOT($0010$)+1 = $1101+1 = 1110$. C2($1110$) $= -2$. ✓
- $+5$: NOT($1011$)+1 = $0100+1 = 0101$. C2($0101$) $= +5$. ✓
- $-0$: NOT($0000$)+1 = $1111+1 = 10000$, truncar a 4 bits = $0000 = 0$. ✓

**Caso especial:** inverso de $-8$ ($1000$): NOT($1000$)+1 = $0111+1 = 1000 = -8$. El $+8$ no es representable en C2 de 4 bits → overflow.

**Chuleta**
1. NOT$(x) = -x - 1$ (invertir todos los bits da el complementario, no el inverso)
2. $-x = \text{NOT}(x) + 1$ (invertir + sumar 1)
3. Caso especial: inverso de $-2^{k-1}$ produce overflow (no hay $+2^{k-1}$ en C2 de $k$ bits)

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/rangos_representacion_numerica]] | [[parciales_analizados/1P_2C_2024]] (Ej1 inverso aditivo), [[parciales_analizados/1P_2C_2024_recuperatorio]] (Ej1)

---

### Ejercicio 12 — Biyectividad de sistemas de representacion (V/F)

**Enunciado**

Un sistema de representacion es **biyectivo** si no admite mas de una representacion para cada numero y toda cadena disponible representa algun numero.

Decidir si la siguiente afirmacion es verdadera o falsa y justificar:

> "No es posible dar con un sistema que represente numeros con signo utilizando cadenas binarias de longitud fija que sea biyectivo, tenga una representacion para el cero y donde la cantidad de numeros positivos y negativos representados sea la misma."

**Explicacion**

Pregunta conceptual sobre teoria de representaciones. Una cadena de $k$ bits tiene $2^k$ patrones. Si es biyectivo: $2^k$ numeros distintos. Si hay un cero y cantidades iguales de positivos y negativos: necesitaria $2m + 1$ numeros (impar). Pero $2^k$ es siempre par → contradiccion → la afirmacion es **verdadera**. C2 "resuelve" esto asimetrizando el rango (un negativo mas que positivos).

**Resolucion paso a paso**

La afirmacion es **Verdadera**.

**Demostracion:**

Con cadenas de $k$ bits hay $2^k$ patrones distintos. Si el sistema es biyectivo, cada patron corresponde a un numero diferente → hay exactamente $2^k$ numeros representados.

Si el sistema tiene un cero mas $m$ positivos y $m$ negativos, la cantidad total de numeros es $2m + 1$ (impar).

Pero $2^k$ es siempre **par** (para cualquier $k \geq 1$). Contradiccion: $2m+1 \neq 2^k$.

Por lo tanto no existe tal sistema. $\blacksquare$

**Por que C2 evita este problema:** C2 no es simetrico; tiene $2^{k-1}$ negativos y $2^{k-1}-1$ positivos mas el cero. La cantidad total es $2^k$ (par), pero la distribucion es asimetrica.

**Chuleta**
- $2^k$ es par → imposible tener cero + misma cantidad de positivos y negativos (eso requeriria $2m+1$ numeros, impar)
- La simetria exige sacrificar el cero (Ej 13) o la biyectividad (S+M: tiene $-0$)

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 13 — Sistema biyectivo con igual cantidad de positivos y negativos

**Enunciado**

Dar un ejemplo de un sistema de representacion biyectivo en el que la cantidad de numeros positivos y negativos representados sea la misma.

**Explicacion**

Sigue del Ej. 12: dado que $2^k$ es par, un sistema biyectivo puede tener igual cantidad de positivos y negativos si y solo si **no incluye representacion para el cero**. Un ejemplo posible: complemento a 1 sin la cadena de todos ceros, o simplemente un sistema con $2^{k-1}$ negativos y $2^{k-1}$ positivos sin cero. El ejercicio invita a construir tal sistema.

**Resolucion paso a paso**

Del Ej 12: $2^k$ es par, y si hay igual cantidad de positivos ($m$) y negativos ($m$), la cantidad total es $2m$ (par). Para que sea biyectivo: $2m = 2^k$ → $m = 2^{k-1}$. Esto es posible si y solo si **el sistema no incluye representacion para el cero**.

**Ejemplo concreto para $k=3$ bits (8 cadenas):**

| Cadena | Numero representado |
|--------|---------------------|
| $000$ | $+1$ |
| $001$ | $+2$ |
| $010$ | $+3$ |
| $011$ | $+4$ |
| $100$ | $-1$ |
| $101$ | $-2$ |
| $110$ | $-3$ |
| $111$ | $-4$ |

Este sistema es:
- **Biyectivo:** cada cadena → numero distinto, y cada numero tiene exactamente un patron ✓
- **4 positivos, 4 negativos:** igual cantidad ✓
- **Sin representacion para el cero** ✓

Regla general: la cadena $b_{k-1} b_{k-2} \ldots b_0$ representa $(-1)^{b_{k-1}} \cdot (b_{k-2}\ldots b_0 + 1)_{(10)}$, que siempre es $\neq 0$.

**Chuleta**
- Imposible ser biyectivo con cero + simetria → hay que eliminar el cero
- Con $k$ bits sin cero: $2^{k-1}$ positivos y $2^{k-1}$ negativos
- Ejemplo: interpretar los $k-1$ bits bajos como magnitud en $[1, 2^{k-1}]$ con el MSB como signo

**¿Aparece en parciales?** ⚪ No
