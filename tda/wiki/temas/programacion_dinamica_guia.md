---
nombre: Programacion Dinamica — Guia de Ejercicios
parcial: 1P
tipo: guia
tema: programacion_dinamica
fuente: raw/guias_practicas/2.guia_1P_tecnicas_algoritmicas.pdf
paginas_relacionadas:
  - "[[programacion_dinamica_teoria]]"
  - "[[programacion_dinamica_top_down_practica_pt1]]"
  - "[[programacion_dinamica_top_down_practica_pt2]]"
  - "[[programacion_dinamica_bottom_up_practica]]"
---

# Programacion Dinamica — Guia de Ejercicios

Practica 2 (Tecnicas Algoritmicas), seccion de Programacion Dinamica (ej. 9–26). Compilado: 17 sept. 2025.

La guia conecta sistematicamente BT → PD: para cada ejercicio, se parte de la recursion de BT y se aplica memoizacion o se transforma a bottom-up.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 9 | KingArmy — Fibonacci generalizado, O(N) | ⚪ No |
| Ej. 10 | Vacations — minimizar dias de descanso, O(N) | ⚪ No |
| Ej. 11 | SumaDinamica — suma de subconjuntos con PD (top-down + bottom-up) | 🔴 Si |
| Ej. 12 | OptiPago — pagar con minimo exceso y menos billetes | ⚪ No |
| Ej. 13 | AstroTrade — compra-venta de asteroides, mgn(a,d) | 🔴 Si |
| Ej. 14 | Fire — salvar articulos en incendio, $O(D \cdot N + N \log N)$ | 🔴 Si |
| Ej. 15 | CortesEconomicos — orden optimo de cortes en una vara | 🔴 Si |
| Ej. 16 | TravesiaVital — camino con minima vida inicial en grilla de trampas | ⚪ No |
| Ej. 17 | PilaCauta — maxima pila de cajas con restriccion de soporte | 🔴 Si |
| Ej. 18 | OperacionesSeq — intercalar +, ×, ↑ entre elementos de vector para llegar a w | ⚪ No |
| Ej. 19 | DadosSuma — contar formas de sumar s con n dados de k caras (distinguibles e indistinguibles) | ⚪ No |
| Ej. 20 | CaesarsLegions — contar formaciones de P patos y D dodos con restriccion de consecutivos | 🔴 Si |
| Ej. 21 | Farmer — recolectar arvejas en grilla M×N con divisibilidad por K+1 | ⚪ No |
| Ej. 22 | ProblemasAnteriores — reducir complejidad espacial de ejercicios anteriores | ⚪ No |
| Ej. 23 | ABBOptimoBU — ABB optimo bottom-up en $O(n^3)$ con optim. de Knuth | 🔴 Si |
| Ej. 24 | Lagunas (TAP 2025 L) — barcos en grilla, ganancia neta, opt. $O(N^3) \to O(N^{3/2})$ | ⚪ No |
| Ej. 25 | MiBuenosAiresCrecido — LIS ponderada por ancho de edificios | 🔴 Si |
| Ej. 26 | Guirnaldas (CF 1286A) — completar secuencia de guirnaldas con min complejidad | ⚪ No |

## Patrones de este tema en parciales

> BT→PD via memoizacion · Recurrencia con semantica clara · Top-down vs Bottom-up · Optimizacion espacial

## Ejercicios

### Ejercicio 9 — KingArmy (Fibonacci)

**Enunciado**

El rey Cambyses arma ejercitos en dias consecutivos: el ejercito del dia $d_i$ es igual a la suma de los dias $i-1$ e $i-2$. Los dias 0 y 1 tienen siempre 1 persona. Dado un dia $N$, devolver el numero de personas.

Pensar un algoritmo $O(N)$ y demostrar correctitud y complejidad.

**Explicacion**

Fibonacci con desplazamiento. PD con 2 variables: $O(N)$ tiempo y $O(1)$ espacio.

**Resolucion paso a paso**

**Formulacion recursiva:**

$$king(d) = \begin{cases} 1 & d \le 1 \\ king(d-1) + king(d-2) & d \ge 2 \end{cases}$$

Los dias 0 y 1 siempre tienen 1 persona. Esta es la secuencia de Fibonacci desplazada.

**Algoritmo $O(N)$ con $O(1)$ espacio:**

```
KingArmy(N):
  si N <= 1: retornar 1
  prev2 = 1, prev1 = 1
  para i = 2 hasta N:
    actual = prev1 + prev2
    prev2 = prev1
    prev1 = actual
  retornar actual
```

**Correctitud:** por induccion en $d$. Base: $king(0) = king(1) = 1$ correcto. Paso: $king(d) = king(d-1) + king(d-2)$ — el enunciado define exactamente esta relacion. El algoritmo bottom-up computa los valores en orden creciente, reusando los dos anteriores.

**Complejidad:** $O(N)$ tiempo (un paso por dia), $O(1)$ espacio (solo 2 variables).

**Chuleta**
> Fibonacci con base $f(0)=f(1)=1$. Bottom-up con 2 variables, $O(N)$ tiempo, $O(1)$ espacio.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 10 — Vacations

**Enunciado**

Tomas tiene $N$ dias de vacaciones. Puede hacer gimnasio (G) o competencias (C), pero no puede repetir la misma actividad que hizo el dia anterior. Quiere minimizar los dias de descanso.

a) Disenar un algoritmo $O(N)$.
b) Probar correctitud y complejidad.
c) Indicar como reconstruir la solucion (que hara cada dia).

Ejemplo: $N=4$, gimnasio dias $\{2,3\}$, competencias dias $\{1,2\}$ → minimo 2 dias de descanso.

**Explicacion**

Estado: $(dia, ultima\_actividad)$. Tres estados por dia: descanso, G o C. $f(i, act)$ = minimos dias de descanso hasta el dia $i$ terminando con actividad $act$. $O(N)$ tiempo y espacio. Este ejercicio aparece en [[programacion_dinamica_top_down_practica_pt2]] como Vacations (Codeforces 698A).

**Resolucion paso a paso**

**a) Algoritmo $O(N)$:**

Estado: $f(i, act)$ = minimos dias de descanso hasta el dia $i$ terminando con actividad $act \in \{D, G, C\}$ (descanso, gimnasio, competencia).

$$f(i, D) = 1 + \min(f(i-1, D),\; f(i-1, G),\; f(i-1, C))$$

$$f(i, G) = \begin{cases} f(i-1, C) & \text{si hay gimnasio el dia } i \\ \infty & \text{si no} \end{cases}$$

$$f(i, C) = \begin{cases} f(i-1, G) & \text{si hay competencia el dia } i \\ \infty & \text{si no} \end{cases}$$

Base: $f(0, D)=0$, $f(0, G)=\infty$, $f(0, C)=\infty$ (antes del dia 1 no se hizo nada).

Respuesta: $\min(f(N, D), f(N, G), f(N, C))$.

**b) Correctitud y complejidad:**

**Correctitud:** por induccion en $i$. El estado $f(i, act)$ captura el optimo hasta el dia $i$ con la ultima actividad $act$. La restriccion de no repetir actividad se garantiza al transicionar: G solo puede seguir a C, C solo puede seguir a G, D puede seguir a cualquiera. La base es correcta. El paso inductivo: si $f(i-1, \cdot)$ es optimo, entonces $f(i, \cdot)$ toma el mejor predecesor valido.

**Complejidad:** $O(N)$ — 3 estados por dia, transicion en $O(1)$, un paso por dia.

**c) Reconstruccion:**

Guardar en cada celda $f(i, act)$ el predecesor optimo. Al finalizar, seguir los punteros desde $\arg\min(f(N, \cdot))$ hacia atras.

**Chuleta**
> Estado: $f(i, act)$ con $act \in \{D,G,C\}$. $f(i,D) = 1 + \min$ anterior. $f(i,G) = f(i-1,C)$ si hay G. $f(i,C) = f(i-1,G)$ si hay C. Respuesta: $\min f(N,\cdot)$. $O(N)$ con 3 variables por dia.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 11 — SumaDinamica

**Enunciado**

Resolver el problema de suma de subconjuntos (Ejercicio 1) usando PD.

