---
nombre: Caminos Minimos Todos a Todos y DAGs — Clase Practica
parcial: 2P
tipo: practica
tema: caminos_minimos
fuente: raw/clases/prac/11.prac_2P_recorrido_minimo_todos_a_todos_DAGs.pdf
paginas_relacionadas:
  - "[[caminos_minimos_teoria]]"
  - "[[caminos_minimos_practica]]"
---

## Patrones de este tema en parciales
> [[tipos_ejercicio/cm_estado_expandido]] · [[tipos_ejercicio/cm_estado_expandido]]
(se completa despues de analizar parciales)

---

## Repaso: DAGs y camino minimo

### DAG (Directed Acyclic Graph)
Digrafo sin ciclos dirigidos. Se puede verificar con DFS o BFS en $O(n+m)$.

### Orden topologico
Ordenamiento $v_1 v_2 \ldots v_n$ tal que toda arista $v_i v_j$ cumple $i < j$.

**Existencia:** un digrafo tiene orden topologico $\iff$ es un DAG.

**Algoritmos:**
- **Kahn:** cola de nodos con grado de entrada 0; al sacar uno, eliminar aristas salientes; si quedan aristas → hay ciclo.
- **DFS:** invertir el post-order (push a stack al terminar nodo).

**Maximo de aristas en DAG de $n$ nodos:** $\binom{n}{2} = \frac{n(n-1)}{2}$ (grafo completo con orden topologico).

### Camino minimo en DAG

$$d_s(v) = \begin{cases} 0 & \text{si } v = s \\ \min\{w(u,v) + d_s(u) : u \to v \in E\} & \text{si no} \end{cases}$$

Esto es **PD** porque en un DAG no hay ciclos → no hay dependencias circulares. Complejidad: $O(n + m)$ (lineal en tamaño del grafo).

Se puede implementar top-down (memoizacion) o bottom-up (orden topologico, relajar aristas en ese orden).

**Nota:** en un DAG tambien se puede calcular camino **maximo** (negar pesos o cambiar min por max). Esto **no** funciona en digrafos generales.

---

## Repaso: APSP (All-Pairs Shortest Paths)

| Algoritmo | Complejidad | Observaciones |
|-----------|-------------|---------------|
| Floyd-Warshall | $O(n^3)$ | PD, invariante: despues de iteracion $k$, considera intermedios $\{1, \ldots, k\}$ |
| Dantzig | $O(n^3)$ | Crece matriz $k \times k$; util cuando se agregan nodos incrementalmente |
| $n \times$ Dijkstra | $O(n \cdot m \log n)$ | Mejor para grafos ralos con pesos $\geq 0$ |
| $n \times$ Bellman-Ford | $O(n^2 m)$ | Necesario con pesos negativos |
| Johnson | $O(nm \log n)$ | Repondera (BF una vez) + $n \times$ Dijkstra |

Cota inferior del output: $O(n^2)$ (la matriz de distancias tiene $n^2$ entradas).

---

## Ejercicios de clase

### Ejercicio 1 — Sasha y los peajes (DAG por expansion temporal)

**Enunciado**
Mapa de $n$ ciudades y $m$ rutas. Cada ruta $e_i$ tiene peaje $p_i$ y tarda $m_i$ minutos. Encontrar camino de Kruskal a Kazan que minimice peajes con tiempo total $< t$ ($t \in O(n)$, "chico").

**Explicacion**
Como hay dos costos (tiempo y peaje) y el tiempo esta acotado, se puede expandir el grafo por tiempo: cada estado = (ciudad, tiempo transcurrido). El grafo expandido es un **DAG** (el tiempo solo avanza), permitiendo PD en $O(nt + mt)$.

**Resolucion paso a paso**

