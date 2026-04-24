---
nombre: Inferencia de tipos — algoritmo W/I paso a paso
parcial: 2P
tipo: tipo_ejercicio
---

# Inferencia de tipos — algoritmo W/I paso a paso

## Como reconocer este patron

- El enunciado pide "inferir el tipo usando el algoritmo W/I" o "usar el algoritmo I"
- El término es una expresión lambda (posiblemente con extensiones: listas, pares, folds)
- Puede incluir "rectificar el término" antes de inferir

## Template de resolucion

**Algoritmo I (bottom-up, genera ecuaciones):**

```
Pasos:
1. RECTIFICAR: renombrar variables ligadas para evitar capturas.
   Si una variable libre y una ligada tienen el mismo nombre → renombrar la ligada.

2. ANOTAR: asignar variables de tipo frescas a cada subexpresión.
   Cada λ, aplicación y variable libre recibe su X_i.

3. GENERAR ECUACIONES por las reglas de tipado:
   - Var:    x aparece en Γ con tipo σ  →  τ_x = σ
   - Abs:    λx:X_i. M con tipo X_i → τ_M  →  τ_abs = X_i → τ_M
   - App:    M N con tipo X_j  →  τ_M = τ_N → X_j
   - If:     condición Bool, ramas mismo tipo
   - Fold:   verificar que todos los casos retornen tipo τ

4. UNIFICAR (MGU): resolver el conjunto de ecuaciones.
   - Descomponer: (A → B = C → D)  →  {A = C, B = D}
   - Eliminar: (X = T) con X no en T  →  [X ↦ T] y sustituir
   - CLASH: (Nat = Bool) o (Nat = A → B)  →  NO tipable

5. APLICAR la sustitución al tipo de la raíz → tipo principal
```

**Detección de no-tipabilidad:**
- **Occur check:** $X = X \to \tau$ → bucle (no tipable)
- **Clash:** $Nat \doteq Bool$, $Nat \doteq A \to B$, $Region \doteq A \to B$ → no tipable

## Por que funciona

El algoritmo I es correcto y completo para el cálculo lambda simplemente tipado: si el término es tipable, W/I devuelve el tipo principal (el más general). Si no es tipable, el proceso de unificación falla con un clash o un ciclo.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 3a: algoritmo W sobre `foldAT (Tern ...) TNil (rd -> ...)`
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 3a.ii: dos términos — uno tipable (type: $\chi_2 \to \chi_3$), uno no (Nat≠Bool)
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 3a.ii: dos términos — ambos no tipables por clashes (Región≠función; Nat≠Bool)

## Ejercicios que ejemplifican esto

- [[temas/unificacion_e_inferencia_guia]] — Ejercicio 3 (MGU)
- [[temas/unificacion_e_inferencia_guia]] — Ejercicio 4 (decidibilidad de tipado)
- [[temas/unificacion_e_inferencia_guia]] — Ejercicio 5 (paso a paso del algoritmo)
- [[temas/unificacion_e_inferencia_guia]] — Ejercicio 6 (numerales de Church)
- [[temas/unificacion_e_inferencia_guia]] — Ejercicio 8 (extensión pares)
- [[temas/unificacion_e_inferencia_guia]] — Ejercicio 10 (extensión listas y foldr)
- [[temas/unificacion_e_inferencia_practica]] — Ejercicio 2 (algoritmo I paso a paso para λx. λf. f x)
