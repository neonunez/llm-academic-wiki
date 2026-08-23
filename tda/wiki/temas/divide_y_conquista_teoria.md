---
nombre: Divide & Conquer — Teoria
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: divide_y_conquista
fuentes:
  vigente: []
  historico:
    - raw/clases/teo/1.teo_1P_divide_&_conquer.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[complejidad_computacional_teoria]]"
  - "[[fuerza_bruta_backtracking_teoria]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Divide & Conquer — Teoria

## Concepto y definicion

Tambien conocida como: Divide & Conquer, Dividir y Conquistar, D&C.

Se basa en:
1. **Dividir** un problema en subproblemas del mismo tipo que el original.
2. **Resolver** los problemas mas pequenos (recursivamente).
3. **Combinar** las soluciones.

### Caracteristicas de algoritmos D&C

- Las subpartes tienen que ser **mas pequenas** que el original.
- Las subpartes deben ser el **mismo tipo de tarea**.
- Dividir y combinar pueden no ser nulas, pero no tienen que ser demasiado costosas.

### Forma general

```
F(X):
  Si X es suficientemente chico o simple:
    solucionar de manera ad hoc
  Si no:
    Dividir a X en X_1, X_2, ..., X_k
    Para cada i <= k: Y_i = F(X_i)
    Combinar los Y_i en un Y que es solucion para X
    Devolver Y
```

**Ejemplos D&C / No D&C:**
- Pintar una pared: si (dividir en secciones, mismo tipo de tarea)
- Construir una casa: no (subtareas heterogeneas)
- Buscar al maximo en una matriz recursivamente: si

## Cuando se aplica

- El problema se puede descomponer en subproblemas **del mismo tipo**.
- Los subproblemas son **independientes** entre si.
- El costo de dividir y combinar no domina el costo total.

## Propiedades y teoremas

### Analisis de complejidad de D&C

El costo de un algoritmo D&C de tamano $n$ se expresa como $T(n)$, considerando:

- Dividir el problema en $a$ subproblemas de tamano maximo $n/c$ (siempre que $n/c > n_0$).
- El costo de subdividir y combinar los resultados.
- Resolver los subproblemas: $a \cdot T(n/c)$.

Se define una funcion $g(n)$ tal que $g(n) \geq T(n)$:

