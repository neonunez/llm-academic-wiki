---
nombre: Teoría de Interpretación
parcial: 2P
tipo: Clase teórica
tema: Interpretación
fuente: plp/raw/clases/teo/8.teo_2P_interpretacion.pdf
paginas_relacionadas: [[calculo_lambda_tipado_teoria]], [[programacion_funcional_teoria]]
---

# Teoría de Interpretación

Un **intérprete** es un programa que ejecuta programas. Involucra dos lenguajes:
1. **Lenguaje de implementación**: Lenguaje en el que está definido el intérprete (en este caso, Haskell).
2. **Lenguaje fuente**: Lenguaje en el que están escritos los programas que se interpretan.

## Sintaxis Concreta vs. Abstracta

- **Sintaxis concreta**: Representación como cadena de texto (ej: `"while (true) { x = x + 1; }"`).
- **Sintaxis abstracta (AST)**: Representación como un árbol de sintaxis. El proceso de convertir sintaxis concreta a abstracta se llama *análisis sintáctico* (fuera del alcance de esta materia).

## Intérpretes Básicos

### Lenguaje de Expresiones Aritméticas
Lenguaje minimalista con constantes y sumas:
```haskell
data Expr = EConstNum Int
          | EAdd Expr Expr
```
El intérprete tiene tipo `eval :: Expr -> Int`.

### Extensión con Booleanos y Valores
Si agregamos booleanos, el resultado de `eval` ya no es solo un `Int`. Definimos un tipo `Val`:
```haskell
data Val = VN Int
         | VB Bool

data Expr = EConstNum Int
          | EConstBool Bool
          | EAdd Expr Expr

eval :: Expr -> Val
```

### Definiciones Locales y Entornos
Para manejar `let x = e1 in e2`, necesitamos un **Entorno (Environment)** que asocie identificadores a valores.

- **Entorno (`Env a`)**: Diccionario `Id -> a`.
- **Interfaz**:
  - `emptyEnv :: Env a`
  - `lookupEnv :: Env a -> Id -> a`
  - `extendEnv :: Env a -> Id -> a -> Env a`

El tipo del intérprete pasa a ser: `eval :: Expr -> Env Val -> Val`.

## Características Imperativas

En lenguajes imperativos, las variables son **mutables**.

### Entorno vs. Memoria
- **Entorno**: Asocia cada variable a una **dirección de memoria** (`Addr`).
- **Memoria (Store)**: Asocia direcciones a **valores** (`Val`).

La evaluación de un programa puede modificar la memoria. El tipo del intérprete es:
`eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)`

### Interfaz de Memoria (`Mem a`)
- `emptyMem :: Mem a`
- `freeAddress :: Mem a -> Addr`
- `load :: Mem a -> Addr -> a`
- `store :: Mem a -> Addr -> a -> Mem a`

### Estructuras de Control
Se incluyen asignaciones (`x := e`), composición secuencial (`e1; e2`), condicionales (`if`) y bucles (`while`).

## Características Funcionales

La mayoría de los lenguajes funcionales se basan en el **Cálculo-$\lambda$**:
```haskell
data Expr = EVar Id
          | ELam Id Expr    -- \x -> e
          | EApp Expr Expr  -- e1 e2
```

### Funciones como Valores
**Primer intento (incorrecto)**: El valor de una función es su código fuente (`VFunction Id Expr`).
**Problema: Captura de variables**. En un `let`, si una función usa una variable libre que luego es redefinida en un entorno local, el resultado puede ser incorrecto (Scope dinámico vs estático).

### Clausuras (Closures)
Para solucionar la captura de variables, el valor de una función debe ser una **clausura**:
1. El código fuente de la función.
2. Un **entorno** que contiene los valores de sus variables libres al momento de la definición.

```haskell
data Val = VN Int
         | VB Bool
         | VClosure Id Expr (Env Val)
```

## Estrategias de Evaluación

Existen distintas técnicas para evaluar una aplicación `(e1 e2)`:

1. **Llamada por Valor (Call-by-value)**:
   - Se evalúa `e1` hasta obtener una clausura.
   - Se evalúa `e2` hasta obtener un **valor**.
   - Se evalúa el cuerpo de la función con el parámetro ligado al valor de `e2`.

2. **Llamada por Nombre (Call-by-name)**:
   - Se evalúa `e1` hasta obtener una clausura.
   - Se evalúa el cuerpo de la función directamente.
   - El parámetro queda ligado a la expresión `e2` **sin evaluar** (usando un **Thunk**).
   - Cada vez que se usa el parámetro, se evalúa la expresión.

### Thunks
Un **Thunk** es un dato que incluye:
1. Una expresión no evaluada.
2. Un entorno para sus variables libres.

```haskell
data Thunk = TT Expr (Env Thunk)
data Val = ... | VClosure Id Expr (Env Thunk)
```

3. **Llamada por Necesidad (Call-by-need)**: Similar a llamada por nombre pero memoriza el resultado de la primera evaluación del thunk (evaluación perezosa/lazy).
