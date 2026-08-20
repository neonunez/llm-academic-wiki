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
**I. Tipo de cada función** (asumiendo que todos los números son `Float`)

```haskell
max2           :: (Float, Float) -> Float
normaVectorial :: (Float, Float) -> Float
subtract       :: Float -> Float -> Float
predecesor     :: Float -> Float
evaluarEnCero  :: (Float -> a) -> a
dosVeces       :: (a -> a) -> a -> a
flipAll        :: [a -> b -> c] -> [b -> a -> c]
flipRaro       :: b -> (a -> b -> c) -> a -> c
```

*Cómo se derivan los casos no triviales:*

- `subtract = flip (-)`: como `(-) :: Float -> Float -> Float` y `flip :: (a -> b -> c) -> b -> a -> c`, instanciando $a = b = c = $ `Float` queda `Float -> Float -> Float`.
- `predecesor = subtract 1`: evaluación parcial de `subtract`, se consume un `Float` y queda `Float -> Float`. Notar que `predecesor 5 = 5 - 1 = 4` (por el `flip`, el argumento fijo queda a la derecha del `-`).
- `evaluarEnCero = \f -> f 0`: `f` se aplica a `0 :: Float`, así que `f :: Float -> a` y el resultado es `a`.
- `dosVeces = \f -> f . f`: para poder componer `f` consigo misma, dominio y codominio deben coincidir: `f :: a -> a`. El resultado `f . f :: a -> a`.
- `flipAll = map flip`: `map :: (x -> y) -> [x] -> [y]` con `x = (a -> b -> c)` e `y = (b -> a -> c)`.
- `flipRaro = flip flip`: el `flip` externo espera como primer argumento algo de tipo $(x \to y \to z)$. Le pasamos el `flip` interno, cuyo tipo es $(a \to b \to c) \to b \to (a \to c)$. Unificando: $x = (a \to b \to c)$, $y = b$, $z = (a \to c)$. Como `flip f :: y -> x -> z`, resulta

$$\texttt{flipRaro} :: b \to (a \to b \to c) \to a \to c$$

  Es decir, `flipRaro` recibe **primero** el segundo argumento y **después** la función.

**II. Funciones no currificadas**

Las que reciben una **tupla** como único argumento: `max2` y `normaVectorial`. Sus versiones currificadas:

```haskell
max2' :: Float -> Float -> Float
max2' x y | x >= y    = x
          | otherwise = y

normaVectorial' :: Float -> Float -> Float
normaVectorial' x y = sqrt (x^2 + y^2)
```

Equivalentemente, usando el `curry` del ejercicio 2: `max2' = curry max2` y `normaVectorial' = curry normaVectorial`.

Las demás **ya están currificadas**: reciben sus argumentos de a uno y devuelven funciones intermedias, lo que habilita la evaluación parcial (`predecesor = subtract 1` es exactamente eso).

**Chuleta:**
> 1. Tipos: `->` asocia a derecha, la aplicación a izquierda → leer `a -> b -> c` como `a -> (b -> c)`.
> 2. `flip :: (a->b->c) -> b -> a -> c`; `flip flip :: b -> (a->b->c) -> a -> c` (unificar el argumento del flip externo con el tipo del interno).
> 3. No currificadas = las que reciben tupla: `max2` y `normaVectorial` → currificar con `curry` o reescribiendo `f x y = ...`.

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
**I. `curry`**

```haskell
curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x, y)
```

Toma una función que espera un par y devuelve una que recibe los dos componentes de a uno.

**II. `uncurry`**

```haskell
uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x, y) = f x y
```

Son inversas entre sí: `curry (uncurry f) = f` y `uncurry (curry g) = g`.

**III. ¿Se puede definir `curryN`?**

**No**, no en Haskell (con su sistema de tipos Hindley-Milner). El motivo es de **tipado**, no de programación:

- El tipo de `curryN` dependería de $n$, la cantidad de argumentos: para $n = 2$ sería `((a,b) -> c) -> a -> b -> c`, para $n = 3$ sería `((a,b,c) -> d) -> a -> b -> c -> d`, etc. Cada aridad da un tipo **distinto y no unificable** con los otros.
- Las tuplas de distinta aridad son tipos completamente distintos (`(,)`, `(,,)`, `(,,,)` son constructores de tipo diferentes), no una familia indexada por un número.
- Escribir un único tipo que abarque todas las aridades requeriría **tipos dependientes** (que el tipo dependa de un valor $n$), algo que Haskell estándar no tiene.

Por eso en la librería estándar existen `curry`/`curry3`/... a mano, pero no un `curryN` genérico.

**Chuleta:**
> 1. `curry f x y = f (x,y)` :: `((a,b) -> c) -> a -> b -> c`.
> 2. `uncurry f (x,y) = f x y` :: `(a -> b -> c) -> (a,b) -> c`. Son inversas.
> 3. `curryN` no existe: su tipo dependería de la aridad $n$ → haría falta tipos dependientes; las tuplas de distinta aridad son tipos distintos.

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
**I. Redefiniciones con `foldr`**

```haskell
sum' :: Num a => [a] -> a
sum' = foldr (+) 0

elem' :: Eq a => a -> [a] -> Bool
elem' e = foldr (\x rec -> x == e || rec) False

(+++) :: [a] -> [a] -> [a]
xs +++ ys = foldr (:) ys xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x rec -> if p x then x : rec else rec) []

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x rec -> f x : rec) []
```

*Idea:* en `(++)` el caso base **no** es `[]` sino `ys`, porque `foldr` reemplaza el `[]` del final de `xs` por el valor `z`, y `(:)` queda intacto. Notar además que `elem'` funciona sobre listas infinitas gracias a que `(||)` es no estricto en su segundo argumento.

**II. `mejorSegun`**

```haskell
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec)
```

Se usa `foldr1` (y no `foldr`) porque no hay un elemento neutro genérico para "el mejor": el caso base debe ser el último elemento de la lista. Con esto, `maximum = mejorSegun (>)` y `minimum = mejorSegun (<)`.

**III. `sumasParciales`**

```haskell
sumasParciales :: Num a => [a] -> [a]
sumasParciales = foldr (\x rec -> x : map (+x) rec) []
```

*Justificación del esquema:* es recursión estructural. La suma parcial de la posición $i$ es $x_0 + \dots + x_i$; si ya tengo las sumas parciales de la cola, alcanza con sumarle `x` a todas y anteponer `x`.

Traza con `[1,4,-1,0,5]` (de derecha a izquierda):

```
[5]          ~> [5]
[0,5]        ~> 0 : map (+0) [5]        = [0,5]
[-1,0,5]     ~> -1 : map (-1+) [0,5]    = [-1,-1,4]
[4,-1,0,5]   ~> 4 : map (+4) [-1,-1,4]  = [4,3,3,8]
[1,4,-1,0,5] ~> 1 : map (+1) [4,3,3,8]  = [1,5,4,4,9]   ✓
```

