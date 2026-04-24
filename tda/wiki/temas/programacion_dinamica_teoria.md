---
nombre: Programacion Dinamica — Teoria
parcial: 1P
tipo: teoria
tema: programacion_dinamica
fuente:
  - raw/clases/teo/3.teo_1P_programacion_dinamica.pdf
  - raw/clases/teo/3.teo_1P_demo_mochila.pdf
  - raw/clases/teo/3.teo_1P_demo_monedas.pdf
paginas_relacionadas:
  - "[[divide_y_conquista_teoria]]"
  - "[[fuerza_bruta_backtracking_teoria]]"
  - "[[greedy_teoria]]"
---

# Programacion Dinamica — Teoria

## Concepto y definicion

Al igual que Divide & Conquer, se divide el problema en subproblemas de tamanos menores que se resuelven recursivamente.

**Diferencia clave:** en PD hay **superposicion de estados** — el arbol de llamadas recursivas resuelve el mismo subproblema varias veces. PD evita estas repeticiones.

### Dos enfoques

1. **Top-down (memorizacion):** Se implementa recursivamente, pero se guarda el resultado de cada llamada en una estructura de datos. Si una llamada se repite, se toma el resultado almacenado.
2. **Bottom-up (tabulacion):** Se resuelven primero los subproblemas mas pequenos y se guardan todos los resultados en una tabla, generalmente iterando.

> El nombre "programacion dinamica" fue elegido por Richard Bellman (1950) para ocultar la naturaleza matematica de su trabajo al Secretario de Defensa Charles Wilson, quien tenia "miedo y odio patologico a la palabra *research*".

## Cuando se aplica

- El problema tiene **subestructura optima**: la solucion optima se construye a partir de soluciones optimas de subproblemas.
- Hay **superposicion de subproblemas**: los mismos subproblemas se resuelven repetidamente en la recursion directa.

## Ejemplo 1: Coeficientes binomiales

### Definicion

$$\binom{n}{k} = \frac{n!}{k!(n-k)!}$$

Computar directamente la definicion no es buena idea: overflow y precision numerica.

### Relacion recursiva (Triangulo de Pascal)

$$\binom{n}{k} = \begin{cases} 1 & \text{si } k = 0 \text{ o } k = n \\ \binom{n-1}{k-1} + \binom{n-1}{k} & \text{si } 0 < k < n \end{cases}$$

### Implementacion recursiva directa (mala)

```
combinatorio(n, k):
  si k = 0 o k = n: retornar 1
  sino:
    a := combinatorio(n-1, k-1)
    b := combinatorio(n-1, k)
    retornar a + b
```

Complejidad: $\Omega\left(\binom{n}{k}\right)$ — exponencial por superposicion de estados.

### Implementacion bottom-up (PD)

```
combinatorio(n, k):
  para i = 1 hasta n: A[i][0] <- 1
  para j = 0 hasta k: A[j][j] <- 1
  para i = 2 hasta n:
    para j = 1 hasta min(i-1, k):
      A[i][j] <- A[i-1][j-1] + A[i-1][j]
  retornar A[n][k]
```

### Comparacion de complejidades

| Metodo | Tiempo | Espacio |
|--------|--------|---------|
| Definicion directa ($n!$) | $O(n)$ pero inestable | $O(1)$ |
| Recursion directa | $\Omega\left(\binom{n}{k}\right)$ | $O(n)$ (pila) |
| PD bottom-up | $O(nk)$ | $\Theta(k)$ (solo fila anterior) |

> Optimizacion de espacio: solo se necesita almacenar la fila anterior. Esto **no es posible con top-down**. Se puede mejorar aprovechando $\binom{n}{k} = \binom{n}{n-k}$.

## Ejemplo 2: Problema del cambio de monedas

### Datos

- Denominaciones $a_1, \ldots, a_k \in \mathbb{Z}^+$ (con $a_i > a_{i+1}$)
- Objetivo $t \in \mathbb{Z}^+$

**Problema:** Encontrar $x_1, \ldots, x_k \in \mathbb{Z}^+$ tales que $t = \sum_{i=1}^{k} x_i a_i$, minimizando $x_1 + \cdots + x_k$.

### Definicion recursiva

Sea $f(s)$ la cantidad minima de monedas para entregar $s$ centavos:

$$f(s) = \begin{cases} 0 & \text{si } s = 0 \\ \min_{i: a_i \leq s} \{1 + f(s - a_i)\} & \text{si existe } i \text{ tal que } a_i \leq s \\ \infty & \text{en otro caso} \end{cases}$$

