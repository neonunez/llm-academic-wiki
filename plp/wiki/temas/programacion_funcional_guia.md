---
nombre: Práctica 1 - Programación Funcional
parcial: 1P
tipo: Guía de Ejercicios
tema: Programación Funcional
fuente: plp/raw/guias_practicas/0.guia_1P_programacion_funcional.pdf
paginas_relacionadas: ["[[programacion_funcional_teoria]]", "[[programacion_funcional_practica]]"]
---

# Guía 1 — Programación Funcional

Esta guía cubre los conceptos fundamentales de programación funcional en Haskell: currificación, tipos, esquemas de recursión (especialmente sobre listas y otras estructuras inductivas) y generación infinita.

> [!IMPORTANT]
> Para resolver esta práctica, se recomienda el uso del intérprete GHCi. No está permitido el uso de recursión explícita a menos que se indique lo contrario.

---

## Currificación y Tipos

### Ejercicio 1 ★
Considerar las siguientes definiciones de funciones:

```haskell
- max2 (x, y) | x >= y = x
              | otherwise = y
- normaVectorial (x, y) = sqrt (x^2 + y^2)
- subtract = flip (-)
- predecesor = subtract 1
- evaluarEnCero = \f -> f 0
- dosVeces = \f -> f . f
- flipAll = map flip
- flipRaro = flip flip
```

I. ¿Cuál es el tipo de cada función? (Suponer que todos los números son de tipo `Float`).
II. Indicar cuáles de las funciones anteriores *no* están currificadas. Para cada una de ellas, definir la función currificada correspondiente. Recordar dar el tipo de la función.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
El ejercicio busca que el estudiante identifique tipos de orden superior y entienda la diferencia entre funciones que reciben tuplas (no currificadas) y funciones que reciben argumentos de a uno (currificadas).

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 2 ★
I. Definir la función `curry`, que dada una función de dos argumentos, devuelve su equivalente currificada.
II. Definir la función `uncurry`, que dada una función currificada de dos argumentos, devuelve su versión no currificada equivalente. Es la inversa de la anterior.
III. ¿Se podría definir una función `curryN`, que tome una función de un número arbitrario de argumentos y devuelva su versión currificada?
**Sugerencia:** pensar cuál sería el tipo de la función.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Implementación de las funciones de alto nivel para transformar el modo en que se reciben los argumentos.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

## Esquemas de Recursión

### Ejercicio 3 ★
I. Redefinir usando `foldr` las funciones `sum`, `elem`, `(++)`, `filter` y `map`.
II. Definir la función `mejorSegun :: (a -> a -> Bool) -> [a] -> a`, que devuelve el máximo elemento de la lista según una función de comparación, utilizando `foldr1`. Por ejemplo, `maximum = mejorSegun (>)`.
III. Definir la función `sumasParciales :: Num a => [a] -> [a]`, que dada una lista de números devuelve otra de la misma longitud, que tiene en cada posición la suma parcial de los elementos de la lista original desde la cabeza hasta la posición actual. Por ejemplo, `sumasParciales [1,4,-1,0,5] ~> [1,5,4,4,9]`.
IV. Definir la función `sumaAlt`, que realiza la suma alternada de los elementos de una lista. Es decir, da como resultado: el primer elemento, menos el segundo, más el tercero, menos el cuarto, etc. Usar `foldr`.
V. Hacer lo mismo que en el punto anterior, pero en sentido inverso (el último elemento menos el anteúltimo, etc.). Pensar qué esquema de recursión conviene usar en este caso.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_funciones_sobre_arboles]]

**Explicación:**
Uso intensivo de `foldr` y `foldr1` para encapsular la recursión estructural sobre listas.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 4
I. Definir la función `permutaciones :: [a] -> [[a]]`, que dada una lista devuelve todas sus permutaciones. Se recomienda utilizar `concatMap :: (a -> [b]) -> [a] -> [b]`, y también `take` y `drop`.
II. Definir la función `partes`, que recibe una lista L y devuelve la lista de todas las listas formadas por los mismos elementos de L, en su mismo orden de aparición. Ejemplo (en algún orden):
```haskell
partes [5, 1, 2] -> [[], [5], [1], [2], [5, 1], [5, 2], [1, 2], [5, 1, 2]]
```
III. Definir la función `prefijos`, que dada una lista, devuelve todos sus prefijos. Ejemplo:
```haskell
prefijos [5, 1, 2] -> [[], [5], [5, 1], [5, 1, 2]]
```
IV. Definir la función `sublistas` que, dada una lista, devuelve todas sus sublistas (listas de elementos que aparecen consecutivos en la lista original). Ejemplo (en algún orden):
```haskell
sublistas [5, 1, 2] -> [[], [5], [1], [2], [5, 1], [1, 2], [5, 1, 2]]
```

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Problemas clásicos de combinatoria sobre listas resueltos mediante esquemas de recursión.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 5 ★
Considerar las siguientes funciones:

```haskell
elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs
                                    then [x]
                                    else x : elementosEnPosicionesPares (tail xs)

entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys -> if null ys
                           then x : entrelazar xs []
                           else x : head ys : entrelazar xs (tail ys)
```

Indicar si la recursión utilizada en cada una de ellas es o no estructural. Si lo es, reescribirla utilizando `foldr`. En caso contrario, explicar el motivo.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Análisis de la forma de recursión. La recursión estructural debe procesar exactamente un elemento de la estructura a la vez (en listas, `x:xs` -> `xs`).

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 6 ★
El siguiente esquema captura la recursión primitiva sobre listas.

```haskell
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)
```

a. Definir la función `sacarUna :: Eq a => a -> [a] -> [a]`, que dados un elemento y una lista devuelve el resultado de eliminar de la lista la primera aparición del elemento (si está presente).
b. Explicar por qué el esquema de recursión estructural (`foldr`) no es adecuado para implementar la función `sacarUna` del punto anterior.
c. Definir la función `insertarOrdenado :: Ord a => a -> [a] -> [a]` que inserta un elemento en una lista ordenada (de manera creciente), de manera que se preserva el ordenamiento.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_recursion_primitiva_rec]]

**Explicación:**
Introducción a la recursión primitiva (`recr`), que a diferencia de `foldr`, permite acceder a la cola (`xs`) además del resultado recursivo.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 7 ★
Definir las siguientes funciones para trabajar sobre listas, y dar su tipo. Todas ellas deben poder aplicarse a listas *finitas* e *infinitas*.

I. `mapPares`, una versión de `map` que toma una función currificada de dos argumentos y una lista de pares de valores, y devuelve la lista de aplicaciones de la función a cada par. **Pista:** recordar `curry` y `uncurry`.
II. `armarPares`, que dadas dos listas arma una lista de pares que contiene, en cada posición, el elemento correspondiente a esa posición en cada una de las listas. Si una de las listas es más larga que la otra, ignorar los elementos que sobran (el resultado tendrá la longitud de la lista más corta). Esta función en Haskell se llama `zip`. **Pista:** aprovechar la currificación y utilizar evaluación parcial.
III. `mapDoble`, una variante de `mapPares`, que toma una función currificada de dos argumentos y dos listas (de igual longitud), y devuelve una lista de aplicaciones de la función a cada elemento correspondiente de las dos listas. Esta función en Haskell se llama `zipWith`.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_currificacion_evaluacion_parcial]]

**Explicación:**
Uso de orden superior y evaluación parcial para implementar funciones de la librería estándar.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 8
I. Escribir la función `sumaMat`, que representa la suma de matrices, usando `zipWith`. Representaremos una matriz como la lista de sus filas. Esto quiere decir que cada matriz será una lista de listas finitas, todas de la misma longitud, con elementos enteros. Recordamos que la suma de matrices se define como la suma celda a celda. Asumir que las dos matrices a sumar están bien formadas y tienen las mismas dimensiones.
   `sumaMat :: [[Int]] -> [[Int]] -> [[Int]]`
II. Escribir la función `trasponer`, que, dada una matriz como las del ítem I, devuelva su traspuesta. Es decir, en la posición $i,j$ del resultado está el contenido de la posición $j,i$ de la matriz original. Notar que si la entrada es una lista de $N$ listas, todas de longitud $M$, la salida debe tener $M$ listas, todas de longitud $N$.
   `trasponer :: [[Int]] -> [[Int]]`

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Manipulación de listas de listas usando esquemas de recursión.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

## Otras Estructuras de Datos

### Ejercicio 9 ★
I. Definir y dar el tipo del esquema de recursión `foldNat` sobre los naturales. Utilizar el tipo `Integer` de Haskell (la función va a estar definida sólo para los enteros mayores o iguales que 0).
II. Utilizando `foldNat`, definir la función `potencia`.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_fold_tipo_arboles]]

**Explicación:**
Isomorfismo entre naturales y listas (donde `0` es `[]` y `n+1` es `x:xs`).

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 10
I. Definir la función `genLista :: a -> (a -> a) -> Integer -> [a]`, que genera una lista de una cantidad dada de elementos, a partir de un elemento inicial y de una función de incremento entre los elementos de la lista. Dicha función de incremento, dado un elemento de la lista, devuelve el elemento siguiente.
II. Usando `genLista`, definir la función `desdeHasta`, que dado un par de números (el primero menor que el segundo), devuelve una lista de números consecutivos desde el primero hasta el segundo.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Generación de listas (análogo a un `unfold` finito).

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 11
Definir el esquema de recursión estructural para el siguiente tipo:

```haskell
data Polinomio a = X
                 | Cte a
                 | Suma (Polinomio a) (Polinomio a)
                 | Prod (Polinomio a) (Polinomio a)
```

Luego usar el esquema definido para escribir la función `evaluar :: Num a => a -> Polinomio a -> a` que, dado un número y un polinomio, devuelve el resultado del evaluar el polinomio dado en el número dado.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_fold_tipo_arboles]]

**Explicación:**
Recursión sobre un tipo algebraico de datos (ADT) recursivo.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 12 ★
Considerar el siguiente tipo, que representa a los árboles binarios:
`data AB a = Nil | Bin (AB a) a (AB a)`

I. Usando recursión explícita, definir los esquemas de recursión estructural (`foldAB`) y primitiva (`recAB`), y dar sus tipos.
II. Definir las funciones `esNil`, `altura` y `cantNodos` (para `esNil` puede utilizarse `case` en lugar de `foldAB` o `recAB`).
III. Definir la función `mejorSegun :: (a -> a -> Bool) -> AB a -> a`, análoga a la del ejercicio 3, para árboles. Se recomienda definir una función auxiliar para comparar la raíz con un posible resultado de la recursión para un árbol que puede o no ser `Nil`.
IV. Definir la función `esABB :: Ord a => AB a -> Bool` que chequea si un árbol es un árbol binario de búsqueda. Recordar que, en un árbol binario de búsqueda, el valor de un nodo es mayor o igual que los valores que aparecen en el subárbol izquierdo y es estrictamente menor que los valores que aparecen en el subárbol derecho.
V. Justificar la elección de los esquemas de recursión utilizados para los tres puntos anteriores.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_fold_tipo_arboles]]

**Explicación:**
Recursión sobre árboles binarios. Diferencia entre fold (catamorfismo) y rec (paramorfismo).

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 13
Dado el tipo `AB a` del ejercicio 12:
I. Definir las funciones `ramas` (caminos desde la raíz hasta las hojas), `cantHojas` y `espejo`.
II. Definir la función `mismaEstructura :: AB a -> AB b -> Bool` que, dados dos árboles, indica si éstos tienen la misma forma, independientemente del contenido de sus nodos. **Pista:** usar evaluación parcial y recordar el ejercicio 7.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Operaciones comunes sobre árboles. `mismaEstructura` requiere un manejo cuidadoso de la recursión sobre dos estructuras simultáneamente.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 14
Se desea modelar en Haskell los árboles con información en las hojas (y sólo en ellas). Para esto introduciremos el siguiente tipo:
`data AIH a = Hoja a | Bin (AIH a) (AIH a)`

a) Definir el esquema de recursión estructural `foldAIH` y dar su tipo. Por tratarse del primer esquema de recursión que tenemos para este tipo, se permite usar recursión explícita.
b) Escribir las funciones `altura :: AIH a -> Integer` y `tamaño :: AIH a -> Integer`. Considerar que la altura de una hoja es 1 y el tamaño de un `AIH` es su cantidad de hojas.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_fold_tipo_arboles]]

**Explicación:**
Variante de árboles donde la información reside únicamente en los nodos terminales.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 15 ★
I. Definir el tipo `RoseTree` de árboles no vacíos, con una cantidad indeterminada de hijos para cada nodo.
II. Escribir el esquema de recursión estructural para `RoseTree`. **Importante:** escribir primero su tipo.
III. Usando el esquema definido, escribir las siguientes funciones:
    a) `hojas`, que dado un `RoseTree`, devuelva una lista con sus hojas ordenadas de izquierda a derecha, según su aparición en el `RoseTree`.
    b) `distancias`, que dado un `RoseTree`, devuelva las distancias de su raíz a cada una de sus hojas.
    c) `altura`, que devuelve la altura de un `RoseTree` (la cantidad de nodos de la rama más larga). Si el `RoseTree` es una hoja, se considera que su altura es 1.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_fold_tipo_arboles]]

**Explicación:**
Los RoseTrees son árboles donde cada nodo tiene una lista de hijos. La recursión es mutua o utiliza `map` sobre la lista de hijos.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 16 (Opcional)
Se desea representar conjuntos mediante Hashing abierto (*chain addressing*). El Hashing abierto consta de dos funciones: una *función de Hash*, que dado un elemento devuelve un valor entero (el cual se espera que no se repita con frecuencia), y una *tabla de Hash*, que dado un número entero devuelve los elementos del conjunto a los que la función de Hash asignó dicho número (es decir, la preimagen de la función de Hash para ese número).
Los representaremos en Haskell de la siguiente manera:
`data HashSet a = Hash (a -> Integer) (Integer -> [a])`
Por contexto de uso, vamos a suponer que la tabla de Hash es una función total, que devuelve listas vacías para los números que no corresponden a elementos del conjunto. Este es un **invariante** que deberá preservarse en todas las funciones que devuelvan conjuntos.