(Es $O(n^2)$; una versión $O(n)$ usa `foldl` con acumulador: `sumasParciales = tail . scanl (+) 0`.)

**IV. `sumaAlt` con `foldr`**

```haskell
sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0
```

Porque `foldr (-) 0 [a,b,c] = a - (b - (c - 0)) = a - b + c`, exactamente la suma alternada empezando por el primero. `foldr` es el esquema natural: el signo alterna "desde la cabeza".

**V. Suma alternada en sentido inverso**

Conviene **`foldl`** (recursión a la cola): recorre desde la izquierda acumulando, de modo que el último elemento queda aplicado "más afuera".

```haskell
sumaAltInv :: Num a => [a] -> a
sumaAltInv = foldl (flip (-)) 0
```

Traza: `foldl (flip (-)) 0 [a,b,c]` $= c - (b - (a - 0)) = c - b + a$ ✓ (último menos anteúltimo más el anterior…).

Equivalentemente `sumaAltInv = sumaAlt . reverse`, pero la versión con `foldl` no necesita invertir la lista.

**Chuleta:**
> 1. `sum = foldr (+) 0` · `elem e = foldr (\x r -> x == e || r) False` · `xs ++ ys = foldr (:) ys xs` · `filter p = foldr (\x r -> if p x then x:r else r) []` · `map f = foldr ((:) . f) []`.
> 2. `mejorSegun f = foldr1 (\x r -> if f x r then x else r)` (foldr1 porque no hay neutro).
> 3. `sumasParciales = foldr (\x r -> x : map (+x) r) []`.
> 4. `sumaAlt = foldr (-) 0` → `a - (b - (c - 0))`.
> 5. Inversa: `foldl (flip (-)) 0` → `c - (b - (a - 0))`. Regla: alternar desde la cabeza = `foldr`; desde el final = `foldl`.

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
**I. `permutaciones`**

```haskell
permutaciones :: [a] -> [[a]]
permutaciones = foldr (\x rec -> concatMap (intercalar x) rec) [[]]

intercalar :: a -> [a] -> [[a]]
intercalar x xs = map (\i -> take i xs ++ [x] ++ drop i xs) [0 .. length xs]
```

*Justificación:* recursión estructural sobre la lista. Si ya tengo todas las permutaciones de la cola, las permutaciones de `x:xs` se obtienen insertando `x` en **todas las posiciones posibles** de cada una de ellas (de ahí `take`/`drop` y `concatMap`).

Ejemplo: `permutaciones [1,2]` $\Rightarrow$ `[[1,2],[2,1]]`.

**II. `partes`** (subsecuencias, preservando el orden)

```haskell
partes :: [a] -> [[a]]
partes = foldr (\x rec -> rec ++ map (x:) rec) [[]]
```

*Idea:* cada subconjunto de `x:xs` o bien no contiene a `x` (son las partes de `xs`) o bien lo contiene (partes de `xs` con `x` adelante). La cantidad de resultados es $2^n$.

`partes [5,1,2]` $\Rightarrow$ `[[],[2],[1],[1,2],[5],[5,2],[5,1],[5,1,2]]` (mismo conjunto que el enunciado, en otro orden).

**III. `prefijos`**

```haskell
prefijos :: [a] -> [[a]]
prefijos = foldr (\x rec -> [] : map (x:) rec) [[]]
```

*Idea:* los prefijos de `x:xs` son el prefijo vacío más cada prefijo de `xs` con `x` adelante.

Traza `[5,1,2]`: `[2] ~> [[],[2]]`, `[1,2] ~> [[],[1],[1,2]]`, `[5,1,2] ~> [[],[5],[5,1],[5,1,2]]` ✓

**IV. `sublistas`** (segmentos contiguos)

Una sublista contigua no vacía es un **prefijo no vacío de algún sufijo**:

```haskell
sufijos :: [a] -> [[a]]
sufijos = foldr (\x rec -> (x : head rec) : rec) [[]]

sublistas :: [a] -> [[a]]
sublistas xs = [] : filter (not . null) (concatMap prefijos (sufijos xs))
```

Traza `[5,1,2]`: `sufijos = [[5,1,2],[1,2],[2],[]]`; sus prefijos no vacíos son `[5],[5,1],[5,1,2],[1],[1,2],[2]`; agregando `[]` quedan las 7 sublistas del enunciado ✓

**Chuleta:**
> 1. `permutaciones = foldr (\x r -> concatMap (intercalar x) r) [[]]` con `intercalar x xs = map (\i -> take i xs ++ [x] ++ drop i xs) [0..length xs]`.
> 2. `partes = foldr (\x r -> r ++ map (x:) r) [[]]` (con/sin `x`, $2^n$ resultados).
> 3. `prefijos = foldr (\x r -> [] : map (x:) r) [[]]`.
> 4. `sublistas`: prefijos no vacíos de cada sufijo, más `[]`. `sufijos = foldr (\x r -> (x : head r) : r) [[]]`.

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
**`elementosEnPosicionesPares`: NO es recursión estructural.**

Motivo: el llamado recursivo es sobre `tail xs`, **no** sobre `xs`. La recursión estructural sobre listas exige que, dado el patrón `(x:xs)`, el único llamado recursivo permitido sea sobre `xs` (y que no se use `xs` de otra manera). Acá se consumen **dos** elementos por paso y además se inspecciona la cola (`null xs`, `tail xs`), lo cual queda fuera del esquema de `foldr`.

Tampoco es recursión primitiva "directa" con `recr`: aunque `recr` da acceso a `xs`, el llamado recursivo que `recr` provee es sobre `xs` y acá se necesita el resultado sobre `tail xs`. Sí se puede escribir con `foldr` **cambiando el tipo del resultado** a una función que lleve un estado de paridad (truco estándar):

```haskell
elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares xs =
  foldr (\x rec par -> if par then x : rec False else rec True) (const []) xs True
```

pero eso ya no es la misma definición: es otra función que sí es estructural.

**`entrelazar`: SÍ es recursión estructural.**

El llamado recursivo es exactamente sobre `xs`, el caso base (`id`) es fijo, y la lista `ys` se maneja como parte del **resultado**, que es una función. El tipo del `foldr` es `b = [a] -> [a]` (evaluación parcial / *fold* que devuelve función):

```haskell
entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr (\x rec ys -> if null ys
                                 then x : rec []
                                 else x : head ys : rec (tail ys))
                   id
```

Chequeo de tipos: `foldr :: (a -> b -> b) -> b -> [a] -> b` con `b = [a] -> [a]`; el caso base `id :: [a] -> [a]` ✓ y la función combinadora `a -> ([a] -> [a]) -> ([a] -> [a])` ✓.

