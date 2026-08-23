---
nombre: Programacion Dinamica Top-Down — Clase Practica (2025)
parcial: 2P
programa: 2C_2026
tipo: practica
tema: programacion_dinamica
fuentes:
  vigente: []
  historico:
    - raw/clases/prac/3.prac_1P_programacion_dinamica_top_down_parte1.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[programacion_dinamica_teoria]]"
  - "[[programacion_dinamica_top_down_practica_pt2]]"
  - "[[programacion_dinamica_guia]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Programacion Dinamica Top-Down — Clase Practica Pt1 (2025)

> Clase del 2do cuatrimestre 2025. 58 slides Beamer. Docentes: Joaquin Laks y Ezequiel Companeetz. 3 ejercicios progresivos: Fibonacci, AstroTrade (2 parametros), Tobi el granjero (3 parametros + refinamiento de estado).

## Patrones de este tema en parciales
> [[tipos_ejercicio/pd_definir_recursion]] · [[tipos_ejercicio/pd_superposicion_subproblemas]]

---

## Ejercicios de clase

### Ejercicio 1 — El Retorno del Rey (Fibonacci con PD)

**Enunciado**
El rey Cambyses arma ejercitos: el dia $i$ tiene $f(i)$ personas, donde $f(i) = f(i-1) + f(i-2)$ para $i > 1$, y $f(0) = f(1) = 1$. Dado $N$, devolver la cantidad de personas el dia $N$.

**Explicacion**
Introduce la motivacion de PD top-down. La recursion naive de Fibonacci tiene $\Omega(2^{n/2})$ llamados porque recalcula los mismos estados. Con memoizacion, cada estado $f(i)$ se calcula exactamente una vez: $O(n)$ estados × $O(1)$ costo cada uno = $O(n)$.

**Resolucion paso a paso**

**Funcion recursiva naive:**
```
F(i):
  Si i ≤ 1 devolver 1
  Si no, devolver F(i-1) + F(i-2)
```
Problema: el arbol de llamados tiene $\Omega(2^{n/2})$ nodos (hay un subarbol binario completo de altura $\lfloor n/2 \rfloor$).

**Observacion clave — estados vs llamados:**
$f$ puede llamarse con $i \in \{0, 1, \ldots, N\}$ → solo $O(n)$ formas distintas de llamarla. Los $\Omega(2^{n/2})$ llamados son repeticiones del mismo conjunto de $O(n)$ estados.

**Funcion con memoizacion:**
```
Sea M ∈ N^N inicializada con valores indefinidos.
F(i):
  Si M[i] está definido devolver M[i]
  Si i ≤ 1 devolver 1
  M[i] ← F(i-1) + F(i-2)
  devolver M[i]
```

**Complejidad:**
- Temporal: $O(n)$ estados × $O(1)$ por estado = $O(n)$
- Espacial: $O(n)$ para la matriz $M$

**Superposicion de subproblemas:** se cumple ya que $n \ll 2^{n/2}$.

**Chuleta**
> Estado: i (dia). Semantica: f(i) = soldados el dia i. Llamado: F(N). Memoria: array de N posiciones. Complejidad: O(n) tiempo y espacio. Superposicion: N estados vs Ω(2^(N/2)) llamados.

**¿Aparece en parciales?** ⚪ No (ejercicio introductorio de metodologia)

---

### Ejercicio 2 — AstroTrade

**Enunciado**
Dados los precios $p = (p_1, \ldots, p_n)$ de asteroides en $n$ dias consecutivos, Lu puede comprar a lo sumo 1 asteroide por dia, vender a lo sumo 1 por dia, y comienza sin asteroides. No puede vender lo que no tiene. Encontrar la maxima ganancia neta.

Formalmente: maximizar $g = \sum_{i=1}^n x_i p_i$ con $x_i \in \{-1, 0, 1\}$ y $\sum_{i=1}^j x_i \le 0$ para todo $j$.

Incisos: (1) definir casos base y recursion, (2) escribir matematicamente la funcion, (3) indicar el llamado que resuelve el problema, (4) disenар algoritmo PD top-down con complejidades, (5) demostrar correctitud.

**Explicacion**
Introduce estados con 2 parametros. El estado captura dos dimensiones: en que dia estoy y cuantos asteroides tengo. La semantica de la funcion es critica para definir correctamente los casos base y el paso recursivo.

**Resolucion paso a paso**

**Estado y semantica:**
$$\text{mgn}(a, d) = \text{maxima ganancia neta si Lu tiene } a \text{ asteroides al final del dia } d$$

**Casos base:**
- $\text{mgn}(a, d) = -\infty$ si $a < 0$ (vendio lo que no tenia)
- $\text{mgn}(a, d) = -\infty$ si $a > d$ (tiene mas asteroides que dias posibles de haber comprado)
- $\text{mgn}(0, 0) = 0$ (sin asteroides al inicio)

