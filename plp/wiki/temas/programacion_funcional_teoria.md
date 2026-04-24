---
nombre: Teoría de Programación Funcional
parcial: 1P
tipo: Clase teórica
tema: Programación Funcional
fuente: 
  - raw/clases/teo/0.teo_1P_repaso.pdf
  - raw/clases/teo/1.teo_1P_programacion_funcional.pdf
  - raw/clases/teo/2.teo_1P_esquemas_recursion_&_tipos_datos_inductivos.pdf
paginas_relacionadas: []
---

# Introducción a la materia y Programación funcional básica

## Presentación de la materia

La materia Paradigmas de Programación estudia tres aspectos de los lenguajes de programación:
- Programación
- Semántica
- Implementación

### Motivación: programación
Los lenguajes de programación tienen distintas características:
- Etiquetado dinámico vs. tipado estático.
- Administración manual vs. automática de memoria.
- Funciones de primer orden vs. funciones de orden superior.
- Mutabilidad vs. inmutabilidad.
- Alcance dinámico vs. estático.
- Resolución de nombres temprana vs. tardía.
- Inferencia de tipos.
- Determinismo vs. no determinismo.
- Pasaje de parámetros por copia o por referencia.
- Evaluación estricta (por valor) o diferida (por necesidad).
- Tipos de datos inductivos, co-inductivos, GADTs, familias dependientes.
- Pattern matching, unificación.
- Polimorfismo paramétrico.
- Subclasificación, polimorfismo de subtipos, herencia simple vs. múltiple.
- Estructuras de control no local.

Distintas características permiten abordar un mismo problema de distintas maneras.

| Tipado dinámico | Tipado estático | Tipado gradual |
| --- | --- | --- |
| **Funcional:** Erlang, Elixir, Clojure | Haskell, ML, Elm, F# | Typed Clojure |
| **Lógico:** Prolog | Datalog | |
| **Objetos:** Python, JavaScript, Ruby, Smalltalk | C#, Java | TypeScript |

### Motivación: semántica
Dependemos del software en aplicaciones críticas (telecomunicaciones, procesos industriales, aeronáutica, vehículos autónomos, etc.). Las fallas cuestan recursos monetarios y vidas humanas.

Objetivo:
- Probar teoremas sobre el comportamiento de los programas.
- Dar significado matemático a los programas.

### Motivación: implementación
Una computadora física ejecuta programas escritos en código máquina.
¿Cómo es capaz de ejecutar programas escritos en otros lenguajes?
- Interpretación (o evaluación).
- Chequeo e inferencia de tipos.
- Compilación (traducción de un lenguaje a otro).

### ¿Qué es un programa?
Un programa se puede escribir de muchas maneras:
- **PI:** secuencia de instrucciones
- **PF:** lista de ecuaciones
- **PL:** base de conocimientos y una consulta
- **POO:** colaboraciones entre objetos

Un programa es un modelo computable de un dominio de problema. Una **descripción ejecutable**.
Está hecho para:
- ser ejecutado por computadoras (visión operacional), y para
- ser leído y mantenido por seres humanos (visión denotacional).

---

## Programación con tipos básicos y secuencias

Definir las siguientes funciones:

- `factorial :: Int -> Int`: dado un entero n ≥ 0, devuelve n!.
- `sumaN :: Int -> [Int] -> [Int]`: dado un entero k y una lista xs, devuelve la lista que resulta de sumarle k a cada elemento de xs.
- `aparece :: Char -> String -> Bool`: dado un caracter c y un string s, devuelve un booleano que indica si c aparece en s.
  Más en general: `aparece :: Eq a => a -> [a] -> Bool`
- `ordenar :: [Float] -> [Float]`: dada una lista, devuelve su permutación ordenada.
  Más en general: `ordenar :: Ord a => [a] -> [a]`

---

## Tipos de datos inductivos

### Tipos enumerados
Dado el siguiente tipo de datos:
```haskell
data Direccion = Norte | Este | Sur | Oeste
```
definir la función
```haskell
opuesta :: Direccion -> Direccion
```
que dada una dirección d, devuelve la dirección opuesta a d.

