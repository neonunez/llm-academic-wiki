---
nombre: Fuerza Bruta & Backtracking — Teoria
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: fuerza_bruta_backtracking
fuentes:
  vigente: []
  historico:
    - raw/clases/teo/2.teo_1P_fuerza_bruta_backtracking.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[complejidad_computacional_teoria]]"
  - "[[divide_y_conquista_teoria]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Fuerza Bruta & Backtracking — Teoria

## Concepto y definicion

### Problemas bien resueltos

**Convencion:** los algoritmos polinomiales se consideran satisfactorios (cuanto menor sea el grado, mejor), y los algoritmos supra-polinomiales se consideran no satisfactorios.

No obstante, hay matices:
- Si los tamanos de instancia son pequenos, un algoritmo exponencial puede no ser malo.
- $O(n^{85})$ vs $O(1.001^n)$: el polinomial puede ser peor en la practica para instancias reales.
- Un algoritmo de peor caso exponencial puede ser eficiente en la practica (y hasta ser el mejor disponible).
- A veces no se encuentra un algoritmo polinomial para el problema.

### Problemas de optimizacion

Un problema de optimizacion consiste en encontrar la mejor solucion dentro de un conjunto:

$$z^* = \max_{x \in S} f(x) \qquad \text{o bien} \qquad z^* = \min_{x \in S} f(x)$$

- $f : S \to \mathbb{R}$: **funcion objetivo** del problema.
- $S$: **region factible**; los elementos $x \in S$ se llaman **soluciones factibles**.
- $z^* \in \mathbb{R}$: **valor optimo** del problema.
- Cualquier $x^* \in S$ tal que $f(x^*) = z^*$ se llama un **optimo** del problema.

### Problemas de optimizacion combinatoria

Un problema de optimizacion combinatoria es un problema de optimizacion cuya **region factible es un conjunto definido por consideraciones combinatorias**: todos los subconjuntos/permutaciones de un conjunto finito de elementos (posiblemente con restricciones adicionales), todos los caminos en un grafo, etc.

## Fuerza bruta

Un **algoritmo de fuerza bruta** para un problema de optimizacion combinatoria consiste en **generar todas las soluciones factibles y quedarse con la mejor**.

Tambien llamados: algoritmos de **busqueda exhaustiva** o **generate and test**.

**Propiedades:**
1. Tecnica trivial pero muy general.
2. Suele ser facil de implementar.
3. Es un algoritmo **exacto**: si hay solucion, siempre la encuentra.
4. **Principal problema:** complejidad habitualmente exponencial.

## Backtracking

**Idea:** Recorrer sistematicamente todas las posibles configuraciones del espacio de soluciones de un problema computacional, **eliminando las configuraciones parciales que no puedan completarse a una solucion** (poda).

### Representacion

- Utiliza un vector $a = (a_1, a_2, \ldots, a_n)$ para representar una solucion candidata.
- Cada $a_i$ pertenece a un dominio/conjunto ordenado y finito $A_i$.
- El **espacio de soluciones** es el producto cartesiano $A_1 \times \ldots \times A_n$.

### Mecanismo

- En cada paso se extienden las **soluciones parciales** $a = (a_1, a_2, \ldots, a_k)$, $k < n$, agregando un elemento $a_{k+1} \in S_{k+1} \subseteq A_{k+1}$.
- Las nuevas soluciones parciales son **sucesores** de la anterior.
- Si $S_{k+1}$ es vacio, se **retrocede** a la solucion parcial $(a_1, a_2, \ldots, a_{k-1})$.
- El espacio se piensa como un **arbol dirigido**: cada vertice es una solucion parcial, y un vertice $x$ es hijo de $y$ si $x$ se extiende desde $y$.
- Permite **descartar configuraciones antes de explorarlas** (podar el arbol).

### Algoritmo: Todas las soluciones

```
BT(a, k):
  si a es solucion entonces
    procesar(a)
    retornar
  sino
    para cada a' en Sucesores(a, k):
      BT(a', k + 1)
    fin para
  fin si
  retornar
```

### Algoritmo: Una solucion

```
BT(a, k):
  si a es solucion entonces
    sol <- a
    encontro <- true
  sino
    para cada a' en Sucesores(a, k):
      BT(a', k + 1)
      si encontro entonces
        retornar
      fin si
    fin para
  fin si
  retornar
```

