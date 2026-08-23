---
nombre: Repaso para el Primer Parcial
parcial: historico_1P
programa: historico_hasta_1C_2026
tipo: sintesis
tema: repaso_1P
fuente: raw/clases/prac/6.prac_1P_repaso_para_primer_parcial.pdf
paginas_relacionadas:
  - "[[divide_y_conquista_teoria]]"
  - "[[divide_y_conquista_practica]]"
  - "[[fuerza_bruta_backtracking_teoria]]"
  - "[[fuerza_bruta_backtracking_practica]]"
  - "[[programacion_dinamica_teoria]]"
  - "[[programacion_dinamica_top_down_practica_pt1]]"
  - "[[programacion_dinamica_bottom_up_practica]]"
  - "[[greedy_teoria]]"
  - "[[greedy_practica]]"
  - "[[definiciones_y_demostraciones_teoria]]"
---

> ⚠️ **Material del programa viejo.** Esta clase de consulta preparaba el 1P cuando ese parcial cubria Divide & Conquer, Backtracking, PD, Greedy y Definiciones/Demos.
> Con el programa vigente (2C-2026), PD y Greedy ya **no** entran en tu 1P (pasaron al 2P), y le falta todo el bloque de grafos que si entra.
> El contenido de los ejercicios sigue siendo valido; lo que ya no vale es usarla como guia de que entra en tu parcial. Ver [[programa]].

> Clase de consultas previa al primer parcial (2do cuatrimestre 2025). Cubre los 5 temas del 1P con ejercicios representativos y preguntas de multiple choice conceptuales.

---

## Multiple Choice — Conceptos clave

### Teorema Maestro

**Pregunta:** Dada $T(n) = aT(n/b) + f(n)$, ¿cuales de los siguientes parametros aseguran $T(n) = \Theta(\sqrt{n} \log n)$?

| Opcion | $a$ | $b$ | $f(n)$ | Resultado |
|--------|-----|-----|---------|-----------|
| (1) ✓ | 4 | 16 | $n^{1/2}$ | $\log_{16} 4 = 1/2 \Rightarrow n^{1/2}$. Caso 2 $\Rightarrow \Theta(n^{1/2} \log n)$ |
| (2) ✗ | 2 | 2 | $n^{1/2} \log n$ | $\log_2 2 = 1 \Rightarrow n^1$ (mayor que $\sqrt{n}$) |
| (3) ✓ | 2 | 8 | $n^{1/2} \log n$ | $\log_8 2 = 1/3 \Rightarrow n^{1/3}$. $f(n) = n^{1/2} \log n$ domina polinomialmente. Caso 3 $\Rightarrow \Theta(n^{1/2} \log n)$ |
| (4) ✗ | 4 | 2 | $1$ | $\log_2 4 = 2 \Rightarrow n^2$ (cuadratico) |
| (5) ✗ | 3 | 9 | $n^{1/4}$ | $\log_9 3 = 1/2 \Rightarrow n^{1/2}$. $f(n) = n^{1/4}$ es menor. Caso 1 $\Rightarrow \Theta(n^{1/2})$ |

**Respuesta correcta:** (1) y (3).

---

### Backtracking

**Pregunta:** ¿Cuales de estas afirmaciones son verdaderas?

| Afirmacion | Verdad | Explicacion |
|-----------|--------|-------------|
| Evalua todas las soluciones candidatas posibles | ✓ | Si no hay podas efectivas, explora todo el espacio |
| Anticipa que ciertos subconjuntos no son factibles y los descarta | ✓ | Podas de factibilidad — la razon de ser del backtracking |
| Explota superposicion de subproblemas | ✗ | Eso es PD; backtracking no guarda resultados |
| Siempre mejora la complejidad de fuerza bruta | ✗ | Sin podas efectivas puede ser igual que fuerza bruta |
| Siempre tiene complejidad exponencial | ✗ | En algunos problemas puede ser lineal (ej. DFS para existencia de camino) |
| Puede usarse en problemas sin algoritmo polinomial conocido | ✓ | Se usa en NP-completos como Mochila 0/1 |

**Respuesta correcta:** 1, 2, 6.

---

### Complejidad espacial de PD top-down

