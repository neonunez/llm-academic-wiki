---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_1C_2025_resolucion(1).pdf
metodo: claude_vision
nota_examen: 75/100
turno: Manana
materia: TDA
---

# Transcripcion — 1P 1C 2025 Resolucion(1)

Corrigio: Rora. Nota: 75/100.

## Seccion 1: Preguntas de opcion multiple

Cada pregunta tiene 4 opciones y una sola opcion correcta. Correctas (Bien) suman 5 puntos. Incorrectas (Mal) restan 2 puntos. No respondidas no se consideran incorrectas y suman 0 puntos.

### Pregunta 1

Sea la siguiente funcion recursiva que calcula el numero combinatorio $\binom{N}{K}$:

$$\binom{N}{K} = \begin{cases} 1, & \text{si } k = 0 \lor k = n \\ 0, & \text{si } k < 0 \lor k > n \\ \binom{N-1}{K-1} + \binom{N-1}{K} & \text{si no} \end{cases}$$

Cual es la complejidad temporal de calcular $\binom{N}{K}$ utilizando Programacion Dinamica?

**Respuesta marcada:** $\Theta(N \cdot K)$ [CORRECTA]

### Pregunta 2

Dado un grafo con N nodos y M aristas. Cual es la complejidad espacial de la representacion como matriz de adyacencia?

**Respuesta marcada:** $\Theta(N^2)$ [CORRECTA]

### Pregunta 3

Si en la representacion de un grafo de N nodos (1 a N) y M aristas como lista de adyacencia, reemplazo los vectores que contienen a los vecinos de cada nodo por tablas hash (*) (ej: unordered_set en C++, HashSet en Rust, dict en Python), podre:

- Poder recorrer los vecinos de un nodo v dado en orden ascendente en $O(d(v))$
- Tener complejidad espacial $O(N)$
- Saber si dos nodos u y v son vecinos en $\Theta(1)$
- Saber si dos nodos u y v tienen vecinos en comun en $O(\log(N))$

(*) Durante el parcial no se responderan consultas sobre lo que es una tabla hash.

**Respuesta:** NO RESPONDE (anotacion manuscrita: "No responde")

### Pregunta 4

Dado el digrafo con 5 nodos y aristas: $(1,2), (1,3), (2,4), (3,4), (4,5)$. Cual de los siguientes es un recorrido de DFS valido?

**Respuesta marcada:** $1-2-4-5-3$ [CORRECTA]

### Pregunta 5

Dado un grafo dirigido con nodos del 1 al N, donde el nodo i ($1 \leq i \leq N$) tiene asociado un string $s_i$ (todos los $s_i$ son no vacios y distintos) en el cual hay una arista $(i, j)$ si y solo si $s_j$ es un sufijo de $s_i$. Cual de las siguientes afirmaciones es falsa?

- De un nodo i pueden salir a lo sumo $|s_i|$* aristas
- El grafo tiene bucles (pares $(i,i)$) — anotacion manuscrita: checkmark
- El grafo es transitivo
- El grafo puede tener ciclos dirigidos simples con mas de un nodo

(*) $|s|$ es la cantidad de caracteres de $s$

**Respuesta marcada:** "El grafo puede tener ciclos dirigidos simples con mas de un nodo" [CORRECTA — es la falsa]

Anotacion manuscrita: "puede ser palindromo", "si sj es sufijo de Si"

### Pregunta 6

Si represento a una funcion recursiva $f$ (que al computarla no genera una recursion infinita) como un grafo dirigido donde cada uno de los N nodos es un estado y una arista $(a, b)$ significa "La funcion se llama a si misma con el estado $b$ para procesar el estado $a$". Cual de las siguientes afirmaciones es correcta?

- Puede haber ciclos en el grafo
- Siempre podemos calcular la funcion $f$ para todos los estados en $O(N)$
- Los casos base tienen grado de entrada 0
- Llamar a la funcion con el estado $x$ generara tantas llamadas al estado $y$ como caminos hay de $x$ a $y$ en el grafo

**Respuesta marcada:** "Llamar a la funcion con el estado $x$ generara tantas llamadas al estado $y$ como caminos hay de $x$ a $y$ en el grafo" [CORRECTA]

Anotacion manuscrita sobre opcion 2: "dirigidos"

