---
nombre: Definiciones y Demostraciones — Guia de Ejercicios (Repaso Induccion)
parcial: ambos
programa: 2C_2026
tipo: guia
tema: definiciones_y_demostraciones
fuentes:
  vigente: []
  historico:
    - raw/guias_practicas/0.guia_1P_repaso.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[definiciones_y_demostraciones_teoria]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Definiciones y Demostraciones — Guia de Ejercicios (Repaso Induccion)

Practica 0: Repaso de induccion matematica. 8 ejercicios fundamentales. Compilado: 17 agosto 2025.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Probar 8 identidades por induccion (sumatoria, cuadrados, Fibonacci) | ⚪ No |
| Ej. 2 | Formula de potencias de 2: $1 + 2 + 2^2 + \ldots + 2^n$ | ⚪ No |
| Ej. 3 | Colonia de hormigas (duplicacion anual, formula cerrada) | ⚪ No |
| Ej. 4 | $2^n > n^2$ para $n \geq 5$ | ⚪ No |
| Ej. 5 | Gatos Fibonacci (formula de Binet) | ⚪ No |
| Ej. 6 | Implementar recursion del ej. 5 con casos de test | ⚪ No |
| Ej. 7 | Error en demostracion: todos los elementos de un conjunto son iguales | 🔴 Si |
| Ej. 8 | Error en demostracion: $a^n = 1$ para todo $a \neq 0$ | 🔴 Si |

## Ejercicios

### Ejercicio 1 — Identidades por induccion

**Enunciado**

Probar por induccion:

a) $1 + 2 + \ldots + n = \dfrac{n(n+1)}{2}$, $\forall n \geq 1$

b) $1 + 3 + 5 + \ldots + (2n+1) = (n+1)^2$, $\forall n \geq 0$

c) $1^2 + 2^2 + \ldots + n^2 = \dfrac{n(n+1)(2n+1)}{6}$, $\forall n \geq 1$

d) $-1 + 2^2 - 3^2 + \ldots + (-1)^n n^2 = (-1)^n \dfrac{n(n+1)}{2}$, $\forall n \geq 1$

e) $(1 + 2 + 3 + \ldots + n)^2 = 1^3 + 2^3 + \ldots + n^3$, $\forall n \geq 1$

f) $1 \times 1! + 2 \times 2! + \ldots + n \times n! = (n+1)! - 1$, $\forall n \geq 1$

**Explicacion**

Ejercicios clasicos de induccion simple. Requieren: caso base, hipotesis inductiva clara, paso inductivo algebraico. El item d) requiere manejar signo alternado $(-1)^n$; el e) conecta suma y suma de cubos (identidad de Nicomachus).

**Resolucion paso a paso**

**a)** Sea $P(n): \sum_{i=1}^n i = \frac{n(n+1)}{2}$.

*Base* ($n=1$): $1 = \frac{1 \cdot 2}{2} = 1$. ✓

*HI:* $\sum_{i=1}^k i = \frac{k(k+1)}{2}$.

*Paso* ($k \to k+1$):
$$\sum_{i=1}^{k+1} i = \sum_{i=1}^k i + (k+1) = \frac{k(k+1)}{2} + (k+1) = (k+1)\left(\frac{k}{2} + 1\right) = \frac{(k+1)(k+2)}{2}$$
que es la formula para $n = k+1$. $\blacksquare$

**b)** Sea $P(n): \sum_{i=0}^n (2i+1) = (n+1)^2$.

*Base* ($n=0$): $2 \cdot 0 + 1 = 1 = 1^2$. ✓

*HI:* $1 + 3 + \ldots + (2k+1) = (k+1)^2$.

*Paso:*
$$\sum_{i=0}^{k+1}(2i+1) = (k+1)^2 + (2(k+1)+1) = k^2 + 2k + 1 + 2k + 3 = k^2 + 4k + 4 = (k+2)^2$$
que es la formula para $n = k+1$. $\blacksquare$

**c)** Sea $P(n): \sum_{i=1}^n i^2 = \frac{n(n+1)(2n+1)}{6}$.

