---
nombre: Programación funcional — guía priorizada de entrenamiento
tipo: material_de_estudio
origen: raw/cursada_2C_2026/guias/guia1_funcional.pdf
tipo_documento: guia
temas: [programacion_funcional]
parcial: 1P
programa: 2C_2026
generado: 2026-08-31
base_comparacion:
  parciales_analizados: 11
  tipos_ejercicio: 23
ingestado: false
---

# Programación funcional — guía priorizada de entrenamiento

**Fuente:** `raw/cursada_2C_2026/guias/guia1_funcional.pdf` · **Tema:** `programacion_funcional` → **1P** (programa 2C_2026)

> Regla de la guía: no usar recursión explícita salvo cuando el enunciado lo permite. Los ejercicios con `⋆` forman el mínimo recomendado por la cátedra, pero la prioridad de este documento se deriva además de los parciales.

## Qué busca entrenar la guía

- Inferir tipos, reconocer currificación y usar evaluación parcial.
- Entender evaluación no estricta y producir enumeraciones infinitas justas.
- Reemplazar recursión explícita por `map`, `filter`, folds y esquemas propios.
- Distinguir recursión estructural, primitiva y general.
- Derivar `foldX` y `recX` directamente desde un tipo algebraico.
- Hacer que un fold devuelva una función cuando queda un parámetro adicional.
- Elegir `fold` o `rec` según la información que necesita cada función.

## Plan de trabajo

### Nivel 1 — adquirir la técnica

- Ej. 1–3: tipos, currificación y evaluación perezosa.
- Ej. 8: `map`, `filter`, `foldr`, `foldr1`, `foldl` y composición.
- Ej. 10–12: diferencia entre fold, `recr`, recursión general y evaluación parcial.
- Ej. 14 y 16: derivar folds pequeños antes de pasar a árboles.

### Nivel 2 — consolidar

- Ej. 4–7: enumeración por diagonales y generación finita por capas.
- Ej. 9: combinatoria de listas sin recursión explícita.
- Ej. 13 y 15: reutilización de `zipWith`, `iterate`, `take` y `foldNat`.
- Ej. 17–19: árboles binarios y árboles con información en hojas.

### Nivel 3 — dificultad de parcial

- Ej. 17 completo: `foldAB`, `recAB`, observadores y elección de esquema.
- Ej. 18.ii: fold que devuelve una función para comparar dos árboles.
- Ej. 20: fold de un árbol con lista de hijos.
- **Ej. 22 completo:** es literalmente del tipo de ejercicio de parcial y coincide con el Ej. 1 del 1P 2C 2024.

### Variantes opcionales

- Ej. 20 — está marcado opcional, pero su forma `data nuevo → fold → funciones` es crítica para parcial.
- Ej. 21 — Hashing abierto; útil para practicar funciones como datos e invariantes, pero sin patrón propio en los parciales relevados.
- En Ej. 4–7, comparar una enumeración injusta con una por diagonales y observar con `take` dónde se bloquea la primera.

## Selección rápida

| Ejercicio | Prioridad | Habilidad | Dependencia | Motivo |
|---|---|---|---|---|
| 1 | 🟡 | Tipos y currificación | Ninguna | Base vigente para evaluación parcial |
| 2 | 🟡 | `curry`/`uncurry` | Ej. 1 | Base vigente sin aparición propia |
| 3 | 🟡 | Evaluación no estricta | Listas | Material vigente; soporte para infinitas |
| 4 | 🟡 | Diagonalización de pares | Comprensiones | Variante de generación evaluada |
| 5 | 🟡 | Enumeración justa | Ej. 4 | Corrige bloqueo por generador infinito |
| 6 | 🟡 | Generación por suma | Recursión general permitida | Base de Ej. 7 |
| 7 | 🟡 | Todas las listas finitas | Ej. 6 | Variante de generación por capas |
| 8 | 🔴 | Folds sobre listas | Funciones de orden superior | Base directa de funciones vía fold |
| 9 | 🟡 | Combinatoria de listas | `foldr`, `concatMap` | Transferencia sin patrón propio |
| 10 | 🔴 | `recr` vs `foldr` | Ej. 8 | Coincide con recursión primitiva |
| 11 | 🔴 | Clasificar esquemas | Ej. 8 y 10 | Decisión central de parcial |
| 12 | 🔴 | Fold que devuelve función | Currificación | Patrón con tres parciales |
| 13 | 🟡 | `zipWith` en matrices | Ej. 12 | Aplicación vigente |
| 14 | 🔴 | Derivar `foldNat` | Folds | Forma `definir esquema + usarlo` |
| 15 | 🟡 | Generadores finitos | Ej. 14 | Aplicación sin patrón propio |
| 16 | 🔴 | `foldPolinomio` | Tipos inductivos | Forma exacta de fold nuevo |
| 17 | 🔴 | `foldAB`, `recAB`, funciones | Ej. 10 y 16 | Núcleo del patrón de examen |
| 18 | 🔴 | Funciones sobre árboles | Ej. 17 | Fold y evaluación parcial |
| 19 | 🔴 | Fold de `AIH` y generación | Ej. 17 | Tipo nuevo y funciones derivadas |
| 20 | 🔴 | Fold de `RoseTree` | Ej. 17–19 | Patrón exacto aunque sea opcional |
| 21 | 🟡 | Funciones como datos e invariante | Listas y evaluación parcial | Vigente, sin aparición propia |
| 22 | 🔴 | Buffer completo | Todos los anteriores | Aparición literal en 1P 2C 2024 |

---

## 🟡 Ej. 1 — tipos, currificación y orden superior

### Enunciado

Para `max2`, `normaVectorial`, `subtract = flip (-)`, `predecesor = subtract 1`, `evaluarEnCero = \f -> f 0`, `dosVeces = \f -> f . f`, `flipAll = map flip` y `flipRaro = flip flip`: inferir los tipos suponiendo números `Float`; identificar las no currificadas y definir sus versiones currificadas con tipo.

### Qué tenés que producir

Ocho tipos y versiones currificadas de las funciones que reciben una tupla.

### Qué conocimiento presupone

Aplicación asociativa a izquierda, `->` asociativo a derecha y tipos de `map`, `(.)` y `flip`.

### Pista de reconocimiento

Una función no está currificada cuando recibe `(x,y)` como un único argumento.

### Plan de resolución

Inferir desde las aplicaciones internas; para `flipRaro`, instanciar el tipo del `flip` externo con el tipo completo del interno.

### Resolución paso a paso

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

Las únicas no currificadas son `max2` y `normaVectorial`:

```haskell
max2C :: Float -> Float -> Float
max2C x y | x >= y    = x
          | otherwise = y

normaVectorialC :: Float -> Float -> Float
normaVectorialC x y = sqrt (x^2 + y^2)
```

- **Por qué:** `predecesor = subtract 1` consume solo el primer argumento de una función currificada; `dosVeces` exige que `f` pueda componerse consigo misma.

