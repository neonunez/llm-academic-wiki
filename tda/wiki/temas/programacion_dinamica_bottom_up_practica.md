---
nombre: Programacion Dinamica Bottom-Up — Clase Practica
parcial: 1P
tipo: practica
tema: programacion_dinamica
fuente: raw/clases/prac/4.prac_1P_programacion_dinamica_bottom_up.pdf
paginas_relacionadas:
  - "[[programacion_dinamica_teoria]]"
  - "[[programacion_dinamica_top_down_practica_pt1]]"
  - "[[programacion_dinamica_top_down_practica_pt2]]"
---

## Patrones de este tema en parciales
> [[tipos_ejercicio/pd_definir_recursion]] · [[tipos_ejercicio/pd_superposicion_subproblemas]]

---

## Ejercicios de clase

### Ejercicio — Fibonacci Bottom-Up

**Enunciado**
$$f(n) = \begin{cases} 1 & \text{si } n \leq 1 \\ f(n-1) + f(n-2) & \text{c.c.} \end{cases}$$

**Explicacion**
Contraste directo con top-down. La clave es que $f(i)$ solo depende de los dos estados anteriores, lo que permite optimizar la memoria de $O(n)$ a $O(1)$.

**Resolucion paso a paso**

1. **Top-down con memo** — resolver empezando por $f(n)$, guardando en $M$. Complejidad: $O(n)$ tiempo, $O(n)$ espacio.

2. **Identificar orden de dependencias** — $f(i)$ depende de $f(i-1)$ y $f(i-2)$, ambos de indice mas chico. Orden valido: $f(0) \to f(1) \to \cdots \to f(n)$.

3. **Bottom-up basico** — recorrer en orden creciente:
```
F(n):
  Sea M ∈ N^(n+1) con M[0] = M[1] = 1
  Para i desde 2 hasta n:
    M[i] ← M[i-1] + M[i-2]
  Retornar M[n]
```
Complejidad: $O(n)$ tiempo, $O(n)$ espacio.

4. **Optimizacion de memoria** — $f(i)$ solo usa los dos anteriores, nunca los previos:
```
F(n):
  último, anteúltimo ← 1
  Repetir n-2 veces:
    actual ← último + anteúltimo
    anteúltimo ← último
    último ← actual
  Retornar último
```
Complejidad: $O(n)$ tiempo, $O(1)$ espacio.

**Chuleta**
> 1. Identificar que $f(i)$ solo depende de los $k$ estados anteriores → 2. Usar solo $k$ variables en lugar de todo el arreglo → Espacio $O(k)$ en lugar de $O(n)$

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio — Astro Trade Bottom-Up

**Enunciado**
Sea $p \in \mathbb{N}^n$ tal que $p_i$ es el precio de un asteroide el $i$-esimo dia. Lu quiere comprar y vender para maximizar ganancia neta. Puede comprar a lo sumo 1 por dia, vender a lo sumo 1 por dia, comienza sin asteroides, no puede vender lo que no tiene, y en la solucion optima termina sin asteroides.

*(El mismo problema de la clase de top-down; esta clase se enfoca en la version bottom-up y optimizacion de espacio.)*

**Explicacion**
La funcion recursiva ya fue definida en la clase de top-down (ver [[programacion_dinamica_top_down_practica_pt1]]). Aqui se convierte a bottom-up y se reduce el espacio de $O(n^2)$ a $O(n)$.

**Formulacion recursiva (recordatorio)**
$$\text{mgn}(a, d) = \begin{cases}
-\infty & \text{si } a < 0 \text{ o } a > d \\
0 & \text{si } d = 0 \\
\max(\text{mgn}(a-1, d-1) - p[d],\ \text{mgn}(a+1, d-1) + p[d],\ \text{mgn}(a, d-1)) & \text{c.c.}
\end{cases}$$