Definir las siguientes funciones:
I. `vacío :: (a -> Integer) -> HashSet a`, que devuelve un conjunto vacío con la función de Hash indicada.
II. `pertenece :: Eq a => a -> HashSet a -> Bool`, que indica si un elemento pertenece a un conjunto. Es decir, si se encuentra en la lista obtenida en la tabla de Hash para el número correspondiente a la función de Hash del elemento.
    Por ejemplo:
    `pertenece 5 $ agregar 1 $ agregar 2 $ agregar 1 $ vacío (flip mod 5)` devuelve `False`.
    `pertenece 2 $ agregar 1 $ agregar 2 $ agregar 1 $ vacío (flip mod 5)` devuelve `True`.
III. `agregar :: Eq a => a -> HashSet a -> HashSet a`, que agrega un elemento a un conjunto. Si el elemento ya estaba en el conjunto, se debe devolver el conjunto sin modificaciones.
IV. `intersección :: Eq a => HashSet a -> HashSet a -> HashSet a` que, dados dos conjuntos, devuelve un conjunto con la misma función de Hash del primero y con los elementos que pertenecen a ambos conjuntos a la vez.
V. `foldr1` (no relacionada con los conjuntos). Dar el tipo y definir la función `foldr1` para listas **sin usar recursión explícita**, recurriendo a alguno de los esquemas de recursión conocidos.
Se recomienda usar la función `error :: String -> a` para el caso de la lista vacía.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Uso de funciones como representación de datos (conjuntos funcionales). El ejercicio desafía la noción de ADT tradicional.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

## Generación Infinita

### Ejercicio 17
¿Cuál es el valor de esta expresión?
`[ x | x <- [1..3], y <- [x..3], (x + y) `mod` 3 == 0 ]`

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Comprensión de listas con generadores dependientes y filtros.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 18 ★
Definir la lista infinita `paresDeNat :: [(Int, Int)]`, que contenga todos los pares de números naturales: (0,0), (0,1), (1,0), etc.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Enumeración de un conjunto infinito numerable ($N \times N$). El orden es crucial para que cualquier par sea alcanzado eventualmente.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 19
Una tripla pitagórica es una tripla (a, b, c) de enteros positivos tal que $a^2 + b^2 = c^2$.
La siguiente expresión intenta ser una definición de una lista (infinita) de triplas pitagóricas:
`pitagóricas :: [(Integer, Integer, Integer)]`
`pitagóricas = [(a, b, c) | a <- [1..], b <- [1..], c <- [1..], a^2 + b^2 == c^2]`
Explicar por qué esta definición no es útil. Dar una definición mejor.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Problema de "estrella de la muerte" en generadores infinitos. El tercer generador nunca termina si los dos primeros no avanzan.

**Resolución:**
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 20 ★
Escribir la función `listasQueSuman :: Int -> [[Int]]` que, dado un número natural $n$, devuelve todas las listas de enteros positivos (es decir, mayores o iguales que 1) cuya suma sea $n$. Para este ejercicio **se permite usar recursión explícita**. Pensar por qué la recursión utilizada no es estructural. (Este ejercicio no es de generación infinita, pero puede ser útil para otras funciones que generen listas infinitas de listas).

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Particiones de un entero. La recursión no es estructural sobre el argumento $n$ de la misma forma que en listas.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 21 ★
Definir en Haskell una lista que contenga todas las listas finitas de enteros positivos (esto es, con elementos mayores o iguales que 1).

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Enumeración de $\bigcup_{n=0}^{\infty} N^n$.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 22
Dado el tipo de datos `AIH a` definido en el ejercicio 14:
a) Definir la lista (infinita) de todos los `AIH` cuyas hojas tienen tipo $()^1$. Se recomienda definir una función auxiliar. Para este ejercicio **se permite utilizar recursión explícita**.
b) Explicar por qué la recursión utilizada en el punto a) no es estructural.

$^1$ El tipo `()`, usualmente conocido como *unit*, tiene un único valor, denotado como `()`.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Generación de todas las posibles estructuras de árboles binarios con información en las hojas.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/haskell_fold_tipo_arboles]] · [[tipos_ejercicio/haskell_funciones_sobre_arboles]] · [[tipos_ejercicio/haskell_currificacion_evaluacion_parcial]] · [[tipos_ejercicio/haskell_recursion_primitiva_rec]]