## Ejemplo: Problema de la mochila

### Datos de entrada

- Capacidad $C \in \mathbb{Z}^+$ de la mochila (peso maximo).
- Cantidad $n \in \mathbb{Z}^+$ de objetos.
- Peso $p_i \in \mathbb{Z}^+$ del objeto $i$, para $i = 1, \ldots, n$.
- Beneficio $b_i \in \mathbb{Z}^+$ del objeto $i$, para $i = 1, \ldots, n$.

**Problema:** Determinar que objetos incluir en la mochila sin exceder el peso maximo $C$, maximizando el beneficio total.

### Version fuerza bruta

```
Mochila(S subconjunto de {1,...,n}, k):
  si k = n + 1 entonces
    si peso(S) <= C y beneficio(S) > beneficio(B) entonces
      B <- S
    fin si
  sino
    Mochila(S union {k}, k + 1)
    Mochila(S, k + 1)
  fin si
```

Se inicia con $B \leftarrow \emptyset$; `Mochila(vacío, 1)`. Complejidad: $O(2^n)$.

### Version backtracking (poda por factibilidad)

```
Mochila(S subconjunto de {1,...,n}, k):
  si k = n + 1 entonces
    si peso(S) <= C y beneficio(S) > beneficio(B) entonces
      B <- S
    fin si
  sino si peso(S) <= C entonces
    Mochila(S union {k}, k + 1)
    Mochila(S, k + 1)
  fin si
```

**Poda:** se interrumpe la recursion cuando el subconjunto actual excede la capacidad. Peor caso sigue $O(2^n)$, pero en la practica poda ramas significativas.

### Version branch and bound (poda por optimalidad)

```
Mochila(S subconjunto de {1,...,n}, k):
  si k = n + 1 entonces
    si peso(S) <= C y beneficio(S) > beneficio(B) entonces
      B <- S
    fin si
  sino si peso(S) <= C y beneficio(S) + sum(b_i, i=k+1..n) > beneficio(B) entonces
    Mochila(S union {k}, k + 1)
    Mochila(S, k + 1)
  fin si
```

**Poda adicional:** ademas de factibilidad, se verifica que el beneficio actual mas el beneficio maximo posible de los objetos restantes supere la mejor solucion conocida.

## Ejemplo: Problema de las n damas

**Problema:** Ubicar $n$ damas en un tablero de $n \times n$ de forma que ninguna dama amenace a otra.

### Reduccion progresiva del espacio de busqueda (n = 8)

| Enfoque | Combinaciones |
|---------|---------------|
| Todos los subconjuntos de 8 casillas en 64 | $\binom{64}{8} = 4,426,165,368$ |
| Una dama por columna: $(a_1, \ldots, a_8)$, $a_i \in \{1,\ldots,8\}$ | $8^8 = 16,777,216$ |
| Una dama por columna **y** una por fila (permutaciones) | $8! = 40,320$ |
| **Con backtracking** (poda por diagonales) | Mucho menos aun |

**Representacion para backtracking:** cada solucion parcial es $(a_1, \ldots, a_k)$, $k \leq n$, con $a_i \in \{1, \ldots, n\}$ indicando la fila de la dama en la columna $i$.

### Sudoku

El problema de resolver un sudoku se resuelve en forma muy eficiente con backtracking (no obstante, el peor caso es exponencial).

## Cuando se aplica

- **Fuerza bruta:** cuando el espacio de soluciones es suficientemente pequeno, o como baseline para verificar correctitud.
- **Backtracking:** problemas de optimizacion combinatoria donde se pueden identificar **podas** que eliminen ramas del arbol de busqueda.
- **Branch and bound:** cuando ademas de podas de factibilidad, se pueden establecer **cotas** (bounds) del valor optimo para podar por optimalidad.

## Formulas clave

$$z^* = \max_{x \in S} f(x) \qquad \text{(problema de optimizacion)}$$

Complejidad tipica de fuerza bruta: $O(2^n)$ para subconjuntos, $O(n!)$ para permutaciones.

## Ver tambien

- [[complejidad_computacional_teoria]] — por que la complejidad exponencial es problematica
- [[divide_y_conquista_teoria]] — tecnica alternativa para problemas descomponibles
