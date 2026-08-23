---
nombre: Recorridos en Grafos — Clase Practica
parcial: 1P
programa: 2C_2026
tipo: practica
tema: recorrido_en_grafos
fuentes:
  vigente: []
  historico:
    - raw/clases/prac/8.prac_2P_recorrido_en_grafos.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[grafos_teoria]]"
  - "[[arboles_teoria]]"
  - "[[grafos_practica]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

## Patrones de este tema en parciales
> [[tipos_ejercicio/bfs_dfs_propiedades]] · [[tipos_ejercicio/cm_estado_expandido]]

---

## Repaso: DFS y BFS

### DFS (Depth-First Search)

Algoritmo recursivo que sigue la idea de backtracking: siempre avanza en profundidad hasta el final de la rama y luego retrocede. Funciona para grafos dirigidos y no dirigidos.

- **Complejidad:** $O(n + m)$ — cada nodo se visita una vez, cada arista se revisa una vez
- **Produce:** arbol/bosque DFS (vector de padres) + lista de backedges (aristas que generan ciclos)

### BFS (Breadth-First Search)

Recorre a lo ancho: primero todos los vecinos, luego los vecinos de los vecinos, etc. Implementacion iterativa con cola.

- **Complejidad:** $O(n + m)$
- **Produce:** arbol $v$-geodesico (las distancias en el arbol son iguales a las del grafo) + vector de distancias de $v$ a todos

---

## Ejercicios de clase

### Ejercicio 1 — Chequeo de conectividad

**Enunciado**
¿Como podemos ver que un grafo es conexo? Dado $G = (V, E)$, chequear si $\forall u, w \in V$, $\exists$ camino entre $u$ y $w$.

**Explicacion**
Correr DFS (o BFS) desde cualquier nodo y verificar si todos los nodos fueron visitados. Si se puede llegar a todos desde uno, el grafo es conexo.

**Resolucion paso a paso**
1. Correr DFS desde un nodo cualquiera (ej: nodo 0) — *por que: DFS alcanza todos los nodos de la componente conexa del nodo inicial*
2. Recorrer el vector de visitados — *por que: si alguna posicion es `false`, ese nodo no es alcanzable*
3. Si todos `true` → conexo. Si algun `false` → no conexo.

```cpp
// Correr DFS desde el primer nodo
dfs(FIRST_NODE)
// Verificar vector de visitados
for (int i = 0; i < visitados.size(); i++) {
    if (!visitados[i]) return false;
}
return true;
```

**Complejidad:** $O(n + m)$ (DFS) + $O(n)$ (recorrido del vector) = $O(n + m)$.

**Chuleta**
> 1. DFS/BFS desde cualquier nodo → 2. Recorrer vector visitados → 3. Todos `true` ↔ conexo

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bfs_dfs_propiedades]]

---

### Ejercicio 2 — Componentes conexas

**Enunciado**
Dar un algoritmo que dado un grafo devuelva la cantidad de componentes conexas que tiene.

**Explicacion**
Iterar sobre todos los nodos: si un nodo no fue visitado, correr DFS/BFS desde el e incrementar el contador de componentes.

**Resolucion paso a paso**
1. Inicializar `componentes ← 0` y vector de visitados en `false`
2. Para cada nodo $v$: si no fue visitado, correr DFS/BFS desde $v$ y sumar 1 a `componentes` — *por que: cada llamada a DFS recorre exactamente una componente conexa completa*
3. Retornar `componentes`

```
ContarComponentes(G):
  componentes ← 0
  Para cada v ∈ V:
    Si no visitado[v]:
      recorroAPartirDelVertice(v)  // DFS o BFS
      componentes ← componentes + 1
  Retornar componentes
```

**Complejidad:** $O(n + m)$ — cada nodo y arista se procesa una vez en total.

**Chuleta**
> 1. Iterar nodos → 2. Si no visitado: DFS/BFS + incrementar contador → 3. Total = componentes conexas

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — Rasta y los alfajores (contar caminos minimos con BFS + PD)

