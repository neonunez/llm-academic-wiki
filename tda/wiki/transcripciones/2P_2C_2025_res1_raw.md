---
tipo: transcripcion
fuente: raw/parciales/2P/2.parcial_2C_2025_resolucion(1).pdf
metodo: claude_vision
nota_examen: desconocida
turno: desconocido
corrector: Dafne Y
fecha_examen: 2025-11-17
---

# Transcripcion — 2P 2C 2025 Resolucion(1)

Corrector: Dafne Y. Nota: no visible en la imagen.

## Informacion del examen

2do Parcial - Tecnica y Diseno de Algoritmos (ex Algo3)
17 de Nov. 2025 - 2do Cuatrimestre
Duracion: 4 horas. Examen individual y a libro cerrado. Nota de aprobacion: 60/100 puntos.

## Ejercicio 1 (16 Puntos) — Multiple choice

Puntajes: Correcto: 4 pts | Incorrecto: -2 pt. Marcar la unica opcion correcta.

### Pregunta I

Dado un grafo $G$ de $n \geq 2$ nodos sin nodos de grado 0, ¿cuales de los siguientes items son condiciones suficientes para que $G$ sea arbol?

A) $G$ tiene exactamente 2 nodos de grado 1 y $n - 1$ aristas
B) $G$ tiene exactamente 2 nodos de grado 1 y sin ciclos
C) $G$ tiene exactamente 2 nodos de grado 1 y es conexo
D) $G$ tiene exactamente 2 nodos de grado 1 y el resto de grado 2

**Respuesta marcada:** no claramente visible en la imagen

### Pregunta II

Para determinar un ciclo con menor cantidad de aristas de un grafo conexo $G = (V, E)$, es posible hallarlo mediante:

a) una unica aplicacion de DFS
b) una unica aplicacion de BFS
c) $\Theta(|V|)$ aplicaciones de DFS, pero no en $O(1)$ aplicaciones
d) $\Theta(|V|)$ aplicaciones de BFS, pero no en $O(1)$ aplicaciones

**Respuesta marcada:** no claramente visible en la imagen

### Pregunta III

Sea $F$ el valor de un flujo en una red $G = (V, A)$ con la funcion de capacidad $c$ definida en $A$ y $S$ un corte ($S \subset N$ y $S \neq \{s\}$, siendo $s$ y $t$ fuente y sumidero de $G$ respectivamente), entonces:

A) $F = w(S)$
B) $F \geq w(S)$
C) $F \leq w(S)$
D) $F \neq w(S)$

**Respuesta marcada:** no claramente visible en la imagen

### Pregunta IV

Un grafo $G$ es autocomplementario si es isomorfo a su grafo complemento. La cantidad de grafos de esta clase con entre 1 y 7 nodos es:

A) 1
B) 2
C) 3
D) 4 o mas

**Respuesta marcada:** no claramente visible en la imagen

## Ejercicio 2 (28 Puntos)

### Enunciado

Sea $G$ un grafo. Sean $v$ y $w$ dos nodos de $G$ tal que $G - v$ es conexo, $G - w$ es conexo, y $G - \{v, w\}$ no es conexo.

(a) Demostrar que existe un ciclo simple (sin nodos ni aristas repetidas) que contenga a $v$ y a $w$. Ayuda: pensar en las componentes conexas de $G - \{v, w\}$. (18 Puntos)

(b) Disenar un algoritmo eficiente que, dados $G$, $v$ y $w$, encuentre un ciclo simple que contenga a $v$ y $w$. Determine y justifique la complejidad temporal. (10 Puntos)

### Respuesta manuscrita — Parte A (paginas 3-4)

(Hoja 1/3)

EJ 2.A:

Sea $G$ un grafo, tenemos:
- $p$: Sean $v$ y $w$ dos nodos de $G$ tq $G-v$ es conexo, $G-w$ es conexo y $G-\{v,w\}$ no es conexo
- $q$: Existe un ciclo simple que contiene a $v$ y a $w$

