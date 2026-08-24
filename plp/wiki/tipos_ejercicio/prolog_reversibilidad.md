---
nombre: Prolog — análisis de reversibilidad
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: programacion_logica
---

# Prolog — análisis de reversibilidad

## Como reconocer este patron

- El enunciado pregunta "¿Es el predicado reversible? Justificar."
- O pide la instanciación `(+X, -Y)` y hay que decidir si funciona con `(-X, +Y)`

## Template de resolucion

```
Un predicado p(+X, -Y) es REVERSIBLE si, al consultarlo con p(-X, +Y):
  1. Prolog encuentra todas las respuestas correctas para X dado Y, Y
  2. Sin colgarse ni divergir (no entra en un bucle infinito buscando X)

Un predicado NO ES REVERSIBLE si:
  A) Usa `is/2`: necesita el lado derecho instanciado → no funciona en reversa
  B) Usa generador infinito al principio: si Y está instanciado pero
     el generador sigue produciendo infinitamente sin llegar a él → diverge
  C) Usa `not(Goal)`: las variables libres dentro del Goal pueden dar
     comportamientos inesperados

Estructura de la justificación:
1. Identificar qué literales requieren instanciación (is, <, >, etc.)
2. Describir el árbol de búsqueda cuando el argumento de salida está instanciado
3. Identificar si existe una rama infinita que Prolog no puede escapar
```

**Ejemplos de respuesta completa:**

```prolog
% fibonacci(N) con N instanciado:
% desde(0, M) genera M = 0, 1, 2, 3, ...
% Si N = 5 y 5 no es Fibonacci, cuando M es suficientemente grande para
% generar todos los números de Fibonacci ≤ 5 sigue buscando con M>T
% para todo T, diverge → NO reversible

% submelodia(+M, -S) con S instanciado:
% El predicado solo recurre sobre la estructura de M.
% Al tener S instanciado, Prolog unifica en cada rama y falla rápido si no hay match.
% La búsqueda en M es finita → SÍ reversible
```

## Por que funciona

La reversibilidad depende de que las restricciones de instanciación de cada literal se satisfagan independientemente del modo de llamado. Los predicados basados puramente en unificación (sin aritmética) suelen ser reversibles. Los que usan `is`, generadores infinitos o `not` con variables libres suelen no serlo.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 2b: `generarCapicuas` no reversible por `desde(1, N)` con backtrack infinito
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 1d: `fibonacci(N)` no reversible con N instanciado (diverge)
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 1b: `submelodia(+M, -S)` SÍ reversible (solo unificación recursiva)
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 1d: `todasLasMatrices(-M)` no reversible con M instanciado

## Ejercicios que ejemplifican esto

- [[temas/programacion_logica_guia]] — Ejercicio 9 (predicado `desde` y reversibilidad)
- [[temas/programacion_logica_guia]] — Ejercicio 3 (naturales y `menorOIgual`, bucle infinito)
- [[temas/programacion_logica_practica]] — Nota bajo `long/2`: reversibilidad con `is`
