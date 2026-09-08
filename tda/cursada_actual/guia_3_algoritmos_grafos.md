---
nombre: Algoritmos sobre grafos — guía priorizada de entrenamiento
tipo: material_de_estudio
origen: "@raw/cursada_2C_2026/guias/guia_3_algoritmos_grafos.pdf"
tipo_documento: guia
temas: [grafos, recorrido_en_grafos, arboles]
parcial: 1P
programa: 2C_2026
generado: 2026-09-01
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 13
ingestado: false
---

# Algoritmos sobre grafos — guía priorizada de entrenamiento

**Fuente:** `raw/cursada_2C_2026/guias/guia_3_algoritmos_grafos.pdf` · **Temas:** `grafos`,
`recorrido_en_grafos` y `arboles` → **1P** (programa `2C_2026`)

La guía trabaja dos capas. Los Ej. 1–9 desarrollan representación, propiedades y algoritmos
estructurales de grafos; los Ej. 10–18 aplican DFS y BFS. El programa vigente ubica los tres temas
en el 1P: `grafos`, `arboles` y `recorrido_en_grafos` (BFS/DFS, conexidad, bipartitez, puentes y
orden topológico). La prioridad histórica se calculó solo con patrones existentes y sus parciales;
el símbolo ⋆ de la guía describe una recomendación de la cátedra, no una aparición en un examen.

## Qué busca entrenar la guía

- Elegir representación según las operaciones: listas, listas dinámicas con índices inversos, matriz y hash.
- Analizar complejidad temporal y espacial sin olvidar el costo de inicialización ni el de recorrer vecindarios.
- Reconocer triángulos, ciclos y órdenes topológicos con cotas ajustadas.
- Usar inducción sobre la estructura de un digrafo funcional y partición-refinement para gemelos.
- Entender la caracterización y representación compacta de grafos threshold.
- Convertir DFS en información estructural: árbol, niveles, `low`, puentes y orientaciones fuertes.
- Usar BFS para bipartición, componentes, árboles geodésicos, ciclos mínimos y árboles geodésicos de peso mínimo.
- Distinguir una prueba de correctitud de un algoritmo de la mera descripción de su ejecución.

## Plan de trabajo

### Nivel 1 — adquirir la técnica

- **Ej. 1** — tabla de costos de representaciones de grafos.
- **Ej. 3** — Kahn: orden topológico sin DFS.
- **Ej. 10** — bipartición mediante DFS y recuperación de ciclo impar.
- **Ej. 12** — puentes, árbol DFS y `low`.
- **Ej. 15** — componentes conexas con DFS/BFS.

### Nivel 2 — consolidar

- **Ej. 2** — correctitud y complejidad de detección de triángulos.
- **Ej. 4** — ciclos de digrafos con forma de $\rho$.
- **Ej. 5** — relaciones de gemelos y mellizos y refinamiento de particiones.
- **Ej. 8** — aristas dirigidas sin arco inverso.
- **Ej. 11** — distinguir puentes de puntos de corte.
- **Ej. 16** — árboles BFS y árboles $v$-geodésicos.

### Nivel 3 — dificultad de parcial

- **Ej. 6–7** — caracterización y reconocimiento de grafos threshold.
- **Ej. 13–14** — orientaciones fuertemente conexas y calles bidireccionales.
- **Ej. 17** — ciclo mínimo par mediante múltiples BFS.
- **Ej. 18** — árbol $v$-geodésico de peso mínimo.

### Variantes opcionales

- **Ej. 9** — GeoCuadrados: dejar en pausa hasta verificar el enunciado; tal como está escrito admite contraejemplos inmediatos.
- Implementar los algoritmos de triángulos y comparar casos mejor/peor, como pide el Ej. 2(d).
- **Ej. 7(b)** — reconocer threshold y devolver la representación compacta; es una extensión natural del Ej. 6.
- **Ej. 17(e)** — mejora a $O(n^2)$: el PDF la marca difícil y el material disponible no sostiene una derivación completa.

> **No confundir con el 2P:** esta guía no cubre AGM, caminos mínimos ponderados ni flujo. Los
> árboles de los Ej. 16 y 18 son árboles BFS/$v$-geodésicos, no árboles generadores mínimos.

## Selección rápida

| Ejercicio | Prioridad | Habilidad | Dependencia | Motivo |
|---|---|---|---|---|
| 1 | 🟡 | Representaciones y costos | listas, matriz, hash | Bloque vigente sin patrón específico compilado |
| 2 | 🟡 | Triángulos y complejidad | adyacencia, $m>n$ | Contenido vigente; entrena análisis de algoritmos |
| 3 | 🟡 | Orden topológico | DAG, grado de entrada | Variante adyacente a detección de ciclos; tema vigente |
| 4 | 🟡 | Digrafos funcionales | grado de salida, ciclos | Contenido vigente sin aparición específica compilada |
| 5 | 🟡 | Partición-refinement | vecindarios abiertos/cerrados | Contenido vigente sin patrón compilado |
| 6 | 🟡 | Caracterización threshold | inclusión de vecindarios | Contenido vigente sin patrón compilado |
| 7 | 🟡 | Reconocimiento threshold | Ej. 6, listas/buckets | Contenido vigente sin patrón compilado |
| 8 | 🟡 | Conteo en multigrafos | hash, pares ordenados | Contenido vigente sin patrón compilado |
| 9 | 🟡 | Cuadrado y geodésicos | distancia, vecindarios cerrados | La prioridad de la cátedra no elimina la inconsistencia detectada |
| 10 | 🔴 | Bipartición y ciclo impar | DFS/BFS, árbol generador | Patrón BFS/DFS con 4 apariciones y ejercicio directo |
| 11 | 🔴 | Puentes vs. articulaciones | conectividad, ciclos | Patrón DFS/puentes y aplicación estructural recurrente |
| 12 | 🔴 | `low` y puentes | árbol DFS, niveles | Algoritmo lineal de puentes, patrón recurrente |
| 13 | 🟡 | Orientación fuerte | puentes, DFS | Variante adyacente; sin patrón independiente compilado |
| 14 | 🟡 | Modelado con puentes | orientación fuerte | Transferencia directa del Ej. 13 |
| 15 | 🔴 | Componentes conexas | DFS/BFS, visitados | Aplicación directa del patrón BFS/DFS |
| 16 | 🔴 | Árbol BFS geodésico | BFS, distancias | Patrón BFS/DFS con ejercicio directo en guías históricas |
| 17 | 🔴 | Ciclo mínimo par | BFS, niveles, múltiples fuentes | Variante directa de ciclos mínimos evaluada |
| 18 | 🔴 | Árbol geodésico mínimo | BFS + selección local | Variante directa de árboles BFS y pesos |

---

## 🟡 Ejercicio 1 — Representación de grafos

### Enunciado

Comparar cuatro implementaciones del conjunto de vecindarios $N(v)$ según inicialización,
adjacencia, recorrido, inserción y eliminación de vértices/aristas, y mantenimiento de un orden.

### Qué tenés que producir

Una tabla de complejidades y una explicación del intercambio entre espacio, consultas de adyacencia,
recorrido de vecinos y operaciones dinámicas.

### Conocimiento que presupone

Listas de adyacencia, matriz de adyacencia, grado $d(v)$, hash y suma de grados.

### Pista de reconocimiento

Separá siempre: consultar si existe una arista, enumerar todo $N(v)$ y modificar una estructura.
No tienen el mismo costo.

### Plan de resolución

Tomar $n=|V|$, $m=|E|$ y $d(v)=|N(v)|$. Para cada estructura, contar entradas almacenadas y
cuántas posiciones hay que inspeccionar.

### Resolución paso a paso

1. **Lista de adyacencia simple.**
   - Espacio: $\Theta(n+m)$ en un grafo no dirigido.
   - Inicializar desde vértices y aristas: $\Theta(n+m)$.
   - Consultar $(v,w)$: $O(d(v))$ buscando en la lista.
   - Recorrer $N(v)$: $\Theta(d(v))$.
   - Insertar un vértice con vecinos: $O(1+d(v))$ amortizado si se agrega una posición y se cargan sus vecinos.
   - Insertar una arista: $O(1)$ amortizado al agregarla al final de las listas.
   - Remover una arista: $O(d(v))$ para encontrarla.
   - Remover un vértice: $O(n+m)$ en el peor caso si hay que buscarlo en todas las listas y quitar todas sus incidencias.
   - Ordenar cada vecindario: se puede mantener una lista ordenada, pero insertar/borrar puede costar $O(d(v))$; si no se mantiene, recorrer en orden requiere ordenar.
