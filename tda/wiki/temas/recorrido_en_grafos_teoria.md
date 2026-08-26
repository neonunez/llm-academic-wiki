---
nombre: Algoritmos sobre Grafos — Teoria (orden topologico, BFS, DFS, puentes)
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: recorrido_en_grafos
fuentes:
  vigente:
    - raw/cursada_2C_2026/teo/teo_clase2_algo_en_grafos.pdf
  historico: []
estado_verificacion: verificado_2C_2026
paginas_relacionadas:
  - "[[recorrido_en_grafos_practica]]"
  - "[[recorrido_en_grafos_guia]]"
  - "[[grafos_teoria]]"
  - "[[arboles_teoria]]"
---

> ✅ Verificado contra la cursada 2C-2026 · fuente: `raw/cursada_2C_2026/teo/teo_clase2_algo_en_grafos.pdf`

# Algoritmos sobre Grafos — Teoria

Clase 2 de la teorica de la cursada 2C-2026: *"Algoritmos sobre grafos — Representaciones,
ordenamiento topologico, BFS y DFS"*. La catedra declara basarse en **Cormen, Leiserson, Rivest,
Stein, *Introduction to Algorithms*, cap. 20**.

**Agenda de la clase (5 bloques):** 1) Representacion de grafos · 2) Ordenamiento topologico ·
3) Busqueda a lo ancho (BFS) · 4) Busqueda en profundidad (DFS) · 5) Deteccion de aristas de corte.

> ℹ️ **Alcance de esta pagina.** Cubre los bloques 2 a 5 (diapositivas 12–58). El bloque 1
> (**Representacion de grafos**, diapositivas 3–11: listas vs. matriz, espacio, costos, pesos)
> pertenece al tema `grafos` y su pagina canonica es [[grafos_teoria]], que ya tiene una seccion
> de representacion. Queda pendiente de reconciliar en una corrida aparte.

---

## ⚠️ Colision de notacion: `d[v]` significa dos cosas distintas

La catedra **reusa la letra `d` a proposito** en esta clase. Hay que leer el contexto:

| Contexto | `d[v]` es | Rango tipico |
|---|---|---|
| **BFS** | la **distancia** desde la fuente $s$ hasta $v$ | $0 \le d[v] \le n-1$, o $\infty$ |
| **DFS** (y puentes) | el **tiempo de descubrimiento** de $v$ | $1 \le d[u] < f[u] \le 2\lvert V \rvert$ |

Ademas, $d(v)$ **sin corchetes** es el **grado** del vertice (y $d^-(v)$ / $d^+(v)$ los grados de
entrada y de salida en un digrafo), como en [[grafos_teoria]]. Tres significados, la misma letra.

---

## Concepto y definicion

Muchos algoritmos sobre grafos siguen **un mismo esquema** para recorrer los vertices alcanzables
desde un vertice inicial $s$ (diapositiva 18):

1. Descubrir el vertice inicial $s$.
2. Mantener una **coleccion de vertices descubiertos que todavia no fueron procesados**.
3. Elegir uno de esos vertices $u$, procesarlo y examinar sus vecinos.
4. Incorporar a la coleccion los vecinos de $u$ que todavia no fueron descubiertos.

Lo unico que cambia entre BFS y DFS es **que estructura implementa esa coleccion**:

| Estructura | Orden de procesamiento | Recorrido |
|---|---|---|
| **Cola** | primero el mas antiguo | **BFS** |
| **Pila** | primero el mas reciente | **DFS** |

Esta es la idea central de la clase: **cola ⇒ BFS, pila ⇒ DFS**. En DFS la pila es, en la practica,
la pila de llamadas recursivas.

## Cuando se aplica

- **Ordenamiento topologico:** planificar tareas con dependencias; detectar si un digrafo tiene ciclos.
- **BFS:** distancias minimas en grafos **sin pesos**, arbol de caminos minimos, reconstruccion de
  caminos, todo lo que sea "por capas" (bipartitez, alcance en $k$ pasos).
- **DFS:** estructura del grafo — bosque DFS, clasificacion de aristas, deteccion de ciclos,
  ancestria/descendencia via tiempos, componentes.
- **Aristas de corte (puentes):** identificar aristas cuya remocion desconecta el grafo, en una
  sola pasada de DFS.

---

# 1. Ordenamiento topologico

## Definicion

Sea $D = (V, E)$ un digrafo. Un **ordenamiento topologico** de $D$ es un orden lineal
$v_1, v_2, \dots, v_n$ de todos sus vertices tal que

$$v_i \to v_j \in E \implies i < j.$$

Es decir: **todas las flechas avanzan en el orden**.

## Propiedades y teoremas

> **Lema.** Todo digrafo aciclico (DAG) tiene un vertice $v$ tal que $d^-(v) = 0$.

> **Teorema.** Un digrafo admite un ordenamiento topologico **si y solo si** es aciclico.

En un DAG siempre existe algun vertice de **grado de entrada cero**; cualquiera de ellos puede
ocupar la proxima posicion del orden. Ese es el motor de los dos algoritmos que siguen.

## Algoritmo recursivo (version ingenua)

1. Buscar un vertice $u$ tal que $d_D^-(u) = 0$ y agregarlo al final del orden.
2. Eliminar $u$ de $D$.
3. Aplicar recursivamente el algoritmo al digrafo $D - u$.
4. Si el digrafo restante no es vacio y **no tiene ningun vertice de grado de entrada cero**,
   entonces contiene un ciclo dirigido.

