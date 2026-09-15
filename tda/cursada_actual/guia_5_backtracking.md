---
nombre: Backtracking — guia priorizada de entrenamiento
tipo: material_de_estudio
origen: raw/cursada_2C_2026/guias/guia_5_backtracking.pdf
tipo_documento: guia
temas: [fuerza_bruta_backtracking]
parcial: 1P
programa: 2C_2026
generado: 2026-09-12
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 13
ingestado: false
---

# Backtracking — guia priorizada de entrenamiento

**Fuente:** `raw/cursada_2C_2026/guias/guia_5_backtracking.pdf` · **Tema:** `fuerza_bruta_backtracking` → **1P** (programa 2C_2026)

> La guía fue declarada como `guia` y efectivamente contiene ejercicios, aunque incorpora una introducción formal extensa (ejercicios 1–4). Es material de la cursada vigente: sus ejercicios sin precedente histórico directo se mantienen como 🟡, no se descartan.

## Que busca entrenar la guia

- Especificar un problema como conjunto de candidatas, predicado de validez y, si corresponde, función objetivo.
- Construir soluciones parciales y su árbol de backtracking; pasar de esa especificación a una recurrencia y a una implementación.
- Justificar correctitud —en especial que una poda no elimina soluciones válidas u óptimas— y analizar tiempo y espacio contando el árbol.
- Recuperar una solución, enumerarlas todas, y tratar variantes por subconjuntos, permutaciones, coloreo y matching.

## Plan de trabajo

### Nivel 1 — adquirir la tecnica

- Ej. 1–3 (🟡): formalizá candidatas, válidas y el orden objetivo antes de escribir una recursión.
- Ej. 4 (⚪): hacé el quiz sin mirar apuntes; necesitás distinguir árboles binarios, asignaciones, subconjuntos y permutaciones.
- Ej. 5–8 (🔴): recorré de punta a punta Suma Subconjuntos: árbol, recurrencia, implementación, complejidad y poda.

### Nivel 2 — consolidar

- Ej. 9–10 (⚪): agregá reconstrucción y enumeración a la solución de Suma Subconjuntos.
- Ej. 11 (🔴): usá permutaciones parciales y una poda de factibilidad en MagiCuadrados.
- Ej. 12–13 (🟡 / 🔴): pasá de factibilidad a optimización con cota, y luego resolvé coloreo con chequeo local.

### Nivel 3 — dificultad de parcial

- Ej. 14 (🟡): TSP; explicitá codificación, costo parcial, poda por optimalidad y su condición de pesos no negativos.
- Ej. 15–18 (🔴 / 🟡): resolvé una recurrencia con muchos cortes, matching, ABB óptimo y cadenas de adición. En todos, defendé la cota a partir del árbol y no sólo con una intuición.

### Variantes opcionales

- Ej. 9 y 10 — no abren un patrón nuevo: extienden el Ej. 7–8 de decisión a construcción y enumeración.
- Ej. 4 — diagnóstico de combinatoria; usalo para detectar qué espacio de búsqueda tiene cada ejercicio posterior.

## Seleccion rapida