### Control del resultado

En GHCi, `predecesor 5` debe dar `4`; `dosVeces (+1) 3` debe dar `5`.

### Si te trabás

1. Escribí primero `flip :: (a -> b -> c) -> b -> a -> c`.
2. Recordá que una tupla no equivale a dos argumentos currificados.
3. Para `flip flip`, el primer argumento del `flip` externo es el `flip` interno completo.

### Variante que conviene intentar

Reescribir `max2C = curry max2` después del Ej. 2.

### Chuleta

> Aplicación a izquierda → flecha a derecha → unificar operadores → tupla significa no currificada.

---

## 🟡 Ej. 2 — `curry`, `uncurry` y el límite de `curryN`

### Enunciado

Definir `curry`, definir su inversa `uncurry` y decidir si puede existir una única `curryN` para una cantidad arbitraria de argumentos.

### Qué tenés que producir

Tipos, ecuaciones y una justificación de tipado para `curryN`.

### Qué conocimiento presupone

Tuplas, currificación y polimorfismo paramétrico.

### Pista de reconocimiento

La transformación solo cambia cómo llegan los argumentos; no cambia el cálculo de `f`.

### Plan de resolución

Desarmar o construir el par. Después comparar los tipos necesarios para aridades 2 y 3.

### Resolución paso a paso

```haskell
curry :: ((a,b) -> c) -> a -> b -> c
curry f x y = f (x,y)

uncurry :: (a -> b -> c) -> (a,b) -> c
uncurry f (x,y) = f x y
```

No hay una `curryN` única en Haskell estándar: para cada aridad cambia tanto el tipo de la tupla como la cantidad de flechas del resultado. El polimorfismo de Hindley–Milner no permite que el tipo dependa de un número arbitrario `n`.

### Control del resultado

Debe valer extensionalmente `curry (uncurry f) = f` y `uncurry (curry g) = g`.

### Si te trabás

1. Aplicá `f` al dato que originalmente esperaba.
2. En `uncurry`, pattern matcheá el par.
3. Compará `((a,b)->c)` con `((a,b,c)->d)`: no son instancias de una misma tupla de aridad variable.

### Variante que conviene intentar

Definir manualmente `curry3 :: ((a,b,c) -> d) -> a -> b -> c -> d`.

### Chuleta

> `curry f x y = f (x,y)` ↔ `uncurry f (x,y) = f x y`; la aridad no es un valor polimórfico.

---

## 🟡 Ej. 3 — reducción perezosa sobre una lista infinita

### Enunciado

Con `listaDesde x = x : listaDesde (x+1)`, `esMultiploDe10 n = mod n 10 == 0` y `takeHastaMultiploDe10`, mostrar paso a paso la reducción de `takeHastaMultiploDe10 (listaDesde 29)`.

### Qué tenés que producir

Una traza finita que explique por qué no se intenta construir toda la lista infinita.

### Qué conocimiento presupone

Pattern matching y evaluación por necesidad.

### Pista de reconocimiento

Para elegir una ecuación de `takeHastaMultiploDe10` solo hace falta conocer el constructor exterior de la lista.

### Plan de resolución

Exponer una celda de `listaDesde` por vez y evaluar el predicado únicamente sobre la cabeza requerida.

### Resolución paso a paso

```text
takeHastaMultiploDe10 (listaDesde 29)
= takeHastaMultiploDe10 (29 : listaDesde 30)
= if esMultiploDe10 29
    then []
    else 29 : takeHastaMultiploDe10 (listaDesde 30)
= 29 : takeHastaMultiploDe10 (listaDesde 30)
= 29 : takeHastaMultiploDe10 (30 : listaDesde 31)
= 29 : if esMultiploDe10 30
         then []
         else 30 : ...
= 29 : []
= [29]
```

- **Por qué:** al detectar `30`, la rama elegida devuelve `[]` y nunca fuerza `listaDesde 31`.

### Control del resultado

`takeHastaMultiploDe10 (listaDesde 28)` debe ser `[28,29]`; desde `30`, `[]`.

### Si te trabás

1. No expandas la cola antes de que alguien la pida.
2. Expandí `listaDesde` solo hasta obtener `(:)`.
3. En un `if`, Haskell evalúa únicamente la rama elegida.

### Variante que conviene intentar

Trazar `take 3 (listaDesde 29)` y comparar qué partes se fuerzan.

### Chuleta

> Exponer constructor exterior → evaluar cabeza → elegir rama → forzar solo la cola necesaria.

---

## 🟡 Ej. 4 — todos los pares naturales sin inanición

### Enunciado

Definir la lista infinita `paresDeNat :: [(Int,Int)]` que contenga todos los pares de naturales.

### Que tenés que producir

Una enumeración justa: cada par debe aparecer tras una cantidad finita de elementos.

### Que conocimiento presupone

Comprensiones y diagonalización.

### Pista de reconocimiento

Agrupá por suma de las componentes: cada diagonal es finita.

### Plan de resolución

Enumerar `n = x+y` y, dentro de cada `n`, recorrer `x` entre `0` y `n`.

### Resolución paso a paso

```haskell
paresDeNat :: [(Int,Int)]
paresDeNat = [(x, n-x) | n <- [0..], x <- [0..n]]
```

Produce `(0,0)`, luego `(0,1),(1,0)`, luego `(0,2),(1,1),(2,0)`, etc.

### Control del resultado

Todo `(a,b)` aparece en la diagonal `n = a+b`.

### Si te trabás

1. Dos generadores infinitos anidados no son justos.
2. Hacé infinito solo el generador exterior.
3. Cada capa interior debe ser finita.

### Variante que conviene intentar

Dentro de cada diagonal, invertir el orden con `[n,n-1..0]`; sigue siendo justo.

### Chuleta

> Elegir una medida finita (`x+y`) → enumerar medidas → enumerar cada capa finita.

---

## 🟡 Ej. 5 — triplas pitagóricas por capas

### Enunciado

Explicar por qué `[(a,b,c) | a <- [1..], b <- [1..], c <- [1..], a^2+b^2==c^2]` no es útil y dar una definición mejor.

### Que tenés que producir

Diagnóstico de inanición y una enumeración justa de soluciones.

### Que conocimiento presupone

Orden de los generadores de una comprensión.

### Pista de reconocimiento

Con `a=1`, el generador infinito de `b` impide volver al generador de `a`; además, para cada `b`, el `c` infinito bloquea todavía antes.

### Plan de resolución

Usar `c` como cota exterior y hacer finitos los rangos internos.

### Resolución paso a paso

```haskell
pitagoricas :: [(Integer,Integer,Integer)]
pitagoricas =
  [(a,b,c) |
     c <- [1..],
     a <- [1..c],
     b <- [a..c],
     a^2 + b^2 == c^2]
```

