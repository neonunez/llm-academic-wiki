---
nombre: Flujo en Redes — Clase Practica Parte 2
parcial: 2P
tipo: practica
tema: flujo_en_redes
fuente: raw/clases/prac/13.prac_2P_flujo_parte2.pdf
paginas_relacionadas:
  - "[[flujo_en_redes_teoria]]"
  - "[[flujo_en_redes_practica]]"
---

> Clase practica de Flujo en Redes — Parte 2 (2do cuatrimestre 2025). Basado en diapositivas de Oriana Biasi y Dafne Yudcovsky. Cubre tres ejercicios complejos: Hospital (scheduling multi-restriccion), Down Went the Titanic (grilla con movimiento de personas) y Satelite (maximizar transferencia de datos).

---

## Patrones de este tema en parciales
> [[tipos_ejercicio/flujo_modelado]] · [[tipos_ejercicio/flujo_modelado]]
(se completa despues de analizar parciales)

---

## Workflow para resolver ejercicios de flujo (5 pasos)

1. **Modelo de red:** definir nodos, aristas y capacidades.
2. **Semantica de la unidad de flujo:** aclarar que representa 1 unidad de flujo.
3. **Conexion modelo-problema:** demostrar $\text{solucion valida de tamano } N \Leftrightarrow \text{flujo valido de valor } N$.
4. **Acotar:** nodos $n$, aristas $m$, y flujo maximo $F$ en terminos del input.
5. **Calcular complejidad:** elegir $O(\min\{mF, nm^2\})$ con las cotas del paso 4.

---

## Ejercicios de clase

### Ejercicio 1 — Hospital (scheduling de medicos en feriados)

**Enunciado**
Un hospital tiene $K$ periodos de feriados. El periodo $k$ consiste de $D_k = \{d_{k,1}, \ldots, d_{k,r}\}$ dias feriados contiguos. El hospital tiene $M$ medicos; el medico $i$ tiene un conjunto $S_i$ de dias disponibles. Se quiere asignar medicos a dias feriados cumpliendo:
- Nadie trabaja mas de $C$ dias en total.
- Cada dia tiene exactamente un medico asignado.
- Un medico tiene como maximo un dia asignado dentro de cada periodo $D_k$.

Modelar como flujo maximo; justificar; dar complejidad.

**Explicacion**
Hay multiples restricciones que mezclan medicos, periodos y dias. La clave es agregar una **capa intermedia de nodos periodo por medico** para separar las restricciones.

**Resolucion — Paso 1: Modelo**

Capas de la red:
- **Fuente $s$** → **Medicos** $M_i$ (una arista por medico, capacidad $C$): limita dias totales asignados.
- **Medicos** $M_i$ → **Periodos** $(M_i, k)$ (una arista por par medico-periodo, capacidad $1$): limita a un dia por periodo por medico.
  - *(Ojo: NO un nodo periodo compartido — eso perderia la informacion de que dias puede hacer cada medico. Hay que tener un nodo $(M_i, k)$ por cada par medico-periodo.)*
- **Periodos** $(M_i, k)$ → **Dias** $d_{k,j}$ (solo los dias disponibles para $M_i$ en $D_k$, capacidad $1$).
- **Dias** $d_{k,j}$ → **Sumidero $t$** (capacidad $1$): cada dia tiene un solo medico.

**Resolucion — Paso 2: Semantica**

Una unidad de flujo representa un dia feriado asignado a un medico.

**Resolucion — Paso 3: Conexion modelo-problema**

*Probar:* "Existe una asignacion de medicos a dias de tamano $N$" $\Leftrightarrow$ "Existe un flujo valido de valor $N$".

$(\Rightarrow)$ Dada una asignacion valida, para cada medico $i$ que trabaja el dia $d_{k,j}$, enviar 1 unidad por el camino $s \to M_i \to (M_i,k) \to d_{k,j} \to t$. Verificar capacidades:
- $s \to M_i$: medico $i$ tiene a lo sumo $C$ dias asignados. ✓
- $M_i \to (M_i,k)$: medico $i$ tiene a lo sumo un dia asignado por periodo. ✓
- $d_{k,j} \to t$: solo un medico por dia. ✓

$(\Leftarrow)$ Por el teorema de integridad, el flujo maximo entero. Si hay una unidad de flujo por el arco $(M_i,k) \to d_{k,j}$, asignar el medico $i$ al dia $d_{k,j}$. Las capacidades garantizan que se cumplen todas las restricciones. El problema tiene solucion si y solo si el flujo maximo es igual a la cantidad total de dias feriados.

**Resolucion — Paso 4: Acotar**

Sea $D = \sum_k |D_k|$ (total de dias feriados) y $K$ el numero de periodos.

