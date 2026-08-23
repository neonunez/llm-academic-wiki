---
nombre: Caminos Minimos — Guia de Ejercicios
parcial: 2P
programa: 2C_2026
tipo: guia
tema: caminos_minimos
fuentes:
  vigente: []
  historico:
    - raw/guias_practicas/5.guia_2P_recorrido_minimo.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[caminos_minimos_teoria]]"
  - "[[caminos_minimos_practica]]"
  - "[[caminos_minimos_todos_a_todos_y_dags_practica]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Caminos Minimos — Guia de Ejercicios

Practica 5: Recorrido minimo. 2do cuatrimestre 2025. Compilado: 4 nov. 2025.

27 ejercicios cubriendo Dijkstra, Bellman-Ford, Floyd-Warshall, DAGs, SRDs (Sistemas de Restricciones de Diferencias). Ejercicios marcados con ⋆ son el subconjunto minimo recomendado.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Aristas st-eficientes: caracterizacion + camino evitandolas | 🔴 Si |
| Ej. 2 | Arista de peso maximo en algun recorrido de s a t con cota de peso | ⚪ No |
| Ej. 3 | Camino minimo de s a t pasando por a lo sumo una arista negativa | ⚪ No |
| Ej. 4 | Aristas que mejoran el camino de s a t, demostrar correctitud | ⚪ No |
| Ej. 5 | Aristas criticas para s y t (las que aumentan la distancia al removerlas) | ⚪ No |
| Ej. 6 | Camino multiplicativo minimo → transformar en camino aditivo | 🔴 Si |
| Ej. 7 | Cabinas de peaje inverso: ciclos puro, modelado + Bellman-Ford | 🔴 Si |
| Ej. 8 | Contar caminos en un DAG, O(n+m) | 🔴 Si |
| Ej. 9 | Arbitraje de divisas: detectar ciclo positivo en log-peso | 🔴 Si |
| Ej. 10 | Robot maximizando energia con pesos negativos (Bellman-Ford) | ⚪ No |
| Ej. 11 | Puntajes con bonificaciones: DAG + ciclos positivos | ⚪ No |
| Ej. 12 | Rutas con reembolsos: detectar ciclos negativos alcanzables desde s a t | 🔴 Si |
| Ej. 13 | Analisis de Bellman-Ford: demos de k iteraciones + optimizacion de terminacion | 🔴 Si |
| Ej. 14 | Camino minimo con exactamente k aristas (PD) | ⚪ No |
| Ej. 15 | SRD: grafos de restricciones, solucion via Bellman-Ford | 🔴 Si |
| Ej. 16 | Posicionamiento uniforme de parentesis como SRD | ⚪ No |
| Ej. 17 | Clientes supermercado en linea: separacion via SRD | ⚪ No |
| Ej. 18 | Clientes supermercado en circulo: SRD circular | ⚪ No |
| Ej. 19 | SRD con ecuaciones + problema ICPC de mate dulce | ⚪ No |
| Ej. 20 | Matriz Floyd-Warshall: determinar si M es FW y reconstruir grafo minimo | ⚪ No |
| Ej. 21 | Arista st-eficiente para la mayor cantidad de pares s,t | ⚪ No |
| Ej. 22 | Conjunto geodesico: determinar si D es geodesico en O(n³) | ⚪ No |
| Ej. 23 | Camino minimo en DAG: recursion + PD top-down + bottom-up | 🔴 Si |
| Ej. 24 | Problema del vuelto como camino minimo en DAG | 🔴 Si |
| Ej. 25 | Gestion de proyectos: etapas criticas como camino minimo en DAG | 🔴 Si |
| Ej. 26 | Invariantes: comparar algoritmos para distintos tipos de grafos y problemas | 🔴 Si |
| Ej. 27 | Dijkstra/Bellman-Ford con tiempos de apertura en aristas | ⚪ No |

## Patrones de este tema en parciales

> Reduccion a CM · Modelado de estado · Dijkstra en grafo expandido · Bellman-Ford con ciclos negativos · Floyd sobre alfabeto/DAG

## Ejercicios

### Ejercicio 1 — Aristas st-Eficientes

**Enunciado**

Dado un digrafo $D$ con pesos $c: E(D) \to \mathbb{N}$ y dos vertices $s$ y $t$. Una arista $v \to w$ es st-eficiente cuando pertenece a algun camino minimo de $s$ a $t$.

a) Demostrar: $v \to w$ es st-eficiente $\Leftrightarrow$ $d(s,v) + c(v \to w) + d(w,t) = d(s,t)$.

b) Usando a), proponer un algoritmo eficiente que encuentre el minimo de los caminos entre $s$ y $t$ que no use aristas st-eficientes (o retornar $\perp$ si no existe).

**Explicacion**

a) Por definicion de camino minimo: la arista es eficiente si y solo si forma parte de un camino minimo optimo.

b) Ejecutar Dijkstra desde $s$ y desde $t$ (en el grafo traspuesto). Marcar aristas st-eficientes (usando a)). Construir subgrafo sin aristas eficientes y encontrar el camino minimo en ese subgrafo con Dijkstra. Este patron aparece en [[caminos_minimos_practica]] (Manuel y los Monstruos: DAG de caminos minimos).

**Resolucion paso a paso**

**Parte a) — Caracterizacion de aristas st-eficientes:**

$(\Rightarrow)$ Si $v \to w$ es st-eficiente, existe un camino minimo $s \leadsto v \to w \leadsto t$ de peso $d(s,t)$. El sub-camino $s \leadsto v$ tiene peso $\geq d(s,v)$ y el sub-camino $w \leadsto t$ tiene peso $\geq d(w,t)$. Sumando: $d(s,v) + c(v \to w) + d(w,t) \leq d(s,t)$. Pero $d(s,t)$ es el minimo entre $s$ y $t$, y cualquier camino de $s$ a $t$ que pase por $v \to w$ tiene peso $\geq d(s,v) + c(v \to w) + d(w,t)$. Entonces la desigualdad debe ser igualdad.

$(\Leftarrow)$ Si $d(s,v) + c(v \to w) + d(w,t) = d(s,t)$: concatenar el camino minimo $s \leadsto v$ (peso $d(s,v)$) + arista $v \to w$ + camino minimo $w \leadsto t$ (peso $d(w,t)$) produce un camino de peso total $d(s,t)$ → es camino minimo y contiene $v \to w$ → la arista es st-eficiente. $\square$

**Parte b) — Camino minimo sin aristas eficientes:**

1. Dijkstra desde $s$ en $D$ → $d_s[v]$ para todo $v$. $O(m \log n)$.
2. Dijkstra desde $t$ en el traspuesto $D^T$ → $d_t[w]$ para todo $w$ (equivalente a $d_D(w,t)$). $O(m \log n)$.
3. Para cada arista $v \to w$: marcarla como st-eficiente si $d_s[v] + c(v \to w) + d_t[w] = d_s[t]$. $O(m)$.
4. Construir $D' = D$ sin aristas st-eficientes.
5. Dijkstra en $D'$ desde $s$ hasta $t$ → retornar $d_{D'}(s,t)$, o $\perp$ si $t$ no es alcanzable. $O(m \log n)$.

Complejidad total: $O(m \log n)$.

**Chuleta**

> **st-eficiente:** $v \to w \in$ algun CM $\Leftrightarrow$ $d(s,v) + c(v \to w) + d(w,t) = d(s,t)$.
>
> **CM sin eficientes:**
> 1. Dijkstra desde $s$ y desde $t$ (traspuesto).
> 2. Marcar aristas eficientes con la condicion.
> 3. Dijkstra en el subgrafo sin eficientes.

**¿Aparece en parciales?** 🔴 Si — DAG de caminos minimos y st-eficiencia aparece en practica de clase

---

### Ejercicio 2 — Arista de Peso Maximo con Cota

**Enunciado**

Dado un digrafo pesado $G$, dos vertices $s$ y $t$ y una cota $c$, determinar una arista de peso maximo de entre aquellas que se encuentran en algun recorrido de $s$ a $t$ cuyo peso sea a lo sumo $c$. Demostrar correctitud.

**Explicacion**

Ejecutar Dijkstra desde $s$ y desde $t$ (traspuesto). Para cada arista $u \to v$, verificar si esta en algun recorrido de peso $\leq c$: $d(s,u) + c(u \to v) + d(v,t) \leq c$. Entre esas aristas, elegir la de peso maximo. $O(m \log n)$.

**Resolucion paso a paso**

1. Dijkstra desde $s$ → $d_s[u]$ para todo $u$. $O(m \log n)$.
2. Dijkstra desde $t$ en el traspuesto → $d_t[v]$ para todo $v$. $O(m \log n)$.
3. Para cada arista $u \to v$ con peso $w_{uv}$:
   - Verificar si existe algun recorrido de $s$ a $t$ que pase por esta arista con peso total $\leq c$: $d_s[u] + w_{uv} + d_t[v] \leq c$.
   - Si si, es candidata.
4. Retornar la candidata con mayor $w_{uv}$.

**Correctitud:** La condicion $d_s[u] + w_{uv} + d_t[v] \leq c$ garantiza que existe un camino $s \leadsto u \to v \leadsto t$ de peso $\leq c$ usando los caminos minimos hacia $u$ y desde $v$. Si no hay camino de peso $\leq c$ que use $u \to v$ con los caminos minimos, tampoco lo hay con caminos no-minimos (solo empeorarían).

**Chuleta**

