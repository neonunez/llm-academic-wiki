---
nombre: Cálculo Lambda — reducción paso a paso
parcial: 1P
tipo: tipo_ejercicio
---

# Cálculo Lambda — reducción paso a paso

## Como reconocer este patron

- El inciso c) pide "mostrar la reducción" o "reducir el siguiente término"
- Se dan términos con aplicaciones lambda, `if`, `case`, o constructores de extensión
- El resultado final debe ser un valor

## Template de resolucion

```
-- Cada línea es un paso. Indicar la regla aplicada al lado derecho.
M0
--> M1    (nombre_regla: Beta / if_t / if_f / def?X / obtX / etc.)
--> M2    (nombre_regla)
...
--> V     (forma normal / valor)
```

**Reglas más frecuentes:**

| Regla | Patrón |
|---|---|
| Beta | `(λx:σ. M) V --> M{x:=V}` |
| if_t | `if true then M else N --> M` |
| if_f | `if false then M else N --> N` |
| case-Hoja | `case Hoja(V) of Hoja x ~> M ... --> M{x:=V}` |
| case-Bin | `case Bin(V1,V2) of ... Bin(i,d) ~> N --> N{i:=V1, d:=V2}` |
| Congruencia | Reducir subexpresión interna antes de aplicar la regla de cómputo |

**Errores comunes:**
- Saltear pasos de congruencia (el corrector lo marca como "SALTEA PASOS")
- Aplicar Beta antes de que el argumento sea un valor (en call-by-value)
- No aplicar sustitución correctamente (especialmente con variables ligadas)

**Orden en call-by-value:**
1. Evaluar la función hasta que sea un λ
2. Evaluar el argumento hasta que sea un valor
3. Aplicar Beta

## Por que funciona

La semántica operacional de paso pequeño (small-step) especifica exactamente cuándo y cómo avanza la evaluación. Cada paso aplica exactamente una regla. Las congruencias propagan la evaluación hacia el interior de los términos.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 3c: reducción con Dicc
- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ejercicio 3c: reducción con AIH y case
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 3c: reducción con head< (listas ordenadas)
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 3c: reducción con foldAT

## Ejercicios que ejemplifican esto

- [[temas/calculo_lambda_practica]] — Ejercicio 7c: reducción con pares
- [[temas/calculo_lambda_practica]] — Ejercicio 8a: reducción con case de árbol binario
- [[temas/calculo_lambda_practica]] — Ejercicio 6-3: reducción con regla ζ
