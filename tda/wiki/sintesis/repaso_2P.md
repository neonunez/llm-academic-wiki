---
nombre: Repaso para el Segundo Parcial
parcial: 2P
tipo: sintesis
tema: repaso_2P
fuente: raw/clases/prac/14.prac_2P_repaso_para_segundo_parcial.pdf
paginas_relacionadas:
  - "[[grafos_teoria]]"
  - "[[grafos_practica]]"
  - "[[arboles_teoria]]"
  - "[[arboles_generadores_minimos_teoria]]"
  - "[[arboles_generadores_minimos_practica]]"
  - "[[caminos_minimos_teoria]]"
  - "[[caminos_minimos_practica]]"
  - "[[flujo_en_redes_teoria]]"
  - "[[flujo_en_redes_practica]]"
  - "[[flujo_en_redes_practica_pt2]]"
---

> Clase de consultas para el 2do recuperatorio (3 de diciembre de 2025). Contenido fragmentado — notas de clase con contraejemplos y justificaciones de multiple choice, sin enunciados completos. Cubre grafos (ciclos, isomorfismo con complemento) y flujo (max-flow min-cut, complejidad).

---

## Grafos — Contraejemplos y Justificaciones

### Arbol con exactamente 2 hojas

**Resultado (Contraejemplo C):**
Si $G$ es un grafo sin nodos aislados con exactamente 2 hojas globales, entonces $G$ es un arbol (conexo).

**Justificacion:** Como no hay nodos aislados, cada componente conexa es un arbol no trivial. Todo arbol no trivial tiene al menos 2 hojas. Si $G$ tiene exactamente 2 hojas en total, solo puede haber una componente conexa — por lo tanto $G$ es un arbol (y es isomorfo a un camino simple $P_n$).

### BFS para ciclo de menor longitud

**Resultado:** Para encontrar el ciclo de menor cantidad de aristas que contiene a un nodo especifico, usar BFS desde ese nodo. El procedimiento se repite una vez por cada nodo que se sospeche este en el ciclo.

---

## Flujo — Recordatorio clave

**Fmax = u(Smin):** el valor del flujo maximo es igual a la capacidad del corte minimo.

$$F \leq u(S) \quad \forall \text{ corte } S$$

En particular, $F_{\max} = u(S_{\min})$ y $F_{\max} \leq u(S)$ para cualquier corte $S$ (util para acotar el flujo maximo).

---

## Grafos — Isomorfismo con el propio complemento

**Problema:** Para que valores de $n$ existe un grafo $G$ que sea isomorfo a su complemento $G^c$?

**Desarrollo:**
- Necesitamos $|E(G)| = |E(G^c)|$.
- Como $|E(G)| + |E(G^c)| = \binom{n}{2} = \frac{n(n-1)}{2}$:

$$|E(G)| = \frac{n(n-1)}{4}$$

- Para que esto sea entero, $n(n-1)$ debe ser divisible por 4.
- $n(n-1)$ es el producto de dos consecutivos. Uno de ellos es par. Para ser divisible por 4, el numero par debe ser divisible por 4.
- Esto descarta $n = 2$ ($2 \cdot 1 = 2$, no div. por 4), $n = 3$ ($3 \cdot 2 = 6$), $n = 6$ ($6 \cdot 5 = 30$), $n = 7$ ($7 \cdot 6 = 42$).
- Quedan $n \equiv 0$ o $n \equiv 1 \pmod{4}$.

**Ejemplos validos de grafos auto-complementarios:**

| $n$ | Grafo |
|-----|-------|
| 1 | Trivial ($K_1$) |
| 4 | Camino de 4 nodos ($P_4$) |
| 5 | Ciclo de 5 nodos ($C_5$) |
| 8 | Toro (grafo de 8 nodos) |

---

## Grafos — Demo: ciclo que conecta dos componentes

**Enunciado del ejercicio:** Sea $G$ un grafo conexo y sean $v, w \in V(G)$ tales que $G - \{v,w\}$ tiene al menos 2 componentes conexas $C_1, C_2$.

**(A) Probar que existe un ciclo en $G$ que contiene tanto a $v$ como a $w$.**

**Demostracion (4 casos):**

Sean $v_1 \in C_1 \cap N(v)$, $w_1 \in C_1 \cap N(w)$, $v_2 \in C_2 \cap N(v)$, $w_2 \in C_2 \cap N(w)$ (todos existen porque $G$ es conexo y $C_1, C_2$ son componentes de $G - \{v,w\}$).

- **Caso 1:** $v_1 = w_1$ y $v_2 = w_2$. Entonces $(v, v_1, w, v_2)$ es un ciclo de 4 nodos. $\square$
- **Caso 2:** $v_1 = w_1$ y $v_2 \neq w_2$. Tomar un camino simple $P = (v_2 = p_1, \ldots, p_x = w_2)$ en $C_2$ (existe porque $C_2$ es conexo). Luego $(v, v_1, w, p_1, \ldots, p_x)$ es un ciclo de $\geq 5$ nodos. $\square$
- **Caso 3:** $v_1 \neq w_1$ y $v_2 = w_2$. Analogo al caso 2 usando $C_1$. $\square$
- **Caso 4:** $v_1 \neq w_1$ y $v_2 \neq w_2$. Tomar camino $P = (v_1 = q_1, \ldots, q_y = w_1)$ en $C_1$ y camino $Q = (v_2 = p_1, \ldots, p_x = w_2)$ en $C_2$. Luego $(v, q_1, \ldots, q_y, w, p_1, \ldots, p_x)$ es un ciclo de $\geq 6$ nodos. $\square$

**(B) Dar un algoritmo $O(n+m)$ para encontrar el ciclo.**

El algoritmo sale de la misma idea que la demostracion:
1. Encontrar las componentes conexas de $G - \{v,w\}$: $O(n+m)$.
2. Identificar $v_1, w_1 \in C_1$ y $v_2, w_2 \in C_2$.
3. Segun el caso, hacer a lo sumo 2 BFS/DFS dentro de $C_1$ o $C_2$ para encontrar los caminos $P$ o $Q$: $O(n+m)$ cada uno.
4. Total: $O(n+m)$.

---

## Complejidad de un ejercicio de flujo (referencia)

Notas de complejidad de un ejercicio no identificado completamente (probablemente involucra $k$ grupos y $n$ elementos):

- **Nodos:** $O(n)$
- **Arcos:** $O(n^2)$
- **Flujo maximo:** $(k+1)(n-1) = O(kn)$
- **Complejidad total:** $O(\min(k n^3, n^5))$ con Edmonds-Karp.

---

## Ver tambien

- [[grafos_teoria]] — definiciones, Handshaking, bipartitos, isomorfismo
- [[arboles_teoria]] — lemas de hojas, m = n-1
- [[flujo_en_redes_teoria]] · [[flujo_en_redes_practica]] · [[flujo_en_redes_practica_pt2]]
- [[sintesis/repaso_1P]] — formato analogo para el 1P
