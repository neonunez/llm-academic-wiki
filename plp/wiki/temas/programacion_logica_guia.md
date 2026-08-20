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

**I. `?- abuelo(X, manuel).`**

`abuelo(X, manuel)` se expande a `padre(X, Z), padre(Z, manuel)`. El literal seleccionado es el primero, pero Prolog resuelve de izquierda a derecha: busca `padre(X, Z)` y luego verifica `padre(Z, manuel)`. La única solución es:

- `padre(luis, manuel)` fija `Z = luis`; `padre(juan, luis)` fija `X = juan`.

Resultado: **`X = juan`** (única solución).

**II. Predicados `hijo`, `hermano`, `descendiente`**

```prolog
% hijo(?X, ?Y) — X es hijo de Y. Totalmente reversible: sólo invierte los
% argumentos de un hecho, no usa aritmética.
hijo(X, Y) :- padre(Y, X).

% hermano(?X, ?Y) — comparten padre y son distintos.
% Modo de uso: cualquiera de los dos puede venir libre o instanciado.
% Ojo: X \= Y exige que al menos uno esté instanciado al momento de evaluarse;
% como padre/2 los instancia antes, aquí es seguro.
hermano(X, Y) :- padre(P, X), padre(P, Y), X \= Y.

% descendiente(?X, ?Y) — X es descendiente de Y.
% Recursión a derecha sobre padre/2 (base de hechos finita) => termina.
descendiente(X, Y) :- padre(Y, X).
descendiente(X, Y) :- padre(Y, Z), descendiente(X, Z).
```

**III. Árbol de búsqueda de `?- descendiente(Alguien, juan).`**

Notación: `R1` = primera cláusula de `descendiente`, `R2` = segunda.

```
?- descendiente(Alguien, juan)
├── R1: padre(juan, Alguien)
│     ├── Alguien = carlos                        ✔ (1ª solución)
│     └── Alguien = luis                          ✔ (2ª solución)
└── R2: padre(juan, Z), descendiente(Alguien, Z)
      ├── Z = carlos → descendiente(Alguien, carlos)
      │     ├── R1: padre(carlos, Alguien)
      │     │     ├── Alguien = daniel            ✔ (3ª solución)
      │     │     └── Alguien = diego             ✔ (4ª solución)
      │     └── R2: padre(carlos, Z'), descendiente(Alguien, Z')
      │           ├── Z' = daniel → padre(daniel, _) falla   ✗
      │           └── Z' = diego  → padre(diego, _) falla    ✗
      └── Z = luis → descendiente(Alguien, luis)
            ├── R1: padre(luis, Alguien)
            │     ├── Alguien = pablo             ✔ (5ª solución)
            │     ├── Alguien = manuel            ✔ (6ª solución)
            │     └── Alguien = ramiro            ✔ (7ª solución)
            └── R2: padre(luis, Z'), descendiente(Alguien, Z')
                  └── Z' ∈ {pablo, manuel, ramiro} → sin hijos  ✗
```

Orden de respuestas (DFS, cláusulas de arriba hacia abajo): `carlos, luis, daniel, diego, pablo, manuel, ramiro`. El árbol es **finito** porque cada rama consume una arista de `padre/2`, que es un conjunto finito y acíclico de hechos.

**IV. Nietos de Juan**

```prolog
?- abuelo(juan, N).
% equivalentemente: ?- padre(juan, Z), padre(Z, N).
% N = daniel ; N = diego ; N = pablo ; N = manuel ; N = ramiro
```

**V. Hermanos de pablo**

```prolog
?- hermano(H, pablo).
% H = manuel ; H = ramiro
% (la condición H \= pablo evita que pablo se devuelva como hermano de sí mismo)
```

**VI–VII. `ancestro` con recursión por izquierda**

```prolog
ancestro(X, X).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).   % ← recursión POR IZQUIERDA
```

`?- ancestro(juan, X).` produce respuestas y **después se cuelga**:

1. Cláusula 1: `X = juan`.
2. Cláusula 2: el literal seleccionado es `ancestro(Z, X)`. Con la cláusula 1 (`Z = X`) queda `padre(juan, X)` → `X = carlos`, `X = luis`.
3. Al pedir más, `ancestro(Z, X)` reentra por la cláusula 2 → nivel 2: da los nietos `daniel, diego, pablo, manuel, ramiro`.
4. Al pedir más, baja al nivel 3, 4, 5, … Como no hay bisnietos, ninguna rama profunda tiene éxito, pero **la recursión por izquierda nunca se detiene**: el literal seleccionado siempre vuelve a ser `ancestro(_, _)` sin que ningún argumento se achique. Prolog entra en una rama infinita (stack overflow).

Es exactamente la **incompletitud de Prolog por DFS**: la refutación no existe más allá del nivel 3, pero la búsqueda en profundidad no lo descubre nunca.

**VIII. Solución al problema**

Convertir la recursión por izquierda en recursión a derecha, poniendo primero el literal que **consume** la base de hechos finita:

```prolog
ancestro(X, X).
ancestro(X, Y) :- padre(X, Z), ancestro(Z, Y).
```

Ahora `padre(X, Z)` se resuelve primero y fija `Z` a un hijo concreto; la llamada recursiva baja un nivel del árbol genealógico, que tiene profundidad finita ⇒ **termina**. Nótese que la semántica declarativa es la misma; sólo cambió el orden de los literales, que en Prolog **sí** afecta la terminación.

**Chuleta**
> 1. `abuelo(X, manuel)` → `padre(X,Z), padre(Z,manuel)` → **X = juan** (única).
> 2. `hijo(X,Y) :- padre(Y,X).` · `hermano(X,Y) :- padre(P,X), padre(P,Y), X \= Y.` · `descendiente` = `padre` + recursión a derecha.
> 3. Árbol de `descendiente(A, juan)`: R1 da hijos (carlos, luis) → R2 baja un nivel y da nietos/bisnietos. Finito y ordenado por DFS.
> 4. `ancestro(X,Y) :- ancestro(Z,Y), padre(X,Z).` es **recursión por izquierda**: da respuestas y después se cuelga (rama infinita, DFS incompleto).
> 5. Arreglo: poner el literal finito primero → `ancestro(X,Y) :- padre(X,Z), ancestro(Z,Y).` Misma semántica declarativa, distinta terminación.

---

### Ejercicio 2 — Predicado `vecino`

**Enunciado**
Sea el programa: `vecino(X, Y, [X|[Y|Ls]]).` y `vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).`
I. Mostrar el árbol de búsqueda para `?- vecino(5, Y, [5,6,5,3]).`
II. Si se invierte el orden de las reglas, ¿cambian los resultados o su orden?

**Explicacion**
Análisis de cómo Prolog recorre una lista para encontrar elementos adyacentes.

**Resolucion paso a paso**

```prolog
% vecino(?X, ?Y, ?Ls) — X e Y son elementos adyacentes (en ese orden) de Ls.
% Modo típico: vecino(+X, -Y, +Ls) o vecino(-X, -Y, +Ls).
% Con Ls libre genera listas parcialmente instanciadas infinitamente.
vecino(X, Y, [X | [Y | _]]).
vecino(X, Y, [_ | Ls]) :- vecino(X, Y, Ls).
```

**I. Árbol de búsqueda de `?- vecino(5, Y, [5,6,5,3]).`**

Notación: `C1` = cláusula base (los dos primeros elementos), `C2` = cláusula recursiva (descartar la cabeza).

```
?- vecino(5, Y, [5,6,5,3])
├── C1: [5|[Y|Ls]] ~ [5,6,5,3] → Y = 6, Ls = [5,3]      ✔ (1ª solución: Y = 6)
└── C2: vecino(5, Y, [6,5,3])
      ├── C1: [5|[Y|Ls]] ~ [6,5,3] → 5 ≠ 6              ✗
      └── C2: vecino(5, Y, [5,3])
            ├── C1: [5|[Y|Ls]] ~ [5,3] → Y = 3, Ls = [] ✔ (2ª solución: Y = 3)
            └── C2: vecino(5, Y, [3])
                  ├── C1: [3] no unifica con [X,Y|Ls]   ✗
                  └── C2: vecino(5, Y, [])
                        ├── C1: [] no unifica           ✗
                        └── C2: [] no unifica con [_|Ls] ✗
```

Respuestas en orden: **`Y = 6 ; Y = 3`**. El árbol es finito porque cada aplicación de `C2` acorta la lista en un elemento y `[]` no unifica con ninguna cabeza.

**II. Si se invierte el orden de las reglas**

```prolog
vecino(X, Y, [_ | Ls]) :- vecino(X, Y, Ls).   % ahora primero
vecino(X, Y, [X | [Y | _]]).
```

- **El conjunto de soluciones no cambia**: las mismas ramas del árbol tienen éxito, sólo se visitan en otro orden (Prolog recorre primero la rama recursiva, llega hasta `[]`, falla, y va desarmando la pila).
- **El orden sí cambia**: ahora las respuestas salen `Y = 3 ; Y = 6` (de la sublista más profunda hacia la más superficial).
- **La terminación no se ve afectada en este caso** porque la lista es finita y está instanciada. Pero si `Ls` viniera libre (`?- vecino(5, Y, L).`), la versión con la recursiva primero **se cuelga sin dar ninguna respuesta**, mientras que la versión original devuelve `L = [5,Y|_]` inmediatamente. Moraleja: **poner siempre el caso base primero**.

**Chuleta**
> 1. `C1` = los dos primeros elementos son X e Y; `C2` = tirar la cabeza y seguir.
> 2. `vecino(5,Y,[5,6,5,3])` → **Y = 6 ; Y = 3** (las dos ocurrencias de 5 con sucesor).
> 3. Árbol finito: cada `C2` acorta la lista; `[]` no unifica con ninguna cabeza.
> 4. Invertir reglas → **mismas soluciones, orden invertido** (Y=3 ; Y=6).
> 5. Con la lista libre, base primero **genera**, recursiva primero **se cuelga** → caso base siempre arriba.

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

**I. ¿Qué sucede con `?- menorOIgual(0, X).`?**

El programa es:

```prolog
natural(0).
natural(suc(X)) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).   % ← primera cláusula: recursiva
menorOIgual(X, X) :- natural(X).               % ← segunda cláusula: base
```

Traza:

```
?- menorOIgual(0, X)
└── C1: X = suc(Y1), objetivo menorOIgual(0, Y1)
      └── C1: Y1 = suc(Y2), objetivo menorOIgual(0, Y2)
            └── C1: Y2 = suc(Y3), objetivo menorOIgual(0, Y3)
                  └── ... (rama infinita, nunca se prueba C2)
```

