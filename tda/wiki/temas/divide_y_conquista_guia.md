---
nombre: Divide & Conquer — Guia de Ejercicios
parcial: 1P
programa: 2C_2026
tipo: guia
tema: divide_y_conquista
fuentes:
  vigente: []
  historico:
    - raw/guias_practicas/1.guia_1P_divide_&_conquer.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[divide_y_conquista_teoria]]"
  - "[[divide_y_conquista_practica]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Divide & Conquer — Guia de Ejercicios

Practica 1. Objetivos: introducir D&C, identificar pasos (divide/conquer/combine), optimizaciones, calcular complejidad de recursiones con Teorema Maestro. Ejercicios con ⋆ forman el subconjunto minimo recomendado.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 ⋆ | MergeSort — analisis completo | 🔴 Si |
| Ej. 2 ⋆ | BusquedaBinaria — analisis completo | 🔴 Si |
| Ej. 3 ⋆ | IzquierdaDominante — disenar D&C, O(n) estricto | ⚪ No |
| Ej. 4 ⋆ | IndiceEspejo — buscar $a_i = i$, sublineal | ⚪ No |
| Ej. 5 ⋆ | PotenciaLogaritmica — calcular $a^b$ en $O(\log b)$ | ⚪ No |
| Ej. 6 | MaximoMontana — arreglo montania, O(log n) | 🔴 Si |
| Ej. 7 ⋆ | ComplexityQuest — 12 recurrencias con TM | 🔴 Si |
| Ej. 8 ⋆ | MaximaSubsecuencia — suma maxima contigua, O(n log n) | 🔴 Si |
| Ej. 9 ⋆ | PotenciaSum — $A^1 + A^2 + \ldots + A^n$ en O(log n) operaciones | ⚪ No |
| Ej. 10 ⋆ | DistanciaMaxima — arbol binario, maxima distancia entre nodos | ⚪ No |
| Ej. 11 ⋆ | DesordenSort — parejas en desorden (inversiones), O(n log n) | ⚪ No |
| Ej. 12 ⋆ | CazadorDeFalsos — matriz booleana, hallar/contar false en o(n²) | ⚪ No |
| Ej. 13 | MergeSelectivo — i-esimo elemento del merge, O(log² n) | ⚪ No |
| Ej. 14 | DiferenciaMinima — minima diferencia absoluta de posiciones, O(log n) | 🔴 Si |
| Ej. 15 | SubBusqueda — hallar indice en arreglo, sublineal | ⚪ No |
| Ej. 16 | L-Tetris — rellenar tablero n×n con piezas L via D&C | ⚪ No |

## Patrones de este tema en parciales

> Recurrencias con TM · Diseno de D&C con caso cruzado · Busqueda binaria en variantes

## Ejercicios

### Ejercicio 1 ⋆ — MergeSort

**Enunciado**

Dado el algoritmo de mergesort (codigo Python con `merge` y `merge_sort` dados), responder:

1. Identificar que lineas son el divide, el conquer y el combine.
2. ¿En cuantos subproblemas se divide?
3. ¿De que tamano son estos subproblemas?
4. ¿Cual es el costo de combinar los resultados?
5. Escribir $T(n)$ de manera recursiva.
6. Determinar la complejidad usando el Teorema Maestro.

**Explicacion**

Analisis canonico de D&C. $T(n) = 2T(n/2) + \Theta(n)$ — Caso 2 del TM ($a=2$, $b=2$, $f(n) = \Theta(n)$, $n^{\log_2 2} = n$) → $\Theta(n \log n)$.

**Resolucion paso a paso**

```python
def merge_sort(A):
    if len(A) <= 1:          # caso base
        return A
    mid = len(A) // 2        # DIVIDE: partir en dos mitades
    left  = merge_sort(A[:mid])   # CONQUER: resolver mitad izquierda
    right = merge_sort(A[mid:])   # CONQUER: resolver mitad derecha
    return merge(left, right)     # COMBINE: fusionar resultados
```

1. **Divide:** `mid = len(A) // 2`.
2. **Conquer:** dos llamadas recursivas a `merge_sort`.
3. **Combine:** `merge(left, right)` — recorre ambas mitades una vez: $\Theta(n)$.
4. **Cantidad de subproblemas:** $a = 2$.
5. **Tamano de cada subproblema:** $n/2$.
6. **Recurrencia:**

$$T(n) = 2T(n/2) + \Theta(n), \quad T(1) = \Theta(1)$$

7. **Teorema Maestro:** $a=2$, $c=2$, $f(n) = \Theta(n) = \Theta(n^{\log_2 2}) = \Theta(n^1)$ → **Caso 2** → $T(n) = \Theta(n \log n)$.

**Chuleta**

> $T(n) = 2T(n/2) + \Theta(n)$. TM Caso 2 ($a=c=2$, $f(n)=\Theta(n^1)$) → $\Theta(n \log n)$.

**¿Aparece en parciales?** 🔴 Si — recurrencia de MergeSort es ejemplo canonico evaluado

---

### Ejercicio 2 ⋆ — BusquedaBinaria

**Enunciado**

Dado el algoritmo de busqueda binaria (codigo Python con `busqueda_binaria` dado), responder:

1. Identificar divide, conquer y combine.
2. ¿En cuantos subproblemas se divide?
3. ¿De que tamano son estos subproblemas?
4. ¿Cual es el costo de combinar?
5. Escribir $T(n)$ de manera recursiva.
6. Determinar la complejidad usando el Teorema Maestro.

**Explicacion**

$T(n) = T(n/2) + \Theta(1)$ — Caso 2 del TM ($a=1$, $b=2$, $f(n) = \Theta(1)$, $n^{\log_2 1} = n^0 = 1$) → $\Theta(\log n)$.

**Resolucion paso a paso**

