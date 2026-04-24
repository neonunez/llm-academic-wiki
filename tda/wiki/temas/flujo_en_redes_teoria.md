---
nombre: Flujo en Redes — Teoria
parcial: 2P
tipo: teoria
tema: flujo_en_redes
fuente: raw/clases/teo/11.teo_2P_flujo_en_redes.pdf
paginas_relacionadas:
  - "[[grafos_teoria]]"
  - "[[arboles_teoria]]"
  - "[[caminos_minimos_teoria]]"
---

## Concepto y definicion

**Datos de entrada del problema de flujo máximo:**
1. Un grafo dirigido $G = (N, A)$.
2. Nodos $s, t \in N$ de **origen** (fuente) y **destino** (sumidero).
3. Una función de **capacidad** $u: A \to \mathbb{Z}^+$ asociada con los arcos.

**Problema:** Encontrar un flujo (cantidad a enviar por cada arco) entre $s$ y $t$ de mayor valor posible.

**Restricciones de un flujo factible:**
1. **Conservación:** Salvo $s$ y $t$, en cada nodo la cantidad de flujo que entra es igual a la que sale.
2. **Capacidad:** La cantidad $x_{ij}$ enviada por el arco $ij \in A$ debe cumplir $0 \leq x_{ij} \leq u_{ij}$.
3. **Valor:** El valor de un flujo $F$ es la cantidad de flujo neto que sale de $s$.

## Propiedades y teoremas

### Corte y su capacidad

**Corte:** Un corte en la red $G = (N, A)$ es un subconjunto $S \subseteq N \setminus \{t\}$ tal que $s \in S$.

**Notación:** Dados $S, T \subseteq N$, definimos $ST = \{ij \in A : i \in S \text{ y } j \in T\}$.

**Capacidad de un corte $S$:**
$$u(S) = \sum_{ij \in S\bar{S}} u_{ij}$$
donde $\bar{S} = N \setminus S$.

### Proposicion: valor de flujo = flujo neto a través de cualquier corte

**Proposición:** Sea $x$ un flujo definido en una red $G = (N, A)$ y sea $S$ un corte. Entonces:
$$F = \sum_{ij \in S\bar{S}} x_{ij} - \sum_{ij \in \bar{S}S} x_{ij}$$

**Prueba:** Claramente vale para $S = \{s\}$ (por definición de valor de flujo). Para un corte $S$ arbitrario, tomar $S' = S \setminus \{s\}$. Como $N$ es unión disjunta de $\{s\}$, $S'$ y $\bar{S}$, y por la ley de conservación en cada nodo de $S'$, la igualdad se mantiene. $\square$

### Cota superior y certificado de optimalidad

**Proposición:** Si $x$ es un flujo con valor $F$ y $S$ es un corte en $N$, entonces:
$$F \leq u(S)$$

**Corolario (certificado de optimalidad):** Si $F$ es el valor de un flujo $x$ y $S$ un corte en $G$ tal que $F = u(S)$, entonces $x$ define un **flujo máximo** y $S$ un **corte de capacidad mínima**.

## Red residual y camino de aumento

**Red residual** $R(G, x) = (N, A_R)$ dado un flujo factible $x$:
1. $ij \in A_R$ si $x_{ij} < u_{ij}$ (arco directo con capacidad residual).
2. $ji \in A_R$ si $x_{ij} > 0$ (arco inverso para cancelar flujo).

**Camino de aumento:** Un camino orientado de $s$ a $t$ en $R(G, x)$.

**Capacidad de aumento** sobre camino $P$: Para cada arco $ij \in P$:
$$\Delta(ij) = \begin{cases} u_{ij} - x_{ij} & \text{si } ij \in A \\ x_{ji} & \text{si } ji \in A \end{cases}$$
$$\Delta(P) = \min_{ij \in P} \{\Delta(ij)\}$$

Se puede encontrar un camino de aumento en $O(m)$ y calcular $\Delta(P)$ en $O(n)$.

### Actualizacion del flujo