> 1. Dijkstra desde $s$ y desde $t$ (traspuesto).
> 2. Arista $u \to v$ elegible si $d_s[u] + w_{uv} + d_t[v] \leq c$.
> 3. Retornar la elegible de mayor peso.
> 4. $O(m \log n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — Camino con a lo Sumo una Arista Negativa

**Enunciado**

Dado un digrafo pesado $G$ y dos vertices $s$ y $t$, determinar el recorrido minimo de $s$ a $t$ que pasa por a lo sumo una arista de peso negativo. Demostrar correctitud.

**Explicacion**

Expansion de estado: estado $(v, k)$ donde $k \in \{0, 1\}$ = numero de aristas negativas usadas hasta ahora. Dijkstra en el grafo expandido: si la arista es no-negativa, la transicion es normal; si es negativa, solo se puede usar si $k = 0$. Si los pesos no-negativos son $\geq 0$, Dijkstra funciona. $O((n+m) \log n)$.

**Resolucion paso a paso**

**Grafo expandido $H$:**
- Vertices: $\{(v, 0) : v \in V\} \cup \{(v, 1) : v \in V\}$ — $2n$ vertices.
- Aristas:
  - Si $u \to v$ con peso $w \geq 0$: aristas $(u,0) \to (v,0)$ y $(u,1) \to (v,1)$, ambas de peso $w$.
  - Si $u \to v$ con peso $w < 0$: arista $(u,0) \to (v,1)$ de peso $w$ (usar la arista negativa transiciona de $k=0$ a $k=1$). No hay arista desde $(u,1)$ (ya se uso la negativa).

La distancia en $H$ de $(s,0)$ a $(t,0)$ o $(t,1)$ da el CM con a lo sumo una arista negativa. La respuesta es $\min(d_H((s,0),(t,0)),\ d_H((s,0),(t,1)))$.

**Algoritmo:**

Fase 1: Dijkstra desde $s$ solo con aristas no-negativas → $d_0[v]$ (CM sin aristas negativas).

Fase 2: Para cada arista negativa $u \to v$ con peso $w < 0$: candidato inicial para $(v, 1)$ = $d_0[u] + w$. Dijkstra desde todos los $(v,1)$ con distancias iniciales → $d_1[t]$ (CM con exactamente una arista negativa usada en algun punto antes de $v$).

Respuesta: $\min(d_0[t], d_1[t])$.

Complejidad: $O((n+m) \log n)$.

⚠️ Verificar — Si las aristas negativas crean distancias negativas en el estado $(v,1)$, Dijkstra en la segunda fase podria fallar. El supuesto es que los pesos no-negativos son $\geq 0$, lo que garantiza que desde $(v,1)$ solo se usan aristas no-negativas. La fase 2 de Dijkstra es valida.

**Chuleta**

> 1. Estado $(v, k)$ con $k \in \{0,1\}$ = numero de aristas negativas usadas.
> 2. Dijkstra fase 1: CM sin aristas negativas → $d_0[v]$.
> 3. Fase 2: inicializar $(v,1)$ con $d_0[u] + w$ para cada arista negativa $u \to v$. Dijkstra sobre aristas no-negativas → $d_1[t]$.
> 4. Respuesta: $\min(d_0[t], d_1[t])$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — Aristas que Mejoran el Camino

**Enunciado**

Sea $G$ un digrafo con pesos positivos con vertices especiales $s$ y $t$. Para una arista $e \notin E(G)$, $e$ mejora el camino si $d_G(s,t) > d_{G+e}(s,t)$.

Dado un conjunto de aristas $E \notin E(G)$ con pesos positivos, determinar cuales mejoran el camino de $s$ a $t$. Demostrar correctitud.

**Explicacion**

Ejecutar Dijkstra desde $s$ y desde $t$ (traspuesto). Una arista $u \to v$ con peso $w$ mejora el camino $\Leftrightarrow$ $d(s,u) + w + d(v,t) < d(s,t)$. Verificar en $O(1)$ por arista. Total: $O((n+m) \log n + |E|)$.

**Resolucion paso a paso**

1. Dijkstra desde $s$ en $G$ → $d_s[u]$ para todo $u$. $O(m \log n)$.
2. Dijkstra desde $t$ en el traspuesto $G^T$ → $d_t[v]$ para todo $v$. $O(m \log n)$.
3. Para cada arista candidata $e = (u \to v)$ con peso $w$:
   - $e$ mejora el camino $\Leftrightarrow$ $d_s[u] + w + d_t[v] < d_s[t]$.
   - Verificar en $O(1)$.

**Correctitud:** Si $d_s[u] + w + d_t[v] < d(s,t)$, el camino $s \leadsto u \to v \leadsto t$ en $G + e$ tiene peso $< d(s,t)$, luego $d_{G+e}(s,t) < d(s,t)$. La vuelta es inmediata: si la arista mejora, debe existir un camino mas corto que pasa por $u \to v$.

**Chuleta**

> Dijkstra desde $s$ y $t$ (traspuesto). Arista $u \to v$ mejora $\Leftrightarrow$ $d_s[u] + w + d_t[v] < d_s[t]$. $O(1)$ por arista.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 — Aristas Criticas

**Enunciado**

Sea $G$ un digrafo con pesos positivos y vertices especiales $s$ y $t$. Una arista $e \in E(G)$ es critica para $s$ y $t$ cuando $d_G(s,t) < d_{G-e}(s,t)$.

Determinar las aristas de $G$ criticas para $s$ y $t$. Demostrar correctitud.

Hint: pensar en el subgrafo $P$ de $G$ formado por las aristas de caminos minimos de $G$ (grafo de caminos minimos, equivalente al DAG de aristas st-eficientes).

**Explicacion**

Una arista es critica $\Leftrightarrow$ es st-eficiente (ver Ej. 1) Y es un "puente" en el DAG de caminos minimos (su remocion no tiene alternativa). Determinar las aristas-puente del DAG de caminos minimos con DFS.

**Resolucion paso a paso**

**Observacion:** Una arista $e$ es critica $\Leftrightarrow$:
1. $e$ es st-eficiente (de lo contrario, $d_{G-e}(s,t) = d_G(s,t)$ — ningun camino minimo la usaba).
2. $e$ es "puente" en el DAG de caminos minimos $P_{st}$ (si se elimina, no hay otro camino minimo de $s$ a $t$).

**Algoritmo:**

1. Dijkstra desde $s$ y desde $t$ (traspuesto) → $d_s[]$ y $d_t[]$. $O(m \log n)$.
2. Construir el DAG de caminos minimos $P_{st}$: incluir arista $u \to v$ si $d_s[u] + c(u \to v) + d_t[v] = d_s[t]$. $O(m)$.
3. Encontrar puentes de $P_{st}$ con DFS + $low[]$. $O(n + |P_{st}|) = O(n+m)$.
4. Las aristas criticas = puentes en $P_{st}$.

**Correctitud:** Si $e$ es puente en $P_{st}$, removerla desconecta $s$ de $t$ en $P_{st}$, es decir, no hay camino minimo sin $e$ → $d_{G-e}(s,t) > d_G(s,t)$. Si $e$ no es puente en $P_{st}$ pero es st-eficiente: hay otro camino minimo en $P_{st}$ que no usa $e$ → $d_{G-e}(s,t) = d_G(s,t)$ → no es critica.

**Chuleta**

> 1. Dijkstra desde $s$ y $t$ (traspuesto).
> 2. Construir DAG $P_{st}$ con aristas st-eficientes.
> 3. DFS + $low[]$ en $P_{st}$ para encontrar puentes.
> 4. Criticas = puentes en $P_{st}$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 6 — Camino Multiplicativo Minimo

**Enunciado**

En un digrafo $D$ pesado con $c: E(G) \to \mathbb{R}_{>1}$, el peso multiplicativo de un camino $v_1, \ldots, v_k$ es el producto de los pesos de sus aristas. Encontrar el camino de peso multiplicativo minimo.

Modelar como camino minimo aditivo. Demostrar correctitud.

**Explicacion**

Transformacion: $c'(e) = \log c(e)$. El producto se convierte en suma. Como $c(e) > 1$, $c'(e) > 0$ → Dijkstra funciona. El camino de menor suma de $\log c(e)$ corresponde al de menor producto. Para probabilidades: usar $-\log$ para maximizar.

**Resolucion paso a paso**

**Transformacion:**

Sea $P = v_1, v_2, \ldots, v_k$ un camino. Su peso multiplicativo es:
$$\prod_{i=1}^{k-1} c(v_i \to v_{i+1})$$

Aplicar logaritmo (monotono y positivo para $c > 1$):
$$\log \prod_{i=1}^{k-1} c(v_i \to v_{i+1}) = \sum_{i=1}^{k-1} \log c(v_i \to v_{i+1})$$

Minimizar el producto $\Leftrightarrow$ minimizar la suma de $\log c(e)$.

**Propiedades:**
- Como $c(e) > 1$: $\log c(e) > 0$ → todos los pesos transformados son positivos → Dijkstra funciona.
- La transformacion es biyectiva y monotona → el camino optimo bajo $c'$ es el mismo que bajo $c$.

**Algoritmo:**
1. Construir $D'$ con $c'(e) = \ln c(e)$ (o $\log_2$ o cualquier base). $O(m)$.
2. Dijkstra en $D'$ desde el origen. $O(m \log n)$.
3. El camino minimo en $D'$ es el multiplicativamente minimo en $D$.

**Variante para probabilidades** (maximizar producto de probabilidades $p(e) \in (0,1)$):
$$c'(e) = -\log p(e) > 0 \quad (\text{pues } p(e) < 1)$$
Minimizar $\sum -\log p(e)$ $\Leftrightarrow$ maximizar $\prod p(e)$.

**Chuleta**

> - Peso multiplicativo → aditivo: $c'(e) = \ln c(e)$.
> - Valido si $c(e) > 1$ (garantiza $c'(e) > 0$ → Dijkstra).
> - Para max producto de probabilidades: $c'(e) = -\ln p(e)$, minimizar.
> - $O(m \log n)$.

**¿Aparece en parciales?** 🔴 Si — transformacion logaritmica de pesos multiplicativos es evaluado en 2P

---

### Ejercicio 7 — Cabinas de Peaje Inverso

**Enunciado**

La ciudad de Ciclos Positivos implementa cabinas de peaje inverso (pagan al conductor). Los costos: $c_{ij} > 0$ para viajar de cabina $i$ a $j$, $c_i$ para la cabina $i$ ($c_i < 0$ si es inversa).

a) Modelar el problema de determinar si la ciudad permite el negocio del ciclo pure (ganancia que tiende a infinito) cuando el costo total de un camino puede ser negativo.

b) Dar un algoritmo y su complejidad.

