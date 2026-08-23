---
nombre: Backtracking — TSP y problemas de permutacion con poda
parcial: 1P
programa: 2C_2026
tema: fuerza_bruta_backtracking
apariciones_en_parciales:
  - wiki/parciales_analizados/1P_1C_2025.md
---

# Backtracking — TSP y problemas de permutacion con poda

## Como reconocer este patron

- El espacio de soluciones es el conjunto de **permutaciones** de $\{1,\ldots,n\}$ (o un subconjunto de ellas).
- Se busca la permutacion de **costo minimo** (o maximo) segun una funcion objetivo acumulativa.
- La funcion objetivo se puede calcular **parcialmente** a medida que se construye la permutacion.
- Señal tipica: "Dada una matriz de distancias/costos $D_{ij}$, encontrar el orden optimo de visitar todos los nodos."

## Template de resolucion

### Representacion de la solucion candidata

- Solucion candidata: permutacion $\pi = (\pi_1, \pi_2, \ldots, \pi_n)$ de $\{1,\ldots,n\}$.
- Solucion parcial: los primeros $k$ elementos $(\pi_1, \ldots, \pi_k)$ ya elegidos, con $\pi_{k+1}, \ldots, \pi_n$ aun no asignados.
- Costo parcial: $\text{costo}(\pi_1,\ldots,\pi_k) = \sum_{i=1}^{k-1} D_{\pi_i \pi_{i+1}}$.

### Algoritmo

```
BT_TSP(perm, usados, costo_parcial, mejor):
  Si |perm| = n:
    Si costo_parcial < mejor.costo:
      mejor ← (perm, costo_parcial)
    Devolver
  Para cada j ∉ usados:
    // Poda por optimalidad
    Si costo_parcial + D[perm[-1]][j] >= mejor.costo:
      Continuar  ← podar
    Extender: perm.agregar(j), usados.agregar(j)
    BT_TSP(perm, usados, costo_parcial + D[perm[-2]][j], mejor)
    Retroceder: perm.quitar(j), usados.quitar(j)

Llamado inicial: BT_TSP([1], {1}, 0, (∅, +∞))
```

### Complejidad (sin podas)

El arbol tiene $n!$ hojas y $O(n!)$ nodos en total. Cada nodo se procesa en $O(1)$ → $O(n!)$ en peor caso.

## Por que funciona

### Correctitud de la poda por optimalidad

Sea $\text{costo}(p) = \sum_{i=1}^{k-1} D_{p_i p_{i+1}}$ el costo de los arcos ya elegidos. Como todos los pesos $D_{ij} \geq 0$:

$$\text{costo}(\text{cualquier extension de } p) \geq \text{costo}(p)$$

Por lo tanto, si $\text{costo}(p) \geq \text{mejor\_hasta\_ahora}$, ninguna extension puede mejorar la solucion actual. La poda no descarta ninguna solucion optima. $\square$

**Condicion clave:** la demostracion depende de que $D_{ij} \geq 0$ para todo $i, j$. Si hubiera costos negativos, la poda seria incorrecta.

### Por que backtracking es correcto

El arbol de backtracking recorre **todas** las permutaciones posibles (sin podas). Con podas, se recorta el arbol pero nunca se omite una solucion optima (por el argumento anterior). Al terminar, `mejor` contiene la permutacion optima.

## Apariciones en parciales

- **1P_1C_2025 — RutaMinima:** Matriz $D$ de $n \times n$ naturales, minimizar $\sum_{i=1}^{n-1} D_{\pi_i \pi_{i+1}}$. Diseñar backtracking, calcular complejidad sin podas, demostrar correctitud de la poda por optimalidad. Ver resolucion completa en [[sintesis/repaso_1P]].

## Ejercicios que ejemplifican esto

- [[fuerza_bruta_backtracking_guia]] — Ej. 4 (RutaMinima/TSP) — ejercicio canonico de este patron
- [[fuerza_bruta_backtracking_guia]] — Ej. 3 (MochilaBT) — backtracking sobre subconjuntos con poda por optimalidad, estructura similar
- [[sintesis/repaso_1P]] — resolucion completa con demostracion de poda
