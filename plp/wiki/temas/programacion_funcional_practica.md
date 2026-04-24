---
nombre: Programación Funcional en Haskell (Práctica)
parcial: 1
tipo: Clase práctica
tema: Programación Funcional
fuente: raw/clases/prac/0.prac_1P_programacion_funcional_haskell.pdf
paginas_relacionadas: [[programacion_funcional_teoria]]
---

# Programación Funcional en Haskell — Práctica 1

Esta clase cubre los conceptos fundamentales de Haskell, desde el uso del intérprete hasta las funciones de orden superior y esquemas de recursión básicos sobre listas.

## Repaso de Conceptos Básicos

### Uso de GHCi
- `:q`: Salir.
- `:l archivo.hs`: Cargar un archivo.
- `:r`: Recargar el archivo actual.
- `:t expresion`: Ver el tipo de una expresión.

### Currificación y Aplicación Parcial
En Haskell, todas las funciones son currificadas. Esto permite la aplicación parcial:
```haskell
sumar :: Int -> Int -> Int
sumar x y = x + y

sumarDos :: Int -> Int
sumarDos = sumar 2
```

## Ejercicios: Orden Superior sobre Listas

### Ejercicio: `mejorSegun`
Generalizar la búsqueda del "mejor" elemento en una lista dado un criterio de comparación.

**Enunciado**
Definir la función `mejorSegun :: (a -> a -> Bool) -> [a] -> a` que recibe un predicado binario y una lista, y devuelve el elemento que resulta "mejor" según el predicado. Luego, reescribir `maximo` y `listaMasCorta` usando esta función.

**Explicación**
La función debe comparar los elementos de a dos y quedarse con el que cumpla la condición. Es un esquema de reducción.

**Resolución**
```haskell
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun p [x] = x
mejorSegun p (x:xs) = if p x subMejor then x else subMejor
    where subMejor = mejorSegun p xs

-- Redefiniendo maximo
maximo :: Ord a => [a] -> a
maximo = mejorSegun (>)

-- Redefiniendo listaMasCorta
listaMasCorta :: [[a]] -> [a]
listaMasCorta = mejorSegun (\l1 l2 -> length l1 < length l2)
```

**Chuleta**
> [!TIP]
> Al generalizar funciones que recorren una lista comparando elementos, el parámetro suele ser el predicado de comparación `(a -> a -> Bool)`.

---

### Ejercicio: `filter` y sus aplicaciones

**Enunciado**
Definir las siguientes funciones usando `filter`:
1. `deLongitudN :: Int -> [[a]] -> [[a]]`: Deja solo las listas de longitud $n$.
2. `soloPuntosFijosEnN :: Int -> [Int -> Int] -> [Int -> Int]`: Dada una lista de funciones, deja solo aquellas tales que $f(n) = n$.

**Resolución**
```haskell
-- 1. deLongitudN
deLongitudN :: Int -> [[a]] -> [[a]]
deLongitudN n = filter (\l -> length l == n)

-- 2. soloPuntosFijosEnN
soloPuntosFijosEnN :: Int -> [Int -> Int] -> [Int -> Int]
soloPuntosFijosEnN n = filter (\f -> f n == n)
```

---

### Ejercicio: `map` y sus aplicaciones

**Enunciado**
Definir las siguientes funciones usando `map`:
1. `reverseAnidado :: [[Char]] -> [[Char]]`: Dada una lista de strings, devuelve una lista con cada string dado vuelta y la lista completa dada vuelta.
2. `paresCuadrados :: [Int] -> [Int]`: Eleva al cuadrado los números pares y mantiene los impares igual.

**Resolución**
```haskell
-- 1. reverseAnidado
reverseAnidado :: [[Char]] -> [[Char]]
reverseAnidado xss = reverse (map reverse xss)

-- 2. paresCuadrados
paresCuadrados :: [Int] -> [Int]
paresCuadrados = map (\x -> if even x then x^2 else x)
```

---

## Esquemas de Recursión: `foldr`

El esquema `foldr` generaliza la recursión estructural sobre listas.

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr z [] = z
foldr f z (x:xs) = f x (foldr f z xs)
```

- `z`: Caso base (valor para `[]`).
- `f`: Función que combina la cabeza con el resultado de la recursión sobre la cola.

### Redefiniendo `map` y `filter` con `foldr`

```haskell
map :: (a -> b) -> [a] -> [b]
map f = foldr (\x r -> f x : r) []

filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\x r -> if p x then x:r else r) []
```

### Ejercicio: `filterMap`

**Enunciado**
Escribir `filterMap :: (a -> Maybe b) -> [a] -> [b]` que aplica una función, se queda con los valores `Just` y descarta los `Nothing`.

**Resolución**
```haskell
filterMap :: (a -> Maybe b) -> [a] -> [b]
filterMap f = foldr (\x r -> case f x of
                                Just y -> y : r
                                Nothing -> r) []
