---
nombre: Arboles Generadores Minimos — Guia de Ejercicios
parcial: 2P
programa: 2C_2026
tipo: guia
tema: arboles_generadores_minimos
fuentes:
  vigente: []
  historico:
    - raw/guias_practicas/4.guia_2P_recorridos_&_arboles.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[arboles_generadores_minimos_teoria]]"
  - "[[arboles_generadores_minimos_practica]]"
  - "[[recorrido_en_grafos_guia]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Arboles Generadores Minimos — Guia de Ejercicios

Practica 4: Recorridos y Arboles, seccion AGM + ejercicios integradores. 1er cuatrimestre 2024. Compilado: 21 oct. 2025.

Ejercicios 11–20 de la guia. Los ejercicios de DFS/BFS (ej. 1–10) estan en [[recorrido_en_grafos_guia]]. Ejercicios con ⋆ son el subconjunto minimo recomendado.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 11 ⋆ | AGM de grafo asociado a secuencias, O(kn²) | ⚪ No |
| Ej. 12 ⋆ | Ancho de banda de red + actualizacion de aristas a ∞ | 🔴 Si |
| Ej. 13 | Arbol maximin ↔ AGM maximo; demostracion completa | 🔴 Si |
| Ej. 14 ⋆ | Kruskal/Prim con orden de seleccion; unicidad del AGM con pesos distintos | 🔴 Si |
| Ej. 15 | Unicidad del AGM via Kruskal con prioridades q y −q | ⚪ No |
| Ej. 16 | Virus (integ.): AGM con nodo especial + BFS, O(kn²) | ⚪ No |
| Ej. 17 | Grafos cactus: DFS, AGM en O(n), contar AGMs | ⚪ No |
| Ej. 18 | DFS postorder → orden topologico de digrafo aciclico | 🔴 Si |
| Ej. 19 | Consultas de camino unico entre dos vertices, preprocesar O(n+m) responder O(1) | ⚪ No |
| Ej. 20 | Meta-algoritmo de AGM (Boruvka, Prim, Kruskal como casos particulares) | 🔴 Si |

## Patrones de este tema en parciales

> AGM y minimax/maximin · Unicidad AGM · Kruskal y Prim por invariante · Algoritmo de Boruvka

## Ejercicios

### Ejercicio 11 ⋆ — AGM de Grafo de Secuencias

**Enunciado**

Se define la distancia entre dos secuencias $X = x_1, \ldots, x_k$ e $Y = y_1, \ldots, y_k$ como $d(X, Y) = \sum_{i=1}^{k} |x_i - y_i|$. Dado un conjunto de secuencias $X_1, \ldots, X_n$ de tamano $k$, su grafo asociado $G$ tiene un vertice $v_i$ por secuencia y una arista $v_i v_j$ de peso $d(X_i, X_j)$.

Proponer un algoritmo de complejidad $O(kn^2)$ para encontrar el AGM de este grafo.

**Explicacion**

Hay $O(n^2)$ aristas, cada una con peso calculable en $O(k)$ → matriz de pesos en $O(kn^2)$. Con Prim en $O(n^2)$ (sin heap), el total es $O(kn^2)$. No conviene ordenar las aristas (Kruskal seria $O(n^2 \log n)$ adicional).

**Resolucion paso a paso**

El grafo $G$ tiene $n$ vertices y $\binom{n}{2} = O(n^2)$ aristas. Cada peso $d(X_i, X_j)$ se calcula en $O(k)$.

**¿Por que Prim y no Kruskal?**

- Kruskal requiere ordenar $O(n^2)$ aristas → $O(n^2 \log n)$, que supera $O(kn^2)$ cuando $k < \log n$.
- Prim con arreglo (sin heap): mantiene un arreglo $\text{key}[v]$ = peso minimo de arista que conecta $v$ con el arbol actual. Cada iteracion: encontrar el minimo en $O(n)$, actualizar vecinos en $O(n)$ → $n$ iteraciones × $O(n)$ = $O(n^2)$.

**Algoritmo $O(kn^2)$:**

```
# Precalcular pesos bajo demanda (lazy: no materializar la matriz entera)
# Prim con arreglo
T = {}
en_arbol = {v1}
key[v] = ∞  para todo v ≠ v1
padre[v] = null

para v vecino de v1:        # O(n) vecinos, O(k) cada peso
    key[v] = d(X_1, X_v)
    padre[v] = v1

repetir n-1 veces:
    u = argmin_{v ∉ en_arbol} key[v]    # O(n)
    agregar (padre[u], u) a T
    en_arbol += {u}
    para v ∉ en_arbol:                  # O(n) vecinos, O(k) cada peso
        w = d(X_u, X_v)
        si w < key[v]:
            key[v] = w
            padre[v] = u
```

Costo: $n$ iteraciones × ($O(n)$ para el minimo + $O(kn)$ para actualizar vecinos) = $O(kn^2)$.

**Nota:** Los pesos se calculan "on the fly" en la actualizacion de vecinos — no hace falta materializar la matriz completa.

**Chuleta**

> 1. Usar Prim con arreglo (no heap, no Kruskal).
> 2. Calcular $d(X_u, X_v)$ on the fly en $O(k)$ al actualizar key[v].
> 3. $n$ iteraciones × $O(kn)$ actualizaciones = $O(kn^2)$.
> 4. Kruskal seria $O(n^2 \log n)$ por el sort — peor cuando $k < \log n$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 12 ⋆ — Ancho de Banda de Red

**Enunciado**

Una empresa modela su red con un grafo $G$ con capacidades positivas. El ancho de banda de la red es el maximo $k$ tal que $G_k$ (subgrafo generador eliminando aristas de peso $< k$) es conexo.

a) Proponer un algoritmo eficiente para determinar el ancho de banda de la red.

La empresa quiere actualizar $i$ aristas a capacidad virtualmente infinita (para todo $0 \leq i < n$).

