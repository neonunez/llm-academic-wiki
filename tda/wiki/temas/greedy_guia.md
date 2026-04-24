---
nombre: Greedy — Guia de Ejercicios
parcial: 1P
tipo: guia
tema: greedy
fuente: raw/guias_practicas/2.guia_1P_tecnicas_algoritmicas.pdf
paginas_relacionadas:
  - "[[greedy_teoria]]"
  - "[[greedy_practica]]"
---

# Greedy — Guia de Ejercicios

Practica 2 (Tecnicas Algoritmicas), seccion de Greedy y ejercicios integradores. Ejercicios 27–37. Compilado: 17 sept. 2025.

Los ejercicios 36-37 son integradores (BT → PD → Greedy), cerrando la guia completa de tecnicas.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 27 | SumaSelectiva — maximo subconjunto de tamano k | ⚪ No |
| Ej. 28 | SumaGolosa — sumar elementos de multiconjunto con costo minimo | ⚪ No |
| Ej. 29 | Deadlines — maximizar tareas completadas antes de sus deadlines | 🔴 Si |
| Ej. 30 | RutaEficiente — minimizar paradas en ruta (Viaje a Mar del Plata) | 🔴 Si |
| Ej. 31 | ProductoEscalar — permutaciones que minimizan el producto escalar | 🔴 Si |
| Ej. 32 | DivisionPandemica — particionar curso con cota de parejas cercanas | ⚪ No |
| Ej. 33 | MaxMex — permutacion que maximiza suma de mex de prefijos | ⚪ No |
| Ej. 34 | CacheOpt — politica furthest-in-future para minimizar cache misses | ⚪ No |
| Ej. 35 | ParejasDeBaile — maximas parejas con diferencia de habilidad ≤ 1 | ⚪ No |
| Ej. 36 | InvitacionEstrategica (Problema de la Fiesta / Max Independent Set) | ⚪ No |
| Ej. 37 | SeleccionDeActividades — BT → PD → Greedy (demo por intercambio) | 🔴 Si |

## Patrones de este tema en parciales

> Argumento de intercambio · Lema de eleccion greedy + subestructura optima · Ordenar por criterio correcto

## Ejercicios

### Ejercicio 27 — SumaSelectiva

**Enunciado**

Dado un conjunto $X$ con $|X| = n$ y un entero $k \leq n$, encontrar el maximo valor que pueden sumar los elementos de un subconjunto $S \subseteq X$ de tamano $k$:
$$\max_{S \subseteq X, |S|=k} \sum_{s \in S} s$$

a) Proponer un algoritmo greedy y demostrar su correctitud. Extender para devolver un subconjunto optimo.
b) Implementacion con complejidad $O(n \log n)$.
c) Implementacion con complejidad $O(n \log k)$.

**Explicacion**

Greedy trivial: elegir los $k$ elementos mas grandes. Correctitud: si hubiera un elemento no seleccionado mayor a alguno seleccionado, el intercambio mejoraria la suma (argumento de intercambio directo). $O(n \log n)$ con sorting; $O(n \log k)$ con min-heap de tamano $k$.

**Resolucion paso a paso**

**Parte a) Algoritmo greedy + demostración**

Algoritmo: seleccionar los $k$ elementos más grandes de $X$.

*Demostración de correctitud (argumento de intercambio):*

Sea $S^*$ una solución óptima con $|S^*| = k$. Suponer que $S^*$ no es el conjunto de los $k$ elementos más grandes. Entonces existe $x \in S^*$ y $y \notin S^*$ tal que $y > x$. Definir $S' = (S^* \setminus \{x\}) \cup \{y\}$, con $|S'| = k$.

$$\sum_{s \in S'} s = \sum_{s \in S^*} s - x + y > \sum_{s \in S^*} s$$

Esto contradice que $S^*$ es óptima. Por lo tanto, la solución óptima es el conjunto de los $k$ elementos más grandes. $\blacksquare$

Para devolver el subconjunto: ordenar $X$ crecientemente y retornar los últimos $k$ elementos.

**Parte b) Implementación $O(n \log n)$**

```
Ordenar X de mayor a menor  → O(n log n)
Retornar X[0..k-1]          → O(1)
```

Suma total: $\sum_{i=0}^{k-1} X[i]$.

**Parte c) Implementación $O(n \log k)$**

Usar un min-heap de capacidad $k$:

```
H ← min-heap vacío
Para cada x en X:
  insertar(H, x)            → O(log k)
  si |H| > k:
    extraer_min(H)           → O(log k)
// H contiene los k mayores
retornar suma(H)
```

Invariante: H siempre contiene los $k$ mayores elementos vistos hasta ahora. Si llega un elemento mayor que el mínimo de H, el mínimo se descarta. Total: $O(n \log k)$.

**Chuleta**
> 1. Ordenar $X$ de mayor a menor → tomar primeros $k$ elementos.
> 2. Correctitud: intercambio de cualquier elemento fuera del top-k por uno dentro siempre mejora → el top-k es óptimo.
> 3. $O(n \log n)$: sort + slice. $O(n \log k)$: min-heap de tamaño $k$ (descartar si supera $k$).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 28 — SumaGolosa

**Enunciado**

Encontrar la forma mas economica de sumar todos los elementos de un multiconjunto de numeros naturales, donde cada suma se realiza entre exactamente dos numeros $x$ e $y$ con costo $x + y$.

Ejemplo: $\{1, 2, 5\}$: mejor opcion es $1+2$ (costo 3) luego $3+5$ (costo 8) = total 11.

a) Explicitar una estrategia greedy.
b) Demostrar que es correcta.
c) Implementacion iterativa con complejidad $O(n \log n)$ usando una secuencia ordenada.

**Explicacion**

Greedy: siempre sumar los dos elementos mas pequenos (usar min-heap). Correctitud: se puede demostrar por argumento de intercambio — sumar los dos menores primero reduce los costos subsecuentes. Equivalente al algoritmo de Huffman para codigos optimos.

**Resolucion paso a paso**

**Parte a) Estrategia greedy**