**Chuleta:**
> 1. Estructural = el único llamado recursivo es sobre `xs` y no se usa `xs` de otra forma.
> 2. `elementosEnPosicionesPares`: **NO** (recurre sobre `tail xs`, consume 2 elementos por paso).
> 3. `entrelazar`: **SÍ** → `foldr (\x rec ys -> if null ys then x : rec [] else x : head ys : rec (tail ys)) id`, con `b = [a] -> [a]`.

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
**a. `sacarUna`**

```haskell
sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr (\x xs rec -> if x == e then xs else x : rec) []
```

Traza con `sacarUna 2 [1,2,3,2]`: en `x=1` no coincide → `1 : rec`; en `x=2` coincide → devuelve la **cola original** `[3,2]` sin seguir recursión. Resultado `[1,3,2]` ✓

**b. ¿Por qué `foldr` no alcanza?**

Porque al encontrar la primera aparición hay que devolver **la cola original intacta**, y `foldr` sólo ofrece el *resultado del llamado recursivo* sobre la cola (`rec`), nunca la cola misma (`xs`). Si se escribiera

```haskell
sacarUna e = foldr (\x rec -> if x == e then rec else x : rec) []   -- ✗ MAL
```

se eliminarían **todas** las apariciones, porque `rec` ya tiene la ocurrencia sacada de la cola. La recursión primitiva (`recr`) es exactamente el esquema que agrega ese acceso a `xs`, y por eso es el adecuado.

(Con `foldr` se puede simular llevando información extra en el tipo del resultado — p. ej. devolviendo el par `([a], Bool)` o una función —, pero la definición natural es la primitiva.)

**c. `insertarOrdenado`**

```haskell
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr (\x xs rec -> if e <= x then e : x : xs else x : rec) [e]
```

También necesita `recr`: al encontrar la posición de inserción hay que **pegar el resto de la lista tal cual** (`x : xs`), sin seguir recorriéndola. El caso base `[e]` cubre el caso en que `e` es mayor que todos los elementos.

Traza `insertarOrdenado 3 [1,2,5,7]` → `1 : (2 : (3 : 5 : [7]))` = `[1,2,3,5,7]` ✓

**Chuleta:**
> 1. `recr f z (x:xs) = f x xs (recr f z xs)` → da acceso a **la cola original** `xs`, no sólo al `rec`.
> 2. `sacarUna e = recr (\x xs rec -> if x == e then xs else x : rec) []`.
> 3. Con `foldr` saldría "sacar **todas**" porque `rec` ya viene modificado y no se puede recuperar `xs`.
> 4. `insertarOrdenado e = recr (\x xs rec -> if e <= x then e : x : xs else x : rec) [e]`.
> 5. Regla: si al cortar necesito devolver el resto original → `recr`.

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
**I. `mapPares`**

```haskell
mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)
```

`uncurry f :: (a,b) -> c` es justo lo que `map` necesita para una lista de pares. Funciona sobre listas infinitas porque `map` (definido con `foldr`) es perezoso: produce la cabeza sin evaluar la cola.

**II. `armarPares` (`zip`)**

```haskell
armarPares :: [a] -> [b] -> [(a, b)]
armarPares = foldr (\x rec ys -> if null ys
                                 then []
                                 else (x, head ys) : rec (tail ys))
                   (const [])
```

*Justificación:* recursión estructural sobre la **primera** lista, con `b = [b] -> [(a,b)]` (el *fold* devuelve una función; esto es la "evaluación parcial" que pide la pista). La segunda lista se consume como estado del resultado.

Los dos casos de corte están cubiertos: si se acaba la primera lista, el caso base `const []` ignora lo que quede de `ys`; si se acaba la segunda, `null ys` corta. Sirve para listas infinitas en cualquiera de los dos argumentos (mientras la otra sea finita, o para tomar prefijos con `take`).

**III. `mapDoble` (`zipWith`)**

```haskell
mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)
```

o, directamente y sin construir la lista intermedia:

```haskell
mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f = foldr (\x rec ys -> if null ys
                                 then []
                                 else f x (head ys) : rec (tail ys))
                   (const [])
```

Ambas versiones son perezosas y aptas para listas infinitas.

**Chuleta:**
> 1. `mapPares f = map (uncurry f)`.
> 2. `armarPares = foldr (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) (const [])` → **fold que devuelve una función** (`b = [b] -> [(a,b)]`).
> 3. `mapDoble f xs ys = mapPares f (armarPares xs ys)`.
> 4. Truco general: para recorrer **dos** estructuras a la vez con un solo `foldr`, hacer que el resultado sea una función que reciba la segunda.

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
**I. `sumaMat`**

```haskell
sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith (zipWith (+))
```

El `zipWith` externo aparea filas; el interno suma celda a celda dentro de cada fila. Se aprovecha la currificación: `zipWith (+) :: [Int] -> [Int] -> [Int]` es exactamente la función combinadora que espera el `zipWith` externo.

**II. `trasponer`**

```haskell
trasponer :: [[Int]] -> [[Int]]
trasponer = foldr (\fila rec -> zipWith (:) fila rec) (repeat [])
```

*Justificación:* recursión estructural sobre la lista de filas. Si `rec` es la traspuesta de las filas restantes (una lista de $M$ columnas), agregar la fila actual consiste en anteponer su $j$-ésimo elemento a la $j$-ésima columna: eso es exactamente `zipWith (:) fila rec`. El caso base `repeat []` da "infinitas columnas vacías", pero `zipWith` **trunca** a la longitud de `fila`, así que el resultado final tiene exactamente $M$ columnas.

Traza con `[[1,2],[3,4]]`:

```
[[3,4]]       ~> zipWith (:) [3,4] (repeat []) = [[3],[4]]
[[1,2],[3,4]] ~> zipWith (:) [1,2] [[3],[4]]   = [[1,3],[2,4]]   ✓
```

⚠️ Verificar — con la matriz vacía (`trasponer []`) esta definición devuelve `repeat []`, una lista infinita. Si se exige el caso `trasponer [] = []`, agregar el pattern matching explícito antes del `foldr`, o usar como caso base `replicate m []` calculando `m = length (head m)`.

**Chuleta:**
> 1. `sumaMat = zipWith (zipWith (+))` → externo aparea filas, interno suma celdas.
> 2. `trasponer = foldr (\fila rec -> zipWith (:) fila rec) (repeat [])` → cada elemento de la fila encabeza su columna; `repeat []` se trunca solo.
> 3. Cuidado: `trasponer []` con esa base da lista infinita → agregar caso `trasponer [] = []` si hace falta.

---

## Otras Estructuras de Datos

### Ejercicio 9 ★
I. Definir y dar el tipo del esquema de recursión `foldNat` sobre los naturales. Utilizar el tipo `Integer` de Haskell (la función va a estar definida sólo para los enteros mayores o iguales que 0).
II. Utilizando `foldNat`, definir la función `potencia`.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/haskell_fold_tipo_arboles]]