b) Proponer un algoritmo que determine el vector $a_0, \ldots, a_{n-1}$ donde $a_i$ es el maximo ancho de banda posible reemplazando $i$ aristas.

**Explicacion**

a) El ancho de banda es el peso minimo de las aristas del AGM maximo (si el AGM maximo es conexo, el ancho de banda es el minimo peso del AGM maximo). Computar el AGM maximo en $O(m \log n)$ y devolver el peso minimo de sus aristas.

b) Con $i$ reemplazos: las $i$ aristas mas livianas del AGM maximo se convierten en $\infty$ → el nuevo ancho de banda es el $(i+1)$-esimo peso mas grande de las aristas del AGM original. El vector $a_i$ se obtiene recorriendo las aristas del AGM maximo en orden.

Este ejercicio es la version abstracta del problema de audifonos defectuosos de [[arboles_generadores_minimos_practica]].

**Resolucion paso a paso**

**Parte a) — Ancho de banda = minimo peso del AGM maximo:**

El ancho de banda es el maximo $k$ tal que $G_k$ es conexo. Afirmamos que:
$$\text{ancho de banda} = \min_{e \in T^*} c(e)$$
donde $T^*$ es el AGM maximo de $G$.

*Demostracion:*
- Sea $k^* = \min_{e \in T^*} c(e)$. El AGM maximo $T^*$ usa solo aristas de peso $\geq k^*$, y es un arbol generador — luego $G_{k^*}$ es conexo. Asi el ancho de banda $\geq k^*$.
- Para cualquier $k > k^*$: la arista $e^* \in T^*$ con $c(e^*) = k^*$ no esta en $G_k$ (peso $< k$). Si quitar $e^*$ de $G$ desconecta $G_k$... Mas precisamente: si existiera un arbol generador de $G_k$ (todas aristas $\geq k > k^*$), ese arbol tendria mayor peso que $T^*$ — contradiccion con que $T^*$ sea maximo. Luego $G_k$ no es conexo para $k > k^*$.

Algoritmo:
1. Calcular AGM maximo con Kruskal (orden decreciente de pesos) o Prim — $O(m \log n)$.
2. Retornar la arista de menor peso del AGM maximo.

**Parte b) — Vector de anchos de banda con $i$ reemplazos:**

Con $i$ reemplazos optimos: conviene reemplazar exactamente las $i$ aristas de menor peso del AGM maximo (el cuello de botella esta en esas aristas). Tras reemplazarlas con $\infty$, el nuevo minimo del AGM es la arista de menor peso entre las $n-1-i$ restantes.

Sea el AGM maximo con aristas ordenadas $w_1 \geq w_2 \geq \ldots \geq w_{n-1}$:

$$a_i = w_{n-1-i} \quad \text{para } i = 0, 1, \ldots, n-2$$

(Para $i = n-1$: todas las aristas del AGM son $\infty$, ancho de banda = $\infty$.)

*Justificacion:* Reemplazar las $i$ aristas de menor peso ($w_{n-1}, \ldots, w_{n-i}$) por $\infty$. El nuevo AGM maximo incluye estas $i$ aristas (ahora $\infty$) mas las $n-1-i$ restantes del AGM original. El nuevo minimo es $w_{n-1-i}$. Ninguna otra eleccion de $i$ aristas puede lograr un minimo mayor, ya que el AGM maximo es la estructura optima de conectividad.

Algoritmo para el vector:
1. Calcular AGM maximo — $O(m \log n)$.
2. Ordenar sus $n-1$ aristas: $w_1 \geq \ldots \geq w_{n-1}$ — $O(n \log n)$.
3. $a_i = w_{n-1-i}$ para cada $i$ — $O(n)$.

Total: $O(m \log n)$.

**Chuleta**

> **a)** Ancho de banda = $\min_{e \in T^*} c(e)$ donde $T^*$ = AGM maximo. Kruskal maximo → $O(m \log n)$.
>
> **b)** Aristas del AGM maximo en orden $w_1 \geq \ldots \geq w_{n-1}$. Con $i$ reemplazos: $a_i = w_{n-1-i}$.
> Intuicion: reemplazar los $i$ cuellos de botella del AGM por $\infty$, el nuevo minimo sube.

**¿Aparece en parciales?** 🔴 Si — MiniMax/MaxiMin via AGM es tema evaluado en 2P

---

### Ejercicio 13 — Arbol MaxiMin

**Enunciado**

El ancho de banda $bwd_G(C)$ de un camino $C$ es el minimo peso de sus aristas. El ancho de banda $bwd_G(v,w)$ entre $v$ y $w$ es el maximo entre los anchos de banda de todos los caminos de $v$ a $w$. Un arbol generador $T$ es maximin cuando $bwd_T(v,w) = bwd_G(v,w)$ para todo $v,w$.

Demostrar: $T$ es maximin $\Leftrightarrow$ $T$ es un AGM maximo. Concluir que el arbol maximin existe y puede computarse con cualquier algoritmo de AGM maximo.

Hint: para la ida, tomar el AGM $T'$ con mas aristas en comun con $T$ y suponer que $T'$ tiene una arista $e'$ no en $T$. Para la vuelta, considerar la arista $xy$ de peso minimo en el unico camino de $T'$ que une $v$ y $w$.

**Explicacion**

Esta demostracion es el nucleo teorico del problema de audifonos defectuosos. La idea: en el AGM maximo, el camino entre cualquier par de vertices maximiza el peso minimo de las aristas del camino — esto es exactamente la propiedad maximin. Aparece en [[arboles_generadores_minimos_practica]].

**Resolucion paso a paso**

**($\Rightarrow$) maximin $\Rightarrow$ AGM maximo:**

Sea $T$ maximin. Supongamos que $T$ no es AGM maximo. Sea $T^*$ el AGM maximo con la mayor cantidad de aristas en comun con $T$ (entre todos los AGMs maximos).