**Complejidad.** Con listas de adyacencia, buscar y eliminar un vertice cuesta $O(n + m)$. Como se
realizan hasta $n$ pasos, esta implementacion cuesta

$$O\bigl(n(n + m)\bigr).$$

## Algoritmo con cola (ORDEN-TOPOLOGICO / Kahn)

La mejora clave: en vez de rebuscar el vertice de grado cero cada vez, se **mantienen los grados de
entrada en un arreglo** y solo se actualizan los de los vecinos salientes del vertice eliminado.

Al procesar $u$:

1. Agregar $u$ al final del orden.
2. Eliminar **conceptualmente** a $u$ (no se toca la estructura).
3. Disminuir el grado de entrada de cada vecino saliente.
4. **Encolar** los vecinos cuyo grado pasa a ser $0$.

Solo se modifican los grados de entrada de los vertices $v \in N^+(u)$.

```
ORDEN-TOPOLOGICO(D)

  Inicializacion
   1  n <- |V(D)|;  L <- <>
   2  computar entrada[v] = d-(v) para todo v in V(D)
   3  Q <- cola vacia
   4  para todo v in V(D) hacer
   5      si entrada[v] = 0 entonces
   6          ENCOLAR(Q, v)

  Construccion del orden
   7  mientras Q != vacio hacer
   8      u <- DESENCOLAR(Q)
   9      agregar u al final de L
  10      para todo v in N+(u) hacer
  11          entrada[v] <- entrada[v] - 1
  12          si entrada[v] = 0 entonces
  13              ENCOLAR(Q, v)
  14  si |L| < n entonces
  15      devolver "D tiene un ciclo"
  16  devolver L
```

**Invariante de costo:** cada vertice se encola **una sola vez** y cada arista se procesa **una sola vez**.

### Deteccion de ciclo

$$\lvert L \rvert < \lvert V(D) \rvert \implies \text{el subdigrafo inducido por los vertices restantes contiene un ciclo.}$$

Si la cola se vacia antes de haber emitido los $n$ vertices, **no existe orden topologico**. Esta es
la forma barata de testear aciclicidad de un digrafo.

### Complejidad

Con listas de adyacencia,

$$O\bigl(\lvert V(D) \rvert + \lvert E(D) \rvert\bigr).$$

### Ejemplo de la clase (diapositivas 16–17)

Sobre el digrafo de $6$ vertices $\{a,b,c,d,e,f\}$, la ejecucion termina con
$Q = \langle\ \rangle$ y $L = \langle a, b, c, d, e, f \rangle$. Como $\lvert L \rvert = \lvert V(D) \rvert$,
el algoritmo obtuvo un orden topologico valido: dibujados en ese orden, **todas las aristas apuntan
hacia la derecha**.

---

# 2. Busqueda a lo ancho (BFS)

## Definicion

Sea $G = (V, E)$ un grafo o digrafo **sin pesos** y sea $s \in V$ un vertice fuente. La **busqueda a
lo ancho (BFS)** explora primero los vertices mas cercanos a $s$, organizandolos en **capas**:

$$L_i = \{v \in V : \delta(s, v) = i\},$$

donde $\delta(s, v)$ es la longitud de un **camino minimo** de $s$ a $v$, y vale $\infty$ si $v$ no
es alcanzable desde $s$. Se tiene $L_0 = \{s\}$, luego $L_1, L_2, L_3, \dots$

BFS calcula dos cosas:

- $d[v]$: la **distancia** desde $s$ hasta $v$;
- $\pi[v]$: el **predecesor** de $v$ en un arbol de caminos minimos.

## Estados por color

Durante la ejecucion, cada vertice se encuentra en uno de tres estados:

| Color | Significa | Detalle |
|---|---|---|
| **Blanco** | todavia no fue descubierto | $d[v] = \infty$ y $\pi[v] = \text{NIL}$ |
| **Gris** | descubierto, pero no termino de procesarse | esta **en la cola**; es parte de la **frontera** entre descubiertos y no descubiertos |
| **Negro** | termino de procesarse | toda su lista de adyacencia ya fue examinada |

> **Invariante.** Al comienzo de cada iteracion, la cola contiene **exactamente** los vertices grises.

## Pseudocodigo

```
BFS(G, s)

  para cada u in V(G) \ {s} hacer
      color[u] <- blanco
      d[u] <- infinito;  pi[u] <- NIL
  color[s] <- gris
  d[s] <- 0;  pi[s] <- NIL
  Q <- cola vacia;  ENCOLAR(Q, s)
  mientras Q != vacio hacer
      u <- DESENCOLAR(Q)
      para cada v in Adj[u] hacer
          si color[v] = blanco entonces
              color[v] <- gris
              d[v] <- d[u] + 1;  pi[v] <- u
              ENCOLAR(Q, v)
      color[u] <- negro
  devolver d, pi
```

## Ejemplo de la clase (diapositivas 22–23)

Grafo con vertices $\{r, s, t, u, v, w, x, y\}$, listas de adyacencia en **orden alfabetico**,
fuente $s$. Resultado final:

| $i$ | $L_i = \{v : d[v] = i\}$ | Predecesores |
|---|---|---|
| 0 | $\{s\}$ | $\pi[s] = \text{NIL}$ |
| 1 | $\{r, w\}$ | $\pi[r] = \pi[w] = s$ |
| 2 | $\{v, t, x\}$ | $\pi[v] = r$, $\pi[t] = \pi[x] = w$ |
| 3 | $\{u, y\}$ | $\pi[u] = t$, $\pi[y] = x$ |