2. **Lista con índices inversos.** Cada entrada de $w\in N(v)$ guarda la posición de $v$ en $N(w)$.
   - El espacio sigue siendo $\Theta(n+m)$.
   - Consultar y recorrer: $O(d(v))$ y $\Theta(d(v))$, respectivamente.
   - Insertar una arista: $O(1)$ amortizado, agregando las dos entradas y sus índices.
   - Remover una arista: $O(1)$, porque cada extremo conoce la posición de la otra entrada; puede usarse swap con el último elemento.
   - Remover $v$: $O(d(v))$ para quitar $v$ de cada vecino, si el arreglo de vértices se mantiene dinámico sin relabeling global.
   - La información inversa mejora operaciones dinámicas, pero no convierte una lista en una estructura de consulta $O(1)$.
3. **Matriz de adyacencia.**
   - Espacio e inicialización: $\Theta(n^2)$.
   - Consultar, insertar o remover una arista: $\Theta(1)$.
   - Recorrer $N(v)$: $\Theta(n)$, porque hay que inspeccionar toda la fila.
   - Insertar/remover un vértice con una matriz dinámica puede requerir redimensionar y copiar $\Theta(n^2)$; si solo se marca como eliminado, limpiar su fila/columna cuesta $\Theta(n)$.
   - Para mantener los vecinos en orden por etiqueta no hace falta trabajo adicional: se recorre la fila de $0$ a $n-1$, pero se paga $\Theta(n)$ aunque el grado sea bajo.
4. **Hash por vecindario.**
   - Espacio e inicialización esperada: $\Theta(n+m)$.
   - Consultar si $(v,w)$ existe: $O(1)$ amortizado/esperado.
   - Recorrer $N(v)$: $\Theta(d(v))$, aunque el orden no queda garantizado.
   - Insertar o remover una arista: $O(1)$ esperado.
   - Insertar o remover un vértice: $O(d(v))$ esperado si se recorren sus vecinos.
   - Si se exige orden, el hash no alcanza: hay que ordenar al recorrer o usar otra estructura, pagando al menos el costo correspondiente.
5. En un grafo no dirigido vale
   $$\sum_{v\in V}d(v)=2m,$$
   por lo que recorrer todas las listas cuesta $\Theta(n+m)$ y no $\Theta(nm)$.

### Control del resultado

La matriz debe aparecer con espacio $\Theta(n^2)$ y consulta $O(1)$; la lista, con espacio
$\Theta(n+m)$ y recorrido $\Theta(d(v))$; el hash, con consulta esperada $O(1)$ pero sin orden.

### Si te trabás

Completá primero solo estas tres columnas: espacio, consultar arista y recorrer vecindario. Luego
agregá las operaciones dinámicas.

### Variante que conviene intentar

Rehacer la tabla para un digrafo: allí $\sum_v d^+(v)=m$, no $2m$.

### Chuleta

> Lista: poco espacio y recorrer rápido. Matriz: consulta $O(1)$ pero espacio $n^2$. Hash: consulta esperada $O(1)$, sin orden.

---

## 🟡 Ejercicio 2 — Triángulos

### Enunciado

Dados $n$ vértices y $m>n$ aristas, justificar un algoritmo cúbico con matriz y uno cuadrático
con listas para decidir si existe un triángulo; analizar correctitud, complejidad y mejores/peores casos.

### Qué tenés que producir

Dos pruebas de correctitud, las cotas $\Theta(n^3)$ y $\Theta(nm)$, y casos que expliquen cuándo
la salida temprana ayuda.

### Conocimiento que presupone

Matriz/lista de adyacencia, triángulo como $K_3$ inducido y $\sum_vd(v)=2m$.

### Pista de reconocimiento

En el algoritmo cúbico, una triple de vértices determina una posible respuesta. En el cuadrático,
para un $v$ fijo se marcan sus vecinos y se busca una arista entre dos marcados.

### Plan de resolución

Probar primero que cada algoritmo encuentra exactamente un triángulo si lo hay; luego contar la
inicialización, los ciclos y las operaciones de marcado/desmarcado.

### Resolución paso a paso

1. **Algoritmo cúbico: correctitud.** Para una triple distinta $v,w,z$, el producto
   $$A_{vw}A_{wz}A_{vz}=1$$
   si y solo si existen las tres aristas. Eso equivale a que la triple induce un triángulo. Recorrer todas las triples devuelve verdadero exactamente cuando existe alguno.
2. **Algoritmo cúbico: costo.** Construir $A$ cuesta $\Theta(n^2)$. Probar todas las triples cuesta $\Theta(n^3)$ en el peor caso y domina la inicialización. Cota total: $\Theta(n^3)$.
3. **Algoritmo cuadrático: correctitud.** Fijado $v$, quedan marcados exactamente sus vecinos. Si existe una arista $wz$ con ambos extremos marcados, las aristas $vw$, $vz$ y $wz$ forman un triángulo. Recíprocamente, todo triángulo tiene dos vecinos $w,z$ de algún tercer vértice $v$, por lo que el algoritmo lo detecta al procesar ese $v$.
4. **Algoritmo cuadrático: costo.** Para cada $v$, marcar y desmarcar cuesta $O(d(v))$ y recorrer las aristas cuesta $O(m)$. Sumando:
   $$O\left(\sum_vd(v)+nm\right)=O(m+nm)=O(nm).$$
   Como $m>n$, también $O(nm)\subseteq O(m^2)$.
5. **Mejor caso.** Si la estructura de control prueba primero una triple que es triángulo, el algoritmo cúbico puede terminar después de la inicialización en $\Theta(n^2)$; el cuadrático puede terminar tras construir las listas y procesar el primer vértice útil, en $O(n+m+d(v))$.
6. **Peor caso.** Si no hay triángulos o el primero aparece al final del orden, el cúbico revisa $\Theta(n^3)$ triples y el cuadrático procesa todos los $n$ vértices y sus aristas, $\Theta(nm)$.

### Control del resultado

No confundas “hay un camino de longitud dos” con triángulo: hace falta además la arista entre
los dos extremos.

### Si te trabás

Para el algoritmo cuadrático dibujá un vértice central $v$ y preguntá si su vecindario contiene
una arista.

### Variante que conviene intentar

Implementar ambos algoritmos sobre grafos aleatorios y separar el costo de construir la estructura
del costo de buscar el triángulo, como pide la parte (d).

### Chuleta

> Matriz + triples: $\Theta(n^3)$. Listas + vecinos marcados: $\Theta(nm)$. Triángulo = dos vecinos de un mismo vértice unidos entre sí.

---

## 🟡 Ejercicio 3 — Orden topológico sin DFS

### Enunciado

Para un digrafo $D$: (a) demostrar que un DAG tiene un vértice de grado de entrada $0$; (b) construir
un orden topológico sin DFS; (c) probar la equivalencia entre DAG y orden topológico; (d) mejorar a
$O(|V|+|E|)$.

### Qué tenés que producir

El algoritmo ingenuo y la versión de Kahn, ambas con correctitud, complejidad y espacio.

### Conocimiento que presupone

DAG, grado de entrada, cola y definición de orden topológico.

### Pista de reconocimiento

Si todos los grados de entrada fueran positivos, se podría seguir una arista entrante indefinidamente
y, por finitud, aparecería un ciclo.

### Plan de resolución

Probar el lema, eliminar repetidamente vértices de entrada cero y luego reemplazar la búsqueda repetida
por una cola.

### Resolución paso a paso

1. **(a).** Supongamos que el DAG no tiene vértices de entrada cero. Partiendo de cualquier vértice $v_0$, elegimos un predecesor $v_1$; luego un predecesor de $v_1$, y así sucesivamente. Como hay finitos vértices, se repite uno y aparece un ciclo dirigido, contradicción. Existe un vértice de entrada cero.
2. **(b), algoritmo ingenuo.** Repetir: buscar un vértice de entrada cero, agregarlo al final de $L$, eliminarlo y sus aristas salientes. Si quedan vértices pero ninguno tiene entrada cero, reportar ciclo.
3. **Correctitud.** El lema garantiza una elección mientras el grafo restante sea acíclico. Al eliminar $u$, todas sus aristas apuntaban desde una posición anterior hacia vértices restantes; por eso el orden construido respeta cada arista. Si no se puede elegir, el lema aplicado al subdigrafo restante muestra que contiene un ciclo.
4. Si en cada ronda se busca y elimina recorriendo todo el grafo, el tiempo es $O(n(n+m))$ y el espacio adicional $O(n)$, además de la representación.
5. **(c), orden implica DAG.** Por contrarrecíproco: si hay un ciclo $v_1\to v_2\to\cdots\to v_k\to v_1$, el orden exigiría $v_1<v_2<\cdots<v_k<v_1$, imposible.
6. **(d), Kahn.** Calcular `entrada[v]`, poner en una cola todos los vértices con entrada $0$ y, al desencolar $u$, decrementar `entrada[w]` para cada arco $u\to w$; encolar $w$ al llegar a cero. Al final, si $|L|<|V|$, hay ciclo.
7. Cada vértice se encola una vez y cada arco se procesa una vez. Tiempo $O(n+m)$ y espacio adicional $O(n)$, o $O(n+m)$ contando la representación.