Como $T \neq T^*$, existe $e^* = uv \in E(T^*) \setminus E(T)$. Al agregar $e^*$ a $T$ se forma un unico ciclo $C$ en $T \cup \{e^*\}$. Existe $e \in C \cap E(T) \setminus E(T^*)$ (alguna arista del ciclo esta en $T$ pero no en $T^*$).

Como $T^*$ es AGM maximo: $c(e) \leq c(e^*)$ (si $c(e) > c(e^*)$, reemplazar $e^*$ por $e$ en $T^*$ aumentaria el peso — contradiccion).

La arista $e$ divide $T$ en dos componentes al eliminarla; $u$ y $v$ (extremos de $e^*$) quedan en componentes distintas, y el unico camino de $u$ a $v$ en $T$ pasa por $e$. Entonces:
$$bwd_T(u,v) \leq c(e) \leq c(e^*) \leq bwd_G(u,v)$$

Si $c(e) < c(e^*)$: $bwd_G(u,v) \geq c(e^*) > c(e) = bwd_T(u,v)$ — contradiccion con que $T$ sea maximin.

Luego $c(e) = c(e^*)$. Entonces $T' = T^* \cup \{e\} \setminus \{e^*\}$ es tambien AGM maximo con mas aristas en comun con $T$ que $T^*$ — contradiccion con la eleccion de $T^*$.

Por tanto $T$ es AGM maximo. $\square$

**($\Leftarrow$) AGM maximo $\Rightarrow$ maximin:**

Sea $T^*$ un AGM maximo. Para cualquier par $v, w$ y cualquier camino $P$ de $v$ a $w$ en $G$:

Sea $xy$ la arista de menor peso en $P_{T^*}(v,w)$ (el camino unico de $v$ a $w$ en $T^*$), con $c(xy) = bwd_{T^*}(v,w)$. Al eliminar $xy$ de $T^*$, el grafo se divide en dos componentes $A$ (contiene $v$) y $B$ (contiene $w$).

*Claim:* toda arista de $G$ entre $A$ y $B$ tiene peso $\leq c(xy)$.

*Prueba del claim:* si existiera $e' = a'b'$ con $a' \in A$, $b' \in B$ y $c(e') > c(xy)$: reemplazar $xy$ por $e'$ en $T^*$ produce un arbol de mayor peso — contradiccion con que $T^*$ sea AGM maximo. Luego $c(e') \leq c(xy)$ para toda arista entre $A$ y $B$.

Consecuencia: cualquier camino $P$ de $v$ a $w$ en $G$ cruza el corte $(A, B)$ al menos una vez, y cada cruce usa una arista de peso $\leq c(xy)$. Luego $bwd_G(P) \leq c(xy) = bwd_{T^*}(v,w)$ para todo camino $P$.

Tomando el maximo sobre todos los caminos: $bwd_G(v,w) \leq bwd_{T^*}(v,w)$.

La desigualdad opuesta es inmediata ($T^*$ es un camino en $G$). Luego $bwd_{T^*}(v,w) = bwd_G(v,w)$.

$T^*$ es maximin. $\square$

**Conclusion:** El arbol maximin existe (existe el AGM maximo) y puede computarse con cualquier algoritmo de AGM maximo en $O(m \log n)$.

**Chuleta**

> **AGM maximo $\Leftrightarrow$ arbol maximin.**
>
> **$\Leftarrow$ (clave):** Sea $xy$ la arista minima del camino $T^*(v,w)$. Al cortar $xy$, el grafo queda en $(A, B)$. Por ser AGM maximo, toda arista entre $A$ y $B$ tiene peso $\leq c(xy)$. Luego todo camino $v \to w$ en $G$ tiene cuello de botella $\leq c(xy) = bwd_{T^*}(v,w)$.
>
> **$\Rightarrow$:** Si $T$ maximin pero no AGM maximo, se encuentra $e \in T \setminus T^*$ con $c(e) < c(e^*)$ (arista de $T^*$), contradiciendo la propiedad maximin.

**¿Aparece en parciales?** 🔴 Si — demo AGM ↔ maximin aparece en practica de clase

---

### Ejercicio 14 ⋆ — Kruskal/Prim con Orden de Seleccion

**Enunciado**

El algoritmo de Kruskal/Prim con orden de seleccion es una variante donde a cada arista $e$ se le asigna una prioridad $q(e)$ ademas de su peso $p(e)$. Cuando hay multiples aristas candidatas, se elige la de minima prioridad.

a) Demostrar que para todo AGM $T$ de $G$, si las prioridades son $q_T(e) = 0$ si $e \in T$, $1$ si $e \notin T$, entonces el algoritmo con $q_T$ retorna $T$.

b) Usando a), demostrar: si todos los pesos de $G$ son distintos, entonces $G$ tiene un unico AGM.

**Explicacion**

a) Con las prioridades $q_T$, el algoritmo siempre prefiere las aristas de $T$ ante empates de peso — como $T$ es un AGM valido, el algoritmo siempre puede elegir aristas de $T$ sin violar las propiedades. Inductivamente, retorna exactamente $T$.

b) Si todos los pesos son distintos, no hay empates de peso → el resultado de Kruskal/Prim es unico sin importar las prioridades. Por a), ese unico resultado debe ser $T$ para cualquier AGM $T$, lo que implica que solo hay un AGM.

**Resolucion paso a paso**

**Parte a) — Kruskal con $q_T$ retorna $T$:**

Kruskal con prioridades procesa aristas en orden lexicografico $(p(e), q_T(e))$. Las aristas de $T$ (prioridad 0) se procesan antes que las de fuera (prioridad 1) cuando tienen igual peso.

**Invariante:** en todo momento del algoritmo, el bosque $F$ es un subgrafo de $T$.

*Base:* $F = \emptyset \subseteq T$. ✓

