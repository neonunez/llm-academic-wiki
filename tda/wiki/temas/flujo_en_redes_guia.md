---
nombre: Flujo en Redes — Guia de Ejercicios
parcial: 2P
tipo: guia
tema: flujo_en_redes
fuente: raw/guias_practicas/6.guia_2P_flujo_en_redes.pdf
paginas_relacionadas:
  - "[[flujo_en_redes_teoria]]"
  - "[[flujo_en_redes_practica]]"
  - "[[flujo_en_redes_practica_pt2]]"
---

# Flujo en Redes — Guia de Ejercicios

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Propiedades flujo max (par/impar/racional) | ⚪ No |
| Ej. 2 | Red con F iteraciones para Ford-Fulkerson | ⚪ No |
| Ej. 3 | Complejidad Edmonds-Karp en tres variantes | ⚪ No |
| Ej. 4 | Algoritmo lineal para corte de capacidad minima | ⚪ No |
| Ej. 5 | Modelado: max caminos disjuntos en aristas | 🔴 Si |
| Ej. 6a | Popular-A: Ariana, calles sin repetir (caminos disjuntos aristas) | 🔴 Si |
| Ej. 6b | Popular-B: interceptar a Cynthia (corte min en vertices) | 🔴 Si |
| Ej. 7 | Matching bipartito de cardinalidad maxima | 🔴 Si |
| Ej. 8 | Solteros en mesas (asignacion con limites por familia/mesa) | ⚪ No |
| Ej. 9 | Matriz m×n con sumas de filas y columnas fijas | ⚪ No |
| Ej. 10 | Realizacion de secuencia digrafica | ⚪ No |
| Ej. 11 | Grafo mixto euleriano | ⚪ No |
| Ej. 12 | Hospital con K periodos de feriados | 🔴 Si |
| Ej. 13 | Enchufes: adaptadores para dispositivos | 🔴 Si |
| Ej. 14 | Figuritas de Carle — intercambio (version 1) | ⚪ No |
| Ej. 15 | Figuritas de Carle — intercambio (version 2, identico a 14) | ⚪ No |
| Ej. 16 | Satelite: datos con N ventanas de tiempo | 🔴 Si |
| Ej. 17 | Titanic: personas en maderas via icebergs | 🔴 Si |
| Ej. 18 | Maquinas y proyectos (beneficio neto via min-cut) | 🔴 Si |
| Ej. 19 | Nodos valiosos: subconjunto sin aristas salientes | ⚪ No |
| Ej. 20 | Subgrafo de peso maximo con nodos y aristas ponderados | ⚪ No |
| Ej. 21 | Edificios y normativas: alturas con multas | ⚪ No |
| Ej. 22 | Ford-Fulkerson con camino de aumento de costo minimo | ⚪ No |
| Ej. 23 | Matching bipartito de peso minimo | ⚪ No |
| Ej. 24 | TSP via matching bipartito (caso $|V|=2n$) | ⚪ No |
| Ej. 25 | Red con demandas: reduccion a red sin demandas | ⚪ No |
| Ej. 26 | Elecciones Rumestania (max telegramas digitalizados) | 🔴 Si |
| Ej. 27 | Torneos de Futbol: puede ganar el equipo (Furbo) | 🔴 Si |

---

## Ejercicios

### Ejercicio 1 — Propiedades de flujos en redes

**Enunciado**

Para cada una de las siguientes sentencias sobre el problema de flujo maximo en una red $N$: demostrar que es verdadera o dar un contraejemplo.

a) Si la capacidad de cada arista de $N$ es par, entonces el valor del flujo maximo es par.

b) Si la capacidad de cada arista de $N$ es par, entonces existe un flujo maximo en el cual el flujo sobre cada arista de $N$ es par.

c) Si la capacidad de cada arista de $N$ es impar, entonces el valor del flujo maximo es impar.

d) Si la capacidad de cada arista de $N$ es impar, entonces existe un flujo maximo en el cual el flujo sobre cada arista de $N$ es impar.

e) Si todas las aristas de $N$ tienen capacidades racionales, entonces el flujo maximo es racional.

**Explicacion**

Ejercicio de analisis de propiedades. Activa el Teorema del Flujo Entero (FF garantiza flujo entero cuando capacidades son enteras) y su generalizacion a racionales. Para (a) y (b) usar integridad: si capacidades pares, Ford-Fulkerson produce flujo entero, y un flujo entero puede ser reescalado. Para (c)/(d): contraejemplo clasico con dos rutas. Para (e): racionales se pueden escalar a enteros → flujo max racional.

**Resolucion paso a paso**

**Herramienta clave — Teorema del flujo entero:** Si todas las capacidades son enteras, existe un flujo maximo con flujo entero en cada arista (Ford-Fulkerson con caminos enteros produce flujo entero).

**a) Capacidades pares → flujo maximo par. VERDADERO.**

Por el Teorema del flujo entero, existe un flujo maximo $f^*$ entero. Por el Teorema max-flow min-cut, el valor del flujo maximo $= $ capacidad del corte minimo $= \sum_{e \in \text{corte}} c(e)$. Cada $c(e)$ es par → la suma es par → flujo maximo es par.

Alternativa: si todas las capacidades son pares, dividirlas por 2, resolver, multiplicar por 2. El valor original es $2 \times$ (flujo en la red escalada) → par.

**b) Capacidades pares → existe flujo maximo con flujos pares en cada arista. VERDADERO.**

Por el Teorema del flujo entero, existe un flujo maximo con valores enteros en cada arista. Considerar el flujo maximo $f^*$ entero. Descomponer en caminos (cada camino transporta una unidad entera). Agrupar de a pares de caminos del mismo tipo → flujo equivalente con valores pares. Mas directamente: dividir todas las capacidades por 2, hallar el flujo maximo (entero), multiplicar por 2. El resultado tiene flujos pares y valor maximo.

**c) Capacidades impares → flujo maximo impar. FALSO.**

Contraejemplo: red $s \to v$, $v \to t$, $s \to t$ con capacidades 1, 1, 1. Flujo maximo = 2 (par). Todas las capacidades son impares.

O mas simple: $s \to t$ con 3 aristas paralelas de capacidad 1. Flujo maximo = 3 (impar). Funciona este, pero para el contraejemplo: $s \to a$ (cap 1), $a \to t$ (cap 1), $s \to b$ (cap 1), $b \to t$ (cap 1). Flujo maximo = 2 (par), capacidades todas impares.

**d) Capacidades impares → existe flujo maximo con flujos impares en cada arista. FALSO.**

Mismo contraejemplo: en la red con dos caminos paralelos de capacidad 1, el flujo maximo es 2 con $f(s \to a) = 1$, $f(a \to t) = 1$, $f(s \to b) = 1$, $f(b \to t) = 1$ — flujos impares. Pero si tomamos $s \to a$ (cap 1), $a \to t$ (cap 3), $s \to t$ (cap 1): flujo max = 2, con $f(s \to a) = 1$, $f(a \to t) = 1$, $f(s \to t) = 1$. En cualquier flujo max de valor 2, la arista $a \to t$ tiene flujo 1 (impar) o 0. El flujo maximo puede tener flujos impares...

Contraejemplo clasico: red $s \to a$ (cap 3), $s \to b$ (cap 3), $a \to t$ (cap 3), $b \to t$ (cap 3), $a \to b$ (cap 1). Flujo maximo = 6. Con $f(s \to a) = 3$, $f(s \to b) = 3$, $f(a \to t) = 3$, $f(b \to t) = 3$, $f(a \to b) = 0$ — flujo par en $a \to b$. No puede hacerse impar en $a \to b$ con flujo maximo.

⚠️ Verificar — El contraejemplo de (c)/(d) es mas delicado. La forma mas simple: red con $s \to a$, $s \to b$, $a \to t$, $b \to t$ todas de cap 1 (impares). Flujo max = 2 (par). En cualquier flujo maximo, cada arista tiene flujo 0 o 1. El valor total = 2, pero no todas las aristas con flujo positivo pueden ser "todas impares" — los que tienen flujo 1 son impares, los que tienen 0 son pares. La afirmacion (d) pide que el flujo en CADA arista sea impar, lo que es imposible si alguna arista tiene flujo 0.

**e) Capacidades racionales → flujo maximo racional. VERDADERO.**

Multiplicar todas las capacidades por el MCM de los denominadores → capacidades enteras. El flujo maximo en la red escalada es entero → dividir por el MCM → flujo racional. El valor del flujo maximo es proporcional → racional.

**Chuleta**

> **a)** Par → VERDADERO: corte minimo suma pares.
> **b)** Par → VERDADERO: flujo entero, escalar por ½.
> **c)** Impar → FALSO: 4 aristas cap 1 (dos caminos), flujo max = 2 (par).
> **d)** Impar → FALSO: mismo ejemplo, $f(a \to b) = 0$ (par) en el optimo.
> **e)** Racional → VERDADERO: escalar a enteros, dividir resultado.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 2 — Red con F iteraciones para Ford-Fulkerson

**Enunciado**

Para todo $F \in \mathbb{N}$, construir una red con 4 vertices y 5 aristas en la que el metodo de Ford y Fulkerson necesite $F$ iteraciones en peor caso para obtener el flujo de valor maximo (partiendo de un flujo inicial con valor 0).

**Explicacion**

Construccion clasica del contraejemplo de Ford-Fulkerson con capacidades enteras y eleccion adversarial de caminos de aumento. La red tiene estructura de "diamante" (s, a, b, t) con la arista cruzada $a \to b$ o $b \to a$ de capacidad 1. Cada iteracion aumenta en 1 en lugar de saturar el cuello de botella. Fundamental para entender por que EK usa BFS (garantiza $O(nm^2)$).

**Resolucion paso a paso**

**Construccion de la red:**

Vertices: $s, a, b, t$. Aristas:
- $s \to a$ con cap $F$
- $s \to b$ con cap $F$
- $a \to t$ con cap $F$
- $b \to t$ con cap $F$
- $a \to b$ con cap 1 (la arista cruzada)

Flujo maximo = $2F$ (dos caminos de cap $F$ cada uno).

**Peor caso de Ford-Fulkerson:**

Si Ford-Fulkerson alterna entre los caminos:
1. Iteracion 1: camino $s \to a \to b \to t$ (aumento de 1).
2. Iteracion 2: camino $s \to b \to a \to t$ (aumento de 1, usa arista residual $b \to a$).
3. Iteracion 3: camino $s \to a \to b \to t$ (aumento de 1).
4. ...

Cada iteracion aumenta el flujo en 1. Para llegar a $2F$: se necesitan $2F$ iteraciones.

**Por que EK evita esto:** EK usa BFS → siempre elige el camino mas corto. En esta red, los caminos de longitud 2 ($s \to a \to t$ y $s \to b \to t$) se saturam primero en 2 iteraciones. La arista cruzada no se usa hasta que sea necesaria.