**Enunciado**
Calcular el numero de caminos con minima cantidad de cuadras entre la casa de Rasta ($R$) y la fabrica de alfajores ($F$) en un mapa de calles modelado como grafo.

**Explicacion**
Modelado: nodos = esquinas, aristas = cuadras. Primero BFS para obtener distancias, luego programacion dinamica para contar caminos minimos. Superposicion de subproblemas: un nodo puede tener multiples vecinos que estan un nivel mas cerca de $R$.

**Resolucion paso a paso**

1. **Modelar:** $G = (V, E)$ donde $V$ = esquinas, $E$ = cuadras
2. **BFS desde $F$:** obtener vector $\delta$ con distancias de $F$ a todos — *por que: BFS en grafos sin peso da distancias exactas*
3. **Definir funcion PD:**

$$\text{\#caminosHasta}(v) = \begin{cases} 1 & \text{si } v = R \\ \displaystyle\sum_{w^* \in N(v)} \text{\#caminosHasta}(w) & \text{en otro caso} \end{cases}$$

donde $w^* = \{w \in N(v) : \delta(w) + 1 = \delta(v)\}$ (vecinos que estan un nivel mas cerca de $R$).

4. **Calcular:** `#caminosHasta(F)` con memoizacion

**Complejidad:**
- BFS: $O(n + m)$
- PD: $O(n + m)$ — cada nodo se llena una vez en la memoizacion, y para cada nodo se revisan sus aristas
- **Total:** $O(n + m)$

**Chuleta**
> 1. BFS desde destino → vector distancias → 2. PD: `#caminos(v)` = suma de `#caminos(w)` para vecinos $w$ con $\delta(w) + 1 = \delta(v)$ → 3. Memoizar → $O(n + m)$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bfs_dfs_propiedades]]

---

### Ejercicio 4 — Chequeo de bipartito (Streamers y conflictos)

**Enunciado**
Dados $N$ streamers y $c$ pares de conflictos, determinar si se pueden armar dos canales sin conflictos internos. Modelar como grafo y resolver.

**Explicacion**
Modelado: nodos = streamers, aristas = conflictos. Queremos verificar si el grafo es **bipartito** (se puede 2-colorear). Usamos BFS: si dos nodos adyacentes tienen la misma paridad de distancia, hay un ciclo impar y no es bipartito.

**Definicion:** $G$ es bipartito $\iff$ $\exists V_1, V_2$ con $V_1 \cup V_2 = V$, $V_1 \cap V_2 = \emptyset$, y toda arista cruza entre $V_1$ y $V_2$.

**Lema:** $G$ es bipartito $\iff$ no tiene ningun ciclo impar.

**Resolucion paso a paso**
1. Para cada componente conexa no visitada, correr BFS — *por que: la particion debe funcionar en cada componente independientemente*
2. Asignar distancia 0 al nodo inicial; para cada vecino no visitado, asignar $\text{distancia} + 1$
3. Si se encuentra una arista $(u, v)$ con ambos ya visitados y $(\delta(u) - \delta(v)) \mod 2 = 0$: **no es bipartito** — *por que: misma paridad de distancia + arista = ciclo impar*
4. Si se recorren todas las componentes sin conflicto: **es bipartito**

```cpp
bool isBipartiteComponent(graph, n, start, distance[]) {
    Queue q; distance[start] = 0;
    enqueue(&q, start);
    while (!isEmpty(&q)) {
        int vertex = dequeue(&q);
        for (int neighbour in range(n)) {
            if (graph[vertex][neighbour]) {
                if (distance[neighbour] == -1) {
                    distance[neighbour] = 1 + distance[vertex];
                    enqueue(&q, neighbour);
                } else if ((distance[neighbour] - distance[vertex]) % 2 == 0) {
                    return false;  // ciclo impar
                }
            }
        }
    }
    return true;
}

bool isBipartite(graph, n) {
    int distance[MAX_NODES];
    for (int i = 0; i < n; i++) distance[i] = -1;
    for (int i = 0; i < n; i++) {
        if (distance[i] == -1) {
            if (!isBipartiteComponent(graph, n, i, distance))
                return false;
        }
    }
    return true;
}
```

