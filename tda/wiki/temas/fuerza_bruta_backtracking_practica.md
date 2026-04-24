---
nombre: Fuerza Bruta & Backtracking — Clase Practica
parcial: 1P
tipo: practica
tema: fuerza_bruta_backtracking
fuente: raw/clases/prac/2.prac_1P_backtracking_handout.pdf
paginas_relacionadas:
  - "[[fuerza_bruta_backtracking_teoria]]"
  - "[[definiciones_y_demostraciones_teoria]]"
  - "[[fuerza_bruta_backtracking_guia]]"
---

# Fuerza Bruta & Backtracking — Clase Practica

> Handout (formato LaTeX, no Beamer). 6 paginas, 4 ejercicios. Fuente adicional: `raw/clases/prac/2.prac_1P_backtracking_slides.pdf` (5569 chars, Beamer builds — contenido incluido en el handout).

## Patrones de este tema en parciales
> [[tipos_ejercicio/bt_complejidad_backtracking]]

---

## Ejercicios de clase

### Ejercicio 1 — Separar cadena en palabras

**Enunciado**
Dada una cadena de letras sin espacios, verificar si se puede subdividir para obtener palabras validas. Se tiene una funcion `palabra: [a,z]* → bool` que verifica si una cadena es palabra valida en $O(n)$.

a) Dar una funcion recursiva que resuelva el problema.
b) Calcular una cota superior para la complejidad.
c) Demostrar que el algoritmo es correcto.

**Explicacion**
Backtracking sobre todas las posibles particiones de la cadena. La clave es la induccion fuerte sobre la longitud — los subproblemas son cadenas de tamano estrictamente menor.

**Resolucion paso a paso**

**a) Funcion recursiva:**

$$\text{separar}(S) = \begin{cases} \text{True} & |S| = 0 \\ \bigvee_{k=1}^{|S|} \left(\text{separar}(S[k+1:]) \wedge \text{palabra}(S[:k])\right) & |S| > 0 \end{cases}$$

Llamado inicial: `separar(S)`.

**b) Complejidad — truco de restarsele un elemento:**

$$T(n) = \sum_{k=0}^{n-1} T(k) + O(n)$$

Comparando con $T(n-1) = \sum_{k=0}^{n-2} T(k) + C(n-1)$ y restando:

$$T(n) - T(n-1) = T(n-1) + C \implies T(n) = 2T(n-1) + C$$

Arbol binario balanceado completo de altura n → $T(n) = O(2^n)$.

Cota final: $O(\text{costo}(\text{palabra}(n)) \cdot 2^n)$.

**c) Demostracion por induccion fuerte sobre $|S| = n$:**

**Predicado:** $P(n)$: para toda cadena $S$ de tamano $n$, `separar(S)` responde correctamente.

**Caso base** $P(0)$: cadena vacia → devuelve True, que es correcto (no hay mas que subdividir).

**Caso inductivo:** Asumir $P(n)$ para todo $n \le j$. Para $|S| = j+1 > 0$, caemos en el segundo caso. Dos subcasos:

- **S subdividible:** existe un $k$ que da el primer prefijo. `palabra(S[:k])` devuelve True y `separar(S[k:])` devuelve True por HI (ya que $|S[k:]| < j+1$). El AND de dos True es True.
- **S no subdividible:** para cada $k$, si `palabra(S[:k])` es False, listo. Si es True, entonces `separar(S[k:])` debe devolver False — y lo hace por HI ya que $|S[k:]| \le j$ y en ese subfijo no hay subdivision valida.

**Chuleta**
> Caso base: cadena vacia → True. Recursion: OR sobre todos los prefijos validos → True si al menos uno permite subdividir el sufijo. Complejidad: O(2^n). Demo: induccion fuerte sobre longitud, dos casos (S subdividible / no subdividible).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bt_complejidad_backtracking]]

---

### Ejercicio 2 — Arbol Binario de Busqueda Optimo

**Enunciado**
Dado un conjunto $[n]$ y una funcion de frecuencias $f: [n] \to \mathbb{N}$, un arbol binario de busqueda optimo (ABB optimo) minimiza el costo total de accesos segun $f$.

