---
nombre: Resumen General — Comunidad (Damy)
parcial: ambos
tipo: sintesis
tema: todos
fuente: raw/contenido_comunidad/1.comunidad_resumen_general.pdf
paginas_relacionadas:
  - "[[complejidad_computacional_teoria]]"
  - "[[divide_y_conquista_teoria]]"
  - "[[fuerza_bruta_backtracking_teoria]]"
  - "[[programacion_dinamica_teoria]]"
  - "[[greedy_teoria]]"
  - "[[grafos_teoria]]"
  - "[[arboles_teoria]]"
  - "[[arboles_generadores_minimos_teoria]]"
  - "[[caminos_minimos_teoria]]"
  - "[[flujo_en_redes_teoria]]"
---

> **Fuente:** Resumen estudiantil ("By Damy") — contenido_comunidad. Cubre todos los temas 1P y 2P en formato de repaso compacto. Util como segundo punto de vista. Para demostraciones formales y pseudocodigos completos, consultar las paginas `_teoria` y `_practica` correspondientes.

---

## Complejidad computacional

Ver [[complejidad_computacional_teoria]].

- **Problema:** descripcion de datos de entrada y respuesta a proveer. **Instancia:** juego valido de datos de entrada.
- **Modelo RAM:** memoria como sucesion de celdas de $b$ bits; programa imperativo no almacenado en memoria.
- **Costos:** acceso a celda, asignacion, estructuras de control y operaciones logicas: $O(1)$. Suma/resta: $O(b)$. Multiplicacion/division: $O(b \log b)$. Si $b$ fijo → todo $O(1)$.
- **Tiempo de ejecucion:** maximo de la suma de tiempos de instrucciones ejecutadas.
- Convencion: algoritmos polinomiales = satisfactorios. Supra-polinomiales = no satisfactorios.

**Notacion asintotica:**

$$f(n) = O(g(n)) \iff \exists\, c \in \mathbb{R}^+,\, n_0 \in \mathbb{N} : f(n) \leq c \cdot g(n)\quad \forall n \geq n_0$$

$f(n) = \Omega(g(n))$ analogamente con $\geq$. $f(n) = \Theta(g(n))$ si ambas.

**Problemas de optimizacion combinatoria:** $Z^* = \max f(x),\ x \in S$. La region factible $S$ esta definida por consideraciones combinatorias.

---

## Fuerza bruta y Backtracking

Ver [[fuerza_bruta_backtracking_teoria]] · [[fuerza_bruta_backtracking_practica]].

**Fuerza bruta:** genera todas las soluciones factibles, retiene la mejor. Simple de implementar, exacto, pero generalmente exponencial.

**Backtracking:** exploracion ordenada del espacio de soluciones mediante extension de soluciones parciales. Se visualiza como arbol; se aplican podas:
- **Poda por factibilidad:** descartar nodos no factibles.
- **Poda por optimalidad:** descartar nodos suboptimos.
- **Branch and bound:** usar la mejor solucion actual para decidir si explorar (backtracking + podas por optimalidad).

Representacion habitual: vector que se extiende en cada paso.

---

## Programacion Dinamica

Ver [[programacion_dinamica_teoria]] · [[programacion_dinamica_top_down_practica_pt1]] · [[programacion_dinamica_bottom_up_practica]].

Cuando hay **superposicion de subproblemas** (mismos parametros repetidos), conviene guardar resultados.

- **Top-down (memoizacion):** implementacion recursiva + estructura de datos para cachear. Permite reconstruir la solucion.
- **Bottom-up:** resolucion iterativa de todos los subproblemas menores. Generalmente menor uso de memoria; puede no permitir reconstruir la solucion.

Complejidad resultante: generalmente **pseudopolinomial** (acotada por polinomio en los valores numericos del input, no en la longitud).

---

## Divide & Conquer

Ver [[divide_y_conquista_teoria]] · [[divide_y_conquista_practica]].

Dividir en subproblemas del mismo tipo, resolver recursivamente, combinar.

**Teorema Maestro:** para $T(n) = aT(n/b) + \Theta(n^c)$:

| Caso | Condicion | Solucion |
|------|-----------|----------|
| 1 | $c < \log_b a$ | $\Theta(n^{\log_b a})$ |
| 2 | $c = \log_b a$ | $\Theta(n^c \log n)$ |
| 3 | $c > \log_b a$ | $\Theta(n^c)$ |

Ejemplos:
- $T(n) = 3T(n/2) + \Theta(n)$: Caso 1 → $\Theta(n^{\log_2 3})$
- $T(n) = 2T(n/2) + \Theta(n)$: Caso 2 → $\Theta(n \log n)$
- $T(n) = T(n/2) + \Theta(n)$: Caso 3 → $\Theta(n)$