**Complejidad:** $O(n + m)$ (BFS sobre todas las componentes).

**Chuleta**
> 1. Modelar conflictos como grafo → 2. BFS por componente, asignar distancias → 3. Si arista conecta nodos con misma paridad de distancia → ciclo impar → no bipartito → 4. Si todo OK → bipartito

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bfs_dfs_propiedades]]

---

### Ejercicio 5 — Aristas puente (DFS + cubren)

**Enunciado**
Dado $G$ conexo:
(a) Demostrar que $vw$ es puente $\iff$ $vw$ no pertenece a ningun ciclo de $G$.
(b) Dar un algoritmo lineal basado en DFS para encontrar todas las aristas puente.

**Explicacion**
Una arista es puente si al sacarla aumenta la cantidad de componentes conexas. Una backedge nunca puede ser puente. Los puentes son tree-edges que no tienen ninguna backedge que las "cubra".

**Parte (a) — Demostracion**

**IDA** ($vw$ puente $\Rightarrow$ $vw$ no pertenece a ningun ciclo):
- Por absurdo: suponer que $vw$ es puente y pertenece a un ciclo.
- Si pertenece a un ciclo, hay camino de $v$ a $w$ sin usar $vw$.
- Entonces al quitar $vw$, $v$ y $w$ siguen conectados → contradiccion con que $vw$ es puente. $\square$

**VUELTA** ($vw$ no en ningun ciclo $\Rightarrow$ $vw$ es puente):
- Por contrarreciproco: demostrar que $vw$ no es puente $\Rightarrow$ $vw$ pertenece a algun ciclo.
- Si $vw$ no es puente, $G' = G - \{vw\}$ sigue conexo.
- Existe camino $P$ de $v$ a $w$ en $G'$ (no usa $vw$).
- $P$ junto con la arista $vw$ forman un ciclo en $G$. $\square$

**Parte (b) — Algoritmo lineal**

**Idea clave:** para cada nodo $v$, calcular cuantas backedges "cubren" la arista de $v$ a su padre en el arbol DFS:

$$\text{cubren}(v) = \text{backConExtremoInferiorEn}(v) - \text{backConExtremoSuperiorEn}(v) + \sum_{w \in \text{hijos}(v)} \text{cubren}(w)$$

Si $\text{cubren}(v) = 0$, la arista de $v$ a su padre es **puente**.

**Algoritmo:**
1. **DFS con 3 estados** (no visto, en proceso, terminado): para cada nodo calcular `backConExtremoInferiorEn[v]` y `backConExtremoSuperiorEn[v]` — *cuando encontramos un nodo ya "en proceso" que no es el padre, es una backedge*
2. **PD sobre el arbol DFS:** calcular `cubren[v]` bottom-up con memoizacion
3. **Contar puentes:** $|\{v : \text{cubren}(v) = 0\}|$ — restar cantidad de componentes conexas (raices tambien tienen cubren = 0)

**Complejidad:**
- DFS: $O(n + m)$
- cubren (memoizacion): $O(n)$
- Contar puentes: $O(n)$
- **Total:** $O(n + m)$

**Chuleta**
> 1. DFS 3 estados → contar backedges inferior/superior por nodo → 2. PD bottom-up: $\text{cubren}(v) = \text{inferior}(v) - \text{superior}(v) + \sum \text{cubren(hijos)}$ → 3. Puente $\iff$ cubren = 0 (descontar raices)

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bfs_dfs_propiedades]]

---

### Ejercicio 6 — Luces en la casa (grafo implicito + BFS)