```python
def busqueda_binaria(A, e, i, j):
    if i > j:
        return -1
    mid = (i + j) // 2           # DIVIDE: encontrar punto medio
    if A[mid] == e:
        return mid
    elif A[mid] < e:
        return busqueda_binaria(A, e, mid+1, j)  # CONQUER: mitad derecha
    else:
        return busqueda_binaria(A, e, i, mid-1)  # CONQUER: mitad izquierda
    # COMBINE: ninguno — el subproblema resuelto es la solucion directamente
```

1. **Divide:** `mid = (i+j)//2`.
2. **Conquer:** 1 llamada recursiva (en la mitad relevante).
3. **Combine:** ninguno ($\Theta(1)$).
4. **Cantidad de subproblemas:** $a = 1$.
5. **Tamano:** $n/2$.
6. **Recurrencia:**

$$T(n) = T(n/2) + \Theta(1), \quad T(1) = \Theta(1)$$

7. **Teorema Maestro:** $a=1$, $c=2$, $f(n) = \Theta(1) = \Theta(n^{\log_2 1}) = \Theta(n^0)$ → **Caso 2** → $T(n) = \Theta(\log n)$.

**Chuleta**

> $T(n) = T(n/2) + \Theta(1)$. TM Caso 2 ($a=1, c=2$, $f(n)=\Theta(1)=\Theta(n^0)$) → $\Theta(\log n)$.

**¿Aparece en parciales?** 🔴 Si — recurrencia de BusquedaBinaria evaluada en parciales

---

### Ejercicio 3 ⋆ — IzquierdaDominante

**Enunciado**

Escribir un algoritmo D&C que determine si un arreglo de tamano potencia de 2 es "mas a la izquierda", donde esto significa:
- La suma de los elementos de la mitad izquierda supera a la de la mitad derecha.
- Cada una de las mitades es a su vez "mas a la izquierda".

Por ejemplo, $[8, 6, 7, 4, 5, 1, 3, 2]$ es "mas a la izquierda", pero $[8, 4, 7, 6, 5, 1, 3, 2]$ no lo es. La complejidad debe ser estrictamente menor a $O(n^2)$.

**Explicacion**

D&C con caso base (arreglo de 1 elemento → siempre dominante) y paso inductivo: verificar condicion de suma en raiz + recursion en ambas mitades. Se puede obtener $O(n)$ si se computa la suma simultaneamente con la verificacion.

**Resolucion paso a paso**

La idea: hacer recursion en ambas mitades y que cada llamada devuelva no solo el booleano sino tambien la suma del subarreglo. Asi se computa la suma de cada mitad en $O(1)$ adicional usando las sumas retornadas por las llamadas recursivas.

```python
def izquierda_dominante(A, i, j):
    """
    Retorna (es_dominante: bool, suma: int).
    Un arreglo de un elemento siempre es dominante.
    """
    if i == j:
        return (True, A[i])
    mid = (i + j) // 2
    dom_izq, suma_izq = izquierda_dominante(A, i, mid)
    dom_der, suma_der = izquierda_dominante(A, mid + 1, j)
    es_dominante = dom_izq and dom_der and (suma_izq > suma_der)
    return (es_dominante, suma_izq + suma_der)
```

**Recurrencia:** $T(n) = 2T(n/2) + O(1)$.

**TM:** $a=2$, $c=2$, $f(n) = O(1) = O(n^{\log_2 2 - \epsilon})$ para $\epsilon=1$ → **Caso 1** → $T(n) = \Theta(n)$.

**Correctitud:** Para $n=1$, trivialmente dominante. Para $n > 1$: el arreglo es dominante si y solo si ambas mitades lo son Y la suma de la izquierda supera a la de la derecha. Esto es exactamente la definicion, y se puede computar en $O(1)$ dado las sumas de las mitades.

**Chuleta**

