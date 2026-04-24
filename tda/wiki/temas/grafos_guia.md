---
nombre: Grafos — Guia de Ejercicios (Teoria Algoritmica)
parcial: ambos
tipo: guia
tema: grafos
fuente: raw/guias_practicas/3.guia_1P_teoria_algoritmica_de_grafos.pdf
paginas_relacionadas:
  - "[[grafos_teoria]]"
  - "[[grafos_practica]]"
  - "[[definiciones_y_demostraciones_teoria]]"
---

# Grafos — Guia de Ejercicios (Teoria Algoritmica)

Practica 3: Introduccion a la teoria algoritmica de grafos. 1er cuatrimestre 2024. Compilado: 1 oct. 2025.

**Nota:** esta guia esta numerada como "1P" en el nombre de archivo pero cubre contenido de grafos (tema 2P) y demostraciones (tema 1P). `parcial: ambos`. Los ejercicios con ⋆ son el subconjunto minimo recomendado para cubrir el temario evaluado en parciales.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 ⋆ | EquilibrioDigrafo — induccion en m: $\sum d_{out} = \sum d_{in} = |E|$ | 🔴 Si |
| Ej. 2 ⋆ | DobleGrado — absurdo: todo grafo no trivial tiene 2 vertices del mismo grado | 🔴 Si |
| Ej. 3 ⋆ | UnicidadDigrafo — construccion: existe un unico grafo orientado con todos grados de salida distintos | ⚪ No |
| Ej. 4 | ArteConexo — n vertices, mas de $(n-1)(n-2)/2$ aristas → conexo; biconexo con 2 mas | ⚪ No |
| Ej. 5 ⋆ | CicloCompartido — dos caminos distintos de v a w → hay un ciclo con aristas de P o Q | 🔴 Si |
| Ej. 6 | ModeladoBasico — en todo grupo de 2+ personas, 2 tienen la misma cantidad de amigos | 🔴 Si |
| Ej. 7 ⋆ | InterseccionMaxima — dos caminos simples de longitud maxima tienen un vertice en comun | ⚪ No |
| Ej. 8 | UnionVsJunta — G es union ↔ G es disconexo; G es junta ↔ complemento es disconexo | ⚪ No |
| Ej. 9 | UnicidadDeGrados — $G_n$ tiene un unico par de vertices del mismo grado | ⚪ No |
| Ej. 10 | TrianguloInductivo — grafo de $2n$ vertices con $> n^2$ aristas tiene un triangulo | ⚪ No |
| Ej. 11 | CicloImpar — caminata cerrada de longitud impar → existe ciclo simple impar | 🔴 Si |
| Ej. 12 | BipartitOCiclo — G-v bipartito para todo v ↔ G es bipartito o ciclo impar | 🔴 Si |
| Ej. 13 | GrafoConexoDosNoArticulacion — todo grafo conexo $G_n$ ($n \geq 2$) tiene 2 vertices no-articulacion | 🔴 Si |
| Ej. 14 ⋆ | RepresentaGrafos — ventajas/desventajas de lista adyacencia, lista con info dinamica, matriz, hash | 🔴 Si |
| Ej. 15 ⋆ | AdyacenciaEficiente — construir lista de adyacencia en O(n+m) | ⚪ No |
| Ej. 16 | GemelosyMellizos — partition refinement: particionar V en mellizos/gemelos en O(n+m) | ⚪ No |
| Ej. 17 ⋆ | CazadorDeCiclos — detectar ciclos en digrafo, O(n+m); orden topologico como caso negativo | 🔴 Si |
| Ej. 18 | TrianguloGrafo — 3 algoritmos para detectar triangulos: O(n³), O(nm), O(m^{3/2}) | ⚪ No |
| Ej. 19 | UmbralDeGrafos — grafos threshold: propiedades, descomposicion threshold, isomorfismo | ⚪ No |
| Ej. 20 | AristasUnicas — aristas v→w tales que w→v no es arista, O(n+m) | ⚪ No |
| Ej. 21 | CiclosRho — digrafos con forma de ρ (grado de salida 1): unico ciclo por comp. conexa; actividades periodicas | ⚪ No |
| Ej. 22 | GeoCuadrados — camino geodesico ≥ 4 aristas → G² completo (dificil) | ⚪ No |

## Patrones de este tema en parciales

> Demo por absurdo · Demo constructiva · Handshaking Lemma · Representacion de grafos · Deteccion de ciclos · Caminata impar → ciclo impar

## Ejercicios

### Ejercicio 1 ⋆ — EquilibrioDigrafo

**Enunciado**

Demostrar, usando induccion en la cantidad de aristas, que todo digrafo $D$ satisface:
$$\sum_{v \in V(D)} d_{in}(v) = \sum_{v \in V(D)} d_{out}(v) = |E(D)|$$

**Explicacion**

Induccion en $m = |E(D)|$. Caso base $m=0$: todos los grados son 0. Paso inductivo: agregar una arista $u \to v$ aumenta $d_{out}(u)$ y $d_{in}(v)$ en 1, y $|E|$ en 1. Generaliza el Handshaking Lemma a digrafos.

**Resolucion paso a paso**

*Induccion en $m = |E(D)|$:*

**Base ($m = 0$):** No hay arcos. Todo vértice tiene $d_{in}(v) = d_{out}(v) = 0$. Entonces $\sum d_{in}(v) = \sum d_{out}(v) = 0 = |E(D)|$. ✓

**Paso inductivo:** Sea $D$ un digrafo con $m+1$ arcos ($m \geq 0$). Tomar cualquier arco $e = (u, v)$ y definir $D' = D \setminus \{e\}$ (que tiene $m$ arcos).