En cada paso, tomar los dos elementos más pequeños del multiconjunto, sumarlos (pagando el costo $x + y$), y reemplazarlos por su suma.

Estructura de datos: min-heap.

```
H ← min-heap con todos los elementos del multiconjunto
costo_total ← 0
mientras |H| > 1:
  x ← extraer_min(H)
  y ← extraer_min(H)
  costo_total += x + y
  insertar(H, x + y)
retornar costo_total
```

Ejemplo: $\{1, 2, 5\}$:
- Paso 1: x=1, y=2 → costo=3, insertar 3. H={3,5}
- Paso 2: x=3, y=5 → costo=8, insertar 8. H={8}
- Total: 3 + 8 = 11. ✓

**Parte b) Demostración de correctitud (argumento de intercambio)**

Clave: el costo total se puede reescribir. Si representamos las sumas como un árbol binario (cada hoja es un elemento original, cada nodo interno es una suma), el costo total es $\sum_{e \in \text{hojas}} e \cdot \text{profundidad}(e)$.

Esto es porque cada elemento $e$ contribuye al costo tantas veces como sumas "lo incluyan" (una vez por cada nivel del árbol desde su hoja hasta la raíz).

Para minimizar esta suma ponderada por profundidades, los elementos más pequeños deben tener mayor profundidad (ser sumados más veces). El greedy garantiza esto: al siempre combinar los dos menores, los menores terminan en las hojas más profundas.

Argumento de intercambio directo: sea $O$ una solución que en el primer paso suma $a$ y $b$ (no los dos menores). Sea $c \leq a \leq b$ el menor elemento. Intercambiar $a$ por $c$ en la primera suma: la primera suma pasa de $a+b$ a $c+b \leq a+b$. El resultado $c+b$ entra al multiconjunto en lugar de $a+b$, y como $c+b \leq a+b$, las sumas futuras con ese resultado no pueden ser peores. Por inducción sobre la cantidad de sumas, el greedy es óptimo. $\blacksquare$

**Parte c) Implementación iterativa $O(n \log n)$**

El algoritmo de la parte a) ya es $O(n \log n)$: $n-1$ iteraciones, cada una con 2 extracciones y 1 inserción en el heap → $O(\log n)$ por iteración.

Con una secuencia ordenada (sin heap), se puede mantener el invariante insertando el resultado en su posición correcta con búsqueda binaria: $O(n \log n)$ total.

**Chuleta**
> 1. Min-heap con todos los elementos.
> 2. Repetir: extraer los dos menores $x, y$; acumular costo $x+y$; reinsertar $x+y$.
> 3. Correctitud: equivalente a construir el árbol de Huffman óptimo. Los menores van a mayor profundidad → mínimo costo acumulado.
> 4. $O(n \log n)$: $n-1$ iteraciones × $O(\log n)$ por heap.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 29 — Deadlines

**Enunciado**

Dado un conjunto de $n$ tareas $T = \{t_1, \ldots, t_n\}$ donde cada tarea $t_i$ tiene deadline $d_i \in \mathbb{Z}^+$ (cada tarea requiere exactamente 1 unidad de tiempo y no se puede interrumpir), maximizar el numero de tareas completadas antes de sus deadlines.

Ejemplo: $n=4$, $D=\{2,1,3,2\}$ → solucion optima $\{t_2, t_1, t_3\}$ (3 tareas).

a) Proponer un algoritmo greedy que maximice las tareas completadas. 
b) Demostrar la optimalidad.

**Explicacion**

Greedy: ordenar por deadline creciente (GSA — Greedy Scheduling Algorithm). Correctitud: similar a la demostracion de seleccion de actividades — argumento de intercambio + lema de subestructura optima. Este ejercicio aparece en [[greedy_practica]] como "Planificacion de tareas con deadlines" con demostracion completa por GSA.

**Resolucion paso a paso**

**Parte a) Algoritmo greedy**

Greedy: **Earliest Deadline First (EDF)**. Ordenar las tareas por deadline $d_i$ creciente. Ejecutarlas en ese orden; si la tarea actual puede completarse antes de su deadline, ejecutarla; si no, descartarla.

```
Ordenar tareas por d_i creciente
t ← 0        // tiempo actual
S ← ∅
para cada tarea t_i (en orden de deadline):
  si t < d_i:         // puede completarse antes del deadline
    S ← S ∪ {t_i}
    t ← t + 1
retornar S
```

Ejemplo: $D = \{2,1,3,2\}$. Orden EDF: $t_2(d=1), t_1(d=2), t_4(d=2), t_3(d=3)$:
- $t=0$: $d_{t_2}=1 > 0$ → ejecutar, $t=1$
- $t=1$: $d_{t_1}=2 > 1$ → ejecutar, $t=2$
- $t=2$: $d_{t_4}=2$, $2 \not< 2$ → descartar
- $t=2$: $d_{t_3}=3 > 2$ → ejecutar, $t=3$
- Resultado: $\{t_2, t_1, t_3\}$ — 3 tareas. ✓

**Parte b) Demostración de optimalidad**

*Lema (el conjunto elegido por EDF es óptimo):*

Primero observar que un conjunto $S$ de tareas es **factible** (pueden ejecutarse todas antes de sus deadlines) si y solo si, cuando se ordenan por deadline, la $j$-ésima tarea puede completarse en el slot $j$ (i.e., $j \leq d_{(j)}$ donde $d_{(j)}$ es el $j$-ésimo deadline más pequeño).

*Demostración de que EDF maximiza $|S|$:*

Sea $G$ el conjunto producido por EDF y $O$ cualquier conjunto factible con $|O| > |G|$.

El greedy rechazó alguna tarea $t^*$. En el momento del rechazo, $t \geq d_{t^*}$. Esto significa que el greedy ya seleccionó $d_{t^*}$ tareas con deadline $\leq d_{t^*}$ (las tareas se procesan por deadline creciente, y el tiempo avanza una unidad por cada selección).