> **El orden de las listas puede cambiar el arbol, pero no las distancias.**
> Es decir: el arbol BFS no es unico; los valores $d[v]$ si lo son.

## Propiedades y teoremas

> **Lema (cota inferior).** Al terminar BFS, para todo $v \in V(G)$: $\;d[v] \ge \delta(s, v)$.

> **Lema de la cola.** Si $Q = \langle v_1, v_2, \dots, v_r \rangle$, entonces
> $$d[v_1] \le d[v_2] \le \cdots \le d[v_r] \le d[v_1] + 1.$$
> La cola contiene vertices de **a lo sumo dos capas consecutivas**.

> **Teorema (correctitud de BFS).** Para todo $v \in V(G)$, al terminar BFS, $d[v] = \delta(s, v)$.
> Ademas, para todo vertice $v \ne s$ alcanzable desde $s$, un camino minimo de $s$ a $v$ se
> obtiene tomando un camino minimo de $s$ a $\pi[v]$ y agregando la arista $(\pi[v], v)$.

## Demostraciones

### Lema $d[v] \ge \delta(s,v)$ (diapositiva 24)

El unico valor finito inicial es $d[s] = 0$. Cuando $v$ es descubierto desde $u$, el algoritmo asigna

$$\pi[v] = u, \qquad d[v] = d[u] + 1.$$

Sale por **induccion sobre el numero de descubrimientos** (numero de llamadas a `ENCOLAR`): los
predecesores determinan un camino de $s$ a $v$ de longitud $d[v]$. Como $\delta(s,v)$ es la longitud
**minima** de un camino de $s$ a $v$, resulta $\delta(s, v) \le d[v]$.

Falta probar que BFS **no encuentra un camino mas largo que el minimo** — eso lo da el lema de la cola.

### Lema de la cola (diapositiva 25) — idea

Induccion sobre las operaciones realizadas sobre $Q$:

- Al comienzo, $Q = \langle s \rangle$ y la propiedad es inmediata.
- Al desencolar $v_1$, el nuevo primer elemento $v_2$ satisface $d[v_2] \ge d[v_1]$; las
  desigualdades se conservan.
- Si $v$ se descubre al procesar $u$, entonces $d[v] = d[u] + 1$. Al agregarlo al final, queda
  detras de vertices con distancia $d[u]$ o $d[u] + 1$.

En consecuencia, **los vertices se encolan y se procesan en orden no decreciente de $d$**.

### Teorema $d[v] = \delta(s,v)$ (diapositiva 26) — idea

Supongamos que la igualdad falla y elijamos un vertice $v$ con $\delta(s, v)$ **minima** entre los
que tienen un valor incorrecto.

> ⚠️ Verificar — el PDF corta la demostracion en el planteo del vertice minimal y pasa directamente
> al analisis de complejidad; el argumento de contradiccion completo se hizo en el pizarron.

## Complejidad

El preprocesamiento toma $O(n)$. Con listas de adyacencia, cada vertice se encola a lo sumo una vez
y cada lista se examina a lo sumo una vez:

$$O(n) + O\Bigl(\sum_{v \in V(G)} d(v)\Bigr) = O(n + 2m) = O(n + m).$$

## Subgrafo de predecesores y reconstruccion de caminos

Despues de ejecutar `BFS(G, s)`, definimos $G_\pi = (V_\pi, E_\pi)$, donde

$$V_\pi = \{s\} \cup \{v \in V : \pi[v] \ne \text{NIL}\}, \qquad
E_\pi = \{(\pi[v], v) : v \in V_\pi \setminus \{s\}\}.$$

> **Lema.** El subgrafo de predecesores $G_\pi$ es un **arbol BFS** con raiz $s$. Para todo vertice
> $v$ alcanzable desde $s$, el unico camino simple de $s$ a $v$ en $G_\pi$ es un camino minimo en
> $G$, y su longitud es $d[v] = \delta(s, v)$.

Un arbol BFS con raiz $s$ contiene **exactamente los vertices alcanzables desde $s$**.

```
PRINT-PATH(G, s, v)

  si v = s entonces
      IMPRIMIR(s)
  sino, si pi[v] = NIL entonces
      IMPRIMIR("no existe camino")
  sino
      PRINT-PATH(G, s, pi[v])
      IMPRIMIR(v)
```

---

# 3. Busqueda en profundidad (DFS)

## Definicion

La **busqueda en profundidad (DFS)** explora las aristas que salen del vertice descubierto **mas
recientemente** que todavia tiene aristas sin examinar.

- **Si puede avanzar:** visita recursivamente un vecino **blanco**.
- **Si no puede avanzar:** **retrocede** al vertice desde el cual llego.

Cuando termina de explorar lo alcanzable desde una fuente, el algoritmo elige otro vertice no
descubierto. Por eso, en general, **produce un bosque y no un unico arbol**.

## Bosque DFS

Cuando DFS descubre a $v$ al examinar una arista $(u, v)$, asigna $\pi[v] \leftarrow u$. El subgrafo
de predecesores es

$$G_\pi = (V, E_\pi), \qquad E_\pi = \{(\pi[v], v) : v \in V \text{ y } \pi[v] \ne \text{NIL}\}.$$