Por HI aplicada a $D'$: $\sum_{w \in V} d_{out}^{D'}(w) = \sum_{w \in V} d_{in}^{D'}(w) = m$.

Al agregar el arco $e = (u, v)$:
- $d_{out}^D(u) = d_{out}^{D'}(u) + 1$
- $d_{in}^D(v) = d_{in}^{D'}(v) + 1$
- Para todo $w \neq u$: $d_{out}^D(w) = d_{out}^{D'}(w)$
- Para todo $w \neq v$: $d_{in}^D(w) = d_{in}^{D'}(w)$

Por lo tanto:
$$\sum_{w \in V} d_{out}^D(w) = \sum_{w \in V} d_{out}^{D'}(w) + 1 = m + 1 = |E(D)|$$
$$\sum_{w \in V} d_{in}^D(w) = \sum_{w \in V} d_{in}^{D'}(w) + 1 = m + 1 = |E(D)| \quad \blacksquare$$

**Chuleta**
> Inducción en $m$. Base: $m=0$, todo grado 0. Paso: tomar arco $e=(u,v)$, retirar → $D'$ con $m$ arcos, por HI $\sum d_{out}' = \sum d_{in}' = m$. Agregar $e$: sube $d_{out}(u)$ y $d_{in}(v)$ en 1 → ambas sumas $= m+1 = |E(D)|$.

**¿Aparece en parciales?** 🔴 Si — demos sobre grados de digrafos son evaluadas

---

### Ejercicio 2 ⋆ — DobleGrado

**Enunciado**

Demostrar, usando reduccion al absurdo, que todo grafo no trivial tiene al menos dos vertices del mismo grado.

Hint: prestar atencion a la secuencia ordenada de los grados.

**Explicacion**

Si todos los $n$ vertices tuvieran grados distintos y los grados estan en $[0, n-1]$, entonces los grados serian exactamente $\{0, 1, \ldots, n-1\}$. Pero no puede haber simultaneamente un vertice de grado 0 (aislado) y uno de grado $n-1$ (adyacente a todos) → contradiccion. Este ejercicio aparece en [[grafos_practica]] con principio del palomar.

**Resolucion paso a paso**

*Por reducción al absurdo:*

Sea $G$ un grafo de $n \geq 2$ vértices. Suponer que todos los vértices tienen grados distintos.

Los grados son enteros no negativos y el grado de cada vértice está en $\{0, 1, \ldots, n-1\}$ (como máximo adyacente a todos los demás). Si los $n$ grados son todos distintos y los valores posibles son exactamente $n$ enteros en $\{0, \ldots, n-1\}$, entonces los grados deben ser exactamente $\{0, 1, 2, \ldots, n-1\}$.

Pero esto es imposible: si hay un vértice $v$ con $d(v) = 0$ (aislado, sin vecinos), y un vértice $u$ con $d(u) = n-1$ (adyacente a todos los demás vértices incluyendo $v$), entonces $u$ es adyacente a $v$. Pero $v$ tiene grado 0 y no puede ser adyacente a ningún vértice. **Contradicción.** $\blacksquare$

**Chuleta**
> Absurdo: suponer $n$ grados distintos → deben ser $\{0, 1, \ldots, n-1\}$ (únicos $n$ valores posibles). Pero grado 0 (aislado) y grado $n-1$ (adyacente a todos) no pueden coexistir → contradicción.

**¿Aparece en parciales?** 🔴 Si — aparece en [[grafos_practica]] y en examen 2P_2C_2025

---

### Ejercicio 3 ⋆ — UnicidadDigrafo

**Enunciado**

Un grafo orientado es un digrafo $D$ tal que al menos uno de $v \to w$ y $w \to v$ no es arista, para todo $v, w$. Demostrar en forma constructiva que para cada $n$ existe un unico grafo orientado cuyos vertices tienen todos grados de salida distintos.

Hint: aprovechar el ejercicio anterior y observar que el absurdo no se produce para un unico grafo orientado.

**Explicacion**

Construccion por induccion: el grafo orientado unico es el torneo transitivo (los vertices $v_0, v_1, \ldots, v_{n-1}$ tienen $d_{out}(v_i) = i$). El grafo orientado con $d_{out} \in \{0, 1, \ldots, n-1\}$ es unico: orientar las aristas del grafo completo $K_n$ segun el orden de los vertices.

**Resolucion paso a paso**

*Existencia:* Construir el **torneo transitivo** de $n$ vértices: sean $v_0, v_1, \ldots, v_{n-1}$ y orientar $v_i \to v_j$ si $i < j$ (para todo $i \neq j$). Entonces:
$$d_{out}(v_i) = |\{j : j > i\}| = n - 1 - i$$

Reasignando, los grados de salida son $\{0, 1, \ldots, n-1\}$, todos distintos. Es un grafo orientado (para cada par solo hay un arco). ✓

*Unicidad:* Sea $D$ cualquier grafo orientado con todos los grados de salida distintos.

Los grados de salida son enteros en $\{0, 1, \ldots, n-1\}$. En un grafo orientado sobre $n$ vértices, para cada par $(v_i, v_j)$ exactamente uno de $v_i \to v_j$ o $v_j \to v_i$ puede existir. La suma $d_{out}(v_i) + d_{out}(v_j) \leq n-1$ para todo par (a lo sumo $n-1$ arcos salen entre ellos y hacia los demás). 

Si los grados de salida son $\{0, 1, \ldots, n-1\}$, entonces $\sum d_{out}(v_k) = \binom{n}{2}$. Como cada par contribuye exactamente un arco, el digrafo es un **torneo** (grafo completo orientado). 

En un torneo con grados de salida distintos: el vértice de $d_{out} = n-1$ gana contra todos. El de $d_{out} = n-2$ gana contra todos excepto el anterior. Por inducción, el orden de los grados de salida determina unívocamente el ganador de cada par → el torneo es único (isomorfo al torneo transitivo). $\blacksquare$

**Chuleta**
> Existencia: torneo transitivo $v_i \to v_j$ si $i < j$ → $d_{out}(v_i) = n-1-i$, grados $\{0,...,n-1\}$. Unicidad: grados distintos $\{0,...,n-1\}$ → torneo completo → el orden de los grados determina unívocamente cada arco → único.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — ArteConexo

**Enunciado**

a) Demostrar que todo grafo de $n$ vertices con mas de $\frac{(n-1)(n-2)}{2}$ aristas es conexo. (Por induccion o contrarreciproco.)

b) Demostrar que todo grafo de $n$ vertices con al menos $2 + \frac{(n-1)(n-2)}{2}$ aristas es biconexo. (Por absurdo.)

c) ¿Se pueden dar cotas mejores a partir de algun $n_0$?

**Explicacion**

a) Contrarreciproco: si G es disconexo, tiene al menos dos componentes. La maxima cantidad de aristas en un grafo disconexo de $n$ vertices es $\binom{n-1}{2} = \frac{(n-1)(n-2)}{2}$ (un componente de $n-1$ vertices completo + 1 aislado).

b) Biconexo requiere conexidad + sin puntos de articulacion. 2 aristas adicionales garantizan que no hay punto de articulacion.

**Resolucion paso a paso**

**Parte a) Más de $(n-1)(n-2)/2$ aristas → conexo (contrarrecíproco)**

El contrarrecíproco: si $G$ es disconexo, tiene $m \leq \frac{(n-1)(n-2)}{2}$.

*Demostración:* Si $G$ es disconexo, tiene al menos 2 componentes conexas. Sea la partición de vértices en dos grupos: uno de $k$ vértices y otro de $n-k$ (con $1 \leq k \leq n-1$). El número de aristas es a lo sumo $\binom{k}{2} + \binom{n-k}{2}$ (sin aristas entre grupos). Este valor se maximiza cuando $k=1$ (o $k=n-1$):
$$\binom{n-1}{2} + \binom{1}{2} = \frac{(n-1)(n-2)}{2} + 0 = \frac{(n-1)(n-2)}{2}$$

Por lo tanto, si $m > \frac{(n-1)(n-2)}{2}$, el grafo no puede ser disconexo → es conexo. $\blacksquare$

**Parte b) Al menos $2 + (n-1)(n-2)/2$ aristas → biconexo (por absurdo)**

Suponer $G$ tiene $m \geq 2 + \frac{(n-1)(n-2)}{2}$ aristas pero no es biconexo. Por parte a), $G$ es conexo. Como no es biconexo, tiene algún punto de articulación $v$: al quitar $v$, $G \setminus \{v\}$ tiene $\geq 2$ componentes. Sean $C_1$ y $C_2$ dos componentes con $n_1$ y $n_2$ vértices respectivamente ($n_1 + n_2 \leq n-1$, ya que $v$ fue quitado).

El número máximo de aristas: las aristas en $C_1 \cup \{v\}$ más las aristas en $C_2$ (o viceversa, maximizando en ambas):
$$m \leq \binom{n_1 + 1}{2} + \binom{n_2}{2} \leq \binom{n-1}{2} + \binom{1}{2} + 1 = \frac{(n-1)(n-2)}{2} + 1$$

⚠️ Verificar — la cota exacta para biconexo requiere un argumento más cuidadoso sobre la distribución de vértices entre componentes. La idea es que al tener un punto de articulación, la cota máxima de aristas cae por debajo de $2 + (n-1)(n-2)/2$.

**Parte c) ¿Cotas mejores?**

Para $n$ grande, el teorema de Turán da cotas más finas para grafos sin $K_k$. Para conexidad, la cota es exacta: para todo $n$, el grafo $K_{n-1} \cup K_1$ tiene exactamente $(n-1)(n-2)/2$ aristas y es disconexo.

**Chuleta**
> a) Contrarrecíproco: disconexo ↔ se puede separar en $k$ y $n-k$ vértices sin aristas entre ellos. Máx: $K_{n-1} + K_1 = (n-1)(n-2)/2$ aristas. Si $m > (n-1)(n-2)/2$ → conexo.
> b) Biconexo: absurdo + punto de articulación → máximo de aristas cae por debajo del umbral.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 ⋆ — CicloCompartido

**Enunciado**

Sean $P$ y $Q$ dos caminos distintos de un grafo $G$ que unen un vertice $v$ con otro $w$. Demostrar en forma directa que $G$ tiene un ciclo cuyas aristas pertenecen a $P$ o $Q$.

Hint: denotar $P = v_0, \ldots, v_p$ y $Q = w_0, \ldots, w_q$ con $v_0 = w_0 = v$ y $v_p = w_q = w$. Definir explicitamente cuales subcaminos de $P$ y $Q$ forman el ciclo.

**Explicacion**

Construccion directa: sea $i$ el maximo indice tal que $v_i = w_j$ para algun $j$ antes de que los caminos se separen definitivamente. Entonces el subcamino de $P$ desde $v_i$ hasta $v_p$ y el subcamino de $Q$ desde $w_j$ hasta $w_q$ (en reverso) forman un ciclo. Este ejercicio aparece en [[grafos_practica]].

**Resolucion paso a paso**

*Construccion directa:*

Sean $P = v_0, v_1, \ldots, v_p$ y $Q = w_0, w_1, \ldots, w_q$ con $v_0 = w_0 = v$ y $v_p = w_q = w$. Los caminos son distintos (difieren en al menos una arista).

**Paso 1 — Encontrar el primer punto de divergencia:**

Sea $i$ el mayor índice tal que $v_i = w_j$ para algún $j$, y a partir de $v_{i+1}$ los caminos no vuelven a encontrarse en ningún vértice (es decir, $\{v_{i+1}, \ldots, v_p\} \cap \{w_{j+1}, \ldots, w_q\} = \emptyset$). 

Más precisamente: sea $i$ el mayor índice tal que $v_i \in V(Q)$. Sea $j$ el índice con $w_j = v_i$.

**Paso 2 — Construir el ciclo:**

El subcamino $P_{v_i, v_p}$ (de $v_i$ a $v_p = w$ por $P$) y el subcamino $Q_{w_j, w_q}$ (de $w_j = v_i$ a $w_q = w$ por $Q$) tienen:
- El mismo extremo inicial: $v_i = w_j$
- El mismo extremo final: $v_p = w_q = w$
- Vértices internos disjuntos (por elección de $i$ como el último punto de encuentro)

Concatenar: $P_{v_i, v_p}$ seguido de la inversión de $Q_{w_j, w_q}$ forma un ciclo (circuito simple) cuyas aristas pertenecen a $P$ o $Q$. $\blacksquare$