### Control del resultado

La condición $|L|<|V|$ no significa solamente “el algoritmo se quedó sin trabajo”: significa que
el subdigrafo restante no tiene entrada cero y, por el lema, contiene un ciclo.

### Si te trabás

Anotá qué grado de entrada cambia al quitar $u$: solo los de sus vecinos salientes.

### Variante que conviene intentar

Comparar Kahn con el orden topológico por DFS de [[recorrido_en_grafos_practica]] y explicar por
qué ambos son lineales, aunque esta consigna prohíbe usar DFS.

### Chuleta

> Entrada $0$ → cola → quitar aristas salientes → los que llegan a $0$ entran → $|L|<n$ implica ciclo → $O(n+m)$.

---

## 🟡 Ejercicio 4 — Ciclos de digrafos con forma de $\rho$

### Enunciado

Un digrafo con loops tiene forma de $\rho$ si todo vértice tiene grado de salida $1. Demostrar que
cada componente conexa subyacente tiene un único ciclo dirigido y encontrar todos los ciclos.

### Qué tenés que producir

Una prueba constructiva de existencia y unicidad, y un algoritmo lineal para todas las componentes.

### Conocimiento que presupone

Grafo subyacente, finitud, grados de entrada/salida y ciclos dirigidos.

### Pista de reconocimiento

Seguí la única arista saliente desde cualquier vértice. La secuencia debe repetir un vértice.

### Plan de resolución

Mostrar existencia siguiendo sucesores; para unicidad usar que una componente con $r$ vértices tiene
exactamente $r$ aristas y, si es conexa, no puede contener dos ciclos subyacentes.

### Resolución paso a paso

1. Sea $v$ un vértice. Como tiene exactamente una salida, definimos $v_{i+1}=succ(v_i)$. La secuencia $v_0,v_1,\ldots$ es infinita dentro de un conjunto finito, así que aparece una repetición $v_i=v_j$ con $i<j$. El segmento entre esas posiciones es un ciclo dirigido; un loop es el caso $i+1=j$ y $v_i=v_j$.
2. Sea $C$ una componente conexa del grafo subyacente, con $r$ vértices. Como cada vértice tiene una salida, el número de aristas contando multiplicidades es $r$. Una componente conexa con $r$ vértices y $r$ aristas tiene exactamente un ciclo subyacente; si tuviera dos, su exceso de aristas sobre un árbol sería al menos dos. Como todo ciclo dirigido es un ciclo subyacente, el ciclo encontrado es único.
3. **Algoritmo.** Calcular grados de entrada. Encolar todos los vértices con entrada $0$. Mientras haya uno, eliminarlo y decrementar la entrada de su único sucesor; si llega a $0$, encolarlo. Los vértices que quedan son exactamente los ciclos: en el subgrafo restante todos tienen salida $1$ y, como la suma de grados de entrada es igual a la cantidad de vértices, todos tienen también entrada $1$.
4. Recorrer los vértices restantes; para cada uno no reportado, seguir sucesores hasta volver al inicio y emitir ese ciclo. Cada vértice y arista se procesa una cantidad constante de veces: $O(n+m)$.

### Control del resultado

Las entradas eliminadas no pueden pertenecer a un ciclo: tienen una cadena que retrocede hacia un
vértice de entrada cero. Los restantes deben quedar como ciclos disjuntos.

### Si te trabás

Pensá en un digrafo funcional: cada vértice apunta a exactamente un sucesor, pero puede recibir
muchas aristas.

### Variante que conviene intentar

Usar DFS con tres colores para detectar ciclos y comparar qué información adicional aprovecha la
eliminación por grados de entrada.

### Chuleta

> Sucesor único + finitud → existe ciclo. En cada componente: $m=n$ → un solo ciclo. Eliminar entrada $0$ → lo que queda son los ciclos.

---

## 🟡 Ejercicio 5 — Gemelos y mellizos

### Enunciado

Definir $N(v)$ y $N[v]$, probar que las relaciones de mellizos ($N(u)=N(v)$) y gemelos
($N[u]=N[v]$) son de equivalencia, justificar el algoritmo de partición en gemelos, implementarlo
en $O(n+m)$ y modificarlo para mellizos.

### Qué tenés que producir

La invariante del refinamiento y qué cambia al pasar de vecindario cerrado a abierto.

### Conocimiento que presupone

Relación de equivalencia, partición, vecindarios y listas de adyacencia.

### Pista de reconocimiento

Dos vértices terminan en la misma clase exactamente cuando nunca fueron separados por un vértice
$ v_i$; eso equivale a tener la misma respuesta de pertenencia para cada $v_i$.

### Plan de resolución

Probar primero equivalencia; después interpretar cada refinamiento como una pregunta booleana sobre
la pertenencia a $N[v_i]$.

### Resolución paso a paso

1. **Mellizos.** Reflexividad: $N(u)=N(u)$. Simetría: la igualdad es simétrica. Transitividad: si $N(u)=N(v)$ y $N(v)=N(w)$, entonces $N(u)=N(w)$.
2. **Gemelos.** El mismo argumento reemplazando $N$ por $N[\,]$. Por eso ambas relaciones inducen particiones.
3. El algoritmo parte de $P_0=\{V\}$. Al procesar $v_i$, cada bloque $W$ se separa en
   $$W\cap N[v_i]\qquad\text{y}\qquad W\setminus N[v_i],$$
   omitiendo los conjuntos vacíos.
4. **Invariante:** después de procesar $v_1,\ldots,v_i$, dos vértices $u,w$ están en el mismo bloque si y solo si
   $$N[u]\cap\{v_1,\ldots,v_i\}=N[w]\cap\{v_1,\ldots,v_i\}.$$
   La base $i=0$ es trivial. En el paso, dos vértices quedan juntos solo si ambos pertenecen o ambos no pertenecen a $N[v_{i+1}]$, que es exactamente agregar la nueva coordenada a la firma.
5. Para $i=n$, las firmas coinciden si y solo si $N[u]=N[w]$. Por lo tanto la partición final es la de gemelos.
6. Para mellizos, usar $N(v_i)$ en lugar de $N[v_i]$; la misma invariante termina caracterizando $N(u)=N(w)$.
7. **Implementación.** Mantener bloques como listas enlazadas y, para cada bloque tocado por el conjunto splitter, separar las entradas marcadas y no marcadas. Con listas de adyacencia se procesan las incidencias de cada vecindario y cada vértice una cantidad acotada de veces; la implementación lineal que conoce la cátedra cuesta $O(n+m)$ y espacio $O(n+m)$. Una implementación ingenua que recorra todos los bloques completos en cada ronda puede ser más lenta y no debe venderse como lineal.

### Control del resultado

En el algoritmo de gemelos, la diagonal importa: $v\in N[v]$ siempre. En el de mellizos, no se
incluye el propio vértice.

### Si te trabás

Pensá cada vértice como una columna de bits: la fila $v_i$ pregunta si cada vértice pertenece a
$N[v_i]$.

### Variante que conviene intentar

Aplicar el algoritmo al diamante, a $C_4$ y a la garra de la figura; verificar las clases descritas
en el enunciado.

### Chuleta

> Refinar por $N[v_i]$ → misma firma completa ⇔ gemelos. Refinar por $N(v_i)$ → mellizos.

---

## 🟡 Ejercicio 6 — Grafos threshold: caracterización

### Enunciado

Para un grafo threshold, demostrar propiedades de vértices con igual grado, existencia de un vértice
aislado o universal, herencia al eliminar vértices, equivalencia con una descomposición threshold y
el criterio de isomorfismo entre dos descomposiciones.

### Qué tenés que producir

Las cinco demostraciones conectadas. La idea central es que la inclusión de vecindarios queda
determinada por el orden de grados.

### Conocimiento que presupone

Vecindario abierto/cerrado, grados, inducción, subgrafo inducido e isomorfismo.

### Pista de reconocimiento

Con igual grado, una inclusión entre conjuntos del mismo tamaño debe ser igualdad. Para la existencia
de aislado/universal, elegí un vértice de grado mínimo y razoná con uno de sus vecinos.

### Plan de resolución

Resolver (a) y (b) primero; usar (b) y (c) para inducir la descomposición; cerrar con la secuencia de
bits de la descomposición.

### Resolución paso a paso