a) Convencerse de que $ss'_C(i,j) = ss'_C(i-1,j) \lor ss'_C(i-1,j-C[i])$ es equivalente a $ss$ de BT. Hay $O(nk)$ posibles entradas.
b) Con $k \ll 2^n/n$, mostrar que se recalculan instancias.
c) Implementar algoritmo top-down con memoizacion (matriz $(n+1) \times (k+1)$).
d) Calcular complejidad y comparar con BT. ¿Cual es mejor cuando $k \ll 2^n$? ¿Y cuando $k \gg 2^n$?
e) Algoritmo bottom-up: `M[i,j] = M[i-1,j] ∨ (j-C[i]≥0 ∧ M[i-1,j-C[i]])`, con `M[0,0]=true`, `M[0,j]=false` para $j>0$.
f) (Opcional) Mejorar complejidad espacial a $O(k)$.
g) (Opcional) Demostrar correctitud por induccion en $i$.

**Explicacion**

Transicion canonica BT → PD. La superposicion de subproblemas ocurre cuando $k \ll 2^n/n$. PD top-down: $O(nk)$ tiempo y espacio. PD bottom-up: igual complejidad, pero con posible mejora espacial a $O(k)$ usando fila unica (bottom-up hacia atras).

**Resolucion paso a paso**

**a) Equivalencia $ss'_C(i,j)$ con $ss$ de BT:**

$ss'_C(i,j)$ = ¿existe subconjunto de $\{C[1],\ldots,C[i]\}$ que sume exactamente $j$?

$$ss'_C(i, j) = \begin{cases} j = 0 & i = 0 \\ ss'_C(i-1, j) \lor ss'_C(i-1, j-C[i]) & i > 0 \end{cases}$$

Es identica a $ss$: el elemento $C[i]$ o se incluye (suma queda $j - C[i]$) o no se incluye (suma queda $j$). Las posibles entradas son $(i, j) \in \{0,\ldots,n\} \times \{0,\ldots,k\}$ → $O(nk)$ estados.

**b) Superposicion de subproblemas cuando $k \ll 2^n/n$:**

El arbol de BT tiene $O(2^n)$ nodos. Cuando $k \ll 2^n/n$, la cantidad de estados distintos $O(nk)$ es mucho menor que el numero de llamadas recursivas sin memoizacion. En ese caso, los mismos subproblemas se recalculan multiples veces.

**c) Top-down con memoizacion (matriz $(n+1) \times (k+1)$):**

```
memo[n+1][k+1] inicializado con NULO

ss_td(i, j):
  si memo[i][j] != NULO: retornar memo[i][j]
  si i = 0: memo[i][j] = (j == 0); retornar memo[i][j]
  res = ss_td(i-1, j)
  si j >= C[i]: res = res or ss_td(i-1, j - C[i])
  memo[i][j] = res; retornar res
```

**d) Complejidad y comparacion:**

- PD top-down: $O(nk)$ tiempo y espacio.
- PD bottom-up: $O(nk)$ tiempo y espacio.
- BT sin memo: $O(2^n)$.

**Cuando PD es mejor:** $k \ll 2^n$ → $nk \ll 2^n$ → PD mucho mas rapido.

**Cuando BT puede ser mejor:** $k \gg 2^n$ (en practica imposible ya que $k \le \sum C[i]$, pero si $k$ es grande y $n$ es chico, el backtracking con podas puede terminar rapido).

**e) Bottom-up:**

```
M[0][0] = true; M[0][j] = false para j > 0
para i = 1 hasta n:
  para j = 0 hasta k:
    M[i][j] = M[i-1][j] or (j >= C[i] and M[i-1][j-C[i]])
retornar M[n][k]
```

**f) Optimizacion espacial a $O(k)$:**

En bottom-up, la fila $i$ solo depende de la fila $i-1$. Usar un solo array de tamano $k+1$, recorriendolo de **derecha a izquierda** para no sobreescribir valores que aun se necesitan:

```
M[0] = true; M[j] = false para j > 0
para i = 1 hasta n:
  para j = k hasta C[i] (decrementando):
    M[j] = M[j] or M[j - C[i]]
```

**g) Correctitud por induccion en $i$:**

**Predicado:** $P(i)$: $M[i][j] = $ True ssi existe subconjunto de $\{C[1],\ldots,C[i]\}$ que suma $j$.

$P(0)$: $M[0][0] = $ True (subconjunto vacio suma 0), $M[0][j] = $ False para $j > 0$. Correcto.

$P(i)$ dado $P(i-1)$: Si incluimos $C[i]$, necesitamos que $M[i-1][j-C[i]]$ sea True. Si no lo incluimos, necesitamos $M[i-1][j]$ True. El OR captura ambos casos. $\blacksquare$

**Chuleta**
> $ss'(i,j)$: incluir o no $C[i]$. $O(nk)$ estados. Top-down: memo $(n+1)\times(k+1)$. Bottom-up: doble loop, recorrer $j$ de derecha a izquierda para $O(k)$ espacio. PD mejor cuando $nk \ll 2^n$.

**¿Aparece en parciales?** 🔴 Si — suma de subconjuntos / mochila es patron canon de PD en 1P

---

### Ejercicio 12 — OptiPago

**Enunciado**

Dado un multiconjunto $B = \{b_1, \ldots, b_n\}$ de billetes y un costo $c$, encontrar el subconjunto de billetes de minimo exceso sobre $c$ y, entre esos, de minima cantidad de billetes.

Ejemplo: $c=14$, $B=\{2,3,5,10,20,20\}$ → pagar 15 con 2 billetes (10+5).

a) Funcion recursiva `cc(B, c)` que devuelve $(c', q)$ (minimo costo $\geq c$, minima cantidad).
b) Implementar `cc(B, i, j)`. Complejidad.
c) Reescribir como $cc'_B(i,j)$. ¿Cuando hay superposicion de subproblemas?
d) Estructura de memoizacion para $cc'_B$.
e) Adaptar con memoizacion.
f) Llamada que resuelve el problema y complejidad.
g) (Opcional) Bottom-up con mejora de memoria.
h) (Opcional) Demostrar correctitud por induccion.

**Explicacion**

Variante de mochila/cambio de monedas con dos criterios de optimizacion (lexicografico). El estado es $(i, j)$ = respuesta para usar los primeros $i$ billetes cubriendo exactamente $j$. $O(n \cdot \sum b_i)$.

**Resolucion paso a paso**

**a–b) Funcion recursiva $cc(B, i, j)$:**

$cc'_B(i, j)$ = (minimo costo $\ge j$ pagable con los primeros $i$ billetes, minima cantidad para ese costo):

$$cc'_B(i, j) = \begin{cases} (j, 0) & i = 0,\; j = 0 \\ (\infty, \infty) & i = 0,\; j > 0 \end{cases}$$

Para $i > 0$: comparar lexicograficamente no incluir vs incluir el billete $B[i]$:

$$cc'_B(i, j) = \min_{\text{lex}}\!\left( cc'_B(i-1, j),\quad (c' + B[i],\; q'+1) \;\text{donde}\; (c',q') = cc'_B(i-1,\; \max(0, j-B[i])) \right)$$

Llamado: `cc'_B(n, c)`.

**c) Cuando hay superposicion:**

$O(n \cdot \sum b_i)$ estados posibles. Cuando $n$ y $\sum b_i$ son grandes respecto de $2^n$, los mismos $(i, j)$ se calculan multiples veces desde distintas ramas.

**d) Estructura de memoizacion:**

Tabla `memo[n+1][max_costo+1]` donde `max_costo` $= \sum_{i=1}^n B[i]$.

**e–f) Con memoizacion:**

Complejidad: $O(n \cdot \sum b_i)$ tiempo y espacio. Llamada que resuelve: `cc'_B(n, c)`.

**g) Bottom-up con mejora de memoria:**

Computar fila $i$ solo usando fila $i-1$: rolling array de tamanio $O(\sum b_i)$.

**h) Correctitud por induccion en $i$:**

Base $i=0$ correcta (sin billetes, solo se puede pagar exactamente 0). Paso: al agregar billete $B[i]$, la funcion elige entre incluirlo o no, tomando el minimo lexicografico — captura todos los subconjuntos posibles. Por HI, $cc'_B(i-1, \cdot)$ es optimo. $\blacksquare$

**Chuleta**
> Estado $(i, j)$: usar primeros $i$ billetes para pagar $\ge j$. Transicion: incluir/no incluir $B[i]$, minimizar $(costo, cantidad)$ lex. $O(n \cdot \sum b_i)$. Rolling array para $O(\sum b_i)$ espacio.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 13 — AstroTrade

**Enunciado**

Dado un vector de precios $p \in \mathbb{N}^n$, Astro Void quiere maximizar la ganancia neta comprando/vendiendo a lo sumo 1 asteroide por dia, comenzando y terminando sin asteroides.