$G_\pi$ es el **bosque DFS**; las aristas de $E_\pi$ son las **aristas del arbol**. Cada llamada
inicial a `DFS-VISIT(G, u)` desde el bucle exterior **crea una raiz**.

> A diferencia de BFS, **DFS no esta asociada a una unica fuente**: el bucle exterior garantiza que
> todos los vertices pertenezcan a algun arbol.

## Estados por color

| Color | Significa | Detalle |
|---|---|---|
| **Blanco** | no fue descubierto | no se inicio ninguna llamada a `DFS-VISIT` para el vertice |
| **Gris** | descubierto, aun no termino | la llamada recursiva esta **activa**; puede quedar alguna arista sin examinar |
| **Negro** | termino de procesarse | ya se examino completamente su lista de adyacencia |

> **Invariante.** Los vertices **grises** son exactamente los vertices de la **pila de llamadas
> recursivas**. Esto es lo que hace que un vecino gris sea necesariamente un ancestro.

## Tiempos de descubrimiento y de finalizacion

DFS mantiene un **contador global** `tiempo`. Para cada vertice $u$ registra:

- $d[u]$: instante en que $u$ se **descubre** y pasa a gris;
- $f[u]$: instante en que **termina** de examinarse y pasa a negro.

Como hay **un descubrimiento y una finalizacion por vertice**, los tiempos son enteros de $1$ a
$2\lvert V \rvert$. En particular,

$$1 \le d[u] < f[u] \le 2\lvert V \rvert.$$

## Pseudocodigo

```
DFS(G)

  para cada u in V(G) hacer
      color[u] <- blanco
      pi[u] <- NIL
  tiempo <- 0
  para cada u in V(G) hacer
      si color[u] = blanco entonces
          DFS-VISIT(G, u)
```

```
DFS-VISIT(G, u)

  tiempo <- tiempo + 1
  d[u] <- tiempo
  color[u] <- gris
  para cada v in Adj[u] hacer
      si color[v] = blanco entonces
          pi[v] <- u
          DFS-VISIT(G, v)
  tiempo <- tiempo + 1
  f[u] <- tiempo
  color[u] <- negro
```

La primera iteracion de `DFS` inicializa todos los vertices; la segunda recorre $V(G)$ y **cada
llamada realizada alli crea un nuevo arbol del bosque DFS**.

La llamada de $u$ queda **suspendida** mientras se explora recursivamente un vecino blanco. Solo
finaliza cuando ya se examinaron **todas** las aristas que salen de $u$.

## Ejemplo dirigido de la clase (diapositivas 35–37)

El bucle exterior considera $u, v, w, x, y, z$ en ese orden, con listas de adyacencia:

| $q$ | $\mathrm{Adj}[q]$ | $q$ | $\mathrm{Adj}[q]$ | $q$ | $\mathrm{Adj}[q]$ |
|---|---|---|---|---|---|
| $u$ | $\langle v, x \rangle$ | $v$ | $\langle y \rangle$ | $w$ | $\langle y, z \rangle$ |
| $x$ | $\langle v \rangle$ | $y$ | $\langle x \rangle$ | $z$ | $\langle z \rangle$ |

Resultado:

| $q$ | $u$ | $v$ | $y$ | $x$ | $w$ | $z$ |
|---|---|---|---|---|---|---|
| $d[q]$ | 1 | 2 | 3 | 4 | 9 | 10 |
| $f[q]$ | 8 | 7 | 6 | 5 | 12 | 11 |
| $\pi[q]$ | NIL | $u$ | $v$ | $y$ | NIL | $w$ |

- **Orden de descubrimiento:** $u, v, y, x, w, z$.
- **Orden de finalizacion:** $x, y, v, u, z, w$.
- Se producen **dos arboles** (raices $u$ y $w$) y **doce marcas temporales**.

> **El orden puede cambiar el bosque.** La salida concreta de DFS depende de dos decisiones: el orden
> en que el bucle exterior considera los vertices, y el orden de los vertices en cada lista de
> adyacencia. Esos ordenes pueden modificar **las raices, las aristas del bosque y los tiempos
> $d$ y $f$**.

## Complejidad

Con listas de adyacencia:

- La inicializacion y el bucle exterior cuestan $\Theta(\lvert V \rvert)$.
- `DFS-VISIT` se llama **exactamente una vez por vertice** y, en total, el bucle recorre todas las
  aristas una vez: $\sum_{u \in V} \lvert \mathrm{Adj}[u] \rvert = \Theta(\lvert E \rvert)$.

$$\boxed{\Theta(\lvert V \rvert + \lvert E \rvert)}$$

> Notar que aca la catedra usa $\Theta$ (cota ajustada), a diferencia del $O(n+m)$ de BFS: DFS
> **siempre** recorre todo el grafo, porque el bucle exterior arranca desde cada vertice blanco.

---

# 4. Estructura de parentesis

## Definicion

El intervalo

$$I(u) = [\,d[u],\ f[u]\,]$$

representa el **periodo durante el cual la llamada de $u$ esta activa**.

En la corrida del ejemplo anterior, los intervalos de cada arbol **se anidan**:

$$I(u) = [1,8] \supset I(v) = [2,7] \supset I(y) = [3,6] \supset I(x) = [4,5],
\qquad I(w) = [9,12] \supset I(z) = [10,11].$$

