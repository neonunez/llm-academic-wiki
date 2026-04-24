---
nombre: Divide & Conquer — Clase Practica
parcial: 1P
tipo: practica
tema: divide_y_conquista
fuente: raw/clases/prac/1.prac_1P_divide_&_conquer.pdf
paginas_relacionadas:
  - "[[divide_y_conquista_teoria]]"
  - "[[divide_y_conquista_guia]]"
---

# Divide & Conquer — Clase Practica

> Clase del 20 de agosto de 2025. 57 slides Beamer. Ejercicios numerados 1, 2, 6, 8, 14 (numeracion coincide con guia).

## Patrones de este tema en parciales
> [[tipos_ejercicio/dc_teorema_maestro]]

---

## Nota conceptual — Que NO es Divide & Conquer

El PDF introduce este punto explicitamente: **no todo algoritmo recursivo que divide el problema es D&C**.

`BúsquedaLinealModificada(A, elem)`: divide en subproblemas de tamaño 1 y n-1 → recurrencia $T(n) = T(n-1) + O(1) = O(n)$. Es una recursion lineal disfrazada.

`BúsquedaLinealModificadaV2(A, elem)`: divide en dos mitades de n/2 → recurrencia $T(n) = 2T(n/2) + O(1) = O(n)$. Es D&C real pero no mejora la complejidad (hay que recorrer todo el arreglo de todas formas).

**Criterios para D&C real:**
- Division balanceada (subproblemas de tamaño n/c)
- Reduccion significativa por factor constante
- Verdadera descomposicion del problema

---

## Ejercicios de clase

### Ejercicio 1 — MergeSort

**Enunciado**
Dado el algoritmo de mergesort en Python, identificar: (1) lineas de divide/conquer/combine, (2) cantidad de subproblemas, (3) tamano de subproblemas, (4) costo de combinar, (5) funcion T(n), (6) complejidad con Teorema Maestro.

```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    medio = len(arr) // 2
    mitad_izq = merge_sort(arr[:medio])
    mitad_der = merge_sort(arr[medio:])
    return merge(mitad_izq, mitad_der)

def merge(izq, der):
    mergeados = []
    i = j = 0
    while i < len(izq) and j < len(der):
        if izq[i] < der[j]:
            mergeados.append(izq[i]); i += 1
        else:
            mergeados.append(der[j]); j += 1
    mergeados.extend(izq[i:])
    mergeados.extend(der[j:])
    return mergeados
```

**Explicacion**
Ejercicio introductorio que descompone MergeSort en las tres fases D&C. Consolida la conexion entre estructura recursiva y recurrencia, y aplica el Teorema Maestro caso 2.

**Resolucion paso a paso**
1. **Divide:** `medio = len(arr) // 2` — calcula el punto medio. *Por que: particion balanceada en O(1)*
2. **Conquer:** `mitad_izq = merge_sort(arr[:medio])` y `mitad_der = merge_sort(arr[medio:])` — *Por que: 2 llamadas recursivas sobre mitades*
3. **Combine:** `return merge(mitad_izq, mitad_der)` + toda la funcion `merge` — *Por que: fusion de dos listas ordenadas en O(n)*
4. **Subproblemas:** 2, cada uno de tamano n/2 — para analisis asintotico ambos son $\Theta(n/2)$
5. **Costo de combinar:** `merge` recorre cada elemento una vez → $\Theta(n)$
6. **Recurrencia:**
$$T(n) = \begin{cases} \Theta(1) & n \le 1 \\ 2T(n/2) + \Theta(n) & n > 1 \end{cases}$$
7. **Teorema Maestro:** $a=2$, $c=2$, $f(n)=\Theta(n)$. $\log_c a = \log_2 2 = 1$. Como $f(n) = \Theta(n^1) = \Theta(n^{\log_c a})$ → **Caso 2** → $T(n) = \Theta(n \log n)$

