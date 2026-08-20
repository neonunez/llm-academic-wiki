---
nombre: Flujo en Redes — Clase Practica
parcial: 2P
tipo: practica
tema: flujo_en_redes
fuente: raw/clases/prac/12.prac_2P_flujo_slides.pdf + raw/clases/prac/12.prac_2P_flujos_handout.pdf
paginas_relacionadas:
  - "[[flujo_en_redes_teoria]]"
  - "[[flujo_en_redes_practica_pt2]]"
  - "[[flujo_en_redes_guia]]"
---

> Clase practica de Flujo en Redes (2do cuatrimestre 2025). Slides de Oriana Biasi, Dafne Yudcovsky y Luciana Skakovsky. Handout de 2C 2024 TM. Cubre: repaso de flujo, caminos disjuntos, corte minimo, matching bipartito, adaptadores (Enchufados), y sports elimination (Furbo).

---

## Patrones de este tema en parciales
> [[tipos_ejercicio/flujo_modelado]]

---

## Mini-Repaso de Flujo Maximo

### Definicion de flujo valido

Dada una red $G = \langle V, E, c \rangle$, para que $f : E \to \mathbb{N}$ sea un flujo valido debe cumplir:

$$\forall e \in E,\quad 0 \leq f(e) \leq c(e)$$

$$\forall v \in V \setminus \{s, t\},\quad \sum_{u \in N^-(v)} f(u \to v) = \sum_{u \in N^+(v)} f(v \to u)$$

El valor del flujo es:
$$|f| = \sum_{u \in N^+(s)} f(s \to u) = \sum_{u \in N^-(t)} f(u \to t)$$

### Aumento de flujo y optimalidad

Dado un flujo $x$ y un camino de aumento $P$ en la red residual $R(G,x)$, se define $\Delta(P) = \min_{ij \in P} r_{ij}$ y se actualiza:

$$\bar{x}_{ij} = \begin{cases} x_{ij} + \Delta(P) & \text{si } ij \in P \\ x_{ij} - \Delta(P) & \text{si } ji \in P \\ x_{ij} & \text{en otro caso} \end{cases}$$

**Proposicion:** $\bar{x}$ es un flujo factible con valor $F + \Delta(P)$.

**Teorema:** $x$ es flujo maximo $\Leftrightarrow$ no existe camino de aumento en $R(G,x)$.

**Teorema Max-Flow Min-Cut:** El valor del flujo maximo es igual a la capacidad del corte minimo.

### Ford-Fulkerson y Edmonds-Karp

- **Ford-Fulkerson:** BFS o DFS para camino de aumento. Complejidad: $O(nmU)$ donde $U = \max_{ij} u_{ij}$. Puede no detenerse si las capacidades son irracionales.
- **Edmonds-Karp:** Usa BFS para el camino mas corto. Complejidad: $O(nm^2)$ (garantizado, sin importar las capacidades).
- **Cota combinada:** $O(\min\{nm^2, \, mF\})$.

---

## Como demostrar correctitud en flujo

Dado un problema $P$ modelado como una red de flujo $N$, queremos probar que el flujo maximo $F$ coincide con la solucion optima. Se demuestra la doble implicacion:

$$\text{Existe un flujo valido de valor } F \;\Longleftrightarrow\; \text{Existe solucion al problema de tamano } F$$

**Ida** ($\Rightarrow$): dado un flujo valido de valor $F$, construir una solucion al problema de tamano $F$.

**Vuelta** ($\Leftarrow$): dada una solucion de tamano $F$, construir un flujo valido de valor $F$.

---

## Tecnicas de modelado

### Mas de un sumidero

Si hay un conjunto $Q$ de vertices que actuan como sumideros, agregar un nodo ficticio $t$ y conectar cada $q \in Q$ a $t$ con capacidad $\infty$.

### Limitar el flujo que pasa por un vertice

Si el vertice $v$ no puede recibir mas de $l$ unidades, duplicarlo:
- $v_{\text{in}}$: recibe todas las aristas entrantes
- $v_{\text{out}}$: envia todas las aristas salientes
- Arista interna: $v_{\text{in}} \to v_{\text{out}}$ con capacidad $l$

### Unificar capas

A veces las entidades concretas del problema no son suficientes como capas — se necesitan capas abstractas o combinaciones de entidades para capturar las restricciones.

---

## Ejercicios de clase

### Ejercicio 1 — ¡Vas a ser popular! (caminos disjuntos en aristas)

