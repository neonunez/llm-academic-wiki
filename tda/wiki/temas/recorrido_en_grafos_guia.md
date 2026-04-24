---
nombre: Recorrido en Grafos — Guia de Ejercicios
parcial: 2P
tipo: guia
tema: recorrido_en_grafos
fuente: raw/guias_practicas/4.guia_2P_recorridos_&_arboles.pdf
paginas_relacionadas:
  - "[[arboles_teoria]]"
  - "[[grafos_teoria]]"
  - "[[recorrido_en_grafos_practica]]"
  - "[[arboles_generadores_minimos_guia]]"
---

# Recorrido en Grafos — Guia de Ejercicios

Practica 4: Recorridos y Arboles. 1er cuatrimestre 2024. Compilado: 21 oct. 2025.

Esta pagina cubre los ejercicios de DFS y BFS de la guia (ej. 1–10). Los ejercicios de AGM y los integradores (ej. 11–20) estan en [[arboles_generadores_minimos_guia]]. Ejercicios con ⋆ son el subconjunto minimo recomendado.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 ⋆ | Bipartito via DFS: arbol generador + clasificacion de aristas | 🔴 Si |
| Ej. 2 ⋆ | Aristas puente via DFS: caracterizacion + algoritmo lineal | 🔴 Si |
| Ej. 3 | Orientacion fuertemente conexa: equivalencias + algoritmo lineal | ⚪ No |
| Ej. 4 | Calles de ciudad: minimizar calles bidireccionales, O(n+m) | ⚪ No |
| Ej. 5 ⋆ | BFS genera arboles v-geodesicos; contraejemplo de la vuelta | 🔴 Si |
| Ej. 6 | Arbol v-geodesico de menor peso, O(n+m) | ⚪ No |
| Ej. 7 | Recorrido de longitud par de s a t usando menor cantidad de aristas | ⚪ No |
| Ej. 8 ⋆ | Grilla con transformacion de valor via BFS en O(kmn) | ⚪ No |
| Ej. 9 | Minimo n divisible por d con digitos que sumen s, O(ds) | ⚪ No |
| Ej. 10 | Luces de habitaciones: camino mas corto apagando luces, BFS con bitmask | 🔴 Si |

## Patrones de este tema en parciales

> BFS multi-source · Grafo implicito con estado · Aristas puente via DFS · Bipartito via BFS

## Ejercicios

### Ejercicio 1 ⋆ — Bipartito via DFS

**Enunciado**

Sea $T$ un arbol generador de un grafo (conexo) $G$ con raiz $r$. Sean $V$ y $W$ los vertices a distancia par e impar de $r$, respectivamente.

a) Observar: si existe una arista $vw \in E(G) \setminus E(T)$ con $v, w \in V$ o $v, w \in W$, entonces el unico ciclo de $T \cup \{vw\}$ tiene longitud impar.

b) Observar: si toda arista de $E(G) \setminus E(T)$ une un vertice de $V$ con uno de $W$, entonces $(V, W)$ es una biparticion de $G$.

c) A partir de lo anterior, disenar un algoritmo lineal para determinar si $G$ conexo es bipartito. Si si, devolver una biparticion. Si no, devolver un ciclo impar. Explicitar la implementacion.

d) Generalizar a grafos no necesariamente conexos (G es bipartito $\Leftrightarrow$ sus componentes son bipartitas).

**Explicacion**

Algoritmo: BFS o DFS desde $r$ asignando nivel par/impar. Si se encuentra una arista "cruzada" entre dos vertices del mismo nivel, el grafo no es bipartito y el ciclo impar se recupera trazando el camino en el arbol. $O(n+m)$.

Este ejercicio aparece en [[recorrido_en_grafos_practica]] como "Chequeo de bipartito" con implementacion en C++.

**Resolucion paso a paso**

**Parte a) — Ciclo impar cuando $v, w$ estan en la misma clase:**

Sea $vw \in E(G) \setminus E(T)$ con $v, w \in V$ (distancia par de $r$). El unico ciclo de $T \cup \{vw\}$ es el camino de $v$ a $w$ en $T$ mas la arista $vw$.

Sea $\ell = \text{LCA}(v, w)$ en $T$. La longitud del camino en $T$ de $v$ a $w$ es:
$$\text{nivel}(v) - \text{nivel}(\ell) + \text{nivel}(w) - \text{nivel}(\ell) = \text{nivel}(v) + \text{nivel}(w) - 2\,\text{nivel}(\ell)$$

Como $v, w \in V$, ambos tienen nivel par. La expresion anterior es (par) + (par) - (par) = par. Sumando la arista $vw$: longitud del ciclo = par + 1 = impar. Analogo para $v, w \in W$ (ambos impares: impar + impar - par = par; + 1 = impar).

**Parte b) — Biparticion cuando todas las aristas no-arbol cruzan $V$ y $W$:**

Las aristas de $T$ unen padre e hijo, y en $T$ el padre de un vertice de $V$ esta en $W$ y viceversa (los niveles difieren en 1). Por hipotesis, las aristas no-arbol tambien unen $V$ con $W$. Entonces toda arista de $E(G)$ une un vertice de $V$ con uno de $W$ $\Rightarrow$ $(V, W)$ es biparticion de $G$.

**Parte c) — Algoritmo lineal:**