*Base* ($n=1$): $1 = \frac{1 \cdot 2 \cdot 3}{6} = 1$. ✓

*HI:* $\sum_{i=1}^k i^2 = \frac{k(k+1)(2k+1)}{6}$.

*Paso:*
$$\sum_{i=1}^{k+1} i^2 = \frac{k(k+1)(2k+1)}{6} + (k+1)^2 = (k+1)\left[\frac{k(2k+1)}{6} + (k+1)\right] = (k+1) \cdot \frac{k(2k+1) + 6(k+1)}{6}$$
$$= (k+1) \cdot \frac{2k^2 + 7k + 6}{6} = \frac{(k+1)(k+2)(2k+3)}{6}$$
que es la formula para $n = k+1$. $\blacksquare$

**d)** Sea $P(n): \sum_{i=1}^n (-1)^i i^2 = (-1)^n \frac{n(n+1)}{2}$.

*Base* ($n=1$): $(-1)^1 \cdot 1 = -1 = (-1)^1 \cdot \frac{1 \cdot 2}{2} = -1$. ✓

*HI:* $\sum_{i=1}^k (-1)^i i^2 = (-1)^k \frac{k(k+1)}{2}$.

*Paso:*
$$\sum_{i=1}^{k+1} (-1)^i i^2 = (-1)^k \frac{k(k+1)}{2} + (-1)^{k+1}(k+1)^2$$
$$= (-1)^k(k+1)\left[\frac{k}{2} - (k+1)\right] \quad \text{[factorizando } (-1)^k(k+1)\text{, usando } (-1)^{k+1} = -(-1)^k \text{]}$$
$$= (-1)^k(k+1) \cdot \frac{k - 2(k+1)}{2} = (-1)^k(k+1) \cdot \frac{-(k+2)}{2} = (-1)^{k+1} \cdot \frac{(k+1)(k+2)}{2}$$
que es la formula para $n = k+1$. $\blacksquare$

**e)** Sea $P(n): \left(\sum_{i=1}^n i\right)^2 = \sum_{i=1}^n i^3$.

*Base* ($n=1$): $1^2 = 1 = 1^3$. ✓

*HI:* $\left(\frac{k(k+1)}{2}\right)^2 = \sum_{i=1}^k i^3$.

*Paso:*
$$\sum_{i=1}^{k+1} i^3 = \left(\frac{k(k+1)}{2}\right)^2 + (k+1)^3 = (k+1)^2\left[\frac{k^2}{4} + (k+1)\right] = (k+1)^2 \cdot \frac{k^2 + 4k + 4}{4} = (k+1)^2 \cdot \frac{(k+2)^2}{4}$$
$$= \left(\frac{(k+1)(k+2)}{2}\right)^2$$
que es la formula para $n = k+1$. $\blacksquare$

**f)** Sea $P(n): \sum_{i=1}^n i \cdot i! = (n+1)! - 1$.

*Base* ($n=1$): $1 \cdot 1! = 1 = 2! - 1 = 1$. ✓

*HI:* $\sum_{i=1}^k i \cdot i! = (k+1)! - 1$.

*Paso:*
$$\sum_{i=1}^{k+1} i \cdot i! = (k+1)! - 1 + (k+1)(k+1)! = (k+1)!\underbrace{[1 + (k+1)]}_{k+2} - 1 = (k+2)! - 1$$
que es la formula para $n = k+1$. $\blacksquare$

**Chuleta**

> **Plantilla induccion simple:**
> 1. Definir $P(n)$ explicitamente.
> 2. Base: verificar $P(n_0)$ sustituyendo directamente.
> 3. HI: enunciar "$P(k)$ vale para algun $k \geq n_0$".
> 4. Paso: escribir $P(k+1)$, separar el ultimo termino, aplicar HI al resto, simplificar.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 2 — Formula potencias de 2

**Enunciado**

Encontrar una formula para la suma $1 + 2 + 2^2 + 2^3 + \ldots + 2^n$ y demostrarla por induccion.