La ciudad decide usar cabinas mixtas: si se cobro en la cabina anterior, la cabina mixta paga; si se pago, la cabina mixta cobra.

c) Modelar el problema de determinar si hay ciclos pure con la nueva configuracion.

**Explicacion**

a) Ciclo pure = ciclo de costo total negativo en el grafo de cabinas (donde el peso de cada arco $i \to j$ es $c_{ij} + c_j$). Usar Bellman-Ford para detectar ciclos negativos. $O(VE)$.

b) Bellman-Ford con $n-1$ relajaciones + una mas: si hay cambio, hay ciclo negativo.

c) Expansion de estado: $(cabina, cobro\_o\_pago\_anterior)$. Doble el grafo. En el grafo expandido, detectar ciclos negativos con Bellman-Ford.

Este problema es esencialmente el de [[caminos_minimos_practica]] (Manuel y los Monstruos: puntaje no acotado ↔ ciclo positivo alcanzable).

**Resolucion paso a paso**

**Parte a) — Modelado con ciclos puros:**

El costo total de un camino $i_0 \to i_1 \to \ldots \to i_k$ es:
$$\sum_{j=0}^{k-1} c_{i_j i_{j+1}} + \sum_{j=1}^{k} c_{i_j} = \sum_{j=0}^{k-1} (c_{i_j i_{j+1}} + c_{i_{j+1}})$$

(cada cabina visitada excepto la inicial contribuye $c_j$; la arista contribuye $c_{ij}$).

Definir el grafo $D$: vertice por cabina, arco $i \to j$ con peso $w_{ij} = c_{ij} + c_j$.

Un ciclo pure = ciclo de peso total $< 0$ en $D$.

**Parte b) — Algoritmo Bellman-Ford:**

Bellman-Ford en $D$ para detectar ciclos negativos:
1. Inicializar $d[v] = 0$ para todo $v$ (o agregar un super-fuente con aristas de peso 0).
2. Ejecutar $n-1$ relajaciones.
3. Ejecutar una relajacion mas: si algun $d[v]$ cambia → hay ciclo negativo → ciclo pure.

Complejidad: $O(nm)$ donde $n$ = numero de cabinas, $m$ = numero de conexiones.

**Parte c) — Cabinas mixtas (expansion de estado):**

Sea $M$ el conjunto de cabinas mixtas. El costo de pasar por una cabina mixta $j$ depende del estado de la cabina anterior:
- Estado anterior "cobrado" ($c_i > 0$): cabina mixta $j$ paga → contribuye $-|c_j|$.
- Estado anterior "pagado" ($c_i \leq 0$): cabina mixta $j$ cobra → contribuye $+|c_j|$.

**Grafo expandido $D'$:** vertices $(i, \text{cobrado})$ y $(i, \text{pagado})$ para cada cabina $i$.

Transicion de $(i, \text{estado})$ a $(j, \text{nuevo\_estado})$ via arco $i \to j$:
- Si $j$ es normal ($c_j > 0$, cobra): nuevo\_estado = cobrado. Peso = $c_{ij} + c_j$.
- Si $j$ es inversa ($c_j < 0$, paga): nuevo\_estado = pagado. Peso = $c_{ij} + c_j$.
- Si $j$ es mixta: nuevo\_estado depende de estado anterior (si cobrado → mixta paga; si pagado → mixta cobra).

Detectar ciclos negativos en $D'$ con Bellman-Ford. Complejidad: $O(nm)$ con $2n$ vertices.

**Chuleta**

> **a/b:** Grafo $D$ con arco $i \to j$ de peso $c_{ij} + c_j$. Ciclo pure = ciclo negativo. Bellman-Ford $O(nm)$.
>
> **c:** Estado expandido $(cabina, cobrado/pagado)$. Cabina mixta invierte su costo segun estado anterior. Bellman-Ford en grafo expandido $O(nm)$.

**¿Aparece en parciales?** 🔴 Si — deteccion de ciclos negativos (o positivos equivalentes) es evaluado

---

### Ejercicio 8 — Contar Caminos en un DAG

**Enunciado**

Proponer un algoritmo en tiempo $O(n+m)$ para contar la cantidad de caminos en un DAG.

**Explicacion**

PD en orden topologico: $f(v)$ = cantidad de caminos desde $v$ hasta algun sumidero. $f(t) = 1$ para todo sumidero $t$. $f(v) = \sum_{v \to w \in E} f(w)$ para el resto. Procesar en orden topologico inverso. $O(n+m)$.

Para contar caminos entre dos vertices $s$ y $t$ especificos: misma idea pero solo desde $s$.

**Resolucion paso a paso**

**Contar todos los caminos desde cualquier fuente hasta cualquier sumidero:**

- Sumidero: vertice sin aristas salientes.
- $f(v)$ = cantidad de caminos que parten de $v$.
- Caso base: $f(t) = 1$ para todo sumidero $t$.
- Recurrencia: $f(v) = \sum_{v \to w \in E} f(w)$.
- Orden de computo: topologico inverso (de sumideros hacia fuentes).

La cantidad total de caminos es $\sum_{\text{fuente } s} f(s)$.

**Contar caminos de $s$ a $t$ especificos:**

- $f(v)$ = cantidad de caminos de $v$ a $t$.
- Caso base: $f(t) = 1$.
- Recurrencia: $f(v) = \sum_{v \to w \in E} f(w)$ para $v \neq t$.
- Respuesta: $f(s)$.
- Orden: topologico inverso desde $t$.

**Algoritmo $O(n+m)$:**
```
Ordenar vertices en orden topologico.
f[t] = 1 para cada sumidero t.
f[v] = 0 para el resto.
Para v en orden topologico inverso (de sumideros a fuentes):
    si v no es sumidero:
        f[v] = sum(f[w] para v → w en E)
Retornar f[s]
```

**Nota:** La cantidad de caminos puede ser exponencial en $n$ — el resultado se retorna como entero grande.

**Chuleta**

> PD en orden topologico inverso. $f[t]=1$, $f[v] = \sum_{v \to w} f[w]$. $O(n+m)$.

**¿Aparece en parciales?** 🔴 Si — contar caminos en DAG es evaluado en 2P (CM en DAG via PD)

---

### Ejercicio 9 — Arbitraje de Divisas

**Enunciado**

Se tienen $n$ monedas y tipos de cambio $r_{ij}$ (de moneda $i$ a $j$). Un arbitraje es un ciclo de conversiones que multiplica la cantidad inicial por $> 1$.

a) Modelar el problema de detectar si existe un arbitraje como un problema de camino minimo.
b) Disenar un algoritmo para detectar arbitrajes y, si existe, mostrar la secuencia de conversiones.
c) Complejidad.

**Explicacion**

Transformacion: $c'(i \to j) = -\log(r_{ij})$. Un arbitraje es un ciclo de producto $> 1$, es decir, de suma de $-\log$ negativa → ciclo negativo. Usar Bellman-Ford. Si detecta ciclo negativo, trazarlo hacia atras en el arreglo de padres. $O(nm)$.

**Resolucion paso a paso**

**Parte a) — Modelado:**

Un arbitraje es un ciclo de conversiones $i_0 \to i_1 \to \ldots \to i_k \to i_0$ tal que:
$$r_{i_0 i_1} \cdot r_{i_1 i_2} \cdots r_{i_{k-1} i_0} > 1$$

Aplicar $-\log$ (transformacion monotona decreciente para productos):
$$-\log\prod r_{i_j i_{j+1}} = \sum -\log r_{i_j i_{j+1}} < 0 \quad \Leftrightarrow \quad \text{ciclo negativo}$$

Definir $c'(i \to j) = -\log r_{ij}$. Un arbitraje $\Leftrightarrow$ ciclo negativo en el grafo con pesos $c'$.

**Parte b) — Algoritmo:**

1. Construir grafo $D$ con $n$ monedas como vertices y arcos $i \to j$ con peso $c'(i \to j) = -\log r_{ij}$. $O(n^2)$.
2. Agregar super-fuente $s$ con arcos de peso 0 a todos los vertices.
3. Bellman-Ford desde $s$ con $n$ iteraciones (en lugar de $n-1$):
   - Si en la iteracion $n$ hay alguna actualizacion: hay ciclo negativo → arbitraje.
   - Tomar el vertice $v$ que fue actualizado en la iteracion $n$.
4. Para recuperar el ciclo: seguir $n$ veces los punteros $\text{parent}[v]$ desde $v$ (se garantiza que se entra en el ciclo). Luego trazar el ciclo desde ese punto.

**Parte c) — Complejidad:**

- $n$ monedas, $n^2$ tipos de cambio (grafo completo).
- Bellman-Ford: $O(n \cdot n^2) = O(n^3)$.

**Chuleta**

> 1. $c'(i \to j) = -\log r_{ij}$. Arbitraje = ciclo negativo.
> 2. Super-fuente + Bellman-Ford con $n$ iteraciones.
> 3. Si hay actualizacion en iteracion $n$: ciclo negativo → arbitraje.
> 4. Recuperar ciclo siguiendo $\text{parent}[]$ desde el vertice actualizado.
> 5. $O(n^3)$ para grafo de $n$ monedas.