Pero cualquier conjunto factible puede incluir a lo sumo $d_{t^*}$ tareas con deadline $\leq d_{t^*}$ (no hay suficiente tiempo para ejecutar más de $d_{t^*}$ tareas antes del tiempo $d_{t^*}$). Por lo tanto $t^*$ no puede añadirse a ninguna solución factible que ya tenga $d_{t^*}$ tareas con deadline $\leq d_{t^*}$ → $|O| \leq |G|$. Contradicción. $\blacksquare$

**Chuleta**
> 1. Ordenar tareas por $d_i$ creciente (EDF).
> 2. Recorrer en orden: ejecutar si $t < d_i$ (incrementar $t$), descartar si no.
> 3. Correctitud: el greedy nunca rechaza una tarea que podría estar en un conjunto factible mayor (al rechazar $t^*$, ya hay $d_{t^*}$ tareas con deadline $\leq d_{t^*}$ → límite físico del tiempo).
> 4. Complejidad: $O(n \log n)$ por sorting.

**¿Aparece en parciales?** 🔴 Si — planificacion con deadlines es ejercicio de clase practica evaluado

---

### Ejercicio 30 — RutaEficiente

**Enunciado**

Tomas quiere viajar de Buenos Aires (km 0) a Mar del Plata (km $M$) en un Renault 12 que puede hacer hasta $C$ km con el tanque lleno. Las estaciones de servicio estan en los km $0 = x_1 \leq x_2 \leq \ldots \leq x_n \leq M$.

a) Proponer un algoritmo greedy que minimice la cantidad de paradas y devuelva el conjunto de estaciones donde detenerse. Probar correctitud.
b) Dar una implementacion de complejidad temporal $O(n)$.

**Explicacion**

Greedy: en cada paso, ir a la estacion mas lejana que este dentro del alcance $C$. Correctitud: Lema 1 (eleccion greedy) + Lema 2 (subestructura optima). $O(n)$: un unico recorrido del arreglo.

Este ejercicio aparece en [[greedy_practica]] como "Viaje a Mar del Plata" y en [[sintesis/repaso_1P]].

**Resolucion paso a paso**

**Parte a) Algoritmo greedy + demostración**

Greedy: desde la posición actual, **avanzar a la estación más lejana dentro del alcance $C$**.

```
paradas ← []
pos ← 0                   // posicion actual (km 0)
i ← 1
mientras pos < M:
  j ← i
  mientras j <= n y x_j ≤ pos + C:
    j ← j + 1
  si j == i:              // ninguna estacion alcanzable: imposible
    retornar error
  pos ← x_{j-1}          // la más lejana dentro del alcance
  paradas.agregar(x_{j-1})
  i ← j
retornar paradas
```

*Lema 1 (elección greedy):* Existe una solución óptima que en el primer paso selecciona la estación más lejana dentro del alcance.

*Demostración:* Sea $O$ una solución óptima que en el primer paso selecciona $x_j$ (no la más lejana). Sea $x_k$ la estación más lejana dentro del alcance ($x_k \geq x_j$). Definir $O' = (O \setminus \{x_j\}) \cup \{x_k\}$. Como $x_k \geq x_j$, todo lo que era alcanzable desde $x_j$ también es alcanzable desde $x_k$ (o mejor). Por lo tanto $O'$ sigue siendo válida con $|O'| \leq |O|$. $\blacksquare$

*Lema 2 (subestructura óptima):* Después de elegir la primera parada en $x_k$, el problema reducido es llegar de $x_k$ a $M$ con mínimas paradas. La solución óptima del problema original restringida al tramo $[x_k, M]$ es óptima para ese subproblema.

*Demostración del teorema:* por inducción sobre el número de paradas, combinando Lema 1 y Lema 2. $\blacksquare$

**Parte b) Implementación $O(n)$**

El pseudocódigo de la parte a) es $O(n)$: el índice $j$ solo avanza, nunca retrocede. En total $j$ hace a lo sumo $n$ incrementos.

**Chuleta**
> 1. Desde posición actual, avanzar a la estación más lejana dentro del alcance $C$.
> 2. Lema 1: reemplazar la primera parada del óptimo por la más lejana no aumenta las paradas totales.
> 3. Lema 2: el subproblema restante tiene la misma estructura.
> 4. $O(n)$: puntero que solo avanza.

**¿Aparece en parciales?** 🔴 Si — Viaje a Mar del Plata es ejercicio de clase practica y repaso 1P

---

### Ejercicio 31 — ProductoEscalar

**Enunciado**

Dados dos vectores $v = (v_1, \ldots, v_n)$ y $w = (w_1, \ldots, w_n)$ en $\mathbb{R}^n$, encontrar permutaciones $\sigma, \tau$ de sus coordenadas que minimicen el producto escalar:
$$\langle v_\sigma, w_\tau \rangle = \sum_{i=1}^{n} v_{\sigma(i)} \cdot w_{\tau(i)}$$

a) Proponer un algoritmo greedy.
b) Demostrar la optimalidad.

**Explicacion**

Greedy: ordenar $v$ crecientemente y $w$ decrecientemente (o viceversa). Correctitud: argumento de intercambio. Sin perdida de generalidad, se puede fijar $\sigma = id$ y permutar solo $w$. Este ejercicio aparece en [[greedy_practica]] como "Minimizacion del producto escalar".

**Resolucion paso a paso**

**Parte a) Algoritmo greedy**

Sin pérdida de generalidad, fijar $\sigma = \text{id}$ (dejar $v$ fijo y permutar $w$). Greedy: ordenar $v$ crecientemente y $w$ decrecientemente, luego emparejar $v_i$ con $w_{\tau(i)}$ en ese orden.

Equivalentemente: ordenar $v$ crecientemente, ordenar $w$ decrecientemente, emparejar posición a posición.

**Parte b) Demostración de optimalidad (argumento de intercambio)**

*Setup:* ordenar $v$ crecientemente: $v_1 \leq v_2 \leq \ldots \leq v_n$. Buscamos la permutación $\tau$ de $w$ que minimice $\sum_{i=1}^n v_i \cdot w_{\tau(i)}$.

Sea $\tau^*$ una permutación óptima que no es la decreciente de $w$ respecto al orden de $v$. Entonces existen índices $i < j$ tales que $w_{\tau^*(i)} < w_{\tau^*(j)}$ (es decir, $w$ no está ordenado decrecientemente en la posición $i,j$).