**Ejemplo de verificación:** si $P = a,b,c,d$ y $Q = a,e,f,d$ (dos caminos de $a$ a $d$). El último vértice común es $a$ (si los caminos divergen inmediatamente) o podría ser $d$ si convergen antes. Si los vértices intermedios son disjuntos: ciclo $a,b,c,d,f,e,a$ (usando $P$ de $a$ a $d$ luego $Q$ al revés).

**Chuleta**
> 1. Identificar el último vértice $v_i = w_j$ en común antes de la separación final de $P$ y $Q$.
> 2. Ciclo = subcamino de $P$ desde $v_i$ hasta $w$ + subcamino de $Q$ desde $w$ hasta $v_i$ (en reverso).
> 3. Vértices internos disjuntos por construcción → ciclo simple. Aristas de $P \cup Q$.

**¿Aparece en parciales?** 🔴 Si — CicloCompartido aparece en [[grafos_practica]] y es evaluado

---

### Ejercicio 6 — ModeladoBasico (Misma Cantidad de Amigos)

**Enunciado**

Probar que en todo grupo de dos o mas personas hay por lo menos dos de ellas que tienen la misma cantidad de amigos en el grupo.

**Explicacion**

Equivalente al Ejercicio 2 (DobleGrado): modelar como grafo de $n \geq 2$ vertices, usar principio del palomar. Este ejercicio aparece en [[grafos_practica]].

**Resolucion paso a paso**

*Modelado + principio del palomar:*

Modelar: definir el grafo $G$ de $n \geq 2$ vértices (personas), con arista $(u,v)$ si $u$ y $v$ son amigos. El número de amigos de la persona $i$ es $d(v_i) \in \{0, 1, \ldots, n-1\}$.

Suponer por absurdo que todos tienen distinto número de amigos. Entonces los $n$ grados son $n$ valores distintos en $\{0, 1, \ldots, n-1\}$ → deben ser exactamente $\{0, 1, \ldots, n-1\}$.

Pero si hay una persona de grado 0 (sin amigos), y otra de grado $n-1$ (amiga de todos), entonces la persona de grado $n-1$ es amiga de la persona de grado 0 → la persona de grado 0 tiene al menos un amigo → contradicción con grado 0.

Por lo tanto, los $n$ grados no pueden ser todos distintos → por principio del palomar, al menos dos personas tienen la misma cantidad de amigos. $\blacksquare$

**Chuleta**
> Mismo argumento que Ej. 2 aplicado al contexto social. Principio del palomar: $n$ personas, grados en $\{0,...,n-1\}$ pero grado 0 y $n-1$ no coexisten → solo $n-1$ valores posibles → dos personas con igual grado.

**¿Aparece en parciales?** 🔴 Si — aparece en [[grafos_practica]] como demostracion sobre grafos

---

### Ejercicio 7 ⋆ — InterseccionMaxima

**Enunciado**

Sea $G$ un grafo conexo. Demostrar por el contrarreciproco que todo par de caminos simples de longitud maxima de $G$ tienen un vertice en comun.

Hint: suponer que hay dos caminos disjuntos en vertices de igual longitud y definir explicitamente un camino que sea mas largo que ellos.

**Explicacion**

Contrarreciproco: si existieran dos caminos $P$ y $Q$ de longitud maxima $l$ con $V(P) \cap V(Q) = \emptyset$, como $G$ es conexo hay un camino de algun vertice de $P$ a algun vertice de $Q$. Concatenando se obtiene un camino de longitud $> l$ (si el camino de union tiene algun vertice no en $P$ o $Q$, se puede extender por $P$ y $Q$) → contradiccion.

**Resolucion paso a paso**

*Por contrarrecíproco:* suponer que existen dos caminos simples $P$ y $Q$ de longitud máxima $l$ con $V(P) \cap V(Q) = \emptyset$.

Como $G$ es conexo, existe un camino de algún vértice $p \in V(P)$ a algún vértice $q \in V(Q)$. Sea $R$ ese camino, con longitud $|R| \geq 1$. Podemos elegir $p$ y $q$ como el primer vértice de $V(P)$ y el primer de $V(Q)$ alcanzado por $R$ respectivamente, de modo que el interior de $R$ es ajeno a $V(P) \cup V(Q)$.

Construir un camino más largo: tomar el extremo de $P$ más alejado de $p$ (distancia $\geq \lceil l/2 \rceil$ de $p$ dentro de $P$), recorrer $P$ hasta $p$, luego $R$ hasta $q$, luego $Q$ hasta el extremo más alejado de $q$ (distancia $\geq \lceil l/2 \rceil$ de $q$ dentro de $Q$).

Longitud total:
$$\text{longitud} \geq \left\lceil \frac{l}{2} \right\rceil + |R| + \left\lceil \frac{l}{2} \right\rceil \geq l + 1 > l$$

Esto contradice que $l$ es la longitud máxima de un camino simple en $G$. $\blacksquare$

**Chuleta**
> Contrarrecíproco: suponer $P$ y $Q$ disjuntos de longitud máxima $l$. Por conexidad, existe camino $R$ entre algún $p \in P$ y $q \in Q$. Camino nuevo = mitad de $P$ + $R$ + mitad de $Q$ tiene longitud $\geq \lceil l/2 \rceil + 1 + \lceil l/2 \rceil \geq l+1$ → contradicción.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 8 — UnionVsJunta

**Enunciado**

La union disjunta $G \cup H$ (con $V(G) \cap V(H) = \emptyset$) y la junta $G + H$ (union mas todas las aristas entre $V(G)$ y $V(H)$).

a) Demostrar que $G$ es un grafo union $\Leftrightarrow$ $G$ es disconexo.
b) Demostrar que $G$ es un grafo junta $\Leftrightarrow$ $\overline{G}$ (complemento) es un grafo union.
c) Concluir: $G$ es junta $\Leftrightarrow$ $\overline{G}$ es disconexo.

**Explicacion**

a) $(\Rightarrow)$: por definicion de union, no hay aristas entre $G_1$ y $G_2$. $(\Leftarrow)$: las componentes conexas son los grafos de la union. b) El complemento de la junta es la union de los complementos. c) Combina a) y b).

**Resolucion paso a paso**

**Parte a) $G$ es union ↔ $G$ es disconexo**

$(\Rightarrow)$: Si $G = G_1 \cup G_2$ (union disjunta con $V(G_1) \cap V(G_2) = \emptyset$), no hay aristas entre $V(G_1)$ y $V(G_2)$. No existe camino de ningún vértice de $G_1$ a ninguno de $G_2$ → $G$ es disconexo.

$(\Leftarrow)$: Si $G$ es disconexo, sea $C_1$ la componente conexa de algún vértice $v$ y $C_2$ = el resto (union de las demás componentes). Entonces $G = C_1 \cup C_2$ (union disjunta sin aristas entre ellas). ✓

**Parte b) $G$ es junta ↔ $\overline{G}$ es union**

$(\Rightarrow)$: Si $G = G_1 + G_2$ (junta), entonces en $G$ existen todas las aristas entre $V(G_1)$ y $V(G_2)$. En $\overline{G}$ no existen aristas entre $V(G_1)$ y $V(G_2)$. Dentro de cada conjunto, $\overline{G}$ tiene las aristas que $G$ no tiene en $G[V(G_1)]$ y $G[V(G_2)]$ respectivamente. Entonces $\overline{G} = \overline{G_1} \cup \overline{G_2}$ (union disjunta sin aristas entre $V(G_1)$ y $V(G_2)$).

$(\Leftarrow)$: Si $\overline{G} = H_1 \cup H_2$ con $V(H_1) \cap V(H_2) = \emptyset$, entonces en $\overline{G}$ no hay aristas entre $V(H_1)$ y $V(H_2)$. Por complemento: en $G$ existen todas las aristas entre $V(H_1)$ y $V(H_2)$ → $G = G[V(H_1)] + G[V(H_2)]$ (junta).

**Parte c) $G$ es junta ↔ $\overline{G}$ es disconexo**

Por composición: $G$ es junta $\overset{(b)}{\Leftrightarrow}$ $\overline{G}$ es union $\overset{(a)}{\Leftrightarrow}$ $\overline{G}$ es disconexo. $\blacksquare$

**Chuleta**
> a) Union ↔ disconexo: ida directa (sin aristas entre partes), vuelta (tomar componente + resto).
> b) Junta ↔ complemento es union: complementar invierte "todas las aristas entre partes" ↔ "ninguna arista entre partes".
> c) Junta ↔ complemento disconexo: por a) y b).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 9 — UnicidadDeGrados

**Enunciado**

Sean $G_2 = K_2$ y $G_{n+1} = G_n \cup K_1$ para todo $n \geq 2$. Demostrar por induccion que $G_n$ tiene un unico par de vertices del mismo grado.

**Explicacion**

