---
nombre: Programación Lógica — Guia de Ejercicios
parcial: 2P
tipo: guia
tema: programacion_logica
fuente: raw/guias_practicas/7.guia_2P_programacion_logica.pdf
paginas_relacionadas:
  - "[[resolucion_sld_y_prolog_teoria]]"
  - "[[programacion_logica_practica]]"
---

# Programación Lógica — Guía de Ejercicios

## Indice de ejercicios

### El Motor de Búsqueda de Prolog
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Relaciones familiares y recursión infinita | ⚪ No |
| Ej. 2 | Predicado `vecino` y árbol de búsqueda | ⚪ No |
| Ej. 3 | Naturales y `menorOIgual` (generación infinita) | 🔴 Si |

### Operaciones sobre Listas
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 4 | Predicado `juntar` (append) | 🔴 Si |
| Ej. 5 | Operaciones clásicas: `last`, `reverse`, `prefijo`, etc. | 🔴 Si |
| Ej. 6 | Predicado `aplanar` (flatten) | 🔴 Si |
| Ej. 7 | Operaciones avanzadas: `intersección`, `partir`, `borrar`, `permutación`, `reparto` | 🔴 Si |
| Ej. 8 | Predicado `parteQueSuma` | 🔴 Si |

### Instanciación y Reversibilidad
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 9 | Predicado `desde` y reversibilidad | 🔴 Si |
| Ej. 10 | Predicado `intercalar` | ⚪ No |
| Ej. 11 | Árboles binarios: altura, cantidad de nodos | 🔴 Si |
| Ej. 12 | Inorder, Árboles Binarios de Búsqueda (ABB) | 🔴 Si |

### Generate & Test
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 13 | Números coprimos | ⚪ No |
| Ej. 14 | Cuadrados mágicos y semi-mágicos | 🔴 Si |
| Ej. 15 | Triángulos y perímetros (generación por niveles) | 🔴 Si |

### Negación por Falla y Cut
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 16 | Heladería: uso de `cut` (!) y `not` | 🔴 Si |
| Ej. 17 | Comportamiento de `not` y orden de literales | 🔴 Si |
| Ej. 18 | Predicado `corteMásParejo` | ⚪ No |
| Ej. 19 | Mínimo elemento que satisface una propiedad | ⚪ No |
| Ej. 20 | Próximo número poderoso | ⚪ No |
| Ej. 21 | Representación de conjuntos y doble negación | 🔴 Si |

### Ejercicios Integradores
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 22 | Grafos: caminos simples, conexidad, estrella | 🔴 Si |
| Ej. 23 | Árboles binarios: generación y filtrado | 🔴 Si |

---

## El Motor de Búsqueda de Prolog

### Ejercicio 1 — Relaciones familiares

**Enunciado**
Considerar la siguiente base de conocimiento:
```prolog
padre(juan, carlos).    padre(luis, pablo).
padre(juan, luis).      padre(luis, manuel).
padre(carlos, daniel).  padre(luis, ramiro).
padre(carlos, diego).   abuelo(X,Y) :- padre(X,Z), padre(Z,Y).
```
I. ¿Cuál el resultado de la consulta `?- abuelo(X, manuel)?`
II. Definir los predicados: `hijo`, `hermano` y `descendiente`.
III. Dibujar el árbol de búsqueda para `?- descendiente(Alguien, juan).`
IV. ¿Qué consulta encontraría a los nietos de Juan?
V. Definir una consulta para conocer a todos los hermanos de pablo.
VI. Considerar el agregado de:
```prolog
ancestro(X, X).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).
```
VII. ¿Qué sucede con `?- ancestro(juan, X).` si se pide más de un resultado?
VIII. Sugerir una solución al problema de recursión infinita.

**Explicacion**
Evalúa el conocimiento sobre el algoritmo de búsqueda de Prolog (DFS), la instanciación de variables y los peligros de la recursión por izquierda.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 2 — Predicado `vecino`

**Enunciado**
Sea el programa: `vecino(X, Y, [X|[Y|Ls]]).` y `vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).`
I. Mostrar el árbol de búsqueda para `?- vecino(5, Y, [5,6,5,3]).`
II. Si se invierte el orden de las reglas, ¿cambian los resultados o su orden?

**Explicacion**
Análisis de cómo Prolog recorre una lista para encontrar elementos adyacentes.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 3 — Naturales y `menorOIgual`

**Enunciado**
```prolog
natural(0).
natural(suc(X)) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
menorOIgual(X, X) :- natural(X).
```
I. ¿Qué sucede con `?- menorOIgual(0, X).`?
II. Describir las circunstancias en las que puede colgarse un programa en Prolog.
III. Corregir la definición para que funcione adecuadamente.

**Explicacion**
Problema de generación infinita. Al buscar `X` tal que `0 <= X`, la primera regla permite incrementar `Y` (en `suc(Y)`) indefinidamente sin llegar nunca al caso base si el árbol de búsqueda no está bien podado o estructurado.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Operaciones sobre Listas

### Ejercicio 4 — Predicado `juntar`

**Enunciado**
Definir `juntar(?Lista1, ?Lista2, ?Lista3)` (equivalente a `append/3`). Analizar su reversibilidad con consultas como `?- juntar(L1, L2, [1,2,3]).`

**Explicacion**
El "Hola Mundo" de la reversibilidad en Prolog.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 5 — Operaciones clásicas con `append`

**Enunciado**
Definir usando `append`: `last`, `reverse`, `prefijo`, `sufijo`, `sublista`, `pertenece` (member).

**Explicacion**
Práctica de modelado declarativo utilizando un único predicado base potente.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 6 — Predicado `aplanar`

