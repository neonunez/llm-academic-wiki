---
nombre: Cálculo Lambda (Tipado y Semántica) — Guia de Ejercicios
parcial: 1P
tipo: guia
tema: calculo_lambda_tipado
fuente: raw/guias_practicas/3.guia_1P_calculo_lamda_tipado_semantica_operacional.pdf
paginas_relacionadas:
  - "[[calculo_lambda_tipado_teoria]]"
  - "[[calculo_lambda_practica]]"
---

# Práctica Nº 4 - Cálculo-λ: Tipado y Semántica Operacional

Esta guía cubre los fundamentos sintácticos, el sistema de tipado simple y la semántica operacional del cálculo lambda, junto con extensiones comunes (pares, sumas, listas, deques).

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| [Ej. 1](#ejercicio-1-—-sintaxis) | Validez sintáctica de expresiones | ⚪ No |
| [Ej. 2](#ejercicio-2-—-gramatica-completa) | Término que usa todas las reglas | ⚪ No |
| [Ej. 3](#ejercicio-3-—-subterminos) | Identificación de subtérminos y ocurrencias | ⚪ No |
| [Ej. 4](#ejercicio-4-—-parentización-y-árboles) | Convención de paréntesis y árboles sintácticos | 🔴 Si |
| [Ej. 5](#ejercicio-5-—-no-tipable) | Término no tipable sin variables libres | ⚪ No |
| [Ej. 6](#ejercicio-6-—-derivaciones-de-tipado) | Construcción de derivaciones de tipado | 🔴 Si |
| [Ej. 7](#ejercicio-7-—-cambio-de-regla) | Análisis de impacto por cambio en regla de abstracción | 🔴 Si |
| [Ej. 8](#ejercicio-8-—-deducción-de-tipos) | Determinar tipo resultante de juicios | ⚪ No |
| [Ej. 9](#ejercicio-9-—-tipos-habitados) | Demostrar que tipos están habitados (combinadores) | 🔴 Si |
| [Ej. 10](#ejercicio-10-—-inferencia-manual) | Determinar tipos $\sigma$ y $\tau$ en juicios | 🔴 Si |
| [Ej. 11](#ejercicio-11-—-debilitamiento-y-fortalecimiento) | Propiedades del contexto de tipado | ⚪ No |
| [Ej. 12](#ejercicio-12-—-lema-de-sustitución) | Demostración del lema fundamental de sustitución | ⚪ No |
| [Ej. 13](#ejercicio-13-—-sustituciones) | Cálculo manual de sustituciones | 🔴 Si |
| [Ej. 14](#ejercicio-14-—-conmutación-de-sustituciones) | Propiedad de conmutación de sustituciones | ⚪ No |
| [Ej. 15](#ejercicio-15-—-valores) | Identificación de valores según la gramática | 🔴 Si |
| [Ej. 16](#ejercicio-16-—-programas-y-forma-normal) | Evaluación de programas y detección de errores | 🔴 Si |
| [Ej. 17](#ejercicio-17-—-determinismo) | Análisis de determinismo en la reducción | ⚪ No |
| [Ej. 18](#ejercicio-18-—-propiedades-de-succ-y-pred) | Evaluación de términos con succ/pred/isZero | ⚪ No |
| [Ej. 19](#ejercicio-19-—-regla-xi) | Impacto de permitir reducción bajo abstracciones | 🔴 Si |
| [Ej. 20](#ejercicio-20-—-extension-pares) | Reglas y habitantes para productos (pares) | 🔴 Si |
| [Ej. 21](#ejercicio-21-—-extension-sumas) | Reglas y habitantes para co-productos (sumas) | 🔴 Si |
| [Ej. 22](#ejercicio-22-—-extension-listas) | Reglas y reducción para listas y foldr | 🔴 Si |
| [Ej. 23](#ejercicio-23-—-map) | Definición de map para listas | 🔴 Si |
| [Ej. 24](#ejercicio-24-—-listas-por-comprensión) | Extensión para listas por comprensión | 🔴 Si |
| [Ej. 25](#ejercicio-25-—-macros-booleanas) | Definición de Not, And, Or, Xor como macros | ⚪ No |
| [Ej. 26](#ejercicio-26-—-funciones-de-listas) | head, tail, iterate, zip, take como macros | 🔴 Si |
| [Ej. 27](#ejercicio-27-—-extension-deques) | Reglas y reducción para colas bidireccionales | 🔴 Si |

---

## SINTAXIS

### Ejercicio 1 — Sintaxis
**Enunciado**
Determinar qué expresiones son sintácticamente válidas (es decir, pueden ser generadas con las gramáticas presentadas) y determinar a qué categoría pertenecen (expresiones de términos o expresiones de tipos):

a) $x$ | b) $x x$ | c) $M$ | d) $M M$ | e) $\text{true false}$ | f) $\text{true succ}(\text{false true})$ | g) $\lambda x . \text{isZero}(x)$ | h) $\lambda x : \sigma . \text{succ}(x)$ | i) $\lambda x : \text{Bool} . \text{succ}(x)$ | j) $\lambda x : \text{if true then Bool else Nat} . x$ | k) $\sigma$ | l) $\text{Bool}$ | m) $\text{Bool} \to \text{Bool}$ | n) $\text{Bool} \to \text{Bool} \to \text{Nat}$ | ñ) $(\text{Bool} \to \text{Bool}) \to \text{Nat}$ | o) $\text{succ true}$ | p) $\lambda x : \text{Bool} . \text{if zero then true else zero succ}(\text{true})$

**Explicación**
Pide distinguir entre la sintaxis de términos (que representan programas/valores) y tipos (que clasifican términos). Hay que notar que algunas expresiones usan meta-variables ($M, \sigma$) y otras constantes de la gramática.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 2 — Gramática completa
**Enunciado**
Mostrar un término que utilice al menos una vez **todas** las reglas de generación de la gramática de los términos y exhibir su *árbol sintáctico*.

**Explicación**
Requiere construir un término "monstruo" que incluya abstracción, aplicación, booleanos (true, false, if), y naturales (zero, succ, pred, isZero).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 3 — Subtérminos
**Enunciado**
a) Marcar las ocurrencias del término $x$ como subtérmino en $\lambda x : \text{Nat} . \text{succ}((\lambda x : \text{Nat} . x) x)$.
b) ¿Ocurre $x_1$ como subtérmino en $\lambda x_1 : \text{Nat} . \text{succ}(x_2)$?
c) ¿Ocurre $x (y z)$ como subtérmino en $u x (y z)$?

**Explicación**
Concepto de subtérmino y ocurrencia. Es vital para entender el alcance de las variables y la sustitución.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 4 — Parentización y árboles
**Enunciado**
Para los siguientes términos:
a) $u x (y z) (\lambda v : \text{Bool} . v y)$
b) $(\lambda x : \text{Bool} \to \text{Nat} \to \text{Bool} . \lambda y : \text{Bool} \to \text{Nat} . \lambda z : \text{Bool} . x z (y z)) u v w$
c) $w (\lambda x : \text{Bool} \to \text{Nat} \to \text{Bool} . \lambda y : \text{Bool} \to \text{Nat} . \lambda z : \text{Bool} . x z (y z)) u v$

Se pide:
I. Insertar todos los paréntesis de acuerdo a la convención usual.
II. Dibujar el árbol sintáctico de cada una de las expresiones.
III. Indicar en el árbol cuáles ocurrencias de variables aparecen ligadas y cuáles libres.
IV. ¿En cuál o cuáles de los términos anteriores ocurre la siguiente expresión como subtérmino?
$(\lambda x : \text{Bool} \to \text{Nat} \to \text{Bool} . \lambda y : \text{Bool} \to \text{Nat} . \lambda z : \text{Bool} . x z (y z)) u$

**Explicación**
Uso de la convención de asociatividad a izquierda para la aplicación y a derecha para el tipo flecha. Identificación de variables libres y ligadas.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_sintaxis_arbol]]

---

## TIPADO

### Ejercicio 5 — No tipable
**Enunciado**
Mostrar un término que no sea tipable y que no tenga variables libres ni abstracciones.

**Explicación**
Busca un error de tipo "dinámico" que el sistema de tipos estático debería rechazar (ej: usar succ sobre un Booleano).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 6 — Derivaciones de tipado
**Enunciado**
Dar una derivación –o explicar por qué no es posible dar una derivación– para cada uno de los siguientes juicios de tipado:
a) $\vdash \text{if true then zero else succ}(\text{zero}) : \text{Nat}$
b) $x : \text{Nat}, y : \text{Bool} \vdash \text{if true then false else } (\lambda z : \text{Bool} . z) \text{ true} : \text{Bool}$
c) $\vdash \text{if } \lambda x : \text{Bool} . x \text{ then zero else succ}(\text{zero}) : \text{Nat}$
d) $x : \text{Bool} \to \text{Nat}, y : \text{Bool} \vdash x y : \text{Nat}$

