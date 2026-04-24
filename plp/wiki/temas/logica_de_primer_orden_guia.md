---
nombre: Lógica de Primer Orden — Guia de Ejercicios
parcial: 2P
tipo: guia
tema: logica_de_primer_orden
fuente: raw/guias_practicas/5.guia_2P_logica_de_primer_orden.pdf
paginas_relacionadas:
  - "[[logica_de_primer_orden_teoria]]"
---

# Práctica Nº 6 - Lógica de primer orden

Esta guía abarca la sintaxis de la LPO (términos y fórmulas), el algoritmo de unificación, la deducción natural para predicados y la semántica (interpretaciones y modelos).

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| [Ej. 1](#ejercicio-1-—-términos) | Identificación de términos válidos | ⚪ No |
| [Ej. 2](#ejercicio-2-—-fórmulas) | Identificación de fórmulas válidas | ⚪ No |
| [Ej. 3](#ejercicio-3-—-variables-y-sustituciones) | Variables libres/ligadas y aplicación de sustituciones | ⚪ No |
| [Ej. 4](#ejercicio-4-—-sustituciones-complejas) | Sustituciones con meta-variables | ⚪ No |
| [Ej. 5](#ejercicio-5-—-tabla-de-unificación) | Unificación de predicados y términos con MGU | 🔴 Si |
| [Ej. 6](#ejercicio-6-—-algoritmo-de-unificación) | Aplicación de Martelli-Montanari | 🔴 Si |
| [Ej. 7](#ejercicio-7-—-propiedades-de-la-unificación) | Reflexividad, simetría y transitividad | ⚪ No |
| [Ej. 8](#ejercicio-8-—-unificación-de-tipos) | MGU aplicado a tipos flecha, Nat y Bool | 🔴 Si |
| [Ej. 9](#ejercicio-9-—-deducción-natural) | Pruebas de teoremas en DN para LPO | 🔴 Si |
| [Ej. 10](#ejercicio-10-—-derivación-compleja) | Derivación con funciones y cuantificadores | 🔴 Si |
| [Ej. 11](#ejercicio-11-—-fnn) | Forma Normal Negada | ⚪ No |
| [Ej. 12](#ejercicio-12-—-fnp) | Forma Normal Prenexa | 🔴 Si |
| [Ej. 13](#ejercicio-13-—-semántica-en-z) | Interpretaciones en el dominio de los Enteros | 🔴 Si |
| [Ej. 14](#ejercicio-14-—-semántica-aritmética) | Satisfacibilidad en el dominio de los Naturales | 🔴 Si |
| [Ej. 15](#ejercicio-15-—-validez-lógica) | Demostrar que fórmulas NO son lógicamente válidas | 🔴 Si |
| [Ej. 16](#ejercicio-16-—-extra-dn) | Ejercicios adicionales de Deducción Natural | 🔴 Si |

---

## SINTAXIS

### Ejercicio 1 — Términos
**Enunciado**
Dados $\mathcal{F} = \{d, f, g\}$, donde $d$ tiene aridad 0, $f$ aridad 2 y $g$ aridad 3. ¿Cuáles de las siguientes cadenas son términos sobre $\mathcal{F}$?
I. $g(d, d)$ | II. $f(X, g(Y, Z), d)$ | III. $g(X, f(d, Z), d)$ | IV. $g(X, h(Y, Z), d)$ | V. $f(f(g(d, X), f(g(d, X), Y, g(Y, d)), g(d, d)), g(f(d, d, X), d), Z)$

**Explicación**
Un término se construye recursivamente a partir de variables y símbolos de función aplicados a la cantidad correcta de argumentos (aridad).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 2 — Fórmulas
**Enunciado**
Sean $c$ una constante, $f$ un símbolo de función de aridad 1 y $S$ y $B$, dos símbolos de predicado binarios. ¿Cuáles de las siguientes cadenas son fórmulas?
I. $S(c, X)$ | II. $B(c, f(c))$ | III. $f(c)$ | IV. $B(B(c, X), Y)$ | V. $S(B(c), Z)$ ... (ver PDF para lista completa)

**Explicación**
Las fórmulas se construyen a partir de predicados (que toman términos como argumentos) y conectivos lógicos. No se pueden anidar predicados dentro de otros predicados ni funciones que devuelvan fórmulas.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

---

## UNIFICACIÓN

### Ejercicio 5 — Tabla de unificación
**Enunciado**
Unir con flechas las expresiones que unifican entre sí. Para cada par unificable, exhibir el $mgu$.
Predicados y términos a cruzar: $P(f(X))$, $P(a)$, $P(Y)$, $Q(X, f(Y))$, $Q(X, f(Z))$, $Q(X, f(a))$, $X$, $f(X)$, $P(X)$, $P(f(a))$, $P(g(Z))$, $Q(f(Y), X)$, $Q(f(Y), f(X))$, $Q(f(Y), Y)$, $f(f(c))$, $f(g(Y))$.

**Explicación**
Práctica de unificación estructural. El MGU es la sustitución más general que hace que dos átomos sean idénticos.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_unificacion]]

### Ejercicio 8 — Unificación de tipos
**Enunciado**
Calcular el MGU para ecuaciones de tipos como:
I. $\{T_1 \to T_2 \doteq \text{Nat} \to \text{Bool}\}$
II. $\{T_1 \to T_2 \doteq T_3\}$
... (ver PDF para lista completa de 8 ítems)

**Explicación**
Aplicación del algoritmo de unificación al sistema de tipos flecha, fundamental para la inferencia.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_mgu]]

---

## DEDUCCIÓN NATURAL

### Ejercicio 9 — Deducción Natural
**Enunciado**
Demostrar en deducción natural que vale $\vdash \sigma$ para cada una de las siguientes fórmulas, **sin usar principios de razonamiento clásicos** (salvo indicación contraria).
Incluye: Diagonal, De Morgan (casos intuicionistas), Intercambio de cuantificadores, Drinker's Principle (clásico).

**Explicación**
Uso de las reglas de introducción y eliminación para $\forall$ y $\exists$. Atención a las restricciones de las variables frescas en $\forall I$ y $\exists E$.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_deduccion_natural]]

---

## SEMÁNTICA

### Ejercicio 14 — Semántica aritmética
**Enunciado**
Sea $N$ la interpretación aritmética donde $D_I = \mathbb{N}$, $c^0 = 0$, $P^2 = \text{"="}$, $f^1_1 = \text{sucesor}$, $f^2_2 = "+", f^2_3 = "\times"$.
Hallar asignaciones que satisfagan (y que no) fórmulas como:
I. $P(f_2(X_1, X_1), f_3(f_1(X_1), f_1(X_1)))$
IV. $\forall X_1 . P(f_3(X_1, X_2), X_3)$

**Explicación**
Evaluación de fórmulas en una estructura (modelo). Diferencia entre verdad lógica (en todo modelo) y satisfacibilidad (en algún modelo con alguna asignación).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_semantica_modelos]]
