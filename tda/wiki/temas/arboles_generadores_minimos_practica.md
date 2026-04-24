---
nombre: Arboles Generadores Minimos — Clase Practica
parcial: 2P
tipo: practica
tema: arboles_generadores_minimos
fuente: raw/clases/prac/9.prac_2P_arbol_generador_minimo.pdf
paginas_relacionadas:
  - "[[arboles_generadores_minimos_teoria]]"
  - "[[grafos_practica]]"
  - "[[caminos_minimos_practica]]"
  - "[[arboles_generadores_minimos_guia]]"
---

## Patrones de este tema en parciales
> [[tipos_ejercicio/agm_propiedades]]

---

## Repaso: conceptos clave

### Arbol Generador (AG)
$T$ es AG de $G$ si: $T$ es subgrafo de $G$, $T$ es arbol, $T$ tiene todos los vertices de $G$.

### Arbol Generador Minimo (AGM)
$T$ es AGM de $G$ si es AG y su costo (suma de pesos de aristas) es minimo entre todos los AGs.

### Caminos MaxiMin y MiniMax

**Camino MaxiMin** de $v$ a $w$: camino $P$ que maximiza $c_{\min}(P) = \min\{c(e) : e \in E(P)\}$ (= camino mas ancho).

**Camino MiniMax** de $v$ a $w$: camino $P$ que minimiza $c_{\max}(P) = \max\{c(e) : e \in E(P)\}$ (= camino cuello de botella minimo).

### Vinculo MiniMax ↔ AGM

**Lema:** $T$ es AGM de $(G, c) \iff$ todo camino de $T$ es MiniMax de $(G, c)$.

**Demostracion** (camino AGM $\Rightarrow$ MiniMax, por absurdo):
Suponer que existe camino $Q$ en AGM $T$ de $a$ a $z$ que no es MiniMax. Entonces existe camino $P$ con $c_{\max}(P) < c_{\max}(Q)$. Sea $q$ la arista mas grande de $Q$ (que no esta en $P$). Al sacar $q$ de $T$, quedan dos componentes; $P$ debe tener alguna arista $p$ cruzando entre ellas (con $p \notin T$). Como $c(p) \leq c_{\max}(P) < c_{\max}(Q) = c(q)$, el arbol $T^* = T - q + p$ es AG con peso menor que $T$. Absurdo con $T$ AGM. $\square$

### Aplicaciones del AGM
- Red de electricidad (costo minimo de conexion)
- Spanning Tree Protocol (STP) en redes
- Aproximacion para TSP (Traveling Salesman Problem)

---

## Ejercicios de clase

### Ejercicio 1 — Viaje en peligro (Prim parcial)

**Enunciado**
Cifu vive en Kruskal, Rusia. Hay $n$ ciudades y el presidente ofrece construir $k \ll n$ rutas con 2 condiciones: (1) que queden conectadas $k+1$ localidades, (2) que la red resultante sea subred de la red que conecta todas las localidades con costo minimo. El costo de una ruta entre $x$ e $y$ es $r \cdot \text{distEnKm}(x,y) + c_{x,y}$.

**Explicacion**
Se necesita un subarbol de $k$ aristas del AGM que contenga a la localidad de Cifu. Esto es exactamente lo que produce **Prim** detenido despues de $k$ iteraciones (su invariante garantiza que en la $i$-esima iteracion tiene un subgrafo de $i$ aristas del AGM). Kruskal no sirve porque puede generar arboles que no contengan la localidad de Cifu.

**Resolucion paso a paso**
1. Crear grafo completo: un vertice por localidad, aristas con peso $\text{distEnKm}(x,y) + c_{x,y}$ — $O(n^2)$
2. Correr **Prim desde la localidad de Cifu**, deteniendose despues de $k$ aristas — $O(nk)$ con implementacion $O(n^2)$ de Prim
3. Retornar las $k$ aristas seleccionadas

**Complejidad:** $O(n^2)$ (construccion del grafo domina, con $k \ll n$).

**Nota importante:** El invariante de Prim dice que en su $i$-esimo paso tiene un subgrafo de $i$ aristas **de algun AGM**, no necesariamente el arbol de $i$ aristas de costo minimo que contenga la raiz. Ejemplo: en ciertos grafos, Prim desde nodo $K$ genera un subarbol (azul) que no es el de costo minimo (rojo) para ese tamaño.

**Chuleta**
> 1. Grafo completo con costos → 2. Prim desde Cifu, parar en $k$ aristas → 3. Invariante de Prim: subgrafo del AGM

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/agm_modelado]]

---

### Ejercicio 2 — Conjuntos deseables (Kruskal + DSU)

**Enunciado**
Dado $G = (V, E)$ pesado con $c : E \to \mathbb{N}$, un conjunto $D \subseteq V$ es **deseable** si: (1) el subgrafo inducido por $D$ es conexo, y (2) toda arista que sale de $D$ tiene peso estrictamente mayor que cualquier arista interna a $D$.

