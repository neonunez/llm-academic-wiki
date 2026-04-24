---
nombre: Fuerza Bruta & Backtracking — Guia de Ejercicios
parcial: 1P
tipo: guia
tema: fuerza_bruta_backtracking
fuente: raw/guias_practicas/2.guia_1P_tecnicas_algoritmicas.pdf
paginas_relacionadas:
  - "[[fuerza_bruta_backtracking_teoria]]"
  - "[[fuerza_bruta_backtracking_practica]]"
---

# Fuerza Bruta & Backtracking — Guia de Ejercicios

Practica 2 (Tecnicas Algoritmicas), seccion de Backtracking. Ejercicios 1–8. Compilado: 17 sept. 2025.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | SumaSubconjuntosBT — analisis completo de BT con reglas de factibilidad y PD | 🔴 Si |
| Ej. 2 | MagiCuadrados — contar cuadrados magicos de orden n | ⚪ No |
| Ej. 3 | MaxiSubconjunto — maximizar suma de subconjunto de tamano k | ⚪ No |
| Ej. 4 | RutaMinima (TSP) — permutacion minima en matriz de distancias | 🔴 Si |
| Ej. 5 | PalabrasEnCadena — subdividir cadena en palabras validas | 🔴 Si |
| Ej. 6 | ABBOptimos — arbol binario de busqueda optimo (costo minimo de acceso) | 🔴 Si |
| Ej. 7 | Dobra — reemplazar guiones bajos para formar palabras buenas | 🔴 Si |
| Ej. 8 | CadenasDeAdicion — cadena de adicion de longitud minima para n | ⚪ No |

## Patrones de este tema en parciales

> Arbol de backtracking · Poda por factibilidad y optimalidad · Correctitud por induccion fuerte

## Ejercicios

### Ejercicio 1 — SumaSubconjuntosBT

**Enunciado**

Dado un multiconjunto $C = \{c_1, \ldots, c_n\}$ de numeros naturales y un natural $k$, determinar si existe un subconjunto de $C$ cuya sumatoria sea $k$. Las soluciones candidatas son vectores binarios $a = (a_1, \ldots, a_n)$ donde $a_i = 1$ significa que $c_i$ esta en el subconjunto.

a) Escribir el conjunto de soluciones candidatas para $C = \{6, 12, 6\}$ y $k = 12$.
b) Escribir el conjunto de soluciones validas.
c) Escribir el conjunto de soluciones parciales.
d) Dibujar el arbol de backtracking para $C = \{6, 12, 6\}$ y $k = 12$.
e) Convencerse de que la funcion recursiva $ss$ es correcta:
$$ss(\{c_1,\ldots,c_n\}, k) = \begin{cases} k = 0 & \text{si } n = 0 \\ ss(\{c_1,\ldots,c_{n-1}\}, k) \lor ss(\{c_1,\ldots,c_{n-1}\}, k-c_n) & \text{si } n > 0 \end{cases}$$
f) Implementar `subset_sum(C, i, j)` — ¿Complejidad?
g) Comparar arbol de llamadas recursivas con arbol de backtracking.
h) Agregar regla de factibilidad: retornar `false` si $j < 0$.
i) Definir otra regla de factibilidad y mostrar que es correcta.
j) Modificar para imprimir el subconjunto que suma $k$ (mantener vector de solucion parcial sin copiarlo).

**Explicacion**

Ejercicio fundamental de BT. Introduce todas las definiciones clave: soluciones candidatas, validas, parciales, arbol de BT. La regla de factibilidad $j < 0$ es la poda por factibilidad estandar. La relacion con PD se explora en ejercicio 11 de la misma guia (SumaDinamica).

**Resolucion paso a paso**

**a) Soluciones candidatas para $C = \{6,12,6\}$, $k=12$:**

Todos los vectores binarios de longitud 3:

$$\{(0,0,0),\; (0,0,1),\; (0,1,0),\; (0,1,1),\; (1,0,0),\; (1,0,1),\; (1,1,0),\; (1,1,1)\}$$

Total: $2^3 = 8$ candidatas.

**b) Soluciones validas** (subconjuntos que suman exactamente $k=12$):

- $(0,1,0)$: $12 = 12$ ✓
- $(1,0,1)$: $6+6 = 12$ ✓

Total: 2 soluciones validas.

**c) Soluciones parciales:**

Todos los vectores binarios de longitud $< 3$:

$$\{(),\; (0),\; (1),\; (0,0),\; (0,1),\; (1,0),\; (1,1)\}$$

Total: $1 + 2 + 4 = 7$ soluciones parciales (el arbol tiene 7 nodos internos).