$G_n$ tiene un vertice aislado (de grado 0) que se fue anadiendo, y los demas tienen grados $1, 2, \ldots, n-2$, excepto que hay dos vertices de grado 1 (los extremos de $K_2$ inicial). Induccion en $n$: al agregar $K_1$, el nuevo vertice tiene grado 0 y habia exactamente un par de grado igual antes.

**Resolucion paso a paso**

⚠️ Verificar — la construcción "$G_{n+1} = G_n \cup K_1$" (unión disjunta) produciría la secuencia de grados $\{1,1\}, \{0,1,1\}, \{0,0,1,1\}, \ldots$ que tiene dos pares de igual grado para $n \geq 4$. La explicación del enunciado sugiere que la secuencia de grados de $G_n$ es $(0, 1, 1, 2, 3, \ldots, n-2)$ (un único par de grado 1). Esto solo es consistente si la operación "$\cup K_1$" conecta el nuevo vértice a algún vértice específico de $G_n$, no como unión disjunta pura.

**Prueba para los casos $n=2$ y $n=3$ (que sí funcionan con unión disjunta):**

*Base ($n=2$):* $G_2 = K_2$ tiene grados $\{1, 1\}$. Exactamente un par de igual grado. ✓

*Caso $n=3$:* $G_3 = G_2 \cup K_1$ agrega un vértice aislado. Grados $\{0, 1, 1\}$. El grado 0 es único; el par de grado 1 es el único par. ✓

**Idea clave para el paso inductivo (asumiendo la secuencia correcta):**

Si $G_n$ tiene secuencia de grados $(0, 1, 1, 2, 3, \ldots, n-2)$ con exactamente un par de igual grado (los dos vértices de grado 1), al agregar un nuevo vértice que adquiere un grado no presente en la secuencia actual, se mantiene la unicidad del par. La inducción funciona siempre que:
1. El nuevo vértice tenga grado que no crea nuevos pares (o absorbe el par existente de forma controlada).
2. Los grados previos (todos únicos excepto el par de grado 1) no se dupliquen.

**Chuleta**
> ⚠️ Verificar construcción. Idea: secuencia de grados $(0, 1, 1, 2, \ldots, n-2)$ tiene exactamente un par (grado 1). Al extender, el nuevo vértice toma un grado fresco → unicidad se mantiene por inducción.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 10 — TrianguloInductivo

**Enunciado**

Demostrar por induccion que todo grafo de $2n$ vertices con mas de $n^2$ aristas tiene algun triangulo.

¿Se puede dar una cota mejor a partir de algun $n_0$?

**Explicacion**

Induccion en $n$. Caso base $n=1$: grafo de 2 vertices con $> 1$ arista no puede existir (maximo 1 arista entre 2 vertices). Paso inductivo: si ningun vertice tiene grado $> n$, el numero de aristas es $\leq n \cdot 2n/2 = n^2$ (Handshaking), contradiccion. Si hay un vertice $v$ de grado $> n$, tomar sus vecinos: si dos de ellos son adyacentes se tiene un triangulo; si no, quitar $v$ y proceder con el subgrafo.

**Resolucion paso a paso**

*Induccion en $n$:*

**Base ($n=1$):** $G$ tiene 2 vértices. $m > 1$ pero hay a lo sumo 1 arista entre 2 vértices (grafo simple) → no existe tal $G$ → afirmación vacuamente verdadera. ✓

**Paso inductivo:** Suponer válido para grafos de $2n$ vértices. Sea $G$ de $2(n+1)$ vértices con $m > (n+1)^2$.

*Caso 1: algún vértice $v$ tiene grado $d(v) > n+1$.*

$v$ tiene $\geq n+2$ vecinos. Si dos de ellos son adyacentes → triángulo. ✓

Si ningún par de vecinos es adyacente (son independientes): los $d(v) \geq n+2$ vecinos no se conectan entre sí, y tampoco forman triángulo con $v$ por sí solos. El número de aristas restantes en $G \setminus \{v\}$ es $m - d(v) > (n+1)^2 - (n+2) = n^2 + n - 1 > n^2$. El subgrafo $G \setminus \{v\}$ tiene $2n+1$ vértices (impar) pero más de $n^2$ aristas → aplicar Turán directamente.

*Caso 2: todos los vértices tienen grado $\leq n+1$.*

$\sum d(v_i) \leq (n+1)(2n+2) = 2(n+1)^2 \Rightarrow m \leq (n+1)^2$ → contradicción con $m > (n+1)^2$.

**Entonces siempre existe $v$ con $d(v) > n+1$**, y si sus vecinos no forman triángulo entre sí, hay suficientes aristas para aplicar Turán al subgrafo restante. $\blacksquare$

**Alternativa (Turán directamente):** Un grafo de $N$ vértices sin triángulo tiene $\leq \lfloor N^2/4 \rfloor$ aristas. Para $N = 2n$: $\lfloor (2n)^2/4 \rfloor = n^2$. Si $m > n^2$ → hay triángulo. $\blacksquare$

**¿Se puede dar una cota mejor?** El grafo bipartito completo $K_{n,n}$ tiene exactamente $n^2$ aristas y no tiene triángulo (es bipartito). La cota es exacta: $m > n^2$ es suficiente y necesaria para garantizar un triángulo en todo grafo de $2n$ vértices.

**Chuleta**
> Argumento Turán: grafo sin $K_3$ de $2n$ vértices tiene $\leq n^2$ aristas. Si $m > n^2$ → triángulo existe.
> Argumento directo: si todo grado $\leq n$ → $m \leq n^2$ (Handshaking) → contradicción. Existe $v$ con $d(v) > n$; si sus vecinos tienen alguna arista entre sí → triángulo.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 11 — CicloImpar

**Enunciado**

Dado un grafo $G$, si existe una caminata de longitud impar que empieza y termina en el mismo vertice, entonces hay un ciclo (simple) impar.

**Explicacion**

Demostracion por induccion en la longitud $l$ de la caminata. Si la caminata no repite vertices, ya es un ciclo simple impar. Si repite algun vertice $v$, se puede partir en dos caminatas cerradas mas cortas (en $v$); al menos una de ellas tiene longitud impar. Por HI, esa caminata mas corta tiene un ciclo simple impar. Este ejercicio aparece en [[grafos_practica]] con demostracion completa.

**Resolucion paso a paso**

*Induccion en la longitud $l$ de la caminata cerrada:*

Sea $W = v_0, e_1, v_1, e_2, \ldots, e_l, v_l = v_0$ una caminata cerrada de longitud impar $l$.

**Base ($l = 3$, el ciclo impar más corto):** Si $W$ no repite vértices (excepto $v_0 = v_l$), es un ciclo simple de longitud 3 (impar). ✓

**Paso inductivo:** Asumir válido para toda caminata cerrada de longitud impar $< l$. Sea $W$ de longitud impar $l \geq 5$.

*Caso A: $W$ no repite vértices (excepto inicio = fin).* $W$ es directamente un ciclo simple impar. ✓

*Caso B: $W$ repite algún vértice.* Existe $v_i = v_j$ con $0 \leq i < j \leq l$ y $(i,j) \neq (0,l)$.

Descomponer $W$ en dos caminatas cerradas:
- $W_1 = v_i, e_{i+1}, v_{i+1}, \ldots, e_j, v_j = v_i$ de longitud $l_1 = j - i$
- $W_2 = v_0, \ldots, v_i, v_{j+1}, \ldots, v_l = v_0$ de longitud $l_2 = l - l_1$

Como $l_1 + l_2 = l$ (impar), exactamente una de $l_1, l_2$ es impar. Ambas son estrictamente menores que $l$ (ya que $1 \leq l_1 < l$ y $1 \leq l_2 < l$).

Por HI aplicada a la caminata de longitud impar menor: existe un ciclo simple impar. $\blacksquare$

**Chuleta**
> Inducción en $l$. Base: $l=3$, ciclo simple. Paso: si $W$ repite vértice $v_i = v_j$, partir en dos caminatas cerradas de longitudes $l_1 = j-i$ y $l_2 = l-l_1$. Como $l_1+l_2=l$ impar, una es impar. Aplicar HI a la más corta.

**¿Aparece en parciales?** 🔴 Si — aparece en [[grafos_practica]] y es tema 2P

---

### Ejercicio 12 — BipartitOCiclo

**Enunciado**

Sea $G$ un grafo de $n$ vertices. Demostrar que $G - v$ es bipartito para todo $v \in V(G)$ si y solo si $G$ es bipartito o un ciclo impar.

(La ida por contrarreciproco, la vuelta en forma directa.)

**Explicacion**

$(\Rightarrow)$ Contrarreciproco: si $G$ no es bipartito ni ciclo impar, existe un ciclo impar de longitud $\geq 5$, y al quitar cualquier vertice del ciclo el resto sigue teniendo un ciclo impar mas corto → no todos los $G-v$ son bipartitos.

$(\Leftarrow)$ Directo: si $G$ es bipartito, $G-v$ tambien lo es (subgrafo de bipartito). Si $G$ es ciclo impar de $n$ vertices, $G-v$ es un camino de $n-1$ vertices que es bipartito.

