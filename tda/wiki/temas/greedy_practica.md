---
nombre: Greedy — Clase Practica
parcial: 2P
programa: 2C_2026
tipo: practica
tema: greedy
fuentes:
  vigente: []
  historico:
    - raw/clases/prac/5.prac_1P_greedy.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[greedy_teoria]]"
  - "[[greedy_guia]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

## Patrones de este tema en parciales
> [[tipos_ejercicio/greedy_demo_intercambio]]

---

## Ejercicios de clase

### Ejercicio 1 — Planificacion de tareas con deadlines

**Enunciado**
Se tiene un conjunto de $n$ tareas $T = \{t_1, t_2, \ldots, t_n\}$, donde cada tarea $t_i$ tiene asociado un deadline $d_i \in \mathbb{Z}^+$. Restricciones: cada tarea requiere exactamente 1 unidad de tiempo, solo se puede ejecutar una tarea a la vez, no hay preemption. Una tarea $t_i$ se completa exitosamente si su tiempo de finalizacion $f_i \leq d_i$. Determinar una planificacion que maximice el numero total de tareas completadas dentro de sus deadlines.

*Ejemplo:* $n = 4$, $D = \{2, 1, 3, 2\}$. Solucion optima: ejecutar $t_2$ en $[0,1)$, $t_1$ en $[1,2)$, $t_3$ en $[2,3)$. Total: 3 tareas.

**Explicacion**
Problema de scheduling con deadlines. El algoritmo greedy ordena las tareas por deadline creciente y las ejecuta en ese orden si es factible. La clave es el Lema de Intercambio (reordenar tareas en orden creciente de deadline no pierde factibilidad) y la tecnica Greedy Stays Ahead.

**Algoritmo Greedy**
```
MaxTareas(T, D):
  Ordenar las tareas por deadline: d[i₁] ≤ d[i₂] ≤ ... ≤ d[iₙ]
  S ← {}
  t_actual ← 0
  Para cada tarea t_j en orden de deadline creciente:
    Si t_actual + 1 ≤ d[j]:
      S ← S ∪ {t_j}
      t_actual ← t_actual + 1
  Retornar |S|
```
Complejidad: $O(n \log n)$ (dominada por el ordenamiento).

**Demostracion de correctitud — Greedy Stays Ahead**

*Lema de Intercambio:* Si en una solucion factible ejecutamos $t_i$ antes que $t_j$ con $d(t_i) > d(t_j)$, podemos intercambiarlos manteniendo la factibilidad.

*Prueba:* Si $t_i$ se ejecuta en tiempo $s$ y $t_j$ en tiempo $s' > s$:
- Antes: $t_i$ cumple $s+1 \leq d(t_i)$; $t_j$ cumple $s'+1 \leq d(t_j)$.
- Despues del intercambio: $t_j$ en $s$: $s+1 \leq s'+1 \leq d(t_j)$ ✓; $t_i$ en $s'$: $s'+1 \leq d(t_j) < d(t_i)$ ✓. $\square$

Por lo tanto, podemos asumir WLOG que cualquier solucion optima $O$ esta ordenada por deadlines.

*Lema (Greedy Stays Ahead):* Para todo $i \in \{1, \ldots, \min(m, n)\}$, se cumple $d(g_i) \leq d(o_i)$, donde $G = \{g_1, \ldots, g_m\}$ es la solucion greedy y $O = \{o_1, \ldots, o_n\}$ es cualquier solucion optima (ambas ordenadas por deadline).

*Prueba por induccion en $i$:*
- Base ($i=1$): $g_1$ es la tarea con menor deadline ejecutable en $t=0$. Como $o_1$ tambien es factible desde $t=0$, $d(g_1) \leq d(o_1)$. $\square$
- Paso ($k$): Por HI, el greedy ejecuto $k-1$ tareas con deadlines $\leq$ los primeros $k-1$ de $O$. El tiempo de finalizacion de $g_{k-1}$ es $k-1$. La tarea $o_k$ es factible en la solucion optima despues de $\{o_1, \ldots, o_{k-1}\}$, y como $d(o_{k-1}) \leq d(o_k)$, el greedy la habra considerado y elegido $g_k$ con el menor deadline posible entre las factibles. Por lo tanto $d(g_k) \leq d(o_k)$. $\square$

*Teorema de optimalidad:* El algoritmo greedy produce una solucion optima.

*Prueba:* Sea $G$ con $m$ tareas y $O$ con $n$ tareas optima. Supongamos por contradiccion que $m < n$. Por el Lema GSA, $d(g_m) \leq d(o_m) \leq d(o_{m+1})$. El tiempo de finalizacion de $g_m$ es $m$, por lo que $m + 1 \leq d(o_{m+1})$. Esto significa que despues de ejecutar $G$, en tiempo $m$, la tarea $o_{m+1}$ (o cualquier con el mismo deadline) es factible — el greedy la habria agregado. Contradiccion. Por lo tanto $m = n$. $\square$

**Chuleta**
> 1. Ordenar por deadline creciente → 2. Ejecutar greedy: tomar tarea si cabe antes de su deadline → 3. Correctitud: Lema de Intercambio (WLOG solucion ordenada) + GSA por induccion + teorema de optimalidad por contradiccion

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/greedy_demo_intercambio]]