**Enunciado (Parte A)**
Ariana viaja todos los sabados de su casa (nodo $A$) a la de su amiga Cynthia (nodo $C$). Para que los fans de Ariana conozcan a Cynthia, quiere maximizar la cantidad de sabados que puede ir sin repetir ninguna calle. Se tiene un digrafo $D = (V, E)$.

**Explicacion**
Hay que maximizar la cantidad de caminos disjuntos en aristas entre $A$ y $C$. Esto se modela directamente como flujo maximo con capacidades unitarias.

**Resolucion paso a paso**

1. **Modelo:** usar el mismo digrafo $D = (V, E)$ como red de flujo. Asignar capacidad $1$ a todas las aristas (una arista solo puede ser usada en un camino).
2. **Unidad de flujo:** una unidad de flujo representa un camino de $A$ a $C$.
3. **Correctitud:** probar que $\text{max flujo} = K$ (cantidad de caminos disjuntos en aristas).

**Demostracion doble implicacion:**

*Vuelta* ($K$ caminos disjuntos $\Rightarrow$ flujo valido de valor $K$):
Sean $c_1, \ldots, c_K$ los caminos disjuntos. Definir:
$$f(e) = \begin{cases} 1 & \text{si } e \in c_i \text{ para algun } i \\ 0 & \text{en otro caso} \end{cases}$$
- Restriccion de capacidad: $f(e) \leq 1 = c(e)$. ✓
- Conservacion de flujo: cada nodo $v \neq A, C$ tiene la misma cantidad de aristas entrantes y salientes en los caminos (pues $v$ pertenece a ciertos caminos disjuntos). ✓
- Valor: $\sum_{w \in N^+(A)} f(w) = \#\{i \mid A \in c_i\} = K$. ✓

*Ida* (flujo valido de valor $F$ $\Rightarrow$ $F$ caminos disjuntos en aristas):
Como todas las capacidades son enteras, el flujo maximo es entero. Algoritmo inductivo:
1. Tomar una arista con $f(e) = 1$ que sale de $A$; seguir aristas con $f = 1$ hasta llegar a $C$: esto define un camino $p$.
2. Restar $1$ al flujo de todas las aristas de $p$ (el flujo queda valido con valor $F-1$).
3. Repetir $F$ veces. Cada camino obtenido no comparte aristas con los anteriores (por capacidad $1$).

**Complejidad:**
- Armar la red: $O(n + m)$.
- Edmonds-Karp: $O(\min\{nm^2, mF\}) = O(nm)$ (pues $F \leq n$, ya que no puede haber mas caminos disjuntos que vertices).
- Total: $O(nm)$.

**Chuleta**
> ¡Popular! A: max caminos disjuntos en aristas $A$-$C$ = max flow con cap $1$ en todas las aristas. Complejidad $O(nm)$ (cota $F \leq n$).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/flujo_modelado]]

---

### Ejercicio 1B — ¡Pero no tan popular como yo! (corte minimo en vertices)

**Enunciado**
Cynthia tambien se volvio popular. Los lideres del club de fans, Toto y Pepi, quieren interceptar a Cynthia colocando subditos en esquinas (vertices). Quieren minimizar la cantidad de subditos necesarios para que Cynthia no pueda llegar a la casa de Ariana sin pasar por uno. Nota: las casas de Ariana y Cynthia no pueden ser interceptadas.

**Explicacion**
Hay que calcular el corte minimo en **vertices** (no en aristas). El corte de aristas del modelo anterior no sirve directamente — hay que adaptar el modelo.

**Resolucion paso a paso**

1. **Dividir cada vertice interno** $v$ en dos nodos $v_{\text{in}}$ y $v_{\text{out}}$:
   - $v_{\text{in}}$ recibe todas las aristas entrantes
   - $v_{\text{out}}$ envia todas las aristas salientes
   - Arista interna: $v_{\text{in}} \to v_{\text{out}}$ con **capacidad $1$** (el subdito ocupa la esquina)
2. **Aristas de calles:** capacidad $\infty$ (el corte no debe pasar por ellas).
3. **Corte minimo:** las aristas del corte minimo pasan unicamente por las aristas internas (porque tienen capacidad finita). Estas aristas del corte minimo indican las esquinas donde colocar los subditos.

**Justificacion:** el corte minimo no es $\infty$ porque, tomando $S = N[s]$ (vecinos de $A$), el corte tiene capacidad $\deg(A)$ (finita). Luego el corte minimo solo usa aristas internas. Si Cynthia puede llegar a la casa de Ariana esquivando los subditos, no estaba en un corte.

