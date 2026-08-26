---
nombre: Algoritmos sobre grafos — lo que hay que tener claro (clase 2)
tipo: material_de_estudio
origen: raw/cursada_2C_2026/teo/teo_clase2_algo_en_grafos.pdf
tipo_documento: teorica
temas: [recorrido_en_grafos, grafos]
parcial: 1P
programa: 2C_2026
generado: 2026-08-25
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 13
ingestado: false
---

# Algoritmos sobre grafos — lo que hay que tener claro

La clase 2 arma una sola idea y la exprime cinco veces: **un grafo se recorre manteniendo una
colección de vértices descubiertos pendientes, y la estructura que elegís para esa colección
decide todo el resto.** Cola ⇒ BFS ⇒ distancias mínimas. Pila ⇒ DFS ⇒ estructura de anidamiento
⇒ ciclos, orden topológico y puentes. Todo lo demás de la clase son consecuencias.

**Fuente:** `raw/cursada_2C_2026/teo/teo_clase2_algo_en_grafos.pdf` (58 diapositivas)
**Tema:** `recorrido_en_grafos` + `grafos` → **1P** (programa 2C_2026)
**Cómo leer esto:** ordenado por cuánto conviene dominar cada cosa.
🔴 dominar · 🟡 entender · ⚪ leer una vez

> ⚠️ **Antes de empezar: `d[v]` significa dos cosas distintas.**
> En **BFS**, `d[v]` es la **distancia** desde la fuente. En **DFS**, `d[u]` es el **tiempo de
> descubrimiento** (el valor del contador cuando el vértice se pinta de gris). Y `d(v)` sin
> corchetes es el **grado**. La cátedra reusa la letra a propósito. En el parcial, escribí
> siempre qué estás llamando `d` antes de usarlo.

---

## 🔴 1. Ordenamiento topológico

### Qué dice

Un **orden topológico** de un digrafo es una forma de acomodar todos los vértices en una fila tal
que **todas las flechas apuntan hacia adelante**. Si existe la arista $v_i \to v_j$, entonces $v_i$
va antes que $v_j$ en la fila.

Formalmente: un orden lineal $v_1, v_2, \ldots, v_n$ de $V$ tal que $v_i \to v_j \in E \implies i < j$.

**El teorema central:** un digrafo admite orden topológico **si y solo si es acíclico** (un DAG).

La dirección fácil es la que casi nunca piden pero conviene saber decir en una línea: si hubiera
un ciclo $a \to b \to c \to a$, entonces $a$ tendría que ir antes que $b$, que antes que $c$, que
antes que $a$ — o sea, $a$ antes que sí mismo. Absurdo.

### Por qué es cierto

La dirección difícil (acíclico ⇒ existe orden) se apoya en un lema que hay que tener a mano:

> **Lema.** Todo DAG tiene al menos un vértice $v$ con grado de entrada $d^-(v) = 0$.

**Por qué:** supongamos que no — que **todo** vértice tiene alguna flecha entrante. Entonces parate
en cualquier vértice y caminá **hacia atrás**: siempre hay por dónde seguir, así que podés caminar
para siempre. Pero el grafo tiene finitos vértices, así que en algún momento tenés que **repetir**
uno. El tramo entre las dos visitas a ese vértice es un ciclo dirigido. Contradice que sea un DAG.

Con el lema, el orden se construye solo, por inducción: agarrás un vértice de grado de entrada
cero, lo ponés primero (no depende de nadie, así que es seguro), lo borrás, y lo que queda **sigue
siendo un DAG** — borrar vértices no puede crear ciclos. Repetís.

Esa es toda la demostración, y es la que te piden escribir cuando el ejercicio es de desarrollo.

### Cómo se usa

El algoritmo de la cátedra es **Kahn**, y lo que lo hace lineal es no recalcular los grados desde
cero en cada paso: cuando sacás $u$, lo único que cambia son los grados de entrada de sus vecinos
de salida.

```
ORDEN-TOPOLOGICO(D)
  n ← |V(D)|;  L ← ⟨⟩
  computar entrada[v] = d⁻(v) para todo v
  Q ← cola vacía
  para todo v: si entrada[v] = 0 → ENCOLAR(Q, v)

  mientras Q ≠ ∅:
      u ← DESENCOLAR(Q)
      agregar u al final de L
      para todo v ∈ N⁺(u):
          entrada[v] ← entrada[v] − 1
          si entrada[v] = 0 → ENCOLAR(Q, v)

  si |L| < n → devolver "D tiene un ciclo"
  devolver L
```

**El chequeo `|L| < n` es la detección de ciclos, no un paso extra.** Si la cola se vacía antes de
haber emitido los $n$ vértices, los que sobraron forman un subdigrafo donde **todos** tienen grado
de entrada positivo — y por el lema de arriba, eso significa que hay un ciclo. Un solo algoritmo
te responde las dos preguntas: "¿es acíclico?" y "dame el orden".