**Pregunta:** La complejidad espacial de la memorizacion de una PD con $N$ estados y $M$ transiciones, implementada top-down recursiva, es:

- $\Theta(M)$ ✗
- $\Theta(N + M)$ ✗
- **$\Theta(N)$ ✓**
- $\Theta(NM)$ ✗

**Explicacion:** Solo se guarda un valor por estado ($N$ en total). Las $M$ transiciones no ocupan espacio adicional en la memo. La pila recursiva agrega $O(\text{profundidad}) \leq O(N)$. Total: $\Theta(N)$.

---

### Estrategias Greedy

**Pregunta:** ¿Cuales de las siguientes afirmaciones describe(n) a las estrategias greedy?

| Afirmacion | Verdad | Explicacion |
|-----------|--------|-------------|
| Siempre garantizan solucion optima | ✗ | Falso; hay problemas donde greedy falla (ej. cambio de monedas no canonico) |
| Exploran exactamente una rama del arbol de backtracking definido por la recursion | ✓ | Un greedy recorre una sola secuencia de decisiones |
| Para considerarlas algoritmos correctos, se necesita demostracion de optimalidad | ✓ | Se requiere prueba formal; la intuicion no alcanza |
| Siempre son estrictamente mejores que cualquier otro algoritmo | ✗ | No siempre son mejores en complejidad o resultado |

**Respuesta correcta:** 2 y 3.

---

## Ejercicio — Maximin D&C (maximo y minimo con menos comparaciones)

**Enunciado**
Se tiene un arreglo $A$ de $n$ elementos ($n$ potencia de 2). Se quiere obtener su maximo y minimo. La solucion secuencial compara cada elemento contra el maximo y el minimo actuales ($2(n-1)$ comparaciones). Proponer un algoritmo D&C que minimice la cantidad de comparaciones sin empeorar el tiempo asintotico.

**Idea D&C**
- **Dividir:** partir el arreglo en dos mitades.
- **Resolver:** obtener $(\min, \max)$ de cada mitad recursivamente.
- **Combinar:** $\min_{\text{global}} = \min(\min_{\text{izq}}, \min_{\text{der}})$; $\max_{\text{global}} = \max(\max_{\text{izq}}, \max_{\text{der}})$.
- **Caso base:** 1 elemento $\Rightarrow$ ese valor es minimo y maximo.

```
ObtenerMaxMin(A, inicio, fin):
  Si inicio = fin: devolver (A[inicio], A[inicio])
  medio ← ⌊(inicio + fin)/2⌋
  (min_izq, max_izq) ← ObtenerMaxMin(A, inicio, medio)
  (min_der, max_der) ← ObtenerMaxMin(A, medio+1, fin)
  min_global ← min(min_izq, min_der)
  max_global ← max(max_izq, max_der)
  devolver (min_global, max_global)
```

**Analisis de complejidad**

Recurrencia: $T(n) = 2T(n/2) + O(1)$

Teorema Maestro: $a = 2$, $b = 2$, $f(n) = O(1)$. $n^{\log_b a} = n^{\log_2 2} = n$. Caso 2 $\Rightarrow T(n) = \Theta(n)$.

**Cantidad de comparaciones:** La solucion D&C realiza $\approx \frac{3n}{2} - 2$ comparaciones (para $n$ potencia de 2), calculado exactamente via la serie geometrica $n/2 + n/4 + \ldots$. Esto es menor que $2n - 2$ de la solucion secuencial.

**Chuleta**
> D&C MaxMin: 2 llamadas recursivas + 2 comparaciones para combinar $\Rightarrow$ $3n/2 - 2$ comparaciones totales vs $2(n-1)$ secuencial

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/dc_diseno]]

---

## Ejercicio — Viaje a Mar del Plata (Greedy)

*(Mismo enunciado que en la clase de greedy. Ver [[greedy_practica]] para la demostracion completa.)*

**Enunciado breve**
Minimizar paradas para cargar nafta en un viaje de 0 a $M$ km, con autonomia $C$ km y estaciones en posiciones $x_1 \leq x_2 \leq \ldots \leq x_n$.

**Algoritmo:** Elegir siempre la estacion mas lejana dentro del alcance. $O(n)$.