a) La maxima ganancia neta (m.g.n.) si Astro Void tiene $c$ asteroides al final del dia $j$ es el maximo entre: comprar (c-1 asteroides ayer), vender (c+1 ayer), no operar (c ayer).
b) Escribir la formulacion recursiva matematicamente. Casos base.
c) ¿Que dato es la respuesta?
d) Algoritmo PD top-down y complejidad.
e) (Opcional) Bottom-up con optimizacion espacial.
f) (Opcional) Demostrar correctitud por induccion.

**Explicacion**

Estado $mgn(j, c)$ = maxima ganancia neta al final del dia $j$ con $c$ asteroides. $O(n^2)$ estados, $O(1)$ por estado → $O(n^2)$ tiempo y espacio. Optimizacion espacial: $O(n)$ usando solo filas $j$ y $j-1$.

Este ejercicio aparece en [[programacion_dinamica_top_down_practica_pt1]] y [[programacion_dinamica_bottom_up_practica]].

**Resolucion paso a paso**

**a–b) Formulacion recursiva:**

$mgn(j, c)$ = maxima ganancia neta al final del dia $j$ teniendo $c$ asteroides en ese momento ($c \in \{0, 1, \ldots, n\}$, aunque en la practica $c \in \{0,1\}$ porque se compra/vende de a uno).

$$mgn(j, c) = \max\begin{cases}
mgn(j-1,\; c+1) - p_j & \text{(compre en dia } j\text{: tenia } c+1\text{, ahora } c) \\
mgn(j-1,\; c-1) + p_j & \text{(vendi en dia } j\text{: tenia } c-1\text{, ahora } c),\; \text{si } c \ge 1 \\
mgn(j-1,\; c)           & \text{(no opere)}
\end{cases}$$

**Casos base:** $mgn(0, 0) = 0$ (dia 0 con 0 asteroides, sin ganancia). $mgn(0, c) = -\infty$ para $c > 0$ (imposible tener asteroides antes de operar).

**c) Dato que es la respuesta:** $mgn(n, 0)$ — al final del dia $n$ con 0 asteroides (condicion del problema: comenzar y terminar sin asteroides).

**d) Algoritmo PD top-down y complejidad:**

```
memo[n+1][n+1] inicializado con NULL

mgn(j, c):
  si memo[j][c] != NULL: retornar memo[j][c]
  si j = 0: retornar (0 si c=0 else -inf)
  res = mgn(j-1, c)                           // no operar
  si c+1 <= n: res = max(res, mgn(j-1,c+1) - p[j])  // comprar
  si c >= 1:   res = max(res, mgn(j-1,c-1) + p[j])  // vender
  memo[j][c] = res; retornar res
```

$O(n^2)$ estados $(j, c)$, $O(1)$ por estado → **$O(n^2)$ tiempo y espacio**.

**e) Bottom-up con optimizacion espacial:**

Solo se necesita la fila $j-1$ para calcular la fila $j$ → rolling array $O(n)$ espacio.

**f) Correctitud por induccion en $j$:**

**Base:** $mgn(0, 0) = 0$ correcto. $mgn(0, c>0) = -\infty$ correcto (imposible).

**Paso:** si $mgn(j-1, \cdot)$ es optimo, entonces $mgn(j, c)$ considera todas las operaciones validas (compra, venta, no-op) y toma el maximo — cubre todos los casos posibles en el dia $j$. $\blacksquare$

**Chuleta**
> Estado $mgn(j,c)$: max ganancia al dia $j$ con $c$ asteroides. Transicion: comprar ($c+1 \to c$, restar $p_j$), vender ($c-1 \to c$, sumar $p_j$), no-op. Base: $mgn(0,0)=0$. Respuesta: $mgn(n,0)$. $O(n^2)$.

**¿Aparece en parciales?** 🔴 Si — AstroTrade es ejercicio central de clases prac (PD, top-down y bottom-up)

---

### Ejercicio 14 — Fire (Codeforces 864E)

**Enunciado**

Un sabueso quiere salvar articulos de un incendio. Cada articulo $i$ tiene tiempo de rescate $t_i$, deadline $d_i$ (se quema en ese instante inclusive si se esta rescatando) y valor $p_i$. Se salva un articulo a la vez. 

Disenar un algoritmo en $O(D \cdot N + N \log N)$ que maximice la suma de valores salvados (donde $D$ es el maximo de los deadlines), que devuelva los articulos a salvar y el orden.

**Explicacion**

Ordenar articulos por deadline. Estado $f(i, T)$ = maximo valor salvando articulos del $i$ al $N$ empezando en tiempo $T$. Como los deadlines estan acotados por $D$, hay $O(ND)$ estados. Para reconstruir el orden se guarda cual articulo fue elegido en cada estado. El $N \log N$ es del ordenamiento inicial.

Este ejercicio aparece en [[programacion_dinamica_top_down_practica_pt2]] como Fire (Codeforces 864E).

**Resolucion paso a paso**

**Idea:** ordenar articulos por deadline creciente. Definir:

$f(i, T)$ = maxima suma de valores salvando articulos del $i$ al $N$ comenzando en tiempo $T$.

$$f(i, T) = \max\begin{cases}
f(i+1, T) & \text{(no salvar articulo } i\text{)} \\
p_i + f(i+1, T + t_i) & \text{si } T + t_i \le d_i \text{ (salvar articulo } i\text{)}
\end{cases}$$

**Casos base:** $f(N+1, T) = 0$ para todo $T$.

**Parametros:** $i \in \{1,\ldots,N+1\}$, $T \in \{0,\ldots,D\}$ (el tiempo nunca supera el maximo deadline $D$).

**Algoritmo:**

```
1. Ordenar articulos por d_i creciente — O(N log N)
2. memo[N+1][D+1] inicializado con NULL
3. Llamar f(1, 0)
4. Para reconstruir: guardar en eleccion[i][T] si se salvo o no el articulo i
```

**Complejidad:** $O(N \log N)$ por el ordenamiento + $O(ND)$ estados × $O(1)$ por estado = $\mathbf{O(ND + N\log N)}$.

**Correctitud:** ordenar por deadline es clave — si se decide salvar el articulo $i$, hacerlo lo antes posible (en el tiempo $T$ actual) nunca es peor que hacerlo despues, porque el deadline de $i$ es el menor de los restantes. Por induccion en $N - i$: $f(N+1, \cdot) = 0$ correcto. Paso: si $f(i+1, \cdot)$ es optimo, entonces $f(i, T)$ considera ambas opciones y toma el maximo.

**Chuleta**
> Ordenar por deadline. $f(i, T)$: max valor de $i\ldots N$ empezando en $T$. Salvar $i$ si $T + t_i \le d_i$. $O(ND + N\log N)$.

**¿Aparece en parciales?** 🔴 Si — Fire es ejercicio de clase practica

---

### Ejercicio 15 — CortesEconomicos

**Enunciado**

Cortar una vara de longitud $\ell$ en lugares predeterminados $C = \{c_1, \ldots, c_k\}$. El costo de un corte en una vara de longitud $l$ es $l$. Minimizar el costo total.

Ejemplo: vara de 10m, cortar en 2, 4 y 7. Cortar en 4 primero (costo 10+4+6=20) es mejor que en 2 primero (10+8+6=24).

a) Convencerse de que el minimo costo de cortar $[i,j]$ con cortes $C$ entre $i$ y $j$ es $(j-i) + \min_c \{$ costo$[i,c]$ + costo$[c,j]\}$.
b) Escribir la formulacion recursiva. Explicar semantica. Indicar parametros.
c) Algoritmo PD y complejidad temporal y espacial. Comparar top-down vs bottom-up.
d) Reformulacion con vector `cortes` (agregando 0 y $\ell$): 2 parametros $f(i,j)$ = costo optimo entre cortes $i$ y $j$. Disenar PD, calcular complejidad.

**Explicacion**

Intervalo DP (rango $[i,j]$). Hay $O(k^2)$ estados, $O(k)$ transiciones por estado → $O(k^3)$ con la reformulacion de d). Similar a multiplicacion de matrices.

**Resolucion paso a paso**

**a) Convencerse de la recursion:**

El costo de cortar el intervalo $[i,j]$ es $(j-i)$ (longitud de la vara en ese momento) mas el costo optimo de los dos subintervalos generados. Para cada corte $c \in C$ con $i < c < j$, el costo total es $(j-i) + \text{costo}(i,c) + \text{costo}(c,j)$. Se toma el minimo sobre todos los posibles primeros cortes $c$.