> Retornar (bool, suma). Caso base: $(True, A[i])$. Paso: recursar en mitades, verificar ambas dominantes y suma_izq > suma_der. $T(n) = 2T(n/2) + O(1) = \Theta(n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 4 ⋆ — IndiceEspejo

**Enunciado**

Tenemos un arreglo $a = [a_1, a_2, \ldots, a_n]$ de $n$ enteros distintos en orden estrictamente creciente. Determinar si existe una posicion $i$ tal que $a_i = i$. Por ejemplo, en $[-4, -1, 2, 4, 7]$, $i = 4$ es esa posicion.

Disenar un algoritmo D&C eficiente de complejidad estrictamente menor que lineal.

**Explicacion**

Observacion clave: si $a_{mid} > mid$ entonces la solucion (si existe) esta en la mitad izquierda; si $a_{mid} < mid$, esta en la mitad derecha. Esto es busqueda binaria: $T(n) = T(n/2) + O(1) \Rightarrow O(\log n)$.

**Resolucion paso a paso**

**Invariante:** si $a[mid] > mid$, entonces para todo $k > mid$: $a[k] \geq a[mid] + (k - mid) > mid + (k - mid) = k$. Por lo tanto $a[k] > k$ para todo $k > mid$ — no hay solucion a la derecha. Analogamente para $a[mid] < mid$.

```python
def indice_espejo(A, i=None, j=None):
    if i is None: i = 0
    if j is None: j = len(A) - 1
    # Convencion: indices 0-based, buscamos A[i] == i
    if i > j:
        return -1
    mid = (i + j) // 2
    if A[mid] == mid:
        return mid
    elif A[mid] > mid:
        return indice_espejo(A, i, mid - 1)   # solucion a la izquierda
    else:
        return indice_espejo(A, mid + 1, j)   # solucion a la derecha
```

**Recurrencia:** $T(n) = T(n/2) + O(1) \Rightarrow O(\log n)$.

**Chuleta**

> Si $A[mid] > mid$: ir a la izquierda. Si $A[mid] < mid$: ir a la derecha. Invariante: enteros distintos crecientes → el desplazamiento respecto al indice es monotono. $T(n) = T(n/2)+O(1) = O(\log n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 ⋆ — PotenciaLogaritmica

**Enunciado**

Encontrar un algoritmo para calcular $a^b$ en tiempo logaritmico en $b$. Pensar como reutilizar resultados ya calculados. Justificar la complejidad.

**Explicacion**

Exponenciacion rapida: si $b$ es par, $a^b = (a^{b/2})^2$; si impar, $a^b = a \cdot a^{b-1}$. $T(b) = T(b/2) + O(1) \Rightarrow O(\log b)$.

**Resolucion paso a paso**

```python
def potencia(a, b):
    if b == 0:
        return 1
    if b % 2 == 0:
        mitad = potencia(a, b // 2)
        return mitad * mitad          # reutilizar: (a^(b/2))^2
    else:
        return a * potencia(a, b - 1) # a * a^(b-1)
```

**Correctitud:**
- $b=0$: $a^0 = 1$. ✓
- $b$ par: $a^b = (a^{b/2})^2$. Se computa $a^{b/2}$ una vez y se eleva al cuadrado.
- $b$ impar: $a^b = a \cdot a^{b-1}$. Como $b-1$ es par, la llamada siguiente divide.

**Recurrencia:** En ambos casos el argumento se divide por 2 (o se reduce 1 seguido de dividir por 2). Hay a lo sumo $2 \log b$ llamadas recursivas. $T(b) = O(\log b)$.

**Chuleta**

> $a^b$: si $b$ par → $(a^{b/2})^2$ (llamar una sola vez a `potencia(a, b//2)`); si impar → $a \cdot a^{b-1}$. $O(\log b)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 6 — MaximoMontana

**Enunciado**

Un arreglo se denomina montania si esta compuesto por una secuencia estrictamente creciente seguida de una estrictamente decreciente. Dado un arreglo montania de longitud $n$, dar un algoritmo que encuentre el maximo en complejidad $O(\log n)$.

Por ejemplo, para $[-1, 3, 8, 22, 30, 22, 8, 4, 2, 1]$, el maximo esta en posicion 4 y vale 30.

**Explicacion**

Busqueda ternaria o binaria con invariante unimodal: si $A[mid] < A[mid+1]$, el maximo esta a la derecha; si $A[mid] < A[mid-1]$, esta a la izquierda. $T(n) = T(n/2) + O(1) \Rightarrow O(\log n)$.

Este ejercicio aparece resuelto en [[divide_y_conquista_practica]].

**Resolucion paso a paso**

**Invariante:** El maximo esta siempre en el rango $[i, j]$ actual.

```python
def maximo_montana(A, i=None, j=None):
    if i is None: i = 0
    if j is None: j = len(A) - 1
    if i == j:
        return A[i]
    mid = (i + j) // 2
    if A[mid] < A[mid + 1]:
        # Estamos en la parte creciente: el maximo esta a la derecha
        return maximo_montana(A, mid + 1, j)
    else:
        # A[mid] >= A[mid+1]: estamos en la parte decreciente o en el pico
        # El maximo esta en [i, mid]
        return maximo_montana(A, i, mid)
```

**Correctitud:**
- Si $A[mid] < A[mid+1]$: el pico esta a la derecha de $mid$ (la funcion aun sube).
- Si $A[mid] > A[mid+1]$: el pico esta a la izquierda de $mid+1$ (la funcion ya baja o $mid$ es el pico). En ambos casos el maximo esta en el subintervalo al que se recursa.

**Recurrencia:** $T(n) = T(n/2) + O(1)$.

**TM:** $a=1$, $c=2$, $f(n) = O(1)$ → Caso 2 → $T(n) = \Theta(\log n)$.

**Chuleta**

> Si $A[mid] < A[mid+1]$: recursar derecha. Sino: recursar izquierda (incluyendo $mid$). $T(n) = T(n/2)+O(1) = O(\log n)$.

**¿Aparece en parciales?** 🔴 Si — MaximoMontana es ejercicio de clase practica, aparece en examen

---

### Ejercicio 7 ⋆ — ComplexityQuest

**Enunciado**

Calcular la complejidad de algoritmos con las siguientes recurrencias $T(n)$:

1. $T(n) = T(n-2) + 5$
2. $T(n) = T(n-1) + n$
3. $T(n) = T(n-1) + \sqrt{n}$
4. $T(n) = T(n-1) + n^2$
5. $T(n) = 2T(n-1)$
6. $T(n) = T(n/2) + n$
7. $T(n) = T(n/2) + \sqrt{n}$
8. $T(n) = T(n/2) + n^2$
9. $T(n) = 2T(n-4)$
10. $T(n) = 2T(n/2) + \log n$
11. $T(n) = 3T(n/4)$
12. $T(n) = 3T(n/4) + n$

Intentar estimar directamente y luego calcular con Teorema Maestro donde aplique.

**Explicacion**

Ejercicio de calculo sistematico. Las recurrencias 1-5 y 9 son de tipo $T(n) = aT(n-b) + f(n)$ (no aplica TM directamente — se resuelven por sustitucion o arbol de recursion). Las recurrencias 6-8 y 10-12 son de tipo TM.

Resultados clave:
- (6): $T(n) = T(n/2) + n$ → Caso 3 TM, $\Theta(n)$
- (10): $T(n) = 2T(n/2) + \log n$ → Caso 1 TM ($\log n \ll n$), $\Theta(n)$
- (11): $T(n) = 3T(n/4)$ → Caso 1 TM, $\Theta(n^{\log_4 3})$
- (12): $T(n) = 3T(n/4) + n$ → Caso 3 TM, $\Theta(n)$

**Resolucion paso a paso**

**Recurrencias de tipo $T(n) = aT(n-b) + f(n)$ (no aplica TM):**

**(1) $T(n) = T(n-2) + 5$:** Por sustitucion: $T(n) = T(n-2k) + 5k$. Con $k = \lfloor n/2 \rfloor$: $T(n) = T(r) + 5\lfloor n/2 \rfloor = \Theta(n)$.

**(2) $T(n) = T(n-1) + n$:** Telescopando: $T(n) = \sum_{i=1}^n i = \frac{n(n+1)}{2} = \Theta(n^2)$.

**(3) $T(n) = T(n-1) + \sqrt{n}$:** $T(n) = \sum_{i=1}^n \sqrt{i} \approx \int_1^n \sqrt{x}\,dx = \frac{2}{3}n^{3/2}\Big|_1^n \approx \frac{2}{3}n^{3/2} = \Theta(n^{3/2})$.

**(4) $T(n) = T(n-1) + n^2$:** $T(n) = \sum_{i=1}^n i^2 = \frac{n(n+1)(2n+1)}{6} = \Theta(n^3)$.

**(5) $T(n) = 2T(n-1)$:** $T(n) = 2 \cdot T(n-1) = 2^2 T(n-2) = \ldots = 2^{n-1} T(1) = \Theta(2^n)$.

**(9) $T(n) = 2T(n-4)$:** $T(n) = 2^k T(n-4k)$. Con $k = n/4$: $T(n) = 2^{n/4} \cdot T(O(1)) = \Theta(2^{n/4})$ (exponencial en $n$).

---

**Recurrencias TM** $T(n) = aT(n/c) + f(n)$:

**(6) $T(n) = T(n/2) + n$:** $a=1$, $c=2$, $\log_2 1 = 0$. $f(n) = n = \Omega(n^{0+1})$ → **Caso 3** (verificar condicion de regularidad: $1 \cdot f(n/2) = n/2 \leq k \cdot n$ para $k = 1/2 < 1$ ✓) → $T(n) = \Theta(n)$.

**(7) $T(n) = T(n/2) + \sqrt{n}$:** $a=1$, $c=2$, $\log_2 1 = 0$. $f(n) = n^{1/2} = \Omega(n^{0+\epsilon})$ para $\epsilon = 1/2$ → **Caso 3** → $T(n) = \Theta(\sqrt{n})$.

**(8) $T(n) = T(n/2) + n^2$:** $a=1$, $c=2$, $\log_2 1 = 0$. $f(n) = n^2 = \Omega(n^{0+2})$ → **Caso 3** → $T(n) = \Theta(n^2)$.

**(10) $T(n) = 2T(n/2) + \log n$:** $a=2$, $c=2$, $\log_2 2 = 1$. $f(n) = \log n = O(n^{1-\epsilon})$ para cualquier $\epsilon \in (0,1)$ (p.ej. $\epsilon = 1/2$: $\log n = O(n^{1/2})$ ✓) → **Caso 1** → $T(n) = \Theta(n^{\log_2 2}) = \Theta(n)$.

**(11) $T(n) = 3T(n/4)$:** $a=3$, $c=4$, $\log_4 3 \approx 0.79$. $f(n) = 0 = O(n^{\log_4 3 - \epsilon})$ → **Caso 1** → $T(n) = \Theta(n^{\log_4 3}) \approx \Theta(n^{0.79})$.

**(12) $T(n) = 3T(n/4) + n$:** $a=3$, $c=4$, $\log_4 3 \approx 0.79$. $f(n) = n = \Omega(n^{\log_4 3 + \epsilon})$ para $\epsilon = 1 - \log_4 3 > 0$ → **Caso 3** (regularidad: $3 \cdot f(n/4) = 3n/4 \leq kn$ para $k=3/4 < 1$ ✓) → $T(n) = \Theta(n)$.

**Chuleta**

> **Para TM** $T(n) = aT(n/c) + f(n)$: calcular $\alpha = \log_c a$.
> - $f(n) = O(n^{\alpha-\epsilon})$: **C1** → $\Theta(n^\alpha)$.
> - $f(n) = \Theta(n^\alpha)$: **C2** → $\Theta(n^\alpha \log n)$.
> - $f(n) = \Omega(n^{\alpha+\epsilon})$: **C3** → $\Theta(f(n))$ (verificar regularidad).
>
> **Para restadas** $T(n) = T(n-b) + f(n)$: telescopar sumando $\sum_{k} f(n-kb)$.

**¿Aparece en parciales?** 🔴 Si — resolver recurrencias con TM es evaluado en todos los parciales 1P

---

### Ejercicio 8 ⋆ — MaximaSubsecuencia

**Enunciado**

Dada una secuencia de $n$ enteros, encontrar el maximo valor que se puede obtener sumando elementos contiguos. Disenar un algoritmo D&C en $O(n \log n)$.

Por ejemplo, para $[3, -1, 4, 8, -2, 2, -7, 5]$, el valor es 14, de la subsecuencia $[3, -1, 4, 8]$.

**Explicacion**

Caso cruzado: el subarreglo maximo puede estar en la mitad izquierda, en la derecha, o cruzar el medio. El caso cruzado se computa en $O(n)$: extender desde el medio hacia izquierda y derecha. $T(n) = 2T(n/2) + O(n) \Rightarrow \Theta(n \log n)$.

Este ejercicio aparece resuelto en [[divide_y_conquista_practica]].

**Resolucion paso a paso**

```python
def max_cruzado(A, i, mid, j):
    """Maximo subarreglo que cruza la posicion mid."""
    # Sufijo maximo de A[i..mid]
    suma_izq = float('-inf')
    total = 0
    for k in range(mid, i - 1, -1):
        total += A[k]
        suma_izq = max(suma_izq, total)
    # Prefijo maximo de A[mid+1..j]
    suma_der = float('-inf')
    total = 0
    for k in range(mid + 1, j + 1):
        total += A[k]
        suma_der = max(suma_der, total)
    return suma_izq + suma_der   # O(n) total

def max_subarray(A, i=None, j=None):
    if i is None: i, j = 0, len(A) - 1
    if i == j:
        return A[i]
    mid = (i + j) // 2
    max_izq = max_subarray(A, i, mid)
    max_der = max_subarray(A, mid + 1, j)
    max_cruz = max_cruzado(A, i, mid, j)
    return max(max_izq, max_der, max_cruz)
```

**Recurrencia:** $T(n) = 2T(n/2) + \Theta(n)$.

**TM:** $a=2$, $c=2$, $f(n) = \Theta(n) = \Theta(n^{\log_2 2})$ → **Caso 2** → $T(n) = \Theta(n \log n)$.

**Correctitud:** El maximo subarreglo esta en uno de tres lugares:
1. Completamente en $A[i..mid]$ → resuelto recursivamente.
2. Completamente en $A[mid+1..j]$ → resuelto recursivamente.
3. Cruza $mid$ → resuelto por `max_cruzado` en $O(n)$.
Los tres casos cubren todas las posibilidades.

**Chuleta**

> Tres casos: izq, der, cruzado. Cruzado = sufijo_max(izq) + prefijo_max(der) en $O(n)$. $T(n)=2T(n/2)+\Theta(n)$ → TM Caso 2 → $\Theta(n\log n)$.

**¿Aparece en parciales?** 🔴 Si — patron de caso cruzado en D&C evaluado en parciales

---

### Ejercicio 9 ⋆ — PotenciaSum

**Enunciado**

Dado un metodo `potencia` que computa $A^n$ para una matriz $A$ de $4 \times 4$ y $n$ potencia de 2, disenar un algoritmo D&C que calcule $A^1 + A^2 + A^3 + \ldots + A^n$ usando `potencia`, `suma` y `producto` una cantidad estrictamente menor que $O(n)$ veces.

**Explicacion**

Observacion: $A^1 + \ldots + A^n = A(I + A)(I + A^2)(I + A^4) \cdots (I + A^{n/2})$ (factorizacion geometrica para potencias de 2). D&C con $T(n) = T(n/2) + O(1)$ operaciones de matrices → $O(\log n)$ operaciones.

**Resolucion paso a paso**

**Identidad clave:** Para $n$ potencia de 2:
$$S(n) = A + A^2 + \ldots + A^n = (I + A^{n/2}) \cdot S(n/2)$$

Verificacion: $(I + A^{n/2}) \cdot (A + \ldots + A^{n/2}) = (A + \ldots + A^{n/2}) + (A^{n/2+1} + \ldots + A^n) = S(n)$. ✓

```python
def potencia_sum(A, n):
    """Calcula A + A^2 + ... + A^n para n potencia de 2."""
    if n == 1:
        return A
    S_mitad = potencia_sum(A, n // 2)        # S(n/2) = A + ... + A^(n/2)
    A_mitad = potencia(A, n // 2)            # A^(n/2)
    I = identidad()
    return producto(suma(I, A_mitad), S_mitad)  # (I + A^(n/2)) * S(n/2)
```

**Conteo de operaciones:** Cada llamada usa 1 `potencia`, 1 `suma`, 1 `producto`. $T_{\text{ops}}(n) = T_{\text{ops}}(n/2) + O(1) = O(\log n)$ operaciones. $\blacksquare$

**Chuleta**

> $S(n) = (I + A^{n/2}) \cdot S(n/2)$. Recursar en $n/2$, llamar `potencia(A, n//2)` y `producto`/`suma`. $O(\log n)$ operaciones de matrices.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 10 ⋆ — DistanciaMaxima

**Enunciado**

Dado un arbol binario cualquiera, disenar un algoritmo D&C que devuelva la maxima distancia entre dos nodos (maxima cantidad de aristas a atravesar). El algoritmo no debe hacer recorridos innecesarios.

Hint: para saber el camino mas largo de un arbol, posiblemente se necesite conocer mas que solo los caminos mas largos de los subarboles.

**Explicacion**

El camino maximo puede pasar por la raiz (suma de profundidades maximas de ambos subarboles) o estar completamente en un subarbole. Cada llamada recursiva retorna (max_distancia, max_profundidad). $O(n)$.

**Resolucion paso a paso**

La observacion del hint: la distancia maxima que **pasa por la raiz** es `profundidad_max_izq + profundidad_max_der`. Pero tambien puede estar completamente en un subarbole. Necesitamos propagar ambas metricas.

```python
def distancia_max(nodo):
    """
    Retorna (max_dist: int, max_prof: int).
    max_dist: maxima distancia entre cualquier par de nodos del subarbole.
    max_prof: maxima profundidad (distancia a la hoja mas lejana).
    """
    if nodo is None:
        return (0, 0)
    
    dist_izq, prof_izq = distancia_max(nodo.izq)
    dist_der, prof_der = distancia_max(nodo.der)
    
    dist_via_raiz = prof_izq + prof_der         # camino que pasa por la raiz actual
    max_dist = max(dist_izq, dist_der, dist_via_raiz)
    max_prof = 1 + max(prof_izq, prof_der)
    
    return (max_dist, max_prof)
```

**Complejidad:** $T(n) = 2T(n/2) + O(1) = \Theta(n)$ (visita cada nodo exactamente una vez).

**Chuleta**

> Retornar `(max_dist, max_prof)`. `max_prof = 1 + max(prof_izq, prof_der)`. `max_dist = max(dist_izq, dist_der, prof_izq + prof_der)`. $O(n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 11 ⋆ — DesordenSort

**Enunciado**

La cantidad de parejas en desorden de un arreglo $A[1 \ldots n]$ es la cantidad de parejas $(i, j)$ con $1 \leq i < j \leq n$ tales que $A[i] > A[j]$. Dar un algoritmo que calcule la cantidad de parejas en desorden con complejidad estrictamente mejor que $O(n^2)$.

Hint: considerar una modificacion de un algoritmo de sorting.

**Explicacion**

MergeSort modificado: durante el merge, cada vez que se elige un elemento de la mitad derecha antes que uno de la izquierda, se cuentan todas las inversiones restantes con ese elemento. $O(n \log n)$.

**Resolucion paso a paso**

**Idea:** Cuando en `merge` se elige $R[j]$ antes que $L[i]$, significa que $L[i] > R[j]$. Como $L$ esta ordenado, **todos** los elementos $L[i], L[i+1], \ldots, L[\text{fin}]$ son mayores que $R[j]$, contribuyendo `len(L) - i` inversiones.

```python
def contar_inversiones(A, i, j):
    """Retorna (num_inversiones, A[i..j] ordenado)."""
    if i >= j:
        return 0, A[i:j+1]
    mid = (i + j) // 2
    inv_izq, sorted_izq = contar_inversiones(A, i, mid)
    inv_der, sorted_der = contar_inversiones(A, mid + 1, j)
    inv_merge, sorted_merge = merge_contar(sorted_izq, sorted_der)
    return inv_izq + inv_der + inv_merge, sorted_merge

def merge_contar(L, R):
    inversiones = 0
    result = []
    i = j = 0
    while i < len(L) and j < len(R):
        if L[i] <= R[j]:
            result.append(L[i])
            i += 1
        else:
            result.append(R[j])
            inversiones += len(L) - i  # L[i..] todos > R[j]
            j += 1
    result.extend(L[i:])
    result.extend(R[j:])
    return inversiones, result
```

**Recurrencia:** $T(n) = 2T(n/2) + \Theta(n)$ → **Caso 2 TM** → $\Theta(n \log n)$.

**Chuleta**

> MergeSort modificado: al elegir $R[j]$ primero, sumar `len(L) - i` inversiones. Misma recurrencia que MergeSort: $\Theta(n \log n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 12 ⋆ — CazadorDeFalsos

**Enunciado**

Se tiene una matriz booleana $A$ de $n \times n$ y una operacion `conjuncionSubmatriz(i0, i1, j0, j1)` que toma $O(1)$ y devuelve la conjuncion de todos los elementos de la submatriz.

a) Dar un algoritmo de complejidad estrictamente menor que $O(n^2)$ que calcule la posicion de algun `false`, asumiendo que hay al menos uno.

b) Modificar para contar cuantos `false` hay en la matriz. Asumiendo que hay a lo sumo 5 elementos `false`, la complejidad debe ser menor a $O(n^2)$.

**Explicacion**

a) D&C: dividir la matriz en 4 cuadrantes. Si `conjuncionSubmatriz` de un cuadrante es `true`, no hay `false` ahi → no se recursa. Si hay al menos un `false`, habra al menos un cuadrante con conjuncion `false`. $T(n^2) = T(n^2/4) + O(1) \Rightarrow O(\log n^2) = O(\log n)$ en el mejor caso; en el peor (solo 1 false), $O(\log n)$ niveles.

b) Con a lo sumo 5 `false`, la recursion termina tras encontrar cada uno: $O(5 \cdot \log n)= O(\log n)$.

