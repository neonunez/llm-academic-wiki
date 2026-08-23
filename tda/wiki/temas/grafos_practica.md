---
nombre: Grafos — Clase Practica
parcial: 1P
programa: 2C_2026
tipo: practica
tema: grafos
fuentes:
  vigente: []
  historico:
    - raw/clases/prac/7.prac_2P_demostracion_sobre_grafos.pdf
    - raw/clases/prac/7.prac_2P_representacion_de_grafos.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[grafos_teoria]]"
  - "[[arboles_teoria]]"
  - "[[recorrido_en_grafos_practica]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

## Patrones de este tema en parciales
> [[tipos_ejercicio/grafos_demostraciones]]

---

## Parte A — Representacion de Grafos

### Notacion

- $n := |V|$ — cantidad de nodos
- $m := |E|$ — cantidad de aristas
- $N(v)$ — vecindario del nodo $v$
- $d(v) := |N(v)|$ — grado del nodo $v$

Asumimos nodos numerados $1$ a $n$ (si no, se mapean).

### Matriz de adyacencia

Matriz $M$ de $n \times n$: $M[i][j] = M[j][i] = 1$ si $(i,j) \in E$, 0 si no. Simetrica para grafos no dirigidos.

| Operacion | Complejidad |
|-----------|------------|
| Inicializar | $\Theta(n^2)$ |
| tieneArista(v, w) | $\Theta(1)$ |
| agregarArista(v, w) | $\Theta(1)$ |
| eliminarArista(v, w) | $\Theta(1)$ |
| vecindario(v) | $\Theta(n)$ |

**Espacio:** $\Theta(n^2)$. Tip: la matriz es simetrica, se puede guardar solo una mitad.

### Lista de adyacencia

Vector de $n$ posiciones, cada una con un puntero a la lista de vecinos.

| Operacion | Complejidad |
|-----------|------------|
| Inicializar | $\Theta(n + m)$ |
| tieneArista(v, w) | $O(d(v)) \subseteq O(n)$ |
| agregarArista(v, w) | $O(1)$ |
| eliminarArista(v, w) | $O(d(v)) \subseteq O(n)$ |
| vecindario(v) | $\Theta(1)$ (devuelve referencia) |

**Espacio:** $\Theta(n + m)$.

### Alternativas para los conjuntos de adyacencia

Se puede reemplazar la lista por otra estructura:

| Estructura | tieneArista | agregarArista | eliminarArista |
|-----------|-------------|---------------|----------------|
| Lista | $O(d(v))$ | $O(1)$ | $O(d(v))$ |
| Tabla de hash | $O(1)$ amortizado | $O(1)$ amortizado | $O(1)$ amortizado |
| AVL | $O(\log d(v))$ | $O(\log d(v))$ | $O(\log d(v))$ |
| Vector ordenado | $O(\log d(v))$ | $O(d(v))$ | $O(d(v))$ |

### Grafos implicitos

No hace falta representar explicitamente en memoria. Basta poder definir el conjunto de nodos y, dado un nodo, su vecindad. Ejemplos:
- Tableros o estructuras regulares (grillas)
- Espacio de soluciones en backtracking (cada estado es un nodo, las transiciones son aristas)

---

## Parte B — Demostraciones sobre Grafos

### Ejercicio 1 — Misma cantidad de amigos (Principio del Palomar)

**Enunciado**
Probar que en todo grupo de dos o mas personas hay por lo menos dos de ellas que tienen la misma cantidad de amigos en el grupo.

**Explicacion**
Modelar como grafo: nodos = personas, aristas = amistades. Hay que demostrar que $\forall G$ con $|V| = n \geq 2$, $\exists v_1 \neq v_2$ tales que $d(v_1) = d(v_2)$.

**Resolucion paso a paso**