1. DFS desde $r$ asignando $\text{color}[r] = 0$. Para cada vertice $u$ descubierto desde $v$: $\text{color}[u] = 1 - \text{color}[v]$. Guardar $\text{parent}[u]$.
2. Para cada arista $vw \in E(G)$: si $\text{color}[v] = \text{color}[w]$, el grafo NO es bipartito.
   - Extraer ciclo impar: el ciclo es el camino de $v$ a $\text{LCA}(v,w)$ mas el camino de $w$ a $\text{LCA}(v,w)$ mas la arista $vw$. En DFS de grafos no dirigidos, si se encuentra la arista $vw$ y $v$ es ancestro de $w$, el ciclo es el camino de $v$ a $w$ en $T$ mas $vw$ — reconstruir con $\text{parent}[]$.
3. Si se recorre todo $G$ sin conflicto: retornar $(V = \{v : \text{color}[v]=0\},\ W = \{v : \text{color}[v]=1\})$.

Complejidad: $O(n + m)$ — una pasada DFS + recorrido de aristas.

**Parte d) — Generalizacion a grafos no conexos:**

Iterar sobre todos los vertices; por cada vertice no visitado iniciar una nueva DFS (nueva componente). $G$ es bipartito si y solo si todas sus componentes son bipartitas. La biparticion global es la union de las biparticiones de cada componente. Complejidad total: $O(n+m)$.

**Chuleta**

> 1. DFS/BFS desde cada componente no visitada.
> 2. Asignar $\text{color}[u] = 1 - \text{color}[v]$ al descubrir $u$ desde $v$.
> 3. Si arista $vw$ con $\text{color}[v] = \text{color}[w]$: NO bipartito — ciclo impar = camino $v \leadsto \text{LCA}(v,w)$ + camino $w \leadsto \text{LCA}(v,w)$ + arista $vw$.
> 4. Si sin conflicto: bipartito con biparticion $(\{\text{color}=0\}, \{\text{color}=1\})$.
> 5. $O(n+m)$.

**¿Aparece en parciales?** 🔴 Si — bipartito via BFS es ejercicio evaluado en 2P

---

### Ejercicio 2 ⋆ — Aristas Puente via DFS

**Enunciado**

Una arista de $G$ es puente si su remocion aumenta las componentes conexas. Sea $T$ un arbol DFS de $G$ conexo.

a) Demostrar: $vw$ es puente $\Leftrightarrow$ $vw$ no pertenece a ningun ciclo de $G$.

b) Demostrar: si $vw \in E(G) \setminus E(T)$, entonces $v$ es ancestro de $w$ en $T$ o viceversa.

c) Sea $vw \in E(G)$ con $nivel(v) \leq nivel(w)$ en $T$. Demostrar: $vw$ es puente $\Leftrightarrow$ $v$ es el padre de $w$ en $T$ y ninguna arista de $G \setminus \{vw\}$ une a un descendiente de $w$ (o $w$) con un ancestro de $v$ (o $v$).

d) Dar un algoritmo lineal basado en DFS para encontrar todas las aristas puente. Primera fase: DFS para calcular el minimo nivel alcanzable desde cada vertice usando back edges de su subarbol. Segunda fase: recorrer todas las aristas para chequear la condicion.

**Explicacion**

El valor clave es $low[v] = \min(\text{nivel}[v], \min_{(v,u) \in E \setminus T} \text{nivel}[u], \min_{w \in \text{hijos}(v)} low[w])$. La arista $(padre, v)$ es puente si y solo si $low[v] > nivel[padre]$.

Este ejercicio aparece en [[recorrido_en_grafos_practica]] como "Aristas puente" con algoritmo DFS + array cubren.

**Resolucion paso a paso**

**Parte a) — Puente $\Leftrightarrow$ no pertenece a ningun ciclo:**

$(\Rightarrow)$ Si $vw$ es puente, supongamos que pertenece a un ciclo $C$. Entonces existe un camino de $v$ a $w$ en $G \setminus \{vw\}$ (el resto del ciclo $C$). Por tanto $v$ y $w$ siguen conectados tras remover $vw$ — contradiccion con que $vw$ sea puente.

$(\Leftarrow)$ Si $vw$ no pertenece a ningun ciclo, supongamos que $G' = G \setminus \{vw\}$ es conexo. Entonces existe un camino $P$ de $v$ a $w$ en $G'$. Pero entonces $P + \{vw\}$ es un ciclo de $G$ que contiene $vw$ — contradiccion. Luego $G'$ no es conexo, es decir, $vw$ es puente.

**Parte b) — Las aristas no-arbol son back edges:**

Sea $vw \in E(G) \setminus E(T)$. Supongamos que ni $v$ es ancestro de $w$ ni $w$ es ancestro de $v$. En DFS sobre grafo no dirigido, cuando se procesa la arista $vw$ desde $v$ (ya descubierto), $w$ debe estar en uno de dos estados: no visitado (seria arista de arbol — contradiccion) o ya visitado. Si $w$ esta visitado, debe estar activo en el stack DFS (en grafos no dirigidos, si $w$ ya fue cerrado antes de que DFS llegue a $v$, la arista $vw$ habria sido procesada ya desde $w$). Que $w$ este en el stack cuando se procesa $v$ significa que $w$ es ancestro de $v$ en $T$ — contradiccion. Entonces $w$ es ancestro de $v$ o $v$ es ancestro de $w$.

**Parte c) — Caracterizacion de puentes via DFS:**

Sea $vw \in E(G)$ con $\text{nivel}(v) \leq \text{nivel}(w)$, es decir, $v$ es ancestro de $w$ (o $v = w$).