Se usa `b <- [a..c]` para evitar repetir `(a,b,c)` y `(b,a,c)`. Toda tripla positiva tiene una hipotenusa finita `c`, así que finalmente se visita su capa.

### Control del resultado

`take 2 pitagoricas` debe comenzar con `(3,4,5)` y otra solución posterior, sin colgarse.

### Si te trabás

1. Detectá cuál generador infinito queda más adentro.
2. Elegí una magnitud que acote a las demás.
3. Hacé que todos los generadores internos sean finitos.

### Variante que conviene intentar

Permitir ambos órdenes usando `b <- [1..c]` y observar la duplicación simétrica.

### Chuleta

> Generador exterior infinito + capas interiores finitas + filtro al final.

---

## 🟡 Ej. 6 — listas positivas con suma fija

### Enunciado

Definir `listasQueSuman :: Int -> [[Int]]`: para un natural `n`, devolver todas las listas de enteros positivos cuya suma sea `n`. Se permite recursión explícita y hay que explicar por qué no es estructural.

### Que tenés que producir

Un generador finito y una clasificación de su recursión.

### Que conocimiento presupone

Comprensiones y descomposición de un entero.

### Pista de reconocimiento

Elegida la primera parte `x`, el resto debe sumar `n-x`.

### Plan de resolución

Usar `[[]]` para suma cero y probar todas las primeras partes entre `1` y `n`.

### Resolución paso a paso

```haskell
listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n
  | n < 0     = []
  | otherwise =
      [x : xs | x <- [1..n], xs <- listasQueSuman (n-x)]
```

No es recursión estructural sobre un dato inductivo de entrada: para un mismo `n` hace varias llamadas sobre valores calculados `n-x`, no una única llamada sobre un subconstructor inmediato de una estructura recibida.

### Control del resultado

Para `3`, ignorando orden, deben aparecer `[3]`, `[1,2]`, `[2,1]`, `[1,1,1]`; todas suman `3` y tienen elementos positivos.

### Si te trabás

1. El caso `0` tiene una solución: la lista vacía.
2. No confundas `[]` con `[[]]`.
3. El resto de una lista que empieza con `x` debe sumar `n-x`.

### Variante que conviene intentar

Restringir a listas no decrecientes agregando una cota mínima al generador.

### Chuleta

> Suma 0 → `[[]]`; elegir cabeza positiva → generar colas que sumen el resto.

---

## 🟡 Ej. 7 — todas las listas finitas positivas

### Enunciado

Definir una lista infinita que contenga todas las listas finitas de enteros positivos.

### Que tenés que producir

Una enumeración completa y justa.

### Que conocimiento presupone

Ej. 6 y evaluación perezosa.

### Pista de reconocimiento

Toda lista positiva tiene una suma natural finita.

### Plan de resolución

Concatenar las capas dadas por `listasQueSuman n` en orden creciente de `n`.

### Resolución paso a paso

```haskell
todasLasListasPositivas :: [[Int]]
todasLasListasPositivas = concatMap listasQueSuman [0..]
```

Cada capa es finita y toda lista aparece en la capa igual a la suma de sus elementos.

### Control del resultado

`[]` aparece en la capa 0; `[2,1]` en la 3; ninguna lista contiene cero o negativos.

### Si te trabás

1. No enumeres primero la longitud y luego elementos con un generador infinito interno.
2. Buscá una medida finita de cada objeto.
3. La suma ya fue resuelta por el Ej. 6.

### Variante que conviene intentar

Eliminar `[]` usando `concatMap listasQueSuman [1..]`.

### Chuleta

> Particionar por suma → cada capa finita → concatenar capas crecientes.

---

## 🔴 Ej. 8 — biblioteca de folds sobre listas

### Enunciado

Definir con `map`/`filter` tres transformaciones; redefinir `sum`, `elem`, `(++)`, `filter` y `map` con `foldr`; definir `mejorSegún` con `foldr1`, `sumasParciales`, suma alternada directa e inversa, y `componerTodas`.

### Que tenés que producir

Funciones sin recursión explícita y una elección justificada de fold.

### Que conocimiento presupone

Tipos de `foldr`, `foldr1`, `foldl`, composición y listas.

### Pista de reconocimiento

En `foldr f z`, `z` reemplaza `[]` y `f` reemplaza `(:)`.

### Plan de resolución

Resolver primero las redefiniciones canónicas; después elegir el tipo de acumulador requerido por cada función.

### Resolución paso a paso

```haskell
-- i
cortas :: [String] -> [String]
cortas = filter ((< 5) . length)

aprobadas :: [Float] -> [Bool]
aprobadas = map (> 6)

paresCuadrados :: [Int] -> [Int]
paresCuadrados = map (^2) . filter even

-- ii
sum' :: Num a => [a] -> a
sum' = foldr (+) 0

elem' :: Eq a => a -> [a] -> Bool
elem' e = foldr (\x r -> x == e || r) False

(+++) :: [a] -> [a] -> [a]
xs +++ ys = foldr (:) ys xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x r -> if p x then x:r else r) []

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x r -> f x:r) []

-- iii
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun mejor = foldr1 (\x r -> if mejor x r then x else r)

-- iv
sumasParciales :: Num a => [a] -> [a]
sumasParciales = foldr (\x r -> x : map (+x) r) []

-- v
sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

-- vi
sumaAltInv :: Num a => [a] -> a
sumaAltInv = foldl (flip (-)) 0

-- vii
componerTodas :: [a -> a] -> a -> a
componerTodas = foldr (.) id
```

- **Por qué:** `foldr (-) 0 [a,b,c] = a-(b-(c-0))`; `foldl (flip (-)) 0 [a,b,c] = c-(b-(a-0))`.

### Control del resultado

`sumasParciales [1,4,-1,0,5] == [1,5,4,4,9]` y el ejemplo de `componerTodas` debe dar `1`.

### Si te trabás

1. Escribí las ecuaciones deseadas para `[]` y `x:xs`.
2. El caso base de `(++)` es la segunda lista, no `[]`.
3. Si no existe neutro genérico, usá `foldr1`.

### Variante que conviene intentar

Explicar por qué `elem'` puede devolver `True` sobre una lista infinita si encuentra el elemento en un prefijo finito.

### Chuleta

> Reemplazar `[]` por base → reemplazar `(:)` por combinador → elegir dirección según asociación.

---

## 🟡 Ej. 9 — permutaciones, partes, prefijos y sublistas

### Enunciado

Definir `permutaciones`, `partes`, `prefijos` y las sublistas consecutivas, usando combinadores como `concatMap`, `take` y `drop`.

### Que tenés que producir

Cuatro enumeradores finitos sin recursión explícita.

### Que conocimiento presupone

`foldr`, comprensiones, índices y concatenación.

### Pista de reconocimiento

Permutar consiste en insertar cada cabeza en todas las posiciones de cada permutación de la cola.

### Plan de resolución

Usar fold para las elecciones inductivas y rangos finitos para prefijos/sublistas.