Intercambiar $w_{\tau^*(i)}$ y $w_{\tau^*(j)}$ en $\tau^*$. El cambio en el producto escalar es:

$$\Delta = \left(v_i \cdot w_{\tau^*(j)} + v_j \cdot w_{\tau^*(i)}\right) - \left(v_i \cdot w_{\tau^*(i)} + v_j \cdot w_{\tau^*(j)}\right)$$

$$= (v_i - v_j)(w_{\tau^*(j)} - w_{\tau^*(i)})$$

Como $i < j$ y $v$ está ordenado crecientemente: $v_i \leq v_j \Rightarrow v_i - v_j \leq 0$.

Como $w_{\tau^*(i)} < w_{\tau^*(j)}$: $w_{\tau^*(j)} - w_{\tau^*(i)} > 0$.

Por lo tanto $\Delta \leq 0$: el intercambio no empeora el producto escalar. Aplicando este argumento mientras haya inversiones en $w$, la permutación decreciente de $w$ es al menos tan buena como cualquier óptima. $\blacksquare$

**Chuleta**
> 1. Ordenar $v$ crecientemente y $w$ decrecientemente, emparejar posición a posición.
> 2. Correctitud: intercambio de dos elementos fuera de orden en $w$ da $\Delta = (v_i - v_j)(w_j - w_i) \leq 0$ (por $v_i \leq v_j$ y $w_i < w_j$) → no empeora.
> 3. Fórmula: $\Delta = (v_i - v_j)(w_{\tau(j)} - w_{\tau(i)})$.
> 4. Complejidad: $O(n \log n)$ por sorting.

**¿Aparece en parciales?** 🔴 Si — producto escalar minimo es ejercicio de clase practica

---

### Ejercicio 32 — DivisionPandemica

**Enunciado**

Una escuela quiere dividir cada curso en dos subcursos para reducir parejas de estudiantes "cercanos". Cada curso con $c$ parejas cercanas debe dividirse en dos subcursos con a lo sumo $\lfloor c/2 \rfloor$ parejas cada uno.

Formalmente, dado $E$ (estudiantes) y $C \subseteq E \times E$ (parejas cercanas), encontrar una particion $(A, B)$ de $E$ con $|(A \times A) \cap C| \leq |C|/2$ y $|(B \times B) \cap C| \leq |C|/2$.

a) Especificar el problema (instancia y resultado esperado).
b) Demostrar que para toda instancia existe una solucion valida (por induccion en $|E|$; en el paso inductivo, asignar iterativamente cada estudiante al subcurso con menor cantidad de vecinos ya asignados).
c) Disenar un algoritmo lineal basado en la demostracion del inciso b).

**Explicacion**

Greedy incremental: asignar cada estudiante al subcurso que tenga menos vecinos suyos ya asignados. La demostracion por induccion muestra que esto mantiene la invariante $|C \cap (A \times A)| \leq |C|/2$. Complejidad: $O(|E| + |C|)$.

**Resolucion paso a paso**

**Parte a) Especificación**

- *Instancia:* conjunto $E$ de $n$ estudiantes, conjunto $C \subseteq E \times E$ de parejas cercanas (grafo no dirigido).
- *Resultado esperado:* partición $(A, B)$ con $A \cup B = E$, $A \cap B = \emptyset$, tal que:
  $$|(A \times A) \cap C| \leq \lfloor |C|/2 \rfloor \quad \text{y} \quad |(B \times B) \cap C| \leq \lfloor |C|/2 \rfloor$$

**Parte b) Demostración por inducción en $|E|$**

*Invariante:* para todo $E, C$, existe una partición $(A, B)$ válida.

*Base ($|E| = 0$):* $(A=\emptyset, B=\emptyset)$ cumple trivialmente ($0 \leq 0$).

*Paso inductivo:* sea $|E| = n$. Tomar cualquier $e \in E$ y aplicar HI a $(E' = E \setminus \{e\}, C' = C \cap (E' \times E'))$: existe $(A', B')$ válida para $E'$ con $|C' \cap (A' \times A')| \leq |C'|/2$.

Sea $a$ = número de vecinos de $e$ en $A'$ y $b$ = número de vecinos de $e$ en $B'$, con $a + b \leq \deg_C(e)$. Asignar $e$ al grupo con menos vecinos, WLOG $a \leq b$, asignar $e$ a $A$:

Al agregar $e$ a $A'$, los nuevos pares en $(A \times A) \cap C$ son exactamente los vecinos de $e$ en $A'$: se añaden $a$ pares.

Necesitamos: $|C \cap (A \times A)| = |C' \cap (A' \times A')| + a \leq |C|/2$.

Como $a \leq b$ y $a + b = $ pares de $e$ en $C$ que van a algún grupo: $a \leq (a+b)/2$. Los $a$ pares nuevos "dentro" de $A$ corresponden a $a$ aristas de $C$ "consumidas" dentro del mismo grupo, y los otros $b$ van entre grupos distintos. Para ver que la cota global se mantiene: cada arista de $C$ va a parar a "dentro de $A$", "dentro de $B$", o "entre $A$ y $B$". El greedy minimiza las que van dentro al asignar $e$ al lado con menos vecinos, lo que garantiza que al menos la mitad de las aristas de $e$ van entre grupos. Por inducción, la invariante $|C \cap (A \times A)| + |C \cap (B \times B)| \leq |C|$ se mantiene con equilibrio. $\blacksquare$

**Parte c) Algoritmo lineal**

```
Construir lista de adyacencia de (E, C)
A ← ∅, B ← ∅
Para cada e en E:  // en cualquier orden
  a ← |{v ∈ A : (e,v) ∈ C}|   // contar vecinos de e en A
  b ← |{v ∈ B : (e,v) ∈ C}|   // contar vecinos de e en B
  si a ≤ b: A ← A ∪ {e}
  sino:     B ← B ∪ {e}
retornar (A, B)
```

Complejidad: $O(|E| + |C|)$ — cada arista se procesa a lo sumo dos veces (una por cada extremo).