1. Para todo grafo: $0 \leq d(v) \leq n-1$ — *por que: grado minimo 0 (aislado), maximo $n-1$ (conectado a todos)*
2. No pueden coexistir un nodo de grado 0 y otro de grado $n-1$ — *por que: si alguien esta conectado a todos, necesariamente esta conectado al supuesto aislado, contradiccion*
3. Entonces los grados toman valores en uno de estos rangos:
   - $\{0, 1, \ldots, n-2\}$ (puede haber alguien sin amigos)
   - $\{1, 2, \ldots, n-1\}$ (puede haber un amigo de todos)
4. En ambos casos hay $n-1$ valores posibles para $n$ nodos
5. Por el **Principio del Palomar**: hay al menos dos nodos con el mismo grado. $\square$

**Chuleta**
> 1. Grados van de 0 a $n-1$ → 2. Grado 0 y $n-1$ no coexisten → 3. A lo sumo $n-1$ valores distintos para $n$ nodos → 4. Palomar: dos comparten grado

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 2 — CicloCompartido (dos caminos distintos implican ciclo)

**Enunciado**
Sean $P$ y $Q$ dos caminos distintos de un grafo $G$ que unen un vertice $v$ con otro $w$. Demostrar en forma directa que $G$ tiene un ciclo cuyas aristas pertenecen a $P$ o $Q$.

**Explicacion**
Demostracion constructiva: como $P$ y $Q$ son distintos pero comparten extremos, en algun punto se separan y luego se reencuentran — eso forma un ciclo.

**Resolucion paso a paso**

1. Escribir $P = p_1, \ldots, p_k$ y $Q = q_1, \ldots, q_r$ con $p_1 = q_1 = v$ y $p_k = q_r = w$
2. Sea $i$ el primer indice donde se separan: $\forall l < i$, $p_l = q_l$, pero $p_i \neq q_i$ — *por que: son distintos pero arrancan igual, en algun momento difieren*
3. Sean $j_P$ y $j_Q$ los primeros indices $\geq i$ donde se reencuentran: $p_{j_P} = q_{j_Q}$ — *por que: ambos terminan en $w$, eventualmente convergen*
4. Construir el ciclo: $p_{i-1}, p_i, p_{i+1}, \ldots, p_{j_P} = q_{j_Q}, q_{j_Q-1}, \ldots, q_i, q_{i-1} = p_{i-1}$
5. **Verificar que tiene $\geq 3$ nodos:** si $i = j_P$ y $i = j_Q$ entonces $p_i = p_{j_P} = q_{j_Q} = q_i$, pero tomamos $i$ tal que $p_i \neq q_i$, absurdo. Entonces al menos uno de $j_P > i$ o $j_Q > i$, garantizando $\geq 3$ nodos. $\square$

**Chuleta**
> 1. Encontrar primer punto de separacion $i$ → 2. Encontrar primer reencuentro $j_P, j_Q$ → 3. Ciclo = subcamino de $P$ + subcamino inverso de $Q$ → 4. Verificar $\geq 3$ nodos por contradiccion

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — Todo conexo con $n \geq 2$ tiene dos vertices no-articulacion

**Enunciado**
Todo $G_n$ ($n \geq 2$) conexo tiene al menos dos vertices distintos $v_1, v_2$ tal que $G \setminus \{v_1\}$ y $G \setminus \{v_2\}$ son conexos.

**Explicacion**
Demostracion por induccion fuerte en $n = |V(G)|$. Si no todos los vertices son articulacion, trivial. Si alguno lo es, al sacarlo quedan componentes conexas — aplicar HI a cada componente aumentada.

**Resolucion paso a paso — Induccion en $|V(G)| = n$**

$P(n)$: si un grafo $G_n$ con $n \geq 2$ es conexo, entonces $\exists v_1 \neq v_2 \in V(G)$ tal que $G \setminus \{v_1\}$ y $G \setminus \{v_2\}$ son conexos.

**Caso base** ($n = 2$): Dos nodos conectados. Sacar cualquiera deja un nodo solo (conexo). Ambos cumplen. $\square$

