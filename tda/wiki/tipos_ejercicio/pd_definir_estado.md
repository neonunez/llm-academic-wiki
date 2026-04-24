---
nombre: PD — Definir el estado (elegir dimensiones)
parcial: 1P
tema: programacion_dinamica
apariciones_en_parciales:
  - wiki/parciales_analizados/1P_1C_2024.md
  - wiki/parciales_analizados/1P_1C_2025.md
---

# PD — Definir el estado (elegir dimensiones)

## Como reconocer este patron

- El enunciado da un problema de optimizacion o conteo y pide diseñar una solucion PD.
- La dificultad esta en **que recordar** entre etapas, no solo en escribir la recursion.
- Señales: el problema tiene mas de un "recurso" que evoluciona (ej: posicion + cantidad acumulada), o la decision en la etapa $i$ depende de mas de un parametro del estado anterior.
- Relacionado con [[tipos_ejercicio/pd_definir_recursion]], que cubre el template completo de escribir la recursion y calcular complejidad una vez que el estado ya esta definido.

## Template de resolucion

### Paso 1: Identificar los parametros variables

Preguntar: "Si en la etapa $i$ quisiera saber la solucion optima al subproblema, ¿que informacion adicional necesito ademas de $i$?"

Cada pieza de informacion que varia entre llamadas y afecta la optimalidad es una **dimension del estado**.

### Paso 2: Regla de inclusion/exclusion de dimensiones

| Incluir en el estado | No incluir en el estado |
|----------------------|------------------------|
| Parametro que varia entre subproblemas | Parametro constante para toda la instancia ($k$, $n$, $W$) |
| Parametro del que depende la decision optima en el paso actual | Informacion que puede derivarse de los parametros ya incluidos |
| Recurso que puede "agotarse" o acumularse (cantidades, pesos, indices) | Variables auxiliares que pueden calcularse al final |

### Paso 3: Verificar que el estado es suficiente

El estado $(p_1, p_2, \ldots)$ es suficiente si y solo si: conocer el estado en la etapa actual es suficiente para determinar la solucion optima del subproblema **sin importar como se llego a ese estado** (principio de optimalidad de Bellman).

### Paso 4: Acotar las dimensiones

Para cada dimension, determinar su rango. El tamaño de la tabla de memoizacion es el producto de todos los rangos. Esto determina la complejidad espacial y (con el costo por celda) la complejidad temporal.

## Por que funciona

La tabla de memoizacion almacena exactamente un valor por estado. Si el estado es suficiente (paso 3), cada valor se computa una unica vez y se reutiliza. Si el estado tiene dimensiones de mas, la tabla sera mas grande de lo necesario pero la solucion seguira siendo correcta. Si tiene dimensiones de menos, habra subproblemas indistinguibles que en realidad son distintos, y la solucion sera incorrecta.

## Apariciones en parciales

### 1P bottom-up — Pila Cauta (dos formulaciones del estado)

Problema de apilar cajas con restricciones de peso y soporte. Hay **dos estados validos distintos**:

- **Version 1:** Estado $(i, p)$ = maximas cajas apilables usando las primeras $i$ cajas con peso total $p$ disponible sobre la pila. Tabla: $N \times W$. Complejidad $O(N \cdot W)$.
- **Version 2:** Estado $(i, l)$ = maximo soporte disponible encima si se apilan exactamente $l$ cajas seleccionadas entre las primeras $i$. Tabla: $N \times N$. Complejidad $O(N^2)$.

La eleccion del estado cambia completamente la dimension de la tabla y la complejidad resultante.

### 1P bottom-up — Astro Trade (estado con cantidad de asteroides)

$\text{mgn}(a, d)$ = maxima ganancia neta al final del dia $d$ poseyendo $a$ asteroides. La clave es incluir $a$ (la cantidad de asteroides) como dimension del estado, porque la decision del dia $d$ (comprar/vender/no operar) depende de cuantos asteroides se tienen. Sin esta dimension, no se puede distinguir estados con distinto numero de asteroides → solucion incorrecta.

### 1P_1C_2025 — Numero combinatorio $\binom{N}{K}$

Estado $(N, K)$: ambos parametros varian, ambos se incluyen. Tabla $N \times K$, complejidad $\Theta(N \cdot K)$.

## Ejercicios que ejemplifican esto

- [[programacion_dinamica_bottom_up_practica]] — Pila Cauta (dos formulaciones), Astro Trade bottom-up
- [[programacion_dinamica_top_down_practica_pt1]] — AstroTrade top-down, definicion de $\text{mgn}(a,d)$
- [[sintesis/repaso_1P]] — Pila Cauta con analisis de las dos versiones
- [[tipos_ejercicio/pd_definir_recursion]] — una vez elegido el estado, template para escribir la recursion y calcular complejidad
