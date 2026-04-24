---
tipo: transcripcion
fuente: raw/parciales/2P/2.parcial_1C_2025_resolucion(1).pdf
metodo: claude_vision
nota_examen: 68/100
turno: TDA / Algo3
variante: Tema A
---

# Transcripcion — 2P 1C 2025 Resolucion(1)

Nota: 68/100. Variante: Tema A. Examen regular (no recuperatorio).

## Informacion del examen

TDA / Algo3, 1erC 2025, 2do Parcial.
Duracion: 5 horas. Examen individual y a libro cerrado.
- Ejercicios 1 a 4 valen 5 puntos si se responden correctamente, -2 puntos si se responden incorrectamente. Cada uno tiene una unica opcion correcta. Marcar mas de una opcion se considera una respuesta incorrecta.
- Los ejercicios 5 y 6 valen 10 puntos si se responden correctamente.
- Los ejercicios 7 a 10 valen 15 puntos si se responden correctamente.
- La nota de aprobacion es de 60/100 puntos.

## Seccion 1: Preguntas de opcion multiple (Ej 1-4)

### Ejercicio 1

Un coloreo en un grafo es una asignacion de colores a todos sus vertices de manera tal que si dos vertices son adyacentes entonces no reciben el mismo color. Un grafo de $n$ vertices que es un ciclo es coloreable con 2 colores

- si y solo si n es potencia de 2
- **[X] si y solo si n es par**
- si y solo si $n \geq 2$
- siempre

**Respuesta marcada:** si y solo si n es par

### Ejercicio 2

Cual es la complejidad temporal de sort en funcion de la longitud $n$ del array de entrada?

```python
def sort_rec(arr, i, j):
    if j < i+2:
        return
    if j == i+2:
        if arr[i+1] < arr[i]:
            swap(arr[i+1], arr[i])
        return
    n = j-i
    sort_rec(arr, i, j-n//3)
    sort_rec(arr, i+n//3, j)
    sort_rec(arr, i, j-n//3)

def sort(arr):
    sort_rec(arr, 0, len(arr))
```

Opciones:
- $\Theta(n \log_{3/2}(n))$
- $\Theta(n^{\log_{3/2}(3)})$
- $\Theta(n^{3/2 \cdot \log_3(n)})$
- $\Theta(n^3)$

**Respuesta marcada:** no se distingue claramente en la imagen

### Ejercicio 3

Al aplicar el algoritmo de BFS en un grafo grilla (donde cada nodo es una celda, y esta conectado con sus vecinos, que son 4 para las celdas internas, 2 para las esquinas y 3 para los bordes que no son esquinas). Si se ejecuta una busqueda BFS comenzando en esquina $(0,0)$ puede asegurarse que un vertice $(i,j)$ se visita despues que el vertice $(2,3)$ cuando

- $i > 2$
- $j > 3$
- **[X] $i + j > 5$**
- nunca puede asegurarse, depende del recorrido

**Respuesta marcada:** $i + j > 5$

### Ejercicio 4

Si una funcion recursiva tiene complejidad $T(n) = bT(n/b) + \Theta(n)$ con $b > 1$, entonces $T(n)$ es

- $\Theta(n)$
- **[X] $\Theta(n \log n)$**
- $\Theta(n \log^2 n)$
- $\Theta(n^2)$

**Respuesta marcada:** $\Theta(n \log n)$

## Seccion 2: Respuesta corta (Ej 5-6)

### Ejercicio 5

Dar un ejemplo de un grafo conexo pesado y una arista nueva, tal que agregarle la arista al grafo reduzca el peso del AGM del grafo.

**Respuesta manuscrita:**

Grafo con vertices A, B, C, D, E, F:
- Grafo original: aristas con pesos dibujados (vertices en circulo azul conectados con pesos: A-B(5), A-D(10), B-C(3), B-E(6), C-E(4), D-E(8), etc.)
- AGM del grafo original marcado en verde: peso = 21
- Arista nueva: (A, C) con peso 2
- AGM del grafo con arista nueva: peso = 15

**Marca del corrector:** check (✓)

### Ejercicio 6

Sabemos que el algoritmo de Dijkstra puede fallar si en un grafo dirigido pesado se tienen pesos negativos. Dar un ejemplo de una instancia (grafo y nodo de origen) donde esto ocurra.

**Respuesta manuscrita:**

Grafo dirigido con 4 nodos: A, B, C, D
- Nodo origen: A
- Aristas: A→B (peso 3), A→C (peso 10), B→D (peso 6), C→D (peso -8)

"Si corro Dijkstra en este grafo desde A, el algoritmo falla (no me devuelve las longitudes de los caminos minimos de A a todos los nodos). Esto se ve con el nodo D, ya que $d(A,D) = 2$ y Dijkstra va a devolver $d(A,D) = 9$."