**Explicacion**

Serie geometrica de razon 2. La formula es $2^{n+1} - 1$. Ejercicio standard de induccion con suma geometrica; aparece como subproblema en analisis de D&C.

**Resolucion paso a paso**

**Formula:** $\displaystyle\sum_{i=0}^n 2^i = 2^{n+1} - 1$.

*Base* ($n=0$): $2^0 = 1 = 2^1 - 1$. ✓

*HI:* $\sum_{i=0}^k 2^i = 2^{k+1} - 1$.

*Paso:*
$$\sum_{i=0}^{k+1} 2^i = 2^{k+1} - 1 + 2^{k+1} = 2 \cdot 2^{k+1} - 1 = 2^{k+2} - 1$$
que es la formula para $n = k+1$. $\blacksquare$

**Chuleta**

> $\sum_{i=0}^n 2^i = 2^{n+1} - 1$. Base n=0: trivial. Paso: separar ultimo termino, aplicar HI, $2 \cdot 2^{k+1} = 2^{k+2}$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — Colonia de hormigas

**Enunciado**

La poblacion de una colonia de hormigas se duplica todos los anios. Si se establece una colonia inicial de 10 hormigas, ¿cuantas habra despues de $n$ anios?

**Explicacion**

Formula cerrada: $10 \cdot 2^n$. Demostracion por induccion trivial. Introduce la idea de formula cerrada para recurrencias simples.

**Resolucion paso a paso**

**Formula:** $H(n) = 10 \cdot 2^n$.

*Derivacion informal:* la recurrencia es $H(n) = 2 \cdot H(n-1)$, $H(0) = 10$. Aplicando $n$ veces: $H(n) = 2^n \cdot H(0) = 10 \cdot 2^n$.

*Demostracion por induccion:*

*Base* ($n=0$): $H(0) = 10 = 10 \cdot 2^0$. ✓

*HI:* $H(k) = 10 \cdot 2^k$.

*Paso:*
$$H(k+1) = 2 \cdot H(k) = 2 \cdot 10 \cdot 2^k = 10 \cdot 2^{k+1}$$
$\blacksquare$

**Chuleta**

> Recurrencia $T(n) = c \cdot T(n-1)$ con $T(0) = T_0$ → formula cerrada $T(n) = c^n \cdot T_0$. Demostrar por induccion separando $T(k+1) = c \cdot T(k)$ y aplicando HI.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — $2^n > n^2$ para $n \geq 5$

**Enunciado**

Probar por induccion que para $n \geq 5$ se verifica que $2^n > n^2$.

**Explicacion**

Induccion con hipotesis fuerte o standard. El caso base es $n = 5$: $2^5 = 32 > 25 = 5^2$. Paso inductivo: asumir $2^n > n^2$, mostrar $2^{n+1} > (n+1)^2$. Requiere la cota $2n^2 > n^2 + 2n + 1$, es decir $n^2 > 2n + 1$, i.e. $(n-1)^2 > 2$, valida para $n \geq 3$.

**Resolucion paso a paso**

*Base* ($n=5$): $2^5 = 32 > 25 = 5^2$. ✓

*HI:* $2^k > k^2$ para algun $k \geq 5$.

*Paso:* Necesito demostrar $2^{k+1} > (k+1)^2$.

$$2^{k+1} = 2 \cdot 2^k > 2k^2 \quad \text{[por HI]}$$

Queda ver $2k^2 \geq (k+1)^2 = k^2 + 2k + 1$, i.e. $k^2 \geq 2k + 1$, i.e. $k^2 - 2k - 1 \geq 0$, i.e. $(k-1)^2 \geq 2$.

Como $k \geq 5$, se tiene $k - 1 \geq 4 \geq \sqrt{2}$, entonces $(k-1)^2 \geq 16 > 2$. ✓

Por lo tanto $2^{k+1} > 2k^2 \geq (k+1)^2$. $\blacksquare$

**Chuleta**