### Pregunta 7

La relacion entre los nodos de un grafo no dirigido definida como $R(a, b)$ si y solo si $a$ y $b$ pertenecen a la misma componente conexa, es:

**Respuesta marcada:** "Una relacion de equivalencia" [CORRECTA]

### Pregunta 8

La complejidad espacial de la memorizacion de una DP con $N$ estados y $M$ transiciones entre estados, implementada de forma top-down recursiva, es:

**Respuesta marcada:** $\Theta(N)$ [CORRECTA]

## Seccion 2: Preguntas abiertas de respuesta corta

Respuesta Bien: +5 puntos. Respuesta Regular, Mal o sin completar: +0 puntos.

### Pregunta 9

En el algoritmo de DP de Floyd Warshall visto en clase, que se calcula en cada estado de la DP?

**Respuesta manuscrita:** "B. El estado esta determinado por i, j y k, y calcula el camino minimo de i a j tomando solo los nodos intermedios desde i hasta K, siendo i, j y k nodos."

### Pregunta 10

En el algoritmo de DP de Bellman Ford visto en clase, que se calcula en cada estado de la DP?

**Respuesta manuscrita:** "El estado esta determinado por i y calcula el camino minimo desde el origen hasta el nodo i. Solo vale en las ultimas iteraciones."

### Pregunta 11

Sea $G$ un grafo dirigido (digrafo) donde los nodos son los numeros de la 1 a N y existe una arista $(a, b)$ si y solo si existe un numero primo $p$ tal que $b = a \cdot p$. Que significa que exista un camino de $u$ a $v$ en $G$?

**Respuesta manuscrita:** "B. Significa que $v = u \cdot p_1 \cdot p_2 \cdot ... \cdot p_k$, es decir que $v$ es un multiplo de $u$ y ademas $v$ es un producto de $u$ por tantos primos como nodos intermedios tiene el camino (si pasa por K-1 nodos intermedios, mas el nodo $v$ tendre K primos multiplicando $u$), ya que el nodo $v$ 'aporta' un primo tambien."

### Pregunta 12

Indique un orden topologico valido del siguiente grafo dirigido aciclico: [grafo con nodos 1-9]

Aristas visibles: $6 \to 2$, $6 \to 3$, $2 \to 1$, $1 \to 7$, $4 \to 2$, $4 \to 9$, $3 \to 4$, $5 \to 3$, $5 \to 8$, $8 \to 9$ (entre otras)

**Respuesta manuscrita:** $6 \to 1 \to 5 \to 2 \to 3 \to 4 \to 9 \to 7 \to 8$

"B. El 6 se hace primero, luego el 1 y asi sucesivamente siguiendo las flechas hasta el 8."

## Seccion 3: Ejercicios a Desarrollar

Ejercicio Bien: +10 puntos. Ejercicio Regular: +5 puntos. Ejercicio Mal o sin completar: +0 puntos.

### Pregunta 13

Dado un grafo dirigido $G = (V, E)$ con nodos numeros de 1 a N. Se tiene asociado a cada nodo $v$ un peso $p_v$ entero positivo. Se pide disenar un algoritmo o utilizar uno existente que en $O(N^3)$ (espacial y temporal) determine cada par ordenado de nodos $(u, v)$ si es posible llegar de $u$ a $v$ en el digrafo dado y, si es posible, determinar el menor peso $P$ tal que es posible llegar utilizando como nodos intermedios (sin contar $u$ ni $v$) solo a nodos con un peso menor o igual a $P$.

**Respuesta:** NO RESPONDE (anotacion: "No responde")

### Pregunta 14

Dado un cubo de Rubik, definimos el estado del Cubo como una posicion definida por el color de cada celda que hay en cada cara (cada cara tiene un identificador que permite diferenciarlas). El cubo se considera resuelto si cada cara tiene unicamente celdas de un mismo color. Una jugada valida consiste en rotar una cara del cubo 90 grados en sentido horario o anti-horario.

Se pide modelar el cubo con un grafo donde:
A) Cada nodo represente un estado del cubo.
B) La distancia entre dos nodos $u$ y $v$ sea igual a la cantidad de jugadas necesarias para convertir el estado representado por $u$ en el estado representado por $v$.

**Respuesta manuscrita (paginas 5-6):**