**Chuleta**

> Red: $s \to a$ (F), $s \to b$ (F), $a \to t$ (F), $b \to t$ (F), $a \to b$ (1). Flujo max = $2F$.
> FF adversarial: alterna $s \to a \to b \to t$ y $s \to b \to a \to t$ → $2F$ iteraciones de aumento de 1.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — Complejidad de Edmonds-Karp en variantes

**Enunciado**

Determinar la complejidad del algoritmo de Edmonds y Karp para encontrar el flujo maximo de una red $N$ cuando:

a) no hay informacion acerca de las capacidades de las aristas de $N$.

b) todas las aristas de $N$ tienen capacidad a lo sumo $q \ll n$.

c) el flujo maximo de $N$ tiene un valor $F \ll mn$.

**Explicacion**

EK tiene complejidad general $O(nm^2)$. Este ejercicio requiere analizar casos especiales. En (b) el valor del flujo maximo es $O(qn)$, lo que puede acotar el numero de iteraciones. En (c) el valor $F \ll mn$ limita las iteraciones directamente. Comparar la cota general contra la cota basada en el valor del flujo $O(mF)$.

**Resolucion paso a paso**

**Recordatorio:** Edmonds-Karp (EK) = Ford-Fulkerson con BFS para elegir caminos de aumento. Cotas:
- Numero de iteraciones (caminos de aumento): $O(nm)$.
- Costo por iteracion (BFS): $O(n + m) = O(m)$.
- Total: $O(nm^2)$.
- Alternativa basada en valor: $O(mF)$ donde $F$ = valor del flujo maximo.

**a) Sin informacion sobre capacidades:**

Usar la cota general de EK: $O(nm^2)$.

**b) Capacidades $\leq q \ll n$:**

El valor del flujo maximo $\leq$ capacidad del corte minimo $\leq q \cdot n$ (a lo sumo $n$ aristas en el corte, cada una con cap $\leq q$). Usando la cota $O(mF)$:
$$O(m \cdot qn) = O(qmn)$$

Comparar con $O(nm^2)$: si $q \ll m$ (pocas aristas), $O(qmn) \ll O(nm^2)$. Complejidad: $\min(O(nm^2), O(qmn))$.

**c) Flujo maximo $= F \ll mn$:**

Cada iteracion de Ford-Fulkerson aumenta el flujo en al menos 1 unidad (capacidades enteras). Luego hay a lo sumo $F$ iteraciones. Costo: $O(mF)$.

Como $F \ll mn$: $O(mF) \ll O(nm^2)$ → la cota $O(mF)$ es mejor.

**Chuleta**

> **EK general:** $O(nm^2)$ (o $O(mF)$, lo que sea menor).
> **a)** Sin info: $O(nm^2)$.
> **b)** Cap $\leq q$: flujo max $\leq qn$ → $O(qmn)$.
> **c)** Flujo max $= F$: $O(mF)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — Algoritmo lineal para corte de capacidad minima

**Enunciado**

Proponer un algoritmo lineal que dada una red $N$ y un flujo de valor maximo, encuentre un corte de capacidad minima de $N$.

**Explicacion**

Dado el flujo maximo ya calculado, construir la red residual y hacer BFS/DFS desde la fuente $s$. Los vertices alcanzables desde $s$ en la red residual forman el conjunto $S$ del corte minimo. Las aristas de la red original que van de $S$ a $\bar{S}$ son el corte minimo. Complejidad $O(n+m)$. Activa directamente el Teorema Max-Flow Min-Cut.

**Resolucion paso a paso**

**Fundamento — Teorema Max-Flow Min-Cut:**

Si $f^*$ es un flujo maximo, la red residual $G_{f^*}$ no tiene camino aumentante de $s$ a $t$. El conjunto $S = \{v : v \text{ alcanzable desde } s \text{ en } G_{f^*}\}$ define un corte $(S, \bar{S})$ con:
- $s \in S$, $t \in \bar{S}$ (ya que no hay camino de $s$ a $t$).
- Para toda arista $u \to v$ con $u \in S$, $v \in \bar{S}$: $f^*(u \to v) = c(u \to v)$ (saturada, sino habria arista residual).
- La capacidad del corte $= \sum_{u \in S, v \in \bar{S}} c(u \to v) = $ valor del flujo maximo.

Luego es el corte minimo.

**Algoritmo $O(n+m)$:**

```
1. Construir la red residual G_f* a partir del flujo maximo f* — O(m).
2. BFS/DFS desde s en G_f* → marcar todos los vertices alcanzables → conjunto S — O(n+m).
3. Para cada arista u → v en la red original:
   si u ∈ S y v ∉ S: agregar u→v al corte minimo.
4. Retornar (S, V\S) con las aristas del corte.
```

**Chuleta**

> 1. Construir red residual con el flujo maximo dado.
> 2. BFS/DFS desde $s$ en residual → conjunto $S$ de alcanzables.
> 3. Aristas de corte = aristas originales de $S$ a $\bar{S}$.
> 4. $O(n+m)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 — Modelado: caminos disjuntos en aristas

**Enunciado**

Sea $G$ un digrafo con dos vertices $s$ y $t$.

a) Proponer un modelo de flujo para determinar la maxima cantidad de caminos disjuntos en aristas que van de $s$ a $t$.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Demostrar que el modelo es correcto.

d) Determinar la complejidad de resolver el modelo resultante con el algoritmo de Edmonds y Karp.

**Explicacion**

Modelo canonico de caminos disjuntos en aristas: asignar capacidad 1 a cada arista. El flujo maximo de $s$ a $t$ es exactamente la cantidad maxima de caminos arco-disjuntos (Teorema de Menger). Cada unidad de flujo representa un camino. La demostracion usa la doble implicacion: todo flujo entero de valor $k$ induce $k$ caminos disjuntos (por integridad) y viceversa. Ver [[flujo_en_redes_practica]] para la resolucion completa del ejercicio Popular-A.

**Resolucion paso a paso**

**Parte a) — Modelo de flujo:**

Red $N = G$ con la misma estructura. Capacidad: $c(e) = 1$ para toda arista $e \in E(G)$.

**Parte b) — Interpretacion:**

- Una unidad de flujo por una arista = esa arista es usada por un camino disjunto.
- La restriccion $f(e) \leq 1$ garantiza que cada arista se usa a lo sumo una vez (disjuncion de aristas).
- La conservacion de flujo en cada vertice intermedio garantiza que el flujo forma caminos completos de $s$ a $t$.

**Parte c) — Correctitud:**

$(\Rightarrow)$ Si hay $k$ caminos arco-disjuntos $P_1, \ldots, P_k$: definir $f(e) = |\{i : e \in P_i\}| \leq 1$ (son disjuntos). Este es un flujo valido de valor $k$.

$(\Leftarrow)$ Si hay un flujo maximo $f^*$ de valor $k$: por el Teorema del flujo entero, existe flujo entero de valor $k$. Descomponer el flujo en caminos: como $f^*(e) \in \{0, 1\}$ para todo $e$, la descomposicion produce $k$ caminos donde cada arista aparece en a lo sumo uno (ya que $f^*(e) \leq 1$). Los caminos son arco-disjuntos. $\square$

**Parte d) — Complejidad con EK:**

El flujo maximo $F \leq n - 1$ (a lo sumo $n-1$ caminos disjuntos). Usando la cota $O(mF)$: $O(m(n-1)) = O(mn)$. Con EK general: $O(nm^2)$. La cota ajustada es $O(mn)$.

**Chuleta**

> **Modelo:** capacidad 1 a cada arista. Flujo max = max caminos disjuntos en aristas.
> **Demo:** flujo entero ↔ descomposicion en caminos con $f(e) \leq 1$ → arco-disjuntos.
> **Complejidad:** $O(mn)$ (pues flujo max $\leq n$).

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica]] (Popular-A)

---

### Ejercicio 6 — Popular (caminos disjuntos en aristas y vertices)

**Enunciado**

**6a)** Todos los sabados, Ariana viaja desde su casa a la casa de su gran amiga Cynthia. Como es muy popular, el solo hecho de pasar por una calle atraeria la atencion de sus fans. Para que esos fans tambien puedan conocer a Cynthia, Ariana quiere calcular la cantidad maxima de sabados que podra ir a la casa de Cynthia sin repetir ninguna calle. ¿Que podemos utilizar para resolver este problema?

**6b)** Luego de la constante insistencia de Ariana, Cynthia se hizo popular tambien. Los lideres del club de fans, Toto y Pepi, quieren interceptar a Cynthia cuando vaya a la casa de Ari. Tienen subditos en las intersecciones de las calles y quieren saber cual es la menor cantidad de subditos que necesitan conseguir para asegurarse de interceptar a Cynthia. Aclaracion: Ariana y Cynthia se enojan mucho si las interceptan en sus casas y ademas sabemos que no son vecinas.

**Explicacion**

6a pide max caminos disjuntos en aristas (calles no repetidas): modelo de capacidad 1 por arista, flujo maximo = $O(nm)$ con EK.

6b pide min corte en vertices (subditos en intersecciones, no en casas): tecnica de split de vertice $v_{in} \to v_{out}$ con capacidad 1; las calles tienen capacidad $\infty$. El corte minimo en la nueva red da la cantidad minima de subditos. Complejidad $O(n(n+m))$.

Ver resolucion completa en [[flujo_en_redes_practica]].

**Resolucion paso a paso**

**6a — Max sabados (caminos disjuntos en aristas):**

- Red: misma que el mapa de calles (digrafo o grafo no dirigido modelado con arcos en ambos sentidos).
- Capacidad: $c(\text{calle}) = 1$.
- Flujo maximo de $\text{casa\_Ariana}$ a $\text{casa\_Cynthia}$ = cantidad maxima de sabados.
- Complejidad: $O(mn)$ (flujo max $\leq n$).

**6b — Min subditos (corte minimo en vertices):**

**Tecnica de split de vertice:** para cada interseccion $v$ (excepto las casas de Ariana y Cynthia), crear dos nodos $v_{in}$ y $v_{out}$ con arista $v_{in} \to v_{out}$ de capacidad 1 (colocar un subdito aqui intercepta todos los caminos que pasan por $v$).

- Las calles (aristas) se convierten en aristas $u_{out} \to v_{in}$ con capacidad $\infty$.
- Casas de Ariana ($s$) y Cynthia ($t$) no se splitean (no se pueden interceptar en sus casas).
- Corte minimo en la red construida de $s$ a $t$ = minima cantidad de subditos.

**Correctitud:** un subdito en la interseccion $v$ bloquea el arco $v_{in} \to v_{out}$. El corte minimo corresponde al conjunto minimo de vertices internos cuya remocion desconecta $s$ de $t$ = Teorema de Menger para vertices.