### Resolución paso a paso

```haskell
insertarEnTodas :: a -> [a] -> [[a]]
insertarEnTodas x xs =
  [take i xs ++ [x] ++ drop i xs | i <- [0..length xs]]

permutaciones :: [a] -> [[a]]
permutaciones =
  foldr (\x ps -> concatMap (insertarEnTodas x) ps) [[]]

partes :: [a] -> [[a]]
partes = foldr (\x rs -> rs ++ map (x:) rs) [[]]

prefijos :: [a] -> [[a]]
prefijos xs = [take n xs | n <- [0..length xs]]

sublistas :: [a] -> [[a]]
sublistas xs = [] :
  [take largo (drop inicio xs) |
     inicio <- [0..length xs - 1],
     largo  <- [1..length xs - inicio]]
```

### Control del resultado

Para una lista de longitud `n` sin repetidos: `permutaciones` tiene `n!` resultados, `partes` tiene $2^n$ y `prefijos` tiene `n+1`.

### Si te trabás

1. El caso base de permutaciones es `[[]]`.
2. Cada elemento en `partes` ofrece dos decisiones: excluir o incluir.
3. Una sublista queda determinada por inicio y longitud.

### Variante que conviene intentar

Aplicar `sublistas` a `[1,1]` y decidir si la consigna distingue ocurrencias o valores; esta versión conserva ocurrencias y puede repetir valores iguales.

### Chuleta

> Permutar = insertar en todas partes; partes = tomar/no tomar; sublista = inicio + longitud.

---

## 🔴 Ej. 10 — recursión primitiva sobre listas

### Enunciado

Dado `recr :: (a -> [a] -> b -> b) -> b -> [a] -> b`, definir `sacarUna`, explicar por qué `foldr` no alcanza y definir `insertarOrdenado` preservando orden.

### Que tenés que producir

Dos funciones con `recr` y la distinción conceptual entre resultado recursivo y cola original.

### Que conocimiento presupone

Recursión estructural y acceso al subtérmino original.

### Pista de reconocimiento

Cuando se encuentra el elemento, hay que devolver la cola **sin procesarla**.

### Plan de resolución

En cada paso recibir `x`, `xs` original y `r` procesado; elegir entre conservar `xs` o usar `r`.

### Resolución paso a paso

```haskell
sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr paso []
  where
    paso x xs r
      | x == e    = xs
      | otherwise = x:r

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr paso [e]
  where
    paso x xs r
      | e <= x    = e:x:xs
      | otherwise = x:r
```

`foldr` entrega `x` y el resultado de procesar `xs`, pero no `xs`. Si `x == e`, `sacarUna` necesita devolver exactamente la cola original para no eliminar apariciones posteriores. Lo mismo ocurre al insertar antes de `x`: el resto debe quedar intacto.

### Control del resultado

`sacarUna 2 [1,2,2,3] == [1,2,3]`; `insertarOrdenado 3 [1,2,4] == [1,2,3,4]`.

### Si te trabás

1. Marcá tipos: `xs :: [a]`, `r :: [a]`.
2. Preguntá qué rama necesita la cola original.
3. En la rama que sigue buscando, usá `r`.

### Variante que conviene intentar

Definir `sacarTodas` y explicar por qué allí `foldr` sí alcanza.

### Chuleta

> Si debo detener la transformación y conservar la cola original → `recr`; si siempre uso la cola procesada → `foldr`.

---

## 🔴 Ej. 11 — reconocer estructural, primitiva y general

### Enunciado

Clasificar la recursión de `elementosEnPosicionesPares`, `entrelazar`, `slowSort`, `sufijos` y `miScanr`; reescribir con `recr` o `foldr` los casos estructurales/primitivos.

### Que tenés que producir

Clasificación justificada y tres reescrituras esquemáticas.

### Que conocimiento presupone

Diferencia entre llamada sobre `xs`, acceso a `xs` y llamada sobre datos calculados.

### Pista de reconocimiento

Mirar exclusivamente el argumento de la llamada recursiva y qué información del original usa el paso.

### Plan de resolución

Clasificar primero; recién después elegir combinador y tipo del acumulador.

### Resolución paso a paso

1. `elementosEnPosicionesPares`: **recursión general**, porque llama sobre `tail xs`, saltando dos constructores respecto de la entrada `x:xs`.
2. `entrelazar`: **estructural sobre la primera lista**; el fold devuelve una función que espera la segunda.
3. `slowSort`: **general**, porque llama sobre `menores` y `mayores`, listas calculadas.
4. `sufijos`: **primitiva**, porque usa la cola original `x:xs` además del resultado recursivo.
5. `miScanr`: **estructural**, porque solo usa el resultado recursivo.

```haskell
entrelazar' :: [a] -> [a] -> [a]
entrelazar' = foldr paso id
  where
    paso x r ys
      | null ys   = x : r []
      | otherwise = x : head ys : r (tail ys)

sufijos' :: [a] -> [[a]]
sufijos' = recr (\x xs r -> (x:xs):r) [[]]

miScanr' :: (a -> b -> b) -> b -> [a] -> [b]
miScanr' f n = foldr paso [n]
  where
    paso x r@(y:_) = f x y : r
```

No corresponde forzar `elementosEnPosicionesPares` ni `slowSort` dentro de `foldr/recr`: sus llamadas no siguen el subtérmino inmediato.

### Control del resultado

Comparar cada versión con la original en listas vacías, unitarias y de varios elementos.

### Si te trabás

1. `f xs` inmediato puede ser estructural.
2. Usar además `xs` pide primitiva.
3. Llamar con `tail xs`, una partición o una transformación pide recursión general.

### Variante que conviene intentar

Reformular `elementosEnPosicionesPares` con un fold que devuelva un par de resultados para posiciones pares e impares.

### Chuleta

> Subdato inmediato y solo resultado → fold; subdato original + resultado → rec; argumento calculado → general.

---

## 🔴 Ej. 12 — currificación y evaluación parcial sobre dos listas

### Enunciado

Definir y tipar `mapPares`, `armarPares` (`zip`) y `mapDoble` (`zipWith`) para listas finitas e infinitas, usando currificación y evaluación parcial.

### Que tenés que producir

Tres funciones productivas que se detengan cuando termina la lista más corta.

### Que conocimiento presupone

`curry`, `uncurry`, `map` y fold que devuelve función.

### Pista de reconocimiento

Al plegar la primera lista, el resultado intermedio puede tener tipo `[b] -> [(a,b)]`.

### Plan de resolución

`mapPares` se reduce a `uncurry`; construir `armarPares` con un fold funcional y derivar `mapDoble` por composición.

### Resolución paso a paso

```haskell
mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = map (uncurry f)

armarPares :: [a] -> [b] -> [(a,b)]
armarPares = foldr paso (const [])
  where
    paso x r ys
      | null ys   = []
      | otherwise = (x, head ys) : r (tail ys)

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)
```