$(\Rightarrow)$ Si $vw$ es puente:
- Por parte a), $vw$ no esta en ningun ciclo, luego esta en el arbol $T$ (las aristas no-arbol son back edges y siempre forman un ciclo con el camino del arbol — parte b). Y $v$ debe ser el padre de $w$ en $T$ (si no fuera el padre, habria un camino alternativo en el arbol).
- Si existiera una arista $uw'$ con $u$ descendiente de $w$ y $w'$ ancestro de $v$: habria un camino de $v$ a $w$ usando $vw_1 \cdots u \to w' \cdots v \cdots w$ — contradiccion con que $vw$ sea puente.

$(\Leftarrow)$ Si $v$ es padre de $w$ en $T$ y no hay arista de $G \setminus \{vw\}$ que una el subarbol de $w$ con un ancestro de $v$: el unico camino de $v$ al subarbol de $w$ pasa por la arista $vw$. Removiendola, el subarbol de $w$ queda desconectado $\Rightarrow$ $vw$ es puente.

**Parte d) — Algoritmo O(n+m) con $low[]$:**

Definicion:
$$low[v] = \min\bigl(\text{nivel}[v],\ \min_{(v,u) \in E \setminus T} \text{nivel}[u],\ \min_{w \in \text{hijos}(v)} low[w]\bigr)$$

$low[v]$ es el minimo nivel alcanzable desde el subarbol de $v$ usando exactamente un back edge.

**La arista $(\text{parent}[v], v)$ es puente $\Leftrightarrow$ $low[v] > \text{nivel}[\text{parent}[v]]$.**

Algoritmo:
```
DFS(v, nivel_actual):
  visitado[v] = true
  nivel[v] = nivel_actual
  low[v] = nivel_actual
  para cada vecino u de v:
    si u no visitado:
      parent[u] = v
      DFS(u, nivel_actual + 1)
      low[v] = min(low[v], low[u])
      si low[u] > nivel[v]:
        reportar arista (v, u) como puente
    si u != parent[v]:          # back edge
      low[v] = min(low[v], nivel[u])
```

Complejidad: $O(n+m)$ — una sola pasada DFS.

**Chuleta**

> 1. DFS calculando $\text{nivel}[v]$ y $low[v]$ en postorder.
> 2. $low[v] = \min(\text{nivel}[v],\ \text{nivel de back edges desde subarbol de } v)$.
> 3. Arista $(\text{parent}[v], v)$ es puente $\Leftrightarrow$ $low[v] > \text{nivel}[\text{parent}[v]]$.
> 4. $O(n+m)$.
> 5. Clave intuitiva: si el subarbol de $v$ no puede llegar mas arriba que $\text{parent}[v]$, la arista es el unico enlace.

**¿Aparece en parciales?** 🔴 Si — aristas puente aparece en clase practica

---

### Ejercicio 3 — Orientacion Fuertemente Conexa

**Enunciado**

Una orientacion de $G$ es un digrafo $D$ cuyo grafo subyacente es $G$. Para todo arbol DFS $T$ de un grafo conexo $G$, $D(T)$ orienta $v \to w$ si: $v$ es el padre de $w$ en $T$, o $w$ es un ancestro no-padre de $v$ en $T$.

a) $D(T)$ esta bien definido por el Ejercicio 2b.

b) Demostrar que las siguientes afirmaciones son equivalentes:
   I) $G$ admite una orientacion fuertemente conexa.
   II) $G$ no tiene puentes.
   III) Para todo arbol DFS $T$, $D(T)$ es fuertemente conexo.
   IV) Existe algun arbol DFS $T$ tal que $D(T)$ es fuertemente conexo.

   Hint para II $\Rightarrow$ III: mostrar que la raiz de $D(T)$ es alcanzable desde cualquier vertice $v$ por induccion en el nivel de $v$, usando resultados del Ejercicio 2.

c) Dar un algoritmo lineal para encontrar una orientacion fuertemente conexa cuando exista.

**Explicacion**

El teorema de Robbins: un grafo admite una orientacion fuertemente conexa $\Leftrightarrow$ no tiene puentes. El algoritmo: hacer DFS, orientar aristas de arbol hacia adelante (padre $\to$ hijo) y back edges hacia arriba (vertice $\to$ ancestro). $O(n+m)$.

**Resolucion paso a paso**

**Parte a) — D(T) bien definido:**

Por el Ejercicio 2b, toda arista $vw \in E(G) \setminus E(T)$ es back edge: uno de los extremos es ancestro del otro. Luego la regla "$w$ es ancestro no-padre de $v$" cubre exactamente estos casos sin ambiguedad. Las aristas de arbol tienen padre bien definido. Luego $D(T)$ asigna orientacion unica a cada arista.

**Parte b) — Cadena de equivalencias:**

**(I $\Rightarrow$ II):** Sea $D$ orientacion FC de $G$. Si $vw$ fuera puente, en $D$ queda orientado como $v \to w$ o $w \to v$. En el primer caso, no hay camino de $w$ a $v$ en $D$ (la arista $vw$ era la unica conexion) — contradiccion con que $D$ sea FC. Identico para el segundo caso.

**(II $\Rightarrow$ III):** Sea $G$ sin puentes y $T$ cualquier arbol DFS. En $D(T)$: aristas de arbol $v \to$ hijo, back edges vertice $\to$ ancestro.

*Claim 1:* desde la raiz $r$ se alcanza todo vertice — siguiendo aristas de arbol $r \to$ hijos $\to$ nietos $\to \ldots$

