---
nombre: Caminos Minimos Uno a Todos — Clase Practica
parcial: 2P
tipo: practica
tema: caminos_minimos
fuente:
  - raw/clases/prac/10.prac_2P_recorrido_minimo_uno_a_todos.pdf
  - raw/clases/prac/10.prac_2P_recorrido_uno_a_todos_soluciones.pdf
paginas_relacionadas:
  - "[[caminos_minimos_teoria]]"
  - "[[arboles_generadores_minimos_practica]]"
  - "[[caminos_minimos_todos_a_todos_y_dags_practica]]"
  - "[[caminos_minimos_guia]]"
---

## Patrones de este tema en parciales
> [[tipos_ejercicio/cm_estado_expandido]]

---

## Repaso: algoritmos de camino minimo uno a todos

| Algoritmo | Restriccion | Complejidad |
|-----------|------------|-------------|
| BFS | Costos iguales | $O(n + m)$ |
| Dijkstra | Costos $\geq 0$ | $O(\min\{m \log n, n^2\})$ |
| Bellman-Ford | Cualquier costo (detecta ciclos negativos) | $O(nm)$ |

---

## Ejercicios de clase

### Ejercicio 1 — Policias (BFS multi-source con nodo fantasma)

**Enunciado**
Una ciudad tiene esquinas $\{v_1, \ldots, v_n\}$, calles $E$, y estaciones de policia en esquinas $\{p_1, \ldots, p_k\}$. Toda esquina debe estar a lo sumo a 5 cuadras de una estacion. Indicar si la normativa se cumple; si no, listar las esquinas desprotegidas.

**Explicacion**
Tecnica **BFS multi-source**: en vez de correr BFS desde cada nodo ($O(n(n+m))$) o desde cada policia ($O(k(n+m))$), agregar un nodo fantasma conectado a todas las estaciones y correr un unico BFS.

**Resolucion paso a paso**
1. Modelar: $V = \{v_1, \ldots, v_n\}$, $E$ = calles
2. Agregar nodo fantasma $\star$ con aristas a todos los $p_i$ — $O(k)$
3. Correr **BFS desde $\star$** — $O(n + m)$
4. Para cada vertice $v$: $\text{distancia a policia mas cercana} = \text{dist}(\star, v) - 1$
5. Si $\text{dist} - 1 > 5$: esquina desprotegida

**Justificacion:** Todo camino desde $\star$ pasa primero por alguna estacion de policia. Un vertice $v$ a distancia $d$ de $\star$ esta a distancia $d-1$ de la estacion mas cercana (y viceversa).

**Complejidad:** $O(n + m + k) = O(n + m)$.

**Chuleta**
> 1. Nodo fantasma $\star$ conectado a estaciones → 2. BFS desde $\star$ → 3. Distancia real = distancia a $\star$ menos 1 → 4. Si $> 5$: desprotegida

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/cm_estado_expandido]]

---

### Ejercicio 2 — Martin y los Mares (Dijkstra doble + aristas especiales)

**Enunciado**
Martin viaja de isla $A$ a isla $B$ por un digrafo con aristas de dos tipos: (1) aristas normales que **suman** $c(u,v)$ percebes, (2) aristas "tortuga" que **multiplican** por $(1 - t(u,v))$ los percebes acumulados (comen un porcentaje). Martin puede pasar por **maximo una** arista tortuga. Minimizar percebes al llegar a $B$.

**Explicacion**
Tecnica de **Dijkstra doble** (ida y vuelta): sacar las aristas tortuga, correr Dijkstra desde $A$ y desde $B$ (en el traspuesto), luego iterar sobre cada arista tortuga evaluando el costo total del camino que la usa.

**Resolucion paso a paso**

Sea $D_0$ el digrafo sin aristas tortuga.

1. **Dijkstra desde $A$** en $D_0$ → $w(A, u)$ para todo $u$ — $O(\min\{m \log n, n^2\})$
2. **Trasponer** $D_0$ → $D_0^T$ — $O(m + n)$
3. **Dijkstra desde $B$** en $D_0^T$ → $w(v, B)$ para todo $v$ — $O(\min\{m \log n, n^2\})$
4. Para cada arista tortuga $(u, v)$: calcular $w(A, u) \cdot (1 - t(u,v)) + w(v, B)$ — $O(m)$
5. Retornar $\min(\text{camino sin tortuga}, \min_{\text{aristas tortuga}}\{\ldots\})$

**Demostracion de correctitud**

Sea $P_{\sin}$ = pesos de caminos sin arista tortuga, $P_{\text{con}}$ = pesos de caminos con exactamente 1 arista tortuga.