**Resolucion paso a paso**

**a)**
```python
def hallar_falso(i0, i1, j0, j1):
    """Encuentra posicion de algun False. Asume que hay al menos uno."""
    if i0 == i1 and j0 == j1:
        return (i0, j0)
    mid_i = (i0 + i1) // 2
    mid_j = (j0 + j1) // 2
    cuadrantes = [
        (i0, mid_i, j0, mid_j),
        (i0, mid_i, mid_j+1, j1),
        (mid_i+1, i1, j0, mid_j),
        (mid_i+1, i1, mid_j+1, j1),
    ]
    for (qi0, qi1, qj0, qj1) in cuadrantes:
        if not conjuncionSubmatriz(qi0, qi1, qj0, qj1):
            return hallar_falso(qi0, qi1, qj0, qj1)
```

**Complejidad a):** Sea $m = n^2$ la cantidad de celdas. $T(m) = T(m/4) + O(1)$ → por TM: $a=1, c=4, f(m)=O(1)$ → Caso 2 → $T(m) = O(\log m) = O(\log n^2) = O(\log n)$.

**b)** Con a lo sumo $K=5$ elementos `false`:
```python
def contar_falsos(i0, i1, j0, j1, encontrados):
    if conjuncionSubmatriz(i0, i1, j0, j1):
        return  # no hay False aqui
    if i0 == i1 and j0 == j1:
        encontrados.append((i0, j0))
        return
    mid_i = (i0 + i1) // 2
    mid_j = (j0 + j1) // 2
    for (qi0, qi1, qj0, qj1) in [(i0,mid_i,j0,mid_j),(i0,mid_i,mid_j+1,j1),
                                   (mid_i+1,i1,j0,mid_j),(mid_i+1,i1,mid_j+1,j1)]:
        contar_falsos(qi0, qi1, qj0, qj1, encontrados)
```

