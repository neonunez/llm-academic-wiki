---
nombre: Algoritmos sobre grafos — explicación para comprender la clase
tipo: material_de_estudio
origen: "@raw/cursada_2C_2026/teo/teo_clase2_algo_en_grafos.pdf"
tipo_documento: teorica
temas: [grafos, recorrido_en_grafos]
parcial: 1P
programa: 2C_2026
generado: 2026-08-27
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 13
ingestado: false
---

# Algoritmos sobre grafos — explicación para comprender la clase

La clase parte de una pregunta general: ¿cómo representar y explorar un grafo sin repetir trabajo?
Primero relaciona la representación con el costo de las operaciones; luego muestra que una cola
produce BFS y una pila produce DFS. A partir de esas dos búsquedas construye distancias, bosques,
tiempos, clasificación de aristas y un algoritmo lineal para encontrar puentes.

**Fuente:** `raw/cursada_2C_2026/teo/teo_clase2_algo_en_grafos.pdf` · **Tema:** `grafos` + `recorrido_en_grafos` → **1P** (programa 2C_2026)
**Cómo leer esto:** 🔴 = dominar en profundidad · 🟡 = entender · ⚪ = contexto

> **Colisión de notación.** En BFS, $d[v]$ es la distancia desde la fuente. En DFS, $d[v]$ es el
> tiempo de descubrimiento. Además, $d(v)$ sin corchetes denota el grado de un vértice. El contexto
> decide cuál de los tres significados corresponde.

## El problema que organiza la clase

Un grafo puede tener muchas aristas y no viene con un orden natural para visitar sus vértices. Para
trabajar sobre él hacen falta tres decisiones conectadas:

1. cómo guardar los vecinos para poder recorrerlos eficientemente;
2. cómo administrar la frontera entre lo descubierto y lo todavía no procesado;
3. qué información registrar durante el recorrido para obtener algo más que una lista de vértices.

La clase muestra que una única estructura general de recorrido se especializa al cambiar la
colección de pendientes. Con una **cola** aparecen capas y distancias mínimas; con una **pila**
aparecen llamadas anidadas, tiempos y relaciones ancestro–descendiente. Esa información permite
resolver problemas estructurales como detectar ciclos y aristas de corte.

## Mapa conceptual

- La representación determina cuánto cuesta consultar una arista o recorrer un vecindario.
- Un DAG siempre tiene un vértice de grado de entrada cero; eliminar esos vértices construye un
  orden topológico.
- Una colección de descubiertos pendientes implementa el esquema general de recorrido.
- Una cola procesa la frontera por antigüedad y produce BFS por capas.
- Una pila procesa el descubrimiento más reciente y produce DFS con llamadas anidadas.
- Los tiempos de DFS convierten la anidación en intervalos y permiten reconocer descendientes.
- La clasificación de aristas separa las aristas del bosque de las que vuelven a ancestros.
- En grafos no dirigidos, esa separación permite calcular $low$ y reconocer puentes.

## Conocimientos previos necesarios

- **Grafo y digrafo** — $G=(V,E)$ es no dirigido; en un digrafo cada arco tiene orientación.
- **Vecindario** — $N(v)$ contiene los vecinos de $v$; en un digrafo se distinguen $N^+(v)$ y
  $N^-(v)$.
- **Grados dirigidos** — $d^+(v)$ cuenta arcos salientes y $d^-(v)$ arcos entrantes.
- **Camino y distancia** — $\delta(s,v)$ es la longitud de un camino mínimo de $s$ a $v$, medida en
  cantidad de aristas cuando el grafo no tiene pesos.
- **Árbol, bosque, ancestro y descendiente** — un bosque es una colección de árboles; la relación
  de ancestría depende de la raíz y de las aristas elegidas para el árbol.
- **Cola y pila** — una cola extrae primero lo más antiguo; una pila extrae primero lo más reciente.

---

## 🟡 1. Representar un grafo es elegir el costo de sus operaciones — diapositivas 3–11

### La idea intuitiva

El grafo es el objeto matemático; la lista o la matriz son formas de guardarlo. Cambiar de
representación no cambia qué vértices están unidos, pero sí cuánto cuesta encontrar un vecino,
consultar una arista o borrar un vértice.

### Qué problema resuelve

Antes de afirmar que BFS o DFS cuestan $O(n+m)$ hay que justificar que recorrer todos los vecinos
cuesta lo mismo que recorrer las aristas existentes. Esa afirmación es cierta con listas de
adyacencia, pero no necesariamente con una matriz.