Como `X` viene **libre**, `X` unifica con `suc(Y)` siempre, y la cláusula recursiva es la primera: Prolog baja infinitamente por la rama izquierda construyendo el término `suc(suc(suc(...)))` y **no devuelve ninguna respuesta**. La rama exitosa (cláusula 2, `X = 0`) existe pero está a la derecha de una rama infinita, y DFS nunca llega.

**II. Circunstancias en las que un programa Prolog se cuelga**

1. **Recursión por izquierda**: el literal recursivo es el primero del cuerpo y ningún argumento decrece (ej. 1, `ancestro`).
2. **Caso recursivo antes del caso base** con argumentos no instanciados: el caso base queda a la derecha de una rama infinita (este ejercicio).
3. **Generadores infinitos con el test mal ubicado**: `desde(0, X), X > 100` nunca falla definitivamente al pedir más soluciones.
4. **Argumentos insuficientemente instanciados**: `is`, `>`, `<` con variables libres dan error; en cambio la unificación sin ocurrencia de test puede generar términos infinitos.
5. **Backtracking sobre un espacio infinito** cuando la solución requiere una rama que DFS visita "después de infinito" (incompletitud de Prolog: BFS sería completo pero impracticable).

**III. Corrección**

Basta con **poner el caso base primero** (y dejar la recursión que decrece el segundo argumento):

```prolog
% menorOIgual(?X, ?Y) — X =< Y en representación de Peano.
% Modos: (+,+) verifica; (+,-) genera todos los Y >= X; (-,+) genera los X =< Y.
menorOIgual(X, X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
```

Ahora `?- menorOIgual(0, X).` responde:

```
X = 0 ;
X = suc(0) ;
X = suc(suc(0)) ;
...
```

Cada respuesta se obtiene en tiempo finito (aunque la enumeración sea infinita, que es lo correcto: hay infinitos naturales ≥ 0). El punto clave es que **cada solución está a distancia finita de la raíz**: la enumeración es *fair*.

Nótese además que `natural(X)` en el caso base es necesario para que, con `X` libre, el predicado no devuelva `menorOIgual(T, T)` para un término cualquiera.

**Chuleta**
> 1. `menorOIgual(0, X)` con la cláusula recursiva primero y `X` libre → **se cuelga sin dar respuestas** (construye `suc(suc(...))` infinito).
> 2. Causa: el caso base queda **a la derecha de una rama infinita** y Prolog hace DFS.
> 3. Se cuelga cuando: recursión por izquierda · recursiva antes que la base · generador infinito con test mal puesto · variables sin instanciar.
> 4. Arreglo: **caso base primero** → `menorOIgual(X,X) :- natural(X).` y después la recursiva.
> 5. Resultado: enumeración *fair* `0 ; suc(0) ; suc(suc(0)) ; …` — infinita pero con cada respuesta a distancia finita.

---

## Operaciones sobre Listas

### Ejercicio 4 — Predicado `juntar`

**Enunciado**
Definir `juntar(?Lista1, ?Lista2, ?Lista3)` (equivalente a `append/3`). Analizar su reversibilidad con consultas como `?- juntar(L1, L2, [1,2,3]).`

**Explicacion**
El "Hola Mundo" de la reversibilidad en Prolog.

**Resolucion paso a paso**

```prolog
% juntar(?Lista1, ?Lista2, ?Lista3) — Lista3 es la concatenación de Lista1 y Lista2.
% Es append/3. La recursión estructural va sobre Lista1 Y sobre Lista3 al mismo
% tiempo (ambos argumentos se descomponen en la cabeza de la cláusula), por eso
% alcanza con que UNO de los dos tenga esqueleto de lista definido para terminar.
juntar([], Ys, Ys).
juntar([X | Xs], Ys, [X | Zs]) :- juntar(Xs, Ys, Zs).
```

**Análisis de reversibilidad (modos de uso)**

| Modo | Consulta ejemplo | Comportamiento |
|------|------------------|----------------|
| `(+,+,-)` | `juntar([1,2],[3],L)` | Determinístico: `L = [1,2,3]`. Termina. |
| `(+,+,+)` | `juntar([1,2],[3],[1,2,3])` | Verifica: `true` (una sola solución). |
| `(-,-,+)` | `juntar(L1,L2,[1,2,3])` | Genera las $n+1$ particiones. Termina. |
| `(+,-,+)` | `juntar([1],L2,[1,2,3])` | `L2 = [2,3]`. Termina. |
| `(-,+,+)` | `juntar(L1,[3],[1,2,3])` | `L1 = [1,2]`. Termina (recorre `L3`). |
| `(-,-,-)` | `juntar(L1,L2,L3)` | Generador infinito: enumera `L1 = []`, `L1 = [_]`, … con `L3` parcialmente instanciada. No se cuelga, pero no termina. |

**Traza de `?- juntar(L1, L2, [1,2,3]).`**

```
?- juntar(L1, L2, [1,2,3])
├── C1: L1 = [], L2 = [1,2,3]                                   ✔ (1ª)
└── C2: L1 = [1|Xs], juntar(Xs, L2, [2,3])
      ├── C1: Xs = [], L1 = [1], L2 = [2,3]                     ✔ (2ª)
      └── C2: Xs = [2|Xs'], juntar(Xs', L2, [3])
            ├── C1: L1 = [1,2], L2 = [3]                        ✔ (3ª)
            └── C2: juntar(Xs'', L2, [])
                  ├── C1: L1 = [1,2,3], L2 = []                 ✔ (4ª)
                  └── C2: [] no unifica con [X|Zs]              ✗
```

Cuatro soluciones, en orden creciente de longitud de `L1`. **Por qué termina**: en cada paso el tercer argumento pierde un elemento, y `[]` sólo unifica con la primera cláusula ⇒ profundidad acotada por `length(L3)`.

**Por qué esto es "el hola mundo de la reversibilidad"**: no hay aritmética ni cortes, sólo unificación estructural. Todo predicado que se defina en términos de `juntar` (prefijo, sufijo, sublista, member, insertar…) hereda esa reversibilidad.

**Chuleta**
> 1. `juntar([], Ys, Ys).` · `juntar([X|Xs], Ys, [X|Zs]) :- juntar(Xs, Ys, Zs).`
> 2. Reversible en todos los modos porque descompone **Lista1 y Lista3 a la vez** por unificación pura (sin `is`, sin cut).
> 3. `juntar(L1,L2,[1,2,3])` → 4 soluciones: `([],[1,2,3]) ; ([1],[2,3]) ; ([1,2],[3]) ; ([1,2,3],[])`.
> 4. Termina si `L1` **o** `L3` tienen esqueleto definido; con los tres libres es generador infinito (pero *fair*).
> 5. Base de casi toda la guía: prefijo/sufijo/sublista/member/insertar salen de acá.

---

### Ejercicio 5 — Operaciones clásicas con `append`

**Enunciado**
Definir usando `append`: `last`, `reverse`, `prefijo`, `sufijo`, `sublista`, `pertenece` (member).

**Explicacion**
Práctica de modelado declarativo utilizando un único predicado base potente.

**Resolucion paso a paso**

Todos se definen "adivinando" cómo se parte la lista con `append/3` y dejando que la reversibilidad de `append` haga el trabajo.

```prolog
% last(?L, ?U) — U es el último elemento de L.
% Modo esperado: last(+L, ?U). Con L libre genera L = [U], [_,U], [_,_,U], ...
last(L, U) :- append(_, [U], L).

% prefijo(+L, ?P) — P es un prefijo de L (incluye [] y L).
prefijo(L, P) :- append(P, _, L).

% sufijo(+L, ?S) — S es un sufijo de L.
sufijo(L, S) :- append(_, S, L).

% sublista(+L, ?SL) — SL es un tramo contiguo de L.
% Primero elijo un sufijo (dónde arranca) y después un prefijo de ese sufijo
% (dónde termina). Genera repetidos ([] aparece varias veces).
sublista(L, SL) :- sufijo(L, S), prefijo(S, SL).

% pertenece(?X, +L) — X aparece en L (member/2).
% El truco: L se parte en "algo ++ [X|resto]".
pertenece(X, L) :- append(_, [X | _], L).

% reverse(+L, ?R) — R es L al revés.
reverse([], []).
reverse([X | Xs], R) :- reverse(Xs, R1), append(R1, [X], R).
```

**Análisis de reversibilidad**

- `last`, `prefijo`, `sufijo`, `pertenece` son **totalmente reversibles**: heredan los modos de `append/3`. Con el primer argumento instanciado terminan siempre; con todo libre son generadores infinitos pero *fair*.
- `sublista/2` genera soluciones **repetidas** (la lista vacía aparece una vez por cada sufijo). Si se quiere sin repetidos hay que fijar el corte de inicio y fin: `append(_, S, L), append(SL, _, S), SL \= []` más un caso aparte para `[]`.
- `reverse/2` como está definido es $O(n^2)$ y **no es reversible en el segundo argumento** de manera terminante: `?- reverse(R, [1,2,3]).` se cuelga, porque la recursión estructural va sobre el primer argumento y con él libre `reverse(Xs, R1)` genera listas de longitud creciente sin cota. La versión reversible y $O(n)$ usa acumulador:

```prolog
% reverseAc(?L, ?R) — reversible en ambos sentidos si UNO de los dos es lista propia.
reverseAc(L, R) :- reverseAc(L, [], R).
reverseAc([], Ac, Ac).
reverseAc([X | Xs], Ac, R) :- reverseAc(Xs, [X | Ac], R).
```

**Ejemplos**

```prolog
?- last([1,2,3], U).        % U = 3
?- prefijo([1,2], P).       % P = [] ; P = [1] ; P = [1,2]
?- sufijo([1,2], S).        % S = [1,2] ; S = [2] ; S = []
?- sublista([1,2], SL).     % SL = [] ; [1] ; [1,2] ; [] ; [2] ; []   (con repetidos)
?- pertenece(X, [a,b]).     % X = a ; X = b
```

**Chuleta**
> 1. Todo sale de partir la lista con `append`: `last(L,U) :- append(_,[U],L).`
> 2. `prefijo(L,P) :- append(P,_,L).` · `sufijo(L,S) :- append(_,S,L).`
> 3. `sublista(L,SL) :- sufijo(L,S), prefijo(S,SL).` (genera repetidos).
> 4. `pertenece(X,L) :- append(_,[X|_],L).`
> 5. `reverse([X|Xs],R) :- reverse(Xs,R1), append(R1,[X],R).` → $O(n^2)$ y **no** reversible; usar acumulador `reverseAc(L,[],R)` para $O(n)$ y reversible.

---

### Ejercicio 6 — Predicado `aplanar`