*Claim 2 (por induccion en nivel):* todo vertice $v$ puede alcanzar $r$.
- Base: $v$ con $\text{nivel}[v] = 1$ (hijo de $r$). Como $G$ no tiene puentes, $(\text{parent}[v], v) = (r, v)$ no es puente, luego $low[v] \leq \text{nivel}[r] = 0$. Existe un back edge desde el subarbol de $v$ hasta $r$: existe un descendiente $u$ de $v$ con arista $u \to r$ en $D(T)$. El camino $v \to \ldots \to u \to r$ (siguiendo aristas de arbol hacia abajo hasta $u$, luego el back edge) muestra que $v$ alcanza $r$.
- Inductivo: supongamos que todo vertice de nivel $< k$ alcanza $r$. Sea $v$ con $\text{nivel}[v] = k$. Como $(\text{parent}[v], v)$ no es puente, $low[v] < \text{nivel}[\text{parent}[v]] = k - 1$, por lo que existe un back edge desde el subarbol de $v$ hasta algun vertice $w$ con $\text{nivel}[w] < k - 1$. El camino de $v$ a $r$: bajar por el arbol hasta el descendiente que emite el back edge, usar el back edge para llegar a $w$ (nivel $< k-1 < k$), y de $w$ a $r$ por hipotesis inductiva.

Luego $D(T)$ es FC.

**(III $\Rightarrow$ IV):** Trivial (si vale para todo $T$, en particular para algun $T$).

**(IV $\Rightarrow$ I):** $D(T)$ es una orientacion de $G$ y es FC — es la orientacion FC buscada.

**Parte c) — Algoritmo lineal:**

1. DFS desde cualquier vertice, calcular $low[]$.
2. Si algun $low[v] > \text{nivel}[\text{parent}[v]]$: hay un puente $\Rightarrow$ no existe orientacion FC. Reportar.
3. Si no hay puentes: orientar cada arista segun $D(T)$:
   - Aristas de arbol: $\text{parent}[v] \to v$.
   - Back edges: $v \to \text{ancestro}$.

Complejidad: $O(n+m)$.

**Chuleta**

> 1. DFS + $low[]$ para detectar puentes — $O(n+m)$.
> 2. Si hay puentes: no existe orientacion FC (Teorema de Robbins).
> 3. Si no: orientar arbol padre $\to$ hijo, back edges vertice $\to$ ancestro.
> 4. Resultado: $D(T)$ es FC.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — Calles de Ciudad

**Enunciado**

La intendencia quiere orientar la mayor cantidad de calles posibles manteniendo la accesibilidad total (desde cualquier esquina a cualquier otra). Modelar el problema y proponer un algoritmo $O(n+m)$ para resolver: que calles orientar y en que sentido para minimizar las calles bidireccionales que quedan.

**Explicacion**

Las calles que no son puentes pueden orientarse (por el Ejercicio 3). Las que son puentes deben mantenerse bidireccionales. Algoritmo: encontrar los puentes (DFS, $O(n+m)$), orientar los no-puentes con $D(T)$, mantener bidireccionales los puentes.

**Resolucion paso a paso**

**Modelado:**
- Grafo $G$: vertices = esquinas, aristas = calles.
- "Accesibilidad total" = desde cualquier esquina se puede llegar a cualquier otra = el digrafo resultante es fuertemente conexo.
- Objetivo: maximizar aristas orientadas (equivalentemente, minimizar aristas bidireccionales).

**Observaciones clave:**
1. Una arista puente, en cualquier orientacion, crea un corte dirigido (en alguna direccion no hay camino). Luego los puentes deben quedar bidireccionales.
2. Una arista no-puente pertenece a un ciclo. Por el Teorema de Robbins (Ej. 3), el subgrafo 2-arista-conexo que la contiene admite orientacion FC. Luego puede orientarse.

**Algoritmo $O(n+m)$:**
1. DFS + $low[]$ para identificar todos los puentes — $O(n+m)$.
2. Para las aristas NO puente: orientar segun $D(T)$ (aristas de arbol hacia abajo, back edges hacia arriba).
3. Para las aristas puente: mantener bidireccionales.

**Correctitud:** Las componentes biconexas (2-arista-conexas) se orientan como FC (Ej. 3). Los puentes conectan estas componentes y deben ser bidireccionales para mantener accesibilidad en ambos sentidos. El resultado minimiza las calles bidireccionales: exactamente los puentes quedan bidireccionales, que es el minimo posible.

**Chuleta**

> 1. DFS para encontrar puentes — $O(n+m)$.
> 2. Orientar aristas NO puente con $D(T)$: arbol padre $\to$ hijo, back edges $\to$ ancestro.
> 3. Puentes: mantener bidireccionales (son el minimo inevitable).
> 4. Total: $O(n+m)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 ⋆ — Arboles v-Geodesicos

**Enunciado**

Un arbol generador $T$ de $G$ es v-geodesico si la distancia entre $v$ y $w$ en $T$ es igual a la distancia en $G$ para todo $w$.

Demostrar: todo arbol BFS de $G$ enraizado en $v$ es v-geodesico.

Dar un contraejemplo para la vuelta: mostrar un arbol generador v-geodesico que no pueda obtenerse por BFS.

**Explicacion**

Demostracion: BFS mantiene la invariante de que cada vertice $w$ se descubre a distancia $d_G(v,w)$. Contraejemplo: en un cuadrado $v-a-b-c-v$, cualquier arbol generador enraizado en $v$ que incluya exactamente 3 aristas es v-geodesico para todas las distancias 1 y 2, pero solo el que usa $va$, $vc$ y uno de $ab$ o $bc$ puede ser generado por BFS (depende del orden de exploración).

**Resolucion paso a paso**

**Demostracion — Todo arbol BFS es v-geodesico:**

