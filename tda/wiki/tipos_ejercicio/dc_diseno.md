---
nombre: D&C — Diseño de algoritmos Divide & Conquer
parcial: 1P
programa: 2C_2026
tema: divide_y_conquista
apariciones_en_parciales:
  - wiki/parciales_analizados/1P_1C_2024.md
  - wiki/parciales_analizados/1P_1C_2025.md
---

# D&C — Diseño de algoritmos Divide & Conquer

## Como reconocer este patron

- Piden **diseñar** un algoritmo D&C (no solo analizar la recurrencia).
- El enunciado da un problema que admite descomposicion en subproblemas de tamaño $n/b$, con una etapa de combinacion no trivial.
- Piden identificar: subproblemas, division, combinacion, correctitud o complejidad.
- Señal tipica: "Diseñar un algoritmo D&C que resuelva X en $O(f(n))$."

Diferencia con [[tipos_ejercicio/dc_teorema_maestro]]: ahi el algoritmo ya esta dado y hay que resolver la recurrencia. Aqui hay que **construir** el algoritmo.

## Template de resolucion

### Paso 1: Identificar los subproblemas

Definir formalmente la funcion recursiva: ¿sobre que parametro(s) se divide? ¿el problema sobre el indice $[i..j]$? ¿sobre el tamaño $n$?

### Paso 2: Definir las tres etapas

| Etapa | Descripcion |
|-------|-------------|
| **Divide** | Partir la entrada en $a$ subproblemas de tamaño $n/b$. Verificar que la division es balanceada. |
| **Conquer** | Llamadas recursivas sobre cada subproblema. Caso base cuando $n \leq c$. |
| **Combine** | Ensamblar las soluciones parciales. Aqui suele estar el costo dominante. |

### Paso 3: Escribir la recurrencia

$$T(n) = a \cdot T(n/b) + f(n)$$

donde $a$ = cantidad de subproblemas, $b$ = factor de reduccion, $f(n)$ = costo de combine.

### Paso 4: Demostrar correctitud (si se pide)

Induccion fuerte sobre $n$:
1. **Caso base:** $n \leq c$ — verificar que el caso base retorna el resultado correcto directamente.
2. **Hipotesis inductiva (HI):** el algoritmo resuelve correctamente instancias de tamaño $< n$.
3. **Paso inductivo:** mostrar que, dados los subresultados correctos por HI, el combine produce la solucion correcta para tamaño $n$.

### Paso 5: Calcular complejidad

Aplicar Teorema Maestro a la recurrencia del paso 3. Ver [[tipos_ejercicio/dc_teorema_maestro]] para el template completo.

## Por que funciona

D&C es correcto cuando:
- Los subproblemas cubren toda la entrada (no se omite ninguna parte).
- Las soluciones parciales son suficientes para ensamblar la solucion global (subestructura optima o propiedad de recombinacion valida).
- El caso base es correcto.

La eficiencia depende de que la division sea balanceada ($n/b$ con $b \geq 2$) y el combine sea polinomial — de lo contrario la recurrencia puede no mejorar la fuerza bruta.

## Apariciones en parciales

- **1P_1C_2024 Ejercicio 3:** Huecos en arreglo ordenado — diseñar D&C con poda en $O(n)$. El algoritmo detecta en $O(1)$ si un subarreglo tiene huecos y poda ramas sin huecos. Nota: el Teorema Maestro no aplica directamente si la cantidad de subproblemas es variable.
- **1P_1C_2025:** MaxMin D&C — calcular maximo y minimo simultaneamente con $\approx 3n/2 - 2$ comparaciones (ver [[sintesis/repaso_1P]]).

## Ejercicios que ejemplifican esto

- [[divide_y_conquista_guia]] — Ej. 8 (MaxMin), Ej. 14 (DiferenciaMinima), Ej. 6 (BusquedaBinariaVariante)
- [[divide_y_conquista_practica]] — MergeSort, MaximoMontana, MaximaSubsecuencia, DiferenciaMinima
- [[sintesis/repaso_1P]] — MaxMin con analisis de comparaciones exacto