**d) Arbol de backtracking para $C = \{6,12,6\}$, $k=12$** (sin podas — $j$ = suma restante):

```
                     () j=12
                /              \
          (1) j=6           (0) j=12
          /     \            /       \
    (1,1) j=-6 (1,0) j=6 (0,1) j=0  (0,0) j=12
               /    \     /    \     /      \
       (1,0,1)j=0 (1,0,0)j=6 (0,1,1)j=-6 (0,1,0)j=0  (0,0,1)j=6 (0,0,0)j=12
       ✓ VALIDA  ✗ no 0    ✗ no 0    ✓ VALIDA        ✗ no 0    ✗ no 0
```

**e) Correctitud de $ss$:**

La recursion es correcta por definicion del problema. Para $n > 0$, el elemento $c_n$ o esta en el subconjunto buscado o no lo esta — son los dos casos de la disyuncion. Si esta, necesitamos que el resto sume $k - c_n$; si no, que sume $k$. La base $n=0$ es: solo hay solucion si $k=0$ (subconjunto vacio suma 0).

**f) Implementacion $\texttt{subset\_sum}(C, i, j)$:**

```
subset_sum(C, i, j):
  si i = 0 entonces retornar j = 0
  si C[i] > j entonces
    retornar subset_sum(C, i-1, j)    // no incluir C[i]
  sino
    retornar subset_sum(C, i-1, j) or subset_sum(C, i-1, j - C[i])
```

Complejidad: $O(2^n)$ — en cada paso se realizan 2 llamadas y hay $n$ niveles.

**g) Relacion arbol de llamadas $\leftrightarrow$ arbol de BT:**

Son identicos (sin podas). Cada nodo del arbol de backtracking corresponde exactamente a una llamada recursiva. El nodo $(a_1,\ldots,a_k)$ corresponde a la llamada con $i = n-k$ y el $j$ acumulado segun los $a_i$ elegidos.

**h) Regla de factibilidad $j < 0$:**

Si $j < 0$, retornar `False`. Es correcta porque todos los $c_i \in \mathbb{N}$: ningun subconjunto de naturales tiene suma negativa. Por lo tanto, si la suma requerida ya es negativa, ninguna extension puede cumplirla.

**i) Otra regla de factibilidad — suma maxima restante:**

Si $j > \sum_{m=1}^{i} C[m]$ (la suma de todos los elementos restantes es menor que $j$), retornar `False`. Es correcta porque el mejor caso es incluir todos los elementos restantes; si aun asi no se alcanza $j$, no hay solucion.

Formalmente: $\text{sumaRestante}(i) = \sum_{m=1}^{i} C[m]$ calculado en $O(1)$ con prefijos. Si $j > \text{sumaRestante}(i)$, ninguna extension suma $j$.

**j) Imprimir subconjunto sin copiar vector:**

Mantener un vector global `sol[1..n]` de bits. Al bajar en la recursion, setear `sol[i] = 1` o `sol[i] = 0`. Al encontrar solucion ($j=0$ con $i=0$), imprimir los `sol[k]` que tienen `sol[k]=1`.

```
subset_sum(C, i, j, sol):
  si i = 0 entonces
    si j = 0 entonces imprimir sol
    retornar
  sol[i] = 1; subset_sum(C, i-1, j - C[i], sol)
  sol[i] = 0; subset_sum(C, i-1, j, sol)
```

No se copia el vector — se modifica in situ y se restaura al retroceder.

**Chuleta**
> **a)** $2^n$ candidatas (vectores binarios). **b)** Validas: suman exactamente $k$. **c)** Parciales: prefijos del vector. **d)** Arbol binario de profundidad $n$. **e)** Correctitud por casos: $c_n$ in o out. **f)** $O(2^n)$. **g)** Arbol de llamadas = arbol BT. **h)** Poda factibilidad: $j < 0 \Rightarrow$ False. **i)** Poda extra: $j > \text{sumaRestante} \Rightarrow$ False. **j)** Vector global, modificar/restaurar in situ.

**¿Aparece en parciales?** 🔴 Si — SumaSubconjuntos aparece en practica de clase, es patron canonico

---

### Ejercicio 2 — MagiCuadrados

**Enunciado**

Un cuadrado magico de orden $n$ es un cuadrado con los numeros $\{1, \ldots, n^2\}$ tal que todas sus filas, columnas y diagonales suman lo mismo (numero magico).