> 1. Base $n=5$: verificar directamente.
> 2. HI: $2^k > k^2$.
> 3. $2^{k+1} = 2 \cdot 2^k \stackrel{HI}{>} 2k^2$.
> 4. Mostrar $2k^2 \geq (k+1)^2$ ↔ $(k-1)^2 \geq 2$, valido para $k \geq 3$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 — Gatos Fibonacci (formula de Binet)

**Enunciado**

La poblacion de gatos tiene la propiedad de que el numero de gatos en un anio es la suma de los dos anios anteriores. Si en el anio 1 habia 1 gato y en el anio 2 habia 2, probar que el numero de gatos en el anio $n$ es:

$$\frac{1}{\sqrt{5}} \left( \frac{1+\sqrt{5}}{2} \right)^{n+1} - \frac{1}{\sqrt{5}} \left( \frac{1-\sqrt{5}}{2} \right)^{n+1}$$

**Explicacion**

Esta es la formula de Binet para la sucesion de Fibonacci (con desplazamiento). La demostracion requiere induccion fuerte (con dos casos base). El paso inductivo usa que ambas raices $\phi = (1+\sqrt{5})/2$ y $\psi = (1-\sqrt{5})/2$ satisfacen $x^2 = x + 1$.

**Resolucion paso a paso**

Sean $\phi = \dfrac{1+\sqrt{5}}{2}$ y $\psi = \dfrac{1-\sqrt{5}}{2}$. Notar que $\phi - \psi = \sqrt{5}$, $\phi + \psi = 1$, $\phi \cdot \psi = -1$, y ambas satisfacen $x^2 = x + 1$ (raices de $x^2 - x - 1 = 0$).

La formula a demostrar es $F(n) = \dfrac{\phi^{n+1} - \psi^{n+1}}{\sqrt{5}}$.

*Base* ($n=1$): $\dfrac{\phi^2 - \psi^2}{\sqrt{5}} = \dfrac{(\phi-\psi)(\phi+\psi)}{\sqrt{5}} = \dfrac{\sqrt{5} \cdot 1}{\sqrt{5}} = 1 = F(1)$. ✓

*Base* ($n=2$): Usando $\phi\psi = -1$ y $\phi + \psi = 1$:
$$\frac{\phi^3 - \psi^3}{\sqrt{5}} = \frac{(\phi-\psi)(\phi^2 + \phi\psi + \psi^2)}{\sqrt{5}} = \phi^2 + \phi\psi + \psi^2 = (\phi+\psi)^2 - 2\phi\psi + \phi\psi = 1 - \phi\psi = 1-(-1) = 2 = F(2)$$
✓

*HI fuerte:* Para todo $j \leq k$ (con $k \geq 2$): $F(j) = \dfrac{\phi^{j+1} - \psi^{j+1}}{\sqrt{5}}$.

*Paso:* Por definicion de la sucesion:
$$F(k+1) = F(k) + F(k-1) = \frac{\phi^{k+1} - \psi^{k+1}}{\sqrt{5}} + \frac{\phi^k - \psi^k}{\sqrt{5}} = \frac{\phi^k(\phi+1) - \psi^k(\psi+1)}{\sqrt{5}}$$

Usando $x^2 = x + 1 \Rightarrow x + 1 = x^2$:
$$= \frac{\phi^k \cdot \phi^2 - \psi^k \cdot \psi^2}{\sqrt{5}} = \frac{\phi^{k+2} - \psi^{k+2}}{\sqrt{5}}$$
que es la formula para $n = k+1$. $\blacksquare$

**Chuleta**

> 1. Definir $\phi = (1+\sqrt5)/2$, $\psi = (1-\sqrt5)/2$. Ambas satisfacen $x^2 = x+1$.
> 2. Induccion fuerte con dos bases: $n=1$ y $n=2$.
> 3. Paso: $F(k+1) = F(k)+F(k-1) = \frac{\phi^{k+1}-\psi^{k+1}}{\sqrt5} + \frac{\phi^k-\psi^k}{\sqrt5}$.
> 4. Factorizar $\phi^k$ y $\psi^k$, usar $\phi+1=\phi^2$ y $\psi+1=\psi^2$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 6 — Implementacion recursiva de Fibonacci