**¿Aparece en parciales?** 🔴 Si — arbitraje/ciclos negativos es patron evaluado

---

### Ejercicio 10 — Robot Maximizando Energia

**Enunciado**

Un robot va de $s$ a $t$ en un digrafo $D$ con costos energeticos $c(v \to w)$ (pueden ser negativos: estaciones de carga). El robot quiere llegar a $t$ con la maxima energia posible.

a) Modelar como camino minimo.
b) ¿Que condicion garantiza que el problema tiene solucion? ¿Que significa en el mapa?
c) Algoritmo cuando existe solucion.

**Explicacion**

Negar pesos: minimizar $\sum -c(e)$ es maximizar energia. Si hay ciclos de carga neta positiva alcanzables desde $s$ con acceso a $t$, la energia es ilimitada (no hay solucion). La condicion de solucion: no hay ciclos de peso negativo en el grafo de pesos negados que sean alcanzables y desde los que se alcance $t$. Usar Bellman-Ford con deteccion de ciclos negativos relevantes.

**Resolucion paso a paso**

**Parte a) — Modelado:**

Maximizar $\sum c(e)$ a lo largo del camino $\Leftrightarrow$ minimizar $\sum (-c(e))$.

Definir $c'(e) = -c(e)$. El problema se convierte en CM con pesos $c'$ (que pueden ser negativos).

**Parte b) — Condicion de solucion:**

El problema no tiene solucion (energia ilimitada) si existe un ciclo de peso negativo en el grafo con pesos $c'$ que sea:
- Alcanzable desde $s$, Y
- Co-alcanzable hacia $t$ (desde el ciclo se puede llegar a $t$).

Semantica en el mapa: el robot puede dar vueltas infinitas en un ciclo de "estaciones de carga neta positiva" que esta en el camino de $s$ a $t$.

La condicion de existencia de solucion: no existe tal ciclo.

**Parte c) — Algoritmo:**

1. Calcular vertices alcanzables desde $s$: DFS desde $s$ en $D$ → conjunto $A$.
2. Calcular vertices co-alcanzables a $t$: DFS desde $t$ en el traspuesto $D^T$ → conjunto $B$.
3. Bellman-Ford desde $s$ con pesos $c'$, restringido a vertices en $A$.
4. Si en la iteracion $n$ hay actualizacion en algun vertice de $A \cap B$: no hay solucion.
5. Si no: retornar $-d_{c'}(s,t)$ como energia maxima.

Complejidad: $O(nm)$.

**Chuleta**

> 1. Negar pesos: $c'(e) = -c(e)$. Maximizar energia = minimizar $\sum c'$.
> 2. No hay solucion si hay ciclo negativo (en $c'$) alcanzable desde $s$ y co-alcanzable a $t$.
> 3. Verificar con Bellman-Ford + DFS desde $s$ y $t$ (traspuesto).
> 4. $O(nm)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 11 — Puntajes con Bonificaciones

**Enunciado**

En un videojuego, un jugador va del nivel 1 al nivel $n$ por caminos directos con puntaje $p(i \to j)$ (positivo o negativo). Hay caminos especiales con bonificaciones muy grandes.

a) Si el jugador puede recorrer cada camino a lo sumo una vez, encontrar la ruta de puntaje maximo del nivel 1 al $n$.
b) Si puede recorrer multiples veces, ¿cuando es posible obtener puntaje infinito?
c) Si es posible obtener puntaje infinito pasando por el nivel $n$, encontrar una secuencia de movimientos que lo demuestre.

**Explicacion**

a) Negar pesos + camino minimo en el DAG de niveles ($i < j$ implica $i \to j$). $O(n+m)$.
b) Puntaje infinito $\Leftrightarrow$ hay un ciclo positivo alcanzable desde el nivel 1 y desde el que se puede llegar al nivel $n$ (usando Bellman-Ford con pesos negados → ciclo negativo).
c) Trazarlo con Bellman-Ford: iterar $> n-1$ veces para encontrar el vertice que sigue mejorando.

**Resolucion paso a paso**

**Parte a) — Ruta de puntaje maximo en el DAG:**

El grafo es un DAG (si $i < j$ implica $i \to j$, no hay ciclos). Negar pesos $c'(e) = -p(e)$ y aplicar CM en DAG.

```
d[1] = 0; d[v] = +inf para v != 1
Para v en orden topologico (1, 2, ..., n):
    Para cada v → w:
        d[w] = min(d[w], d[v] + c'(v→w))
Retornar -d[n]
```

Complejidad: $O(n+m)$.

**Parte b) — Condicion de puntaje infinito:**

Si los niveles pueden recorrerse multiples veces (el grafo ya no es DAG), el puntaje es infinito si y solo si existe un ciclo de puntaje positivo (ciclo negativo en $c'$) que sea alcanzable desde el nivel 1 y co-alcanzable al nivel $n$.

Usar Bellman-Ford con pesos negados. Si hay ciclo negativo relevante: puntaje infinito.

**Parte c) — Encontrar el ciclo:**

Con Bellman-Ford ejecutando $> n-1$ iteraciones:
1. El vertice $v$ que sigue actualizandose en la iteracion $n$ esta en o es alcanzable desde un ciclo negativo.
2. Seguir $\text{parent}[v]$ durante $n$ pasos → se garantiza estar dentro del ciclo.
3. Trazar el ciclo desde ese vertice.

**Chuleta**

> **a)** DAG → negar pesos → CM en DAG → $O(n+m)$.
> **b)** Ciclo positivo (puntaje $> 0$) alcanzable desde 1 y co-alcanzable a $n$ → puntaje infinito. Bellman-Ford.
> **c)** Vertice que actualiza en iteracion $n$ de BF → seguir $n$ pasos en parent[] → ciclo.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 12 — Rutas con Peajes y Reembolsos

**Enunciado**

Una empresa debe enviar camiones de $s$ a $t$ en una red con costos $c(i \to j)$ (pueden ser negativos: reembolsos).

a) Detectar si existe algun ciclo donde al recorrerlo se obtiene dinero neto (costo total negativo).
b) Si existe tal ciclo, determinar si puede aprovecharse en una ruta de $s$ a $t$.
c) Complejidad.

**Explicacion**

a) Bellman-Ford: si despues de $n-1$ iteraciones hay relajaciones posibles, hay un ciclo negativo.
b) El ciclo negativo debe ser alcanzable desde $s$ y desde el mismo debe poderse llegar a $t$. DFS desde $s$ en el grafo original + DFS hacia atras desde $t$ en el grafo traspuesto para identificar vertices alcanzables desde $s$ que puedan llegar a $t$.

**Resolucion paso a paso**

**Parte a) — Detectar ciclos negativos:**

Bellman-Ford desde algun vertice con super-fuente (arcos de peso 0 a todos):
1. Inicializar $d[v] = 0$ para todo $v$.
2. Ejecutar $n-1$ iteraciones de relajacion.
3. Ejecutar una iteracion mas: si hay actualizaciones → ciclo negativo.

**Parte b) — Ciclo negativo aprovechable:**

Para que el ciclo negativo sea aprovechable en una ruta $s \to t$, debe ser:
- Alcanzable desde $s$: DFS/BFS desde $s$ → conjunto $A$ de vertices alcanzables.
- Co-alcanzable a $t$: DFS/BFS desde $t$ en el traspuesto → conjunto $B$.
- El ciclo negativo contiene un vertice en $A \cap B$.

Algoritmo:
1. DFS desde $s$ → $A$.
2. DFS desde $t$ en $D^T$ → $B$.
3. Bellman-Ford desde $s$ (solo relajando vertices en $A$).
4. Si hay vertice en $A \cap B$ que actualiza en la iteracion $n$: el ciclo negativo es aprovechable → costo de $s$ a $t$ es $-\infty$.

**Parte c) — Complejidad:**

$O(nm)$ (Bellman-Ford domina). Los DFS son $O(n+m)$.

**Chuleta**

> **a)** Bellman-Ford con $n$ iteraciones (una extra): actualizacion en iter $n$ → ciclo negativo.
> **b)** Ciclo aprovechable $\Leftrightarrow$ vertice del ciclo $\in A$ (alcanzable desde $s$) $\cap$ $B$ (co-alcanzable a $t$).
> **c)** $O(nm)$.

**¿Aparece en parciales?** 🔴 Si — deteccion de ciclos negativos alcanzables es patron evaluado

---

### Ejercicio 13 — Analisis de Bellman-Ford

**Enunciado**

a) Demostrar: despues de $k$ iteraciones del algoritmo de Bellman-Ford, se ha calculado correctamente la distancia minima desde $s$ a todo vertice alcanzable mediante un camino de a lo sumo $k$ aristas.

b) Explicar por que con $n-1$ iteraciones es suficiente si no hay ciclos negativos.

c) Disenar una optimizacion que termine antes si en alguna iteracion no se actualiza ninguna distancia. ¿Por que es correcta?

d) En el peor caso, ¿cuantas iteraciones necesita la version optimizada? Dar un ejemplo.

**Explicacion**

a) Por induccion en $k$: base $k=0$ trivial. Paso: en la iteracion $k$, se relajan todas las aristas y se considera el camino optimo de exactamente $k$ aristas terminando en cada vertice.
b) Si no hay ciclos negativos, el camino minimo simple tiene a lo sumo $n-1$ aristas.
c) Si en una iteracion no hay actualizaciones, el algoritmo ya convergio (igual que Bellman-Ford puede terminar antes).
d) El peor caso es un camino largo lineal $s \to v_1 \to v_2 \to \ldots \to v_{n-1}$ procesado en orden inverso → $n-1$ iteraciones necesarias.