Queremos demostrar $p \Rightarrow q$, lo vamos a hacer por reduccion al absurdo $p \wedge \neg q \Rightarrow$ ABS.

Asumimos como verdadero $p$ y tambien asumimos que NO existe un ciclo simple que contenga a $v$ y a $w$ ($\neg q$).

Partiendo del grafo $G$, defino a $G' = G - v$ y por $p$ sabemos que $G'$ es conexo. Pero por $p$ tambien sabemos que $G' - w$ NO es conexo. (Que $G'$ sea conexo y que $G' - w$ no lo sea, nos indica que al eliminar a $w$ (y sus aristas incidentes) aumentamos la cantidad de componentes conexas, entonces $w$ tiene al menos una arista incidente en $G'$ tal que esa arista es puente.)

Analogamente, se puede hacer el mismo analisis con $v$ y definiendo $G'' = G - w$.

Hasta aca sabemos que tenemos, como minimo, 2 aristas puente distintas (una por parte de $v$ y otra por parte de $w$) (es decir, una contiene a $v$ y la otra incide en $w$).

[Nota del corrector en rojo: "No necesariamente"]

La pregunta que nos hacemos es ¿como sabemos que estos, al menos dos puentes, estan conectados?
Sabemos que estos puentes unen componentes conexas puesto que $G$ es conexo y $G-\{v,w\}$ no lo es.

[Dibujo mostrando componentes S, v, w, T]

Entonces, independientemente del nodo al que llega el puente que incide en $v$, como estoy llegando a una componente conexa, por definicion de conexo, voy a poder llegar al otro nodo donde arranca el otro puente (el puente por parte de $w$).

Analogamente, puedo hacer el mismo analisis arrancando del puente que incide en $w$.

[Dibujo mostrando dos componentes conexas conectadas por puentes a traves de v y w]

[Nota del corrector en rojo: "El dibujo me dice que no entendiste la propiedad de 'articulacion que hay que demostrar'" y "v y w pueden ser cualquiera de los 4 nodos mostrados, siempre que no formen parte del mismo puente."]

Esto nos indica que tenemos dos caminos distintos porque tenemos, como minimo, dos puentes distintos (notar que el puente $(v,w)$ no puede existir ya que $G-v$ (o $G-w$) no seria conexo), y en caso de que fuera conexo nos indicaria que hay otros puentes que no incidan ni en $v$ ni en $w$ entonces haria que $G-\{v,w\}$ fuera conexo, nos contradiciria con $p$).

Entonces tenemos dos caminos distintos y disjuntos ya que "caminan" por la primer componente conexa no comparte nodo con "caminar" por la segunda componente conexa.

Dos caminos distintos y disjuntos de llegar de $v$ a $w$, por ende, existe un ciclo simple que contiene a $v$ y a $w$... pero esto es ABSURDO porque asumimos $\neg q$.

Por reduccion al absurdo, queda demostrado $p \Rightarrow q$.

**Feedback del corrector (en rojo):** "No termina de cerrar la argumentacion. Usa demo mas constructiva, no por absurdo."

**Calificacion parte A:** R (Regular)

### Respuesta manuscrita — Parte B (pagina 5)

(Hoja 2/3)

EJ 2.B:

El algoritmo tiene que armarse el arbol DFS ejecutandose desde el nodo $v$ (es analogo con $w$) y el ciclo que contiene a $v$ y $w$ va a ser la union de los caminos:
- camino de $w$ hasta la raiz (o sea, $v$) $\cup$
- camino de $x$ hasta $w$, donde $x$ es un nodo que tiene a $w$ como ancestro y tiene una back-edge hacia la raiz (o sea, $v$) $\cup$
- back_edge $(x, v)$

[Dibujo del arbol DFS con $v$ como raiz, $w$ debajo, $x$ mas abajo, backedges formando ciclo. Anotacion: "ciclo simple"]