**Explicación**
Construcción de árboles de derivación usando las reglas de tipado (T-If, T-Abs, T-App, T-Var, etc.).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_derivacion_tipado]]

### Ejercicio 7 — Cambio de regla
**Enunciado**
Se modifica la regla de tipado de la abstracción y se la cambia por la siguiente regla:
$$\frac{\Gamma \vdash M : \tau}{\Gamma \vdash \lambda x : \sigma . M : \sigma \to \tau} \to_{i2}$$
Exhibir un juicio de tipado que sea derivable en el sistema original pero que no lo sea en el sistema actual.

**Explicación**
La nueva regla NO agrega la variable ligada $x$ al contexto $\Gamma$ para tipar el cuerpo $M$. Esto significa que $M$ no puede usar $x$ de forma libre.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_cambio_reglas]]

### Ejercicio 8 — Deducción de tipos
**Enunciado**
Determinar qué tipo representa $\sigma$ en cada uno de los siguientes juicios de tipado.
a) $\vdash \text{succ}(\text{zero}) : \sigma$
b) $\vdash \text{isZero}(\text{succ}(\text{zero})) : \sigma$
c) $\vdash \text{if } (\text{if true then false else false}) \text{ then zero else succ}(\text{zero}) : \sigma$

**Explicación**
Propagación de tipos básica.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 9 — Tipos habitados
**Enunciado**
Decimos que un tipo $\tau$ está *habitado* si existe un término $M$ tal que el juicio $\vdash M : \tau$ es derivable. En ese caso, decimos que $M$ es un *habitante* de $\tau$. Demostrar que los siguientes tipos están habitados (para cualquier $\sigma, \tau$ y $\rho$):
a) $\sigma \to \tau \to \sigma$
b) $(\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$
c) $(\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$
d) $(\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$

**Explicación**
Encontrar los combinadores básicos (K, S, etc.). Está relacionado con la Correspondencia Curry-Howard (habitantes de tipos flecha como pruebas de implicación lógica).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_habitantes]]