**Complejidad:** $O(|V| + |E|)$ con listas de adyacencia. Cada vértice se encola exactamente una
vez y cada arista se procesa exactamente una vez.

La clase también muestra a propósito la **versión ingenua** (diapositiva 13): buscar un vértice de
grado 0, borrarlo del grafo, recursión. Es correcta pero cuesta $O(n(n+m))$, porque buscar-y-borrar
es $O(n+m)$ y lo hacés $n$ veces. Sabé que existe y por qué es peor — es material de multiple choice.

### Cómo te lo piden

Dos formas, las dos ya tomadas:

1. **Ejecución a mano.** Te dibujan un DAG chico y tenés que escribir un orden topológico válido.
2. **Modelado + demostración + algoritmo.** Te dan un problema de dependencias en palabras
   ("módulos de un sistema", "materias correlativas") y tenés que: traducir "no se puede actualizar
   en un orden seguro" a "tiene un ciclo", **demostrar el lema de existencia**, y dar el algoritmo
   $O(n+m)$ con pseudocódigo.

### La trampa

**Cuatro, y las cuatro cuestan puntos:**

- **El orden no es único**, y no hace falta que lo sea. Cualquier vértice de grado de entrada cero
  sirve en cada paso. Si dudás entre dos respuestas porque "el orden me dio distinto al del
  compañero", probablemente las dos estén bien. Verificá arista por arista, no contra otro orden.
- **Leé para qué lado apunta la flecha.** En el problema de desarrollo ya tomado, la respuesta era
  el orden topológico del **traspuesto**: si la arista $a \to b$ significa "$a$ depende de $b$",
  entonces el orden seguro de actualización es el **inverso** del orden topológico directo. Acá es
  donde se pierde el ejercicio entero, no en el algoritmo.
- **No te olvides del chequeo final.** Un algoritmo que devuelve `L` sin verificar `|L| < n` está
  incompleto, y devuelve silenciosamente una respuesta incorrecta sobre un grafo con ciclo.
- **Es más fácil de lo que parece, y por eso se pierde.** En el 1P de 1C-2025 este era un multiple
  choice, y **las dos resoluciones fotografiadas que tenemos lo contestaron mal**. Practicalo a
  mano aunque te parezca trivial.

> Lo tomaron en: `1P_1C_2024` Problema B (desarrollo) · `1P_1C_2025` Ej 12

---

## 🔴 2. BFS — recorrido por capas y distancias mínimas

### Qué dice

BFS recorre el grafo **en capas de distancia creciente** desde una fuente $s$: primero $s$, después
todo lo que está a distancia 1, después todo lo que está a distancia 2, etc.

$$L_i = \{v \in V : \delta(s,v) = i\}$$

donde $\delta(s,v)$ es la longitud (en **cantidad de aristas**, no pesos) del camino más corto de
$s$ a $v$, e $\infty$ si $v$ no es alcanzable.

Devuelve dos cosas:
- `d[v]` — la distancia desde $s$ hasta $v$
- `π[v]` — el predecesor de $v$ en un **árbol de caminos mínimos**

**El teorema:** al terminar, $d[v] = \delta(s,v)$ para todo $v$. BFS no *aproxima* las distancias:
las calcula exactamente.

### Por qué es cierto

Esto es lo más denso de la clase, y se demuestra en dos mitades que atacan desigualdades opuestas.

**Mitad fácil — $d[v] \ge \delta(s,v)$.** Cuando BFS descubre $v$ desde $u$, escribe
$d[v] = d[u]+1$ y $\pi[v] = u$. Siguiendo la cadena de predecesores hacia atrás obtenés un **camino
real** de $s$ a $v$ de longitud exactamente $d[v]$. Y como $\delta(s,v)$ es la longitud del camino
*más corto*, ningún camino real puede ser más corto que él: $\delta(s,v) \le d[v]$. O sea, **BFS
nunca subestima** — todo valor que escribe es alcanzable de verdad.

**Mitad difícil — $d[v] \le \delta(s,v)$**, es decir, BFS tampoco *sobre*estima. Acá hace falta una
pieza extra, y es la que se saltea todo el mundo:

> **Lema de la cola.** Si en algún momento $Q = \langle v_1, \ldots, v_r \rangle$, entonces
> $$d[v_1] \le d[v_2] \le \cdots \le d[v_r] \le d[v_1] + 1$$

En castellano: **la cola siempre está ordenada por distancia, y contiene vértices de a lo sumo dos
capas consecutivas.** Nunca hay un vértice de la capa 5 y uno de la capa 3 esperando juntos.