```

**Chuleta**
> [!NOTE]
> `filterMap` es un patrón común donde se combina la transformación y el filtrado en un solo paso. Es total por construcción si usamos `foldr` y `case`.

---

## Listas por Comprensión

**Ejercicio**
Definir una expresión equivalente a `[f x | x <- xs, p x]` utilizando `map` y `filter`.

**Resolución**
```haskell
listaComp :: (a -> Bool) -> (a -> b) -> [a] -> [b]
listaComp p f xs = map f (filter p xs)
```

---

# Programación Funcional — Práctica 2: Estructuras Inductivas y Funciones

Esta parte extiende el uso de esquemas de recursión a estructuras más complejas y explora el uso de funciones como ciudadanos de primer nivel.

## Recursión Estructural sobre Árboles

### Árbol Binario de Expresión (AEB)
Un `AEB` tiene valores tanto en las hojas como en los nodos internos.

```haskell
data AEB a = Hoja a | Bin (AEB a) a (AEB a)
```

**Esquema de Recursión (`foldAEB`)**
```haskell
foldAEB :: (a -> b) -> (b -> a -> b -> b) -> AEB a -> b
foldAEB fHoja fBin t = case t of
    Hoja n      -> fHoja n
    Bin t1 n t2 -> fBin (foldAEB fHoja fBin t1) n (foldAEB fHoja fBin t2)
```

**Ejercicio: Aplicaciones de `foldAEB`**
Definir las siguientes funciones usando `foldAEB`:
1. `altura :: AEB a -> Int`
2. `cantNodos :: AEB a -> Int`

**Resolución**
```haskell
-- 1. altura
altura :: AEB a -> Int
altura = foldAEB (const 1) (\recI _ recD -> 1 + max recI recD)

-- 2. cantNodos
cantNodos :: AEB a -> Int
cantNodos = foldAEB (const 1) (\recI _ recD -> 1 + recI + recD)
```

---

### Rose Trees
Árboles donde cada nodo tiene una cantidad arbitraria de hijos.

```haskell
data RoseTree a = Rose a [RoseTree a]
```

**Esquema de Recursión (`foldRose`)**
Aquí la recursión es mutua (sobre el árbol y sobre la lista de hijos).
```haskell
foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose f (Rose x hijos) = f x (map (foldRose f) hijos)
```

**Ejercicio: `hojas` y `altura`**
1. `hojas :: RoseTree a -> [a]`: Lista de hojas de izquierda a derecha.
2. `altura :: RoseTree a -> Int`: Rama más larga.

**Resolución**
```haskell
-- 1. hojas
hojas :: RoseTree a -> [a]
hojas = foldRose (\x recs -> if null recs then [x] else concat recs)

-- 2. altura
altura :: RoseTree a -> Int
altura = foldRose (\_ recs -> 1 + if null recs then 0 else maximum recs)
```

---

## Folds sobre otras estructuras: Polinomios

**Enunciado**
Dado el tipo:
```haskell
data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a)
```
Definir `foldPoli` y usarlo para implementar `evaluar :: Num a => a -> Polinomio a -> a`.

**Resolución**
```haskell
foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPoli fX fCte fSuma fProd p = case p of
    X          -> fX
    Cte n      -> fCte n
    Suma p1 p2 -> fSuma (rec p1) (rec p2)
    Prod p1 p2 -> fProd (rec p1) (rec p2)
  where rec = foldPoli fX fCte fSuma fProd

-- evaluar
evaluar :: Num a => a -> Polinomio a -> a
evaluar n = foldPoli n id (+) (*)
```

---

## Funciones como Estructuras de Datos: Conjuntos

Se puede representar un conjunto mediante su función de pertenencia (característica).

```haskell
type Conj a = (a -> Bool)
```

**Ejercicios: Operaciones Básicas**
1. `vacio :: Conj a`
2. `insertar :: Eq a => a -> Conj a -> Conj a`
3. `union :: Conj a -> Conj a -> Conj a`

**Resolución**
```haskell
-- 1. vacio
vacio :: Conj a
vacio = \_ -> False

-- 2. insertar
insertar :: Eq a => a -> Conj a -> Conj a
insertar x c = \y -> y == x || c y

-- 3. union
union :: Conj a -> Conj a -> Conj a
union c1 c2 = \x -> c1 x || c2 x
```

**Chuleta**
> [!IMPORTANT]
> Representar estructuras mediante funciones permite manejar conjuntos infinitos (ej: `even` es el conjunto de pares), pero perdemos la capacidad de computar propiedades globales como el tamaño o listar sus elementos si el dominio no es finito y numerable.

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/haskell_fold_tipo_arboles]] · [[tipos_ejercicio/haskell_funciones_sobre_arboles]] · [[tipos_ejercicio/haskell_currificacion_evaluacion_parcial]] · [[tipos_ejercicio/haskell_recursion_primitiva_rec]]
