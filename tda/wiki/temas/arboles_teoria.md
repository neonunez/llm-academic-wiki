---
nombre: Arboles — Teoria
parcial: 2P
tipo: teoria
tema: arboles
fuente: raw/clases/teo/7.teo_2P_arboles.pdf
paginas_relacionadas:
  - "[[grafos_teoria]]"
  - "[[arboles_generadores_minimos_teoria]]"
---

## Concepto y definicion

Un **arbol** es un grafo conexo sin circuitos simples.

Definiciones auxiliares:
- Una **arista** $e$ de $G$ es **puente** si $G - e$ tiene más componentes conexas que $G$.
- Un **vértice** $v$ de $G$ es **punto de corte** o **punto de articulación** si $G - v$ tiene más componentes conexas que $G$.

## Propiedades y teoremas

### Teorema de equivalencias (forma 1)

Dado un grafo $G = (V, X)$ son equivalentes:
1. $G$ es un árbol.
2. $G$ es un grafo sin circuitos simples, pero si se agrega una arista $e$ a $G$ resulta un grafo con exactamente un circuito simple, y ese circuito contiene a $e$.
3. Existe exactamente un camino entre todo par de nodos.
4. $G$ es conexo, pero si se quita cualquier arista a $G$ queda un grafo no conexo (toda arista es puente).

### Lemas

**Lema 0:** Sea $G = (V, X)$ un grafo, $v, w \in V$ dos vértices diferentes, y existen 2 caminos distintos entre estos dos vértices. Entonces hay un ciclo en $G$.

**Lema 1:** Sea $G = (V, X)$ un grafo conexo y $e \in X$. $G - e$ es conexo si y solo si $e$ pertenece a un circuito simple de $G$.

**Lema 2:** Todo árbol no trivial tiene al menos dos hojas.
- Una **hoja** es un nodo de grado 1.

**Lema 3:** Sea $G = (V, X)$ árbol. Entonces $m = n - 1$.

**Corolario 1:** Sea $G = (V, X)$ sin circuitos simples y $c$ componentes conexas. Entonces $m = n - c$.

**Corolario 2:** Sea $G = (V, X)$ con $c$ componentes conexas. Entonces $m \geq n - c$.

### Teorema de equivalencias (forma 2)

Dado un grafo $G$ son equivalentes:
1. $G$ es un árbol.
2. $G$ es un grafo sin circuitos simples y $m = n - 1$.
3. $G$ es conexo y $m = n - 1$.

## Arboles enraizados

- Un **árbol enraizado** es un árbol que tiene un vértice distinguido llamado **raíz**.
- El **nivel** de un vértice es la distancia de la raíz a ese vértice.
- La **altura** $h$ de un árbol enraizado es el máximo nivel de sus vértices.
- Los **vértices internos** son aquellos que no son ni hojas ni la raíz.
- Un árbol enraizado se dice **m-ario** si todos sus vértices internos tienen grado a lo sumo $m + 1$ y su raíz a lo sumo $m$.
- Un árbol enraizado se dice **exactamente m-ario** si todos sus vértices internos tienen grado $m + 1$ y su raíz $m$.
- Un árbol se dice **balanceado** si todas sus hojas están a nivel $h$ o $h - 1$.
- Un árbol se dice **balanceado completo** si todas sus hojas están a nivel $h$.
- Dos vértices adyacentes tienen relación **padre-hijo**, siendo el padre el vértice de menor nivel.

### Teorema sobre árboles m-arios

- Un árbol $m$-ario de altura $h$ tiene a lo sumo $m^h$ hojas. Alcanza esta cota si es un árbol exactamente $m$-ario balanceado completo con $h \geq 1$.
- Un árbol $m$-ario con $l$ hojas tiene $h \geq \lceil \log_m l \rceil$.
- Si $T$ es un árbol exactamente $m$-ario balanceado no trivial entonces $h = \lceil \log_m l \rceil$.

**Cantidad de nodos en árbol exactamente m-ario:** Si tiene $i$ nodos internos, tiene $mi + 1$ nodos en total.

## Arboles generadores

**Definición:** Un **árbol generador (AG)** de un grafo $G$ es un subgrafo generador (que tiene el mismo conjunto de vértices) de $G$ que es árbol.

**Teoremas:**
- Todo grafo conexo tiene (al menos) un árbol generador.
- $G$ tiene un único árbol generador $\Longleftrightarrow$ $G$ es árbol.
- Sea $T = (V, X_T)$ un AG de $G = (V, X)$ y $e \in X \setminus X_T$. Entonces $T' = T + e - f = (V, X_T \cup \{e\} \setminus \{f\})$, con $f$ una arista del único circuito de $T + e$, es árbol generador de $G$.