Si al descubrir $u$ escribimos `(u` y al finalizarlo escribimos `u)`, obtenemos una **expresion de
parentesis bien formada**: una llamada recursiva debe terminar antes de que termine la llamada que
la creo.

## Propiedades y teoremas

> **Teorema de los parentesis.** Para cualesquiera $u, v \in V$, ocurre **exactamente una** de las
> siguientes posibilidades:
> 1. $I(u) \cap I(v) = \emptyset$, y ninguno es descendiente del otro;
> 2. $I(u) \subset I(v)$, y $u$ es descendiente de $v$;
> 3. $I(v) \subset I(u)$, y $v$ es descendiente de $u$.
>
> **Dos intervalos nunca se superponen parcialmente.**

> **Corolario.** Un vertice $v$ es **descendiente propio** de $u$ en el bosque DFS **si y solo si**
> $$d[u] < d[v] < f[v] < f[u].$$

> **Teorema del camino blanco.** En el bosque DFS, $v$ es descendiente de $u$ **si y solo si**, en el
> instante $d[u]$, existe un camino de $u$ a $v$ formado **enteramente por vertices blancos**.

## Demostraciones

### Teorema de los parentesis (diapositiva 40) — idea

Supongamos $d[u] < d[v]$.

- Si $v$ se descubre **antes** de que termine $u$, entonces $u$ esta **gris**: la exploracion de $v$
  se completa antes de regresar a $u$, y $I(v) \subset I(u)$.
- Si $u$ **ya habia terminado**, entonces $f[u] < d[v]$, y los intervalos son **disjuntos**.

### Corolario (diapositiva 41) — idea

Es la **traduccion directa** del caso de intervalos anidados del teorema de los parentesis.

Ejemplo de la clase: con $u = 1/8$ y $x = 4/5$, se tiene $1 < 4 < 5 < 8$, luego $x$ es descendiente
de $u$.

### Teorema del camino blanco (diapositiva 42) — idea

$(\Rightarrow)$ El camino de $u$ a cualquiera de sus descendientes en el arbol DFS todavia esta
blanco cuando se descubre $u$.

$(\Leftarrow)$ Si DFS no incorporara todo el camino blanco, tomemos el **primer vertice que queda
afuera**. Su predecesor si es descendiente de $u$ y, al examinar la arista que los une, encontraria
**blanco** al siguiente vertice: contradiccion.

---

# 5. Clasificacion de aristas

La clasificacion se realiza **con respecto al bosque DFS obtenido**.

| Tipo | Definicion |
|---|---|
| **Arbol** (*tree edge*) | La arista $(u,v)$ **descubre por primera vez** a $v$, por lo que $\pi[v] = u$ |
| **Retroceso** (*back edge*) | La arista $(u,v)$ va desde $u$ hacia uno de sus **ancestros** $v$. Los **bucles** se consideran aristas de retroceso |
| **Avance** (*forward edge*) | La arista $(u,v)$ **no pertenece al bosque** y va hacia un **descendiente propio** de $u$ |
| **Cruce** (*cross edge*) | Cualquier otra arista: sus extremos son **incomparables** en el arbol DFS o pertenecen a **arboles distintos** |

> La clasificacion **depende del bosque DFS** y, por lo tanto, puede cambiar cuando cambia el orden
> de exploracion.

En la corrida del ejemplo dirigido (diapositiva 44) aparecen los cuatro tipos: $u \to x$ es una
*forward edge*, $x \to v$ es una *back edge*, y $w \to y$ es una *cross edge*.

## Regla del color: clasificar al examinar la arista

Cuando DFS examina una arista $(u,v)$, el vertice $u$ esta **gris**. Entonces:

| $\text{color}[v]$ | Tipo de $(u,v)$ | Razon |
|---|---|---|
| **blanco** | arbol | $v$ se descubre mediante $(u,v)$ |
| **gris** | retroceso | $v$ es un **ancestro activo** de $u$ |
| **negro** | avance **o** cruce | $v$ ya termino de procesarse |

**Idea clave.** Los vertices grises forman una **cadena de ancestros**: son exactamente las llamadas
activas de la pila. Por eso, una arista hacia un vertice gris necesariamente vuelve hacia un ancestro.

Si $v$ esta **negro**, los tiempos distinguen los dos casos:

$$d[u] < d[v] \implies \text{avance}, \qquad d[v] < d[u] \implies \text{cruce}.$$

## Caso no dirigido

> **Teorema.** En una busqueda en profundidad de un **grafo no dirigido** $G$, toda arista es una
> **arista de arbol** o una **arista de retroceso**. (No hay aristas de avance ni de cruce.)

**Demostracion (idea).** Sea $\{u, v\} \in E$ y supongamos $d[u] < d[v]$.

- Si la arista se examina primero **desde $u$**, entonces $v$ todavia esta blanco y la arista se
  incorpora al arbol.
- Si se examina primero **desde $v$**, entonces $u$ todavia esta **gris** y es un ancestro de $v$; la
  arista es de **retroceso**.

Estas dos posibilidades **agotan los casos**. $\blacksquare$

> Este teorema es el que habilita todo el bloque de puentes: en un grafo no dirigido solo hay
> aristas de arbol y de retroceso, asi que "volver hacia arriba" siempre significa una back edge.

---

# 6. Deteccion de aristas de corte (puentes)

## Por que alcanza con una sola DFS

Sea $G$ un grafo **no dirigido** y sea $T$ el bosque producido por DFS.