**Correctitud:** Propiedad de eleccion greedy (Lema 1) + Subestructura optima (Lema 2) + Induccion sobre las elecciones greedy.

---

## Ejercicio — RutaMinima (Backtracking + Poda)

**Enunciado**
Dada una matriz $D$ de $n \times n$ numeros naturales, encontrar una permutacion $\pi$ de $\{1, \ldots, n\}$ que minimice:
$$D_{\pi(n)\pi(1)} + \sum_{i=1}^{n-1} D_{\pi(i)\pi(i+1)}$$

*Ejemplo:* $D = \begin{pmatrix} 0 & 1 & 10 \\ 10 & 0 & 3 \\ 2 & 22 & 0 \end{pmatrix}$. La solucion optima es $\pi(i) = i$ con costo $1 + 3 + 2 = 6$.

**1. Algoritmo de Backtracking**

- **Soluciones candidatas:** todas las permutaciones $\pi = (\pi_1, \ldots, \pi_n)$ con $1 \leq \pi_i \leq n$ y todos distintos.
- **Soluciones validas:** todas las candidatas (cualquier permutacion define una ruta).
- **Soluciones parciales:** vectores $p = (p_1, \ldots, p_i)$ con $1 \leq p_j \leq n$, todos distintos, $0 \leq i \leq n$.
- **Sucesoras de $p$:** $p \oplus x$ con $1 \leq x \leq n$ y $x \notin p$.

**2. Arbol de recursion para $n = 3$**
```
[]
├── [1] ── [1,2] ── [1,2,3]
│       └── [1,3] ── [1,3,2]
├── [2] ── [2,1] ── [2,1,3]
│       └── [2,3] ── [2,3,1]
└── [3] ── [3,1] ── [3,1,2]
          └── [3,2] ── [3,2,1]
```

**3. Complejidad:** $O(n!)$ — se evaluan todas las permutaciones.

**4. Poda por optimalidad**

Si durante la expansion de una solucion parcial $p = (p_1, \ldots, p_k)$ el costo parcial ya acumulado supera el costo de la mejor solucion completa encontrada hasta el momento, se puede podar esa rama.

*Correctitud de la poda:* Sea $\text{costo}(p) = \sum_{i=1}^{k-1} D_{p_i p_{i+1}}$ el costo de los arcos ya elegidos en $p$. Como todos los pesos $D_{ij} \geq 0$, el costo de cualquier extension de $p$ satisface:
$$\text{costo}(\text{extension}) \geq \text{costo}(p)$$
Por lo tanto, si $\text{costo}(p) \geq \text{mejor\_hasta\_ahora}$, ninguna extension puede mejorar la solución actual, y la poda es correcta (no descartamos ninguna solucion optima). $\square$

**Chuleta**
> Backtracking RutaMinima: soluciones candidatas = permutaciones ($n!$) → poda por optimalidad: costo parcial $\geq$ mejor actual $\Rightarrow$ podar → correctitud: pesos $\geq 0$ implica que el costo solo puede crecer

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/backtracking_tsp]]

---

## Ejercicio — Pila Cauta (PD)

**Enunciado**
Tenemos cajas numeradas de 1 a $N$. Cada caja $i$ tiene peso $w_i$ y soporte $s_i$. Queremos encontrar la maxima cantidad de cajas que pueden apilarse en una unica pila cumpliendo:
- Solo puede haber una caja apoyada directamente sobre otra.
- Las cajas deben estar ordenadas crecientemente por numero de abajo hacia arriba.
- El peso total de las cajas encima de otra no debe exceder su soporte.

*Ejemplo:* $w = [19, 7, 5, 6, 1]$, $s = [15, 13, 7, 8, 2]$. Respuesta: 4 (ej. pila $1\text{-}2\text{-}3\text{-}5$ o $1\text{-}2\text{-}4\text{-}5$).

**1. Idea de Backtracking**

Funcion $f(w, \text{sec})$: para cada caja en $w$, decidir si incluirla o no en la secuencia actual. Complejidad: $O(2^N)$ (evalua todos los subconjuntos).

**2. Formulacion PD — version pseudopolinomial**

**Abstraccion clave:** no importa cuales cajas puse anteriormente, sino cuanto peso puedo poner encima de ellas.