**Resolucion paso a paso**

**($\Leftarrow$) Directo:**

- Si $G$ es bipartito: para cualquier $v$, $G - v$ es un subgrafo inducido de $G$ → subgrafo de bipartito → bipartito (bipartito se hereda a subgrafos). ✓

- Si $G$ es un ciclo impar $C_{2k+1}$ de $n = 2k+1$ vértices: $G - v$ elimina un vértice del ciclo → $G-v$ es un camino de $2k$ vértices. Todo camino es bipartito (alternar colores: rojo, azul, rojo, ...). ✓

**($\Rightarrow$) Contrarrecíproco:**

Suponer $G$ no es bipartito y $G$ no es ciclo impar. Hay que encontrar algún $v$ tal que $G - v$ no sea bipartito.

*Paso 1:* Como $G$ no es bipartito → $G$ tiene al menos un ciclo impar $C$. Sea $|V(C)| = 2k+1 \geq 3$.

*Paso 2:* Como $G$ no es ciclo impar, hay alguna estructura adicional. Dos subcasos:

**Subcaso A: $|V(G)| > 2k+1$.** Existe $w \notin V(C)$. Quitar $w$: $G - w$ aún contiene $C$ (ciclo impar) → $G - w$ no es bipartito. ✓ (tomamos $v = w$).

**Subcaso B: $|V(G)| = 2k+1$ pero $G$ tiene aristas adicionales a las de $C$.** Existe una cuerda $e = (u_i, u_j)$ del ciclo. La cuerda divide $C$ en dos subciclos de longitudes $a = |i-j|+1$ y $b = (2k+1-|i-j|)+1$. Como $a + b = 2k+3$ (impar), uno de $a, b$ es par y otro impar. El subciclo de longitud impar es un ciclo impar más corto $C'$. Quitar cualquier vértice $v$ que esté en $C$ pero no en $C'$: $G-v$ aún contiene $C'$ → $G-v$ no es bipartito. ✓

En ambos subcasos existe $v$ tal que $G-v$ no es bipartito → contrarrecíproco demostrado. $\blacksquare$

**Chuleta**
> ($\Leftarrow$): bipartito → subgrafos bipartitos; ciclo impar → quitando vértice queda camino (bipartito).
> ($\Rightarrow$) Contrarrecíproco: $G$ no bipartito y no ciclo impar → tiene ciclo impar $C$ más algo extra (vértice fuera de $C$ o cuerda). En ambos casos, quitar el "algo extra" deja un ciclo impar en $G-v$.

**¿Aparece en parciales?** 🔴 Si — bipartito y ciclo impar son temas evaluados en 2P

---

### Ejercicio 13 — GrafoConexoDosNoArticulacion

**Enunciado**

Todo $G_n$ ($n \geq 2$) conexo tiene al menos dos vertices distintos $v_1, v_2$ tal que $G \setminus \{v_1\}$ y $G \setminus \{v_2\}$ son conexos.

**Explicacion**

Los extremos de cualquier camino de longitud maxima (diametro) no pueden ser puntos de articulacion. Alternativamente: por DFS, las hojas del arbol DFS no son puntos de articulacion. Como todo DFS de un grafo conexo genera al menos 2 hojas, existen al menos 2 vertices no-articulacion. Este ejercicio aparece en [[grafos_practica]] con demostracion por induccion en $n$.

**Resolucion paso a paso**

*Via DFS:*

**Claim: las hojas del árbol DFS de un grafo conexo no son puntos de articulación.**

Sea $v$ una hoja del árbol DFS (no tiene hijos en el árbol DFS). Quitar $v$: para todo par de vértices $u, w \neq v$, existe un camino entre ellos en $G - v$. ¿Por qué? En el DFS, todo vértice fue descubierto a través del árbol DFS sin pasar por $v$ (ya que $v$ es hoja, no descubrió ningún vértice). Los arcos de retroceso (backward edges) desde $v$ van hacia sus ancestros, pero esos ancestros ya estaban conectados al resto del grafo sin necesidad de $v$. Formalmente: si existiera un componente $C$ de $G-v$ que no llega al padre de $v$, habría un vértice $u \in C$ que fue descubierto por DFS sin pasar por $v$... contradicción con $v$ siendo hoja (no descubrió a nadie).

Por lo tanto $v$ no es punto de articulación. ✓

**Todo árbol con $n \geq 2$ vértices tiene $\geq 2$ hojas:**

En un árbol, la suma de los grados es $2(n-1)$. Si hubiera a lo sumo 1 hoja (vértice de grado 1), todos los demás tendrían grado $\geq 2$: $\sum d \geq 2(n-1) + 1 = 2n-1 > 2(n-1)$ → contradicción. ✓

**Conclusión:** El árbol DFS de $G$ tiene $\geq 2$ hojas → $G$ tiene $\geq 2$ vértices que no son puntos de articulación. $\blacksquare$

*(Prueba alternativa de [[grafos_practica]]: por inducción en $n$. La demostración completa aparece allí.)*

**Chuleta**
> DFS sobre $G$ conexo → árbol DFS. Las hojas del árbol DFS no son articulación (no descubren a nadie; si $v$ fuera articulación, habría un componente sin camino al padre, contradicción). Todo árbol con $\geq 2$ vértices tiene $\geq 2$ hojas → $\geq 2$ no-articulaciones.

**¿Aparece en parciales?** 🔴 Si — vertices no-articulacion aparece en [[grafos_practica]]

---

### Ejercicio 14 ⋆ — RepresentaGrafos

**Enunciado**

Discutir ventajas y desventajas en complejidad temporal y espacial de las siguientes representaciones del vecindario $N(v)$ de un grafo $G$, para las operaciones: inicializar, chequear adyacencia, recorrer $N(v)$, insertar vertice/arista, remover vertice/arista, mantener orden de $N(v)$.

a) Lista de adyacencias (lista de listas).
b) Lista de adyacencias con indice inverso (para operaciones dinamicas).
c) Matriz de adyacencias.
d) Lista de adyacencias con tabla de hash.

**Explicacion**

Tabla resumen:
| Operacion | Lista | Lista+inv | Matriz | Hash |
|-----------|-------|-----------|--------|------|
| Inicializar | O(n+m) | O(n+m) | O(n²) | O(n+m) |
| Adyacencia? | O(d(v)) | O(d(v)) | O(1) | O(1) amortizado |
| Recorrer N(v) | O(d(v)) | O(d(v)) | O(n) | O(d(v)) |
| Insertar arista | O(1) | O(1) | O(1) | O(1) amortizado |
| Remover arista | O(d(v)) | O(1) | O(1) | O(1) amortizado |

Este ejercicio aparece en [[grafos_practica]] (Parte A).

**Resolucion paso a paso**

Tabla completa de complejidades por operación y representación:

| Operación | Lista de adj. | Lista + índice inverso | Matriz $n \times n$ | Hash |
|-----------|---------------|------------------------|---------------------|------|
| **Inicializar** | $O(n+m)$ | $O(n+m)$ | $O(n^2)$ | $O(n+m)$ |
| **Adyacencia $u$-$v$?** | $O(d(u))$ | $O(d(u))$ | $O(1)$ | $O(1)$ amort. |
| **Recorrer $N(v)$** | $O(d(v))$ | $O(d(v))$ | $O(n)$ | $O(d(v))$ |
| **Insertar arista** | $O(1)$ | $O(1)$ | $O(1)$ | $O(1)$ amort. |
| **Remover arista** | $O(d(v))$ | $O(1)$ | $O(1)$ | $O(1)$ amort. |
| **Mantener orden $N(v)$** | Si (lista) | Si | No aplica | No (hash desordenado) |
| **Espacio** | $O(n+m)$ | $O(n+m)$ | $O(n^2)$ | $O(n+m)$ |

**Justificaciones clave:**

- *Lista:* Remover arista $O(d(v))$ porque hay que buscarla linealmente en la lista.
- *Lista + índice inverso:* Cada arista tiene un puntero al nodo en la lista del otro extremo → remoción $O(1)$.
- *Matriz:* Adyacencia y remoción $O(1)$; recorrer $N(v)$ requiere escanear toda la fila → $O(n)$.
- *Hash:* Operaciones $O(1)$ amortizado; sin garantía de orden.

**Trade-offs:**
- Grafos densos ($m \approx n^2$): matriz conveniente (buena localidad de caché, adyacencia $O(1)$).
- Grafos esparsos ($m \ll n^2$): lista o hash (espacio $O(n+m)$ vs $O(n^2)$).
- Muchas actualizaciones dinámicas: lista + índice inverso.

**Chuleta**
> Lista: espacio $O(n+m)$, adyacencia $O(d(v))$, recorrer $O(d(v))$. Matriz: espacio $O(n^2)$, adyacencia $O(1)$, recorrer $O(n)$. Hash: espacio $O(n+m)$, operaciones $O(1)$ amort., no mantiene orden. Lista+inv: remoción $O(1)$.

**¿Aparece en parciales?** 🔴 Si — representacion de grafos es tema evaluado en 2P