---

## Algoritmos Golosos (Greedy)

Ver [[greedy_teoria]] · [[greedy_practica]].

**Heuristica:** procedimiento computacional que intenta obtener soluciones de buena calidad (cercanas al optimo).

**Greedy:** en cada paso selecciona la mejor alternativa local sin considerar (o casi sin considerar) implicancias futuras. Genera soluciones razonables (pero potencialmente suboptimas) en tiempo eficiente.

Un algoritmo $A$ es $\varepsilon$-aproximado si la solucion obtenida difiere del optimo en a lo sumo $\varepsilon$.

---

## Grafos

Ver [[grafos_teoria]] · [[grafos_practica]].

**Definiciones basicas:**
- $G = (V, X)$: $V$ vertices, $X \subseteq \binom{V}{2}$ (pares no ordenados).
- $n = |V|$, $m = |X|$.
- Multigrafo: multiples aristas entre un par. Pseudografo: multigrafo con loops.
- **Grado** $d(v)$: cantidad de aristas incidentes a $v$.
- $\Delta(G)$: maximo grado. $\delta(G)$: minimo grado.
- **Handshaking Lemma:** $\sum_{v \in V} d(v) = 2m$.
- **Corolario:** la cantidad de vertices de grado impar es par.

**Tipos especiales:**
- **Grafo completo** $K_n$: todos los pares adyacentes.
- **Complemento** $G^c$: mismos vertices, aristas complementarias.
- **Bipartito:** $V = V_1 \cup V_2$, $V_1 \cap V_2 = \emptyset$, aristas solo entre $V_1$ y $V_2$. **Teorema:** bipartito $\iff$ sin ciclos de longitud impar.
- **Grafo conexo:** camino entre todo par de vertices. **Componente conexa:** subgrafo conexo maximal.

**Recorridos:**
- **Recorrido:** secuencia alternada de vertices y aristas, vertices consecutivos adyacentes.
- **Camino:** recorrido sin repetir vertices.
- **Circuito/Ciclo:** recorrido/camino que empieza y termina en el mismo vertice ($\geq 3$ vertices en ciclo simple).
- **Distancia** $d(v,w)$: longitud del recorrido minimo. Si no existe: $\infty$. Propiedades: no negatividad, identidad, simetria, desigualdad triangular.

