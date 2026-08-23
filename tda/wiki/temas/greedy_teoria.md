---
nombre: Greedy — Teoria
parcial: 2P
programa: 2C_2026
tipo: teoria
tema: greedy
fuentes:
  vigente: []
  historico:
    - raw/clases/teo/4.teo_1P_greedy.pdf
    - raw/clases/teo/4.teo_1P_demo_seleccion_de_actividades.pdf
estado_verificacion: pendiente_verificacion
paginas_relacionadas:
  - "[[programacion_dinamica_teoria]]"
  - "[[fuerza_bruta_backtracking_teoria]]"
---

> ⚠️ **Sin verificar contra la cursada actual.** El contenido de esta pagina viene de
> cuatrimestres pasados. Los contenidos son los mismos, pero puede haber diferencias de
> notacion, alcance u orden. Ver [[programa]].

# Greedy — Teoria

## Concepto y definicion

### Heuristicas

- Una **heuristica** es un procedimiento computacional que intenta obtener soluciones de buena calidad, intentando que su comportamiento sea lo mas preciso posible.
- Un algoritmo es **$\epsilon$-aproximado** ($\epsilon \geq 0$) para un problema de optimizacion si:

$$\frac{x_A - x_{OPT}}{x_{OPT}} \leq \epsilon$$

> Clases de complejidad relacionadas: APX (approximable) y PTAS (polynomial-time approximation scheme).

### Algoritmos golosos

**Idea:** Construir una solucion seleccionando en cada paso la **mejor alternativa local**, sin considerar (o haciendolo debilmente) las implicancias de esta seleccion.

**Propiedades:**
- Habitualmente proporcionan **heuristicas sencillas** para problemas de optimizacion.
- En general permiten construir soluciones razonables (pero sub-optimas) en tiempos eficientes.
- Sin embargo, en ocasiones son **optimos** — y eso hay que demostrarlo.

## Cuando se aplica

- Problemas de optimizacion donde la **eleccion localmente optima conduce al optimo global**.
- Requiere demostrar que la estrategia greedy es correcta (tipicamente por **intercambio** o **induccion**).
- Si no se puede probar optimalidad, el greedy puede servir como heuristica rapida.

## Ejemplo 1: Problema de la mochila

### Datos

Capacidad $C \in \mathbb{Z}^+$, $n$ objetos con peso $p_i \in \mathbb{Z}_{>0}$ y beneficio $b_i \in \mathbb{Z}_{>0}$.

### Estrategias greedy

Mientras no se exceda la capacidad, agregar el objeto que:
1. Tenga **mayor beneficio** $b_i$.
2. Tenga **menor peso** $p_i$.
3. **Maximice el cociente** $b_i / p_i$.

Ninguna de estas estrategias es optima para la mochila entera (0-1).

### Mochila fraccionaria

Si se puede poner una **fraccion** de cada elemento:

```
Ordenar objetos de mayor a menor cociente b_i/p_i
L <- C
i <- 1
mientras L > 0 y i <= n:
  x <- min{1, L/p_i}
  Agregar fraccion x del objeto i a la solucion
  L <- L - x * p_i
  i <- i + 1
```

**Teorema.** El algoritmo goloso por cocientes $b_i/p_i$ encuentra una solucion optima del problema de la mochila fraccionario.

## Ejemplo 2: Problema del cambio de monedas (greedy)

### Datos

Denominaciones $a_1, \ldots, a_k \in \mathbb{Z}^+$ (con $a_i > a_{i+1}$), valor del cambio $t$.

### Algoritmo greedy

```
s <- 0
i <- 1
mientras s < t y i <= k:
  c <- floor((t - s) / a_i)
  Agregar c monedas de tipo i a la solucion
  s <- s + c * a_i
  i <- i + 1
```

**Comportamiento:** en cada paso selecciona la moneda de mayor valor posible, sin preocuparse de que esto pueda llevar a una mala solucion. Nunca modifica una decision tomada.

### Cuando funciona y cuando no

- **Funciona** para monedas de 1, 5, 10, 25 centavos (sistema estandar estadounidense).
- **No funciona** si agregamos monedas de 12 centavos: para devolver 21 centavos, el greedy da 6 monedas (12+5+1+1+1+1) vs optimo 3 monedas (10+10+1).

### Teorema (condicion suficiente)

Si existen $m_2, \ldots, m_k \in \mathbb{Z}_{\geq 2}$ tales que $a_i = m_{i+1} \cdot a_{i+1}$ para $i = 1, \ldots, k-1$ (cada denominacion es multiplo de la siguiente), entonces toda solucion optima usa $\lfloor t/a_1 \rfloor$ monedas de tipo $a_1$.

**Corolario.** Bajo esta condicion, el algoritmo goloso proporciona una solucion optima.

## Ejemplo 3: Tiempo de espera total en un sistema

### Datos

Un servidor con $n$ clientes, tiempo de atencion $t_i \in \mathbb{R}^+$ para cada cliente $i$.

**Objetivo:** Determinar el orden de atencion que minimice la suma de tiempos de espera.

Si $I = (i_1, i_2, \ldots, i_n)$ es el orden de atencion:

$$T = t_{i_1} + (t_{i_1} + t_{i_2}) + (t_{i_1} + t_{i_2} + t_{i_3}) + \cdots = \sum_{k=1}^{n} (n-k) \cdot t_{i_k}$$

### Algoritmo greedy

En cada paso, atender al cliente pendiente con **menor tiempo de atencion**. Retorna permutacion $I_{GOL} = (i_1, \ldots, i_n)$ con $t_{i_j} \leq t_{i_{j+1}}$.

**Teorema.** El algoritmo goloso por menor tiempo de atencion proporciona una solucion optima para minimizar el tiempo total de espera.

## Ejemplo 4: Seleccion de actividades

### Datos

Un aula y $n$ actividades, cada una con hora de inicio $s_i$ y fin $f_i$. Solo una actividad puede usar el aula a la vez. Las actividades no se pueden interrumpir.

**Objetivo:** Maximizar el numero de actividades que se pueden programar sin solapamiento.

### Estrategias greedy posibles

1. Elegir la actividad **mas corta** disponible.
2. Elegir la que **empiece mas temprano**.
3. Elegir la que **termine mas temprano**.
4. Elegir la que tenga **menos conflictos**.

La estrategia correcta es la **(3): elegir la que termine mas temprano** — "liberar el recurso" lo antes posible maximiza las oportunidades futuras.

## Demostraciones

### Principio de intercambio (exchange argument)

Tecnica para demostrar optimalidad de algoritmos greedy:

1. Suponer que existe una solucion optima $O$ diferente de la greedy $G$.
2. Identificar la primera diferencia entre $O$ y $G$.
3. Intercambiar elementos en $O$ para hacerla mas parecida a $G$.
4. Demostrar que el intercambio **no empeora** el valor de $O$.
5. Repetir hasta que $O$ sea identica a $G$.
6. Concluir que $G$ es optima.

### Demostracion: Seleccion de actividades

**Teorema.** El algoritmo greedy por tiempo de finalizacion minimo es optimo para el problema de seleccion de actividades.

**Notacion:**
- Actividades ordenadas por fin: $f_1 \leq f_2 \leq \ldots \leq f_n$
- Solucion greedy: $G = \{g_1, g_2, \ldots, g_k\}$ (por orden de seleccion)
- Solucion optima arbitraria: $O = \{o_1, o_2, \ldots, o_m\}$ (por tiempo de fin)
- **Objetivo:** demostrar que $|G| = |O|$

**Lema.** Para todo $i \leq \min(|G|, |O|)$: $f(g_i) \leq f(o_i)$.

*Demostracion por induccion sobre $i$:*

**Base ($i = 1$):** $g_1$ es la actividad con menor tiempo de finalizacion entre todas las disponibles. Como $o_1$ es una de esas actividades, $f(g_1) \leq f(o_1)$.

**Paso inductivo:** Supongamos $f(g_j) \leq f(o_j)$ para todo $j < i$.

1. **Compatibilidad en $O$:** $s(o_i) \geq f(o_{i-1})$ (por definicion de solucion valida).
2. **Hipotesis inductiva:** $f(g_{i-1}) \leq f(o_{i-1})$.
3. **Transitividad:** $s(o_i) \geq f(o_{i-1}) \geq f(g_{i-1})$.
4. **Conclusion:** $o_i$ es compatible con $\{g_1, \ldots, g_{i-1}\}$.
5. **Eleccion greedy:** como el greedy elige la que termina mas temprano entre las compatibles: $f(g_i) \leq f(o_i)$. $\blacksquare$

**Demostracion del teorema (por contradiccion):**

Supongamos $|G| < |O|$. Entonces existe $o_{|G|+1} \in O$:

$$s(o_{|G|+1}) \geq f(o_{|G|}) \geq f(g_{|G|}) \quad \text{(por el lema)}$$

Entonces $o_{|G|+1}$ es compatible con todas las actividades de $G$. Pero si existe una actividad compatible, el algoritmo greedy no deberia haberse detenido — **contradiccion**. $\blacksquare$

## Propiedades y teoremas

| Problema | Estrategia greedy | Optimo? |
|----------|-------------------|---------|
| Mochila fraccionaria | Mayor cociente $b_i/p_i$ | Si |
| Mochila 0-1 | Cualquier criterio simple | No |
| Cambio de monedas | Mayor denominacion | Si (si denominaciones son multiplos) |
| Tiempo de espera | Menor tiempo de atencion | Si |
| Seleccion de actividades | Menor tiempo de finalizacion | Si |

## Formulas clave

$$\frac{x_A - x_{OPT}}{x_{OPT}} \leq \epsilon \quad \text{(algoritmo } \epsilon\text{-aproximado)}$$

$$T = \sum_{k=1}^{n} (n-k) \cdot t_{i_k} \quad \text{(tiempo de espera total)}$$

## Ver tambien

- [[programacion_dinamica_teoria]] — alternativa exacta cuando greedy no es optimo (mochila 0-1, cambio general)
- [[fuerza_bruta_backtracking_teoria]] — baseline exacto para comparar con heuristicas greedy