**Paso recursivo:** el maximo entre 3 acciones el dia $d$:
$$\text{mgn}(a, d) = \max\begin{cases}
\text{mgn}(a-1, d-1) - p_d & \text{(comprar un asteroide el dia } d\text{)} \\
\text{mgn}(a+1, d-1) + p_d & \text{(vender un asteroide el dia } d\text{)} \\
\text{mgn}(a, d-1) & \text{(no operar el dia } d\text{)}
\end{cases}$$

**Version simplificada:**
$$\text{mgn}(a, d) = \begin{cases}
-\infty & a < 0 \text{ o } a > d \\
0 & d = 0 \\
\max(\text{mgn}(a-1, d-1) - p_d,\ \text{mgn}(a+1, d-1) + p_d,\ \text{mgn}(a, d-1)) & \text{si no}
\end{cases}$$

**Llamado:** `mgn(0, |p|)` — terminar con 0 asteroides despues de todos los dias.

*Nota: se puede demostrar que en toda solucion optima Lu termina con 0 asteroides. Si quedara con $k > 0$, se podria mejorar eliminando la ultima compra (suma $p_i > 0$ a la ganancia) → contradiccion con optimalidad.*

**Algoritmo PD top-down:**
```cpp
// M: matriz (|p|+1) x (|p|+1) inicializada en -INF
int mgn(int asteroid, int day) {
    if (asteroid < 0 || asteroid > day) return NEG;
    if (day == 0) return 0;
    int &memo = gain_per_day_and_asteroid[day][asteroid];
    if (memo != NEG) return memo;
    int ans = mgn(asteroid, day - 1);
    ans = max(ans, mgn(asteroid - 1, day - 1) - prices[day]);
    ans = max(ans, mgn(asteroid + 1, day - 1) + prices[day]);
    memo = ans;
    return memo;
}
```

**Complejidades:**
- Espacial: $O(n^2)$ (matriz de tamano $(n+1) \times (n+1)$)
- Backtracking sin memo: $O(3^n)$ (cada dia: 3 acciones)
- **PD con memo:** $O(n^2)$ estados × $O(1)$ por estado = $O(n^2)$
- *Posible mejora espacial: ver bottom-up con solo las ultimas 2 filas → $O(n)$*

**Superposicion:** $n^2$ estados vs $\Omega(2^n)$ llamados de backtracking. Se cumple cuando $n^2 \ll 2^n$.

**Demostracion de correctitud — por induccion en $d$:**

**Proposicion:** para todo $d \in \{0, \ldots, n\}$ y todo $a$, `mgn(a, d)` devuelve la maxima ganancia neta al final del dia $d$ con $a$ asteroides.

**Caso base** $d=0$: el unico estado valido es $a=0$ con ganancia 0. Para $a \ne 0$ se retorna $-\infty$ (estado invalido). Correcto.

**HI:** la proposicion vale para $d-1$.

**Paso inductivo:** toda secuencia factible que lleva al estado $(a, d)$ proviene de $(a, d-1)$, $(a-1, d-1)$ o $(a+1, d-1)$ mediante no operar, comprar o vender. Por HI, cada termino representa la ganancia maxima del estado previo. El maximo de los tres es la mejor accion en el dia $d$.

**Chuleta**
> Estado: (asteroides, dia). Semantica: mgn(a,d) = max ganancia con a asteroides al dia d. Casos base: a<0 o a>d → -inf; d=0 → 0. Paso: max(comprar, vender, no-operar). Llamado: mgn(0, n). O(n²) tiempo y espacio.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/pd_definir_recursion]]

---

### Ejercicio 3 — Tobi el Granjero

**Enunciado**
El abuelo de Tobi tiene un terreno de $N \times M$ celdas con arvejas. Tobi empieza en una celda $(x, 0)$ y puede moverse solo hacia adelante-izquierda o adelante-derecha. Quiere llegar a la fila $N$ con la maxima cantidad de arvejas **divisible por $K+1$**. Devolver -1 si es imposible.

Input: $n$, $m$, $k$ (filas, columnas, modulo), luego la grilla de valores. Output: maximo de arvejas (divisible por $k+1$), posicion inicial, y secuencia de movimientos (I/D).

Nota: problema extraido de Codeforces con cotas $2 \le n, m \le 100$, $0 \le k \le 10$.

**Explicacion**
Introduce el refinamiento del estado. La definicion naive lleva a $O(M^2 N^2)$ estados (inaceptable). La clave: no necesitamos saber *cuantas* arvejas llevamos, sino su *modulo* respecto a $k+1$ → $O(MNK)$ estados.

**Resolucion paso a paso**

**Estado inicial (ingenuo):**