**Resolucion paso a paso**

**Parte a) — Invariante por induccion:**

Sea $d_k[v]$ el valor de $d[v]$ despues de $k$ iteraciones. El invariante es: $d_k[v] \leq$ peso del camino minimo de $s$ a $v$ usando a lo sumo $k$ aristas.

**Base $k=0$:** $d_0[s] = 0$ (camino de 0 aristas) y $d_0[v] = \infty$ para $v \neq s$. ✓

**Paso inductivo:** Supongamos que el invariante vale para $k-1$. En la iteracion $k$, para cada arista $u \to v$:
$$d_k[v] = \min(d_{k-1}[v],\ d_{k-1}[u] + c(u \to v))$$

El segundo termino considera el camino optimo de $\leq k-1$ aristas hasta $u$, mas la arista $u \to v$ → camino de $\leq k$ aristas hasta $v$. Luego $d_k[v]$ es el minimo entre el optimo de $\leq k-1$ aristas y el de exactamente $k$ aristas (con el penultimo en $u$). Por HI, $d_{k-1}[u]$ es correcto → $d_k[v]$ es el CM de $\leq k$ aristas. ✓

**Parte b) — n-1 iteraciones son suficientes:**

Sin ciclos negativos: el camino minimo entre dos vertices es simple (no repite vertices). Un camino simple tiene a lo sumo $n-1$ aristas. Por la parte a), despues de $n-1$ iteraciones, $d_{n-1}[v]$ = CM de $s$ a $v$ por camino simple = CM real. ✓

**Parte c) — Parada temprana:**

Si en la iteracion $k$ ningun $d[v]$ cambia: $d_k[v] = d_{k-1}[v]$ para todo $v$. En la iteracion $k+1$: para cada arista $u \to v$, $d_k[u] + c(u \to v)$ no puede mejorar sobre $d_{k-1}[u] + c(u \to v)$ (pues $d_k = d_{k-1}$). Luego ninguna iteracion futura producira cambios → el algoritmo convergio → terminar. ✓

**Parte d) — Peor caso de la version optimizada:**

Grafo: $s \to v_1 \to v_2 \to \ldots \to v_{n-1}$, aristas procesadas en orden inverso ($v_{n-1} \to v_{n-2}$ antes que $v_{n-2} \to v_{n-3}$, etc.).

En cada iteracion, solo se puede relajar un vertice mas (la arista mas cercana a $s$ que no se pudo relajar antes). Luego se necesitan exactamente $n-1$ iteraciones — el peor caso es igual sin la optimizacion.

**Chuleta**

> **a)** Iter $k$ calcula CM de $\leq k$ aristas (induccion sobre la longitud del camino).
> **b)** CM simple $\leq n-1$ aristas → $n-1$ iter. suficientes.
> **c)** Sin cambios en iter $k$ → convergio → terminar.
> **d)** Peor caso: cadena procesada en orden inverso → $n-1$ iter.

**¿Aparece en parciales?** 🔴 Si — analisis de Bellman-Ford es evaluado en 2P

---

### Ejercicio 14 — Camino con Exactamente k Aristas

**Enunciado**

Dado un digrafo $D$ con pesos $c$, dos vertices $s$ y $t$ y un entero $k > 0$, encontrar el camino de peso minimo de $s$ a $t$ que usa exactamente $k$ aristas.

a) Definir $d_i(v)$ = peso del camino minimo desde $s$ hasta $v$ usando exactamente $i$ aristas.
b) Algoritmo de PD basado en a).
c) Complejidad. Comparar con Bellman-Ford.
d) Modificar para a lo sumo $k$ aristas.

**Explicacion**

$d_i(v) = \min_{u: u \to v \in E} \{d_{i-1}(u) + c(u \to v)\}$. Caso base: $d_0(s) = 0$, $d_0(v) = \infty$ para $v \neq s$. $d_k(t)$ es la respuesta. Complejidad: $O(km)$. Bellman-Ford es equivalente pero calcula $d_{\leq i}(v)$ (a lo sumo $i$ aristas) en vez de exactamente $i$.

**Resolucion paso a paso**

**Parte a) — Definicion recursiva:**

$$d_0(s) = 0; \quad d_0(v) = \infty \text{ para } v \neq s$$
$$d_i(v) = \min_{u : u \to v \in E} \{d_{i-1}(u) + c(u \to v)\} \quad \text{para } i \geq 1$$

$d_i(v)$ es el peso del camino minimo de $s$ a $v$ usando exactamente $i$ aristas (o $\infty$ si no existe).

**Parte b) — Algoritmo PD:**

```
d[0][s] = 0; d[0][v] = inf para v != s
Para i = 1, ..., k:
    Para cada arista u → v con peso c:
        d[i][v] = min(d[i][v], d[i-1][u] + c)
Retornar d[k][t]
```

Se pueden usar solo dos arreglos (actual y anterior) para ahorrar memoria.

**Parte c) — Complejidad y comparacion con Bellman-Ford:**

Complejidad: $k$ iteraciones × $O(m)$ relajaciones = $O(km)$.

**Diferencia con Bellman-Ford:** Bellman-Ford calcula $d_{\leq i}(v) = \min(d_i(v), d_{i-1}(v))$ en cada iteracion (permite usar menos de $i$ aristas). Este algoritmo calcula exactamente $d_i(v)$. Para obtener el CM con a lo sumo $k$ aristas, Bellman-Ford es equivalente pero mas conveniente (actualiza en lugar de mantener dos arrays).

**Parte d) — A lo sumo $k$ aristas:**

$$\text{ans}(v) = \min_{i=0}^{k} d_i(v)$$

En el algoritmo: en cada iteracion $i$, actualizar $\text{ans}[v] = \min(\text{ans}[v], d[i][v])$.

**Chuleta**

> $d_i(v) = \min_{u \to v} \{d_{i-1}(u) + c(u \to v)\}$. Base: $d_0[s]=0$, resto $\infty$.
> Computar para $i=1,\ldots,k$. Respuesta: $d_k[t]$.
> $O(km)$. Para $\leq k$ aristas: $\min_{i=0}^k d_i[t]$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 15 — SRD (Sistema de Restricciones de Diferencias)

**Enunciado**

Un SRD es un sistema de inecuaciones $x_i - x_j \leq c_{ij}$. Para cada SRD $S$ se define el digrafo $D(S)$ con vertice $v_i$ por incognita y aristas $v_j \to v_i$ de peso $c_{ij}$ cuando $x_i - x_j \leq c_{ij}$. Ademas, $D(S)$ tiene un vertice $v_0$ con aristas $v_0 \to v_i$ de peso 0 para todo $i$.

a) Demostrar: si $D(S)$ tiene un ciclo de peso negativo, entonces $S$ no tiene solucion.
b) Demostrar: si $D(S)$ no tiene ciclos de peso negativo, entonces $\{x_i = d(v_0, v_i)\}$ es una solucion de $D(S)$.
c) Proponer un algoritmo para resolver cualquier SRD.

**Explicacion**

a) Un ciclo de peso negativo produce una contradiccion al sumar las inecuaciones del ciclo.
b) La solucion de Bellman-Ford satisface cada inecuacion: $d(v_0, v_i) - d(v_0, v_j) \leq c_{ij}$ es exactamente la condicion de que la arista $v_j \to v_i$ esta relajada.
c) Bellman-Ford desde $v_0$. Si no hay ciclos negativos → retornar $x_i = d(v_0, v_i)$. Si hay ciclos negativos → sin solucion, mostrar el ciclo contradictorio.

**Resolucion paso a paso**

**Parte a) — Ciclo negativo $\Rightarrow$ sin solucion:**

Sea $x_{i_0} - x_{i_1} \leq c_{i_1 i_0}$, $x_{i_1} - x_{i_2} \leq c_{i_2 i_1}$, $\ldots$, $x_{i_{k-1}} - x_{i_0} \leq c_{i_0 i_{k-1}}$ las inecuaciones de un ciclo en $D(S)$.

Sumando todas:
$$0 = (x_{i_0} - x_{i_1}) + (x_{i_1} - x_{i_2}) + \ldots + (x_{i_{k-1}} - x_{i_0}) \leq c_{i_1 i_0} + c_{i_2 i_1} + \ldots + c_{i_0 i_{k-1}} = \text{peso del ciclo}$$

Si el ciclo tiene peso negativo: $0 \leq (\text{negativo})$ — contradiccion. Luego no hay solucion. $\square$

**Parte b) — Sin ciclos negativos $\Rightarrow$ solucion via distancias:**

Sea $x_i = d(v_0, v_i)$ para todo $i$. Para verificar $x_i - x_j \leq c_{ij}$:

Por la condicion de relajacion de Bellman-Ford (convergida sin ciclos negativos):
$$d(v_0, v_i) \leq d(v_0, v_j) + c_{ij}$$
(por la arista $v_j \to v_i$ de peso $c_{ij}$). Luego $x_i - x_j = d(v_0, v_i) - d(v_0, v_j) \leq c_{ij}$. ✓

**Parte c) — Algoritmo:**

1. Construir $D(S)$: un vertice por variable, arco $v_j \to v_i$ con peso $c_{ij}$ por cada restriccion $x_i - x_j \leq c_{ij}$, super-fuente $v_0$ con arcos $v_0 \to v_i$ de peso 0.
2. Bellman-Ford desde $v_0$.
3. Si hay ciclo negativo: no hay solucion. Reportar el ciclo como evidencia.
4. Si no: $x_i = d(v_0, v_i)$ es una solucion.

Complejidad: $O(nm)$ donde $n$ = numero de variables y $m$ = numero de restricciones.

**Chuleta**

