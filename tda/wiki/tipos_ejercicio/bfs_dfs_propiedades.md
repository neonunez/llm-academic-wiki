---
nombre: BFS/DFS — Propiedades y aplicaciones
parcial: 1P
programa: 2C_2026
tema: recorrido_en_grafos
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_2C_2025_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_1C_2025_resolucion(1).pdf
---

# BFS/DFS — Propiedades y aplicaciones

## Como reconocer este patron

- Se pregunta que propiedades tiene BFS o DFS y cuales son falsas.
- Se pide usar BFS/DFS para encontrar algo (ciclo minimo, componentes, camino con restriccion).
- Se pide analizar la complejidad de DFS/BFS o justificar que corre en $O(|V|+|E|)$.
- Se pide cuantas ejecuciones de BFS/DFS son necesarias para resolver un problema.

## Template de resolucion

### Propiedades fundamentales

**BFS:**
- Explora por **niveles**: todos los vertices a distancia $d$ antes que los de distancia $d+1$.
- Garantiza caminos minimos en cantidad de aristas (no pesos).
- Requiere lista de adyacencia para complejidad $O(|V|+|E|)$.
- El arbol BFS **no es unico** (depende del orden de procesamiento).
- Propiedad ancestro-descendiente (toda arista del grafo va entre niveles adyacentes o mismo nivel) es de BFS; DFS tiene backedges/cross edges.

**DFS:**
- Arbol DFS: clasificacion de aristas en **tree edges, backedges, forward edges, cross edges**.
- Backedge $\Rightarrow$ ciclo en el grafo (en grafos no dirigidos).
- DFS detecta ciclos pero NO garantiza que el ciclo detectado sea el mas corto.
- Complejidad total $O(|V|+|E|)$: cada arco se procesa una sola vez (flag de visitado).

### Ciclo minimo (cantidad de aristas)

- DFS no sirve (backedges no dan ciclos minimos).
- BFS desde un nodo $v$: el primer ciclo detectado al expandir niveles pasa por $v$ y es el mas corto pasando por $v$.
- Para el ciclo minimo global: BFS desde **cada** nodo → $\Theta(|V|)$ ejecuciones de BFS → $O(|V| \cdot (|V|+|E|))$.

### BFS en grilla

En una grilla, la distancia BFS desde $(0,0)$ hasta $(i,j)$ es la **distancia Manhattan**: $i+j$.

> $(i,j)$ se visita despues de $(a,b)$ $\Leftrightarrow$ $i+j > a+b$.

$i > a$ o $j > b$ solos no son suficientes (ej: $(3,0)$ tiene distancia 3 < 5 = dist de $(2,3)$).

## Por que funciona

BFS procesa vertices en orden no decreciente de distancia desde la raiz. En grafos sin pesos (o pesos uniformes), esto garantiza que el primer camino encontrado a cualquier vertice es el mas corto en cantidad de aristas.

## Casos vistos en parciales

**1P_1C_2024 Ej 8 — Propiedades de BFS:**
- **VERDADERA:** todos los vertices a distancia $k$ se visitan antes que los de distancia $k+1$.
- **FALSAS:** arbol BFS unico; propiedad ancestro-descendiente pertenece a DFS.

**1P_1C_2024 Ej 9 — Complejidad DFS:**
- Algoritmo que itera vertices y ejecuta DFS desde no visitados: $O(|V|+|E|)$.
- Clave: flags de visitado evitan re-explorar aristas.

**2P_1C_2024 Ej 7 — Camino de longitud par minima (grafo duplicado):**
- Duplicar nodos: $(v, 0)$ y $(v, 1)$ con bit de paridad.
- BFS desde $(v, 0)$, respuesta en $(w, 0)$ → $O(n+m)$.
- Ver tambien: [[cm_estado_expandido]].

**2P_2C_2025 Ej 1.II — Ciclo con menor cantidad de aristas:**
- **Respuesta correcta:** $\Theta(|V|)$ aplicaciones de BFS (no DFS, no una sola BFS).
- Complejidad: $O(|V| \cdot (|V|+|E|))$.

**2P_1C_2025 Ej A3 — BFS en grilla:**
- Distancia BFS desde $(0,0)$ = distancia Manhattan $i+j$.
- $(i,j)$ despues de $(2,3)$ garantizado $\Leftrightarrow$ $i+j > 5$.

## Trampas frecuentes

- Decir que DFS da el ciclo mas corto (falso: backedges detectan ciclos pero no los minimos).
- Olvidar que una unica BFS da el ciclo minimo que pasa por el nodo de inicio, no el global.
- Confundir paridad con magnitud: $i > 2$ no garantiza que $(i,j)$ este mas lejos que $(2,3)$.

## Apariciones en parciales

> ⚠️ **Reubicado por el programa vigente (2C-2026).** Recorridos era **2P** en el programa viejo, asi que los
> rotulos `1P`/`2P` de la lista de abajo corresponden a **como se tomaba antes**.
> Con el programa vigente este patron es material de tu **1P**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].


- **1P_1C_2024 Ej 8-9:** propiedades BFS, complejidad DFS
- **2P_1C_2024 Ej 7:** camino par minimo (grafo con paridad)
- **2P_2C_2025 Ej 1.II:** ciclo minimo → $\Theta(|V|)$ BFS
- **2P_1C_2025 Ej A3:** BFS en grilla, distancia Manhattan

## Ejercicios que ejemplifican esto

- [[recorrido_en_grafos_guia]] — aplicaciones de BFS/DFS
- [[recorrido_en_grafos_practica]] — ejercicios de clase con BFS/DFS
- [[cm_estado_expandido]] — grafo expandido para restricciones en caminos