---

### Ejercicio 2 — Viaje a Mar del Plata

**Enunciado**
Tomas quiere viajar de Buenos Aires (km 0) a Mar del Plata (km $M$) en un auto con autonomia de $C$ km. Las estaciones de servicio estan en posiciones $0 = x_1 \leq x_2 \leq \ldots \leq x_n \leq M$. Al comenzar el viaje el tanque esta vacio. Minimizar la cantidad de paradas para cargar nafta (y devolver el conjunto de estaciones).

**Explicacion**
Greedy clasico: siempre avanzar hasta la estacion mas lejana posible dentro del alcance. Correctitud demostrada con Propiedad de Eleccion Greedy + Subestructura Optima + Induccion.

**Algoritmo Greedy ($O(n)$)**
```
MinParadas(x[], n, C, M):
  posicion_actual ← 0
  estaciones ← {x[1]}      // cargamos en Buenos Aires
  idx ← 1
  Mientras posicion_actual + C < M:
    ultima_alcanzable ← idx - 1
    Mientras idx ≤ n Y x[idx] ≤ posicion_actual + C:
      ultima_alcanzable ← idx
      idx ← idx + 1
    Si ultima_alcanzable == idx - 1:
      Retornar "No hay solucion"
    estaciones ← estaciones ∪ {x[ultima_alcanzable]}
    posicion_actual ← x[ultima_alcanzable]
  Retornar estaciones
```
Complejidad: $O(n)$ — cada estacion se examina a lo sumo una vez.

*Ejemplo:* $M = 400$, $C = 150$, estaciones $= \{0, 80, 140, 200, 280, 350, 400\}$. Iteracion 1: desde 0, elegir 140 (mas lejana $\leq 150$). Iteracion 2: desde 140, elegir 280. Iteracion 3: desde 280, $280 + 150 = 430 \geq 400$, destino alcanzable. Total: paradas en 0, 140, 280.

**Demostracion de correctitud**

*Lema 1 (Propiedad de eleccion Greedy):* Existe una solucion optima que incluye la primera eleccion del algoritmo greedy $g_1$ (la estacion mas lejana alcanzable desde el origen).

*Prueba:* Sea $O = \{o_1, \ldots, o_k\}$ optima. Si $o_1 = g_1$, listo. Si $o_1 \neq g_1$, entonces $x_{o_1} < x_{g_1}$ (pues $g_1$ es la mas lejana). Construimos $O' = \{g_1\} \cup \{o_i \in O : x_{o_i} > x_{g_1}\}$.

$O'$ es factible: $g_1$ es alcanzable desde el origen por definicion. Para cada $o_i$ con $x_{o_i} > x_{g_1}$: si era alcanzable desde $o_1$, tambien lo es desde $g_1$, pues $x_{o_i} - x_{g_1} < x_{o_i} - x_{o_1} \leq C$. Como $|O'| \leq |O|$ y $O$ es optima, $|O'| = |O|$, por lo que $O'$ es optima y contiene a $g_1$. $\square$

*Lema 2 (Subestructura optima):* Si $O$ es optima para llegar de 0 a $M$ y $o_k \in O$, entonces $O \setminus \{o_1, \ldots, o_k\}$ es optima para el subproblema de ir de $x_{o_k}$ a $M$.

*Prueba:* Por contradiccion. Si existiera $S$ para ir de $x_{o_k}$ a $M$ con menos paradas, entonces $\{o_1, \ldots, o_k\} \cup S$ es factible para el problema original con menos paradas que $O$, contradiciendo la optimalidad. $\square$

*Teorema:* El algoritmo greedy produce una solucion optima.

*Prueba por induccion:* Probaremos que para cada $i \in \{1, \ldots, k\}$, existe una solucion optima que contiene $\{g_1, \ldots, g_i\}$.
- Base ($i=1$): Por Lema 1.
- Paso ($i \to i+1$): Por HI, existe $O_i$ optima con $\{g_1, \ldots, g_i\}$. Por Lema 2, $O_i' = O_i \setminus \{g_1, \ldots, g_i\}$ es optima para ir de $x_{g_i}$ a $M$. Aplicando Lema 1 al subproblema, $g_{i+1}$ (la estacion mas lejana desde $x_{g_i}$) puede reemplazar la primera estacion de $O_i'$ sin aumentar paradas. Definimos $O_{i+1} = \{g_1, \ldots, g_i, g_{i+1}\} \cup S$ donde $S$ es optima para ir de $x_{g_{i+1}}$ a $M$. $\square$

**Chuleta**
> 1. Estrategia: elegir siempre la estacion mas lejana dentro del alcance $C$ → 2. Lema de Eleccion Greedy: reemplazar primera estacion de cualquier optima por $g_1$ no aumenta paradas → 3. Subestructura optima: eliminar el prefijo de la optima da optima del subproblema → 4. Induccion: combinar ambos lemas

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/greedy_demo_intercambio]]

---

### Ejercicio 3 — Minimizacion del producto escalar