**Enunciado**
Definir `aplanar(+Xs, -Ys)` que elimina todos los niveles de anidamiento de una lista.
Ejemplo: `?- aplanar([a, [3, b, []], [2]], L).` → `L = [a, 3, b, 2]`.

**Explicacion**
Recursión sobre listas de listas. Requiere distinguir entre elementos atómicos y listas.

**Resolucion paso a paso**

```prolog
% aplanar(+Xs, -Ys) — Ys tiene los elementos no-lista de Xs, en orden, sin anidamiento.
% Modo de uso: el primer argumento DEBE venir instanciado (se necesita saber si
% cada elemento es lista o no, y is_list/1 no funciona con variables libres).
aplanar([], []).
aplanar([X | Xs], Ys) :-
    is_list(X),
    aplanar(X, Y1),
    aplanar(Xs, Y2),
    append(Y1, Y2, Ys).
aplanar([X | Xs], [X | Ys]) :-
    not(is_list(X)),
    aplanar(Xs, Ys).
```

Las cláusulas 2 y 3 son **mutuamente excluyentes** gracias a `is_list(X)` / `not(is_list(X))`, así que no hay soluciones repetidas ni hace falta cut. La versión con corte verde es equivalente y más eficiente:

```prolog
aplanar([], []).
aplanar([X | Xs], Ys) :- is_list(X), !, aplanar(X, Y1), aplanar(Xs, Y2), append(Y1, Y2, Ys).
aplanar([X | Xs], [X | Ys]) :- aplanar(Xs, Ys).
```

**Traza de `?- aplanar([a, [3, b, []], [2]], L).`**

```
aplanar([a, [3,b,[]], [2]], L)
  a no es lista        → L = [a | L1],  aplanar([[3,b,[]], [2]], L1)
    [3,b,[]] es lista  → aplanar([3,b,[]], Y1), aplanar([[2]], Y2), append(Y1,Y2,L1)
      aplanar([3,b,[]], Y1):
        3 no es lista  → Y1 = [3 | ...]
        b no es lista  → Y1 = [3, b | ...]
        [] es lista    → aplanar([], []) → aporta nada
        Y1 = [3, b]
      aplanar([[2]], Y2):
        [2] es lista   → aplanar([2], [2]), aplanar([], []) → Y2 = [2]
      append([3,b], [2], L1) → L1 = [3, b, 2]
  L = [a, 3, b, 2]                                                   ✔
```

**Observaciones**

- El caso `[]` aparece dos veces con roles distintos: como **fin de la lista que estoy recorriendo** (cláusula 1) y como **elemento anidado vacío** (cae en la cláusula 2, con `aplanar([], [])` que aporta `[]` a la concatenación). Por eso `[]` desaparece del resultado, que es lo que pide el enunciado.
- **No es reversible**: `?- aplanar(Xs, [a,b]).` no termina, porque `is_list(X)` con `X` libre tiene éxito (una variable libre no es lista → falla, y la rama de generación queda incompleta) y no hay forma de acotar la profundidad de anidamiento. Se puede acotar con `desde/2` sobre la cantidad de niveles, pero el enunciado pide sólo el modo `(+,-)`.
- Si se quisiera evitar `is_list/1` (que en algunas versiones recorre toda la lista), se puede usar `X = [_|_] ; X == []` como test de "es lista".

**Chuleta**
> 1. Tres casos: lista vacía · cabeza que **es** lista · cabeza que **no** es lista.
> 2. Si la cabeza es lista: aplanar la cabeza, aplanar la cola, y `append` de los dos resultados.
> 3. Si no es lista: va directo al resultado, `[X | Ys]`.
> 4. `is_list(X)` / `not(is_list(X))` hacen las cláusulas excluyentes → sin repetidos y sin cut (o cut verde tras `is_list`).
> 5. Sólo modo `(+,-)`: no es reversible porque `is_list` necesita el argumento instanciado.

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

**I. `intersección(+L1, +L2, -L3)`**

```prolog
% Preserva el orden y las repeticiones de L1. Modo (+,+,-).
intersección([], _, []).
intersección([X | Xs], L2, [X | Ys]) :- member(X, L2), intersección(Xs, L2, Ys).
intersección([X | Xs], L2, Ys)       :- not(member(X, L2)), intersección(Xs, L2, Ys).
```

Cláusulas 2 y 3 excluyentes por `member` / `not(member)` ⇒ una sola solución. Con cut verde: `intersección([X|Xs], L2, [X|Ys]) :- member(X, L2), !, ...`

**II. `partir(N, L, L1, L2)`**

```prolog
% Versión aritmética. Modo (+N, +L, -L1, -L2): N debe estar instanciado por el >.
partir(0, L, [], L).
partir(N, [X | Xs], [X | Ys], Zs) :- N > 0, N1 is N - 1, partir(N1, Xs, Ys, Zs).

% Versión totalmente reversible (?N, ?L, ?L1, ?L2) usando append + length:
partirRev(N, L, L1, L2) :- append(L1, L2, L), length(L1, N).
```

*Reversibilidad*: la primera versión exige `N` instanciado (por `N > 0` y `is`); `partirRev` funciona con `N` libre porque `length/2` es reversible sobre listas propias.

**III. `borrar(+ListaOriginal, +X, -ListaSinX)`**

```prolog
borrar([], _, []).
borrar([X | Xs], X, Ys)       :- borrar(Xs, X, Ys).
borrar([Y | Xs], X, [Y | Ys]) :- Y \= X, borrar(Xs, X, Ys).
```

Borra **todas** las apariciones. `Y \= X` exige ambos instanciados: modo `(+,+,-)`.

**IV. `sacarDuplicados(+L1, -L2)`**

```prolog
sacarDuplicados([], []).
sacarDuplicados([X | Xs], [X | Ys]) :- borrar(Xs, X, Zs), sacarDuplicados(Zs, Ys).
```

Conserva la **primera** aparición de cada elemento. Termina porque `Zs` nunca es más larga que `Xs`.

**V. `permutación(+L1, ?L2)`**

```prolog
insertar(X, L, LX) :- append(A, B, L), append(A, [X | B], LX).

permutación([], []).
permutación([X | Xs], P) :- permutación(Xs, Q), insertar(X, Q, P).
```

Genera las $n!$ permutaciones sin repetir (si `L1` no tiene elementos repetidos). Modo `(+,?)`: con `L1` libre no termina, porque `permutación(Xs, Q)` con `Xs` libre genera listas cada vez más largas.

**VI. `reparto(+L, +N, -LListas)`**

```prolog
% Parte L en exactamente N tramos consecutivos (pueden ser vacíos).
% La concatenación de los N tramos, en orden, es L.
reparto([], 0, []).
reparto(L, N, [L1 | Ls]) :- N > 0, N1 is N - 1, append(L1, R, L), reparto(R, N1, Ls).
```

Cada `append(L1, R, L)` genera por backtracking todos los cortes posibles ⇒ el predicado enumera **todas** las formas de repartir. Para `L` de largo $n$ y $N$ partes hay $\binom{n+N-1}{N-1}$ soluciones.

**VII. `repartoSinVacías(+L, -LListas)`**

```prolog
% Igual que reparto pero sin tramos vacíos y sin fijar N: N queda determinado
% por el reparto elegido (entre 1 y length(L)).
repartoSinVacías([], []).
repartoSinVacías(L, [L1 | Ls]) :- append(L1, R, L), L1 \= [], repartoSinVacías(R, Ls).
```

**Termina** porque la condición `L1 \= []` garantiza que `R` es estrictamente más corta que `L` en cada paso (sin esa condición, `append([], L, L)` daría recursión infinita). Alternativa con `reparto`: `repartoSinVacías(L, Ls) :- length(L, N), between(1, N, K), reparto(L, K, Ls), not(member([], Ls)).` — correcta pero mucho menos eficiente (genera y descarta).

**Chuleta**
> 1. `intersección`: recorrer L1; `member(X,L2)` lo mantiene, `not(member(...))` lo saltea (cláusulas excluyentes).
> 2. `partir`: aritmético `partir(0,L,[],L)` + `N>0, N1 is N-1`; versión reversible = `append(L1,L2,L), length(L1,N)`.
> 3. `borrar`: tres casos, con `Y \= X` en el que conserva. `sacarDuplicados(X|Xs)` = quedarse con X y `borrar(Xs,X,Zs)` antes de recursar.
> 4. `permutación` = `permutación(cola,Q), insertar(X,Q,P)` con `insertar(X,L,LX) :- append(A,B,L), append(A,[X|B],LX).`
> 5. `reparto(L,N,Ls)`: N cortes con `append(L1,R,L)` y recursión con `N-1`. `repartoSinVacías`: mismo esquema con `L1 \= []` (eso garantiza terminación).

---

### Ejercicio 8 — Parte que suma

**Enunciado**
Definir `parteQueSuma(+L, +S, -P)` donde `P` es una sublista de `L` cuyos elementos suman `S`.

**Explicacion**
Combinación de generación de subconjuntos y suma aritmética.

**Resolucion paso a paso**

```prolog
% parteQueSuma(+L, +S, -P) — P es una sublista (no necesariamente contigua) de L
% cuyos elementos suman S. Enumera todas por backtracking.
% Modo de uso: L y S instanciados; P se construye. La recursión estructural va
% sobre L, así que termina siempre que L sea una lista propia.
parteQueSuma([], 0, []).
parteQueSuma([X | Xs], S, [X | P]) :- S1 is S - X, parteQueSuma(Xs, S1, P).
parteQueSuma([_ | Xs], S, P)       :- parteQueSuma(Xs, S, P).
```

**Cómo funciona**: es el esquema clásico "tomo o no tomo el primer elemento" (subset-sum por backtracking). La cláusula 2 **toma** `X` y descuenta su valor del objetivo; la cláusula 3 lo **descarta**. El caso base exige que, al terminar la lista, el saldo pendiente sea exactamente `0`.

**Poda (si todos los elementos son naturales)**

```prolog
parteQueSuma([X | Xs], S, [X | P]) :- X =< S, S1 is S - X, parteQueSuma(Xs, S1, P).
```

Con `X =< S` se corta la rama apenas el saldo se vuelve negativo. Es una poda **correcta sólo si no hay negativos**; con negativos hay que dejar la versión sin poda.

**Ejemplo**

```prolog
?- parteQueSuma([1,2,3,4], 5, P).
P = [1,4] ;
P = [2,3] ;
false.
```

Traza abreviada de la primera solución: tomo `1` (saldo 4) → descarto `2` (saldo 4) → descarto `3` (saldo 4) → tomo `4` (saldo 0) → lista vacía y saldo 0 ⇒ éxito con `P = [1,4]`.

**Versión generate & test** (más declarativa, menos eficiente):