1. **Construir digrafo $G_t$:** vertices = pares $(c, t')$ con $c \in V$, $0 \leq t' \leq t$. Aristas: $(c_1, t_1) \to (c_2, t_2)$ con peso $p_j$ si arista $c_1 c_2 = e_j$ y $m_j + t_1 = t_2$ — $O(nt + mt)$
2. **Agregar nodo final:** aristas de costo 0 desde todos $(Kazan, t')$ para $0 \leq t' \leq t$ — $O(t)$
3. **Camino minimo** de $(Kruskal, 0)$ a final en el DAG — $O(nt + mt)$

**¿Por que es un DAG?** El tiempo solo crece → no hay ciclos.

**Observaciones:**
- Se puede usar Dijkstra ($O(mt \log(nt))$) pero PD sobre el DAG es mas eficiente: $O(nt + mt)$
- Si $t$ no esta acotado, la solucion puede ser exponencial

**Variaciones:**
- Camino minimo a todas las ciudades: agregar nodo final por ciudad, misma complejidad
- Contar recorridos que tarden $< t$: PD con $\text{CR}(v) = \sum_{x \in N^+(v)} \text{CR}(x)$ para $(ciudad, t') \neq Kazan$; $\text{CR}(Kazan, t') = 1$

**Complejidad:** $O(nt + mt)$.

**Chuleta**
> 1. Expandir por tiempo: estado = (ciudad, $t'$) → DAG → 2. Nodo final para Kazan en cualquier $t' \leq t$ → 3. PD/CM en DAG: $O(nt + mt)$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/cm_estado_expandido]]

---

### Ejercicio 2 — Rayuela rectangular (DAG + camino maximo)

**Enunciado**
Rayuela $p \times q$ con numeros distintos. Desde $(i,j)$ se puede saltar a casillas en la misma fila/columna a distancia $\leq k$, siempre que el numero destino sea mayor. Se ganan $r$ puntos al saltar de $x$ a $x+r$. Encontrar el casillero inicial que maximice puntos.

**Explicacion**
Modelar como DAG: nodos = casillas $(i,j)$, aristas solo van de numeros menores a mayores → no hay ciclos. Calcular camino maximo con nodos inicio/fin ficticios.

**Resolucion paso a paso**

1. **Armar digrafo $D$:** $V = \{(i,j) : 0 \leq i < p, 0 \leq j < q\}$. Arista $(i_1, j_1) \to (i_2, j_2)$ con peso $R[i_2, j_2]$ si estan en misma fila/columna, distancia $\leq k$, y $R[i_1,j_1] < R[i_2,j_2]$ — $O(pqk)$
2. **Nodo inicio:** aristas de costo 0 a todos los vertices
3. **Nodo fin:** aristas de costo 0 desde vertices con grado de salida 0
4. **Camino maximo** de inicio a fin en el DAG — $O(pqk)$ (lineal en tamaño del grafo)
5. El segundo nodo del camino maximo = casillero inicial optimo

**Es un DAG** porque las aristas solo van de numeros menores a mayores.

**Complejidad:** $O(p \cdot q \cdot k)$.

**Chuleta**
> 1. Nodos = casillas, aristas solo a numeros mayores (→ DAG) → 2. Nodos inicio/fin ficticios → 3. Camino maximo en DAG: $O(pqk)$

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — Optimizando canciones (Floyd-Warshall + iteracion)

**Enunciado**
$k$ acordes, cancion $C = c_1, c_2, \ldots, c_n$. Pasar del acorde $i$ al $j$ toma $S_{ij}$ segundos, pero a veces es mas rapido con acordes intermedios. Encontrar el tiempo minimo para tocar la cancion.

**Explicacion**
Grafo completo de $k$ nodos (acordes), aristas $S_{ij}$. Precalcular distancias todos-a-todos con **Floyd-Warshall** (el grafo es completo → $|E| \in \Theta(k^2)$ → Floyd es mejor que Johnson). Luego sumar distancias a lo largo de la cancion.

**Resolucion paso a paso**
1. Construir grafo de $k$ nodos con aristas $S_{ij}$
2. **Floyd-Warshall** → matriz de distancias $\delta$ — $O(k^3)$
3. Tiempo total: $t = \sum_{i=1}^{n-1} \delta(c_i, c_{i+1})$ — $O(n)$

**Complejidad:** $O(k^3 + n)$.

**Variacion — cambiar un acorde para minimizar tiempo:**
- Para cada posicion $i > 1$, evaluar cambiar $c_i$ por $c_{i-1}$ (repetir el anterior):
  $t_{c_{i-1} \to c_i} = t - \delta(c_{i-1}, c_i) + \delta(c_{i-1}, c_{i-1}) - \delta(c_i, c_{i+1}) + \delta(c_{i-1}, c_{i+1})$
- **Desigualdad triangular:** $\delta(c_i, c_{i+1}) \leq \delta(c_i, e) + \delta(e, c_{i+1})$ para todo $e$ → el minimo se alcanza repitiendo un acorde vecino (no hace falta probar los $k-1$ candidatos).
- Complejidad: $O(k^3 + n)$.

**Chuleta**
> 1. Floyd $O(k^3)$ → 2. Sumar distancias consecutivas $O(n)$ · Variacion: desigualdad triangular → basta probar repetir acorde vecino

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/cm_estado_expandido]]

---

### Ejercicio 4 — Mas trenes (Dantzig incremental vs Dijkstra on-demand)

