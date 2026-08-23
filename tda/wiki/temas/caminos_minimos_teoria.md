---
nombre: Caminos Minimos en Grafos — Teoria
parcial: 2P
programa: 2C_2026
tipo: teoria
tema: caminos_minimos
fuentes:
  vigente: []
  historico:
    - raw/clases/teo/9.teo_2P_caminos_minimos_en_grafos1.pdf
    - raw/clases/teo/10.teo_2P_caminos_minimos_en_grafos2.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[grafos_teoria]]"
  - "[[arboles_teoria]]"
  - "[[programacion_dinamica_teoria]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

## Concepto y definicion

Sea $G = (V, X)$ un grafo y $\ell: X \to \mathbb{R}$ una función de longitud/peso.

**Longitud de un recorrido** $R$ entre $v$ y $u$:
$$\ell(R) = \sum_{e \in R} \ell(e)$$

**Recorrido mínimo** $R'$ entre $u$ y $v$: recorrido de longitud mínima entre todos los recorridos entre $u$ y $v$.

**Camino mínimo:** Si un recorrido mínimo es un camino, se llama camino mínimo. La existencia de recorridos mínimos es equivalente a la existencia de caminos mínimos. Puede haber varios caminos mínimos.

**Distancia** entre $u$ y $v$: $dist(u, v)$ es la longitud de un camino mínimo entre $u$ y $v$ (si existe camino, $\infty$ en caso contrario).

## Cuando se aplica

### Variantes del problema

1. **Único origen - único destino:** Determinar un camino mínimo entre dos vértices específicos $v$ y $u$.
2. **Único origen - múltiples destinos:** Determinar un camino mínimo desde un vértice específico $v$ al resto de los vértices de $G$.
3. **Múltiples orígenes - múltiples destinos:** Determinar un camino mínimo entre todo par de vértices de $G$.

Todos estos conceptos se adaptan para grafos orientados.

### Consideraciones importantes

**Aristas con peso negativo:** Si $G$ no contiene ciclos de peso negativo (o los tiene pero no son alcanzables desde $v$), el problema sigue bien definido. Si $G$ tiene algún ciclo con peso negativo alcanzable desde $v$, el concepto de recorrido de peso mínimo deja de estar bien definido.

**Ciclos:** El problema de minimizar entre recorridos sin ciclos siempre está bien definido.

## Propiedades y teoremas

### Subestructura optima de un camino minimo

**Propiedad:** Dado un digrafo $G = (V, X)$ con función de peso $\ell: X \to \mathbb{R}$, sea $P: v_1 \ldots v_k$ un camino mínimo de $v_1$ a $v_k$. Entonces $\forall 1 \leq i \leq j \leq k$, $P_{v_i v_j}$ es un camino mínimo desde $v_i$ a $v_j$.

Esta propiedad es la base de los algoritmos de programación dinámica para caminos mínimos (Floyd, Dantzig).

## Algoritmo de Dijkstra (1959) — Unico origen, pesos no negativos

**Supuesto:** Longitudes de aristas no negativas. El grafo puede ser orientado o no.

**Idea:** Greedy — mantener conjunto $S$ de nodos con distancia ya determinada, extender por la arista de menor costo.

### Pseudocodigo

```
S := {v}, π(v) := 0, pred(v) := 0, w := v
para todo u ∈ V \ {v} hacer
  si (v, u) ∈ X entonces
    π(u) := ℓ(v, u), pred(u) := v
  sino
    π(u) := ∞, pred(u) := ∞
  fin si
fin para
mientras S ≠ V y π(w) < ∞ hacer
  elegir w ∈ V \ S tal que π(w) = mín_{u ∈ V\S} π(u)
  S := S ∪ {w}
  para todo u ∈ V \ S y (w, u) ∈ X hacer
    si π(u) > π(w) + ℓ(w, u) entonces
      π(u) := π(w) + ℓ(w, u)
      pred(u) := w
    fin si
  fin para
fin mientras
retornar π, pred
```

### Correctitud

**Lema:** Dado un grafo orientado $G$ con pesos no negativos, al finalizar la iteración $k$ el algoritmo de Dijkstra determina el camino mínimo entre el nodo $v$ y los nodos de $S_k$.

**Teorema:** Dado un grafo orientado $G$ con pesos no negativos, el algoritmo de Dijkstra determina el camino mínimo entre el nodo $v$ y el resto de los nodos de $G$.

**Prueba del lema** (por inducción en $k$): Sean $w_k$ el vértice agregado a $S$ en la iteración $k$, $v = w_0$.

1. Si $\pi(w_k) = \infty$: no hay camino alcanzable desde $v$ hasta $w_k$ (pues si existiese arista de algún $w_p \in S_{k'-1}$ hacia algún $u \notin S_{k'-1}$, se habría actualizado $\pi(u) < \infty$, contradicción).