El fold de `armarPares` devuelve una función; así cada resultado recursivo puede consumir la cola correspondiente de la segunda lista.

### Control del resultado

`take 3 (armarPares [1..] ['a'..]) == [(1,'a'),(2,'b'),(3,'c')]`; con una lista vacía, el resultado es `[]` sin forzar la otra.

### Si te trabás

1. Escribí primero el tipo de salida del fold: `[b] -> [(a,b)]`.
2. El caso base ignora la segunda lista.
3. El paso consume una cabeza de cada lista.

### Variante que conviene intentar

Expresar `mapDoble f = armarPares ...` usando directamente `map (uncurry f)`.

### Chuleta

> Parámetro extra → fold devuelve función → consumir una parte del parámetro en cada paso.

---

## 🟡 Ej. 13 — suma y trasposición de matrices

### Enunciado

Con matrices rectangulares bien formadas, definir `sumaMat` usando `zipWith` y definir `trasponer`.

### Que tenés que producir

Dos transformaciones que preserven o intercambien dimensiones.

### Que conocimiento presupone

Listas de listas, `zipWith`, `head`, `length` y `repeat`.

### Pista de reconocimiento

La suma necesita un `zipWith` para filas y otro para celdas.

### Plan de resolución

Anidar `zipWith`; para trasponer, acumular columnas con `zipWith (:)` y limitar la salida al ancho.

### Resolución paso a paso

```haskell
sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith (zipWith (+))

trasponer :: [[a]] -> [[a]]
trasponer [] = []
trasponer xss =
  take (length (head xss))
       (foldr (zipWith (:)) (repeat []) xss)
```

No hay llamada recursiva explícita. `repeat []` ofrece una columna vacía para cada posición; `take` elimina la cola infinita sobrante.

### Control del resultado

Una matriz `N × M` debe transformarse en `M × N`; trasponer dos veces recupera la matriz bien formada.

### Si te trabás

1. `zipWith (+)` suma una fila.
2. `zipWith (zipWith (+))` suma filas correspondientes.
3. Para trasponer, cada fila agrega una cabeza a cada columna.

### Variante que conviene intentar

Ver qué ocurre con filas de distinta longitud y explicar por qué la consigna exige matrices bien formadas.

### Chuleta

> Operación celda a celda → `zipWith` anidado; filas a columnas → `foldr (zipWith (:))`.

---

## 🔴 Ej. 14 — `foldNat` y potencia

### Enunciado

Definir y tipar `foldNat` sobre `Integer` no negativos; usarlo para definir potencia.

### Que tenés que producir

El esquema y una instancia sin recursión explícita fuera del esquema.

### Que conocimiento presupone

Caso cero y sucesor.

### Pista de reconocimiento

Un natural se observa como `0` o como un sucesor; el fold reemplaza ambos casos.

### Plan de resolución

Elegir un valor para cero y una función que transforme el resultado del predecesor.

### Resolución paso a paso

```haskell
foldNat :: (a -> a) -> a -> Integer -> a
foldNat _ z 0 = z
foldNat f z n = f (foldNat f z (n-1))

potencia :: Num a => a -> Integer -> a
potencia base = foldNat (* base) 1
```

- **Por qué:** $base^0=1$ y $base^{n+1}=base\cdot base^n$.

### Control del resultado

`potencia 2 0 == 1` y `potencia 2 5 == 32`. El contrato excluye exponentes negativos.

### Si te trabás

1. El resultado del fold debe tener el tipo de la función que querés construir.
2. Identificá valor base y transformación sucesora.
3. En potencia son `1` y `(* base)`.

### Variante que conviene intentar

Definir `factorial = snd . foldNat (\(n,r) -> (n+1,(n+1)*r)) (0,1)`.

### Chuleta

> Natural: cero ↦ `z`; sucesor ↦ `f`; potencia: `z=1`, `f=(*base)`.

---

## 🟡 Ej. 15 — generar una progresión finita

### Enunciado

Definir `genLista :: a -> (a -> a) -> Integer -> [a]` y, con ella, `desdeHasta` para un par ordenado de enteros.

### Que tenés que producir

Una lista de exactamente la cantidad solicitada y una especialización consecutiva.

### Que conocimiento presupone

`iterate`, `take` y conversión de `Integer` a `Int`.

### Pista de reconocimiento

`iterate f x` ya genera `x, f x, f(f x), ...`.

### Plan de resolución

Tomar un prefijo finito de `iterate`; calcular inclusivamente la longitud del intervalo.

### Resolución paso a paso

```haskell
genLista :: a -> (a -> a) -> Integer -> [a]
genLista x f n = take (fromInteger n) (iterate f x)

desdeHasta :: (Integer,Integer) -> [Integer]
desdeHasta (desde,hasta) =
  genLista desde (+1) (hasta - desde + 1)
```

### Control del resultado

`genLista 1 (*2) 4 == [1,2,4,8]`; `desdeHasta (3,6) == [3,4,5,6]`.

### Si te trabás

1. El primer elemento cuenta dentro de la cantidad.
2. `iterate` es infinito pero `take` fuerza solo el prefijo.
3. Un intervalo inclusivo tiene `hasta-desde+1` elementos.

### Variante que conviene intentar

Construir una versión con `foldNat` que acumule también el siguiente elemento.

### Chuleta

> Semilla + siguiente → `iterate`; cantidad → `take`; intervalo inclusivo → diferencia + 1.

---

## 🔴 Ej. 16 — fold de polinomios

### Enunciado

Para `data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod ...`, definir el esquema estructural y `evaluar :: Num a => a -> Polinomio a -> a`.

### Que tenés que producir

Tipo de `foldPolinomio`, ecuaciones y una interpretación de cada constructor.

### Que conocimiento presupone

Regla: un argumento del fold por constructor; campos recursivos se reemplazan por resultados.

### Pista de reconocimiento

Al evaluar en `x`, `X` vale `x`, una constante vale sí misma, y los nodos usan `(+)` o `(*)`.

### Plan de resolución

Derivar el tipo constructor por constructor y luego sustituir constructores por su semántica.

### Resolución paso a paso

```haskell
foldPolinomio :: b
               -> (a -> b)
               -> (b -> b -> b)
               -> (b -> b -> b)
               -> Polinomio a -> b
foldPolinomio fX fCte fSuma fProd p = case p of
  X        -> fX
  Cte k    -> fCte k
  Suma q r -> fSuma (rec q) (rec r)
  Prod q r -> fProd (rec q) (rec r)
  where rec = foldPolinomio fX fCte fSuma fProd

evaluar :: Num a => a -> Polinomio a -> a
evaluar x = foldPolinomio x id (+) (*)
```

### Control del resultado

Para `Suma (Prod X X) (Cte 1)`, `evaluar 3` debe dar `10`.

### Si te trabás

