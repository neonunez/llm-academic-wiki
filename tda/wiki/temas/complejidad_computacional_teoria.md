---
nombre: Complejidad Computacional — Repaso
parcial: ambos
programa: 2C_2026
tipo: teoria
tema: complejidad_computacional
fuentes:
  vigente: []
  historico:
    - raw/clases/teo/0.teo_1P_repaso.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[divide_y_conquista_teoria]]"
  - "[[fuerza_bruta_backtracking_teoria]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Complejidad Computacional — Repaso

## Concepto y definicion

En el contexto de la teoria de complejidad computacional:

- **Problema:** descripcion de los datos de entrada y la respuesta a proporcionar para cada dato de entrada.
- **Instancia:** un juego valido de datos de entrada de un problema.

**Ejemplo:**
- Entrada: un numero $n$ entero no negativo.
- Salida: el numero $n$, es primo?
- Una instancia esta dada por un numero entero no negativo concreto.

## Modelo de computo: Maquina RAM

Se supone una **Maquina RAM** (random access memory):

1. La memoria esta dada por una sucesion de celdas numeradas. Cada celda puede almacenar un valor de $b$ bits.
2. Se supone habitualmente que el tamano $b$ en bits de cada celda esta fijo, y que todos los datos individuales que maneja el algoritmo se pueden almacenar con $b$ bits.
3. Se tiene un programa imperativo no almacenado en memoria, compuesto por asignaciones y las estructuras de control habituales.
4. Las asignaciones pueden acceder a celdas de memoria y realizar las operaciones estandar sobre los tipos de datos primitivos habituales.

### Costos de operaciones

Cada instruccion tiene un tiempo de ejecucion asociado:

| Operacion | Costo |
|-----------|-------|
| Acceso a cualquier celda de memoria (lectura/escritura) | $O(1)$ |
| Asignaciones y manejo de estructuras de control | $O(1)$ |
| Operaciones entre valores logicos | $O(1)$ |
| Sumas y restas entre enteros/reales | $O(b)$ |
| Multiplicaciones y divisiones entre enteros/reales | $O(b \log b)$ |

> Si $b$ esta fijo, todas las operaciones aritmeticas son $O(1)$. Si no se puede suponer esto, el costo depende de $b$.

## Tiempo de ejecucion y complejidad

- **Tiempo de ejecucion** de un algoritmo $A$ con instancia $I$:

$$T_A(I) = \text{suma de los tiempos de ejecucion de las instrucciones realizadas por } A \text{ con } I$$

- Dada una instancia $I$, se define $|I|$ como la cantidad de bits necesarios para almacenar los datos de entrada de $I$.
  - Si $b$ esta fijo y la entrada ocupa $n$ celdas de memoria, entonces $|I| = bn = O(n)$.

- **Complejidad** de un algoritmo $A$ (peor caso):

$$f_A(n) = \max_{I : |I| = n} T_A(I)$$

## Notacion asintotica

Dadas dos funciones $f, g : \mathbb{N} \to \mathbb{R}$:

- $f(n) = O(g(n))$ si existen $c \in \mathbb{R}^+$ y $n_0 \in \mathbb{N}$ tales que $f(n) \leq c \cdot g(n)$ para todo $n \geq n_0$.
- $f(n) = \Omega(g(n))$ si existen $c \in \mathbb{R}^+$ y $n_0 \in \mathbb{N}$ tales que $f(n) \geq c \cdot g(n)$ para todo $n \geq n_0$.
- $f(n) = \Theta(g(n))$ si $f = O(g(n))$ y $f = \Omega(g(n))$.

### Clasificacion de algoritmos por complejidad

| Complejidad | Nombre |
|-------------|--------|
| $O(\log n)$ | Logaritmico |
| $O(n)$ | Lineal |
| $O(n^2)$ | Cuadratico |
| $O(n^3)$ | Cubico |
| $O(n^k)$, $k \in \mathbb{N}$ | Polinomial |
| $O(d^n)$, $d \in \mathbb{R}_{>1}$ | Exponencial |

### Propiedad fundamental

Cualquier funcion exponencial es peor que cualquier funcion polinomial:

$$\text{Si } k \in \mathbb{R}_{>1} \text{ y } d \in \mathbb{N}, \text{ entonces } k^n \text{ no es } O(n^d)$$

La funcion logaritmica es mejor que la lineal (independientemente de la base): $\log n$ es $O(n)$ pero no a la inversa.

## Formulas clave

$$f_A(n) = \max_{I : |I| = n} T_A(I)$$

$$f(n) = O(g(n)) \iff \exists\, c > 0,\, n_0 \in \mathbb{N} : f(n) \leq c \cdot g(n) \;\forall\, n \geq n_0$$

## Cuando se aplica

Este repaso es prerequisito de todos los temas de la materia. Las definiciones de complejidad y notacion asintotica se usan para analizar cada tecnica de diseno de algoritmos.

## Ver tambien

- [[divide_y_conquista_teoria]] — primer tema que aplica analisis de complejidad con recurrencias
- [[fuerza_bruta_backtracking_teoria]] — analisis de complejidad exponencial vs polinomial
