---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_2C_2025_resolucion(1).pdf
metodo: claude_vision
nota_examen: 9/42 (seccion 1) + parciales en desarrollo
turno: Delfina (corrector)
materia: TDA (ex Algo3)
fecha: 29 de Septiembre 2025
---

# Transcripcion — 1P 2C 2025 Resolucion(1)

**Fecha examen:** 29 de Sept. 2025 — 2do Cuatrimestre
**Corrector:** Delfina
**Nota seccion 1:** 9/42

## Seccion 1: Preguntas de opcion multiple y asociacion

Ej 1: (12 Puntos) Marque la/s opcion/es correcta/s. En el punto (B), marque la opcion (C) si cree que vale tanto como (B). Puntajes: Correcta 2 pts / Parcial 1 pt / Incorrecta -1 pt.

Solo Ej 3 y 4 pueden responderse en hoja aparte.

### I. Si el paradigma divide y conquista, que condiciones deben cumplirse para que el uso de dicha tecnica para un problema sea eficiente?

**Opciones disponibles (parcialmente legibles):**
- A) Cuando el costo de dividir+combinar crece mas que el costo total de las subproblemas
- B) Cuando la tecnica de division coincide con algo
- C) Cuando hay solo dos subproblemas
- D) Cuando las subproblemas son de igual tamano

### II. Es valido que un algoritmo de fuerza bruta sea la solucion optima de un problema?

**Respuesta:** Si

### III. Cuando explica programacion dinamica el profesor?

[Respuesta marcada ilegible]

### IV. Que determina principalmente si la tecnica de la poda es efectiva?

[Respuesta marcada]

### V-X. Preguntas sobre greedy, grafos, BFS/DFS

(Multiples preguntas de opcion multiple sobre propiedad de seleccion greedy, subestructura optima, grafos, etc.)

**Nota seccion 1:** 9/42 — muchas respuestas incorrectas o parciales

## Seccion 2: Asociar tecnica a problema

Ej 2: (18 Puntos) Para cada uno de los siguientes problemas, determinar la tecnica (Divide & Conquer, Greedy, Dinamica Top-Down, Dinamica Bottom-Up) que emplearia para resolverlo teniendo en cuenta los siguientes factores que deben quedar justificados: correctitud, complejidad (eficiencia) temporal, complejidad (eficiencia) espacial y simplicidad. Justifique su eleccion y/o la no eleccion de las tecnicas de acuerdo a estos factores. Cada item aporta 6 pts a lo sumo.

### I) Dinamica Bottom-Up

**Respuesta manuscrita:** "Dinamica Bottom-Up: pues como por FB solo necesito los dos valores inmediatamente anteriores, esto ademas me permite construir desde mis casos bases. Siendo buena en espacio y tiempo, con complejidad O(n). Es la mas eficiente."

### II) Problema del cambio (dar un vuelto usando monedas con disponibilidad infinita)

**Respuesta manuscrita:** "Dinamica Top-Down: puedo ir seleccionando cada moneda de mis K valores, resolver para eso sub-problemas (vuelto - m) y elegir el menor caudal me de."

Anotacion del corrector: "No explicas por que no va D&C" y "puede haber superposicion de estados por la dinamica de la busq."

### III) Multiplicacion de matrices

**Respuesta manuscrita:** "Greedy: multiplicando el numero mas significativo y despues sumando respetando sus posiciones."

## Seccion 3: Ejercicio de Greedy

Ej 3: (20 Puntos) Dada una lista n de tareas con un determinado orden, donde cada tarea $i = 1, ..., n$ toma $t_i$ unidades de tiempo en ser completada. Son $d_i$ minutos, $= \sum_{j=1}^{i} t_j$, el tiempo que se debe esperar para que la i-esima tarea (segun el orden en que se completaron todas las anteriores cada vez). Nos interesa elegir un orden en el cual resolver las tareas de manera que se minimice la sumatoria de demoras de todas.

a) Plantear como seria el orden de las tareas en un algoritmo greedy (5pts)
b) Demuestre que ese algoritmo greedy es correcto. Se descompentara debajo que no exista ninguna solucion que requiera menos demora total que la obtenida por el algoritmo greedy (15pts)

### Respuesta Ej 3

**a)** Viendo que tenemos que minimizar:

$$\sum_{i=1}^{n} \left(\sum_{j=1}^{i} t_j\right)$$

Me conviene que los primeros terminos de $\sum_{i=1}^{n}$ sean lo mas chicos posibles, pues ellos son los que mas veces van a ser sumados. Y para que esos terminos sean pequenos necesito que $\sum_{j=1}^{i}$ sea pequeno, para eso min primero "i"s.

Entonces el orden de las tareas para greedy deberia ser con $t$ ascendente. Es decir, ordenados de forma ascendente segun el tiempo que les toma completarse.

**Calificacion parte a:** B (Regular)

**b)** Probandolo usando "greedy stays ahead" que es una estrategia donde partiendo de una solucion O optima cualquiera, nuestro algoritmo greedy brinda una solucion al menos tan buena como O.

$G_i = \{g_1, ..., g_n\}$
$O_i = \{o_1, ..., o_n\}$

"no llego..."

**Calificacion parte b:** M (Mal — no completo)

## Seccion 4: Ejercicio de PD — Combinaciones

Ej 4: (30 Puntos) Queremos contar cuantas combinaciones distintas de secuencias $v = (v_1, v_2, ..., v_n)$ existen tal que $v_i \in \mathbb{N}$, $1 \leq v_i \leq k$ y $\sum_{i=1}^{n} v_i = s$, donde n, k y s son parametros. El algoritmo disenado debe estar basado en la tecnica de Programacion Dinamica. Considere a k como constante. Note que se debe cumplir $n \leq s \leq n \cdot k$ para que la respuesta no sea trivial.

a) Definir de forma recursiva la funcion combinaciones(n, k, s) que calcule la cantidad de formas de conseguir la suma s con las restricciones explicadas. No olvide definir los casos base (10 pts).
b) Demostrar que se cumple la propiedad de superposicion de subproblemas (10 pts).
c) Definir un algoritmo (escribir pseudocodigo) top-down para calcular combinaciones(n, k, s) indicando claramente las estructuras de datos utilizadas y la complejidad temporal y espacial resultantes (10 pts).

### Respuesta Ej 4

**a)** Definicion recursiva:

$$comb(s, k, n) = \begin{cases} 0 & \text{si } s < n \\ 1 & \text{si } s = n \\ 1 & \text{si } n = 1 \text{ (es decir, cualquier secuencia suma S, porque estas diciendo que n tiene 1 elemento, alcanza para saber que suma S)} \\ \sum_{i=1}^{K} comb(s-i, k, n-1) & \text{sino} \end{cases}$$

Anotacion adicional: tambien caso base $1$ si $n = 0 \land s = 0$.

**Calificacion parte a:** B (Regular) — anotacion: "falta caso base s=0 y n=0"

**b) Superposicion de subproblemas:**

A partir de ejemplos:
- Con $K=4$, $S=5$, $n=2$: 4 combinaciones (4+1, 3+2, 2+3, 1+4)
- Siendo $K=4$ constante, ahora con $n=3$: $3+2+1 = 5$ combinaciones posibles

Arbol de recursion para $comb(5,3)$: se abre en $comb(4,2)$, $comb(3,2)$, $comb(2,2)$, $comb(1,2)$

Se observa superposicion en sub-problemas como $comb(2,1)$ y $comb(1,1)$.

"El arbol es del orden de tener n niveles y en cada nivel, cada nodo se abre en K opciones. Es decir, cant. nodos $O(K^n)$"

"Ademas, en este corto ejemplo, ya se empieza a ver la superposicion de problemas en los sub-problemas comb(2,1) y comb(1,1)."

Se puede observar que la cant. de llamados que se va a hacer a la funcion es del orden $O(K^n)$, $O(n \cdot s)$ porque K es cte.

Sin embargo, la funcion tiene $O(n \cdot K)$ estados (si bien la funcion tiene 3 argumentos como 1 de ellos es constante, no nos interesa a la hora de hacer memoizacion). Son $O(n \cdot K)$ estados porque K restos, n veces.

Como $n \cdot K \ll K^n$, entonces hay superposicion de problemas.

**Calificacion parte b:** B (Regular)

**c) Pseudocodigo top-down:**