**Enunciado**
Red de trenes con queries: (1) agregar localidad con rutas, (2) cambiar velocidad del tren, (3) consultar tiempo de $i$ a $j$. Proponer estructura de datos.

**Explicacion**
Dos estrategias con trade-offs distintos segun la proporcion de queries:

| | E1 (lazy) | E2 (eager, Dantzig) |
|---|-----------|---------------------|
| Agregar localidad | $O(n)$ — agregar nodo/aristas | $O(n^2)$ — recalcular distancias a lo Dantzig |
| Cambiar tren | $O(1)$ | $O(1)$ |
| Consulta $i \to j$ | $O(m \log n)$ — Dijkstra | $O(1)$ — lookup en matriz |
| **Total** | $O(n^2 + T + Qm\log n)$ | $O(n^3 + T + Q)$ |

Conviene E1 si pocas consultas, E2 si muchas consultas.

**Chuleta**
> Pocas consultas: Dijkstra on-demand $O(m \log n)$ por query · Muchas consultas: Dantzig incremental $O(n^2)$ por nodo agregado, $O(1)$ por query

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/cm_estado_expandido]]

---

### Ejercicio 5 — String problem (Floyd + iteracion por caracter)

**Enunciado**
Dado un alfabeto $\Sigma$ con costos $w_{s_1, s_2}$ de reemplazar simbolo $s_1$ por $s_2$ (posiblemente $\infty$), transformar cadena $a$ en cadena $b$ con costo minimo. Cada posicion es independiente.

**Explicacion**
Cada posicion $i$ es un subproblema: costo minimo de $a_i$ a $b_i$ en el grafo de $|\Sigma|$ nodos con aristas $w_{s_1, s_2}$. Precalcular distancias con Floyd.

**Resolucion:**
1. Si $|a| \neq |b|$: imposible
2. Grafo de $|\Sigma|$ nodos, aristas $w_{s_1, s_2}$
3. Floyd-Warshall → $O(|\Sigma|^3)$
4. Costo total: $\sum_{i=1}^{|a|} \delta(a_i, b_i)$ — $O(|a|)$

**Complejidad:** $O(|\Sigma|^3 + |a|)$. Alternativa sin precalcular: Dijkstra por posicion → $O(|a| \cdot m^2 \log |\Sigma|)$.

**Chuleta**
> Floyd sobre alfabeto $O(|\Sigma|^3)$ → sumar distancias por posicion $O(|a|)$

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 6 — Manic Moving (Floyd + PD sobre ruta de entregas)

**Enunciado**
Homero reparte paquetes a locales $l_1, \ldots, l_k$ en orden, desde central $c$. Su camion lleva maximo 2 paquetes. Minimizar tiempo total de reparto.

**Explicacion**
En cada paso hay dos opciones: (1) llevar 1 paquete (ir y volver) o (2) llevar 2 paquetes (visitar 2 locales seguidos y volver).

**Formula recursiva:**

$$\text{hom}(i) = \begin{cases} \infty & \text{si } i > k+1 \\ 0 & \text{si } i = k+1 \\ \min\begin{cases} \text{hom}(i+1) + \delta(c, l_i) + \delta(l_i, c) \\ \text{hom}(i+2) + \delta(c, l_i) + \delta(l_i, l_{i+1}) + \delta(l_{i+1}, c) \end{cases} & \text{c.c.} \end{cases}$$

**Resolucion:**
1. Precalcular distancias todos-a-todos con Floyd: $O(n^3)$
2. Calcular $\text{hom}(1)$ con PD: $O(k)$

**Complejidad:** $O(n^3 + k)$.

**Chuleta**
> Floyd $O(n^3)$ → PD: en cada paso min(llevar 1 paquete, llevar 2) → $O(k)$

**¿Aparece en parciales?** ⚪ No

---

## Tips para DAGs (de la clase)

1. Leer bien el enunciado y anotar todos los datos para modelar
2. **No modificar los algoritmos** — usarlos como caja negra. Modelar el problema para que el algoritmo estandar de la respuesta directa
3. Estar atentos a si el digrafo es un DAG: permite PD lineal en lugar de Dijkstra/Bellman-Ford

---

## Ver tambien

- [[caminos_minimos_teoria]] — Dijkstra, Bellman-Ford, Floyd (PD todos pares $O(n^3)$), Dantzig (crece matriz)
- [[caminos_minimos_practica]] — ejercicios uno-a-todos: policias (BFS multi-source), Martin (Dijkstra doble), Manuel (Bellman-Ford + DAG CM)
- [[programacion_dinamica_teoria]] — top-down vs bottom-up, definicion recursiva