### Definición precisa

Para $V=\{0,\ldots,n-1\}$:

- una **lista de adyacencia** guarda, para cada $v$, los vértices de $N(v)$;
- una **matriz de adyacencia** guarda una celda $A[v,w]$ por cada par de vértices.

| Operación | Listas de adyacencia | Matriz de adyacencia |
|---|---:|---:|
| Espacio | $\Theta(n+m)$ | $\Theta(n^2)$ |
| Consultar si $vw\in E$ | $O(d(v))$ | $O(1)$ |
| Recorrer $N(v)$ | $O(d(v))$ | $O(n)$ |
| Recorrer todas las aristas | $O(n+m)$ | $O(n^2)$ |
| Insertar una arista | $O(1)$ | $O(1)$ |

En un digrafo, $\sum_v |Adj[v]|=m$; en un grafo no dirigido, cada arista aparece en las listas de
sus dos extremos y $\sum_v |Adj[v]|=2m$.

### Cómo funciona

Las listas pagan solamente por las aristas presentes. La matriz reserva las $n^2$ posiciones,
aunque la mayoría represente pares no adyacentes. Por eso la matriz ofrece consulta de adyacencia
en tiempo constante, mientras las listas permiten enumerar todas las aristas en tiempo lineal en
el tamaño real del grafo.

Con pesos, la lista guarda pares $(w,p(v,w))$ y la matriz guarda el peso en $A[v,w]$. Si una arista
puede tener peso cero, la ausencia no puede representarse con $0$: hace falta un valor como `NIL`.

### Ejemplo mínimo

En un camino de $n$ vértices hay $m=n-1$. Las listas ocupan $\Theta(n)$ y permiten recorrerlo en
$\Theta(n)$. La matriz ocupa $\Theta(n^2)$ aunque casi todas sus celdas estén vacías.

### Por qué funciona

La complejidad se obtiene contando entradas almacenadas. Una lista no dirigida contiene exactamente
dos entradas por arista, de modo que recorrer todas las listas cuesta

$$\Theta\!\left(n+\sum_{v\in V}|Adj[v]|\right)=\Theta(n+2m)=\Theta(n+m).$$

### Qué información conserva y cuál pierde

Ambas representaciones conservan la adyacencia. Una tabla hash para cada vecindario puede dar
consulta esperada $\Theta(1)$, pero pierde el orden de los vecinos. Ese orden no modifica las
distancias de BFS, aunque sí puede modificar el árbol concreto que produce BFS o DFS.

### Relación con otros conceptos

- **Necesita:** la distinción entre grafo, arista y vecindario.
- **Da lugar a:** las cotas $O(n+m)$ de BFS, DFS, Kahn y puentes.
- **Se diferencia de:** el algoritmo; la representación es el soporte, no el recorrido.

### Límites y contraejemplos

No existe una representación universalmente mejor. En un grafo muy denso o cuando predominan las
consultas de adyacencia puede convenir la matriz. En un grafo ralo y para recorridos completos,
las listas evitan examinar pares que no son aristas.

### Confusiones frecuentes

- Creer que una matriz es necesaria para BFS; con ella el costo puede subir a $O(n^2)$.
- Contar una arista no dirigida una sola vez al sumar longitudes de listas.
- Usar $0$ como ausencia cuando hay pesos nulos válidos.

### Explicación para nene de 5

Podés guardar tus amigos de dos formas: una lista al lado de cada nombre, o una tabla enorme con
una casilla para cada pareja posible. La lista es pequeña si hay pocos amigos; la tabla permite
mirar una pareja muy rápido, pero tiene muchísimas casillas vacías. Los nombres son los vértices,
los amigos son las aristas, las listas son `Adj[v]` y la tabla es la matriz $A$.

---

## 🟡 2. Ordenamiento topológico — diapositivas 12–17

### La idea intuitiva

Si unas tareas dependen de otras, queremos ponerlas en una fila donde cada requisito aparezca
antes que aquello que lo necesita. Eso es posible exactamente cuando las dependencias no forman
un ciclo.

### Qué problema resuelve

Permite ordenar un digrafo de dependencias y, al mismo tiempo, detectar si un ciclo hace imposible
ese orden.

### Definición precisa

Sea $D=(V,E)$ un digrafo. Un **ordenamiento topológico** es un orden lineal
$v_1,\ldots,v_n$ tal que

$$v_i\to v_j\in E \implies i<j.$$

Dos resultados sostienen el concepto:

> **Lema.** Todo DAG tiene un vértice $v$ con $d^-(v)=0$.

