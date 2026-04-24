---
nombre: Unificación e Inferencia de Tipos — Guia de Ejercicios
parcial: 2P
tipo: guia
tema: unificacion_e_inferencia
fuente: raw/guias_practicas/4.guia_2P_inferencia_de_tipos.pdf
paginas_relacionadas:
  - "[[unificacion_e_inferencia_de_tipos_teoria]]"
  - "[[unificacion_e_inferencia_practica]]"
---

# Práctica Nº 5 - Inferencia de tipos

Esta guía se centra en el algoritmo de inferencia de tipos (Algoritmo I) basado en la generación de restricciones y unificación (MGU), incluyendo extensiones para tipos compuestos.

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| [Ej. 1](#ejercicio-1-—-sintaxis-y-anotaciones) | Identificación de términos anotados y sin anotar | ⚪ No |
| [Ej. 2](#ejercicio-2-—-sustituciones) | Aplicación de sustituciones de tipos | ⚪ No |
| [Ej. 3](#ejercicio-3-—-unificación) | Cálculo de unificadores más generales (MGU) | 🔴 Si |
| [Ej. 4](#ejercicio-4-—-decidibilidad-de-tipado) | Determinar si expresiones son tipables mediante inferencia | 🔴 Si |
| [Ej. 5](#ejercicio-5-—-paso-a-paso-del-algoritmo) | Ejecución detallada del algoritmo de inferencia | 🔴 Si |
| [Ej. 6](#ejercicio-6-—-numerales-de-church) | Tipado de numerales de Church | 🔴 Si |
| [Ej. 7](#ejercicio-7-—-variables-frescas-y-contexto) | Inferencia con variables libres y ligadas | 🔴 Si |
| [Ej. 8](#ejercicio-8-—-extension-pares) | Algoritmo de inferencia para productos (pares) | 🔴 Si |
| [Ej. 9](#ejercicio-9-—-extension-sumas) | Algoritmo de inferencia para co-productos (sumas) | 🔴 Si |
| [Ej. 10](#ejercicio-10-—-extension-listas) | Algoritmo de inferencia para listas y foldr | 🔴 Si |

---

## CONCEPTOS BÁSICOS

### Ejercicio 1 — Sintaxis y anotaciones
**Enunciado**
Determinar qué expresiones son sintácticamente válidas y, para las que lo sean, indicar a qué gramática pertenecen (tipos, términos anotados o términos sin anotaciones).

I. $\lambda x : \text{Bool} . \text{succ}(x)$
II. $\lambda x . \text{isZero}(x)$
III. $X_1 \to \sigma$
IV. $\text{erase}(f y)$
V. $X_1$
VI. $X_1 \to (\text{Bool} \to X_2)$
VII. $\lambda x : X_1 \to X_2 . \text{if zero then True else zero succ}(\text{True})$
VIII. $\text{erase}(\lambda f : \text{Bool} \to \text{Bool} . \lambda y : \text{Bool} . f y)$

**Explicación**
Diferencia entre el cálculo lambda tipado (anotado) y el cálculo lambda puro donde el sistema infiere los tipos (sin anotar). La función `erase` elimina las anotaciones.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 2 — Sustituciones
**Enunciado**
Determinar el resultado de aplicar la sustitución $S$ a las siguientes expresiones:
I. $S = \{X_1 := \text{Nat}\}$, $S(\{x : X_1 \to \text{Bool}\})$
II. $S = \{X_1 := X_2 \to X_3, X_4 := \text{Bool}\}$, $S(\{x : X_4 \to \text{Bool}\}) \vdash S(\lambda x : X_1 \to \text{Bool} . x) : S(\text{Nat} \to X_2)$

**Explicación**
Práctica de aplicación de sustituciones sobre contextos de tipado y términos.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 3 — Unificación
**Enunciado**
Unir con flechas los tipos que unifican entre sí (entre una fila y la otra). Para cada par unificable, exhibir el $mgu$ ("most general unifier").

Fila 1: $X_1 \to X_2$ | $\text{Nat}$ | $X_2 \to \text{Bool}$ | $X_3 \to X_4 \to X_5$
Fila 2: $X_1$ | $\text{Nat} \to \text{Bool}$ | $(\text{Nat} \to X_2) \to \text{Bool}$ | $\text{Nat} \to X_2 \to \text{Bool}$

**Explicación**
El algoritmo de unificación es el corazón de la inferencia. Se basa en encontrar una sustitución que haga idénticas dos expresiones de tipos.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_mgu]]

---

## ALGORITMO DE INFERENCIA (I)

### Ejercicio 4 — Decidibilidad de tipado
**Enunciado**
Decidir, utilizando el algoritmo de inferencia, cuáles de las siguientes expresiones son tipables. Mostrar qué reglas y sustituciones se aplican en cada paso y justificar por qué no son tipables aquéllas que fallan.

I. $\lambda z . \text{if } z \text{ then zero else succ}(\text{zero})$
II. $\lambda y . \text{succ}((\lambda x . x) y)$
III. $\lambda x . \text{if isZero}(x) \text{ then } x \text{ else } (\text{if } x \text{ then } x \text{ else } x)$
IV. $\lambda x . \lambda y . \text{if } x \text{ then } y \text{ else succ}(\text{zero})$
V. $\text{if True then } (\lambda x . \text{zero}) \text{ zero else } (\lambda x . \text{zero}) \text{ False}$
VI. $(\lambda f . \text{if True then } f \text{ zero else } f \text{ False}) (\lambda x . \text{zero})$
VII. $\lambda x . \lambda y . \lambda z . \text{if } z \text{ then } y \text{ else succ}(x)$

**Explicación**
Aplicación directa de las reglas del algoritmo $\mathcal{I}$. El fallo suele ocurrir por conflictos en la unificación (ej: $\text{Bool} \doteq \text{Nat}$).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_I]]

### Ejercicio 5 — Paso a paso del algoritmo
**Enunciado**
Utilizando el algoritmo de inferencia, inferir el tipo de las siguientes expresiones o demostrar que no son tipables. En cada paso donde se realice una unificación, mostrar el conjunto de ecuaciones a unificar y la sustitución obtenida como resultado de la misma.

- $\lambda x . \lambda y . \lambda z . z x y$
- $\lambda x . x (w (\lambda y . w y))$
- $\lambda x . \lambda y . x y$
- $\lambda x . \lambda y . y x$
- $\lambda x . (\lambda x . x)$
- $\lambda x . (\lambda y . y) x$
- $(\lambda z . \lambda x . x (z (\lambda y . z))) \text{ True}$

**Explicación**
Práctica intensiva de generación de variables frescas y resolución de ecuaciones de tipos.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_I]]

---

## EXTENSIONES DEL ALGORITMO

### Ejercicio 8 — Extensión Pares
**Enunciado**
Dadas las reglas de tipado para pares:
$\frac{\Gamma \vdash M : \tau \quad \Gamma \vdash N : \sigma}{\Gamma \vdash \langle M, N \rangle : \tau \times \sigma} \quad \frac{\Gamma \vdash M : \tau \times \sigma}{\Gamma \vdash \pi_1(M) : \tau} \quad \frac{\Gamma \vdash M : \tau \times \sigma}{\Gamma \vdash \pi_2(M) : \sigma}$
Se pide:
I. Tipar la expresión $(\lambda f . \langle f, \underline{2} \rangle) (\lambda x . x \underline{1})$
II. Intentar tipar $(\lambda f . \langle f \underline{2}, f \text{ True} \rangle) (\lambda x . x)$ e indicar dónde falla.

**Explicación**
Extensión del algoritmo $\mathcal{I}$ para productos. Note que en el punto II, la función $f$ se usa con dos tipos distintos ($\text{Nat} \to X$ y $\text{Bool} \to Y$), lo cual falla en el polimorfismo simple (monomorfismo).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_extension_pares]]

### Ejercicio 9 — Extensión Sumas
**Enunciado**
Definir las reglas del algoritmo de inferencia $\mathcal{I}$ para soportar uniones disjuntas:
$M ::= \dots \mid \text{left}_\tau(M) \mid \text{right}_\tau(M) \mid \text{case } M \text{ of left}(x) \leadsto M_1 \parallel \text{right}(y) \leadsto M_2$
Y aplicarlas a:
I. $\text{case left}(\underline{1}) \text{ of left}(x) \leadsto \text{isZero}(x) \parallel \text{right}(y) \leadsto \text{True}$
II. $\text{case left}(z) \text{ of left}(x) \leadsto \text{isZero}(x) \parallel \text{right}(y) \leadsto y$

**Explicación**
El `case` genera restricciones de unificación entre las ramas y el tipo de retorno.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_extension_sumas]]

### Ejercicio 10 — Extensión Listas
**Enunciado**
Definir las reglas del algoritmo de inferencia $\mathcal{I}$ para soportar listas y `foldr`:
$M ::= \dots \mid []_\tau \mid M :: M \mid \text{foldr } M \text{ base } \leadsto M; \text{rec}(h, r) \leadsto M$
Y aplicarlas a:
I. $\text{foldr } x :: [] \text{ base } \leadsto []; \text{rec}(h, r) \leadsto \text{isZero}(h) :: r$

**Explicación**
`foldr` es el operador más complejo para inferir, ya que involucra el tipo de la lista, el tipo del acumulador y la función de paso.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_extension_listas]]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/inferencia_algoritmo_w]]
