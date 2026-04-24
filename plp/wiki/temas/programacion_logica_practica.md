---
nombre: Programación Lógica - Práctica 1
parcial: 2
tipo: clase_practica
tema: Programación Lógica
fuente: ["plp/raw/clases/prac/8.prac_P2_programacion_logica_(1).pdf", "plp/raw/clases/prac/9.prac_P2_programacion_logica_(2).pdf"]
paginas_relacionadas: ["[[resolucion_teoria]]", "[[resolucion_sld_y_prolog_teoria]]", "[[resolucion_sld_y_prolog_teoria#Negación por Falla]]"]
---

# Programación Lógica — Práctica Integral

Guía completa de práctica de Prolog, desde fundamentos y listas hasta metapredicados, control de flujo y generación en espacios infinitos.

## Fundamentos de Prolog

Prolog es un lenguaje de programación **declarativa** basado en un subconjunto de la lógica de primer orden.

- **Modelo de Cómputo**: Basado en **Cláusulas de Horn** y **Resolución SLD**.
- **Declarativo**: Se especifican hechos, reglas de inferencia y objetivos (queries). No se indica el "cómo" obtener el resultado.
- **Mundo Cerrado (Closed World Assumption)**: Todo lo que no puede deducirse a partir del programa se supone falso.
- **Tipos**: Existe un único tipo, los **términos**.

---

## Bases de Conocimiento

Un programa en Prolog se compone de una base de conocimiento que describe el dominio del problema mediante hechos y reglas.

### Ejemplo: El Apocalipsis Zombie

**Hechos y Reglas (Base de Conocimiento):**
```prolog
zombie(juan).
zombie(valeria).
tomo_mate_despues(juan, carlos). % Carlos tomó mate después de Juan
tomo_mate_despues(clara, juan). % Juan tomó mate después de Clara
infectade(ernesto).

% Reglas
infectade(X) :- zombie(X).
infectade(X) :- zombie(Y), tomo_mate_despues(Y, X).
```

**Consultas (Queries):**
- `?- zombie(juan).` → `true.`
- `?- infectade(carlos).` → `true.` (Carlos tomó mate después del zombie Juan).
- `?- infectade(clara).` → `false.` (Clara no es zombie ni tomó mate después de uno).
- `?- infectade(Quien).` → `Quien = ernesto; Quien = juan; Quien = valeria; Quien = carlos.`

---

## Aritmética y Unificación

Es crucial distinguir entre unificación, comparación y evaluación aritmética.

### Operadores Aritméticos (Evaluación)
Para evaluar expresiones se utiliza el operador `is` o los comparadores específicos.

- `X is E`: Tiene éxito si `X` unifica con el resultado de evaluar `E`.
- `E1 =:= E2`: Evalúa ambos lados y compara si son numéricamente iguales.
- `E1 =\= E2`: Evalúa ambos lados y compara si son distintos.
- `E1 < E2`, `E1 =< E2`, `E1 > E2`, `E1 >= E2`: Comparación numérica tras evaluación.

### Operadores de Unificación (No Aritméticos)
- `X = Y`: Éxito si `X` unifica con `Y`. **No evalúa**.
- `X \= Y`: Éxito si `X` no unifica con `Y`.

> [!IMPORTANT]
> `1 + 1 = 2` es **falso** (el término `1+1` no unifica con `2`).
> `1 + 1 =:= 2` es **verdadero** (se evalúan ambos lados).
> `X is 1 + 1` resulta en `X = 2`.

### Ejercicio: Predicado `entre/3`
Definir `entre(+X, +Y, -Z)` que instancie `Z` en cada entero entre `X` e `Y` inclusive.

**Resolución:**
```prolog
% Caso base: Z es el límite inferior
entre(X, Y, X) :- X =< Y.
% Caso recursivo: Z está en el rango superior
entre(X, Y, Z) :- X < Y, X1 is X + 1, entre(X1, Y, Z).
```

---

