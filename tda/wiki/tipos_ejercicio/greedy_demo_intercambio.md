---
nombre: Greedy — Demostrar correctitud por argumento de intercambio
parcial: 2P
programa: 2C_2026
tema: greedy
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_2C_2025_resolucion(1).pdf
---

# Greedy — Demostrar correctitud por argumento de intercambio

## Como reconocer este patron

- Se da un problema de optimizacion con algoritmo greedy y se pide demostrar que es optimo.
- Piden "demostrar correctitud del greedy".
- El algoritmo ordena por algun criterio y procesa en ese orden.

## Template de resolucion (Exchange Argument)

1. **Suponer** que existe una solucion optima $O$ que no sigue el orden greedy $G$.
2. **Encontrar** un par adyacente $(i, i+1)$ en $O$ que esta "fuera del orden greedy" (el criterio greedy diria que $i+1$ deberia ir antes que $i$).
3. **Intercambiar** $i$ e $i+1$ en $O$ para obtener $O'$.
4. **Demostrar** que $\text{costo}(O') \leq \text{costo}(O)$ (el intercambio no empeora).
5. **Concluir** que $O'$ sigue siendo optimo. Iterando, toda solucion optima puede transformarse en $G$ sin empeorar → $G$ es optimo.

### Variante: "Greedy stays ahead"

Se demuestra que en cada paso, la solucion greedy es al menos tan buena como cualquier solucion optima hasta ese punto. Mas natural para greedy de seleccion (ej: actividades).

## Por que funciona

Si cualquier solucion optima puede transformarse en la solucion greedy via intercambios locales que no empeoran el costo, entonces la solucion greedy tiene el mismo costo que la optima → es optima.

## Casos vistos en parciales

**1P_2C_2025 — SPT (Shortest Processing Time):**
- Minimizar demora total $\sum d_i$ con $d_i = \sum_{j \leq i} t_j$.
- Orden greedy: $t_i$ ascendente.
- Exchange argument: si $t_i > t_{i+1}$ en posiciones adyacentes $i, i+1$, intercambiarlos reduce $d_i + d_{i+1}$ en $t_i - t_{i+1} > 0$. Contradiccion con optimalidad de $O$.

**Seleccion de actividades (clase practica):**
- Orden por fecha de fin. "Greedy stays ahead": la actividad elegida por greedy termina antes o igual que cualquier otra eleccion, dejando mas espacio para actividades futuras.

**Planificacion con deadlines (clase practica y guia):**
- Ordenar por deadline creciente. Demo por intercambio: si dos tareas estan fuera de orden por deadline, intercambiarlas no aumenta el retraso total.

## Trampas frecuentes

- Usar "greedy stays ahead" cuando el problema pide exchange argument, o viceversa.
- No cerrar el argumento: mostrar que el intercambio no empeora no es suficiente — hay que concluir que iterando llegamos a $G$.
- Para SPT: $d_i = \sum_{j=1}^{i} t_j$ (la tarea $j$ contribuye a la demora de todas las tareas posteriores). Cada $t_j$ se cuenta $n - j + 1$ veces en la suma total.

## Apariciones en parciales

> ⚠️ **Reubicado por el programa vigente (2C-2026).** Greedy era **1P** en el programa viejo, asi que los
> rotulos `1P`/`2P` de la lista de abajo corresponden a **como se tomaba antes**.
> Con el programa vigente este patron es material de tu **2P**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].


- **1P_2C_2025 Ej 3:** Minimizar demora total de $n$ tareas — SPT, exchange argument incompleto en la resolucion

## Ejercicios que ejemplifican esto

- [[greedy_guia]] — Ej de deadlines, ej de minimizacion producto escalar
- [[greedy_practica]] — Seleccion de actividades (demo por intercambio completa), planificacion con deadlines
- [[greedy_teoria]] — Demo de correctitud de seleccion de actividades (lema de intercambio)