a) ¿Cuantos cuadrados habria que generar con fuerza bruta?
b) Enunciar un algoritmo de backtracking donde la solucion parcial tiene los valores de las primeras $i-1$ filas y las primeras $j$ columnas de la fila $i$ establecidos. Mostrar los 2 primeros niveles del arbol para $n=3$.
c) Demostrar que el arbol de backtracking tiene $O((n^2)!)$ nodos en peor caso.
d) Poda: verificar que la suma parcial de cada fila y columna no supere el numero magico. Implementar y ejecutar para comparar tiempos.
e) Demostrar que el numero magico de orden $n$ siempre es $(n^3 + n)/2$. Adaptar la poda. Comparar tiempos.

**Explicacion**

Backtracking sobre permutaciones con podas progresivas. El numero magico es $(n^3+n)/2 = n(n^2+1)/2$ (suma de $1+\ldots+n^2$ dividida por $n$ filas). Las podas reducen drasticamente el espacio pero no cambian la complejidad en peor caso.

**Resolucion paso a paso**

**a) Fuerza bruta:**

Colocar los $n^2$ numeros en las $n^2$ casillas del cuadrado → $(n^2)!$ posibles cuadrados. Para $n=3$: $9! = 362{,}880$.

**b) Algoritmo de backtracking:**

Solucion parcial: los valores de las primeras $i-1$ filas y las primeras $j$ columnas de la fila $i$ ya asignados (se recorre celda por celda, izquierda a derecha, fila por fila).

Extension: asignar al siguiente hueco un valor de $\{1,\ldots,n^2\}$ no usado aun.

Para $n=3$, primeros dos niveles:
- **Nivel 1** (celda (1,1)): 9 nodos, uno por cada valor de $\{1,\ldots,9\}$.
- **Nivel 2** (celda (1,2)): para cada nodo del nivel 1, 8 nodos (los 8 valores restantes).

**c) Demostracion $O((n^2)!)$ nodos:**

En el nivel $k$ del arbol, se han asignado $k$ celdas y quedan $n^2 - k$ valores disponibles. El numero de nodos en el nivel $k$ es a lo sumo $\frac{(n^2)!}{(n^2-k)!}$ (permutaciones parciales). El total de nodos es:

$$\sum_{k=0}^{n^2} \frac{(n^2)!}{(n^2-k)!} = (n^2)! \sum_{k=0}^{n^2} \frac{1}{(n^2-k)!} \le (n^2)! \cdot e = O((n^2)!)$$

**d) Poda: suma parcial de fila/columna no supera numero magico.**

Al completar cada fila o columna, verificar que su suma sea exactamente el numero magico; mientras esta parcialmente completa, verificar que la suma acumulada no supere el numero magico. Si se viola, cortar la rama.

**e) Numero magico = $\dfrac{n^3 + n}{2}$:**

La suma de todos los numeros del cuadrado es $1 + 2 + \cdots + n^2 = \frac{n^2(n^2+1)}{2}$.

Hay $n$ filas, cada una con la misma suma → numero magico $= \dfrac{n^2(n^2+1)}{2n} = \dfrac{n(n^2+1)}{2} = \dfrac{n^3+n}{2}$.

Para $n=3$: numero magico $= \frac{27+3}{2} = 15$.

Adaptar la poda: usar la constante $M = \frac{n^3+n}{2}$ para comparar en lugar de calcularlo cada vez.

**Chuleta**
> **a)** $(n^2)!$ candidatos (fuerza bruta). **b)** BT: celda por celda, extender con valores no usados. **c)** Nodos totales $= O((n^2)!)$ por conteo de permutaciones parciales. **d)** Poda: suma parcial de fila/col $\le$ numero magico. **e)** Numero magico $= \frac{n^3+n}{2}$ (suma total / n filas).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — MaxiSubconjunto

**Enunciado**

Dada una matriz simetrica $M$ de $n \times n$ numeros naturales y un numero $k$, encontrar un subconjunto $I \subseteq \{1, \ldots, n\}$ con $|I| = k$ que maximice $\sum_{i,j \in I} M_{ij}$.

a) Disenar un algoritmo de backtracking indicando: codificacion de solucion candidata, validez, solucion parcial, extension.
b) Calcular complejidad temporal y espacial.
c) Proponer una poda por optimalidad y mostrar que es correcta.

**Explicacion**

Busqueda en subconjuntos de tamano fijo $k$ de $\{1,\ldots,n\}$: $\binom{n}{k}$ soluciones candidatas. Poda por optimalidad: si la ganancia maxima posible completando la solucion parcial no supera la mejor solucion encontrada, podar.

**Resolucion paso a paso**

**a) Diseno del backtracking:**