*Paso:* Supongamos $F \subseteq T$ antes de procesar la arista $e$.

- Caso $e \in T$: $e$ conecta dos vertices de $T$. Como $T$ es arbol (aciclico), $e$ no forma ciclo en $T$. Pero ¿forma ciclo en $F$? Si los extremos de $e$ ya estan conectados en $F$: como $F \subseteq T$ y $T$ es aciclico, los extremos de $e$ NO pueden estar conectados en $F$ sin pasar por $e$ (pues el camino en $F$ tambien estaria en $T$, creando un ciclo). Contradiccion. Luego $e$ no forma ciclo en $F$ y se agrega. $F$ sigue siendo subgrafo de $T$. ✓

- Caso $e \notin T$: cuando se procesa $e = uv$ (prioridad 1), todas las aristas de $T$ con $p \leq p(e)$ ya fueron procesadas. En particular, el camino de $u$ a $v$ en $T$ (que existe pues $T$ es arbol generador) usa aristas de $T$ con peso $\leq p(e)$ (si alguna arista del camino tuviera $p > p(e)$, por la propiedad del ciclo de AGM, $e$ no podria estar en el AGM — contradiccion). Luego esas aristas ya fueron agregadas a $F$, por lo que $u$ y $v$ ya estan conectados en $F$, y $e$ forma ciclo en $F$ → no se agrega. ✓

Por induccion, Kruskal agrega exactamente las aristas de $T$ y retorna $T$. $\square$

**Parte b) — Pesos distintos $\Rightarrow$ AGM unico:**

Si todos los pesos son distintos, no hay empates en $p(e)$. El algoritmo de Kruskal es completamente determinístico (el orden lexicografico $(p(e), q(e))$ coincide con el orden por $p(e)$ solo, independientemente de $q$). Luego Kruskal retorna el mismo arbol para cualquier funcion de prioridades $q$.

Por la parte a): para cualquier AGM $T$, Kruskal con $q_T$ retorna $T$. Pero como Kruskal es determinístico (independiente de $q$), todos los AGMs coinciden con ese unico resultado. Luego hay un unico AGM. $\square$

**Chuleta**

> **a)** Prioridades $q_T$: aristas de $T$ tienen prioridad 0 → se procesan antes. Invariante: el bosque $F \subseteq T$ siempre. Las aristas de $T$ no crean ciclos en $F$ (pues $T$ es acíclico y $F \subseteq T$). Las aristas de $\notin T$ crean ciclos (el camino en $T$ ya esta en $F$). Retorna $T$.
>
> **b)** Pesos distintos → Kruskal determinístico → retorna un unico arbol → es el unico AGM.

**¿Aparece en parciales?** 🔴 Si — unicidad de AGM y propiedades de Kruskal/Prim son temas evaluados

---

### Ejercicio 15 — Unicidad del AGM via Prioridades Opuestas

**Enunciado**

Sea $q: V(G) \to \mathbb{Z}$ una funcion inyectiva. Demostrar que $G$ tiene un unico AGM si y solo si el algoritmo de Kruskal con prioridad $q$ retorna el mismo arbol que el algoritmo de Kruskal con prioridad $-q$.

**Explicacion**

Si el AGM es unico, ambas variantes de Kruskal deben retornar ese mismo arbol. Si hay multiples AGMs, se puede encontrar un par de aristas de igual peso $p$ donde el algoritmo con $q$ prefiere una y con $-q$ la otra, produciendo dos AGMs distintos.

**Resolucion paso a paso**

**($\Rightarrow$) AGM unico $\Rightarrow$ ambos Kruskal retornan el mismo arbol:**

Si el AGM es unico, cualquier version del algoritmo de Kruskal (con cualquier funcion de desempate) retorna ese unico AGM. En particular, Kruskal con $q$ y con $-q$ retornan el mismo arbol. ✓

**($\Leftarrow$) Ambos Kruskal retornan el mismo arbol $\Rightarrow$ AGM unico:**

Contrapositivo: si hay multiples AGMs, los dos Kruskal retornan arboles distintos.

Si hay multiples AGMs, por el Ej. 14b, existen aristas con pesos repetidos. Existe una clase de peso $p^*$ que es "critica": hay un momento en el procesamiento de Kruskal donde, al considerar las aristas de peso $p^*$, la eleccion entre ellas determina a que AGM se llega.

Mas formalmente: sea $p^*$ el menor peso donde los dos AGMs difieren. Existen dos AGMs $T_1 \neq T_2$ y una arista $e^* \in T_1 \setminus T_2$ (o viceversa) con peso $p^*$. Hay otra arista $e' \in T_2 \setminus T_1$ con $p(e') = p^*$ (ya que en el conjunto de aristas de peso $p^*$ disponibles, $T_1$ y $T_2$ eligen diferente).