**Demostracion: la solucion optima termina con 0 asteroides**
Sea $o$ una solucion optima con $k$ asteroides al final del dia $n$.
- Si $k < 0$: invalido (vender sin tener → restriccion violada).
- Si $k > 0$: sea $i$ el ultimo dia que Lu compro. La solucion $o'$ donde no compra ese dia tiene ganancia $g(o') = g(o) + p_i > g(o)$, contradiccion con la optimalidad de $o$.
- Por lo tanto $k = 0$. $\square$

**Demostracion de correctitud de la recurrencia (induccion en $d$)**

*Proposicion:* Para todo $d \in \{0, \ldots, n\}$ y todo $a$, la funcion $\text{mgn}(a, d)$ devuelve la maxima ganancia neta alcanzable al final del dia $d$ poseyendo exactamente $a$ asteroides.

*Caso base* ($d = 0$): Solo el estado $a = 0$ es valido con ganancia $0$; todo otro estado es $-\infty$. Coincide con la definicion.

*Paso inductivo* ($d$): Asumiendo que la proposicion vale para $d-1$, toda secuencia factible que lleva al estado $(a, d)$ proviene de exactamente una de tres acciones desde el dia $d-1$:
- No operar: $(a, d-1)$, ganancia $\text{mgn}(a, d-1)$.
- Comprar: $(a-1, d-1)$, ganancia $\text{mgn}(a-1, d-1) - p_d$.
- Vender: $(a+1, d-1)$, ganancia $\text{mgn}(a+1, d-1) + p_d$.

Cada termino es correcto por HI. Tomar el maximo selecciona la mejor accion. $\square$

**Bottom-Up iterativo**
```
Sea M una matriz de (n+1)×(n+1) inicializada en −∞
M[0][0] ← 0
Para d ← 1..n:
  Para a ← 0..n:
    ans ← M[d-1][a]
    Si a > 0: ans ← max(ans, M[d-1][a-1] - prices[d-1])
    Si a < d: ans ← max(ans, M[d-1][a+1] + prices[d-1])
    M[d][a] ← ans
Devolver M[n][0]
```
Complejidad: $O(n^2)$ tiempo, $O(n^2)$ espacio.

**Optimizacion de espacio a $O(n)$**
Observacion: para calcular el dia $d$ solo se necesita el dia $d-1$. Se pueden usar dos arrays alternantes con indice $d \bmod 2$:

```
Sea M una matriz de 2×(n+1) inicializada en −∞
M[0][0] ← 0
Para d ← 1..n:
  prev ← (d-1) mod 2,  curr ← d mod 2
  Para a ← 0..n:
    ans ← M[prev][a]
    Si a > 0: ans ← max(ans, M[prev][a-1] - prices[d-1])
    Si a < d: ans ← max(ans, M[prev][a+1] + prices[d-1])
    M[curr][a] ← ans
Devolver M[n mod 2][0]
```
Complejidad: $O(n^2)$ tiempo, $O(n)$ espacio.

**Chuleta**
> 1. Definir $\text{mgn}(a, d)$ = ganancia max con $a$ asteroides al fin del dia $d$ → 2. Bottom-up: iterar $d$ de 1 a $n$, $a$ de 0 a $n$ → 3. Optimizar espacio: si $f(d, \cdot)$ solo depende de $f(d-1, \cdot)$, usar 2 arrays alternantes → espacio $O(n)$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/pd_definir_estado]]

---

### Ejercicio — Mi Buenos Aires Crecido (LIS ponderada)

**Enunciado**
Se tiene un arreglo de $N$ edificios, cada uno con un ancho $\text{largo}(i)$ y una altura $\text{alto}(i)$. Se quiere encontrar la subsecuencia de edificios de alturas estrictamente crecientes que maximice la suma de los anchos (longitud de la maxima subsecuencia ascendente ponderada por ancho).

*Ejemplo:* para la secuencia de edificios la respuesta es 85 (suma de anchos de una subsecuencia creciente de 3 edificios).

**Explicacion**
Es una variante de LIS (Longest Increasing Subsequence) donde la longitud se reemplaza por la suma de anchos. Hay dos formulaciones recursivas: una con estado $(i, \text{ult})$ de $O(N^2)$ estados (y $O(N^2)$ espacio), y una reformulacion con estado solo $\text{pos}$ de $O(N)$ espacio.

