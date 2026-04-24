---
nombre: Grafos — Teoria
parcial: 2P
tipo: teoria
tema: grafos
fuente: raw/clases/teo/6.teo_2P_grafos.pdf
paginas_relacionadas:
  - "[[arboles_teoria]]"
  - "[[arboles_generadores_minimos_teoria]]"
  - "[[caminos_minimos_teoria]]"
  - "[[flujo_en_redes_teoria]]"
---

# Grafos — Teoria

## Concepto y definicion

Un **grafo** $G = (V, X)$ es un par de conjuntos, donde:
- $V$ es un conjunto de **vertices** (puntos, nodos).
- $X$ es un subconjunto del conjunto de pares no ordenados de elementos distintos de $V$.
- Los elementos de $X$ se llaman **aristas** (ejes).

**Notacion:** $n_G = |V|$ y $m_G = |X|$ (se omite el subindice cuando el grafo es claro del contexto).

### Terminologia basica

- Dados $v, w \in V$, si $e = (v, w) \in X$ se dice que $v$ y $w$ son **adyacentes** y que $e$ es **incidente** a $v$ y $w$.
- **Vecindad** de un vertice $v$: $N(v) = \{w \in V : (v, w) \in X\}$.

### Multigrafos y pseudografos

| Tipo | Aristas multiples | Loops |
|------|-------------------|-------|
| Grafo | No | No |
| Multigrafo | Si | No |
| Pseudografo | Si | Si |

En la materia, "grafo" asume sin aristas multiples ni loops (salvo que se aclare).

## Propiedades y teoremas

### Grado

- **Grado** de un vertice $v$: $d_G(v)$ = cantidad de aristas incidentes a $v$.
- $\Delta(G)$: grado maximo. $\delta(G)$: grado minimo.

**Teorema (Handshaking Lemma):**

$$\sum_{i=1}^{n} d(v_i) = 2m$$

**Corolario:** La cantidad de vertices con grado impar es par.

### Grafo completo

Un grafo es **completo** si todos los vertices son adyacentes entre si. Notacion: $K_n$.

Cantidad de aristas de $K_n$: $\binom{n}{2} = \frac{n(n-1)}{2}$.

### Grafo complemento

Dado $G = (V, X)$, su complemento $\bar{G} = (V, \bar{X})$ tiene los mismos vertices, y $(v,w) \in \bar{X} \iff (v,w) \notin X$.

Si $G$ tiene $n$ vertices y $m$ aristas, $\bar{G}$ tiene $\binom{n}{2} - m$ aristas.

## Recorridos, caminos, circuitos y ciclos

| Concepto | Definicion |
|----------|------------|
| **Recorrido** | Secuencia alternada de vertices y aristas $v_0 e_1 v_1 \ldots v_k$ donde cada $e_i$ conecta $v_{i-1}$ con $v_i$ |
| **Camino** | Recorrido que no pasa dos veces por el mismo vertice |
| **Seccion** de camino $P_{v_i v_j}$ | Subsecuencia de vertices consecutivos de $P$ entre $v_i$ y $v_j$ |
| **Circuito** | Recorrido que empieza y termina en el mismo vertice |
| **Ciclo** | Circuito de $\geq 3$ vertices que no repite vertices (circuito simple) |

En grafos (no multi ni pseudo), un recorrido queda definido solo por la secuencia de vertices.

## Distancia

- **Longitud** de un recorrido $P$: $l(P)$ = cantidad de aristas.
- **Distancia** entre $v$ y $w$: $d(v, w)$ = longitud del recorrido mas corto entre $v$ y $w$.
- Si no existe recorrido: $d(v, w) = \infty$. Para todo $v$: $d(v, v) = 0$.

**Proposicion:** Si un recorrido $P$ entre $v$ y $w$ tiene longitud $d(v, w)$, entonces $P$ es un camino.

**Proposicion (propiedades de distancia):** Para todo $u, v, w \in V$:
1. $d(u, v) \geq 0$ y $d(u, v) = 0 \iff u = v$.
2. $d(u, v) = d(v, u)$ (simetria).
3. $d(u, w) \leq d(u, v) + d(v, w)$ (desigualdad triangular).

## Subgrafos