Como $q$ es inyectiva, $q(e^*) \neq q(e')$. Uno de ellos tiene $q$-valor menor y el otro $(-q)$-valor menor. Kruskal con $q$ prefiere la de menor $q$-valor; Kruskal con $-q$ prefiere la de menor $(-q)$-valor = mayor $q$-valor. Por tanto eligen aristas distintas en este punto del procesamiento, produciendo dos AGMs distintos. ✓

⚠️ Verificar — La demostracion de la vuelta asume que al elegir aristas distintas en ese punto se llega a AGMs distintos. Esto es cierto si la clase de aristas critica realmente determina el AGM, pero el argumento formal requiere mostrar que el resto del algoritmo no "corrige" la diferencia.

**Chuleta**

> **$\Rightarrow$:** AGM unico → ambos Kruskal lo retornan (por unicidad).
>
> **$\Leftarrow$ (contrapositivo):** Multiples AGMs → existe clase de peso critica donde $q$ y $-q$ eligen aristas distintas (pues $q$ inyectiva → ordenes opuestos) → arboles distintos.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 16 — Virus (Integrador)

**Enunciado**

Se tiene una matriz de $n \times n$ con valores en $\{C, -, +, V\}$. El virus parte de $V$ y quiere infectar todas las ciudades $C$. Los $+$ curan a los infectados que pasan. El virus quiere minimizar el numero total de pasos de personas controladas para infectar todos los habitantes.

Proponer un algoritmo con complejidad temporal $O(kn^2)$ donde $k$ es la cantidad de ciudades $C$.

Ejemplo: matriz de 5×5 con resultado de 13 pasos.

**Explicacion**

Modelado: grafo implicito con nodos = ciudades + $V$. La distancia entre dos ciudades/V es la distancia en el grafo de celdas (evitando $+$). Calcular distancias entre todos los pares de ciudades/$V$ usando BFS desde cada ciudad/V: $O(k \cdot n^2)$. Luego resolver el problema de AGM minimo sobre el grafo de ciudades para minimizar los pasos totales (similar al problema del viajante minimizado por un arbol). La idea es que el virus puede moverse como quiera, optimizando el arbol de expansion.

**Resolucion paso a paso**

**Modelado:**

- **Nodos especiales:** $\{V, C_1, \ldots, C_k\}$ — el origen del virus y las $k$ ciudades.
- **Grafo de la grilla:** vertices = celdas de la matriz $n \times n$; aristas = movimientos horizontales/verticales entre celdas no-$+$.
- **Distancia $d(u, v)$** entre dos nodos especiales: longitud del camino BFS mas corto en la grilla de $u$ a $v$ evitando celdas $+$.
- **Grafo de ciudades:** vertices = $\{V, C_1, \ldots, C_k\}$, aristas con peso $d(u,v)$.

**Algoritmo:**

1. **BFS desde cada nodo especial:** para cada uno de los $k+1$ nodos especiales, realizar BFS sobre la grilla $n \times n$ para calcular sus distancias a todos los demas nodos especiales. Costo: $(k+1) \cdot O(n^2) = O(kn^2)$.

2. **AGM minimo del grafo de ciudades:** con $k+1$ vertices y $O(k^2)$ aristas, calcular el AGM minimo con Prim en $O(k^2)$.

3. **Resultado:** el peso del AGM minimo del grafo de ciudades es la cantidad minima de pasos totales para que el virus infecte todas las ciudades.

**Correctitud:** El virus necesita "tender" conexiones entre todas las ciudades desde $V$. La estructura optima que minimiza la suma total de distancias recorridas es el AGM minimo del grafo de ciudades. Las celdas $+$ actuan como barreras impenetrables (el virus no puede cruzarlas).

**Complejidad total:** $O(kn^2)$ (domina el BFS; el AGM es $O(k^2) \leq O(n^2)$).

⚠️ Verificar — El enunciado no especifica exactamente como se acumula el costo (¿es la suma de los pesos del AGM, o se recorre el arbol?). La explicacion de la guia sugiere que el peso del AGM minimo es la respuesta. Verificar con el ejemplo de la grilla 5×5 con resultado 13.

**Chuleta**

> 1. BFS desde cada nodo especial ($V$ y $C_i$) sobre la grilla evitando $+$ — $O(kn^2)$.
> 2. Construir grafo de ciudades con pesos = distancias BFS.
> 3. AGM minimo del grafo de ciudades = pasos minimos totales.
> 4. $O(kn^2)$ total.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 17 — Grafos Cactus

**Enunciado**

Un grafo $G$ es un cactus cuando cada una de sus aristas pertenece a un unico ciclo.

a) Sea $T$ un arbol DFS de $G$. Demostrar: $G$ es un cactus $\Leftrightarrow$ para toda arista $vw \in E(G) \setminus E(T)$, el camino $T(v,w) + vw$ es el unico ciclo que contiene a las aristas de $T(v,w)$.

b) Demostrar que los grafos cactus tienen $O(n)$ aristas.

c) Disenar un algoritmo de tiempo $O(n)$ para determinar si $G$ es un cactus; en caso afirmativo retornar todos los ciclos, en caso negativo retornar dos ciclos que comparten una arista.

d) Disenar un algoritmo de tiempo $O(n)$ para encontrar un AGM de un grafo cactus. Justificar con resultados conocidos.

e) Formula para contar la cantidad de AGMs de un cactus en $O(n)$ operaciones.

**Explicacion**

b) Cada ciclo simple contribuye exactamente una arista "extra" respecto al arbol ($m = n - 1 + \text{numero de ciclos independientes}$). En un cactus, los ciclos son vertex-disjuntos en aristas, y cada arista pertenece a exactamente un ciclo → $m = O(n)$.

d) Por el Ejercicio 13b del Ejercicio 14 ([[arboles_generadores_minimos_teoria]]), el AGM de un cactus se puede computar directamente con Kruskal en $O(n \alpha(n))$ — pero al ser $m = O(n)$, es $O(n)$.

**Resolucion paso a paso**

**Parte a) — Caracterizacion via DFS:**

$(\Rightarrow)$ Si $G$ es cactus: cada arista de arbol $e \in T(v,w)$ pertenece exactamente al ciclo $T(v,w) + vw$. Ninguna otra back edge puede usar aristas de $T(v,w)$, pues eso pondria esas aristas en dos ciclos distintos.

$(\Leftarrow)$ Si para toda back edge $vw$, el ciclo $T(v,w)+vw$ es el unico que contiene las aristas de $T(v,w)$: los ciclos de $G$ corresponden biyectivamente a las back edges, y cada arista de arbol esta en a lo sumo un ciclo. Las back edges tampoco comparten aristas entre si (cada una forma su propio ciclo disjunto). Luego cada arista esta en a lo sumo un ciclo — $G$ es cactus. $\square$

**Parte b) — $m = O(n)$:**