**Complejidad b):** Cada `false` "genera" un camino en el arbol de recursion de profundidad $O(\log n)$. Con $K \leq 5$ falsos: a lo sumo $5 \log n$ nodos con `false` encontrados. Cada nivel del arbol se visita a lo sumo $O(K)$ veces adicionales. Total: $O(K \log n) = O(\log n)$.

**Chuleta**

> Dividir en 4 cuadrantes, recursar solo los que tengan conjuncion `false`. **a):** $T(n^2) = T(n^2/4)+O(1) = O(\log n)$. **b):** $K \leq 5$ `false` → $O(K \log n) = O(\log n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 13 — MergeSelectivo

**Enunciado**

Dados dos arreglos de naturales ordenados de manera creciente, buscar el $i$-esimo elemento del merge ordenado entre ambos (sin hacer el merge completo). Cada natural aparece a lo sumo en uno de los arreglos.

a) Implementar `iesimoMerge(A, B, i)`.

b) Calcular la complejidad. Debe ser $O(\log^2 n)$ donde $n = |A| = |B|$.

c) Desafio adicional: resolver en $O(\log n)$.

**Explicacion**

Busqueda binaria: si $A[mid]$ es el candidato, su posicion en el merge es $mid + \text{(posicion en B via busqueda binaria)}$. Comparar con $i$ para decidir mitad a buscar. $T(n) = T(n/2) + O(\log n) \Rightarrow O(\log^2 n)$.