> **Teorema.** Un digrafo admite ordenamiento topológico si y solo si es acíclico.

### Cómo funciona

El algoritmo de Kahn mantiene los grados de entrada y una cola con todos los vértices cuyo grado
es cero. Extrae uno, lo agrega al orden y reduce solamente los grados de sus vecinos salientes.
Cada vecino que llega a grado cero entra en la cola.

```text
ORDEN-TOPOLOGICO(D)
  calcular entrada[v] para todo v
  Q <- vértices con entrada[v] = 0
  L <- lista vacía
  mientras Q no esté vacía:
      u <- desencolar(Q)
      agregar u a L
      para cada v en N+(u):
          entrada[v] <- entrada[v] - 1
          si entrada[v] = 0: encolar(Q,v)
  si |L| < |V|: informar que D tiene un ciclo
  si no: devolver L
```

La versión ingenua vuelve a buscar y eliminar un vértice de grado cero en cada etapa, y cuesta
$O(n(n+m))$. Mantener los grados evita repetir ese trabajo y reduce el costo a $O(n+m)$.

### Ejemplo mínimo

Para $a\to c$ y $b\to c$, tanto $(a,b,c)$ como $(b,a,c)$ son órdenes válidos. La posición relativa
de $a$ y $b$ no está forzada; $c$ sí debe aparecer después de ambos.

### Por qué funciona

Si todo vértice de un digrafo finito tuviera una arista entrante, podríamos caminar hacia atrás
indefinidamente. Como hay finitos vértices, alguno se repetiría y aparecería un ciclo. Por lo tanto,
un DAG tiene un vértice de grado de entrada cero. Quitarlo no crea ciclos, así que el argumento se
repite sobre el digrafo restante.

En la otra dirección, un ciclo exigiría que cada vértice aparezca antes que el siguiente y que el
último aparezca antes que el primero, algo incompatible con un orden lineal.

### Qué información conserva y cuál pierde

El orden conserva todas las precedencias impuestas por las aristas. No fija el orden entre pares
sin dependencia forzada, por lo que puede haber varios órdenes topológicos.

### Relación con otros conceptos

- **Necesita:** DAG, grado de entrada y cola.
- **Se diferencia de:** BFS; ambos usan cola, pero Kahn encola por grado cero y BFS por descubrimiento.
- **Da lugar a:** detección lineal de ciclos dirigidos y planificación de dependencias.

### Límites y contraejemplos

Un digrafo con el ciclo $a\to b\to c\to a$ no admite orden topológico. Si Kahn vacía la cola con
$|L|<n$, los vértices restantes contienen un ciclo.

### Confusiones frecuentes

- Suponer que el orden es único.
- Omitir la verificación final $|L|<n$.
- No aclarar qué significa una arista de dependencia: si $a\to b$ significa “$a$ depende de $b$”,
  el orden operativo puede corresponder al traspuesto.

### Explicación para nene de 5

Para vestirte, primero van las medias y después los zapatos. Ponemos primero todo lo que no espera
a nada y, cuando lo hacemos, quizá otra cosa deje de esperar. Las prendas son vértices, “tiene que
ir antes” es una arista y la caja de cosas listas es la cola de vértices con grado de entrada cero.
Si cada cosa espera a otra en un círculo, nunca hay una primera: ese círculo es un ciclo dirigido.

---

## 🔴 3. BFS: explorar por capas y obtener distancias mínimas — diapositivas 18–30

### La idea intuitiva

BFS expande una onda desde una fuente $s$. Antes de llegar a distancia dos termina con todo lo que
está a distancia uno; antes de llegar a distancia tres termina con la capa dos. La cola impide que
un vértice más lejano se adelante.

### Qué problema resuelve

Calcula alcanzabilidad, distancias mínimas en cantidad de aristas y un árbol que permite reconstruir
un camino mínimo desde $s$ a cada vértice alcanzable.

### Definición precisa

Para un grafo o digrafo sin pesos,

$$L_i=\{v\in V:\delta(s,v)=i\}.$$

BFS registra:

- $d[v]$, distancia calculada desde $s$;
- $\pi[v]$, predecesor de $v$ en el árbol BFS.

Los colores significan: blanco = no descubierto; gris = descubierto y todavía en la frontera;
negro = lista de adyacencia completamente procesada.