**Complejidad:** $O(n)$ nodos extra → red de $2n$ nodos y $n + m$ aristas. EK: $O(nm(n+m))$ → tipicamente $O(n^2 m)$ o $O(n(n+m))$.

**Chuleta**

> **6a:** cap 1 por calle, flujo max = max sabados. $O(mn)$.
>
> **6b:** Split de vertices: $v \to (v_{in} \to v_{out}, \text{cap }1)$, calles $u_{out} \to v_{in}$ cap $\infty$. Corte min = min subditos. Las casas no se splitean.

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica]] (Popular-A y Popular-B)

---

### Ejercicio 7 — Matching de cardinalidad maxima en grafos bipartitos

**Enunciado**

Nos dan una lista de personas y sus preferencias para hacer ciertas tareas. Cada persona puede hacer una tarea y ademas cada tarea solo puede ser hecha por una sola persona. Calcular la cantidad maxima de tareas que se pueden hacer.

a) Modelar el ejercicio como un problema de flujo maximo.

b) Mostrar que el modelado es correcto.

c) Dar una cota superior de la complejidad.

**Explicacion**

Modelo canonico de matching bipartito: fuente $s \to$ cada persona (cap 1), persona $\to$ tarea si puede hacerla (cap 1), tarea $\to$ sumidero $t$ (cap 1). Flujo maximo = matching maximo. Demo por doble implicacion con integridad del flujo. Complejidad $O(|P| \cdot |T| \cdot \min(|P|, |T|))$ con EK. Ver [[flujo_en_redes_practica]].

**Resolucion paso a paso**

**Parte a) — Modelo de flujo:**

Sea $P = \{p_1, \ldots, p_n\}$ el conjunto de personas y $T = \{t_1, \ldots, t_m\}$ las tareas.

Red $N$:
- Fuente $s$, sumidero $t$.
- Aristas $s \to p_i$ con capacidad 1 para cada persona $p_i$.
- Aristas $p_i \to \tau_j$ con capacidad 1 si la persona $p_i$ puede hacer la tarea $\tau_j$.
- Aristas $\tau_j \to t$ con capacidad 1 para cada tarea $\tau_j$.

Flujo maximo de $s$ a $t$ = cardinalidad del matching maximo.

**Parte b) — Correctitud:**

$(\Rightarrow)$ Dado un matching $M$ de cardinalidad $k$: para cada par $(p_i, \tau_j) \in M$, poner $f(s \to p_i) = f(p_i \to \tau_j) = f(\tau_j \to t) = 1$. Flujo valido de valor $k$.

$(\Leftarrow)$ Dado flujo maximo entero $f^*$ de valor $k$ (existe por Teorema del flujo entero): para cada arista $p_i \to \tau_j$ con $f^*(p_i \to \tau_j) = 1$, incluir $(p_i, \tau_j)$ en el matching. Por las restricciones de capacidad:
- $f^*(s \to p_i) \leq 1$ → cada persona aparece a lo sumo una vez.
- $f^*(\tau_j \to t) \leq 1$ → cada tarea aparece a lo sumo una vez.
El resultado es un matching valido de cardinalidad $k$. $\square$

**Parte c) — Complejidad:**

La red tiene $|P| + |T| + 2$ vertices y $|P| + |T| + |E_{P,T}|$ aristas. El flujo maximo $\leq \min(|P|, |T|)$.

Con EK usando la cota $O(mF)$: $O((|P| + |T| + |E_{P,T}|) \cdot \min(|P|, |T|))$.

**Chuleta**

> Red: $s \to p_i$ (cap 1), $p_i \to \tau_j$ (cap 1 si puede), $\tau_j \to t$ (cap 1).
> Flujo max = matching max.
> Demo: flujo entero ↔ matching (cap 1 por persona y tarea).
> Complejidad: $O((n+m+|E|) \cdot \min(n,m))$.

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica]] (Matching bipartito-Tareas)

---

### Ejercicio 8 — Solteros en mesas (Asignasonia)

**Enunciado**

En el pueblo de Asignasonia, las invitaciones a fiestas son familiares. Se tiene un conjunto de familias $F = \{f_1, \ldots, f_{|F|}\}$ con $f_i$ solteres cada una, un conjunto de mesas $M = \{m_1, \ldots, m_{|M|}\}$ con $m_j$ lugares, y limites $c_{ij}$ a la cantidad de solteres de la familia $i$ que pueden sentarse en la mesa $j$.

a) Proponer un modelo de flujo que determine una asignacion factible respetando todos los limites.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Determinar la complejidad de resolver el modelo resultante con EK.

**Explicacion**

Generalizacion del matching bipartito con limites de flujo por par (familia, mesa). Red: $s \to f_i$ con cap $f_i$, $f_i \to m_j$ con cap $c_{ij}$, $m_j \to t$ con cap $m_j$. Existe asignacion factible $\iff$ flujo maximo $= \sum_j m_j$ (o equivalentemente $= \sum_i f_i$ si el total de solteres cabe). Cada unidad de flujo = un soltero de familia $i$ asignado a mesa $j$.

**Resolucion paso a paso**

**Modelo de flujo:**

- $s \to f_i$ con capacidad $f_i$ (total de solteres de familia $i$).
- $f_i \to m_j$ con capacidad $c_{ij}$ (limite de familia $i$ en mesa $j$).
- $m_j \to t$ con capacidad $m_j$ (total de lugares en mesa $j$).

**Interpretacion:** Una unidad de flujo por la arista $f_i \to m_j$ = un soltero de la familia $i$ se sienta en la mesa $j$.

**Factibilidad:** La asignacion completa existe $\Leftrightarrow$ flujo maximo $= \sum_i f_i = \sum_j m_j$ (suponiendo que el total de solteres = total de lugares; sino verificar que el flujo max satura las aristas de $s$ o las de $t$).

**Complejidad con EK:**

Red con $|F| + |M| + 2$ vertices y $|F| + |M| + |F| \cdot |M|$ aristas. Flujo max $\leq \sum_j m_j$. Cota: $O(m \cdot F)$ donde $m = |F| \cdot |M|$ y $F = \sum_j m_j$.

**Chuleta**

> $s \to f_i$ (cap $f_i$), $f_i \to m_j$ (cap $c_{ij}$), $m_j \to t$ (cap $m_j$).
> Una unidad = un soltero de familia $i$ en mesa $j$.
> Factible $\Leftrightarrow$ flujo max $= \sum_i f_i$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 9 — Matriz con sumas de filas y columnas fijas

**Enunciado**

Sean $r_1, \ldots, r_m$ y $c_1, \ldots, c_n$ numeros naturales. Se quiere asignar los valores de las celdas de una matriz de $m \times n$ con numeros naturales de forma tal que la $i$-esima fila sume $r_i$ y la $j$-esima columna sume $c_j$.

a) Modelar el problema de asignacion como un problema de flujo.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Demostrar que el modelo es correcto.

d) Determinar la complejidad de resolver el modelo resultante con EK.

**Explicacion**

Red bipartita: $s \to$ fila $i$ con cap $r_i$, fila $i \to$ columna $j$ con cap $\infty$ (o cap $\min(r_i, c_j)$ para acotar), columna $j \to t$ con cap $c_j$. La celda $(i,j)$ recibe el flujo que pasa por la arista fila$_i \to$ col$_j$. Existe asignacion $\iff$ flujo maximo $= \sum_i r_i = \sum_j c_j$.

**Resolucion paso a paso**

**Modelo de flujo:**

- $s \to \text{fila}_i$ con cap $r_i$ para cada fila $i$.
- $\text{fila}_i \to \text{col}_j$ con cap $\infty$ para cada par $(i,j)$.
- $\text{col}_j \to t$ con cap $c_j$ para cada columna $j$.

**Interpretacion:** El flujo en $\text{fila}_i \to \text{col}_j$ = valor de la celda $(i,j)$ de la matriz.

**Correctitud:** 
- La restriccion $s \to \text{fila}_i$ con cap $r_i$ garantiza que la suma de la fila $i$ es $\leq r_i$.
- La restriccion $\text{col}_j \to t$ con cap $c_j$ garantiza que la suma de la columna $j$ es $\leq c_j$.
- Si flujo max $= \sum_i r_i = \sum_j c_j$: todas las restricciones se cumplen con igualdad. $\square$

**Condicion de existencia:** $\sum_i r_i = \sum_j c_j$ (condicion necesaria).

**Complejidad con EK:**

$mn + m + n + 2$ vertices, $m + mn + n$ aristas. Flujo max $= \sum_i r_i$. Cota: $O(mn \cdot \sum r_i)$.

**Chuleta**

> $s \to \text{fila}_i$ (cap $r_i$), $\text{fila}_i \to \text{col}_j$ (cap $\infty$), $\text{col}_j \to t$ (cap $c_j$).
> Flujo en $\text{fila}_i \to \text{col}_j$ = celda $(i,j)$.
> Existe matriz $\Leftrightarrow$ flujo max $= \sum r_i = \sum c_j$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 10 — Realizacion de secuencia digrafica

**Enunciado**

Dado un ordenamiento $v_1, \ldots, v_n$ de los vertices de un digrafo $D$, se define la secuencia digrafica de $D$ como $(d^-(v_1), d^+(v_1)), \ldots, (d^-(v_n), d^+(v_n))$. Dada una secuencia de pares $d$, el problema de realizacion de $d$ consiste en encontrar un digrafo $D$ cuya secuencia digrafica sea $d$.

a) Modelar el problema de realizacion como un problema de flujo.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Demostrar que el modelo es correcto.

d) Determinar la complejidad de resolver el modelo resultante con EK (expresar en funcion de $n$, cota ajustada).

**Explicacion**

Red bipartita con nodos duplicados: fuente $s \to v_i^{out}$ con cap $d^+(v_i)$ (grado de salida), $v_i^{in} \to t$ con cap $d^-(v_i)$ (grado de entrada), $v_i^{out} \to v_j^{in}$ con cap 1 para $i \neq j$ (no permite bucles). Existe realizacion $\iff$ flujo max $= \sum_i d^+(v_i) = \sum_i d^-(v_i)$. La cota pedida debe expresarse como $O(n^3)$ o mas ajustada segun la estructura.

**Resolucion paso a paso**

**Modelo de flujo:**

- $s \to v_i^{out}$ con cap $d^+(v_i)$ (grado de salida requerido).
- $v_i^{in} \to t$ con cap $d^-(v_i)$ (grado de entrada requerido).
- $v_i^{out} \to v_j^{in}$ con cap 1 para $i \neq j$ (arco $v_i \to v_j$ en el digrafo; cap 1 porque es simple).

**Interpretacion:** flujo en $v_i^{out} \to v_j^{in} = 1$ significa que existe el arco $v_i \to v_j$ en el digrafo realizado.

