---
nombre: PD — Demostrar superposicion de subproblemas
parcial: 1P
tema: programacion_dinamica
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_2C_2025_resolucion(1).pdf
---

# PD — Demostrar superposicion de subproblemas

## Como reconocer este patron

- Piden "demostrar que hay superposicion de subproblemas".
- Piden justificar por que PD mejora a backtracking.
- Piden mostrar que sin memoizacion la complejidad seria exponencial.

## Template de resolucion

### Estrategia A — Comparacion de llamadas vs estados

1. Contar cuantos **llamados recursivos** hace backtracking sin memoizacion. Tipicamente $O(r^n)$ donde $r$ es la ramificacion.
2. Contar cuantos **estados distintos** existen. Tipicamente $O(n \cdot s)$ o similar (polinomial).
3. Como $r^n \gg n \cdot s$, hay subproblemas que se repiten.

**Ejemplo (combinaciones $\sum v_i = s$):** backtracking genera $O(K^n)$ llamados, pero solo hay $O(n \cdot s)$ estados distintos $(n', s')$. Como $n \cdot s \ll K^n$, hay superposicion.

### Estrategia B — Ejemplo concreto

Dibujar el arbol de recursion para un input pequeno y señalar dos ramas que llegan al mismo subproblema $(n', s')$.

**Ejemplo (combinaciones con $K=4, S=5, n=3$):** desde ramas distintas se llega a $comb(2, 1)$ y $comb(1, 1)$ multiples veces.

### Estrategia C — Argumento por casos

Si el problema tiene un parametro que puede tomar valor 0 o 1 (como $g$ en el ejercicio de alfajores con $g=1$): mostrar que con ese valor no hay superposicion. Con $g \geq 2$: mostrar que si la hay, comparando la funcion $3^{n/4}$ (exponencial) con $n^3$ (polinomial).

## Por que funciona

Backtracking explora el arbol de recursion completo. PD "colapsa" todos los subarboles con el mismo estado en una unica computacion almacenada en la tabla. La superposicion es lo que hace que PD sea mejor que backtracking.

## Trampas frecuentes

- Dar solo un ejemplo sin el argumento formal de cuantos estados hay vs cuantos llamados.
- No considerar casos borde (como $g=1$) que pueden no tener superposicion.
- Confundir "subproblemas se repiten" con "el problema tiene subestructura optima" — son conceptos distintos.

## Apariciones en parciales

- **1P_2C_2025 Ej 4b:** Combinaciones con suma $s$ — comparar $O(K^n)$ llamados vs $O(n \cdot s)$ estados

## Ejercicios que ejemplifican esto

- [[programacion_dinamica_guia]] — varios ejercicios piden demostrar superposicion
- [[programacion_dinamica_top_down_practica_pt2]] — receta 6 pasos, paso de superposicion