**Enunciado**

Programar de manera recursiva (en el lenguaje favorito) la funcion del ejercicio 5. Escribir casos de test usando la formula cerrada demostrada.

**Explicacion**

Ejercicio de programacion basico. La formula cerrada sirve como oraculo para testear la implementacion recursiva.

**Resolucion paso a paso**

```python
from math import sqrt

def fib(n: int) -> int:
    """Fibonacci con F(1)=1, F(2)=2, F(n)=F(n-1)+F(n-2)."""
    if n == 1:
        return 1
    if n == 2:
        return 2
    return fib(n - 1) + fib(n - 2)

def fib_binet(n: int) -> int:
    """Formula de Binet (oraculo para testing)."""
    phi = (1 + sqrt(5)) / 2
    psi = (1 - sqrt(5)) / 2
    return round((phi**(n+1) - psi**(n+1)) / sqrt(5))

# Casos de test: comparar recursivo con Binet
for n in [1, 2, 3, 4, 5, 6, 7, 10]:
    r = fib(n)
    b = fib_binet(n)
    assert r == b, f"n={n}: fib={r}, binet={b}"
    print(f"F({n}) = {r}  ✓")
```

Salida esperada: $F(1)=1, F(2)=2, F(3)=3, F(4)=5, F(5)=8, F(6)=13, F(7)=21, F(10)=89$.

> Nota: `round()` es necesario porque `sqrt` es flotante y acumula error de punto flotante para $n$ grandes.

**Chuleta**

> Recursion directa: caso base $n \in \{1,2\}$, paso $fib(n-1)+fib(n-2)$. Test: usar Binet como oraculo con `round()`.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 7 — Error: todos los elementos son iguales

**Enunciado**

¿Cual es el error en la siguiente demostracion?

Se quiere probar que los elementos $x_1, x_2, \ldots, x_n$ de un conjunto son iguales entre si.

a) Paso inicial ($n=1$): El conjunto tiene un solo elemento $x_1$ que es igual a si mismo.

b) Paso inductivo: Supongamos que $x_1 = x_2 = \ldots = x_{n-1}$. Como tambien vale la hipotesis inductiva para un conjunto de dos elementos, tenemos que $x_{n-1} = x_n$ y por tanto resulta que $x_1 = x_2 = \ldots = x_{n-1} = x_n$.

**Explicacion**

Error clasico de induccion. El paso inductivo falla en el caso base del paso: cuando se aplica HI a "un conjunto de dos elementos" en el paso $n=2$, no se puede concluir $x_1 = x_2$ porque los dos subconjuntos de tamano 1 son disjuntos ($\{x_1\}$ y $\{x_2\}$). La hipotesis solo garantiza que cada conjunto de tamano $n-1 = 1$ es igualado internamente, pero no hay solapamiento entre los dos subconjuntos para el caso $n=2$. El error es que la HI para $n-1=1$ no "conecta" los elementos de los dos subconjuntos.

**Resolucion paso a paso**

El argumento falla en el **caso $n = 2$** del paso inductivo. 

El razonamiento implica: dado $\{x_1, x_2\}$, considerar el subconjunto $\{x_1\}$ (de tamano $n-1=1$, todos iguales trivialmente) y el subconjunto $\{x_2\}$ (idem). El argumento afirma que $x_1 = x_2$ porque "ambos son iguales a $x_{n-1}$". Pero con $n=2$, $x_{n-1} = x_1$ en el primer subconjunto y $x_{n-1} = x_1$ en... espera: los dos subconjuntos son $\{x_1\}$ y $\{x_2\}$, que son **disjuntos**. No hay un elemento comun que actue de "puente" para transferir la igualdad.

