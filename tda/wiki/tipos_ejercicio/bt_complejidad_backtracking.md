---
nombre: BT — Analizar complejidad de backtracking
parcial: 1P
tema: fuerza_bruta_backtracking
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/1P/1.parcial_2C_2025_resolucion(1).pdf
---

# BT — Analizar complejidad de backtracking

## Como reconocer este patron

- Se da un algoritmo de backtracking y se pide la complejidad temporal.
- Se dan opciones de complejidad y se pide elegir la mas ajustada.
- Piden dibujar el arbol de recursion para un input pequeño.

## Template de resolucion

1. **Identificar** el espacio de soluciones (arbol de recursion).
2. **Contar las hojas** del arbol (= cantidad de soluciones o asignaciones posibles).
3. **Contar los nodos internos** (no solo las hojas — errores tipicos los ignoran).
4. **Calcular el trabajo por nodo** (ideal: $O(1)$ en nodos internos si se pasa info incrementalmente).
5. **Resultado:** $O(\text{nodos totales} \times \text{trabajo por nodo})$.

### Formulas canonicas

| Espacio de busqueda | Hojas | Nodos totales |
|--------------------|-------|---------------|
| Asignar $n$ items a $c$ categorias | $c^n$ | $O(c^n)$ (arbol $c$-ario de profundidad $n$) |
| Permutaciones de $n$ items | $n!$ | $O(n! \cdot e) \approx O(n!)$ (suma geometrica) |
| Subconjuntos de $n$ items | $2^n$ | $O(2^n)$ (arbol binario) |
| Particion en 2 grupos (arbol binario) | $2^n$ | $O(2^n)$ |

**Optimizacion:** si el trabajo en hojas es $O(n)$ y en nodos internos $O(1)$ (pasando sumas incrementalmente), el total es $O(n! \cdot 1 + \text{hojas} \cdot O(n))$.

## Por que funciona

La complejidad de backtracking es el numero de nodos del arbol de recursion multiplicado por el trabajo en cada nodo. Para calcular el numero de nodos: hojas + nodos internos. En un arbol $k$-ario completo de profundidad $d$, hay $k^d$ hojas y $\sum_{i=0}^{d-1} k^i = \frac{k^d - 1}{k-1}$ nodos internos.

## Casos vistos en parciales

**1P_1C_2024 — Cajones y juguetes:** dos modelos posibles:
- Asignar cajon a cada juguete: $c^j$ nodos, $O(c^j)$.
- Ordenar juguetes: $j!$ hojas, nodos internos $\approx j! \cdot \sum_{i=0}^{j} \frac{1}{i!} \leq j! \cdot 3$, total $O(j!)$.
Respuesta: $O(j!)$ (la segunda opcion con $c < j$).

**1P_2C_2025 — Particion de hojas (A o C):**
$2^{|h|}$ hojas (arbol binario de profundidad $|h|$). Cada hoja evalua `diferencia` en $O(|h|)$. Total: $O(2^{|h|} \cdot |h|)$.

## Trampas frecuentes

- Contar solo hojas y olvidar nodos internos (en arboles muy ramificados los internos son $O(\text{hojas})$).
- Asumir que el trabajo por hoja es siempre $O(n)$ cuando puede ser $O(1)$ si se pasa informacion incrementalmente.
- Confundir la cantidad de subproblemas (para PD) con los nodos del arbol de backtracking.

## Apariciones en parciales

- **1P_1C_2024 Ej 1:** Cajones y juguetes — complejidad $O(j!)$ vs $O(c^j)$
- **1P_2C_2025 Ej 6:** Particion de hojas — arbol binario, $O(2^n \cdot n)$

## Ejercicios que ejemplifican esto

- [[fuerza_bruta_backtracking_guia]] — multiples ejercicios de complejidad BT
- [[fuerza_bruta_backtracking_practica]] — analisis de complejidad por ejercicio
