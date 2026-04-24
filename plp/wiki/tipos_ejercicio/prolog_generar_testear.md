---
nombre: Prolog — generate & test con generadores infinitos
parcial: 2P
tipo: tipo_ejercicio
---

# Prolog — generate & test con generadores infinitos

## Como reconocer este patron

- El enunciado pide generar **todas** las instancias de algo (melodías, triángulos, matrices, capicúas, subsecuencias)
- Hay un predicado `-M` o `-L` sin instanciar en la cabeza
- Se requiere que sea "sin repetición" y que cubra todo el espacio
- La restricción dice "no usar cut"

## Template de resolucion

```prolog
% Patrón 1D: iterar sobre un parámetro de tamaño creciente
objeto(-O) :-
    desde(1, N),               % generador de tamaños 1, 2, 3, ...
    objetoDeTamanio(N, O).     % construye el objeto de tamaño N

% Patrón 2D: iterar sobre dos parámetros con suma fija (FAIRNESS)
% NUNCA usar dos desde/2 anidados (estrella de la muerte)
objeto2D(-O) :-
    desde(2, Total),
    between(1, Total, A),
    B is Total - A,
    B > 0,
    construir(A, B, O).

% Ejemplo: todas las melodías (arborescentes)
melodia(-M) :- desde(1, T), melodiaDeTamanio(M, T).

melodiaDeTamanio(M, 1) :- nota(M).
melodiaDeTamanio(sec(M1, M2), T) :-
    T > 1, Tp is T - 1,
    between(1, Tp, K1), K2 is T - K1,
    melodiaDeTamanio(M1, K1),
    melodiaDeTamanio(M2, K2).

% Ejemplo: todas las listas capicúas
generarCapicuas(L) :- desde(1, N), listaDeN(N, L), capicua(L).
```

**Señal de error:** si usás `desde(X), desde(Y)` anidados, Prolog se queda siempre en el primer `Y` infinito y nunca incrementa `X` → bucle infinito.

**Corrección:** usar `desde(Total), between(1, Total, X), Y is Total - X`.

## Por que funciona

La **diagonalización** garantiza que para cualquier instancia válida de tamaño $n$, Prolog la alcanzará en un número finito de pasos (en el turno donde `Total = n`). Sin diagonalización, ramas infinitas en el primer generador hacen que Prolog nunca pruebe tamaños mayores.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 2a: `generarCapicuas(-L)` con `desde(1, N)` + `listaDeN`
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 1c: `fibonacciM(M, N)` generador infinito y revisión de divergencia
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 1d: `melodia(-M)` con `desde` y `between` (diagonalización 2D)
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 1c: `todasLasMatrices(-M)` con `desde(2, C), between(1, C, A)`

## Ejercicios que ejemplifican esto

- [[temas/programacion_logica_guia]] — Ejercicio 3 (naturales con `desde`, generación infinita)
- [[temas/programacion_logica_guia]] — Ejercicio 9 (predicado `desde` y reversibilidad)
- [[temas/programacion_logica_guia]] — Ejercicio 15 (triángulos con generación por niveles)
- [[temas/programacion_logica_guia]] — Ejercicio 23 (generación de árboles)
- [[temas/programacion_logica_practica]] — Sección "Ejercicio Integrador: Generación Infinita (Triángulos)"