(a) Probar que si $D$ es deseable entonces existe alguna iteracion $j$ de Kruskal tal que $D$ es una componente conexa de $B_j$.
(b) Dar un algoritmo eficiente que cuente la cantidad de conjuntos deseables. Objetivo: $O(nm)$.

**Explicacion**
Los conjuntos deseables son "islas baratas" que Kruskal completa internamente antes de cruzar aristas mas costosas. La parte (a) se demuestra usando que $\beta < \alpha$ (max interna < min saliente) implica que Kruskal procesa todas las internas antes que las salientes.

**Parte (a) — Demostracion**

Definir $\alpha = \min\{c(e) : e \text{ cruza } (D, V \setminus D)\}$ y $\beta = \max\{c(e) : e \text{ interna a } D\}$. Como $D$ es deseable: $\beta < \alpha$.

**Caso $|D| = 1$:** Trivial — $D$ es componente de $B_0$ (cada vertice comienza como su propia componente).

**Caso $|D| \geq 2$:** Sea $j'$ la primera iteracion donde el subgrafo inducido por $D$ en $B_{j'}$ es conexo. Suponer por absurdo que $D$ no es componente de $B_{j'}$: entonces existe arista saliente $(d_3, d) \in B_{j'}$ con $d_3 \in D$, $d \notin D$, procesada antes que la arista interna $(d_1, d_2)$ de la iteracion $j'$. Como Kruskal procesa en orden creciente: $c(d_3, d) \leq c(d_1, d_2) \leq \beta < \alpha$. Pero $(d_3, d)$ es saliente con peso $< \alpha$, contradiciendo la definicion de $\alpha$. Absurdo. $\square$

**Parte (b) — Algoritmo $O(nm)$**

1. Inicializar `deseables = n` (cada vertice individual es deseable)
2. Recorrer aristas en orden creciente (como Kruskal), usando DSU
3. Cada vez que se unen componentes $D_1$ y $D_2$ formando $D = D_1 \cup D_2$:
   - Actualizar `max_interno(D) = max(max_interno(D_1), max_interno(D_2), c(arista_union))`
   - **Chequeo de deseabilidad:** recorrer $O(m)$ aristas, verificar que toda arista $(x,y)$ con exactamente uno en $D$ cumpla $c(x,y) > \text{max\_interno}(D)$
   - Si cumple: `deseables += 1`
4. Retornar `deseables`

**Cuidado:** No toda componente de Kruskal es deseable. Contraejemplo: grafo con aristas $\{(a,b,2), (b,d,4), (c,d,1), (a,c,3)\}$ — la componente $\{a,b,d\}$ tiene arista interna peso 4 y saliente $(c,d)$ peso 3, no es deseable.

**Complejidad:** $O(n)$ uniones $\times O(m)$ chequeo = $O(nm)$. (Mejor solucion conocida: $O(m \log n)$.)

**Chuleta**
> (a) $\beta < \alpha$ → Kruskal completa internas antes que salientes → $D$ es componente en algun $B_j$ · (b) Kruskal + DSU, en cada union: chequear deseabilidad recorriendo aristas $O(m)$ → total $O(nm)$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/agm_modelado]]

---

### Ejercicio 3 — Audifonos defectuosos (camino MiniMax via AGM)

**Enunciado**
Sasha quiere ir de su hogar a Ciudad Universitaria minimizando el maximo ruido en el camino. Cada calle tiene un nivel de ruido $d$.

**Explicacion**
Buscar camino **MiniMax** = encontrar AGM y tomar el camino en el AGM (por el lema, todo camino del AGM es MiniMax).

**Resolucion paso a paso**
1. Modelar: $V$ = esquinas, $E$ = calles, peso = ruido
2. Calcular AGM con Prim o Kruskal — $O(m + n \log n)$
3. En el AGM, encontrar camino de Sasha a CU (BFS/DFS en el arbol)
4. La arista de maximo peso en ese camino = tolerancia minima

**Complejidad:** $O(m + n \log n)$ (dominada por AGM).

**Variaciones:**
- Tolerancia para todos los destinos: usar todos los caminos del AGM (todo camino es MiniMax)
- Tasha quiere maximizar el minimo ruido (MaxiMin): usar Arbol Generador **Maximo** (analogo)
- Grafo ralo: Kruskal ($O(m \log n)$); grafo denso: Prim ($O(n^2)$)
- Audifonos bloquean 1 calle: problema mucho mas complejo

**Chuleta**
> 1. AGM (Prim/Kruskal) → 2. Camino en el AGM de origen a destino → 3. Arista de max peso = tolerancia minima (por lema MiniMax↔AGM)

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/agm_minimax]]

---

### Ejercicio 4 — Alimentando hormigas (nodo fantasma)