Para que el argumento funcione, se necesitaria que los dos subconjuntos de tamano $n-1$ **se superpongan** en al menos un elemento, de forma que la igualdad se "transfiera" a traves del elemento compartido. Esto ocurre para $n \geq 3$: los subconjuntos $\{x_1, \ldots, x_{n-1}\}$ y $\{x_2, \ldots, x_n\}$ comparten $\{x_2, \ldots, x_{n-1}\}$ (si $n \geq 3$). Pero para $n = 2$, $\{x_1\}$ y $\{x_2\}$ son disjuntos.

**En resumen:** el paso inductivo es valido solo para $n \geq 3$, pero falla exactamente para $n = 2$, que actua como caso base del paso. La base de la induccion es $n=1$ (correcta) pero el paso no cubre la transicion $1 \to 2$.

**Chuleta**

> Error: falla en $n=2$. Los subconjuntos $\{x_1\}$ y $\{x_2\}$ son **disjuntos** → no hay elemento puente para transferir igualdad. El paso es valido solo para $n \geq 3$.

**¿Aparece en parciales?** 🔴 Si — analisis de demos incorrectas aparece en parciales historicos rotulados 1P (ej. [[definiciones_y_demostraciones_teoria]]); tema transversal a ambos parciales con el programa vigente

---

### Ejercicio 8 — Error: $a^n = 1$

**Enunciado**

¿Cual es el error en la siguiente demostracion?

Se quiere probar que $\forall a \neq 0$ vale que $a^n = 1$.

a) Paso inicial ($n=0$): $a^0 = 1$ $\forall a$.

b) Paso inductivo: Supongamos que $a^{n-1} = 1$. Entonces:
$$a^n = \frac{a^{n-1} \times a^{n-1}}{a^{n-2}} = \frac{1 \times 1}{1} = 1$$

**Explicacion**

Error: el paso inductivo usa $a^{n-2}$, lo que require $n \geq 2$ para que el paso sea valido. Pero la induccion solo establece $n \geq 0$. Cuando $n = 1$, se intenta usar $a^{n-2} = a^{-1}$ que no necesariamente es 1 (HI solo dice $a^{n-1} = a^0 = 1$, no dice nada sobre $a^{-1}$). El error es una falla en el caso base del paso inductivo: no hay segunda hipotesis inductiva para $n-2$.

**Resolucion paso a paso**

El argumento del paso inductivo aplica la HI **dos veces**: una para $a^{n-1} = 1$ (explicitamente) y otra para $a^{n-2} = 1$ (en el denominador, implicitamente). Esto requiere $P(n-1)$ **y** $P(n-2)$.

El error se manifiesta en **$n = 1$**: la formula es $a^1 = \dfrac{a^0 \cdot a^0}{a^{-1}}$. La HI garantiza $a^0 = 1$, pero no establece que $a^{-1} = 1$. De hecho, $a^{-1} = 1/a \neq 1$ para $a \neq 1$.

Adicionalmente, la formula requiere $n \geq 2$ para que $a^{n-2}$ sea una potencia **entera no negativa** cubierta por la HI (que solo dice $P(n-1)$ para $n-1 \geq 0$). Para $n=1$, $a^{n-2} = a^{-1}$ esta fuera del dominio de la proposicion inducida.

**En resumen:** la HI deberia ser fuerte: $P(n-1)$ **y** $P(n-2)$, con caso base adicional $n=1$. Pero $P(1)$ es falsa ($a \neq 1$ en general), por lo que no hay base que establecer y la induccion colapsa.

**Chuleta**

> Error: el paso usa $a^{n-2}$ (implica $P(n-2)$ no establecida). Para $n=1$: $a^{-1}$ esta fuera del dominio de HI. HI deberia ser fuerte ($P(n-1)$ y $P(n-2)$) con base $n=1$, pero $P(1)$ es falsa.

**¿Aparece en parciales?** 🔴 Si — analisis de demos incorrectas aparece en parciales historicos rotulados 1P; tema transversal a ambos parciales con el programa vigente

## Ver tambien

- [[definiciones_y_demostraciones_teoria]] — Estrategias de demostracion, errores comunes
- [[divide_y_conquista_guia]] — Usa induccion para probar correctitud de D&C