- **Codificacion de solucion candidata:** vector $(i_1, i_2, \ldots, i_k)$ con $1 \le i_1 < i_2 < \cdots < i_k \le n$ de longitud exactamente $k$ — representa el subconjunto de indices elegidos.
- **Validez:** $|I| = k$.
- **Solucion parcial:** primer $m < k$ indices elegidos $(i_1, \ldots, i_m)$.
- **Extension:** agregar el siguiente indice $r > i_m$ disponible.

```
MaxSubconjunto(I, m, ultimo, k, n, M, mejor):
  si m = k entonces
    valor = sum_{a,b in I} M[a][b]
    si valor > mejor.valor entonces mejor = (I, valor)
  sino
    para r desde ultimo+1 hasta n:
      I[m+1] = r
      MaxSubconjunto(I, m+1, r, k, n, M, mejor)
```

**b) Complejidad temporal y espacial:**

- **Temporal:** $\binom{n}{k}$ soluciones candidatas. Evaluar cada una cuesta $O(k^2)$ (sumar todas las entradas $M[i][j]$ para $i,j \in I$). Total: $O\!\left(\binom{n}{k} \cdot k^2\right)$.
- **Espacial:** $O(k)$ — solo se mantiene el vector de solucion parcial de profundidad $k$ en la pila.

**c) Poda por optimalidad:**

Definir $\text{cotaSup}(I_{\text{parcial}}) = \text{valorActual} + \text{sumaMaxPosible}$ donde $\text{sumaMaxPosible}$ es la suma de los $k - |I_{\text{parcial}}|$ indices restantes que maximizan $\sum_{a \in I_\text{parcial}, b \in \text{nuevos}} M[a][b] + \sum_{a,b \in \text{nuevos}} M[a][b]$.

**Poda simplificada correcta:** si $\text{valorActual} + \text{sumaMaxRestante} \le \text{mejor.valor}$ → podar, donde $\text{sumaMaxRestante}$ es la suma de todos los $M[a][b]$ con $a$ o $b$ en los indices aun no elegidos (cota superior laxa pero valida).

**Correctitud:** si la cota superior real de cualquier extension no supera el mejor conocido, esa rama nunca mejorara la solucion → es seguro podar.

**Chuleta**
> Subconjuntos de {1..n} de tamanio fijo k, en orden creciente. $\binom{n}{k}$ candidatos, $O(k^2)$ por evaluar → $O(\binom{n}{k} \cdot k^2)$. Poda optimalidad: si valor\_actual + cota\_max\_restante $\le$ mejor → cortar.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 — RutaMinima (TSP)

**Enunciado**

Dada una matriz $D$ de $n \times n$ numeros naturales, encontrar una permutacion $\pi$ de $\{1, \ldots, n\}$ que minimice:
$$D_{\pi(n)\pi(1)} + \sum_{i=1}^{n-1} D_{\pi(i)\pi(i+1)}$$

Ejemplo: $D = \begin{pmatrix} 0 & 1 & 10 & 10 \\ 10 & 0 & 3 & 15 \\ 21 & 17 & 0 & 2 \\ 3 & 22 & 30 & 0 \end{pmatrix}$, $\pi(i) = i$ es optimo.

a) Disenar un algoritmo de backtracking.
b) Calcular complejidad temporal y espacial.
c) Proponer una poda por optimalidad y mostrar que es correcta.

**Explicacion**

TSP (Traveling Salesman Problem) simplificado. Backtracking sobre permutaciones: $O(n!)$ candidatos. Poda por optimalidad: si el costo parcial ya supera la mejor solucion encontrada, abandonar la rama.

Este ejercicio aparece como RutaMinima en [[sintesis/repaso_1P]] con poda por optimalidad demostrada (correctitud por pesos $\geq 0$).

**Resolucion paso a paso**

**a) Algoritmo de backtracking:**

- **Codificacion:** permutacion $\pi = (\pi(1), \ldots, \pi(n))$ de $\{1,\ldots,n\}$.
- **Solucion parcial:** $(\pi(1), \ldots, \pi(k))$ con $k < n$ ciudades ya asignadas.
- **Extension:** agregar cualquier ciudad no visitada como $\pi(k+1)$.
- **Costo parcial:** $\sum_{i=1}^{k-1} D_{\pi(i)\pi(i+1)}$ (suma de aristas del recorrido parcial).

```
TSP(pi, k, costo_parcial, mejor):
  si k = n entonces
    costo_total = costo_parcial + D[pi[n]][pi[1]]
    si costo_total < mejor.costo entonces mejor = (pi, costo_total)
  sino
    para cada ciudad c no visitada en pi:
      TSP(pi + [c], k+1, costo_parcial + D[pi[k]][c], mejor)
```