**Enunciado**
Igna compro una casa con $h \leq 10$ habitaciones. Las luces de cada habitacion se controlan desde otra. Igna quiere ir de la primera a la ultima habitacion por el camino mas corto, sin estar nunca a oscuras en la habitacion actual y terminando con todas las luces apagadas.

**Explicacion**
Modelado como **grafo implicito** donde cada nodo es un estado = (habitacion actual, configuracion de luces). Las aristas representan acciones validas (moverse + usar interruptores). Como el grafo no es ponderado, BFS da el camino minimo.

**Resolucion paso a paso**

1. **Modelar estado:** cada nodo = (habitacion, bitmask de luces) — *por que: necesitamos rastrear que luces estan prendidas*
2. **Cantidad de nodos:** $h \cdot 2^h$ — con $h \leq 10$, a lo sumo $10 \cdot 1024 = 10240$ nodos — *factible*
3. **Aristas:** de estado $A$ a estado $B$ si las habitaciones son adyacentes y con los interruptores de $A$ se puede configurar las luces de $B$ (la habitacion destino debe estar iluminada)
4. **Estado inicial:** (habitacion 1, solo luz de habitacion 1 prendida)
5. **Estado final:** (habitacion $h$, solo luz de habitacion $h$ prendida) — *al llegar apaga la ultima*
6. **Correr BFS** desde estado inicial → distancia al estado final = camino minimo

**Complejidad:** $O(h \cdot 2^h)$ en nodos y aristas — exponencial pero factible para $h \leq 10$.

**Chuleta**
> 1. Estado = (habitacion, bitmask luces) → 2. Grafo implicito: $h \cdot 2^h$ nodos → 3. BFS desde estado inicial → 4. Distancia al estado final = respuesta

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bfs_dfs_propiedades]]

---

### Ejercicio 7 — Orden topologico (DFS + stack)

**Enunciado**
Dado un digrafo $D$, un orden topologico es un ordenamiento $v_1 \ldots v_n$ de sus nodos tal que toda arista queda de la forma $v_i v_j$ con $i < j$ (aristas "van hacia adelante").

**Explicacion**
Solo existe si el digrafo es un DAG (sin ciclos). Se calcula con DFS: al terminar de procesar un nodo, pushearlo a un stack. El stack al final contiene el orden topologico.

**Resolucion paso a paso**
1. Verificar que el digrafo no tiene ciclos — con DFS de 3 estados: si encontramos un nodo "en proceso" desde otro "en proceso", hay ciclo — *por que: backedge en digrafo = ciclo*
2. Correr DFS modificado: al terminar de procesar un nodo (estado: "terminado"), pushearlo a un stack `finish`
3. El stack `finish` (de tope a fondo) da el orden topologico

```
OrdenTopologico(D):
  Verificar no hay ciclos (DFS)
  finish ← stack vacio
  Para cada v ∈ V no visitado:
    DFS_topologico(v, finish)
  Retornar finish (de tope a fondo)

DFS_topologico(v, finish):
  estado[v] ← EN_PROCESO
  Para cada w ∈ vecinos(v):
    Si estado[w] = NO_VISTO:
      DFS_topologico(w, finish)
  estado[v] ← TERMINADO
  push(finish, v)
```

**Complejidad:** $O(n + m)$.

**Chuleta**
> 1. Verificar DAG (sin ciclos) con DFS 3 estados → 2. DFS: al terminar nodo, push a stack → 3. Stack de tope a fondo = orden topologico

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bfs_dfs_propiedades]]

---

## Ver tambien

- [[grafos_teoria]] — definiciones, grado, caminos, conexidad, bipartitos (teorema ciclos impares)
- [[arboles_teoria]] — BFS y DFS (algoritmo generico, timestamps, clasificacion arcos tree/back/forward/cross), sort topologico, componentes fuertemente conexas
- [[grafos_practica]] — representacion de grafos, demostraciones sobre grafos (Handshaking, ciclos, conexidad)