Por la caracterizacion del DFS: $m = (n-1) + |\text{back edges}|$. Cada back edge $vw$ define un ciclo $T(v,w) + vw$ de longitud $|T(v,w)| + 1 \geq 3$, y las aristas de arbol usadas ($T(v,w)$) son disjuntas entre distintas back edges (propiedad del cactus). El arbol $T$ tiene $n-1$ aristas repartidas entre los distintos $T(v,w)$; como cada $|T(v,w)| \geq 2$, hay a lo sumo $(n-1)/2$ back edges. Luego:
$$m = (n-1) + |\text{back edges}| \leq (n-1) + \frac{n-1}{2} < \frac{3n}{2} = O(n). \quad \square$$

**Parte c) — Algoritmo $O(n)$:**

Como $m = O(n)$, el DFS tiene costo $O(n)$.

1. DFS sobre $G$. Para cada back edge $vw$: registrar el ciclo $C_{vw} = T(v,w) + vw$.
2. Para cada arista de arbol $e \in T$: llevar cuenta de cuantos ciclos la contienen (marcado durante la DFS: al procesar la back edge $vw$, marcar las aristas de $T(v,w)$).
3. Si algun arista de arbol esta marcada dos veces: $G$ no es cactus — retornar los dos ciclos que comparten esa arista.
4. Si ninguna arista esta marcada dos veces: $G$ es cactus — retornar todos los ciclos $\{C_{vw}\}$.

Costo: $O(n)$ (una DFS + marcado lineal en el total de aristas de los ciclos, que es $O(n)$ por la parte b).

**Parte d) — AGM del cactus en $O(n)$:**

Usando la propiedad del ciclo de Kruskal: **en cualquier ciclo, la arista de menor peso no puede estar en el AGM** (si estuviera, seria la unica conexion en ese ciclo → no esta en ningun ciclo de $T$ → no hay ciclo que la contenga → contradiction). Entonces:

Algoritmo:
1. Para cada ciclo del cactus: eliminar la arista de menor peso.
2. Las aristas restantes forman el AGM.

Correctitud: en cada ciclo, exactamente una arista no puede estar en el AGM (la de menor peso). El resultado es un arbol generador de peso maximo entre los subgrafos que no contienen ciclos con aristas eliminadas correctamente.

Complejidad: recorrer todos los ciclos (total $O(n)$ aristas) para encontrar el minimo de cada uno → $O(n)$.

**Parte e) — Contar AGMs:**

Para cada ciclo $i$ de longitud $\ell_i$: el AGM debe excluir exactamente una arista del ciclo. Si hay $k_i$ aristas de peso minimo en el ciclo $i$, hay $k_i$ elecciones validas.

$$\#\text{AGMs} = \prod_{i} k_i$$

donde el producto es sobre todos los ciclos del cactus.

Complejidad: recorrer cada ciclo una vez para contar aristas de peso minimo → $O(n)$.

**Chuleta**

> **Cactus:** cada arista en exactamente un ciclo. $m = O(n)$.
> - **DFS** $O(n)$: cada back edge define un ciclo; ciclos disjuntos en aristas.
> - **AGM** $O(n)$: eliminar la arista de menor peso de cada ciclo.
> - **Contar AGMs**: $\prod_i (\text{aristas de peso min en ciclo } i)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 18 — DFS Postorder → Orden Topologico

**Enunciado**

Sea $v$ un vertice que alcanza todos los otros en un digrafo $D$ y sea $T$ un arbol generador obtenido por DFS desde $v$, con vertices hermanos ordenados por tiempo de descubrimiento. Sea $S$ la secuencia de vertices en postorder de $T$.

a) Demostrar: $D$ es aciclico $\Leftrightarrow$ el reverso de $S$ es un orden topologico de $D$.

b) Describir el algoritmo resultante para determinar si $D$ es aciclico y obtener el orden topologico.

c) Modificar para evitar la suposicion de que existe un vertice que alcanza a todos.

**Explicacion**

El DFS postorder en un DAG produce los vertices en orden inverso topologico: si $u \to v$ en $D$, entonces $v$ termina de procesarse antes que $u$ en el DFS → $v$ aparece antes en el postorder → $u$ aparece antes en el reverso. El reverso del postorder es un orden topologico valido.

c) Hacer DFS desde todos los vertices no visitados (multiples arboles DFS).

Este ejercicio es una variante del orden topologico de [[recorrido_en_grafos_practica]].

**Resolucion paso a paso**

**Parte a) — DAG $\Leftrightarrow$ reverso del postorder es orden topologico:**

$(\Rightarrow)$ Sea $D$ un DAG y $u \to v$ un arco.

En el DFS desde el vertice raiz:
- Si $v$ es descendiente de $u$ en el arbol DFS: $v$ termina antes que $u$ (por definicion de postorder). Luego $v$ aparece antes en $S$ → $u$ aparece antes en el reverso de $S$. ✓
- Si $v$ no es descendiente de $u$: el arco $u \to v$ es un "cross edge" o "forward edge" en el DFS.
  - Forward edge: $v$ es descendiente de $u$ → caso anterior.
  - Cross edge: $v$ ya fue visitado y cerrado antes de que DFS llegara a $u$. Luego $v$ aparece antes que $u$ en $S$ → $u$ antes en el reverso. ✓
  - Back edge: $v$ es ancestro de $u$ → forma ciclo $v \to \ldots \to u \to v$ — imposible en DAG.

En todos los casos validos (sin back edges), $u$ aparece antes que $v$ en el reverso de $S$ → es orden topologico. ✓

$(\Leftarrow)$ Si el reverso de $S$ es orden topologico, $D$ no tiene ciclos (un ciclo hace imposible cualquier orden topologico). $\square$

**Parte b) — Algoritmo $O(n+m)$:**

```
postorder = []
color[v] = BLANCO para todo v

DFS_topologico(u):
    color[u] = GRIS
    para cada arco u → w:
        si color[w] == GRIS:
            REPORTAR "ciclo detectado — D no es DAG"
        si color[w] == BLANCO:
            DFS_topologico(w)
    color[u] = NEGRO
    postorder.append(u)

DFS_topologico(v_raiz)

si no hay ciclo:
    retornar reverso(postorder)
```

