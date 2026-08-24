---
nombre: Prolog — operaciones sobre listas con append
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: programacion_logica
---

# Prolog — operaciones sobre listas con `append`

## Como reconocer este patron

- El enunciado pide implementar: `sublista`, `prefijo`, `sufijo`, `insertar`, `permutacion`, `partir`, `tokenizar`, `subsecuencia`, `secuenciaRepetida`, etc.
- La restricción dice "no usar recursión explícita" o el predicado natural es con `append/3`
- El predicado tiene instanciación `+L, -S` o `?L1, ?L2, ?L3`

## Template de resolucion

```prolog
% Extrae un prefijo arbitrario de L:
prefijo(L, P) :- append(P, _, L).

% Extrae un sufijo arbitrario de L:
sufijo(L, S) :- append(_, S, L).

% Sublista consecutiva:
sublista(L, SL) :- prefijo(L, P), sufijo(P, SL).
% Forma directa:
sublista(L, SL) :- append(_, S, L), append(SL, _, S).

% Insertar X en posición arbitraria de L:
insertar(X, L, LX) :- append(A, B, L), append(A, [X|B], LX).

% Permutacion:
permutacion([], []).
permutacion([H|T], P) :- permutacion(T, PT), insertar(H, PT, P).

% Partir en dos sublistas cuya concatenación es L:
partir(L, L1, L2) :- append(L1, L2, L).

% Tokenizar (prefijo que pertenece al diccionario):
tokenizar(_, [], []).
tokenizar(D, F, [P|XS]) :-
    member(P, D),
    append(P, YS, F),
    tokenizar(D, YS, XS).
```

**Checklist reversibilidad:**
- `append(?L1, ?L2, ?L3)` — totalmente reversible
- `member(?X, ?L)` — totalmente reversible
- `length(?L, ?N)` — reversible si al menos uno está instanciado
- `is/2`, `</2`, `>/2` — **NO** reversibles (requieren instanciación)

## Por que funciona

`append` funciona tanto para generar como para verificar porque su implementación recursiva no depende de la instanciación de ningún argumento en particular. Al usar `append` como generador, Prolog explora todas las particiones posibles mediante backtracking.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 2c: `tokenizar(+D, +F, -T)` con `append` y `member`
- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 2b: `eliminarAplazos` con `member` y `not`
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 1a: `subsecuenciaCreciente` con `subsecuencia` basada en `append`
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 1a: `listaAMelodia` con `append` como particionador
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 1a: `secuenciaRepetida` con `sublista` basada en `append`

## Ejercicios que ejemplifican esto

- [[temas/programacion_logica_guia]] — Ejercicio 4 (`juntar` = append)
- [[temas/programacion_logica_guia]] — Ejercicio 5 (last, reverse, prefijo, sublista)
- [[temas/programacion_logica_guia]] — Ejercicio 7 (intersección, partir, permutación, reparto)
- [[temas/programacion_logica_practica]] — Sección "Manipulación con append/3"