2. Si $\pi(w_k) < \infty$: tomemos $C_{v,w_k}$ un camino mínimo. Sea $z$ el primer nodo de $C_{v,w_k}$ tal que $z \notin S_{k-1}$ y $w_p$ el nodo anterior de $z$ en $C$. Por hipótesis inductiva $\pi(w_p) = dist(v, w_p)$. Entonces:
$$dist(v, w_k) \geq \ell(C_{v,w_p}) + \ell(w_p, z) = dist(v, w_p) + \ell(w_p, z) = \pi(w_p) + \ell(w_p, z) \geq \pi(z) \geq \pi(w_k)$$
Por otro lado, siempre $dist(v, w_k) \leq \pi(w_k)$. Entonces $\pi(w_k) = dist(v, w_k)$. $\square$

**Nota:** Dijkstra **falla con aristas negativas** — una vez que un nodo entra a $S$, su $\pi$ no se vuelve a actualizar.

### Complejidades

| Implementacion | Complejidad |
|----------------|-------------|
| Trivial | $O(n^2)$ |
| Heap binario | $O((m + n) \log n)$ |
| Heap Fibonacci | $O(m + n \log n)$ |

**Cola de prioridad:** 3 operaciones: CreateQueue $\Theta(n)$, ExtractMin $O(\log n)$, DecreaseKey: $O(\log n)$ (heap binario) o $\Theta(1)$ amortizado (heap Fibonacci).

## Algoritmo de Ford/Bellman-Ford (1956) — Unico origen, permite pesos negativos

**Supuesto:** Grafo orientado, no tiene ciclos de longitud negativa alcanzables desde $v$.

### Pseudocodigo

```
π(v) := 0
para todo u ∈ V \ {v} hacer
  π(u) := ∞
fin para
mientras hay cambios en π hacer
  π' := π
  para todo u ∈ V \ {v} hacer
    π(u) := mín(π(u), mín_{(w,u) ∈ X} π'(w) + ℓ(w, u))
  fin para
fin mientras
retornar π
```

### Correctitud

**Lema 1:** En todo momento de la ejecución del algoritmo de Ford:
1. Si $\pi(w) < \infty$ para algún nodo $w$ entonces existe un recorrido $R$ que conecta $v$ con $w$ y $\pi(w) = \ell(R)$.
2. Si existe un camino mínimo entre $v$ y $w$ entonces $\pi(w) \geq dist(v, w)$.

**Lema 2:** Si $C$ es un camino entre $v$ y $w$ con $k$ aristas, entonces al finalizar la iteración $k$ del algoritmo de Ford, $\pi(w) \leq \ell(C)$.

**Corolario 1:** Al finalizar la iteración $k$ el algoritmo de Ford determina un camino mínimo entre $v$ y $w$ si existe un camino mínimo de $v$ a $w$ con a lo sumo $k$ aristas.

**Teorema:** Dado un grafo orientado $G$ sin ciclos de longitud negativa alcanzables desde $v$, el algoritmo de Ford determina un camino mínimo entre el nodo $v$ y cada nodo alcanzable desde $v$.

**Prueba:** Sin ciclos negativos, todo recorrido mínimo es un camino. Hay finita cantidad de caminos entre $v$ y $w$. Por Corolario 1, el algoritmo encuentra el camino mínimo en las primeras $n-1$ iteraciones (cualquier camino tiene a lo sumo $n-1$ aristas). $\square$

### Deteccion de ciclos negativos

**Corolario 2:** Si hubo cambio de $\pi$ hasta la iteración $n$ inclusive, entonces existe un ciclo de longitud negativa alcanzable desde $v$.

**Proposición 1:** Si existe un ciclo de longitud negativa alcanzable desde $v$, hay cambio de $\pi$ en toda iteración de la ejecución.

**Consecuencia práctica:** El algoritmo termina con exactamente $n-1$ iteraciones si no hay ciclos negativos. Si hay cambio en la iteración $n$, hay ciclo negativo.

## Algoritmos matriciales — Multiples origenes

Aplican a digrafos $G = (\{1, \ldots, n\}, X)$ con función de longitud $\ell: X \to \mathbb{R}$.

**Matriz $L \in \mathbb{R}^{n \times n}$:** elementos $\ell_{ij}$ definidos como:
$$\ell_{ij} = \begin{cases} 0 & \text{si } i = j \\ \ell(i \to j) & \text{si } i \to j \in X \\ \infty & \text{si } i \to j \notin X \end{cases}$$

**Matriz $D \in \mathbb{R}^{n \times n}$:** $d_{ij}$ = longitud del camino mínimo orientado de $i$ a $j$ (si existe, $\infty$ sino). Llamada **matriz de distancias**.

## Algoritmo de Floyd (1962) — Todos los pares, O(n³)

**Supuesto:** Grafo orientado sin ciclos de longitud negativa.

**Idea:** Programación dinámica. $\ell^k_{ij}$ = longitud del camino mínimo de $i$ a $j$ con nodos intermedios en $\{v_1, \ldots, v_k\}$.