**b) Complejidad temporal y espacial:**

- **Temporal:** $O(n!)$ — hay $(n-1)!$ permutaciones circulares distintas, pero sin fijar la ciudad inicial son $n!$.
- **Espacial:** $O(n)$ — profundidad maxima del arbol de BT.

**c) Poda por optimalidad:**

Si $\text{costo\_parcial} \ge \text{mejor.costo}$, abandonar la rama.

**Correctitud:** todos los pesos $D_{ij} \ge 0$ (son naturales). Por lo tanto el costo de un recorrido solo puede crecer al agregar mas aristas. Formalmente: para cualquier extension del recorrido parcial, $\text{costo\_final} \ge \text{costo\_parcial} \ge \text{mejor.costo}$. Ninguna extension puede mejorar la solucion optima conocida → es seguro podar sin perder la optimalidad.

**Verificacion con el ejemplo:**

$D = \begin{pmatrix} 0 & 1 & 10 & 10 \\ 10 & 0 & 3 & 15 \\ 21 & 17 & 0 & 2 \\ 3 & 22 & 30 & 0 \end{pmatrix}$, $\pi = (1,2,3,4)$:

Costo $= D_{12} + D_{23} + D_{34} + D_{41} = 1+3+2+3 = 9$.

**Chuleta**
> BT sobre permutaciones. $O(n!)$. Costo parcial acumulado en cada nodo. Poda optimalidad: $\text{costo\_parcial} \ge \text{mejor} \Rightarrow$ cortar. Correctitud: pesos $\ge 0$ → costo monotono creciente.

**¿Aparece en parciales?** 🔴 Si — RutaMinima aparece en el repaso del 1P (poda por optimalidad evaluada)

---

### Ejercicio 5 — PalabrasEnCadena

**Enunciado**

Dada una cadena de letras sin espacios, analizar si se puede subdividir para obtener todas palabras validas. Se tiene una funcion `palabra(c)` que verifica si una cadena es palabra en $O(|c|)$.

a) Dar una funcion recursiva que resuelva el problema.
b) Calcular una cota superior para la complejidad (cantidad de llamadas a `palabra`).
c) Demostrar que el algoritmo es correcto.

Ejemplo: "TDAeslamejormateriadelDC" → "TDA|es|la|mejor|materia|del|DC" (valida); "nosvemoc" no tiene subdivision valida.

**Explicacion**

Backtracking: en cada posicion, intentar todos los prefijos posibles (hasta $n$ posibles cortes). La funcion recursa sobre el sufijo restante. Hay $2^{n-1}$ posibles subdivisiones. Con memoizacion → PD $O(n^2)$.

Este ejercicio aparece como "Separar cadena en palabras" en [[fuerza_bruta_backtracking_practica]] con demostracion por induccion fuerte y complejidad $O(2^n)$.

**Resolucion paso a paso**

**a) Funcion recursiva:**

$$\text{separar}(S) = \begin{cases} \text{True} & |S| = 0 \\ \bigvee_{k=1}^{|S|} \bigl(\text{palabra}(S[1:k]) \wedge \text{separar}(S[k+1:])\bigr) & |S| > 0 \end{cases}$$

Llamado inicial: `separar(S)`. La funcion prueba todos los prefijos posibles $S[1:k]$; si alguno es palabra valida y el sufijo restante es separable, retorna True.

**b) Cota superior de complejidad:**

Sea $T(n)$ el numero de llamadas a `palabra` para una cadena de longitud $n$:

$$T(n) = \sum_{k=1}^{n} T(n-k) + n = \sum_{j=0}^{n-1} T(j) + n$$

Restando $T(n-1) = \sum_{j=0}^{n-2} T(j) + (n-1)$:

$$T(n) - T(n-1) = T(n-1) + 1 \implies T(n) = 2\,T(n-1) + 1$$

$T(n) = O(2^n)$. Como cada llamada a `palabra` cuesta $O(n)$: cota total $O(n \cdot 2^n)$.

**c) Demostracion de correctitud por induccion fuerte sobre $|S| = n$:**

**Predicado:** $P(n)$: para toda cadena $S$ de tamano $n$, `separar(S)` responde correctamente.

**Caso base** $P(0)$: cadena vacia → retorna True. Correcto: no hay mas caracteres que subdividir.

**Caso inductivo:** asumir $P(0), \ldots, P(j)$. Sea $|S| = j+1 > 0$. Dos casos:

- **S es separable:** existe algun $k$ tal que $S[1:k]$ es palabra y $S[k+1:]$ es separable. Por HI, `separar(S[k+1:])` retorna True (longitud $j+1-k \le j$). El AND es True y el OR da True. Correcto.
- **S no es separable:** para cada $k$, o $S[1:k]$ no es palabra, o $S[k+1:]$ no es separable. En el segundo caso, `separar(S[k+1:])` retorna False por HI. El AND es False para todos los $k$, el OR da False. Correcto.

**Chuleta**
> Caso base: $|S|=0$ → True. Recursion: OR sobre todos los prefijos: $\text{palabra}(S[1:k]) \wedge \text{separar}(S[k+1:])$. Complejidad: $O(n \cdot 2^n)$. Demo: induccion fuerte sobre longitud — dos casos (separable / no separable).

**¿Aparece en parciales?** 🔴 Si — aparece como ejercicio de clase practica y en parciales

---

### Ejercicio 6 — ABBOptimos

**Enunciado**

Dado un conjunto de elementos $[n] = \{1, \ldots, n\}$ y una funcion de frecuencia de acceso $f: [n] \to \mathbb{N}$, un arbol binario de busqueda optimo minimiza el costo total de acceso.

a) Escribir una funcion recursiva que devuelva el costo de acceder a todos los elementos usando $f$.
b) Dar una cota superior para la complejidad.
c) Probar que el algoritmo es correcto.

**Explicacion**

La recursion clasica $AO(i,j)$ = costo optimo para el rango $[i,j]$: intentar cada elemento $k$ como raiz, recursar en $[i,k-1]$ y $[k+1,j]$. Complejidad de backtracking: $O(3^n)$ (por el numero de subproblemas de tamano variable). Con PD: $O(n^3)$.

Este ejercicio aparece como "ABB optimo" en [[fuerza_bruta_backtracking_practica]] con demostracion por induccion en $j-i$.

**Resolucion paso a paso**

**a) Funcion recursiva:**

Sea $f(r)$ la frecuencia de acceso al elemento $r$. El costo de un ABB para el rango $[i,j]$ con raiz $r$ es:

- $\sum_{s=i}^{j} f(s)$: costo de bajar un nivel adicional a todos los nodos cuando se agrega una raiz encima
- $AO(i, r-1)$: costo optimo del subarbol izquierdo
- $AO(r+1, j)$: costo optimo del subarbol derecho

$$AO(i, j) = \begin{cases} 0 & i > j \\ \displaystyle\sum_{r=i}^{j} f(r) + \min_{i \le r \le j}\bigl[AO(i, r-1) + AO(r+1, j)\bigr] & \text{si no} \end{cases}$$

Llamado inicial: `AO(1, n)`.

**b) Cota superior de complejidad:**

Cada llamada $AO(i,j)$ genera $j-i+1$ subproblemas. Sea $n = j - i + 1$:

$$T(n) = \sum_{k=1}^{n} \bigl[T(k-1) + T(n-k)\bigr] + O(n) = 2\sum_{k=0}^{n-1} T(k) + O(n)$$

Restando $2T(n-1)$:

$$T(n) - 2T(n-1) = 2T(n-1) + C \implies T(n) = 4T(n-1) + C$$

⚠️ Verificar — la clase practica obtiene $T(n) = 3T(n-1) + C$ usando el mismo truco con $T(n) = 2\sum T(k) + Cn$ y $T(n-1) = 2\sum_{k=0}^{n-2} T(k) + C(n-1)$, restando: $T(n) - T(n-1) = 2T(n-1) + C$. La cota correcta es $O(3^n)$ — ver [[fuerza_bruta_backtracking_practica]] Ejercicio 2.

**c) Demostracion de correctitud por induccion sobre $j - i$:**

**Predicado:** $P(m)$: `AO(i,j)` computa el costo del ABB optimo para todo rango con $j - i = m$.

**Caso base** $P(-1)$: $i > j$ → retorna 0. Correcto: rango vacio, costo 0.

**Caso inductivo:** asumir $P(0), \ldots, P(m)$. Para $j - i = m+1 > 0$: al fijar la raiz $r \in [i,j]$, el subarbol izquierdo tiene $j-i = r-i-1 \le m$ y el derecho $j-r-1 \le m$. Por HI, $AO(i, r-1)$ y $AO(r+1, j)$ se calculan correctamente. El minimo sobre todos los $r$ posibles da el costo optimo. Cualquier ABB optimo tiene alguna raiz $r^*$; la funcion lo considera y calcula su costo correctamente → el minimo es el optimo global.