**Recuperar las esquinas:** correr DFS desde $A$ en la red residual post-max-flow. La componente conexa desde $A$ forma el conjunto $S$. Las aristas saturadas que salen de $S$ hacia $V \setminus S$ corresponden a las esquinas (aristas internas $v_{\text{in}} \to v_{\text{out}}$) donde van los subditos.

**Complejidad:**
- Red: $n' = 2n - 2$ nodos, $m' = m + n - 2$ arcos (split de vertices internos).
- Flujo maximo: $F \leq \deg(A) < n$.
- EK: $O(\min\{nm^2, mF\}) = O(n(n+m))$ (cota $F < n$, $m' \approx m + n$).
- DFS para recuperar corte: $O(m + n)$.
- Total: $O(n(n+m))$.

**Chuleta**
> Corte minimo en vertices: split $v \to (v_\text{in}, v_\text{out})$ con cap $1$; aristas de calles cap $\infty$; max flow = min corte de vertices; DFS para recuperar subditos. Complejidad $O(n(n+m))$.

**¿Aparece en parciales?** ⚪ No (pero tecnica de split de vertices es frecuente)

---

### Ejercicio 2 — Hotel lleno (corte minimo en aristas)

**Enunciado**
Hilbert tiene un hotel en Tanti, Cordoba. Quiere colocar carteles en tramos de ruta para que ninguna persona pueda viajar de Santiago del Estero a Tanti sin ver un cartel. Cada tramo tiene un precio para colocar un cartel. Se quiere minimizar el costo total.

**Explicacion**
Minimizar el costo de aristas a "cortar" para desconectar el grafo entre origen y destino = corte minimo de aristas ponderado. Max-flow min-cut da la solucion directamente.

**Resolucion paso a paso**

1. **Modelo:** digrafo de rutas. Capacidad de cada arista = precio de poner un cartel en ese tramo.
2. **Corte:** un corte separa Santiago (fuente $s$) de Tanti (sumidero $t$). La capacidad del corte es la suma de precios de los tramos cortados.
3. **Optimalidad:** por max-flow min-cut, el costo minimo de carteles = flujo maximo en la red.

**Chuleta**
> Hotel lleno: min corte ponderado = max flow. Capacidad de arista = precio del cartel. Corte minimo da el conjunto de tramos a bloquear.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/flujo_modelado]]

---

### Ejercicio 3 — Matching de cardinalidad maxima (Tareas)

**Enunciado**
Hay una lista de personas $P$ y tareas $T$. Cada persona puede hacer una tarea y cada tarea solo puede ser hecha por una persona. Maximizar la cantidad de tareas realizadas.

**Resolucion paso a paso**

1. **Modelo por capas:** $s \to T \to P \to t$.
   - $s \to t_i$: capacidad $1$ por cada tarea $t_i \in T$.
   - $t_i \to p_j$: capacidad $1$ si la persona $p_j$ puede hacer la tarea $t_i$.
   - $p_j \to t$: capacidad $1$ por cada persona $p_j \in P$.
2. **Unidad de flujo:** una asignacion persona-tarea.
3. **Correctitud:**
   - $(\Rightarrow)$ Si hay un matching de tamano $k$, para cada par $(t, p)$ enviar 1 unidad por $s \to t \to p \to t$. Flujo valido de valor $k$.
   - $(\Leftarrow)$ Por el teorema de integridad, el flujo maximo entero. Cada arco $t \to p$ con flujo $1$ define una asignacion. Capacidades 1 aseguran que ninguna persona/tarea aparezca dos veces.
4. **Acotar:**
   - $n = O(|P| + |T|)$, $m = O(|P||T|)$, $F \leq \min(|P|, |T|)$.
5. **Complejidad:** $O(|P||T| \cdot \min(|P|, |T|))$.

**Chuleta**
> Matching bipartito: red $s \to T \to P \to t$, capacidades 1. Max flow = matching maximo. Complejidad $O(|P||T| \cdot \min(|P|,|T|))$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/flujo_modelado]]

---

### Ejercicio 4 — Enchufados (adaptadores de corriente)

**Enunciado**
En una cumbre internacional hay $k$ tipos de tomacorrientes. La sala tiene $t_i$ tomas de cada tipo $i$. Les periodistas traen $d_i$ dispositivos que necesitan un tomacorriente de tipo $i$. La fabrica vende adaptadores $(i \to j)$ en cantidad ilimitada. Los adaptadores se pueden encadenar. Minimizar la cantidad de dispositivos sin corriente. (Equivalente: maximizar los dispositivos conectados.)