**Resolucion paso a paso**

**a) Version $O(\log^2 n)$:**

```python
import bisect

def iesimo_merge(A, B, i, loA=0, hiA=None, loB=0, hiB=None):
    if hiA is None: hiA = len(A) - 1
    if hiB is None: hiB = len(B) - 1
    # Si uno de los rangos esta vacio, el resultado esta en el otro
    if loA > hiA:
        return B[loB + i]   # i-esimo restante de B (0-indexed)
    if loB > hiB:
        return A[loA + i]
    midA = (loA + hiA) // 2
    # Cuantos elementos de B[loB..hiB] son <= A[midA]?
    rank_in_B = bisect.bisect_right(B, A[midA], loB, hiB + 1) - loB
    # Rango de A[midA] en el merge (0-indexed desde el inicio del rango actual)
    rank = (midA - loA) + rank_in_B
    if rank == i:
        return A[midA]
    elif rank > i:
        # El i-esimo esta antes de A[midA]
        return iesimo_merge(A, B, i, loA, midA - 1, loB, loB + rank_in_B - 1)
    else:
        # El i-esimo esta despues de A[midA]
        return iesimo_merge(A, B, i - rank - 1, midA + 1, hiA, loB + rank_in_B, hiB)
```

**b) Complejidad:** Cada llamada hace un `bisect_right` sobre $B$: $O(\log n)$. Y reduce el rango de $A$ a la mitad: $T(n) = T(n/2) + O(\log n)$.