### Tipos opcionales
Definir la función
```haskell
elUltimoIndiceDe :: Eq a => a -> [a] -> Int
```
que dado un elemento x y una lista de elementos xs, devuelve el índice de la última ocurrencia de x en xs.
Es una función parcial. ¿Cómo la podemos hacer total?
Podemos usar el siguiente tipo de datos:
```haskell
data Maybe a = Nothing | Just a
```
Redefinir ahora la función para que sea total, con el siguiente tipo:
```haskell
elUltimoIndiceDe :: Eq a => a -> [a] -> Maybe Int
```

### Árboles
Dado el siguiente tipo de datos:
```haskell
data AB a = Nil | Bin (AB a) a (AB a)
```
- Dibujar y escribir en Haskell todos los árboles que tienen 3 nodos, en todos los cuales se encuentra el número 0.
- Definir las funciones:
  1. `preorder :: AB a -> [a]`
  2. `inorder :: AB a -> [a]`
  3. `postorder :: AB a -> [a]`

---

## Tipos abstractos de datos

### Conjunto sobre listas
Implementemos un conjunto con la siguiente interfaz:
```haskell
vacio :: Conj a
insertar :: Eq a => a -> Conj a -> Conj a
pertenece :: Eq a => a -> Conj a -> Bool
eliminar :: Eq a => a -> Conj a -> Conj a
```
Elegimos la siguiente estructura de representación:
```haskell
data Conj a = CConj [a]
```
con el siguiente invariante:
- La lista no debe contener elementos repetidos.

Es importante notar que los resultados de las operaciones no dependen de la implementación elegida.

### Diccionario sobre árboles binarios de búsqueda
Implementemos un diccionario con la siguiente interfaz:
```haskell
vacio :: Dict k v
definir :: Ord k => k -> v -> Dict k v -> Dict k v
buscar :: Ord k => k -> Dict k v -> Maybe v
```
Elegimos la siguiente estructura de representación:
```haskell
data Dict k v = CDict (AB (k, v))
```
con el siguiente invariante:
- El árbol binario debe ser un árbol binario de búsqueda.
Es decir, en cada subárbol:
- Las claves del subárbol izquierdo son menores que la raíz.
- Las claves del subárbol derecho son mayores que la raíz.

---

## Enumeraciones combinatorias

### Subsecuencias
Definir una función: `subsecuencias :: [a] -> [[a]]` que dada una lista, devuelva la lista de todas sus posibles subsecuencias.
Por ejemplo, las subsecuencias de `[1, 2, 3]` son:
```haskell
[[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]]
```

### Permutaciones
Definir una función: `permutaciones :: [a] -> [[a]]` que dada una lista, devuelva la lista de todas sus posibles permutaciones.
Por ejemplo, las permutaciones de `[1, 2, 3]` son:
```haskell
[[1, 2, 3], [1, 3, 2], [2, 1, 3],
 [2, 3, 1], [3, 1, 2], [3, 2, 1]]
```

## Bibliografía y Lectura Recomendada
- Capítulos 1–3 del libro de Bird: Richard Bird. Thinking functionally with Haskell. Cambridge University Press, 2015.

---

# Fundamentos de programación funcional

## Conceptos Core
La programación funcional consiste en definir funciones y aplicarlas para procesar información.
Las "funciones" son verdaderamente funciones matemáticas (o parciales):
- Aplicar una función no tiene **efectos secundarios**.
- A una misma entrada corresponde siempre la misma salida.
- Las estructuras de datos son **inmutables**.

Las funciones son datos como cualquier otro:
- Se pueden pasar como parámetros.
- Se pueden devolver como resultados.
- Pueden formar parte de estructuras de datos (ej. árbol binario en cuyos nodos hay funciones).

Un programa funcional está dado por un conjunto de **ecuaciones**.
Ejemplo de ejecución por sustitución:
```haskell
longitud [] = 0
longitud (x : xs) = 1 + longitud xs

longitud [10, 20, 30] 
= longitud (10 : (20 : (30 : [])))
= 1 + longitud (20 : (30 : []))
= 1 + (1 + longitud (30 : []))
= 1 + (1 + (1 + longitud []))
= 1 + (1 + (1 + 0))
= 3
```

## Expresiones y Tipos

### Expresiones
Las expresiones son secuencias de símbolos que sirven para representar datos, funciones y funciones aplicadas a los datos.
1. **Un constructor:** `True`, `False`, `[]`, `(:)`, `0`, `(+)`
2. **Una variable:** `longitud`, `x`, `xs`
3. **La aplicación:** `ordenar lista`, `not True`, `((+) 1) (alCuadrado 5)`