| Tipo | Condicion |
|------|-----------|
| **Subgrafo** $H \subseteq G$ | $V_H \subseteq V_G$ y $X_H \subseteq X_G \cap (V_H \times V_H)$ |
| **Subgrafo propio** $H \subset G$ | $H \subseteq G$ y $H \neq G$ |
| **Subgrafo generador** | $H \subseteq G$ y $V_G = V_H$ (mismos vertices) |
| **Subgrafo inducido** $G[V']$ | Todo par $u, v \in V'$ con $(u,v) \in X_G$ tambien tiene $(u,v) \in X_H$ |

## Conexidad

- Un grafo es **conexo** si existe camino entre todo par de vertices.
- Una **componente conexa** es un subgrafo conexo maximal.

## Grafos bipartitos

Un grafo $G = (V, X)$ es **bipartito** si existen $V_1, V_2$ con $V = V_1 \cup V_2$, $V_1 \cap V_2 = \emptyset$, y toda arista tiene un extremo en $V_1$ y otro en $V_2$.

- **Bipartito completo** $K_{p,q}$: todo vertice en $V_1$ es adyacente a todo vertice en $V_2$.

**Teorema:** Un grafo $G$ es bipartito $\iff$ no tiene ciclos de longitud impar.

## Isomorfismo de grafos

Dados $G = (V, X)$ y $G' = (V', X')$, son **isomorfos** si existe una funcion biyectiva $f : V \to V'$ tal que:

$$(v, w) \in X \iff (f(v), f(w)) \in X'$$

**Condiciones necesarias** (pero NO suficientes) para isomorfismo:
- Mismo numero de vertices.
- Mismo numero de aristas.
- Para todo $k$: mismo numero de vertices de grado $k$.
- Mismo numero de componentes conexas.
- Para todo $k$: mismo numero de caminos de longitud $k$.

> No se conoce algoritmo polinomial para determinar isomorfismo de grafos en general.

## Representacion en la computadora

### Matriz de adyacencia

$A \in \{0, 1\}^{n \times n}$ donde:

$$a_{ij} = \begin{cases} 1 & \text{si } (v_i, v_j) \in X \\ 0 & \text{si no} \end{cases}$$

**Propiedades:**
- La suma de la fila (o columna) $i$ de $A$ es $d(v_i)$.
- Los elementos de la diagonal de $A^2$: $a_{ii}^2 = d(v_i)$.
- Espacio: $O(n^2)$. Util conceptual y teoricamente, pero ineficiente si el grafo es esparso (muchos ceros).

### Listas de adyacencia

Estructuras mas eficientes en espacio para grafos esparsos.

## Digrafos (grafos dirigidos)

Un **digrafo** $G = (V, X)$ es un par donde $X$ es un subconjunto de pares **ordenados** de elementos distintos de $V$. Los elementos de $X$ se llaman **arcos**.

- Dado un arco $e = (u, w)$: $u$ es la **cola** y $w$ es la **cabeza**.
- **Grado de entrada** $d_{in}(v)$: cantidad de arcos que llegan a $v$ (arcos con $v$ como cabeza).
- **Grado de salida** $d_{out}(v)$: cantidad de arcos que salen de $v$ (arcos con $v$ como cola).
- **Grafo subyacente** $G^s$: remover las direcciones de los arcos (si hay arcos en ambas direcciones entre un par, se coloca una sola arista).

### Matriz de adyacencia de digrafo

$$a_{ij} = \begin{cases} 1 & \text{si hay arco de } v_i \text{ a } v_j \\ 0 & \text{si no} \end{cases}$$

- Suma de fila $i$ = $d_{out}(v_i)$.
- Suma de columna $i$ = $d_{in}(v_i)$.
- **Nota:** la matriz NO es necesariamente simetrica (a diferencia de grafos no dirigidos).

### Recorridos y conexidad en digrafos

- **Camino orientado:** sucesion de arcos $e_1 e_2 \ldots e_k$ donde la cabeza de $e_i$ coincide con la cola de $e_{i+1}$.
- **Ciclo orientado:** camino orientado que empieza y termina en el mismo vertice.
- **Fuertemente conexo:** para todo par $u, v$ existen caminos orientados de $u$ a $v$ **y** de $v$ a $u$.

## Contexto historico

| Año | Evento |
|-----|--------|
| 1736 | Euler resuelve el problema de los puentes de Konigsberg |
| 1771 | Vandermonde estudia el problema del caballo de ajedrez |
| 1823 | Warnsdorff propone heuristica golosa para el caballo |
| 1857 | Hamilton presenta el juego icosiano (ciclos hamiltonianos) |
| 1871 | Hierholzer formaliza condicion suficiente para circuitos eulerianos |
| 1878 | Sylvester usa la palabra "grafo" por primera vez |
| 1852-1976 | Conjetura → Teorema de los cuatro colores (Appel y Haken, asistido por computadora) |

## Formulas clave

$$\sum_{i=1}^{n} d(v_i) = 2m \quad \text{(Handshaking Lemma)}$$

$$|X(K_n)| = \binom{n}{2} = \frac{n(n-1)}{2}$$

$$d(u, w) \leq d(u, v) + d(v, w) \quad \text{(desigualdad triangular)}$$

$$\text{Bipartito} \iff \text{no tiene ciclos de longitud impar}$$

## Ver tambien

- [[arboles_teoria]] — caso particular de grafos conexos sin ciclos
- [[arboles_generadores_minimos_teoria]] — subgrafos generadores de peso minimo
- [[caminos_minimos_teoria]] — algoritmos sobre distancia ponderada en grafos
- [[flujo_en_redes_teoria]] — digrafos con capacidades
