---
nombre: Práctica 3 - Demostración en Lógica Proposicional
parcial: 1P
tipo: Guía de Ejercicios
tema: Lógica Proposicional y Deducción Natural
fuente: plp/raw/guias_practicas/2.guia_1P_demostracion_en_logica_proposicional.pdf
paginas_relacionadas: ["[[sistemas_deductivos_y_deduccion_natural_teoria]]", "[[sistemas_deductivos_y_deduccion_natural_practica]]"]
---

# Guía 3 — Demostración en Lógica Proposicional

Esta guía aborda la lógica proposicional desde dos perspectivas: la **semántica** (tablas de verdad, tautologías, modelos) y la **sintáctica** (Deducción Natural, lógica intuicionista y clásica).

---

## Semántica

### Ejercicio 1
Determinar el valor de verdad de las siguientes proposiciones (fórmulas) cuando el valor de verdad de $P$ y $Q$ es $V$, mientras que el de $S$ y $T$ es $F$.

I. $(\neg P \vee Q)$
II. $(P \vee (S \wedge T) \vee Q)$
III. $\neg(Q \vee S)$
IV. $(\neg P \vee S) \Leftrightarrow (\neg P \wedge \neg S)$
V. $((P \vee S) \wedge (T \vee Q))$
VI. $(((P \vee S) \wedge (T \vee Q)) \Leftrightarrow (P \vee (S \wedge T) \vee Q))$
VII. $(\neg Q \wedge \neg S)$

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Evaluación directa de funciones de verdad basadas en conectivos lógicos.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 2
Mostrar que cualquier fórmula de la lógica proposicional que utilice los conectivos $\neg$ (negación), $\wedge$ (conjunción), $\vee$ (disyunción), $\Rightarrow$ (implicación) puede reescribirse a otra fórmula equivalente que usa sólo los conectivos $\neg$ y $\vee$.
**Sugerencia:** hacer inducción en la estructura de la fórmula.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Demostración de que el conjunto $\{\neg, \vee\}$ es funcionalmente completo.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 3
Sean $\tau, \sigma, \rho$ y $\zeta$ proposiciones tales que $\tau \Rightarrow \sigma$ es tautología y $\rho \Rightarrow \zeta$ es contradicción. Determinar si las siguientes proposiciones son tautologías, contradicciones o contingencias y demostrarlo:

I. $(\tau \Rightarrow \sigma) \vee (\rho \Rightarrow \zeta)$
II. $(\tau \Rightarrow \rho) \vee (\sigma \Rightarrow \zeta)$
III. $(\rho \Rightarrow \sigma) \vee (\zeta \Rightarrow \sigma)$

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Razonamiento sobre meta-propiedades de fórmulas (tautologicidad y contradicción).

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 4
Probar que cualquier fórmula que sea una tautología contiene un $\neg$ o una $\Rightarrow$.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Análisis de la preservación de la verdad. Sin negación ni implicación, una fórmula con átomos falsos siempre será falsa.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

## Deducción Natural

### Ejercicio 5 ★
Demostrar en deducción natural que las siguientes fórmulas son teoremas **sin usar principios de razonamiento clásicos** salvo que se indique lo contrario.

I. Modus ponens relativizado: $(\rho \Rightarrow \sigma \Rightarrow \tau) \Rightarrow (\rho \Rightarrow \sigma) \Rightarrow \rho \Rightarrow \tau$
II. Reducción al absurdo: $(\rho \Rightarrow \perp) \Rightarrow \neg \rho$
III. Introducción de la doble negación: $\rho \Rightarrow \neg\neg \rho$
IV. Eliminación de la triple negación: $\neg\neg\neg \rho \Rightarrow \neg \rho$
V. Contraposición: $(\rho \Rightarrow \sigma) \Rightarrow (\neg \sigma \Rightarrow \neg \rho)$
VI. Adjunción: $((\rho \wedge \sigma) \Rightarrow \tau) \Leftrightarrow (\rho \Rightarrow \sigma \Rightarrow \tau)$
VII. de Morgan (I): $\neg(\rho \vee \sigma) \Leftrightarrow (\neg \rho \wedge \neg \sigma)$
VIII. de Morgan (II): $\neg(\rho \wedge \sigma) \Leftrightarrow (\neg \rho \vee \neg \sigma)$. Para la dirección $\Rightarrow$ es necesario usar principios de razonamiento clásicos.
IX. Conmutatividad ($\wedge$): $(\rho \wedge \sigma) \Rightarrow (\sigma \wedge \rho)$
X. Asociatividad ($\wedge$): $((\rho \wedge \sigma) \wedge \tau) \Leftrightarrow (\rho \wedge (\sigma \wedge \tau))$
XI. Conmutatividad ($\vee$): $(\rho \vee \sigma) \Rightarrow (\sigma \vee \rho)$
XII. Asociatividad ($\vee$): $((\rho \vee \sigma) \vee \tau) \Leftrightarrow (\rho \vee (\sigma \vee \tau))$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/deduccion_natural_intuicionista]]