Por TM: $a=1$, $c=2$, $f(n) = \log n$. $\log_2 1 = 0$, $f(n) = \Omega(n^{0+\epsilon})$ para $\epsilon \to 0$... en realidad $\log n$ no es $\Omega(n^\epsilon)$ para ningun $\epsilon > 0$. Usar el caso 2': $f(n) = \Theta(n^0 \cdot \log^1 n)$ → Caso 2' con $k=1$ → $T(n) = \Theta(n^0 \log^2 n) = \Theta(\log^2 n)$. ✓

**c) Desafio $O(\log n)$:** Hacer busqueda binaria simultaneamente en $A$ y $B$. En cada paso, comparar $A[midA]$ con $B[midB]$ y descartar el cuadrante imposible. ⚠️ Verificar — implementacion mas delicada, la idea es reducir ambos rangos en cada paso.

**Chuleta**

> Para $A[midA]$: su rango en el merge = $(midA - loA)$ + `bisect_right(B, A[midA])`. Comparar con $i$, recursar en la mitad relevante de $A$ y porciones correspondientes de $B$. $T(n) = T(n/2)+O(\log n) = O(\log^2 n)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 14 — DiferenciaMinima

**Enunciado**

Se tienen dos arreglos de $n$ naturales $A$ (orden creciente) y $B$ (orden decreciente). Para cada posicion $i$, considerar $|A[i] - B[i]|$. Encontrar el minimo valor posible de esta diferencia.

Ejemplo: $A = [1, 2, 3, 4]$, $B = [6, 4, 2, 1]$ → diferencias $[5, 2, 1, 3]$, resultado $1$.

a) Implementar `minDif(A, B)`.
b) Complejidad: $O(\log n)$.

**Explicacion**

La diferencia $f(i) = A[i] - B[i]$ es monotonicamnete creciente (A crece, B decrece). Se busca el indice donde el signo cambia: busqueda binaria. $O(\log n)$.

Este ejercicio aparece resuelto en [[divide_y_conquista_practica]] (DiferenciaMinima).

**Resolucion paso a paso**

**Observacion clave:** $f(i) = A[i] - B[i]$ es estrictamente creciente: $A$ crece y $B$ decrece, por lo que $f$ es suma de dos funciones, una estrictamente creciente y una estrictamente decreciente en signo → $f$ es estrictamente creciente.

El valor $|f(i)|$ es minimo cerca del cruce de signo de $f$. Buscar el primer indice donde $f(i) \geq 0$:

```python
def min_dif(A, B):
    n = len(A)
    lo, hi = 0, n - 1
    # Buscar el primer indice donde A[i] >= B[i]
    while lo < hi:
        mid = (lo + hi) // 2
        if A[mid] < B[mid]:   # f(mid) < 0: cruce esta a la derecha
            lo = mid + 1
        else:                  # f(mid) >= 0: cruce esta aqui o a la izquierda
            hi = mid
    # lo es el primer indice con A[lo] >= B[lo]
    candidatos = [abs(A[lo] - B[lo])]
    if lo > 0:
        candidatos.append(abs(A[lo-1] - B[lo-1]))
    return min(candidatos)
```

**Correctitud:** La funcion $f$ es estrictamente creciente. La busqueda binaria halla el primer $i$ con $f(i) \geq 0$. El minimo de $|f(i)|$ se alcanza en $i$ o en $i-1$ (los dos indices mas cercanos al cruce). ⚠️ Verificar — si $f$ puede tomar exactamente 0, ese es el minimo; sino comparar $f(i)$ y $f(i-1)$.

**Complejidad:** $T(n) = T(n/2) + O(1) = O(\log n)$. ✓

**Chuleta**

> $f(i) = A[i] - B[i]$ es estrictamente creciente. Busqueda binaria para primer $i$ con $f(i) \geq 0$. Resultado es $\min(|f(i)|, |f(i-1)|)$. $O(\log n)$.

**¿Aparece en parciales?** 🔴 Si — variante de busqueda binaria en funcion monotona, aparece en clase practica

---

### Ejercicio 15 — SubBusqueda

**Enunciado**

Se tiene un arreglo $A$ de $n$ naturales y una funcion `aparece?(A, i, j, e)` que devuelve `true` si $e = A[k]$ para algun $k$ con $i \leq k \leq j$, y toma $O(\sqrt{j-i+1})$.

Encontrar un algoritmo sublineal que halla el indice de un elemento $e$ en $A$, asumiendo que existe.

a) Implementar `ubicar?(A, n, e)`.
b) Complejidad: estrictamente menor a $O(n)$.

**Explicacion**

Dividir el arreglo en bloques de tamano $O(\sqrt{n})$: verificar en $O(1)$ bloques via `aparece?` → $O(\sqrt{n})$ por bloque, y hay $O(\sqrt{n})$ bloques. $O(\sqrt{n})$ total.

**Resolucion paso a paso**

**Idea D&C (busqueda binaria):** Usar `aparece?` en la mitad para decidir si ir izquierda o derecha.