### Ejercicio 10 — Inferencia manual
**Enunciado**
Determinar qué tipos representan $\sigma$ y $\tau$ en cada uno de los siguientes juicios de tipado. Si hay más de una solución, o si no hay ninguna, indicarlo.
a) $x : \sigma \vdash \text{isZero}(\text{succ}(x)) : \tau$
b) $\vdash (\lambda x : \sigma . x)(\lambda y : \text{Bool} . \text{zero}) : \sigma$
c) $y : \tau \vdash \text{if } (\lambda x : \sigma . x) \text{ then } y \text{ else succ}(\text{zero}) : \sigma$
d) $x : \sigma \vdash x y : \tau$
e) $x : \sigma, y : \tau \vdash x y : \tau$
f) $x : \sigma \vdash x \text{ true} : \tau$
g) $x : \sigma \vdash x \text{ true} : \sigma$
h) $x : \sigma \vdash x x : \tau$

**Explicación**
Inferencia de tipos manual resolviendo restricciones. Especial atención al caso h) (auto-aplicación), que no es tipable en Cálculo Lambda Simple.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_inferencia_manual]]

### Ejercicio 11 — Debilitamiento y fortalecimiento
**Enunciado**
Demostrar las siguientes propiedades, procediendo por inducción en la derivación del juicio correspondiente:
1. Si $\Gamma \vdash M : \sigma$ es un juicio de tipado derivable y $x$ es una variable que no aparece en $\Gamma$, entonces $\Gamma, x : \tau \vdash M : \sigma$ es derivable para todo tipo $\tau$. Esta regla se conoce como *debilitamiento* o *weakening*.
2. Si $\Gamma, x : \tau \vdash M : \sigma$ es un juicio de tipado derivable tal que $x$ no aparece libre en $M$, entonces $\Gamma \vdash M : \sigma$ es derivable para todo tipo $\tau$. Esta regla se conoce como *fortalecimiento* o *strengthening*.
3. Dar un contraejemplo para fortalecimiento en el caso en el que $x$ aparece libre en $M$.