### Teorema

Si $f(s) < \infty$ entonces $f(s)$ es el valor optimo del problema del cambio para entregar $s$ centavos. Si $f(s) = \infty$, el problema no tiene solucion.

### Demostracion (del cambio de monedas)

**Parte 1: Si $f(s) = \infty$, no existe solucion.**

Por contradiccion. Supongamos que existe una solucion con $p$ monedas $\{b_1, \ldots, b_p\}$ donde $b_j \in \{a_1, \ldots, a_k\}$ y $s = \sum_{j=1}^{p} b_j$.

Por definicion de $f$:

$$f(s) \leq 1 + f(s - b_1) \leq 2 + f(s - b_1 - b_2) \leq \cdots \leq p + f\left(s - \sum_{j=1}^{p} b_j\right) = p + f(0) = p$$

Contradiccion: $f(s)$ no puede ser $\infty$ y $\leq p$ simultaneamente.

**Parte 2: Si $f(s) = q < \infty$, entonces $q$ es el valor optimo.**

Si $f(s) = q$, por la definicion recursiva existe moneda $c_1$ tal que:

$$f(s) = \min_{i: a_i \leq s}\{1 + f(s - a_i)\} = 1 + f(s - c_1)$$

Desarrollando: $f(s) = 1 + f(s - c_1) = 2 + f(s - c_1 - c_2) = \cdots = q + f(0) = q$

Se encuentran $q$ monedas $\{c_1, \ldots, c_q\}$ que suman exactamente $s$. Es optimo porque si existiera solucion con menos de $q$ monedas, la definicion de $f$ como minimo la habria elegido. $\blacksquare$

## Ejemplo 3: Problema de la mochila

### Datos

- Capacidad $C \in \mathbb{Z}^+$, cantidad $n \in \mathbb{Z}^+$ de objetos
- Peso $p_i \in \mathbb{Z}_{>0}$ y beneficio $b_i \in \mathbb{Z}^+$ de cada objeto $i$

**Problema:** Maximizar beneficio total sin exceder capacidad $C$.

### Definicion recursiva

$m(k, D)$ = valor optimo con los primeros $k$ objetos y capacidad $D$:

$$m(k, D) = \begin{cases} 0 & \text{si } k = 0 \text{ o } D = 0 \\ m(k-1, D) & \text{si } k > 0 \text{ y } p_k > D \\ \max\{m(k-1, D),\; b_k + m(k-1, D - p_k)\} & \text{si } k > 0 \text{ y } p_k \leq D \end{cases}$$

Los dos terminos del max representan:
- **No incluir** objeto $k$: valor = $m(k-1, D)$
- **Incluir** objeto $k$: valor = $b_k + m(k-1, D - p_k)$

### Teorema

$m(n, C)$ es el valor optimo para el problema de la mochila con $n$ objetos y capacidad $C$.

### Demostracion (de la mochila, por induccion en k)

**Lema clave:** Si una solucion es optima, entonces al quitar cualquier objeto de ella, la solucion restante es optima para el subproblema correspondiente.

**Caso base:** $k = 0$: sin objetos, $m(0, D) = 0$ es optimo. $D = 0$: sin capacidad, $m(k, 0) = 0$ es optimo.

**Hipotesis inductiva:** Para algun $k' \geq 1$, $m(j, D')$ es optimo para todo $j < k'$ y toda capacidad $D' \geq 0$.

**Paso inductivo para $k'$, capacidad $D > 0$:**

- **Caso $p_{k'} > D$:** El objeto $k'$ no cabe. Cualquier solucion factible excluye $k'$, reduciendose al subproblema $(k'-1, D)$. Por HI, $m(k', D) = m(k'-1, D)$ es optimo.