> **SRD:** restriccion $x_i - x_j \leq c_{ij}$ → arco $v_j \to v_i$ con peso $c_{ij}$.
> **Algoritmo:** Bellman-Ford desde $v_0$.
> - Ciclo negativo → sin solucion (la suma de inecuaciones del ciclo da $0 \leq$ negativo).
> - Sin ciclos negativos → $x_i = d(v_0, v_i)$ es solucion (por condicion de relajacion).
> - $O(nm)$.

**¿Aparece en parciales?** 🔴 Si — SRDs aparecen en la guia con varios ejercicios de modelado

---

### Ejercicios 16–19 — SRD: Modelados

**Enunciado resumido**

- **Ej. 16** (Posicionamiento uniforme de parentesis): modelar como SRD con $O(n)$ inecuaciones para encontrar un $\ell$-posicionamiento uniforme de una cadena de parentesis. Resolver en $O(n^2)$.
- **Ej. 17** (Clientes en linea — peleas y amistades): asignar cajas a $n$ clientes con restricciones de distancia minima (pelea) y maxima (amistad). Modelar con SRD, resolver en tiempo polinomial. Complejidad en funcion de $m_1, m_2$ (amistades y peleas).
- **Ej. 18** (Clientes en circulo — solo peleas): version circular del ej. 17 sin restricciones de amistad. SRD circular.
- **Ej. 19** (SRD con ecuaciones — problema ICPC del mate dulce): modelar el problema de distribucion de ICPC circular como SRD con ecuaciones. Algoritmo $O(n)$ donde cada componente de $G(S)$ es un ciclo.

**Explicacion**

Estos ejercicios practican el modelado de problemas como SRD y su resolucion via Bellman-Ford. La clave es identificar las variables (posiciones, tiempos), las restricciones (desigualdades del tipo $x_i - x_j \leq c$) y construir el digrafo $D(S)$.

**Resolucion paso a paso**

**Ej. 16 — Parentesis uniformes:**

Variables: $p_i$ = posicion del $i$-esimo parentesis ($1 \leq i \leq n$).

Restricciones de $\ell$-uniformidad: $p_{i+1} - p_i \geq \ell$ (separacion minima entre consecutivos). Reescrito como SRD: $p_i - p_{i+1} \leq -\ell$.

Restriccion de que quepan en un rango $[1, L]$: $p_1 \geq 1$ y $p_n \leq L$.

Modelado SRD con $O(n)$ restricciones. Bellman-Ford en $O(n^2)$.

**Ej. 17 — Clientes en linea:**

Variables: $x_i$ = posicion de la caja del cliente $i$ en la linea.

- Peleas entre $i$ y $j$: deben estar a distancia $\geq d_{ij}$. Como la linea es ordenada, si $i < j$ en alguna asignacion: $x_j - x_i \geq d_{ij}$ → SRD: $x_i - x_j \leq -d_{ij}$.
- Amistades entre $i$ y $j$: deben estar a distancia $\leq a_{ij}$. Dos restricciones: $x_j - x_i \leq a_{ij}$ y $x_i - x_j \leq a_{ij}$.

Grafo $D(S)$: $n$ vertices + $v_0$. Arcos para peleas ($m_2$ arcos) y amistades ($2 m_1$ arcos). Bellman-Ford: $O(n(m_1 + m_2))$.

**Ej. 18 — Clientes en circulo:**

Similar al 17 pero sin restricciones de amistad y con disposicion circular: $x_n - x_1 \leq L$ y $x_1 - x_n \leq 0$ (o segun el problema especifico). El SRD circular puede tener ciclos positivos → soluciones con espacio.

Detectar ciclos negativos (sin solucion) o ciclos no-negativos (con solucion).

**Ej. 19 — Mate dulce (ICPC):**

Variables: $x_i$ = cantidad de mate dulce del participante $i$ en disposicion circular.

Restricciones de igualdad $x_i = x_j + c_{ij}$: codificar como dos inecuaciones SRD: $x_i - x_j \leq c_{ij}$ y $x_j - x_i \leq -c_{ij}$.

El grafo $G(S)$ donde cada componente conexa es un ciclo simple. Algoritmo $O(n)$: resolver cada ciclo independientemente (si el ciclo tiene peso total $\neq 0$: sin solucion; si = 0: solucion unica salvo constante).

**Chuleta**

> **Template SRD:**
> 1. Variables $x_i$ = lo que se quiere asignar.
> 2. Restricciones $x_i - x_j \leq c$ → arco $v_j \to v_i$ de peso $c$.
> 3. Igualdad $x_i = x_j + c$: dos arcos ($\leq c$ y $\leq -c$).
> 4. Bellman-Ford desde $v_0$ (arcos de peso 0 a todos).
> 5. Ciclo negativo → sin solucion; no ciclos → $x_i = d(v_0, v_i)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 20 — Matrices de Floyd-Warshall

**Enunciado**

Una matriz $M \in \mathbb{N}^{n \times n}$ cuadrada, simetrica y positiva es de Floyd-Warshall (FW) si existe un grafo $G$ tal que $M$ es el resultado de aplicar FW a $G$.

Describir un algoritmo para decidir si $M$ es FW. Si si, retornar un grafo $G$ con la minima cantidad de aristas tal que FW sobre $G$ produce $M$. Si no, retornar evidencia.

**Explicacion**

$M$ es FW $\Leftrightarrow$ satisface la desigualdad triangular: $M[i][j] \leq M[i][k] + M[k][j]$ para todo $k$. Si es FW, el grafo minimo solo incluye la arista $ij$ si $M[i][j] < \min_{k \neq i,j}(M[i][k] + M[k][j])$ (no puede deducirse por triangulo). $O(n^3)$.

**Resolucion paso a paso**

**Condicion para que $M$ sea FW:**

$M$ es FW $\Leftrightarrow$ $M$ satisface la desigualdad triangular:
$$M[i][j] \leq M[i][k] + M[k][j] \quad \forall i, j, k$$

Esta condicion es necesaria (si $M$ son distancias, la desigualdad triangular siempre vale) y suficiente (si vale, tomar $G$ con aristas $M[i][j]$ y aplicar FW reproduce $M$).

**Algoritmo $O(n^3)$:**

1. Verificar la desigualdad triangular para todos los triples $(i,j,k)$ — $O(n^3)$.
   - Si se viola algun triple: $M$ no es FW. Retornar el triple como evidencia.
2. Si es FW: construir el grafo minimo.
   - Para cada par $(i,j)$: incluir arista $i \to j$ con peso $M[i][j]$ si y solo si:
     $$M[i][j] < \min_{k \neq i, k \neq j} (M[i][k] + M[k][j])$$
   - Es decir, la distancia $M[i][j]$ no puede obtenerse por triangulo a traves de ningun $k$.
   - Si puede obtenerse por triangulo, la arista es redundante.

**Correctitud:** El grafo minimo incluye exactamente las aristas "no deducibles" por transitividad. FW sobre este grafo produce la misma matriz $M$ porque los caminos directos son los unicos que no se pueden deducir por pasos intermedios.

**Chuleta**

> 1. $M$ es FW $\Leftrightarrow$ desigualdad triangular: $M[i][j] \leq M[i][k] + M[k][j]$ para todo $k$.
> 2. Verificar en $O(n^3)$.
> 3. Grafo minimo: incluir $i \to j$ solo si $M[i][j] < \min_{k} (M[i][k] + M[k][j])$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 21 — Arista st-Eficiente para Mas Pares

**Enunciado**

Dado un digrafo $D$ con pesos sin ciclos negativos, encontrar la arista $v \to w$ que sea st-eficiente para la mayor cantidad de pares $(s, t)$. Proponer un algoritmo eficiente y simple.

Hint: verificar que la propiedad del Ejercicio 1a es verdadera en este caso.

**Explicacion**

Ejecutar Floyd-Warshall: obtener todas las distancias $d(i,j)$. Para cada arista $v \to w$: contar pares $(s,t)$ tal que $d(s,v) + c(v \to w) + d(w,t) = d(s,t)$. Esto se puede hacer en $O(n^2)$ por arista → $O(n^2 m)$ total (o $O(n^3)$ con Floyd + postprocesamiento).

**Resolucion paso a paso**

1. Floyd-Warshall → $d[i][j]$ para todos los pares. $O(n^3)$.
2. Para cada arista $v \to w$ con peso $c_{vw}$:
   ```
   count[v→w] = 0
   Para cada par (s, t):
       si d[s][v] + c_vw + d[w][t] == d[s][t]:
           count[v→w]++
   ```
   Costo: $O(n^2)$ por arista.
3. Retornar la arista con mayor count.

Complejidad total: $O(n^3 + n^2 m)$. Si $m = O(n^2)$: $O(n^4)$. Si $m = O(n)$: $O(n^3)$.

**Optimizacion:** Para cada arista $v \to w$, contar es:
$$\text{count}[v \to w] = |\{s : d[s][v] < \infty\}| \times |\{t : d[w][t] < \infty\}|$$
restringido a pares donde $d[s][v] + c_{vw} + d[w][t] = d[s][t]$.

**Chuleta**

> 1. Floyd-Warshall: $d[i][j]$ para todo par — $O(n^3)$.
> 2. Por arista $v \to w$: count = $|\{(s,t) : d[s][v] + c_{vw} + d[w][t] = d[s][t]\}|$ — $O(n^2)$.
> 3. Retornar la arista con mayor count.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 22 — Conjunto Geodesico

**Enunciado**

El intervalo entre $v$ y $w$ en un grafo pesado $G$ es el conjunto $I(v,w)$ de todos los vertices en algun recorrido minimo entre $v$ y $w$. Un conjunto de vertices $D$ es geodesico cuando $\bigcup_{v,w \in D} I(v,w) = V(G)$.

Disenar e implementar un algoritmo de tiempo $O(n^3)$ que, dado $G$ y un conjunto $D$, determine si $D$ es geodesico.