**Chuleta**
> 1. Para cada estudiante, asignarlo al grupo con menos vecinos ya asignados.
> 2. Correctitud: asignar $e$ al lado de menos vecinos garantiza $\min(a,b) \leq (a+b)/2$ aristas nuevas "dentro" → por inducción se mantiene la cota $|C|/2$.
> 3. $O(|E| + |C|)$ con lista de adyacencia.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 33 — MaxMex

**Enunciado**

Definir $mex(X) = \min\{j : j \in \mathbb{N} \land j \notin X\}$ (el menor natural no en $X$). Dado un vector $a_1 \ldots a_n$, encontrar la permutacion $b_1 \ldots b_n$ que maximice:
$$\sum_{i=1}^{n} mex(\{b_1, \ldots, b_i\})$$

Ejemplo: $\{3,0,1\}$ → mejor permutacion $\{0,1,3\}$, valor $mex\{0\} + mex\{0,1\} + mex\{0,1,3\} = 1 + 2 + 2 = 5$.

a) Proponer un algoritmo greedy. Hint: ¿cual es el maximo valor que puede tomar $mex(X)$ si $|X|=n$? Si $X \subseteq Y$, ¿que pasa con $mex(X)$ y $mex(Y)$?
b) Implementacion con complejidad $O(n)$.

**Explicacion**

El mex de un conjunto de $n$ elementos es a lo sumo $n$. Para maximizar, hay que ir construyendo el conjunto $\{0, 1, 2, \ldots\}$ tan rapido como sea posible: colocar primero los numeros $0, 1, 2, \ldots$ (en orden) si estan en el vector, luego los demas en cualquier orden. Esto maximiza el mex en cada paso.

**Resolucion paso a paso**

**Parte a) Algoritmo greedy**

Observaciones del hint:
1. $mex(X) \leq |X|$ siempre (si $0,1,\ldots,|X|-1 \in X$, entonces $mex = |X|$; en otro caso $mex < |X|$).
2. Si $X \subseteq Y$ entonces $mex(X) \leq mex(Y)$ (agregar elementos no puede bajar el mex).

Estrategia: construir el prefijo $\{0, 1, 2, \ldots\}$ lo más rápido posible. Colocar primero los elementos $0, 1, 2, \ldots, m-1$ (en ese orden) donde $m$ es el máximo tal que $\{0, 1, \ldots, m-1\} \subseteq$ multiconjunto del vector. Luego colocar el resto en cualquier orden.

Ejemplo: $\{3, 0, 1\}$. El máximo prefijo consecutivo desde 0 que está en el vector: $m=2$ (tenemos 0 y 1, pero no 2). Permutación: $[0, 1, 3]$.
- $mex\{0\} = 1$
- $mex\{0,1\} = 2$
- $mex\{0,1,3\} = 2$
- Suma = $1 + 2 + 2 = 5$. ✓

Si hubiera duplicados de 0,1,…: colocar uno de cada primero (en orden), luego los duplicados.

**Parte b) Implementación $O(n)$**

```
// Paso 1: tabla de frecuencias
freq ← tabla de frecuencias de a[1..n]  // O(n)

// Paso 2: encontrar m (máximo prefijo consecutivo)
m ← 0
mientras freq[m] > 0:
  m ← m + 1
// Ahora m es el menor entero no en el vector

// Paso 3: construir permutación
b ← [0, 1, 2, ..., m-1]  // los primeros m enteros en orden
b += [elementos de a no en {0,...,m-1}]  // el resto en cualquier orden

// Calcular la suma (opcional, si se pide el valor):
suma ← sum(i+1 for i in 0..m-1) + (n - m) * m
     = m*(m+1)/2 + (n-m)*m
```

La suma total es $\sum_{i=1}^{m} i + (n-m) \cdot m = \frac{m(m+1)}{2} + (n-m) \cdot m$.

**Chuleta**
> 1. Encontrar $m$ = máximo prefijo consecutivo $\{0,1,\ldots,m-1\}$ en el vector ($O(n)$ con tabla de frecuencias).
> 2. Permutación: colocar $0,1,\ldots,m-1$ primero (en orden), luego el resto.
> 3. Suma $= m(m+1)/2 + (n-m) \cdot m$.
> 4. Correctitud: colocar el prefijo lo antes posible maximiza mex en cada paso (cada entero añadido al prefijo sube el mex en 1).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 34 — CacheOpt

**Enunciado**

Dado una cache $C$ de tamano $k$ y una lista de $n$ requests $R = \{r_1, r_2, \ldots, r_n\}$ a posiciones de memoria, determinar que decision debe tomar la cache en cada paso para minimizar la cantidad de cache misses.

Politica furthest-in-future: al necesitar desalojar, se descarta la posicion cuyo proximo acceso es el mas lejano (o sin siguiente acceso).

a) (Opcional) Definir $f(i, mem)$ recursiva. ¿Cuando vale la pena memoizar?
b) Demostrar que furthest-in-future es optima (argumento de intercambio: si un paso no sigue la politica, se puede alterar sin aumentar los misses).
c) Algoritmo en $O(n \log k)$ que informe la decision en cada paso.

**Explicacion**

Greedy clasico en teoria de caches. La demostracion de optimalidad es por "exchange argument": dado cualquier algoritmo optimo, si en algun paso no usa furthest-in-future, se puede intercambiar la decision para que si la use sin aumentar los misses.

**Resolucion paso a paso**

**Parte a) Definición recursiva $f(i, mem)$**

$f(i, mem)$ = mínimo número de cache misses al procesar requests $r_i, r_{i+1}, \ldots, r_n$ cuando el contenido actual de la cache es $mem \subseteq$ universo de memoria, $|mem| = k$.

*Caso base:* $f(n+1, mem) = 0$.

*Caso recursivo:*
- Si $r_i \in mem$: hit, $f(i, mem) = f(i+1, mem)$.
- Si $r_i \notin mem$: miss, traer $r_i$ desalojando algún $v \in mem$:
$$f(i, mem) = 1 + \min_{v \in mem} f\!\left(i+1,\ (mem \setminus \{v\}) \cup \{r_i\}\right)$$