**b) Formulacion recursiva:**

Agregar $0$ y $\ell$ al vector $C$ → $\text{cortes} = [0, c_1, c_2, \ldots, c_k, \ell]$ (ordenado).

$f(i, j)$ = costo optimo de hacer todos los cortes entre $\text{cortes}[i]$ y $\text{cortes}[j]$ (no incluye los extremos en $i$ y $j$):

$$f(i, j) = \begin{cases} 0 & j = i + 1 \;\text{(no hay cortes entre ellos)} \\ (\text{cortes}[j] - \text{cortes}[i]) + \min_{i < m < j} \{f(i, m) + f(m, j)\} & j > i+1 \end{cases}$$

**Semantica:** $f(i, j)$ es el costo total de cortar la vara entre las marcas $i$ y $j$.

**Parametros:** $i, j \in \{0, 1, \ldots, k+1\}$, con $k+2$ posiciones (los $k$ cortes mas los dos extremos).

**c) Complejidad top-down vs bottom-up:**

- **Estados:** $O(k^2)$ pares $(i,j)$.
- **Transicion por estado:** $O(k)$ posibles cortes intermedios $m$.
- **Total:** $O(k^3)$ tiempo, $O(k^2)$ espacio.
- **Top-down:** igual complejidad, con overhead de recursion pero facil de implementar.
- **Bottom-up:** iterar por longitud creciente del intervalo $j - i$, de 2 a $k+1$.

```
// Bottom-up
para longitud = 2 hasta k+1:
  para i = 0 hasta k+1-longitud:
    j = i + longitud
    f[i][j] = INF
    para m = i+1 hasta j-1:
      f[i][j] = min(f[i][j], cortes[j]-cortes[i] + f[i][m] + f[m][j])
```

**d) Reformulacion con `cortes`:**

El parametro `cortes` con 0 y $\ell$ agregados reduce el problema a indices: $f(i, j)$ con $i$ y $j$ indices en el vector `cortes`. Complejidad identica: $O(k^3)$.

**Chuleta**
> Agregar 0 y $\ell$ al vector de cortes. $f(i,j) = (\text{cortes}[j] - \text{cortes}[i]) + \min_{m} \{f(i,m) + f(m,j)\}$. Base: $j=i+1 \to 0$. $O(k^3)$ tiempo, $O(k^2)$ espacio. Bottom-up: iterar por longitud creciente.

**¿Aparece en parciales?** 🔴 Si — intervalo DP (bracket DP) es patron evaluado en parciales

---

### Ejercicio 16 — TravesiaVital

**Enunciado**

Grilla de $m \times n$ con valores $A_{i,j}$ (positivos = pociones, negativos = trampas). Solo se puede ir a la derecha o abajo. Encontrar el minimo nivel de vida inicial tal que en todo momento la vida sea al menos 1.

a) Pensar la idea de backtracking (sin escribirlo).
b) Convencerse de que la minima vida necesaria al llegar a $(i,j)$ es $\max(1, \min($vida en $(i+1,j)$, vida en $(i,j+1)$$) - A_{i,j})$.
c) Escribir formulacion recursiva y parametros.
d) Algoritmo PD y complejidad.
e) Bottom-up con complejidad espacial $O(\min(m,n))$.

**Explicacion**

PD de atras hacia adelante: el estado se define como la minima vida necesaria al llegar a $(i,j)$. Caso base: celda final necesita vida 1. Complejidad: $O(mn)$ tiempo, $O(mn)$ espacio → mejorable a $O(\min(m,n))$ con rolling array.

**Resolucion paso a paso**

**a) Idea de backtracking:**

En cada celda $(i,j)$ hay dos decisiones: ir a la derecha $(i, j+1)$ o ir abajo $(i+1, j)$. El objetivo es minimizar la vida inicial necesaria para sobrevivir todo el camino. BT probaria todos los caminos desde $(1,1)$ hasta $(m,n)$ y elegiria el que minimiza la vida inicial necesaria.

**b) Convencerse de la recursion:**

$h(i,j)$ = minima vida necesaria al llegar a $(i,j)$ para poder completar el camino a $(m,n)$.

Al llegar a $(i,j)$, la vida se modifica en $A_{ij}$. Para que al salir de $(i,j)$ la vida sea al menos la minima requerida por el proximo paso ($\min(h(i+1,j), h(i,j+1))$), necesitamos:

$$\text{vida al entrar} + A_{ij} \ge \min(h(i+1,j),\; h(i,j+1))$$

$$h(i,j) = \max\!\left(1,\; \min(h(i+1,j),\; h(i,j+1)) - A_{ij}\right)$$

El $\max(1, \cdot)$ asegura que la vida nunca baje de 1.

**c) Formulacion recursiva y parametros:**

$$h(i, j) = \begin{cases} \max(1,\; 1 - A_{mn}) & i = m,\; j = n \\ \max(1,\; h(i+1,j) - A_{ij}) & i < m,\; j = n \\ \max(1,\; h(i,j+1) - A_{ij}) & i = m,\; j < n \\ \max(1,\; \min(h(i+1,j), h(i,j+1)) - A_{ij}) & \text{si no} \end{cases}$$

**d) Algoritmo PD y complejidad:**

Bottom-up de abajo-derecha hacia arriba-izquierda:

```
h[m][n] = max(1, 1 - A[m][n])
para i = m hasta 1:
  para j = n hasta 1:
    (con las ecuaciones de arriba)
retornar h[1][1]
```

$O(mn)$ tiempo y $O(mn)$ espacio.

**e) $O(\min(m,n))$ espacial con rolling array:**

Calcular columna por columna (o fila por fila), guardando solo la columna actual y la siguiente: $O(m)$ o $O(n)$ espacio → $O(\min(m,n))$.

**Chuleta**
> PD hacia atras: $h(i,j) = \max(1, \min(h(i+1,j), h(i,j+1)) - A_{ij})$. Base: $h(m,n) = \max(1, 1 - A_{mn})$. Bottom-up de $(m,n)$ hacia $(1,1)$. $O(mn)$ tiempo, $O(\min(m,n))$ espacio.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 17 — PilaCauta

**Enunciado**

Cajas numeradas 1 a $N$, todas iguales dimensiones. Encontrar la maxima cantidad que puede apilarse en una pila cumpliendo:
- Solo puede haber una caja apoyada directamente sobre otra.
- Las cajas deben estar en orden creciente de numero (de abajo a arriba).
- Cada caja $i$ tiene peso $w_i$ y soporte $s_i$. El peso total arriba de una caja no puede superar su soporte.

Ejemplo: $w=[19,7,5,6,1]$, $s=[15,13,7,8,2]$ → respuesta 4 (ej: pila 1-2-3-5).

a) Pensar la idea de backtracking.
b) Formulacion recursiva base de PD.
c) Algoritmo PD y complejidad.
d) (Opcional) Demostrar correctitud.

**Explicacion**

Estado $f(i, l)$ = maxima pila empezando en la caja $i$ con peso acumulado $l$ encima. O bien: $f(i)$ = maxima pila usando la caja $i$ como la ultima (de abajo a arriba). La segunda es mas eficiente: $O(N^2)$ tiempo. Este ejercicio aparece como "PilaCauta" en [[sintesis/repaso_1P]] y [[programacion_dinamica_bottom_up_practica]].

**Resolucion paso a paso**

**a) Idea de backtracking:**

Probar todos los subconjuntos de cajas en orden creciente de numero. Para cada caja $i$ con peso acumulado $l$ encima, decidir si apilarla o no.

**b) Formulacion recursiva base:**

Opcion 1 — estado $(i, l)$: $f(i, l)$ = maxima cantidad de cajas apilables encima de la caja $i$, dado que ya hay peso $l$ encima de $i$.

$$f(i, l) = \max_{j > i,\; w_j + l \le s_i} \{1 + f(j,\; l + w_j)\} \quad \cup \quad \{0\}$$

Respuesta: $\max_{i} \{1 + f(i, 0)\}$.

Complejidad: $O(N \cdot W)$ estados donde $W = \sum w_i$ → pseudopolinomial.

Opcion 2 — estado $(i)$ mas eficiente: $g(i)$ = maximo tamano de pila que **termina** en la caja $i$ (caja $i$ es la que esta mas arriba).