```prolog
sublistaNoContigua([], []).
sublistaNoContigua([X | Xs], [X | Ys]) :- sublistaNoContigua(Xs, Ys).
sublistaNoContigua([_ | Xs], Ys)       :- sublistaNoContigua(Xs, Ys).

parteQueSumaGT(L, S, P) :- sublistaNoContigua(L, P), sumlist(P, S).
```

Genera las $2^n$ sublistas y testea la suma. La primera versión es preferible porque **entrelaza** generación y test: descuenta la suma mientras construye, lo que permite podar antes.

**Reversibilidad**: no es reversible en `S` (`is` requiere el lado derecho instanciado). Si se quisiera `parteQueSuma(+L, -S, -P)`, usar la versión generate & test con `sumlist/2`, que sí calcula `S` a partir de `P`.

**Chuleta**
> 1. Esquema **tomo / no tomo**: 3 cláusulas.
> 2. Base: `parteQueSuma([], 0, []).` — al terminar la lista el saldo debe ser 0.
> 3. Tomo: `[X|P]` con `S1 is S - X`. No tomo: mismo `S`, `P` sin `X`.
> 4. Poda con naturales: agregar `X =< S` antes de descontar.
> 5. Termina porque la recursión consume `L`; **no** es reversible en `S` por el `is` (para eso, generar sublista + `sumlist`).

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

```prolog
desde(X, X).
desde(X, Y) :- N is X + 1, desde(N, Y).
```

**I. ¿Cómo deben instanciarse los parámetros para que no se cuelgue?**

- `X` **debe estar instanciado siempre**: `N is X + 1` da error de instanciación si `X` es variable libre.
- `Y` **debe estar libre** (modo `desde(+X, -Y)`). Así el predicado funciona como **generador infinito**: devuelve `X`, `X+1`, `X+2`, … una respuesta por vez, cada una en tiempo finito. Es correcto que no termine: el conjunto de respuestas es infinito.
- Si `Y` viene **instanciado** (`desde(+X, +Y)`):
  - Con `Y >= X`: encuentra la solución tras `Y - X` pasos y responde `true`… pero al pedir otra solución (o si el objetivo posterior falla y se hace backtracking) sigue generando `X+1`, `X+2`, … para siempre. **Se cuelga en el backtracking.**
  - Con `Y < X`: nunca unifica y **se cuelga inmediatamente** sin dar ninguna respuesta.

Moraleja: `desde/2` sólo es seguro como generador puro, y **cualquier test que se le ponga a continuación debe poder acotarse**, porque el generador nunca falla definitivamente.

**II. `desdeReversible(+X, ?Y)`**

Hay que distinguir el modo con `nonvar/1` antes de generar:

```prolog
% desdeReversible(+X, ?Y) — X instanciado.
% Si Y viene instanciado: chequea Y >= X y NO genera (una sola respuesta, termina).
% Si Y viene libre: generador infinito X, X+1, X+2, ...
desdeReversible(X, Y) :- nonvar(Y), !, Y >= X.
desdeReversible(X, X) :- var(X) -> fail ; true.      % (ver nota)
desdeReversible(X, Y) :- N is X + 1, desdeReversible(N, Y).
```

En la práctica se escribe más limpio así:

```prolog
desdeReversible(X, Y) :- nonvar(Y), !, Y >= X.
desdeReversible(X, X).
desdeReversible(X, Y) :- N is X + 1, desdeReversible(N, Y).
```

**Por qué funciona**

- El `!` de la primera cláusula es un **corte rojo**: una vez que se detecta que `Y` está instanciado, se compromete con la comparación `Y >= X` y **poda las dos cláusulas generadoras**. Sin ese corte, tras responder `true` Prolog volvería a entrar en la rama infinita.
- `nonvar(Y)` es un predicado **extra-lógico** (depende del estado de instanciación, no de la semántica declarativa). Es el precio de la reversibilidad en Prolog.
- Con `Y` libre, `nonvar(Y)` falla, se saltea la primera cláusula, y quedan las dos originales: generador clásico.

```prolog
?- desdeReversible(3, 7).      % true.   (una sola solución, termina)
?- desdeReversible(3, 1).      % false.  (termina)
?- desdeReversible(3, Y).      % Y = 3 ; Y = 4 ; Y = 5 ; ...
```

Este patrón (`nonvar(Arg), !, caso_chequeo` antes de los casos generadores) es **el patrón canónico de reversibilidad** en Prolog y reaparece en el ejercicio 15 (`perímetro`).

**Chuleta**
> 1. `desde(X,X). desde(X,Y) :- N is X+1, desde(N,Y).` — `X` **siempre instanciado** (por el `is`).
> 2. Con `Y` libre: generador infinito, cada respuesta en tiempo finito → OK.
> 3. Con `Y` instanciado: responde y **después se cuelga** en el backtracking (o se cuelga ya si `Y < X`).
> 4. Reversible: `desdeReversible(X,Y) :- nonvar(Y), !, Y >= X.` + las dos cláusulas originales.
> 5. Patrón canónico: `nonvar(Arg), !, chequeo` arriba, generadores abajo. El `!` es **corte rojo** (sin él vuelve la rama infinita).

---

### Ejercicio 11 — Árboles Binarios

**Enunciado**
Representación: `nil` o `bin(izq, v, der)`. Definir `vacío`, `raiz`, `altura` y `cantidadDeNodos`.

**Explicacion**
Recursión sobre estructuras de datos no lineales.

**Resolucion paso a paso**

Representación: `nil` (árbol vacío) o `bin(Izq, V, Der)`.

```prolog
% vacío(?T) — T es el árbol vacío.
vacío(nil).

% raiz(+T, ?V) — V es el valor de la raíz. Falla para nil (no tiene raíz).
raiz(bin(_, V, _), V).

% altura(+T, -H) — cantidad de niveles. altura(nil) = 0.
% Modo (+,-): el árbol DEBE estar instanciado por el is / max.
altura(nil, 0).
altura(bin(I, _, D), H) :-
    altura(I, HI),
    altura(D, HD),
    H is max(HI, HD) + 1.

% cantidadDeNodos(+T, -N)
cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(I, _, D), N) :-
    cantidadDeNodos(I, NI),
    cantidadDeNodos(D, ND),
    N is NI + ND + 1.
```

**Ejemplo**

```prolog
?- altura(bin(bin(nil,1,nil), 2, nil), H).        % H = 2
?- cantidadDeNodos(bin(bin(nil,1,nil), 2, nil), N). % N = 2
```

**Análisis de reversibilidad**

- `vacío/1` y `raiz/2` son **totalmente reversibles**: sólo unifican. `raiz(T, 5)` genera `T = bin(_, 5, _)`.
- `altura/2` y `cantidadDeNodos/2` **no son reversibles**: `is` exige que el lado derecho esté completamente instanciado, y eso obliga a que el árbol venga dado. `?- cantidadDeNodos(T, 3).` da error de instanciación (no se puede resolver `3 is NI + ND + 1` con `NI`, `ND` libres).
- Para hacerlos reversibles hay que **invertir el rol**: generar el árbol por tamaño y después medirlo (ver ejercicio 23):

```prolog
% cantidadDeNodosRev(?T, ?N) — genera árboles de N nodos si T está libre.
cantidadDeNodosRev(T, N) :- nonvar(T), !, cantidadDeNodos(T, N).
cantidadDeNodosRev(T, N) :- nonvar(N), !, arbolDeTamaño(N, T).
cantidadDeNodosRev(T, N) :- desde(0, N), arbolDeTamaño(N, T).
```

(con `arbolDeTamaño/2` definido en el ejercicio 23).

**Por qué la recursión termina**: cada llamada recibe un subárbol estrictamente menor (`I` y `D` son subtérminos propios de `bin(I,_,D)`) y `nil` es el caso base, así que la recursión estructural sobre un término finito siempre termina.

**Chuleta**
> 1. Representación: `nil` | `bin(Izq, V, Der)`.
> 2. `vacío(nil).` · `raiz(bin(_,V,_), V).` — puramente unificación, reversibles.
> 3. `altura(nil,0).` · `altura(bin(I,_,D),H) :- altura(I,HI), altura(D,HD), H is max(HI,HD)+1.`
> 4. `cantidadDeNodos(nil,0).` · `... N is NI+ND+1.`
> 5. **No reversibles** por el `is`: modo `(+,-)`. Para el modo `(-,+)` hay que generar por tamaño (ej. 23) y después medir.

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

**I. `inorder(+AB, -Lista)`**

```prolog
% Recorrido izquierda-raíz-derecha.
inorder(nil, []).
inorder(bin(I, V, D), L) :- inorder(I, LI), inorder(D, LD), append(LI, [V | LD], L).
```

**II. `arbolConInorder(+Lista, -AB)`**

Es la relación inversa: hay que **elegir** cuál de los elementos es la raíz, y eso parte la lista en dos.

```prolog
% arbolConInorder(+L, -T) — genera TODOS los árboles cuyo inorder es L.
% Para L de largo n hay Catalan(n) soluciones.
arbolConInorder([], nil).
arbolConInorder(L, bin(I, V, D)) :-
    append(LI, [V | LD], L),
    arbolConInorder(LI, I),
    arbolConInorder(LD, D).
```

`append(LI, [V|LD], L)` no determinístico elige cada posición como raíz. Termina porque `LI` y `LD` son estrictamente más cortas que `L` (siempre se consume al menos el elemento `V`).

Nótese que **`inorder` y `arbolConInorder` son el mismo predicado leído en distintos modos**: podría escribirse uno solo, pero `inorder/2` con el árbol libre no termina (la recursión estructural va sobre el árbol), y `arbolConInorder/2` con la lista libre tampoco. Por eso se separan en dos predicados con modos distintos.

**III. `aBB(+T)`**

Dos formas equivalentes:

```prolog
% (a) Vía inorder: T es ABB sii su inorder está ordenado estrictamente.
aBB(T) :- inorder(T, L), ordenada(L).

ordenada([]).
ordenada([_]).
ordenada([X, Y | R]) :- X < Y, ordenada([Y | R]).

% (b) Directa, con la invariante explícita:
aBB(nil).
aBB(bin(I, V, D)) :-
    aBB(I), aBB(D),
    todosMenores(I, V),
    todosMayores(D, V).

todosMenores(nil, _).
todosMenores(bin(I, W, D), V) :- W < V, todosMenores(I, V), todosMenores(D, V).

todosMayores(nil, _).
todosMayores(bin(I, W, D), V) :- W > V, todosMayores(I, V), todosMayores(D, V).
```

La versión (a) es $O(n^2)$ por los `append` de `inorder`, pero mucho más corta y es la que conviene en un parcial. La versión (b) es la que hace explícita la invariante "todo el subárbol izquierdo es menor que la raíz" — cuidado con el error clásico de comparar **sólo con los hijos inmediatos**, que es incorrecto.

