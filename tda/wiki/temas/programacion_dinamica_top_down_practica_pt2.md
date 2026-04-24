---
nombre: Programacion Dinamica Top-Down — Clase Practica (2023)
parcial: 1P
tipo: practica
tema: programacion_dinamica
fuente: raw/clases/prac/3.prac_1P_programacion_dinamica_top_down_parte2.pdf
paginas_relacionadas:
  - "[[programacion_dinamica_teoria]]"
  - "[[programacion_dinamica_top_down_practica_pt1]]"
---

# Programacion Dinamica Top-Down — Clase Practica Pt2 (2023)

> Clase del 2do cuatrimestre 2023. 34k chars, formato handout. Provee la **Receta de 6 pasos** para PD top-down + 3 ejercicios de Codeforces resueltos completamente siguiendo la receta.

---

## Receta de 6 pasos para PD Top-Down

> Esta receta es la metodologia esperada en los parciales para resolver ejercicios de PD.

### Paso 1 — Definir la funcion recursiva f

**Como encontrar el estado:**
Identificar la informacion minima necesaria en cada paso recursivo para calcular lo que buscamos. Preguntas guia:
- ¿Que necesito en el paso recursivo para calcular el objetivo?
- ¿Cuales son los parametros de la funcion?
- ¿A que estados puedo transicionar desde el estado actual?

**Tip:** Describir con palabras lo que hace la funcion antes de escribirla matematicamente.

**Pasos para construir f:**
1. **Estado del problema:** identificar parametros que capturan toda la informacion relevante
2. **Transiciones:** dado un estado, ¿a que estados se puede ir?
3. **Casos base:** estados donde la respuesta es inmediata y simple

**Tip:** No multiplicar casos base innecesarios — si un estado base se puede calcular con el paso recursivo, no hace falta ponerlo como caso base explicitamente (aunque no este mal hacerlo).

### Paso 2 — Explicar la semantica de f

Describir en palabras que representan:
- Los parametros
- Los casos base
- Los pasos recursivos

### Paso 3 — Llamados que resuelven el problema

Determinar que estados candidatos del problema dan la solucion final.

### Paso 4 — Probar superposicion de subproblemas

**Receta:**
1. Calcular una cota inferior $\Omega(g(n))$ de la cantidad de llamados recursivos (sin memo)
2. Calcular la cantidad de estados posibles $O(f(n))$ = producto de rangos de cada parametro
3. Concluir: la PD es mejor cuando $f(n) \ll g(n)$

**Nota importante:** No "probar" la superposicion mostrando un solo caso particular. Dar la condicion general sobre los parametros.

### Paso 5 — Diseno del algoritmo PD

**Como elegir la estructura de memoria:**
- La funcion tiene $X$ parametros
- Construir una matriz de $X$ dimensiones
- Cada dimension corresponde al rango de valores de ese parametro

**"Parcheo" del algoritmo:**
```python
# Sin dinámica:
def f(params):
    # ... calcular resultado ...
    return resultado

# Con dinámica:
memo = inicializar_con_invalido(dimensiones)
def f(params):
    if memo[params] != invalido:
        return memo[params]
    # ... calcular resultado ...
    memo[params] = resultado
    return memo[params]
```

### Paso 6 — Determinar complejidad

**Formula:**
$$\text{Complejidad} = \text{(cantidad de estados)} \times \text{(costo de calcular cada estado)}$$
$$\text{Complejidad espacial} = \text{(cantidad de estados)} \times \text{(tamano del resultado por estado)}$$

---

## Ejercicios de clase

### Ejercicio — Vacations (Codeforces 698/A)

**Enunciado**
Pepi tiene $N$ dias de vacaciones. Cada dia puede tener disponible: ninguna actividad, solo gimnasio, solo competencia, o ambas. Pepi puede hacer una actividad disponible (pero NO la misma que el dia anterior) o descansar. Minimizar la cantidad de dias de descanso.

Ejemplo: dias disponibles $[(gym), (comp), (gym), (ambas), (ninguna)] \to$ minimo 1 descanso.

Es un ejercicio de **optimizacion** (minimizar descansos).

**Paso 1 — Estado:**
¿Que necesitamos para calcular cuantos descansos minimos quedan?
- El numero del dia actual $d$
- La ultima actividad que hicimos $ult$ (para no repetirla)

