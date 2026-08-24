---
nombre: Prolog — máximo/mínimo con doble negación (not)
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: programacion_logica
---

# Prolog — máximo/mínimo con doble negación (`not`)

## Como reconocer este patron

- El enunciado pide el elemento "de mayor/menor X" o "con la mayor cantidad de Y"
- La restricción dice "sin usar `setof`, `findall`, `aggregate`, ni estructuras auxiliares"
- Acepta `not/1` o `\+`

## Template de resolucion

```prolog
% Patrón: "El X tal que no existe otro Y con mejor valor"
mejorElemento(X) :-
    candidato(X, ValorX),                       % genera un candidato
    not((candidato(Y, ValorY), ValorY > ValorX)). % ninguno es mejor

% Con predicado auxiliar que incluye el valor:
mejorEstudiante(A) :-
    estudiante(A),
    promedio(A, P),
    not((estudiante(B), promedio(B, PZ), PZ > P)).

% Máxima longitud:
subsecuenciaMaxima(L, S) :-
    subsecuencia(L, S),
    length(S, LS),
    not((subsecuencia(L, L2), length(L2, LL), LL > LS)).
```

**Atención con variables libres dentro de `not`:**
```prolog
% MALO: X no está instanciada antes del not
not(p(X))  % Prolog busca si p(X) falla para ALGÚN X, no para el X específico

% BUENO: X ya está instanciada por el candidato anterior
candidato(X), not((candidato(Y), Y es mejor que X))
```

## Por que funciona

`not(Goal)` en Prolog tiene éxito si `Goal` falla (Negation as Failure). Al afirmar que un candidato es el mejor, se asegura que **no existe ningún otro** que lo supere. Es el equivalente de $\neg\exists y. \text{mejor}(y, x)$.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 2d: `mejorEstudiante(-A)` con doble negación
- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 2d: `mayorCantPalabras(+D,+F,-T)` con `not(tokenizarLong ... N2 > N)`
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 1b: `subsecuenciaCrecienteMasLarga(L, S)` con `not(..., L2 > L1)`
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 1b: `secuenciaMaxima(+M, -S)` con `not(secuenciaRepetida(M, L), length > LS)`

## Ejercicios que ejemplifican esto

- [[temas/programacion_logica_guia]] — Ejercicio 21 (conjuntos y doble negación)
- [[temas/programacion_logica_guia]] — Ejercicio 17 (comportamiento de `not` y orden de literales)
- [[temas/programacion_logica_practica]] — Sección "Negación por Falla (`\+`)"