| Ejercicio | Prioridad | Habilidad | Dependencia | Motivo |
|---|---|---|---|---|
| 1 | 🟡 | Candidatas y validez | — | Fundamento vigente de la especificación. |
| 2 | 🟡 | Modelar un espacio de soluciones | Ej. 1 | Transfiere la formalización a permutaciones. |
| 3 | 🟡 | Función objetivo y orden | Ej. 1 | Base de las podas por optimalidad. |
| 4 | ⚪ | Conteo combinatorio | — | Prerrequisito para cotas; no tiene aparición propia. |
| 5–8 | 🔴 | Árbol, recurrencia, complejidad y poda | Ej. 1, 4 | Coinciden con [[tipos_ejercicio/bt_complejidad_backtracking]]. |
| 9–10 | ⚪ | Reconstruir y enumerar | Ej. 7–8 | Extensión directa, sin señal histórica independiente. |
| 11 | 🔴 | Permutaciones, poda y factoriales | Ej. 2, 4 | Entrena conteo de nodos y poda en un árbol de permutaciones. |
| 12 | 🟡 | Optimización sobre subconjuntos | Ej. 3 | Contenido vigente sin patrón específico indexado. |
| 13 | 🔴 | Coloreo, factibilidad y complejidad | Ej. 1, 4 | Caso general de árbol de BT y chequeo de validez incremental. |
| 14 | 🟡 | TSP y poda por optimalidad | Ej. 3, 4 | El patrón [[tipos_ejercicio/backtracking_tsp]] lo propone, pero su enlace histórico requiere verificación. |
| 15 | 🔴 | Cortes de una cadena y recurrencia | Ej. 4 | Entrena la misma lectura de árbol y cota exponencial. |
| 16 | 🟡 | Matching perfecto con BT | Ej. 1 | Vigente, sin patrón específico indexado. |
| 17 | 🟡 | ABB óptimo | Ej. 3, 4 | Vigente; combina minimización, recurrencia y cota. |
| 18 | 🟡 | Podas de factibilidad y optimalidad | Ej. 3, 4 | Vigente; variante de búsqueda de solución mínima. |

---

## 🔴 Ej. 5–8 — Suma Subconjuntos: el recorrido completo de BT

### Enunciado

Para $C=\{c_1,\ldots,c_n\}$ y $k$, los ejercicios piden construir el árbol de soluciones parciales binarias, demostrar la recurrencia

$$
ssrec(C,k)=
\begin{cases}
k=0 & \text{si } |C|=0,\\
ssrec(C\setminus\{c_n\},k)\lor ssrec(C\setminus\{c_n\},k-c_n) & \text{si } |C|>0,
\end{cases}
$$

implementar `subset_sum`, analizarlo y agregar la poda $j<0$ (más otra poda de factibilidad).

### Que tenes que producir

El árbol binario, una demostración por inducción de la recurrencia, el algoritmo con parámetros `(C,i,j)`, sus cotas temporal y espacial, y la prueba de seguridad de cada poda.

### Que conocimiento presupone

El vector binario de candidatas del Ej. 1 y que un árbol binario de profundidad $n$ tiene $O(2^n)$ nodos.

### Pista de reconocimiento

Cada elemento restante tiene exactamente dos decisiones: incluirlo o no. El estado debe conservar qué prefijo/índice falta decidir y qué suma falta alcanzar.

### Plan de resolucion

1. Interpretá cada prefijo binario como las decisiones ya tomadas.
2. Separá por el último elemento: está elegido o no está elegido.
3. Hacé que la llamada recursiva signifique “existe un subconjunto de los primeros $i$ que suma $j$”.
4. Podá sólo cuando podés probar que ninguna extensión satisface ese significado.

### Resolucion paso a paso

1. Para $C=\{6,12,6\}$, las candidatas son los ocho vectores de $\{0,1\}^3$; las válidas para $k=12$ son $(0,1,0)$ y $(1,0,1)$.
   - **Por que:** cada bit decide inclusión de un elemento, aun cuando haya valores repetidos.
2. Un nodo parcial puede ser el prefijo de bits ya decidido. Sus dos hijos fijan el próximo bit en $0$ y $1$.
   - **Por que:** así las hojas son exactamente todas las candidatas.
3. Definí `subset_sum(C,i,j)` con base `i = 0: return (j == 0)` y, si no, las dos llamadas que excluyen o incluyen `C[i]`.
   - **Por que:** todo subconjunto de los primeros $i$ elementos cae en uno de esos casos excluyentes.
4. Demostrá por inducción en $i$: la hipótesis inductiva da la corrección de ambos subproblemas; el `or` implementa el “existe” sobre los dos casos.
   - **Por que:** no alcanza con que el árbol parezca recorrer opciones: hay que vincular su retorno con la especificación.
5. Sin poda hay a lo sumo $2^n$ hojas y $O(2^n)$ nodos; tiempo $O(2^n)$ con trabajo $O(1)$ por nodo y pila $O(n)$.
   - **Por que:** la altura es $n$ y cada nivel bifurca.