Algoritmo:
1. Armo el grafo con lista de adyacencia $O(n+m)$
2. Ejecuto DFS desde $v$ (es analogo con $w$) $O(n+m)$
3. Marco todos los nodos del arbol DFS que tienen como ancestro [corrector: "descendiente"] a $w$ $O(n)$
4. Busco en los backedges generados por DFS cuales es la que incide sobre $v$ y sobre algun nodo de los marcados como descendiente de $w$ $O(m)$
5. Devuelvo esa backedge + camino$(x,w)$ + camino$(w,v)$ $O(n)$

Complejidad final: $O(n+m)$

**Calificacion parte B:** B- (Bien minus)

## Ejercicio 3 (28 Puntos)

### Enunciado

En una gran plaza hay $n$ puestos de comida, numerados del 1 al $n$. Cada puesto vende uno o mas de los $k$ ($1 \leq k$) tipos de comida disponibles. En la plaza existen $m$ caminos, que se pueden recorrer en ambos sentidos, y cada camino $i$ conecta dos puestos $u_i$ y $v_i$ ($1 \leq u_i, v_i \leq n$) y se recorre en $s_i$ segundos.

Mao Mao y Luna son dos amigos que actualmente estan en el puesto de comida 1, el unico que esta cerrado hoy y no vende comida. Los amigos quieren recorrer los puestos y reunirse a comer juntos en el puesto $n$. Pero quieren haber comprado, entre ambos, todos los posibles tipos de comida en su trayecto desde el puesto 1 hasta el puesto $n$. Como tienen hambre, quieren hacer eso lo mas rapido posible, asi que deciden ir por caminos separados (no necesariamente disjuntos) y encontrarse en el puesto $n$. Van a comenzar a comer apenas ambos esten en el puesto $n$, y quieren empezar a comer lo antes posible. Cuando pasan por un puesto de comida, pueden comprar instantaneamente todos los tipos de comida que vende ese puesto.

Quieren saber, ¿cual es el tiempo minimo en segundos que deben esperar hasta que ambos esten en el puesto $n$ habiendo comprado entre los dos todos los tipos de comida?

Modelar el problema usando un grafo $G = (V, E)$ y describir los pre- y pos-procesados necesarios, cumpliendo que:

- $(|V| + |E|) \in O(k \cdot 2^k(n + m))$
- Las aristas del grafo $G$ o bien no son ponderadas, o bien tienen pesos no negativos.
- El tiempo de ejecucion del pre-procesado (que construye el grafo $G$) es $\in O(k \cdot 2^k(n + m))$.
- El tiempo de ejecucion del pos-procesado (que convierte la respuesta del algoritmo de grafos aplicado sobre $G$ en la respuesta del problema original) es $\in O(k^2 \cdot 4^k)$. La mejor complejidad que conocemos es $O(k \cdot 2^k)$.
- Aplica un algoritmo de camino minimo o Arbol generador minimo sobre $G$ que resuelva el problema en la mejor complejidad temporal.

### Respuesta manuscrita (paginas 6-7)

(Hoja 3/3)

EJ 3:

Lo voy a modelar con un grafo de estados.

Tengo $n$ puestos, a cada puesto lo voy a poner con $2^k$ estados. Imaginemos que tenemos un "array" de longitud $k$ donde voy "guardando" los tipos de comida que ya pude conseguir a medida que voy avanzando por los puestos.

En el puesto 1 arranco con $[0,0,0,...,0]$ ya que no tengo ninguna comida, luego el resto de los nodos va a ser del orden $O(2^k)$ ya que para cada puesto tengo que poder admitir un $2^k$ estados. Por ejemplo, si me muevo del puesto 1 al 2 y junto el puesto 2 tiene disponible la variedad 1 y 3 de comidas, mi estado de ese nodo va a ser $[1,0,1,0,0,...,0]$ que quiere decir que consegui la comida 1 y 3.

Las aristas van a ser la transicion entre estados, junto con el tiempo asociado a hacer la transicion. Como por cada estado de cada puesto voy a tener que conectarlo con todos los estados de todos los demas puestos y como tengo hasta $k$ variedades voy a tener aristas del orden $O(n \cdot 2^k)$.