---

### Ejercicio 15 ⋆ — AdyacenciaEficiente

**Enunciado**

Demostrar que las representaciones por listas de adyacencias de un grafo se pueden construir en $O(n+m)$ tiempo. ¿Que ocurre con tabla de hash? ¿Y con matriz de adyacencias?

**Explicacion**

Lista de adyacencias: para cada arista $uv$, agregar $v$ a $N(u)$ y $u$ a $N(v)$ → $O(m)$ total. Con tabla de hash: $O(m)$ amortizado. Con matriz: $O(n^2)$ para inicializar la matriz (independientemente de $m$).

**Resolucion paso a paso**

**Lista de adyacencias:** $O(n+m)$

```
Para cada vértice v: inicializar lista vacía   → O(n) total
Para cada arista (u,v): 
  agregar v a N(u)                              → O(1) por arista
  agregar u a N(v)                              → O(1) por arista
Total: O(n) + 2 × O(m) = O(n+m)
```

**Con tabla de hash:** $O(n+m)$ amortizado

Misma lógica, con hash set por vértice. Cada inserción $O(1)$ amortizado → $O(n+m)$ total.

**Con matriz de adyacencias:** $O(n^2)$

Inicializar la matriz $n \times n$ con ceros requiere $O(n^2)$ operaciones, independientemente de $m$. Incluso si $m = 0$, el costo inicial es $O(n^2)$.

**Conclusión:** La lista de adyacencias (y hash) es $O(n+m)$ óptima para la inicialización. La matriz paga $O(n^2)$ siempre.

**Chuleta**
> Lista/hash: $O(n)$ inicializar + $O(1)$ por arista = $O(n+m)$. Matriz: $O(n^2)$ para llenar la tabla de ceros (aunque $m = 0$).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 16 — GemelosyMellizos

**Enunciado**

Dos vertices $u, v$ son gemelos cuando $N(u) = N(v)$ y mellizos cuando $N[u] = N[v]$ (vecindario cerrado). 

a) Observar que gemelos y mellizos son relaciones de equivalencia.
b) Demostrar por invariante que el siguiente algoritmo de partition refinement encuentra la particion en mellizos: inicializar $P_0 = \{V(G)\}$; para $i$ desde 1 hasta $n$: $P_i = \{W \cap N[v_i] \mid W \in P_{i-1}\} \cup \{W \setminus N[v_i] \mid W \in P_{i-1}\}$.
c) Describir la implementacion con complejidad $O(n+m)$.
d) Modificar para encontrar la particion en gemelos.

**Explicacion**

El invariante es: luego del paso $i$, $u$ y $w$ pertenecen al mismo conjunto de $P_i$ si y solo si $N[u] \cap \{v_1, \ldots, v_i\} = N[w] \cap \{v_1, \ldots, v_i\}$. La implementacion con linked lists y bitmask permite $O(n+m)$.

**Resolucion paso a paso**

**Parte a) Gemelos y mellizos son relaciones de equivalencia**

Para mellizos ($N[u] = N[v]$):
- *Reflexividad:* $N[v] = N[v]$. ✓
- *Simetría:* $N[u] = N[v] \Rightarrow N[v] = N[u]$. ✓
- *Transitividad:* $N[u] = N[v]$ y $N[v] = N[w]$ → $N[u] = N[w]$. ✓

Análogamente para gemelos con vecindario abierto $N(v)$.

**Parte b) Invariante del partition refinement para mellizos**

*Invariante:* tras el paso $i$, $u$ y $w$ pertenecen al mismo bloque de $P_i$ ↔ $N[u] \cap \{v_1, \ldots, v_i\} = N[w] \cap \{v_1, \ldots, v_i\}$.

*Prueba por inducción en $i$:*
- *Base ($i=0$):* $P_0 = \{V\}$, todos en el mismo bloque. $N[u] \cap \emptyset = \emptyset$ para todo $u$. ✓
- *Paso:* El refinamiento en el paso $i+1$ separa $u$ y $w$ si y solo si $v_{i+1} \in N[u]$ y $v_{i+1} \notin N[w]$ (o viceversa). Esto agrega la información de $v_{i+1}$ al invariante. ✓

Al final del paso $n$, el invariante es $N[u] \cap V = N[u] = N[w]$ → la partición final agrupa exactamente los mellizos.

**Parte c) Implementación $O(n+m)$**

```
P ← {V}   (bloque único inicial)
Para i = 1..n:
  Para cada bloque B en P:
    B_in  ← B ∩ N[v_i]
    B_out ← B \ N[v_i]
    si B_in ≠ ∅ y B_out ≠ ∅:
      reemplazar B por B_in y B_out
```

Con listas enlazadas y bitmask de pertenencia a $N[v_i]$: el paso $i$ procesa $|N[v_i]|$ elementos. Total: $\sum_{i=1}^{n} |N[v_i]| = \sum_{i=1}^{n} (d(v_i) + 1) = 2m + n = O(n+m)$.

**Parte d) Gemelos**

Reemplazar $N[v]$ por $N(v)$ (vecindario abierto) en la definición. El algoritmo es idéntico con la modificación de que en el paso $i$, se usa $N(v_i)$ (sin incluir $v_i$ mismo).

**Chuleta**
> Invariante: mismo bloque ↔ mismo $N[u] \cap \{v_1,...,v_i\}$. Implementación: para cada $v_i$, partir cada bloque por intersección con $N[v_i]$. Coste: $\sum |N[v_i]| = O(n+m)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 17 ⋆ — CazadorDeCiclos

**Enunciado**

Disenar un algoritmo para encontrar ciclos en un digrafo.

a) Demostrar constructivamente: si todos los vertices de un digrafo $D$ tienen $d_{out} > 0$, entonces $D$ tiene un ciclo.
b) Disenar un algoritmo que encuentre un ciclo en un digrafo donde todos los $d_{out} > 0$.
c) Implementacion con complejidad $O(n+m)$.
d) Demostrar: $D$ es aciclico $\Leftrightarrow$ $D$ es trivial o tiene un vertice con $d_{out}(v) = 0$ tal que $D \setminus \{v\}$ es aciclico.
e) Algoritmo que determine si $D$ tiene ciclos. Si no, retornar una lista $v_1, \ldots, v_n$ con $d_{out}(v_i) = 0$ en $D \setminus \{v_1, \ldots, v_{i-1}\}$. Si si, retornar un ciclo.
f) Implementacion en $O(n+m)$.

**Explicacion**

a) Construccion: si $d_{out} > 0$ para todo $v$, seguir arcos hasta repetir un vertice → ciclo. b-c) DFS con estados (no visitado, en proceso, terminado): ciclo ↔ arco hacia "en proceso". e) El orden topologico inverso es $v_1, \ldots, v_n$ con $d_{out}(v_i) = 0$ en el grafo con los anteriores eliminados. Equivale a Kahn (BFS topologico). Este ejercicio aparece en [[recorrido_en_grafos_practica]].

**Resolucion paso a paso**

**Parte a) Construcción: $d_{out}(v) > 0$ para todo $v$ → existe ciclo**

Desde cualquier $v_0$, seguir arcos: $v_0 \to v_1 \to v_2 \to \ldots$ Cada vértice tiene $d_{out} \geq 1$ → siempre hay un arco para seguir. Como hay $n$ vértices finitos, en a lo sumo $n$ pasos se repite un vértice: $v_i = v_j$ con $i < j$. La secuencia $v_i, v_{i+1}, \ldots, v_j = v_i$ es un ciclo dirigido. $\blacksquare$

**Parte b) Algoritmo para encontrar ciclo (cuando todo $d_{out} > 0$)**

Seguir arcos desde un vértice inicial hasta repetir (máximo $n+1$ pasos). La traza da el ciclo.

**Parte c) Implementación $O(n+m)$**

DFS con 3 estados: `BLANCO` (no visitado), `GRIS` (en proceso / en pila), `NEGRO` (terminado).

```
color[v] ← BLANCO para todo v
Para cada v no visitado: DFS(v)

DFS(v):
  color[v] ← GRIS
  Para cada w ∈ N_out(v):
    si color[w] = GRIS:
      reportar ciclo (retroceder pila desde v hasta w)
      retornar
    si color[w] = BLANCO:
      DFS(w)
  color[v] ← NEGRO
```

Un arco $v \to w$ con $w$ GRIS indica back-edge → ciclo. $O(n+m)$.

**Parte d) $D$ acíclico ↔ trivial o tiene $v$ con $d_{out}=0$ y $D\setminus\{v\}$ acíclico**

$(\Rightarrow)$: Si $D$ acíclico y no trivial: suponer que todo $v$ tiene $d_{out} \geq 1$ → por a) habría ciclo → contradicción. Entonces existe $v$ con $d_{out}(v) = 0$. $D \setminus \{v\}$ es subgrafo de $D$ acíclico → acíclico. ✓