6. Si todos los $c_i$ son naturales, `j < 0` implica que ninguna suma de los elementos restantes puede devolver el faltante a cero. Otra poda segura es `j > sumaRestante(i)`.
   - **Por que:** ambas son condiciones necesarias para que exista una extensión válida; no cambian el peor caso, pero sí el árbol visitado.

### Control del resultado

Para $C=\{6,12,6\}$ y $k=12$, verificá que el árbol sin poda tenga las dos hojas válidas indicadas. Si una rama llega a $j<0$, debe terminar sin retornar una solución.

### Si te trabas

1. Escribí la semántica exacta de `subset_sum(C,i,j)` antes de escribir código.
2. Dibujá las dos ramas que corresponden a $c_i\notin S$ y $c_i\in S$.
3. Para la poda, intentá construir una extensión válida desde un `j<0$`; el supuesto de naturales muestra por qué es imposible.

### Variante que conviene intentar

Cambiar la consulta de existencia por construcción (Ej. 9) y luego por enumeración (Ej. 10), manteniendo un vector parcial que se modifica y se deshace al retroceder.

### Chuleta

> Estado $(i,j)$ → excluir/incluir $C[i]$ → árbol binario de altura $n$ → $O(2^n)$ → podar sólo con una condición necesaria para cualquier extensión.

---

## 🔴 Ej. 11 — MagiCuadrados: permutaciones y poda

### Enunciado

Contar cuadrados mágicos de orden $n$, construir el árbol de soluciones parciales, acotar sus nodos por $O((n^2)!)$ y podar cuando una suma parcial de fila o columna supera el número mágico.

### Que tenes que producir

Una representación celda a celda, el conteo del árbol, el valor del número mágico y la justificación de la poda.

### Que conocimiento presupone

Ej. 2 (candidatas como asignaciones), Ej. 4 (permutaciones) y Ej. 5–8 (poda segura).

### Pista de reconocimiento

Hay que ubicar cada valor de $\{1,\ldots,n^2\}$ una sola vez: el nivel $r$ del árbol corresponde a una permutación parcial de $r$ valores.

### Plan de resolucion

Llená las celdas en un orden fijo. Guardá los valores usados y las sumas parciales de filas/columnas. Compará esas sumas con el objetivo antes de extender.

### Resolucion paso a paso

1. Una candidata es una permutación de $\{1,\ldots,n^2\}$ asignada a las $n^2$ celdas; una parcial fija sólo las primeras celdas del orden elegido.
   - **Por que:** garantiza sin repetidos sin tener que validarlo sólo al final.
2. En el nivel $r$ hay a lo sumo $\frac{(n^2)!}{(n^2-r)!}$ nodos. Por tanto,
   $$\sum_{r=0}^{n^2}\frac{(n^2)!}{(n^2-r)!}\le e\,(n^2)!=O((n^2)!).$$
   - **Por que:** cuenta nodos internos y hojas, no sólo cuadrados terminados.
3. La suma total de los valores es $\frac{n^2(n^2+1)}2$; al repartirla entre $n$ filas, el número mágico es
   $$M=\frac{n(n^2+1)}2=\frac{n^3+n}{2}.$$ 
4. Si una suma parcial de fila o columna supera $M$, cortá esa rama. Al completar una fila/columna, exigí suma exactamente $M$.
   - **Por que:** los valores restantes son naturales, así que una suma que ya excede $M$ no puede disminuir en ninguna extensión.

### Control del resultado

Para $n=3$, comprobá $M=15$ y que el primer nivel tiene nueve elecciones; desde cada una quedan ocho elecciones para la segunda celda.

### Si te trabas

1. No intentes verificar el cuadrado completo en cada nodo: llevá sumas incrementales.
2. Empezá por la cota sin podas; la poda no autoriza mejorar esa cota de peor caso sin una prueba adicional.
3. Revisá que “no superar $M$” basta sólo para ramas parciales; al cerrar una línea hay que exigir igualdad.

### Variante que conviene intentar

Medir en una implementación la diferencia entre poda por suma parcial y poda que además usa $M$ calculado de antemano.