**Correctitud:** Si el flujo max $= \sum_i d^+(v_i) = \sum_i d^-(v_i)$: el grafo formado por los arcos con flujo 1 tiene exactamente los grados requeridos. Los arcos $v_i^{out} \to v_j^{in}$ solo tienen cap 1 → no hay arcos multiples. $v_i^{out} \to v_i^{in}$ no existe → no hay bucles. $\square$

**Complejidad con EK:** $2n + 2$ vertices, $n + n + n(n-1) = O(n^2)$ aristas. Flujo max $\leq \sum_i d^+(v_i) \leq n(n-1)$. Cota: $O(n^2 \cdot n^2) = O(n^4)$. Cota mas ajustada con la cantidad de arcos: $O(m \cdot F) = O(n^2 \cdot n^2) = O(n^4)$... EK general: $O(nm^2) = O(n \cdot n^4) = O(n^5)$. Pero con la cota $O(mF)$: flujo max $= M$ (total de arcos) $\leq n^2$, $m = O(n^2)$ → $O(n^4)$. Cota ajustada: $O(n^3)$ si $M \leq n$.

⚠️ Verificar — La complejidad exacta depende del valor total del flujo ($\sum d^+_i$). En general $O(n^2 \cdot \sum d^+_i)$.

**Chuleta**

> $s \to v_i^{out}$ (cap $d^+(v_i)$), $v_j^{in} \to t$ (cap $d^-(v_j)$), $v_i^{out} \to v_j^{in}$ (cap 1, $i \neq j$).
> Flujo 1 en $v_i^{out} \to v_j^{in}$ = arco $v_i \to v_j$ en el digrafo.
> Realizable $\Leftrightarrow$ flujo max $= \sum d^+ = \sum d^-$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 11 — Grafo mixto euleriano

**Enunciado**

Un grafo mixto es una tripla $G = (V, E, A)$ donde $(V, E)$ es un grafo y $(V, A)$ es un grafo orientado. $G$ es euleriano si se pueden orientar las aristas de $E$ de modo que el digrafo resultante tenga un circuito que pase por todas sus aristas exactamente una vez. (Un digrafo es euleriano $\iff$ es conexo y $d^+(v) = d^-(v)$ para todo $v$.)

a) Modelar el problema de decidir si un grafo mixto es euleriano como un problema de flujo.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Demostrar que el modelo es correcto.

d) Determinar la complejidad de resolver el modelo resultante con EK.

**Explicacion**

Cada arista no orientada $\{u,v\} \in E$ debe ser orientada. Definir $\delta(v) = d^+_A(v) - d^-_A(v)$ (desbalance inicial de las aristas orientadas). Para que el digrafo final sea euleriano, cada $\{u,v\}$ orientada como $u \to v$ contribuye $+1$ a $d^+(u)$ y $+1$ a $d^-(v)$. El modelo de flujo captura como distribuir las orientaciones para balancear todos los nodos. Nodos con $\delta(v) > 0$ reciben flujo de $s$; nodos con $\delta(v) < 0$ envian a $t$.

**Resolucion paso a paso**

**Formulacion:** queremos orientar cada arista $\{u,v\} \in E$ para que el digrafo resultante satisfaga $d^+(v) = d^-(v)$ para todo $v$.

Desbalance actual (solo con arcos $A$): $\delta(v) = d^+_A(v) - d^-_A(v)$.

Orientar $\{u,v\}$ como $u \to v$ cambia $\delta(u)$ en $+1$ y $\delta(v)$ en $-1$.

El objetivo es orientar todas las aristas de $E$ para que $\delta(v) = 0$ para todo $v$.

**Modelo de flujo:**

- Para cada arista no orientada $\{u,v\} \in E$: crear arco $u \to v$ con cap 1 y arco $v \to u$ con cap 1 (cualquiera de las dos orientaciones).
- Agregar $s$ y $t$: vertices con $\delta(v) > 0$ tienen exceso → $s \to v$ con cap $\delta(v)$; vertices con $\delta(v) < 0$ tienen defecto → $v \to t$ con cap $|\delta(v)|$.
- El grafo es eulerianizable $\Leftrightarrow$ flujo maximo $= \sum_{v: \delta(v) > 0} \delta(v)$ (todas las aristas de $s$ se saturan).

**Interpretacion:** flujo en $u \to v$ de la arista $\{u,v\}$ = orientar esa arista como $u \to v$.

**Complejidad con EK:** $O(nm^2)$ donde $n = |V|$ y $m = |E| + |A|$.

**Chuleta**

> 1. Calcular $\delta(v) = d^+_A(v) - d^-_A(v)$ para cada vertice.
> 2. Aristas de $E$: arcos $u \to v$ y $v \to u$ con cap 1.
> 3. $\delta(v) > 0$: $s \to v$ cap $\delta(v)$. $\delta(v) < 0$: $v \to t$ cap $|\delta(v)|$.
> 4. Eulerianizable $\Leftrightarrow$ flujo max satura todas las aristas de $s$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 12 — Hospital con K periodos de feriados

**Enunciado**

En un hospital hay $K$ periodos de feriados. Cada periodo $k$ consiste de $D_k = \{d_{k1}, \ldots, d_{kr}\}$ dias feriado contiguos. El hospital tiene $N$ medicxs y cada unx tiene un conjunto $S_i$ de dias disponibles para trabajar. Se busca una asignacion de medicxs tal que:

- Nadie trabaja mas de $C$ dias totales en vacaciones (y solo en sus dias disponibles).
- Cada dia de vacaciones tiene asignada una unica persona.
- Unx medicx solo puede tener asignado como maximo un dia dentro de cada periodo $D_k$.

a) Modelar como problema de flujo para decidir si existe asignacion factible.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Demostrar la correctitud del modelo.

d) Determinar la complejidad de resolver el modelo resultante con EK.

**Explicacion**

Modelo con capa intermedia periodo-por-medico. Red: $s \to$ medico$_i$ con cap $C$, medico$_i \to$ (medico$_i$, periodo$_k$) con cap 1 para cada periodo $k$ al que pertenece algun dia disponible de $i$, (medico$_i$, periodo$_k$) $\to$ dia$_d$ con cap 1 si $d \in S_i \cap D_k$, dia$_d \to t$ con cap 1. Flujo $= \sum_k |D_k|$ garantiza asignacion completa. Ver [[flujo_en_redes_practica_pt2]] para resolucion completa de Hospital.

**Resolucion paso a paso**

**Capas de la red:**

1. $s \to \text{med}_i$ con cap $C$ — cada medico trabaja a lo sumo $C$ dias totales.
2. $\text{med}_i \to (\text{med}_i, \text{per}_k)$ con cap 1 — cada medico trabaja a lo sumo 1 dia en el periodo $k$ (solo si tiene algun dia disponible en ese periodo).
3. $(\text{med}_i, \text{per}_k) \to \text{dia}_d$ con cap 1 si $d \in S_i \cap D_k$ — el medico $i$ trabaja el dia $d$ del periodo $k$.
4. $\text{dia}_d \to t$ con cap 1 — cada dia debe tener exactamente una persona asignada.

**Interpretacion:** una unidad de flujo por la ruta $s \to \text{med}_i \to (\text{med}_i, \text{per}_k) \to \text{dia}_d \to t$ = el medico $i$ trabaja el dia $d$ del periodo $k$.

**Correctitud:** La asignacion completa existe $\Leftrightarrow$ flujo max $= \sum_k |D_k|$ (todos los dias cubiertos).

**Complejidad con EK:** $O(nm^2)$ donde $n$ y $m$ son el numero de nodos y aristas de la red construida (proporcionales a $N \cdot K + \sum_k |D_k|$).

**Chuleta**

> Capas: $s \to \text{med}$ (cap $C$) $\to$ (med,per) (cap 1) $\to$ dia (cap 1) $\to t$ (cap 1).
> La capa media garantiza "a lo sumo 1 dia por periodo por medico".
> Factible $\Leftrightarrow$ flujo max $= \sum_k |D_k|$.

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica_pt2]] (Hospital)

---

### Ejercicio 13 — Enchufes (adaptadores para dispositivos)

**Enunciado**

En la sala de una cumbre internacional hay tomacorrientes de tipos limitados y los periodistas traen dispositivos con distintos tipos de enchufes. Un fabricante vende adaptadores con una forma de entrada y una de salida (encadenables ilimitadamente). Se quiere minimizar la cantidad de dispositivos sin corriente.

Datos: $d_i$ = cantidad de dispositivos que usan tomacorriente de tipo $i$, $t_i$ = cantidad de tomacorrientes de tipo $i$ en la sala, pares $(i,j)$ de adaptadores disponibles.

a) Proponer un modelo de flujo para minimizar la cantidad de dispositivos sin corriente.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Determinar la complejidad del modelo resultante con EK.

**Explicacion**

Modelo con nodos intermedios por tipo de tomacorriente. Se crea un grafo de tipos: $s \to$ tipo$_i$ (tomacorriente) con cap $t_i$, adaptador $(i,j)$ como arista tipo$_i \to$ tipo$_j$ con cap $\infty$, tipo$_j \to$ dispositivo$_j$ con cap $d_j$, dispositivo$_j \to t$ con cap $d_j$. Minimizar dispositivos sin corriente = maximizar flujo. Los adaptadores se pueden encadenar → agregar aristas transitivas o modelar con nodos tipo y aristas del grafo de adaptadores. Ver [[flujo_en_redes_practica]] (Enchufados) para resolucion completa $O(k^5)$.

**Resolucion paso a paso**

Sea $K$ el numero de tipos de enchufes.

**Modelo de flujo:**

1. $s \to \text{tipo}_i$ con cap $t_i$ — tomacorrientes disponibles del tipo $i$.
2. $\text{tipo}_i \to \text{tipo}_j$ con cap $\infty$ si existe adaptador $(i, j)$ — transferir capacidad entre tipos. Los adaptadores son encadenables: la transitividad en el grafo de tipos captura el encadenamiento.
3. $\text{tipo}_j \to t$ con cap $d_j$ — dispositivos que pueden conectarse al tipo $j$.

**Interpretacion:** una unidad de flujo = un dispositivo conectado a la corriente (via su tipo o via adaptadores).

**Encadenamiento:** como los adaptadores son transitivos, si hay aristas $\text{tipo}_i \to \text{tipo}_j \to \text{tipo}_k$ con cap $\infty$, el flujo puede llegar de $i$ a $k$ en dos pasos. No hace falta agregar aristas transitivas explicitamente — el flujo las usa automaticamente.

**Resultado:** Flujo maximo = maxima cantidad de dispositivos con corriente. Dispositivos sin corriente = $\sum_j d_j - \text{flujo max}$.