**Chuleta**
> Divide: punto medio → Conquer: 2 llamadas recursivas de n/2 → Combine: merge en O(n) → T(n) = 2T(n/2) + Θ(n) → Caso 2 TM → **Θ(n log n)**

**¿Aparece en parciales?** ⚪ No (ejercicio de analisis, no de diseno)

---

### Ejercicio 2 — BusquedaBinaria

**Enunciado**
Dado el algoritmo de busqueda binaria, mismas preguntas 1-6 que el ejercicio 1.

```python
def busqueda_binaria(arr, objetivo, izq=0, der=len(arr)-1):
    if izq > der:
        return False
    medio = (izq + der) // 2
    if arr[medio] == objetivo:
        return medio
    elif arr[medio] > objetivo:
        return busqueda_binaria(arr, objetivo, izq, medio - 1)
    else:
        return busqueda_binaria(arr, objetivo, medio + 1, der)
```

**Explicacion**
Contraste clave con MergeSort: solo 1 subproblema (no 2), sin fase de combinacion. Muestra que D&C no siempre duplica llamadas — a veces se puede descartar una mitad.

**Resolucion paso a paso**
1. **Divide:** `medio = (izq + der) // 2` + comparacion `arr[medio] > objetivo`
2. **Conquer:** solo UNA llamada recursiva (la mitad relevante)
3. **Combine:** ninguna — se retorna directamente el resultado
4. **Subproblemas:** 1, de tamano n/2
5. **Costo de combinar:** $O(1)$ (comparacion + calculo de medio)
6. **Recurrencia:**
$$T(n) = \begin{cases} \Theta(1) & n \le 1 \\ T(n/2) + \Theta(1) & n > 1 \end{cases}$$
7. **Teorema Maestro:** $a=1$, $c=2$, $f(n)=\Theta(1)$. $\log_2 1 = 0$. $f(n) = \Theta(n^0) = \Theta(n^{\log_c a})$ → **Caso 2** → $T(n) = \Theta(n^0 \log n) = \Theta(\log n)$

**Chuleta**
> Divide: punto medio + comparacion → Conquer: 1 llamada sobre n/2 → Combine: nada → T(n) = T(n/2) + Θ(1) → Caso 2 TM → **Θ(log n)**

**¿Aparece en parciales?** ⚪ No (analisis de algoritmo existente)

---

### Ejercicio 6 — MaximoMontana

**Enunciado**
Un arreglo de enteros es *montana* si esta compuesto por una secuencia estrictamente creciente seguida de una estrictamente decreciente. Dado un arreglo montana de longitud n, encontrar el maximo en $O(\log n)$.

Ejemplo: `[-1, 3, 8, 22, 30, 22, 8, 4, 2, 1]` → maximo en posicion 4, valor 30.

**Explicacion**
Patron: funcion unimodal → busqueda binaria adaptada. La clave es que comparando el elemento medio con sus vecinos se puede determinar en que mitad esta el pico, descartando la otra.

**Resolucion paso a paso**
1. Calcular `medio = (izq + der) // 2`
2. Si `arr[medio] < arr[medio-1]`: estamos en la parte decreciente o despues del pico → buscar en `[izq, medio-1]`
3. Si `arr[medio] < arr[medio+1]`: estamos en la parte creciente → buscar en `[medio+1, der]`
4. Si ninguno: `arr[medio]` es el maximo (mayor que ambos vecinos)

```python
def maximo_montana(arr, izq=0, der=None):
    if der is None:
        der = len(arr) - 1
    if izq == der:
        return izq
    medio = (izq + der) // 2
    if medio > 0 and arr[medio] < arr[medio - 1]:
        return maximo_montana(arr, izq, medio - 1)
    elif medio < len(arr)-1 and arr[medio] < arr[medio + 1]:
        return maximo_montana(arr, medio + 1, der)
    else:
        return medio
```

**Analisis D&C:**
- Divide: punto medio + comparacion con vecinos — $O(1)$
- Conquer: 1 subproblema de n/2 (se descarta la otra mitad)
- Combine: ninguna
- **Recurrencia:** $T(n) = T(n/2) + \Theta(1)$ → identica a busqueda binaria