- **Nodos:** $M$ medicos + $M \cdot K$ nodos periodo (peor caso) + $D$ dias + $s$ + $t$ = $O(MK + D) = O(MD)$ (usando $K \leq D$).
- **Aristas:** $M$ (de $s$) + $MK$ (medicos a periodos) + $MD$ (periodos a dias, peor caso todos disponibles) + $D$ (a $t$) = $O(MD)$.
- **Flujo maximo:** $D$ (un medico por dia, $D$ dias en total).

**Resolucion — Paso 5: Complejidad**

$$O(\min\{mF, nm^2\}) = O(\min\{MD \cdot D, MD \cdot (MD)^2\}) = O(\min\{MD^2, M^3D^3\}) = O(MD^2)$$

**Chuleta**
> Hospital: $s \to M_i$ (cap $C$) $\to (M_i,k)$ (cap $1$) $\to d_{k,j}$ (cap $1$) $\to t$. Clave: nodo periodo por medico, no compartido. Nodos $O(MD)$, aristas $O(MD)$, flujo $D$, complejidad $O(MD^2)$. Tiene solucion $\Leftrightarrow$ flujo maximo $= D$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/flujo_modelado]]

---

### Ejercicio 2 — Down Went the Titanic (grilla con movimiento de personas)

**Enunciado**
El mar se representa como una grilla rectangular. Cada casilla puede ser:
- **Persona flotando sobre hielo:** el hielo se derrite al saltar; no reutilizable.
- **Agua helada:** mortal, no se puede transitar.
- **Hielo flotante:** una persona puede pararse, pero se hunde al saltar. No reutilizable.
- **Iceberg:** puede albergar una sola persona en cada momento, no se hunde, pero la persona no puede quedarse indefinidamente.
- **Madera:** puede albergar hasta $P$ personas indefinidamente.

Solo se puede mover entre casillas vecinas (arriba, abajo, izquierda, derecha). Calcular la maxima cantidad de personas que pueden salvarse (llegar a un trozo de madera).

**Explicacion**
Modelar los movimientos como flujo. Las restricciones de uso unico (hielo) se capturan con split de vertices; la restriccion de no-simultaneidad en icebergs se resuelve en la interpretacion del flujo.

**Resolucion — Paso 1: Modelo**

Nodos:
- Un nodo por **persona** (conectado a $s$).
- Un nodo por cada casilla de **hielo flotante** (split en $h_\text{in}$ y $h_\text{out}$ con cap $1$, pues solo se usa una vez).
- Un nodo por cada casilla de **iceberg** (sin split; su restriccion es de no-simultaneidad, manejada en el paso 3).
- Un nodo por cada casilla de **madera** (conectado a $t$ con cap $P$).
- No se modelan casillas de agua.

Aristas:
- $s \to \text{persona}_i$: capacidad $1$.
- Entre casillas vecinas (que no sean agua): aristas bidireccionales con capacidad $\infty$, excepto las aristas internas de los hielos (cap $1$).
- Aristas desde maderas hacia otros trozos son necesarias (una persona puede transitar por madera sin quedarse): modelar correctamente para no bloquear caminos alternativos.
- $\text{madera}_j \to t$: capacidad $P$.

**Resolucion — Paso 2: Semantica**

Una unidad de flujo representa el recorrido valido de una persona desde su posicion inicial hasta un trozo de madera con capacidad.

**Resolucion — Paso 3: Conexion modelo-problema**

$(\Rightarrow)$ Dada una forma de salvar $N$ personas, para cada persona $i$ que se salva, enviar 1 unidad por el camino que sigue su recorrido en la grilla. Verificar capacidades:
- $s \to \text{persona}_i$: flujo $\leq 1$. ✓
- Hielos duplicados: cada uno se usa a lo sumo una vez. ✓
- $\text{madera}_j \to t$: a lo sumo $P$ personas en la misma madera. ✓

$(\Leftarrow)$ Dado un flujo entero de valor $N$, asignar caminos a personas **secuencialmente** (una persona se mueve a la vez):
- Para cada persona, seguir el camino dado por las aristas con flujo $> 0$.
- Al llegar a un trozo de madera, quedarse si la unica arista con flujo que sale va a $t$ (no hay otras personas que necesiten transitar por esa madera).
- Al terminar, restar 1 a cada arista del camino recorrido.
- La restriccion del iceberg (no-simultaneidad) se satisface porque las personas se mueven en orden.

**Clave:** al asignar el trozo de madera final a una persona, elegir solo cuando la unica arista con flujo que sale va a $t$ (y no hacia otros trozos de iceberg), para que los demas puedan seguir sus caminos. Esto evita que Rose y Jack terminen en la misma madera si no hay espacio.

**Resolucion — Paso 4: Acotar**

Sea $C$ la cantidad total de casillas del tablero.

