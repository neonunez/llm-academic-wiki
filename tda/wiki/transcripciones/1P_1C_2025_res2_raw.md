---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_1C_2025_resolucion(2).pdf
metodo: claude_vision
nota_examen: 85/100
turno: Manana
materia: AED 3
---

# Transcripcion — 1P 1C 2025 Resolucion(2)

Nota: 85/100.

## Seccion 1: Preguntas de opcion multiple

### Pregunta 1

Complejidad temporal de calcular $\binom{N}{K}$ con PD.

**Respuesta marcada:** $\Theta(N \cdot K)$ [CORRECTA]

### Pregunta 2

Complejidad espacial de matriz de adyacencia para grafo con N nodos y M aristas.

**Respuesta marcada:** $\Theta(N^2)$ [CORRECTA]

### Pregunta 3

Reemplazar listas de adyacencia por tablas hash.

**Respuesta marcada:** "Saber si dos nodos u y v son vecinos en $\Theta(1)$" [CORRECTA]

### Pregunta 4

DFS valido en digrafo con 5 nodos.

**Respuesta marcada:** $1-2-4-5-3$ [CORRECTA]

### Pregunta 5

Grafo de strings con sufijos — cual es la falsa.

**Respuesta marcada:** "El grafo puede tener ciclos dirigidos simples con mas de un nodo" [CORRECTA]

### Pregunta 6

Funcion recursiva como grafo dirigido — cual es correcta.

**Respuesta marcada:** "Llamar a la funcion con el estado $x$ generara tantas llamadas al estado $y$ como caminos hay de $x$ a $y$ en el grafo" [CORRECTA]

### Pregunta 7

Relacion $R(a,b)$ si pertenecen a la misma componente conexa.

**Respuesta marcada:** "Una relacion de equivalencia" [CORRECTA]

### Pregunta 8

Complejidad espacial de memorizacion top-down con N estados y M transiciones.

**Respuesta marcada:** $\Theta(N)$ [CORRECTA]

## Seccion 2: Preguntas abiertas de respuesta corta

### Pregunta 9

Floyd Warshall — que se calcula en cada estado de la DP.

**Respuesta manuscrita:** "B.R. Para cada par de vertices (i,j) se calcula la minima distancia entre el valor memorizado y entre agregar el vertice K al camino con $\min(d_{ij}^{k-1}, d_{iu}^{k-1} + d_{kj}^{k-1})$. Explica como se calcula, no que se calcula."

**Calificacion:** X (Mal) — anotacion del corrector: "Explica como se calcula, no que se calcula"

### Pregunta 10

Bellman Ford — que se calcula en cada estado de la DP.

**Respuesta manuscrita:** "R. De la misma manera que arriba, con Floyd, pero extendiendo el camino de largo K-1 a K agregando una arista al camino y comparando con el valor memorizado."

**Calificacion:** X (Mal) — anotacion: "No es de la misma manera que con Floyd. Cada estado calcula el camino minimo desde el origen hasta i con a lo sumo K aristas."

### Pregunta 11

Grafo con aristas multiplicativas por primos — que significa un camino de u a v.

**Respuesta manuscrita:** "B. Significa que v es multiplo de u, siendo el camino mas largo a v el que contiene a todos sus multiplos, en particular contiene a su factorizacion en primos. Considero que a priori lo que la segunda mitad dice no es necesariamente correcto, pero me concentro en lo primero."

**Calificacion:** X (Mal) — anotacion: "No necesariamente" (sobre la parte de factorizacion)

### Pregunta 12

Orden topologico valido del grafo DAG con nodos 1-9.

**Respuesta manuscrita:** $6-3-4-9-7-8-2-1-5$

**Calificacion:** X (Mal — orden invalido)

## Seccion 3: Ejercicios a Desarrollar

### Pregunta 13

Floyd modificado para determinar peso minimo de nodos intermedios.

**Respuesta manuscrita (pagina 5):**

13) Modifico el algoritmo de Floyd que ya encuentra si hay un camino entre u y v para cada par de nodos en $O(N^3)$ temporal y $O(N^2)$ espacial para que haga lo siguiente:

Guardo una matriz MINP de NxN donde para cada (i,j) en cada iteracion K:
- Si no hay camino con el nodo K no hace nada
- Si hay camino: guarda en MINP[i][j] = el minimo entre el valor que ya tenia entre i,j y el maximo entre ($\min(P[i][k], P_k, MINP[k][j])$)

(La matriz MINP se inicializa con todo $\infty$)

Asi tomo el minimo peso de los caminos que encuentre de i a j teniendo en cuenta que un camino que no es de i a k a j tiene peso maximo el maximo entre los nodos de i a k, el peso de k, y los nodos de k a j.

Agregar la matriz es $O(N^2)$ al inicializarla temporalmente ($O(N^2) \in O(N^3)$) y espacialmente tambien. Luego el codigo son comparaciones e if's que son $O(1)$ por lo que mantiene la misma complejidad que Floyd.

