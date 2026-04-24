---
nombre: Definiciones y Demostraciones — Teoria
parcial: 1P
tipo: teoria
tema: definiciones_y_demostraciones
fuente: raw/clases/teo/5.teo_1P_definicion_demo.pdf
paginas_relacionadas:
  - "[[fuerza_bruta_backtracking_teoria]]"
  - "[[programacion_dinamica_teoria]]"
  - "[[greedy_teoria]]"
---

# Definiciones y Demostraciones — Teoria

## Concepto y definicion

Una demostracion es un **algoritmo**: combina definiciones y teoremas para obtener nuevos teoremas. Existen demostradores automaticos que leen demostraciones como programas (ej: Lean).

### Terminologia

| Termino | Significado |
|---------|-------------|
| **Definicion** | Forma de introducir notacion nueva para un objeto matematico |
| **Axioma** | Afirmacion que se toma como valida sin demostrar (ej: axioma de induccion) |
| **Teorema/Lema/Proposicion/Corolario** | Afirmaciones demostradas |

## Estrategias de demostracion

### 1. Demostracion directa

Secuencia de implicaciones: $A \Rightarrow B \Rightarrow C \Rightarrow \cdots \Rightarrow Z$.

**Ejemplo:** Demostrar que dos cuadrados perfectos consecutivos difieren en un numero impar.

Sean $a = (n+1)^2$ y $b = n^2$ cuadrados perfectos consecutivos con $a > b$. Entonces:

$$a - b = (n+1)^2 - n^2 = n^2 + 2n + 1 - n^2 = 2n + 1$$

que es impar. $\blacksquare$

### 2. Por casos

Para demostrar $P \Rightarrow Q$, partir $P$ en $P_1, \ldots, P_q$ y probar $P_i \Rightarrow Q$ para todo $i$.

**Ejemplo:** Demostrar que si $n \in \mathbb{Z}$, entonces $n(n+1)$ es par.

- **Caso $n$ par:** $n = 2k \Rightarrow n(n+1) = 2k(2k+1)$, que es par.
- **Caso $n$ impar:** $n = 2k+1 \Rightarrow n(n+1) = (2k+1)(2k+2) = 2(2k+1)(k+1)$, que es par. $\blacksquare$

### 3. Contradiccion / Absurdo

Asumir que lo que queremos demostrar no se cumple y llegar a algo falso.

**Ejemplo:** Si $n^2$ es par, entonces $n$ es par.

Supongamos $n^2$ par y $n$ impar ($n = 2k+1$). Entonces $n^2 = (2k+1)^2 = 4k^2 + 4k + 1 = 2(2k^2+2k) + 1$, que es impar. Contradiccion con "$n^2$ es par". $\blacksquare$

### 4. Contrarreciproco

$P \Rightarrow Q$ es equivalente a $\neg Q \Rightarrow \neg P$. Se demuestra la segunda.

**Ejemplo (mismo que arriba):** Contrarreciproco: "si $n$ no es par, entonces $n^2$ no es par".

$n$ impar $\Rightarrow n = 2k+1 \Rightarrow n^2 = 4k^2 + 4k + 1 = 2(2k^2+2k)+1$, que es impar. $\blacksquare$

> **ERROR COMUN:** El contrarreciproco de $P \Rightarrow Q$ es $\neg Q \Rightarrow \neg P$, **NO** $\neg P \Rightarrow \neg Q$.

### 5. Por construccion

Para proposiciones de existencia, basta con mostrar un ejemplo.

**Ejemplo:** Demostrar que existe $f : \mathbb{R} \to \mathbb{R}$ par e impar a la vez.

- Par: $f(x) = f(-x)$. Impar: $f(x) = -f(-x)$.
- Forzando ambas: $f(x) = 0$ para todo $x$. La funcion nula es par e impar. $\blacksquare$

### 6. Induccion

Dada una proposicion $P(n)$ dependiente de $n \in \mathbb{N}$:

1. **Caso base:** demostrar $P(1)$ (o $P(a)$ para $n \geq a$).
2. **Paso inductivo:** demostrar $P(i) \Rightarrow P(i+1)$.

**Ejemplo:** Demostrar que $2^n \leq (n+1)!$ para todo $n \in \mathbb{N}$.

- **Base ($n=1$):** $2^1 = 2$ y $(1+1)! = 2$. Vale $2 \leq 2$.
- **Paso inductivo:** Suponemos $2^n \leq (n+1)!$. Entonces:

$$2^{n+1} = 2 \cdot 2^n \leq 2 \cdot (n+1)! \leq (n+2)(n+1)! = (n+2)!$$

La ultima desigualdad vale porque $n+2 \geq 2$. $\blacksquare$

### 7. Contraejemplos

Si una afirmacion es falsa, basta encontrar un ejemplo que lo demuestre.

**Ejemplo:** "$AB = 0_{n \times n} \Rightarrow A = 0 \lor B = 0$" es falso.

$$A = \begin{pmatrix} 1 & 0 \\ 0 & 0 \end{pmatrix}, \quad B = \begin{pmatrix} 0 & 0 \\ 0 & 1 \end{pmatrix} \quad \Rightarrow \quad AB = \begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}$$