**Por qué vale:** los dos únicos eventos que tocan la cola la preservan. Al *desencolar* $v_1$, el
nuevo primero es $v_2$, que ya cumplía $d[v_2] \ge d[v_1]$. Al *encolar* un $v$ descubierto desde
$u$, se agrega **al final** con $d[v] = d[u]+1$, y $u$ era el frente — así que $v$ queda detrás de
puros vértices con distancia $d[u]$ o $d[u]+1$.

**Y de ahí sale el teorema:** el lema garantiza que los vértices se procesan en orden **no
decreciente** de $d$. Entonces, cuando BFS llega a procesar la capa $k$, ya terminó con todas las
anteriores — no puede quedar un camino corto sin explorar que hubiera dado un valor menor. Si algo
fallara, habría un primer vértice (el de $\delta$ mínima entre los incorrectos) donde falla, y el
lema hace imposible que su predecesor en el camino mínimo haya sido procesado tarde.

> ⚠️ **El PDF no cierra este último argumento**: plantea el vértice de $\delta$ mínima y salta a la
> complejidad. Si el parcial pide la demostración completa, está en Cormen cap. 20. Lo que sí
> alcanza para casi todo es saber enunciar el lema de la cola y decir para qué sirve.

### Cómo se usa

**Estados por color** — el vocabulario que después se reusa en DFS:

| Color | Significa | Dónde está |
|---|---|---|
| Blanco | No descubierto | $d[v]=\infty$, $\pi[v]=$ NIL |
| Gris | Descubierto, sin terminar | **En la cola** |
| Negro | Terminado | Ya se miró toda su lista de adyacencia |

**El invariante que vale la pena recordar: en BFS, la cola contiene exactamente los vértices grises.**
Son la frontera entre lo explorado y lo que falta.

```
BFS(G, s)
  para cada u ≠ s:  color[u] ← blanco;  d[u] ← ∞;  π[u] ← NIL
  color[s] ← gris;  d[s] ← 0;  π[s] ← NIL
  Q ← ⟨s⟩

  mientras Q ≠ ∅:
      u ← DESENCOLAR(Q)
      para cada v ∈ Adj[u]:
          si color[v] = blanco:
              color[v] ← gris
              d[v] ← d[u] + 1;  π[v] ← u
              ENCOLAR(Q, v)
      color[u] ← negro
```

**Complejidad $O(n+m)$**, y conviene saber de dónde sale cada término: $O(n)$ de inicializar, más
$O(\sum_v d(v)) = O(2m)$ de recorrer las listas de adyacencia — cada vértice se encola **a lo sumo
una vez** (el chequeo de blanco lo garantiza) y cada lista se examina una sola vez.

**Reconstrucción del camino.** El subgrafo de predecesores $G_\pi$ resulta ser un **árbol BFS** con
raíz $s$: contiene exactamente los vértices alcanzables desde $s$, y el camino del árbol de $s$ a
cualquiera de ellos **es** un camino mínimo en $G$. Para imprimirlo, recursión hacia atrás por $\pi$:

```
PRINT-PATH(G, s, v)
  si v = s        → IMPRIMIR(s)
  si π[v] = NIL   → IMPRIMIR("no existe camino")
  si no           → PRINT-PATH(G, s, π[v]);  IMPRIMIR(v)
```

Esta idea — guardar $\pi$ durante el algoritmo y recuperar la solución recorriéndolo al final — es
la misma que vuelve en caminos mínimos y en la reconstrucción de programación dinámica del 2P.

### Cómo te lo piden

Casi siempre igual: **multiple choice de "cuáles de estas afirmaciones sobre BFS son correctas"**,
con los mismos cuatro distractores rotando. Acá están resueltos:

| Afirmación | | Por qué |
|---|---|---|
| Todo vértice a distancia $k$ se visita antes que los de $k+1$ | **V** | Lema de la cola: se procesan en orden no decreciente de $d$ |
| El árbol BFS es único | **F** | Depende del orden de las listas de adyacencia y de la fuente. **Las distancias sí son únicas; el árbol no** |
| Toda arista $(u,v)$ implica relación ancestro-descendiente en el árbol | **F** | Eso es DFS. Contraejemplo: $K_3$ — dos vértices quedan hermanos en la capa 1 y la arista entre ellos no es de árbol |
| Hace falta matriz de adyacencia para lograr $O(n+m)$ | **F** | Al revés: con **listas** da $O(n+m)$; con matriz, recorrer $N(v)$ cuesta $O(n)$ y el total se va a $O(n^2)$ |

### La trampa

- **La distinción "las distancias son únicas, el árbol no".** Es la respuesta a dos distractores
  distintos y es lo que más se confunde.
