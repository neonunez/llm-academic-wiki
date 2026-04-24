---
nombre: Cálculo Lambda — reglas de tipado para extensión ADT
parcial: 1P
tipo: tipo_ejercicio
---

# Cálculo Lambda — reglas de tipado para extensión ADT

## Como reconocer este patron

- El enunciado extiende el cálculo lambda tipado con nuevos tipos (Dicc, AIH, AT, listas ordenadas, anillos, etc.)
- El inciso a) pide "Introducir las reglas de tipado" o "dar las reglas de tipado"
- Se dan nuevos constructores/destructores: `Vacio`, `definir`, `def?`, `Hoja`, `Bin`, `case`, `head<`, `tail<`, etc.

## Template de resolucion

**Una regla por constructor/destructor:**

```
-- Constructores (valores terminales):
──────────────────────── ax_Vacio
Γ ⊢ Vacio_{σ,τ} : Dicc(σ,τ)

-- Constructores con argumentos:
Γ ⊢ M : σ    Γ ⊢ N : τ
──────────────────────── T-Cons
Γ ⊢ cons(M, N) : Lista(σ)

-- Destructores (observadores):
Γ ⊢ M : Dicc(σ,τ)    Γ ⊢ N : σ
────────────────────────────────── T-obtener
Γ ⊢ obtener(M, N) : τ

-- Eliminadores con binding (case):
Γ ⊢ M : ADT(τ)
Γ, x:τ ⊢ M1 : σ
Γ, i:ADT(τ), d:ADT(τ) ⊢ M2 : σ
──────────────────────────────── T-case
Γ ⊢ case M of Hoja x ~> M1 ; Bin(i,d) ~> M2 : σ
```

**Checklist para cada regla:**
1. ¿Qué tipa el constructor? → tipo resultado en conclusión
2. ¿Qué argumentos recibe? → premisas con sus tipos
3. ¿Introduce variables ligadas? → extender Γ en esas premisas

## Por que funciona

Cada constructor de un ADT tiene un tipo propio. Las reglas de tipado capturan exactamente los tipos de los argumentos y el tipo del resultado, garantizando type safety.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 3a: reglas para Dicc(σ,τ) (Vacio, definir, def?, obtener)
- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ejercicio 3a: reglas para AIH (Hoja, Bin, case)
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 3a: reglas para listas ordenadas ([τ]<)
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 3a: reglas para AT(τ) (TNil, Tern, foldAT)

## Ejercicios que ejemplifican esto

- [[temas/calculo_lambda_guia]] — Ejercicio con extensión pares, sumas, listas
- [[temas/calculo_lambda_practica]] — Ejercicio 8: extensión con árboles binarios (case)