**Explicación:**
Isomorfismo entre naturales y listas (donde `0` es `[]` y `n+1` es `x:xs`).

**Resolución:**
**I. `foldNat`**

Los naturales son un tipo inductivo isomorfo a `data Nat = Zero | Succ Nat` (el `0` cumple el rol de `[]` y `Succ n` el de `x:xs`). Su esquema de recursión estructural es:

```haskell
foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat _ z 0 = z
foldNat f z n
  | n > 0     = f n (foldNat f z (n - 1))
  | otherwise = error "foldNat: no definido para negativos"
```

Se le pasa `n` a la función combinadora porque, a diferencia de las listas, el "elemento" que aporta cada `Succ` es el propio número (esto permite definir, por ejemplo, `factorial = foldNat (*) 1`).

⚠️ Verificar — hay dos convenciones habituales. La otra es `foldNat :: b -> (b -> b) -> Integer -> b` con `foldNat z f n = f (f (... (f z)))`, que **no** le pasa `n` al combinador (es el iterador puro de Church). Ambas son aceptadas; con la segunda, `potencia` queda `potencia b = foldNat 1 (*b)`.

**II. `potencia`**

```haskell
potencia :: Num a => a -> Integer -> a
potencia b = foldNat (\_ rec -> b * rec) 1
```

`potencia b n` multiplica `b` por sí mismo `n` veces sobre el caso base `1`. El primer parámetro del combinador se ignora porque el valor del exponente no interviene en el cálculo, sólo su magnitud.

Traza: `potencia 2 3 = 2 * (2 * (2 * 1)) = 8` ✓ (y `potencia b 0 = 1` ✓).

**Chuleta:**
> 1. `foldNat :: (Integer -> b -> b) -> b -> Integer -> b`; `foldNat _ z 0 = z`; `foldNat f z n = f n (foldNat f z (n-1))`.
> 2. Nat ≅ lista sin contenido: `0` ↔ `[]`, `n` ↔ `x:xs`.
> 3. `potencia b = foldNat (\_ rec -> b * rec) 1`. Bonus: `factorial = foldNat (*) 1`.

---

### Ejercicio 10
I. Definir la función `genLista :: a -> (a -> a) -> Integer -> [a]`, que genera una lista de una cantidad dada de elementos, a partir de un elemento inicial y de una función de incremento entre los elementos de la lista. Dicha función de incremento, dado un elemento de la lista, devuelve el elemento siguiente.
II. Usando `genLista`, definir la función `desdeHasta`, que dado un par de números (el primero menor que el segundo), devuelve una lista de números consecutivos desde el primero hasta el segundo.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Generación de listas (análogo a un `unfold` finito).

**Resolución:**
**I. `genLista`**

Recursión estructural sobre el `Integer` (con `foldNat` del ejercicio 9), donde el resultado del *fold* es una **función** que recibe el elemento actual:

```haskell
genLista :: a -> (a -> a) -> Integer -> [a]
genLista x f n = foldNat (\_ rec -> \y -> y : rec (f y)) (const []) n x
```

Tipos: el `foldNat` se usa con `b = a -> [a]`; el caso base `const [] :: a -> [a]` corta cuando ya se generaron los `n` elementos, y cada paso emite el elemento actual `y` y le pasa `f y` al resto.

Traza `genLista 0 (+1) 3`:

```
g0 = const []
g1 = \y -> y : g0 (y+1)
g2 = \y -> y : g1 (y+1)
g3 = \y -> y : g2 (y+1)
g3 0 = 0 : g2 1 = 0 : 1 : g1 2 = 0 : 1 : 2 : g0 3 = [0,1,2]   ✓
```

(Versión equivalente con recursión explícita, si se permite: `genLista x f n = take (fromIntegral n) (iterate f x)`.)

**II. `desdeHasta`**

```haskell
desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta x y = genLista x (+1) (y - x + 1)
```

Se generan $y - x + 1$ elementos empezando en `x` con incremento `(+1)`. Por ejemplo `desdeHasta 2 5 = [2,3,4,5]` ✓ (con la precondición `x <= y` del enunciado).

**Chuleta:**
> 1. `genLista x f n = foldNat (\_ rec -> \y -> y : rec (f y)) (const []) n x` → *fold* sobre `n` que devuelve una función `a -> [a]`.
> 2. `desdeHasta x y = genLista x (+1) (y - x + 1)`.
> 3. Equivalente informal: `take n (iterate f x)`.

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
**Esquema de recursión estructural**

Regla general: un argumento por constructor; los campos recursivos se reemplazan por el resultado de la recursión, los no recursivos se dejan como están.

```haskell
foldPoli :: b                     -- caso X
         -> (a -> b)              -- caso Cte
         -> (b -> b -> b)         -- caso Suma
         -> (b -> b -> b)         -- caso Prod
         -> Polinomio a
         -> b
foldPoli cX cCte cSuma cProd poli = case poli of
  X        -> cX
  Cte c    -> cCte c
  Suma p q -> cSuma (rec p) (rec q)
  Prod p q -> cProd (rec p) (rec q)
  where rec = foldPoli cX cCte cSuma cProd
```

**`evaluar`**

```haskell
evaluar :: Num a => a -> Polinomio a -> a
evaluar x = foldPoli x id (+) (*)
```

Lectura: la incógnita `X` se reemplaza por el número `x`; una constante se evalúa en sí misma (`id`); la suma de polinomios se evalúa como la suma de las evaluaciones y el producto análogamente. Es recursión estructural pura: para evaluar un nodo alcanza con los resultados de sus hijos, no hace falta el subárbol original.

Ejemplo: sea `p = Suma (Prod X X) (Cte 3)`, es decir $p(x) = x^2 + 3$. Entonces `evaluar 2 p = (2*2) + 3 = 7` ✓

**Chuleta:**
> 1. Un parámetro por constructor: `foldPoli :: b -> (a -> b) -> (b->b->b) -> (b->b->b) -> Polinomio a -> b`.
> 2. Campos recursivos → resultado de la recursión; campos no recursivos → tal cual.
> 3. `evaluar x = foldPoli x id (+) (*)`.

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
**I. Esquemas**

```haskell
data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB cNil cBin Nil           = cNil
foldAB cNil cBin (Bin i r d)   = cBin (foldAB cNil cBin i) r (foldAB cNil cBin d)

recAB :: b -> (AB a -> b -> a -> AB a -> b -> b) -> AB a -> b
recAB cNil cBin Nil            = cNil
recAB cNil cBin (Bin i r d)    = cBin i (recAB cNil cBin i) r d (recAB cNil cBin d)
```

Diferencia: `recAB` le entrega al combinador, además de los resultados recursivos, **los subárboles originales** `i` y `d`.