- Toda arista que **no** pertenece a $T$ esta contenida en un **ciclo**;
- por lo tanto, **solamente las aristas de $T$ pueden ser puentes**.

> **Cantidad de puentes.** Como todo puente pertenece al arbol DFS,
> $$\#\text{puentes} \le n - 1.$$

**Idea del algoritmo:**

1. Durante una **unica** DFS, calcular para cada vertice su tiempo de descubrimiento $d$, su
   predecesor $\pi$ y un valor $low$.
2. Recorrer las aristas del bosque y decidir cuales son puentes **comparando $low[v]$ con $d[\pi[v]]$**.

El algoritmo **tambien funciona si $G$ no es conexo**: en ese caso, DFS produce un bosque en lugar de
un unico arbol.

## $d[u]$ conserva el significado de DFS

Cuando DFS descubre un vertice $u$, incrementa el contador global `tiempo` y asigna
$d[u] \leftarrow \text{tiempo}$. De este modo, al finalizar,

$$d : V(G) \longrightarrow \{1, \dots, 2\lvert V(G) \rvert\}$$

es la funcion que asigna a cada vertice su **tiempo de descubrimiento**. Ademas, si $u$ fue
descubierto al examinar la arista $\{\pi[u], u\}$, entonces $\pi[u]$ es su **padre** en el bosque DFS.

> **Propiedad que se usa.** Si $x$ es un **ancestro propio** de $u$ en el bosque DFS, entonces
> $d[x] < d[u]$.

Para cada raiz $r$ del bosque, $\pi[r] = \text{NIL}$.

## Definicion de $low$

Se define $low[u]$ como el **menor tiempo de descubrimiento** de un vertice al que se puede llegar
desde $u$:

- bajando **cero o mas** aristas del arbol DFS; y luego
- usando **a lo sumo una** arista que **no** pertenece al arbol.

Mas precisamente:

$$low[u] = \min \begin{cases}
d[u], \\
d[v] : \{u,v\} \text{ es una arista de retroceso y } v \text{ es ancestro de } u, \\
low[w] : \pi[w] = u.
\end{cases}$$

> 🔄 **Cambio respecto de cuatrimestres anteriores**
> **Ahora (2C-2026):** $low[u]$ se define sobre **tiempos de descubrimiento** $d[\cdot]$ de DFS, y el
> criterio de puente es $low[v] > d[\pi[v]]$.
> **Antes:** el mismo algoritmo aparece en el wiki en dos formulaciones distintas y **equivalentes**:
> — [[recorrido_en_grafos_guia]] **Ej. 2** define $low[v]$ sobre los **niveles** del arbol DFS,
> $low[v] = \min(\text{nivel}[v],\ \min_{(v,u) \in E \setminus T} \text{nivel}[u],\ \min_{w \in \text{hijos}(v)} low[w])$,
> con criterio $low[v] > \text{nivel}[\text{padre}[v]]$;
> — [[recorrido_en_grafos_practica]] **Ej. 5** usa el metodo **$\text{cubren}(v)$**: cuenta cuantas
> back edges "cubren" la arista de $v$ a su padre,
> $\text{cubren}(v) = \text{inferior}(v) - \text{superior}(v) + \sum_{w \in \text{hijos}(v)} \text{cubren}(w)$,
> con criterio $\text{cubren}(v) = 0$.
> **Tipo:** notacion
> **Como leerlas juntas:** las tres deciden lo mismo — *"¿el subarbol de $v$ puede alcanzar algo
> estrictamente por encima de su padre sin usar la arista al padre?"*. Cambia con que magnitud se
> mide "por encima": tiempo de descubrimiento (vigente), nivel en el arbol (guia) o conteo de back
> edges que cruzan la arista (practica). **En la cursada vigente manda la version con $d[\cdot]$**,
> pero las otras dos **no se degradan ni se corrigen**: ahi estan las demostraciones y los
> ejercicios ya resueltos, y este bloque es el puente para poder leerlos.
> Fuente: `raw/cursada_2C_2026/teo/teo_clase2_algo_en_grafos.pdf`

## Version offline: calcular $low$ despues de la DFS

**Idea del algoritmo (version en dos etapas):**

1. Ejecutar una DFS **ordinaria** y calcular $T$, $d$, $f$ y $\pi$.
2. Una vez terminada la DFS, calcular los valores $low$ recorriendo $T$ **desde las hojas hacia las
   raices**.
3. Para cada arista $\{\pi[v], v\}$ del bosque, decidir si es puente comparando $low[v]$ con $d[\pi[v]]$.

```
CALCULAR-LOW-OFFLINE(G, T, d, pi)

  para cada u in V(G) hacer
      low[u] <- d[u]
  para cada {u,v} in E(G) \ E(T), con v ancestro de u, hacer
      low[u] <- min{ low[u], d[v] }
  para cada u in V(G) en POSTORDEN de T hacer
      si pi[u] != NIL entonces
          low[pi[u]] <- min{ low[pi[u]], low[u] }
  retornar low
```

> **Por que postorden.** El postorden garantiza que, cuando se procesa $u$, los valores de **todos
> sus hijos ya fueron calculados**. La complejidad es $O(n + m)$.

### Ejemplo trabajado — calculo offline (diapositiva 52)

Grafo de $7$ vertices $\{a,b,c,d,e,f,g\}$.