**Subgrafos:**
- Subgrafo propio: $H \subsetneq G$.
- Subgrafo generador: $H \subseteq G$ con $V_H = V_G$.
- Subgrafo inducido $G[V']$: contiene todas las aristas de $G$ entre vertices de $V'$.

**Isomorfismo:** $G \cong G'$ si existe biyeccion $f: V \to V'$ tal que $(v,w) \in X \iff (f(v),f(w)) \in X'$. Condiciones necesarias: mismos $n$, $m$, secuencia de grados, numero de componentes conexas, numero de caminos de longitud $k$. No son suficientes.

**Representacion:**
- **Matriz de adyacencia** $A \in \{0,1\}^{n \times n}$: $a_{ij}=1 \iff (v_i,v_j) \in X$. Suma de fila/columna $i$ = $d(v_i)$. Diagonal de $A^2$: $a_{ii}^2 = d(v_i)$.
- **Lista de adyacencia:** mas eficiente para grafos ralos.

**Digrafos:** $X \subseteq V \times V$ (pares ordenados). Grado de entrada $d_{in}(v)$, grado de salida $d_{out}(v)$. Fuertemente conexo: camino orientado entre todo par.

---

## Arboles

Ver [[arboles_teoria]].

**Definicion:** grafo conexo sin circuitos simples.

**Puente:** arista $e$ tal que $G-e$ tiene mas componentes conexas. **Punto de corte/articulacion:** vertice $v$ tal que $G-v$ tiene mas componentes conexas.

**Teorema de equivalencias (4 condiciones):** $G$ es arbol $\iff$
1. Conexo sin circuitos simples.
2. Sin circuitos, pero agregar cualquier arista crea exactamente un circuito simple.
3. Existe exactamente un camino entre todo par de nodos.
4. Conexo, pero quitar cualquier arista lo desconecta.

**Lemas y corolarios:**
- **Lema 1:** $e \in X$ es puente $\iff$ no pertenece a ningun circuito simple.
- **Lema 2:** todo arbol no trivial tiene al menos dos hojas.
- **Lema 3 (arbol):** $m = n - 1$.
- **Corolario 1 (sin ciclos, $c$ componentes):** $m = n - c$.
- **Corolario 2 ($c$ componentes):** $m \geq n - c$.

**Segundo teorema de equivalencias (3 condiciones):**
1. $G$ es arbol.
2. Sin circuitos simples y $m = n - 1$.
3. Conexo y $m = n - 1$.

**Arboles enraizados:** vertice distinguido = raiz. Nivel: distancia desde la raiz. Altura $h$: maximo nivel. $m$-ario: vertices internos con grado $\leq m+1$, raiz $\leq m$. Balanceado: hojas a nivel $h$ o $h-1$. Balanceado completo: hojas a nivel $h$.

---

## BFS y DFS

Ver [[arboles_teoria]] · [[recorrido_en_grafos_practica]].

**BFS:** recorre a lo ancho (nivel por nivel). Implementacion iterativa con cola. Complejidad: $O(n+m)$. Produce arbol $v$-geodesico; computa distancias exactas desde $v$.

**DFS:** recorre en profundidad (sigue rama hasta el final, luego retrocede). Implementacion recursiva (idea de backtracking). Complejidad: $O(n+m)$. Produce arbol DFS con timestamps `desde`/`hasta`. Clasifica aristas: tree/backward/forward/cross.

**Aplicaciones de DFS:**
- Deteccion de ciclos: $G$ tiene ciclo $\iff$ existe backward edge.
- Sort topologico: ordenar nodos por `hasta` decreciente.
- Componentes fuertemente conexas.
- Puntos de corte y aristas puente.

---

## Arboles Generadores Minimos (AGM)

Ver [[arboles_generadores_minimos_teoria]] · [[arboles_generadores_minimos_practica]].

Dado $G = (V,X)$ conexo con funcion de peso $\ell: X \to \mathbb{R}$, el **AGM** es el arbol generador de longitud minima $\sum_{e \in T} \ell(e)$.

### Algoritmo de Prim

Greedy: empieza en un nodo y agrega iterativamente la arista de menor peso que no genere ciclo conectando al conjunto actual.

**Proposicion:** en la iteracion $k$, $T_k$ (subgrafo con $k$ aristas) es subgrafo de algun AGM de $G$.

**Teorema:** Prim es correcto y determina un AGM.

**Complejidades:**
- $O(n^2)$ — implementacion estandar.
- $O((m+n)\log n)$ — con heap binario. Como generalmente $m \gg n$: $O(m \log n)$.
- $O(m + n \log n)$ — con heap Fibonacci.

### Algoritmo de Kruskal

Greedy: tomar siempre la arista de menor peso que no genere ciclo.

**Proposicion:** en la iteracion $k$, $B_k$ (bosque con $k$ aristas) es subgrafo generador sin ciclos de algun AGM.

**Teorema:** Kruskal es correcto y determina un AGM.

**Complejidades:**
- $O(mn)$ — implementacion trivial.
- $O(m \log n)$ — con Union-Find por rango.
- $O(m \log n + m\, \alpha(n))$ — Union-Find por rango + compresion de camino.

**Observacion:** el problema AGM se resuelve en $O(\min\{n^2,\ m \log n\})$. Para grafos densos ($m \approx n^2$) conviene $O(n^2)$.

---

## Caminos Minimos

Ver [[caminos_minimos_teoria]] · [[caminos_minimos_practica]].

**Longitud** de recorrido entre $u$ y $v$: suma de pesos de aristas. **Camino minimo**: recorrido minimo que no repite vertices. **Distancia** $d(u,v)$: longitud del camino minimo; $\infty$ si no existe.

**Propiedad (subestructura optima):** todo subcamino de un camino minimo es camino minimo.

**Tres variantes:** (1) unico origen–unico destino, (2) unico origen–multiples destinos, (3) todos pares.

**Condicion:** si el grafo tiene ciclos de peso negativo alcanzables desde $v$, el problema no esta bien definido.

### Dijkstra (variantes 1 y 2, pesos $\geq 0$)

Array $\pi$ de tamano $n$. Inicializar $\pi[v]=0$, $\pi[u]=\infty$ para $u \neq v$. Fijar iterativamente el vertice con $\pi$ minimo no fijado, relajar sus vecinos: $\pi[u] \leftarrow \min(\pi[u],\, \pi[w] + \ell(w,u))$.

**Lema:** al finalizar la iteracion $k$, Dijkstra determina el camino minimo entre $v$ y los nodos de $S_k$.

**Teorema:** correcto $\iff$ no hay aristas con peso negativo.

**Complejidades:** $O(n^2)$ estandar; $O(m \log n)$ con heap binario; $O(m + n \log n)$ con heap Fibonacci.

### Bellman-Ford / Ford (variante 2, permite pesos negativos)

Array $\pi$, inicializado igual que Dijkstra. Mantiene $\pi'$ (copia anterior). Mientras $\pi \neq \pi'$: para todo $u \neq v$ y $(w,u) \in X$: $\pi[u] \leftarrow \min(\pi[u],\, \pi[w] + \ell(w,u))$.

**Teorema:** correcto para grafos sin ciclos de longitud negativa alcanzables desde $v$.

**Complejidad:** $O(n \cdot m)$.

**Lema 1:** en todo momento, si $\pi(w) < \infty$ existe recorrido $v \leadsto w$ de longitud $\pi(w)$; si existe camino minimo entonces $\pi(w) \geq d(v,w)$.

**Lema 2:** si $C$ es camino $v \leadsto w$ con $k$ aristas, al finalizar la iteracion $k$: $\pi(w) \leq L(C)$.

**Corolario 1:** al finalizar la iteracion $k$, Ford determina el camino minimo $v \leadsto w$ si existe uno con a lo sumo $k$ aristas.

**Corolario 2:** si hubo cambio de $\pi$ hasta la iteracion $n$ inclusive, entonces existe ciclo de longitud negativa alcanzable desde $v$.

**Proposicion 1:** si existe ciclo de longitud negativa alcanzable desde $v$, hay cambio de $\pi$ en toda iteracion de Ford.

**Modificacion para detectar ciclos negativos:** pisar $\pi$ directamente (sin $\pi'$), con contador $i$ que corta en $i = n$. Si hay cambio en $\pi$ → ciclo de longitud negativa detectado. Complejidad: no cambia asintoticamente.

**Modificacion para arbol de caminos minimos:** mantener arreglo $\text{pred}$: $\text{pred}(u) \leftarrow w$ cada vez que $\pi(u)$ mejora via $w$.

**Modificacion para recuperar el ciclo negativo:** aplicar DFS sobre aristas $(\text{pred}(u), u)$. Si hay backward edge → localizado el ciclo. Si no: tomar arista $(\text{pred}(w), w)$ fuera del arbol, aplicar DFS con aristas invertidas → necesariamente hay backward edge → ciclo localizado.

**Proposicion 2:** $G$ tiene ciclo de longitud negativa alcanzable desde $v$ $\iff$ el subgrafo $G'$ con solo aristas $(\text{pred}(u), u)$ tiene un ciclo con al menos 2 aristas.

**Corolario 3:** sea $G^*$ = subgrafo de $G'$ con nodos alcanzables desde $v$. Tras aplicar la version completa de Ford:
1. $d(v,w) = \infty \iff \pi(w) = \infty$ ($w$ inalcanzable desde $v$).
2. $d(v,w) = -\infty$ (no existe recorrido minimo) $\iff \pi(w) < \infty$ y se cumple alguna de:
   - a. $\text{pred}(v)$ es un nodo de $G$.
   - b. $w$ es inalcanzable desde $v$ en $G^*$ (distintas componentes conexas del grafo subyacente de $G^*$).
   - c. $w$ es alcanzable en $G$ desde algun $u \neq w$ con $d(v,u) = -\infty$.

**Implementacion de Corolario 3:** $O(n)$ para caso trivial; $O(n)$ para DFS que computa T; $O(m+n)$ para hallar nodos de T alcanzables desde $G^* \setminus T$ via nodo fantasma $v^*$.

### Floyd (variante 3, todos pares)

$L^0 = L$ (pesos directos). Iteracion $k$:

$$\ell_{ij}^k = \min\!\left(\ell_{ij}^{k-1},\ \ell_{ik}^{k-1} + \ell_{kj}^{k-1}\right)$$

$D = L^n$. **Lema:** al finalizar iteracion $k$, $\ell_{ij}^k$ es la longitud del camino minimo de $v_i$ a $v_j$ cuyos nodos intermedios $\in \{v_1, \ldots, v_k\}$, si no hay ciclos negativos en ese subconjunto. **Teorema:** correcto en grafos sin ciclos negativos. Complejidad: $O(n^3)$ temporal, $O(n^2)$ espacial.

Deteccion de ciclo negativo: si $\ell_{ii}^n < 0$ para algun $i$.

> Nota: para detectar ciclos negativos en general, conviene Bellman-Ford con nodo fantasma conectado a todos con costo 0 (mas barato que Floyd completo).

### Dantzig (variante 3)

Crece la matriz de $k \times k$ a $(k+1) \times (k+1)$ en cada iteracion. Formulas de actualizacion para filas/columnas nuevas. **Lema:** al finalizar iteracion $k-1$, genera matriz de caminos minimos del subgrafo inducido por $\{v_1, \ldots, v_k\}$. Complejidad: $O(n^3)$ temporal, $O(n^2)$ espacial.

### Johnson (variante 3, grafos ralos con aristas potencialmente negativas)

Reponderacion: nodo fantasma $v^*$ con arco de peso 0 a todos los vertices. Correr Bellman-Ford → distancias $h(v)$ desde $v^*$. Nuevo peso:

$$w'(u,v) = w(u,v) + h(u) - h(v) \geq 0$$

Aplicar Dijkstra $n$ veces. Complejidad total: $O(nm \log n)$. Supera a $O(n^3)$ en grafos ralos.

**Comparacion algoritmos todos-pares:**

| Algoritmo | Complejidad | Restriccion |
|-----------|-------------|-------------|
| $n \times$ Dijkstra | $O(nm \log n)$ | sin aristas negativas |
| Johnson | $O(nm \log n)$ | sin ciclos negativos |
| Floyd | $O(n^3)$ | sin ciclos negativos |
| Dantzig | $O(n^3)$ | sin ciclos negativos |
| $n \times$ Bellman-Ford | $O(n^2 m)$ | sin ciclos negativos |

---

## Flujo en Redes

Ver [[flujo_en_redes_teoria]] · [[flujo_en_redes_practica]].

**Problema:** grafo dirigido $G = (N, A)$, nodos $s$ (origen) y $t$ (destino), capacidad $u: A \to \mathbb{R}_{\geq 0}$. Encontrar flujo $x: A \to \mathbb{R}_{\geq 0}$ de mayor valor posible.

**Restricciones:** $0 \leq x_{ij} \leq u_{ij}$ para todo arco; conservacion de flujo en nodos $\neq s, t$. **Valor del flujo** $F$: flujo neto que sale de $s$.

**Corte** $S \subseteq N \setminus \{t\}$ con $s \in S$. Definir $SC = \{ij \in A : i \in S,\, j \in C\}$.

**Proposicion:** $F = \sum_{ij \in \overrightarrow{SC}} x_{ij} - \sum_{ij \in \overrightarrow{CS}} x_{ij}$ (flujo neto que atraviesa el corte).

**Capacidad del corte** $S$: $u(S) = \sum_{ij \in \overrightarrow{SC}} u_{ij}$.

**Proposicion:** $F \leq u(S)$ para todo corte $S$.

**Corolario de optimalidad:** si $F = u(S)$ entonces $x$ es flujo maximo y $S$ es corte de capacidad minima.

**Red residual** $R(G,x) = (N, A_R)$: $ij \in A_R$ si $x_{ij} < u_{ij}$ (capacidad residual directa); $ji \in A_R$ si $x_{ij} > 0$ (capacidad residual inversa).

**Camino de aumento:** camino orientado de $s$ a $t$ en la red residual. Definir $\Delta(P) = \min_{ij \in P} \text{cap. residual}(ij)$.

**Proposicion:** dado camino de aumento $P$, el flujo aumentado $\bar{x}$ tiene valor $\bar{F} = F + \Delta(P)$ y es factible.

**Teorema Max-Flow Min-Cut:**
- $x$ es flujo maximo $\iff$ no existe camino de aumento en la red residual.
- Valor del flujo maximo = capacidad del corte minimo.

### Ford-Fulkerson

Buscar camino de aumento y aumentar el flujo iterativamente. Complejidad: $O(m \cdot n \cdot U)$ con $U$ = capacidad maxima; equivalentemente $O(m \cdot F)$ donde $F$ = valor del flujo maximo.

**Teorema de flujo entero:** si capacidades son enteras, existe flujo maximo entero.

**Advertencia:** si capacidades son irracionales, puede no terminar.

### Edmonds-Karp

Ford-Fulkerson con BFS para encontrar caminos de aumento (camino mas corto en numero de aristas). Complejidad: $O(n \cdot m^2)$; en la practica $O(\min\{nm^2, mF\})$.

### Matching maximo en grafos bipartitos

**Matching** $M \subseteq E$: cada vertice incidente a lo sumo a una arista de $M$. **Matching maximo:** de cardinal maximo.

Reduccion a flujo: agregar fuente $s$ con arco a cada vertice de $V_1$ (cap. 1), agregar sumidero $t$ con arco desde cada vertice de $V_2$ (cap. 1), arcos de $V_1$ a $V_2$ con cap. 1. Flujo maximo = matching maximo.

---

## Ver tambien

- [[sintesis/repaso_1P]] — clase de consultas previa al 1P
- [[sintesis/repaso_2P]] — clase de consultas 2do recuperatorio