Sea $T$ el arbol BFS de $G$ enraizado en $v$. Demostrar que $d_T(v, w) = d_G(v, w)$ para todo $w$.

BFS descubre los vertices por niveles: nivel 0 = $\{v\}$, nivel 1 = vecinos de $v$, nivel 2 = vecinos del nivel 1 no visitados, etc. La distancia en $T$ de $v$ a $w$ es $\text{nivel}(w)$.

**Invariante:** cuando BFS descubre $w$ en el nivel $k$, se cumple $d_G(v, w) = k$.

- $d_G(v, w) \leq k$: el camino de $v$ a $w$ en $T$ tiene longitud $k$ (construccion del arbol), y ese camino existe en $G$ — luego $d_G \leq k$.
- $d_G(v, w) \geq k$: por induccion en $k$. Para $k=0$ trivial. Para $k \geq 1$: si $w$ esta en el nivel $k$, fue descubierto desde algun $u$ en el nivel $k-1$. Por HI, $d_G(v, u) = k-1$. Como $uw \in E(G)$, $d_G(v, w) \leq d_G(v, u) + 1 = k$. Pero ademas cualquier vecino de $w$ fue descubierto en nivel $\leq k$ (si estuviera en nivel $< k-1$, $w$ habria sido descubierto antes). Luego $d_G(v, w) \geq k$.

Por lo tanto $d_T(v, w) = \text{nivel}(w) = d_G(v, w)$ para todo $w$. $\square$

**Contraejemplo — Arbol v-geodesico que no es arbol BFS:**

Consideremos el grafo $G$ con vertices $\{v, a, b, c, d\}$ y aristas:
$$E = \{v\text{-}a,\ v\text{-}b,\ a\text{-}c,\ b\text{-}c,\ a\text{-}d,\ b\text{-}d\}$$

Distancias desde $v$: $d(v,a)=1$, $d(v,b)=1$, $d(v,c)=2$, $d(v,d)=2$.

El DAG BFS (aristas de nivel $k$ a $k+1$): $v \to a$, $v \to b$, $a \to c$, $b \to c$, $a \to d$, $b \to d$.

Consideremos el arbol $T = \{v\text{-}a,\ v\text{-}b,\ a\text{-}c,\ b\text{-}d\}$:
- $d_T(v, a) = 1$ ✓, $d_T(v, b) = 1$ ✓, $d_T(v, c) = 2$ (via $a$) ✓, $d_T(v, d) = 2$ (via $b$) ✓.
- $T$ es v-geodesico.

**$T$ no puede ser generado por ningun BFS:** En BFS, el primero de $\{a, b\}$ en ser procesado descubre tanto $c$ como $d$ (ambos no visitados). Si $a$ se procesa primero: $\text{parent}(c) = a$ y $\text{parent}(d) = a$. Si $b$ se procesa primero: $\text{parent}(c) = b$ y $\text{parent}(d) = b$. En ningun caso puede ocurrir $\text{parent}(c) = a$ y $\text{parent}(d) = b$ simultaneamente — que es exactamente lo que tiene $T$.

Luego $T$ es v-geodesico y no es arbol BFS. $\square$

**Chuleta**

> **Demo BFS v-geodesico:** BFS descubre $w$ en nivel $k = d_G(v,w)$ — invariante por induccion. $d_T(v,w) = k = d_G(v,w)$.
>
> **Contraejemplo:** $G = \{v, a, b, c, d\}$ con $v$ adyacente a $a$ y $b$; $c$ y $d$ adyacentes a $a$ y $b$. El arbol $T = \{v\text{-}a, v\text{-}b, a\text{-}c, b\text{-}d\}$ es v-geodesico pero BFS nunca puede "partir" $c$ y $d$ entre $a$ y $b$.

**¿Aparece en parciales?** 🔴 Si — BFS y distancias minimas es tema central de 2P

---

### Ejercicio 6 — Arbol v-Geodesico de Menor Peso

**Enunciado**

Dado un grafo conexo $G$ con pesos en sus aristas y un vertice $v$, determinar el arbol de menor peso entre todos los arboles v-geodesicos (con distancias sin pesos). Justificar correctitud. Complejidad $O(n+m)$.

**Explicacion**

Las aristas que pueden pertenecer a algun arbol v-geodesico son exactamente las aristas $vw$ tal que $d_G(v,w)$ sin pesos es $d_G(v, \text{padre}) + 1$ (aristas del DAG BFS). Entre esas aristas, elegir las de menor peso. $O(n+m)$ con BFS + seleccion de minimos por nivel.

**Resolucion paso a paso**

**Observacion clave:** una arista $uw \in E(G)$ puede pertenecer a algun arbol v-geodesico si y solo si $d_G(v, w) = d_G(v, u) + 1$ (es decir, $uw$ es una arista del DAG BFS). Esto se debe a que en todo arbol v-geodesico, el padre de $w$ debe estar en el nivel anterior.

**Algoritmo:**
1. BFS sin pesos desde $v$ para calcular $d_G(v, u)$ para todo $u$ — $O(n+m)$.
2. Para cada vertice $w \neq v$: entre todos sus vecinos $u$ con $d_G(v, u) = d_G(v, w) - 1$, elegir el $u^*$ que minimiza $\text{peso}(uw)$.
3. El arbol $T$ con aristas $\{u^*\text{-}w : w \neq v\}$ es el arbol v-geodesico de menor peso.

**Correctitud:** Todo arbol v-geodesico usa solo aristas del DAG BFS. Para cada $w$, se elige independientemente el padre con menor arista — esta eleccion local es optima porque los pesos de los padres distintos no afectan entre si (cada vertice tiene exactamente un padre en el arbol). Greedy local correcto.

