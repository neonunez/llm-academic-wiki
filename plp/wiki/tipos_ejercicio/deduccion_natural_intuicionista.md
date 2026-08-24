---
nombre: Deducción natural — prueba intuicionista
parcial: 1P
programa: 2C_2026
tipo: tipo_ejercicio
tema: sistemas_deductivos_y_deduccion_natural
---

# Deducción natural — prueba intuicionista

## Como reconocer este patron

- El enunciado pide demostrar una fórmula proposicional "sin principios clásicos" o "en LJ"
- La conclusión es una implicación, conjunción, disyunción o negación
- No aparecen en la fórmula patrones como `τ ∨ ¬τ` (LEM) o pasos que requieran doble negación

## Template de resolucion

**Estrategia top-down (mirar la conclusión):**

| Si la conclusión es... | Última regla aplicada |
|---|---|
| `τ ⇒ σ` | `⇒i` — asumir τ, demostrar σ |
| `τ ∧ σ` | `∧i` — demostrar τ y σ por separado |
| `τ ∨ σ` | `∨i1` o `∨i2` — demostrar uno de los lados |
| `¬τ` | `¬i` — asumir τ, llegar a ⊥ |
| cualquier σ con ⊥ en hipótesis | `⊥e` |

**Estrategia bottom-up (mirar hipótesis):**

| Si tengo en hipótesis... | Puedo aplicar |
|---|---|
| `τ ⇒ σ` y `τ` | `⇒e` (modus ponens) → obtengo σ |
| `τ ∧ σ` | `∧e1` → τ, `∧e2` → σ |
| `τ ∨ σ` | `∨e` — dos ramas, cada una asume un lado |
| `¬τ` y `τ` | `¬e` → ⊥ |

**Secuencia típica para `((P ⇒ Q) ∧ (Q ⇒ R)) ⇒ ¬R ⇒ ¬P`:**
1. Asumir `(P ⇒ Q) ∧ (Q ⇒ R)` (intro para la primera ⇒)
2. Asumir `¬R` (intro para la segunda ⇒)
3. Asumir `P` (intro para ¬P = P ⇒ ⊥)
4. Por ∧e sobre la conjunción, obtener `P ⇒ Q` y `Q ⇒ R`
5. Aplicar modus ponens: P → Q → R
6. R y ¬R dan ⊥. Descargar la hipótesis de P.

## Por que funciona

Deducción natural es un sistema de prueba constructivo. Cada regla de introducción construye la fórmula objetivo; cada regla de eliminación extrae información de las hipótesis. La clave es reconocer la estructura de la conclusión y trabajar hacia atrás.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 2b: `((P⇒Q)∧(Q⇒R))⇒¬R⇒¬P`
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 2b: `p ⇒ (σ ∨ (p ⇒ τ)) ⇒ (σ ∨ τ)`
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 2b: `((ρ∧σ)∨(ρ∧τ)) ⇒ (σ∧ρ) ∨ τ`
- [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 2b: `((π⇒ρ)∨(σ⇒τ)) ⇒ (σ∧π) ⇒ (ρ∨τ)`
- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — (no aplica directamente)

## Ejercicios que ejemplifican esto

- [[temas/sistemas_deductivos_y_deduccion_natural_guia]] — Ejercicio 5 (modus ponens, doble negación, contraposición, De Morgan)
- [[temas/sistemas_deductivos_y_deduccion_natural_guia]] — Ejercicio 11 (batería de secuentes intuicionistas)
- [[temas/sistemas_deductivos_y_deduccion_natural_practica]] — Teoremas intuicionistas (doble/triple negación)