1. **(a).** Si $d(u)=d(v)$, entonces $|N(u)|=|N(v)|$ y $|N[u]|=|N[v]|$. La definición threshold da $N(u)\subseteq N(v)$ o $N[u]\subseteq N[v]$; en ambos casos, por igualdad de cardinalidades, se obtiene igualdad. Luego $u,v$ son mellizos o gemelos.
2. **(b).** Sea $u$ de grado mínimo. Si $d(u)=0$, ya es aislado. Si $d(u)>0$, elegí $v\in N(u)$. Como $d(u)\leq d(v)$, no puede ocurrir $N(u)\subseteq N(v)$: $v\in N(u)$ pero $v\notin N(v)$. Por tanto $N[u]\subseteq N[v]$ y, en particular, $v$ está adyacente a todos los vecinos de $u$ y a $u$.
   Si $v$ no fuera universal, existiría $x$ no adyacente a $v$. Como $u$ es de grado mínimo, $d(u)\leq d(x)$ y la propiedad threshold aplicada a $u,x$ daría una inclusión que fuerza $v\in N(x)$ (porque $v\in N[u]$), contradicción. Por lo tanto existe un vértice universal.
3. **(c).** Al eliminar $v$, los vecindarios de los vértices restantes son los anteriores quitando $v$ cuando correspondía. Las inclusiones $N(u)\subseteq N(w)$ y $N[u]\subseteq N[w]$ se conservan al quitar el mismo elemento. Si el orden de grados se empata o se invierte por la eliminación, el caso de grados iguales del ítem (a) permite volver a elegir la inclusión adecuada. Así $G-v$ sigue siendo threshold.
4. **(d), threshold implica descomposición.** Por (b), $G$ tiene un vértice aislado o universal; eliminarlo deja otro threshold por (c). Aplicar inducción y colocar el vértice eliminado al final: en el subgrafo inducido por el prefijo final es aislado (grado $0$) o universal (grado $i-1$).
5. **Descomposición implica threshold.** Si $v_i$ se agrega como aislado o universal respecto de los anteriores, para cualquier par se puede comparar sus vecindarios según el instante de incorporación. El vértice agregado como universal contiene las adyacencias hacia todo el prefijo; el agregado como aislado no agrega ninguna. Por lo tanto se cumple la inclusión exigida por la definición threshold.
6. **(e).** Sean $v_1,\ldots,v_n$ y $w_1,\ldots,w_n$ descomposiciones con la misma secuencia de decisiones. Para $i<j$, la relación entre $v_j$ y $v_i$ está determinada por si $v_j$ se agregó como universal o aislado; la misma decisión determina la relación entre $w_j$ y $w_i$. Entonces $f(v_i)=w_i$ preserva adyacencias y no adyacencias. Si $G\cong H$ mediante esa función, la afirmación recíproca es inmediata.

### Control del resultado

No confundas “igual grado” con “igual vecindario” en un grafo cualquiera: la igualdad solo se obtiene
porque el grafo es threshold y la definición da inclusiones.

### Si te trabás

Escribí la descomposición como una cadena de bits: `0` = aislado al incorporarse, `1` = universal.

### Variante que conviene intentar

Probar por inducción que la representación por bits determina todas las aristas entre pares de
posiciones distintas.

### Chuleta

> Threshold → aislado o universal → eliminar conserva threshold → secuencia 0/1 → la secuencia determina las adyacencias.

---

## 🟡 Ejercicio 7 — Reconocimiento de grafos threshold

### Enunciado

Proponer una representación de $O(n)$ bits para un grafo threshold y un algoritmo lineal que,
dado un grafo cualquiera, decida si es threshold y devuelva dicha representación.

### Qué tenés que producir

La secuencia de incorporación y una forma de actualizar grados al retirar vértices aislados o
universales.

### Conocimiento que presupone

Descomposición threshold del Ej. 6, listas de adyacencia y colas/buckets.

### Pista de reconocimiento

En cada ronda solo puede retirarse un vértice de grado $0$ o de grado igual al tamaño actual menos $1$.

### Plan de resolución

Retirar vértices en orden inverso de incorporación, guardar un bit por decisión y mantener grados
actualizados.

### Resolución paso a paso

1. **Representación.** Guardar un bit $b_i$ por posición de la descomposición: $b_i=0$ si $v_i$ era aislado respecto del prefijo y $b_i=1$ si era universal. La secuencia ocupa $O(n)$ bits, además de la convención de nombres/orden.
2. Para dos posiciones $i<j$, hay una arista entre $v_i$ y $v_j$ si y solo si $b_j=1$. Así se consulta adyacencia en $O(1)$ a partir de la secuencia.
3. **Reconocimiento.** Mantener el grafo restante, el tamaño $r$ y el grado actual de cada vértice. Una extracción válida es un vértice con grado $0$ o grado $r-1$.
4. Si se extrae $x$ con grado $0$, registrar `0`: no se decrementan grados de otros vértices. Si se extrae $x$ con grado $r-1$, registrar `1` y decrementar en $1$ los grados de sus vecinos restantes.
5. Repetir hasta vaciar el grafo. Si en alguna ronda no existe vértice de grado $0$ ni $r-1$, rechazar: no hay el primer/último paso exigido por la caracterización del Ej. 6.
6. Invertir la secuencia de bits obtenida para recuperar el orden de incorporación.
7. Para lograr $O(n+m)$, mantener buckets o listas de vértices por grado y actualizar solo las incidencias de un vértice universal. Cada arista se elimina y actualiza una sola vez; las comprobaciones de candidatos suman $O(n)$.

### Control del resultado

Al aceptar, reconstruí la secuencia y verificá que cada vértice sea aislado o universal respecto del
prefijo que le corresponde. Si no, hubo un error al invertir el orden.

### Si te trabás

La eliminación empieza por el último vértice de la descomposición, no por el primero.

### Variante que conviene intentar

Reconocer la garra y el diamante y rechazar $C_4$, usando solo la operación de retirar aislados o
universales.

### Chuleta

> Mientras quede grafo: sacar grado $0$ o $r-1$ → guardar bit → actualizar vecinos → invertir bits. Si no hay candidato, no es threshold.

---

## 🟡 Ejercicio 8 — Aristas únicas en multigrafos

### Enunciado

Dado un multigrafo dirigido representado por un multiconjunto de aristas, encontrar (a) aristas no
repetidas y (b) aristas $v\to w$ cuyo inverso $w\to v$ no aparece.

### Qué tenés que producir

Un algoritmo lineal esperado basado en conteo de pares, distinguiendo pares no ordenados de pares
ordenados.

### Conocimiento que presupone

Hash y representación de multiconjuntos.

### Pista de reconocimiento

La arista $(v,w)$ de un grafo no dirigido debe canonicalizarse como $(\min(v,w),\max(v,w))$;
en un digrafo no se puede ordenar los extremos.

### Plan de resolución

Hacer una pasada para contar y otra para filtrar.

### Resolución paso a paso

1. **(a), aristas no dirigidas no repetidas.** Para cada entrada $(v,w)$, formar la clave
   $$k=(\min\{v,w\},\max\{v,w\}).$$
   Incrementar `cantidad[k]` en una tabla hash. En una segunda pasada, devolver las aristas cuya clave tiene conteo $1$. Tiempo esperado $O(m)$ y espacio $O(m)$.