**IV. `aBBInsertar(+X, +T1, -T2)`**

```prolog
% Inserta X manteniendo la invariante de ABB. Si X ya está, devuelve T1 sin cambios.
aBBInsertar(X, nil, bin(nil, X, nil)).
aBBInsertar(X, bin(I, V, D), bin(I2, V, D)) :- X < V, aBBInsertar(X, I, I2).
aBBInsertar(X, bin(I, V, D), bin(I, V, D2)) :- X > V, aBBInsertar(X, D, D2).
aBBInsertar(X, bin(I, X, D), bin(I, X, D)).
```

Las cuatro cláusulas son **excluyentes** (`X < V`, `X > V`, `X = V`), así que hay una sola solución y no hace falta cut.

**Reversibilidad**: `aBBInsertar` requiere `X` y `T1` instanciados (por `<` y `>`). `aBB/1` requiere `T` instanciado por la misma razón. `inorder/2` es reversible sólo con el árbol instanciado; para el otro sentido está `arbolConInorder/2`.

**Chuleta**
> 1. `inorder(bin(I,V,D), L) :- inorder(I,LI), inorder(D,LD), append(LI,[V|LD],L).`
> 2. `arbolConInorder(L, bin(I,V,D)) :- append(LI,[V|LD],L), arbolConInorder(LI,I), arbolConInorder(LD,D).` — genera los Catalan(n) árboles.
> 3. `aBB(T) :- inorder(T,L), ordenada(L).` (truco corto de parcial) o versión directa con `todosMenores/todosMayores` — **no** alcanza comparar con los hijos inmediatos.
> 4. `aBBInsertar`: 4 cláusulas excluyentes — `nil` → hoja; `X < V` → izq; `X > V` → der; `X = V` → sin cambios.
> 5. Todos requieren el árbol instanciado (usan `<` / `>`).

---

## Generate & Test

### Ejercicio 14 — Cuadrados Mágicos

**Enunciado**
Definir `cuadradoSemiMágico(+N, -XS)` y `cuadradoMagico(+N, -XS)`. Las filas, columnas (y diagonales en el mágico) deben sumar lo mismo.

**Explicacion**
Problema de búsqueda en espacio de estados. Requiere un generador de matrices y un test de suma.

**Resolucion paso a paso**

Representación: `XS` es la lista de $N^2$ naturales, **por filas** (los primeros `N` son la fila 1, etc.).

El problema es de **generate & test con espacio infinito**: los valores no están acotados, así que hay que generar **por niveles** (diagonalización) usando como nivel la suma común `S`. Fijada `S`, el espacio es finito y el test es decidible.

**Auxiliares**

```prolog
desde(X, X).
desde(X, Y) :- N is X + 1, desde(N, Y).

% listaQueSuma(+Long, +Suma, -L) — L son Long naturales (>= 0) que suman Suma.
% Finito para Suma dada: cada elemento está entre 0 y Suma.
listaQueSuma(0, 0, []).
listaQueSuma(N, S, [X | Xs]) :-
    N > 0, N1 is N - 1,
    between(0, S, X),
    S1 is S - X,
    listaQueSuma(N1, S1, Xs).

% filas(+CantFilas, +Long, +Suma, -Filas)
filas(0, _, _, []).
filas(K, N, S, [F | Fs]) :- K > 0, K1 is K - 1, listaQueSuma(N, S, F), filas(K1, N, S, Fs).

sumaLista([], 0).
sumaLista([X | Xs], S) :- sumaLista(Xs, S1), S is S1 + X.

todasSuman([], _).
todasSuman([L | Ls], S) :- sumaLista(L, S), todasSuman(Ls, S).

% transponer(+Matriz, -Traspuesta)
transponer([[] | _], []) :- !.
transponer(M, [C | Cs]) :- maplist(cabezaCola, M, C, Resto), transponer(Resto, Cs).
cabezaCola([X | Xs], X, Xs).

% concatenar(+ListaDeListas, -Lista)
concatenar([], []).
concatenar([L | Ls], R) :- concatenar(Ls, R1), append(L, R1, R).
```

**`cuadradoSemiMágico(+N, -XS)`** — todas las filas y todas las columnas suman lo mismo:

```prolog
cuadradoSemiMágico(N, XS) :-
    desde(0, S),              % GENERADOR DE NIVELES: la suma común
    filas(N, N, S, Fs),       % GENERAR: N filas de N naturales que suman S
    transponer(Fs, Cs),
    todasSuman(Cs, S),        % TESTEAR: las columnas también suman S
    concatenar(Fs, XS).
```

**`cuadradoMagico(+N, -XS)`** — además las dos diagonales:

```prolog
% diagonal(+Filas, -D) — diagonal principal.
diagonal(Fs, D) :- diagonalDesde(Fs, 0, D).
diagonalDesde([], _, []).
diagonalDesde([F | Fs], I, [X | Xs]) :- nth0(I, F, X), I1 is I + 1, diagonalDesde(Fs, I1, Xs).

cuadradoMagico(N, XS) :-
    desde(0, S),
    filas(N, N, S, Fs),
    transponer(Fs, Cs),
    todasSuman(Cs, S),
    diagonal(Fs, D1), sumaLista(D1, S),                  % diagonal principal
    maplist(reverse, Fs, Fs2), diagonal(Fs2, D2), sumaLista(D2, S),  % anti-diagonal
    concatenar(Fs, XS).
```

**Por qué la generación por niveles es indispensable**

Si se generara "primero el primer elemento entre 0 e infinito, después el segundo…", Prolog quedaría atrapado explorando valores del primer elemento y **jamás** llegaría a instanciar el segundo: la enumeración no sería *fair*. Al fijar primero la suma `S` con `desde/2`, cada nivel es un espacio **finito** que se agota, y `desde` pasa al siguiente. Así todo cuadrado válido aparece en algún nivel finito ⇒ la generación es **completa**.

**Modo de uso**: `N` debe estar instanciado (lo usan `filas` y `between`); `XS` libre. Con `XS` instanciado el predicado también funciona como verificador, pero **no termina si el cuadrado no es válido** (sigue subiendo `S` para siempre) — para verificar conviene calcular `S` con `sumaLista` de la primera fila en vez de generarla.

⚠️ Verificar — el enunciado no aclara si los elementos deben ser naturales **positivos** o pueden ser `0`. Acá se usó `between(0, S, X)` (incluye el 0, y por lo tanto `S = 0` da el cuadrado de ceros como primera solución). Si se piden positivos, cambiar por `between(1, S, X)`.

**Chuleta**
> 1. `XS` = $N^2$ naturales por filas. **Generate & test por niveles**: el nivel es la suma común `S`, generada con `desde(0, S)`.
> 2. Fijada `S`, generar `N` filas de `N` naturales que sumen `S` (`between(0,S,X)` hace el espacio finito).
> 3. Testear: `transponer` y chequear que **todas las columnas** sumen `S` → semi-mágico.
> 4. Mágico = semi-mágico + diagonal principal y anti-diagonal suman `S` (anti-diagonal = diagonal de las filas invertidas).
> 5. Clave conceptual: sin el generador de niveles la enumeración no es *fair* y nunca se llega a instanciar el segundo elemento.

---

### Ejercicio 15 — Triángulos

**Enunciado**
I. `esTriángulo(+T)`
II. `perímetro(?T, ?P)`
III. `triángulo(-T)` que genere todos los triángulos válidos.

**Explicacion**
Similar al ejercicio integrador de la práctica. Requiere diagonalización para evitar bucles infinitos en la generación.

**Resolucion paso a paso**

Representación: `tri(A, B, C)` con los tres lados naturales.

**I. `esTriángulo(+T)`**

```prolog
% Desigualdad triangular estricta. Modo (+): los tres lados instanciados.
esTriángulo(tri(A, B, C)) :-
    A > 0, B > 0, C > 0,
    A < B + C,
    B < A + C,
    C < A + B.
```

**II. `perímetro(?T, ?P)`**

Se resuelve con el **patrón de reversibilidad** del ejercicio 9: distinguir los modos con `nonvar/1` y un corte, poniendo primero el modo más instanciado.

```prolog
% Caso 1: P instanciado → espacio finito, genero A y B acotados y despejo C.
perímetro(tri(A, B, C), P) :-
    nonvar(P), !,
    between(1, P, A),
    between(1, P, B),
    C is P - (A + B),
    C > 0,
    esTriángulo(tri(A, B, C)).

% Caso 2: el triángulo está instanciado → sólo sumo.
perímetro(tri(A, B, C), P) :-
    nonvar(A), nonvar(B), nonvar(C), !,
    P is A + B + C,
    esTriángulo(tri(A, B, C)).

% Caso 3: todo libre → genero perímetros crecientes y recaigo en el Caso 1.
perímetro(T, P) :-
    desde(3, P),
    perímetro(T, P).
```

*Orden de las cláusulas*: el Caso 1 va primero porque su guarda (`nonvar(P)`) es la que hace finito el espacio. El Caso 3 nunca se alcanza si `P` está instanciado (el `!` del Caso 1 lo poda). El `desde(3, P)` arranca en 3 porque es el perímetro mínimo posible (`tri(1,1,1)`).

**III. `triángulo(-T)`**

```prolog
triángulo(T) :- perímetro(T, _).
```

Como `P` viene libre, entra por el Caso 3: enumera `P = 3, 4, 5, …` y para cada `P` genera **todos** los triángulos de ese perímetro (espacio finito). Es exactamente **generación por niveles (diagonalización)**:

- Nivel `P = 3`: `tri(1,1,1)`.
- Nivel `P = 4`: ninguno (`tri(1,1,2)` no cumple la desigualdad).
- Nivel `P = 5`: `tri(1,2,2)`, `tri(2,1,2)`, `tri(2,2,1)`.
- …

**Por qué hace falta diagonalizar**: si se generara `desde(1, A), desde(1, B), desde(1, C)` en cascada, Prolog fijaría `A = 1` y se colgaría enumerando `B` para siempre, sin llegar nunca a `A = 2`. La enumeración no sería completa. Al usar el perímetro como nivel, cada triángulo aparece en el nivel `A+B+C`, que es finito ⇒ **todo triángulo se genera en tiempo finito**.

Nótese que `triángulo/1` **genera permutaciones** del mismo triángulo (`tri(1,2,2)`, `tri(2,1,2)`, `tri(2,2,1)`). Si se quisieran sin repetir "salvo orden", agregar `A =< B, B =< C` en el Caso 1.

Ver también la versión desarrollada en clase en [[programacion_logica_practica]] (sección *Ejercicio Integrador: Generación Infinita*).