Explicacion: el camino minimo real es A→C→D con peso 10 + (-8) = 2, pero Dijkstra procesa B antes que C (dist 3 < 10), marca D como finalizado con dist 9 (via A→B→D), y nunca corrige cuando descubre el camino por C.

**Marca del corrector:** check (✓)

## Seccion 3: Ejercicios a desarrollar (Ej 7-10)

### Ejercicio 7

**Enunciado impreso:**

Sea $I = \{[l_1, r_1], [l_2, r_2], ..., [l_n, r_n]\}$ un conjunto de intervalos sobre la recta real. Queremos cubrir todos los intervalos colocando la menor cantidad de puntos $x_1, ..., x_k \in \mathbb{R}$, tales que para todo $[l_i, r_i]$ exista algun $x_j \in [l_i, r_i]$. Consideramos el siguiente algoritmo:

- Ordenar los intervalos por su extremo derecho $r_i$ en orden creciente.
- Inicializar el conjunto de puntos $S = \emptyset$
- Para cada intervalo $[l_i, r_i]$, si no existe ningun punto de $S$ que lo cubra, agregamos $r_i$ a $S$.

Demostrar que este algoritmo devuelve una solucion optima, es decir, que $S$ tiene la minima cantidad posible de puntos que cubren todos los intervalos.

**Respuesta manuscrita (paginas 3-4):**

(Nota al margen: "luego 'primero' hace referencia al orden por fin(r_i) de [l_i, r_i]" y "cuando digo siguiente, me refiero al que tenga el siguiente menor r_i")

Ej 7) Supongamos que $O^*$ es una solucion optima, y $S$ (o $G$) es la solucion del algoritmo greedy.

Qvq: $O$ y $G$ tienen la misma cantidad de puntos (la minima). Para esto hare induccion para ver que siempre puedo extender una solucion parcial de $G$ a una solucion optima $O$.

Ambas soluciones son conjuntos (sin orden), pero para demostrar voy a usar una lista que tenga los elementos del conjunto con orden creciente (esto no afecta las soluciones, ya que tengo los mismos puntos). Entonces llamo $O$ y $G$ a las listas ordenadas de la solucion optima y greedy respectivamente: $O = (O_1, O_2, ..., O_k)$ y $G = (G_1, G_2, ..., G_k)$.

**Caso base:** $i = 0$ (1) (mi solucion parcial tiene 1 elemento).

Tengo la solucion $O = (O_1, O_2, ..., O_k)$. La solucion parcial greedy agrega el primer elemento y por como funciona el algoritmo, se que agrega el $r_i$ mas chico de todos los intervalos.

$\Rightarrow r_i \leq r_j$ $\forall$ $1 \leq j \leq n$. Sabemos ademas que en $O$ debo abarcar todos los intervalos (porque es optimo).

$\Rightarrow O_1 \leq r_i \Rightarrow$ los puedo intercambiar (ambos pertenecen al primer intervalo, y si $O_1$ pertenecia a un intervalo con fin superior $\Rightarrow$ $r_i$ estara contenido tambien en ese intervalo).

Entonces puedo extender a $(r_i, O_2, ..., O_k) = (G_1, O_2, ..., O_k)$.

**H.I:** Puedo extender a una solucion optima si mi solucion parcial tiene hasta $i$ elementos.

$G = (G_1, G_2, ..., G_i)$ extiende a $O = (G_1, G_2, ..., G_i, O_{i+1}, ..., O_k)$

**Qvq:** Al agregar el punto $G_{i+1}$ en el algoritmo greedy, igual lo puedo extender a una solucion optima (se puede extender a optimo con $i+1$ elementos).

Yo se que tanto $O_{i+1}$ como $G_{i+1}$ abarcan el siguiente intervalo que al que abarca $G_i$ (ya que estan ordenados los puntos y en una solucion optima no voy a tener mas de 1 punto que abarque el mismo intervalo).

Entonces, de nuevo, este intervalo empieza luego del fin del intervalo de $G_i$.

Entonces de nuevo tengo que, por como funciona el algoritmo greedy, $G_{i+1} = r_b$ (donde $r_b$ es el fin del intervalo siguiente al que abarca $G_i$) $\Rightarrow$

$O_{i+1} \leq G_{i+1}$ (porque si no, $O_{i+1}$ no abarcaria ese intervalo) y entonces $G_{i+1}$ abarca cualquier intervalo siguiente que podria abarcar $O_{i+1}$ $\Rightarrow$ los puedo intercambiar: $O = (G_1, G_2, ..., G_i, G_{i+1}, ..., O_k)$ entonces puedo extenderlo a una solucion optima.