**Explicacion**

Ejecutar Floyd-Warshall ($O(n^3)$). Para cada par $v,w \in D$, calcular $I(v,w)$: un vertice $u \in I(v,w)$ si y solo si $d(v,u) + d(u,w) = d(v,w)$. Verificar que la union de todos los intervalos cubre $V(G)$.

**Resolucion paso a paso**

1. Floyd-Warshall → $d[i][j]$ para todo par. $O(n^3)$.
2. Inicializar $\text{cubierto}[u] = \text{false}$ para todo $u$.
3. Para cada par $(v, w) \in D \times D$:
   - Para cada vertice $u \in V$: si $d[v][u] + d[u][w] = d[v][w]$, entonces $u \in I(v,w)$ → $\text{cubierto}[u] = \text{true}$.
4. Si todos los vertices estan cubiertos: $D$ es geodesico. Si no: retornar un vertice no cubierto.

Complejidad: $O(n^3)$ para Floyd + $O(|D|^2 \cdot n)$ para verificar. Si $|D| = O(\sqrt{n})$: $O(n^2)$ para la verificacion. En general dominado por Floyd: $O(n^3)$.

**Chuleta**

> 1. Floyd-Warshall.
> 2. $u \in I(v,w) \Leftrightarrow d[v][u] + d[u][w] = d[v][w]$.
> 3. Verificar que $\bigcup_{v,w \in D} I(v,w) = V(G)$.
> 4. $O(n^3)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 23 — Camino Minimo en DAG

**Enunciado**

Sea $D$ un digrafo sin ciclos dirigidos donde todo vertice es alcanzable desde $v$, con pesos $c: E(D) \to \mathbb{Z}$.

a) Definir $d: V(D) \to \mathbb{Z}$ recursivamente tal que $d(w)$ es el peso del camino minimo de $v$ a $w$.
b) Algoritmo PD top-down y complejidad.
c) (Integrador-opcional) Algoritmo PD bottom-up con orden topologico. Este orden se computa en $O(n+m)$ (guia 3).

**Explicacion**

$d(w) = \min_{z \to w \in E} \{d(z) + c(z \to w)\}$, con $d(v) = 0$. La funcion esta bien definida porque $D$ es un DAG (no hay ciclos). Top-down con memoizacion: $O(n+m)$. Bottom-up en orden topologico: mismo orden de computo pero sin recursion.

Este ejercicio aparece en [[caminos_minimos_todos_a_todos_y_dags_practica]] (DAGs y Sasha peajes).

**Resolucion paso a paso**

**Parte a) — Definicion recursiva de $d(w)$:**

$$d(\text{raiz}) = 0$$
$$d(w) = \min_{z \to w \in E} \{d(z) + c(z \to w)\}$$

Bien definida porque $D$ es un DAG: el orden de evaluacion sigue el orden topologico (siempre se evalua $d(z)$ antes que $d(w)$ para $z \to w$).

**Parte b) — PD top-down con memoizacion:**

```python
memo = {}
def d(w):
    if w == raiz: return 0
    if w in memo: return memo[w]
    # w tiene al menos un predecesor (todo vertice es alcanzable desde raiz)
    memo[w] = min(d(z) + c(z→w) for z→w in E if z es predecesor de w)
    return memo[w]
```

Cada vertice se computa una sola vez. Cada arista $z \to w$ se considera una sola vez al computar $d(w)$. Total: $O(n+m)$.

**Parte c) — PD bottom-up en orden topologico:**

```
Ordenar vertices en orden topologico: u_1, u_2, ..., u_n
d[raiz] = 0; d[v] = +inf para el resto
Para cada vertice z en orden topologico:
    Para cada arista z → w:
        d[w] = min(d[w], d[z] + c(z→w))
```

Se recorre el grafo en orden topologico: cuando se procesa $z$, su $d[z]$ ya es definitivo (todos sus predecesores fueron procesados antes). $O(n+m)$.

**Chuleta**

> - **Recurrencia:** $d(\text{raiz})=0$; $d(w) = \min_{z \to w} \{d(z) + c(z \to w)\}$.
> - **Top-down:** memoizacion con recursion. $O(n+m)$.
> - **Bottom-up:** procesar en orden topologico, relajar aristas salientes. $O(n+m)$.

**¿Aparece en parciales?** 🔴 Si — CM en DAG via PD es evaluado en 2P

---

### Ejercicio 24 — Problema del Vuelto como CM

**Enunciado**

Con monedas de valores $w_1, \ldots, w_k$ en cantidad ilimitada, dar vuelto $v$ usando el minimo de monedas. Modelar como problema de CM e indicar un algoritmo eficiente. Complejidad $O(vk)$.

Opcional: discutir la relacion con el algoritmo de PD correspondiente.

**Explicacion**

Grafo: vertices $0, 1, \ldots, v$; aristas $i \to i + w_j$ de peso 1 para cada moneda $w_j$. Camino minimo desde $0$ hasta $v$ = minimo de monedas. BFS (todos los pesos = 1) o Dijkstra. $O(vk)$. La PD equivalente es la del cambio de monedas de [[programacion_dinamica_teoria]].

**Resolucion paso a paso**

**Modelado como DAG (en realidad no es DAG pero si se procesa en orden es equivalente):**

- Vertices: $\{0, 1, 2, \ldots, v\}$ (valores de 0 a $v$).
- Aristas: para cada cantidad $i$ y cada moneda $w_j$: arista $i \to i + w_j$ con peso 1 (si $i + w_j \leq v$).
- Camino minimo de 0 a $v$ = minimo de monedas para dar vuelto $v$.

**Por que BFS y no Dijkstra:** Todos los pesos son 1 → BFS es suficiente y mas rapido.

**Algoritmo BFS $O(vk)$:**
```
d[0] = 0; d[i] = inf para i > 0
cola = [0]
mientras cola no vacia:
    i = desencolar
    para j = 1..k:
        si i + w_j <= v y d[i + w_j] == inf:
            d[i + w_j] = d[i] + 1
            encolar i + w_j
Retornar d[v]
```

Cada vertice se visita a lo sumo una vez; por cada vertice se consideran $k$ aristas → $O(vk)$.

**Equivalencia con PD:** La recurrencia de PD es $d[i] = \min_j \{d[i - w_j] + 1\}$, que es exactamente la relajacion de las aristas entrantes en el grafo. Bottom-up de izquierda a derecha reproduce BFS por niveles.

**Chuleta**

> Vertices $0, \ldots, v$. Aristas $i \to i+w_j$ peso 1.
> BFS desde 0 → CM = min monedas. $O(vk)$.
> Equivalente a la PD de vuelto: $d[i] = \min_j \{d[i-w_j]+1\}$.

**¿Aparece en parciales?** 🔴 Si — vuelto/monedas es ejercicio canonico de PD/CM

---

### Ejercicio 25 — Gestion de Proyectos (Etapas Criticas)

**Enunciado**

Un proyecto se divide en $n$ etapas $v_1, \ldots, v_n$ donde cada etapa $v_i$ consume tiempo $t_i \geq 0$. Para empezar $v_i$ se requiere que terminen un conjunto $N(v_i)$ de etapas previas. Una etapa es critica si cualquier atraso provoca un retraso en el proyecto.

Modelar el problema de encontrar todas las etapas criticas como un problema de CM. Algoritmo lineal en la cantidad de datos.

**Explicacion**

Grafo DAG: aristas $v_j \to v_i$ si $v_j \in N(v_i)$, con peso $t_j$. El camino mas largo desde $v_1$ hasta $v_i$ es el tiempo mas temprano en que puede comenzar $v_i$ (critical path method, CPM). Una etapa es critica si el tiempo mas temprano de comienzo = tiempo mas tardio sin retrasar el proyecto. Camino minimo con pesos negados: $O(n+m)$.

**Resolucion paso a paso**

**Modelado (Critical Path Method — CPM):**

Construir el DAG de precedencias:
- Vertice $v_i$ por cada etapa.
- Arco $v_j \to v_i$ con peso $t_j$ si $v_j \in N(v_i)$ ($v_j$ debe terminar para que empiece $v_i$).
- Fuente $s$ con arcos $s \to v_i$ de peso 0 para etapas sin predecesores.
- Sumidero $f$ con arcos $v_i \to f$ de peso $t_i$ para etapas sin sucesores.

**Tiempo mas temprano de inicio (EST — Earliest Start Time):**