**Chuleta**
> 1. `esTriángulo(tri(A,B,C))`: los tres lados > 0 y cada uno menor que la suma de los otros dos.
> 2. `perímetro` reversible = 3 cláusulas con guardas `nonvar` + `!`: (1) `P` dado → `between(1,P,A)`, `between(1,P,B)`, despejar `C`; (2) `T` dado → `P is A+B+C`; (3) todo libre → `desde(3,P)` y recaer en (1).
> 3. `triángulo(T) :- perímetro(T, _).`
> 4. **Diagonalización**: el nivel es el perímetro; cada nivel es finito ⇒ enumeración completa.
> 5. Sin diagonalizar (`desde` anidados) se cuelga con `A = 1` para siempre.

---

## Negación por Falla y Cut

### Ejercicio 16 — Heladería

**Enunciado**
A Ana le gustan los helados que sean a la vez **cremosos y frutales**. En una heladería de su barrio se encontró con los siguientes sabores:

```prolog
frutal(frutilla).
frutal(banana).
frutal(manzana).

cremoso(banana).
cremoso(americana).
cremoso(frutilla).
cremoso(dulceDeLeche).
```

Ana desea comprar un cucurucho con sabores que le gustan. El cucurucho admite hasta 2 sabores. Los siguientes predicados definen las posibles maneras de armar el cucurucho:

```prolog
leGusta(X)      :- frutal(X), cremoso(X).
cucurucho(X, Y) :- leGusta(X), leGusta(Y).
```

I. Escribir el árbol de búsqueda para la consulta `?- cucurucho(X, Y).`
II. Indicar qué partes del árbol se podan al colocar un `!` en **cada ubicación posible** en las definiciones de `cucurucho` y `leGusta`.

**Explicacion**
El ejercicio combina dos cosas: (a) dibujar el árbol SLD completo de una consulta con dos generadores encadenados, y (b) leer sobre ese mismo árbol el efecto del `cut`. La clave es que `!` descarta las alternativas pendientes **a su izquierda en el mismo cuerpo** y las **cláusulas restantes del predicado** donde aparece, pero nunca afecta a los literales que están a su derecha.

**Resolucion paso a paso**

Antes del árbol, conviene resolver `leGusta/1` a mano, respetando el orden de los hechos:

| `frutal(X)` | ¿`cremoso(X)`? | `leGusta(X)` |
|---|---|---|
| `frutilla` | sí (3er hecho de `cremoso`) | ✔ |
| `banana` | sí (1er hecho de `cremoso`) | ✔ |
| `manzana` | no hay hecho | ✗ |

Notar que `americana` y `dulceDeLeche` **nunca se prueban**: `frutal/1` es el generador y `cremoso/1` sólo actúa como filtro. Entonces `?- leGusta(X).` responde `X = frutilla ; X = banana`, en ese orden.

**I. Árbol de búsqueda de `?- cucurucho(X, Y).`**

```
?- cucurucho(X, Y)
│  [cucurucho(X,Y) :- leGusta(X), leGusta(Y)]
└── ?- leGusta(X), leGusta(Y)
    │  [leGusta(X) :- frutal(X), cremoso(X)]
    └── ?- frutal(X), cremoso(X), leGusta(Y)
        │
        ├── X = frutilla ── ?- cremoso(frutilla), leGusta(Y)          ✔
        │   └── ?- leGusta(Y)
        │       └── ?- frutal(Y), cremoso(Y)
        │           ├── Y = frutilla ── cremoso(frutilla)   ✔ □  SOL 1: X=frutilla, Y=frutilla
        │           ├── Y = banana   ── cremoso(banana)     ✔ □  SOL 2: X=frutilla, Y=banana
        │           └── Y = manzana  ── cremoso(manzana)    ✗ (falla)
        │
        ├── X = banana   ── ?- cremoso(banana), leGusta(Y)            ✔
        │   └── ?- leGusta(Y)
        │       └── ?- frutal(Y), cremoso(Y)
        │           ├── Y = frutilla ── cremoso(frutilla)   ✔ □  SOL 3: X=banana, Y=frutilla
        │           ├── Y = banana   ── cremoso(banana)     ✔ □  SOL 4: X=banana, Y=banana
        │           └── Y = manzana  ── cremoso(manzana)    ✗ (falla)
        │
        └── X = manzana  ── ?- cremoso(manzana), leGusta(Y)  ✗ (falla, no se llega a leGusta(Y))
```

Las cuatro soluciones salen en este orden:

$$(\text{frutilla},\text{frutilla}),\ (\text{frutilla},\text{banana}),\ (\text{banana},\text{frutilla}),\ (\text{banana},\text{banana})$$

Observaciones sobre la forma del árbol:

- El subárbol de `leGusta(Y)` está **duplicado**: se recorre entero una vez por cada solución de `leGusta(X)`, incluyendo la rama fallida `Y = manzana`. Con $n$ frutales y $k$ de ellos cremosos, se evalúa `cremoso/1` unas $n + k\cdot n$ veces.
- El backtracking al pedir más soluciones ocurre **primero sobre el literal más a la derecha** (`leGusta(Y)`) y recién cuando ése se agota se reintenta `leGusta(X)`.
- La rama `X = manzana` falla en `cremoso(manzana)` y por eso `leGusta(Y)` ni siquiera se llega a plantear ahí.

**II. Efecto del `!` en cada ubicación posible**

Hay tres ubicaciones en `cucurucho` y tres en `leGusta` (antes del primer literal, entre los dos, y al final).

*En `cucurucho`:*

**(c1) `cucurucho(X, Y) :- !, leGusta(X), leGusta(Y).`**

```prolog
cucurucho(X, Y) :- !, leGusta(X), leGusta(Y).
```

**No poda nada.** A la izquierda del `!` no hay literales con alternativas pendientes y `cucurucho/2` tiene una sola cláusula, así que no hay cláusulas restantes que descartar. El árbol y las 4 soluciones quedan idénticos. Corte **verde** (inútil, pero verde).

**(c2) `cucurucho(X, Y) :- leGusta(X), !, leGusta(Y).`**

```prolog
cucurucho(X, Y) :- leGusta(X), !, leGusta(Y).
```

Al llegar al `!` con `X = frutilla`, se descartan las alternativas pendientes de `leGusta(X)`: **desaparecen del árbol la rama `X = banana` (con todo su subárbol) y la rama fallida `X = manzana`**. Queda fijo el primer sabor y sigue variando el segundo. Soluciones: SOL 1 y SOL 2. Corte **rojo**.

**(c3) `cucurucho(X, Y) :- leGusta(X), leGusta(Y), !.`**

```prolog
cucurucho(X, Y) :- leGusta(X), leGusta(Y), !.
```

El `!` se ejecuta recién después de la primera solución completa, y descarta las alternativas pendientes de **ambos** literales: se podan `Y = banana`, `Y = manzana`, y las ramas `X = banana` y `X = manzana` enteras. Queda **una sola** solución, SOL 1. Corte **rojo**.

*En `leGusta` (el efecto se propaga a las dos llamadas de `cucurucho`):*

**(l1) `leGusta(X) :- !, frutal(X), cremoso(X).`**

```prolog
leGusta(X) :- !, frutal(X), cremoso(X).
```

Igual que (c1): no hay nada a la izquierda ni otras cláusulas de `leGusta/1`. **No poda nada**, siguen las 4 soluciones.

**(l2) `leGusta(X) :- frutal(X), !, cremoso(X).`**

```prolog
leGusta(X) :- frutal(X), !, cremoso(X).
```

Con `X` libre, `frutal(X)` da `X = frutilla` y el `!` **descarta las otras dos ramas del generador** (`banana` y `manzana`). O sea: `leGusta/1` pasa a tener a lo sumo una solución, la que sale del *primer* hecho de `frutal/1`. Como `frutilla` casualmente es cremoso, `leGusta` devuelve `frutilla` y `cucurucho(X,Y)` queda con **una sola** solución, SOL 1. Corte **rojo** y además **frágil**: si el primer hecho de `frutal/1` no fuera cremoso (por ejemplo si `manzana` estuviera primera), `leGusta/1` **fallaría siempre**, aunque haya sabores que Ana efectivamente aceptaría. Llamado con `X` ya instanciado (`leGusta(banana)`) sí es **verde**: `frutal/1` tiene a lo sumo un hecho por sabor, así que no hay alternativas reales que perder.

**(l3) `leGusta(X) :- frutal(X), cremoso(X), !.`**

```prolog
leGusta(X) :- frutal(X), cremoso(X), !.
```

Con `X` libre, el `!` se alcanza después del primer éxito (`X = frutilla`) y descarta tanto las alternativas de `cremoso/1` como las de `frutal/1`: de nuevo `leGusta/1` queda determinístico y `cucurucho(X,Y)` devuelve **una sola** solución, SOL 1. Corte **rojo** en ese modo. Pero a diferencia de (l2), **no rompe la corrección del filtro**: recorre `frutal/1` hasta encontrar un sabor que además sea cremoso, y sólo entonces corta. Llamado con `X` instanciado (`leGusta(frutilla)`) es **verde** puro: sólo evita reintentar hechos de `cremoso/1` que ya no pueden aportar nada.

*Resumen:*

| Ubicación del `!` | Soluciones de `?- cucurucho(X,Y).` | Qué poda | Color |
|---|---|---|---|
| (c1) `!` al principio de `cucurucho` | 4 | nada | verde |
| (c2) `!` entre los dos `leGusta` | 2 | ramas `X = banana` y `X = manzana` | rojo |
| (c3) `!` al final de `cucurucho` | 1 | todo el backtracking pendiente | rojo |
| (l1) `!` al principio de `leGusta` | 4 | nada | verde |
| (l2) `!` tras `frutal(X)` | 1 | resto del generador `frutal/1` | rojo (y rompe el filtro) |
| (l3) `!` al final de `leGusta` | 1 | alternativas de `frutal` y `cremoso` tras el 1er éxito | rojo con `X` libre, verde con `X` instanciado |

**Semántica del cut a recordar**: al ejecutarse `!` se descartan (i) las alternativas pendientes de los literales **a su izquierda en el mismo cuerpo** y (ii) las **cláusulas restantes del predicado** en el que aparece. No afecta a los literales que están a su derecha.