```text
BFS(G,s)
  inicializar cada u != s con color blanco, d[u]=infinito, pi[u]=NIL
  color[s]=gris; d[s]=0; pi[s]=NIL
  Q <- <s>
  mientras Q no esté vacía:
      u <- desencolar(Q)
      para cada v en Adj[u]:
          si color[v]=blanco:
              color[v]=gris
              d[v]=d[u]+1; pi[v]=u
              encolar(Q,v)
      color[u]=negro
```

### Cómo funciona

La cola contiene exactamente los vértices grises. Al descubrir un blanco desde $u$, se fija
$d[v]=d[u]+1$ y se lo agrega al final. El color evita descubrirlo por segunda vez. Cuando se extrae
$u$, se examinan todos sus vecinos y finalmente se lo pinta de negro.

### Ejemplo mínimo

Si $s$ está unido a $a$ y $b$, y ambos están unidos a $c$, entonces $a$ y $b$ forman $L_1$ y $c$
forma $L_2$. Según el orden de `Adj[s]`, el padre de $c$ puede ser $a$ o $b$, pero siempre
$d[c]=2$. **El árbol puede cambiar; las distancias no.**

### Por qué funciona

Primero, toda asignación finita representa un camino real: al descubrir $v$ desde $u$ se agrega
una arista a la cadena de predecesores. Por eso

$$d[v]\geq\delta(s,v).$$

La segunda pieza es el **lema de la cola**. Si
$Q=\langle v_1,\ldots,v_r\rangle$, entonces

$$d[v_1]\leq d[v_2]\leq\cdots\leq d[v_r]\leq d[v_1]+1.$$

La cola contiene a lo sumo dos capas consecutivas y procesa distancias en orden no decreciente.
Esto impide que quede sin explorar un camino más corto cuando se fija la distancia de un vértice,
y lleva al teorema

$$d[v]=\delta(s,v).$$

> ⚠️ **Verificar si se exige la demostración formal completa.** El PDF plantea el argumento del
> vértice incorrecto con $\delta$ mínima, pero no cierra esa demostración en las diapositivas; la
> clase remite a Cormen, capítulo 20. La intuición y los lemas anteriores sí están sostenidos por
> el material disponible.

### Qué información conserva y cuál pierde

$\pi$ conserva un solo camino mínimo por vértice, no todos. El orden de vecinos puede elegir otro
predecesor igualmente óptimo. $d$ conserva la longitud mínima, pero no sirve para pesos arbitrarios.

### Relación con otros conceptos

- **Necesita:** listas de adyacencia y cola.
- **Se diferencia de:** DFS, que profundiza y no garantiza caminos mínimos.
- **Da lugar a:** árbol BFS, reconstrucción de caminos, capas, bipartitez y grafos de estado.
- **Generaliza a:** recorridos sobre estados expandidos, siempre que cada transición tenga costo uniforme.

### Límites y contraejemplos

BFS minimiza cantidad de aristas, no suma de pesos. Una arista de peso $100$ y dos aristas de peso
$1$ muestran la diferencia: BFS prefiere una arista, aunque su costo pesado sea mayor.

Una sola BFS tampoco encuentra necesariamente el ciclo más corto global: su garantía está
anclada en la fuente elegida.

### Confusiones frecuentes

- Confundir árbol único con distancias únicas.
- Atribuir al árbol BFS una relación ancestro–descendiente para toda arista.
- Multiplicar el costo por la cantidad de vértices pese a que cada uno se encola a lo sumo una vez.
- Usar BFS directamente con pesos no uniformes.

### Explicación para nene de 5

Tirás una piedra al agua y las ondas llegan primero a lo cercano y después a lo lejano. La piedra
es la fuente $s$, cada ronda de la onda es una capa $L_i$, la cola hace que las rondas salgan en
orden y $d[v]$ dice cuántos saltos hizo la onda hasta $v$. El padre $\pi[v]$ recuerda desde qué
lugar llegó por primera vez.

---

## 🔴 4. DFS: convertir el recorrido en una estructura anidada — diapositivas 31–38

### La idea intuitiva

DFS sigue un camino todo lo que puede. Solo cuando queda sin vecinos nuevos retrocede al último
vértice pendiente. La recursión funciona como una pila: la llamada más reciente debe terminar
antes que la que la creó.

### Qué problema resuelve

Recorre todo el grafo, construye un bosque, registra relaciones de ancestría y deja información
temporal que luego permite razonar sobre ciclos, clasificación de aristas y puentes.

### Definición precisa

DFS registra para cada vértice:

- $\pi[u]$, su padre en el bosque;
- $d[u]$, tiempo de descubrimiento;
- $f[u]$, tiempo de finalización.

Siempre vale