**Convenio:** La aplicación es asociativa a izquierda.
`f x y ≡ (f x) y`
`f a b c d ≡ (((f a) b) c) d`

### Tipos y Polimorfismo
Un tipo es una especificación del invariante de un dato o de una función. Expresa un contrato.
- Condiciones de tipado: todas las expresiones deben tener tipo, cada variable se usa con un mismo tipo, ambos lados de una ecuación deben tener el mismo tipo, el argumento debe coincidir con el dominio y el resultado con el codominio.
- **Convenio:** `->` es asociativo a derecha. `a -> b -> c ≡ a -> (b -> c)`

Hay expresiones que tienen más de un tipo (Polimorfismo paramétrico). Usamos variables de tipo `a, b, c`.
```haskell
id :: a -> a
(:) :: a -> [a] -> [a]
```

**Nota sobre re-utilización de variables:** "Cada variable se debe usar siempre con un mismo tipo" aplica al alcance de la variable. Es válido usar la misma letra (ej. `x`) en diferentes funciones con diferentes tipos.

## Modelo de Cómputo

Dada una expresión, se computa su valor usando las ecuaciones.
Hay expresiones bien tipadas que no tienen valor (ej. `1 / 0`). Se dice que se indefinen o tienen valor `⊥` (bottom).

Una ecuación `e1 = e2` se interpreta desde dos puntos de vista:
1. **Denotacional:** Declara que `e1` y `e2` tienen el mismo significado.
2. **Operacional:** Computar el valor de `e1` se reduce a computar el valor de `e2`.

El lado izquierdo de una ecuación debe ser una función aplicada a **patrones**.
Un patrón puede ser:
- Una variable.
- Un comodín `_`.
- Un constructor aplicado a patrones.
- *(Regla: no debe contener variables repetidas).*

### Evaluación
Consiste en:
1. Buscar la subexpresión más externa que coincida con el lado izquierdo de una ecuación.
2. Reemplazar por el lado derecho.
3. Continuar la evaluación.

Se detiene cuando se alcanza:
1. Un constructor o constructor aplicado (`True`, `[1, 2, 3]`).
2. Una función parcialmente aplicada (`(+) 5`).
3. Se alcanza un estado de error o no terminación (loop infinito).

**Evaluación no estricta (Perezosa):**
Permite listas infinitas y trabajar con estructuras potencialmente indefinidas si la función no necesita evaluarlas.
```haskell
desde :: Int -> [Int]
desde n = n : desde (n + 1)

head (tail (desde 0)) ⇝ head (tail (0 : desde 1)) ⇝ head (desde 1) ⇝ head (1 : desde 2) ⇝ 1
```

*Importante:* En Haskell, el orden de las ecuaciones es relevante. Se evalúan de arriba hacia abajo y se usa la primera que coincide.

## Funciones de Orden Superior

Son funciones que reciben o devuelven otras funciones. Permiten abstraer esquemas de recursión comunes.

### Composición (`.`)
```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
(g . f) x = g (f x)
-- o equivalentemente:
g . f = \ x -> g (f x)
```

### Abstracción de esquemas

**Esquema `map`:**
Aplica una transformación a cada elemento de una lista.
```haskell
map :: (a -> b) -> [a] -> [b]
map f [] = []
map f (x : xs) = f x : map f xs

-- Ejemplo
dobleL = map (* 2)
```

**Esquema `filter`:**
Filtra elementos de una lista según un predicado.
```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter p [] = []
filter p (x : xs) = if p x then x : filter p xs else filter p xs

-- Ejemplo
noVacias = filter (not . null)
```

---

## Ejercicios / Práctica Teórica

1. **Merge / Mergesort:**
```haskell
merge :: (a -> a -> Bool) -> [a] -> [a] -> [a]
mergesort :: (a -> a -> Bool) -> [a] -> [a]
```

2. **Esquemas de recursión (Fold/Reduce y While):**
```haskell
-- operatoria (equivalente a foldr/foldl1 dependiendo de la implementación)
operatoria :: (a -> a -> a) -> [a] -> a

-- iteración condicional
mientras :: (a -> Bool) -> (a -> a) -> a -> a
```

3. **Árboles binarios infinitos:**
```haskell
data ABI a = IBin (ABI a) a (ABI a)

podadoDesdeElNivel :: Int -> ABI a -> AB a

-- Funciones de caminos
data Direccion = Izq | Der
type Camino = [Direccion]
type FuncionDeCaminos a = Camino -> a

funcionDeCaminosDe :: ABI a -> FuncionDeCaminos a
abiDe :: FuncionDeCaminos a -> ABI a
```