- $\min(P'_{\sin}) = \min(P_{\sin})$: trivial (es Dijkstra).
- $\min(P'_{\text{con}}) \leq \min(P_{\text{con}})$: porque $w(A,u)$ y $w(v,B)$ son minimos, y $t(u,v) \geq 0$, asi que el costo calculado es $\leq$ al de cualquier camino que use esa arista tortuga.
- $\min(P'_{\text{con}}) \geq \min(P_{\text{con}})$: porque $P'_{\text{con}} \subseteq P_{\text{con}}$ (cada costo calculado corresponde a un camino valido).

$\Rightarrow$ Solucion = Algoritmo. $\square$

**Complejidad:** $O(\min\{m \log n, n^2\})$.

**Chuleta**
> 1. Sacar aristas tortuga → 2. Dijkstra desde $A$ → 3. Dijkstra desde $B$ en traspuesto → 4. Para cada arista tortuga $(u,v)$: $w(A,u) \cdot (1-t) + w(v,B)$ → 5. Min entre sin tortuga y con tortuga

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/cm_estado_expandido]]

---

### Ejercicio 3 — Manuel y los Monstruos (Bellman-Ford + DAG de caminos minimos)

**Enunciado**
Un juego con mundos $m_1, \ldots, m_n$ conectados por portales unidireccionales con puntaje $p_i \in \mathbb{R}$. Encontrar: (a) el puntaje maximo de $m_1$ a $m_n$ (puede ser $\infty$ si hay ciclo positivo alcanzable), (b) el minimo numero de portales para obtener ese puntaje maximo.

**Explicacion**
Camino maximo = negar pesos y buscar camino minimo. Ciclo positivo = ciclo negativo con pesos negados. Solo importan ciclos alcanzables desde $m_1$ que alcancen $m_n$.

**Parte (a) — Puntaje maximo**

**Demostracion** (puntuacion no acotada $\iff$ ciclo positivo alcanzable de $m_1$ a $m_n$):
- $\Leftarrow$: trivial — tomar el ciclo repetidamente.
- $\Rightarrow$: si no acotada, para toda $s$ existe recorrido de puntaje $> s$. Tomando $s$ = suma de todos los pesos positivos, ningun camino simple puede superar $s$. Entonces el recorrido tiene un ciclo. Si todos los ciclos fueran no-positivos, al eliminarlos el costo no disminuye, dejando un camino $> s$. Absurdo.

**Algoritmo:**
1. Armar digrafo: nodos = mundos, aristas = portales con peso $p_i$
2. Multiplicar pesos por $-1$
3. Eliminar nodos que no alcancen $m_n$: trasponer, DFS desde $m_n$, borrar no alcanzados — $O(n + m)$
4. **Bellman-Ford desde $m_1$:** si detecta ciclo negativo → retornar $\infty$; sino retornar $-d(m_1, m_n)$

**Parte (b) — Minimo numero de portales**

(Solo tiene sentido si no hay ciclos positivos.)

Construir el **DAG de caminos minimos**: un digrafo con solo las aristas que pertenecen a algun camino minimo de $m_1$ a $m_n$.

1. Bellman-Ford desde $m_1$ → vector $\text{dist}_{m_1}$ — $O(nm)$
2. Bellman-Ford desde $m_n$ en $G^T$ → vector $\text{dist}_{m_n}$ — $O(nm)$
3. Arista $(u,v)$ esta en un camino minimo $\iff$ $\text{dist}_{m_1}[u] + \text{peso}(u,v) + \text{dist}_{m_n}[v] = \text{dist}_{m_1}[m_n]$
4. Agregar esas aristas al DAG
5. **BFS desde $m_1$ en el DAG** → distancia (en numero de aristas) a $m_n$ = minimo de portales

**Demostracion (DAG correcto):**
- $\Rightarrow$: si arista esta en el DAG, cumple la ecuacion, entonces pertenece a un camino minimo.
- $\Leftarrow$: si arista pertenece a un camino minimo, cumple la ecuacion, entonces esta en el DAG.

BFS en el DAG da la minima distancia en aristas de $m_1$ a $m_n$, que es el minimo de portales.

**Nota:** sin ciclos negativos, tambien se puede usar PD sobre DAGs o sort topologico + relajacion.

**Complejidad total:** $O(nm)$.

**Chuleta**
> (a) Negar pesos → podar nodos sin camino a $m_n$ → Bellman-Ford (detectar ciclos) · (b) Construir DAG de CM: $\text{dist}_{m_1}[u] + w(u,v) + \text{dist}_{m_n}[v] = \text{dist}_{m_1}[m_n]$ → BFS en DAG = min portales

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/cm_estado_expandido]]

---

## Resumen: cuando usar cada algoritmo

| Situacion | Algoritmo | Clave |
|-----------|-----------|-------|
| Sin pesos / pesos iguales | BFS | $O(n+m)$ |
| Pesos $\geq 0$, uno a todos | Dijkstra | $O(m \log n)$ o $O(n^2)$ |
| Pesos negativos posibles | Bellman-Ford | $O(nm)$, detecta ciclos negativos |
| Multi-source (muchos origenes) | Nodo fantasma + BFS/Dijkstra | Reduce a uno-a-todos |
| Restriccion "maximo 1 arista especial" | Dijkstra doble (ida/vuelta) | Evaluar cada arista especial |
| Camino maximo | Negar pesos + camino minimo | Ciclo positivo → no acotado |

---

## Ver tambien

- [[caminos_minimos_teoria]] — Dijkstra (lema, teorema, complejidades), Bellman-Ford (lemas, deteccion ciclos negativos), Floyd, Dantzig
- [[arboles_generadores_minimos_practica]] — AGM, camino MiniMax
- [[caminos_minimos_todos_a_todos_y_dags_practica]] — Floyd, Dantzig, DAGs, PD sobre DAGs
- [[recorrido_en_grafos_practica]] — BFS, DFS, aplicaciones basicas
- [[caminos_minimos_guia]] — Guia de ejercicios del tema