Por como funciona la induccion, me queda que puedo seguir extendiendo a una solucion optima hasta que termine el algoritmo greedy $\Rightarrow$ greedy devuelve una solucion optima $\Rightarrow$ $S$ tiene la minima cantidad posible de puntos que cubren todos los intervalos.

**Feedback del corrector (en rojo):**
"PARA DECIR QUE ES OPTIMA FALTA JUSTIFICACION. ¿COMO SABES QUE NO FALTAN PUNTOS? NUNCA EXPLICAS POR QUE SOLO CON QUE DOS PUNTOS ESTEN EN EL MISMO INTERVALO SABES QUE CUBREN LO MISMO. QUE ES CENTRAL A LA DEMO."

(Tambien notas marginales: "PERO ESE PUEDE ESTAR CUBIERTO POR G_i" apuntando a la parte del paso inductivo)

### Ejercicio 8

**Enunciado impreso:**

Queres armar una piramide 3D. Para eso, primero tenes que imprimir y recortar un papel, y luego doblar y pegar los bordes expuestos hasta formar la figura 3D. Los lados de la base miden 4cm y las otras aristas, 6cm.

En la ilustracion se ven tres ejemplos de como podrias armar el recorte. Tenes que encontrar, de todas las formas posibles de armarlo, una que requiera pegar la menor longitud total de bordes para armar la figura 3D. Modelar con el problema de arbol generador minimo. Esto es, definir un grafo tal que resolver el problema propuesto sea equivalente a encontrar un arbol generador minimo en ese grafo y explicar como recuperar la solucion al problema original a partir del AGM del grafo.

**Respuesta manuscrita:** No se observa respuesta escrita para este ejercicio.

### Ejercicio 9

**Enunciado impreso:**

Se tiene un digrafo $G$ con conjunto de nodos $\{1, ..., n\}$. La belleza de una permutacion $f$ es la cantidad de indices $i \in \{1, ..., n\}$ tales que $(i, f(i))$ es un eje del digrafo. Modelar el problema de encontrar la permutacion mas bella usando max-flow.

Nota: una permutacion es una funcion biyectiva $f: \{1, ..., n\} \to \{1, ..., n\}$.

**Respuesta manuscrita (paginas 6-7-8):**

Ej 9) Tengo: Aristas y Nodos de un Digrafo $G$.

[Diagramas mostrando node-splitting: nodos con "in" y "out", y la idea de que cada nodo solo puede ir a un valor (biyectiva)]

Mi red $(V, E)$ es la siguiente:
- $V$ = Nodos del digrafo $G$ duplicados (por cada nodo del digrafo, hay 2 nodos que lo representan en la red). Tengo una biparticion $(A, B)$ donde $A$ tiene todos los nodos de $G$ sin repetidos, al igual que $B$. Ademas tengo el sumidero y fuente.
- $E$: La fuente conecta con los nodos de $A$ con capacidad 1. $\forall (u,v) \in G$ tengo una arista del nodo $u$ en la particion $A$ que va al nodo $v$ en $B$ con capacidad $\infty$. Los nodos de $B$ conectan con el sumidero con capacidad 1.

[Diagrama de la red bipartita: S → nodos A (cap 1) → nodos B (cap ∞) → T (cap 1)]

"Encontrar el flujo maximo en este modelo, soluciona el problema de la permutacion mas bella."

"Flujo maximo = Belleza de la permutacion mas linda."

"Hay arista entre ellos si existe esa arista en $G$."

**Explicacion (pagina 7):**

"Yo quiero que mi permutacion tenga la mayor cantidad de aristas $(i, f(i)) \in G$."

"En la red representamos todas las aristas del digrafo, donde el nodo del que sale la arista esta en $A$ y el nodo al que llega esta en $B$."

"Como una permutacion es una biyeccion, quiero elegir una sola arista que tenga de entrada el nodo $i$ y una sola arista que tenga de salida el nodo $j$, para agregar $f(i) = b$ si $(i,b) \in G$ y $f(a) = j$ si $(a,j) \in G$, pero no agregar $f(i) = j$ si $(i,j) \in G$ si ya agregue las 2 anteriores (deja de ser biyeccion y ni siquiera seria funcion en el ejemplo con $f(i) = j$)."

"Para esto las capacidades que salen de $S$ significan con cierta permutacion 'este nodo $\in$ Dom($f$)' y por eso tienen capacidad 1. Lo mismo pasa con los nodos que van a $T$: las aristas de capacidad 1 que vienen significan 'este nodo es parte de la imagen' y tienen capacidad 1 para que la funcion sea biyectiva."

