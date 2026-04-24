---
nombre: PD — Definir recursion y analizar complejidad
parcial: 1P
tema: programacion_dinamica
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/1P/1.parcial_2C_2025_resolucion(1).pdf
  - raw/parciales/1P/1.parcial_1C_2025_resolucion(1).pdf
---

# PD — Definir recursion y analizar complejidad

## Como reconocer este patron

- Piden definir $f(\ldots)$ recursivamente con casos base.
- Piden dar la complejidad temporal y espacial de la solucion PD.
- Piden implementar top-down o bottom-up con complejidad especificada.

## Template de resolucion

### Paso 1: Disenar el estado

Identificar los **parametros que determinan unicamente el subproblema**. Cada parametro que varia entre llamadas forma una dimension del estado. Parametros constantes (como $k$ en el problema de combinaciones) NO se incluyen como dimension.

### Paso 2: Escribir la recursion

$$f(\text{params}) = \begin{cases}
\text{valor base}_1 & \text{si condicion}_1 \\
\text{valor base}_2 & \text{si condicion}_2 \\
\min/\max\{\text{opcion}_1,\ \text{opcion}_2,\ \ldots\} & \text{sino}
\end{cases}$$

Los casos base deben cubrir **todas** las condiciones de terminacion: no solo el caso "exitoso" sino tambien el "imposible".

### Paso 3: Calcular complejidad

- **Temporal:** $O(\text{estados} \times \text{trabajo por estado})$
  - Estados = producto de rangos de cada parametro
  - Trabajo por estado = lo que hace el for/las opciones (generalmente $O(K)$ o $O(1)$)
- **Espacial:** $O(\text{tamano de la tabla de memoizacion})$ = estados

### Paso 4: Trampa frecuente

Confundir la dimension de la tabla con un parametro constante. Si $K$ es constante, el estado es $(n, s)$ con tabla $n \times s$, **no** $K \times n$.

## Por que funciona

La tabla de memoizacion tiene una entrada por subproblema, y cada entrada se llena a lo sumo una vez. La complejidad total es proporcional al numero de entradas multiplicado por el trabajo para llenar cada una.

## Casos vistos en parciales

**1P_1C_2024 — Alfajores de Alfredo:**
Estado $(i, a, h)$ = (pueblo, alfajores acumulados, hambre). 3 decisiones: comprar/comer/nada. Cota de $a$: $\min\{6n, k + n/g\}$. Complejidad $O(n \cdot \min\{n, k+n/g\} \cdot g)$.

**1P_2C_2025 — Combinaciones $\sum v_i = s$:**
Estado $(n, s)$ con $K$ constante. Recursion: $comb(n, s) = \sum_{i=1}^K comb(n-1, s-i)$. Complejidad: $O(n \cdot s \cdot K) = O(n \cdot s)$. Error tipico: decir $O(n \cdot K)$ (confunde tabla $s \times n$ con $K \times n$).

**1P_1C_2025 — Numero combinatorio $\binom{N}{K}$:**
Estado $(N, K)$. Tabla $N \times K$, cada celda $O(1)$ → $\Theta(N \cdot K)$.

## Apariciones en parciales

- **1P_1C_2024 Problema A:** Alfajores de Alfredo — 3 decisiones, acotamiento de dimension
- **1P_2C_2025 Ej 4:** Combinaciones con $K$ constante — complejidad $O(n \cdot s)$
- **1P_1C_2025 Ej 1:** Numero combinatorio — $\Theta(N \cdot K)$

## Ejercicios que ejemplifican esto

- [[programacion_dinamica_guia]] — multiples ejercicios con este patron
- [[programacion_dinamica_top_down_practica_pt1]] — AstroTrade, Tobi el granjero
- [[programacion_dinamica_top_down_practica_pt2]] — receta 6 pasos para PD top-down