- **Caso $p_{k'} \leq D$:** Sea $S^*$ solucion optima para $(k', D)$:
  - **$k' \notin S^*$:** $S^*$ usa solo objetos $\{1, \ldots, k'-1\}$. Por el lema y la HI, valor optimo = $m(k'-1, D)$.
  - **$k' \in S^*$:** $S^* \setminus \{k'\}$ usa objetos $\{1, \ldots, k'-1\}$ con capacidad $D - p_{k'}$. Por el lema y la HI, valor optimo = $b_{k'} + m(k'-1, D - p_{k'})$.
  - Como no sabemos cual caso da el optimo: $m(k', D) = \max\{m(k'-1, D),\; b_{k'} + m(k'-1, D - p_{k'})\}$. $\blacksquare$

### Complejidad

- Tabla de $(n+1)(C+1)$ entradas, cada una se completa en $O(1)$.
- **Complejidad total:** $O(nC)$.
- **Algoritmo pseudopolinomial:** su tiempo esta acotado por un polinomio en los *valores numericos* del input, no en la *longitud* del input (la longitud de $C$ es $\log C$ bits).

### Reconstruccion de la solucion

El calculo de $m(k, D)$ da el valor optimo pero no el conjunto de objetos. Para reconstruir la solucion, recorrer la tabla desde $m(n, C)$: si $m(k, D) \neq m(k-1, D)$, entonces el objeto $k$ fue incluido (seguir con $(k-1, D - p_k)$); si no, fue excluido (seguir con $(k-1, D)$).

## Ejemplo 4: Subsecuencia comun mas larga (SCML)

### Definicion

Dada una secuencia $A$, una **subsecuencia** se obtiene eliminando cero o mas simbolos de $A$ (preservando el orden).

**Ejemplo:** $[4, 7, 2, 3]$ y $[7, 5]$ son subsecuencias de $A = [4, 7, 8, 2, 5, 3]$, pero $[2, 7]$ no lo es.

**Problema:** Dadas dos secuencias $A = [a_1, \ldots, a_r]$ y $B = [b_1, \ldots, b_s]$, encontrar la subsecuencia comun mas larga.

### Estructura recursiva

Sean $A = [a_1, \ldots, a_r]$ y $B = [b_1, \ldots, b_s]$:

- **Si $a_r = b_s$:** la SCML se obtiene agregando $a_r$ al final de la SCML entre $[a_1, \ldots, a_{r-1}]$ y $[b_1, \ldots, b_{s-1}]$.
- **Si $a_r \neq b_s$:** la SCML es la mas larga entre:
  1. SCML entre $[a_1, \ldots, a_{r-1}]$ y $[b_1, \ldots, b_s]$
  2. SCML entre $[a_1, \ldots, a_r]$ y $[b_1, \ldots, b_{s-1}]$

### Definicion recursiva

$l[i][j]$ = longitud de la SCML entre $[a_1, \ldots, a_i]$ y $[b_1, \ldots, b_j]$:

- $l[0][j] = 0$ para $j = 0, \ldots, s$
- $l[i][0] = 0$ para $i = 0, \ldots, r$
- Si $a_i = b_j$: $l[i][j] = l[i-1][j-1] + 1$
- Si $a_i \neq b_j$: $l[i][j] = \max\{l[i-1][j],\; l[i][j-1]\}$

Solucion: $l[r][s]$.

### Algoritmo

```
scml(A, B):
  l[0][0] <- 0
  para i = 1 hasta r: l[i][0] <- 0
  para j = 1 hasta s: l[0][j] <- 0
  para i = 1 hasta r:
    para j = 1 hasta s:
      si A[i] = B[j]:
        l[i][j] <- l[i-1][j-1] + 1
      sino:
        l[i][j] <- max{l[i-1][j], l[i][j-1]}
  retornar l[r][s]
```

**Complejidad:** $O(r \cdot s)$ en tiempo, $O(r \cdot s)$ en espacio (optimizable a $O(\min(r, s))$ guardando solo dos filas).

## Formulas clave

$$\binom{n}{k} = \binom{n-1}{k-1} + \binom{n-1}{k}$$

$$f(s) = \min_{i: a_i \leq s}\{1 + f(s - a_i)\} \quad \text{(cambio de monedas)}$$

$$m(k, D) = \max\{m(k-1, D),\; b_k + m(k-1, D-p_k)\} \quad \text{(mochila)}$$

$$l[i][j] = \begin{cases} l[i-1][j-1] + 1 & \text{si } a_i = b_j \\ \max\{l[i-1][j], l[i][j-1]\} & \text{si } a_i \neq b_j \end{cases} \quad \text{(SCML)}$$

## Ver tambien

- [[divide_y_conquista_teoria]] — PD se diferencia de D&C por la superposicion de subproblemas
- [[fuerza_bruta_backtracking_teoria]] — fuerza bruta como baseline que PD mejora (mochila)
- [[greedy_teoria]] — algoritmos golosos como alternativa cuando la eleccion local es suficiente