2. **(b), arcos dirigidos sin inverso.** Contar las claves ordenadas $(v,w)$ sin canonicalizar. Para cada arco de entrada $(v,w)$, emitirlo si `cantidad[(w,v)] = 0$. Si la salida debe ser un conjunto de pares, emitir una sola vez por clave; si conserva el multiconjunto, emitir todas sus copias. Ambas variantes son lineales esperadas.
3. Si se exige tiempo determinista, reemplazar la tabla hash por un árbol balanceado y la cota pasa a incluir un factor logarítmico; la guía pide la implementación lineal usual con hashing.

### Control del resultado

En (a), $(v,w)$ y $(w,v)$ cuentan como la misma arista. En (b), $(v,w)$ y $(w,v)$ son claves
diferentes.

### Si te trabás

Probá primero con las entradas $(1,2),(2,1),(1,2)$.

### Variante que conviene intentar

Resolver el mismo problema con sorting: ordenar las claves y recorrer grupos consecutivos.

### Chuleta

> No dirigida: clave ordenada. Dirigida: clave ordenada por dirección. Contar → filtrar.

---

## 🟡 Ejercicio 9 — GeoCuadrados ⚠️ Verificar

### Enunciado

Se define $G^2$ con los mismos vértices que $G$, haciendo adyacentes a $v,w$ si
$N[v]\cap N[w]\neq\varnothing$. La guía afirma que un camino geodésico de longitud al menos $4$
implica que $G^2$ es completo, y luego afirma que un geodésico de longitud al menos $3$ excluye uno
con más de $3$.

### Qué tenés que producir

Antes de demostrar, auditar la afirmación con la definición de $G^2$.

### Conocimiento que presupone

Distancia, camino geodésico y vecindario cerrado.

### Pista de reconocimiento

En un grafo simple, $N[v]\cap N[w]\neq\varnothing$ equivale a $d_G(v,w)\leq2$.

### Plan de resolución

Probar esa equivalencia y buscar un contraejemplo mínimo antes de intentar una demostración.

### Resolución paso a paso

1. Si $x\in N[v]\cap N[w]$, entonces hay un camino de $v$ a $w$ de longitud a lo sumo $2$ pasando por $x$; recíprocamente, un camino de longitud $0$, $1$ o $2$ da un vértice común en los vecindarios cerrados. Por lo tanto
   $$vw\in E(G^2)\iff d_G(v,w)\leq2.$$
2. Tomar $G=P_5$, el camino de cinco vértices. Sus extremos están unidos por un camino geodésico de longitud $4$, pero su distancia es $4$, de modo que no son adyacentes en $G^2$. Por lo tanto $G^2$ no es completo.
3. El inciso (b) también falla tal como está escrito: $P_5$ tiene un camino geodésico de longitud $4\geq3$ y, al mismo tiempo, tiene un geodésico de longitud mayor que $3$.
4. No hay una resolución matemática honesta de los dos incisos sin corregir el enunciado. El material histórico de la wiki ya registra esta misma inconsistencia; se deja como divergencia para que la reconciliación se haga en `/ingestar`, no aquí.

### Control del resultado

Cualquier supuesta prueba debe explicar por qué los extremos de $P_5$ serían adyacentes en $G^2$;
no puede hacerlo porque sus vecindarios cerrados son disjuntos.

### Si te trabás

Escribí $N[v_0]=\{v_0,v_1\}$ y $N[v_4]=\{v_3,v_4\}$ en $P_5$.

### Variante que conviene intentar

Verificar visualmente el PDF fuente para determinar si falta un “no”, una negación o un superíndice en
la afirmación. No usar ninguna de esas correcciones como si ya estuviera confirmada.

### Chuleta

> $N[v]\cap N[w]\neq\varnothing\iff d(v,w)\leq2$. Contraejemplo inmediato: $P_5$.

---

## 🔴 Ejercicio 10 — Grafos bipartitos

### Enunciado

Sea $T$ un árbol generador de un grafo conexo $G$, con raíz $r$. Sean $V$ y $W$ los vértices a
distancia par e impar de $r$. Probar la relación entre aristas no pertenecientes a $T$, ciclos impares
y bipartición; luego diseñar un algoritmo lineal que devuelva una bipartición o un ciclo impar y
generalizarlo a grafos no conexos.

### Qué tenés que producir

Una prueba de (a) y (b), un algoritmo con colores/paridades, recuperación del ciclo impar y la
complejidad $O(n+m)$.

### Conocimiento que presupone

Árbol generador, LCA o padres DFS, niveles y caracterización bipartito $\Leftrightarrow$ sin ciclos impares.

### Pista de reconocimiento

Las aristas de $T$ siempre conectan niveles de paridad distinta. Una arista fuera de $T$ que conecta
la misma paridad cierra un ciclo impar.

### Plan de resolución

Calcular un árbol BFS/DFS y paridades; examinar todas las aristas no árbol y guardar padres para
reconstruir un conflicto.

### Resolución paso a paso

1. En $T$, el único camino entre $v$ y $w$ tiene longitud
   $$\operatorname{nivel}(v)+\operatorname{nivel}(w)-2\operatorname{nivel}(\operatorname{LCA}(v,w)).$$
2. Si $v,w$ tienen la misma paridad, esa longitud es par. Al agregar la arista $(v,w)$, el único ciclo de $T\cup\{(v,w)\}$ tiene longitud par$+1$, es decir, impar.
3. Si toda arista fuera de $T$ une paridades distintas, también las aristas de $T$ unen paridades distintas. Por lo tanto toda arista de $G$ cruza $(V,W)$ y esa pareja es una bipartición.
4. **Algoritmo.** Para cada componente no visitada, iniciar BFS o DFS, asignar `color[r]=0` y al descubrir $u$ desde $x$ asignar `color[u]=1-color[x]$; guardar `parent[u]`.
5. Al examinar $(u,w)$, si los colores son distintos, la arista es compatible. Si son iguales, el grafo no es bipartito. Para devolver un ciclo impar, tomar el camino en el árbol desde $u$ y $w$ hasta su ancestro común y agregar $(u,w)$; eliminar el prefijo común para obtener el ciclo.
6. Si se procesan todas las componentes sin conflicto, devolver
   $$V_0=\{u:color[u]=0\},\qquad V_1=\{u:color[u]=1\}.$$
7. Cada vértice y cada arista se examina una vez. Tiempo $O(n+m)$ y espacio $O(n+m)$ contando el grafo.

### Control del resultado

En una bipartición no puede haber una arista dentro de una clase. Si se devuelve un ciclo, verificá
que sea cerrado, simple después de quitar el prefijo común y de longitud impar.

### Si te trabás

No hace falta que el árbol sea único: cualquier árbol de búsqueda sirve para fijar las paridades.

### Variante que conviene intentar

Resolver una componente con BFS y otra con DFS; comparar la bipartición obtenida y notar que puede
cambiar por inversión de colores, pero la respuesta de bipartitez no cambia.

### Chuleta

> Colorear por paridad → arista misma paridad = ciclo impar → si no hay conflicto, clases par/impar son bipartición → $O(n+m)$.

---

## 🔴 Ejercicio 11 — Puentes vs. puntos de corte

### Enunciado

Para un grafo de al menos tres vértices, decidir si son verdaderas: (a) conexo sin puentes implica
exactamente un ciclo; (b) conexo con exactamente un ciclo implica sin puentes; (c) conexo sin puntos
de corte implica sin puentes; (d) conexo sin puentes implica sin puntos de corte.

### Qué tenés que producir

Valor de verdad, demostración para las verdaderas y contraejemplo para las falsas.

### Conocimiento que presupone

Puente, punto de articulación, ciclo y conectividad.

### Pista de reconocimiento

Una arista pertenece a un ciclo si y solo si no es puente. Un punto de articulación y un puente son
obstrucciones diferentes.

### Plan de resolución

Para cada afirmación buscar el vínculo exacto entre quitar una arista, quitar un vértice y conservar
conectividad.

### Resolución paso a paso

1. **(a) Falsa.** Dos triángulos que comparten un vértice tienen dos ciclos y ninguna arista puente: cada arista pertenece a un triángulo. El vértice compartido sí es articulación, pero eso no contradice la hipótesis de (a).
2. **(b) Falsa.** Tomar un triángulo y agregarle una hoja mediante una arista $vx$. El único ciclo es el triángulo, pero $vx$ es puente porque al quitarla la hoja queda separada.
3. **(c) Verdadera.** Si una arista $uv$ fuera puente, al quitarla se separarían sus extremos en dos partes $A$ y $B$. Si ambas partes tienen al menos dos vértices, quitar $u$ o quitar $v$ deja vértices de ambos lados sin conexión. Si una parte es singleton, su vértice es una hoja y el extremo del puente que está del otro lado es un punto de corte porque $n\geq3$. En todos los casos aparece un punto de corte, contradicción.
4. **(d) Falsa.** El mismo ejemplo de dos triángulos que comparten un vértice no tiene puentes, pero el vértice compartido es punto de corte.
5. Resultado: solo (c) es verdadera.

### Control del resultado

No uses “dos ciclos” como sinónimo de “algún puente”: una arista puede ser puente solo si no
pertenece a ningún ciclo.

### Si te trabás

Compará qué queda desconectado al quitar una arista de un triángulo y al quitar el vértice común
de dos triángulos.

### Variante que conviene intentar

Probar que toda arista de un grafo conexo pertenece a un ciclo si y solo si no es puente.

### Chuleta

> Sin articulación ⇒ sin puente. Sin puente ⇏ sin articulación. Un ciclo puede coexistir con ramas puente.

---

## 🔴 Ejercicio 12 — Puentes y `low`

### Enunciado

Sea $T$ un árbol DFS de un grafo conexo $G$. Probar: (a) puente si y solo si no pertenece a ciclo;
(b) toda arista no árbol une ancestro y descendiente; (c) caracterización de un puente por ausencia
de aristas que cubran el subárbol; (d) algoritmo lineal para todos los puentes.

### Qué tenés que producir

La demostración estructural y el algoritmo con niveles/`low`. La guía usa `nivel`; la teoría vigente
usa tiempos de descubrimiento $d[\,]$ para el mismo criterio estructural.

### Conocimiento que presupone

DFS, ancestro/descendiente, aristas de árbol y de retroceso.

### Pista de reconocimiento