### Chuleta

> Permutación de $n^2$ valores → $O((n^2)!)$ nodos → $M=(n^3+n)/2$ → suma parcial $>M$ implica poda segura.

---

## 🟡 Ej. 12 — MaxiSubconjunto

### Enunciado

Elegir $I\subseteq\{1,\ldots,n\}$ con $|I|=k$ que maximice $\sum_{i,j\in I}M_{ij}$; dar recurrencia, correctitud, complejidades y una poda por optimalidad.

### Que tenes que producir

Una semántica de la función recursiva que diga qué óptimo devuelve para cada solución parcial, y una cota superior que no subestime el trabajo de evaluar candidatos.

### Que conocimiento presupone

Ej. 3 y la diferencia entre factibilidad y optimalidad.

### Pista de reconocimiento

La candidata no es una permutación: es un subconjunto de tamaño fijo. Construir índices en orden creciente evita generar el mismo conjunto varias veces.

### Plan de resolucion

Mantené el conjunto parcial, el próximo índice elegible y su valor acumulado. Al tener $k$ elementos, compará contra el mejor. Para podar, necesitás una cota superior para cualquier completamiento.

### Resolucion paso a paso

1. Representá una candidata como $i_1<\cdots<i_k$; una parcial tiene los primeros índices elegidos.
   - **Por que:** la representación es única para cada subconjunto.
2. Ramificá entre elegir índices posteriores disponibles hasta completar $k$.
   - **Por que:** el árbol enumera exactamente los subconjuntos de cardinalidad $k$.
3. Definí una cota superior para la contribución aún posible. Si `valorActual + cotaSuperior <= mejorValor`, podá.
   - **Por que:** ninguna extensión puede superar al mejor conocido; la correctitud depende de que la cota sea realmente superior.
4. Demostrá por inducción sobre los lugares restantes que el máximo de las ramas devuelve el óptimo de toda extensión.

### Control del resultado

Verificá que una rama con menos de $k$ elementos no se compare como solución final y que la cota no descarte una extensión con valor potencial mayor.

### Si te trabas

1. Antes de programar la poda, resolvé el árbol sin poda.
2. Usá una cota deliberadamente laxa pero indudablemente superior.
3. Separá “valor actual” de “mejor valor global”.

### Variante que conviene intentar

Cambiar “maximizar” por “minimizar” (inciso e) e invertir coherentemente comparación y cota.

### Chuleta

> Subconjuntos de tamaño $k$ en orden creciente → evaluar al completar → podar sólo si una cota superior no supera al mejor.

---

## 🔴 Ej. 13 — Coloreo

### Enunciado

Decidir si un grafo puede colorearse con $k$ colores sin que extremos de una arista compartan color; diseñar BT, poda de factibilidad, complejidad y correctitud.

### Que tenes que producir

Un estado que coloree un prefijo de vértices, una prueba de que el chequeo local permite podar, y una cota basada en hasta $k$ opciones por vértice.

### Que conocimiento presupone

Ej. 1 (validez), Ej. 4 (asignaciones) y Ej. 8 (poda).

### Pista de reconocimiento

Elegir color para el siguiente vértice crea un árbol de aridad a lo sumo $k$. Un conflicto con un vecino ya coloreado no puede arreglarse después.

### Plan de resolucion

Fijá un orden de vértices. Probá cada color permitido para el siguiente; rechazá de inmediato los que igualen el color de un vecino ya fijado.

### Resolucion paso a paso

1. Una candidata es un vector de $|V|$ colores; una parcial colorea los primeros vértices del orden.
2. Para el vértice siguiente, intentá cada color que no genere una arista monocromática con un vecino ya coloreado.
   - **Por que:** esa arista no cambiará en una extensión futura.
3. Si todos los vértices quedaron coloreados, retorná verdadero; si una llamada se queda sin color admisible, falso.
4. La cota bruta tiene $k^{|V|}$ hojas y $O(k^{|V|})$ nodos, más el costo de los chequeos de vecinos.
5. Probá por inducción en la cantidad de vértices no coloreados: las ramas son exactamente las extensiones válidas de la parcial.