## Recorrido de arboles y grafos: BFS y DFS

Al recorrer los vértices de un grafo conexo $G$, los valores de $pred$ implícitamente definen un AG de $G$.

### Algoritmo generico

```
recorrer(G)
  salida: pred[i] = padre de vi, orden[i] = numero asignado a vi
  next ← 1
  r ← elegir un vertice como raiz
  pred[r] ← 0
  orden[r] ← next y orden[v] ← 0 para todo nodo v ≠ r
  LISTA ← {r}
  mientras LISTA ≠ ∅ hacer
    elegir un nodo i de LISTA
    si ∃ un arco (i,j) tq j ∉ LISTA y orden[j] = 0 entonces
      pred[j] ← i
      next ← next + 1
      orden[j] ← next
      LISTA ← LISTA ∪ {j}
    sino
      LISTA ← LISTA \ {i}
    fin si
  fin mientras
  retornar pred y orden
```

**BFS vs DFS:** difieren en cómo se elige el nodo de LISTA:
- **BFS (Breadth-First Search):** LISTA implementada como **cola** — visita nivel a nivel.
- **DFS (Depth-First Search):** LISTA implementada como **pila** — explora cada rama lo más profundo posible antes de retroceder.

### BFS para calcular distancias

- Agregar matriz $dist$ de tamaño $n \times n$, inicializar $dist[i,j] \leftarrow \infty$ si $i \neq j$, $dist[i,i] \leftarrow 0$.
- Después de $pred[j] \leftarrow i$, agregar $dist[r,j] \leftarrow dist[r,i] + 1$.
- Aplicar BFS para cada raíz $r$.

### DFS con timestamps

Incorporar variables adicionales para más información:
- Variable $timer$ inicializada en 0.
- Arreglos $desde[]$ y $hasta[]$, dimensión $n$, inicializados en $-1$.
- Al ingresar nodo $i$ a la pila: $timer \mathrel{+}= 1$, $desde[i] = timer$.
- Al salir nodo $i$ de la pila: $timer \mathrel{+}= 1$, $hasta[i] = timer$.

El intervalo $(desde[i], hasta[i])$ representa el lapso de tiempo que $i$ estuvo en la pila. Para cualquier par de intervalos: hay relación de **contención** o son **disjuntos** (analogía con secuencia de paréntesis).

### Clasificacion de arcos en DFS (digrafos)

| Tipo | Condicion |
|------|-----------|
| **tree edge** | $i = pred[j]$ |
| **backward edge** | $(desde[j], hasta[j])$ contiene a $(desde[i], hasta[i])$ — va hacia ancestro |
| **forward edge** | $(desde[i], hasta[i])$ contiene a $(desde[j], hasta[j])$ y $i \neq pred[j]$ — va hacia descendiente |
| **cross edge** | $hasta[j] < desde[i]$ — va hacia otro árbol o rama anterior |

**Para grafos (no digrafos):** solo existen tree edges y back edges.

## Aplicaciones con DFS

### Deteccion de ciclos

**Teorema:** Dado un grafo (digrafo) $G$:
$$G \text{ tiene un ciclo (ciclo orientado)} \Longleftrightarrow \text{ existe un backward edge en } G$$

### Sort topologico

Ordenar los nodos de acuerdo a su valor en el arreglo $hasta$ de mayor a menor. (No hace falta ordenar explícitamente si se usa una pila al sacar nodos.)

### Componentes fuertemente conexas

Determinar las componentes fuertemente conexas de un digrafo usando DFS (algoritmo de Kosaraju o Tarjan).

### Puntos de corte y aristas puente

Determinar los puntos de corte y las aristas puentes de un grafo conexo mediante DFS con timestamps.

## Formulas clave

$$m = n - 1 \quad \text{(árbol)}$$
$$m = n - c \quad \text{(sin circuitos, } c \text{ componentes conexas)}$$
$$\text{Árbol exactamente m-ario: nodos totales} = mi + 1 \quad \text{(i nodos internos)}$$
$$\text{Árbol m-ario con } l \text{ hojas:} \quad h \geq \lceil \log_m l \rceil$$

## Ver tambien

- [[arboles_generadores_minimos_teoria]] — Prim, Kruskal
- [[grafos_teoria]] — definiciones base, representacion
- [[caminos_minimos_teoria]] — BFS para caminos mínimos no pesados