$$g(1) = b = \max\{b', T(1)\}$$
$$g(n) = a \cdot g(n/c) + b \cdot n^d \quad \text{si } n > 1$$

donde $b' \cdot n^d$ es cota superior del costo de dividir + combinar para tamano $n$.

Es decir: $T(n) \leq a \cdot T(n/c) + b' \cdot n^d \leq g(n) = a \cdot g(n/c) + b \cdot n^d$.

### Desarrollo de la recurrencia

Suponiendo $n = c^k$ para algun $k$:

$$g(c^k) = a^j \cdot g(c^{k-j}) + b \sum_{i=0}^{j-1} a^i \cdot c^{(k-i)d}$$

Caso base cuando $c^{k-j} = 1$, es decir $j = k = \log_c n$:

$$g(n) = b \sum_{i=0}^{k} a^i \cdot c^{(k-i)d} = b \cdot n^d \sum_{i=0}^{k} \left(\frac{a}{c^d}\right)^i$$

### Analisis por casos (d = 1)

**Caso $a = 1$, $d = 0$** (1 subproblema, combinar con costo constante):

$$T(n) = O(\log_c n)$$

**Caso $d = 1$ (division + union con costo lineal):**

- Si $a < c$ ("pocos subproblemas"): $a/c < 1$, la serie converge $\Rightarrow T(n) = O(n)$
- Si $a = c$: $T(n) = O(n \log_c n)$
- Si $a > c$ ("muchos subproblemas"): $T(n) = O(n^{\log_c a})$

## Demostraciones

### Derivacion del caso $a > c$, $d = 1$

$$g(n) = b \cdot n \sum_{i=0}^{\log_c n} (a/c)^i$$

Usando la formula de serie geometrica $\sum_{i=0}^{x} y^i = \frac{y^{x+1} - 1}{y - 1}$:

$$T(n) \leq g(n) = b \cdot n \cdot \frac{(a/c)^{\log_c n + 1} - 1}{a/c - 1}$$

Aplicando $O()$:

$$O\left(n \cdot \left(\frac{a}{c}\right)^{\log_c n}\right) = O\left(n \cdot \frac{a^{\log_c n}}{n}\right) = O(a^{\log_a n \cdot \log_c a}) = O(n^{\log_c a})$$

## Formulas clave

### Teorema Maestro

Permite resolver relaciones de recurrencia de la forma:

$$T(n) = \begin{cases} a \cdot T(n/c) + f(n) & \text{si } n > 1 \\ 1 & \text{si } n = 1 \end{cases}$$

| Caso | Condicion | Resultado |
|------|-----------|-----------|
| 1 | $f(n) = O(n^{\log_c a - \epsilon})$ para $\epsilon > 0$ | $T(n) = \Theta(n^{\log_c a})$ |
| 2 | $f(n) = \Theta(n^{\log_c a})$ | $T(n) = \Theta(n^{\log_c a} \log n)$ |
| 2' | $f(n) = \Theta(n^{\log_c a} \log^k n)$ para $k \geq 0$ | $T(n) = \Theta(n^{\log_c a} \log^{k+1} n)$ |
| 3 | $f(n) = \Omega(n^{\log_c a + \epsilon})$ para $\epsilon > 0$, y $a \cdot f(n/c) < k \cdot f(n)$ para $k < 1$ y $n$ suf. grande | $T(n) = \Theta(f(n))$ |

### Resumen rapido de resultados

Para $T(n) = a \cdot T(n/c) + b \cdot n^d$:

| Relacion | Complejidad |
|----------|-------------|
| $a < c^d$ | $\Theta(n^d)$ |
| $a = c^d$ | $\Theta(n^d \log n)$ |
| $a > c^d$ | $\Theta(n^{\log_c a})$ |

## Ejemplo: Algoritmo de Karatsuba

**Problema:** Multiplicar dos numeros enteros de $n$ digitos en base $b$.

- Complejidad clasica: $O(n^2)$.

**Idea:** Expresar los numeros como:

$$x = x_1 \cdot b^{n/2} + x_0 \qquad y = y_1 \cdot b^{n/2} + y_0$$

Entonces $x \cdot y = x_1 y_1 \cdot b^n + (x_0 y_1 + x_1 y_0) \cdot b^{n/2} + x_0 y_0$

Definiendo:
- $m_1 = x_0 \cdot y_0$
- $m_2 = x_1 \cdot y_1$
- $m_3 = (x_0 - x_1)(y_1 - y_0)$

La multiplicacion se convierte en:

$$x \cdot y = m_2 \cdot b^n + (m_1 + m_2 + m_3) \cdot b^{n/2} + m_1$$

### Algoritmo

```
Karatsuba(x, y):
  1. Si son suficientemente chicos, multiplicar "a mano" y retornar.
  2. Separar x en x_1 y x_0.
  3. Separar y en y_1 y y_0.
  4. Calcular m_1, m_2 y m_3 mediante llamadas recursivas.
  5. Sumar m_2 desplazado n b-bits + (m_1 + m_2 + m_3) desplazado n/2 b-bits + m_1.
  6. Retornar esa suma.
```

### Complejidad

- Separaciones, sumas y desplazados son lineales en $n$.
- Hay **3 llamadas recursivas** de tamano $n/2$.

$$T(n) = 3T(\lceil n/2 \rceil) + cn + c'$$

Con $f(n) = O(n^{\log_2 3 - \epsilon})$, por el Teorema Maestro:

$$T(n) = \Theta(n^{\log_2 3}) \approx \Theta(n^{1.59})$$

## Ver tambien

- [[complejidad_computacional_teoria]] — definiciones de complejidad y notacion O
- [[fuerza_bruta_backtracking_teoria]] — cuando D&C no aplica, alternativas de busqueda