**Enunciado**
Dados dos vectores $v, w \in \mathbb{R}^n$, encontrar permutaciones $\sigma$ y $\tau$ de sus coordenadas que minimicen el producto escalar $\langle v_\sigma, w_\tau \rangle = \sum_{i=1}^n v_{\sigma(i)} \cdot w_{\tau(i)}$.

**Explicacion**
El producto escalar se minimiza apareando el menor de $v$ con el mayor de $w$, el segundo menor con el segundo mayor, etc. La demostracion usa un argumento de intercambio y una prueba por induccion.

**Algoritmo Greedy ($O(n \log n)$)**
```
MinimizarProductoEscalar(v, w):
  Ordenar v de menor a mayor
  Ordenar w de mayor a menor
  Retornar sum(v_ordenado[i] * w_ordenado[i] para i=1..n)
```

*Ejemplo:* $v = (3, 1, 4, 2)$, $w = (5, 2, 8, 1)$.
- $v$ ordenado creciente: $(1, 2, 3, 4)$.
- $w$ ordenado decreciente: $(8, 5, 2, 1)$.
- Producto: $1 \cdot 8 + 2 \cdot 5 + 3 \cdot 2 + 4 \cdot 1 = 8 + 10 + 6 + 4 = 28$.
- Con orden original: $3 \cdot 5 + 1 \cdot 2 + 4 \cdot 8 + 2 \cdot 1 = 51$ (mayor).

**Demostracion de correctitud (argumento de intercambio)**

*Teorema:* El producto escalar se minimiza ordenando $v$ crecientemente y $w$ decrecientemente (o viceversa).

*Prueba:* Supongamos $v_1 \leq v_2 \leq \cdots \leq v_n$ y $w_1 \geq w_2 \geq \cdots \geq w_n$. Supongamos que existe otra permutacion $O$ que produce un producto escalar menor. En $O$, las coordenadas estan apareadas como $(\hat{v}_1, \hat{w}_1), \ldots, (\hat{v}_n, \hat{w}_n)$.

Si en $O$ existen indices $i < j$ con $\hat{v}_i > \hat{v}_j$, consideramos el efecto de intercambiar $\hat{v}_i$ y $\hat{v}_j$:

$$S_{\text{antes}} = \hat{v}_i \cdot \hat{w}_i + \hat{v}_j \cdot \hat{w}_j$$
$$S_{\text{despues}} = \hat{v}_j \cdot \hat{w}_i + \hat{v}_i \cdot \hat{w}_j$$
$$S_{\text{despues}} - S_{\text{antes}} = (\hat{v}_j - \hat{v}_i)(\hat{w}_i - \hat{w}_j)$$

Para que $O$ sea optima y el intercambio no mejore, necesitamos $S_{\text{despues}} - S_{\text{antes}} \geq 0$.

Como $\hat{v}_i > \hat{v}_j \Rightarrow \hat{v}_j - \hat{v}_i < 0$, se necesita $\hat{w}_i - \hat{w}_j \leq 0$, es decir $\hat{w}_i \leq \hat{w}_j$.

Por un argumento simetrico, si $\hat{w}_i < \hat{w}_j$ entonces $\hat{v}_i \geq \hat{v}_j$.

Aplicando este argumento repetidamente: en cualquier solucion optima sin posibilidad de mejora por intercambio, las coordenadas de $v$ estan en orden opuesto a las de $w$. Esto es exactamente lo que produce nuestro algoritmo. $\square$

**Demostracion alternativa por induccion en $n$**

*Caso base* ($n = 2$): $v_1 \leq v_2$, $w_1 \geq w_2$.
$$\underbrace{v_1 w_2 + v_2 w_1}_{\text{alternativo}} - \underbrace{(v_1 w_1 + v_2 w_2)}_{\text{greedy}} = (v_2 - v_1)(w_1 - w_2) \geq 0$$
El greedy es mejor o igual. $\square$

*Paso inductivo:* Con $v_1 \leq v_2 \leq \cdots \leq v_n$ y $w_1 \geq w_2 \geq \cdots \geq w_n$, por el argumento de intercambio $v_1$ debe estar apareado con $w_1$ en alguna solucion optima. Fijado ese apareamiento, el subproblema restante es minimizar el producto escalar en $\mathbb{R}^{n-1}$ con $(v_2, \ldots, v_n)$ y $(w_2, \ldots, w_n)$. Por HI, la solucion optima es aparejarlos en orden opuesto. $\square$

**Chuleta**
> 1. Ordenar $v$ creciente y $w$ decreciente → 2. Correctitud: argumento de intercambio — cualquier desviacion del orden opuesto puede mejorarse intercambiando → la solucion optima es el orden opuesto

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/greedy_demo_intercambio]]

---

## Ver tambien

- [[greedy_teoria]] — teoria: heuristicas, epsilon-aproximacion, mochila fraccionaria, cambio de monedas, seleccion de actividades (con demo por principio de intercambio)
- [[definiciones_y_demostraciones_teoria]] — estrategias de demostracion (intercambio, induccion, contradiccion)
- [[greedy_guia]] — Guia de ejercicios del tema