Para poder colocar caja $j$ sobre caja $i$ (con $j < i$), se necesita que el peso de todo lo que va encima de $j$ (que incluye $i$ y lo que esta arriba de $i$) no supere $s_j$. Esto es mas complejo de plantear directamente.

**Formulacion polinomial usada en clase:**

$f(i)$ = maxima pila usando caja $i$ como la de abajo, sola o con cajas superiores.

Para que las cajas $i_1 < i_2 < \cdots < i_k$ formen una pila valida (de abajo a arriba), se necesita que para cada $j$: $\sum_{l > j} w_{i_l} \le s_{i_j}$.

Esta condicion es equivalente a: si ordenamos las cajas por $w_j + s_j$ creciente, entonces la seleccion optima es un subconjunto con esa estructura. La PD polinomial tiene estado $f(i)$ = longitud maxima de pila terminando en la caja $i$ (de abajo a arriba):

$$f(i) = 1 + \max_{j < i,\; w_i \le s_j - \text{peso encima de j}} \{f(j)\}$$

En la practica (ver [[sintesis/repaso_1P]]): estado $f(i, l)$ con $O(NW)$ → pseudopolinomial, y estado $f(i, l\_indice)$ usando la longitud como proxy del peso → $O(N^2)$ polinomial.

**c) Algoritmo PD $O(N^2)$:**

```
f[i] = 1 para todo i
para i = 1 hasta N:
  para j = 1 hasta i-1:
    // verificar si caja i puede ir encima de la pila terminada en j
    si peso_encima(j, f[j]) + w[i] <= s[j]:
      f[i] = max(f[i], f[j] + 1)
retornar max(f)
```

donde `peso_encima(j, longitud)` es el peso total de `longitud - 1` cajas encima de $j$.

⚠️ Verificar — la condicion exacta de soporte requiere conocer el peso acumulado encima, lo cual necesita rastrear el conjunto elegido. La version $O(N^2)$ vista en clase simplifica usando la observacion de que ordenar por $w_i + s_i$ creciente permite una verificacion mas directa.

**Chuleta**
> Estado $f(i)$: max pila terminando en caja $i$. Transicion: buscar $j < i$ donde $i$ cabe encima de la pila de $j$. $O(N^2)$. Pseudopolinomial: $f(i, l)$ con $l$ = peso encima, $O(NW)$.

**¿Aparece en parciales?** 🔴 Si — PilaCauta es ejercicio del repaso 1P (PD pseudopolinomial + polinomial)

---

### Ejercicio 18 — OperacionesSeq

**Enunciado**

Dado $v = (v_1, \ldots, v_n)$ y $w \in \mathbb{N}$, intercalar operaciones $+$, $\times$, $\uparrow$ entre los elementos de $v$ de modo que el resultado (evaluado de izquierda a derecha, sin precedencia) sea $w$.

Ejemplo: $v=(3,1,5,2,1)$, operaciones $+, \times, \uparrow, \times$ → $(((3+1)\times 5)^2)\times 1 = 400$.

a) Formulacion recursiva base de PD. Explicar semantica.
b) Algoritmo PD, complejidad temporal y espacial. Comparar top-down vs bottom-up.
c) (Opcional) Demostrar correctitud.

**Explicacion**

Estado $f(i, v)$ = ¿se puede obtener el valor $v$ al procesar los primeros $i$ elementos? Hay $O(n \cdot w_{max})$ estados si los valores intermedios estan acotados. Sin acotacion, el espacio puede explotar con la potencia. Complejidad dependiente del rango de valores intermedios posibles.

**Resolucion paso a paso**

**a) Formulacion recursiva:**

$f(i, v)$ = True si se puede obtener el valor $v$ evaluando las primeras $i$ operaciones (los primeros $i+1$ elementos) de izquierda a derecha.

$$f(0, v_1) = (v = v_1)$$

Para $i \ge 1$, la operacion $op_i$ se aplica entre $f(i-1, \cdot)$ y $v_{i+1}$:

$$f(i, w) = \exists\; u \text{ tal que } f(i-1, u) \wedge (u \oplus v_{i+1} = w)$$

donde $\oplus \in \{+, \times, \uparrow\}$ (se evalua de izquierda a derecha).

Equivalentemente, para cada posible valor $u$ alcanzable en el paso $i-1$, generar los tres posibles valores $u + v_{i+1}$, $u \times v_{i+1}$, $u^{v_{i+1}}$.

**b) Complejidad:**

El problema es que los valores intermedios pueden crecer muy rapido (especialmente con $\uparrow$). Si los valores estan acotados por $W_{max}$, hay $O(n \cdot W_{max})$ estados. Sin cota, la complejidad puede ser exponencial en el peor caso.

**Top-down:** tabla `memo[n][W_max]`. Por estado: $O(1)$.

**Bottom-up:** en cada paso $i$, computar el conjunto de valores alcanzables desde los valores del paso $i-1$ aplicando las tres operaciones. Si el conjunto de valores en cada paso tiene a lo sumo $V$ elementos: $O(n \cdot V)$ tiempo.

**c) Correctitud:**

Por induccion en $i$. Base: $f(0, v_1)$ = True ssi $v = v_1$, correcto. Paso: si $f(i-1, \cdot)$ es correcto, entonces $f(i, w)$ es True ssi existe algun $u$ con $f(i-1, u)$ True y alguna operacion que transforma $u, v_{i+1}$ en $w$ — cubre todas las posibilidades. $\blacksquare$

**Chuleta**
> $f(i, w)$: ¿es alcanzable $w$ evaluando los primeros $i+1$ elementos? Transicion: para cada $u$ alcanzable en $i-1$, generar $u+v_{i+1}$, $u \cdot v_{i+1}$, $u^{v_{i+1}}$. Complejidad depende del rango de valores intermedios.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 19 — DadosSuma

**Enunciado**

Se arrojan $n$ dados de $k$ caras numeradas 1 a $k$. Calcular todas las formas de obtener suma total $s$ en una tirada.

(A) Dados distinguibles: $f(n, s)$ = formas con dados distinguibles.
(B) Dados indistinguibles: $g(n, s, k)$ = formas con dados indistinguibles.

a) Definir $f(n, s)$ recursivamente (fijo $k$).
b) Definir $g(n, s, k)$ recursivamente.
c) Demostrar superposicion de subproblemas para ambas.
d) Algoritmos top-down para ambas, con complejidades.
e) Escribir pseudocodigo.

Nota: la complejidad optima es $O(nk \min\{s, nk\})$.

**Explicacion**

(A): $f(n,s) = \sum_{d=1}^{\min(k,s)} f(n-1, s-d)$. (B): $g(n,s,k) = \sum_{d=1}^{\min(k, s/n)} g(n-1, s-d, d)$ (forzar no-decreciente para indistinguibles).

**Resolucion paso a paso**

**(A) Dados distinguibles — $f(n, s)$:**

$$f(n, s) = \begin{cases} 1 & n = 0,\; s = 0 \\ 0 & n = 0,\; s > 0 \\ \displaystyle\sum_{d=1}^{\min(k,s)} f(n-1,\; s-d) & n > 0 \end{cases}$$

**Semantica:** asignar un valor $d \in \{1,\ldots,k\}$ al dado $n$-esimo y recursar sobre los $n-1$ restantes.

**Complejidad top-down:** $O(n \cdot s)$ estados × $O(k)$ por estado = $O(nks)$.

**(B) Dados indistinguibles — $g(n, s, k)$:**

Para evitar contar permutaciones, forzar orden no-decreciente: el dado $n$-esimo tiene valor $\ge$ el del dado $n-1$.

$$g(n, s, \text{min\_val}) = \begin{cases} 1 & n = 0,\; s = 0 \\ 0 & n = 0,\; s > 0 \\ \displaystyle\sum_{d=\text{min\_val}}^{\min(k,s)} g(n-1,\; s-d,\; d) & n > 0 \end{cases}$$

Llamado inicial: `g(n, s, 1)`.

**c) Superposicion de subproblemas:**

(A): los pares $(n', s')$ se repiten cuando distintos prefijos de dados suman lo mismo.
(B): las tripletas $(n', s', \text{min\_val}')$ se repiten analogamente.

**d–e) Algoritmos top-down:**

```
// (A): memo[n+1][s+1]
f(n, s):
  si memo[n][s] != NULL: retornar memo[n][s]
  si n = 0: retornar (s == 0)
  res = 0
  para d = 1 hasta min(k, s): res += f(n-1, s-d)
  memo[n][s] = res; retornar res

// (B): memo[n+1][s+1][k+1]
g(n, s, minv):
  si memo[n][s][minv] != NULL: retornar memo[n][s][minv]
  si n = 0: retornar (s == 0)
  res = 0
  para d = minv hasta min(k, s): res += g(n-1, s-d, d)
  memo[n][s][minv] = res; retornar res
```