$(\Leftarrow)$: Por inducción. $D$ trivial: acíclico. Si $d_{out}(v) = 0$ y $D\setminus\{v\}$ acíclico: cualquier ciclo en $D$ pasaría por $v$, pero $v$ tiene $d_{out}=0$ → no puede salir de $v$ → no hay ciclo pasando por $v$ → $D$ acíclico. ✓

**Parte e-f) Algoritmo: ciclo o topológico**

Equivale a Kahn (BFS topológico): mantener cola de vértices con $d_{in}=0$, procesarlos en orden. Si al final algún vértice no fue procesado → hay ciclo (retroceder para encontrarlo con DFS). Implementación $O(n+m)$.

**Chuleta**
> Existe ciclo ↔ DFS encuentra back-edge (arco a vértice GRIS). DFS 3-estados: BLANCO/GRIS/NEGRO. $O(n+m)$. Acíclico ↔ existe $v$ con $d_{out}=0$ (eliminarlo preserva aciclicidad) → orden topológico por Kahn (BFS con $d_{in}$).

**¿Aparece en parciales?** 🔴 Si — deteccion de ciclos y orden topologico son temas de 2P

---

### Ejercicio 18 — TrianguloGrafo

**Enunciado**

Un triangulo es una tripla $\{v, w, z\}$ que induce un $K_3$. Considerar 3 algoritmos para detectar triangulos en $G$ con $n$ vertices y $m > n$ aristas:

- Cubico: computar matriz de adyacencias $A$, retornar true si existen $v,w,z$ con $A_{vw} A_{wz} A_{vz} = 1$.
- Cuadratico: para cada $v$, marcar $N(v)$; retornar true si existe $wz \in E$ con $w,z$ marcados.
- Subcuadratico: separar vertices de grado $\geq \sqrt{m}$ y $< \sqrt{m}$.

a) Argumentar correctitud de cada algoritmo.
b) Demostrar que el cubico requiere $\Theta(n^3)$, el cuadratico $\Theta(nm) = O(m^2)$, y el subcuadratico $O(m^{3/2})$.
c) Determinar mejor y peor caso para cada uno.

**Explicacion**

El algoritmo subcuadratico: para vertices de grado alto ($\geq \sqrt{m}$): hay $O(\sqrt{m})$ de ellos, recorrer sus vecinos en $O(m)$ total → $O(m\sqrt{m})$. Para vertices de grado bajo ($< \sqrt{m}$): para cada par de vecinos $w,z$ de $v$, chequear $wz \in E$ en $O(d(w)) < O(\sqrt{m})$ → $O(m^{3/2})$ total.

**Resolucion paso a paso**

**Parte a) Correctitud**

- *Cúbico:* $A_{vw} A_{wz} A_{vz} = 1$ ↔ $v-w$, $w-z$, $v-z$ son aristas ↔ $\{v,w,z\}$ forman $K_3$. ✓
- *Cuadrático:* para cada $v$, marcar $N(v)$. Si arista $(w,z)$ con $w,z$ ambos marcados → $v,w,z$ adyacentes entre sí → triángulo. ✓
- *Subcuadrático:* misma idea pero divide el trabajo por grado de los vértices.

**Parte b) Complejidades**

*Cúbico:* tres bucles sobre pares de vértices → $\Theta(n^3)$.

*Cuadrático:* para cada $v$ ($n$ vértices): marcar $N(v)$ en $O(d(v))$ y chequear todas las aristas en $O(m)$. Total: $O(\sum_v (d(v) + m)) = O(nm + nm) = O(nm)$. Como $m \leq n^2$: $O(nm) = O(m^2/n) \leq O(m^2)$.

*Subcuadrático $O(m^{3/2})$:* Sea umbral $T = \sqrt{m}$.

- Vértices "pesados" ($d(v) \geq \sqrt{m}$): hay $\leq 2\sqrt{m}$ de ellos (por Handshaking: $\sum d = 2m$, cada pesado contribuye $\geq \sqrt{m}$). Para cada pesado $v$, recorrer $N(v)$ y marcar: $O(\sum_{v \text{ pesado}} d(v)) \leq O(m)$ total. Luego chequear cada arista $(w,z)$: si ambos están marcados → triángulo. $O(m)$ por cada pesado → $O(m \cdot 2\sqrt{m}) = O(m^{3/2})$... en realidad, se hace de forma más inteligente: para cada pesado $v$, construir tabla de marcado en $O(d(v))$, luego iterar sobre pares de vecinos de $v$ y verificar si son adyacentes. Total por pesados: $O(m) \cdot \sqrt{m}$... ⚠️ Verificar el análisis exacto.

- Vértices "ligeros" ($d(v) < \sqrt{m}$): para cada arista $(u,v)$ con $u$ ligero, iterar sobre $N(u)$ y para cada $w \in N(u)$, verificar si $w \in N(v)$ en $O(1)$ (con hash). Coste: $\sum_{u \text{ ligero}} d(u)^2/2 \leq \sum_{u \text{ ligero}} d(u) \cdot \sqrt{m} = O(m \cdot \sqrt{m}) = O(m^{3/2})$.

**Parte c) Mejor y peor caso**

- *Cúbico:* siempre $\Theta(n^3)$, independientemente de $m$.
- *Cuadrático:* mejor caso $m$ pequeño ($O(nm)$ con $m \ll n^2$); peor caso $m = O(n^2)$ → $O(n^3)$.
- *Subcuadrático:* $O(m^{3/2})$ en todos los casos.

**Chuleta**
> Cúbico $\Theta(n^3)$: tres bucles. Cuadrático $O(nm)$: para cada $v$, marcar $N(v)$ y chequear todas las aristas. Subcuadrático $O(m^{3/2})$: separar pesados ($d \geq \sqrt{m}$, $\leq 2\sqrt{m}$ de ellos) y ligeros ($d < \sqrt{m}$).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 19 — UmbralDeGrafos (Threshold Graphs)

**Enunciado**

$G$ es un grafo threshold si para cada par $u,v$ con $d(u) \leq d(v)$ ocurre que $N(u) \subseteq N(v)$ o $N[u] \subseteq N[v]$.

a) Demostrar que los vertices de grado $k$ son todos mellizos o todos gemelos.
b) Demostrar que $G$ threshold tiene algun vertice de grado 0 o de grado $n-1$.
c) Demostrar que $G$ threshold $\Rightarrow$ $G \setminus \{v\}$ threshold para todo $v$.
d) Demostrar que $G$ es threshold $\Leftrightarrow$ $G$ admite una descomposicion threshold.
e) Proponer estructura de datos en $O(n)$ bits para un grafo threshold.
f) Disenar un algoritmo para determinar si $G$ es threshold. En caso afirmativo, construir la representacion.
g) Demostrar que si $v_1,\ldots,v_n$ y $w_1,\ldots,w_n$ son descomposiciones threshold de $G$ y $H$, entonces $G \cong H \Leftrightarrow f(v_i) = w_i$ es isomorfismo.

**Explicacion**

Los grafos threshold tienen estructura extremadamente regular. La descomposicion threshold asigna a cada vertice, en orden, un rol de "aislado" o "dominante" — esto determina completamente el grafo. El isomorfismo entre threshold grafos es trivial por d).

**Resolucion paso a paso**

*Ejercicio de nivel avanzado. Presentamos las ideas clave.*

**Parte a) Todo $G$ threshold tiene vértice de grado 0 o $n-1$**

Por definición de threshold: para $u$ con grado mínimo $\delta$ y $v$ con grado máximo $\Delta$, $N(u) \subseteq N(v)$ o $N[u] \subseteq N[v]$. Si $\delta \geq 1$ y $\Delta \leq n-2$: todos los vértices tienen vecinos pero nadie es universal. Tomar el par de mínimo y máximo grado; la condición threshold obliga una de las dos inclusiones, lo que eventualmente lleva a una contradicción con la estructura del grafo. (Prueba formal requiere más desarrollo.) ⚠️ Verificar

**Parte b) Descomposición threshold**

Un grafo threshold se puede construir iterativamente: empezando con $G_1 = K_1$, en cada paso añadir un vértice como "aislado" (rol I: no conectado a nada) o "dominante" (rol D: conectado a todos los vértices actuales). La secuencia de roles $(r_1, r_2, \ldots, r_n)$ con $r_i \in \{I, D\}$ determina el grafo completamente.

**Parte c) Estructura de datos $O(n)$ bits**

Almacenar la secuencia de roles $(r_1, \ldots, r_n)$: $n$ bits (uno por vértice).

**Parte d) Isomorfismo trivial**

Si $v_1,\ldots,v_n$ y $w_1,\ldots,w_n$ son descomposiciones threshold de $G$ y $H$: $f(v_i) = w_i$ es isomorfismo ↔ las secuencias de roles coinciden. Esto hace el isomorfismo de threshold grafos solucionable en tiempo lineal.

**Parte e) Algoritmos**

- Determinar si $G$ es threshold: verificar $N(u) \subseteq N[v]$ para cada par de grado mínimo y máximo iterativamente → $O(n \cdot (n+m))$.
- Construir representación: si threshold, reconstruir la secuencia de roles.