**Explicación**
Propiedades estructurales del contexto de tipado.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 12 — Lema de sustitución
**Enunciado**
Demostrar que si valen $\Gamma, x : \sigma \vdash M : \tau$ y $\Gamma \vdash N : \sigma$ entonces vale $\Gamma \vdash M\{x := N\} : \tau$.
*Sugerencia:* proceder por inducción en la estructura del término $M$.

**Explicación**
Es el lema clave para demostrar Preservación (Type Safety). La sustitución preserva el tipo.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

---

## SEMÁNTICA

### Ejercicio 13 — Sustituciones
**Enunciado**
Sean $\sigma, \tau, \rho$ tipos. Según la definición de sustitución, calcular:
a) $(\lambda y : \sigma . x (\lambda x : \tau . x))\{x := (\lambda y : \rho . x y)\}$
b) $(y (\lambda v : \sigma . x v))\{x := (\lambda y : \tau . v y)\}$
Renombrar variables en ambos términos para que las sustituciones no cambien su significado.

**Explicación**
Práctica de sustitución evitando la captura de variables. Requiere $\alpha$-conversión previa.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_sustitucion]]

### Ejercicio 14 — Conmutación de sustituciones
**Enunciado**
a) Por inducción en la estructura del término $M$, demostrar que si $x$ no aparece libre en $P$ y $x \neq y$, entonces:
$M\{x := N\}\{y := P\} = M\{y := P\}\{x := N\{y := P\}\}$
b) Dar un contraejemplo para la ecuación de arriba cuando $x$ aparece libre en $P$.

**Explicación**
Propiedad técnica de la sustitución.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

### Ejercicio 15 — Valores
**Enunciado**
Dado el conjunto de valores visto en clase ($V ::= \lambda x : \tau . M \mid \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V)$), determinar si cada una de las siguientes expresiones es o no un valor:
a) $(\lambda x : \text{Bool} . x) \text{ true}$ | b) $\lambda x : \text{Bool} . \underline{2}$ | c) $\lambda x : \text{Bool} . \text{pred}(\underline{2})$ | d) $\lambda y : \text{Nat} . (\lambda x : \text{Bool} . \text{pred}(\underline{2})) \text{ true}$ | e) $x$ | f) $\text{succ}(\text{succ}(\text{zero}))$

**Explicación**
Un valor es un término que no puede reducirse más bajo la estrategia de evaluación dada. Las abstracciones siempre son valores (en evaluación call-by-value estándar).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_valores]]

### Ejercicio 16 — Programas y forma normal
**Enunciado**
Para el siguiente ejercicio, considerar el cálculo **sin** la regla $\text{pred}(\text{zero}) \to \text{zero}$.
Un *programa* es un término que tipa en el contexto vacío.
Para cada una de las siguientes expresiones:
a) Determinar si puede ser considerada un programa.
b) Si es un programa, ¿Cuál es el resultado de su evaluación? Determinar si se trata de una forma normal, y en caso de serlo, si es un **valor** o un **error**.