1. Hay cuatro constructores: cuatro interpretaciones.
2. `Cte` conserva su campo `a`.
3. En `Suma` y `Prod`, cada `Polinomio a` se reemplaza por `b`.

### Variante que conviene intentar

Definir `cantidadOperaciones = foldPolinomio 0 (const 0) (\x y -> 1+x+y) (\x y -> 1+x+y)`.

### Chuleta

> Un caso por constructor → reemplazar subpolinomios por resultados → evaluar sustituyendo `X`, `Cte`, `Suma`, `Prod`.

---

## 🔴 Ej. 17 — `foldAB`, `recAB` y observadores de árboles

### Enunciado

Para `data AB a = Nil | Bin (AB a) a (AB a)`: definir `foldAB` y `recAB`; definir `esNil`, `altura`, `cantNodos`, `mejorSegún` y `esABB`; justificar los esquemas usados.

### Que tenés que producir

Dos esquemas con tipos y funciones derivadas sin recursión explícita.

### Que conocimiento presupone

Folds, `Maybe` y el invariante de árbol binario de búsqueda indicado por la guía.

### Pista de reconocimiento

Para chequear `esABB`, hacer que cada subárbol entregue validez, mínimo y máximo.

### Plan de resolución

Derivar esquemas; resolver observadores simples con fold; usar un resumen rico para `mejorSegún` y `esABB`.

### Resolución paso a paso

```haskell
foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB z f Nil         = z
foldAB z f (Bin i x d) = f (foldAB z f i) x (foldAB z f d)

recAB :: b
      -> (AB a -> b -> a -> AB a -> b -> b)
      -> AB a -> b
recAB z f Nil         = z
recAB z f (Bin i x d) = f i (recAB z f i) x d (recAB z f d)

esNil :: AB a -> Bool
esNil Nil = True
esNil _   = False

altura :: AB a -> Int
altura = foldAB 0 (\hi _ hd -> 1 + max hi hd)

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\ni _ nd -> 1 + ni + nd)

mejorSegunAB :: (a -> a -> Bool) -> AB a -> a
mejorSegunAB mejor t = extraer (foldAB Nothing combinar t)
  where
    elegir x y = if mejor x y then x else y
    combinar mi x md = Just (foldr elegir x (valores mi ++ valores md))
    valores Nothing  = []
    valores (Just x) = [x]
    extraer Nothing  = error "arbol vacio"
    extraer (Just x) = x

esABB :: Ord a => AB a -> Bool
esABB t = valido (foldAB (True,Nothing,Nothing) combinar t)
  where
    valido (ok,_,_) = ok
    combinar (okI,minI,maxI) x (okD,minD,maxD) =
      ( okI && okD
        && maybe True (<= x) maxI
        && maybe True (> x) minD
      , Just (maybe x id minI)
      , Just (maybe x id maxD)
      )
```

El comparador acepta valores del subárbol izquierdo `<= x` y del derecho `> x`, exactamente el convenio de la guía. `foldAB` alcanza porque cada función usa resúmenes recursivos; `recAB` se define porque será necesario cuando una decisión requiera inspeccionar subárboles originales.

### Control del resultado

`altura Nil == 0`, `cantNodos Nil == 0`; un `Bin Nil 2 (Bin Nil 3 Nil)` es ABB, pero uno con `1` a la derecha no.

### Si te trabás

1. Escribí primero el tipo de cada constructor reemplazando `AB a` por `b`.
2. Si `Nil` impide devolver un `a`, acumulá `Maybe a`.
3. Para ABB no alcanza un `Bool`: también hacen falta extremos.

### Variante que conviene intentar

Definir `inorder = foldAB [] (\ri x rd -> ri ++ [x] ++ rd)` y comprobar que un ABB produce una lista ordenada según el convenio.

### Chuleta

> Derivar fold/rec del `data` → elegir resumen `b` suficiente → combinar hijos → extraer resultado final.

---

## 🔴 Ej. 18 — caminos, espejo y comparación estructural

### Enunciado

Sobre `AB a`, definir `ramas`, `cantHojas`, `espejo` y `mismaEstructura :: AB a -> AB b -> Bool`; para esta última usar evaluación parcial.

### Que tenés que producir

Cuatro folds, uno de los cuales devuelve una función sobre el segundo árbol.

### Que conocimiento presupone

`foldAB`, constructores de árbol y evaluación parcial.

### Pista de reconocimiento

En `mismaEstructura`, el resultado de plegar el primer árbol tiene tipo `AB b -> Bool`.

### Plan de resolución

Combinar caminos de hijos; reconstruir con hijos invertidos; comparar el segundo árbol en cada función generada.

### Resolución paso a paso

```haskell
ramas :: AB a -> [[a]]
ramas = foldAB [] paso
  where
    paso ri x rd
      | null ri && null rd = [[x]]
      | otherwise          = map (x:) (ri ++ rd)

cantHojas :: AB a -> Int
cantHojas = foldAB 0 paso
  where
    paso 0 _ 0 = 1
    paso i _ d = i + d

espejo :: AB a -> AB a
espejo = foldAB Nil (\ri x rd -> Bin rd x ri)

mismaEstructura :: AB a -> AB b -> Bool
mismaEstructura = foldAB esNil paso
  where
    paso ri _ rd Nil         = False
    paso ri _ rd (Bin i _ d) = ri i && rd d
```

En el caso `Nil`, el fold devuelve `esNil :: AB b -> Bool`. En un `Bin`, devuelve una función que exige otro `Bin` y delega sus subárboles a las funciones recursivas.

### Control del resultado

`espejo . espejo` debe recuperar el árbol; `cantHojas (Bin Nil x Nil) == 1`; los contenidos no deben afectar `mismaEstructura`.

### Si te trabás

1. Decidí qué representa una rama cuando el nodo tiene ambos hijos `Nil`.
2. `espejo` intercambia resultados, no árboles originales.
3. Anotá `b = AB c -> Bool` en el fold de `mismaEstructura`.

### Variante que conviene intentar

Definir `zipAB` que combine nodos mientras ambas estructuras coincidan.

### Chuleta

> Función con segundo árbol → fold devuelve `AB b -> resultado`; aplicar funciones recursivas a hijos correspondientes.

---

## 🔴 Ej. 19 — árboles con información en hojas

### Enunciado

Para `data AIH a = Hoja a | Bin (AIH a) (AIH a)`: definir `foldAIH`, `altura`, `tamaño`, la lista infinita de todos los `AIH ()` y explicar por qué su generación no es estructural.

### Que tenés que producir

Un fold, dos observadores y una enumeración justa por tamaño.

### Que conocimiento presupone

Folds binarios y generación por capas.

### Pista de reconocimiento

Un árbol tiene un número finito de hojas; usarlo como medida de la capa.

### Plan de resolución

Derivar el fold; después generar exactamente los árboles con `n` hojas, repartiendo `n` entre ambos hijos.

### Resolución paso a paso