Complejidad optima: $O(nk\min\{s, nk\})$ usando tabla aditiva para la suma de transicion en $O(1)$.

**Chuleta**
> (A) Distinguibles: $f(n,s) = \sum_{d=1}^{\min(k,s)} f(n-1, s-d)$. (B) Indistinguibles: $g(n,s,minv) = \sum_{d=minv}^{\min(k,s)} g(n-1, s-d, d)$ (forzar no-decreciente). Tabla aditiva para $O(1)$ por transicion → $O(nk\min\{s,nk\})$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 20 — CaesarsLegions (Codeforces 118D)

**Enunciado**

General Caesar tiene $P$ patos y $D$ dodos. Quiere poner en linea sus tropas sin que haya mas de $MP$ patos consecutivos ni mas de $MD$ dodos consecutivos. Contar la cantidad de formaciones posibles.

a) Definir $f(t, nP, nD, kP, kD)$.
b) Modificar la firma a $f(nP, nD, k, ultTropa)$.
c) Modificar a $f(nP, nD, ultTropa)$.
d) Calcular complejidad de cada version.
e) Demostrar correctitud de cada version.
f) Optimizar a $O(P \cdot D)$ en tiempo y espacio.

**Explicacion**

Estado optimo: $f(nP, nD, kP, kD)$ tiene $O(P \cdot D \cdot MP \cdot MD)$ estados. Con la version c): $O(P \cdot D)$ — se puede porque el numero de consecutivos de la ultima tropa esta determinado por $nP$, $nD$ y cual fue la ultima tropa. Optimizacion a $O(P \cdot D)$ usa tablas aditivas (TP y TD). Este ejercicio aparece en [[programacion_dinamica_top_down_practica_pt2]] y [[programacion_dinamica_bottom_up_practica]].

**Resolucion paso a paso**

**a) Version $f(t, nP, nD, kP, kD)$:**

$f(t, nP, nD, kP, kD)$ = formas de alinear las tropas restantes: $nP$ patos y $nD$ dodos, con $kP$ patos consecutivos al final y $kD$ dodos consecutivos al final en la posicion $t$ de la fila.

$$f(t, nP, nD, kP, kD) = \begin{cases}
1 & nP = 0 \wedge nD = 0 \\
f(t+1, nP-1, nD, kP+1, 0) & \text{si } kP < MP \wedge nP > 0 \\
+ f(t+1, nP, nD-1, 0, kD+1) & \text{si } kD < MD \wedge nD > 0
\end{cases}$$

Estados: $O(P \cdot D \cdot MP \cdot MD)$.

**b) Version $f(nP, nD, k, ultTropa)$:**

Eliminar $t$ (redundante: $t = (P - nP) + (D - nD)$). El estado $k$ = consecutivos de la ultima tropa.

Estados: $O(P \cdot D \cdot \max(MP, MD))$.

**c) Version $f(nP, nD, ultTropa)$:**

Clave: dado $nP$, $nD$ y `ultTropa`, el numero de consecutivos de la ultima tropa queda determinado. Si `ultTropa = P`, los patos consecutivos al final son exactamente $(P_{total} - nP) - (D_{total} - nD)$... No exactamente, depende de la historia.

La version optima vista en clase usa: si `ultTropa = Pato`, entonces el numero de patos consecutivos al final es determinable de forma mas indirecta. El estado reducido $f(nP, nD, ultTropa)$ es valido porque:

Al conocer $nP$, $nD$ y `ultTropa`, el numero de consecutivos de la ultima tropa es $\min(kP, MP)$ o $\min(kD, MD)$ segun la ultima — y la recursion suma sobre todas las formaciones validas. La eliminacion de $k$ es posible usando tablas aditivas TP y TD (ver abajo).

Estados: $O(P \cdot D)$.

**d) Complejidades:**

| Version | Estados | Transicion | Total |
|---------|---------|-----------|-------|
| $f(t, nP, nD, kP, kD)$ | $O(P \cdot D \cdot MP \cdot MD)$ | $O(1)$ | $O(P \cdot D \cdot MP \cdot MD)$ |
| $f(nP, nD, k, ult)$ | $O(P \cdot D \cdot \max(MP,MD))$ | $O(1)$ | $O(P \cdot D \cdot \max(MP,MD))$ |
| $f(nP, nD, ult)$ | $O(P \cdot D)$ | $O(\max(MP,MD))$ | $O(P \cdot D \cdot \max(MP,MD))$ |
| Con tablas TP/TD | $O(P \cdot D)$ | $O(1)$ | $O(P \cdot D)$ |

**e) Correctitud:**

Induccion en el total de tropas restantes $nP + nD$. Base: $nP = nD = 0$ → 1 formacion (la vacia). Paso: la funcion considera ambas opciones (colocar P o D) cuando es valido, y suma correctamente por HI.

**f) Optimizacion a $O(P \cdot D)$ con tablas aditivas:**