**Resolucion paso a paso**

1. **Modelo:** red con $k$ tipos de tomacorrientes como nodos intermedios.
   - $s \to i$: capacidad $t_i$ (tomas disponibles de tipo $i$).
   - $i \to t$ (sumidero): capacidad $d_i$ (dispositivos que necesitan tipo $i$).
   - $i \to j$ (adaptador): capacidad $\infty$ (fabrican cantidad ilimitada).
2. **Unidad de flujo:** un dispositivo que logra conectarse (directamente o via cadena de adaptadores).
3. **Correctitud:**
   - $(\Rightarrow)$ Dado flujo $f$, cada unidad que llega a $t$ sigue un camino $s \to i_1 \to \cdots \to t$ = conexion valida via adaptadores.
   - $(\Leftarrow)$ Dada una asignacion valida, cada dispositivo conectado aporta una unidad de flujo a lo largo de su cadena.
4. **Acotar:** $n = k + 2$, $m = O(k^2)$ (adaptadores entre todos los tipos), $F \leq \sum_i d_i$.
5. **Complejidad EK:** $O(nm^2) = O((k+2) \cdot k^4) = O(k^5)$.

**Chuleta**
> Enchufados: nodos = tipos de tomacorrientes. $s \to i$ (cap $t_i$), $i \to t$ (cap $d_i$), $i \to j$ (cap $\infty$ si hay adaptador). Max flow = max dispositivos conectados. Complejidad $O(k^5)$.

**¿Aparece en parciales?** ⚪ No (modelado no estandar, pero tecnica frecuente)

---

### Ejercicio 5 — Furbo (sports elimination)

**Enunciado (Version A — empates posibles)**
Las Algoritmicas juegan un torneo. Ganar = 2 puntos, empatar = 1 punto, perder = 0 puntos. Saben los puntos actuales de cada equipo y las fechas restantes. Quieren saber si todavia pueden ganar (terminar primeras).

**Resolucion (Version A)**

Sea $A$ el equipo de Las Algoritmicas. Sea $p_A$ sus puntos actuales y $k$ las fechas que le restan a $A$.

1. **Condicion necesaria previa:** si el equipo $i \neq A$ ya tiene $p_i > p_A + 2k$, $A$ no puede ganar sin importar el resto.
2. **Definicion:** $p_{A}^{\max} = p_A + 2k$ (maximo de puntos que puede obtener $A$ ganando todo).
3. **Modelo de flujo:** para distribuir los puntos de las fechas restantes entre los equipos rivales (sin involucrar a $A$):
   - Nodo por **partido** $F_{(i,j)}$ entre cada par de equipos $i \neq j$ distintos de $A$. Capacidad de la arista $s \to F_{(i,j)}$: cantidad de puntos disponibles en ese partido (2 puntos).
   - Nodo por **equipo** $E_i$ ($i \neq A$). Aristas $F_{(i,j)} \to E_i$ y $F_{(i,j)} \to E_j$ sin restriccion (los puntos van a uno u otro).
   - Arista $E_i \to t$ con capacidad $p_{A}^{\max} - 1 - p_i$ (maximo que puede acumular $E_i$ sin superar a $A$).
4. **Respuesta:** $A$ puede ganar $\Leftrightarrow$ el flujo maximo satura todas las aristas $s \to F_{(i,j)}$ (todos los puntos se pueden distribuir sin que ningun equipo supere a $A$).

**Modelo (Version B — solo victoria o derrota, 3 o 0 puntos)**
Analogo pero una unidad de flujo = **el equipo $E_i$ gana el partido $F_{(i,j)}$** (no los puntos). Asi se evitan flujos de valores 1 o 2 que no tendrian significado fisico.

**Chuleta**
> Furbo: nodos partidos $F_{(i,j)}$ + nodos equipos $E_i$. $s \to F_{(i,j)}$ (cap = puntos del partido), $F \to E_i$ o $E_j$ (sin restriccion), $E_i \to t$ (cap = max aceptable para $E_i$). $A$ gana si flujo maximo satura todo $s \to F$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/flujo_modelado]]

---

## Ver tambien

- [[flujo_en_redes_teoria]] · [[flujo_en_redes_practica_pt2]]
- [[recorrido_en_grafos_practica]] — para grafos implicitos y BFS/DFS auxiliares
- [[flujo_en_redes_guia]] — Guia de ejercicios del tema
