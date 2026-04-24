---
nombre: D&C — Aplicar/verificar Teorema Maestro
parcial: 1P
tema: divide_y_conquista
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/1P/1.parcial_2C_2025_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_1C_2025_resolucion(2).pdf
---

# D&C — Aplicar/verificar Teorema Maestro

## Como reconocer este patron

- Se da una recurrencia $T(n) = aT(n/c) + f(n)$ y se pide la complejidad.
- Se da un algoritmo recursivo y se pide identificar la recurrencia y resolver.
- Se da una demostracion del TM y se pide verificar si es correcta.

## Template de resolucion

1. **Identificar** $a$ (cantidad de llamadas), $c$ (factor de division), $f(n)$ (costo dividir+combinar).
2. **Calcular** $\alpha = \log_c a$.
3. **Comparar** $f(n)$ con $n^\alpha$:
   - $f(n) = O(n^{\alpha - \epsilon})$ para $\epsilon > 0$ → **Caso 1** → $T(n) = \Theta(n^\alpha)$
   - $f(n) = \Theta(n^\alpha)$ → **Caso 2** → $T(n) = \Theta(n^\alpha \log n)$
   - $f(n) = \Theta(n^\alpha \log^k n)$, $k \geq 0$ → **Caso 2'** → $T(n) = \Theta(n^\alpha \log^{k+1} n)$
   - $f(n) = \Omega(n^{\alpha + \epsilon})$ para $\epsilon > 0$ → **Caso 3** → $T(n) = \Theta(f(n))$ (verificar regularidad)
4. Si se pide verificar una demo: el $\epsilon$ en casos 1 y 3 **debe ser positivo**.

## Por que funciona

El TM analiza si el trabajo en las hojas ($\Theta(n^\alpha)$) domina, iguala, o es dominado por el trabajo en la raiz ($f(n)$).

## Trampa frecuente en parciales

En 1P_1C_2024 Ej 4: se presenta una demo de $T(n) = 3T(n/9) + 5n^{1/4}$ que usa $\omega = -6$ (negativo). La complejidad final ($\Theta(n^{1/2})$) es correcta pero la demo es incorrecta — $\omega$ debe ser $> 0$ en el Caso 1.

## Casos canonicos (memorizados)

| Recurrencia | Caso TM | Complejidad |
|-------------|---------|-------------|
| $T(n)=2T(n/2)+\Theta(n)$ | 2 | $\Theta(n\log n)$ — MergeSort |
| $T(n)=T(n/2)+\Theta(1)$ | 2 | $\Theta(\log n)$ — BusquedaBinaria |
| $T(n)=2T(n/2)+\Theta(1)$ | 1 | $\Theta(n)$ — recorrer arbol |
| $T(n)=bT(n/b)+\Theta(n)$ | 2 | $\Theta(n\log n)$ — para cualquier $b>1$ |
| $T(n)=3T(n/9)+5n^{1/4}$ | 1 | $\Theta(n^{1/2})$ — $\log_9 3 = 1/2$ |
| $T(n)=3T(2n/3)+O(1)$ | 1 | $\Theta(n^{\log_{3/2}3}) \approx \Theta(n^{2.71})$ |
| $T(n)=3T(n/4)+n$ | 3 | $\Theta(n)$ — $\log_4 3 \approx 0.79 < 1$ |

## Apariciones en parciales

- **1P_1C_2024 Ej 4:** $T(n) = 3T(n/9) + 5n^{1/4}$, demo con $\omega$ negativo — correctitud de la demo
- **1P_2C_2025 Ej 5:** algoritmo `es_derecha_dominante` → $T(n) = 2T(n/2) + O(1) = \Theta(n)$
- **2P_1C_2025 Ej A2:** sort con 3 llamadas de $2n/3$ → $T(n) = 3T(2n/3) + O(1) = \Theta(n^{\log_{3/2}3})$
- **2P_1C_2025 Ej A4:** $T(n) = bT(n/b) + \Theta(n)$ → caso 2 → $\Theta(n \log n)$

## Ejercicios que ejemplifican esto

- [[divide_y_conquista_guia]] Ej 7 (ComplexityQuest — 12 recurrencias)
- [[divide_y_conquista_guia]] Ej 1 (MergeSort), Ej 2 (BusquedaBinaria)
- [[divide_y_conquista_practica]] — todos los ejercicios incluyen recurrencia + TM