¿Cuándo vale la pena memoizar? Cuando hay muchos estados $(i, mem)$ repetidos. El número de estados distintos es $O\!\left(n \cdot \binom{U}{k}\right)$ donde $U$ = posiciones distintas. Si $U$ es grande, la PD es exponencial → memoizar solo es práctico cuando $U$ es pequeño (número reducido de posiciones distintas en $R$).

**Parte b) Demostración de furthest-in-future**

*Argumento de intercambio:*

Sea $A$ un algoritmo óptimo con $\leq$ misses que cualquier otro. Construir $B$ (furthest-in-future) que sea "al menos tan bueno" como $A$ mediante una serie de modificaciones.

*Invariante:* al inicio de cada request $r_i$, las caches de $A$ y $B$ difieren en a lo sumo los elementos que B va a necesitar antes que A.

En el paso $i$ donde $A$ y $B$ difieren:
- Si es hit en ambos o miss en ambos con misma decisión de desalojo: sincronizan.
- Si es miss en ambos y $A$ desaloja $v_A$, $B$ desaloja $v_B$ (furthest): si $v_A \neq v_B$, modificamos $A$ para que desaloje $v_B$ en este paso:
  - $v_B$ se usa después de $v_A$ (por definición de furthest-in-future).
  - Cuando llegue el momento en que $v_A$ se necesite, $A$ modificado puede desalojarlo entonces; como $v_B$ aún no se necesita, no hay miss extra.
  - Resultado: $A$ modificado tiene las mismas o menos misses que $A$ original, y se sincroniza con $B$.

Repetir este argumento para cada divergencia: $B$ (furthest-in-future) tiene $\leq$ misses que cualquier $A$ óptimo. $\blacksquare$

**Parte c) Algoritmo $O(n \log k)$**

```
Preprocesar next[i]: para cada posicion r_i,
  next[i] = min{j > i : r_j = r_i}  (o ∞ si no hay siguiente)
  → O(n) con recorrido de derecha a izquierda

cache ← max-heap de (next[r], r) para los elementos en cache, tamaño ≤ k
misses ← 0

Para i = 1..n:
  si r_i ∈ cache:  // O(1) con hash set auxiliar
    actualizar next de r_i en el heap  → O(log k)
  sino:
    misses ← misses + 1
    si |cache| == k:
      desalojar la raíz del max-heap (mayor next)  → O(log k)
    insertar (next[i], r_i) en el heap  → O(log k)

retornar misses
```

Complejidad: $O(n \log k)$ — $n$ iteraciones, cada una $O(\log k)$ en el heap.

**Chuleta**
> 1. Política: al necesitar desalojar, expulsar el elemento cuyo próximo acceso es el más lejano (o nunca).
> 2. Correctitud: exchange argument — si un óptimo difiere de FIF, modificar esa decisión sincroniza con FIF sin aumentar misses.
> 3. Implementación: preprocesar `next[]` en $O(n)$; max-heap de tamaño $k$ → $O(n \log k)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 35 — ParejasDeBaile

**Enunciado**

Dados dos conjuntos de personas con habilidades de baile, formar el maximo numero de parejas (una persona de cada conjunto) tal que la diferencia de habilidad de cada pareja sea $\leq 1$.

Ejemplo: $\{1,2,4,6\}$ y $\{1,5,5,7,9\}$ → maximo 3 parejas.

a) Observar que con ambos multiconjuntos ordenados crecientemente, la solucion se puede obtener recorriendo en orden.
b) Disenar un algoritmo greedy que recorra cada multiconjunto una unica vez. Calcular complejidad.
c) Demostrar correctitud.

**Explicacion**

Greedy: con dos punteros en los multiconjuntos ordenados, si los elementos actuales pueden formar pareja ($|h_A - h_B| \leq 1$) se emparejan, si no se avanza el puntero del menor. $O(n)$ despues del ordenamiento ($O(n \log n)$ total).

**Resolucion paso a paso**

**Parte a) Observación**

Con $A = \{a_1 \leq a_2 \leq \ldots \leq a_p\}$ y $B = \{b_1 \leq b_2 \leq \ldots \leq b_q\}$ ordenados, el óptimo nunca "cruza" parejas: si $a_i$ se empareja con $b_j$ y $a_k$ con $b_l$ con $i < k$, entonces $j \leq l$ en el óptimo. Esto se demuestra por intercambio: si hubiera cruce ($j > l$), intercambiar los emparejamientos no disminuye la cantidad de parejas válidas (las diferencias siguen dentro de $\leq 1$ o no cambia cuales son válidas).

**Parte b) Algoritmo dos punteros**

```
Ordenar A crecientemente  → O(|A| log |A|)
Ordenar B crecientemente  → O(|B| log |B|)
i ← 0, j ← 0, parejas ← 0
mientras i < |A| y j < |B|:
  si |A[i] - B[j]| ≤ 1:
    parejas ← parejas + 1
    i ← i + 1
    j ← j + 1
  sino si A[i] < B[j]:
    i ← i + 1    // A[i] no puede emparejarse con nadie
  sino:
    j ← j + 1    // B[j] no puede emparejarse con nadie
retornar parejas
```

Complejidad: $O(n \log n + m \log m)$ por sorting; $O(n + m)$ el recorrido.

Ejemplo: $A = \{1,2,4,6\}$, $B = \{1,5,5,7,9\}$:
- $i=0,j=0$: $|1-1|=0 \leq 1$ → pareja, $i=1,j=1$
- $i=1,j=1$: $|2-5|=3 > 1$, $A[1]=2 < B[1]=5$ → $i=2$
- $i=2,j=1$: $|4-5|=1 \leq 1$ → pareja, $i=3,j=2$
- $i=3,j=2$: $|6-5|=1 \leq 1$ → pareja, $i=4,j=3$
- $i=4$: fin. Total: 3 parejas. ✓

**Parte c) Demostración de correctitud**

*Caso "no emparejar":* si $A[i] < B[j] - 1$, entonces para todo $k \geq j$: $B[k] \geq B[j] > A[i] + 1$, así que $A[i]$ no puede emparejarse con ningún $B[k]$ restante → avanzar $i$ no pierde ninguna pareja posible.

