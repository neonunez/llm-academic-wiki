---
nombre: Resolución SLD y Semántica de Prolog — Teoría
parcial: 2P
tipo: teoria
tema: resolucion_sld_prolog
fuente: raw/clases/teo/11.teo_2P_resolucion_SLD_prolog.pdf
paginas_relacionadas:
  - "[[resolucion_teoria]]"
  - "[[logica_de_primer_orden_teoria]]"
---

# Resolución SLD y Semántica de Prolog

La resolución SLD (*Selective Linear Definite clause resolution*) es el método de resolución utilizado en la programación lógica. Es una refinación de la resolución general que es eficiente y completa para **cláusulas de Horn**.

## Resolución SLD

### Definición
Dada una cláusula objetivo $G = \{\neg A_1, \dots, \neg A_n\}$ y una cláusula de definición $D = \{A, \neg B_1, \dots, \neg B_m\}$, si $A_1$ y $A$ unifican con mgu $S$, la **resolución SLD** produce un nuevo objetivo:
$$S(\{\neg B_1, \dots, \neg B_m, \neg A_2, \dots, \neg A_n\})$$

*   **Selección**: Se elige un literal de la cláusula objetivo (en Prolog, siempre el primero).
*   **Lineal**: Siempre se resuelve el objetivo actual con una cláusula del programa original.
*   **Definite**: Se usan cláusulas de definición (un literal positivo).

### Árbol de Resolución SLD
Es un árbol donde:
*   La raíz es la cláusula objetivo inicial.
*   Los hijos de un nodo son los resultados de aplicar resolución SLD con todas las cláusulas del programa que unifiquen con el literal seleccionado.
*   **Éxito**: Una hoja con la cláusula vacía $\square$. La composición de los mgu en el camino es la **sustitución respuesta**.
*   **Falla**: Una hoja donde el literal seleccionado no unifica con ninguna cabeza de cláusula.

### Propiedades
*   **Completitud**: Si $\{D_1, \dots, D_n, G\}$ es insatisfactible, existe una refutación SLD (teorema para cláusulas de Horn).

---

## Semántica Operacional de Prolog

Prolog implementa la resolución SLD con decisiones específicas de diseño para ganar eficiencia, lo que afecta su declaratividad.

### Reglas de Ejecución
1.  **Criterio de Selección**: Elige siempre el **primer literal** de la cláusula objetivo (de izquierda a derecha).
2.  **Criterio de Búsqueda**: Las cláusulas del programa se intentan en **orden de aparición** (de arriba hacia abajo).
3.  **Estrategia de Exploración**: Realiza una búsqueda en profundidad (**DFS**).

### Incompletitud de Prolog
Debido a la búsqueda DFS, Prolog puede entrar en una rama infinita y nunca encontrar una refutación que existe en otra rama.
*   **BFS** sería completo pero es computacionalmente muy costoso.
*   El orden de las reglas en Prolog es relevante para la terminación.

### Omisión de Occurs-check
Por eficiencia, Prolog usualmente no realiza el *occurs-check* durante la unificación (verificar si una variable $X$ aparece en el término con el que unifica, ej: $X = f(X)$).
*   Esto puede llevar a "refutaciones" incorrectas desde el punto de vista lógico.
*   La carga de evitar estos casos recae en el programador.

---

## El Operador de Corte (Cut `!`)

Es un operador **extra-lógico** que permite podar el árbol de búsqueda. No tiene interpretación declarativa.

### Semántica del Cut
Cuando se alcanza un `!`:
1.  Tiene éxito inmediatamente.
2.  Al hacer backtracking, si se llega al `!`:
    *   Se descartan todas las alternativas restantes para el literal que activó la regla actual.
    *   Se descartan todas las alternativas restantes para la regla misma.
    *   Se continúa el backtracking desde antes de la llamada al predicado que contenía el corte.

### Tipos de Cortes
*   **Green Cuts (Cortes Verdes)**: No alteran la semántica declarativa del programa, solo mejoran la eficiencia evitando búsquedas innecesarias.
*   **Red Cuts (Cortes Rojos)**: Alteran la semántica. Si se eliminan, el programa puede dar respuestas distintas o incorrectas.

---

## Negación por Falla (*Negation as Failure*)

Prolog no posee negación lógica pura. Implementa `not(P)` (o `\+ P`) basándose en el éxito o falla de la resolución.

### Definición Operacional
```prolog
not(P) :- P, !, fail.
not(P).
```
*   `not(P)` tiene éxito si `P` falla.
*   `not(P)` falla si `P` tiene éxito.

### Problemas de la Negación por Falla
No coincide con la negación lógica y atenta contra la declaratividad:
*   El orden de los literales importa: `verdura(X), not(fruta(X))` puede dar un resultado distinto a `not(fruta(X)), verdura(X)`.
*   Solo es seguro usarla cuando las variables del predicado negado ya están instanciadas (*Grounding*).

---

## Ejemplos Clave

### Concatenación de Listas (`append`)
```prolog
c([], Ys, Ys).
c([X | Xs], Ys, [X | Zs]) :- c(Xs, Ys, Zs).
```
Permite múltiples modos de uso:
*   **Verificación**: `?- c([1,2], [3,4], [1,2,3,4]).` $\to$ `true`.
*   **Construcción**: `?- c([1,2], [3,4], Zs).` $\to$ `Zs = [1,2,3,4]`.
*   **Descomposición**: `?- c(Xs, Ys, [1,2]).` $\to$ encuentra todas las particiones.

### Máximo con Red Cut
```prolog
maximo(A, B, A) :- A >= B, !.
maximo(A, B, B).
```
Sin el corte, `maximo(5, 2, 2)` podría devolver `true` en la segunda regla si no se tiene cuidado. El corte asegura que si la primera regla aplica, no se intente la segunda.

---

## Ver también
- [[resolucion_teoria]]
- [[logica_de_primer_orden_teoria]]
- [[unificacion_e_inferencia_de_tipos_teoria]]