$$1\leq d[u]<f[u]\leq 2|V|.$$

```text
DFS(G)
  inicializar color[u]=blanco y pi[u]=NIL para todo u
  tiempo=0
  para cada u:
      si color[u]=blanco: DFS-VISIT(G,u)

DFS-VISIT(G,u)
  tiempo++; d[u]=tiempo; color[u]=gris
  para cada v en Adj[u]:
      si color[v]=blanco:
          pi[v]=u
          DFS-VISIT(G,v)
  tiempo++; f[u]=tiempo; color[u]=negro
```

Cada llamada iniciada por el bucle exterior crea una raíz; por eso el resultado general es un
bosque y no necesariamente un solo árbol.

### Cómo funciona

Mientras `DFS-VISIT(u)` está activa, $u$ permanece gris. Al llamar recursivamente sobre un vecino,
la llamada de $u$ queda suspendida. Cuando el vecino y todos sus descendientes terminan, el control
vuelve a $u$. Los vértices grises son exactamente la pila activa de llamadas.

### Ejemplo mínimo

En el digrafo $a\to b$, si el bucle exterior comienza por $a$, aparece un árbol con raíz $a$ y
$b$ como hijo. Si comienza por $b$, termina primero un árbol con raíz $b$ y después crea otro con
raíz $a$. El bosque y los tiempos dependen del orden, aunque el grafo sea el mismo.

### Por qué funciona

El color blanco garantiza que `DFS-VISIT` se ejecuta exactamente una vez por vértice. Cada lista de
adyacencia también se recorre una sola vez. Con listas, el costo total es

$$\Theta(|V|+|E|).$$

La pila activa explica la estructura: un gris visto desde el vértice actual no puede ser un vértice
arbitrario; necesariamente es un ancestro cuya llamada todavía no terminó.

### Qué información conserva y cuál pierde

El bosque conserva una historia concreta de descubrimientos, no una estructura única del grafo.
Cambiar el orden del bucle exterior o de las listas puede cambiar raíces, padres, tiempos y tipos
de aristas. DFS preserva relaciones estructurales de esa corrida, pero no distancias mínimas.

### Relación con otros conceptos

- **Necesita:** pila o recursión y colores.
- **Se diferencia de:** BFS, que mantiene una frontera por antigüedad y distancias.
- **Da lugar a:** intervalos, clasificación de aristas, detección de ciclos y cálculo de $low$.

### Límites y contraejemplos

Contar cuántas veces el bucle exterior lanza DFS no define, en un digrafo general, una propiedad
invariante. En $a\to b$ el conteo puede ser uno o dos según el primer vértice considerado. DFS
tampoco garantiza encontrar el ciclo más corto.

### Confusiones frecuentes

- Creer que el `for` exterior multiplica el costo por $|V|$; los visitados son compartidos.
- Interpretar $d[u]$ como distancia en lugar de tiempo.
- Suponer que el bosque es único.
- Confundir un vértice gris con cualquier vértice ya visitado; negro significa que su llamada terminó.

### Explicación para nene de 5

Entrás a un laberinto y seguís siempre por una puerta nueva. Si no hay más puertas, volvés al
último cuarto donde quedaba una opción. Los cuartos son vértices, las puertas son aristas, la pila
de cuartos abiertos son los grises, $d[u]$ anota cuándo entrás y $f[u]$ cuándo terminás de revisar
el cuarto.

---

## 🟡 5. Intervalos y clasificación de aristas — diapositivas 39–46

### La idea intuitiva

Como una llamada recursiva debe terminar antes que su llamadora, los tiempos de DFS se comportan
como paréntesis: los intervalos de dos llamadas se anidan o quedan separados. Esa geometría permite
decidir quién es descendiente de quién y qué papel cumple cada arista.

### Qué problema resuelve

Convierte una ejecución procedural de DFS en relaciones formales que pueden consultarse después:
ancestría, aristas hacia ancestros y aristas entre ramas.

### Definición precisa

Para cada vértice, sea

$$I(u)=[d[u],f[u]].$$

El **teorema de los paréntesis** afirma que, para dos vértices $u,v$, sus intervalos son disjuntos o
uno contiene al otro; nunca se superponen parcialmente. En particular,

$$v\text{ es descendiente propio de }u
\iff d[u]<d[v]<f[v]<f[u].$$

Respecto de un bosque DFS dirigido, una arista $(u,v)$ puede ser:

- **de árbol**, si descubre a $v$;
- **de retroceso**, si vuelve de $u$ a un ancestro;
- **de avance**, si no es del árbol y va a un descendiente propio;
- **de cruce**, en los demás casos.