**Chuleta**
> 1. `leGusta(X) :- frutal(X), cremoso(X).` — `frutal/1` **genera** y `cremoso/1` **filtra**: sólo pasan `frutilla` y `banana` (en ese orden); `americana` y `dulceDeLeche` nunca se prueban.
> 2. `?- cucurucho(X,Y).` da 4 soluciones: (frutilla,frutilla), (frutilla,banana), (banana,frutilla), (banana,banana).
> 3. El subárbol de `leGusta(Y)` se **repite entero** por cada solución de `leGusta(X)`, ramas fallidas incluidas.
> 4. `!` al principio de un predicado de **una sola cláusula** no poda nada (c1, l1).
> 5. `!` entre los dos `leGusta` (c2) → fija `X`, varía `Y` → 2 soluciones. Rojo.
> 6. `!` al final de `cucurucho` (c3) → 1 sola solución. Rojo.
> 7. `!` tras `frutal(X)` (l2) es el peligroso: corta el generador antes de filtrar y puede hacer fallar a `leGusta/1` aunque haya soluciones.
> 8. Semántica: `!` descarta alternativas **a su izquierda** y las **cláusulas restantes del predicado**; nunca a su derecha.

---

### Ejercicio 17 — Comportamiento de `not`

**Enunciado**
I. ¿Qué significa `?- P(Y), not(Q(Y)).`?
II. ¿Qué pasa si se invierte el orden?
III. ¿Cómo usar `not` para determinar si existe una única `Y` tal que `P(Y)`?

**Explicacion**
Análisis de la Negación por Falla y la importancia de que las variables estén instanciadas antes de aplicar `not`.

**Resolucion paso a paso**

Recordar la definición operacional de la negación por falla:

```prolog
not(P) :- P, !, fail.
not(P).
```

`not(P)` tiene éxito sii `P` **falla**, y — crucial — **nunca instancia variables**: si `P` tuvo éxito, el `!, fail` deshace todo; si `P` falló, no hay bindings que propagar.

**I. ¿Qué significa `?- p(Y), not(q(Y)).`?**

`p(Y)` actúa como **generador**: instancia `Y` con cada solución de `p`. Recién entonces se evalúa `not(q(Y))` con `Y` **ground**, donde la negación por falla coincide con la negación lógica (bajo hipótesis de mundo cerrado).

Lectura: *"existe un `Y` tal que `p(Y)` y no se puede probar `q(Y)`"*, es decir
$$\exists Y.\ p(Y) \land \neg q(Y)$$
Devuelve, uno por uno, todos los `Y` que cumplen `p` pero no `q`. **Es el orden correcto.**

**II. ¿Qué pasa si se invierte el orden? `?- not(q(Y)), p(Y).`**

Ahora `not(q(Y))` se evalúa con `Y` **libre**:

- Prolog intenta probar `q(Y)` para *algún* `Y`. Si **existe al menos un** `Y` con `q(Y)`, la llamada interna tiene éxito ⇒ `not(q(Y))` **falla** ⇒ toda la consulta falla, aunque haya `Y` que cumplan `p(Y) ∧ ¬q(Y)`.
- Si `q` no tiene ninguna solución, `not(q(Y))` tiene éxito pero **deja `Y` sin instanciar**; después `p(Y)` genera todos los `Y` con `p`.

Lectura:
$$(\neg \exists Y.\ q(Y)) \land \exists Y.\ p(Y)$$

que **no** es equivalente a la anterior. Ejemplo: con `p(1). p(2). q(2).` la primera consulta da `Y = 1`; la segunda da `false`.

Conclusión (regla de oro): **`not` sólo es seguro con sus variables ya instanciadas** (*grounding*). Siempre poner el generador antes del `not`. Esto rompe la declaratividad: en lógica pura el orden de una conjunción es irrelevante.

**III. Determinar si existe una única `Y` tal que `p(Y)`**

Con doble negación: *"existe `Y` con `p(Y)` y no existe otro `Z` distinto que también cumpla `p`"*.

```prolog
% únicaSolución(?Y) — Y es la ÚNICA solución de p/1.
% Y queda instanciada por p(Y) antes del not, así que Z \= Y se evalúa bien.
únicaSolución(Y) :- p(Y), not(( p(Z), Z \= Y )).

% existeÚnica — sólo chequea la existencia y unicidad.
existeÚnica :- p(_), not(( p(A), p(B), A \= B )).
```

Formalmente:
$$\exists! Y.\ p(Y) \equiv \exists Y.\big(p(Y) \land \neg \exists Z.(p(Z) \land Z \neq Y)\big)$$

Detalles importantes:

- El paréntesis doble `not(( ... ))` es necesario: `not/1` recibe **un** término, y `(A, B)` es el término `','(A,B)`.
- `Z \= Y` requiere `Y` instanciada — lo está, porque `p(Y)` va primero.
- La variable `Z` es **local al `not`**: se comporta como cuantificada existencialmente dentro de la negación, y sus bindings se pierden al salir. Eso es justamente lo que se quiere acá (ver ejercicio 21).
- Alternativas con metapredicados: `findall(Y, p(Y), [Y])` o `forall(p(Z), Z == Y)`.

**Chuleta**
> 1. `not(P)` = "no puedo probar P". Tiene éxito si `P` falla y **nunca instancia variables**.
> 2. `p(Y), not(q(Y))` → $\exists Y.\, p(Y) \land \neg q(Y)$. **Orden correcto**: el generador instancia `Y` antes del `not`.
> 3. `not(q(Y)), p(Y)` → $(\neg\exists Y.\, q(Y)) \land \exists Y.\, p(Y)$. Falla si `q` tiene alguna solución; no instancia `Y`.
> 4. Regla de oro: `not` sólo es seguro con variables **ground** → generador primero.
> 5. Unicidad: `únicaSolución(Y) :- p(Y), not(( p(Z), Z \= Y )).` (doble paréntesis obligatorio; `Z` es local al `not`).

---

### Ejercicio 21 — Conjuntos y Negación

**Enunciado**
Definir `conjuntoDeNaturales(X)` que sea verdadero si todos los elementos de `X` son naturales.
Indicar el error en: `conjuntoDeNaturalesMalo(X) :- not( (not(natural(E)), pertenece(E, X)) ).`

**Explicacion**
Uso de la doble negación para implementar cuantificación universal ($\forall X. \phi \equiv \neg \exists X. \neg \phi$). El error suele estar en el alcance de las variables.

**Resolucion paso a paso**

**Definición correcta**

Cuantificación universal vía doble negación: $\forall E.\ (E \in X \to natural(E)) \equiv \neg \exists E.\ (E \in X \land \neg natural(E))$.

```prolog
% conjuntoDeNaturales(+X) — todos los elementos de la lista X son naturales.
% Modo de uso: X DEBE estar instanciado (es una propiedad a verificar, no un generador).
% El generador (pertenece) va PRIMERO, adentro del not, para que E quede ground
% antes de evaluar not(natural(E)).
conjuntoDeNaturales(X) :- not(( pertenece(E, X), not(natural(E)) )).
```

Equivalentemente, con `forall/2`: `conjuntoDeNaturales(X) :- forall(pertenece(E, X), natural(E)).` — de hecho `forall(G, C)` está **definido** como `not((G, not(C)))`.

**El error de `conjuntoDeNaturalesMalo`**

```prolog
conjuntoDeNaturalesMalo(X) :- not(( not(natural(E)), pertenece(E, X) )).
```

Los dos literales del `not` interno están **invertidos**: se evalúa `not(natural(E))` con `E` **libre**.

Traza del cuerpo interno:

1. `not(natural(E))` con `E` libre ⇒ Prolog intenta probar `natural(E)`; lo consigue de inmediato con el hecho `natural(0)` (`E = 0`).
2. Como la llamada interna tuvo éxito, `not(natural(E))` **falla**.
3. Al fallar el primer literal, la conjunción `(not(natural(E)), pertenece(E, X))` falla **siempre**, sin siquiera mirar `X`.
4. Por lo tanto el `not` externo **siempre tiene éxito**.

Conclusión: **`conjuntoDeNaturalesMalo(X)` es verdadero para cualquier `X`**, incluso `conjuntoDeNaturalesMalo([a, b, foo(3)])`. El predicado no dice nada.

**Los dos errores conceptuales involucrados**

1. **Instanciación**: la negación por falla exige que las variables del objetivo negado estén ground. Acá `E` llega libre al `not` interno, y `not(natural(E))` pasa de significar *"E no es natural"* a significar *"no existe ningún natural"* (que es falso, luego el `not` falla).
2. **Alcance de las variables**: `E` sólo existe dentro del `not` externo; los bindings que produjera `pertenece(E, X)` se pierden al salir. Por eso el generador tiene que estar **dentro** del mismo `not` y **antes** del test — es el único lugar donde el binding de `E` es visible para el test.

Regla mnemotécnica: en el patrón $\forall$ = `not((generador, not(test)))` el **generador siempre va primero**. Invertirlo lo convierte en una tautología.

**Verificación**

```prolog
?- conjuntoDeNaturales([0, suc(0), suc(suc(0))]).   % true.
?- conjuntoDeNaturales([0, a]).                     % false.
?- conjuntoDeNaturalesMalo([0, a]).                 % true.   ← el bug
```

**Chuleta**
> 1. $\forall$ se codifica como **doble negación**: `not(( generador, not(test) ))`.
> 2. Correcto: `conjuntoDeNaturales(X) :- not(( pertenece(E, X), not(natural(E)) )).`
> 3. Error del "malo": literales invertidos → `not(natural(E))` se evalúa con `E` **libre**.
> 4. Con `E` libre, `natural(E)` tiene éxito (`E = 0`) ⇒ `not(natural(E))` falla ⇒ la conjunción falla siempre ⇒ el `not` externo **siempre da true**: el predicado es una tautología.
> 5. Doble moraleja: `not` necesita variables **ground**, y los bindings de una variable **no salen** del `not` → generador adentro y primero.

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

**Representación**

```prolog
% G = grafo(Nodos, Aristas), con Aristas una lista de ar(X, Y) NO dirigidas
% (cada arista aparece una sola vez, en cualquiera de los dos órdenes).
% Ejemplo: grafo([a,b,c], [ar(a,b), ar(b,c)])

% vecino(+G, ?X, ?Y) — X e Y son adyacentes. Simetriza las aristas.
vecino(grafo(_, As), X, Y) :- member(ar(X, Y), As).
vecino(grafo(_, As), X, Y) :- member(ar(Y, X), As).
```

⚠️ Verificar — el enunciado sólo dice "dado un grafo `G` (nodos y aristas)" sin fijar el functor. Si la guía usa otra representación (por ejemplo dos argumentos separados `+Nodos, +Aristas`, o listas de adyacencia), adaptar únicamente `vecino/3`: el resto de los predicados está escrito en términos de `vecino/3` y no cambia.

**I. `caminoSimple(+G, +D, +H, ?L)`**

Camino de `D` a `H` **sin repetir nodos**. Se lleva la lista de visitados como acumulador — es el control de ciclos, sin el cual el predicado no terminaría en un grafo con ciclos.

