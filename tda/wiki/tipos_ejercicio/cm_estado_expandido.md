---
nombre: CM — Caminos minimos con estado expandido
parcial: 2P
tema: caminos_minimos
apariciones_en_parciales:
  - raw/parciales/2P/2.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_2C_2025_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_1C_2025_resolucion(1).pdf
---

# CM — Caminos minimos con estado expandido

## Como reconocer este patron

- Camino minimo con **restricciones adicionales** sobre el camino (paridad, recursos, colecciones de items, turnos).
- El estado necesario para tomar decisiones optimas no es solo el vertice actual sino una tupla $(vertice, recurso)$.
- El enunciado pide "modelar con grafo" o da cotas de complejidad que involucran potencias de 2 (bitmask) o factores extra.

## Template de resolucion

1. **Identificar el estado:** ¿que informacion necesito saber ademas del vertice actual?
   - Paridad de longitud del camino: bit $b \in \{0, 1\}$ → estado $(v, b)$
   - Turnos restantes: entero $j$ → estado $(v, j)$
   - Conjunto de items colectados: bitmask de $k$ bits → estado $(v, mask)$

2. **Construir grafo expandido:**
   - **Nodos:** producto cartesiano vertice × recurso. Total: $n \cdot |R|$ nodos.
   - **Aristas:** $(u, r) \to (v, r')$ donde $r'$ es el nuevo estado al cruzar la arista $(u,v)$ con estado $r$.
   - **Pesos:** mismo peso que la arista original.

3. **Aplicar Dijkstra/BFS** en el grafo expandido.

4. **Leer el resultado:** en el nodo $(destino, r_{final})$ que satisfaga la condicion de exito.

### Formulas de complejidad

| Restriccion | Estado | Nodos | Aristas |
|-------------|--------|-------|---------|
| Paridad | $(v, b)$, $b \in \{0,1\}$ | $2n$ | $O(m)$ |
| Turnos $t$ | $(v, j)$, $j \in \{0,...,t\}$ | $nt$ | $O(mt)$ |
| Bitmask $k$ items | $(v, mask)$, $mask \in \{0,...,2^k-1\}$ | $n \cdot 2^k$ | $O(m \cdot 2^k)$ |

## Por que funciona

El grafo expandido "abre" cada vertice en multiples copias segun el estado del recurso. Dijkstra en el grafo expandido explora optimamente porque los pesos siguen siendo no negativos (el recurso no afecta los pesos de las aristas).

## Casos vistos en parciales

**2P_1C_2024 Ej 7 — Camino de longitud par minima (paridad):**
- Estado: $(v, b)$ con $b \in \{0, 1\}$ = paridad de la longitud del camino.
- Arista $(u,v)$ en grafo original → aristas $(u, b) \to (v, 1-b)$ en grafo expandido.
- BFS desde $(s, 0)$, respuesta en $(w, 0)$.
- Complejidad: $O(n + m)$.
- Variante: BFS desde $(s, 1)$ busca caminos de longitud impar.

**2P_2C_2025 Ej 3 — Dos amigos comprando comida (bitmask + Dijkstra):**
- $k$ tipos de comida, cada puesto $i$ tiene un subconjunto $food_i$ como bitmask.
- Estado: $(puesto, mask)$ donde $mask$ es el conjunto de comidas ya compradas.
- Arista $(i, j)$ con tiempo $s$ → $(i, mask) \to (j, mask\,|\,food_j)$ con peso $s$.
- Dijkstra desde $(1, 0)$ → distancias $d[n, mask]$ para cada $mask$.
- Post-procesado: $\min_{m_1 \,|\, m_2 = 2^k - 1} \max(d[n, m_1], d[n, m_2])$.
- Complejidad: $O(k \cdot 2^k (n+m))$ construccion + $O(k \cdot 2^k(n+m) \log(n \cdot 2^k))$ Dijkstra.
- ⚠️ La condicion de exito para DOS amigos es $m_1 | m_2 = 2^k - 1$ (union cubre todos los tipos).

**2P_1C_2025 Ej A10 — James Bo (vertices + turnos):**
- Matriz $M[arista][turno]$: indica si la arista puede cruzarse en ese turno.
- Estado: $(vertice, turno)$ — ojo: es vertice, NO arista.
- Arista $(u, j) \to (v, j+1)$ si $M[arista(u,v)][j] = 1$.
- Arista $(u, j) \to (u, j+1)$ para "permanecer".
- BFS desde $(origen, 0)$; primera llegada a $(s \in S, j)$ es la respuesta.
- Complejidad: $|V| = nt$, $|E| = O(mt)$ → BFS $O(nt + mt) = O(mt)$ (ya que $m > n$).
- ⚠️ Error comun: nodos como (arista, turno) en lugar de (vertice, turno).

## Trampas frecuentes

- Definir el estado como (arista, recurso) en lugar de (vertice, recurso) — las aristas no son nodos del grafo.
- Olvidar las aristas de "permanecer" o "no hacer nada" en el grafo expandido.
- En bitmask: confundir $mask = food_j$ (solo lo que tiene el puesto $j$) con $mask | food_j$ (lo acumulado incluyendo el puesto $j$).
- En el post-procesado del problema de dos caminos: iterar $O(4^k)$ pares sin optimizacion puede ser muy lento; buscar con mascaras complementarias.

## Apariciones en parciales

- **2P_1C_2024 Ej 7:** camino de longitud par — grafo duplicado con paridad $O(n+m)$
- **2P_2C_2025 Ej 3:** dos amigos comprando comida — bitmask + Dijkstra $O(k \cdot 2^k(n+m))$
- **2P_1C_2025 Ej A10:** James Bo con turnos — grafo expandido $(vertice, turno)$, BFS $O(mt)$

## Ejercicios que ejemplifican esto

- [[caminos_minimos_guia]] — ejercicios de estado expandido
- [[caminos_minimos_practica]] — ejemplos de clase con restricciones en caminos
- [[bfs_dfs_propiedades]] — BFS como base del estado expandido sin pesos