Al examinar $(u,v)$: blanco implica árbol; gris implica retroceso; negro exige distinguir avance
de cruce mediante los tiempos.

### Cómo funciona

La llamada de un descendiente comienza después que la de su ancestro y termina antes. Por eso su
intervalo queda contenido. Si una llamada empieza después de que otra terminó, los intervalos son
disjuntos.

La regla del color usa el mismo hecho: los grises son las llamadas activas y forman la cadena de
ancestros del vértice actual.

### Ejemplo mínimo

Si $d[u]=1$, $d[v]=2$, $f[v]=3$ y $f[u]=4$, entonces
$1<2<3<4$ y $v$ es descendiente de $u$. En cambio, $I(u)=[1,4]$ e $I(w)=[5,6]$ son disjuntos y
ninguno desciende del otro.

### Por qué funciona

La recursión no permite retornos cruzados: una llamada interna debe terminar antes de reanudar la
externa. Eso descarta intervalos parcialmente superpuestos. En un grafo no dirigido, toda arista
resulta ser de árbol o de retroceso: si el segundo extremo está blanco, la arista lo descubre; si
ya fue descubierto y la arista se examina desde abajo, el otro extremo sigue gris y es ancestro.

### Qué información conserva y cuál pierde

Los intervalos conservan la ancestría del bosque concreto. No describen una ancestría intrínseca
del grafo, porque otro orden de DFS puede producir otro bosque.

### Relación con otros conceptos

- **Necesita:** tiempos y pila activa de DFS.
- **Da lugar a:** detección de ciclos y al algoritmo de puentes.
- **Se diferencia de:** las capas de BFS; los intervalos expresan anidación, no distancia.

### Límites y contraejemplos

La afirmación “solo hay aristas de árbol o retroceso” vale para grafos no dirigidos. En digrafos
pueden existir también aristas de avance y de cruce.

### Confusiones frecuentes

- Clasificar una arista sin fijar la corrida de DFS.
- Usar solamente el color negro para separar avance de cruce.
- Trasladar al caso dirigido el teorema de los dos tipos de aristas.

### Explicación para nene de 5

Abrís una caja, y adentro abrís otra. Tenés que cerrar primero la caja de adentro y después la de
afuera. Cada caja es una llamada DFS y sus momentos de abrir y cerrar son $d[u]$ y $f[u]$. Una caja
adentro de otra representa un descendiente; dos cajas separadas representan ramas sin relación de
ancestría.

---

## 🟡 6. Puentes y el valor `low` — diapositivas 47–58

### La idea intuitiva

Una arista del árbol DFS es puente cuando el subárbol que cuelga debajo no tiene ninguna salida
alternativa hacia arriba. `low` resume hasta qué ancestro puede volver ese subárbol sin usar la
arista que lo conecta con su padre.

### Qué problema resuelve

Encuentra todas las aristas cuya eliminación aumenta la cantidad de componentes conexas, en una
sola DFS y tiempo lineal.

### Definición precisa

Para un grafo no dirigido y un bosque DFS,

$$low[u]=\min\begin{cases}
d[u],\\
d[v] & \text{si }\{u,v\}\text{ es de retroceso hacia un ancestro},\\
low[w] & \text{si }\pi[w]=u.
\end{cases}$$

Equivalente en palabras: es el menor tiempo de descubrimiento alcanzable desde $u$ bajando cero o
más aristas del árbol y usando a lo sumo una arista que no pertenece al árbol.

Para una arista de árbol $uv$ con $\pi[v]=u$:

$$uv\text{ es puente}\iff low[v]>d[u].$$

### Cómo funciona

Al descubrir $u$, se inicializa $low[u]=d[u]$. Cuando termina la visita de un hijo $v$, se propaga
$low[v]$ hacia arriba. Cuando se observa una arista de retroceso hacia $v$, se incorpora $d[v]$.

```text
DFS-PUENTES-VISIT(G,u)
  d[u]=low[u]=++tiempo; color[u]=gris
  para cada v en Adj[u]:
      si color[v]=blanco:
          pi[v]=u
          DFS-PUENTES-VISIT(G,v)
          low[u]=min(low[u],low[v])
      si no, si color[v]=gris y v != pi[u]:
          low[u]=min(low[u],d[v])
  color[u]=negro
```

Después se inspecciona una vez cada vértice no raíz y se aplica
$low[v]>d[\pi[v]]$. La clase también presenta una versión *offline*: primero ejecuta DFS y después
propaga `low` en postorden. Las dos calculan la misma magnitud.