### Control del resultado

El grafo de la guía con dos vértices adyacentes del mismo color debe fallar; una asignación donde todas las aristas unen colores distintos debe aceptarse.

### Si te trabas

1. No chequees aristas entre dos vértices todavía sin color.
2. Explicá por qué el conflicto local es irreversible: ésa es la prueba de la poda.
3. Para la complejidad, empezá por “a lo sumo $k$ hijos y profundidad $|V|$”.

### Variante que conviene intentar

Cambiar el orden fijo por elegir primero un vértice no coloreado con más vecinos ya coloreados; es una heurística, no una mejora automática de peor caso.

### Chuleta

> Estado = colores del prefijo → probar hasta $k$ colores → conflicto con vecino ya coloreado = poda de factibilidad → árbol $k$-ario de profundidad $|V|$.

---

## 🟡 Ej. 14 — Viajante de comercio

### Enunciado

Encontrar la permutación $\pi$ que minimiza

$$w(\pi(n),\pi(1))+\sum_{i=1}^{n-1}w(\pi(i),\pi(i+1)),$$

con BT, complejidad y una poda por optimalidad correctamente demostrada.

### Que tenes que producir

La codificación de permutación, el costo parcial, una cota de $O(n!)$ sin podas y la prueba de una poda segura.

### Que conocimiento presupone

Ej. 3, Ej. 4 y la distinción entre una cota de factibilidad y una de optimalidad.

### Pista de reconocimiento

La parcial es el prefijo de un recorrido sin ciudades repetidas; su costo parcial ya suma los arcos recorridos.

### Plan de resolucion

Extendé el prefijo con una ciudad no visitada. Al completar, agregá la arista de regreso. Mantené el mejor costo encontrado y comparalo con el parcial sólo bajo la condición de pesos no negativos.

### Resolucion paso a paso

1. Usá como candidata una permutación de ciudades y como parcial un prefijo sin repetidos.
2. Cada extensión agrega una ciudad no usada y actualiza en $O(1)$ el costo parcial.
3. Sin poda, hay $n!$ permutaciones (o menos si fijás una ciudad inicial) y $O(n!)$ nodos del árbol.
4. Si todos los pesos son naturales, `costoParcial >= mejorCosto` permite podar.
   - **Por que:** cada arista que queda agrega un valor no negativo; ninguna extensión puede bajar el costo parcial.
5. La prueba de correctitud separa las permutaciones por su próxima ciudad: el árbol sin poda las cubre todas, y la poda sólo elimina extensiones incapaces de mejorar la mejor solución.

### Control del resultado

En la matriz del enunciado, evaluá la permutación identidad sumando también el arco de vuelta. Confirmá que no se poda una rama sólo porque sea peor que otra parcial si podría usar pesos negativos: esa condición no está permitida aquí.

### Si te trabas

1. Fijá la primera ciudad para evitar simetrías, pero explicá que no cambia el argumento.
2. No olvides el arco final al comparar soluciones completas.
3. Escribí explícitamente dónde se usa $w\ge0$ en la demostración de poda.

### Variante que conviene intentar

Usar una cota inferior adicional para el costo pendiente; sólo sirve para poda si se demuestra que ninguna extensión puede quedar por debajo de ella.

### Chuleta

> Permutación parcial + costo acumulado → extender con ciudad no usada → $O(n!)$ sin poda → con pesos $\ge0$, costo parcial no puede bajar.

---

## 🔴 Ej. 15 — Palabras en cadena

### Enunciado

Decidir si una cadena puede separarse en palabras válidas, teniendo `palabra(c)` en $O(|c|)$; dar recurrencia, cota y demostración.

### Que tenes que producir

Una disyunción sobre todos los cortes posibles, una cota para sus llamadas y una inducción fuerte sobre la longitud de la cadena.

### Que conocimiento presupone

Ej. 4 y la formulación de recurrencias de Ej. 6.

### Pista de reconocimiento

La primera palabra de una separación válida termina en algún corte $r$; después hay que resolver el sufijo estrictamente más corto.