$$f(i, p) = \text{maxima cantidad de cajas apilables usando solo cajas } i, i+1, \ldots, N \text{ con } p \text{ de peso disponible encima}$$

$$f(i, p) = \begin{cases}
-\infty & \text{si } p < 0 \\
0 & \text{si } i > N \\
\max\left(f(i+1, p),\ 1 + f(i+1, \min(p - w_i, s_i))\right) & \text{si } i \leq N
\end{cases}$$

Sea $W = \min\left(\max_{1 \leq i \leq N}(w_i + s_i),\ \sum_{i=1}^N w_i\right)$. La respuesta es $f(1, W)$.

Complejidad: $O(N \cdot W)$ — pseudopolinomial (lineal en $W$, pero $W$ no esta acotado por el tamano de la entrada en bits).

**Observacion:** con enfoque iterativo se puede reducir el espacio a $O(W)$ (en lugar de $O(N \cdot W)$).

**Demostracion de correctitud (induccion en $i$)**

*Hipotesis inductiva $H(i, p)$:* $f(i, p)$ devuelve la maxima cantidad de cajas apilables usando solo las cajas $i, \ldots, N$ con $p$ de peso disponible.

*Caso base:*
- $p < 0$: no se puede poner ninguna caja ($-\infty$). ✓
- $i > N$: no quedan cajas ($0$). ✓

*Caso inductivo ($i \leq N$):* Supongamos $H(i', p')$ cierta para todo $i' > i$. Tenemos dos opciones:
- No poner caja $i$: la maxima cantidad es $f(i+1, p)$, correcto por HI.
- Poner caja $i$: se consume $w_i$ de peso disponible ($p - w_i$), y el nuevo soporte disponible encima de $i$ es $\min(p - w_i, s_i)$. La maxima cantidad es $1 + f(i+1, \min(p - w_i, s_i))$, correcto por HI.

Por lo tanto, $f(i, p)$ devuelve el maximo de ambas opciones, que es correcto. $\square$

**3. Formulacion PD alternativa — version polinomial**

$$f(i, l) = \text{maximo soporte disponible para una pila de longitud } l \text{ formada usando solo las primeras } i \text{ cajas}$$

$$f(i, l) = \begin{cases}
\infty & \text{si } l \leq 0 \\
0 & \text{si } i = 0 \text{ y } l > 0 \\
\max\left(f(i-1, l),\ \min(f(i-1, l-1) - w_i, s_i)\right) & \text{si } i > 0 \text{ y } l > 0
\end{cases}$$

Respuesta: maximo $l$ tal que $f(N, l) \geq 0$.

Complejidad: $O(N^2)$ — completamente polinomial.

*Nota:* Si las cajas estuvieran ponderadas por valor, el problema seria NP-completo (reduccion desde Mochila).

**Comparacion top-down vs bottom-up**

| Enfoque | Espacio | Orden de calculo |
|---------|---------|-----------------|
| Top-down (version 1) | $O(N \cdot W)$ | Recursivo con memo |
| Bottom-up (version 1) | $O(W)$ | Iterativo, $i$ de 1 a $N$; espacio optimizable a $O(W)$ |
| Bottom-up (version 2) | $O(N^2)$ | Iterativo, $i$ de 1 a $N$, $l$ de 0 a $N$ |

**Chuleta**
> Version 1 $O(N \cdot W)$: estado $(i, p)$ = max cajas con peso $p$ disponible; respuesta $f(1, W)$ | Version 2 $O(N^2)$: estado $(i, l)$ = max soporte para pila de longitud $l$ con primeras $i$ cajas; respuesta max $l$ con $f(N, l) \geq 0$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/pd_definir_estado]]

---

## Ver tambien

- [[divide_y_conquista_teoria]] · [[divide_y_conquista_practica]]
- [[fuerza_bruta_backtracking_teoria]] · [[fuerza_bruta_backtracking_practica]]
- [[programacion_dinamica_teoria]] · [[programacion_dinamica_top_down_practica_pt1]] · [[programacion_dinamica_top_down_practica_pt2]] · [[programacion_dinamica_bottom_up_practica]]
- [[greedy_teoria]] · [[greedy_practica]]
- [[definiciones_y_demostraciones_teoria]]