**Correctitud (invariante):** el maximo siempre esta en `[izq, der]` actual.
- Si `arr[medio] < arr[medio-1]`: como la secuencia es creciente antes del pico y decreciente despues, si el elemento anterior es mayor estamos en la parte decreciente o hemos pasado el pico → maximo a la izquierda
- Si `arr[medio] < arr[medio+1]`: estamos en la parte creciente → maximo a la derecha
- Si ninguno: maximo encontrado

**Teorema Maestro:** $a=1$, $c=2$, $f(n)=\Theta(1)$ → Caso 2 → $T(n) = \Theta(\log n)$

**Chuleta**
> Si medio < vecino izquierdo → buscar izquierda. Si medio < vecino derecho → buscar derecha. Sino → encontrado. T(n) = T(n/2) + Θ(1) → **Θ(log n)**

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/dc_teorema_maestro]]

---

### Ejercicio 8 — MaximaSubsecuencia (Maximum Subarray)

**Enunciado**
Dada una secuencia de n enteros, encontrar el maximo valor que se puede obtener sumando elementos contiguos. Disenar un algoritmo D&C con $O(n \log n)$.

Ejemplo: `[3, -1, 4, 8, -2, 2, -7, 5]` → valor 14 (subsecuencia `[3, -1, 4, 8]`).

**Explicacion**
Patron D&C con 3 casos: la subsecuencia maxima esta completamente en la mitad izquierda, completamente en la derecha, o cruza el punto medio. El tercer caso requiere tratamiento especial: escanear desde el medio hacia los extremos.

Comparacion de enfoques:
| Algoritmo | Complejidad | Descripcion |
|---|---|---|
| Fuerza bruta | $O(n^3)$ | Probar todos los pares (i, j) |
| Fuerza bruta mejorada | $O(n^2)$ | Sumas acumuladas |
| **Divide & Conquer** | $O(n \log n)$ | Este ejercicio |
| Kadane (PD) | $O(n)$ | Optimo |

**Resolucion paso a paso**
1. Dividir el arreglo por el medio
2. Calcular recursivamente la subsecuencia maxima en la mitad izquierda
3. Calcular recursivamente la subsecuencia maxima en la mitad derecha
4. Calcular la subsecuencia maxima que cruza el punto medio:
   - Desde `medio` hacia izquierda: acumular y trackear maximo prefijo
   - Desde `medio+1` hacia derecha: acumular y trackear maximo sufijo
   - Resultado cruzado = suma de ambos maximos
5. Retornar el maximo de los tres casos

```python
def max_subsecuencia(arr, izq=0, der=None):
    if der is None:
        der = len(arr) - 1
    if izq == der:
        return arr[izq]
    medio = (izq + der) // 2
    max_izq = max_subsecuencia(arr, izq, medio)
    max_der = max_subsecuencia(arr, medio + 1, der)
    max_cruzado = suma_maxima_cruzada(arr, izq, medio, der)
    return max(max_izq, max_der, max_cruzado)

def suma_maxima_cruzada(arr, izq, medio, der):
    suma_izq = float('-inf')
    suma = 0
    for i in range(medio, izq - 1, -1):   # de medio hacia izquierda
        suma += arr[i]
        suma_izq = max(suma_izq, suma)
    suma_der = float('-inf')
    suma = 0
    for i in range(medio + 1, der + 1):   # de medio+1 hacia derecha
        suma += arr[i]
        suma_der = max(suma_der, suma)
    return suma_izq + suma_der             # complejidad: O(n)
```

**Analisis D&C:**
- Divide: punto medio → $O(1)$
- Conquer: 2 subproblemas de n/2 → 2T(n/2)
- Combine: `suma_maxima_cruzada` recorre el arreglo → $\Theta(n)$