**Explicación:**
Práctica de reglas de introducción y eliminación en Lógica Intuicionista (LJ).

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 6 ★
Demostrar en deducción natural que vale $\vdash \sigma$ para cada una de las siguientes fórmulas. Para estas fórmulas es **imprescindible usar lógica clásica**:

I. Absurdo clásico: $(\neg \tau \Rightarrow \perp) \Rightarrow \tau$
II. Ley de Peirce: $((\tau \Rightarrow \rho) \Rightarrow \tau) \Rightarrow \tau$
III. Tercero excluido: $\tau \vee \neg \tau$
IV. Consecuencia milagrosa: $(\neg \tau \Rightarrow \tau) \Rightarrow \tau$
V. Contraposición clásica: $(\neg \rho \Rightarrow \neg \tau) \Rightarrow (\tau \Rightarrow \rho)$
VI. Análisis de casos: $(\tau \Rightarrow \rho) \Rightarrow (\neg \tau \Rightarrow \rho) \Rightarrow \rho$
VII. Implicación vs. disyunción: $(\tau \Rightarrow \rho) \Leftrightarrow (\neg \tau \vee \rho)$

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Uso de la regla de Absurdo Clásico o Tercero Excluido para demostrar teoremas no válidos en lógica intuicionista.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 7
Probar las siguientes propiedades:

I. **Debilitamiento.** Si $\Gamma \vdash \sigma$ es válido entonces $\Gamma, \tau \vdash \sigma$ es válido.
II. **Regla de corte.** Si $\Gamma, \tau \vdash \sigma$ es válido y $\Gamma \vdash \tau$ es válido, entonces $\Gamma \vdash \sigma$ es válido.
III. $\Rightarrow^{-1}_i$: Si $\Gamma \vdash \tau \Rightarrow \sigma$ es válido, entonces $\Gamma, \tau \vdash \sigma$ también lo es.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Propiedades estructurales del sistema de Deducción Natural.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 8
Si $[\tau_1, \dots, \tau_n]$ es una lista de fórmulas, definimos la notación $[\tau_1, \dots, \tau_n] \Rightarrow^* \sigma$ inductivamente:
- $([] \Rightarrow^* \sigma) = \sigma$
- $([\tau_1, \tau_2, \dots, \tau_n] \Rightarrow^* \sigma) = \tau_1 \Rightarrow ([\tau_2, \dots, \tau_n] \Rightarrow^* \sigma)$

Probar por inducción en $n$ que $\tau_1, \dots, \tau_n \vdash \sigma$ es válido si y sólo si $\vdash [\tau_1, \dots, \tau_n] \Rightarrow^* \sigma$ es válido.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Teorema de la deducción generalizado.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicios 9 - 10
Teoremas y tautologías adicionales para practicar.

---

## Ejercicios Extra de Deducción Natural

### Ejercicio 11
Probar que los siguientes secuentes son válidos sin usar principios de razonamiento clásicos:
(Lista de 14 secuentes, ej: $(P \wedge Q) \wedge R, S \wedge T \vdash Q \wedge S$)

### Ejercicio 12
Probar que los siguientes secuentes son válidos (puede requerir lógica clásica):
(Lista de 11 secuentes, ej: $(P \wedge \neg Q) \Rightarrow R, \neg R, P \vdash Q$)

### Ejercicio 13
Probar que los siguientes secuentes son válidos:
(Lista de 9 secuentes, ej: $\neg P \Rightarrow \neg Q \vdash Q \Rightarrow P$)

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/deduccion_natural_intuicionista]]

**Explicación:**
Batería de ejercicios para mecanizar el uso de las reglas de Deducción Natural.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/deduccion_natural_intuicionista]]