$\text{EST}(v_i)$ = camino mas largo desde $s$ a $v_i$ = $-d_{c'}(s, v_i)$ donde $c'(e) = -c(e)$ (negar pesos para maximizar).

Calcular con CM en DAG bottom-up en orden topologico: $O(n+m)$.

**Tiempo mas tardio de inicio (LST — Latest Start Time):**

$\text{LST}(v_i)$ = duracion total del proyecto - camino mas largo de $v_i$ al sumidero.

Calcular con CM en DAG desde el sumidero hacia atras (orden topologico inverso): $O(n+m)$.

**Etapas criticas:**

$v_i$ es critica $\Leftrightarrow$ $\text{EST}(v_i) = \text{LST}(v_i)$ (no hay holgura).

El camino critico es la secuencia de etapas criticas conectadas desde la fuente al sumidero.

**Complejidad:** $O(n+m)$ — dos pasadas en el DAG.

**Chuleta**

> 1. DAG: arco $v_j \to v_i$ con peso $t_j$ si $j$ precede a $i$.
> 2. $\text{EST}(v_i)$ = camino mas largo desde $s$ a $v_i$ (negar + CM DAG). $O(n+m)$.
> 3. $\text{LST}(v_i)$ = duracion total $-$ camino mas largo de $v_i$ a $f$. $O(n+m)$.
> 4. Critica $\Leftrightarrow$ $\text{EST}(v_i) = \text{LST}(v_i)$.

**¿Aparece en parciales?** 🔴 Si — critico del camino / DAG con pesos es evaluado

---

### Ejercicio 26 — Invariantes: Que Algoritmo Usar

**Enunciado**

Determinar que algoritmo de CM conviene usar para cada uno de los siguientes problemas (grafos ralos: $O(n)$ aristas; grafos densos: $\Omega(n^2)$ aristas):

a. CM de uno a todos, pesos iguales no negativos (ralo/denso).
b. CM de todos a todos, pesos iguales no negativos (ralo/denso).
c. CM de uno a todos, pesos no negativos (ralo/denso).
d. CM de todos a todos, pesos no negativos (ralo/denso).
e. Detectar ciclos negativos, grafo no necesariamente conexo (ralo/denso).
f. Recorrido minimo de uno a todos (permite ciclos negativos) (ralo/denso).
g. Recorrido minimo de todos a todos (ralo/denso).

**Explicacion**

Tabla resumen:

| Variante | Ralo | Denso |
|----------|------|-------|
| a (1-a-todos, pesos iguales) | BFS $O(n+m)$ | BFS $O(n+m)$ |
| b (todos-a-todos, pesos iguales) | $n \times$ BFS $O(n(n+m)) = O(n^2)$ | $n \times$ BFS $O(n^3)$ o Floyd $O(n^3)$ |
| c (1-a-todos, pesos $\geq 0$) | Dijkstra + heap $O((n+m)\log n)$ | Dijkstra + array $O(n^2)$ |
| d (todos-a-todos, pesos $\geq 0$) | $n \times$ Dijkstra heap $O(nm \log n) = O(n^2 \log n)$ | Floyd $O(n^3)$ |
| e (ciclos negativos) | Bellman-Ford $O(nm) = O(n^2)$ | Bellman-Ford $O(nm) = O(n^3)$ o Floyd |
| f (1-a-todos, permite neg.) | Bellman-Ford $O(nm) = O(n^2)$ | Bellman-Ford $O(n^3)$ |
| g (todos-a-todos) | Johnson $O(nm\log n) = O(n^2 \log n)$ | Floyd $O(n^3)$ |

**Resolucion paso a paso**

**a — Pesos iguales (BFS):**

Todos los pesos son 1 (o iguales) → distancia = numero de aristas → BFS. $O(n+m)$ independientemente de densidad.

**b — Todos a todos con pesos iguales:**

$n$ BFS desde cada vertice. Ralo: $O(n(n+m)) = O(n^2)$ (pues $m = O(n)$). Denso: $O(n(n+m)) = O(n^3)$. Floyd con pesos iguales tambien da $O(n^3)$ — equivalente.

**c — Pesos no negativos, uno a todos:**

Dijkstra. Ralo: con heap binario $O((n+m)\log n) = O(n \log n)$ (pues $m = O(n)$). Denso: con arreglo $O(n^2)$ (mejor que heap cuando $m = O(n^2)$, pues heap seria $O(n^2 \log n)$).

**d — Pesos no negativos, todos a todos:**

Ralo: $n$ × Dijkstra con heap $= O(nm \log n) = O(n^2 \log n)$. Denso: Floyd-Warshall $O(n^3)$ — mejor que $n$ × Dijkstra array que seria $O(n^3)$ — igual asintoticamente pero Floyd tiene mejores constantes.

**e — Detectar ciclos negativos:**

Bellman-Ford con super-fuente. Ralo: $O(nm) = O(n^2)$. Denso: $O(nm) = O(n^3)$. Floyd tambien detecta ciclos negativos (diagonal negativa) en $O(n^3)$.

**f — CM con pesos negativos, uno a todos:**

Bellman-Ford. Ralo: $O(nm) = O(n^2)$. Denso: $O(nm) = O(n^3)$.

**g — CM con pesos posiblemente negativos, todos a todos:**

Ralo: Johnson ($O(nm \log n) = O(n^2 \log n)$): un Bellman-Ford + $n$ Dijkstra con reweighting. Denso: Floyd-Warshall $O(n^3)$.

**Chuleta**

> | | Ralo ($m=O(n)$) | Denso ($m=O(n^2)$) |
> |---|---|---|
> | pesos iguales, 1-todos | BFS $O(n)$ | BFS $O(n^2)$ |
> | pesos iguales, todos | $n$×BFS $O(n^2)$ | $n$×BFS $O(n^3)$ |
> | $\geq 0$, 1-todos | Dijkstra heap $O(n \log n)$ | Dijkstra array $O(n^2)$ |
> | $\geq 0$, todos | $n$×Dijkstra $O(n^2 \log n)$ | Floyd $O(n^3)$ |
> | ciclos neg / 1-todos | BF $O(n^2)$ | BF/Floyd $O(n^3)$ |
> | todos (neg) | Johnson $O(n^2 \log n)$ | Floyd $O(n^3)$ |

**¿Aparece en parciales?** 🔴 Si — eleccion de algoritmo segun tipo de grafo es evaluado en 2P

---

### Ejercicio 27 — Dijkstra/Bellman-Ford con Tiempos de Apertura

**Enunciado**

Dado un digrafo $D$ donde cada arista $v \to w$ tiene tiempo de viaje $t(v \to w)$ y tiempo de apertura $s(v \to w) \geq 0$ (no se puede cruzar antes de ese instante). Determinar el instante mas temprano $d(w)$ para llegar a $w$ desde $v$ para todo $w$.

a) Con $t(\cdot) \geq 0$: disenar un algoritmo eficiente basado en Dijkstra. Invariante: particion $V, W$ tal que $d(x)$ es correcto para $x \in V$ y $d(y) \geq d(x)$ para todo $y \in W$. Identificar que vertice de $W$ puede agregarse a $V$.

b) Sin suponer $t(\cdot) \geq 0$ pero con $t(C) \geq 0$ para todo ciclo $C$: algoritmo basado en Bellman-Ford.

c) ¿Se adapta Floyd-Warshall facilmente para todos-a-todos?

**Explicacion**

a) El tiempo de llegada a $w$ via $v \to w$ es $\max(d(v), s(v \to w)) + t(v \to w)$. El invariante de Dijkstra se mantiene si $t \geq 0$: el vertice con menor $d(y)$ en $W$ es el siguiente en agregarse a $V$.

b) Con tiempos potencialmente negativos pero ciclos no-negativos, Bellman-Ford funciona similarmente pero es necesario calcular el tiempo de llegada correctamente (el tiempo en el ciclo no puede decrecer).

**Resolucion paso a paso**

**Parte a) — Dijkstra con tiempos de apertura:**

La funcion de actualizacion de $d[w]$ al expandir $v$:
$$d[w] \leftarrow \min\bigl(d[w],\ \max(d[v],\ s(v \to w)) + t(v \to w)\bigr)$$

**Por que el invariante de Dijkstra se mantiene:**

Cuando se extrae el vertice $u$ de menor $d[u]$ en $W$: cualquier camino alternativo de la fuente a $u$ que pase por algun $z \in W$ tiene $d[z] \geq d[u]$. El tiempo de llegada via $z$ es:
$$\max(d[z], s(z \to u)) + t(z \to u) \geq d[z] \geq d[u]$$

(pues $t \geq 0$ y $\max \geq d[z]$). Luego no puede mejorar $d[u]$ — el invariante se mantiene. ✓

Implementacion identica a Dijkstra estandar, cambiando la relajacion por la formula anterior. Complejidad: $O(m \log n)$.

**Parte b) — Bellman-Ford con $t(C) \geq 0$:**

La hipotesis es que los ciclos tienen tiempo total $\geq 0$: el tiempo de llegada no puede decrecer indefinidamente en un ciclo. Bellman-Ford aplica la misma relajacion $\max(d[v], s(v \to w)) + t(v \to w)$ repetidamente.

Sin ciclos de tiempo negativo, el algoritmo converge en $n-1$ iteraciones. Complejidad: $O(nm)$.

**Parte c) — Floyd-Warshall para todos a todos:**

Floyd-Warshall **no se adapta facilmente**. En el Floyd estandar, la subestructura optima dice: el CM de $i$ a $j$ pasando por el subconjunto $\{1,\ldots,k\}$ es $\min(d_{k-1}(i,j),\ d_{k-1}(i,k) + d_{k-1}(k,j))$.

Con tiempos de apertura, la composicion de dos caminos no es simple: el tiempo de llegada al punto medio $k$ afecta la disponibilidad de la arista $k \to j$. La operacion $\max(d(i,k), s(k \to j)) + t(k \to j)$ no es lineal en $d(i,k)$ → el principio de optimalidad de Floyd no se puede aplicar directamente.

⚠️ Verificar — En algunos casos con estructura especial podria adaptarse, pero en general no.

**Chuleta**

> **Relajacion:** $d[w] \leftarrow \min(d[w],\ \max(d[v], s(v \to w)) + t(v \to w))$.
> **a)** $t \geq 0$ → Dijkstra con esta relajacion. Invariante: vertice de menor $d$ en $W$ es optimo. $O(m \log n)$.
> **b)** Ciclos $\geq 0$ → Bellman-Ford con esta relajacion. $O(nm)$.
> **c)** Floyd no se adapta: composicion de caminos con $\max$ no satisface la subestructura de Floyd.

**¿Aparece en parciales?** ⚪ No

## Ver tambien

- [[caminos_minimos_teoria]] — Dijkstra, Bellman-Ford, Floyd-Warshall, teoremas
- [[caminos_minimos_practica]] — Ejercicios de clase: Manuel y Monstruos, peajes, etc.
- [[caminos_minimos_todos_a_todos_y_dags_practica]] — DAGs, Sasha peajes, Floyd