### Plan de resolucion

Probá cada prefijo no vacío. Si es palabra, recurrí sobre el sufijo; devolvé verdadero si alguna rama funciona.

### Resolucion paso a paso

1. Definí
   $$separar(S)=\bigvee_{r=1}^{|S|}\bigl(palabra(S[1:r])\land separar(S[r+1:])\bigr),$$
   con $separar(\varepsilon)=\text{True}$.
2. La corrección se demuestra por inducción fuerte en $|S|$: toda separación válida tiene un primer corte, y el sufijo correspondiente es menor.
3. Para una cota superior, la exploración de cortes genera un árbol exponencial; una cota segura es $O(|S|\,2^{|S|})$ si se incorpora el costo de `palabra`.
4. Si no existe un corte válido, cada conjunción falla y el `or` retorna falso.

### Control del resultado

Probá una segmentación conocida, como `TDA|es|la|mejor|materia|del|DC`, y una cadena sin descomposición. Verificá que la base de cadena vacía representa “ya se separó todo”.

### Si te trabas

1. Elegí primero el fin de la primera palabra, no todas las particiones a la vez.
2. En la inducción, nombrá el corte de una separación válida.
3. Distinguí el número de nodos del árbol del costo de reconocer una palabra.

### Variante que conviene intentar

Identificar qué estado se repetiría si se memoizara por posición inicial; no implementes PD antes de dominar la versión de BT.

### Chuleta

> Probar cada primer corte → prefijo válido AND sufijo separable → inducción fuerte en longitud → cota exponencial sin memoización.

---

## 🟡 Ej. 16 — Formando parejas

### Enunciado

Decidir si un grafo tiene un apareamiento perfecto; especificar candidatas, parciales, recurrencia, complejidad y poda de factibilidad.

### Que tenes que producir

Una búsqueda que seleccione aristas sin extremos compartidos y que termine sólo cuando todos los vértices estén cubiertos.

### Que conocimiento presupone

Ej. 1, Ej. 5 y la noción de conjunto de aristas sin conflictos.

### Pista de reconocimiento

Elegí un vértice aún no cubierto: en cualquier matching perfecto debe emparejarse con exactamente uno de sus vecinos aún libres.

### Plan de resolucion

Tomá un vértice libre $v$, ramificá por cada vecino libre $u$ de $v$, agregá $(v,u)$ y marcá ambos. Si $v$ no tiene vecino libre, retorná falso.

### Resolucion paso a paso

1. Una candidata es un conjunto de aristas; es válida si no comparte extremos y cubre todo vértice.
2. Una parcial es un matching que cubre algunos vértices.
3. Elegí un vértice no cubierto $v$. Para cada vecino no cubierto $u$, extendé con $(v,u)$.
   - **Por que:** cualquier solución completa debe tomar una de esas aristas para cubrir $v$.
4. Si no hay vecinos libres para $v$, podá.
   - **Por que:** $v$ ya no puede quedar cubierto en ninguna extensión.
5. La inducción sobre vértices sin cubrir prueba que la disyunción de ramas es verdadera exactamente cuando existe un matching perfecto que extiende la parcial.

### Control del resultado

Un número impar de vértices debe fallar: no puede particionarse en pares. También verificá que nunca se agrega una arista con extremo ya cubierto.

### Si te trabas

1. Elegí siempre un vértice libre concreto; no intentes elegir una arista arbitraria del grafo entero.
2. Marcá y desmarcá ambos extremos al bajar y retroceder.
3. La poda se justifica por el vértice libre sin alternativas, no por “parece mala”.

### Variante que conviene intentar

Elegir primero el vértice libre de menor grado; reduce ramas en casos favorables, sin cambiar por sí solo la cota de peor caso.

### Chuleta

> Elegir vértice libre $v$ → emparejarlo con cada vecino libre → sin vecino libre implica poda → cubrir todos implica solución.

---

## 🟡 Ej. 17 — ABB óptimo

### Enunciado

Para frecuencias $f:[n]\to\mathbb N$, buscar el árbol binario de búsqueda que minimiza el costo de accesos; dar recurrencia, cota y demostración.