Definir $TP[nP][nD]$ = suma de $f(nP', nD, P)$ para $nP' \in [nP, nP + MP - 1]$ (cuantos patos consecutivos se pueden poner antes de estar obligado a poner un dodo). Analogamente $TD$.

Con prefijos 2D precalculados: cada transicion es $O(1)$.

**Chuleta**
> Version optima: $f(nP, nD, ult)$. Estados $O(PD)$. Transicion: sumar $f(nP-1, nD, P)$ para hasta $MP$ patos consecutivos → usar tabla aditiva TP. Idem para dodos con TD. Total: $O(PD)$.

**¿Aparece en parciales?** 🔴 Si — CaesarsLegions es ejercicio de clase practica

---

### Ejercicio 21 — Farmer (Codeforces 41D)

**Enunciado**

Un granjero tiene un terreno de $N \times M$ dividido en celdas 1x1m. Empieza en alguna celda de $y=0$ y puede moverse en diagonal adelante-izquierda o adelante-derecha. Debe llegar al final ($y=N$) con la cantidad de arvejas recolectadas divisible por $K+1$ (con $K$ fijo).

Disenar un algoritmo en $O(N \cdot M \cdot K)$ que calcule la maxima cantidad de arvejas recolectables. Demostrar correctitud y complejidad. Indicar como reconstruir un camino.

**Explicacion**

Estado $f(i, j, r)$ = maxima arvejas llegando a la celda $(i,j)$ con $r = $ arvejas acumuladas $\mod (K+1)$. Similar a Tobi el granjero en [[programacion_dinamica_top_down_practica_pt1]].

**Resolucion paso a paso**

$f(i, j, r)$ = maxima cantidad de arvejas llegando a la celda $(i, j)$ con $r =$ arvejas acumuladas $\bmod (K+1)$.

$$f(i, j, r) = \max\begin{cases}
f(i-1,\; j-1,\; (r - A_{ij}) \bmod (K+1)) + A_{ij} & j > 0 \\
f(i-1,\; j+1,\; (r - A_{ij}) \bmod (K+1)) + A_{ij} & j < M-1
\end{cases}$$

(movimiento diagonal: de $(i-1, j-1)$ o $(i-1, j+1)$ hacia $(i, j)$)

**Casos base:** $f(0, j, A_{0j} \bmod (K+1)) = A_{0j}$ para cada celda de inicio $j$ en $y=0$.

**Respuesta:** $\max_{j} f(N, j, 0)$ — llegar a la ultima fila con arvejas divisibles por $K+1$.

**Complejidad:** $O(N \cdot M \cdot K)$ estados × $O(1)$ por estado = $\mathbf{O(NMK)}$.

**Reconstruccion:** guardar en `desde[i][j][r]` desde cual celda se llego al estado $(i,j,r)$ con el valor optimo. Seguir desde $(N, j^*, 0)$ hacia atras.

**Correctitud:** por induccion en $i$. Base: $i=0$ correcto. Paso: si $f(i-1, \cdot, \cdot)$ es optimo, entonces $f(i, j, r)$ toma el maximo de los dos predecesores validos, correcto.

**Chuleta**
> Estado $f(i,j,r)$ con $r = \text{arvejas} \bmod (K+1)$. Transicion: desde $(i-1, j\pm 1)$ actualizar $r$ restando $A_{ij}$ mod $(K+1)$. Respuesta: $\max_j f(N, j, 0)$. $O(NMK)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 22 — ProblemasAnteriores

**Enunciado**

Usando PD iterativa, repensar los siguientes ejercicios para alcanzar las complejidades espaciales propuestas:

- Ej. 9: $O(1)$
- Ej. 10: $O(1)$
- Ej. 13: $O(|p|)$
- Cambio de monedas (devolver vuelto $K$): $O(K)$
- Numero combinatorio $C(N,K)$: $O(K)$
- LCS entre $S$ y $T$: $O(\min(|S|, |T|))$
- Ej. 19: $O(1)$ (ambas versiones)
- Ej. 21: $O(M \cdot K)$

**Explicacion**

Tecnica de rolling array: identificar cuales filas de la tabla PD son necesarias para calcular la fila actual. Si solo se necesita la fila anterior, usar dos arrays alternantes → optimizacion espacial clasica.

**Resolucion paso a paso**

Tecnica central: **rolling array** — si la PD bottom-up solo necesita la fila (o filas) anterior para calcular la actual, se puede descartar las filas mas viejas.

**Ej. 9 — $O(1)$:** Solo se necesitan los dos valores anteriores → 2 variables (`prev1`, `prev2`). Ver resolucion del Ej. 9.

**Ej. 10 — $O(1)$:** Estado $(i, act)$ con $act \in \{D, G, C\}$ → 3 variables por fila. Solo se usa la fila $i-1$ → 3 variables totales.

**Ej. 13 (AstroTrade) — $O(|p|)$:** Estado $(j, c)$: se usa la fila $j-1$ → guardar solo la fila anterior: $O(n)$ espacio.

**Cambio de monedas $O(K)$:** La tabla es $f(s)$ indexada por $s \in \{0, \ldots, K\}$. Sin items: se puede computar en un solo array de tamano $K+1$ (sin dimension de items si los items son reutilizables — cambio de monedas clasico). Si hay items sin repeticion: rolling de una fila, recorriendo de mayor a menor para no reusar el mismo item.

**$C(N,K)$ — $O(K)$:** Triangulo de Pascal: $C(n,k) = C(n-1,k-1) + C(n-1,k)$. Guardar solo la fila anterior de tamano $K+1$.

**LCS — $O(\min(|S|,|T|))$:** La tabla $l[i][j]$ solo necesita la fila $i-1$. Si $|S| \ge |T|$, usar $T$ como segunda dimension → $O(|T|)$ espacio.

**Ej. 19 (DadosSuma) — $O(1)$ para ambas:** La suma acumulada de cada dado solo depende del resultado anterior del dado previo → rolling de la dimension de dados. Con tabla aditiva 1D, solo se necesita el vector de la iteracion anterior.

**Ej. 21 (Farmer) — $O(M \cdot K)$:** Estado $f(i, j, r)$: la fila $i$ solo depende de $i-1$ → guardar solo las dos filas actuales: $O(M \cdot K)$ espacio.

**Chuleta**
> Rolling array: si $f(i, \cdot)$ solo depende de $f(i-1, \cdot)$ → guardar 2 filas alternantes. Si depende de $f(i-1, \cdot)$ y $f(i-2, \cdot)$ → 3 filas. Recorrer de derecha a izquierda cuando se actualiza in-place (evitar reusar el mismo item en problemas 0-1).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 23 — ABBOptimoBU

**Enunciado**

Revisitar el ejercicio 6 (ABBOptimos) y disenar un algoritmo PD bottom-up que resuelva el problema en $O(n^3)$ tiempo y $O(n^2)$ espacio. Demostrar correctitud y complejidad.

Opcional: La Optimizacion de Knuth mejora la complejidad a $O(n^2)$ usando la propiedad: si $opt(i,j)$ es la raiz optima para $[i,j)$, entonces $opt(i,j-1) \leq opt(i,j) \leq opt(i+1,j)$.

**Explicacion**

Bottom-up de ABB optimo: computar $f(i,j)$ en orden creciente de longitud del rango $j-i$. Los casos base son $f(i,i)=0$. La formula: $f(i,j) = \sum_{l=i}^{j} freq_l + \min_{k=i}^{j}\{f(i,k-1) + f(k+1,j)\}$.

Este ejercicio aparece como "ABB optimo AO(i,j)" en [[fuerza_bruta_backtracking_practica]].

**Resolucion paso a paso**

**Algoritmo bottom-up $O(n^3)$:**

Computar $f(i,j)$ en orden creciente de longitud del rango $\ell = j - i$:

$$f(i, j) = \sum_{l=i}^{j} \text{freq}[l] + \min_{k=i}^{j}\{f(i, k-1) + f(k+1, j)\}$$

Con $f(i, i-1) = 0$ (rango vacio) como caso base.

```
// Inicializar
para todo i, j: f[i][j] = 0 si j < i, INF si no
// Longitud 1
para i = 1 hasta n: f[i][i] = freq[i]
// Longitudes mayores
para len = 2 hasta n:
  para i = 1 hasta n-len+1:
    j = i + len - 1
    suma = sum(freq[i..j])  // O(1) con prefijos
    f[i][j] = INF
    para k = i hasta j:
      costo = suma + f[i][k-1] + f[k+1][j]
      f[i][j] = min(f[i][j], costo)
retornar f[1][n]
```

**Complejidad:** $O(n^2)$ estados × $O(n)$ transicion = $O(n^3)$. Espacio: $O(n^2)$.

**Correctitud:** por induccion en $\ell = j - i$. Para $\ell = 0$: $f(i,i) = \text{freq}[i]$, correcto (arbol de un nodo con costo $\text{freq}[i]$). Para $\ell > 0$: si $f(i', j')$ es correcto para todo $j' - i' < \ell$, entonces $f(i, j)$ prueba todas las raices posibles y toma la que minimiza el costo — optimo por subestructura optima del ABB.

**Optimizacion de Knuth ($O(n^2)$):**

Si $opt(i,j)$ es el indice $k$ que minimiza $f(i,j)$, se cumple la propiedad de monotonia:
$$opt(i, j-1) \le opt(i, j) \le opt(i+1, j)$$

Esto reduce el numero total de transiciones a $O(n^2)$: en lugar de buscar $k$ en $[i,j]$, se busca en $[opt(i,j-1), opt(i+1,j)]$.

**Chuleta**
> Bottom-up por longitud creciente de rango. $f(i,j) = \sum \text{freq} + \min_k \{f(i,k-1)+f(k+1,j)\}$. Base: rangos vacios = 0. $O(n^3)$, $O(n^2)$ espacio. Knuth: acotar busqueda de $k$ → $O(n^2)$.

**¿Aparece en parciales?** 🔴 Si — ABB optimo es ejercicio de clase practica

---

### Ejercicio 24 — Lagunas (TAP 2025 L)

**Enunciado**

Marcos tiene un terreno $1 \times N$ con casillas de tierra o agua. Puede colocar barcos de distintos largos en agua (casillas contiguas). Todos los barcos deben tener largos diferentes y ordenados crecientemente de izquierda a derecha. Puede excavar casillas de tierra (costo $T_i$). Cada barco colocado da ganancia $G$. Maximizar la ganancia neta.

a) PD en $O(N^3)$.
b) Optimizar a $O(N^2 \sqrt{N})$.
c) Optimizar a $O(N \sqrt{N})$.
d) Optimizar memoria a $O(N)$.

**Explicacion**

Estado $f(i, b)$ = maxima ganancia usando casillas 1 a $i$ con $b$ barcos colocados. La clave para la optimizacion: el largo del proximo barco es $b+1$, y acotando $b = O(\sqrt{N})$ (porque hay $O(\sqrt{N})$ barcos de tamano distinto en una grilla de tamano $N$) → $O(N^{3/2})$ estados. Tablas aditivas para sumas de rangos. Este ejercicio aparece en [[programacion_dinamica_bottom_up_practica]].

**Resolucion paso a paso**

**a) $O(N^3)$:**

$f(i, b)$ = maxima ganancia neta al usar las casillas 1 a $i$ con $b$ barcos ya colocados (el proximo barco tendra largo $b+1$).

El barco $b+1$ ocupa casillas contiguas de agua (posiblemente excavando tierra). Sea $\text{costo}(l, r)$ = costo de excavar las casillas de tierra en $[l, r]$. Si el barco $b+1$ ocupa $[l, i]$ con $i - l + 1 = b+1$:

$$f(i, b) = \max\left(f(i-1, b),\; G - \text{costo}(i-b, i) + f(i-b-1,\; b-1)\right)$$