## Listas

Sintaxis: `[]` (vacía), `[H | T]` (cabeza y cola).

### Ejercicios Básicos

#### 1. Longitud de una lista
`long(+L, -N)` relaciona una lista con su longitud.

**Resolución:**
```prolog
long([], 0).
long([_|T], N) :- long(T, N1), N is N1 + 1.
```
> [!NOTE]
> ¿Es reversible? No directamente con `is`, ya que `is` requiere que el lado derecho esté instanciado. Para hacerlo reversible se debería usar una representación de Peano o el predicado `length/2` de la biblioteca estándar.

#### 2. Sacar elementos
`sacar(+X, +XS, -YS)` elimina todas las ocurrencias de `X` en `XS`.

**Resolución:**
```prolog
sacar(_, [], []).
sacar(X, [X|T], YS) :- sacar(X, T, YS).
sacar(X, [H|T], [H|YS]) :- X \= H, sacar(X, T, YS).
```

#### 3. Sin repeticiones consecutivas
`sinConsecRep(+XS, -YS)` devuelve una lista sin duplicados adyacentes.

**Resolución:**
```prolog
sinConsecRep([], []).
sinConsecRep([X], [X]).
sinConsecRep([X, X | T], YS) :- sinConsecRep([X | T], YS).
sinConsecRep([X, Y | T], [X | YS]) :- X \= Y, sinConsecRep([Y | T], YS).
```

---

## Manipulación con `append/3`

El predicado `append(?L1, ?L2, ?L3)` es extremadamente potente por su reversibilidad.

```prolog
append([], L, L).
append([X|L1], L2, [X|L3]) :- append(L1, L2, L3).
```

### Implementaciones basadas en `append`:

| Predicado | Definición |
| :--- | :--- |
| `prefijo(+L, ?P)` | `append(P, _, L).` |
| `sufijo(+L, ?S)` | `append(_, S, L).` |
| `sublista(+L, ?SL)` | `prefijo(L, P), sufijo(P, SL).` |
| `insertar(?X, +L, ?LX)` | `append(A, B, L), append(A, [X\|B], LX).` |
| `permutacion(+L, ?P)` | `permutacion([], []).`<br>`permutacion([H\|T], P) :- permutacion(T, PT), insertar(H, PT, P).` |

---

## Estructuras Parcialmente Instanciadas

Prolog permite trabajar con variables dentro de estructuras. Un ejemplo clásico es el predicado `capicua/1`.

**Implementación con `append`:**
```prolog
capicua([]).
capicua([_]).
capicua([H | T]) :- append(M, [H], T), capicua(M).
```

Si consultamos `?- capicua(L).`, Prolog generará infinitas listas que cumplen la propiedad:
1. `L = []`
2. `L = [_]`
3. `L = [_A, _A]`
4. `L = [_A, _, _A]`
...

**Solución alternativa (usando `reverse`):**
```prolog
capicua(L) :- reverse(L, L).
```

---

## Seguimiento de `member/2`

Predicado estándar:
```prolog
member(X, [X|_]).
member(X, [_|L]) :- member(X, L).
```

**Análisis de consultas:**
- `?- member(2, [1, 2]).` → `true.` (Segunda cláusula, luego primera).
- `?- member(X, [1, 2]).` → `X = 1; X = 2.` (Generador).
- `?- member(5, [X, 3, X]).` → `X = 5.` (Unifica `X` con `5` en el primer intento).
- `?- length(L, 2), member(5, L), member(2, L).` → `L = [5, 2]; L = [2, 5].` (Genera listas de tamaño 2 y ubica los elementos).

---

## Control de Flujo: El Operador Cut (`!`)

El "corte" permite podar ramas del árbol de búsqueda SLD, limitando el backtracking.