**Complejidad:** $O(n+m)$ — BFS + un escaneo de todas las aristas para seleccionar el minimo por cada vertice.

**Chuleta**

> 1. BFS sin pesos desde $v$ para calcular niveles.
> 2. Para cada vertice $w$: elegir el vecino $u$ de nivel anterior con menor $\text{peso}(uw)$.
> 3. Esas aristas forman el arbol v-geodesico de menor peso.
> 4. $O(n+m)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 7 — Recorrido de Longitud Par

**Enunciado**

Dado un digrafo $G$ y dos vertices $s$ y $t$, encontrar el recorrido de longitud par de $s$ a $t$ que use la menor cantidad de aristas.

a) Definir el digrafo bipartito $H$ con dos copias $v^0, v^1$ de cada vertice $v$, donde $v^i$ es adyacente a $w^{1-i}$ si $v$ y $w$ son adyacentes en $G$. Demostrar: $v_1, \ldots, v_k$ es un recorrido en $G$ $\Leftrightarrow$ $v_1^{i_1}, v_2^{1-i_1}, \ldots, v_k^{i_k}$ es un recorrido en $H$.

b) Definir $G^{=2}$ como el digrafo con los mismos vertices donde $v$ es adyacente a $w$ si existe $z$ con $v \to z \to w$ en $G$. Demostrar: $G$ tiene un recorrido de longitud $2k$ $\Leftrightarrow$ $G^{=2}$ tiene un recorrido de longitud $k$.

c) Disenar dos algoritmos basados en a) y b).

d) Justificar cual es mejor (complejidad, espacio, implementacion, generalizacion a longitud impar).

**Explicacion**

Construccion H: BFS en $H$ desde $s^0$ a $t^0$ da el camino par mas corto. Construccion $G^{=2}$: BFS en $G^{=2}$ — pero construir $G^{=2}$ cuesta $O(nm)$. H es mejor: $O(n+m)$ sin aumentar la complejidad y se generaliza facilmente a longitud impar (buscar $s^0$ a $t^1$).

**Resolucion paso a paso**

**Parte a) — Equivalencia en $H$:**

$H$ tiene vertices $\{v^0, v^1 : v \in V(G)\}$ y arista $v^i \to w^{1-i}$ para cada arco $v \to w \in E(G)$.

$(\Rightarrow)$ Si $v_1, v_2, \ldots, v_k$ es recorrido en $G$: el recorrido $v_1^0, v_2^1, v_3^0, \ldots$ en $H$ alterna los superindices. La arista $v_j^{i_j} \to v_{j+1}^{1-i_j}$ existe en $H$ porque $v_j \to v_{j+1}$ existe en $G$. Valido.

$(\Leftarrow)$ Analogo: dado recorrido en $H$, proyectando a los vertices base se obtiene recorrido en $G$.

**Consecuencia:** un recorrido de longitud $k$ de $s$ a $t$ en $G$ corresponde a un camino de longitud $k$ en $H$ de $s^0$ a $t^0$ (si $k$ par) o $t^1$ (si $k$ impar).

**Parte b) — Equivalencia con $G^{=2}$:**

$G^{=2}$: arco $v \to w$ si existe $z$ con $v \to z \to w$ en $G$.

Un recorrido de longitud $2k$ en $G$: $u_0, u_1, u_2, \ldots, u_{2k}$ equivale a tomar pasos de a 2: $u_0, u_2, u_4, \ldots, u_{2k}$ — recorrido de longitud $k$ en $G^{=2}$. La equivalencia es directa por construccion.

**Parte c) — Dos algoritmos:**

**Algoritmo basado en $H$:**
1. Construir $H$: $2|V|$ vertices, $2|E|$ aristas — $O(n+m)$.
2. BFS en $H$ desde $s^0$ hasta $t^0$ — $O(n+m)$.
3. La longitud del camino minimo en $H$ de $s^0$ a $t^0$ es el numero de aristas del recorrido par mas corto.

**Algoritmo basado en $G^{=2}$:**
1. Construir $G^{=2}$: para cada $v$ y cada par $v \to z \to w$, agregar $v \to w$. Costo: $O(n \cdot m)$ en el peor caso (un vertice con grado $m$).
2. BFS en $G^{=2}$ desde $s$ hasta $t$ — $O(n + m^2)$ en peor caso.
3. $d_{G^{=2}}(s,t) = k$ implica recorrido de longitud $2k$ en $G$.

**Parte d) — Comparacion:**

| Criterio | $H$ | $G^{=2}$ |
|---|---|---|
| Construccion | $O(n+m)$ | $O(nm)$ peor caso |
| Espacio extra | $O(n+m)$ | $O(n+m^2)$ peor caso |
| BFS | $O(n+m)$ | $O(n+m^2)$ |
| **Total** | $O(n+m)$ | $O(nm)$ |
| Longitud impar | $s^0$ a $t^1$ | No aplica directamente |

$H$ es claramente superior en complejidad, espacio e implementacion. La generalizacion a longitud impar es trivial en $H$: buscar el camino minimo de $s^0$ a $t^1$.

**Chuleta**

> **Construccion $H$:** duplicar vertices ($v^0$, $v^1$); aristas alternan superindice.
> - Recorrido par $s \to t$: BFS en $H$ de $s^0$ a $t^0$.
> - Recorrido impar $s \to t$: BFS en $H$ de $s^0$ a $t^1$.
> - $O(n+m)$ total.
>
> **$G^{=2}$:** es $O(nm)$ — evitar.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 8 ⋆ — Grilla con Transformacion de Valor