Nodos: $O(n \cdot 2^k)$
Aristas: $O(m \cdot k \cdot 2^k)$

[Nota del corrector en verde: "Esta bien pero ¿cual es la condicion para conectar dos nodos con una arista y que peso le asignas a cada una?"]

Hay algunos estados que no podrias conectar...

Luego, voy a crear unos nodos fantasma y conecto bit a bit. A cada nodo fantasma lo voy a conectar con solo 2 nodos de estado y esa conexion solo va a ser si la operacion logica XOR entre los estados da todo 1, ejemplo:
```
  1 0 1 1 0 0
xor 0 1 0 0 1 1
  = 1 1 1 1 1 1  → tengo todas las variedades
```

Con peso 0 en esas aristas. $O(k)$

Luego, ejecuto Dijkstra desde el puesto 1 (que solo el puesto 1 tiene 1 estado) para obtener los caminos minimos desde los puestos a todos los nodos $O(\min\{n^2 \cdot 2^k, (n+m) \cdot \log n, m + n \cdot \log n\})$

[Nota del corrector en rojo: "Es otra la cota para este pobre $(n \cdot 2^{k/2})$"]

Me quedo con la distancia minima y con la inmediatamente anterior de las distancias a mis $k$ nodos fantasma $O(k)$.

Devuelvo como respuesta la inmediatamente anterior a min distancia minima (la 2da minimiza). Me falta la parte de la decision.

[Notas del corrector en verde:
- "Aca calculo que quisiste unir nodos $u_1$ y $u_2$ tales que $C_2 = C_1 \cup u_s$ → lo que se vendria acumulando"
- "# correccion: solo conecto a mis nodos fantasma los estados de mi puesto $N$ que den como resultado XOR todo en 1"
- "En donde se analizan los caminos para Mao Mao y Luna y de los que tardan menos cual es el primero que tiene todas las comidas → pero el modelo esta casi bien"]

**Calificacion:** B- (Bien minus)

## Ejercicio 4 (28 Puntos)

### Enunciado

Luego del exito del torneo anterior los organizadores del torneo de voley TYVA se preparan para hacer una nueva edicion. Esta vez proponen un nuevo sistema por rondas donde en cada ronda de $n$ equipos pasan los $n - 1$ equipos con mejor puntaje, el puntaje ademas satura en $P$ puntos, es decir una vez que un equipo llega a $P$ puntos cualquier punto extra no cuenta para la clasificacion a la siguiente ronda.

Para hacer el torneo mas picante, si un equipo gano demasiado y tiene puntos de sobra puede regalarle algunos de estos a otro equipo pero solo si le ganaron previamente al mismo. Se conoce la lista de partidos $L$ que se jugaron. Para que no sea demasiado desbalanceado ademas se propone un limite $Q$ de puntos que puede recibir en total un equipo en cada ronda.

El equipo de definitivamente no Echu o como acortaremos a $\neg$Echu tiene $K$ puntos y por alguna extrana razon los equipos restantes le tomaron odio y no quieren que pase de la primera ronda por lo cual conspiran para redistribuir los puntos sobrantes entre ellos.

$\neg$Echu hizo los calculos y vio que si se repartieran los puntos sin ninguna de las restricciones entonces su equipo no pasaria a la siguiente ronda.

(a) Ayudar a $\neg$Echu a modelar el problema como un problema de flujo para ver si es posible que su equipo pase, es decir, que no es posible redistribuir los puntajes de forma que todos los equipos tengan mas de $K$ puntos sabiendo que $K < P$ y que se conocen los puntajes iniciales de cada equipo $p_i$.

(b) Justificar por que el modelo es correcto.

(c) Calcular su complejidad.

### Respuesta manuscrita

**Sin respuesta escrita para este ejercicio.**

## Ver también

- [[2P_2C_2025]] — Parcial analizado correspondiente a esta transcripcion