$f(x, y, arv)$ = max arvejas divisibles por $k+1$ que puede obtener Tobi partiendo de $(x, y)$ con $arv$ arvejas acumuladas.

$$f(x, y, arv) = \begin{cases}
0 & y = n \wedge arv \bmod (k+1) = 0 \\
-\infty & y = n \wedge arv \bmod (k+1) \ne 0 \\
\text{terr}[x][y] + f(x+1, y+1, \text{sigArv}) & x = 0 \\
\text{terr}[x][y] + f(x-1, y+1, \text{sigArv}) & x = m-1 \\
\text{terr}[x][y] + \max(f(x-1, y+1, \text{sigArv}), f(x+1, y+1, \text{sigArv})) & \text{sino}
\end{cases}$$

Problema: la matriz de memoizacion es $O(m) \times O(n) \times O(mn \cdot 10) = O(M^2 N^2)$. Muy pesado.

**Refinamiento — usar modulo en lugar de acumulado:**

Observacion: si estoy en $(x, y)$ con 10 arvejas (mod 2 = 0) y con 8 arvejas (mod 2 = 0), el comportamiento futuro es identico. Solo importa $arv \bmod (k+1)$.

**Estado refinado:** $f(x, y, arvMod)$ donde $arvMod = arv \bmod (k+1) \in \{0, 1, \ldots, k\}$.

$$f(x, y, arvMod) = \begin{cases}
0 & y = n \wedge arvMod = 0 \\
-\infty & y = n \wedge arvMod \ne 0 \\
\text{terr}[x][y] + f(x+1, y+1, \text{sigArv}) & x = 0 \\
\text{terr}[x][y] + f(x-1, y+1, \text{sigArv}) & x = m-1 \\
\text{terr}[x][y] + \max(f(x-1, y+1, \text{sigArv}), f(x+1, y+1, \text{sigArv})) & \text{sino}
\end{cases}$$

donde $\text{sigArv} = (arvMod + \text{terr}[x][y]) \bmod (k+1)$.

**Llamado:** para cada $i \in \{0, \ldots, m-1\}$: `f(i, 0, 0)`. El resultado es el maximo de todos.

**Implementacion Python:**
```python
def dp(x, y, arvMod):
    if y == n:
        if arvMod == 0: return 0
        return -INF
    arvMod = (arvMod + grid[y][x]) % (k+1)
    if memoria[y][x][arvMod] != -1:
        return memoria[y][x][arvMod]
    maxArvs = -INF
    if x > 0:
        maxArvs = max(maxArvs, dp(x-1, y+1, arvMod))
    if x < m-1:
        maxArvs = max(maxArvs, dp(x+1, y+1, arvMod))
    maxArvs += grid[y][x]
    memoria[y][x][arvMod] = maxArvs
    return maxArvs

# Resolucion
memoria = [[[-1 for _ in range(k+2)] for _ in range(m+1)] for _ in range(n+1)]
optimo = -1
for c in range(m):
    res = dp(c, 0, 0)
    optimo = max(optimo, res)
```

**Complejidades:**
- Espacial: $O(MNK)$ (tres dimensiones de la memoria)
- Mejora posible: $O(MK)$ guardando solo las ultimas 2 filas (la complejidad temporal no cambia)
- **Temporal:** $O(MNK)$ estados × $O(1)$ = $O(MNK)$

**Superposicion:**
- Backtracking: $\Omega(M \cdot 2^{N/2})$ (cada columna es un inicio, N/2 filas con 2 opciones)
- PD: $O(MNK)$ estados
- Se cumple cuando $K < 2^{N/2}/N$ — con las cotas del problema ($n, m \le 100$, $k \le 10$): $10 < 2^{100}/100$ ✓

**Reconstruccion del camino ($O(N)$):**
1. Encontrar el $i$ optimo (inicio de columna)
2. Iterar desde $f(i, 0, 0)$: en cada fila $y$, ver cual de las dos celdas siguientes $(j \in \{i-1, i+1\})$ cumple $f(j, y+1, arv + \text{terr}[x][y]) = f(x, y, arv) - \text{terr}[x][y]$
3. Registrar I o D segun la decision

**Chuleta**
> Estado REFINADO: (x, y, arvMod) donde arvMod = arvejas_acumuladas mod (k+1). Casos base: y=n y arvMod=0 → 0; y=n y arvMod≠0 → -inf. Paso: mover izq/der segun limites. Llamado: max(f(i,0,0)) para i en [0,m). O(MNK) tiempo y espacio.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/pd_definir_recursion]]

---

## Ver tambien
- [[programacion_dinamica_teoria]] — PD top-down vs bottom-up, SCML, mochila, monedas (con demos formales)
- [[programacion_dinamica_top_down_practica_pt2]] — Receta 6 pasos, Vacations, Caesar's Legions, Fire
- [[programacion_dinamica_guia]] — Guia de ejercicios del tema