**Enunciado**
Definir `aplanar(+Xs, -Ys)` que elimina todos los niveles de anidamiento de una lista.
Ejemplo: `?- aplanar([a, [3, b, []], [2]], L).` → `L = [a, 3, b, 2]`.

**Explicacion**
Recursión sobre listas de listas. Requiere distinguir entre elementos atómicos y listas.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 7 — Intersección y Reparto

**Enunciado**
Definir:
I. `intersección(+L1, +L2, -L3)`
II. `partir(N, L, L1, L2)`: `L1` tiene los primeros `N` elementos.
III. `borrar(+ListaOriginal, +X, -ListaSinX)`
IV. `sacarDuplicados(+L1, -L2)`
V. `permutación(+L1, ?L2)`
VI. `reparto(+L, +N, -LListas)`: reparte `L` en `N` listas.
VII. `repartoSinVacías(+L, -LListas)`

**Explicacion**
Ejercicios de manipulación de listas y recursión.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 8 — Parte que suma

**Enunciado**
Definir `parteQueSuma(+L, +S, -P)` donde `P` es una sublista de `L` cuyos elementos suman `S`.

**Explicacion**
Combinación de generación de subconjuntos y suma aritmética.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Instanciación y Reversibilidad

### Ejercicio 9 — Predicado `desde`

**Enunciado**
`desde(X, X).` y `desde(X, Y) :- N is X + 1, desde(N, Y).`
I. ¿Cómo deben instanciarse los parámetros para que no se cuelgue?
II. Dar una versión `desdeReversible(+X, ?Y)`.

**Explicacion**
El predicado `desde` original es un generador infinito. Para ser reversible, debe controlar la instanciación de sus argumentos.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 11 — Árboles Binarios

**Enunciado**
Representación: `nil` o `bin(izq, v, der)`. Definir `vacío`, `raiz`, `altura` y `cantidadDeNodos`.

**Explicacion**
Recursión sobre estructuras de datos no lineales.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 12 — Inorder y ABB

**Enunciado**
Definir:
I. `inorder(+AB, -Lista)`
II. `arbolConInorder(+Lista, -AB)`
III. `aBB(+T)` (es un Árbol Binario de Búsqueda)
IV. `aBBInsertar(+X, +T1, -T2)`

**Explicacion**
Uso de Prolog para mantener invariantes de estructuras de datos.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Generate & Test

### Ejercicio 14 — Cuadrados Mágicos

**Enunciado**
Definir `cuadradoSemiMágico(+N, -XS)` y `cuadradoMagico(+N, -XS)`. Las filas, columnas (y diagonales en el mágico) deben sumar lo mismo.

**Explicacion**
Problema de búsqueda en espacio de estados. Requiere un generador de matrices y un test de suma.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 15 — Triángulos

**Enunciado**
I. `esTriángulo(+T)`
II. `perímetro(?T, ?P)`
III. `triángulo(-T)` que genere todos los triángulos válidos.

**Explicacion**
Similar al ejercicio integrador de la práctica. Requiere diagonalización para evitar bucles infinitos en la generación.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Negación por Falla y Cut

### Ejercicio 16 — Heladería

**Enunciado**
Hechos: `frutal(f)`, `cremoso(c)`.
`leGusta(X) :- frutal(X), cremoso(X).`
`cucurucho(X, Y) :- leGusta(X), leGusta(Y).`
I. Dibujar árbol de búsqueda para `?- cucurucho(X, Y).`
II. ¿Dónde colocar `!` para podar el árbol?

**Explicacion**
Uso de `cut` para optimizar o cambiar la semántica (por ejemplo, obtener solo una combinación).

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 17 — Comportamiento de `not`

**Enunciado**
I. ¿Qué significa `?- P(Y), not(Q(Y)).`?
II. ¿Qué pasa si se invierte el orden?
III. ¿Cómo usar `not` para determinar si existe una única `Y` tal que `P(Y)`?

**Explicacion**
Análisis de la Negación por Falla y la importancia de que las variables estén instanciadas antes de aplicar `not`.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 21 — Conjuntos y Negación

**Enunciado**
Definir `conjuntoDeNaturales(X)` que sea verdadero si todos los elementos de `X` son naturales.
Indicar el error en: `conjuntoDeNaturalesMalo(X) :- not( (not(natural(E)), pertenece(E, X)) ).`

**Explicacion**
Uso de la doble negación para implementar cuantificación universal ($\forall X. \phi \equiv \neg \exists X. \neg \phi$). El error suele estar en el alcance de las variables.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Ejercicios Integradores

### Ejercicio 22 — Grafos

**Enunciado**
Dado un grafo `G` (nodos y aristas), implementar:
I. `caminoSimple(+G, +D, +H, ?L)`
II. `caminoHamiltoniano(+G, ?L)`
III. `esConexo(+G)`
IV. `esEstrella(+G)`

**Explicacion**
Problemas clásicos de grafos resueltos mediante búsqueda con retroceso (backtracking) y control de ciclos.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 23 — Generación de Árboles

**Enunciado**
I. `arbol(-A)` que genere estructuras de árboles binarios.
II. `nodosEn(?A, +L)`: nodos del árbol pertenecen a la lista `L`.
III. `sinRepEn(-A, +L)`: genera árboles con nodos de `L` sin repetir.

**Explicacion**
Generación de estructuras complejas y filtrado dinámico.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/prolog_listas_append]] · [[tipos_ejercicio/prolog_generar_testear]] · [[tipos_ejercicio/prolog_maximo_doble_not]] · [[tipos_ejercicio/prolog_reversibilidad]]