*Caso "emparejar":* si $|A[i] - B[j]| \leq 1$, emparejarlos es al menos tan bueno como no hacerlo (lema de intercambio): si en el óptimo $A[i]$ no se empareja con $B[j]$ pero sí con $B[k]$ (o viceversa), se puede reorganizar para que $A[i]$ se empareje con $B[j]$ sin perder ninguna pareja (los elementos ordenados garantizan que las diferencias siguen siendo válidas o quedan libres para otros emparejamientos). $\blacksquare$

**Chuleta**
> 1. Ordenar ambos conjuntos crecientemente.
> 2. Dos punteros: si $|A[i]-B[j]| \leq 1$ → emparejar y avanzar ambos. Si $A[i] < B[j]$ → avanzar $i$. Si $B[j] < A[i]$ → avanzar $j$.
> 3. Correctitud: el elemento descartado no puede emparejarse con ningún elemento futuro (por orden).
> 4. $O(n \log n)$ total.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 36 — InvitacionEstrategica (Problema de la Fiesta)

**Enunciado**

Dado un conjunto $V$ de posibles invitados y un conjunto $E$ de conflictos (pares no ordenados), encontrar un subconjunto $S \subseteq V$ de cardinalidad maxima tal que $\{v,w\} \notin E$ para todo par $v,w \in S$ (conjunto independiente maximo en grafos).

a) Funcion recursiva $fs(S, W)$ (S = invitados ya elegidos, W = candidatos compatibles con S) que devuelva el conjunto de maxima cardinalidad que contiene a S.
b) Implementar el algoritmo de backtracking basado en a): cada nodo del arbol tiene $(S, W)$; la extension considera 2 opciones para $w \in W$: no invitar (S queda igual, W pierde w) o invitar (S gana w, W pierde todos los conflictos de w).
c) Escribir los tres primeros niveles del arbol de BT.
d) Describir una regla de optimalidad para podar.
e) ¿Se puede definir $fs(V, S, i)$ solo con indice $i$? ¿Cual es el problema? (No se puede: el estado $W$ depende de $S$, no solo de $i$).
f) Observar que hay $\Omega(2^n)$ posibles instancias de $fs$: no hay superposicion de subproblemas en el caso general → NP-completo.

**Explicacion**

Maximal Independent Set es NP-completo en general. Este ejercicio muestra que no toda BT puede convertirse en PD eficiente: la ausencia de superposicion de subproblemas es la diferencia clave. Contraste con Ejercicio 37 (Seleccion de Actividades) donde si hay estructura.

**Resolucion paso a paso**

**Parte a) Función recursiva $fs(S, W)$**

```
fs(S, W):
  si W = ∅: retornar S
  elegir cualquier w ∈ W
  // opción 1: no invitar a w
  no_invitar ← fs(S, W \ {w})
  // opción 2: invitar a w — eliminar todos sus conflictos de W
  invitar ← fs(S ∪ {w}, W \ ({w} ∪ N(w)))   // N(w) = vecinos de w en E
  retornar el de mayor cardinalidad
```

**Parte b) Árbol de backtracking (tres primeros niveles)**

Sea $V = \{v_1, v_2, \ldots\}$. El árbol tiene raíz $(S=\emptyset, W=V)$.

```
Nivel 0: (∅, V)
           ├── no invitar v₁: (∅, V\{v₁})
           └── invitar v₁:    ({v₁}, V\{v₁}\N(v₁))

Nivel 1, rama izquierda (∅, V\{v₁}):
  ├── no invitar v₂: (∅, V\{v₁,v₂})
  └── invitar v₂:    ({v₂}, V\{v₁,v₂}\N(v₂))

Nivel 1, rama derecha ({v₁}, V\{v₁}\N(v₁)):
  sea w₃ el primer elemento de V\{v₁}\N(v₁)
  ├── no invitar w₃: ({v₁}, V\{v₁}\N(v₁)\{w₃})
  └── invitar w₃:    ({v₁,w₃}, V\{v₁}\N(v₁)\{w₃}\N(w₃))
```

**Parte c) Regla de poda (optimalidad)**

Cota superior: desde el estado $(S, W)$, la solución máxima alcanzable tiene a lo sumo $|S| + |W|$ invitados. Si $|S| + |W| \leq \text{mejor\_conocido}$, podar.

**Parte d) ¿Por qué no se puede reducir a índice $i$?**

No se puede definir $fs(V, S, i)$ usando solo el índice $i$ como estado porque el conjunto $W$ de candidatos disponibles **depende del subconjunto exacto $S$ elegido hasta ahora** (los conflictos de los invitados eliminan distintos candidatos en cada rama). Dos nodos del árbol en el "nivel $i$" pueden tener $W$ completamente distintos según las elecciones anteriores → el estado $(S, W)$ no se puede comprimir a un escalar.

**Parte e) Ausencia de superposición → NP-completo**

Para cada subconjunto $S \subseteq V$, el estado $W = V \setminus (S \cup N(S))$ puede ser distinto. Hay $2^n$ subconjuntos posibles de $S$ → $\Omega(2^n)$ posibles estados $(S, W)$. No hay superposición de subproblemas en el caso general. El problema de Independent Set Máximo es NP-completo.

**Chuleta**
> 1. BT: $fs(S, W)$ — elegir $w \in W$: no invitar ($W$ pierde $w$) o invitar ($S$ gana $w$, $W$ pierde $w$ y $N(w)$). $O(2^n)$.
> 2. Poda: si $|S| + |W| \leq$ mejor conocido, podar.
> 3. No se puede memoizar: $W$ depende de $S$ exacto, no solo del índice.
> 4. NP-completo: $\Omega(2^n)$ estados distintos → no hay PD polinomial.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 37 — SeleccionDeActividades

**Enunciado**

Dado un conjunto de actividades $A = \{A_1, \ldots, A_n\}$ donde cada $A_i$ ocupa el intervalo $(s_i, t_i)$, encontrar un subconjunto $S$ de cardinalidad maxima tal que ningún par de actividades de $S$ se solapen.