**II. `esNil`, `altura`, `cantNodos`**

```haskell
esNil :: AB a -> Bool
esNil t = case t of
            Nil -> True
            _   -> False

altura :: AB a -> Int
altura = foldAB 0 (\ri _ rd -> 1 + max ri rd)

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\ri _ rd -> 1 + ri + rd)
```

**III. `mejorSegun` para árboles**

El problema es el caso `Nil`: no hay un valor de tipo `a` para devolver. La solución limpia es plegar hacia `Maybe a` y desenvolver al final (la "función auxiliar para comparar la raíz con un posible resultado de la recursión" que sugiere el enunciado):

```haskell
mejorM :: (a -> a -> Bool) -> Maybe a -> Maybe a -> Maybe a
mejorM _ Nothing  my       = my
mejorM _ mx       Nothing  = mx
mejorM f (Just x) (Just y) = Just (if f x y then x else y)

mejorSegun :: (a -> a -> Bool) -> AB a -> a
mejorSegun f = fromJust . foldAB Nothing (\ri r rd -> mejorM f (Just r) (mejorM f ri rd))
```

(`fromJust` es de `Data.Maybe`; sobre `Nil` la función se indefine, igual que `maximum []`.)

**IV. `esABB`**

```haskell
esABB :: Ord a => AB a -> Bool
esABB = recAB True (\i ri r d rd -> ri && rd && todos (<= r) i && todos (> r) d)
  where todos p = foldAB True (\li x ld -> p x && li && ld)
```

Se usa `recAB` porque hay que volver a mirar **los subárboles originales** `i` y `d` para comparar todos sus valores contra la raíz `r`; los booleanos `ri`/`rd` no alcanzan. Según el enunciado: los del izquierdo deben ser $\leq r$ y los del derecho estrictamente $> r$.

Versión $O(n)$ (alternativa, plegando hacia una terna):

```haskell
esABB' :: Ord a => AB a -> Bool
esABB' = fst3 . foldAB (True, Nothing, Nothing)
                       (\(bi, mini, maxi) r (bd, mind, maxd) ->
                          ( bi && bd
                            && maybe True (<= r) maxi
                            && maybe True (>  r) mind
                          , Just (minimum (r : catMaybes [mini, mind]))
                          , Just (maximum (r : catMaybes [maxi, maxd])) ))
  where fst3 (b, _, _) = b
```

**V. Justificación de los esquemas elegidos**

| Función | Esquema | Por qué |
|---|---|---|
| `esNil` | `case` | No hay recursión: alcanza con distinguir el constructor de la raíz. |
| `altura`, `cantNodos` | `foldAB` | El valor del nodo depende sólo de los **resultados** sobre los hijos → recursión estructural pura. |
| `mejorSegun` | `foldAB` (a `Maybe a`) | Ídem: sólo se combinan resultados; el `Maybe` resuelve la falta de neutro en `Nil`. |
| `esABB` | `recAB` | Se necesitan **los subárboles originales** para comparar todos sus valores con la raíz. Con `foldAB` sólo se tendría "¿es ABB el hijo?", que no basta. (Salvo que se enriquezca el tipo del resultado con mín/máx, como en `esABB'`.) |

**Chuleta:**
> 1. `foldAB :: b -> (b -> a -> b -> b) -> AB a -> b`; `recAB :: b -> (AB a -> b -> a -> AB a -> b -> b) -> AB a -> b` (agrega los subárboles originales).
> 2. `altura = foldAB 0 (\ri _ rd -> 1 + max ri rd)` · `cantNodos = foldAB 0 (\ri _ rd -> 1 + ri + rd)` · `esNil` con `case`.
> 3. `mejorSegun f = fromJust . foldAB Nothing (\ri r rd -> mejorM f (Just r) (mejorM f ri rd))` — el `Maybe` cubre el `Nil`.
> 4. `esABB = recAB True (\i ri r d rd -> ri && rd && todos (<=r) i && todos (>r) d)` → **recAB** porque hay que revisitar los subárboles.
> 5. Regla de oro: ¿me alcanza con el resultado de los hijos? → `fold`. ¿Necesito los hijos en sí? → `rec`.

---

### Ejercicio 13
Dado el tipo `AB a` del ejercicio 12:
I. Definir las funciones `ramas` (caminos desde la raíz hasta las hojas), `cantHojas` y `espejo`.
II. Definir la función `mismaEstructura :: AB a -> AB b -> Bool` que, dados dos árboles, indica si éstos tienen la misma forma, independientemente del contenido de sus nodos. **Pista:** usar evaluación parcial y recordar el ejercicio 7.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Operaciones comunes sobre árboles. `mismaEstructura` requiere un manejo cuidadoso de la recursión sobre dos estructuras simultáneamente.

**Resolución:**
**I. `ramas`, `cantHojas`, `espejo`**

```haskell
ramas :: AB a -> [[a]]
ramas = foldAB [] (\ri r rd -> if null ri && null rd
                               then [[r]]                 -- hoja: una sola rama
                               else map (r:) (ri ++ rd))

cantHojas :: AB a -> Int
cantHojas = foldAB 0 (\ri _ rd -> if ri + rd == 0 then 1 else ri + rd)

espejo :: AB a -> AB a
espejo = foldAB Nil (\ri r rd -> Bin rd r ri)
```

*Justificación:* las tres son recursión estructural pura (`foldAB`): el resultado de un nodo se arma combinando los resultados de sus hijos, sin necesitar los subárboles originales.

- `ramas`: si ambos hijos dieron listas vacías, el nodo es una hoja y su única rama es `[r]`; si no, se antepone `r` a cada rama de los hijos. Notar que un nodo con un solo hijo **no** cuenta como hoja, y eso queda bien resuelto porque el hijo `Nil` aporta `[]` al `++`.
- `cantHojas`: hoja ⟺ ambos hijos aportan 0.
- `espejo`: intercambia los resultados de los hijos en cada nivel.

**II. `mismaEstructura`**

Mismo truco que en el ejercicio 7: el `foldAB` devuelve una **función** que consume el segundo árbol (evaluación parcial), con `b = AB b -> Bool`.

```haskell
mismaEstructura :: AB a -> AB b -> Bool
mismaEstructura = foldAB esNil
                        (\ri _ rd t -> case t of
                            Nil       -> False
                            Bin i _ d -> ri i && rd d)
```

Chequeo de tipos: caso base `esNil :: AB b -> Bool` ✓; combinador `(AB b -> Bool) -> a -> (AB b -> Bool) -> (AB b -> Bool)` ✓.

Lectura: si el primer árbol es `Nil`, el segundo debe ser `Nil` (`esNil`); si el primero es un `Bin`, el segundo también debe serlo y, además, sus hijos deben coincidir estructuralmente con los del primero. Los valores (`_`) nunca se miran, por eso los tipos `a` y `b` pueden ser distintos.