$f(d, ult)$ = minimo de dias de descanso desde el dia $d$ en adelante, habiendo hecho $ult$ el dia anterior.

**Paso 2 — Semantica:**
- $d$: dia actual (de 1 a N)
- $ult \in \{0, 1, 2\}$: 0 = descanso/nada, 1 = gimnasio, 2 = competencia
- Casos base: $d > N$ → 0 (no quedan dias)
- Paso recursivo: para cada accion posible en el dia $d$, calcular el costo y recursar

**Paso 3 — Llamado:**
$\min_{ult \in \{0,1,2\}} f(1, ult)$ — comenzar el dia 1 sin restriccion previa.

**Paso 4 — Superposicion:**
- Backtracking: a lo sumo 3 llamados recursivos por dia → $O(3^N)$
- Estados: $O(N) \times O(3) = O(3N)$
- Se cumple cuando $3N \ll 3^N$ (siempre para $N$ suficientemente grande)

**Paso 5 — Algoritmo:**
```
Memoria M de tamaño (N+1) × 3, inicializada en invalido.
f(d, ult):
  Si d > N devolver 0
  Si M[d][ult] != invalido devolver M[d][ult]
  resultado ← 1 + f(d+1, 0)   [siempre puedo descansar]
  Si disp[d] tiene gym y ult != 1:
    resultado ← min(resultado, f(d+1, 1))
  Si disp[d] tiene comp y ult != 2:
    resultado ← min(resultado, f(d+1, 2))
  M[d][ult] ← resultado
  devolver M[d][ult]
```

**Paso 6 — Complejidad:**
- Cantidad de estados: $O(N \cdot 3) = O(N)$
- Costo por estado: $O(1)$ (a lo sumo 3 llamados recursivos + min)
- **Complejidad total:** $O(N)$

**Chuleta**
> Estado: (dia, ultima_actividad). Semantica: min descansos desde dia d con ultima=ult. Llamado: min(f(1,0), f(1,1), f(1,2)). Complejidad: O(N). Truco: ult previene repeticion.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/pd_definir_recursion]]

---

### Ejercicio — Caesar's Legions (Codeforces 118/D)

**Enunciado**
El general Caesar tiene $P$ patos y $D$ dodos que quiere poner en linea. Restricciones: no mas de $MP$ patos consecutivos, no mas de $MD$ dodos consecutivos. Los animales de cada tipo son indistinguibles. Contar las combinaciones validas.

Es un ejercicio de **conteo**.

**Paso 1 — Estado:**
¿Que necesitamos para calcular cuantas formaciones validas quedan?
- Patos restantes $p$ (aun no colocados)
- Dodos restantes $d$
- Consecutivos del tipo actual $cp$ (patos consecutivos al final de la formacion hasta ahora)
- Consecutivos del tipo actual $cd$ (dodos consecutivos al final)

$f(p, d, cp, cd)$ = cantidad de formaciones validas con $p$ patos y $d$ dodos restantes, habiendo puesto $cp$ patos y $cd$ dodos consecutivos al final.

**Paso 2 — Semantica:**
- $p, d$: animales restantes de cada tipo
- $cp \in \{0, \ldots, MP\}$, $cd \in \{0, \ldots, MD\}$: consecutivos al final (solo uno puede ser $> 0$ a la vez)
- Caso base: $p = 0 \wedge d = 0$ → 1 (formacion completa valida)
- Paso recursivo: elegir poner un pato (si $p > 0$ y $cp < MP$) o un dodo (si $d > 0$ y $cd < MD$)

**Paso 3 — Llamado:**
$f(P, D, 0, 0)$ — comenzar con todos los animales disponibles y sin consecutivos.

**Paso 4 — Superposicion:**
- Backtracking: $\Omega(2^{P+D})$ (en cada paso 2 elecciones)
- Estados: $O(P \cdot D \cdot MP \cdot MD)$
- Se cumple cuando $P \cdot D \cdot MP \cdot MD \ll 2^{P+D}$

**Paso 5 — Algoritmo:**
```
Memoria M de tamaño (P+1)×(D+1)×(MP+1)×(MD+1), inicializada en -1.
f(p, d, cp, cd):
  Si p = 0 y d = 0: devolver 1
  Si M[p][d][cp][cd] != -1: devolver M[p][d][cp][cd]
  resultado ← 0
  Si p > 0 y cp < MP:
    resultado ← resultado + f(p-1, d, cp+1, 0)
  Si d > 0 y cd < MD:
    resultado ← resultado + f(p, d-1, 0, cd+1)
  M[p][d][cp][cd] ← resultado
  devolver resultado
```