Deteccion de ciclos: un arco $u \to w$ con $w$ en estado GRIS (activo en el stack) es un back edge → ciclo.

Complejidad: $O(n+m)$.

**Parte c) — Sin suposicion de vertice universal:**

Si no existe un unico vertice que alcance a todos, usar multiples raices DFS:

```
postorder = []
color[v] = BLANCO para todo v

para cada v en V(D):
    si color[v] == BLANCO:
        DFS_topologico(v)

retornar reverso(postorder)
```

El postorder global acumula los tiempos de cierre de todos los arboles DFS. El reverso sigue siendo un orden topologico valido si $D$ es DAG.

Complejidad: $O(n+m)$ (cada vertice y arista se visita una sola vez en total).

**Chuleta**

> 1. DFS con colores BLANCO/GRIS/NEGRO.
> 2. Arco a vertice GRIS = back edge = ciclo → no es DAG.
> 3. Al cerrar un vertice: agregarlo a postorder.
> 4. Reverso del postorder = orden topologico.
> 5. Sin vertice universal: DFS desde todos los BLANCOS.
> 6. $O(n+m)$.

**¿Aparece en parciales?** 🔴 Si — orden topologico via DFS es tema evaluado en 2P

---

### Ejercicio 19 — Consultas de Camino Unico

**Enunciado**

Dado un grafo $G$, responder consultas de la forma: dados dos vertices $v$ y $w$, ¿existe un unico camino entre $v$ y $w$?

Disenar un algoritmo que dado $G$ lo procese para generar una estructura de datos que responda cada consulta en $O(1)$ tiempo. El mejor algoritmo de preprocesamiento toma $O(n+m)$.

**Explicacion**

Existe un unico camino entre $v$ y $w$ $\Leftrightarrow$ $v$ y $w$ estan en la misma componente de un arbol (componente 2-arista-conexa degenerada a un arbol). Preprocesamiento: calcular las componentes biconexas (puentes y su estructura). Dos vertices tienen camino unico $\Leftrightarrow$ el unico camino entre ellos no pasa por ninguna arista que no sea puente → respuesta: están en la misma componente biconexas trivial.

Implementacion: contrae cada componente 2-arista-conexa a un nodo, formando un arbol (el arbol de bloques). Dos vertices tienen camino unico $\Leftrightarrow$ el camino entre ellos en el arbol de bloques consiste solo en aristas-puente. Esto puede responderse con LCA (Lowest Common Ancestor) en $O(1)$.

**Resolucion paso a paso**

**Caracterizacion:**

Existe un unico camino simple entre $v$ y $w$ en $G$ $\Leftrightarrow$ todo par de vertices en ese camino esta conectado unicamente por puentes. Equivalentemente: $v$ y $w$ estan en distintas componentes 2-arista-conexas (o la misma componente trivial), y todas las componentes en el camino del bridge tree son triviales (contienen un solo vertice).

**Preprocesamiento $O(n+m)$:**

1. DFS + $low[]$ para encontrar todos los puentes — $O(n+m)$.
2. Calcular componentes 2-arista-conexas (grupos de vertices sin puentes entre ellos). Asignar a cada vertice su componente: $\text{comp}[v]$.
3. Construir el bridge tree: supernodos = componentes; aristas = puentes.
4. Marcar cada componente como trivial (un solo vertice) o no-trivial.

**Estructura de datos para queries $O(1)$:**

Para responder "¿camino unico entre $v$ y $w$?" en $O(1)$:

- Si $\text{comp}[v] = \text{comp}[w]$: camino unico $\Leftrightarrow$ la componente es trivial (sin ciclos internos).
- Si $\text{comp}[v] \neq \text{comp}[w]$: el camino del bridge tree de $\text{comp}[v]$ a $\text{comp}[w]$ debe pasar solo por componentes triviales. Para responder esto en $O(1)$: preprocesar el bridge tree con Euler tour + sumas de prefijos para contar componentes no-triviales en el camino. Consulta: numero de componentes no-triviales en el camino = 0 $\Leftrightarrow$ camino unico.

Con preprocesamiento de LCA en el bridge tree ($O(n)$ usando DFS + sparse tables), se puede responder en $O(1)$ si el camino entre dos nodos del bridge tree contiene algun nodo no-trivial.

**Complejidad:** Preprocesamiento $O(n+m)$; query $O(1)$.

**Chuleta**

> 1. DFS + $low[]$ → puentes y componentes 2-arista-conexas — $O(n+m)$.
> 2. Construir bridge tree (componentes → supernodos, puentes → aristas).
> 3. Camino unico entre $v$ y $w$ $\Leftrightarrow$ todas las componentes en el camino del bridge tree son triviales (1 vertice).
> 4. Preprocesar bridge tree con Euler tour para respuesta $O(1)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 20 — Meta-Algoritmo de AGM (Boruvka)

**Enunciado**

Sea $F$ un bosque generador de un grafo $G$ pesado. Una arista $vw$ es segura si $v$ y $w$ pertenecen a distintos arboles de $F$. La arista $vw$ es candidata para el arbol $T$ de $F$ que contiene a $v$ cuando $vw$ es segura y $c(vw) \leq c(xy)$ para toda arista segura $xy$ con $x \in T$.

Meta-algoritmo: inicializar $F = (V(G), \emptyset)$; para $i = 1, \ldots, n-1$: agregar a $F$ una arista candidata de algun arbol $T$.

a) Demostrar que este meta-algoritmo retorna un AGM de $G$ (por induccion en $i$: $F_i$ es subgrafo de algun AGM).

b) Mostrar que Prim y Kruskal son casos particulares con politicas especificas de seleccion de la arista candidata. Concluir que a) prueba su correctitud en forma conjunta.