**Chuleta:**
> 1. `ramas = foldAB [] (\ri r rd -> if null ri && null rd then [[r]] else map (r:) (ri ++ rd))`.
> 2. `cantHojas = foldAB 0 (\ri _ rd -> if ri + rd == 0 then 1 else ri + rd)`.
> 3. `espejo = foldAB Nil (\ri r rd -> Bin rd r ri)`.
> 4. `mismaEstructura = foldAB esNil (\ri _ rd t -> case t of Nil -> False; Bin i _ d -> ri i && rd d)` → *fold* que devuelve función `AB b -> Bool`.

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
**a. `foldAIH`**

```haskell
data AIH a = Hoja a | Bin (AIH a) (AIH a)

foldAIH :: (a -> b) -> (b -> b -> b) -> AIH a -> b
foldAIH cHoja _    (Hoja x)  = cHoja x
foldAIH cHoja cBin (Bin i d) = cBin (foldAIH cHoja cBin i) (foldAIH cHoja cBin d)
```

Un parámetro por constructor: `Hoja` lleva información pero no recursión (`a -> b`), `Bin` lleva dos campos recursivos y ninguna información (`b -> b -> b`). Notar que, a diferencia de `AB`, **no hay caso base sin recursión que no cargue datos**: el caso base es la hoja.

**b. `altura` y `tamaño`**

```haskell
altura :: AIH a -> Integer
altura = foldAIH (const 1) (\ri rd -> 1 + max ri rd)

tamaño :: AIH a -> Integer
tamaño = foldAIH (const 1) (+)
```

- `altura`: una hoja mide 1 (como pide el enunciado) y un `Bin` suma 1 al máximo de sus hijos.
- `tamaño` = cantidad de hojas: cada hoja aporta 1 y cada `Bin` suma las de sus hijos.

Se usa `const 1` porque el contenido de la hoja es irrelevante para ambas medidas — de hecho ambas funciones son polimórficas en `a`. Como corolario, en un `AIH` con $h$ hojas siempre hay $h - 1$ nodos `Bin`.

**Chuleta:**
> 1. `foldAIH :: (a -> b) -> (b -> b -> b) -> AIH a -> b`; `foldAIH f g (Hoja x) = f x`; `foldAIH f g (Bin i d) = g (rec i) (rec d)`.
> 2. `altura = foldAIH (const 1) (\ri rd -> 1 + max ri rd)`.
> 3. `tamaño = foldAIH (const 1) (+)` (= cantidad de hojas).

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
**I. Tipo `RoseTree`**

```haskell
data RoseTree a = Rose a [RoseTree a]
```

Un único constructor: un valor en la raíz y una **lista** (posiblemente vacía) de hijos. Es no vacío por construcción; una hoja es `Rose x []`.

**II. Esquema de recursión estructural**

Primero el tipo. Como la recursión está "adentro de una lista", el combinador recibe la lista de resultados de los hijos:

```haskell
foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose f (Rose x hijos) = f x (map (foldRose f) hijos)
```

El `map` es la clave: aplica la recursión a cada hijo y produce el `[b]`. (Formalmente es recursión mutua entre el fold del árbol y el `map` sobre la lista de hijos, pero `map` la encapsula.)

**III. Funciones**

```haskell
-- a) hojas de izquierda a derecha
hojas :: RoseTree a -> [a]
hojas = foldRose (\x rec -> if null rec then [x] else concat rec)

-- b) distancias de la raíz a cada hoja
distancias :: RoseTree a -> [Int]
distancias = foldRose (\_ rec -> if null rec then [0] else map (+1) (concat rec))

-- c) altura (cantidad de nodos de la rama más larga)
altura :: RoseTree a -> Int
altura = foldRose (\_ rec -> 1 + maximum (0 : rec))
```

*Justificación:*

- `hojas`: si no hay hijos el nodo **es** una hoja y aporta `[x]`; si los hay, se concatenan las hojas de los hijos en orden (`concat` preserva el orden izquierda-derecha de la lista de hijos).
- `distancias`: una hoja está a distancia 0 de sí misma; en un nodo interno, cada distancia de los hijos aumenta en 1.
- `altura`: `maximum (0 : rec)` evita que `maximum []` se indefina en las hojas, dando altura 1 para `Rose x []` ✓

Ejemplo: para `Rose 1 [Rose 2 [], Rose 3 [Rose 4 []]]` → `hojas = [2,4]`, `distancias = [1,2]`, `altura = 3`.

**Chuleta:**
> 1. `data RoseTree a = Rose a [RoseTree a]`.
> 2. `foldRose :: (a -> [b] -> b) -> RoseTree a -> b`; `foldRose f (Rose x hs) = f x (map (foldRose f) hs)` ← el `map` hace la recursión sobre los hijos.
> 3. `hojas = foldRose (\x r -> if null r then [x] else concat r)`.
> 4. `distancias = foldRose (\_ r -> if null r then [0] else map (+1) (concat r))`.
> 5. `altura = foldRose (\_ r -> 1 + maximum (0 : r))` (el `0 :` cubre las hojas).

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
Recordar la representación: `data HashSet a = Hash (a -> Integer) (Integer -> [a])`, es decir, el conjunto **es** un par de funciones. El invariante es que la tabla devuelve `[]` para los enteros sin elementos asociados, y que en el balde `n` sólo hay elementos cuyo hash es `n`.

**I. `vacío`**

```haskell
vacío :: (a -> Integer) -> HashSet a
vacío f = Hash f (const [])
```

La tabla constante `[]` respeta el invariante trivialmente.

**II. `pertenece`**

```haskell
pertenece :: Eq a => a -> HashSet a -> Bool
pertenece e (Hash f t) = elem e (t (f e))
```

Sólo hace falta mirar **un** balde: el de `f e`. Es el invariante lo que garantiza que si `e` estuviera, estaría ahí.

**III. `agregar`**

```haskell
agregar :: Eq a => a -> HashSet a -> HashSet a
agregar e h@(Hash f t)
  | pertenece e h = h
  | otherwise     = Hash f (\n -> if n == f e then e : t n else t n)
```

No se "modifica" ninguna estructura: se devuelve una **nueva función tabla** que difiere de la anterior únicamente en el balde `f e`. Se preserva el invariante porque `e` se agrega exactamente al balde `f e`.

**IV. `intersección`**

```haskell
intersección :: Eq a => HashSet a -> HashSet a -> HashSet a
intersección (Hash f t) h2 = Hash f (\n -> filter (\e -> pertenece e h2) (t n))
```

Se conserva la función de hash `f` del primer conjunto (como pide el enunciado) y cada balde se filtra dejando sólo los elementos que también están en `h2`. Como los elementos que quedan salieron del balde `n` de `t`, siguen cumpliendo `f e == n`: el invariante se preserva. Los baldes vacíos siguen vacíos (`filter p [] = []`).

