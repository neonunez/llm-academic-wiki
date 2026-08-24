---
nombre: Deducción Natural — con cuantificadores LPO (∃E, ∀I, ∃I)
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: logica_de_primer_orden
---

# Deducción Natural — con cuantificadores LPO (∃E, ∀I, ∃I)

## Como reconocer este patron

- El enunciado pide demostrar una fórmula con $\forall$, $\exists$
- Aparecen conectivos como $P(X, Y)$, $\exists Z. Q(Z)$, $\forall Y. P(Y) \Rightarrow Q(Y)$
- Puede requerir lógica clásica (PBC/LEM) o ser puramente intuicionista

## Template de resolucion

**Reglas de cuantificadores:**

| Regla | Condición | Enunciado |
|---|---|---|
| $\forall I$ | $x$ no libre en hipótesis no descargadas | De $P(x)$ concluir $\forall X. P(X)$ |
| $\forall E$ | Ninguna | De $\forall X. P(X)$ concluir $P(t)$ para cualquier término $t$ |
| $\exists I$ | Ninguna | De $P(t)$ concluir $\exists X. P(X)$ |
| $\exists E$ | $x$ no libre en conclusión ni hipótesis abiertas | De $\exists X. P(X)$ y de $[P(x)]$ llegar a $C$, concluir $C$ |

**Secuencia típica para $(∃X. P(X)) ⇒ (∀Y. P(Y) ⇒ Q(Y)) ⇒ ∃Z. Q(Z)$:**
```
1. Asumir [∃X. P(X)]^1
2. Asumir [∀Y. P(Y) ⇒ Q(Y)]^2
3. Abrir ∃E: Asumir [P(x0)]^3  (x0 fresca)
4. ∀E en (2): P(x0) ⇒ Q(x0)
5. ⇒E en (4) y (3): Q(x0)
6. ∃I: ∃Z. Q(Z)
7. Cerrar ∃E: usando (1) y (3)-(6) → ∃Z. Q(Z)  [descarga hipótesis 3]
8. ⇒I: ∀Y.(P(Y) ⇒ Q(Y)) ⇒ ∃Z. Q(Z)  [descarga 2]
9. ⇒I: ∃X. P(X) ⇒ ... [descarga 1]
```

**Para probar $\exists X. \phi$ con lógica clásica (PBC):**
```
Asumir [¬∃X. φ]^k
→ derivar ∀X. ¬φ  (por equivalencia)
→ choca con alguna hipótesis → ⊥
→ PBC, descargar k → ∃X. φ
```

## Por que funciona

La regla $\exists E$ requiere que la variable testigo $x_0$ no aparezca libre fuera de la subdemostración, garantizando que la conclusión $C$ no depende de quién sea ese testigo en particular.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 3c: $\exists X. P(X) \vee \forall Y. Q(Y) \Rightarrow \exists X.(Q(X) \vee P(X))$ con ∨E y ∃E
- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 3b: $\forall X. \forall Y.(\exists Z.P(X,Z)\wedge P(Z,Y)) \Rightarrow \exists W. P(X,W)$ con ∃E+∧E+∃I
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 3b: $(\exists x. P(x)) \Rightarrow ((\forall y. P(y) \Rightarrow Q(y)) \Rightarrow \exists z. Q(z))$
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 3b: $(\neg \forall Y. P(Y)) \Rightarrow \exists X.(P(X) \Rightarrow Q(X))$ con PBC
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 3b: $\exists X. P(X,X) \Rightarrow \exists Y. \neg\forall Z. \neg P(Y,Z)$ intuicionista con ∃E+¬I

## Ejercicios que ejemplifican esto

- [[temas/logica_de_primer_orden_guia]] — Ejercicios de Deducción Natural LPO
- [[temas/sistemas_deductivos_y_deduccion_natural_guia]] — Ejercicio 11 (batería de secuentes)