- **La propiedad ancestro-descendiente es de DFS.** Si la ves enunciada sobre BFS, es falsa.
- **BFS da caminos mínimos en cantidad de aristas, no en peso.** Con pesos hace falta Dijkstra
  (que es 2P). Si el enunciado tiene números sobre las aristas, BFS solo sirve si todos los pesos
  son iguales.
- **Una sola BFS no te da el ciclo mínimo del grafo.** Ver la sección de huecos al final: esto ya
  lo tomaron y la respuesta correcta era $\Theta(|V|)$ ejecuciones de BFS.

> Lo tomaron en: `1P_1C_2024` Ej 8 · `2P_1C_2024` Ej 7 · `2P_2C_2025` Ej 1.II · `2P_1C_2025` Ej A3, B2

---

## 🔴 3. DFS — bosque, tiempos y complejidad

### Qué dice

DFS explora las aristas del vértice **descubierto más recientemente** que todavía tiene aristas sin
mirar. Avanza mientras encuentra vértices nuevos; cuando no puede, **retrocede** al vértice desde el
que llegó.

Dos diferencias estructurales con BFS que hay que tener claras:

- **DFS no está atado a una fuente.** Un bucle exterior relanza `DFS-VISIT` desde cada vértice que
  quedó blanco, así que produce un **bosque**, no un solo árbol. Cada llamada del bucle exterior
  crea una raíz nueva.
- **DFS registra tiempos.** Un contador global se incrementa dos veces por vértice:
  - `d[u]` — cuándo se descubre (pasa a gris)
  - `f[u]` — cuándo termina de examinar toda su lista (pasa a negro)

  Como hay exactamente un descubrimiento y una finalización por vértice, los tiempos son enteros
  de $1$ a $2|V|$, y siempre $1 \le d[u] < f[u] \le 2|V|$.

### Por qué es cierto

**El invariante que explica todo DFS: los vértices grises son exactamente la pila de llamadas
recursivas.** No es una metáfora — es literal. Un vértice está gris justamente durante el intervalo
en que su llamada `DFS-VISIT` está activa y todavía no retornó.

De ahí sale, sin esfuerzo, todo lo demás: por qué una arista hacia un gris va necesariamente hacia
un ancestro (los grises son la cadena de ancestros del vértice actual), por qué los intervalos
$[d[u], f[u]]$ se anidan como paréntesis, y por qué `low` se puede propagar hacia arriba al
retroceder.

**La complejidad $\Theta(|V|+|E|)$** sale de dos observaciones independientes:
- `DFS-VISIT` se llama **exactamente una vez por vértice** — el chequeo de blanco lo garantiza.
- Sumando sobre todas las llamadas, el bucle interno recorre cada lista de adyacencia una vez:
  $\sum_u |Adj[u]| = \Theta(|E|)$.

```
DFS(G)
  para cada u:  color[u] ← blanco;  π[u] ← NIL
  tiempo ← 0
  para cada u:
      si color[u] = blanco → DFS-VISIT(G, u)      ← cada llamada acá crea una raíz

DFS-VISIT(G, u)
  tiempo ← tiempo + 1;  d[u] ← tiempo;  color[u] ← gris
  para cada v ∈ Adj[u]:
      si color[v] = blanco:
          π[v] ← u
          DFS-VISIT(G, v)
  tiempo ← tiempo + 1;  f[u] ← tiempo;  color[u] ← negro
```

### Cómo se usa

Es el motor de casi todo lo demás del tema: detección de ciclos (buscar back edges), orden
topológico alternativo (post-orden invertido), componentes conexas, y puentes.

**Lo que la salida de DFS *no* es: única.** Depende de dos decisiones arbitrarias — el orden en que
el bucle exterior considera los vértices, y el orden de los vecinos dentro de cada lista de
adyacencia. Cambiar cualquiera de las dos puede cambiar las raíces, las aristas del bosque, los
tiempos, y hasta la clasificación de las aristas.

### Cómo te lo piden

Tres formas, las tres ya tomadas:

1. **"¿Cuál de estos recorridos es un DFS válido?"** Te dan un digrafo chico y cuatro secuencias.
   Se resuelve simulando: profundizá hasta que no haya vecinos blancos, después retrocedé.
2. **"¿Cuál es la complejidad de este algoritmo?"** Te dan código que itera los vértices y lanza
   DFS desde los no visitados. La respuesta es $O(|V|+|E|)$ — **no** $O(|V| \cdot (|V|+|E|))$,
   porque los flags de visitado impiden re-explorar.
3. **"¿Qué calcula este algoritmo?"** — la más difícil. Ver la trampa.

### La trampa

- **Un DFS anidado dentro de un `for` sobre los vértices NO multiplica la complejidad.** Parece
  $n$ veces $O(n+m)$, pero es $O(n+m)$ total, porque el estado de visitado es **compartido** entre
  todas las llamadas. Este razonamiento es el que evalúan, no la fórmula.