"La capacidad de las aristas del medio es indiferente porque ya tengo las restricciones que necesito. Entonces la configuracion del flujo maximo (el flujo de cada arista) representa a donde debo enviar ciertos elementos del dominio ($A$) para tener la maxima cantidad de $(i, f(i)) \in G$."

"Cada camino de flujo 1 de $S$ a $T$ me indica que en la permutacion mas bella debe estar $f(i) = j$: si $i \in A$, $j \in B$ y ambos pertenecen a este camino de flujo 1. Si hay flujo 0, significa que esos $i' \in A$ y $j' \in B$ que pertenecen al camino de flujo 0 no tienen restriccion en la permutacion mas bella, por lo que tengo $f(i') = a$, siendo $a$ cualquier numero de 1 a $n$ que no sea $f(b) = a$ para $b \neq i'$."

**(Pagina 8 — continuacion):**

"Es decir, si alguien ya iba a 'a', $i'$ no puede ir a 'a' (porque es una funcion). Lo mismo es analogo para $j'$, que puede ser resultado de cualquier $f(K)$ si $K$ no va a ningun otro resultado (es biyectiva la funcion)."

"De esta forma, viendo la configuracion del flujo en mi modelo puedo construir la permutacion mas bella."

"Todo lo que dije de que la configuracion del flujo me da ciertas permutaciones validas es cierto gracias a la conservacion de flujo y flujo $\leq$ cap:
- (elementos del Dom($f$)) van a un solo lugar por cap 1 de la fuente
- (elementos de la Im($f$)) son resultado de un unico $f(i)$ por cap 1 al sumidero"

**Marca del corrector:** "B" (presumiblemente calificacion parcial — "Bien" o nota)

Notas marginales del corrector: "Para todo $i$ existe $f(i)$ que supera su capacidad de flujo?" (cuestionando si el modelo garantiza que TODOS los nodos tengan asignacion)

### Ejercicio 10

**Enunciado impreso:**

James Bo esta atrapado en un grafo de $n$ vertices y $m$ aristas ($m > n$). Para escapar debe ir del vertice en el que se encuentra a alguno de los marcados como "de salida" en a lo sumo $t$ turnos. En cada turno puede recorrer exactamente una arista o permanecer en el nodo en el que esta. Hay un problema: en cada turno $1, ..., t$, puede haber algunas aristas con trampas mortales activadas. El servicio de inteligencia oriental le proveyo con una servilleta que contiene:

- La matriz $M$ de tamaño $m \times t$ que indica si la arista $i$ puede atravesarse en el turno $j$.
- La estructura del grafo, donde ademas estan senalados tanto el vertice donde el se encuentra prisionero como el conjunto $S$ de vertices de salida.

Dar un algoritmo de complejidad temporal $O(mt)$ para encontrar un camino de escape de la minima cantidad de turnos, si existiera.

**Respuesta manuscrita (pagina 5):**

Ej 10) Puedo ir a lo sumo en $t$ turnos.
- En cada turno recorre una arista o permanece en la que esta.
- Tengo matriz $m \times t$ que dice si puedo pasar por arista $i$ en el turno $j$.
- Tengo los vertices de salida.
- Se donde estoy.

Puedo modelar un grafo con nodos (arista, turno). Luego conecto un nodo $U$ con $V$ $\Leftrightarrow$ $\exists$ $(U,V)$ en $G$ y en turno $t_u$ si tengo $(U, t_u)$ y $(V, t_v)$ con $t_v = t_u + 1$ (si un nodo es el nodo de salida pertenece al turno anterior, es decir de llegada).

Estos nodos (arista, turno) solo existen si puedo pasar por la arista en ese turno (si no puedo pasar en ese turno, no existe la tupla en mi modelo).

Corro BFS desde donde esta James Bo y el primer nodo $\in S$ que aparezca, sera al que debera ir James en su camino de escape. (Siempre que sea alcanzable)

Tambien conecto para todo nodo $u$: conecto $(u, t_u)$ a $(u, t_u + 1)$ (todo nodo se conecta con el mismo en el siguiente turno — permanecer).

El grafo que modele es dirigido.

La complejidad de BFS es $O(V + E)$. Tengo $V = mt$... $E = $...

**Feedback del corrector (en rojo):** "esta mal por otro motivo adelante" y marca lateral "R" (presumiblemente "Regular" como calificacion).

Nota: el estudiante modela nodos como (arista, turno) en lugar de (vertice, turno). El corrector senala que hay un error conceptual — deberian ser nodos (vertice, turno), no (arista, turno), para que BFS funcione correctamente y la complejidad sea $O(mt)$ con la cantidad correcta de vertices y aristas.

## Ver también

- [[2P_1C_2025]] — Parcial analizado correspondiente a esta transcripcion