c) Implementar el algoritmo de Boruvka (insertar todas las aristas candidatas posibles en cada iteracion) en $O(m \log n)$.

**Explicacion**

a) Por induccion: en cada paso, la arista candidata puede ser cualquier arista minima que conecta una componente con el resto → por la propiedad del ciclo, es seguro agregarla.

b) Kruskal: considera todas las aristas en orden de peso, eligiendo la candidata de menor peso global. Prim: el arbol $T$ es siempre la componente actual que crece.

c) Boruvka: en cada iteracion, encontrar la arista minima saliente de cada componente (arista candidata) → $O(m)$ por iteracion. Despues de cada iteracion, la cantidad de componentes se reduce a la mitad → $O(\log n)$ iteraciones. Total: $O(m \log n)$.

**Resolucion paso a paso**

**Parte a) — Correctitud por induccion:**

**Invariante:** $F_i$ es subgrafo de algun AGM de $G$.

**Base:** $F_0 = \emptyset$ — subgrafo de cualquier AGM. ✓

**Paso inductivo:** Supongamos $F_i \subseteq T^*$ (AGM). El paso $i+1$ agrega una arista candidata $e = vw$: $v \in T$ (algun arbol del bosque), $w \notin T$, y $e$ es la arista de menor peso que sale de $T$.

*Caso $e \in T^*$:* $F_{i+1} = F_i \cup \{e\} \subseteq T^*$. ✓

*Caso $e \notin T^*$:* Agregar $e$ a $T^*$ crea un unico ciclo $C$. Existe $e' \in C \cap E(T^*) \setminus E(F_i)$ que cruza el corte entre $T$ y el resto (alguna arista de $C$ debe cruzar el corte; si fuera que todas las aristas de $C \cap T^*$ ya estan en $F_i$... pero como $F_i \subseteq T^*$ y $F_i$ es bosque, si $e$ crea un ciclo en $F_i \cup T^*$ habria una arista de $T^*$ no en $F_i$ que hace el camino de $v$ a $w$ en $F_i \cup T^*$, esa arista cruza el corte).

Como $e$ es candidata: $c(e) \leq c(e')$ (e es la arista minima saliente de $T$, y $e'$ tambien sale de $T$). Como $T^*$ es AGM: $c(e') \leq c(e)$ (si $c(e) < c(e')$, intercambiar $e'$ por $e$ en $T^*$ reduciria el peso — imposible). Luego $c(e) = c(e')$ y $T^{**} = T^* \cup \{e\} \setminus \{e'\}$ es tambien AGM. $F_{i+1} \subseteq T^{**}$. ✓

Por induccion, al agregar $n-1$ aristas (AGM tiene $n-1$ aristas y cada una es candidata), $F_{n-1}$ es un AGM. $\square$

**Parte b) — Prim y Kruskal como casos particulares:**

**Kruskal:** en cada iteracion, el arbol $T$ seleccionado es cualquier componente, y la arista candidata elegida es la de **menor peso global** entre todas las aristas seguras (de todas las componentes). Kruskal simplemente ordena todas las aristas y las agrega en orden — esto es equivalente a elegir siempre la arista candidata de minimo peso global.

**Prim:** se mantiene **un unico arbol** $T$ (la componente que crece). En cada iteracion, la arista candidata es la de menor peso entre las aristas seguras de ese arbol $T$. Prim no cambia de arbol — siempre expande el mismo.

La demostracion de a) prueba la correctitud de ambos en forma unificada: independientemente de como se elija la arista candidata (cualquier componente, cualquier arista minima saliente), el resultado es siempre un AGM.

**Parte c) — Boruvka $O(m \log n)$:**

```
Boruvka(G):
    F = (V, ∅)
    mientras F no sea arbol generador:
        candidata[T] = null para cada arbol T de F
        para cada arista e = vw:
            T_v = componente de v en F
            T_w = componente de w en F
            si T_v ≠ T_w:
                si c(e) < c(candidata[T_v]):
                    candidata[T_v] = e
                si c(e) < c(candidata[T_w]):
                    candidata[T_w] = e
        para cada arbol T de F:
            agregar candidata[T] a F  (con DSU para evitar duplicados)
    retornar F
```

**Analisis:**
- Cada iteracion: recorrer $m$ aristas para encontrar candidatas → $O(m)$.
- Cada iteracion: fusionar componentes con candidatas. Cada componente absorbe al menos otra — el numero de componentes se reduce al menos a la mitad. De $n$ componentes iniciales: $\lceil n/2 \rceil$, $\lceil n/4 \rceil$, ..., 1.
- Numero de iteraciones: $O(\log n)$.

Total: $O(m \log n)$.

Manejo de duplicados: si dos componentes $T_1$ y $T_2$ se eligen mutuamente (candidata de $T_1$ va a $T_2$ y viceversa), agregar solo una (con DSU). $O(\alpha(n))$ por operacion DSU — despreciable.

**Chuleta**

> **Meta-invariante:** $F_i \subseteq$ algun AGM. La arista candidata (minima saliente de una componente) siempre puede cambiarse por otra de igual peso en el AGM.
>
> **Prim:** un solo arbol creciendo. **Kruskal:** arista candidata global minima.
>
> **Boruvka:** todas las candidatas en paralelo, $O(m)$/iteracion, $O(\log n)$ iteraciones → $O(m \log n)$.

**¿Aparece en parciales?** 🔴 Si — correctitud de Prim/Kruskal por invariante es tema evaluado

## Ver tambien

- [[arboles_generadores_minimos_teoria]] — Prim, Kruskal, demos de correctitud
- [[arboles_generadores_minimos_practica]] — Ejercicios de clase: Viaje en peligro, Audifonos, Hormigas, DSU
- [[recorrido_en_grafos_guia]] — DFS/BFS de la misma guia (ej. 1–10)