```haskell
foldAIH :: (a -> b) -> (b -> b -> b) -> AIH a -> b
foldAIH fHoja fBin (Hoja x) = fHoja x
foldAIH fHoja fBin (Bin i d) =
  fBin (foldAIH fHoja fBin i) (foldAIH fHoja fBin d)

alturaAIH :: AIH a -> Integer
alturaAIH = foldAIH (const 1) (\hi hd -> 1 + max hi hd)

tamanioAIH :: AIH a -> Integer
tamanioAIH = foldAIH (const 1) (+)

aihConHojas :: Integer -> [AIH ()]
aihConHojas 1 = [Hoja ()]
aihConHojas n =
  [Bin i d |
     k <- [1..n-1],
     i <- aihConHojas k,
     d <- aihConHojas (n-k)]

todosLosAIH :: [AIH ()]
todosLosAIH = concatMap aihConHojas [1..]
```

La recursión de `aihConHojas` no consume un `AIH` ni sigue sus subárboles; construye árboles y se llama sobre enteros calculados `k` y `n-k`. Por eso no es estructural sobre `AIH`.

### Control del resultado

La capa `1` tiene solo `Hoja ()`; cada árbol de la capa `n` debe tener exactamente `n` hojas; toda capa es finita.

### Si te trabás

1. El constructor `Hoja` aporta una hoja.
2. En `Bin`, repartir la cantidad total entre dos enteros positivos.
3. Concatenar capas finitas evita inanición.

### Variante que conviene intentar

Generar por altura exacta y observar por qué hay que controlar duplicados entre capas.

### Chuleta

> Fold: hoja ↦ función unaria, bin ↦ combinar dos resultados; generación: particionar cantidad de hojas.

---

## 🔴 Ej. 20 — `RoseTree`: recursión anidada

### Enunciado

Definir un tipo de árbol no vacío con cantidad indeterminada de hijos, su fold y las funciones `hojas`, `distancias` y `altura`.

### Que tenés que producir

Un esquema donde los hijos recursivos se transforman en una lista de resultados.

### Que conocimiento presupone

Tipos algebraicos, `map`, `concat` y máximos.

### Pista de reconocimiento

Si los hijos tienen tipo `[RoseTree a]`, después de plegarlos deben tener tipo `[b]`.

### Plan de resolución

Elegir un constructor único y hacer que el fold mapee recursivamente sobre la lista de hijos.

### Resolución paso a paso

```haskell
data RoseTree a = Rose a [RoseTree a]

foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose f (Rose x hijos) = f x (map (foldRose f) hijos)

hojas :: RoseTree a -> [a]
hojas = foldRose (\x rhs -> if null rhs then [x] else concat rhs)

distancias :: RoseTree a -> [Int]
distancias =
  foldRose (\_ rhs -> if null rhs
                       then [0]
                       else map (+1) (concat rhs))

alturaRose :: RoseTree a -> Int
alturaRose = foldRose (\_ rhs -> 1 + maximum (0:rhs))
```

### Control del resultado

Una hoja tiene `hojas = [x]`, `distancias = [0]` y altura `1`; la cantidad de distancias coincide con la cantidad de hojas.

### Si te trabás

1. No confundas `[RoseTree a]` con un único subárbol.
2. La llamada recursiva se distribuye con `map`.
3. El caso hoja se detecta porque la lista de resultados de hijos es vacía.

### Variante que conviene intentar

Definir `cantidadNodos = foldRose (\_ rs -> 1 + sum rs)`.

### Chuleta

> Recursión dentro de lista → `map fold` → combinar `[b]`; hoja = lista de hijos vacía.

---

## 🟡 Ej. 21 — HashSet funcional y `foldr1`

### Enunciado

Para `data HashSet a = Hash (a -> Integer) (Integer -> [a])`, definir `vacío`, `pertenece`, `agregar` sin duplicar, `intersección` preservando la función hash del primero y `foldr1` sin recursión explícita.

### Que tenés que producir

Operaciones que preserven la totalidad de la tabla y una versión segura salvo lista vacía de `foldr1`.

### Que conocimiento presupone

Funciones como datos, closures, filtros y `recr`.

### Pista de reconocimiento

Actualizar una tabla funcional consiste en devolver otra función que distingue una clave y delega las demás.

### Plan de resolución

Desarmar `Hash h tabla`; construir una tabla nueva por casos sobre el entero consultado.

### Resolución paso a paso

```haskell
vacio :: (a -> Integer) -> HashSet a
vacio h = Hash h (const [])

pertenece :: Eq a => a -> HashSet a -> Bool
pertenece x (Hash h tabla) = elem x (tabla (h x))

agregar :: Eq a => a -> HashSet a -> HashSet a
agregar x s@(Hash h tabla)
  | pertenece x s = s
  | otherwise = Hash h tabla'
  where
    tabla' k
      | k == h x  = x : tabla k
      | otherwise = tabla k

interseccion :: Eq a => HashSet a -> HashSet a -> HashSet a
interseccion (Hash h tabla) s2 =
  Hash h (\k -> filter (\x -> pertenece x s2) (tabla k))

foldr1' :: (a -> a -> a) -> [a] -> a
foldr1' f = recr paso (error "foldr1: lista vacia")
  where
    paso x xs r
      | null xs   = x
      | otherwise = f x r
```

La tabla resultante sigue siendo total: para cualquier entero, o usa el bucket especial o delega a una tabla total.

### Control del resultado

Los ejemplos de pertenencia de la guía deben dar `False` para `5` y `True` para `2`; agregar dos veces no crea duplicados.

### Si te trabás

1. La tabla es una función, no una lista global enumerable.
2. Solo se modifica el bucket `h x`.
3. En la intersección no se puede recorrer todo el universo: se filtra cada bucket cuando es consultado.

### Variante que conviene intentar

Definir `eliminar` mediante una tabla que filtre `(/= x)` únicamente en `h x`.

### Chuleta

> Desarmar `Hash` → cerrar sobre tabla vieja → interceptar bucket → delegar el resto → preservar invariante.

---

## 🔴 Ej. 22 — Buffer con historia, fold, rec y evaluación parcial

### Enunciado

Para `data Buffer a = Empty | Write Int a (Buffer a) | Read Int (Buffer a)`: definir `foldBuffer` y `recBuffer`; `posicionesOcupadas`, `contenido`, `puedeCompletarLecturas` y `deshacer`. La lectura elimina contenido y las operaciones más externas son las más recientes.

### Que tenés que producir

La familia completa de funciones sin recursión explícita fuera de los esquemas.

### Que conocimiento presupone

Folds para tipos nuevos, recursión primitiva, estado representado por historia y fold que devuelve función.

### Pista de reconocimiento

- `foldBuffer`: alcanza cuando solo importa el estado resumido.
- `recBuffer`: hace falta cuando una lectura debe consultar el buffer anterior o cuando hay que conservar una cola original.
- `deshacer`: el esquema debe devolver `Int -> Buffer a`.