**V. `foldr1`**

```haskell
foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 f = recr (\x xs rec -> if null xs then x else f x rec)
                (error "foldr1: lista vacía")
```

Se usa **recursión primitiva** (`recr`) y no `foldr` porque hay que preguntar si la **cola original** está vacía para saber si el elemento actual es el último (y devolverlo tal cual, sin combinarlo con el caso base). Con `foldr` no se tiene acceso a `xs`, sólo a `rec`.

**Chuleta:**
> 1. `vacío f = Hash f (const [])`.
> 2. `pertenece e (Hash f t) = elem e (t (f e))` — un solo balde, por invariante.
> 3. `agregar e h@(Hash f t) = if pertenece e h then h else Hash f (\n -> if n == f e then e : t n else t n)` — se devuelve una **nueva función**, no se muta nada.
> 4. `intersección (Hash f t) h2 = Hash f (\n -> filter (\e -> pertenece e h2) (t n))`.
> 5. `foldr1 f = recr (\x xs rec -> if null xs then x else f x rec) (error "lista vacía")` → `recr` porque hay que ver si la cola original es vacía.

---

## Generación Infinita

### Ejercicio 17
¿Cuál es el valor de esta expresión?
`[ x | x <- [1..3], y <- [x..3], (x + y) `mod` 3 == 0 ]`

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Comprensión de listas con generadores dependientes y filtros.

**Resolución:**
La comprensión recorre los pares $(x, y)$ con $1 \leq x \leq 3$ y $x \leq y \leq 3$ (el segundo generador **depende** del primero), y se queda con los $x$ tales que $(x+y) \bmod 3 = 0$.

| $x$ | $y$ candidatos | $x + y$ | ¿$\equiv 0 \pmod 3$? | aporta |
|---|---|---|---|---|
| 1 | 1, 2, 3 | 2, 3, 4 | sólo con $y=2$ | `1` |
| 2 | 2, 3 | 4, 5 | ninguno | — |
| 3 | 3 | 6 | sí | `3` |

Resultado:

```haskell
[ x | x <- [1..3], y <- [x..3], (x + y) `mod` 3 == 0 ]  ~>  [1,3]
```

Dos observaciones: (i) el valor devuelto es `x`, no el par, así que si un mismo `x` tuviera dos `y` válidos aparecería repetido; (ii) el orden es lexicográfico, con el generador de la derecha variando más rápido (como bucles anidados, el interno es el último).

**Chuleta:**
> 1. Los generadores se leen como bucles anidados: el **último** varía más rápido; `y <- [x..3]` depende de `x`.
> 2. Filtrar $(x+y) \bmod 3 = 0$: sirven $(1,2)$ y $(3,3)$.
> 3. Se devuelve `x` → resultado `[1,3]`.

---

### Ejercicio 18 ★
Definir la lista infinita `paresDeNat :: [(Int, Int)]`, que contenga todos los pares de números naturales: (0,0), (0,1), (1,0), etc.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Enumeración de un conjunto infinito numerable ($N \times N$). El orden es crucial para que cualquier par sea alcanzado eventualmente.

**Resolución:**
La idea es enumerar $\mathbb{N} \times \mathbb{N}$ **por diagonales**: agrupar los pares según la suma de sus componentes. Para cada $n$ hay finitos pares con $x + y = n$ (exactamente $n+1$), así que recorriendo $n = 0, 1, 2, \dots$ todo par $(a,b)$ aparece en un tiempo finito, en la diagonal $n = a + b$.

```haskell
paresDeNat :: [(Int, Int)]
paresDeNat = [ (x, n - x) | n <- [0..], x <- [0..n] ]
```

Primeros elementos:

```
n = 0: (0,0)
n = 1: (0,1) (1,0)
n = 2: (0,2) (1,1) (2,0)
n = 3: (0,3) (1,2) (2,1) (3,0)
...
~> [(0,0),(0,1),(1,0),(0,2),(1,1),(2,0),(0,3),...]
```

**Por qué el orden importa.** La definición "ingenua"

```haskell
paresMal = [ (x, y) | x <- [0..], y <- [0..] ]   -- ✗
```

nunca produce ningún par con $x > 0$: el generador interno `y <- [0..]` es infinito, así que `x` se queda clavado en `0` para siempre. La clave es que **sólo el generador más externo puede ser infinito**; los internos deben ser finitos y depender de él. Esto es exactamente el argumento de que $\mathbb{N} \times \mathbb{N}$ es numerable (el zigzag de Cantor).

**Chuleta:**
> 1. Enumerar por diagonales: `paresDeNat = [(x, n-x) | n <- [0..], x <- [0..n]]`.
> 2. Regla de oro: **sólo el generador más externo puede ser infinito**; los internos, finitos y dependientes de él.
> 3. `[(x,y) | x <- [0..], y <- [0..]]` está mal: `x` nunca avanza de 0.

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
**Por qué la definición no sirve**

```haskell
pitagóricas = [(a, b, c) | a <- [1..], b <- [1..], c <- [1..], a^2 + b^2 == c^2]  -- ✗
```

Las comprensiones se evalúan como bucles anidados donde el generador más a la derecha varía más rápido. Con `a = 1` y `b = 1` fijos, el generador `c <- [1..]` recorre **infinitos** valores buscando $1 + 1 = c^2$, que no tiene solución: nunca termina y nunca vuelve atrás para incrementar `b`. Por lo tanto la lista se indefine: ni siquiera produce su primer elemento (`take 1 pitagóricas` cuelga). El problema es el mismo del ejercicio 18: hay más de un generador infinito, y los internos impiden que los externos avancen.

**Definición mejor**

Acotar los generadores internos en función del externo. Como en una tripla pitagórica $a, b < c$, alcanza con dejar infinito sólo a `c`:

```haskell
pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [ (a, b, c) | c <- [1..], a <- [1..c], b <- [1..c], a^2 + b^2 == c^2 ]
```

Ahora, para cada `c` fijo hay finitos pares $(a,b)$, la búsqueda de cada diagonal termina y la lista produce elementos indefinidamente:

```
~> [(3,4,5),(4,3,5),(6,8,10),(8,6,10),(5,12,13),(12,5,13),...]
```

Si se quieren sin repetir el orden de $a$ y $b$, usar `b <- [a..c]`. Otra variante equivalente, indexando por la suma `n = a + b + c`:

```haskell
pitagóricas' = [ (a,b,c) | n <- [1..], a <- [1..n], b <- [1..n], let c = n - a - b,
                           c > 0, a^2 + b^2 == c^2 ]
```