**Enunciado**
$n$ cuevas con coordenadas $(x_i, y_i)$. Se pueden colocar **tubos de comida** (costo $T$ cada uno) o construir **tuneles** entre cuevas (costo $M \cdot (|x_i - x_j| + |y_i - y_j|)$). Minimizar costo para que todas las cuevas tengan acceso a comida.

**Explicacion**
Modelar con **nodo fantasma "Tubo"** conectado a todas las cuevas con peso $T$. AGM del grafo extendido decide optimamente cuantos tubos poner y que tuneles construir. Arista $(c_i, \text{Tubo})$ en el AGM = poner tubo en cueva $i$. Arista $(c_i, c_j)$ en el AGM = construir tunel.

**Modelo erroneo:** AGM sin nodo Tubo siempre pone un solo tubo — no funciona si dos grupos de cuevas estan muy lejos (seria mas barato poner 2 tubos).

**Resolucion paso a paso**
1. Crear grafo con $n$ cuevas + 1 nodo "Tubo" — $O(n)$
2. Agregar aristas entre cuevas: peso $M \cdot (|x_i - x_j| + |y_i - y_j|)$ — $O(n^2)$
3. Agregar aristas (cueva $i$, Tubo): peso $T$ — $O(n)$
4. Calcular AGM — $O(n^2)$ (grafo denso, usar Prim)
5. Traducir: aristas al Tubo = tubos, aristas entre cuevas = tuneles

**Complejidad:** $O(n^2)$.

**Chuleta**
> 1. Nodo fantasma "Tubo" con aristas de costo $T$ a cada cueva → 2. AGM decide optimalidad entre tubos y tuneles → 3. Traducir aristas del AGM a la solucion del problema

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/agm_modelado]]

---

### Ejercicio 5 — Rutas y aeropuertos (comparar dos AGMs)

**Enunciado**
$n$ ciudades, costos de rutas $c_{i,j}$, costos de aeropuertos $a_i$. Conectar todas las ciudades con costo minimo usando rutas y/o aeropuertos (volar entre ciudades con aeropuerto es gratis).

**Explicacion**
A diferencia de hormigas, aqui **no basta** un solo nodo fantasma sin mas: un AGM con nodo Aeropuerto siempre preferiria usar aeropuertos si son baratos, aunque la solucion sin aeropuertos sea mejor (ejemplo: 2 ciudades cercanas — mejor la ruta directa que 2 aeropuertos). Se comparan dos soluciones.

**Resolucion paso a paso**
1. $G$ = grafo de ciudades con aristas de costo $c_{i,j}$
2. **Sin aeropuertos:** AGM de $G$ → guardar peso en `pesoSin`
3. $G'$ = $G$ + nodo Aeropuerto con aristas de costo $a_i$ a cada ciudad
4. **Con aeropuertos:** AGM de $G'$ → guardar peso en `pesoCon`
5. Retornar $\min(\text{pesoSin}, \text{pesoCon})$

**Justificacion:** Toda solucion que usa aeropuertos se traduce en un subgrafo conexo de $G'$; si no es arbol, se puede mejorar sacando aristas. Entonces el AGM de $G'$ es optimo entre las que usan aeropuertos.

**Complejidad:** 2 ejecuciones de Prim/Kruskal sobre grafos de $O(n)$ nodos = $O(n^2)$ si denso.

**Chuleta**
> 1. AGM sin aeropuertos (solo rutas) → 2. Agregar nodo Aeropuerto → AGM con aeropuertos → 3. Retornar min de ambos pesos

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/agm_modelado]]

---

## Repaso: Disjoint Set Union (DSU / Union-Find)

Estructura para Kruskal eficiente:
- `find(u)`: retorna representante de la componente de $u$
- `union(u, v)`: une las componentes de $u$ y $v$

**Optimizaciones:**
- **Union by rank:** al unir, el arbol mas chico apunta al mas grande (rank = cota superior de altura)
- **Path compression:** al hacer `find`, todos los nodos visitados apuntan directamente a la raiz

Con ambas optimizaciones: $O(\alpha(n))$ amortizado por operacion ($\alpha$ = inversa de Ackermann, practicamente constante).

Sin optimizaciones: `find` es $O(n)$ peor caso → Kruskal $O(mn)$.
Con ambas: Kruskal $O(m \log n + m \cdot \alpha(n)) = O(m \log n)$.

---

## Ver tambien

- [[arboles_generadores_minimos_teoria]] — Prim (proposicion, teorema, prueba por induccion), Kruskal (proposicion, teorema, prueba por induccion, Union-Find)
- [[grafos_practica]] — representacion de grafos, demostraciones sobre grafos
- [[caminos_minimos_practica]] — Dijkstra, Bellman-Ford aplicados
- [[arboles_generadores_minimos_guia]] — Guia de ejercicios del tema