a) Analogia con el Problema de la Fiesta (ej 36): proponer un algoritmo de backtracking. Complejidad.
b) Con $A$ ordenado por momento de comienzo, escribir $act(A, S, i)$ que encuentre el conjunto maximo de actividades seleccionables que contiene a $S \subseteq \{A_1, \ldots, A_{i-1}\}$ usando solo actividades de $\{A_i, \ldots, A_n\}$. ¿Por que aqui si se puede y en el Ej. 36 no?
c) Implementar un algoritmo de PD basado en b). Complejidad.
d) Estrategia greedy: elegir siempre la actividad con momento final mas temprano que no se solape con las ya elegidas. Demostrar correctitud por induccion.
e) Implementacion greedy en $O(n)$.

**Explicacion**

La clave es que al ordenar por $s_i$, el estado de $act$ se reduce a "cual fue la ultima actividad elegida" (su tiempo final). Esto permite PD en $O(n^2)$. La version greedy es $O(n)$ (o $O(n \log n)$ con sorting). La demostracion es el argumento clasico de intercambio por induccion: en cada paso, la eleccion greedy puede sustituir a la optima sin perder cardinalidad.

Este ejercicio aparece como "Seleccion de Actividades" en [[greedy_teoria]] y [[greedy_practica]] con demostracion completa.

**Resolucion paso a paso**

**Parte a) Backtracking — analogía con Problema de la Fiesta**

El grafo de conflictos tiene una arista entre $A_i$ y $A_j$ si sus intervalos se solapan. Selección de Actividades = Independent Set Máximo en el grafo de intervalos resultante. Aplicar $fs(S, W)$ del Ej. 36 directamente.

Complejidad: $O(2^n)$ en el peor caso.

**Parte b) Formulación $act(A, S, i)$ — por qué sí permite PD**

Con $A$ ordenado por $s_i$ (momento de inicio): $act(A, S, i)$ = máximo conjunto que contiene a $S$ usando actividades de $\{A_i, \ldots, A_n\}$.

El conjunto $S$ solo importa a través de **cuándo terminó la última actividad elegida** ($f_{last}$). Con actividades ordenadas por inicio, la compatibilidad de $A_i$ con $S$ depende únicamente de si $s_i \geq f_{last}$. Dos estados con el mismo $f_{last}$ son **equivalentes** → el estado se colapsa de un conjunto exponencial a un único número.

Por qué en Ej. 36 no: en Independent Set general, $W$ depende del subconjunto $S$ exacto (no hay resumen numérico). Aquí la estructura de intervalos garantiza que solo $f_{last}$ determina compatibilidad futura.

**Parte c) Implementación PD**

Ordenar por $f_i$ (tiempo de fin). Definir:
- $dp[i]$ = máximo número de actividades sin solapar usando $\{A_1, \ldots, A_i\}$
- $p(i)$ = mayor $j < i$ tal que $f_j \leq s_i$ (última actividad compatible con $A_i$)

$$dp[i] = \max(dp[i-1],\ dp[p(i)] + 1)$$

```
Ordenar A por f_i
Calcular p(i) para todo i    → O(n log n) con búsqueda binaria
dp[0] ← 0
Para i = 1..n:
  dp[i] ← max(dp[i-1], dp[p(i)] + 1)
retornar dp[n]
```

Complejidad: $O(n \log n)$ (con búsqueda binaria para $p(i)$).

**Parte d) Estrategia greedy — demostración por inducción**

Estrategia: de las actividades compatibles con las ya elegidas, elegir **siempre la de menor tiempo de finalización**.

La demostración completa está en [[greedy_teoria]]. Esquema:

*Lema:* para todo $i \leq \min(|G|, |O|)$: $f(g_i) \leq f(o_i)$.

*Base* ($i=1$): $g_1$ tiene menor $f_i$ entre todas; $o_1$ es una de ellas → $f(g_1) \leq f(o_1)$.

*Paso inductivo:* por HI $f(g_{i-1}) \leq f(o_{i-1})$. Entonces $s(o_i) \geq f(o_{i-1}) \geq f(g_{i-1})$ → $o_i$ es compatible con $\{g_1,\ldots,g_{i-1}\}$. El greedy elige la de menor fin entre compatibles: $f(g_i) \leq f(o_i)$. $\blacksquare$

*Teorema* (por contradicción): si $|G| < |O|$, existe $o_{|G|+1}$ compatible con $G$ por el lema → el greedy no debió detenerse. Contradicción. $\blacksquare$

**Parte e) Implementación greedy $O(n)$**

```
Ordenar A por f_i  → O(n log n)
S ← {A₁}           // la de menor f_i es siempre elegible
f_last ← f₁
Para i = 2..n:
  si s_i ≥ f_last:
    S ← S ∪ {Aᵢ}
    f_last ← f_i
retornar S
```

$O(n)$ el recorrido post-sort (un único pase).

**Chuleta**
> 1. BT: $fs(S, W)$ análogo a Independent Set. $O(2^n)$.
> 2. PD: estado = $f_{last}$ (el conjunto $S$ colapsa a su tiempo de fin). $dp[i] = \max(dp[i-1],\, dp[p(i)]+1)$. $O(n \log n)$.
> 3. Greedy: ordenar por $f_i$, elegir siempre la de menor fin compatible. $O(n)$ post-sort.
> 4. Demo: Lema $f(g_i) \leq f(o_i)$ por inducción → $|G| \geq |O|$ por contradicción.

**¿Aparece en parciales?** 🔴 Si — Seleccion de Actividades es ejercicio canonico de Greedy evaluado en parciales

## Ver tambien

- [[greedy_teoria]] — Mochila fraccionaria, cambio de monedas, seleccion de actividades (con demo)
- [[greedy_practica]] — Planificacion con deadlines, Viaje Mar del Plata, producto escalar
- [[programacion_dinamica_guia]] — Seccion PD de la misma guia (ej. 9-26)
- [[fuerza_bruta_backtracking_guia]] — Seccion BT de la misma guia (ej. 1-8)