**Complejidad:** Red con $K + 2$ vertices y $K + K^2 + K$ aristas = $O(K^2)$ aristas. Flujo max $\leq \sum_j d_j$. EK general: $O(K \cdot K^4) = O(K^5)$.

**Chuleta**

> $s \to \text{tipo}_i$ (cap $t_i$), adaptador $i \to j$: arista $\text{tipo}_i \to \text{tipo}_j$ (cap $\infty$), $\text{tipo}_j \to t$ (cap $d_j$).
> Flujo max = dispositivos con corriente. Sin corriente = $\sum d_j - \text{max}$.
> Encadenamiento: automatico en el grafo de tipos. $O(K^5)$.

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica]] (Enchufados)

---

### Ejercicio 14 — Figuritas de Carle (version 1)

**Enunciado**

Carle coleccionaba figuritas de "Italia 90" y junto a sus compañeres intercambiaban usando el protocolo "late-nola": cada dos personas intercambian una figurita repetida por una que no poseen. Carle puede obtener copias adicionales de figuritas que ya tiene para intercambiar transitivamente. Se conocen todas las figuritas repetidas (y la cantidad) de cada compañere.

a) Proponer un modelo de flujo maximo para maximizar la cantidad de figuritas no repetidas que Carle puede obtener, considerando que todes intercambian primero con Carle.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Determinar la complejidad del modelo resultante con EK.

**Explicacion**

Modelo de transporte con nodos por figurita. Carle puede "transferir" figuritas repetidas entre compañeres via si misma. La red captura el flujo de figuritas: fuente $s$ (figuritas repetidas de compañeres), nodos por figurita y compañere, sumidero $t$ (figuritas nuevas para Carle). Las capacidades reflejan las repeticiones disponibles de cada compañere y el protocolo late-nola (1 para 1).

**Resolucion paso a paso**

Sea $C$ el conjunto de compañeres, $F$ el conjunto de figuritas. Para cada compañere $c$ y figurita $f$: $\text{rep}(c,f)$ = cantidad de repetidas de $f$ que tiene $c$, $\text{falta}(c,f) = 1$ si $c$ no tiene la figurita $f$.

**Modelo de flujo:**

- $s \to c$ con cap $\sum_f \text{rep}(c,f)$ — total de figuritas repetidas que $c$ puede intercambiar.
- $c \to f$ con cap $\text{rep}(c,f)$ si $c$ tiene repetidas de $f$ — cantidad de figuritas $f$ que $c$ puede dar.
- $f \to \text{Carle}$ con cap 1 si Carle no tiene la figurita $f$ — Carle solo necesita una de cada.
- $\text{Carle} \to t$ con cap $|\{f : \text{Carle no tiene } f\}|$ — total de figuritas nuevas que Carle puede obtener.

Flujo maximo = figuritas nuevas para Carle.

⚠️ Verificar — El modelado exacto depende de los detalles del protocolo (si la transitividad es bilateral o unilateral). La idea principal es la red bipartita compañere-figurita con las capacidades de repetidas.

**Chuleta**

> $s \to c$ (cap = repetidas totales de $c$), $c \to f$ (cap $= \text{rep}(c,f)$), $f \to t$ (cap 1 si Carle no tiene $f$).
> Flujo max = figuritas nuevas que Carle obtiene.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 15 — Figuritas de Carle (version 2)

**Nota:** El enunciado del ejercicio 15 en la guia original es identico al ejercicio 14. Se trata de una duplicacion en el PDF fuente. Mismo modelo y resolucion.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 16 — Satelite: datos con ventanas de tiempo

**Enunciado**

Un satelite dispone de $N$ ventanas de tiempo para mandar datos a la Tierra. Tiene $R$ sensores, cada uno con una cola de capacidad $c_q$ megabytes. El sensor $r$ carga $a_{rt}$ datos a su cola en la ventana $t$. En cada ventana se pueden mandar hasta $d_t$ megabytes en total. Los datos no mandados se conservan para la siguiente ventana.

a) Escribir un programa para maximizar la cantidad de megabytes transferidos desde el satelite a la Tierra.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Determinar la complejidad del modelo resultante con EK.

**Explicacion**

Modelo con nodos (cola, ventana). En cada ventana $t$ y cola $q$: la cola recibe $a_{rt}$ datos de su sensor y puede almacenar hasta $c_q$ total. Se puede enviar desde cualquier cola en cualquier ventana, respetando el limite $d_t$ global. Las colas acumulan datos entre ventanas. Ver [[flujo_en_redes_practica_pt2]] donde el ejercicio Satelite aparece como enunciado pendiente.

**Resolucion paso a paso**

**Nodos de la red:**

- $(q, t)$: estado de la cola $q$ al final de la ventana $t$. $R \times N$ nodos.
- Fuente $s$ y sumidero $t_{sink}$.

**Aristas:**

1. **Acumulacion:** $s \to (q, 1)$ con cap $a_{q1}$ (datos iniciales del sensor en ventana 1).
2. **Datos nuevos:** Para $t \geq 2$: arista $s \to (q, t)$ con cap $a_{qt}$ (nuevos datos en ventana $t$).
3. **Persistencia:** $(q, t) \to (q, t+1)$ con cap $c_q$ (datos que se guardan para la siguiente ventana, limitado por la capacidad de la cola).
4. **Envio:** $(q, t) \to \text{envio}_t$ con cap $c_q$ (se puede enviar hasta $c_q$ desde la cola $q$ en la ventana $t$).
5. **Limite de transmision:** $\text{envio}_t \to t_{sink}$ con cap $d_t$ (limite total de envio en la ventana $t$).

**Interpretacion:** Una unidad de flujo = 1 megabyte transferido a la Tierra.

**Complejidad con EK:** $O(RN)$ nodos, $O(RN)$ aristas. Flujo max $\leq \sum_t d_t$. Cota: $O(RN \cdot (\sum d_t))$.

⚠️ Verificar — El modelado exacto de la persistencia de cola y los datos nuevos puede variar. La idea central es que el flujo captura el flujo de datos por cola por ventana.

**Chuleta**

> Nodos $(q, t)$ = cola $q$ en ventana $t$.
> - Datos nuevos: $s \to (q,t)$ cap $a_{qt}$.
> - Persistencia: $(q,t) \to (q,t+1)$ cap $c_q$.
> - Envio: $(q,t) \to \text{envio}_t \to t_{sink}$, limite $d_t$.
> Flujo max = total MB enviados.

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica_pt2]] (Satelite)

---

### Ejercicio 17 — Titanic: personas en maderas via icebergs

**Enunciado**

Despues del hundimiento del Titanic, personas estan sobre icebergs pequenos. Hay icebergs grandes (cap $\infty$, no se hunden pero no pueden quedarse) y pedazos de madera (solo una persona, indefinidamente). Cada iceberg pequeno se hunde cuando alguien se mueve. Se describe el mapa como una matriz: madera, iceberg pequeno, iceberg grande o mar libre. Todas las personas empiezan sobre un iceberg pequeno.

a) Modelar como problema de flujo para maximizar la gente que queda sobre madera para ser rescatada.

b) Dar una interpretacion a cada unidad de flujo y cada restriccion de capacidad.

c) Determinar la complejidad del modelo resultante con EK.

**Explicacion**

Split de nodo: iceberg pequeno $v_{in} \to v_{out}$ con cap 1 (se hunde tras 1 uso), iceberg grande cap $\infty$, madera $\to t$ con cap 1. La fuente es un nodo ficticio $s$ conectado a todos los icebergs pequenos iniciales. Las aristas entre posiciones adyacentes capturan los movimientos. Ver [[flujo_en_redes_practica_pt2]] para resolucion completa de Down Went the Titanic con complejidad $O(C^2)$.

**Resolucion paso a paso**

**Tecnica de split de nodo** para modelar que cada iceberg pequeno "se hunde" (solo puede ser pisado una vez):

**Nodos:**
- Cada iceberg pequeno $v$: split en $v_{in}$ y $v_{out}$ con arista $v_{in} \to v_{out}$ de cap 1.
- Cada iceberg grande $w$: split en $w_{in}$ y $w_{out}$ con arista $w_{in} \to w_{out}$ de cap $\infty$.
- Cada madera $m$: nodo simple $m_{in}$ (una persona puede quedarse).
- Fuente $s$, sumidero $t_{sink}$.

**Aristas:**
- $s \to v_{in}$ con cap 1 para cada iceberg pequeno inicial (una persona por iceberg).
- Movimiento entre posiciones adyacentes: $u_{out} \to v_{in}$ con cap $\infty$ (moverse no tiene limite).
- $m_{in} \to t_{sink}$ con cap 1 (cada madera puede rescatar a 1 persona).

**Interpretacion:** Una unidad de flujo = una persona que llega a un pedazo de madera.

**Correctitud:** La cap 1 del split de icebergs pequenos garantiza que cada uno se hunde al ser usado. Los icebergs grandes no tienen limite. Las maderas tienen cap 1 de salida.

**Complejidad:** $O(C^2)$ donde $C$ es el numero de celdas de la matriz (segun la practica).

**Chuleta**

> Split de icebergs pequenos: $v_{in} \to v_{out}$ cap 1 (se hunde).
> Icebergs grandes: $w_{in} \to w_{out}$ cap $\infty$.
> $s \to v_{in}$ cap 1 por persona inicial. Movimientos: $u_{out} \to v_{in}$ cap $\infty$.
> $m_{in} \to t$ cap 1 por madera. Flujo max = personas rescatadas.

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica_pt2]] (Down Went the Titanic)

---

### Ejercicio 18 — Maquinas y proyectos (beneficio neto via min-cut)

**Enunciado**

Hay $M$ maquinas y $P$ proyectos. Comprar la maquina $i$ cuesta $c_i$ y completar el proyecto $j$ da beneficio $b_j$. Se tienen $R$ relaciones $(i,j)$ indicando que el proyecto $j$ requiere la maquina $i$. Maximizar el beneficio neto $\sum_{j \in P'} b_j - \sum_{i \in M'} c_i$.

a) Proponer un digrafo ponderado $G = (V, E)$ con $|V|+|E| \in O(M+P+R)$ tal que exista $C$ con beneficio neto maximo $= C - \text{MinCut}(G)$. Recuperar $M'$ y $P'$ del corte minimo.

b) Indicar como calcular $C$.

c) Indicar como recuperar $M'$ y $P'$ del corte minimo.

d) Determinar la complejidad con EK.

**Explicacion**

Patron clasico de proyecto-maquina via min-cut. Red: $s \to$ proyecto$_j$ con cap $b_j$, proyecto$_j \to$ maquina$_i$ con cap $\infty$ para cada relacion $(i,j)$, maquina$_i \to t$ con cap $c_i$. $C = \sum_j b_j$. Beneficio neto maximo $= C - \text{MinCut}$. Los proyectos del lado de $s$ en el corte son $P'$, las maquinas del lado de $t$ son $M'$. Patron frecuente en parciales de flujo.