**Chuleta:**
> 1. Falla porque `c <- [1..]` es infinito y está **adentro**: con `a=1, b=1` busca `c` para siempre → la lista no produce nada.
> 2. Arreglo: dejar infinito sólo el generador externo y acotar los internos. Como $a,b < c$: `[(a,b,c) | c <- [1..], a <- [1..c], b <- [1..c], a^2+b^2 == c^2]`.
> 3. Patrón general: infinito afuera, finito adentro.

---

### Ejercicio 20 ★
Escribir la función `listasQueSuman :: Int -> [[Int]]` que, dado un número natural $n$, devuelve todas las listas de enteros positivos (es decir, mayores o iguales que 1) cuya suma sea $n$. Para este ejercicio **se permite usar recursión explícita**. Pensar por qué la recursión utilizada no es estructural. (Este ejercicio no es de generación infinita, pero puede ser útil para otras funciones que generen listas infinitas de listas).

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Particiones de un entero. La recursión no es estructural sobre el argumento $n$ de la misma forma que en listas.

**Resolución:**
```haskell
listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = [ x : xs | x <- [1..n], xs <- listasQueSuman (n - x) ]
```

*Idea:* toda lista de enteros positivos que suma $n$ tiene una cabeza `x` con $1 \leq x \leq n$; el resto es una lista de positivos que suma $n - x$. El caso base es $n = 0$, cuya única solución es la lista vacía. (Para $n < 0$ la función no está definida, pero el generador `x <- [1..n]` garantiza que nunca se llegue ahí.)

Ejemplo:

```
listasQueSuman 3 ~> [[1,1,1],[1,2],[2,1],[3]]
```

Nótese que hay $2^{n-1}$ resultados para $n \geq 1$ (son las composiciones de $n$).

**Por qué la recursión no es estructural**

Sobre los naturales (vistos como el tipo inductivo `Zero | Succ n`), la recursión estructural sólo permite un llamado recursivo sobre el **predecesor inmediato**, `n - 1` — eso es justamente lo que captura `foldNat` del ejercicio 9. Acá, en cambio:

- el llamado recursivo es sobre `n - x`, con `x` **variable** entre 1 y `n`, o sea sobre un natural arbitrario menor que `n`, no sobre su predecesor;
- hay una cantidad **no acotada a priori** de llamados recursivos por invocación (uno por cada `x`).

Es entonces **recursión bien fundada** (well-founded / *strong recursion*): termina porque `n - x < n` en toda llamada y `<` está bien fundado sobre $\mathbb{N}$, pero no encaja en `foldNat`. Por eso el enunciado habilita la recursión explícita.

---

### Ejercicio 21 ★
Definir en Haskell una lista que contenga todas las listas finitas de enteros positivos (esto es, con elementos mayores o iguales que 1).

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Enumeración de $\bigcup_{n=0}^{\infty} N^n$.

**Resolución:**
Toda lista **finita** de enteros positivos tiene una suma finita $n \geq 0$, y para cada $n$ el conjunto de listas que suman $n$ es **finito** (ejercicio 20). Entonces alcanza con recorrer las sumas en orden creciente:

```haskell
listasFinitasDePositivos :: [[Int]]
listasFinitasDePositivos = concatMap listasQueSuman [0..]
```

Primeros elementos:

```
n=0: []
n=1: [1]
n=2: [1,1], [2]
n=3: [1,1,1], [1,2], [2,1], [3]
n=4: [1,1,1,1], [1,1,2], [1,2,1], [1,3], [2,1,1], [2,2], [3,1], [4]
...
```

**Por qué está bien definida:** es el mismo principio del ejercicio 18. La lista es infinita pero cada elemento se alcanza en tiempo finito: una lista `l` cualquiera aparece en el bloque $n = \texttt{sum l}$, y antes de ese bloque sólo hay $\sum_{k<n} |\texttt{listasQueSuman } k|$ elementos, una cantidad finita. Además ninguna lista se repite, porque los bloques son disjuntos (cada lista tiene una única suma).

*Contraejemplo de lo que no funciona:* `[l | k <- [0..], l <- listasDeLongitud k]` estaría bien por la misma razón (agrupar por longitud), pero algo como `[l | x <- [1..], l <- ...]` con un generador interno infinito no produciría nada.

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
**a. Lista infinita de todos los `AIH ()`**

Se agrupa por **tamaño** (cantidad de hojas): para cada $n \geq 1$ hay finitos `AIH` con $n$ hojas, así que concatenando por tamaño creciente se enumeran todos.

```haskell
todosLosAIH :: [AIH ()]
todosLosAIH = concatMap aihDeTamaño [1..]

aihDeTamaño :: Integer -> [AIH ()]
aihDeTamaño 1 = [Hoja ()]
aihDeTamaño n = [ Bin i d | k <- [1 .. n - 1]
                          , i <- aihDeTamaño k
                          , d <- aihDeTamaño (n - k) ]
```

*Idea:* un `AIH` de tamaño $n > 1$ es un `Bin` cuyo hijo izquierdo tiene $k$ hojas y el derecho $n - k$, con $1 \leq k \leq n-1$. La cantidad de árboles de tamaño $n$ es el $(n-1)$-ésimo número de Catalan: 1, 1, 2, 5, 14, …

```
n=1: Hoja ()
n=2: Bin (Hoja ()) (Hoja ())
n=3: Bin (Hoja ()) (Bin (Hoja ()) (Hoja ())),
     Bin (Bin (Hoja ()) (Hoja ())) (Hoja ())
...
```

Como el generador externo `[1..]` es el único infinito y los internos son finitos, la lista produce elementos indefinidamente y **todo** `AIH ()` aparece eventualmente (en la posición correspondiente a su cantidad de hojas).

**b. Por qué la recursión no es estructural**

Por dos motivos, ambos importantes:

1. **La recursión no va sobre un `AIH`, va sobre el número `n`.** Acá no se *consume* un árbol sino que se *genera*: no hay un argumento de tipo `AIH` sobre el cual hacer recursión estructural, así que `foldAIH` no es aplicable.
2. **Aun viendo a `n :: Integer` como el natural inductivo**, los llamados recursivos son sobre `k` y `n - k` con `k` variable en $[1, n-1]$, no sobre el predecesor `n - 1`. La recursión estructural sobre naturales (`foldNat`) sólo admite el llamado sobre `n - 1` y una cantidad fija de llamados; acá hay $2(n-1)$ llamados con argumentos arbitrariamente menores.

Es, igual que en el ejercicio 20, **recursión bien fundada**: termina porque $k < n$ y $n - k < n$, pero no es estructural. De ahí que el enunciado permita recursión explícita.

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/haskell_fold_tipo_arboles]] · [[tipos_ejercicio/haskell_funciones_sobre_arboles]] · [[tipos_ejercicio/haskell_currificacion_evaluacion_parcial]] · [[tipos_ejercicio/haskell_recursion_primitiva_rec]]