```python
def ubicar(A, e, i=0, j=None):
    if j is None: j = len(A) - 1
    if i == j:
        return i
    mid = (i + j) // 2
    if aparece(A, i, mid, e):
        return ubicar(A, e, i, mid)
    else:
        return ubicar(A, e, mid + 1, j)
```

**Recurrencia:** $T(n) = T(n/2) + O(\sqrt{n})$ (cada llamada usa `aparece?` en un rango de tamano $n/2$: costo $O(\sqrt{n/2}) = O(\sqrt{n})$).

**TM:** $a=1$, $c=2$, $f(n) = \sqrt{n} = \Omega(n^{0+\epsilon})$ para $\epsilon=1/2$ → **Caso 3** (regularidad: $1 \cdot f(n/2) = \sqrt{n/2} = \sqrt{n}/\sqrt{2} \leq k\sqrt{n}$ para $k = 1/\sqrt{2} < 1$ ✓) → $T(n) = \Theta(\sqrt{n})$.

$O(\sqrt{n}) = o(n)$. ✓

**Chuleta**

> Busqueda binaria con `aparece?` en la mitad. $T(n)=T(n/2)+O(\sqrt{n})$. TM Caso 3 → $\Theta(\sqrt{n})$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 16 — L-Tetris

**Enunciado**

Se tiene un tablero de $n \times n$ con $n$ potencia de 2, donde una posicion esta ocupada inicialmente. Rellenar todas las posiciones con piezas L (3 posiciones en forma de L). Formalmente, dado $n$, $i_0$, $j_0$ (posicion ocupada), encontrar una matriz $B$ de $n \times n$ tal que:
- $B[i_0, j_0] = 0$
- Todos los valores de $1$ a $(n^2 - 1)/3$ aparecen exactamente tres veces en $B$
- Cada grupo de tres apariciones forma una pieza L

Hint: para particionar el tablero conviene posicionar alguna pieza estrategicamente.

**Explicacion**

D&C clasico: dividir el tablero en 4 cuadrantes de $(n/2) \times (n/2)$. La casilla ocupada esta en uno de los cuadrantes. Colocar una pieza L en el centro (esquina de los 3 cuadrantes que no tienen la casilla ocupada) → ahora cada cuadrante tiene exactamente una casilla "ocupada". Recursar en cada cuadrante. $T(n^2) = 4T(n^2/4) + O(1) \Rightarrow O(n^2)$.

**Resolucion paso a paso**

```python
contador = [0]  # global para numerar las piezas

def l_tetris(B, n, i0, j0, fila, col):
    """
    Rellena B[fila..fila+n-1][col..col+n-1] con piezas L.
    (i0, j0) es la casilla ya ocupada dentro del cuadrante.
    """
    if n == 1:
        return  # base: unica casilla ya ocupada
    
    mid = n // 2
    contador[0] += 1
    c = contador[0]
    
    # Centro del tablero: (fila+mid-1, col+mid-1), (fila+mid-1, col+mid),
    #                     (fila+mid, col+mid-1), (fila+mid, col+mid)
    # Colocar pieza L en las 3 esquinas del centro que NO tienen la casilla ocupada
    
    # Determinar en que cuadrante esta (i0, j0)
    cuadrante = (i0 >= fila + mid, j0 >= col + mid)
    # cuadrante = (False, False) → sup-izq, (False, True) → sup-der
    #             (True, False)  → inf-izq, (True, True)  → inf-der
    
    # Marcar las 3 esquinas centrales que no pertenecen al cuadrante de (i0, j0)
    if cuadrante != (False, False):
        B[fila+mid-1][col+mid-1] = c   # esquina sup-izq del centro
    if cuadrante != (False, True):
        B[fila+mid-1][col+mid] = c     # esquina sup-der del centro
    if cuadrante != (True, False):
        B[fila+mid][col+mid-1] = c     # esquina inf-izq del centro
    if cuadrante != (True, True):
        B[fila+mid][col+mid] = c       # esquina inf-der del centro
    
    # Recursar en cada cuadrante con su "casilla ocupada"
    l_tetris(B, mid, i0 if not cuadrante[0] else fila+mid-1,
                     j0 if not cuadrante[1] else col+mid-1,
                     fila, col)
    l_tetris(B, mid, i0 if not cuadrante[0] else fila+mid-1,
                     j0 if cuadrante[1] else col+mid,
                     fila, col+mid)
    l_tetris(B, mid, i0 if cuadrante[0] else fila+mid,
                     j0 if not cuadrante[1] else col+mid-1,
                     fila+mid, col)
    l_tetris(B, mid, i0 if cuadrante[0] else fila+mid,
                     j0 if cuadrante[1] else col+mid,
                     fila+mid, col+mid)
```

**Invariante:** Al llamar a `l_tetris` en un cuadrante de $k \times k$, exactamente una casilla del cuadrante ya esta "ocupada" (sea la casilla original o una esquina central de la pieza L del nivel superior).

**Recurrencia:** Sea $m = n^2$. $T(m) = 4T(m/4) + O(1)$.

**TM:** $a=4$, $c=4$, $\log_4 4 = 1$. $f(m) = O(1) = O(m^{1-\epsilon})$ para $\epsilon=1$ → **Caso 1** → $T(m) = \Theta(m^1) = \Theta(n^2)$. ✓

**(Correcto: se colocan $(n^2-1)/3$ piezas → $\Theta(n^2)$ trabajo minimo.)**

**Chuleta**

> Dividir en 4 cuadrantes. Colocar pieza L en las 3 esquinas del centro sin la casilla ocupada. Recursar en 4 cuadrantes (cada uno con 1 casilla ocupada). $T(n^2) = 4T(n^2/4)+O(1) = \Theta(n^2)$.

**¿Aparece en parciales?** ⚪ No

## Ver tambien

- [[divide_y_conquista_teoria]] — Teorema Maestro, analisis de recurrencias
- [[divide_y_conquista_practica]] — Ejercicios resueltos en clase (MergeSort, BusquedaBinaria, MaximoMontana, MaximaSubsecuencia, DiferenciaMinima)