Una arista de árbol $(p,v)$ es puente exactamente cuando el subárbol de $v$ no puede volver a $p$ ni
a un ancestro de $p$ mediante una arista no árbol.

### Plan de resolución

Probar el lema puente-ciclo; usar la propiedad de DFS en grafos no dirigidos; definir `low` en
postorden y comparar con el nivel del padre.

### Resolución paso a paso

1. **(a).** Si $e=vw$ pertenece a un ciclo, el resto del ciclo es un camino alternativo entre $v$ y $w$; quitar $e$ no desconecta. Si $e$ no es puente, al quitarla existe un camino alternativo entre sus extremos; ese camino junto con $e$ forma un ciclo.
2. **(b).** Sea $vw$ una arista no árbol. Cuando DFS procesa uno de sus extremos, el otro no puede ser blanco, porque entonces la arista se habría elegido como arista de árbol. En un grafo no dirigido tampoco puede ser un vértice ya terminado de otra rama sin que la arista se hubiera procesado antes desde allí. Por lo tanto el otro extremo estaba activo: es ancestro del extremo actual.
3. **(c).** Supongamos $nivel(v)\leq nivel(w)$. Si $vw$ es puente, por (a) no está en un ciclo; por (b), una arista no árbol entre esos extremos cerraría un ciclo, así que $vw$ debe ser arista de árbol. Si $v$ no fuera el padre de $w$, el camino de árbol entre ellos, junto con $vw$, formaría un ciclo; luego $v=padre(w)$.
4. La arista $(v,w)$ no es puente si existe una arista desde $w$ o un descendiente de $w$ hacia $v$ o un ancestro de $v$: junto con los caminos de $T$ forma una ruta alternativa. Si no existe tal arista, el subárbol de $w$ solo se conecta con el resto mediante $(v,w)$ y esta es puente.
5. **(d), `low`.** Para cada vértice $w$ definir
   $$low[w]=\min\left( nivel[w],\ \{nivel[x]:(y,x)\text{ es back edge desde el subárbol de }w\},\ \{low[c]:c\text{ hijo de }w\}\right).$$
   Con la notación vigente, reemplazar `nivel` por el tiempo de descubrimiento $d[\,]$ y mantener el mismo criterio.
6. En DFS, al volver del hijo $w$ a su padre $v$:
   $$ (v,w)\text{ es puente}\iff low[w]>nivel[v].$$
   Si $low[w]\leq nivel[v]$, el subárbol de $w$ alcanza a $v$ o más arriba y existe ciclo alternativo; si es mayor, no puede salir del subárbol sin esa arista.
7. El algoritmo hace una sola DFS, calcula `low` en postorden, marca cada arista que satisface el criterio y cuesta $O(n+m)$.

### Control del resultado

No marques una arista de retroceso como puente. Para cada arista de árbol, la comparación es con el
nivel/tiempo del padre, no con el del propio vértice.

### Si te trabás

Preguntá: “¿el subárbol de $w$ puede volver al padre de $w$ o más arriba sin usar $(v,w)$?”.

### Variante que conviene intentar

Escribir la versión con la función `cubren` de [[recorrido_en_grafos_practica]] y traducirla a
`low`; la guía vigente usa niveles y la teoría vigente usa tiempos de descubrimiento.

### Chuleta

> DFS → `low` en postorden → puente $(v,w)$ si $low[w]>nivel[v]$ (o $d[v]$ vigente) → $O(n+m)$.

---

## 🟡 Ejercicio 13 — Orientaciones fuertemente conexas

### Enunciado

Para un árbol DFS $T$, definir $D(T)$ orientando aristas de árbol padre→hijo y aristas no árbol
hacia el ancestro. Probar la equivalencia entre existencia de orientación fuertemente conexa,
ausencia de puentes y fuerte conexidad de $D(T)$, y dar un algoritmo lineal.

### Qué tenés que producir

La cadena de implicaciones y el procedimiento para construir la orientación cuando existe.

### Conocimiento que presupone

Puentes, `low`, árbol DFS y fuerte conexidad dirigida.

### Pista de reconocimiento

Los puentes son la única obstrucción: cualquier orientación de un puente deja un sentido imposible.
Las aristas de un ciclo permiten volver hacia arriba.

### Plan de resolución

Probar primero que una orientación fuerte no puede tener puentes; después usar `low` para mostrar que
$D(T)$ permite subir a la raíz; la bajada siempre se hace por aristas de árbol.

### Resolución paso a paso

1. **Orientación fuerte implica no puentes.** Si $e$ fuera puente, al quitarla el grafo se separaría en dos partes. Cualquiera sea su orientación, no habría camino dirigido de la parte posterior a la parte anterior sin usar $e$ en el sentido inverso.
2. **Sin puentes implica $D(T)$ fuerte.** Desde la raíz se alcanza cualquier vértice siguiendo aristas de árbol hacia abajo. Para volver desde un vértice $x$ hacia la raíz, si $x$ no es raíz la arista padre-hijo no es puente; por el criterio de `low`, el subárbol de $x$ tiene una arista de retroceso hacia un ancestro del padre. Desde $x$ se baja por el árbol hasta el extremo de esa retroceso y se la sigue hacia arriba. Repitiendo por inducción en el nivel, se alcanza la raíz.
3. Si todo vértice alcanza la raíz y la raíz alcanza todo vértice, cualquier par $x,y$ se conecta mediante $x\leadsto r\leadsto y$; por lo tanto $D(T)$ es fuertemente conexo.
4. Si existe un árbol DFS cuyo $D(T)$ es fuerte, ese $D(T)$ ya es una orientación fuerte; la implicación hacia existencia es inmediata.
5. **Algoritmo.** Ejecutar DFS y calcular `low`. Si aparece un puente, informar que no existe orientación fuerte. Si no aparece ninguno, orientar las aristas de árbol hacia abajo y las retrocesas hacia arriba. La salida es $D(T)$ y cuesta $O(n+m)$.

### Control del resultado

La orientación de una arista no árbol debe ir del descendiente al ancestro. La orientación inversa
puede destruir la ruta de retorno a la raíz.

### Si te trabás

Probá primero un ciclo: orientarlo todo en el mismo sentido es fuerte; probá luego un puente y observá
que una dirección siempre queda bloqueada.

### Variante que conviene intentar

Reutilizar la misma DFS del Ej. 12: no hagas una segunda búsqueda solo para orientar.

### Chuleta

> Robbins: orientación fuerte ⇔ sin puentes. DFS + `low`; árbol abajo, back edges arriba.

---

## 🟡 Ejercicio 14 — Orientación de calles

### Enunciado

Dado un grafo conexo de calles bidireccionales, orientar la mayor cantidad posible manteniendo
accesibilidad desde cualquier esquina hacia cualquier otra; minimizar las calles que quedan
bidireccionales en $O(n+m)$.

### Qué tenés que producir

El modelo dirigido, el mínimo inevitable de calles bidireccionales y un algoritmo lineal.

### Conocimiento que presupone

Orientaciones fuertes, puentes y `low`.

### Pista de reconocimiento

Una calle puente debe quedar bidireccional; una calle que no es puente puede orientarse con $D(T)$.

### Plan de resolución

Encontrar puentes, mantenerlos en ambos sentidos y aplicar la orientación del Ej. 13 al resto.

### Resolución paso a paso

1. Modelar esquinas como vértices y calles como aristas. “Llegar desde cualquier esquina a cualquier otra” significa fuerte conexidad del digrafo resultante.
2. Si una calle es puente, al orientarla en un solo sentido separa las dos partes para el sentido inverso. Por eso toda solución debe dejar cada puente bidireccional.
3. Ejecutar DFS con `low` y marcar puentes en $O(n+m)$.
4. Orientar las aristas no puente como en $D(T)$: aristas de árbol padre→hijo y aristas no árbol descendiente→ancestro. Mantener cada puente en ambos sentidos.
5. Dentro de cada bloque sin puentes, la orientación es fuertemente conexa; los puentes bidireccionales permiten atravesar el árbol de bloques en ambos sentidos. Así el grafo final es fuertemente conexo.
6. Es óptimo porque ninguna solución puede orientar en un solo sentido un puente; el algoritmo deja bidireccionales exactamente las calles inevitables.
7. Tiempo $O(n+m)$ y espacio $O(n+m)$.

### Control del resultado

Verificá que no quede ningún puente orientado en un solo sentido y que las aristas no puente sigan
la clasificación del árbol DFS.

### Si te trabás

Resolver primero el caso sin puentes: allí todas las calles pueden orientarse.

### Variante que conviene intentar

Aplicar el algoritmo al grafo de dos triángulos unidos por un puente: solo esa unión queda doble.

### Chuleta

> Puentes bidireccionales obligatorios; resto según $D(T)$; cantidad mínima = cantidad de puentes.

---

## 🔴 Ejercicio 15 — Componentes conexas