- **Arbol DFS:** el camino $a - b - c - d - e - f - g$.
- **Aristas de retroceso:** $\{a, c\}$ y $\{e, g\}$.
- **Orden DFS:** $a, b, c, d, e, f, g$ · **Postorden:** $g, f, e, d, c, b, a$.

| $u$ | $a$ | $b$ | $c$ | $d$ | $e$ | $f$ | $g$ |
|---|---|---|---|---|---|---|---|
| $d[u]$ | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| $f[u]$ | 14 | 13 | 12 | 11 | 10 | 9 | 8 |
| $low[u]$ | 1 | 1 | 1 | 4 | 5 | 5 | 5 |

Aplicando el criterio de puente:

$$low[d] = 4 > d[c] = 3, \qquad low[e] = 5 > d[d] = 4.$$

Por lo tanto, **$cd$ y $de$ son aristas de corte**.

> Leer la tabla al reves aclara la idea: $low[c] = 1$ porque la back edge $\{a,c\}$ devuelve a $c$
> hasta $d[a] = 1$; $low[e] = 5$ porque la back edge $\{e,g\}$ solo devuelve al propio $e$. El
> subarbol colgado de $d$ y el colgado de $e$ **no tienen forma de volver por encima de su padre**.

## Version inline: calcular $low$ dentro de la DFS

### Primera fase — inicializacion extendida

```
PUENTES(G)

  para cada u in V(G) hacer
      color[u] <- blanco
      pi[u] <- NIL
      d[u] <- infinito
      low[u] <- infinito
  tiempo <- 0
  para cada u in V(G) hacer
      si color[u] = blanco entonces
          DFS-PUENTES-VISIT(G, u)
```

Al terminar esta fase, $d$, $low$ y $\pi$ estan definidos para **todos** los vertices. La segunda
fase solamente inspeccionara las aristas $\{\pi[v], v\}$ del bosque DFS.

```
DFS-PUENTES-VISIT(G, u)

  tiempo <- tiempo + 1
  d[u] <- tiempo
  low[u] <- d[u]
  color[u] <- gris
  para cada v in Adj[u] hacer
      si color[v] = blanco entonces
          pi[v] <- u
          DFS-PUENTES-VISIT(G, v)
          low[u] <- min{ low[u], low[v] }
      si no, si color[v] = gris y v != pi[u] entonces
          low[u] <- min{ low[u], d[v] }
  tiempo <- tiempo + 1
  f[u] <- tiempo
  color[u] <- negro
```

> ⚠️ **La condicion $v \ne \pi[u]$ es el detalle que se olvida.** Evita considerar como arista de
> retroceso **la copia de la arista del arbol que lleva de $u$ a su padre**. En un grafo no dirigido
> cada arista aparece en dos listas de adyacencia; sin esa guarda, $u$ "vuelve" a su padre por la
> misma arista del arbol y $low[u]$ baja indebidamente, haciendo desaparecer puentes reales.

### Por que las dos actualizaciones de $low$ alcanzan (diapositiva 56)

Al descubrir $u$, inicialmente solamente sabemos que $u$ se alcanza a si mismo:
$low[u] \leftarrow d[u]$.

1. **Un hijo $v$ termina de procesarse.** Todo lo que puede alcanzarse desde el subarbol de $v$
   tambien puede alcanzarse desde el subarbol de $u$. Por eso
   $$low[u] \leftarrow \min\{low[u],\ low[v]\}.$$
2. **Se examina una arista que no es la arista al padre.** La arista $uv$ permite alcanzar
   **directamente** un vertice ya descubierto. Por eso
   $$low[u] \leftarrow \min\{low[u],\ d[v]\}.$$

Como la actualizacion con $low[v]$ se realiza **despues** de la llamada recursiva, los valores se
propagan **de las hojas hacia la raiz**.

### Ejemplo trabajado — calculo inline (diapositiva 55)

Mismo grafo que el ejemplo offline; el resultado coincide. Orden: $a, b, c, d, e, f, g$, con la
aclaracion de que **en $c$ se examina $d$ antes que $a$**.

| $u$ | $a$ | $b$ | $c$ | $d$ | $e$ | $f$ | $g$ |
|---|---|---|---|---|---|---|---|
| $d[u]$ | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| $f[u]$ | 14 | 13 | 12 | 11 | 10 | 9 | 8 |
| $low[u]$ | 1 | 1 | 1 | 4 | 5 | 5 | 5 |

$$low[d] = 4 > d[c] = 3, \qquad low[e] = 5 > d[d] = 4 \implies cd \text{ y } de \text{ son aristas de corte.}$$

> Las dos versiones dan **exactamente la misma tabla**. La diferencia es solo **cuando** se calcula
> $low$: recorriendo $T$ en postorden despues de la DFS (offline), o al retroceder dentro de la
> propia DFS (inline).

## Segunda fase — un test por arista del arbol

Despues de completar todas las llamadas a `DFS-PUENTES-VISIT`, el procedimiento `PUENTES(G)` continua:

```
  B <- vacio
  para cada v in V(G) hacer
      si pi[v] != NIL  y  low[v] > d[pi[v]] entonces
          B <- B union { {pi[v], v} }
  retornar B
```

> **No es necesario recorrer todo $E(G)$ en esta fase:** alcanza con recorrer los **vertices no
> raiz**, uno por cada arista del bosque DFS. (Un vertice no raiz $\leftrightarrow$ la arista que lo
> une a su padre: la biyeccion es exacta.)