**Resolucion paso a paso**

**Red de flujo:**

- $s \to \text{proy}_j$ con cap $b_j$ para cada proyecto $j$.
- $\text{proy}_j \to \text{maq}_i$ con cap $\infty$ para cada relacion $(i,j)$ (proyecto $j$ requiere maquina $i$).
- $\text{maq}_i \to t$ con cap $c_i$ para cada maquina $i$.

**Parte b) — Calculo de $C$:**

$$C = \sum_{j \in P} b_j$$

(suma de todos los beneficios posibles).

**Parte c) — Interpretacion del corte:**

Sea $(S, \bar{S})$ el corte minimo ($s \in S$, $t \in \bar{S}$). El corte incluye aristas:
- $s \to \text{proy}_j$ si $\text{proy}_j \in \bar{S}$ → estos proyectos NO se realizan ($\notin P'$).
- $\text{maq}_i \to t$ si $\text{maq}_i \in S$ → estas maquinas SÍ se compran ($\in M'$).
- Aristas $\text{proy}_j \to \text{maq}_i$ con cap $\infty$ no pueden estar en el corte minimo (infinito coste).

La condicion de que el corte sea finito garantiza: si $\text{proy}_j \in S$ (proyecto realizado), todas sus maquinas requeridas deben estar en $S$ (compradas). Esto se asegura porque si $\text{proy}_j \in S$ y $\text{maq}_i \in \bar{S}$, la arista $\text{proy}_j \to \text{maq}_i$ de cap $\infty$ estaria en el corte → costo infinito.

Entonces:
- $P' = \{\text{proy}_j : \text{proy}_j \in S\}$ (proyectos realizados = lado de $s$).
- $M' = \{\text{maq}_i : \text{maq}_i \in S\}$ (maquinas compradas = lado de $s$).

**Relacion beneficio neto — min-cut:**

$$\text{Capacidad del corte} = \sum_{j \notin P'} b_j + \sum_{i \in M'} c_i = C - \sum_{j \in P'} b_j + \sum_{i \in M'} c_i = C - \text{beneficio neto}$$

Luego: $\text{beneficio neto maximo} = C - \text{MinCut}$.

**Parte d) — Complejidad con EK:**

Red con $M + P + 2$ vertices y $P + R + M$ aristas. EK: $O((M+P+R)^3)$ en general o $O(mF)$.

**Chuleta**

> **Patron maquinas-proyectos:**
> $s \to \text{proy}_j$ (cap $b_j$), $\text{proy}_j \to \text{maq}_i$ (cap $\infty$), $\text{maq}_i \to t$ (cap $c_i$).
> $C = \sum b_j$. Beneficio neto max $= C - \text{MinCut}$.
> Lado de $s$ = proyectos hechos + maquinas compradas.
> Corte invalida proyectos que necesitan maquinas no compradas (aristas $\infty$ en corte → imposible).

**¿Aparece en parciales?** 🔴 Si → patron maquinas-proyectos, aparece en examenes de flujo

---

### Ejercicio 19 — Nodos valiosos: subconjunto sin aristas salientes

**Enunciado**

Se tiene un digrafo $G = (V, E)$ donde cada nodo $v$ tiene valor $w(v) \in \mathbb{R}$. Elegir $V' \subseteq V$ que maximice $\sum_{v \in V'} w(v)$ tal que no exista arista $u \to v \in E$ con $u \in V'$ y $v \notin V'$ (el subconjunto es cerrado hacia adelante).

a) Proponer un digrafo ponderado $G' = (V', E')$ con $|V'|+|E'| \in O(|V|+|E|)$ tal que exista $C$ con valor maximo $= C - \text{MinCut}(G')$. Recuperar $V'$ del corte.

b) Indicar como calcular $C$.

c) Indicar como recuperar $V'$ del corte minimo.

d) Determinar la complejidad con EK.

**Explicacion**

Variante del patron de seleccion de subconjunto via min-cut. Nodos con $w(v) > 0$: $s \to v$ con cap $w(v)$. Nodos con $w(v) < 0$: $v \to t$ con cap $|w(v)|$. Aristas del digrafo original: $u \to v$ con cap $\infty$. $C = \sum_{w(v)>0} w(v)$. El corte separa los nodos en $S$ (elegidos) y $\bar{S}$ (no elegidos).

**Resolucion paso a paso**

**Red de flujo:**

- Para $w(v) > 0$: arista $s \to v$ con cap $w(v)$ (perdemos este beneficio si $v \notin V'$).
- Para $w(v) < 0$: arista $v \to t$ con cap $|w(v)|$ (pagamos este costo si $v \in V'$).
- Para $w(v) = 0$: sin arista a $s$ o $t$.
- Para cada arista $u \to v \in E(G)$: arista $u \to v$ con cap $\infty$ (si $u \in V'$ entonces $v \in V'$).

**Parte b) — $C$:** $C = \sum_{w(v) > 0} w(v)$.

**Parte c) — Recuperacion de $V'$:** $V' = S \setminus \{s\}$ donde $S$ es el lado de $s$ en el corte minimo.

**Relacion valor — min-cut:**

$$\text{MinCut} = \sum_{v \in \bar{S}, w(v)>0} w(v) + \sum_{v \in S, w(v)<0} |w(v)|$$

(aristas $s \to v$ cortadas + aristas $v \to t$ cortadas). Luego:

$$\text{valor de } V' = \sum_{v \in S} w(v) = \sum_{v \in S, w>0} w(v) - \sum_{v \in S, w<0} |w(v)| = C - \text{MinCut}$$

La condicion de aristas $\infty$ garantiza que $V'$ es cerrado hacia adelante.

**Complejidad:** $O(nm^2)$ con EK donde $n = |V|$, $m = |E| + |V|$.

**Chuleta**

> $w(v) > 0$: $s \to v$ cap $w(v)$. $w(v) < 0$: $v \to t$ cap $|w(v)|$.
> Aristas originales: cap $\infty$.
> $C = \sum_{w>0} w(v)$. Max valor $= C - \text{MinCut}$.
> $V' = $ lado de $s$ (sin $s$).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 20 — Subgrafo de peso maximo con nodos y aristas ponderados

**Enunciado**

Se tiene un grafo $G = (V, E)$ con nodos y aristas ponderados. Elegir subgrafo $G' = (V', E')$ que maximice $\sum_{v \in V'} w(v) + \sum_{e \in E'} w(e)$ tal que $(u,v) \in E' \Rightarrow u, v \in V'$.

a) Proponer digrafo ponderado $G'' = (V'', E'')$ con $|V''|+|E''| \in O(|V|+|E|)$ tal que valor maximo $= C - \text{MinCut}(G'')$. Recuperar $V'$ y $E'$ del corte.

b) Indicar como calcular $C$.

c) Indicar como recuperar $V'$ y $E'$ del corte minimo.

d) Determinar la complejidad con EK.

**Explicacion**

Extension del patron de min-cut a aristas ponderadas. Cada arista se convierte en un nodo intermedio: arista$(u,v)$ con valor $w(u,v)$ → nodo $a_{uv}$. Conexiones: $u \to a_{uv}$ con cap $\infty$, $v \to a_{uv}$ con cap $\infty$ (ambos extremos deben estar en $V'$ para incluir la arista), $a_{uv} \to t$ con cap $|w(u,v)|$ si $w(u,v) < 0$, $s \to a_{uv}$ con cap $w(u,v)$ si $w(u,v) > 0$.

**Resolucion paso a paso**

**Nodos de la red:** Nodos de $V$, nodos intermedios $a_e$ por cada arista $e = (u,v) \in E$, fuente $s$, sumidero $t$.

**Aristas de la red:**

Para cada nodo $v \in V$:
- $w(v) > 0$: $s \to v$ cap $w(v)$.
- $w(v) < 0$: $v \to t$ cap $|w(v)|$.

Para cada arista $e = (u,v) \in E$ (convertida en nodo $a_e$):
- $w(e) > 0$: $s \to a_e$ cap $w(e)$, $a_e \to u$ cap $\infty$, $a_e \to v$ cap $\infty$.
- $w(e) < 0$: $u \to a_e$ cap $\infty$, $v \to a_e$ cap $\infty$, $a_e \to t$ cap $|w(e)|$.

La logica: si $a_e \in S$ (arista incluida), sus extremos $u, v$ deben estar en $S$ (aristas $\infty$). Si $a_e \in \bar{S}$ cuando $w(e) > 0$: se pierde el beneficio.

**Parte b) — $C$:** $C = \sum_{w(v)>0} w(v) + \sum_{w(e)>0} w(e)$.

**Parte c) — Recuperacion:**
- $V' = \{v \in V : v \in S\}$.
- $E' = \{e \in E : a_e \in S\}$ (y ambos extremos en $V'$, garantizado por las aristas $\infty$).

**Complejidad:** $O((|V|+|E|) + (|V|+|E|)^2 \cdot F)$ con EK.

**Chuleta**

> Aristas con $w > 0$: $s \to a_e$, $a_e \to u$, $a_e \to v$ (cap $\infty$). Nodos con $w > 0$: $s \to v$.
> Aristas con $w < 0$: $u \to a_e$, $v \to a_e$, $a_e \to t$. Nodos con $w < 0$: $v \to t$.
> $C = \sum_{w>0} w$. Max $= C - \text{MinCut}$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 21 — Edificios y normativas (alturas con multas)

**Enunciado**

Hay $N$ lotes y un valor $H$. En el lote $i$ se puede construir un edificio de entre 0 y $H_i \leq H$ pisos. Construir un edificio de altura $h$ genera un beneficio de $h^2$ pesos. Ademas, hay $M$ normativas $(l_j, r_j, H_j, c_j)$: si algun edificio en los lotes $l_j, \ldots, r_j$ supera la altura $H_j$, se paga multa $c_j$ pesos. Maximizar el beneficio neto.

a) Proponer un digrafo ponderado con $|V|+|E| \in O((H+M) \cdot N)$ tal que beneficio neto maximo $= C - \text{MinCut}(G)$. Recuperar alturas del corte.

b) Indicar como calcular $C$.

c) Indicar como recuperar las alturas del corte minimo.

d) Determinar la complejidad con EK.

**Explicacion**

Modelo avanzado: cada lote $i$ tiene $H_i+1$ alturas posibles → nodo por (lote, altura). El corte determina la altura elegida. Las normativas generan aristas adicionales que conectan altura-en-lote con penalizacion. El beneficio cuadratico $h^2$ se incorpora como diferencias marginales $h^2 - (h-1)^2 = 2h-1$ entre niveles consecutivos.

**Resolucion paso a paso**