**Chuleta**
> $AO(i,j) = \sum f(r) + \min_r [AO(i,r-1) + AO(r+1,j)]$. Base: $i > j \to 0$. Complejidad: $O(3^n)$. Demo: induccion sobre $j-i$, HI aplica a subtrees de tamano menor.

**¿Aparece en parciales?** 🔴 Si — ABB optimo es ejercicio de clase practica

---

### Ejercicio 7 — Dobra

**Enunciado**

Dobra crea palabras escribiendo una cadena "buena" y reemplazando algunos caracteres con guiones bajos (`_`). Luego intenta reemplazar los `_` con letras para crear palabras lindas. Una palabra es "buena" si: no tiene 3 vocales consecutivas, no tiene 3 consonantes consecutivas, y contiene al menos una E.

a) Mostrar alguna solucion candidata y solucion parcial.
b) Proponer una funcion recursiva y estimar su complejidad (asumiendo funcion `verificar` en $O(1)$).
c) Probar correctitud.
d) Proponer al menos una poda por factibilidad.
e) Si la complejidad de b) no es $O(3^n)$, analizar separando la recursion en tener o no una E.

**Explicacion**

Backtracking sobre reemplazos de guiones bajos: 26 posibilidades por posicion con `_`. Las podas clave son: i) no tener 3 vocales/consonantes consecutivas (chequear inmediatamente al colocar una letra), ii) separar si ya se tiene o no una E para la condicion obligatoria. Complejidad con poda de E: $O(n \cdot 2^n)$ (una rama con E garantizada, otra sin).

Este ejercicio aparece en [[fuerza_bruta_backtracking_practica]] como "Dobra palabras buenas".

**Resolucion paso a paso**

**a) Solucion candidata y solucion parcial:**

- **Solucion candidata:** una cadena de longitud $n$ donde cada posicion con `_` fue reemplazada por una letra del abecedario. Ej: `"a_e_"` → `"abec"` es candidata.
- **Solucion parcial:** los primeros $k < n$ caracteres definidos (las posiciones `_` anteriores ya resueltas, las posteriores aun con `_`).

**b) Funcion recursiva y complejidad:**

```
Dobra(S, i, hayE):
  si i = n entonces retornar (1 si hayE, 0 si no)
  si S[i] != '_' entonces
    si es valido localmente entonces
      retornar Dobra(S, i+1, hayE or S[i]='E')
    sino retornar 0
  sino  // S[i] = '_'
    total = 0
    para c en ABC:
      S[i] = c
      si no viola regla local (3 vocales/consonantes) entonces
        total += Dobra(S, i+1, hayE or c='E')
    retornar total
```

Sin podas (todos `_`): $T(n) = 26\,T(n-1) + O(1)$ → $O(26^n)$.

Con poda de estado local (no 3 vocales/consonantes consecutivas): a lo sumo 3 ramas por comodin (vocal/consonante/ambas segun contexto) → $T(n) \le 3\,T(n-1) + O(1)$ → $O(3^n)$.

Con separacion por E (branch: "ya tengo E" / "todavia no tengo E"): para la rama sin E, en alguna posicion con `_` se fuerza una E. Si hay $p$ comodines, hay $p$ opciones de posicion para la E. Cada eleccion + el resto con 2 opciones → $O(n \cdot 2^n)$.

**c) Correctitud por induccion sobre el prefijo procesado $i$:**

**Predicado:** $P(i)$: `Dobra(S, i, hayE)` cuenta correctamente las palabras buenas formadas por los sufijos validos de $S[i:]$ dado el estado actual (ultimas dos letras, `hayE`).

**Caso base** $P(n)$: retorna 1 si `hayE` y 0 si no. Correcto: la cadena esta completa; se verifica la condicion de la E.

**Caso inductivo:** asumir $P(i+1)$. En la posicion $i$:
- Si no es `_`: el caracter ya esta fijo. Si viola la regla local, retorna 0. Si no, pasa al siguiente con el estado actualizado — por HI, $P(i+1)$ es correcto.
- Si es `_`: se itera sobre todas las letras validas localmente. Para cada letra $c$ valida, se actualiza el estado y se llama a $P(i+1)$ — correcto por HI. La suma da el conteo total correcto.

**d) Poda por factibilidad:**

- **Poda 1 (estado local):** si las ultimas dos letras colocadas son ambas vocales, el siguiente caracter solo puede ser consonante (y vice versa). Elimina ~20 de las 26 opciones en cada paso.
- **Poda 2 (E alcanzable):** si no hay ninguna E hasta el momento (`hayE = False`) y no quedan posiciones con `_` por delante, la cadena no puede ser buena → retornar 0 inmediatamente.