- **Nodos:** cada casilla se representa con $0$ (agua), $1$ (personas, iceberg, madera) o $2$ (hielo — split) nodos. Peor caso: $O(2C) = O(C)$.
- **Aristas:** $O(C)$ (de $s$) + $O(C)$ (hacia $t$) + $O(4C)$ (entre vecinos, 4 vecinos por casilla) + $O(C)$ (aristas de split de hielos) = $O(C)$.
- **Flujo maximo:** suma de capacidades de aristas que salen de $s$ = a lo sumo $C$ personas = $O(C)$.

**Resolucion — Paso 5: Complejidad**

$$O(\min\{mF, nm^2\}) = O(\min\{C^2, C^3\}) = O(C^2)$$

**Chuleta**
> Titanic: personas $\to$ hielos (split cap $1$) $\to$ icebergs $\to$ maderas $\to t$ (cap $P$). Hielo duplicado para uso unico. Iceberg: no-simultaneidad resuelta con movimiento secuencial en la interpretacion. Nodos/aristas/flujo $O(C)$. Complejidad $O(C^2)$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/flujo_modelado]]

---

### Ejercicio 3 — Satelite (maximizar transferencia de datos)

**Enunciado**
Un satelite necesita mandar datos (megabytes) a la Tierra. Tiene $N$ ventanas de tiempo y $R$ sensores. Cada sensor tiene una cola asignada con capacidad $c_q$ megabytes. El sensor $r$ carga $a_{rt}$ datos a su cola en la ventana $t$ (antes del inicio de esa ventana de envio). En cada ventana $t$ se pueden mandar hasta $d_t$ megabytes entre todas las colas. Si en una ventana las colas no mandan todo, guardan los datos para la siguiente ventana. Maximizar los megabytes transferidos al cabo de las $N$ ventanas.

**Explicacion**
Ejercicio de modelado avanzado (enunciado planteado al final de la clase). Combina ventanas de tiempo, colas con capacidad, y un limite de envio por ventana — hay que pensar en capas temporales.

**Resolucion — Paso 1: Modelo**

**Idea central:** expandir la red en el tiempo. Cada par (sensor/cola, ventana) es un nodo. Los datos se acumulan entre ventanas (aristas de "carry-over") y se envian a la Tierra por un sumidero por ventana.

Capas de la red (para $r = 1, \ldots, R$ y $t = 1, \ldots, N$):

**Nodos:**
- **Fuente $s$**
- **Nodo de carga** $\text{load}_{r,t}$: representa los $a_{rt}$ MB que el sensor $r$ produce en la ventana $t$.
- **Cola** de sensor $r$ en ventana $t$, modelada con split de vertice:
  - $q_{r,t}^{\text{in}}$ y $q_{r,t}^{\text{out}}$, con arista interna $q_{r,t}^{\text{in}} \to q_{r,t}^{\text{out}}$ de capacidad $c_q$ (la cola tiene capacidad $c_q$ MB en cada instante).
- **Nodo de ventana** $w_t$: agrega el envio de todas las colas en la ventana $t$.
- **Sumidero $t$** (un unico nodo $t$).

**Aristas:**

1. **Produccion de datos:**
   $s \to \text{load}_{r,t}$ con capacidad $a_{rt}$, para cada $r, t$.
   *(Limita los datos que ingresan a la cola de $r$ en la ventana $t$ a exactamente lo producido.)*

2. **Ingreso a la cola:**
   $\text{load}_{r,t} \to q_{r,t}^{\text{in}}$ con capacidad $a_{rt}$.

3. **Capacidad de la cola (split):**
   $q_{r,t}^{\text{in}} \to q_{r,t}^{\text{out}}$ con capacidad $c_q$.
   *(El split asegura que en cualquier ventana la cola nunca supera $c_q$ MB.)*

4. **Carry-over (datos no enviados pasan a la siguiente ventana):**
   $q_{r,t}^{\text{out}} \to q_{r,t+1}^{\text{in}}$ con capacidad $c_q$, para $t = 1, \ldots, N-1$.
   *(Los datos que no se enviaron en la ventana $t$ quedan disponibles en la ventana $t+1$, sin exceder la capacidad de la cola.)*

5. **Envio desde cola hacia ventana:**
   $q_{r,t}^{\text{out}} \to w_t$ con capacidad $c_q$, para cada $r, t$.

6. **Limite de envio por ventana:**
   $w_t \to t_{\text{sink}}$ con capacidad $d_t$.
   *(Solo se pueden enviar $d_t$ MB en total desde todas las colas en la ventana $t$.)*

⚠️ Verificar — En el modelo anterior, un mismo nodo $q_{r,t}^{\text{out}}$ tiene dos salidas: carry-over y envio. El flujo total que sale de $q_{r,t}^{\text{out}}$ esta acotado por la arista interna (cap $c_q$), lo que implica que la suma de "lo que se envia" + "lo que se lleva" $\leq c_q$. Esto es correcto: la cola no puede enviar mas de lo que almacena.