## Bibliografía Adicional
- Capítulo 4 del libro de Bird: Richard Bird. *Thinking functionally with Haskell*. Cambridge University Press, 2015.

---

# Esquemas de Recursión y Tipos de Datos Inductivos

## Esquemas de recursión sobre listas

Existen patrones comunes de recursión que pueden ser abstraídos en funciones de orden superior.

### 1. Recursión Estructural (`foldr`)
Una función está dada por recursión estructural si:
1. El caso base devuelve un valor "fijo" (no depende de la función recursiva).
2. El caso recursivo no puede usar la función ni la cola directamente, salvo en el llamado recursivo sobre la cola.

**Ejemplo - Suma:**
```haskell
suma :: [Int] -> Int
suma [] = 0
suma (x : xs) = x + suma xs
```

El esquema de recursión estructural se abstrae con **foldr** (plegado a derecha):
```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z [] = z
foldr f z (x : xs) = f x (foldr f z xs)

-- Ejemplos
suma = foldr (+) 0
producto = foldr (*) 1
reverse = foldr (\x rec -> rec ++ [x]) []
```

### 2. Recursión Primitiva (`recr`)
Similar a la recursión estructural, pero el caso recursivo permite referirse directamente a la cola (`xs`).
**Esquema `recr`**:
```haskell
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f z [] = z
recr f z (x : xs) = f x xs (recr f z xs)
```
*Toda definición por recursión estructural también es primitiva, pero no al revés.*

### 3. Recursión a la Cola (`foldl`)
Una función está dada por recursión a la cola si:
1. El caso base devuelve el acumulador.
2. El caso recursivo invoca inmediatamente a la función recursiva sobre la cola de la lista, pasando el acumulador actualizado en función del elemento actual.

Se abstrae con **foldl** (plegado a izquierda):
```haskell
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f ac [] = ac
foldl f ac (x : xs) = foldl f (f ac x) xs

-- Ejemplos
foldl (flip (:)) [] = reverse
```

**Diferencia `foldr` vs `foldl`:**
- `foldr (F) z [a, b, c] = a F (b F (c F z))`
- `foldl (F) z [a, b, c] = ((z F a) F b) F c`
Si `F` es asociativo y conmutativo, ambas devuelven el mismo resultado. `foldl` actúa como un bucle iterativo (while) manteniendo un estado (el acumulador).

## Tipos de Datos Algebraicos

En Haskell podemos definir nuevos tipos utilizando la cláusula `data`.

### Variantes de Tipos Algebraicos
1. **Tipos enumerados** (Muchos constructores sin parámetros):
   `data Dia = Dom | Lun | Mar | Mie | Jue | Vie | Sab`
2. **Tipos producto / tuplas** (Un solo constructor con muchos parámetros):
   `data Persona = LaPersona String String Int`
3. **Tipos con múltiples constructores y parámetros**:
   `data Forma = Rectangulo Float Float | Circulo Float`
4. **Tipos recursivos** (Tienen constructores que reciben como parámetro un valor del mismo tipo):
   `data Nat = Zero | Succ Nat`

Las listas y los árboles binarios son casos particulares de tipos algebraicos recursivos:
```haskell
-- Listas
data [a] = [] | a : [a]

-- Árboles binarios
data AB a = Nil | Bin (AB a) a (AB a)
```

## Recursión Estructural en Tipos Algebraicos

El concepto de recursión estructural se generaliza a cualquier tipo algebraico recursivo `T`:
1. Cada caso base se escribe combinando los parámetros.
2. Cada caso recursivo no usa la función `g` ni los parámetros de tipo `T` del constructor (salvo para hacer llamados recursivos sobre ellos). Sí puede usar los parámetros que no son de tipo `T`.

**Ejemplo sobre Árboles Binarios (`foldAB`)**:
```haskell
foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB cNil cBin Nil = cNil
foldAB cNil cBin (Bin i r d) =
  cBin (foldAB cNil cBin i) r (foldAB cNil cBin d)
```

## Bibliografía y Lectura Recomendada Adicional
- Graham Hutton. *A tutorial on the universality and expressiveness of fold*. J. Functional Programming 9 (4): 355–372, julio de 1999.