### Plan de resolución

Derivar ambos esquemas; interpretar operaciones de adentro hacia afuera; usar el buffer original en las funciones que necesitan historia.

### Resolución paso a paso

```haskell
foldBuffer :: b
           -> (Int -> a -> b -> b)
           -> (Int -> b -> b)
           -> Buffer a -> b
foldBuffer z fWrite fRead buf = case buf of
  Empty       -> z
  Write n x b -> fWrite n x (rec b)
  Read n b    -> fRead n (rec b)
  where rec = foldBuffer z fWrite fRead

recBuffer :: b
          -> (Int -> a -> Buffer a -> b -> b)
          -> (Int -> Buffer a -> b -> b)
          -> Buffer a -> b
recBuffer z fWrite fRead buf = case buf of
  Empty       -> z
  Write n x b -> fWrite n x b (rec b)
  Read n b    -> fRead n b (rec b)
  where rec = recBuffer z fWrite fRead

posicionesOcupadas :: Buffer a -> [Int]
posicionesOcupadas = foldBuffer [] escribir leer
  where
    escribir n _ ocupadas = n : filter (/= n) ocupadas
    leer n ocupadas        = filter (/= n) ocupadas

contenido :: Int -> Buffer a -> Maybe a
contenido buscada = foldBuffer Nothing escribir leer
  where
    escribir n x anterior
      | n == buscada = Just x
      | otherwise    = anterior
    leer n anterior
      | n == buscada = Nothing
      | otherwise    = anterior

puedeCompletarLecturas :: Buffer a -> Bool
puedeCompletarLecturas = recBuffer True escribir leer
  where
    escribir _ _ _ ok = ok
    leer n previo ok = elem n (posicionesOcupadas previo) && ok

deshacer :: Buffer a -> Int -> Buffer a
deshacer = recBuffer (const Empty) escribir leer
  where
    escribir n x previo rec k
      | k == 0    = Write n x previo
      | otherwise = rec (k-1)
    leer n previo rec k
      | k == 0    = Read n previo
      | otherwise = rec (k-1)
```

Para

```haskell
buf = Write 1 "a" (Write 2 "b" (Write 1 "c" Empty))
```

se obtiene:

```text
posicionesOcupadas buf = [1,2]
contenido 1 buf = Just "a"
contenido 1 (Read 1 buf) = Nothing
deshacer buf 2 = Write 1 "c" Empty
```

`puedeCompletarLecturas` necesita `recBuffer`: en `Read n previo`, la validez depende de si `n` estaba ocupada en el **buffer original previo**, no solo de un booleano recursivo.

### Control del resultado

Probar exactamente los ejemplos de la guía, incluidos dos `Read 1` consecutivos: el primero puede completarse y el segundo no.

### Si te trabás

1. Procesá primero la historia interior: representa el estado anterior.
2. Una escritura pisa: agregá `n` y eliminá cualquier copia previa.
3. En `deshacer`, si `k>0` descartá el constructor externo; si `k=0`, conservá el resto original.

### Variante que conviene intentar

Definir `cantidadOperaciones = foldBuffer 0 (\_ _ r -> 1+r) (\_ r -> 1+r)` y controlar que `deshacer b n` sea `Empty` cuando `n` supera esa cantidad.

### Chuleta

> Derivar fold/rec → interpretar historia interior → usar `rec` para estado original → devolver función para contador extra.

---

## Ejercicios redundantes u opcionales

- **Ej. 20** — opcional según la guía, pero no redundante para examen: practica exactamente el patrón de derivar un fold para un árbol nuevo con recursión anidada.
- **Ej. 21** — opcional y sin aparición propia compilada; sirve para consolidar funciones como representación e invariantes.
- **Ej. 4–7** — comparten la técnica de capas finitas. Una vez dominados Ej. 4, 6 y 7, el Ej. 5 funciona como control de que se reconoce la inanición.
- **Ej. 13 y 15** — aplicaciones de combinadores ya entrenados; hacerlos después del núcleo de folds y árboles.

## Criterio para considerar dominada la guía

- Puedo derivar el tipo y las ecuaciones de `foldX` y `recX` mirando solo una declaración `data`.
- Puedo explicar, antes de programar, por qué una función requiere fold, rec o recursión general.
- Puedo hacer que un fold devuelva una función cuando queda un parámetro adicional.
- Puedo producir una enumeración infinita por capas finitas y demostrar que todo objeto aparece.
- Puedo resolver el Ej. 22 completo sin mirar la solución y verificar cada ejemplo.
- Puedo detectar cuándo un acumulador `Bool` o `Int` pierde información y reemplazarlo por un resumen más rico, como `Maybe`, extremos o una función.
- Puedo ejecutar en GHCi pruebas sobre casos vacíos, unitarios, finitos e infinitos sin forzar más estructura de la necesaria.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Ej. 14, 16, 17, 19, 20 y 22 — derivar fold/rec | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 1 | [[tipos_ejercicio/haskell_fold_tipo_arboles]] |
| Ej. 8, 16–20 y 22 — funciones vía fold | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 1b–d · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 1b–d · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1b · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1b–d · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 1b–c | [[tipos_ejercicio/haskell_funciones_sobre_arboles]] |
| Ej. 12, 18 y 22 — fold/rec que devuelve función | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 1d · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1d · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1e | [[tipos_ejercicio/haskell_currificacion_evaluacion_parcial]] |
| Ej. 10, 11, 17 y 22 — `rec` vs fold | 🔴 | [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 1d · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1c · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1d | [[tipos_ejercicio/haskell_recursion_primitiva_rec]] |
| Ej. 1–7, 9, 13, 15 y 21 — fundamentos y variantes vigentes | 🟡 | Variante de generación en [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 1d; sin patrón independiente para los demás | [[tipos_ejercicio/haskell_funciones_sobre_arboles]] |

**Base de comparación:** 11 parciales analizados, 23 patrones en `tipos_ejercicio/`. El tema `programacion_funcional` tiene cuatro patrones compilados y todos fueron contrastados solo contra los parciales que citan. La forma global es estable: los cinco exámenes distintos enlazados por `haskell_fold_tipo_arboles` toman en el Ej. 1 un tipo algebraico nuevo, su esquema y funciones derivadas.

## Lo que este documento NO cubre y igual toman

Ninguno dentro de `programacion_funcional`: la guía cubre los cuatro patrones compilados del tema.

## Divergencias detectadas

- La guía vigente numera y agrupa los ejercicios de forma distinta de [[programacion_funcional_guia]], que proviene del material histórico: la vigente ubica generación infinita en los Ej. 4–7 y agrega `Buffer` como Ej. 22. No se modificó ni reconcilió la wiki.
- El Ej. 22 vigente reproduce el tipo y las consignas centrales del [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1; por eso se prioriza como práctica literal de parcial, aunque no figure en la guía histórica ingestada.