### Ejemplo mínimo

En el camino $a-b-c$, DFS produce esas dos aristas de árbol y no hay retrocesos. Entonces
$low[c]=d[c]>d[b]$ y $low[b]=d[b]>d[a]$: ambas aristas son puentes.

Si agregamos $c-a$, el subárbol de $c$ puede volver a $a$. El valor `low` se propaga hacia arriba y
las aristas del ciclo dejan de satisfacer el criterio.

### Por qué funciona

Toda arista no perteneciente al bosque DFS de un grafo no dirigido está en un ciclo, así que no
puede ser puente. Para una arista de árbol $uv$, si $low[v]\le d[u]$, el subárbol de $v$ tiene una
ruta alternativa que llega a $u$ o más arriba; quitar $uv$ no lo separa. Si $low[v]>d[u]$, no existe
esa salida y $uv$ es la única conexión del subárbol con el resto.

### Qué información conserva y cuál pierde

`low[v]` resume el ancestro más antiguo alcanzable, pero no conserva cuál es el camino alternativo
completo. Para reconstruirlo haría falta registrar información adicional.

### Relación con otros conceptos

- **Necesita:** bosque DFS, aristas de retroceso, tiempos y postorden.
- **Da lugar a:** identificación lineal de puentes.
- **Se diferencia de:** articulaciones; la clase y este PDF desarrollan aristas de corte, no el
  criterio completo para vértices de articulación.

### Límites y contraejemplos

El algoritmo expuesto supone un grafo no dirigido. La condición $v\ne\pi[u]$ es esencial porque
cada arista no dirigida aparece en las listas de ambos extremos. Sin ella, la copia de la arista al
padre se confundiría con una arista de retroceso y ocultaría puentes reales.

### Confusiones frecuentes

- Usar $low[v]\ge d[u]$ en vez de la desigualdad estricta $low[v]>d[u]$.
- Actualizar con $low[v]$ antes de terminar la llamada recursiva del hijo.
- Examinar raíces con el criterio pese a que $\pi[r]=\text{NIL}$.
- Confundir el $d$ temporal de DFS con la distancia de BFS.

### Explicación para nene de 5

Imaginá casas colgadas de un único puente. Desde las casas de abajo buscás si hay otro camino que
vuelva a una casa de arriba. `low[v]` anota qué tan arriba llega esa salida secreta. Si no llega ni
a la casa del padre, la arista al padre es el único puente y, al sacarla, todo lo de abajo queda
separado. Las casas son vértices, el árbol es el bosque DFS y “qué tan arriba” se mide con $d$.

## ⚪ Contexto para leer una vez

- **Esquema general de recorrido — diapositiva 18** — mantener descubiertos pendientes y cambiar la
  estructura: cola $\Rightarrow$ BFS; pila $\Rightarrow$ DFS.
- **Corridas completas de los ejemplos** — sirven para comprobar a mano cómo cambian cola, colores,
  tiempos y `low`; no agregan nuevas definiciones.
- **Subgrafo de predecesores de BFS** — contiene los alcanzables desde $s$ y un camino mínimo único
  dentro del árbol hacia cada uno, aunque el árbol elegido no sea único.
- **Teorema del camino blanco** — $v$ es descendiente de $u$ si y solo si, al descubrir $u$, existe
  un camino de $u$ a $v$ compuesto por vértices blancos. Formaliza por qué DFS absorbe una región
  todavía no descubierta.

---

## Síntesis de la clase

### El hilo completo en pocas palabras

La representación decide el costo de mirar vecinos. Kahn explota grados de entrada cero para
ordenar un DAG. El esquema general de recorrido guarda vértices descubiertos pendientes: una cola
produce BFS y distancias; una pila produce DFS y anidación. Los tiempos de DFS formalizan esa
anidación, permiten clasificar aristas y sostienen el valor `low`. Finalmente, `low` reconoce si un
subárbol tiene una salida alternativa y, por lo tanto, si su arista al padre es puente.

### Definiciones que hay que poder reconstruir

- Orden topológico: $v_i\to v_j\in E\implies i<j$.
- Capas BFS: $L_i=\{v:\delta(s,v)=i\}$.
- Lema de la cola y teorema $d[v]=\delta(s,v)$.
- Bosque DFS, tiempos $d[u]$ y $f[u]$.
- Criterio de descendiente: $d[u]<d[v]<f[v]<f[u]$.
- Aristas de árbol, retroceso, avance y cruce.
- Definición de $low[u]$ y criterio $low[v]>d[\pi[v]]$.