**Enunciado**

Se tiene una grilla de $m \times n$ posiciones con valores en $[0, k)$. Dado un objetivo $w$ y una posicion inicial $(x_1, y_1)$ con valor $v_1$, encontrar la minima cantidad de movimientos horizontales/verticales que transformen $v_1$ en $w$, donde el $i$-esimo movimiento transforma $v_i$ en $v_{i+1} = (v_i + z) \mod k$ con $z$ el valor de la casilla de destino.

Ejemplo (k=10): transformar $v_1 = 1$ en $w = 0$ en la grilla dada.

Modelar como problema de grafos y resolver con BFS en $O(kmn)$.

**Explicacion**

Estado: (posicion, valor\_actual) → $k \cdot m \cdot n$ estados. Aristas: desde $(pos, v)$ a $(pos', (v + z) \mod k)$ para cada posicion adyacente $pos'$ con valor $z$. BFS desde $(pos_{inicial}, v_1)$ hasta cualquier estado con valor $w$.

Este ejercicio aparece en [[recorrido_en_grafos_practica]] como "Luces" (variante con bitmask).

**Resolucion paso a paso**

**Modelado del grafo implicito:**

- **Estado:** $(pos, val)$ donde $pos = (i,j) \in \{1..m\} \times \{1..n\}$ y $val \in \{0, \ldots, k-1\}$.
- **Numero de estados:** $k \cdot m \cdot n$.
- **Aristas:** desde $(pos, v)$ hay aristas a $(pos', (v + z) \bmod k)$ para cada posicion adyacente $pos'$ (arriba, abajo, izquierda, derecha) con $z = \text{grilla}[pos']$.
- **Grado de cada estado:** a lo sumo 4 (cuatro direcciones).
- **Total de aristas:** $O(k \cdot m \cdot n)$.
- **Estado inicial:** $((x_1, y_1), v_1)$.
- **Estados objetivo:** cualquier $((i,j), w)$ para algun $(i,j)$.

**Algoritmo BFS:**
```
inicializar dist[pos][val] = infinito para todo (pos, val)
cola = [ ((x1, y1), v1) ]
dist[(x1, y1)][v1] = 0

mientras cola no vacia:
    (pos, val) = desencolar
    si val == w: retornar dist[pos][val]
    para cada vecino pos' de pos:
        z = grilla[pos']
        val' = (val + z) mod k
        si dist[pos'][val'] == infinito:
            dist[pos'][val'] = dist[pos][val] + 1
            encolar (pos', val')

retornar -1  # no alcanzable
```

**Complejidad:** $O(k \cdot m \cdot n)$ — cada estado visitado a lo sumo una vez, con a lo sumo 4 transiciones por estado.

**Correctitud:** BFS en grafo no ponderado da camino minimo en numero de aristas = numero minimo de movimientos.

**Chuleta**

> 1. Estado = (posicion en grilla, valor actual) — $k \cdot m \cdot n$ estados.
> 2. Transicion: moverse a $(i', j')$ cambia $val \to (val + \text{grilla}[i'][j']) \bmod k$.
> 3. BFS desde estado inicial hasta cualquier estado con $val = w$.
> 4. $O(kmn)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 9 — Minimo n con Resto y Suma de Digitos

**Enunciado**

Dados dos naturales $d > 0$ y $s > 0$, encontrar el minimo $n$ divisible por $d$ cuyos digitos sumen exactamente $s$, o reportar que no existe. Complejidad $O(ds)$.

Hint: descomponer $n = n_1 \ldots n_k$. Al agregar el digito $n_{i+1}$, el resto modulo $d$ cambia de $d_i$ a $(10 d_i + n_{i+1}) \mod d$, y la suma de digitos de $s_i$ a $s_i + n_{i+1}$.

**Explicacion**

Estado: (resto\_mod\_d, suma\_digitos) — hay $d \cdot s$ estados. BFS desde estado $(0, 0)$ (numero vacio) a estado $(0, s)$ (divisible por $d$ con digitos sumando $s$). Cada estado se expande con los 10 posibles digitos $0-9$. BFS da el minimo numero de digitos → minimo $n$. $O(ds)$.

**Resolucion paso a paso**

**Modelado:**

- **Estado:** $(r, \sigma)$ donde $r = n \bmod d$ ($0 \leq r < d$) y $\sigma$ = suma de digitos usados hasta ahora ($0 \leq \sigma \leq s$).
- **Numero de estados:** $d \cdot (s + 1)$.
- **Transicion:** al agregar digito $c \in \{0, \ldots, 9\}$:
$$(r, \sigma) \xrightarrow{c} ((10r + c) \bmod d,\ \sigma + c) \quad \text{si } \sigma + c \leq s$$
- **Estado inicial:** $(0, 0)$ — numero vacio (resto 0, suma 0).
- **Estado objetivo:** $(0, s)$ — divisible por $d$ con digitos sumando $s$.

**Algoritmo BFS:**
```
dist[r][sigma] = infinito para todo (r, sigma)
parent[r][sigma] = null
digito_usado[r][sigma] = -1

cola = [ (0, 0) ], dist[0][0] = 0

mientras cola no vacia:
    (r, sigma) = desencolar
    si (r, sigma) == (0, s): reconstruir y retornar n
    para c en rango(0, 10):  # digitos posibles
        r' = (10*r + c) mod d
        sigma' = sigma + c
        si sigma' <= s y dist[r'][sigma'] == infinito:
            dist[r'][sigma'] = dist[r][sigma] + 1
            parent[r'][sigma'] = (r, sigma)
            digito_usado[r'][sigma'] = c
            encolar (r', sigma')

retornar "no existe"
```

**Reconstruccion de $n$:** seguir punteros $\text{parent}[]$ desde $(0, s)$ hasta $(0, 0)$, recolectar digitos en orden inverso. El numero tiene la minima cantidad de digitos; entre todos los de esa longitud, BFS (expandiendo $c$ de 0 a 9 en orden) garantiza el lexicograficamente menor — que es el numericamente menor.

**Nota:** Si el numero no puede tener cero a la izquierda (numero natural > 0), en el primer paso solo expandir $c \in \{1, \ldots, 9\}$. Para $n = 0$ (si $d | 0$ y $s = 0$): caso especial.

**Complejidad:** $O(d \cdot s)$ — $d \cdot (s+1)$ estados, 10 transiciones por estado.

**Chuleta**

> 1. Estado = (resto mod $d$, suma de digitos acumulada).
> 2. BFS desde $(0, 0)$ hasta $(0, s)$.
> 3. Transicion con digito $c$: $r \to (10r + c) \bmod d$, $\sigma \to \sigma + c$.
> 4. BFS con $c$ en orden 0-9 da el numero lexicograficamente menor con minima cantidad de digitos.
> 5. $O(ds)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 10 — Luces de Habitaciones

**Enunciado**

Una persona esta en el cuarto 1 con las luces de los otros cuartos apagadas. Los interruptores de cada cuarto estan en otro cuarto. Nunca puede estar en una habitacion a oscuras. Debe llegar a su habitacion final sin que queden otras luces prendidas. La casa tiene a lo sumo 10 habitaciones.

Encontrar el camino mas corto.

**Explicacion**

Estado: (habitacion\_actual, bitmask\_de\_luces\_prendidas). Con a lo sumo 10 habitaciones: $10 \cdot 2^{10} = 10240$ estados. BFS en el grafo implicito de estados. Transicion: al moverse de habitacion $a$ a habitacion $b$, el bitmask se actualiza toggleando el interruptor en $b$ (o el interruptor que controla el cuarto del que se sale, dependiendo del modelo).

Este ejercicio aparece en [[recorrido_en_grafos_practica]] como "Luces" con BFS + bitmask.

**Resolucion paso a paso**

**Modelado:**

Sea $n \leq 10$ el numero de habitaciones. Cada habitacion $i$ tiene un interruptor $sw[i]$ que controla otra habitacion (al entrar a la habitacion $i$, se togglea el interruptor $sw[i]$, prendiendo o apagando la luz que controla).

- **Estado:** $(hab, luces)$ donde $hab \in \{1, \ldots, n\}$ es la habitacion actual y $luces \subseteq \{1, \ldots, n\}$ representado como bitmask (bit $i$ = 1 si la luz de la habitacion $i$ esta prendida).
- **Numero de estados:** $n \cdot 2^n \leq 10 \cdot 2^{10} = 10240$.
- **Estado inicial:** $(1,\ \{1\})$ — en habitacion 1, solo su luz prendida.
- **Estado objetivo:** $(hab\_final,\ \{hab\_final\})$ — en la habitacion final, solo esa luz prendida.
- **Restriccion de validez:** el estado $(hab, luces)$ es valido si $hab \in luces$ (la habitacion actual debe estar iluminada).

**Transicion:** desde $(hab, luces)$, moverse a habitacion vecina $hab'$:
$$luces' = luces \oplus (1 \ll sw[hab'])$$
(toggle del interruptor presente en $hab'$, que controla la habitacion $sw[hab']$).