### Que tenes que producir

Una función cuyo resultado tenga una semántica precisa sobre un intervalo de claves y una demostración de optimalidad por la elección de la raíz.

### Que conocimiento presupone

Ej. 3, mínimos sobre alternativas y demostración inductiva.

### Pista de reconocimiento

La raíz de un ABB con claves en $[i,j]$ puede ser cualquier $r$ del intervalo; al fijarla, los subárboles son intervalos estrictamente menores.

### Plan de resolucion

Para cada posible raíz, combiná el costo de sus dos subárboles con el costo extra que sufren las claves del intervalo. Elegí el mínimo.

### Resolucion paso a paso

1. Para $i>j$, devolvé $0$. Para un intervalo no vacío, considerá cada $r\in[i,j]$ como raíz.
2. El subárbol izquierdo usa $[i,r-1]$ y el derecho $[r+1,j]$; cada clave del intervalo paga un nivel adicional al quedar debajo de la nueva raíz.
3. Tomá el mínimo sobre todas las raíces posibles.
   - **Por que:** todo ABB válido tiene una raíz, y el algoritmo considera esa partición.
4. Probá por inducción sobre el tamaño del intervalo: la hipótesis da optimalidad en ambos subintervalos y el mínimo entre raíces da el óptimo global.
5. Derivá la cota desde la recurrencia que explora raíces y subintervalos; no confundas esta búsqueda sin memoización con la versión de programación dinámica.

### Control del resultado

Para un intervalo de un elemento, el costo debe ser su frecuencia. Para uno vacío, debe ser $0$; ambos casos sostienen la inducción.

### Si te trabas

1. Separá el costo de elegir raíz del costo de los dos subárboles.
2. Escribí primero la semántica: “costo mínimo para todas las claves de $[i,j]$”.
3. No afirmes la complejidad de PD si la recursión todavía recomputa intervalos.

### Variante que conviene intentar

Identificar los pares $(i,j)$ repetidos y comparar después con una solución memoizada.

### Chuleta

> Elegir cada raíz $r$ → resolver intervalos izquierdo/derecho → sumar el costo de bajar niveles → mínimo sobre $r$ → inducción por tamaño de intervalo.

---

## 🟡 Ej. 18 — Cadenas de adición

### Enunciado

Encontrar una cadena creciente $1=x_1<\cdots<x_k=n$ de longitud mínima, donde cada nuevo valor sea suma de dos anteriores; proponer podas de factibilidad y optimalidad.

### Que tenes que producir

Una búsqueda que mantenga una cadena parcial, una mejor cadena encontrada y pruebas separadas para ambas podas.

### Que conocimiento presupone

Ej. 3, Ej. 4 y poda por optimalidad del Ej. 14.

### Pista de reconocimiento

Una extensión válida agrega un número mayor que el último, obtenido como suma de dos valores que ya están en la cadena.

### Plan de resolucion

Empezá con $(1)$. Generá extensiones válidas hasta llegar a $n$; actualizá la mejor si la nueva cadena es más corta. Podá por longitud y por imposibilidad de alcanzar $n$ con los pasos que restan.

### Resolucion paso a paso

1. La parcial es una secuencia creciente que comienza en $1$ y conserva la propiedad de suma para todos sus elementos ya agregados.
2. Generá $x+y$ para pares de valores presentes, quedándote con resultados mayores que el último y a lo sumo $n$.
3. Si se alcanza $n$, compará la longitud con la mejor conocida.
4. Si la parcial ya tiene longitud al menos igual a la mejor, podá.
   - **Por que:** cualquier extensión sólo aumenta la longitud.
5. Para una poda de factibilidad, acotá cuánto puede crecer el máximo si se duplica el máximo actual en cada paso disponible. Si aun esa cota queda bajo $n$, podá.
   - **Por que:** ninguna extensión legal puede crecer más rápido que duplicar el máximo mediante una suma de dos valores existentes.

### Control del resultado

Para $n=6$, verificá que $1<2<4<6$ cumple la propiedad y tiene longitud menor que las dos cadenas alternativas del enunciado.