### Enunciado

Escribir un programa que determine en tiempo lineal la cantidad y el tamaño de las componentes
conexas de un grafo. Decidir si también puede hacerse con DFS.

### Qué tenés que producir

Un recorrido completo del grafo, un contador de componentes y el tamaño asociado a cada raíz.

### Conocimiento que presupone

BFS/DFS, vector de visitados y listas de adyacencia.

### Pista de reconocimiento

Una nueva BFS/DFS solo se inicia desde un vértice todavía no visitado; esa raíz identifica una
componente nueva.

### Plan de resolución

Recorrer el arreglo de vértices, iniciar BFS o DFS en cada blanco y contar cuántos vértices visita.

### Resolución paso a paso

1. Inicializar `visitado[v]=false`, `cantidad=0` y una lista de tamaños.
2. Para cada vértice $s$: si ya está visitado, continuar; si no, incrementar `cantidad`, iniciar una BFS o DFS desde $s$ y poner `tam=0$.
3. Cada vez que se descubre un vértice, marcarlo y aumentar `tam`; recorrer todos sus vecinos y encolar/recursar solo los no visitados.
4. Al terminar la búsqueda, guardar `tam`. Esa búsqueda visitó exactamente la componente de $s$: todo vértice alcanzable desde $s$ se descubre, y no puede salir de la componente porque no hay aristas entre componentes.
5. El algoritmo funciona idénticamente con DFS; solo cambia la estructura de frontera: cola para BFS, pila/recursión para DFS.
6. Cada vértice se marca una vez y cada arista se examina una vez (dos veces si el grafo es no dirigido, una por extremo). Tiempo $O(n+m)$ y espacio $O(n)$ adicional.

### Control del resultado

La suma de los tamaños debe ser $n$. Si no, se omitió una raíz o se contó dos veces un vértice.

### Si te trabás

El bucle exterior no “repite” una componente ya visitada: el vector de visitados lo evita.

### Variante que conviene intentar

Guardar también la etiqueta `componente[v]` para devolver a qué componente pertenece cada vértice.

### Chuleta

> Por cada blanco: BFS/DFS, contar visitados, guardar tamaño. Cada vértice y arista una vez → $O(n+m)$.

---

## 🔴 Ejercicio 16 — Árboles $v$-geodésicos

### Enunciado

Demostrar que todo árbol BFS de $G$ enraizado en $v$ es $v$-geodésico y dar un árbol
$v$-geodésico que no pueda ser producido por ningún BFS desde $v$.

### Qué tenés que producir

La igualdad de distancias para el árbol BFS y un contraejemplo que use la dependencia entre padres
de dos vértices del mismo nivel.

### Conocimiento que presupone

BFS, niveles, árbol de predecesores y distancia sin pesos.

### Pista de reconocimiento

BFS asigna a cada vértice un padre en el nivel anterior; lo importante es que el árbol conserve el
nivel correcto, no que exista un árbol BFS único.

### Plan de resolución

Probar $d_T(v,w)=d_G(v,w)$ usando la correctitud de BFS; luego impedir una elección de padres que
BFS no puede hacer por el orden de procesamiento.

### Resolución paso a paso

1. Sea $T$ el árbol de predecesores de BFS desde $v$. BFS descubre un vértice $w$ con valor
   $$d[w]=d_G(v,w).$$
2. El camino de $v$ a $w$ en $T$ tiene exactamente tantos saltos como el nivel de $w$, es decir,
   $$d_T(v,w)=d[w]=d_G(v,w).$$
   Esto vale para todos los vértices alcanzables; como $G$ es conexo, para todos.
3. **Contraejemplo.** Tomar vértices $\{v,a,b,c,d\}$ y aristas
   $$va,vb,ac,bc,ad,bd.$$
   Desde $v$, $a,b$ están en nivel $1$ y $c,d$ en nivel $2$.
4. Definir $T$ con aristas $va,vb,ac,bd$. Sus distancias desde $v$ son $1,1,2,2$, así que es $v$-geodésico.
5. Pero ningún BFS puede producirlo: si procesa primero $a$, descubre tanto $c$ como $d$ y ambos quedan con padre $a$; si procesa primero $b$, ambos quedan con padre $b$. No puede producir simultáneamente $parent(c)=a$ y $parent(d)=b$.

### Control del resultado

El árbol contraejemplo debe ser generador, tener la distancia correcta desde $v$ a cada vértice y
fallar específicamente la condición de orden de descubrimiento de BFS.

### Si te trabás

Separá dos afirmaciones: “es geodésico” depende de niveles; “es producido por BFS” depende del
orden en que se procesan los vértices.

### Variante que conviene intentar

Construir otro contraejemplo permutando $c$ y $d$ o intercambiando los roles de $a$ y $b$.

### Chuleta

> BFS fija niveles óptimos; el árbol no es único. Un árbol puede respetar niveles y aun así exigir padres incompatibles con un único orden BFS.

---

## 🔴 Ejercicio 17 — Ciclo mínimo par

### Enunciado

Suponiendo que el ciclo mínimo de $G$ es par, caracterizarlo mediante BFS: un ciclo mínimo de
longitud $2k$ produce un vértice de nivel $k$ visitado por dos caminos; diseñar un algoritmo
$O(nm)$ y estudiar la mejora difícil a $O(n^2)$.

### Qué tenés que producir

La caracterización y el algoritmo basado en BFS desde cada vértice. La mejora (e) queda marcada para
verificación separada porque el material disponible no contiene una derivación completa.

### Conocimiento que presupone

BFS, niveles, caminos mínimos y recuperación de padres.

### Pista de reconocimiento

Dos caminos distintos de igual longitud desde una fuente hasta un mismo vértice forman un ciclo al
unirse en su último punto de divergencia.

### Plan de resolución

Probar primero los dos sentidos locales de la caracterización y después enumerar todas las fuentes.

### Resolución paso a paso

1. Sea $C$ un ciclo mínimo de longitud $2k$ y sea $v$ uno de sus vértices. Los dos recorridos sobre $C$ desde $v$ hasta el vértice opuesto $u$ tienen longitud $k$.
2. Ninguno puede ser reemplazado por un camino más corto sin producir, junto con uno de los dos tramos del ciclo, un ciclo menor que $2k$. Por lo tanto $d_G(v,u)=k$ y existen dos caminos mínimos distintos de $v$ a $u$.
3. En BFS desde $v$, ambos caminos llegan al nivel $k$; según la implementación, $u$ puede ser descubierto por dos vecinos distintos del nivel $k-1$, es decir, recibe más de un candidato/predecesor o es “visitado dos veces” en el sentido de la consigna.
4. Recíprocamente, si BFS desde $v$ encuentra dos caminos distintos de longitud $i\leq k$ hasta $u$, tomar el último vértice común de ambos y unir sus tramos divergentes produce un ciclo de longitud a lo sumo $2i\leq2k$.
5. Si el menor ciclo del grafo es par y se toma el primer nivel donde aparece esa duplicación, la longitud del ciclo obtenido es exactamente el mínimo, $2k$.
6. **Algoritmo $O(nm)$.** Para cada fuente $v$, correr BFS, conservar niveles y detectar cuándo un vértice recibe dos caminos mínimos distintos. Actualizar la mejor longitud $2i$. Una BFS cuesta $O(n+m)$; repetir para todos los vértices cuesta $O(n(n+m))$. Como el grafo conexo tiene $m\geq n-1$, esto es $O(nm)$.
7. Para reconstruir el ciclo, conservar dos padres distintos de $u$ y remontar ambos caminos hasta su último antecesor común.
8. **Parte (e).** ⚠️ Verificar: el PDF pide una mejora a $O(n^2)$, pero el material consultado no sostiene una derivación completa y no se inventa aquí.

### Control del resultado

No devuelvas la primera duplicación sin comparar niveles: el objetivo es el ciclo mínimo. Verificá que
el ciclo reconstruido sea simple y que su longitud sea par.

### Si te trabás

En un ciclo par, el vértice opuesto está a la mitad de las dos rutas desde la fuente elegida.

### Variante que conviene intentar

Implementar BFS con dos predecesores por vértice en vez de “visitar” dos veces un vértice ya marcado.

### Chuleta

> BFS desde cada fuente → duplicación en nivel $k$ → dos caminos mínimos → ciclo $2k$ → costo $n(n+m)=O(nm)$.

---

## 🔴 Ejercicio 18 — Árbol geodésico de peso mínimo

### Enunciado

Dado un grafo conexo con pesos y un vértice $v$, encontrar en $O(n+m)$ el árbol de menor peso
entre todos los árboles $v$-geodésicos.

### Qué tenés que producir

Un BFS para fijar niveles y una selección de padre mínimo para cada vértice, junto con una prueba de
que las elecciones son independientes.

### Conocimiento que presupone

BFS, árboles geodésicos y pesos de aristas.

### Pista de reconocimiento

En cualquier árbol $v$-geodésico, el padre de un vértice de nivel $i$ debe estar en el nivel $i-1$.

### Plan de resolución

Separar la restricción de distancias —sin pesos— del objetivo de minimizar la suma de pesos.

### Resolución paso a paso

1. Correr BFS desde $v$ ignorando los pesos y obtener $dist[x]=d_G(v,x)$.
2. Para cada $w\neq v$, considerar solo los vecinos $u$ que cumplen
   $$dist[u]=dist[w]-1.$$
   Esas son exactamente las aristas que pueden ser padre de $w$ en un árbol $v$-geodésico.
3. Elegir entre esos vecinos el que minimiza el peso $p(u,w)$ y agregar $(u,w)$ al árbol.
4. La elección es válida: cada arista elegida baja exactamente un nivel, por lo que desde $v$ hasta $w$ hay un camino de longitud $dist[w]$. BFS ya garantiza que ninguna ruta en $G$ puede ser más corta.
5. La elección es óptima: todo árbol $v$-geodésico debe elegir para cada $w$ un padre de nivel $dist[w]-1$; el costo total es la suma de una arista elegida para cada $w$, sin restricciones entre elecciones de vértices distintos. Elegir el mínimo local en cada conjunto minimiza la suma global.
6. BFS cuesta $O(n+m)$ y el escaneo de las listas para buscar el mínimo también cuesta $O(n+m)$. Total $O(n+m)$.

### Control del resultado

El árbol debe tener exactamente $n-1$ aristas, una entrante para cada vértice salvo $v$, y cada
padre debe estar un nivel más cerca de $v$.

### Si te trabás

Primero olvidá los pesos y dibujá las capas BFS; recién después elegí la arista más barata que baja
una capa.

### Variante que conviene intentar

Si hay empates de peso, elegir cualquier mínimo: el árbol puede no ser único, pero el peso óptimo sí.

### Chuleta

> BFS sin pesos → para cada $w$, vecinos del nivel anterior → elegir arista mínima → $n-1$ aristas, $O(n+m)$.

---

# Ejercicios redundantes u opcionales

- **Ej. 9** — además de no tener precedente histórico compilado, contiene una afirmación que falla en $P_5$; no debe resolverse memorizando la interpretación de la guía histórica.
- **Ej. 10 y Ej. 12** — comparten la infraestructura DFS/BFS y el razonamiento de árbol más aristas no árbol, pero entrenan salidas distintas: bipartición/ciclo impar frente a puentes.
- **Ej. 13 y Ej. 14** — el Ej. 14 es una aplicación del teorema del Ej. 13; resolver primero el 13 y usar el 14 como transferencia.
- **Ej. 17(e)** — está marcado difícil; conservarlo como desafío separado hasta contar con una derivación verificable de la mejora a $O(n^2)$.
- **Ej. 2(d)** — la implementación y el benchmark son útiles, pero no agregan una técnica teórica nueva después de dominar las cotas.

## Criterio para considerar dominada la guía

- Puedo elegir lista, matriz, hash o lista con índices inversos según la operación que domina.
- Puedo justificar por qué los algoritmos de triángulos cuestan $\Theta(n^3)$ y $\Theta(nm)$.
- Puedo construir un orden topológico sin DFS, demostrar su correctitud y detectar ciclos con $|L|<n$.
- Puedo reconocer la estructura de un digrafo funcional y extraer sus ciclos por eliminación de entrada cero.
- Puedo explicar la invariante de refinamiento de gemelos y cambiarla de $N[v]$ a $N(v)$.
- Puedo reconocer un grafo threshold, devolver sus bits y consultar adyacencia desde esa representación.
- Puedo distinguir puente de punto de corte y obtener todos los puentes con `low` en una sola DFS.
- Puedo orientar un grafo sin puentes de manera fuertemente conexa y justificar qué calles deben quedar bidireccionales.
- Puedo calcular componentes con DFS o BFS en $O(n+m)$.
- Puedo demostrar que un árbol BFS es geodésico y construir un geodésico que no sea árbol BFS.
- Puedo detectar bipartitez y devolver una bipartición o un ciclo impar.
- Puedo encontrar el ciclo mínimo par con BFS desde cada fuente y justificar $O(nm)$.
- Puedo construir el árbol geodésico de peso mínimo seleccionando padres por nivel.
- Puedo detectar y reportar que los Ej. 9 y 17(e) requieren verificación adicional, sin inventar una solución.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Ej. 10 — bipartición, ciclo impar y BFS/DFS | 🔴 | `1P_1C_2024` Ej. 8–9; `2P_1C_2024` Ej. 7; `2P_2C_2025` Ej. 1.II; `2P_1C_2025` A3 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Ej. 11–12 — puentes y propiedades de DFS | 🔴 | `1P_1C_2024` Ej. 8–9; `2P_1C_2024` Ej. 7; `2P_2C_2025` Ej. 1.II; `2P_1C_2025` A3 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Ej. 15 — componentes conexas | 🔴 | `1P_1C_2024` Ej. 8–9; `2P_1C_2024` Ej. 7; `2P_2C_2025` Ej. 1.II; `2P_1C_2025` A3 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Ej. 16 — árbol BFS y distancias | 🔴 | `1P_1C_2024` Ej. 8–9; `2P_1C_2024` Ej. 7; `2P_2C_2025` Ej. 1.II; `2P_1C_2025` A3 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Ej. 17 — ciclo mínimo por BFS | 🔴 | `1P_1C_2024` Ej. 8–9; `2P_1C_2024` Ej. 7; `2P_2C_2025` Ej. 1.II; `2P_1C_2025` A3 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Ej. 18 — selección sobre árboles BFS | 🔴 | `1P_1C_2024` Ej. 8–9; `2P_1C_2024` Ej. 7; `2P_2C_2025` Ej. 1.II; `2P_1C_2025` A3 | [[tipos_ejercicio/bfs_dfs_propiedades]] |
| Ej. 3–4 — topológico y ciclos | 🟡 | variantes de propiedades/ciclos en `1P_1C_2024` Ej. 5–7, `2P_2C_2025` Ej. 2 y `2P_1C_2025` A1 | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 10 — ciclo impar y bipartición | 🟡 | `1P_1C_2024` Ej. 5–7, `2P_2C_2025` Ej. 2 y `2P_1C_2025` A1 | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 1–2, 5–9, 13–14 | 🟡 | sin patrón específico compilado; contenido de la guía vigente, que eleva el contenido nuevo a 🟡 | — |

**Base de comparación:** 6 parciales analizados, 13 patrones en `wiki/tipos_ejercicio/`.
El patrón de BFS/DFS tiene 4 exámenes citados y el patrón de demostraciones sobre grafos tiene
3 exámenes citados. Los rótulos históricos `1P`/`2P` no se usaron para reasignar el material:
según `programa.md`, todos estos temas corresponden al 1P vigente.

## Lo que este documento NO cubre y igual toman

- [[tipos_ejercicio/grafos_demostraciones]] — 3 apariciones históricas (`1P_1C_2024`,
  `2P_2C_2025` y `2P_1C_2025`). La guía cubre varias demostraciones de ese patrón, pero no
  todos sus casos: orientaciones acíclicas de $K_n$, sumideros y caminos hamiltonianos aparecen
  en [[grafos_guia]].
- No se considera cubierto el desafío de mejora del Ej. 17(e): la guía lo menciona, pero no hay
  una solución verificable en el material disponible.

## Divergencias detectadas

- **Ej. 9, GeoCuadrados:** con la definición escrita, $vw\in E(G^2)$ si y solo si
  $d_G(v,w)\leq2$. El camino $P_5$ refuta directamente que un geodésico de longitud $\geq4$
  vuelva $G^2$ completo y también refuta el inciso (b). El material histórico de
  [[grafos_guia]] ya había dejado esta inconsistencia abierta. No se resuelve aquí.
- **Ej. 12, notación de puentes:** la guía vigente formula el criterio con `nivel`, mientras la
  teoría vigente de [[recorrido_en_grafos_teoria]] usa tiempos de descubrimiento $d[\,]$; se
  reporta la diferencia, no se modifica ninguna página canónica.
- **Ej. 17(e):** el PDF solicita una mejora a $O(n^2)$, pero la extracción y las páginas de wiki
  consultadas sostienen el algoritmo $O(nm)$, no la mejora. Queda como ⚠️ Verificar.
- **Ej. 7:** la cota lineal requiere una implementación cuidadosa de buckets/partición; una
  implementación ingenua de la definición puede ser superlineal. La cota declarada se conserva
  como objetivo de la guía, no como costo de cualquier pseudocódigo directo.