**Formulacion 1: estado $(i, \text{ult})$**

Sea $\text{alto}(-1) = 0$.
$$f(i, \text{ult}) = \begin{cases}
0 & \text{si } i \geq N \\
f(i+1, \text{ult}) & \text{si } \text{alto}(\text{ult}) \geq \text{alto}(i) \\
\max\{f(i+1, \text{ult}),\ f(i+1, i) + \text{largo}(i)\} & \text{c.c.}
\end{cases}$$

Respuesta: $f(0, -1)$.

Complejidad sin memo: $\Omega(2^N)$ (en el peor caso, edificios crecientes, se exploran todos los subconjuntos).
Complejidad con memo: $O(N^2)$ estados $\times O(1)$ por estado $= O(N^2)$ tiempo, $O(N^2)$ espacio.

```
Sea M ∈ N^(N×N) inicializada indefinida
F(i, ult):
  Si M[i][ult] está definido: devolver M[i][ult]
  Si i ≥ N: devolver 0
  Si alto(ult) ≥ alto(i): devolver F(i+1, ult)
  M[i][ult] ← max{F(i+1, ult), F(i+1, i) + largo(i)}
  devolver M[i][ult]
```

**Formulacion 2: estado $\text{pos}$ (espacio $O(N)$)**

Redefinimos el estado: $\text{LIS}(\text{pos})$ = maximo ancho de subsecuencia ascendente que **termina** en el edificio $\text{pos}$.

$$\text{LIS}(\text{pos}) = \begin{cases}
\text{anchos}[\text{pos}] & \text{si } \nexists\, j < \text{pos} \text{ t.q. } \text{alt}[j] < \text{alt}[\text{pos}] \\
\text{anchos}[\text{pos}] + \max_{j < \text{pos},\, \text{alt}[j] < \text{alt}[\text{pos}]} \text{LIS}(j) & \text{c.c.}
\end{cases}$$

Respuesta: $\max_{\text{pos}} \text{LIS}(\text{pos})$.

```python
def LIS(pos, alturas, anchos, memo):
    if memo[pos] == -1:
        ancho_maximo_anterior = 0
        for j in range(0, pos):
            if alturas[j] < alturas[pos]:
                ancho_maximo_anterior = max(ancho_maximo_anterior, LIS(j, alturas, anchos, memo))
        memo[pos] = anchos[pos] + ancho_maximo_anterior
    return memo[pos]
```

Complejidad: $O(N^2)$ tiempo (cada estado cuesta $O(\text{pos})$), $O(N)$ espacio.

Nota del profesor: existe una version $O(N \log N)$ (no cubierta en esta clase).

**Chuleta**
> Formulacion por sufijo $(i, \text{ult})$: $O(N^2)$ espacio | Formulacion por prefijo $\text{LIS}(\text{pos})$: $O(N)$ espacio, misma complejidad temporal

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio — Garland

**Enunciado**
Lean tiene una guirnalda de $n$ bombillas en una fila. Cada bombilla lleva un numero distinto entre 1 y $n$, en orden arbitrario. El gato retiro algunas (marcadas con $0$). La complejidad de la guirnalda es la cantidad de pares de bombillas adyacentes con diferente paridad. Lean quiere recolocar las bombillas faltantes de forma que la complejidad sea minima.

*Ejemplo:* Para $[1, 4, 2, 3, 5]$ la complejidad es 2. Para $[1, 3, 5, 7, 6, 4, 2]$ la complejidad es 1.

**Explicacion**
La idea clave: para minimizar cambios de paridad, conviene agrupar todos los impares juntos y todos los pares juntos. Solo habra (a lo sumo) 1 cambio de paridad entre el grupo de impares y el grupo de pares. En cada posicion cero se puede elegir poner un par o un impar (si quedan disponibles), y el costo depende de la paridad del elemento anterior.