### Relaciones que hay que entender

- Lista de adyacencia $\Rightarrow$ recorrer todas las aristas en $\Theta(n+m)$.
- Grado de entrada cero $\Rightarrow$ próximo vértice posible en un orden topológico.
- Cola $\Rightarrow$ distancias no decrecientes $\Rightarrow$ caminos mínimos sin pesos.
- Pila activa $\Rightarrow$ vértices grises = ancestros activos.
- Pila activa $\Rightarrow$ intervalos anidados.
- Grafo no dirigido $\Rightarrow$ solo aristas de árbol o retroceso en DFS.
- `low` por encima del padre $\Rightarrow$ camino alternativo; `low` debajo del padre $\Rightarrow$ puente.

### Puente hacia la práctica

La representación se transforma en justificar complejidades. El orden topológico se transforma en
modelar precedencias y detectar ciclos. BFS se usa cuando el objetivo depende de cantidad mínima de
pasos o de capas; DFS, cuando depende de la estructura y de relaciones ancestro–descendiente. Los
tiempos y colores permiten justificar detección de ciclos, mientras `low` se convierte en la
herramienta para reconocer puentes en tiempo lineal.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Representaciones | 🟡 | [[parciales_analizados/1P_1C_2024]] Ej. 8, como contraste de complejidad | Sin patrón específico compilado |
| Ordenamiento topológico | 🟡 | [[parciales_analizados/1P_1C_2024]] Problema B | Variante adyacente de [[tipos_ejercicio/grafos_demostraciones]] |
| BFS | 🔴 | [[parciales_analizados/1P_1C_2024]] Ej. 8; [[parciales_analizados/2P_1C_2024]] Ej. 7; [[parciales_analizados/2P_2C_2025]] Ej. 1.II; [[parciales_analizados/2P_1C_2025]] Ej. A3 y B2 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| DFS | 🔴 | [[parciales_analizados/1P_1C_2024]] Ej. 9–10; uso adyacente en [[parciales_analizados/2P_2C_2025]] Ej. 1.II y 2 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Intervalos y clasificación | 🟡 | Variante adyacente del patrón BFS/DFS; back edges en [[parciales_analizados/1P_1C_2024]] Problema B | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Puentes con `low` | 🟡 | Sin aparición directa en los parciales consultados; se eleva por provenir de `raw/cursada_2C_2026/` | Sin patrón específico compilado |

**Base de comparación:** 6 parciales analizados, 13 patrones en `tipos_ejercicio/`.

El índice derivado está poblado. Para los temas `recorrido_en_grafos` y `grafos` se consultaron los
patrones coincidentes y únicamente los parciales citados por ellos. No se releyeron los otros dos
parciales. Representación, orden topológico y puentes no tienen patrón propio: sus niveles no se
inflaron; los dos primeros conservan la evidencia puntual encontrada en los parciales abiertos y
puentes queda 🟡 por ser contenido de la cursada vigente.

> Los rótulos históricos `1P`/`2P` de las apariciones no asignan el parcial actual. Según
> [[programa]], `grafos` y `recorrido_en_grafos` pertenecen al **1P** en 2C-2026.

## Lo que este documento NO cubre y igual toman

- [[tipos_ejercicio/grafos_demostraciones]] — 3 parciales distintos. Incluye demostraciones y
  contraejemplos sobre orientaciones, ciclos, conexidad y otras propiedades estructurales que no
  se reducen a los algoritmos de esta clase. Material en [[grafos_teoria]], [[arboles_teoria]] y
  [[grafos_guia]].
- El patrón [[tipos_ejercicio/bfs_dfs_propiedades]] también incluye aplicaciones que esta clase
  fundamenta pero no desarrolla como unidades propias: ciclo mínimo global, BFS sobre grillas y
  estados expandidos con paridad. Material en [[recorrido_en_grafos_practica]] y
  [[recorrido_en_grafos_guia]].

## Divergencias detectadas

> **Notación de puentes.** La cursada 2C-2026 define `low` sobre tiempos de descubrimiento de DFS y
> usa $low[v]>d[\pi[v]]$. [[recorrido_en_grafos_guia]] usa una formulación sobre niveles del árbol,
> y [[recorrido_en_grafos_practica]] usa el conteo `cubren(v)`. Las tres expresan si el subárbol
> puede volver por encima de su padre, pero la notación vigente es la de este PDF. La divergencia se
> reporta aquí sin modificar ni reconciliar la wiki.
