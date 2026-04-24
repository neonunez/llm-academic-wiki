---
nombre: Flujo — Modelar problemas como redes de flujo
parcial: 2P
tema: flujo_en_redes
apariciones_en_parciales:
  - raw/parciales/2P/2.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_2C_2025_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_1C_2025_resolucion(1).pdf
---

# Flujo — Modelar problemas como redes de flujo

## Como reconocer este patron

- Se pide asignar recursos/items/unidades respetando restricciones de capacidad.
- Se pide decidir si una distribucion es factible (flujo maximo = demanda total).
- Se pide maximizar una cantidad que tiene estructura de "matching" (bipartito o no).
- El enunciado menciona: capacidades, fuente, sumidero, redistribucion, donaciones con restricciones.

## Template de resolucion

### Estructura basica de un modelo de flujo

1. **Identificar la fuente $S$** (de donde viene el recurso).
2. **Identificar el sumidero $T$** (a donde va el recurso).
3. **Definir los nodos intermedios** (quienes distribuyen o consumen).
4. **Asignar capacidades** a cada arista segun las restricciones del problema.
5. **Decidir la condicion de exito:** flujo maximo = valor objetivo, o que ciertas aristas esten saturadas.

### Patron: matching bipartito via flujo

Particion $A$ y $B$. Asignacion maxima entre ellas.

- $S \to$ cada nodo de $A$ con cap 1.
- Nodo $a \in A \to$ nodo $b \in B$ si $(a,b)$ es asignacion valida (cap 1 o $\infty$).
- Cada nodo de $B \to T$ con cap 1.
- Flujo maximo = tamaño del matching maximo.

### Patron: viabilidad de redistribucion

Verificar si es posible satisfacer todos los requerimientos respetando las restricciones.

- $S \to$ donantes con cap = cuanto pueden donar.
- Donante $i \to$ receptor $j$ si la restriccion lo permite (cap = $\infty$ o acotada).
- Receptor $j \to T$ con cap = cuanto necesita $j$.
- Exito: flujo max = $\sum$ necesidades de los receptores (todas las aristas al sumidero saturadas).

## Propiedades fundamentales de flujo en redes

| Propiedad | Enunciado |
|-----------|-----------|
| Cota por corte | Para todo flujo $F$ y todo corte $S$: $F \leq w(S)$ |
| Max-flow min-cut | Flujo maximo = capacidad del corte minimo |
| Flujo maximo impar | Implica que al menos una arista tiene capacidad impar |
| Grafo residual | Puede tener ciclos aunque el original sea aciclico |
| Corte minimo | Aumentar una arista del corte minimo no siempre aumenta el flujo (puede haber otro corte minimo) |

## Casos vistos en parciales

**2P_1C_2024 Ej 8 — Propiedades de redes:**
- $F \leq w(S)$ para todo corte $S$ (verdadera).
- Grafo residual puede tener ciclos aunque el original sea aciclico (verdadera).
- Capacidades distintas no implica corte minimo unico (falsa la negacion).

**2P_1C_2024 Ej 9 — Propiedades de cortes:**
- Aumentar arista de corte minimo puede NO aumentar el flujo (si hay otro corte minimo sin esa arista).
- Sumar constante $\delta > 0$ a todas las capacidades SI cambia el flujo.

**2P_2C_2025 Ej 1.III — Cota de flujo por corte:**
- Para cualquier flujo $F$ y corte $S$: $F \leq w(S)$.
- Igualdad $\Leftrightarrow$ flujo maximo y corte minimo.

**2P_2C_2025 Ej 4 — Torneo de voley (redistribucion de puntos):**
- Equipo $i$ tiene puntos sobrantes ($p_i > P$), puede donarlos a $j$ si $i$ le gano a $j$ en lista $L$.
- Receptor $j$ necesita $\min(K+1-p_j, Q)$ puntos para superar $K$.
- Red: $S \to$ donantes (cap = puntos sobrantes); donante $i \to$ receptor $j$ si $(i \to j) \in L$; receptor $\to T$ (cap = puntos necesarios acotados por $Q$).
- Exito: flujo maximo satura todas las aristas al sumidero.

**2P_1C_2025 Ej A9 — Permutacion mas bella (matching bipartito):**
- Bipartir: $A$ = dominio $\{1,...,n\}$, $B$ = imagen $\{1,...,n\}$.
- $S \to A$ (cap 1), $A \to B$ si arista en $G$ (cap 1), $B \to T$ (cap 1).
- Flujo maximo = belleza maxima = tamaño del matching.
- ⚠️ Hay que completar la permutacion: nodos no matcheados se asignan entre si.
- ⚠️ Caps en aristas del medio: 1 es suficiente (no necesita $\infty$, pero funciona con ambas).

## Trampas frecuentes

- Olvidar justificar que el flujo maximo implica factibilidad (explicitar que las aristas al sumidero deben estar saturadas).
- En matching bipartito: no explicar como completar la asignacion para los nodos sin match.
- Confundir $F \leq w(S)$ (valido para cualquier flujo y cualquier corte) con $F = w(S)$ (solo para flujo max y corte min).
- En redistribucion: no acotar correctamente las capacidades (olvidar el limite $Q$ de puntos recibidos).

## Apariciones en parciales

- **2P_1C_2024 Ej 8-9:** propiedades de redes de flujo y cortes
- **2P_2C_2025 Ej 1.III:** cota $F \leq w(S)$
- **2P_2C_2025 Ej 4:** redistribucion de puntos en torneo
- **2P_1C_2025 Ej A9:** permutacion mas bella — matching bipartito via max-flow

## Ejercicios que ejemplifican esto

- [[flujo_en_redes_guia]] — modelado de distintos problemas como flujo
- [[flujo_en_redes_practica]] — ejercicios de clase con modelado
- [[flujo_en_redes_teoria]] — teorema max-flow min-cut, Ford-Fulkerson