**Estado:** $\text{gar}(i, e, p)$ = costo minimo desde la posicion $i$, con $e$ pares usados en los ceros hasta $i$, y siendo $p \in \{0, 1\}$ la paridad del ultimo elemento (0 par, 1 impar).

**Definiciones auxiliares:**
- $\text{par}(x) = x \bmod 2$
- $\text{odds\_used}(i, e) = \text{prefZero}[i] - e$ (impares usados en ceros = total ceros en prefijo $i$ menos pares usados)
- $\text{avail\_even}$ = cantidad de pares disponibles entre los ceros
- $\text{avail\_odd}$ = cantidad de impares disponibles entre los ceros
- $S(i, e)$ = opciones disponibles en posicion $i$ con $e$ pares usados: $\{(e+1, 0)$ si $e < \text{avail\_even}\} \cup \{(e, 1)$ si $\text{odds\_used}(i,e) < \text{avail\_odd}\}$
- $\text{costoCambio}(i, p, p') = \begin{cases} 1 & \text{si } i > 0 \text{ y } p \neq p' \\ 0 & \text{sino} \end{cases}$

**Funcion recursiva:**
$$\text{gar}(i, e, p) = \begin{cases}
0 & \text{si } i = n \\
\text{costoCambio}(i, p, \text{par}(a_i)) + \text{gar}(i+1, e, \text{par}(a_i)) & \text{si } a_i \neq 0 \\
\min_{(e', p') \in S(i,e)} \text{costoCambio}(i, p, p') + \text{gar}(i+1, e', p') & \text{si } a_i = 0
\end{cases}$$

Convencion: para el primer elemento ($i = 0$) no se penaliza el cambio.

**Complejidad:** Estados: $n \times \text{avail\_even} \times 2 = O(n^2)$, transiciones $O(1)$ por estado. Total: $O(n^2)$ tiempo, $O(n^2)$ espacio (reducible a $O(n)$ con bottom-up).

**Top-Down (C++):**
```cpp
int gar(int i, int e_used, int last_par) {
    if (i == n) return 0;
    int &res = memo[i][e_used][last_par];
    if (res != -1) return res;
    res = INF;
    bool first = (i == 0);
    auto relax = [&](int next_e_used, int cur_par) {
        int add = (first ? 0 : (cur_par != last_par));
        res = min(res, add + gar(i + 1, next_e_used, cur_par));
    };
    if (a[i] != 0) {
        int par = (a[i] & 1);
        relax(e_used, par);
    } else {
        int zeros_used = prefZero[i];
        int odds_used = zeros_used - e_used;
        if (e_used + 1 <= avail_even) relax(e_used + 1, 0);  // colocar par
        if (odds_used + 1 <= avail_odd) relax(e_used, 1);    // colocar impar
    }
    return res;
}
```

**Bottom-Up (C++) — orden de i = n-1 hacia 0:**
```cpp
for (int i = n-1; i >= 0; --i) {
    for (int e = 0; e <= avail_even; ++e) {
        for (int last_par = 0; last_par <= 1; ++last_par) {
            int best = INF;
            bool first = (i == 0);
            auto updateBest = [&](int next_par, int next_e) {
                int add = (first ? 0 : (next_par != last_par));
                best = min(best, add + dp[i+1][next_e][next_par]);
            };
            if (a[i] != 0) {
                int par = (a[i] & 1);
                updateBest(par, e);
            } else {
                int zeros_used = prefZero[i];
                int odds_used = zeros_used - e;
                if (e + 1 <= avail_even) updateBest(0, e + 1);
                if (odds_used + 1 <= avail_odd) updateBest(1, e);
            }
            dp[i][e][last_par] = best;
        }
    }
}
```

**Chuleta**
> Estado: (posicion, pares\_usados\_en\_ceros, paridad\_ultimo) → transicion: si $a_i \neq 0$ la paridad es fija; si $a_i = 0$ elegir entre par/impar segun disponibilidad → Bottom-up de derecha a izquierda

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio — Caesar's Legions Optimizado

**Enunciado**
*(Mismo problema de la clase de top-down: P patos, D dodos, no mas de MP patos consecutivos ni MD dodos consecutivos. Contar formas de organizar la linea.)*

**Esta clase:** Optimizar la solucion top-down de $O(P \cdot D \cdot (P + D))$ a $O(P \cdot D)$ usando tablas aditivas.

**Solucion top-down (recordatorio)**
$$f(nP, nD, \text{ultTropa}) = \begin{cases}
1 & \text{si } nP + nD = 0 \\
\text{ponerPATO}(nP, nD) & \text{si ultTropa} = \text{DODO} \\
\text{ponerDODO}(nP, nD) & \text{si ultTropa} = \text{PATO}
\end{cases}$$

$$\text{ponerPATO}(nP, nD) = \sum_{i=1}^{\min(nP, MP)} f(nP - i, nD, \text{PATO})$$
$$\text{ponerDODO}(nP, nD) = \sum_{i=1}^{\min(nD, MD)} f(nP, nD - i, \text{DODO})$$

Cantidad de estados: $P \cdot D \cdot 2 \in \Theta(P \cdot D)$. Transiciones por estado: $O(MP + MD) \in O(P + D)$. Complejidad total: $O(P \cdot D \cdot (P + D)) = O(N^3)$ asumiendo $P, D \in O(N)$.

**Optimizacion a $O(P \cdot D)$ con tablas aditivas**

Observacion: ponerPATO y ponerDODO son sumas de rangos de la tabla $f$.

Definimos tablas aditivas $TP$ y $TD$:
$$TP[i][nD] = \sum_{j=0}^{i-1} f(j, nD, \text{PATO}) = TP[i-1][nD] + f(i-1, nD, \text{PATO})$$
$$TD[i][nP] = \sum_{j=0}^{i-1} f(nP, j, \text{DODO}) = TD[i-1][nP] + f(nP, i-1, \text{DODO})$$

Al calcular cada $f(nP, nD, \text{ultTropa})$:
- Si ultTropa = PATO: $TP[nP+1][nD] = f(nP, nD, \text{PATO}) + TP[nP][nD]$
- Si ultTropa = DODO: $TD[nP][nD+1] = f(nP, nD, \text{DODO}) + TD[nP][nD]$

Luego las sumas quedan:
$$\text{ponerPATO}(nP, nD) = TP[nP][nD] - TP[\max(0, nP - MP)][nD]$$
$$\text{ponerDODO}(nP, nD) = TD[nP][nD] - TD[nP][\max(0, nD - MD)]$$

Complejidad: $P \cdot D \cdot 2$ estados, $O(1)$ por estado $\Rightarrow O(P \cdot D)$.

**Requisito:** Bottom-up garantiza el orden correcto de calculo de los estados para que las tablas aditivas esten disponibles.

**Implementacion Bottom-Up (Python):**
```python
np, nd, kp, kd = map(int, input().split())
mod, PATO, DODO = 10**8, 0, 1
f = [[[0,0] for _ in range(nd+2)] for _ in range(np+2)]
tp = [[0]*(nd+2) for _ in range(np+2)]
td = [[0]*(nd+2) for _ in range(np+2)]
for p in range(0, np+1):
    for d in range(0, nd+1):
        for ultTropa in range(2):
            if (p+d) == 0: f[p][d][ultTropa] = 1
            elif ultTropa == DODO:
                f[p][d][DODO] = (tp[p][d] - tp[max(0,p-kp)][d] + mod) % mod
            else:
                f[p][d][PATO] = (td[p][d] - td[p][max(0,d-kd)] + mod) % mod
            if ultTropa == PATO: tp[p+1][d] = (tp[p][d] + f[p][d][PATO]) % mod
            else: td[p][d+1] = (td[p][d] + f[p][d][DODO]) % mod
print((f[np][nd][PATO] + f[np][nd][DODO]) % mod)
```
AC: 156ms en Codeforces 118D.

**Chuleta**
> 1. Identificar que la transicion es una suma de rango en la tabla $f$ → 2. Definir tablas aditivas $TP$, $TD$ para computarlas en $O(1)$ → 3. Usar bottom-up para garantizar orden correcto de calculo

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio — Lagunas

**Enunciado**
Marcos tiene un terreno $1 \times N$. Cada casilla es agua o tierra. Puede excavar casillas de tierra a costo $T_i$. Puede colocar barcos de distintos largos, ordenados crecientemente de izquierda a derecha, sin solaparse, en casillas contiguas de agua (incluyendo excavadas). Por cada barco obtiene ganancia $G$. Maximizar la ganancia neta.

**Explicacion**
Problema con multiples optimizaciones: $O(N^3) \to O(N^2\sqrt{N}) \to O(N\sqrt{N})$ en tiempo, y reduccion a $O(N)$ en espacio.

**Version $O(N^3)$**

Estado: $f(i, b)$ = maxima ganancia posible considerando las primeras $i$ casillas y los primeros $b$ barcos (de largos $1, 2, \ldots, b$).

$$f(i, b) = \begin{cases}
0 & \text{si } i = 0 \text{ o } b = 0 \\
-\infty & \text{si } i < 0 \text{ o } b < 0 \\
\max(f(i-1, b),\ f(i, b-1),\ \text{usar\_barco}(i, b)) & \text{si } i > 0
\end{cases}$$

$$\text{usar\_barco}(i, b) = \begin{cases}
f(i-b, b-1) + G - \sum_{j=i-b+1}^{i} T_j & \text{si } i - b \geq 0 \\
-\infty & \text{si } i - b < 0
\end{cases}$$

Respuesta: $f(N, N)$.

Complejidad: $N^2$ estados, sumatoria $O(N)$ por estado $\Rightarrow O(N^3)$.

**Optimizacion a $O(N^2\sqrt{N})$**

Observacion: nunca conviene saltarse un barco. Si se usan $b$ barcos, son los de longitudes $1, 2, \ldots, b$.

La longitud total $L = \sum_{i=1}^{b} i = \frac{b(b+1)}{2} \leq N$, por lo tanto $b = O(\sqrt{N})$.

Definiendo $B$ como el maximo $b$ tal que $\frac{B(B+1)}{2} \leq N$, la respuesta es $f(N, B)$.

Ahora el estado es $f(i, b)$ con $b \leq B = O(\sqrt{N})$, por lo que hay $N \cdot B = O(N\sqrt{N})$ estados, y la sumatoria sigue siendo $O(N)$ por estado $\Rightarrow O(N^2\sqrt{N})$.

**Optimizacion a $O(N\sqrt{N})$**

La sumatoria $\sum_{j=i-b+1}^{i} T_j$ es una suma de rango. Se puede precalcular con una tabla aditiva de $T$ y evaluarla en $O(1)$.

Ahora: $O(N\sqrt{N})$ estados $\times O(1)$ por estado $\Rightarrow O(N\sqrt{N})$.

**Optimizacion a $O(N)$ de espacio**

Igual que en otros problemas: si $f(i, b)$ depende solo de $f(i-1, \cdot)$ y $f(i, \cdot)$, se puede reducir el espacio de $O(N \cdot B)$ a $O(N)$.

**Chuleta**
> 1. Estado $(i, b)$: primeras $i$ casillas, barcos $1..b$ → 2. Cota $b = O(\sqrt{N})$: suma de $1..b \leq N$ → 3. Suma de rango con tabla aditiva para calcular costo de excavacion en $O(1)$ → complejidad final $O(N\sqrt{N})$

**¿Aparece en parciales?** ⚪ No

---

## Ver tambien

- [[programacion_dinamica_teoria]] — teoria completa (top-down vs bottom-up, mochila, monedas, SCML)
- [[programacion_dinamica_top_down_practica_pt1]] — Fibonacci top-down, AstroTrade top-down, Tobi el granjero
- [[programacion_dinamica_top_down_practica_pt2]] — Receta 6 pasos, Vacations, Caesar's Legions top-down, Fire