```
memo[][] <- inicializo con -1
comb(S, K, n):
    c_total <- 0
    si S == n || n == 1:
        devolver 1
    si S < n:
        devolver 0
    for (i = 1, i <= K, i++):
        si memo[S-i][n-1] == -1:
            memo[S-i][n-1] <- comb(S-i, K, n-1)
        c_total <- c_total + memo[S-i][n-1]
    devolver c_total
```

Continuacion Ej 4 c:

Complejidad temporal: es del $O(n \cdot K)$ ya que el trabajo que hacemos en cada estado es el for hasta K, ademas de al inicio inicializar memo.

**Correccion del corrector:** "No" — la complejidad temporal deberia ser $O(n \cdot K \cdot K) = O(n \cdot K^2)$ o bien $O(n \cdot s)$ considerando los estados posibles y el for de K en cada uno. Pero como K es constante, queda $O(n \cdot s)$.

Complejidad espacial: es del $O(n \cdot K)$ el tamano de la matriz memo.

**Calificacion parte c:** R (Regular)

## Seccion 5: Ejercicio de D&C — Teorema Maestro

Ej 5: (10 Puntos) Analice la complejidad temporal del siguiente algoritmo usando el Teorema Maestro:

```python
def es_derecha_dominante(arr, inicio, fin):
    if fin - inicio == 1:
        return True, arr[inicio]
    
    medio = (inicio + fin) // 2
    
    izq_dominante, suma_izq = es_derecha_dominante(arr, inicio, medio)
    der_dominante, suma_der = es_derecha_dominante(arr, medio, fin)
    
    es_dominante = (suma_der > suma_izq) and izq_dominante and der_dominante
    suma_total = suma_izq + suma_der
    
    return es_dominante, suma_total
```

Describa a (numero de subproblemas), b (factor de division), $f(n)$ (costo de dividir+combinar), caso del Teorema Maestro y complejidad final.

### Respuesta Ej 5

**Respuesta manuscrita:**

$a = 2$ pues procesa 2 mitades.
$b = 2$ pues reduce a la mitad el arreglo.
$f(n) = O(1)$ pues solo hace operaciones booleanas y aritmeticas elementales.

Caso 1: $f(n) = O(1) \in O(n^{\log_2 2 - \epsilon}) = O(n^1)$

$T(n) = \Theta(n^{\log_2 2}) = \Theta(n)$

**Calificacion:** B (Bien)

## Seccion 6: Ejercicio de Backtracking

Ej 6: (10 Puntos) El parcial termino y tenes que repartir en entregas entre dos ayudantes (Alicia y Carlos) para que corrijan. Cada parcial tiene una cantidad de hojas $h_i$. Tu objetivo es minimizar la diferencia entre la cantidad de hojas que debe corregir cada ayudante. Para ver cual es la minima diferencia de hojas que podes conseguir, haces el siguiente algoritmo de backtracking:

```python
def particion(h, solucion):
    if len(solucion) == len(h):
        return diferencia(h, solucion)
    part_a = solucion + ['A']
    part_c = solucion + ['C']
    return min(particion(h, part_a),
               particion(h, part_c))

def diferencia(h, solucion):
    sum_a = 0
    sum_c = 0
    for i in range(len(h)):
        if solucion[i] == 'A':
            sum_a += h[i]
        if solucion[i] == 'C':
            sum_c += h[i]
    return abs(sum_a - sum_c)
```

Asumiendo que las lineas 4 y 5 son $O(1)$, reporte la complejidad del algoritmo.

Dibuje el arbol de recursion con $h = [1, 5, 3]$. Para los nodos de soluciones validas, escriba su valor.

### Respuesta Ej 6

**Complejidad:** $O(2^{|h|} \cdot |h|)$

**Arbol de recursion** con $h = [1, 5, 3]$:

```
                    [1,5,3], []
                   /           \
                [A]             [C]
               /   \           /   \
           [A,A]  [A,C]    [C,A]  [C,C]
           / \    / \       / \    / \
        AAA AAC ACA ACC  CAA CAC CCA CCC
```

Valores en hojas:
- AAA: $|9-0| = 9$... (parcialmente legible)
- Valores calculados con diferencias: $|3-0|=3$, $|1-2|=1$, etc.

**Calificacion:** A (anotacion: "No son estos los valores. Se entiende la idea")

## Ver también

- [[1P_2C_2025]] — Parcial analizado correspondiente a esta transcripcion