La transicion es valida si $hab' \in luces'$ (el destino queda iluminado tras el toggle).

**Algoritmo BFS:**
```
dist[hab][luces] = infinito para todo estado
cola = [ (1, {1}) ], dist[1][{1}] = 0

mientras cola no vacia:
    (hab, luces) = desencolar
    si hab == hab_final y luces == {hab_final}: retornar dist[hab][luces]
    para cada vecino hab' de hab:
        luces' = luces XOR (1 << sw[hab'])
        si hab' esta prendido en luces' y dist[hab'][luces'] == infinito:
            dist[hab'][luces'] = dist[hab][luces] + 1
            encolar (hab', luces')

retornar "imposible"
```

**Complejidad:** $O(n \cdot 2^n)$ — cada estado visitado a lo sumo una vez.

**Correctitud:** BFS en el grafo implicito da el camino minimo en cantidad de movimientos. La restriccion de no estar en oscuras es chequeada en cada transicion.

**Chuleta**

> 1. Estado = (habitacion actual, bitmask de luces prendidas) — $n \cdot 2^n \leq 10240$ estados.
> 2. Transicion $hab \to hab'$: toggle de $sw[hab']$ (interruptor en destino).
> 3. Valido si destino queda iluminado en $luces'$.
> 4. BFS desde $(1, \{1\})$ hasta $(hab\_final, \{hab\_final\})$.
> 5. $O(n \cdot 2^n)$.

**¿Aparece en parciales?** 🔴 Si — grafo implicito con estado + BFS es patron evaluado en 2P

## Ver tambien

- [[arboles_teoria]] — BFS/DFS, timestamps, clasificacion de arcos
- [[grafos_teoria]] — Definiciones, representacion
- [[recorrido_en_grafos_practica]] — Ejercicios de clase: conectividad, bipartito, puentes, luces, orden topologico
- [[arboles_generadores_minimos_guia]] — Resto de la guia 4: AGM, minimax/maximin, ejercicios integradores