$$\ell^k_{ij} = \min(\ell^{k-1}_{ij}, \ell^{k-1}_{ik} + \ell^{k-1}_{kj})$$

### Pseudocodigo

```
L0 := L
para k desde 1 a n hacer
  para i desde 1 a n hacer
    para j desde 1 a n hacer
      ℓ^k_ij := mín(ℓ^(k-1)_ij, ℓ^(k-1)_ik + ℓ^(k-1)_kj)
    fin para
  fin para
fin para
retornar Ln
```

**Lema:** Al finalizar la iteración $k$, $\ell_{ij}$ es la longitud de los caminos mínimos de $v_i$ a $v_j$ cuyos nodos intermedios están en $V_k = \{v_1, \ldots, v_k\}$, si no existe ciclo de longitud negativa con todos sus vértices en $V_k$.

**Teorema:** El algoritmo de Floyd determina los caminos mínimos entre todos los pares de nodos de un grafo orientado sin ciclos de longitud negativa.

**Complejidad:** $O(n^3)$ tiempo, $O(n^2)$ memoria.

### Deteccion de ciclos negativos (version modificada)

```
L0 := L
para k desde 1 a n hacer
  para i desde 1 a n hacer
    si ℓ^(k-1)_ik ≠ ∞ entonces
      si ℓ^(k-1)_ik + ℓ^(k-1)_ki < 0 entonces
        retornar "Hay ciclos negativos."
      fin si
      para j desde 1 a n hacer
        ℓ^k_ij := mín(ℓ^(k-1)_ij, ℓ^(k-1)_ik + ℓ^(k-1)_kj)
      fin para
    fin si
  fin para
fin para
retornar L
```

## Algoritmo de Dantzig (1966) — Todos los pares, O(n³)

**Idea:** Crece la matriz de distancias de $k \times k$ a $(k+1) \times (k+1)$ en cada iteración (trabaja sobre el subgrafo inducido por $\{v_1, \ldots, v_k\}$).

Calcula $L^{k+1}$ a partir de $L^k$ para $1 \leq i, j \leq k$:
$$L^{k+1}_{i,k+1} = \min_{1 \leq j \leq k} (L^k_{i,j} + L^k_{j,k+1})$$
$$L^{k+1}_{k+1,i} = \min_{1 \leq j \leq k} (L^k_{k+1,j} + L^k_{j,i})$$
$$L^{k+1}_{i,j} = \min(L^k_{i,j}, L^k_{i,k+1} + L^k_{k+1,j})$$

### Pseudocodigo

```
para k desde 1 a n − 1 hacer
  para i desde 1 a k hacer
    Li,k+1 := mín_{1≤j≤k} (Li,j + Lj,k+1)
    Lk+1,i := mín_{1≤j≤k} (Lk+1,j + Lj,i)
  fin para
  t := mín_{1≤i≤k} (Lk+1,i + Li,k+1)
  si t < 0 entonces
    retornar "Hay ciclos de longitud negativa"
  fin si
  para i desde 1 a k hacer
    para j desde 1 a k hacer
      Li,j := mín(Li,j, Li,k+1 + Lk+1,j)
    fin para
  fin para
fin para
retornar L
```

**Lema:** Al finalizar la iteración $k-1$, la matriz de $k \times k$ generada contiene la longitud de los caminos mínimos en el subgrafo inducido por $\{v_1, \ldots, v_k\}$ sin ciclos de longitud negativa.

**Teorema:** El algoritmo de Dantzig determina los caminos mínimos entre todos los pares de nodos de un grafo orientado sin ciclos de longitud negativa.

**Complejidad:** $O(n^3)$ — igual que Floyd pero con mejor constante en algunas implementaciones.

## Comparacion de algoritmos

| Algoritmo | Variante | Pesos negativos | Ciclos negativos | Complejidad |
|-----------|---------|----------------|-----------------|-------------|
| Dijkstra | 1 origen | No (falla) | — | $O(n^2)$ / $O(m + n\log n)$ |
| Bellman-Ford | 1 origen | Sí | Detecta | $O(nm)$ |
| Floyd | Todos pares | Sí | Detecta | $O(n^3)$ |
| Dantzig | Todos pares | Sí | Detecta | $O(n^3)$ |

## Formulas clave

Dijkstra — relajacion de aristas:
$$\pi(u) := \pi(w) + \ell(w, u) \quad \text{si mejora}$$

Floyd — recurrencia:
$$\ell^k_{ij} = \min(\ell^{k-1}_{ij},\ \ell^{k-1}_{ik} + \ell^{k-1}_{kj})$$

## Ver tambien

- [[grafos_teoria]] — definiciones base (digrafo, camino, distancia)
- [[arboles_teoria]] — BFS para caminos mínimos sin pesos
- [[flujo_en_redes_teoria]] — usa BFS/DFS sobre red residual
- [[programacion_dinamica_teoria]] — Floyd y Dantzig son PD
