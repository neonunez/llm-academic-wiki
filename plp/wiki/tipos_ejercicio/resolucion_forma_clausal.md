---
nombre: Resolución — transformar a forma clausal (CNF / Skolem)
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: resolucion
---

# Resolución — transformar a forma clausal (CNF / Skolem)

## Como reconocer este patron

- El enunciado da fórmulas LPO y pide "llevar a forma clausal" o "representar como cláusulas de Horn"
- Las fórmulas contienen $\Leftrightarrow$, $\Rightarrow$, $\exists$, $\forall$, $\neg$, $\wedge$, $\vee$

## Template de resolucion

**Pasos en orden fijo:**

```
1. ELIMINAR BICONDICIONALES
   A ⟺ B  ≡  (A ⇒ B) ∧ (B ⇒ A)

2. ELIMINAR IMPLICACIONES
   A ⇒ B  ≡  ¬A ∨ B

3. MOVER NEGACIONES HACIA ADENTRO (NNF)
   ¬(A ∧ B) ≡ ¬A ∨ ¬B       (De Morgan)
   ¬(A ∨ B) ≡ ¬A ∧ ¬B       (De Morgan)
   ¬∀X.P(X) ≡ ∃X.¬P(X)
   ¬∃X.P(X) ≡ ∀X.¬P(X)
   ¬¬A      ≡ A

4. SKOLEMIZACIÓN (eliminar existenciales)
   ∃X.P(X)             → P(c)              [constante de Skolem c]
   ∀Y.∃X.P(X,Y)        → P(f(Y), Y)        [función de Skolem f(Y)]
   ∀Y.∀Z.∃X.P(X,Y,Z)   → P(g(Y,Z), Y, Z)  [función g de aridad 2]

5. PRENEX: mover ∀ afuera (ya implícitos)

6. DISTRIBUIR (forma normal conjuntiva, CNF)
   A ∨ (B ∧ C) ≡ (A ∨ B) ∧ (A ∨ C)

7. EXTRAER CLÁUSULAS
   Cada conjunción en el nivel superior es una cláusula separada.
   Cada cláusula es un conjunto de literales.
```

**Cláusulas de Horn:** a lo sumo 1 literal positivo.
- Hecho: `{P}` — solo positivo
- Regla: `{P, ¬Q1, ..., ¬Qn}` — un positivo, varios negativos
- Objetivo: `{¬Q1, ..., ¬Qn}` — solo negativos
- Una disyunción con ≥2 literales positivos NO es de Horn

## Por que funciona

La forma clausal preserva la satisfacibilidad. La eliminación de cuantificadores existenciales por Skolemización es correcta porque los términos de Skolem actúan como testigos concretos para las variables existenciales, que dependen de las variables universales que los contienen.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 1a: clausular cota superior/inferior con bicondicional
- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 1a: clausular conocimiento sobre Radio, Libro, Dormilon, Posee
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 2a: clausular reglas de tipado (tipo App, constantes de Skolem)
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 2a: clausular vacío con bicondicional y Skolem función
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 2: clausular KB de melodías

## Ejercicios que ejemplifican esto

- [[temas/resolucion_guia]] — Ejercicio 1 (conversión a CNF proposicional)
- [[temas/resolucion_guia]] — Ejercicio 5 (conversión a NNF)
- [[temas/resolucion_guia]] — Ejercicio 6 (Skolem y forma clausal LPO)
- [[temas/resolucion_practica]] — Ejercicio 2 (propiedades de relaciones, clausulación)