Ninguna es la matriz nula, pero el producto si lo es. $\blacksquare$

### 8. Doble implicacion

Para demostrar $P \iff Q$ se debe demostrar **ambas direcciones**: $P \Rightarrow Q$ y $Q \Rightarrow P$.

## Errores comunes en demostraciones

### Razonamiento circular

Asumir lo que se quiere probar. Ejemplo: "Si los elementos son iguales, entonces $x_a = x_b$. Como tomamos cualquier par..."  — esto **asume** la tesis.

### Induccion: caso base faltante

Intentar probar que todos los elementos de un conjunto son iguales: el paso inductivo funciona para $n \geq 3$, pero **falla para $n=2$** (no hay "conjunto previo" que conecte los dos elementos). Falta verificar el caso base $n=2$.

### Induccion: usar hipotesis no establecida

Probar "$a^n = 1$ para todo $a \neq 0$": el paso inductivo usa $a^{n-1} = 1$ **y** $a^{n-2} = 1$, pero la HI solo garantiza $P(n-1)$, no $P(n-2)$.

## Ejemplo resuelto: Poda por optimalidad (Ejercicio 3c de guia)

### Enunciado

Dada una matriz simetrica $M$ de $n \times n$ numeros naturales y un numero $k$, encontrar un subconjunto $I$ de $\{1, \ldots, n\}$ con $|I| = k$ que maximice $\sum_{i,j \in I} M_{ij}$. Proponer una poda por optimalidad y mostrar que es correcta.

### Definiciones formales

- **Solucion parcial** hasta iteracion $it$: $I_{it} \subseteq \{1, \ldots, it\}$.
- **Extension** de $I_{it}$: un conjunto $I$ tal que $I_{it} \subseteq I$ y $I \setminus I_{it} \subseteq \{it+1, \ldots, n\}$.

### Poda propuesta

Si la mejor solucion hasta ahora es $I_{mejor}$ con $\sum_{i,j \in I_{mejor}} M_{ij} = q$, y la solucion parcial $I_{it}$ cumple:

$$\sum_{i,j \in I_{it} \cup \{it+1, \ldots, n\}} M_{ij} \leq q$$

entonces no existe extension $I$ de $I_{it}$ tal que $\sum_{i,j \in I} M_{ij} > q$.

### Demostracion de correctitud

Sea $I$ cualquier extension de $I_{it}$. Como $I = I_{it} \cup (I \setminus I_{it})$ con $I_{it} \cap (I \setminus I_{it}) = \emptyset$:

$$\sum_{i \in I}\sum_{j \in I} M_{ij} = \sum_{i \in I_{it}}\sum_{j \in I_{it}} M_{ij} + \sum_{i \in I_{it}}\sum_{j \in I \setminus I_{it}} M_{ij} + \sum_{i \in I \setminus I_{it}}\sum_{j \in I_{it}} M_{ij} + \sum_{i \in I \setminus I_{it}}\sum_{j \in I \setminus I_{it}} M_{ij}$$

Como $I \setminus I_{it} \subseteq \{it+1, \ldots, n\}$ y los $M_{ij}$ son numeros naturales (no negativos), reemplazar $I \setminus I_{it}$ por el conjunto completo $\{it+1, \ldots, n\}$ solo puede aumentar la suma:

$$\sum_{i \in I}\sum_{j \in I} M_{ij} \leq \sum_{i,j \in I_{it} \cup \{it+1, \ldots, n\}} M_{ij} \leq q$$

Por lo tanto, ninguna extension de $I_{it}$ puede superar $q$, y la poda es correcta. $\blacksquare$

> **Nota sobre solucion incorrecta de cubawiki:** La poda "si agregando todos los indices restantes no llego a $k$, detengo esa rama" es una poda de **factibilidad**, no de optimalidad. No compara con la mejor solucion encontrada, solo verifica si se puede alcanzar tamano $k$.

## Tips para escribir demostraciones

1. **Si estas en duda, explica de mas.**
2. **Empieza definiendo todo formalmente.**
3. Cualquier cosa que escribas, preguntate: por que vale? Si la respuesta es "porque obvio", no sabes por que vale.
4. **Sin idea de como seguir?** Volve a las definiciones. Que resultados vimos en teoria sobre los temas del ejercicio?
5. Para demostrar minimalidad, demostrar que cualquier otro es $\geq$. Para igualdad de conjuntos, doble contencion.

## Cuando se aplica

Este contenido es transversal a toda la materia. Cada tecnica (D&C, PD, Greedy, Backtracking) requiere demostraciones de correctitud y optimalidad. Las estrategias aqui presentadas son las herramientas fundamentales.

## Ver tambien

- [[fuerza_bruta_backtracking_teoria]] — el ejemplo resuelto es una poda por optimalidad en backtracking
- [[greedy_teoria]] — demostraciones de optimalidad de algoritmos golosos usan intercambio
- [[programacion_dinamica_teoria]] — demostraciones por induccion para correctitud de recurrencias