**Estructura clave — incrementos marginales:**

Para cada lote $i$ y altura $h \in \{1, \ldots, H_i\}$: el beneficio marginal de pasar de $h-1$ a $h$ pisos es $h^2 - (h-1)^2 = 2h-1$.

**Nodos:** $(i, h)$ para cada lote $i$ y altura $h \in \{0, \ldots, H_i\}$. Plus nodo normativa $n_j$ por cada normativa.

**Aristas:**

- Beneficio marginal: $s \to (i, h)$ con cap $2h-1$ para $h = 1, \ldots, H_i$ (perdemos este beneficio si la altura de $i$ es $< h$).
- Cadena de altura: $(i, h) \to (i, h-1)$ con cap $\infty$ para $h \geq 1$ (si incluimos el nivel $h$, debemos incluir el $h-1$).
- $(i, 0) \to t$ con cap $\infty$ (nivel 0 siempre incluido).
- Normativa $(l_j, r_j, H_j, c_j)$: si algun $(i, H_j+1) \in S$ para $i \in [l_j, r_j]$: pagar multa $c_j$.
  - Aristas $(i, H_j+1) \to n_j$ con cap $\infty$ para $i \in [l_j, r_j]$.
  - $n_j \to t$ con cap $c_j$.

**Parte b) — $C$:** $C = \sum_i H_i^2$ (maximo beneficio sin multas).

**Parte c) — Alturas del corte:** La altura del lote $i$ = $\max\{h : (i,h) \in S\}$.

⚠️ Verificar — El modelado exacto de las normativas (especialmente el "algun edificio supera la altura") requiere verificacion cuidadosa. La idea de usar nodos normativa con aristas $\infty$ desde los niveles es correcta en principio.

**Complejidad:** Red con $O(NH + M)$ nodos y $O(NH + MN)$ aristas. EK: $O(nm^2)$ con estos valores.

**Chuleta**

> Incremento marginal $h^2 - (h-1)^2 = 2h-1$: $s \to (i,h)$ cap $2h-1$.
> Cadena: $(i,h) \to (i,h-1)$ cap $\infty$. $(i,0) \to t$.
> Normativa: $(i, H_j+1) \to n_j$ cap $\infty$, $n_j \to t$ cap $c_j$.
> Altura lote $i$ = max nivel en $S$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 22 — Ford-Fulkerson con camino de aumento de costo minimo

**Enunciado**

Una red con costos tiene capacidad $c(e)$ y costo $q(e) \geq 0$ por arista. El problema de flujo maximo con costo minimo consiste en encontrar el flujo maximo $f$ que minimice $\sum_{e \in E} f(e) \cdot q(e)$.

Demostrar que el algoritmo de Ford-Fulkerson, eligiendo siempre el camino de aumento de costo minimo, resuelve el problema. Determinar que algoritmo usar para elegir el camino de aumento y calcular la complejidad resultante (el algoritmo requiere a lo sumo $O(nU)$ iteraciones, donde $U = \max_{e \in E} c(e)$).

**Explicacion**

Se usa Bellman-Ford o Dijkstra (con reescalado de pesos) para encontrar el camino de costo minimo en la red residual. El algoritmo de camino de costo minimo (MCMF) requiere $O(nU)$ iteraciones × $O(nm)$ por BF = $O(n^2 m U)$. La demo usa el principio de que si siempre se aumenta por el camino mas barato, no se puede mejorar el costo para el mismo valor de flujo.

**Resolucion paso a paso**

**Demostracion de correctitud (sketch):**

Invariante: el flujo actual $f_k$ es el flujo de costo minimo entre todos los flujos de valor $|f_k|$.

- Base: flujo 0 es trivialmente optimo para valor 0.
- Paso: si $f_k$ es optimo para valor $|f_k|$, y aumentamos por el camino de costo minimo $P$ en la red residual: obtenemos $f_{k+1}$ de valor $|f_k| + \delta$ (cuello de botella del camino). Para cualquier otro flujo de valor $|f_{k+1}|$, la diferencia con $f_k$ contiene un camino de costo $\geq$ costo de $P$ (por ser $P$ el minimo). Luego $f_{k+1}$ es optimo para valor $|f_{k+1}|$. $\square$

**Algoritmo para elegir el camino:**

- Si la red residual puede tener aristas de costo negativo (aristas residuales inversas tienen costo $-q(e)$): usar Bellman-Ford para el camino de costo minimo en la residual. $O(nm)$ por iteracion.
- Con Dijkstra + reescalado de Johnson (potenciales): $O(m \log n)$ por iteracion.

**Complejidad:**

- Iteraciones: $O(nU)$ donde $U = \max c(e)$ (cada iteracion puede aumentar el cuello de botella por 1).
- Por iteracion (Bellman-Ford): $O(nm)$.
- Total: $O(n^2 m U)$.

Con Dijkstra reescalado: $O(nU \cdot m \log n)$.

**Chuleta**

> FF con camino de costo minimo (MCMF):
> 1. Red residual con costos (aristas inversas tienen costo negativo).
> 2. Camino de costo minimo: Bellman-Ford $O(nm)$ o Dijkstra+reescalado $O(m \log n)$.
> 3. $O(nU)$ iteraciones. Total: $O(n^2 mU)$ o $O(nUm \log n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 23 — Matching bipartito de peso minimo

**Enunciado**

Sea $G = (A \cup B, E)$ un grafo bipartito con pesos $w: E \to \mathbb{N}$. El problema de matching bipartito de peso minimo consiste en hallar el matching $M \subseteq E$ de maximo cardinal posible en $G$ que ademas tenga costo total minimo.

a) Modelar como problema de flujo maximo de costo minimo.

b) Dar una interpretacion a cada unidad de flujo, restriccion de capacidad y costo por unidad.

c) Demostrar que el modelo es correcto.

d) Determinar la complejidad con el algoritmo del Ejercicio 22.

**Explicacion**

Extension del matching bipartito con costos: misma estructura que el modelo de cardinalidad maxima, pero cada arista $a_i \to b_j$ tiene costo $w(a_i, b_j)$. Aristas $s \to a_i$ y $b_j \to t$ tienen costo 0. El flujo maximo con costo minimo da el matching de maximo cardinal y minimo costo.

**Resolucion paso a paso**

**Modelo de flujo con costos:**

- $s \to a_i$ con cap 1, costo 0.
- $a_i \to b_j$ con cap 1, costo $w(a_i, b_j)$ (para cada arista $(a_i, b_j) \in E$).
- $b_j \to t$ con cap 1, costo 0.

**Interpretacion:** cada unidad de flujo = un par $(a_i, b_j)$ asignado al matching, con costo $w(a_i, b_j)$.

**Correctitud:** La estructura es la misma que el matching de cardinalidad maxima (Ej. 7). Maximizar el flujo produce el matching de cardinalidad maxima. Entre todos los matchings de cardinalidad maxima, el flujo de costo minimo selecciona el de menor costo total. $\square$

**Complejidad con el algoritmo del Ej. 22:**

Red con $|A| + |B| + 2$ vertices y $|A| + |B| + |E|$ aristas. Flujo max $\leq \min(|A|, |B|)$. Costo maximo por unidad $\leq \max w$. Usando MCMF: $O(n \cdot U \cdot m^2)$ con BF, o mejor con Dijkstra reescalado.

**Chuleta**

> Matching bipartito + costos: misma red que cardinalidad max, pero $a_i \to b_j$ con costo $w$.
> MCMF da el matching de max cardinalidad y min costo.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 24 — TSP via matching bipartito (caso $|V|=2n$)

**Enunciado**

En un digrafo completo y pesado $D$ con $|V(D)| = 2n$, se conoce el orden de los nodos "pares": $w_2, w_4, \ldots, w_{2n}$. El output debe ser un ciclo $v_1, v_2, \ldots, v_{2n}$ tal que $v_{2i} = w_{2i}$ para todo $i$.

a) Modelar el TSP como un problema de matching bipartito de peso minimo en un grafo $G$.

b) Dar una interpretacion a cada matching de $G$ como representante de un ciclo de $D$.

c) Demostrar que el modelo es correcto.

d) Determinar la complejidad con el algoritmo del Ejercicio 23.

**Explicacion**

Los nodos pares estan fijados. Los nodos impares $v_1, v_3, \ldots, v_{2n-1}$ deben ser asignados a las posiciones impares del ciclo. Cada nodo impar $v_{2i-1}$ aparece entre $w_{2i-2}$ y $w_{2i}$ en el ciclo. El matching bipartito asigna nodos impares (vertices de $D$) a posiciones impares, minimizando el costo de los arcos $w_{2i-2} \to v_{2i-1} \to w_{2i}$ en $D$.

**Resolucion paso a paso**

**Idea:** El ciclo alterna nodos impares (libres) y pares (fijos). Cada nodo impar $u$ ocupa la posicion $2i-1$ entre $w_{2i-2}$ y $w_{2i}$. El costo de asignar $u$ a la posicion $2i-1$ es $c_D(w_{2i-2} \to u) + c_D(u \to w_{2i})$.

**Modelo de matching bipartito:**

- Lado izquierdo: nodos impares libres $U = V(D) \setminus \{w_2, w_4, \ldots, w_{2n}\}$ (exactamente $n$ nodos).
- Lado derecho: posiciones impares $P = \{1, 3, 5, \ldots, 2n-1\}$ (exactamente $n$ posiciones).
- Arista $(u, 2i-1)$ con peso $c_D(w_{2i-2}, u) + c_D(u, w_{2i})$ (indice modular: $w_0 = w_{2n}$).

El matching perfecto de peso minimo da el ciclo de costo minimo con los nodos pares fijos.

**Correctitud:** Cada matching perfecto asigna un nodo impar a cada posicion impar → ciclo hamiltoniano valido. El costo del matching = costo del ciclo (solo los arcos hacia/desde nodos impares; los arcos entre nodos pares consecutivos son fijos). $\square$

**Complejidad:** $n$ vertices de cada lado, $n^2$ aristas. Con MCMF: $O(n^3)$.

**Chuleta**

> Bipartito: nodos impares vs. posiciones impares.
> Peso $(u, 2i-1) = c(w_{2i-2}, u) + c(u, w_{2i})$.
> Matching perfecto de peso min = ciclo min con nodos pares fijos.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 25 — Red con demandas (adicional)

**Enunciado**

Una red con demandas tiene por arista una capacidad $c(e)$ y una demanda $0 \leq d(e) \leq c(e)$. El problema de flujo en la red consiste en encontrar $f$ tal que $d(e) \leq f(e) \leq c(e)$ para todo arco $e$.

Para resolverlo se transforma la red $N$ en una red $N'$ agregando fuente $s'$, sumidero $t'$, arista $t' \to s'$ con cap $\infty$, y para todo $v$:

$$c'(s' \to v) = \sum_{u \in V} d(u \to v), \quad c'(v \to t') = \sum_{w \in V} d(v \to w)$$
$$c'(u \to v) = c(u \to v) - d(u \to v), \quad c'(t \to s) = \infty$$

Demostrar que $N$ tiene un flujo factible $\iff$ el flujo maximo de $N'$ satura todas las aristas que salen de $s'$ (y las que entran a $t'$).

**Explicacion**

Tecnica de reduccion de demandas. Cada arco con demanda $d(e)$ es "pre-llenado" con $d(e)$ unidades: $s'$ provee la demanda de entrada de cada nodo, $t'$ absorbe la demanda de salida. Un flujo factible en $N$ equivale a un flujo en $N'$ que satura las aristas de $s'$. La sugerencia de la doble implicacion guia la demostracion.

**Resolucion paso a paso**

**Intuicion:** La red $N'$ "pre-carga" las demandas. La diferencia $c'(u \to v) = c(u \to v) - d(u \to v)$ es la capacidad residual disponible ademas de la demanda minima. Las aristas de $s'$ y $t'$ modelan el desbalance por las demandas en cada nodo.

**Demostracion:**

$(\Rightarrow)$ Sea $f$ un flujo factible en $N$ ($d(e) \leq f(e) \leq c(e)$). Definir $f'$ en $N'$:
- $f'(u \to v) = f(u \to v) - d(u \to v) \in [0, c(u \to v) - d(u \to v)] = [0, c'(u \to v)]$. ✓
- $f'(s' \to v) = \sum_u d(u \to v)$ (flujo de demanda de entrada de $v$). ✓
- $f'(v \to t') = \sum_w d(v \to w)$ (flujo de demanda de salida de $v$). ✓
- Conservacion en $v$ en $N'$: flujo entrante = $f'(s' \to v) + \sum_u f'(u \to v) = \sum_u d(u \to v) + \sum_u (f(u \to v) - d(u \to v)) = \sum_u f(u \to v)$. Flujo saliente analogamente. Como $f$ conserva en $N$: $f'$ conserva en $N'$. ✓
- Aristas de $s'$ saturadas: $f'(s' \to v) = c'(s' \to v)$. ✓

$(\Leftarrow)$ Sea $f'$ flujo en $N'$ que satura todas las aristas de $s'$. Definir $f(u \to v) = f'(u \to v) + d(u \to v)$:
- $f(u \to v) \in [d(u \to v), d(u \to v) + c'(u \to v)] = [d(u \to v), c(u \to v)]$. ✓
- Conservacion: verificar que $\sum_u f(u \to v) = \sum_w f(v \to w)$ en $N$ — se deduce de la conservacion de $f'$ en $N'$ y de que las aristas de $s'$ y $t'$ estan saturadas (el "flujo virtual" de demandas se cancela). ✓

**Chuleta**

> **Reduccion de demandas:** pre-cargar cada demanda $d(e)$.
> - $s' \to v$ cap $= \sum$ demandas entrantes a $v$.
> - $v \to t'$ cap $= \sum$ demandas salientes de $v$.
> - Aristas originales: cap $c(e) - d(e)$.
> - Factible en $N$ $\Leftrightarrow$ flujo max en $N'$ satura todas las aristas de $s'$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 26 — Elecciones Rumestania (adicional)

> Ejercicio de 2do Parcial C2 2023

**Enunciado**

**26a)** En Zrovaliev ($n$ edificaciones, $U$ urnas distribuidas) los telegramas con conteos deben llevarse fisicamente a edificios con buena conexion. Para un par de edificaciones $(e_i, e_j)$ se hace a lo sumo un unico viaje si la distancia es $< d$ metros. Cada persona lleva a lo sumo $k$ telegramas. Se tiene para cada edificacion $i$: $u_i$ (urnas), lat$_i$, lon$_i$, tiene\_conexion$_i$. Maximizar la cantidad de telegramas que se pueden digitalizar.

i) Modelar y proponer un algoritmo basado en flujo. ¿Que representa cada unidad de flujo? ¿Cual es la complejidad?

**26b)** La prensa quiere colocar dispositivos espia en las mochilas para asegurarse de que todo telegrama que sea contabilizado pase por una mochila con dispositivo. Se conoce la logistica: que viajes se realizaran y cuantos telegramas llevara cada mochila. Encontrar la cantidad minima de dispositivos espias necesarios.

**Explicacion**

26a: modelo de flujo por edificaciones. $s \to$ edificio$_i$ con cap $u_i$ (telegramas disponibles), edificio$_i \to$ edificio$_j$ con cap $k$ si distancia $(i,j) < d$, edificio$_j \to t$ con cap $\infty$ si tiene\_conexion$_j$. Cada unidad de flujo = 1 telegrama digitalizado.

26b: min-cut en la red de viajes. Cada mochila (arista) puede contener un dispositivo → convertir aristas en nodos (split) con capacidad 1. Min-cut = minima cantidad de mochilas que interceptan todos los caminos de telegramas.

**Resolucion paso a paso**

**26a — Modelado de flujo:**

Red con $n + 2$ vertices:
- $s \to \text{edif}_i$ con cap $u_i$ (telegramas disponibles en edificacion $i$).
- $\text{edif}_i \to \text{edif}_j$ con cap $k$ si distancia$(i,j) < d$ (un viaje lleva hasta $k$ telegramas).
- $\text{edif}_j \to t$ con cap $\infty$ si $\text{tiene\_conexion}_j$ (edificios con conexion digitalizan sin limite).

Cada unidad de flujo = 1 telegrama digitalizado.

Complejidad: $O(n^2)$ aristas (todos los pares con distancia $< d$). Flujo max $\leq U$. EK: $O(n^2 U)$.

**26b — Minima cantidad de dispositivos:**

La red de viajes tiene aristas (viajes) con telegramas. Queremos interceptar todos los telegramas = min-cut donde los "nodos" son las mochilas (viajes).

Split de aristas: cada viaje (arista) se convierte en un nodo $v_{viaje}$ con arista entrante y saliente de cap = (numero de telegramas en ese viaje). El min-cut en la nueva red = minima cantidad de mochilas necesarias.

Alternativamente: min-cut en el grafo de viajes donde cada arista tiene cap 1 (seleccionar o no la mochila).

**Chuleta**

> **26a:** $s \to \text{edif}_i$ (cap $u_i$), $\text{edif}_i \to \text{edif}_j$ (cap $k$, dist $< d$), conexion $\to t$ (cap $\infty$). Flujo max = telegramas digitalizados.
>
> **26b:** Split de viajes (aristas → nodos con cap 1). Min-cut = min dispositivos espias.

**¿Aparece en parciales?** 🔴 Si → 2do Parcial C2 2023 (ejercicio original de parcial)

---

### Ejercicio 27 — Torneos de Futbol (adicional)

> Patron Furbo — ver [[flujo_en_redes_practica]]

**Enunciado**

**27a)** El equipo "Las Algoritmicas" quiere saber si puede ganar un torneo de fulbito. Ganar da 2 puntos, perder 0, empatar 1 a cada equipo. Se conocen los puntos actuales de cada equipo y cuantas fechas quedan. Modelar como problema de flujo.

**27b)** Boca quiere determinar, dados los puntajes actuales y los partidos por jugar, si puede ganar el torneo (puntaje mayor estricto que todos los demas). Ahora los partidos deben tener un ganador (sin empates), y ganar da 3 puntos. Modelar como problema de flujo.

**Explicacion**

Patron clasico de "sports elimination" (Furbo). El equipo candidato $c$ puede ganar como maximo $p_c + 2 \cdot r_c$ puntos. Para cada par de equipos $(i,j)$ con partidos restantes entre ellos: nodo partido$(i,j)$ con flujo = puntos a distribuir; nodos equipo$_i$ y equipo$_j$; sumidero con cap = limite de puntos que cada equipo puede acumular sin superar a $c$. El equipo $c$ puede ganar $\iff$ el flujo maximo satura todos los nodos de partido.

27b: mismo patron pero sin empates, cada partido distribuye exactamente 3 puntos al ganador.

Ver resolucion completa en [[flujo_en_redes_practica]] (Furbo version A y B).

**Resolucion paso a paso**

**Notacion:** Equipo candidato $c$, puntos actuales $p_i$, partidos restantes $r_i$ (total del equipo $i$), partidos restantes entre $i$ y $j$: $g_{ij}$.

**Puntaje maximo de $c$:** $P^*_c = p_c + 2 \cdot r_c$ (si $c$ gana todos sus partidos).

**27a — Con empates (ganar=2, empatar=1):**

Red de flujo:
- $s \to \text{partido}(i,j)$ con cap $2 \cdot g_{ij}$ (puntos totales a distribuir en ese partido: 2 si hay ganador, 2 si empatan en total).
- $\text{partido}(i,j) \to \text{equipo}_i$ con cap $2 \cdot g_{ij}$ (todos los puntos pueden ir a $i$).
- $\text{partido}(i,j) \to \text{equipo}_j$ con cap $2 \cdot g_{ij}$.
- $\text{equipo}_i \to t$ con cap $P^*_c - p_i - 1$ (equipo $i$ puede acumular a lo sumo $P^*_c - p_i - 1$ puntos adicionales sin superar a $c$; si ya supera: cap = 0 → imposible).

$c$ puede ganar $\Leftrightarrow$ flujo maximo $= \sum_{i \neq c, j \neq c, i < j} 2 \cdot g_{ij}$ (todos los partidos entre otros equipos saturados).

**27b — Sin empates (ganar=3, perder=0):**

Cada partido distribuye exactamente 3 puntos al ganador.

Red:
- $s \to \text{partido}(i,j)$ con cap $3 \cdot g_{ij}$.
- $\text{partido}(i,j) \to \text{equipo}_i$ y $\to \text{equipo}_j$ con cap $3 \cdot g_{ij}$.
- $\text{equipo}_i \to t$ con cap $P^*_c - p_i - 1$.

Misma condicion de saturacion.

**Complejidad:** $O(n^2)$ nodos de partido, $O(n^2)$ aristas. Flujo max $= O(n^2 \cdot g_{max})$. EK: $O(n^2 \cdot n^4)$ en general.

**Chuleta**

> **Patron Furbo:**
> $P^*_c = p_c + 2r_c$ (max puntos de $c$ con empates) o $p_c + 3r_c$ (sin empates).
> $s \to \text{partido}(i,j)$ (cap = puntos del partido), partido $\to$ equipo (cap = mismos), equipo $\to t$ (cap $= P^*_c - p_i - 1$).
> $c$ puede ganar $\Leftrightarrow$ flujo max satura todos los nodos de partido.

**¿Aparece en parciales?** 🔴 Si → [[flujo_en_redes_practica]] (Furbo)