a) Escribir una funcion recursiva que devuelva el costo del ABB optimo.
b) Dar una cota superior para la complejidad.
c) Probar que el algoritmo es correcto.

**Explicacion**
Backtracking: probar cada posible raiz $r$ del subarbol $[i..j]$ y calcular recursivamente el costo del subarbol izquierdo $[i..r-1]$ y derecho $[r+1..j]$. La induccion es sobre $j - i$ (tamano del subarreglo).

**Resolucion paso a paso**

**a) Funcion recursiva:**

$$AO(i, j) = \begin{cases} 0 & i > j \\ \sum_{r=i}^{j} f(r) + \min_{i \le r \le j}\left[AO(i, r-1) + AO(r+1, j)\right] & \text{si no} \end{cases}$$

Llamado inicial: `AO(1, n)`.

**b) Complejidad:**

$$T(n) = \sum_{k=1}^{n} \left[T(k-1) + T(n-k)\right] + O(n) = 2\sum_{k=0}^{n-1} T(k) + Cn$$

Usando el mismo truco que el ejercicio 1:

$$T(n) - T(n-1) = 2T(n-1) + C \implies T(n) = 3T(n-1) + C$$

Por lo tanto $T(n) = O(3^n)$.

**c) Demostracion por induccion sobre $j - i$:**

**Predicado:** $P(n)$: `AO(i, j)` computa el costo del ABB optimo para todo arreglo de tamano $j - i = n$.

**Caso base** $P(0)$: $j - i = 0$ (un elemento). La funcion cae en el paso recursivo pero las llamadas internas retornan 0 (rango vacio, $i > j$ en cada rama), sumando solo $f(i)$. Correcto: un arbol de un nodo tiene costo $f(i)$.

**Caso inductivo:** Asumir $P(0), \ldots, P(k)$. Para $j - i = k+1 > 0$: al fijar la raiz $r$, los subtrees son de tamano $(r-i)$ y $(j-r)$, ambos $\le k$, por HI se calculan correctamente. El minimo sobre todos los $r$ posibles es el optimo.

**Chuleta**
> AO(i,j): suma f[r] para todo r en [i,j] + min sobre r de AO(i,r-1) + AO(r+1,j). Complejidad: O(3^n). Demo: induccion sobre j-i, HI aplica a subtrees de tamano menor.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bt_complejidad_backtracking]]

---

### Ejercicio 3 — Dobra (Palabras Buenas con Comodines)

**Enunciado**
Dobra considera una palabra "buena" si: (i) no contiene 3 vocales consecutivas, (ii) no contiene 3 consonantes consecutivas, (iii) contiene al menos una E.
Dada una cadena con comodines (`_`), calcular cuantas palabras buenas se pueden formar reemplazando los comodines con letras.

a) Mostrar solucion candidata y solucion parcial.
b) Proponer funcion recursiva y estimar complejidad.
c) Probar correctitud.
d) Proponer al menos una poda por factibilidad.
e) Analizar si la complejidad mejora separando en tener o no una E.

**Explicacion**
Backtracking con comodines. La solucion naive es exponencial en 26. Las podas y la separacion por "hay o no E" reducen drasticamente el espacio.

**Resolucion paso a paso**

**b) Funcion recursiva (sin podas):**

$$\text{Dobra}(S, i) = \begin{cases} \text{verificar}(S) & i = n \\ \text{Dobra}(S, i+1) & S[i] \ne \_ \\ \sum_{c \in \text{ABC}} \text{Dobra}(S[i] \leftarrow c, i+1) & S[i] = \_ \end{cases}$$

Peor caso (todos comodines): $T(n) = 26T(n-1)$ → $O(n \cdot 26^n)$ con el costo de `verificar` en hojas.

**d) Poda por factibilidad — version optimizada:**

En lugar de probar las 26 letras y llamar a `verificar` al final, llevar el historial de estado "en linea":
- Si ya hay 2 vocales consecutivas, la siguiente solo puede ser consonante.
- Si ya hay 2 consonantes consecutivas, la siguiente solo puede ser vocal.
- Trackear si ya se coloco una E (`hayE`).
- Descartar la solucion si al final `hayE = False`.

La funcion resultante tiene solo 3 ramas (vocal/consonante/E como caso especial):

