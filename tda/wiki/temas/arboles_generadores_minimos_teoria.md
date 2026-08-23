---
nombre: Arboles Generadores Minimos — Teoria
parcial: 2P
programa: 2C_2026
tipo: teoria
tema: arboles_generadores_minimos
fuentes:
  vigente: []
  historico:
    - raw/clases/teo/8.teo_2P_arboles_generadores_minimos.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[arboles_teoria]]"
  - "[[grafos_teoria]]"
  - "[[greedy_teoria]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

## Concepto y definicion

**Longitud de un árbol:** Sea $T = (V, X)$ un árbol y $\ell: X \to \mathbb{R}$ una función que asigna pesos a las aristas. Se define la longitud de $T$ como:
$$\ell(T) = \sum_{e \in T} \ell(e)$$

**Árbol Generador Mínimo (AGM):** Dado un grafo conexo $G = (V, X)$ con función de longitudes $\ell$, un AGM de $G$ es un árbol generador de $G$ de mínima longitud:
$$\ell(T) \leq \ell(T') \quad \forall T' \text{ árbol generador de } G$$

## Cuando se aplica

- Grafo conexo con pesos en aristas.
- Se quiere conectar todos los nodos con costo mínimo.
- Ambos algoritmos (Prim y Kruskal) son algoritmos **greedy**.

## Algoritmo de Prim

### Pseudocodigo

```
Entrada: G = (V, X) grafo conexo con función ℓ : X → R.
VT := {z}   (z cualquier nodo de G)
XT := ∅
i := 1
mientras i ≤ n − 1 hacer
  elegir e = (u, v) ∈ X tal que ℓ(e) sea mínima
    entre las aristas que tienen un extremo u ∈ VT
    y el otro v ∈ V \ VT
  XT := XT ∪ {e}
  VT := VT ∪ {v}
  i := i + 1
retornar T = (VT, XT)
```

### Correctitud

**Proposición:** Sea $G$ un grafo conexo. Sea $T_k = (V_{T_k}, X_{T_k})$ el árbol que el algoritmo de Prim determina en la iteración $k$, para $0 \leq k \leq n - 1$. $T_k$ es un subárbol de un árbol generador mínimo de $G$.

**Teorema:** El algoritmo de Prim es correcto: dado un grafo $G$ conexo determina un árbol generador mínimo de $G$.

### Demostraciones

**Prueba de la proposición** (por inducción en $k$):

*Caso base* ($k = 0$): $T_0$ (árbol de un solo nodo) es subárbol de cualquier AGM $T$ ya que todo subgrafo generador de $G$ debe tener a todos los nodos.

*Paso inductivo*: Supongamos que $T_{k-1}$ es subárbol de algún AGM $T$. Supongamos que no vale para $T_k$: entonces existe un AGM $T$ tal que $T_{k-1}$ es subárbol suyo y $T_k$ no lo es. Por lo tanto $e_1, \ldots, e_{k-1}$ son aristas de $T$ y $e_k = (a, b)$ no es arista de $T$.

Sea $P_{ab}$ el camino de $T$ que une $a$ con $b$ y $C = P_{ab} \cup \{e_k\}$ el único ciclo de $T + e_k$. Existe una arista $f = (c, d) \in P_{ab}$ tal que $c \in V_{T_{k-1}}$ y $d \notin V_{T_{k-1}}$. Claramente $\ell(f) \geq \ell(e_k)$ (ambas estaban disponibles en la iteración $k$ y $e_k$ fue elegida). Además $\ell(f) = \ell(e_k)$, pues si $\ell(f) > \ell(e_k)$ entonces $\ell(T) > \ell(T \cup \{e_k\} \setminus \{f\})$, contradiciendo que $T$ es mínimo. Por lo tanto $T' = T \cup \{e_k\} \setminus \{f\}$ es un AGM que tiene a $T_k$ como subárbol. $\square$

### Complejidades

| Implementacion | Complejidad |
|----------------|-------------|
| Estándar | $O(n^2)$ |
| Heap binario | $O((m + n) \log n)$ |
| Heap Fibonacci | $O(m + n \log n)$ |

## Algoritmo de Kruskal

### Pseudocodigo

```
Entrada: G = (V, X) grafo conexo con función ℓ : X → R.
XT := ∅
i := 1
mientras i ≤ n − 1 hacer
  elegir e ∈ X tal que ℓ(e) sea mínima entre las
    aristas que no forman ciclo con las
    aristas que ya están en XT
  XT := XT ∪ {e}
  i := i + 1
retornar T = (V, XT)
```

### Correctitud

**Proposición:** Sea $G$ un grafo conexo. Sea $B_k = (V, X_{T_k})$ el bosque que el algoritmo de Kruskal genera con exactamente $k$ aristas, $0 \leq k \leq n - 1$. $B_k$ es un subgrafo generador sin ciclos de un árbol generador mínimo de $G$.

**Teorema:** El algoritmo de Kruskal es correcto: dado un grafo $G$ conexo determina un árbol generador mínimo de $G$.

### Demostraciones

**Prueba de la proposición** (por inducción en $k$):

Sean $e_1, \ldots, e_m$ las aristas ordenadas de menor a mayor por $\ell$ y $e_1' = e_{j_1}, \ldots, e_{n-1}' = e_{j_{n-1}}$ las $n-1$ aristas agregadas por Kruskal, con $1 = j_1 < \cdots < j_{n-1}$.

*Caso base* ($k = 0$): $B_0$ (sin aristas) es subgrafo generador de cualquier AGM.

*Paso inductivo*: Supongamos que no vale para $B_k$. Existe un AGM $T$ tal que $B_{k-1}$ es subgrafo suyo y $B_k$ no. Por lo tanto $e_1', \ldots, e_{k-1}'$ son aristas de $T$ y $e_k' = e_{j_k} = (a, b)$ no es arista de $T$.

Sea $P_{ab}$ el camino de $T$ que une $a$ con $b$. Cualquier arista $e_p \in P_{ab}$ satisface $\ell(e_p) \leq \ell(e_k')$ (sino $T' = T \cup \{e_k'\} \setminus \{e_p\}$ tendría menor longitud, contradicción). Existe $e_p \in P_{ab}$ que no está en $B_k$ (sino $C = P_{ab} \cup \{e_k'\}$ sería ciclo en $B_k$, contradicción). Si $p < j_k$, $e_p$ formaba ciclo con aristas de $B_{k-1}$ (fue descartada) y ese ciclo estaría en $T$, contradicción. Por lo tanto $p > j_k$ y $\ell(e_p) \geq \ell(e_k')$. Consecuentemente $\ell(e_p) = \ell(e_k')$ y $T' = T \cup \{e_k'\} \setminus \{e_p\}$ es AGM que tiene a $B_k$ como subgrafo generador. $\square$

### Complejidades

| Implementacion | Complejidad |
|----------------|-------------|
| Trivial | $O(m \cdot n)$ |
| Union-Find por rango | $O(m \log n + m \log n)$ |
| Union-Find por rango + compresión de camino | $O(m \log n + m \cdot \alpha(n))$ |

## Comparacion

| Algoritmo | Estrategia | Mejor para |
|-----------|-----------|------------|
| Prim | Crece desde un nodo, siempre mantiene un árbol | Grafos densos ($m \approx n^2$) |
| Kruskal | Ordena aristas globalmente, evita ciclos | Grafos dispersos ($m \approx n$) |

## Formulas clave

$$\ell(T) = \sum_{e \in T} \ell(e) \quad \text{(longitud del árbol)}$$

Intercambio de aristas: Si $T$ es AG y $e \notin T$, $f$ arista del ciclo de $T + e$:
$$T' = T \cup \{e\} \setminus \{f\} \text{ es árbol generador}$$

## Ver tambien

- [[arboles_teoria]] — definicion de arbol generador
- [[grafos_teoria]] — definiciones base
- [[greedy_teoria]] — Prim y Kruskal son greedy