I. $(\lambda x : \text{Bool} . x) \text{ true}$
II. $\lambda x : \text{Nat} . \text{pred}(\text{succ}(x))$
III. $\lambda x : \text{Nat} . \text{pred}(\text{succ}(y))$
IV. $(\lambda x : \text{Bool} . \text{pred}(\text{isZero}(x))) \text{ true}$
V. $(\lambda f : \text{Nat} \to \text{Bool} . f \text{ zero}) (\lambda x : \text{Nat} . \text{isZero}(x))$
VI. $(\lambda f : \text{Nat} \to \text{Bool} . x) (\lambda x : \text{Nat} . \text{isZero}(x))$
VII. $(\lambda f : \text{Nat} \to \text{Bool} . f \text{ pred}(\text{zero})) (\lambda x : \text{Nat} . \text{isZero}(x))$
VIII. $\text{fix } \lambda y : \text{Nat} . \text{succ}(y)$

**Explicación**
Diferencia entre forma normal (no reduce más) y valor (resultado deseado). Un error es una forma normal que no es un valor (término "trabado" o "stuck").

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_evaluacion]]

---

## EXTENSIONES

### Ejercicio 20 — Extension Pares (Productos)
**Enunciado**
Este ejercicio extiende el cálculo-$\lambda$ tipado con *pares*. Las gramáticas de los tipos y los términos se extienden de la siguiente manera:
$\tau ::= \dots \mid \tau \times \tau$
$M ::= \dots \mid \langle M, M \rangle \mid \pi_1(M) \mid \pi_2(M)$
a) Definir reglas de tipado para los nuevos constructores.
b) Exhibir habitantes para:
I. Constructor de pares: $\sigma \to \tau \to (\sigma \times \tau)$
II. Proyecciones: $(\sigma \times \tau) \to \sigma$ y $(\sigma \times \tau) \to \tau$
III. Conmutatividad, Asociatividad, Currificación.
c) ¿Cómo se extiende el conjunto de los valores?
d) Definir reglas de semántica operacional.
e) Propiedades (Determinismo, Preservación, Progreso).

**Explicación**
Extensión básica de productos.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_extension_pares]]

### Ejercicio 21 — Extension Sumas (Uniones Disjuntas)
**Enunciado**
Extensión con *uniones disjuntas* (co-productos):
$\tau ::= \dots \mid \tau + \tau$
$M ::= \dots \mid \text{left}_\tau(M) \mid \text{right}_\tau(M) \mid \text{case } M \text{ of left}(x) \leadsto M_1 \parallel \text{right}(y) \leadsto M_2$
a) Definir reglas de tipado.
b) Exhibir habitantes (Inyecciones, Análisis de casos, Conmutatividad, Asociatividad, Distributividad, Ley de los exponentes).
c) Valores, d) Semántica, e) Propiedades.

**Explicación**
Extensión de sumas, análogo a `Either` en Haskell.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_extension_sumas]]

### Ejercicio 22 — Extension Listas
**Enunciado**
Extensión con *listas*:
$\tau ::= \dots \mid [\tau]$
$M ::= \dots \mid []_\tau \mid M :: N \mid \text{case } M \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} \mid \text{foldr } M \text{ base } \leadsto N; \text{rec}(h, r) \leadsto O$
a) Árbol sintáctico. b) Reglas de tipado. c) Juicio de tipado. d) Valores. e) Reglas de reducción.

**Explicación**
Implementación de listas con un operador de recursión estructural `foldr` integrado.

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_extension_listas]]

### Ejercicio 27 — Extension Deques (Colas bidireccionales)
**Enunciado**
Extender con *colas bidireccionales* (`deque`):
$\tau ::= \dots \mid \text{Cola}_\tau$
$M ::= \dots \mid \langle \rangle_\tau \mid M \bullet M \mid \text{próximo}(M) \mid \text{desencolar}(M) \mid \text{case } M \text{ of } \langle \rangle \leadsto M_2; c \bullet x \leadsto M_3$
1. Reglas de tipado. 2. Valores y reducción. 3. Ejemplo de reducción. 4. Macro $\text{último}_\tau$.

**Explicación**
Extensión avanzada que suele aparecer en parciales recientes (ej: 2024, 2025).

**Resolución paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_extension_deques]]