Luego de ejecutar este algoritmo MINP[i][j] tiene valor $< \infty$ si hay camino y este sera el menor peso mayor al resto del camino, y menor entre todos los caminos de i a j.

**Calificacion:** B (Regular = +5 puntos)

### Pregunta 14

Cubo de Rubik como grafo.

**Respuesta manuscrita (pagina 6):**

14) Defino el grafo como:
Los vertices son los posibles estados del cubo, donde el vertice $E_i$ (para cualquier $i$, entre la cantidad de estados) tiene 12 aristas que salen, dirigidos, dos para cada cara, una para girarla en sentido horario y otra en el sentido anti-horario. Cada una dirigida al estado $E_j$ al cual terminaria el estado $E_i$ si se le aplica ese movimiento.

Como cada arista representa un movimiento valido, si partimos del estado $u$ y contamos la distancia que recorremos, al hacer cualquier camino a un estado $v$ esa sera por definicion la cantidad de movimientos necesarios y el camino sera la lista de movimientos al ser todos ellos validos.

**Calificacion:** B (Regular = +5 puntos) — anotacion del corrector: "La cantidad de movimientos necesarios para ir al minimo. Queda un poco mas directo el modelado con un grafo no dirigido pero esta bien."

### Pregunta 15

Sudoku backtracking — demostrar complejidades.

**Respuesta manuscrita (pagina 7):**

15) A) Un estado se define como una posible solucion, al no tener podas vamos a permitir repetir numeros en la misma fila o columna, por lo que para cada casillero hay N opciones, hay $N^2$ casilleros por lo que para cualquier N dado vamos a formar las $N^{N^2}$ posibles configuraciones.

**Calificacion parte A:** Checkmark [CORRECTA]

B) Ahora si para poner un numero tenemos solo en cuenta los que son validos y rellenamos secuencialmente. La primera fila, vamos a tener que en el primer casillero tenemos N opciones, en el segundo N-1, ... hasta 1 sola opcion, por lo que para esa fila son $N!$ posibilidades. La segunda fila empieza con $(N-1)$ opciones ya que esta limitada la casilla de arriba por lo que la segunda fila tiene $(N-1)!$ opciones. Asi llegamos a la ultima con 1. Juntando esto tenemos:

$$N! \cdot (N-1)! \cdot (N-2)! \cdot (N-3)! \cdot ... \cdot 2! \cdot 1! = \prod_{i=0}^{N-1} (N-i)!$$

Que es lo mismo a que si a cada termino lo reemplazamos con $N!$ como cota superior tenemos $(N!)^N$.

Pero como "elegimos" desde N opciones a la primer casilla tenemos que multiplicar por $N^2$ para considerar empezar en cualquier casillero. Aunque no se use el algoritmo en si, los estados visitados se forman de la misma manera.

Entonces:

$$O\left(\prod_{i=0}^{N-1} (N-i)! \times N^2\right) \in O\left((N!)^N \times N^2\right)$$

Donde $m = N$.

**Calificacion parte B:** B (Regular) — anotacion: "por estados visitados -> el N^2 es por la cantidad de indices posibles"

### Pregunta 16

Mochila — demostrar correctitud.

**Respuesta manuscrita (pagina 8):**

16) Lo pruebo por induccion en el tamano de S:

- Si S tiene tamano 0 entonces para cualquier peso P el maximo valor tiene que ser 0 ya que esta vacio, y $Mochila(P, []) = len(S) == 0$: RET 0 nos da 0 por lo que se cumple el caso base.

- Ahora si S tiene un tamano cualquiera $\geq 1$ y lo podemos representar como $[X:S]$ (casi Haskell) donde X es el primer elemento, asumo como hipotesis inductiva que $Mochila(P, S)$ y $Mochila(P - pesoX, S)$ dan los maximos valores posibles correspondientes a $V_P$ y $V_{P-x}$.

Ahora $MOCHILA(P, [X:S])$ se define por la funcion por: $\max(Mochila(P, S), Mochila(P - pesoX, S) + valorX)$

Y por HI podemos saber que: $Mochila(P, [X:S]) = \max(V_P, V_{P-x} + valorX)$

Asi tendriamos el maximo valor de poner X o no al subconjunto que ya maximizaba el valor, obteniendo el maximo valor posible de los $[X:S]$ elementos a un peso $\leq P$.

Aclarar que si agregar X excede el peso $V_{P-x}$ seria $-INF$ por HI y que en ningun momento se asumio algo del orden de los elementos, solo que $|S| \geq 1$, habiendo cubierto $|S| = 0$.

**Calificacion:** B (Regular = +5 puntos) — anotacion: "No esta muy bien definida la HI"

## Ver también

- [[1P_1C_2025]] — Parcial analizado correspondiente a esta transcripcion