R14) Cada cara tiene un identificador y tomare en cuenta que dado el identificador puedo saber cual cara tengo a derecha, izquierda, arriba y abajo (si no puedo asumir esto lo construiria yo mismo de manera sencilla, ya que al tener un cubo Rubik cada cara va en un lugar especifico y puedo para cada cara, guardar en una tupla (por ejemplo) la cara que tiene a der, izq, arriba y abajo respectivamente). Esto ya esta hecho al momento de modelar mi grafo.

- Cada nodo esta compuesto por un diccionario donde cada clave es una cara y cada valor respectivo es una matriz n x m donde n son mis filas y m las columnas (iguales dimensiones en todas las caras). Esto esta bien, es un nodo pero seria mucho mas simple... podria usar de muchas maneras. Matriz[i][j] me dice el color que tengo en la celda i,j.

- Las aristas tienen peso 1 (se puede ver como un grafo no ponderado) ya que me indican una jugada valida. $\exists (u,v) \Leftrightarrow$ puedo hacer una transicion (una jugada valida de $u$ a $v$). El grafo no es dirigido, ya que puedo volver atras y repetir jugadas.

- Transicion: Puedo hacer 2 cosas a partir de un estado:
  1) Dado 1 cara Ck puedo modificar una cara por vez, y puedo elegir cualquier cara para modificar (solo puedo hacer una jugada valida sobre una cara a la vez y puedo elegir cualquiera de las caras para esto):
     - Roto cara Ck hacia derecha: cara derecha a Ck = der(Ck). Para todo j en rango: der(Ck)[0][j] = cara arriba de der(Ck). Luego repito esto para toda cara abajo de la que modifique anteriormente hasta llegar de vuelta al inicio (der(Ck)). Por ultimo, en la cara que rote (Ck), cambio la primer fila por la ultima columna y asi sucesivamente hasta que quede toda la cara rotada.
  2) Roto cara Ck hacia izquierda: Es analogo al caso anterior. Cara izquierda a Ck = izq(Ck). Para todo j en rango: izq(Ck)[n-1][j] = arriba(izq(Ck))[n-1][j] y repito para toda cara abajo de izq(Ck) hasta volver al inicio. Por ultimo hago la rotacion correspondiente de Ck: primer fila pasa a primer columna y asi sucesivamente.

**Calificacion:** B (Regular = +5 puntos)

### Pregunta 15

Sea el problema Sudoku N el problema de rellenar una matriz de NxN con numeros de 1 a N tal que no haya dos celdas con el mismo numero en la misma fila ni en la misma columna. Sean estas dos soluciones con Backtracking:

```python
def Sudoku(estado: list[list[int]], celda: int) -> int:
    if celda == N * N:
        return int(es_valido(estado))
    fil, col = celda // N, celda % N
    retorno = 0
    for num in range(1, N+1):
        estado[fil][col] = num
        retorno += Sudoku(estado, celda + 1)
        estado[fil][col] = 0
    return retorno
```

```python
def Sudoku_poda(estado: list[list[int]], celda: int) -> int:
    if celda == N * N:
        return 1
    fil, col = celda // N, celda % N
    retorno = 0
    for num in range(1, N+1):
        estado[fil][col] = num
        if es_valido(estado):
            retorno += Sudoku_poda(estado, celda + 1)
        estado[fil][col] = 0
    return retorno
```

Demostrar que:
A) La cantidad de estados visitados por Sudoku es $\Theta(N^{(N^2)})$
B) La cantidad de estados visitados por Sudoku_poda es $O((N!)^N \cdot N^2)$

Puede usar lo siguiente sin necesidad de demostrarlo: $\sum_{i=1}^{n} p^i \in \Theta(p^n)$

**Respuesta manuscrita (pagina 7):**

R15) A) Para cada celda (excepto la final) tengo N llamados recursivos, los cuales realizan una operacion de complejidad $\Theta(1)$. Mi cantidad total de celdas es $N^2$ (contando la final, la cual usa es_valido y no hace recursion). En total son entonces $N^{N^2}$ llamados recursivos, ya que lo podemos escribir como $\sum_{i=1}^{N^2} N^i$; luego por propiedad (enunciado) pertenece a $\Theta(N^{N^2})$. Queda demostrado que la cant de recursiones (llamados recursivos) que hacemos es $\Theta(N^{N^2})$ y como cada llamado recursivo determina un estado => Demostramos que la cantidad de estados visitados por Sudoku es $\Theta(N^{N^2})$.