### Tipos de Corte
- **Corte Verde (Green Cut)**: No altera el conjunto de soluciones del predicado. Solo se utiliza por eficiencia (evita buscar en ramas que sabemos que fallarán o que darán soluciones ya encontradas).
- **Corte Rojo (Red Cut)**: Altera el conjunto de soluciones. Si se quita el corte, el programa se comporta de forma distinta (podría dar soluciones incorrectas).

### Ejemplo de Corte Rojo: `if-then-else`
```prolog
% max(X, Y, Max)
max(X, Y, X) :- X >= Y, !.
max(X, Y, Y). % Si llegamos aquí es porque X < Y
```

---

## Negación por Falla (`\+`)

Prolog implementa la negación mediante el principio de **Negación como Falla (Negation as Failure)**.

- `\+ Goal` tiene éxito si `Goal` falla.
- No es una negación lógica pura (no significa "es falso", sino "no puedo probar que sea cierto").

> [!CAUTION]
> **Peligro con variables libres**: `\+ p(X)` intenta probar si existe algún `X` tal que `p(X)`. Si lo encuentra, `\+ p(X)` falla. Si no lo encuentra, tiene éxito pero **no instancía X**.

---

## Metapredicados

Predicados que toman otros predicados (objetivos) como argumentos.

### Recolección de Soluciones
| Predicado | Descripción |
| :--- | :--- |
| `findall(X, Goal, L)` | Lista `L` con todos los `X` que cumplen `Goal`. Ignora variables libres en `Goal`. Devuelve `[]` si no hay soluciones. |
| `bagof(X, Goal, L)` | Similar a `findall`, pero preserva el orden de aparición y agrupa por variables libres en `Goal`. Falla si no hay soluciones. |
| `setof(X, Goal, L)` | Similar a `bagof`, pero devuelve la lista **ordenada y sin duplicados**. |

### Predicados de Orden Superior
- `maplist(:Goal, ?List)`: Tiene éxito si `Goal` se cumple para cada elemento de `List`.
- `maplist(:Goal, ?List1, ?List2)`: Aplica el predicado binario a pares de elementos.
- `forall(:Gen, :Cond)`: Éxito si para toda solución de `Gen`, se cumple `Cond`. (Equivale a `\+ (Gen, \+ Cond)`).
- `limit(+Count, :Goal)`: Limita el número de soluciones encontradas por el backtracking.

---

## Ejercicio Integrador: Generación Infinita (Triángulos)

Representamos un triángulo como `tri(A, B, C)`.
Predicado auxiliar: `esTriangulo(+T)` verifica la desigualdad triangular.

### Objetivo
Implementar `perimetro(?T, ?P)` que funcione para cualquier instanciación, sin repetir resultados.

**Resolución:**
Para que sea reversible y no entre en un bucle infinito al generar, debemos utilizar una estrategia de **búsqueda por niveles** (diagonalización), generando el perímetro primero.

```prolog
% Generador de números naturales
desde(N, N).
desde(N, X) :- N1 is N + 1, desde(N1, X).

% perimetro(?T, ?P)
perimetro(tri(A, B, C), P) :-
    nonvar(P), !,           % Caso 1: P instanciado
    entre(1, P, A),
    entre(1, P, B),
    C is P - (A + B),
    C > 0,
    esTriangulo(tri(A, B, C)).

perimetro(tri(A, B, C), P) :-
    nonvar(A), nonvar(B), nonvar(C), !, % Caso 2: T instanciado
    P is A + B + C,
    esTriangulo(tri(A, B, C)).

perimetro(T, P) :-         % Caso 3: Generador total
    desde(3, P),           % Generamos perímetros crecientes
    perimetro(T, P).       % Recurrimos al Caso 1
```

### Generador de Triángulos
`triangulo(-T)` simplemente utiliza el generador de perímetros:
```prolog
triangulo(T) :- perimetro(T, _).
```

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/prolog_listas_append]] · [[tipos_ejercicio/prolog_generar_testear]] · [[tipos_ejercicio/prolog_maximo_doble_not]] · [[tipos_ejercicio/prolog_reversibilidad]]