- **"¿Qué calcula contar las invocaciones de DFS?" → "Ninguna de las anteriores."** El número de
  veces que el bucle exterior lanza `DFS-VISIT` **depende del orden de iteración**, así que no
  puede ser una propiedad del grafo. El contraejemplo mínimo es el digrafo $u \to v$: empezando
  por $v$ da 2, empezando por $u$ da 1. Con eso descartás todas las opciones que ofrecen
  "componentes conexas", "componentes fuertemente conexas" o "vértices de grado de entrada 0".
  **Guardate ese contraejemplo de dos vértices**: es lo más barato que podés memorizar de esta clase.
- **No confundir `d[u]` (tiempo) con `d[v]` de BFS (distancia).** Ver el aviso del principio.

> Lo tomaron en: `1P_1C_2024` Ej 9, Ej 10 · `1P_1C_2025` Ej 4

---

## 🟡 4. Representación: listas vs. matriz

### Qué dice

El grafo $G=(V,E)$ es un objeto matemático; la **representación** es una estructura de datos que
implementa la función $v \mapsto N(v)$. Distintas representaciones no cambian el grafo — cambian
cuánto cuesta cada operación. Suponiendo $V = \{0, \ldots, n-1\}$:

| | Listas de adyacencia | Matriz de adyacencia |
|---|---|---|
| **Espacio** | $\Theta(n+m)$ | $\Theta(n^2)$ |
| Consultar $vw \in E$ | $O(d(v))$ | $O(1)$ |
| Recorrer $N(v)$ | $O(d(v))$ | $O(n)$ |
| Recorrer todas las aristas | $O(n+m)$ | $O(n^2)$ |
| Insertar $vw$ | $O(1)$ | $O(1)$ |
| Remover $vw$ | $O(d(v)+d(w))$ | $O(1)$ |
| Remover un vértice | $O(n+m)$ | $O(n^2)$ |

**Regla de decisión: manda la operación dominante del algoritmo.** Grafo ralo ($m \sim n$) →
listas, porque $n+m \ll n^2$. Grafo denso o algoritmo que pregunta adyacencia todo el tiempo →
puede convenir la matriz. No hay una universalmente mejor.

### Por qué es cierto

- **La matriz es $\Theta(n^2)$ pase lo que pase**, porque reserva una celda por *par* de vértices,
  tenga o no arista. Por eso desperdicia en grafos ralos.
- **Las listas guardan solo lo que existe**, y el conteo exacto importa:
  $$\sum_{v \in V} |Adj[v]| = m \ \text{ (digrafos)} \qquad \sum_{v \in V} |Adj[v]| = 2m \ \text{ (no dirigidos)}$$
  En un digrafo cada arco $v \to w$ aparece una sola vez (en la lista de $v$); en un grafo no
  dirigido, la arista $vw$ aparece dos veces, en la lista de $v$ **y** en la de $w$. Esa suma es
  **exactamente** el paso que justifica el $O(n + 2m) = O(n+m)$ de BFS y DFS. No es un detalle
  contable: es de dónde sale la complejidad de todo el resto de la clase.
- **Remover $vw$ de listas cuesta $O(d(v)+d(w))$** justamente porque hay que encontrar y borrar las
  dos copias.
- **Pesos:** se guardan junto a la arista — `Adj[v] ∋ (w, p(v,w))`, o `A[v,w] = p(v,w)` con `NIL`
  para ausencia. La estructura no cambia, solo la información asociada.

### La trampa

- **Tablas hash en lugar de vectores**: te dan adyacencia en $\Theta(1)$, pero **no** reducen el
  espacio (sigue siendo $O(n+m)$) y **pierden el orden**, así que ya no podés recorrer $N(v)$ en
  orden ascendente. De cuatro opciones ofrecidas, la única verdadera es la de $\Theta(1)$.
- **"Peso 0" vs. "sin arista".** No uses $0$ para marcar ausencia si una arista puede pesar $0$ —
  el PDF lo señala explícitamente. Usá `NIL`.
- **Es la pregunta más barata del parcial.** Tres preguntas ya tomadas se contestan con la tabla de
  arriba. Memorizala tal cual; son puntos regalados.

> Lo tomaron en: `1P_1C_2025` Ej 2, Ej 3 · `1P_1C_2024` Ej 8 (como distractor)

---

## 🟡 5. Clasificación de aristas y la regla del color

### Qué dice

Respecto de un bosque DFS ya construido, toda arista de un digrafo cae en exactamente una de
cuatro categorías:

| Tipo | Qué es |
|---|---|
| **Árbol** | $(u,v)$ descubrió a $v$ por primera vez, o sea $\pi[v]=u$ |
| **Retroceso** (*back*) | Va de $u$ hacia un **ancestro** suyo. Los bucles cuentan acá |
| **Avance** (*forward*) | No es del bosque y va hacia un **descendiente propio** de $u$ |
| **Cruce** (*cross*) | Cualquier otra: extremos incomparables, o en árboles distintos |

Y se clasifican **sobre la marcha**, mirando el color del destino:

| `color[v]` al examinar $(u,v)$ | Tipo | Por qué |
|---|---|---|
| Blanco | **Árbol** | $v$ se descubre justo por esta arista |
| Gris | **Retroceso** | Los grises son la cadena de ancestros activos |
| Negro | Avance **o** cruce | $v$ ya terminó. Desempatar con tiempos: $d[u]<d[v]$ ⇒ avance, $d[v]<d[u]$ ⇒ cruce |

### Por qué es cierto

La fila del gris es la única que necesita argumento, y ya la tenés: **los grises son exactamente la
pila de llamadas activas**, o sea la cadena de ancestros de $u$. Una arista hacia un gris no tiene
a dónde ir que no sea hacia arriba.

Y el teorema que hace útil todo esto:

> **En un grafo NO dirigido, toda arista es de árbol o de retroceso.** No hay avance ni cruce.

**Por qué:** sea $\{u,v\}$ con $d[u] < d[v]$. La arista se examina desde alguno de los dos extremos
primero. Si se examina desde $u$, entonces $v$ todavía está blanco (porque $d[v] > d[u]$) y la
arista entra al árbol. Si se examina desde $v$, entonces $u$ todavía está gris — su llamada no
terminó — así que $u$ es ancestro de $v$ y la arista es de retroceso. No hay tercer caso.

### La trampa

- **La clasificación no es propiedad del grafo, es propiedad del bosque.** Cambiá el orden de
  exploración y la misma arista puede pasar de avance a cruce. Si un enunciado dice "la arista
  $(u,v)$ **es** de cruce" sin fijar el recorrido, está mal planteado o es un distractor.
- **En la práctica esto no se pregunta solo**, sino como el paso "detecto un ciclo" adentro de un
  ejercicio más grande: **hay ciclo $\iff$ hay back edge**. Esa equivalencia es el uso real.
- **Solo cuatro tipos en digrafos; dos en no dirigidos.** Confundirlos rompe el algoritmo de puentes.

> Lo tomaron en: `1P_1C_2024` Problema B (back edges para detectar ciclos) · `2P_2C_2025` Ej 2

---

## 🟡 6. Aristas de corte (puentes) con `low`

### Qué dice

Una arista es **puente** (o arista de corte) si sacarla aumenta la cantidad de componentes conexas.
La clase da un algoritmo que los encuentra **todos** en una sola DFS, $\Theta(n+m)$.

**El recorte que hace todo posible:** toda arista que **no** está en el bosque DFS es de retroceso
(teorema de la unidad anterior), y por lo tanto está contenida en un ciclo — sacarla no desconecta
nada. Entonces **solo las aristas del árbol pueden ser puente**, y como el bosque tiene a lo sumo
$n-1$ aristas, hay a lo sumo $n-1$ puentes. Ya redujiste el problema de $m$ candidatas a $n-1$.

Se define, para cada vértice $u$:

$$low[u] = \min \begin{cases} d[u] \\ d[v] : \{u,v\} \text{ de retroceso, } v \text{ ancestro de } u \\ low[w] : \pi[w] = u \end{cases}$$

En castellano: **`low[u]` es el tiempo de descubrimiento más antiguo al que podés llegar arrancando
en $u$, bajando cero o más aristas del árbol, y usando a lo sumo una arista que no sea del árbol.**
Como los tiempos crecen hacia abajo en el árbol, "más antiguo" significa "más arriba".

**El criterio:** $uv$ con $\pi[v]=u$ es puente $\iff$ $low[v] > d[u]$.

### Por qué es cierto

Leé el criterio como una pregunta: *¿el subárbol de $v$ puede alcanzar algo estrictamente por
encima de $u$ sin usar la arista $uv$?*

- Si **puede** ($low[v] \le d[u]$), existe un camino alternativo que rodea la arista: bajás por el
  subárbol de $v$, tomás la arista de retroceso, y salís por arriba. Sacar $uv$ no desconecta nada.
- Si **no puede** ($low[v] > d[u]$), la única forma de salir del subárbol de $v$ hacia el resto del
  grafo es la arista $uv$. Sacarla lo aísla. Es puente.

Las dos actualizaciones de `low` se corresponden exactamente con los dos casos de la definición:

```
DFS-PUENTES-VISIT(G, u)
  tiempo ← tiempo + 1;  d[u] ← tiempo;  low[u] ← d[u];  color[u] ← gris
  para cada v ∈ Adj[u]:
      si color[v] = blanco:
          π[v] ← u
          DFS-PUENTES-VISIT(G, v)
          low[u] ← mín{low[u], low[v]}        ← al VOLVER: heredo lo del hijo
      si no, si color[v] = gris y v ≠ π[u]:
          low[u] ← mín{low[u], d[v]}          ← arista de retroceso
  tiempo ← tiempo + 1;  f[u] ← tiempo;  color[u] ← negro
```

**Que la primera actualización esté DESPUÉS de la llamada recursiva no es un detalle de estilo:**
es lo que hace que los valores se propaguen de las hojas hacia la raíz. Cuando volvés de explorar
$v$, todo lo que el subárbol de $v$ alcanza también lo alcanza $u$.

Y la segunda fase es barata — un test por arista del árbol, o sea un test por vértice no raíz:

```
B ← ∅
para cada v:  si π[v] ≠ NIL y low[v] > d[π[v]]  →  B ← B ∪ {π[v], v}
devolver B
```

**Complejidad:** $\Theta(|V|+|E|)$ en tiempo, $O(|V|)$ en espacio adicional (los arreglos `color`,
`π`, `d`, `f`, `low` más la pila de recursión). Funciona igual si $G$ no es conexo: da un bosque.

### La trampa

- **La condición `v ≠ π[u]` es obligatoria y es donde se rompe todo.** En un grafo no dirigido, la
  arista al padre aparece en la lista de adyacencia de $u$ como cualquier otra. Sin ese chequeo, la
  tomarías como arista de retroceso, `low[u]` bajaría hasta `d[π[u]]` y **ningún** arista daría
  puente jamás. Si tu algoritmo devuelve cero puentes siempre, es esto.
- **Las raíces no tienen arista al padre**, así que el test de la segunda fase las saltea
  (`π[v] = NIL`). No las cuentes.
- **Ojo con la desigualdad estricta.** Es $low[v] > d[u]$, no $\ge$. Con $\ge$ marcarías como
  puente toda arista del árbol.
- **Hay tres versiones distintas de este algoritmo dando vueltas en tus apuntes** — ver la sección
  de divergencias al final antes de estudiar de la guía vieja.

> Lo tomaron en: ningún parcial de los 6 analizados. Sube a 🟡 igual — ver el apéndice.

---

## ⚪ Leer una vez, no memorizar

- **Grafo vs. representación como objetos distintos** (diapos 3–5) — el marco conceptual del que
  cuelga la unidad 4. Dos minutos de lectura.
- **Esquema unificado de recorrido** (diapo 18) — cola ⇒ BFS, pila ⇒ DFS. Es el hilo de toda la
  clase, pero nunca se pregunta solo.
- **Teorema de los paréntesis** (diapos 39–40) — los intervalos $I(u)=[d[u],f[u]]$ de dos vértices
  **o se anidan o son disjuntos**, nunca se superponen parcialmente. Es la formalización del
  invariante "grises = pila de llamadas", y la maquinaria detrás de las unidades 5 y 6.
  **Excepción que sí conviene memorizar — el corolario:** $v$ es descendiente propio de $u$
  $\iff d[u] < d[v] < f[v] < f[u]$. Es una línea, es la definición operativa de "descendiente", y
  tiene forma de multiple choice.
- **Teorema del camino blanco** (diapo 42) — $v$ es descendiente de $u$ $\iff$ en el instante
  $d[u]$ existe un camino de $u$ a $v$ **todo blanco**. Elegante y útil para razonar, sin
  precedente en parciales.
- **Las corridas paso a paso** (diapos 16, 22–23, 35–37, 52, 55) — no se estudian, se **usan**:
  tapá el resultado, corré el algoritmo a mano, y recién ahí compará. Las de 52 y 55 corren el
  mismo grafo de 7 vértices con las dos implementaciones de `low` y llegan a los mismos valores.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Orden topológico | 🔴 | `1P_1C_2024` Problema B · `1P_1C_2025` Ej 12 | *(sin patrón compilado)* |
| BFS | 🔴 | `1P_1C_2024` Ej 8 · `2P_1C_2024` Ej 7 · `2P_2C_2025` Ej 1.II · `2P_1C_2025` Ej A3, B2 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| DFS | 🔴 | `1P_1C_2024` Ej 9, Ej 10 · `1P_1C_2025` Ej 4 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Representación | 🟡 | `1P_1C_2025` Ej 2, Ej 3 · `1P_1C_2024` Ej 8 (distractor) | *(sin patrón compilado)* |
| Clasificación de aristas | 🟡 | `1P_1C_2024` Problema B · `2P_2C_2025` Ej 2 (como herramienta) | — |
| Puentes con `low` | 🟡 | **ninguna** | — |
| Paréntesis / camino blanco | ⚪ | ninguna | — |