> **Teorema (criterio de puente).** Sea $G$ un grafo con $uv \in E(G)$ y $\pi$ producido por el
> algoritmo DFS. Entonces $uv$ es puente de $G$, con $\pi[v] = u$, **si y solo si**
> $$low[v] > d[u].$$

## Complejidad

- La inicializacion cuesta $\Theta(\lvert V \rvert)$.
- Cada vertice es descubierto **una sola vez**.
- Cada arista aparece **dos veces** en las listas de adyacencia y provoca solamente una **cantidad
  constante** de operaciones.
- La segunda fase recorre $V(G)$ una vez.

Por lo tanto, con listas de adyacencia:

$$\boxed{\Theta(\lvert V \rvert + \lvert E \rvert)}$$

**Espacio.** Se almacenan los arreglos $\text{color}$, $\pi$, $d$, $f$ y $low$, ademas de la pila de
recursion y la salida. El espacio adicional es

$$O(\lvert V \rvert)$$

sin contar la representacion del grafo ni la lista de puentes devuelta.

---

## Formulas clave

| Concepto | Formula |
|---|---|
| Orden topologico | $v_i \to v_j \in E \implies i < j$ |
| Lema del DAG | todo DAG tiene $v$ con $d^-(v) = 0$ |
| Teorema del orden topologico | admite orden topologico $\iff$ es aciclico |
| Deteccion de ciclo (Kahn) | $\lvert L \rvert < n \implies$ hay ciclo |
| Costo orden topologico ingenuo | $O(n(n+m))$ |
| Costo ORDEN-TOPOLOGICO | $O(\lvert V \rvert + \lvert E \rvert)$ |
| Capas de BFS | $L_i = \{v \in V : \delta(s,v) = i\}$ |
| Actualizacion BFS | $d[v] = d[u] + 1$, $\pi[v] = u$ |
| Cota inferior BFS | $d[v] \ge \delta(s,v)$ |
| Lema de la cola | $d[v_1] \le d[v_2] \le \cdots \le d[v_r] \le d[v_1] + 1$ |
| Correctitud BFS | $d[v] = \delta(s,v)$ |
| Costo BFS | $O(n) + O\bigl(\sum_v d(v)\bigr) = O(n + 2m) = O(n+m)$ |
| Arbol BFS | $E_\pi = \{(\pi[v], v) : v \in V_\pi \setminus \{s\}\}$ |
| Tiempos DFS | $1 \le d[u] < f[u] \le 2\lvert V \rvert$ |
| Costo DFS | $\Theta(\lvert V \rvert + \lvert E \rvert)$ |
| Intervalo DFS | $I(u) = [d[u], f[u]]$ |
| Descendiente propio | $v \prec u \iff d[u] < d[v] < f[v] < f[u]$ |
| Negro: avance vs. cruce | $d[u] < d[v] \Rightarrow$ avance; $d[v] < d[u] \Rightarrow$ cruce |
| $low$ (vigente) | $low[u] = \min\{d[u];\ d[v] \text{ back edge a ancestro};\ low[w] : \pi[w] = u\}$ |
| Criterio de puente (vigente) | $uv$ puente con $\pi[v] = u \iff low[v] > d[u]$ |
| Cota de puentes | $\#\text{puentes} \le n - 1$ |
| Costo puentes | $\Theta(\lvert V \rvert + \lvert E \rvert)$ tiempo, $O(\lvert V \rvert)$ espacio adicional |

---

## Notas de transcripcion

- **$d^-(v)$ en el lema del DAG (diapositiva 12).** El PDF renderiza el enunciado como
  `d^( v ) = 0`: el signo menos del superindice **no se imprime** en la propia filmina (no es un
  problema de extraccion de texto). Se reconstruye como $d^-(v) = 0$ — grado de entrada — a partir
  del titulo y el cuerpo de la diapositiva 13, *"Vertices con grado de entrada igual a cero"*, donde
  la misma condicion aparece correctamente escrita como $d_D^-(u) = 0$.
- **Diapositiva 26.** El PDF empieza la demostracion del teorema $d[v] = \delta(s,v)$ y salta al
  analisis de complejidad sin cerrarla. Queda marcada con `⚠️ Verificar`: el argumento completo se
  hizo en el pizarron. No se reconstruyo.
- Los graficos de las diapositivas 52 y 55 se transcribieron a texto (arbol DFS + aristas de
  retroceso) leyendo el PDF renderizado; las tablas de $d$, $f$ y $low$ son literales.
- No hubo ninguna formula que quedara ilegible.

---

## Ver tambien

- [[recorrido_en_grafos_practica]] — ejercicios de clase: conectividad, componentes conexas, contar
  caminos minimos (BFS + PD), bipartitez, **aristas puente via $\text{cubren}(v)$**, grafos
  implicitos, **orden topologico con DFS + pila** (variante del Kahn de esta pagina)
- [[recorrido_en_grafos_guia]] — 10 ejercicios de guia; en particular **Ej. 2** (puentes con $low$
  sobre niveles) y **Ej. 5** (BFS y arboles $v$-geodesicos)
- [[grafos_teoria]] — definiciones basicas, grados, $\delta(s,v)$, conexidad, bipartitos y
  **representacion de grafos** (listas vs. matriz)
- [[arboles_teoria]] — arboles y bosques, arboles enraizados, y la version historica de BFS/DFS con
  timestamps y clasificacion de arcos
- [[programa]] — reparto de temas por parcial vigente (2C-2026)