### Si te trabas

1. Guardá valores ya usados para no volver a generar extensiones idénticas.
2. Diferenciá: longitud demasiado grande es poda de optimalidad; máximo alcanzable demasiado chico es de factibilidad.
3. La poda de factibilidad usa una cota optimista; si esa cota falla, todas las ramas reales fallan.

### Variante que conviene intentar

Probar distintas órdenes de generación y observar cómo una mejor solución temprana fortalece la poda por optimalidad, sin cambiar la corrección.

### Chuleta

> Cadena creciente desde $1$ → agregar suma de dos anteriores → si longitud $\ge$ mejor, podar → si ni duplicando se llega a $n$, podar.

---

## Ejercicios redundantes u opcionales

- **Ej. 4** — diagnóstico de conteo; resolvelo rápido antes de usar sus resultados en cotas.
- **Ej. 9** — construcción de una solución; prolonga Ej. 7.
- **Ej. 10** — enumeración; prolonga Ej. 9 y puede aumentar el trabajo de salida.

## Criterio para considerar dominada la guia

- Puedo escribir para cada problema qué representan candidata, válida y parcial antes de programar.
- Puedo justificar una poda con “ninguna extensión puede…” y no sólo con intuición.
- Puedo contar nodos internos, hojas y trabajo por nodo para defender una complejidad.
- Puedo distinguir árbol binario de subconjuntos, árbol $k$-ario de asignaciones y árbol de permutaciones.
- Puedo demostrar por inducción que una recurrencia cubre todas y sólo las extensiones relevantes.

---

# Apendice — por que estas cosas y no otras

## Evidencia de la seleccion

| Unidad | Nivel | Apariciones | Patron |
|---|---|---|---|
| Ej. 5–8, 11, 13 y 15 | 🔴 | [[parciales_analizados/1P_1C_2024]] Ej. 1 · [[parciales_analizados/1P_2C_2025]] Ej. 6 | [[tipos_ejercicio/bt_complejidad_backtracking]] |
| Ej. 14 | 🟡 | Sin aparición verificable en el parcial enlazado; contenido vigente | [[tipos_ejercicio/backtracking_tsp]] |
| Ej. 1–3, 12 y 16–18 | 🟡 | Sin patrón específico indexado; contenido vigente | — |
| Ej. 4 y 9–10 | ⚪ | Sin aparición propia; prerrequisito o extensión de las unidades críticas | — |

**Base de comparacion:** 6 parciales analizados, 13 patrones en `tipos_ejercicio/`. Para `fuerza_bruta_backtracking` se cargaron los dos patrones del tema y se verificaron los parciales que cita el patrón crítico: [[parciales_analizados/1P_1C_2024]] y [[parciales_analizados/1P_2C_2025]]. El tercer parcial del tema, [[parciales_analizados/1P_1C_2025]], se consultó para el patrón de TSP.

El tema sí tiene patrones compilados, por lo que no fue necesario degradar el cruce a parciales crudos. Los ejercicios vigentes sin coincidencia directa se priorizan como 🟡 según la regla de material de `raw/cursada_2C_2026/`: la falta de precedente no demuestra que no se evalúen.

## Lo que este documento NO cubre y igual toman

- [[tipos_ejercicio/bt_complejidad_backtracking]] — 2 apariciones. Material base adicional en [[fuerza_bruta_backtracking_practica]].
- [[tipos_ejercicio/backtracking_tsp]] — 1 aparición declarada en el patrón. Material relacionado en [[fuerza_bruta_backtracking_guia]].

## Divergencias detectadas

- [[tipos_ejercicio/backtracking_tsp]] declara una aparición en [[parciales_analizados/1P_1C_2025]], pero esa página analizada no contiene una coincidencia textual para `RutaMinima`, `Viajante` ni `TSP`. Por honestidad, el Ej. 14 queda 🟡 por material vigente y no se usa esa aparición como evidencia verificada. Corresponde revisar el patrón o el análisis de parcial con `/ingestar` / mantenimiento; esta nota no modifica la wiki.