Estados: $O(N \cdot B_{max})$ donde $B_{max} = O(\sqrt{N})$ (ver abajo). Con $B_{max} = O(\sqrt{N})$: $O(N\sqrt{N})$ estados.

Para $O(N^3)$ naive: $B_{max} = O(N)$, estados $O(N^2)$, transicion $O(N)$ → $O(N^3)$.

**b) $O(N^2\sqrt{N})$:**

Observacion clave: el largo del barco $b+1$ es $b+1$. Para colocar $b$ barcos en una grilla de $N$ casillas, necesitamos al menos $1 + 2 + \cdots + b = b(b+1)/2$ casillas. Por tanto $b(b+1)/2 \le N$ → $b = O(\sqrt{N})$.

Con $B_{max} = O(\sqrt{N})$: $O(N\sqrt{N})$ estados × $O(N)$ transicion = $O(N^2\sqrt{N})$.

**c) $O(N\sqrt{N})$:**

Precalcular $\text{costo}(l, r)$ con tabla aditiva (suma de prefijos sobre celdas de tierra) → $O(1)$ por consulta. Estados $O(N\sqrt{N})$ × $O(1)$ transicion = $O(N\sqrt{N})$.

**d) $O(N)$ memoria:**

Solo guardar las filas $f[\cdot][b]$ y $f[\cdot][b-1]$ → rolling array. $O(N)$ espacio.

**Chuleta**
> $b = O(\sqrt{N})$ barcos posibles. Estado $f(i, b)$: max ganancia con $b$ barcos en las primeras $i$ casillas. Tabla aditiva para $\text{costo}(l,r)$ en $O(1)$. $O(N\sqrt{N})$ tiempo, $O(N)$ espacio con rolling.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 25 — MiBuenosAiresCrecido (LIS Ponderada)

**Enunciado**

Dada una lista de edificios de izquierda a derecha con alto $H_i$ y ancho $W_i$, encontrar la maxima subsecuencia ascendente ponderada por ancho (LIS donde se maximiza la suma de $W_i$ para edificios con $H_i$ creciente).

a) PD en $O(N^2)$ tiempo y espacio.
b) Optimizar a $O(N)$ memoria.
c) (Opcional) $O(N \log N)$ con segment tree o Fenwick tree.

**Explicacion**

Estado $f(i)$ = maximo ancho total de LIS terminando en el edificio $i$. Hay dos formulaciones: $f(i, ult)$ con $O(N^2)$ espacio vs. $f(pos)$ con $O(N)$ espacio (solo guarda el ancho maximo). Este ejercicio aparece en [[programacion_dinamica_bottom_up_practica]].

**Resolucion paso a paso**

**a) $O(N^2)$ tiempo y espacio:**

$f(i, ult)$ = maximo ancho total de LIS entre los edificios 1 a $i$, donde el ultimo edificio incluido es `ult` (y $H_{ult} < H_{i+1}$ para la siguiente extension).

Equivalentemente, definir directamente:

$f(i)$ = maximo ancho total de LIS de alturas **estrictamente crecientes** que termina en el edificio $i$.

$$f(i) = W_i + \max_{j < i,\; H_j < H_i} f(j)$$

Base: $f(i) = W_i$ (el edificio $i$ solo).

Respuesta: $\max_i f(i)$.

**Complejidad:** $O(N^2)$ — para cada $i$, recorrer todos los $j < i$. Espacio $O(N)$.

**b) $O(N)$ memoria:**

El estado $f(i)$ ya es $O(N)$ — solo un array de $N$ valores. No se necesita una tabla 2D.

Si la pregunta se refiere a la formulacion $f(i, ult)$ con $O(N^2)$ espacio: la optimizacion es usar solo $f(i)$ en lugar de $f(i, ult)$ (colapsar la dimension de `ult`).

**c) $O(N \log N)$ con segment tree / Fenwick tree:**

Comprimir las alturas a $\{1, \ldots, N\}$ (coordinate compression). Usar un Fenwick tree que responda: "maximo $f(j)$ para todos los $j$ con $H_j < H_i$". Al procesar el edificio $i$: consultar el maximo en $[1, H_i - 1]$ y actualizar la posicion $H_i$ con $f(i)$. Cada operacion es $O(\log N)$ → total $O(N \log N)$.

**Chuleta**
> $f(i) = W_i + \max_{j < i, H_j < H_i} f(j)$. LIS ponderada por ancho. $O(N^2)$ naive, $O(N \log N)$ con Fenwick tree sobre alturas comprimidas.

**¿Aparece en parciales?** 🔴 Si — LIS y variantes son patrones evaluados en 1P

---

### Ejercicio 26 — Guirnaldas (Codeforces 1286A)

**Enunciado**

Vladimir tiene $n$ guirnaldas numeradas 1 a $n$. La complejidad de una secuencia es el numero de pares adyacentes con distinta paridad. Tiene una secuencia parcialmente decorada $s$ (con ceros en lugares libres). Completarla con las guirnaldas restantes para minimizar la complejidad.

a) PD en $O(N^3)$.
b) Optimizar a $O(N^2)$.
c) Optimizar a $O(N^2)$ tiempo y $O(N)$ espacio.

**Explicacion**

Estado $f(i, pares\_usados, impares\_usados)$ = minima complejidad de la secuencia parcial hasta la posicion $i$. Requiere saber cuantos pares e impares se han colocado para determinar cuales restan. La complejidad puede reducirse usando la observacion de que la paridad de la posicion $i$ solo depende de los conteos de pares/impares usados.

Este ejercicio aparece en [[programacion_dinamica_bottom_up_practica]] como Garland.

**Resolucion paso a paso**

Sean $P$ = cantidad de guirnaldas pares disponibles y $Q$ = cantidad impares disponibles.

**a) $O(N^3)$:**

$f(i, p, q)$ = minima complejidad de completar la secuencia desde la posicion $i$, habiendo usado $p$ pares y $q$ impares hasta el momento.

- Si $s[i] \ne 0$: la guirnalda $i$ ya esta fija. Su paridad es conocida.
- Si $s[i] = 0$: probar colocar un par (si quedan) o un impar (si quedan).

$$f(i, p, q) = \begin{cases}
0 & i > N \\
\text{costo}(i, par, p+1, q) & \text{si } s[i] = 0 \wedge p < P \\
+ \text{costo}(i, impar, p, q+1) & \text{si } s[i] = 0 \wedge q < Q \\
\text{costo}(i, par(s[i]), p + \text{es\_par}(s[i]), q + \text{es\_impar}(s[i])) & \text{si } s[i] \ne 0
\end{cases}$$

donde $\text{costo}(i, paridad, p', q') = [\text{paridad} \ne \text{paridad}(s[i-1])] + f(i+1, p', q')$.

Estados: $O(N \cdot P \cdot Q)$ = $O(N^3)$.

**b) $O(N^2)$:**

Observacion: en vez de trackear $(p, q)$ por separado, basta trackear solo $p$ (la cantidad de pares usados), ya que $q = i - 1 - p$ (total colocados = $i-1$, de los cuales $p$ son pares y el resto impares). Esto reduce a $O(N^2)$ estados.

**c) $O(N^2)$ tiempo y $O(N)$ espacio:**

Como $f(i, p)$ solo depende de $f(i+1, \cdot)$, usar rolling array: guardar solo la fila $i+1$ de tamano $O(N)$.

**Chuleta**
> Estado $f(i, p)$: min complejidad desde posicion $i$ habiendo usado $p$ pares ($q = i-1-p$ impares). Transicion: colocar par o impar si hay, pagar 1 si cambia paridad respecto al anterior. $O(N^2)$ tiempo, $O(N)$ espacio con rolling.

**¿Aparece en parciales?** ⚪ No

## Ver tambien

- [[programacion_dinamica_teoria]] — Definicion, top-down vs bottom-up, ejemplos
- [[programacion_dinamica_top_down_practica_pt1]] — Fibonacci, AstroTrade, Tobi granjero (2025)
- [[programacion_dinamica_top_down_practica_pt2]] — Vacations, CaesarsLegions, Fire (2023)
- [[programacion_dinamica_bottom_up_practica]] — BU, AstroTrade BU, MiBsAs, Garland, Lagunas
- [[fuerza_bruta_backtracking_guia]] — Seccion BT de la misma guia (ej. 1-8)
- [[greedy_guia]] — Seccion Greedy de la misma guia (ej. 27+)