```prolog
caminoSimple(G, D, H, L) :- caminoAux(G, D, H, [D], LRev), reverse(LRev, L).

% caminoAux(+G, +Actual, +Hasta, +VisitadosAlReves, -CaminoAlReves)
caminoAux(_, H, H, Vis, Vis).
caminoAux(G, A, H, Vis, L) :-
    vecino(G, A, B),
    not(member(B, Vis)),      % B ya está instanciado por vecino/3 => not seguro
    caminoAux(G, B, H, [B | Vis], L).
```

**Terminación**: cada paso agrega un nodo nuevo a `Vis` y `not(member(B, Vis))` impide repetir, así que la profundidad está acotada por $|V|$. Enumera **todos** los caminos simples de `D` a `H` por backtracking.

**Modo de uso**: `D` y `H` instanciados, `L` libre (o instanciada, en cuyo caso verifica). Con `D` o `H` libres funciona igual porque `vecino/3` es reversible, pero conviene combinarlo con `member(D, Nodos)` para acotar.

**II. `caminoHamiltoniano(+G, ?L)`**

Camino simple que pasa por **todos** los nodos exactamente una vez:

```prolog
caminoHamiltoniano(G, L) :-
    G = grafo(Ns, _),
    length(Ns, N),
    member(D, Ns), member(H, Ns),
    caminoSimple(G, D, H, L),
    length(L, N).
```

Como `caminoSimple` ya garantiza que no hay nodos repetidos, alcanza con pedir que el camino tenga tantos nodos como el grafo. Es búsqueda exhaustiva: el problema es NP-completo, no hay mejor en el caso general. Poda posible: fijar `D` como el primer nodo sólo si el grafo es no dirigido y se buscan ciclos, no acá.

**III. `esConexo(+G)`**

*"No existen dos nodos distintos sin camino entre ellos"* — cuantificación universal por doble negación (ej. 21):

```prolog
esConexo(G) :-
    G = grafo(Ns, _),
    not(( member(X, Ns), member(Y, Ns), X \= Y, not(caminoSimple(G, X, Y, _)) )).
```

Los generadores `member/2` van **primero**, para que `X` e `Y` estén instanciados cuando se evalúa el `not` interno. Versión más eficiente (basta con que **un** nodo alcance a todos):

```prolog
esConexo(grafo([N | Ns], As)) :-
    forall(member(X, Ns), caminoSimple(grafo([N | Ns], As), N, X, _)).
```

(vale porque en un grafo no dirigido la alcanzabilidad es simétrica y transitiva).

**IV. `esEstrella(+G)`**

Un grafo estrella tiene un **centro** adyacente a todos los demás nodos, y **ninguna** arista entre nodos no centrales:

```prolog
esEstrella(G) :-
    G = grafo(Ns, As),
    member(C, Ns),                                    % candidato a centro
    not(( member(X, Ns), X \= C, not(vecino(G, C, X)) )),   % el centro llega a todos
    not(( member(ar(X, Y), As), X \= C, Y \= C )).          % no hay otras aristas
```

Con `forall/2` queda más legible:

```prolog
esEstrella(grafo(Ns, As)) :-
    member(C, Ns),
    forall((member(X, Ns), X \= C), vecino(grafo(Ns, As), C, X)),
    forall(member(ar(X, Y), As), (X == C ; Y == C)).
```

**Patrón general del ejercicio**: todos los predicados de propiedades globales (`esConexo`, `esEstrella`) son **"para todo … vale …"**, y en Prolog eso se escribe `not(( generador, not(condición) ))` — el generador siempre primero. Los predicados de existencia (`caminoSimple`, `caminoHamiltoniano`) son búsqueda con backtracking + acumulador de visitados para cortar ciclos.

**Chuleta**
> 1. `G = grafo(Nodos, Aristas)`; `vecino/3` simetriza (`ar(X,Y)` o `ar(Y,X)`).
> 2. `caminoSimple`: recursión con **acumulador de visitados** y `not(member(B, Vis))` → corta ciclos y garantiza terminación (profundidad ≤ |V|).
> 3. `caminoHamiltoniano` = `caminoSimple` + `length(L, |Nodos|)` (los repetidos ya están excluidos).
> 4. `esConexo` = `not(( member(X,Ns), member(Y,Ns), X \= Y, not(caminoSimple(G,X,Y,_)) ))` — o "un nodo alcanza a todos".
> 5. `esEstrella` = existe centro `C` adyacente a todos **y** toda arista toca a `C`.
> 6. Regla: propiedades globales → doble negación con el generador primero; búsqueda de caminos → backtracking + visitados.

---

### Ejercicio 23 — Generación de Árboles

**Enunciado**
I. `arbol(-A)` que genere estructuras de árboles binarios.
II. `nodosEn(?A, +L)`: nodos del árbol pertenecen a la lista `L`.
III. `sinRepEn(-A, +L)`: genera árboles con nodos de `L` sin repetir.

**Explicacion**
Generación de estructuras complejas y filtrado dinámico.

**Resolucion paso a paso**

**I. `arbol(-A)` — generar estructuras de árboles binarios**

La definición estructural ingenua **no sirve como generador**:

```prolog
arbolMalo(nil).
arbolMalo(bin(I, _, D)) :- arbolMalo(I), arbolMalo(D).
```

`?- arbolMalo(A).` devuelve `nil`, `bin(nil,_,nil)`, `bin(nil,_,bin(nil,_,nil))`, … : se queda enumerando para siempre árboles con **subárbol izquierdo vacío**, porque al hacer backtracking siempre vuelve primero sobre `arbolMalo(D)` (el literal más a la derecha) y `arbolMalo(I)` nunca llega a probar su segunda alternativa. La enumeración **no es completa** (nunca sale `bin(bin(nil,_,nil), _, nil)`).

Solución: **generar por niveles** (diagonalización), usando la cantidad de nodos como nivel — cada nivel es finito.

```prolog
desde(X, X).
desde(X, Y) :- N is X + 1, desde(N, Y).

% arbolDeTamaño(+N, -A) — genera todos los árboles de exactamente N nodos.
% Espacio FINITO para N dado (hay Catalan(N) árboles).
arbolDeTamaño(0, nil).
arbolDeTamaño(N, bin(I, _, D)) :-
    N > 0, N1 is N - 1,
    between(0, N1, NI),
    ND is N1 - NI,
    arbolDeTamaño(NI, I),
    arbolDeTamaño(ND, D).

% arbol(-A) — generador completo y fair.
arbol(A) :- desde(0, N), arbolDeTamaño(N, A).
```

Ahora todo árbol de $n$ nodos aparece en el nivel $n$, que se agota en tiempo finito ⇒ **generación completa**.

**II. `nodosEn(?A, +L)` — los nodos de `A` pertenecen a `L`**

```prolog
% Modo (+A, +L): verifica. Modo (-A, +L): instancia los valores, pero NO acota
% la forma del árbol, así que hay que combinarlo con un generador de estructuras.
nodosEn(nil, _).
nodosEn(bin(I, V, D), L) :- member(V, L), nodosEn(I, L), nodosEn(D, L).
```

Con `A` libre, `nodosEn/2` sola no termina (no hay cota para la estructura); usada después de `arbolDeTamaño/2` sí, porque el esqueleto ya está fijo y sólo faltan los valores, que `member/2` recorre en un conjunto finito.

**III. `sinRepEn(-A, +L)` — árboles con nodos de `L` sin repetir**

Como no se puede repetir y los nodos salen de `L`, el árbol tiene a lo sumo `length(L)` nodos ⇒ el espacio es **finito** y no hace falta `desde/2`: alcanza con `between/3`.

```prolog
% nodos(+A, -Ns) — lista de nodos (inorder).
nodos(nil, []).
nodos(bin(I, V, D), Ns) :- nodos(I, NI), nodos(D, ND), append(NI, [V | ND], Ns).

sinRep([]).
sinRep([X | Xs]) :- not(member(X, Xs)), sinRep(Xs).

% sinRepEn(-A, +L)
sinRepEn(A, L) :-
    length(L, N),
    between(0, N, K),          % tamaño posible del árbol: 0 .. |L|
    arbolDeTamaño(K, A),       % GENERAR estructura
    nodosEn(A, L),             % GENERAR valores tomados de L
    nodos(A, Ns),
    sinRep(Ns).                % TESTEAR que no se repitan
```

**Por qué termina**: `between(0, N, K)` acota el tamaño; para cada `K` hay finitos esqueletos (Catalan) y finitas asignaciones de valores ($|L|^K$). Es generate & test puro, con el test recién al final porque `sinRep` necesita el árbol completo.

*Optimización*: se pueden evitar las repeticiones desde la generación, pasando la lista de disponibles y sacando el elemento elegido:

```prolog
sinRepEnRapido(A, L) :- sinRepAux(A, L, _).
sinRepAux(nil, L, L).
sinRepAux(bin(I, V, D), L, Resto) :-
    select(V, L, L1),          % elige V y lo saca de la lista
    sinRepAux(I, L1, L2),
    sinRepAux(D, L2, Resto).
```

Acá el "no repetir" está garantizado por construcción (`select/3` consume el elemento), así que no hay test que falle: es **generación dirigida** en vez de generate & test, y termina porque la lista de disponibles se achica en cada nodo.

**Relación con el ejercicio 11**: `arbolDeTamaño/2` es exactamente el generador que le faltaba a `cantidadDeNodos/2` para volverse reversible.

**Chuleta**
> 1. `arbol(nil). arbol(bin(I,_,D)) :- arbol(I), arbol(D).` **no** sirve como generador: se cuelga con el subárbol izquierdo vacío (enumeración no *fair*).
> 2. Diagonalizar por cantidad de nodos: `arbolDeTamaño(N, A)` reparte `N-1` nodos entre izq y der con `between(0, N-1, NI)`; `arbol(A) :- desde(0,N), arbolDeTamaño(N,A).`
> 3. `nodosEn(bin(I,V,D), L) :- member(V,L), nodosEn(I,L), nodosEn(D,L).` — sola no termina con `A` libre; combinar con el generador por tamaño.
> 4. `sinRepEn(A, L)`: `between(0, |L|, K)` acota el tamaño → generar estructura, poner valores de `L`, testear `sinRep(nodos)`. Espacio finito ⇒ termina.
> 5. Versión eficiente: `select(V, L, L1)` consume el elemento al elegirlo → sin repetidos **por construcción**, sin test.

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/prolog_listas_append]] · [[tipos_ejercicio/prolog_generar_testear]] · [[tipos_ejercicio/prolog_maximo_doble_not]] · [[tipos_ejercicio/prolog_reversibilidad]]