**Proposición:** Sea $x$ un flujo con valor $F$ y $P$ un camino de aumento en $R(G, x)$. Entonces el flujo $\bar{x}$, definido por:
$$\bar{x}(ij) = \begin{cases} x_{ij} & \text{si } ij \notin P \wedge ji \notin P \\ x_{ij} + \Delta(P) & \text{si } ij \in P \\ x_{ij} - \Delta(P) & \text{si } ji \in P \end{cases}$$
es un flujo factible sobre $N$ con valor $\bar{F} = F + \Delta(P)$.

### Teorema fundamental

**Teorema:** Sea $x$ un flujo definido sobre una red $N$. Entonces:
$$x \text{ es flujo máximo} \Longleftrightarrow \text{no existe camino de aumento en } R(G, x)$$

**Teorema (max flow - min cut):** Dada una red $N$:
$$\text{valor del flujo máximo} = \text{capacidad del corte mínimo}$$

## Algoritmo de Ford y Fulkerson (1956)

### Pseudocodigo

```
Definir un flujo inicial en N (por ejemplo, x = 0)
mientras exista P := camino de aumento en R(G, x) hacer
  para cada arco ij ∈ P hacer
    si ij ∈ A entonces
      xij := xij + Δ(P)
    sino (ji ∈ A)
      xji := xji − Δ(P)
    fin si
  fin para
fin mientras
```

### Correctitud y complejidad

**Teorema:** Si las capacidades de los arcos de la red son enteras, entonces el problema de flujo máximo tiene un flujo máximo **entero**.

**Teorema:** Si los valores del flujo inicial y las capacidades son enteras, el método de Ford y Fulkerson realiza a lo sumo $nU$ iteraciones, donde $U$ es cota superior de las capacidades. **Complejidad:** $O(nmU)$.

**Advertencia:** Si las capacidades o el flujo inicial son números **irracionales**, el método de Ford y Fulkerson puede no terminar (infinito número de pasos).

### Algoritmo de Edmonds y Karp (1972)

**Modificación:** Usar **BFS** para buscar caminos de aumento (camino de menor número de aristas).

**Complejidad:** $O(nm^2)$ — independiente de las capacidades.

## Matching maximo en grafos bipartitos

**Matching:** Un conjunto $M \subseteq E$ de aristas de $G$ tal que para todo $v \in V$, $v$ es incidente a lo sumo a una arista de $M$.

**Problema:** Encontrar un matching de cardinal máximo.

**Reducción a flujo máximo:** Dado el grafo bipartito $G = (V_1 \cup V_2, E)$, definir la red $N = (V', E')$:
- $V' = V_1 \cup V_2 \cup \{s, t\}$ (fuente y sumidero ficticios).
- $E' = \{(i, j) : i \in V_1, j \in V_2, ij \in E\} \cup \{(s, i) : i \in V_1\} \cup \{(j, t) : j \in V_2\}$.
- $u_{ij} = 1$ para todo $ij \in E$.

**Resultado:** El cardinal del matching máximo de $G$ = valor del flujo máximo en la red $N$.

Resoluble en tiempo polinomial para grafos en general (Edmonds, 1961–1965). Para bipartitos, la reducción a flujo es más simple.

## Formulas clave

Valor del flujo:
$$F = \sum_{ij \in S\bar{S}} x_{ij} - \sum_{ij \in \bar{S}S} x_{ij} \quad \forall \text{ corte } S$$

Cota:
$$F \leq u(S) = \sum_{ij \in S\bar{S}} u_{ij}$$

Teorema max-flow min-cut:
$$\max F = \min_S u(S)$$

Complejidades:
- Ford-Fulkerson: $O(nmU)$
- Edmonds-Karp: $O(nm^2)$

## Ver tambien

- [[grafos_teoria]] — digrafos, definiciones base
- [[arboles_teoria]] — BFS y DFS (usados en Edmonds-Karp y Ford-Fulkerson)
- [[caminos_minimos_teoria]] — caminos en grafos orientados