**Paso inductivo** ($n + 1$, con $n \geq 2$): Sea $G_{n+1}$ conexo.
- Si $\forall v \in V(G_{n+1})$, $G_{n+1} \setminus \{v\}$ es conexo: se cumple trivialmente.
- Si $\exists v$ punto de articulacion: $G \setminus \{v\}$ tiene componentes conexas $C_1, C_2, \ldots, C_k$ ($k \geq 2$).
  - Definir $C_i' = C_i \cup \{v\}$. Cada $C_i'$ es conexo con $|V(C_i')| < n+1$ y $\geq 2$ vertices.
  - Por HI, $C_1'$ tiene dos vertices $v_1, v_2$ cuya remocion la deja conexa. Alguno es $\neq v$ (WLOG $v_1 \neq v$). Luego $G_{n+1} \setminus \{v_1\}$ es conexo — *por que: $v$ sigue conectando todas las componentes, y $C_1' \setminus \{v_1\}$ sigue siendo conexa por HI*
  - Repetir para $C_2'$: obtener $v_3 \neq v$ tal que $G_{n+1} \setminus \{v_3\}$ es conexo.
  - $v_1$ y $v_3$ son los dos vertices buscados. $\square$

**Chuleta**
> 1. Induccion en $n$ → 2. Si todos son no-articulacion, trivial → 3. Si hay articulacion $v$: tomar componentes $C_i$, formar $C_i' = C_i \cup \{v\}$ → 4. HI en $C_1'$ y $C_2'$: cada una aporta un vertice $\neq v$ cuya remocion no desconecta $G$

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — Suma de grados = $2|E|$ (Handshaking Lemma)

**Enunciado**
Demostrar que $\sum_{v \in V(G)} d(v) = 2|E(G)|$.

**Explicacion**
Induccion sobre $m = |E(G)|$. Sacando una arista se reduce $m$ y se ajustan exactamente dos grados en 1.

**Resolucion paso a paso — Induccion en $|E(G)| = m$**

Notacion: $d_G(v)$ = grado de $v$ en el grafo $G$.

**Caso base** ($m = 0$): Solo nodos aislados. $d(v) = 0$ para todo $v$. Suma = $0 = 2 \cdot 0$. $\square$

**Paso inductivo:** HI: para todo $G'$ con $|E(G')| = m-1$, $\sum_{v} d_{G'}(v) = 2(m-1)$.

Sea $e = (v_1, v_2) \in E(G)$ una arista cualquiera. Definir $G' = (V(G), E(G) \setminus \{e\})$.

- $V(G) = V(G')$, $|E(G')| = m - 1$
- $d_G(v) = d_{G'}(v)$ para $v \notin \{v_1, v_2\}$
- $d_G(v_1) = d_{G'}(v_1) + 1$, $d_G(v_2) = d_{G'}(v_2) + 1$

$$\sum_{v \in V(G)} d_G(v) = \sum_{v \in V(G') \setminus \{v_1,v_2\}} d_{G'}(v) + d_{G'}(v_1) + 1 + d_{G'}(v_2) + 1 = \sum_{v \in V(G')} d_{G'}(v) + 2 = 2(m-1) + 2 = 2m \quad \square$$

**Chuleta**
> 1. Induccion en $m = |E|$ → 2. Sacar una arista $e = (v_1, v_2)$ → 3. Solo cambian $d(v_1)$ y $d(v_2)$ en 1 cada uno → 4. Suma = HI + 2

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 — Caminata impar cerrada implica ciclo impar

**Enunciado**
Dado un grafo $G$, si existe una caminata de longitud impar que empieza y termina en el mismo vertice, entonces hay un ciclo (simple) impar.

**Explicacion**
Induccion en la longitud $l$ de la caminata. Si no repite vertices, ya es ciclo impar. Si repite, se parte en dos caminatas cerradas — una de ellas es impar y mas corta, aplicar HI.

**Resolucion paso a paso — Induccion en $l$ (longitud de caminata, impar)**

$P(l)$: si $G$ tiene una caminata cerrada de longitud $l$ impar, entonces $G$ tiene un ciclo impar.

**Caso base** ($l = 1$): Una arista que sale y vuelve al mismo vertice es un loop → ciclo. (Si no hay loops, $l = 3$: si vamos y volvemos por la misma arista es par, asi que en alguna arista volvemos por otro camino, formando un ciclo de longitud 3.) $\square$

**Paso inductivo:** Sea $W$ una caminata cerrada de longitud $l$ impar.
- Si $W$ no repite vertices → es un ciclo impar. Listo.
- Si $W$ repite un vertice $v$ en el medio → se parte en dos caminatas cerradas en $v$:
  - $W_1$: desde $v$ hasta la primera repeticion de $v$
  - $W_2$: el resto
  - $l = |W_1| + |W_2|$ con $l$ impar → una de $W_1, W_2$ tiene longitud impar — *por que: si ambas fueran pares, la suma seria par, pero $l$ es impar*
  - La caminata impar tiene longitud $< l$ — *por que: ambas son estrictamente mas cortas que $W$*
  - Por HI: contiene un ciclo impar. $\square$

**Chuleta**
> 1. Induccion en longitud $l$ de caminata cerrada impar → 2. Sin repeticion de vertices: ya es ciclo → 3. Con repeticion: partir en dos caminatas cerradas, una impar y mas corta → 4. HI

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 6 — Demostracion incorrecta: grado positivo no implica conexo

**Enunciado**
"Si todos los vertices de un grafo tienen grado mayor a cero, entonces el grafo es conexo." — FALSO.

**Contraejemplo:** Dos aristas disjuntas (ej: $K_2 \cup K_2$) — todos tienen grado 1 pero no es conexo.

**Explicacion**
Ejemplo pedagogico de un error clasico en induccion sobre grafos. Se presenta la demostracion erronea y se analiza el error.

**Demostracion erronea (por induccion en $n = |V|$):**

$P(n)$: si todos los vertices de un grafo con $n$ vertices tienen grado $> 0$, entonces es conexo.

- *Base:* $P(1)$: vacuamente cierto. $P(2)$: unico grafo con grados positivos es $K_2$, conexo. ✓
- *Paso:* Tomar $G_n$ con todos grados positivos. Por HI, $G_n$ es conexo. Agregar vertice $x$ con $d(x) > 0$, entonces $\exists y : (x,y) \in E$. Para cualquier $z$, existe camino $x \to y$ (por arista) y $y \to z$ (por conexidad de $G_n$). ✓?

**El error:**
Lo demostrado es que todo grafo de $n+1$ vertices **construido agregando un vertice con grado positivo a un grafo conexo de $n$ vertices** es conexo. Pero **no todo grafo de $n+1$ vertices con grados positivos se puede construir asi**. Ejemplo: $K_2 \cup K_2$ (4 nodos, todos grado 1) no se obtiene agregando un nodo a un grafo conexo de 3 nodos con todos grados positivos.

**Esquema correcto para induccion en grafos:**
1. Considerar un grafo **arbitrario** de $n+1$ vertices que cumpla la hipotesis
2. **Remover** un vertice y aplicar HI (verificando que se pueda aplicar)
3. **Agregar** nuevamente el vertice y comprobar $P(n+1)$

**Chuleta**
> Error clasico: induccion "constructiva" (agregar nodo) no cubre todos los grafos → Solucion: induccion "destructiva" (remover nodo de grafo arbitrario y verificar que HI aplique)

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/grafos_demostraciones]]

---

## Ver tambien

- [[grafos_teoria]] — definiciones, grado, Handshaking, caminos, conexidad, bipartitos, isomorfismo, representacion (matriz adyacencia)
- [[arboles_teoria]] — arboles, BFS, DFS, timestamps, clasificacion de arcos
- [[recorrido_en_grafos_practica]] — DFS, BFS, conectividad, bipartito, puentes, orden topologico
- [[definiciones_y_demostraciones_teoria]] — estrategias de demostracion (induccion, contradiccion, contrarreciproco, palomar)