**Ejemplo:** `[3, -1, 4, 8 | -2, 2, -7, 5]`
- Maximo izquierda (desde medio=3, idx 3): $8 + 4 + (-1) + 3 = 14$
- Maximo derecha (desde medio+1=4, idx 4): $(-2) + 2 = 0$
- Suma cruzada: $14 + 0 = 14$
- Resultado final: $\max(14, 5, 14) = 14$

**Recurrencia:** $T(n) = 2T(n/2) + \Theta(n)$ — identica a MergeSort

**Teorema Maestro:** $a=2$, $c=2$, $f(n)=\Theta(n)$ → Caso 2 → $T(n) = \Theta(n \log n)$

**Chuleta**
> 3 casos: izq / der / cruzado. Cruzado: escanear desde medio hacia extremos en O(n). T(n) = 2T(n/2) + Θ(n) → **Θ(n log n)**

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/dc_teorema_maestro]]

---

### Ejercicio 14 — DiferenciaMinima (Busqueda Ternaria)

**Enunciado**
Dados dos arreglos de n naturales $A$ (creciente) y $B$ (decreciente), sin repeticiones dentro de cada uno. Para cada posicion $i$ considerar $|A[i] - B[i]|$. Implementar `minDif` en $O(\log n)$.

Ejemplo: $A = [1,2,3,4]$, $B = [6,4,2,1]$ → diferencias $[5,2,1,3]$ → minimo = 1.

**Explicacion**
La funcion $f(i) = |A[i] - B[i]|$ es **unimodal**: como A crece y B decrece, la diferencia primero decrece y luego crece (tiene al mas un valle). Esto permite aplicar **busqueda ternaria** para encontrar el minimo en $O(\log n)$.

**Resolucion paso a paso — Busqueda Ternaria**
1. Inicializar `left=0`, `right=n-1`
2. Mientras `right - left > 2`:
   - Calcular dos puntos de tercio: `mid1 = left + (right-left)//3`, `mid2 = right - (right-left)//3`
   - Si `|A[mid1] - B[mid1]| > |A[mid2] - B[mid2]|`: el minimo esta mas cerca de mid2 → `left = mid1`
   - Sino: el minimo esta mas cerca de mid1 → `right = mid2`
3. Cuando quedan $\le 3$ elementos: buscar el minimo lineal en `[left, right]`

```python
def minDif(A, B):
    n = len(A)
    left, right = 0, n - 1
    while right - left > 2:
        mid1 = left + (right - left) // 3
        mid2 = right - (right - left) // 3
        dif1 = abs(A[mid1] - B[mid1])
        dif2 = abs(A[mid2] - B[mid2])
        if dif1 > dif2:
            left = mid1
        else:
            right = mid2
    min_dif = float('inf')
    for i in range(left, right + 1):
        min_dif = min(min_dif, abs(A[i] - B[i]))
    return min_dif
```

**Correctitud:** La propiedad de unimodalidad garantiza que si `dif(mid1) > dif(mid2)`, el minimo NO esta en `[left, mid1)` (ya que la funcion es decreciente en ese tramo). Analogamente en el otro caso.

**Recurrencia:** $T(n) = T\!\left(\frac{2n}{3}\right) + \Theta(1)$

**Teorema Maestro:** $a=1$, $c=3/2$, $f(n)=\Theta(1)$. $\log_{3/2} 1 = 0$. $f(n) = \Theta(n^0) = \Theta(n^{\log_c a})$ → **Caso 2** → $T(n) = \Theta(\log n)$

**Chuleta**
> Observar unimodalidad de |A[i]-B[i]|. Busqueda ternaria: dos puntos de tercio, descartar tercio donde la funcion crece. T(n) = T(2n/3) + Θ(1) → **Θ(log n)**

**¿Aparece en parciales?** ⚪ No

---

## Ver tambien
- [[divide_y_conquista_teoria]] — Teorema Maestro completo con 4 casos, derivacion formal de recurrencias
- [[divide_y_conquista_guia]] — Guia de ejercicios del tema