$$\text{Dobra}(S, i, hayE) = \begin{cases}
1 & i = n \wedge hayE \\
\text{Dobra}(S, i+1, hayE \vee S[i]=E) & S[i] \ne \_ \wedge \text{combinacion valida} \\
4\cdot\text{Dobra}(\ldots, hayE) + \text{Dobra}(\ldots, \text{True}) & S[i] = \_ \wedge \text{solo vocal valida} \\
21\cdot\text{Dobra}(\ldots, hayE) & S[i] = \_ \wedge \text{solo consonante} \\
4\cdot\text{Dobra}(\ldots) + 21\cdot\text{Dobra}(\ldots) + \text{Dobra}(\ldots, \text{True}) & S[i] = \_ \wedge \text{ambas validas} \\
0 & \text{caso contrario}
\end{cases}$$

Peor caso acotado por $T(n) = 3T(n-1)$ → $O(3^n)$.

**e) Separacion por E:** Una vez que `hayE = True`, no hace falta seguir separando — cada posicion tiene 2 opciones (vocal/consonante). Esto da $T(n) = 2T(n-1)$ → $O(n \cdot 2^n)$ (el factor $n$ viene de las $n$ elecciones de donde poner la E).

**c) Correctitud:** Induccion sobre el tamano del prefijo $k$. Caso base $P(0)$: calcula si la palabra entera es valida (llamada con sufijo vacio). Caso inductivo: si comodines pueden producir un estado valido, la funcion lo cuenta; si no, retorna 0. En ambos casos la HI sobre el sufijo siguiente garantiza la cuenta correcta.

**Chuleta**
> Trackear: contador de vocales/consonantes consecutivas + hayE. Ramificar: vocal/consonante/E. Poda: si configuracion local es invalida, retornar 0. Complejidad con poda: O(n·2^n).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/bt_complejidad_backtracking]]

---

### Ejercicio 4 — Cadenas de Adicion

**Enunciado**
Dado un entero $n$, una *cadena de adicion* $C = \{x_1, \ldots, x_k\}$ cumple:
- $1 = x_1 < x_2 < \cdots < x_k = n$
- Para cada $2 \le j \le k$: existen $k_1, k_2 < j$ tal que $x_{k_1} + x_{k_2} = x_j$

a) Encontrar un algoritmo de backtracking que encuentre la cadena de adicion de longitud minima.
b) Dar podas por factibilidad/optimalidad.

**Explicacion**
El espacio de soluciones es $\mathcal{P}([n])$. Se puede iterar representando subconjuntos como enteros de 0 a $2^n - 1$. Verificar si un subconjunto es cadena de adicion cuesta $O(n^2)$.

**Resolucion paso a paso**

**a) Algoritmo:**

Iterar sobre todos los subconjuntos de $\{1, \ldots, n\}$ (representados como enteros de 0 a $2^n$). Para cada subconjunto verificar:
- El primer elemento es 1
- El ultimo elemento es n
- Cada elemento se puede expresar como suma de dos anteriores

Complejidad total: $O(n^2 \cdot 2^n)$ — por $2^n$ subconjuntos × $O(n^2)$ de verificacion.

**b) Podas:**

- **Poda por factibilidad 1:** el bit $n$ debe estar encendido (la cadena debe contener $n$). Descartar subconjuntos sin el bit $n$ sin verificar → ahorra la mitad.
- **Poda por optimalidad:** si el subconjunto actual tiene mas bits que la mejor solucion encontrada hasta ahora, descartarlo. Aunque sea una cadena valida, sera mas larga → no optima.

**Chuleta**
> Iterar subconjuntos de {1,...,n}. Verificar: 1 esta, n esta, cada elemento es suma de dos anteriores. Poda factibilidad: bit n encendido. Poda optimalidad: bits usados < mejor actual. Complejidad: O(n^2 * 2^n).

**¿Aparece en parciales?** ⚪ No

---

## Ver tambien
- [[fuerza_bruta_backtracking_teoria]] — Backtracking generico, branch & bound, mochila, n-damas
- [[definiciones_y_demostraciones_teoria]] — Induccion fuerte, estrategias de demostracion
- [[fuerza_bruta_backtracking_guia]] — Guia de ejercicios del tema