**Paso 6 — Complejidad:**
- Estados: $O(P \cdot D \cdot MP \cdot MD)$
- Costo por estado: $O(1)$ (2 posibles llamados recursivos)
- **Complejidad total:** $O(P \cdot D \cdot MP \cdot MD)$

**Chuleta**
> Estado: (p, d, cp, cd). Semantica: combinaciones con p patos y d dodos restantes, cp patos y cd dodos al final. Llamado: f(P, D, 0, 0). Complejidad: O(P·D·MP·MD). Truco: cp y cd nunca son >0 simultaneamente.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/pd_definir_recursion]] · [[tipos_ejercicio/pd_superposicion_subproblemas]]

---

### Ejercicio — Fire (Codeforces 864/E)

**Enunciado**
El sabueso debe salvar articulos de una casa en llamas. Cada articulo $i$ tiene:
- $t_i$: tiempo que tarda en salvarlo
- $d_i$: tiempo a partir del cual se quema (ya no se puede salvar)
- $p_i$: valor del articulo

Salva los articulos uno tras otro. Si ya tardo $T$ segundos en total y salva el articulo $i$, debe satisfacer $T + t_i \le d_i$. Maximizar la suma de valores salvados.

Es un ejercicio de **optimizacion** (maximizar valor).

**Paso 1 — Estado:**
¿Que necesitamos para calcular el maximo valor que puede salvar desde ahora?
- El articulo actual que considera $i$ (siguiendo un orden)
- El tiempo acumulado hasta ahora $t$

**Observacion clave:** los articulos deben ordenarse por $d_i$ (deadline) antes de aplicar PD. Es un resultado estandar de scheduling: si vamos a salvar un subconjunto, conviene hacerlo en orden de deadline (greedy de correctitud).

$f(i, t)$ = maximo valor que puede obtener considerando los articulos $i, i+1, \ldots, n$ con $t$ segundos ya usados.

**Paso 2 — Semantica:**
- $i$: siguiente articulo a considerar (ya ordenados por deadline)
- $t$: tiempo total acumulado hasta el articulo $i$
- Caso base: $i > n$ → 0
- Paso recursivo: para el articulo $i$, elegir salvarlo (si $t + t_i \le d_i$) o no salvarlo

**Paso 3 — Llamado:**
$f(1, 0)$ — comenzar desde el primer articulo sin tiempo acumulado.

**Paso 4 — Superposicion:**
- Backtracking: $\Omega(2^n)$ (para cada articulo: salvar o no)
- Estados: $O(n \cdot T_{max})$ donde $T_{max} = \max d_i$ (cota maxima del tiempo)
- Se cumple cuando $n \cdot T_{max} \ll 2^n$

**Paso 5 — Algoritmo:**
```
Ordenar articulos por d_i (deadline).
Memoria M de tamaño (n+1) × (T_max+1), inicializada en invalido.
f(i, t):
  Si i > n: devolver 0
  Si M[i][t] != invalido: devolver M[i][t]
  resultado ← f(i+1, t)                       [no salvar articulo i]
  Si t + tiempo[i] <= deadline[i]:
    resultado ← max(resultado, valor[i] + f(i+1, t + tiempo[i]))
  M[i][t] ← resultado
  devolver resultado
```

**Paso 6 — Complejidad:**
- Estados: $O(n \cdot T_{max})$
- Costo por estado: $O(1)$ (2 opciones)
- **Complejidad total:** $O(n \cdot T_{max})$

**Chuleta**
> Ordenar por deadline. Estado: (articulo, tiempo_acumulado). Semantica: max valor desde articulo i con t segundos usados. Llamado: f(1,0). Complejidad: O(n·T_max). Truco: ordenar por deadline primero (greedy de orden).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/pd_definir_recursion]]

---

## Ver tambien
- [[programacion_dinamica_teoria]] — PD top-down vs bottom-up, SCML, mochila, monedas (con demos formales)
- [[programacion_dinamica_top_down_practica_pt1]] — AstroTrade, Tobi el granjero (2025)