**Base de comparación:** 6 parciales analizados, 13 patrones en `tipos_ejercicio/`.

**Por qué puentes sube a 🟡 sin apariciones.** Dos razones concretas, no precaución genérica:
es el **ejercicio ⋆ de la guía** ([[recorrido_en_grafos_guia]] Ej 2, con 4 incisos, y
[[recorrido_en_grafos_practica]] Ej 5), y la cátedra le dedicó **12 de 58 diapositivas** con dos
implementaciones completas. Además, el material de la cursada vigente es fuente de autoridad:
"nunca lo tomaron" puede significar "todavía no".

> ⚠️ **Hueco del índice.** Orden topológico y representación de grafos **fueron evaluados** pero no
> tienen página en `tipos_ejercicio/`. El cruce para esos dos se hizo leyendo los
> `parciales_analizados/` directamente. Sin eso, este documento habría dicho "sin precedente" sobre
> justo lo que sí toman. Correr `/tipos_ejercicio_scan` para cerrarlo.

> 📌 Los rótulos `1P`/`2P` de los parciales citados son **históricos**: recorridos era 2P en el
> programa viejo. Con el programa vigente (2C-2026) todo esto es material de tu **1P**. Los
> ejercicios siguen valiendo; cambió en qué parcial te los toman. Ver [[programa]].

## Lo que este documento NO cubre y igual toman

Esta clase da la **maquinaria**. Las **aplicaciones** las toman más:

- **Ciclo mínimo global** → $\Theta(|V|)$ ejecuciones de BFS, $O(|V|\cdot(|V|+|E|))$.
  Una sola BFS da el ciclo mínimo *que pasa por el nodo inicial*, no el global. DFS **no** sirve:
  las back edges detectan ciclos pero no los más cortos. (`2P_2C_2025` Ej 1.II)
- **BFS en grilla** = distancia Manhattan $i+j$. (`2P_1C_2025` Ej A3)
- **Grafo expandido / duplicado con bit de paridad** para camino de longitud par mínima.
  (`2P_1C_2024` Ej 7 · [[tipos_ejercicio/cm_estado_expandido]])
- **Bipartitez vía BFS** (2-coloreo). (`2P_1C_2025` Ej A1)
- **Componentes conexas y la relación de conectividad.** (`1P_1C_2025` Ej 7)

Todas viven en [[recorrido_en_grafos_practica]] y [[recorrido_en_grafos_guia]].

- **[[tipos_ejercicio/grafos_demostraciones]] — 3 apariciones.** Demostrar o refutar propiedades de
  la *estructura* de los grafos: orientaciones acíclicas, grafos autocomplementarios, condiciones
  suficientes para ser árbol. Esta clase demuestra cosas sobre BFS/DFS, que es otra habilidad.
  Material en [[grafos_teoria]], [[arboles_teoria]], [[grafos_guia]].
- **Componentes fuertemente conexas** — aparecen como distractor en `1P_1C_2024` Ej 10 y esta clase
  no las da.

## Divergencias detectadas

> 🔄 **El algoritmo de puentes está en tres formulaciones distintas en tus apuntes.** Son
> equivalentes, pero si estudiás de la guía vieja sin saber esto, no vas a reconocer el criterio.
>
> | Fuente | Magnitud | Criterio de puente |
> |---|---|---|
> | **Cursada 2C-2026** (esta clase) | tiempos de descubrimiento `d[]` | $low[v] > d[\pi[v]]$ |
> | [[recorrido_en_grafos_guia]] Ej 2 | **niveles** del árbol DFS | $low[v] > \text{nivel}[\text{padre}]$ |
> | [[recorrido_en_grafos_practica]] Ej 5 | conteo `cubren(v)` de back edges | $\text{cubren}(v) = 0$ |
>
> Las tres responden lo mismo: *¿el subárbol de $v$ alcanza algo estrictamente por encima de su
> padre sin usar la arista al padre?* Cambia con qué se mide "por encima". **Manda la vigente**,
> pero las otras dos no se descartan: ahí están las demostraciones y los ejercicios resueltos.
> Ya quedó registrada en [[recorrido_en_grafos_teoria]].

## Estado

Este PDF **ya fue ingestado** — la teoría vive en [[recorrido_en_grafos_teoria]] (creada
2026-08-25). Este archivo es material de estudio personal, regenerable, y no se mantiene.

**Pendiente:** las diapositivas 3–11 (representación) pisan la sección de representación de
[[grafos_teoria]] y requieren `/ingestar` en modo reconciliación con aprobación. El texto ya
consolidado está en `.ingestas_pendientes/`.