**Resolucion — Paso 2: Semantica**

Una unidad de flujo representa 1 megabyte de datos transferido a la Tierra.

**Resolucion — Paso 3: Conexion modelo-problema**

*Probar:* "Existe una politica de envio que transfiere $F$ MB" $\Leftrightarrow$ "Existe un flujo valido de valor $F$".

$(\Rightarrow)$ Dada una politica valida:
- Para cada MB producido por sensor $r$ en ventana $t$: enviar 1 unidad por $s \to \text{load}_{r,t} \to q_{r,t}^{\text{in}} \to q_{r,t}^{\text{out}}$.
- Si ese MB se envia en la ventana $t$: continuar por $q_{r,t}^{\text{out}} \to w_t \to t_{\text{sink}}$.
- Si se lleva a la siguiente ventana: continuar por $q_{r,t}^{\text{out}} \to q_{r,t+1}^{\text{in}} \to \ldots$ hasta que se envie.

Verificacion de capacidades:
- $s \to \text{load}_{r,t}$: a lo sumo $a_{rt}$ MB producidos. ✓
- Arista interna del split: la cola nunca supera $c_q$ MB. ✓
- Carry-over: los datos transportados entre ventanas no superan $c_q$. ✓
- $w_t \to t_{\text{sink}}$: en la ventana $t$ se envian a lo sumo $d_t$ MB en total. ✓

$(\Leftarrow)$ Por el teorema de integridad, el flujo maximo es entero. Dado un flujo entero de valor $F$:
- Cada unidad de flujo que llega a $t_{\text{sink}}$ corresponde a 1 MB transferido.
- Para cada $r, t$: el flujo por la arista $\text{load}_{r,t} \to q_{r,t}^{\text{in}}$ no supera $a_{rt}$ (datos disponibles). ✓
- El flujo por la arista interna del split no supera $c_q$ (capacidad de cola). ✓
- El flujo por $w_t \to t_{\text{sink}}$ no supera $d_t$ (limite de envio por ventana). ✓
- La conservacion en los nodos de cola garantiza que los datos no "aparecen de la nada".

Concluir: el flujo maximo = maxima cantidad de MB transferibles.

**Resolucion — Paso 4: Acotar**

- **Nodos:** $1$ (fuente) + $R \cdot N$ (nodos de carga) + $2 \cdot R \cdot N$ (split de colas) + $N$ (nodos de ventana) + $1$ (sumidero) $= O(RN)$.
- **Aristas:**
  - $R \cdot N$ (fuente a carga) + $R \cdot N$ (carga a cola in) + $R \cdot N$ (aristas internas de split) + $R \cdot (N-1)$ (carry-over) + $R \cdot N$ (cola out a ventana) + $N$ (ventana a sumidero) $= O(RN)$.
- **Flujo maximo:** $F \leq \sum_{t=1}^{N} d_t$. Denotar $D = \sum_t d_t$. Alternativamente $F \leq \sum_{r,t} a_{rt}$; tomar $F = O(\min\{D, \sum_{r,t} a_{rt}\}) = O(D)$ (usando $D$ como cota).

**Resolucion — Paso 5: Complejidad**

Con $n = O(RN)$, $m = O(RN)$, $F = O(D)$:

$$O(\min\{mF,\, nm^2\}) = O\!\left(\min\!\left\{RN \cdot D,\; RN \cdot (RN)^2\right\}\right) = O\!\left(\min\!\left\{RND,\; R^3N^3\right\}\right)$$

Para instancias donde $D \ll R^2N^2$, la cota $O(RND)$ domina. En general: $O(RND)$.

**Chuleta**
> **Satelite:** red temporal con $R \times N$ nodos de cola (split cap $c_q$) + nodos de carga + nodos de ventana. Aristas: $s \to \text{load}_{r,t}$ (cap $a_{rt}$) $\to q_{r,t}^{\text{in}} \to q_{r,t}^{\text{out}}$ (cap $c_q$) $\to w_t \to t$ (cap $d_t$); carry-over: $q_{r,t}^{\text{out}} \to q_{r,t+1}^{\text{in}}$ (cap $c_q$). 1 unidad = 1 MB. Nodos/aristas $O(RN)$, flujo $O(D)$ donde $D = \sum_t d_t$. Complejidad $O(RND)$.

**¿Aparece en parciales?** ⚪ No documentado aun

---

## Ver tambien

- [[flujo_en_redes_teoria]] · [[flujo_en_redes_practica]]
- [[caminos_minimos_todos_a_todos_y_dags_practica]] — para modelos con expansion temporal (DAGs temporales, similar al paso de Satelite)