**e) Con separacion por E → $O(n \cdot 2^n)$:**

Una vez que `hayE = True`, el estado solo tiene 2 dimensiones (vocal/consonante consecutiva), dando $T(n) = 2\,T(n-1)$ → $O(2^n)$. La primera vez que se fuerza una E hay a lo sumo $n$ posiciones posibles → total $O(n \cdot 2^n)$.

**Chuleta**
> **Estado:** (posicion, ultimas 2 letras tipo, hayE). **Ramas:** vocal/consonante, distinguir E. **Poda local:** no 3 vocales/consonantes → a lo sumo 2 ramas por comodin. **Separacion E:** complejidad $O(n \cdot 2^n)$. **Demo:** induccion sobre prefijo, base = cadena completa.

**¿Aparece en parciales?** 🔴 Si — Dobra es ejercicio de clase practica

---

### Ejercicio 8 — CadenasDeAdicion

**Enunciado**

Dado un entero $n$, una cadena de adicion $C = \{x_1, \ldots, x_k\}$ cumple:
- $1 = x_1 < x_2 < \ldots < x_k = n$
- Para cada $2 \leq j \leq n$ existen $k_1, k_2 < j$ tal que $x_{k_1} + x_{k_2} = x_j$

a) Encontrar un algoritmo de backtracking que encuentre la cadena de adicion de longitud minima.
b) Proponer al menos una poda por optimalidad y otra por factibilidad.

**Explicacion**

Busqueda en subconjuntos de $\{1, \ldots, n\}$ con estructura acumulativa. Complejidad: $O(n^2 \cdot 2^n)$ sin podas. Poda por optimalidad: si $|C| \geq$ longitud de la mejor solucion encontrada, abandonar. Poda por factibilidad: si la suma maxima alcanzable (duplicando repetidamente el maximo actual) no llega a $n$, abandonar.

Este ejercicio aparece en [[fuerza_bruta_backtracking_practica]] con podas de factibilidad y optimalidad.

**Resolucion paso a paso**

**a) Algoritmo de backtracking:**

Representar la cadena de adicion como un subconjunto creciente de $\{1,\ldots,n\}$ que incluye 1 y $n$. Se construye incrementalmente agregando el siguiente elemento.

```
CadenasAdicion(C, n, mejor):
  si C.ultimo() = n entonces
    si |C| < |mejor| entonces mejor = C
    retornar
  sino
    para cada par (x1, x2) en C × C con x1 <= x2:
      siguiente = x1 + x2
      si siguiente > C.ultimo() y siguiente <= n entonces
        CadenasAdicion(C + {siguiente}, n, mejor)
```

Llamado inicial: `CadenasAdicion({1}, n, infinito)`.

En cada paso se generan a lo sumo $|C|^2$ extensiones. Como $|C| \le n$, hay a lo sumo $n^2$ sucesores por nodo. El arbol tiene profundidad $O(n)$ → $O(n^2 \cdot 2^n)$ nodos en peor caso (acotando por $2^n$ subconjuntos de $\{1,\ldots,n\}$ y $O(n^2)$ de verificacion).

**b) Podas:**

**Poda por factibilidad 1 — n debe ser alcanzable:**

Si el elemento maximo de $C$ es $m$, la forma mas rapida de alcanzar $n$ es duplicando en cada paso: tras $r$ pasos mas, el maximo posible es $m \cdot 2^r$. Si quedan $r = |mejor| - |C| - 1$ pasos permitidos y $m \cdot 2^r < n$, podar.

Formalmente: si $C.\text{max}() \cdot 2^{|mejor| - |C| - 1} < n$ → retornar.

**Poda por optimalidad:**

Si $|C| \ge |\text{mejor}|$, cualquier extension producira una cadena igual de larga o mas → podar.

```
si |C| >= |mejor| entonces retornar
```

**Chuleta**
> Construir subconjunto creciente desde {1} hasta n, sumando pares de elementos existentes. Poda optimalidad: $|C| \ge |\text{mejor}| \Rightarrow$ cortar. Poda factibilidad: si maximo actual $\times\, 2^{\text{pasos restantes}} < n \Rightarrow$ cortar. Complejidad sin podas: $O(n^2 \cdot 2^n)$.

**¿Aparece en parciales?** ⚪ No

## Ver tambien

- [[fuerza_bruta_backtracking_teoria]] — Pseudocodigo generico de BT, branch & bound
- [[fuerza_bruta_backtracking_practica]] — Ejercicios resueltos en clase
- [[programacion_dinamica_guia]] — Seccion de PD de la misma guia (ej. 9-26): BT → PD via memoizacion