**Chuleta**
> Threshold: $N(u) \subseteq N(v)$ para todo par (orden por grado). Siempre hay vértice aislado o universal. Descomposición: secuencia de roles I/D de longitud $n$. Isomorfismo: trivial por comparación de secuencias.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 20 — AristasUnicas

**Enunciado**

Dado un digrafo $D$, determinar las aristas $v \to w$ tales que $w \to v$ no es arista de $D$.

a) Describir un algoritmo lineal que, dado un multigrafo $G$ como conjunto de aristas, determine las aristas $(v,w)$ no repetidas.
b) Describir un algoritmo lineal que, dado $D$ como conjunto de aristas, determine las aristas $v \to w$ tal que $w \to v \notin E(D)$.

**Explicacion**

a) Usar tabla de hash: insertar todas las aristas, contar ocurrencias. b) Para cada $v \to w$ en $E(D)$, chequear si $w \to v$ esta en $E(D)$ usando hash set. Ambos $O(m)$ amortizado.

**Resolucion paso a paso**

**Parte a) Multigrafo con aristas repetidas**

Usar tabla de hash sobre pares $(v,w)$ (normalizados con $v \leq w$ para grafo no dirigido):
```
freq ← tabla de hash vacía
Para cada arista (v,w) en la lista:
  clave ← normalizar(v,w)  // e.g., (min,max)
  freq[clave]++
retornar [(v,w) : freq[(v,w)] = 1]  // no repetidas
```
$O(m)$ amortizado.

**Parte b) Aristas $v \to w$ tales que $w \to v \notin E(D)$**

```
arcos ← hash set de todos los arcos de D
Para cada arco (v,w) en E(D):
  si (w,v) ∉ arcos:
    retornar/reportar (v,w)
```
$O(m)$ amortizado (construcción del hash set + una pasada por todos los arcos).

**Chuleta**
> a) Tabla de hash de frecuencias sobre aristas normalizadas → retornar las de frecuencia 1. $O(m)$.
> b) Hash set de arcos → para cada $v \to w$, verificar si $w \to v$ está en el set. $O(m)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 21 — CiclosRho

**Enunciado**

Un digrafo con loops tiene forma de $\rho$ cuando todos sus vertices tienen grado de salida igual a 1.

a) Demostrar constructivamente: si un digrafo conexo tiene forma de $\rho$, entonces tiene un unico ciclo dirigido.
b) Disenar un algoritmo para encontrar todos los ciclos de un digrafo con forma de $\rho$ (no necesariamente conexo). Hint: los vertices con $d_{in} = 0$ no estan en ciclos; eliminarlos iterativamente. Los vertices restantes tienen $d_{in} = 1$ → todos pertenecen a un ciclo.
c-e) Aplicacion: Seleccion de Actividades Periodicas. Definir el digrafo de actividades $D$ (vertice $i$ por actividad, arco $i \to j$ cuando $j$ es la eleccion golosa al salir de $i$). $D$ es un digrafo con forma de $\rho$. Demostrar que algun ciclo de $D$ es una solucion optima. Algoritmo resultante.

**Explicacion**

En un digrafo con forma de $\rho$ no conexo, cada componente conexa tiene exactamente un ciclo (la "cabeza" de la $\rho$). El algoritmo elimina vertices con $d_{in}=0$ iterativamente (similar a Kahn) hasta que todos los vertices restantes pertenecen a ciclos.

**Resolucion paso a paso**

**Parte a) Digrafo conexo con forma de ρ tiene un único ciclo**

*Existencia:* Desde cualquier $v$, seguir el único arco saliente: $v \to v_1 \to v_2 \to \ldots$ Como $d_{out}(v_i) = 1$ para todo $i$, la secuencia es determinista. Con $n$ vértices finitos, en a lo sumo $n+1$ pasos: $v_i = v_j$ con $i < j$ → ciclo $v_i, v_{i+1}, \ldots, v_j = v_i$. ✓

*Unicidad:* Suponer dos ciclos $C_1$ y $C_2$ distintos. Para llegar de $C_1$ a $C_2$ y volver (el grafo es conexo), algún vértice del camino tendría $d_{out} = 2$ (para "divergir" hacia ambos ciclos) → contradicción con $d_{out} = 1$ para todo vértice. ✓

**Parte b) Algoritmo para encontrar todos los ciclos**

```
Calcular d_in[v] para todo v             → O(n+m)
Cola ← {v : d_in[v] = 0}
Mientras cola no vacía:
  v ← extraer
  w ← sucesor único de v                  // d_out[v] = 1
  d_in[w]--
  si d_in[w] == 0: agregar w a cola
// Vértices con d_in[v] > 0 pertenecen a ciclos
Para cada componente de {v : d_in[v] > 0}:
  desde cualquier vértice, seguir arcos hasta ciclo, reportar
```
$O(n+m)$.

**Parte c-e) Selección de Actividades Periódicas**

Definir el digrafo $D$ de actividades: vértice $i$ por actividad, arco $i \to j$ donde $j$ es la próxima actividad elegida por el greedy tras el fin de $i$ (la primera actividad compatible que termina más temprano). Cada vértice tiene exactamente un sucesor → $d_{out} = 1$ para todo vértice → forma de ρ.

Cada ciclo de $D$ representa un conjunto periódico de actividades que el greedy elige cíclicamente. El ciclo de mayor cardinalidad (más actividades) es la solución óptima.

Algoritmo: construir $D$ + encontrar ciclos de $D$ → retornar el ciclo con más nodos. $O(n \log n)$ (sorting para el greedy) + $O(n)$ (ciclos).

**Chuleta**
> ρ-digrafo: cada componente conexa tiene exactamente 1 ciclo (unicidad por $d_{out}=1$). Algoritmo: eliminar $d_{in}=0$ iterativamente (como Kahn) → lo que queda son los ciclos. $O(n+m)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 22 — GeoCuadrados

**Enunciado**

Un camino $P$ de $v$ a $w$ en $G$ es geodesico si su longitud es la minima entre todos los caminos de $v$ a $w$. El cuadrado $G^2$ de $G$ tiene los mismos vertices y $vw$ son adyacentes en $G^2$ si y solo si sus vecindarios cerrados tienen algun vertice en comun.

a) (Dificil) Si $G$ tiene un camino geodesico con $\geq 4$ aristas, entonces $G^2$ es un grafo completo.
b) Si $G$ tiene un camino geodesico con $\geq 3$ aristas, entonces $G$ no tiene caminos geodesicos con $> 3$ aristas.

**Explicacion**

Ejercicio de nivel avanzado. a) Si existe un camino geodesico $v_0, v_1, v_2, v_3, v_4$, en $G^2$: $v_i$ y $v_j$ son adyacentes en $G^2$ si y solo si $|i-j| \leq 2$ (por la propiedad de camino geodesico). Pero ademas, todos los otros vertices del grafo deben conectarse por vecindarios compartidos. b) Se deduce de a): si hubiera un geodesico de longitud $> 3$, el cuadrado seria completo pero tener un geodesico de longitud 3 aun es compatible.

**Resolucion paso a paso**

⚠️ Verificar — el enunciado parece contener una inconsistencia. Si $G$ tiene un camino geodésico de longitud $\geq 4$, hay dos vértices a distancia $\geq 4$ en $G$. Pero en $G^2$ (definido como $vw$ adyacentes ↔ $N[v] \cap N[w] \neq \emptyset$ ↔ $d_G(v,w) \leq 2$), esos vértices NO serían adyacentes → $G^2$ no sería completo.

**Interpretación más plausible del ejercicio:**

Quizás la afirmación correcta es la **contrarrecíproca**: si $G^2$ no es completo (existe un par $u,w$ con $d_G(u,w) > 2$), entonces el mayor geodésico de $G$ tiene longitud $\geq 3$.

**Parte b) Si $G$ tiene geodésico de longitud $\geq 3$, no tiene geodésicos de longitud $> 3$**

Si existe geodésico $v_0, v_1, v_2, v_3$ (longitud 3), entonces por la estructura de vecindarios:
- $v_0$ y $v_3$ están a distancia 3.
- Si existiera otro geodésico de longitud $\geq 4$: $u_0, u_1, u_2, u_3, u_4$, la existencia de ambos geodésicos crearía una contradicción con la propiedad métrica del grafo (desigualdad triangular o estructura de geodésicos). ⚠️ Verificar argumento completo.

**Chuleta**
> ⚠️ Verificar enunciado: camino geodésico de longitud $\geq 4$ implica diámetro $\geq 4$, lo que hace $G^2$ NO completo. Posible error en el enunciado. Parte b): unicidad del geodésico más largo (estructura métrica).

**¿Aparece en parciales?** ⚪ No

## Ver tambien

- [[grafos_teoria]] — Definiciones, Handshaking, recorridos, representacion
- [[grafos_practica]] — Ejercicios de clase: representacion, demos sobre grafos
- [[definiciones_y_demostraciones_teoria]] — Tecnicas de demostracion para grafos
- [[recorrido_en_grafos_guia]] — Guia de DFS/BFS (grafos 2P)