B) Para demostrar esto analizamos el problema un poco distinto. Si bien en el algoritmo vamos celda por celda, se puede ver como que voy fila por fila y para cada fila completo el sudoku (es analogo verlo por columnas). El valor de cada nodo es [validado] por la funcion es_valido que es $O(N^2)$ siempre, pero estamos dando una cota superior y seguro que ningun nodo es mas costoso que $N^2$.

**Calificacion:** B + "No responde = (K)" (parcial)

### Pregunta 16

Sea el problema: Dado un conjunto $S$ de $N$ items $(p_i, v_i)$ y un peso limite $P$, no negativo. Determinar el maximo valor posible $V$ tal que existe un subconjunto $S'$ de $S$ tal que:
A) La suma de los $p_i$ con $i$ en $S'$ es menor o igual a $P$.
B) La suma de los $v_i$ con $i$ en $S'$ es igual a $V$.

```python
def Mochila(P: int, S: list[tuple[int,int]]) -> int:
    if P < 0: return -inf
    if len(S) == 0: return 0
    (peso, valor) = S[0]
    return max(Mochila(P,S[1:]),Mochila(P-peso,S[1:])+valor)
```

Demostrar que $Mochila(P,S)$ devuelve la respuesta al problema planteado, independientemente del orden de los elementos en $S$.

**Respuesta manuscrita (paginas 8-9):**

R16) Quiero demostrar que Mochila(P,S) resuelve el problema sin importar el orden de los elementos de S. Lo demuestro por induccion en el tamano de S.

Primero veo el caso $P < 0$: en este caso no puedo tener una respuesta valida, ya que P no puede ser negativo en ningun momento, entonces esta bien que devuelva $-\infty$ que es el neutro del maximo.

Ahora demuestro el resto con induccion en la longitud de S:
- Caso base: $len(S) = 0$, si no tengo elementos, lo maximo que puedo sumar es 0, la funcion es correcta en este caso.
- Paso inductivo:
  - H.I.: Si $len(S) = n$ => Mochila(P,S) resuelve el problema. $P(n)$
  - Tomo $Q_2$: $P(n) \Rightarrow P(n+1)$
  - Tomo $len(S) = n+1$ entonces me fijo en el caso recursivo de la funcion. Hacer la mochila para un conjunto S es igual a hacer la mochila para todos los elementos menos un elemento $v$ y luego fijarse si ese elemento conviene agregarlo al conjunto o no.
  - Por ejemplo, tomo el primer elemento de S y tengo que $|S - S[0]| = n$ => Por H.I. tengo que $Mochila(P, S - S[0])$ devuelve el maximo valor con las condiciones del problema.
  - Ahora tengo que fijarme en el elemento $S[0]$. Tengo dos opciones:
    1) No agrego y sumo su valor al valor maximo y resto su peso a P: $Mochila(P-peso, S[1:]) + valor$
    2) No lo agrego y me quedo con el maximo valor y el peso que tenga hasta ahora: $Mochila(P, S[1:])$
  - Si $S[0] = (peso, valor)$:
    - El caso 1) seria $Mochila(P-peso, S-S[0]) + valor$
    - El caso 2) es $Mochila(P, S-S[0])$
  - $S - S[0]$ se puede escribir como $S[1:]$
  - Como queremos quedarnos con el maximo valor, entonces quiero el max entre ambas opciones (la opcion que me devuelva un numero mayor). Esto es: $\max(Mochila(P, S[1:]), Mochila(P-peso, S[1:]) + valor)$
  - Y esto es exactamente lo que hace la funcion.
  - Entonces $P(n+1)$ tambien vale y por induccion, queda probado para cualquier $S$ (con cualquier longitud positiva).

Como para todos los casos la funcion resuelve el problema => Tambien lo resuelve particularmente para los $P$ y $S$ del enunciado original => $Mochila(P,S)$ devuelve la respuesta al problema planteado.

**Calificacion:** Checkmark (Bien = +10 puntos)

## Ver también

- [[1P_1C_2025]] — Parcial analizado correspondiente a esta transcripcion
