---
nombre: Unificación e Inferencia de Tipos — Guia de Ejercicios
parcial: 2P
programa: 2C_2026
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
| [Ej. 8](#ejercicio-8-—-extensión-pares) | Algoritmo de inferencia para productos (pares) | 🔴 Si |
| [Ej. 9](#ejercicio-9-—-extensión-sumas) | Algoritmo de inferencia para co-productos (sumas) | 🔴 Si |
| [Ej. 10](#ejercicio-10-—-extensión-listas) | Algoritmo de inferencia para listas y foldr | 🔴 Si |

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
Hay **tres gramáticas** distintas en juego y toda expresión válida pertenece a exactamente una de ellas:

- **Tipos:** $\sigma, \tau ::= \text{Bool} \mid \text{Nat} \mid X_i \mid \sigma \to \tau$
- **Términos anotados ($M$):** $M ::= x \mid \lambda x : \sigma . M \mid M\,M \mid \text{True} \mid \text{False} \mid \text{if } M \text{ then } M \text{ else } M \mid \text{zero} \mid \text{succ}(M) \mid \text{pred}(M) \mid \text{isZero}(M)$
- **Términos sin anotar ($U$):** idéntica a la anterior salvo la abstracción, que es $\lambda x . U$ (sin `:` ni tipo).

$\text{erase}$ **no es un constructor** de ninguna de las tres: es una función del metalenguaje
$$\text{erase} : \{\text{términos anotados}\} \to \{\text{términos sin anotar}\}$$
definida recursivamente por $\text{erase}(\lambda x : \sigma . M) = \lambda x . \text{erase}(M)$, $\text{erase}(M\,N) = \text{erase}(M)\,\text{erase}(N)$, $\text{erase}(x) = x$, etc.

| # | Expresión | ¿Válida? | ¿A qué gramática pertenece? |
|---|---|---|---|
| I | $\lambda x : \text{Bool} . \text{succ}(x)$ | ✅ | Término **anotado** |
| II | $\lambda x . \text{isZero}(x)$ | ✅ | Término **sin anotaciones** |
| III | $X_1 \to \sigma$ | ✅ | **Tipo** |
| IV | $\text{erase}(f\,y)$ | ✅ | Metalenguaje; su **resultado** es un término sin anotaciones |
| V | $X_1$ | ✅ | **Tipo** (incógnita de tipo) |
| VI | $X_1 \to (\text{Bool} \to X_2)$ | ✅ | **Tipo** |
| VII | $\lambda x : X_1 \to X_2 . \text{if zero then True else zero succ}(\text{True})$ | ✅ (sintaxis) | Término **anotado** — pero **no tipable** |
| VIII | $\text{erase}(\lambda f : \text{Bool} \to \text{Bool} . \lambda y : \text{Bool} . f\,y)$ | ✅ | Metalenguaje; su resultado es un término sin anotaciones |

**Comentarios ítem por ítem**

- **I.** La abstracción lleva anotación ($x : \text{Bool}$) ⟹ gramática anotada. Es sintácticamente correcta pero **no tipable**: $\text{succ}$ exige $\text{Nat}$ y $x : \text{Bool}$ ⟹ clash $\text{Bool} \doteq \text{Nat}$. *Sintaxis y tipado son chequeos independientes.*
- **II.** La abstracción no lleva anotación ⟹ gramática sin anotar. Es exactamente el input del algoritmo $\mathcal{I}$; su tipo principal es $\text{Nat} \to \text{Bool}$.
- **III.** $X_1$ es una incógnita de tipo y $\sigma$ una metavariable de tipo; el constructor $\to$ los combina ⟹ es un tipo. Recordar que $\to$ asocia a **derecha**.
- **IV.** $f\,y$ es una aplicación de dos variables; las variables y la aplicación pertenecen a **ambas** gramáticas de términos, así que $f\,y$ es un término anotado legítimo (uno que no tiene ninguna anotación que borrar). Luego $\text{erase}(f\,y) = f\,y$, que es un término sin anotaciones. ⚠️ Verificar — algunas resoluciones la consideran inválida argumentando que $\text{erase}$ sólo debe aplicarse a términos "genuinamente anotados"; con la definición estándar de $\text{erase}$ sobre toda la gramática anotada, la expresión es válida y es la identidad sobre $f\,y$.
- **V.** Una incógnita sola ya es un tipo (caso base de la gramática de tipos). No es un término.
- **VI.** Tipo. Notar que los paréntesis son redundantes: $X_1 \to (\text{Bool} \to X_2) = X_1 \to \text{Bool} \to X_2$.
- **VII.** Sintácticamente válida: la anotación $X_1 \to X_2$ es un tipo, y $\text{zero succ}(\text{True})$ parsea como la aplicación $\text{zero}\,(\text{succ}(\text{True}))$ (la aplicación asocia a izquierda y tiene mayor precedencia que el `if`). **No es tipable** por tres motivos simultáneos: la guarda $\text{zero} : \text{Nat} \neq \text{Bool}$; $\text{succ}(\text{True})$ exige $\text{Bool} \doteq \text{Nat}$; y $\text{zero}$ se usa como función ($\text{Nat} \doteq \tau \to \sigma$, clash).
- **VIII.** $\text{erase}$ aplicado a un término anotado bien formado. Resultado: $\lambda f . \lambda y . f\,y$, término sin anotaciones cuyo tipo principal es $(X_1 \to X_2) \to X_1 \to X_2$ (más general que el $(\text{Bool}\to\text{Bool}) \to \text{Bool} \to \text{Bool}$ del original: **borrar anotaciones generaliza**).

**Chuleta**
> 1. ¿Hay `:` después de un $\lambda$? → término **anotado**. → 2. ¿Hay $\lambda$ sin `:`? → término **sin anotar**. → 3. ¿Sólo aparecen $\text{Bool}$, $\text{Nat}$, $X_i$ y $\to$? → es un **tipo**. → 4. $\text{erase}(\cdot)$ es metalenguaje: come anotado, devuelve sin anotar. → 5. **Sintaxis $\neq$ tipado**: $\lambda x{:}\text{Bool}.\text{succ}(x)$ es válida y no tipable. → 6. Precedencias: aplicación a izquierda y más fuerte que $\lambda$/`if`; $\to$ a derecha.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 2 — Sustituciones
**Enunciado**
Determinar el resultado de aplicar la sustitución $S$ a las siguientes expresiones:
I. $S = \{X_1 := \text{Nat}\}$, $S(\{x : X_1 \to \text{Bool}\})$
II. $S = \{X_1 := X_2 \to X_3, X_4 := \text{Bool}\}$, $S(\{x : X_4 \to \text{Bool}\}) \vdash S(\lambda x : X_1 \to \text{Bool} . x) : S(\text{Nat} \to X_2)$

**Explicación**
Práctica de aplicación de sustituciones sobre contextos de tipado y términos.

**Resolución paso a paso**
Una sustitución $S = \{X_{i_1} := \tau_1, \dots, X_{i_n} := \tau_n\}$ se aplica **simultáneamente** (no en cascada) y de forma **homomórfica**: baja por la estructura de tipos, términos y contextos reemplazando sólo incógnitas de tipo. Nunca toca variables de término.

$$S(\text{Bool}) = \text{Bool} \qquad S(\sigma \to \tau) = S(\sigma) \to S(\tau) \qquad S(X_i) = \begin{cases} \tau_i & \text{si } (X_i := \tau_i) \in S \\ X_i & \text{si no} \end{cases}$$
$$S(\{x_1 : \sigma_1, \dots\}) = \{x_1 : S(\sigma_1), \dots\} \qquad S(\lambda x : \sigma . M) = \lambda x : S(\sigma) . S(M)$$

**I.** $S = \{X_1 := \text{Nat}\}$

$$S(\{x : X_1 \to \text{Bool}\}) = \{x : S(X_1 \to \text{Bool})\} = \{x : S(X_1) \to S(\text{Bool})\} = \boxed{\{x : \text{Nat} \to \text{Bool}\}}$$

**II.** $S = \{X_1 := X_2 \to X_3,\; X_4 := \text{Bool}\}$

Se aplica $S$ a las tres componentes del juicio por separado:

1. **Contexto:** $S(\{x : X_4 \to \text{Bool}\}) = \{x : S(X_4) \to \text{Bool}\} = \{x : \text{Bool} \to \text{Bool}\}$
2. **Término:** $S(\lambda x : X_1 \to \text{Bool} . x) = \lambda x : S(X_1) \to \text{Bool} . x = \lambda x : (X_2 \to X_3) \to \text{Bool} . x$
   *(la variable de término $x$ queda intacta; sólo cambia la anotación)*
3. **Tipo:** $S(\text{Nat} \to X_2) = \text{Nat} \to X_2$ — **sin cambios**, porque $X_2 \notin dom(S) = \{X_1, X_4\}$. Esto ilustra que la sustitución es simultánea: el $X_2$ que aparece en la imagen de $X_1$ **no** se vuelve a sustituir.

Juicio resultante:
$$\{x : \text{Bool} \to \text{Bool}\} \vdash \lambda x : (X_2 \to X_3) \to \text{Bool} . x : \text{Nat} \to X_2$$

**Observación importante.** Este juicio **no es derivable**: por t-abs, $\lambda x : (X_2\to X_3)\to\text{Bool}.x$ sólo puede tener el tipo $((X_2\to X_3)\to\text{Bool}) \to ((X_2\to X_3)\to\text{Bool})$, que no unifica con $\text{Nat} \to X_2$ (clash $\text{Nat}$ vs $\to$). Como las sustituciones **preservan derivabilidad** (si $\Gamma \vdash M : \tau$ es derivable entonces $S(\Gamma) \vdash S(M) : S(\tau)$ también lo es), el juicio original tampoco era derivable. Notar además la inconsistencia del enunciado original: el contexto liga $x$ con tipo $X_4 \to \text{Bool}$ mientras la abstracción lo re-liga con $X_1 \to \text{Bool}$ — la ligadura interna es la que manda.

**Chuleta**
> 1. $S$ se aplica **simultáneamente**, nunca en cascada (no re-sustituir dentro de las imágenes). → 2. Bajar homomórficamente: $S(\sigma\to\tau) = S(\sigma)\to S(\tau)$. → 3. Sobre un **juicio** hay que aplicarla a las **tres** partes: contexto, anotaciones del término y tipo. → 4. Incógnita fuera de $dom(S)$ → queda igual. → 5. Variables de término **jamás** se tocan. → 6. Propiedad clave: $\Gamma\vdash M:\tau$ derivable $\Rightarrow$ $S(\Gamma)\vdash S(M):S(\tau)$ derivable.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 3 — Unificación
**Enunciado**
Unir con flechas los tipos que unifican entre sí (entre una fila y la otra). Para cada par unificable, exhibir el $mgu$ ("most general unifier").

Fila 1: $X_1 \to X_2$ | $\text{Nat}$ | $X_2 \to \text{Bool}$ | $X_3 \to X_4 \to X_5$
Fila 2: $X_1$ | $\text{Nat} \to \text{Bool}$ | $(\text{Nat} \to X_2) \to \text{Bool}$ | $\text{Nat} \to X_2 \to \text{Bool}$

**Explicación**
El algoritmo de unificación es el corazón de la inferencia. Se basa en encontrar una sustitución que haga idénticas dos expresiones de tipos.

**Resolución paso a paso**
Escribimos $\doteq$ para las **ecuaciones a unificar** (para no confundirlas con la igualdad sintáctica). Se aplican las reglas de Martelli-Montanari: *delete, decompose, swap, elim, clash, occurs-check*. **Las incógnitas se comparten entre ambas filas** (el $X_1$ de la fila 1 es el mismo $X_1$ de la fila 2, y el $X_2$ de la fila 1 es el mismo $X_2$ de la fila 3 de abajo): ése es justamente el motivo por el que varios pares fallan por *occurs-check*.

**Matriz de resultados** (filas = fila 1, columnas = fila 2)

| $\downarrow$ vs $\rightarrow$ | $X_1$ | $\text{Nat} \to \text{Bool}$ | $(\text{Nat} \to X_2) \to \text{Bool}$ | $\text{Nat} \to X_2 \to \text{Bool}$ |
|---|---|---|---|---|
| $X_1 \to X_2$ | ✗ occurs-check | ✅ | ✅ | ✗ occurs-check |
| $\text{Nat}$ | ✅ | ✗ clash | ✗ clash | ✗ clash |
| $X_2 \to \text{Bool}$ | ✅ | ✅ | ✗ occurs-check | ✗ clash |
| $X_3 \to X_4 \to X_5$ | ✅ | ✗ clash | ✗ clash | ✅ |

**Los 7 pares que unifican, con su $mgu$**

1. $X_1 \to X_2 \;\doteq\; \text{Nat} \to \text{Bool}$
   *decompose* → $\{X_1 \doteq \text{Nat},\; X_2 \doteq \text{Bool}\}$ → *elim* ×2.
   $$mgu = \{X_1 := \text{Nat},\; X_2 := \text{Bool}\} \qquad \text{instancia común: } \text{Nat} \to \text{Bool}$$

2. $X_1 \to X_2 \;\doteq\; (\text{Nat} \to X_2) \to \text{Bool}$ — *(corrida completa, modelo para el resto)*
   - $E_0 = \{X_1 \to X_2 \doteq (\text{Nat}\to X_2) \to \text{Bool}\}$, $S = id$
   - **decompose**: $E_1 = \{X_1 \doteq \text{Nat} \to X_2,\; X_2 \doteq \text{Bool}\}$
   - **elim** ($X_1 \notin fv(\text{Nat}\to X_2)$ ✓): $E_2 = \{X_2 \doteq \text{Bool}\}$, $S = \{X_1 := \text{Nat} \to X_2\}$
   - **elim** ($X_2 \notin fv(\text{Bool})$ ✓): $E_3 = \emptyset$, $S = \{X_2 := \text{Bool}\} \circ \{X_1 := \text{Nat}\to X_2\}$
   $$mgu = \{X_1 := \text{Nat} \to \text{Bool},\; X_2 := \text{Bool}\} \qquad \text{instancia común: } (\text{Nat}\to\text{Bool}) \to \text{Bool}$$
   *(Ojo con el orden: al componer hay que aplicar la sustitución nueva a las imágenes de la vieja.)*

3. $\text{Nat} \;\doteq\; X_1$ → *swap* → $X_1 \doteq \text{Nat}$ → *elim*.
   $$mgu = \{X_1 := \text{Nat}\} \qquad \text{instancia común: } \text{Nat}$$

4. $X_2 \to \text{Bool} \;\doteq\; X_1$ → *swap* → $X_1 \doteq X_2 \to \text{Bool}$; $X_1 \notin fv(X_2 \to \text{Bool})$ ✓ → *elim*.
   $$mgu = \{X_1 := X_2 \to \text{Bool}\} \qquad \text{instancia común: } X_2 \to \text{Bool}$$

5. $X_2 \to \text{Bool} \;\doteq\; \text{Nat} \to \text{Bool}$ → *decompose* → $\{X_2 \doteq \text{Nat},\; \text{Bool} \doteq \text{Bool}\}$ → *delete* + *elim*.
   $$mgu = \{X_2 := \text{Nat}\} \qquad \text{instancia común: } \text{Nat} \to \text{Bool}$$

6. $X_3 \to X_4 \to X_5 \;\doteq\; X_1$ → *swap* → *elim*.
   $$mgu = \{X_1 := X_3 \to X_4 \to X_5\} \qquad \text{instancia común: } X_3 \to X_4 \to X_5$$

7. $X_3 \to (X_4 \to X_5) \;\doteq\; \text{Nat} \to (X_2 \to \text{Bool})$
   *decompose* → $\{X_3 \doteq \text{Nat},\; X_4 \to X_5 \doteq X_2 \to \text{Bool}\}$ → *decompose* → $\{X_3 \doteq \text{Nat}, X_4 \doteq X_2, X_5 \doteq \text{Bool}\}$ → *elim* ×3.
   $$mgu = \{X_3 := \text{Nat},\; X_4 := X_2,\; X_5 := \text{Bool}\} \qquad \text{instancia común: } \text{Nat} \to X_2 \to \text{Bool}$$

**Los 9 pares que fallan, con el motivo exacto**

| Par | Paso que falla | Motivo |
|---|---|---|
| $X_1 \to X_2 \doteq X_1$ | *swap* + occurs-check | $X_1 \in fv(X_1 \to X_2)$ — daría el "tipo" infinito $((\dots \to X_2) \to X_2)$ |
| $X_1 \to X_2 \doteq \text{Nat} \to X_2 \to \text{Bool}$ | decompose → $X_2 \doteq X_2 \to \text{Bool}$ | occurs-check: $X_2 \in fv(X_2 \to \text{Bool})$ |
| $\text{Nat} \doteq \text{Nat} \to \text{Bool}$ | clash | constructor $\text{Nat}$ vs constructor $\to$ |
| $\text{Nat} \doteq (\text{Nat}\to X_2)\to\text{Bool}$ | clash | ídem |
| $\text{Nat} \doteq \text{Nat} \to X_2 \to \text{Bool}$ | clash | ídem |
| $X_2 \to \text{Bool} \doteq (\text{Nat}\to X_2)\to\text{Bool}$ | decompose → $X_2 \doteq \text{Nat} \to X_2$ | occurs-check |
| $X_2 \to \text{Bool} \doteq \text{Nat} \to X_2 \to \text{Bool}$ | decompose → $\{X_2 \doteq \text{Nat},\, \text{Bool} \doteq X_2 \to \text{Bool}\}$; elim $X_2 := \text{Nat}$ → $\text{Bool} \doteq \text{Nat} \to \text{Bool}$ | clash $\text{Bool}$ vs $\to$ |
| $X_3 \to X_4 \to X_5 \doteq \text{Nat} \to \text{Bool}$ | decompose → $X_4 \to X_5 \doteq \text{Bool}$ | clash $\to$ vs $\text{Bool}$ |
| $X_3 \to X_4 \to X_5 \doteq (\text{Nat}\to X_2)\to\text{Bool}$ | decompose → $X_4 \to X_5 \doteq \text{Bool}$ | clash $\to$ vs $\text{Bool}$ |

⚠️ Verificar — el ejercicio no aclara si las incógnitas de la fila 1 y la fila 2 son las mismas o pertenecen a "universos" distintos. Acá se toman como **compartidas** (lectura estándar, y la única que hace aparecer el occurs-check, que es el punto pedagógico del ejercicio). Si se renombraran aparte, $X_1 \to X_2$ sí unificaría con $X_1'$ vía $\{X_1' := X_1 \to X_2\}$, y $X_2 \to \text{Bool}$ con $(\text{Nat}\to X_2')\to\text{Bool}$ vía $\{X_2 := \text{Nat} \to X_2'\}$.

**Chuleta**
> 1. Armar $E$ con la única ecuación $\tau \doteq \sigma$. → 2. Mirar los constructores de cabeza: distintos ⟹ **clash** (fin); iguales ⟹ **decompose**. → 3. Ecuación $\tau \doteq X$ con $\tau$ no-incógnita ⟹ **swap**. → 4. $X \doteq X$ ⟹ **delete**. → 5. $X \doteq \tau$: si $X \in fv(\tau)$ ⟹ **occurs-check, falla**; si no ⟹ **elim** (sustituir en todo $E$ y **acumular** en $S$, componiendo a izquierda). → 6. $E = \emptyset$ ⟹ $S$ es el $mgu$; verificar aplicándolo a ambos lados: deben quedar idénticos.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

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
**Receta única para los 7 ítems:** (1) rectificar y anotar con incógnitas frescas ⟹ $\Gamma_0, M_0$; (2) generar $E$ con las reglas de $\mathcal{I}$; (3) unificar; (4) si hay $mgu$ $S$, el juicio principal es $S(\Gamma_0) \vdash S(M_0) : S(\tau)$; si no, **no tipable**.

Reglas usadas: $\mathcal{I}(\Gamma \mid M_1 M_2) = (X_{fresca} \mid E_1 \cup E_2 \cup \{\tau_1 \doteq \tau_2 \to X_{fresca}\})$, $\mathcal{I}(\Gamma \mid \text{if } M_1 \text{ then } M_2 \text{ else } M_3) = (\tau_2 \mid E_1\cup E_2\cup E_3 \cup \{\tau_1 \doteq \text{Bool},\; \tau_2 \doteq \tau_3\})$, $\mathcal{I}(\Gamma\mid\text{succ}(M)) = (\text{Nat}\mid E\cup\{\tau \doteq \text{Nat}\})$, $\mathcal{I}(\Gamma\mid\text{isZero}(M)) = (\text{Bool}\mid E\cup\{\tau \doteq \text{Nat}\})$.

---

**I. $\lambda z . \text{if } z \text{ then zero else succ}(\text{zero})$ — ✅ TIPABLE**

Anotación: $\lambda z : X_1 . \text{if } z \text{ then zero else succ}(\text{zero})$, con $\Gamma = \{z : X_1\}$.

| Subtérmino | Tipo | Ecuaciones aportadas |
|---|---|---|
| $z$ | $X_1$ | — |
| $\text{zero}$ | $\text{Nat}$ | — |
| $\text{succ}(\text{zero})$ | $\text{Nat}$ | $\text{Nat} \doteq \text{Nat}$ |
| `if` | $\text{Nat}$ | $X_1 \doteq \text{Bool}$, $\text{Nat} \doteq \text{Nat}$ |

$E = \{X_1 \doteq \text{Bool},\, \text{Nat}\doteq\text{Nat}\}$ → *delete* → *elim* → $S = \{X_1 := \text{Bool}\}$.
Tipo del $\lambda$: $X_1 \to \text{Nat}$. Aplicando $S$:
$$\emptyset \vdash \lambda z : \text{Bool} . \text{if } z \text{ then zero else succ}(\text{zero}) : \text{Bool} \to \text{Nat}$$

---

**II. $\lambda y . \text{succ}((\lambda x . x)\,y)$ — ✅ TIPABLE**

Anotación: $\lambda y : X_1 . \text{succ}((\lambda x : X_2 . x)\,y)$.

- $\mathcal{I}(\{y{:}X_1\} \mid \lambda x{:}X_2.x) = (X_2 \to X_2 \mid \emptyset)$
- Aplicación (con $X_3$ fresca): tipo $X_3$, ecuación $X_2 \to X_2 \doteq X_1 \to X_3$
- $\text{succ}$: ecuación $X_3 \doteq \text{Nat}$
- Tipo del $\lambda$ externo: $X_1 \to \text{Nat}$

$$E = \{\, X_2 \to X_2 \doteq X_1 \to X_3,\;\; X_3 \doteq \text{Nat} \,\}$$

Unificación: *decompose* → $\{X_2 \doteq X_1,\, X_2 \doteq X_3,\, X_3 \doteq \text{Nat}\}$ → *elim* $X_2 := X_1$ → $\{X_1 \doteq X_3,\, X_3 \doteq \text{Nat}\}$ → *elim* $X_1 := X_3$ → $\{X_3 \doteq \text{Nat}\}$ → *elim* $X_3 := \text{Nat}$.
$$S = \{X_1 := \text{Nat},\; X_2 := \text{Nat},\; X_3 := \text{Nat}\}$$
$$\emptyset \vdash \lambda y : \text{Nat} . \text{succ}((\lambda x : \text{Nat} . x)\,y) : \text{Nat} \to \text{Nat}$$

---

**III. $\lambda x . \text{if isZero}(x) \text{ then } x \text{ else } (\text{if } x \text{ then } x \text{ else } x)$ — ❌ NO TIPABLE**

Anotación: $\lambda x : X_1 . \dots$, $\Gamma = \{x : X_1\}$.

- $\text{isZero}(x)$: tipo $\text{Bool}$, ecuación $\boxed{X_1 \doteq \text{Nat}}$
- `if` interno: guarda $x$ ⟹ ecuación $\boxed{X_1 \doteq \text{Bool}}$; ramas $x$, $x$ ⟹ $X_1 \doteq X_1$; tipo $X_1$
- `if` externo: guarda $\text{Bool} \doteq \text{Bool}$; ramas $X_1 \doteq X_1$; tipo $X_1$

$$E = \{\, X_1 \doteq \text{Nat},\;\; X_1 \doteq \text{Bool},\;\; \text{Bool}\doteq\text{Bool},\;\; X_1 \doteq X_1 \,\}$$

*delete* las triviales; *elim* $X_1 := \text{Nat}$ deja $\{\text{Nat} \doteq \text{Bool}\}$ ⟹ **CLASH**.
La misma variable $x$ se usa como $\text{Nat}$ (argumento de $\text{isZero}$) y como $\text{Bool}$ (guarda del `if` interno). No tipable.

---

**IV. $\lambda x . \lambda y . \text{if } x \text{ then } y \text{ else succ}(\text{zero})$ — ✅ TIPABLE**

$\Gamma = \{x : X_1, y : X_2\}$. Ecuaciones: $X_1 \doteq \text{Bool}$ (guarda) y $X_2 \doteq \text{Nat}$ (ramas: $\tau_{then} = X_2$, $\tau_{else} = \text{Nat}$).
Tipo del término antes de unificar: $X_1 \to X_2 \to X_2$ (el `if` tiene el tipo de la rama `then`).
$$S = \{X_1 := \text{Bool},\; X_2 := \text{Nat}\}$$
$$\emptyset \vdash \lambda x : \text{Bool} . \lambda y : \text{Nat} . \text{if } x \text{ then } y \text{ else succ}(\text{zero}) : \text{Bool} \to \text{Nat} \to \text{Nat}$$

---

**V. $\text{if True then } (\lambda x . \text{zero})\,\text{zero else } (\lambda x . \text{zero})\,\text{False}$ — ✅ TIPABLE**

**Clave:** las dos abstracciones son **ocurrencias distintas**, así que la anotación les da incógnitas **frescas y separadas** ($X_1$ y $X_3$). No hay ningún conflicto.

- Rama `then`: $\lambda x : X_1 . \text{zero}$ tiene tipo $X_1 \to \text{Nat}$; aplicada a $\text{zero}$ (con $X_2$ fresca) ⟹ $X_1 \to \text{Nat} \doteq \text{Nat} \to X_2$, tipo $X_2$
- Rama `else`: $\lambda x : X_3 . \text{zero}$ tiene tipo $X_3 \to \text{Nat}$; aplicada a $\text{False}$ (con $X_4$ fresca) ⟹ $X_3 \to \text{Nat} \doteq \text{Bool} \to X_4$, tipo $X_4$
- `if`: $\text{Bool} \doteq \text{Bool}$ y $X_2 \doteq X_4$; tipo $X_2$

$$E = \{\, X_1 \to \text{Nat} \doteq \text{Nat} \to X_2,\;\; X_3 \to \text{Nat} \doteq \text{Bool} \to X_4,\;\; \text{Bool}\doteq\text{Bool},\;\; X_2 \doteq X_4 \,\}$$

*decompose* ×2 → $\{X_1 \doteq \text{Nat},\, \text{Nat} \doteq X_2,\, X_3 \doteq \text{Bool},\, \text{Nat} \doteq X_4,\, X_2 \doteq X_4\}$ → *swap* + *elim*:
$$S = \{X_1 := \text{Nat},\; X_2 := \text{Nat},\; X_3 := \text{Bool},\; X_4 := \text{Nat}\}$$
$$\emptyset \vdash \text{if True then } (\lambda x{:}\text{Nat}.\text{zero})\,\text{zero else } (\lambda x{:}\text{Bool}.\text{zero})\,\text{False} : \text{Nat}$$

---

**VI. $(\lambda f . \text{if True then } f\,\text{zero else } f\,\text{False})\,(\lambda x . \text{zero})$ — ❌ NO TIPABLE**

Acá sí hay conflicto, porque es **una sola** variable $f : X_1$ usada en dos aplicaciones.

- $f\,\text{zero}$ ($X_2$ fresca): $\boxed{X_1 \doteq \text{Nat} \to X_2}$, tipo $X_2$
- $f\,\text{False}$ ($X_3$ fresca): $\boxed{X_1 \doteq \text{Bool} \to X_3}$, tipo $X_3$
- `if`: $\text{Bool}\doteq\text{Bool}$, $X_2 \doteq X_3$; tipo $X_2$
- $\lambda f$: tipo $X_1 \to X_2$; argumento $\lambda x : X_4 . \text{zero} : X_4 \to \text{Nat}$; aplicación ($X_5$ fresca): $X_1 \to X_2 \doteq (X_4 \to \text{Nat}) \to X_5$

Unificando: *elim* $X_1 := \text{Nat} \to X_2$ transforma la segunda en $\text{Nat} \to X_2 \doteq \text{Bool} \to X_3$; *decompose* deja $\text{Nat} \doteq \text{Bool}$ ⟹ **CLASH**.

**Moraleja:** el cálculo-$\lambda$ simplemente tipado es **monomórfico** — cada variable ligada tiene *un solo* tipo. Aunque el argumento $\lambda x.\text{zero}$ funcionaría para ambos usos (es "polimórfico" a ojo), el algoritmo unifica las restricciones de $f$ *antes* de mirar el argumento y falla. Con let-polimorfismo (Hindley-Milner) o System F sí tiparía.

---

**VII. $\lambda x . \lambda y . \lambda z . \text{if } z \text{ then } y \text{ else succ}(x)$ — ✅ TIPABLE**

$\Gamma = \{x : X_1, y : X_2, z : X_3\}$.
- $\text{succ}(x)$: $X_1 \doteq \text{Nat}$, tipo $\text{Nat}$
- `if`: $X_3 \doteq \text{Bool}$ (guarda), $X_2 \doteq \text{Nat}$ (ramas $y$ y $\text{succ}(x)$); tipo $X_2$

$$E = \{X_1 \doteq \text{Nat},\; X_3 \doteq \text{Bool},\; X_2 \doteq \text{Nat}\} \implies S = \{X_1 := \text{Nat}, X_2 := \text{Nat}, X_3 := \text{Bool}\}$$

Tipo antes de unificar: $X_1 \to X_2 \to X_3 \to X_2$.
$$\emptyset \vdash \lambda x{:}\text{Nat} . \lambda y{:}\text{Nat} . \lambda z{:}\text{Bool} . \text{if } z \text{ then } y \text{ else succ}(x) : \text{Nat} \to \text{Nat} \to \text{Bool} \to \text{Nat}$$

---

**Resumen**

| Ítem | ¿Tipable? | Tipo principal / motivo del fallo |
|---|---|---|
| I | ✅ | $\text{Bool} \to \text{Nat}$ |
| II | ✅ | $\text{Nat} \to \text{Nat}$ |
| III | ❌ | clash $\text{Nat} \doteq \text{Bool}$ ($x$ usada como $\text{Nat}$ y como $\text{Bool}$) |
| IV | ✅ | $\text{Bool} \to \text{Nat} \to \text{Nat}$ |
| V | ✅ | $\text{Nat}$ (dos $\lambda$ distintos ⟹ incógnitas frescas independientes) |
| VI | ❌ | clash $\text{Nat} \doteq \text{Bool}$ (monomorfismo: $f$ usada a dos tipos) |
| VII | ✅ | $\text{Nat} \to \text{Nat} \to \text{Bool} \to \text{Nat}$ |

**Chuleta**
> 1. **Rectificar** ($\alpha$-renombrar) y **anotar** cada $\lambda$ y cada variable libre con una incógnita **fresca**. → 2. Recorrer bottom-up generando $E$: aplicación ⟹ $\tau_1 \doteq \tau_2 \to X_{fresca}$; `if` ⟹ $\tau_{guarda} \doteq \text{Bool}$ y $\tau_{then} \doteq \tau_{else}$; $\text{succ}/\text{pred}$ ⟹ $\tau \doteq \text{Nat}$ (resultado $\text{Nat}$); $\text{isZero}$ ⟹ $\tau \doteq \text{Nat}$ (resultado $\text{Bool}$). → 3. Unificar $E$. → 4. $mgu$ existe ⟹ tipable con $S(\tau)$ en $S(\Gamma_0)$; **clash** u **occurs-check** ⟹ **no tipable**. → 5. Señal de no-tipable: la **misma** variable ligada forzada a $\text{Nat}$ y a $\text{Bool}$ (monomorfismo). → 6. Señal de tipable: dos $\lambda$ **distintos** ⟹ incógnitas independientes, no chocan.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

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
En cada ítem se muestra: **anotación** → **conjunto $E$** → **corrida de unificación** → **sustitución $S$** → **tipo principal**.

---

**(a) $\lambda x . \lambda y . \lambda z . z\,x\,y$ — ✅**

Anotación: $\lambda x{:}X_1 . \lambda y{:}X_2 . \lambda z{:}X_3 . z\,x\,y$. Recordar que $z\,x\,y = (z\,x)\,y$.

- $\mathcal{I}(\Gamma \mid z\,x) = (X_4 \mid \{X_3 \doteq X_1 \to X_4\})$
- $\mathcal{I}(\Gamma \mid (z\,x)\,y) = (X_5 \mid \{X_3 \doteq X_1 \to X_4,\; X_4 \doteq X_2 \to X_5\})$
- Tipo del término: $X_1 \to X_2 \to X_3 \to X_5$

$$E = \{\, X_3 \doteq X_1 \to X_4,\;\; X_4 \doteq X_2 \to X_5 \,\}$$

Unificación: *elim* $X_3 := X_1 \to X_4$ (ok, $X_3$ no ocurre) → $\{X_4 \doteq X_2 \to X_5\}$ → *elim* $X_4 := X_2 \to X_5$. Al componer, hay que propagar a la imagen anterior:
$$S = \{\, X_4 := X_2 \to X_5,\;\; X_3 := X_1 \to X_2 \to X_5 \,\}$$
$$\boxed{\;\emptyset \vdash \lambda x . \lambda y . \lambda z . z\,x\,y \;:\; X_1 \to X_2 \to (X_1 \to X_2 \to X_5) \to X_5\;}$$

---

**(b) $\lambda x . x\,(w\,(\lambda y . w\,y))$ — ❌ NO TIPABLE (occurs-check)**

$w$ es **libre** ⟹ va al contexto inicial: $\Gamma_0 = \{w : X_0\}$. Anotación: $\lambda x{:}X_1 . x\,(w\,(\lambda y{:}X_2 . w\,y))$.

- $\mathcal{I}(\Gamma \mid w\,y) = (X_3 \mid \{X_0 \doteq X_2 \to X_3\})$
- $\mathcal{I}(\Gamma \mid \lambda y{:}X_2 . w\,y) = (X_2 \to X_3 \mid \dots)$
- $\mathcal{I}(\Gamma \mid w\,(\lambda y . w\,y)) = (X_4 \mid \dots \cup \{X_0 \doteq (X_2 \to X_3) \to X_4\})$
- $\mathcal{I}(\Gamma \mid x\,(\dots)) = (X_5 \mid \dots \cup \{X_1 \doteq X_4 \to X_5\})$
- Tipo del término: $X_1 \to X_5$

$$E = \{\, X_0 \doteq X_2 \to X_3,\;\; X_0 \doteq (X_2 \to X_3) \to X_4,\;\; X_1 \doteq X_4 \to X_5 \,\}$$

Unificación:
1. *elim* $X_0 := X_2 \to X_3$ ⟹ $E = \{\, X_2 \to X_3 \doteq (X_2 \to X_3) \to X_4,\;\; X_1 \doteq X_4 \to X_5 \,\}$
2. *decompose* ⟹ $\{\, \boxed{X_2 \doteq X_2 \to X_3},\;\; X_3 \doteq X_4,\;\; X_1 \doteq X_4 \to X_5 \,\}$
3. $X_2 \in fv(X_2 \to X_3)$ ⟹ **OCCURS-CHECK: falla**

**Intuición:** $w$ se aplica a $y$ (⟹ $w : X_2 \to X_3$) y también a $\lambda y . w\,y$, cuyo tipo *contiene* el tipo de $w$. Haría falta un tipo recursivo $X_2 = X_2 \to X_3$, que no existe en el sistema simplemente tipado. **No tipable.**

---

**(c) $\lambda x . \lambda y . x\,y$ — ✅**

Anotación: $\lambda x{:}X_1 . \lambda y{:}X_2 . x\,y$. Aplicación ⟹ $X_3$ fresca.
$$E = \{\, X_1 \doteq X_2 \to X_3 \,\} \;\xrightarrow{\;elim\;}\; S = \{X_1 := X_2 \to X_3\}$$
Tipo antes de unificar: $X_1 \to X_2 \to X_3$.
$$\boxed{\;\emptyset \vdash \lambda x . \lambda y . x\,y \;:\; (X_2 \to X_3) \to X_2 \to X_3\;}$$
*(el $\eta$-expandido de la identidad sobre funciones)*

---

**(d) $\lambda x . \lambda y . y\,x$ — ✅**

Anotación: $\lambda x{:}X_1 . \lambda y{:}X_2 . y\,x$. Ahora la función es $y$ y el argumento es $x$.
$$E = \{\, X_2 \doteq X_1 \to X_3 \,\} \;\xrightarrow{\;elim\;}\; S = \{X_2 := X_1 \to X_3\}$$
$$\boxed{\;\emptyset \vdash \lambda x . \lambda y . y\,x \;:\; X_1 \to (X_1 \to X_3) \to X_3\;}$$
*(el combinador "flip apply" / aplicación reversa)*

---

**(e) $\lambda x . (\lambda x . x)$ — ✅**

**Paso previo obligatorio: rectificación.** Hay dos ligaduras del mismo nombre $x$, así que se $\alpha$-renombra la interna:
$$\lambda x . (\lambda x . x) \;=_\alpha\; \lambda x . (\lambda x' . x')$$
Anotación: $\lambda x{:}X_1 . (\lambda x'{:}X_2 . x')$.
$$E = \emptyset \implies S = id$$
$$\boxed{\;\emptyset \vdash \lambda x . (\lambda x . x) \;:\; X_1 \to X_2 \to X_2\;}$$
Sin rectificar, uno podría erróneamente forzar $X_1 \doteq X_2$; el cuerpo interno se refiere a la ligadura **más cercana**, que es independiente de la externa.

---

**(f) $\lambda x . (\lambda y . y)\,x$ — ✅**

Anotación: $\lambda x{:}X_1 . (\lambda y{:}X_2 . y)\,x$. $\lambda y{:}X_2.y$ tiene tipo $X_2 \to X_2$; aplicación con $X_3$ fresca.
$$E = \{\, X_2 \to X_2 \doteq X_1 \to X_3 \,\}$$
*decompose* → $\{X_2 \doteq X_1,\; X_2 \doteq X_3\}$ → *elim* $X_2 := X_1$ → $\{X_1 \doteq X_3\}$ → *elim* $X_1 := X_3$.
$$S = \{\, X_1 := X_3,\;\; X_2 := X_3 \,\}$$
Tipo antes de unificar: $X_1 \to X_3$.
$$\boxed{\;\emptyset \vdash \lambda x . (\lambda y . y)\,x \;:\; X_3 \to X_3\;}$$
Coherente con **preservación de tipos**: el término $\beta$-reduce a $\lambda x . x$, cuyo tipo principal es también $X \to X$.

---

**(g) $(\lambda z . \lambda x . x\,(z\,(\lambda y . z)))\,\text{True}$ — ❌ NO TIPABLE**

Anotación: $(\lambda z{:}X_1 . \lambda x{:}X_2 . x\,(z\,(\lambda y{:}X_3 . z)))\,\text{True}$.

- $\mathcal{I}(\Gamma \mid \lambda y{:}X_3 . z) = (X_3 \to X_1 \mid \emptyset)$
- $\mathcal{I}(\Gamma \mid z\,(\lambda y . z)) = (X_4 \mid \{\, X_1 \doteq (X_3 \to X_1) \to X_4 \,\})$
- $\mathcal{I}(\Gamma \mid x\,(\dots)) = (X_5 \mid \dots \cup \{X_2 \doteq X_4 \to X_5\})$
- $\lambda x$: $X_2 \to X_5$; $\lambda z$: $X_1 \to X_2 \to X_5$
- Aplicación a $\text{True}$ ($X_6$ fresca): $X_1 \to X_2 \to X_5 \doteq \text{Bool} \to X_6$

$$E = \{\, \boxed{X_1 \doteq (X_3 \to X_1) \to X_4},\;\; X_2 \doteq X_4 \to X_5,\;\; X_1 \to X_2 \to X_5 \doteq \text{Bool} \to X_6 \,\}$$

**Falla por partida doble:**
- La primera ecuación tiene $X_1 \in fv((X_3 \to X_1) \to X_4)$ ⟹ **OCCURS-CHECK**. Ya el cuerpo $\lambda z . \lambda x . x\,(z\,(\lambda y.z))$ es no tipable por sí solo: $z$ se aplica a un término que menciona a $z$.
- Aun ignorando eso, la tercera ecuación fuerza $X_1 \doteq \text{Bool}$ (*decompose*), y entonces la primera queda $\text{Bool} \doteq (X_3 \to \text{Bool}) \to X_4$ ⟹ **CLASH** ($\text{Bool}$ vs $\to$): $z$ no puede ser a la vez un booleano y una función.

**No tipable**, se elija el orden de reducción de ecuaciones que se elija (el $mgu$ es único salvo renombre, así que el orden no cambia el resultado).

---

**Resumen**

| Término | ¿Tipable? | Tipo principal / falla |
|---|---|---|
| $\lambda x . \lambda y . \lambda z . z\,x\,y$ | ✅ | $X_1 \to X_2 \to (X_1 \to X_2 \to X_5) \to X_5$ |
| $\lambda x . x\,(w\,(\lambda y . w\,y))$ | ❌ | occurs-check $X_2 \doteq X_2 \to X_3$ |
| $\lambda x . \lambda y . x\,y$ | ✅ | $(X_2 \to X_3) \to X_2 \to X_3$ |
| $\lambda x . \lambda y . y\,x$ | ✅ | $X_1 \to (X_1 \to X_3) \to X_3$ |
| $\lambda x . (\lambda x . x)$ | ✅ | $X_1 \to X_2 \to X_2$ (¡rectificar!) |
| $\lambda x . (\lambda y . y)\,x$ | ✅ | $X_3 \to X_3$ |
| $(\lambda z . \lambda x . x\,(z\,(\lambda y . z)))\,\text{True}$ | ❌ | occurs-check + clash $\text{Bool}$ vs $\to$ |

**Chuleta**
> 1. **Rectificar** primero (ítem (e): $\lambda x.(\lambda x.x) \to \lambda x.(\lambda x'.x')$) y mandar las **variables libres** al $\Gamma_0$ con incógnita fresca (ítem (b): $w : X_0$). → 2. Anotar cada $\lambda$ con incógnita fresca. → 3. Una ecuación **por cada aplicación**: $\tau_{fun} \doteq \tau_{arg} \to X_{fresca}$, y el tipo de la aplicación es $X_{fresca}$. → 4. El tipo del término es $X_{\lambda_1} \to \dots \to X_{\lambda_n} \to \tau_{cuerpo}$ **antes** de sustituir. → 5. Unificar y aplicar $S$ al tipo **y** al contexto. → 6. Alarma de occurs-check: una variable aplicada a algo que la menciona ($w\,(\lambda y . w\,y)$, $z\,(\lambda y . z)$) ⟹ tipo infinito ⟹ **no tipable**. → 7. Chequeo de sanidad: $\beta$-reducir y ver que el tipo coincide (preservación).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

### Ejercicio 6 — Numerales de Church
**Enunciado**
Indicar tipos $\sigma$ y $\tau$ apropiados de modo que los términos de la forma $\lambda y : \sigma . \lambda x : \tau . y^n(x)$ resulten tipables para todo $n$ natural. El par $(\sigma, \tau)$ debe ser el mismo para todos los términos. Observar si tienen todos el mismo tipo.

Notación: $M^0(N) = N$, $M^{n+1}(N) = M(M^n(N))$.

*Sugerencia:* empezar haciendo inferencia para $n = 2$ — es decir, calcular el juicio de tipado más general para $\lambda y . \lambda x . y\,(y\,x)$ — y generalizar el resultado.

**Explicación**
Los términos $\overline{n} = \lambda y . \lambda x . y^n(x)$ son los **numerales de Church**: codifican el natural $n$ como "aplicar $n$ veces la función $y$ al valor $x$". El ejercicio pide encontrar el par de anotaciones $(\sigma, \tau)$ que sirve **uniformemente** para todos ellos, y observar la tensión entre "todos tipan con el mismo par" y "el tipo principal de cada uno es distinto" — que es la puerta de entrada al monomorfismo del cálculo simplemente tipado.

**Resolución paso a paso**
**Paso 1 — Inferencia para $n = 2$: $\lambda y . \lambda x . y\,(y\,x)$**

Anotación con incógnitas frescas: $\lambda y{:}X_1 . \lambda x{:}X_2 . y\,(y\,x)$, con $\Gamma = \{y : X_1,\, x : X_2\}$.

| Subtérmino | Tipo | Ecuación aportada |
|---|---|---|
| $y$ | $X_1$ | — |
| $x$ | $X_2$ | — |
| $y\,x$ ($X_3$ fresca) | $X_3$ | $X_1 \doteq X_2 \to X_3$ |
| $y\,(y\,x)$ ($X_4$ fresca) | $X_4$ | $X_1 \doteq X_3 \to X_4$ |

Tipo del término **antes** de unificar: $X_1 \to X_2 \to X_4$.

$$E = \{\; X_1 \doteq X_2 \to X_3,\;\; X_1 \doteq X_3 \to X_4 \;\}$$

*Unificación paso a paso:*

| Paso | Regla | $E$ | $S$ acumulada |
|---|---|---|---|
| 0 | — | $\{X_1 \doteq X_2 \to X_3,\; X_1 \doteq X_3 \to X_4\}$ | $id$ |
| 1 | *elim* $X_1 := X_2 \to X_3$ ($X_1 \notin fv$ ✓) | $\{X_2 \to X_3 \doteq X_3 \to X_4\}$ | $\{X_1 := X_2 \to X_3\}$ |
| 2 | *decompose* | $\{X_2 \doteq X_3,\; X_3 \doteq X_4\}$ | ídem |
| 3 | *elim* $X_2 := X_3$ | $\{X_3 \doteq X_4\}$ | $+\{X_2 := X_3\}$ |
| 4 | *elim* $X_3 := X_4$ (propagar a las imágenes) | $\emptyset$ | $\{X_1 := X_4 \to X_4,\; X_2 := X_4,\; X_3 := X_4\}$ |

**Las tres incógnitas colapsan en una sola.** Aplicando $S$ al tipo $X_1 \to X_2 \to X_4$:

$$\boxed{\;\emptyset \vdash \lambda y{:}X_4 \to X_4 . \lambda x{:}X_4 . y\,(y\,x) \;:\; (X_4 \to X_4) \to X_4 \to X_4\;}$$

**Paso 2 — Lectura del resultado y respuesta**

Escribiendo $X$ por $X_4$, el par pedido es

$$\boxed{\;\sigma = X \to X \qquad \tau = X\;}$$

y con él **todos** los términos $\lambda y{:}X\to X . \lambda x{:}X . y^n(x)$ tipan, con el **mismo** tipo

$$\overline{n} \;:\; (X \to X) \to X \to X$$

**Por qué el par funciona (demostración por inducción en $n$).** Sea $\Gamma = \{y : X \to X,\; x : X\}$. Afirmamos que $\Gamma \vdash y^n(x) : X$ para todo $n$:

- **Caso base ($n = 0$):** $y^0(x) = x$ y $\Gamma \vdash x : X$ por **t-var**. ✓
- **Paso inductivo:** supongamos $\Gamma \vdash y^n(x) : X$ (HI). Entonces $y^{n+1}(x) = y\,(y^n(x))$ y por **t-app** con $\Gamma \vdash y : X \to X$ (t-var) y la HI, obtenemos $\Gamma \vdash y\,(y^n(x)) : X$. ✓

Aplicando **t-abs** dos veces: $\emptyset \vdash \lambda y{:}X\to X . \lambda x{:}X . y^n(x) : (X\to X) \to X \to X$ para todo $n$. $\blacksquare$

Intuitivamente: $\sigma$ tiene que ser un tipo **funcional que se pueda componer consigo mismo** (dominio $=$ codominio, o sea $X \to X$), porque $y$ se aplica al resultado de $y$; y $\tau$ debe ser el dominio de $y$, o sea $X$.

**Paso 3 — ¿Tienen todos el mismo tipo?**

**Sí con el par fijo, no como tipo principal.** Corriendo $\mathcal{I}$ sobre los términos **sin anotar** $\lambda y . \lambda x . y^n(x)$:

| $n$ | Término sin anotar | $E$ | Tipo **principal** |
|---|---|---|---|
| $0$ | $\lambda y . \lambda x . x$ | $\emptyset$ | $X_1 \to X_2 \to X_2$ |
| $1$ | $\lambda y . \lambda x . y\,x$ | $\{X_1 \doteq X_2 \to X_3\}$ | $(X_2 \to X_3) \to X_2 \to X_3$ |
| $2$ | $\lambda y . \lambda x . y\,(y\,x)$ | $\{X_1 \doteq X_2 \to X_3,\, X_1 \doteq X_3 \to X_4\}$ | $(X_4 \to X_4) \to X_4 \to X_4$ |
| $3$ | $\lambda y . \lambda x . y\,(y\,(y\,x))$ | $\{X_1 \doteq X_2\to X_3,\, X_1 \doteq X_3\to X_4,\, X_1 \doteq X_4\to X_5\}$ | $(X_5 \to X_5) \to X_5 \to X_5$ |
| $\ge 2$ | — | — | $(X \to X) \to X \to X$ |

- Para $n = 0$ el tipo principal es $\sigma \to \tau \to \tau$ con $\sigma$ y $\tau$ **completamente independientes**: $\overline{0}$ ni siquiera usa a $y$, así que nada obliga a que $y$ sea una función de $X$ en $X$.
- Para $n = 1$ el tipo principal es $(\sigma \to \tau) \to \sigma \to \tau$: $y$ debe ser función, pero dominio y codominio todavía pueden diferir, porque $y$ se aplica **una sola vez**.
- A partir de $n = 2$ aparece la ecuación que iguala dominio y codominio ($X_2 \doteq X_3$ en el paso 2 de la corrida) y el tipo principal se estabiliza en $(X \to X) \to X \to X$ para **todo** $n \ge 2$.

Es decir: $(X\to X) \to X \to X$ es una **instancia** de los tipos principales de $\overline 0$ y $\overline 1$ (vía $\{X_1 := X\to X,\, X_2 := X\}$ y $\{X_2 := X,\, X_3 := X\}$ respectivamente), y es **exactamente** el tipo principal de todos los demás. Por eso el par $(\sigma, \tau) = (X \to X,\, X)$ sirve uniformemente: es el tipo común más general que todos admiten.

**Paso 4 — Consecuencia: monomorfismo**

El $X$ de $(X \to X) \to X \to X$ es una **incógnita libre**, no un $\forall X$: el sistema simplemente tipado **no tiene cuantificadores**. Concretamente:

- Cada uso de un numeral fija su $X$ de una vez: $\overline{2}$ aplicado a $\text{succ} : \text{Nat}\to\text{Nat}$ obliga $X := \text{Nat}$ y el término entero queda $(\text{Nat}\to\text{Nat})\to\text{Nat}\to\text{Nat}$.
- Si un mismo numeral (una misma **variable ligada**) se usa a dos instancias distintas de $X$ dentro del mismo término, la unificación choca — exactamente el fenómeno del **Ejercicio 4.VI** y del **Ejercicio 8.II**. Para eso hace falta let-polimorfismo (Hindley-Milner) o System F, donde el numeral recibe el esquema $\forall X . (X\to X)\to X\to X$.

**Complemento — aritmética sobre numerales.** Escribiendo $\text{Nat}_C \equiv (X\to X)\to X\to X$, las operaciones estándar tipan con el **mismo** $X$:

$$\text{succ} \;=\; \lambda n{:}\text{Nat}_C . \lambda s{:}X\to X . \lambda z{:}X .\; s\,(n\,s\,z) \;:\; \text{Nat}_C \to \text{Nat}_C$$
$$\text{suma} \;=\; \lambda m{:}\text{Nat}_C . \lambda n{:}\text{Nat}_C . \lambda s{:}X\to X . \lambda z{:}X .\; m\,s\,(n\,s\,z) \;:\; \text{Nat}_C \to \text{Nat}_C \to \text{Nat}_C$$

Chequeo rápido de $\text{succ}$: $n\,s : X \to X$, luego $n\,s\,z : X$, luego $s\,(n\,s\,z) : X$; abstrayendo $z$ y $s$ queda $(X\to X)\to X\to X = \text{Nat}_C$ ✓. Notar que ambas funciones son monomórficas en $X$: sirven para numerales de un $X$ fijo, no "para todo" $X$.

⚠️ Verificar — la consigna dice "observar si tienen todos el mismo tipo" sin aclarar si se refiere al tipo con el par $(\sigma,\tau)$ fijo o al tipo **principal** de cada término sin anotar. Acá se responden las dos lecturas: con el par fijo **sí** comparten el tipo $(X\to X)\to X\to X$; como tipos principales **no**, porque $\overline 0$ y $\overline 1$ tienen tipos estrictamente más generales ($\overline n$ para $n \ge 2$ sí comparten tipo principal). Si la cátedra sólo pide la primera lectura, el paso 3 es material extra.

**Chuleta**
> 1. Numeral de Church: $\overline n = \lambda y . \lambda x . y^n(x)$ = "aplicar $y$ $n$ veces a $x$". → 2. Inferir con $n = 2$ y generalizar: la ecuación clave es $X_1 \doteq X_2 \to X_3$ **y** $X_1 \doteq X_3 \to X_4$ ⟹ dominio $=$ codominio. → 3. Respuesta: $\sigma = X \to X$, $\tau = X$; tipo $(X\to X)\to X\to X$. → 4. Justificar por **inducción en $n$**: base $y^0(x)=x : X$; paso $y^{n+1}(x) = y(y^n(x)) : X$ por t-app. → 5. Tipos principales: $n{=}0 \Rightarrow \sigma\to\tau\to\tau$; $n{=}1 \Rightarrow (\sigma\to\tau)\to\sigma\to\tau$; $n \ge 2 \Rightarrow (X\to X)\to X\to X$ (se estabiliza). → 6. El $X$ es una **incógnita libre, no un $\forall$**: los numerales son **monomórficos**; reusarlos a dos tipos distintos ⟹ clash.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

### Ejercicio 7 — Variables frescas y contexto
**Enunciado**
I. Utilizar el algoritmo de inferencia sobre la siguiente expresión: $\lambda y . (x\,y)\,(\lambda z . x_2)$
II. Una vez calculado, demostrar (utilizando chequeo de tipos) que el juicio encontrado es correcto.
III. ¿Qué ocurriría si $x_2$ fuera $x$?

**Explicación**
El punto del ejercicio es la **distinción entre variables libres y ligadas**: $x$ y $x_2$ son **libres** (van al contexto inicial $\Gamma_0$ con una incógnita fresca cada una), mientras que $y$ y $z$ son **ligadas** (cada $\lambda$ genera su propia incógnita fresca en la anotación). El ítem III muestra qué pasa cuando dos ocurrencias que eran variables **distintas** pasan a ser la **misma**: las restricciones se fusionan y aparece el occurs-check.

**Resolución paso a paso**
**Preliminar — quiénes son las variables.** Según la gramática de la práctica, los nombres se toman de $\mathcal{X} = \{w, w_1, w_2, \dots, x, x_1, x_2, \dots\}$: **$x_2$ es un nombre de variable, distinto de $x$**. El ítem III lo confirma al preguntar qué pasaría si fueran la misma.

- **Libres:** $x$, $x_2$ ⟹ van a $\Gamma_0$ con incógnitas frescas.
- **Ligadas:** $y$ (por el $\lambda$ externo), $z$ (por el $\lambda$ interno) ⟹ cada una recibe una incógnita fresca **en su anotación**, no en $\Gamma_0$.
- **Parseo:** $(x\,y)\,(\lambda z . x_2)$ es la aplicación de $(x\,y)$ al argumento $(\lambda z . x_2)$; los paréntesis del enunciado son explícitos, no hace falta desambiguar. El término no requiere rectificación: los cuatro nombres son distintos y ninguna ligadura captura a otra.

$$\Gamma_0 = \{\, x : X_1,\;\; x_2 : X_2 \,\} \qquad\qquad \text{Anotación: } \lambda y{:}X_3 . (x\,y)\,(\lambda z{:}X_4 . x_2)$$

---

**I. Corrida de $\mathcal{I}$**

| Paso | Subtérmino | Resultado $(\tau \mid E)$ |
|---|---|---|
| 1 | $x$ | $(X_1 \mid \emptyset)$ — t-var, del contexto |
| 2 | $y$ | $(X_3 \mid \emptyset)$ — t-var, de la anotación del $\lambda$ |
| 3 | $x\,y$ ($X_5$ fresca) | $(X_5 \mid \{\, X_1 \doteq X_3 \to X_5 \,\})$ |
| 4 | $x_2$ (en $\Gamma_0, y{:}X_3, z{:}X_4$) | $(X_2 \mid \emptyset)$ — **sigue siendo el del contexto**, el $\lambda z$ no lo liga |
| 5 | $\lambda z{:}X_4 . x_2$ | $(X_4 \to X_2 \mid \emptyset)$ — el cuerpo ignora a $z$ ⟹ $X_4$ queda libre |
| 6 | $(x\,y)\,(\lambda z . x_2)$ ($X_6$ fresca) | $(X_6 \mid \{\, X_1 \doteq X_3 \to X_5,\;\; X_5 \doteq (X_4 \to X_2) \to X_6 \,\})$ |
| 7 | $\lambda y{:}X_3 . (\dots)$ | $(X_3 \to X_6 \mid E)$ |

$$E = \{\; \underbrace{X_1 \doteq X_3 \to X_5}_{\text{aplicación } x\,y},\;\; \underbrace{X_5 \doteq (X_4 \to X_2) \to X_6}_{\text{aplicación externa}} \;\}$$

Tipo del término **antes** de unificar: $X_3 \to X_6$.

*Unificación paso a paso:*

| Paso | Regla | $E$ | $S$ acumulada |
|---|---|---|---|
| 0 | — | $\{X_1 \doteq X_3 \to X_5,\; X_5 \doteq (X_4 \to X_2) \to X_6\}$ | $id$ |
| 1 | *elim* $X_1 := X_3 \to X_5$ ($X_1 \notin fv$ ✓) | $\{X_5 \doteq (X_4 \to X_2) \to X_6\}$ | $\{X_1 := X_3 \to X_5\}$ |
| 2 | *elim* $X_5 := (X_4 \to X_2) \to X_6$ ($X_5 \notin fv$ ✓, **propagar a la imagen de $X_1$**) | $\emptyset$ | $\{X_1 := X_3 \to ((X_4 \to X_2) \to X_6),\; X_5 := (X_4 \to X_2) \to X_6\}$ |

Aplicando $S$ al contexto y al tipo:

$$\boxed{\;\{\, x : X_3 \to (X_4 \to X_2) \to X_6,\;\; x_2 : X_2 \,\} \;\vdash\; \lambda y{:}X_3 . (x\,y)\,(\lambda z{:}X_4 . x_2) \;:\; X_3 \to X_6\;}$$

**✅ TIPABLE.** Quedan **cuatro incógnitas libres** ($X_2, X_3, X_4, X_6$): el juicio es un esquema, cualquier instancia suya es un juicio derivable. Notar en particular que:
- $X_4$ (el tipo de $z$) queda **totalmente libre**, porque $z$ no se usa en el cuerpo del $\lambda z$;
- $X_2$ (el tipo de $x_2$) también queda libre, y **aparece en el tipo de $x$** dentro del contexto: la restricción viaja desde el argumento hasta el tipo de la variable libre $x$;
- $x$ recibe en el contexto un tipo **de segundo orden en apariencia** — toma un $X_3$ y devuelve una función que come funciones $X_4 \to X_2$.

---

**II. Chequeo de tipos del juicio encontrado**

Ahora **verificamos** (ya no inferimos): se construye el árbol de derivación de arriba hacia abajo con las reglas **t-var**, **t-app** y **t-abs**, sobre el término **anotado** que devolvió la inferencia. Escribimos $\Gamma = \{x : X_3 \to (X_4 \to X_2) \to X_6,\; x_2 : X_2\}$.

$$\frac{\dfrac{\dfrac{\;}{\Gamma, y{:}X_3 \vdash x : X_3 \to (X_4\to X_2)\to X_6}\;\text{t-var} \qquad \dfrac{\;}{\Gamma, y{:}X_3 \vdash y : X_3}\;\text{t-var}}{\Gamma, y{:}X_3 \vdash x\,y : (X_4 \to X_2) \to X_6}\;\text{t-app} \qquad \dfrac{\dfrac{\;}{\Gamma, y{:}X_3, z{:}X_4 \vdash x_2 : X_2}\;\text{t-var}}{\Gamma, y{:}X_3 \vdash \lambda z{:}X_4 . x_2 : X_4 \to X_2}\;\text{t-abs}}{\dfrac{\Gamma, y{:}X_3 \vdash (x\,y)\,(\lambda z{:}X_4 . x_2) : X_6}{\Gamma \vdash \lambda y{:}X_3 . (x\,y)\,(\lambda z{:}X_4 . x_2) : X_3 \to X_6}\;\text{t-abs}}\;\text{t-app}$$

Leído linealmente (que es como conviene escribirlo en un parcial):

1. $\Gamma, y{:}X_3 \vdash x : X_3 \to (X_4\to X_2)\to X_6$ — **t-var** ($x \in dom(\Gamma)$)
2. $\Gamma, y{:}X_3 \vdash y : X_3$ — **t-var** (la ligadura de $y$ es la más cercana)
3. $\Gamma, y{:}X_3 \vdash x\,y : (X_4 \to X_2)\to X_6$ — **t-app** sobre 1 y 2: el dominio de 1 es **exactamente** el tipo de 2 ✓
4. $\Gamma, y{:}X_3, z{:}X_4 \vdash x_2 : X_2$ — **t-var** (extender $\Gamma$ con $z$ no afecta a $x_2$)
5. $\Gamma, y{:}X_3 \vdash \lambda z{:}X_4 . x_2 : X_4 \to X_2$ — **t-abs** sobre 4
6. $\Gamma, y{:}X_3 \vdash (x\,y)\,(\lambda z{:}X_4.x_2) : X_6$ — **t-app** sobre 3 y 5: el dominio de 3 es $X_4 \to X_2$, que es **exactamente** el tipo de 5 ✓
7. $\Gamma \vdash \lambda y{:}X_3 . (x\,y)\,(\lambda z{:}X_4 . x_2) : X_3 \to X_6$ — **t-abs** sobre 6 ✓

El árbol cierra sin ninguna ecuación pendiente ⟹ el juicio inferido es **correcto**. (Ésta es la dirección "corrección del algoritmo": lo que $\mathcal{I}$ devuelve es derivable. La otra dirección, "completitud", dice que además es el **más general**: cualquier otro juicio derivable para el término es una instancia $S'$ del inferido.)

---

**III. ¿Qué ocurriría si $x_2$ fuera $x$? — ❌ NO TIPABLE (occurs-check)**

El término pasa a ser $\lambda y . (x\,y)\,(\lambda z . x)$, con **una sola** variable libre. Eso cambia el contexto inicial:

$$\Gamma_0 = \{\, x : X_1 \,\} \qquad\qquad \text{Anotación: } \lambda y{:}X_3 . (x\,y)\,(\lambda z{:}X_4 . x)$$

La corrida es la misma salvo que **el tipo del cuerpo del $\lambda z$ ya no es una incógnita independiente $X_2$, sino el propio $X_1$**:

| Paso | Subtérmino | Resultado |
|---|---|---|
| 3 | $x\,y$ ($X_5$ fresca) | $(X_5 \mid \{X_1 \doteq X_3 \to X_5\})$ |
| 5 | $\lambda z{:}X_4 . x$ | $(X_4 \to \boxed{X_1} \mid \emptyset)$ |
| 6 | $(x\,y)\,(\lambda z . x)$ ($X_6$ fresca) | $(X_6 \mid \{X_1 \doteq X_3 \to X_5,\;\; X_5 \doteq (X_4 \to X_1) \to X_6\})$ |

$$E = \{\; X_1 \doteq X_3 \to X_5,\;\; X_5 \doteq (X_4 \to X_1) \to X_6 \;\}$$

*Unificación:*
1. *elim* $X_1 := X_3 \to X_5$ ⟹ la segunda ecuación se convierte en $X_5 \doteq (X_4 \to (X_3 \to X_5)) \to X_6$
2. $X_5 \in fv\bigl((X_4 \to X_3 \to X_5) \to X_6\bigr)$ ⟹ **OCCURS-CHECK: FALLA**

*(El orden no importa: si se elimina primero $X_5 := (X_4 \to X_1)\to X_6$, la primera ecuación queda $X_1 \doteq X_3 \to ((X_4 \to X_1) \to X_6)$ y el occurs-check falla sobre $X_1$. El $mgu$ es único salvo renombre, así que ninguna estrategia salva el término.)*

**Intuición.** Al identificar las dos variables, $x$ queda usada de dos maneras incompatibles dentro del mismo término:
- como **función** aplicada a $y$, cuyo resultado se aplica a su vez a $\lambda z . x$ ⟹ el tipo de $x$ aparece en el **argumento** de una aplicación cuyo functor también se deriva de $x$;
- haría falta resolver la ecuación recursiva $X_1 = X_3 \to (X_4 \to X_1) \to X_6$, o sea un **tipo infinito** $X_3 \to (X_4 \to (X_3 \to (X_4 \to \cdots) \to X_6)) \to X_6$.

El sistema simplemente tipado **no tiene tipos recursivos**, así que el término no es tipable. Es el mismo patrón que en los ítems (b) y (g) del **Ejercicio 5**: *una variable aplicada (directa o indirectamente) a algo que la menciona*.

**Moraleja del ejercicio completo:** el nombre de las variables **importa**. Dos variables libres distintas ⟹ dos incógnitas independientes en $\Gamma_0$ ⟹ ninguna ecuación las liga y el término tipa; la misma variable dos veces ⟹ una única incógnita ⟹ todas sus restricciones se unifican entre sí. Es exactamente la contracara del fenómeno del **Ejercicio 4.V** (dos $\lambda$ distintos ⟹ frescas independientes ⟹ tipa) frente al **4.VI** (una sola variable ⟹ clash), y la razón por la que **rectificar antes de anotar** es obligatorio.

⚠️ Verificar — el ítem II dice "demostrar (utilizando chequeo de tipos) que el juicio encontrado es correcto". Acá se interpreta como **construir el árbol de derivación** del término anotado con t-var/t-app/t-abs y verificar que cierra. Si la cátedra se refiere al *algoritmo de chequeo de tipos* $\text{check}(\Gamma, M, \tau)$ visto como función, el contenido es el mismo (recorre el término comparando tipos en lugar de generar ecuaciones), sólo cambia la presentación.

**Chuleta**
> 1. **Libres al contexto, ligadas a la anotación**: cada variable libre entra en $\Gamma_0$ con una incógnita fresca; cada $\lambda$ genera la suya en la anotación. → 2. **Rectificar primero** ($\alpha$-renombrar ligaduras repetidas) — si dos nombres son distintos, las incógnitas son independientes y no se unifican. → 3. Una ecuación **por aplicación**: $\tau_{fun} \doteq \tau_{arg} \to X_{fresca}$. → 4. Variable ligada **no usada** en el cuerpo ⟹ su incógnita queda **libre** en el tipo principal. → 5. Al terminar, aplicar $S$ **al tipo y al contexto**: las restricciones fijan también el tipo de las variables libres. → 6. **Chequeo de tipos** $\neq$ inferencia: se parte del término ya anotado y se arma el árbol con t-var/t-app/t-abs; no hay ecuaciones ni sustituciones. → 7. Identificar dos variables libres distintas en una sola ⟹ sus restricciones se fusionan ⟹ alarma de **occurs-check** (tipo infinito ⟹ no tipable).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

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
**Reglas nuevas del algoritmo $\mathcal{I}$ para productos**

A partir de las reglas de tipado dadas, se leen "de abajo hacia arriba" convirtiendo cada coincidencia de tipos en una ecuación y cada tipo desconocido en una incógnita fresca:

$$\mathcal{I}(\Gamma \mid \langle M, N \rangle) = (\tau \times \sigma \mid E_1 \cup E_2) \quad \text{donde } \mathcal{I}(\Gamma\mid M) = (\tau\mid E_1),\; \mathcal{I}(\Gamma\mid N) = (\sigma\mid E_2)$$

$$\mathcal{I}(\Gamma \mid \pi_1(M)) = (X \mid E \cup \{\, \tau \doteq X \times Y \,\}) \qquad \mathcal{I}(\Gamma \mid \pi_2(M)) = (Y \mid E \cup \{\, \tau \doteq X \times Y \,\})$$
con $X, Y$ **frescas** y $\mathcal{I}(\Gamma \mid M) = (\tau \mid E)$.

**Cómo cambian las restricciones:** el par **no genera ecuaciones nuevas** (sólo compone tipos, igual que $\lambda$), mientras que cada proyección **sí** agrega una: obliga a que su argumento sea un producto. Además hay que extender la unificación con la regla de *decompose* para $\times$:
$$\{\tau_1 \times \tau_2 \doteq \sigma_1 \times \sigma_2\} \cup E \;\to\; \{\tau_1 \doteq \sigma_1,\; \tau_2 \doteq \sigma_2\} \cup E$$
y $\times$ pasa a ser un constructor más para el **clash**: $\tau_1 \times \tau_2 \doteq \sigma_1 \to \sigma_2$ falla, igual que $\tau_1\times\tau_2 \doteq \text{Nat}$.

---

**I. $(\lambda f . \langle f, \underline{2} \rangle)\,(\lambda x . x\,\underline{1})$ — ✅ TIPABLE**

Con $\underline{2} = \text{succ}(\text{succ}(\text{zero})) : \text{Nat}$ y $\underline{1} = \text{succ}(\text{zero}) : \text{Nat}$.

Anotación: $(\lambda f{:}X_1 . \langle f, \underline 2 \rangle)\,(\lambda x{:}X_2 . x\,\underline 1)$.

*Lado izquierdo:*

| Subtérmino | Tipo | Ecuaciones |
|---|---|---|
| $f$ | $X_1$ | — |
| $\underline 2$ | $\text{Nat}$ | — |
| $\langle f, \underline 2\rangle$ | $X_1 \times \text{Nat}$ | — *(el par no aporta ecuaciones)* |
| $\lambda f{:}X_1 . \langle f,\underline 2\rangle$ | $X_1 \to (X_1 \times \text{Nat})$ | — |

*Lado derecho:*

| Subtérmino | Tipo | Ecuaciones |
|---|---|---|
| $x\,\underline 1$ ($X_3$ fresca) | $X_3$ | $X_2 \doteq \text{Nat} \to X_3$ |
| $\lambda x{:}X_2 . x\,\underline 1$ | $X_2 \to X_3$ | ídem |

*Aplicación* ($X_4$ fresca):
$$E = \{\;\underbrace{X_2 \doteq \text{Nat} \to X_3}_{(1)},\;\; \underbrace{X_1 \to (X_1 \times \text{Nat}) \doteq (X_2 \to X_3) \to X_4}_{(2)}\;\}$$
El tipo del término entero es $X_4$.

*Unificación:*
1. *decompose* en (2): $\{\, X_2 \doteq \text{Nat} \to X_3,\;\; X_1 \doteq X_2 \to X_3,\;\; X_1 \times \text{Nat} \doteq X_4 \,\}$
2. *elim* $X_2 := \text{Nat} \to X_3$: $\{\, X_1 \doteq (\text{Nat} \to X_3) \to X_3,\;\; X_1 \times \text{Nat} \doteq X_4 \,\}$
3. *elim* $X_1 := (\text{Nat} \to X_3) \to X_3$: $\{\, ((\text{Nat}\to X_3)\to X_3) \times \text{Nat} \doteq X_4 \,\}$
4. *swap* + *elim* $X_4 := ((\text{Nat}\to X_3)\to X_3) \times \text{Nat}$: $E = \emptyset$

$$S = \{\, X_1 := (\text{Nat}\to X_3)\to X_3,\;\; X_2 := \text{Nat} \to X_3,\;\; X_4 := ((\text{Nat}\to X_3)\to X_3)\times\text{Nat} \,\}$$

$$\boxed{\;\emptyset \vdash (\lambda f . \langle f, \underline 2\rangle)(\lambda x . x\,\underline 1) \;:\; ((\text{Nat} \to X_3) \to X_3) \times \text{Nat}\;}$$

*Verificación por $\beta$:* el término reduce a $\langle \lambda x . x\,\underline 1,\; \underline 2\rangle$; y $\lambda x . x\,\underline 1$ tiene tipo $(\text{Nat}\to X_3) \to X_3$ (recibe una función que come $\text{Nat}$). El par queda $((\text{Nat}\to X_3)\to X_3)\times\text{Nat}$ ✓.

---

**II. $(\lambda f . \langle f\,\underline{2},\; f\,\text{True} \rangle)\,(\lambda x . x)$ — ❌ NO TIPABLE**

Anotación: $(\lambda f{:}X_1 . \langle f\,\underline 2,\; f\,\text{True}\rangle)\,(\lambda x{:}X_4 . x)$.

| Subtérmino | Tipo | Ecuaciones |
|---|---|---|
| $f\,\underline 2$ ($X_2$ fresca) | $X_2$ | $\boxed{X_1 \doteq \text{Nat} \to X_2}$ |
| $f\,\text{True}$ ($X_3$ fresca) | $X_3$ | $\boxed{X_1 \doteq \text{Bool} \to X_3}$ |
| $\langle\,,\rangle$ | $X_2 \times X_3$ | — |
| $\lambda f$ | $X_1 \to (X_2 \times X_3)$ | — |
| $\lambda x{:}X_4 . x$ | $X_4 \to X_4$ | — |
| aplicación ($X_5$ fresca) | $X_5$ | $X_1 \to (X_2 \times X_3) \doteq (X_4 \to X_4) \to X_5$ |

$$E = \{\, X_1 \doteq \text{Nat} \to X_2,\;\; X_1 \doteq \text{Bool} \to X_3,\;\; X_1 \to (X_2\times X_3) \doteq (X_4 \to X_4) \to X_5 \,\}$$

*Unificación:*
1. *elim* $X_1 := \text{Nat} \to X_2$ ⟹ la segunda ecuación queda $\text{Nat} \to X_2 \doteq \text{Bool} \to X_3$
2. *decompose* ⟹ $\boxed{\text{Nat} \doteq \text{Bool}}$ ⟹ **CLASH. FALLA.**

**Dónde falla exactamente:** en la unificación de las dos restricciones que genera la **misma** variable $f$ dentro del par — $f$ debería ser simultáneamente $\text{Nat} \to X_2$ y $\text{Bool} \to X_3$. El algoritmo falla **antes de mirar el argumento** $\lambda x.x$, así que ni siquiera llega a usar la identidad.

**Lo importante:** $\lambda x . x$ *sí* podría servir para ambos usos (su tipo principal $X_4 \to X_4$ instancia tanto a $\text{Nat}\to\text{Nat}$ como a $\text{Bool}\to\text{Bool}$), pero en el cálculo-$\lambda$ simplemente tipado la variable ligada $f$ recibe **un único** tipo monomórfico. Es el ejemplo canónico de por qué hace falta el **let-polimorfismo** (Hindley-Milner) o la cuantificación explícita de System F: con `let f = λx.x in ⟨f 2, f True⟩` el término sí tipa, porque cada uso de $f$ se instancia por separado desde el esquema $\forall X . X \to X$.

**Chuleta**
> 1. Extender los tipos: $\sigma ::= \dots \mid \sigma \times \sigma$. → 2. $\mathcal{I}(\Gamma\mid\langle M,N\rangle) = (\tau\times\sigma \mid E_1\cup E_2)$ — **el par no agrega ecuaciones**. → 3. $\mathcal{I}(\Gamma\mid\pi_i(M)) = (X_i \mid E \cup \{\tau \doteq X_1\times X_2\})$ con $X_1,X_2$ frescas — **la proyección sí agrega una**. → 4. Extender la unificación: *decompose* para $\times$ ($\tau_1\times\tau_2 \doteq \sigma_1\times\sigma_2 \Rightarrow \tau_1\doteq\sigma_1, \tau_2\doteq\sigma_2$) y $\times$ choca con $\to$, $\text{Nat}$, $\text{Bool}$. → 5. Si una **misma** variable ligada se aplica a $\text{Nat}$ y a $\text{Bool}$ ⟹ clash garantizado (**monomorfismo**), sin importar cuán general sea el argumento. → 6. Chequeo: $\beta$-reducir y comparar tipos.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

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
**Reglas de tipado para sumas** (uniones disjuntas $\tau + \sigma$)

$$\frac{\Gamma \vdash M : \tau}{\Gamma \vdash \text{left}_\sigma(M) : \tau + \sigma}\;\text{t-left} \qquad \frac{\Gamma \vdash M : \sigma}{\Gamma \vdash \text{right}_\tau(M) : \tau + \sigma}\;\text{t-right}$$

$$\frac{\Gamma \vdash M : \tau + \sigma \quad \Gamma, x : \tau \vdash M_1 : \rho \quad \Gamma, y : \sigma \vdash M_2 : \rho}{\Gamma \vdash \text{case } M \text{ of left}(x) \leadsto M_1 \parallel \text{right}(y) \leadsto M_2 : \rho}\;\text{t-case}$$

*(La anotación en $\text{left}_\sigma$ / $\text{right}_\tau$ existe porque la mitad "no usada" del tipo suma no es recuperable del término: $\text{left}(\underline 1)$ podría ser $\text{Nat}+\text{Bool}$ o $\text{Nat}+\text{Nat}$. La unicidad de tipos se pierde sin la anotación.)*

**Reglas nuevas del algoritmo $\mathcal{I}$**

$$\mathcal{I}(\Gamma \mid \text{left}(M)) = (\tau + Y \mid E) \qquad \text{con } \mathcal{I}(\Gamma\mid M) = (\tau\mid E),\; Y \text{ fresca}$$
$$\mathcal{I}(\Gamma \mid \text{right}(M)) = (X + \tau \mid E) \qquad \text{con } \mathcal{I}(\Gamma\mid M) = (\tau\mid E),\; X \text{ fresca}$$

Es decir: **el constructor deja libre la otra mitad como incógnita fresca**, que la unificación resolverá (o dejará libre, dando un tipo principal con parámetro). Si el término viene ya anotado ($\text{left}_\sigma(M)$), se usa $\sigma$ en lugar de la incógnita fresca.

$$\mathcal{I}(\Gamma \mid \text{case } M \text{ of left}(x)\leadsto M_1 \parallel \text{right}(y) \leadsto M_2) = \bigl(\tau_1 \;\bigm|\; E \cup E_1 \cup E_2 \cup \{\, \tau \doteq X + Y,\;\; \tau_1 \doteq \tau_2 \,\}\bigr)$$
donde $X, Y$ son **frescas**, $\mathcal{I}(\Gamma \mid M) = (\tau \mid E)$, $\mathcal{I}(\Gamma, x{:}X \mid M_1) = (\tau_1 \mid E_1)$ y $\mathcal{I}(\Gamma, y{:}Y \mid M_2) = (\tau_2 \mid E_2)$.

**Cómo cambian las restricciones:** el `case` es el análogo del `if` pero más rico — genera **dos** ecuaciones: una que obliga al scrutinee a ser una suma ($\tau \doteq X + Y$, que además *conecta* los tipos de las variables ligadas $x$ e $y$ con el scrutinee) y otra que iguala las dos ramas ($\tau_1 \doteq \tau_2$). Y hay que extender la unificación con *decompose* para $+$:
$$\{\tau_1 + \tau_2 \doteq \sigma_1 + \sigma_2\} \cup E \to \{\tau_1 \doteq \sigma_1,\; \tau_2 \doteq \sigma_2\} \cup E$$
tratando $+$ como un constructor más a efectos de *clash*.

---

**I. $\text{case left}(\underline 1) \text{ of left}(x) \leadsto \text{isZero}(x) \parallel \text{right}(y) \leadsto \text{True}$ — ✅ TIPABLE**

| Paso | Resultado |
|---|---|
| $\mathcal{I}(\emptyset \mid \underline 1)$ | $(\text{Nat} \mid \emptyset)$ |
| $\mathcal{I}(\emptyset \mid \text{left}(\underline 1))$ | $(\text{Nat} + X_1 \mid \emptyset)$, $X_1$ fresca |
| $\mathcal{I}(\{x{:}X_2\} \mid \text{isZero}(x))$ | $(\text{Bool} \mid \{X_2 \doteq \text{Nat}\})$ |
| $\mathcal{I}(\{y{:}X_3\} \mid \text{True})$ | $(\text{Bool} \mid \emptyset)$ |
| `case` | $(\text{Bool} \mid E)$ |

$$E = \{\; X_2 \doteq \text{Nat},\;\; \text{Nat} + X_1 \doteq X_2 + X_3,\;\; \text{Bool} \doteq \text{Bool} \;\}$$

*Unificación:*
1. *delete* $\text{Bool} \doteq \text{Bool}$
2. *elim* $X_2 := \text{Nat}$ ⟹ $\{\, \text{Nat} + X_1 \doteq \text{Nat} + X_3 \,\}$
3. *decompose* ($+$) ⟹ $\{\, \text{Nat} \doteq \text{Nat},\;\; X_1 \doteq X_3 \,\}$
4. *delete* + *elim* $X_1 := X_3$ ⟹ $E = \emptyset$

$$S = \{\, X_2 := \text{Nat},\;\; X_1 := X_3 \,\}$$

$$\boxed{\;\emptyset \vdash \text{case left}_{X_3}(\underline 1) \text{ of left}(x) \leadsto \text{isZero}(x) \parallel \text{right}(y) \leadsto \text{True} \;:\; \text{Bool}\;}$$

Observar que $X_3$ (el tipo de la rama `right`, que nunca se ejecuta) **queda libre**: el término es tipable para *cualquier* instancia de $X_3$, y ése es precisamente su tipo principal. El término anotado resultante lleva $\text{left}_{X_3}$.

---

**II. $\text{case left}(z) \text{ of left}(x) \leadsto \text{isZero}(x) \parallel \text{right}(y) \leadsto y$ — ✅ TIPABLE**

$z$ es **libre** ⟹ $\Gamma_0 = \{z : X_0\}$.

| Paso | Resultado |
|---|---|
| $\mathcal{I}(\Gamma_0 \mid z)$ | $(X_0 \mid \emptyset)$ |
| $\mathcal{I}(\Gamma_0 \mid \text{left}(z))$ | $(X_0 + X_1 \mid \emptyset)$, $X_1$ fresca |
| $\mathcal{I}(\Gamma_0, x{:}X_2 \mid \text{isZero}(x))$ | $(\text{Bool} \mid \{X_2 \doteq \text{Nat}\})$ |
| $\mathcal{I}(\Gamma_0, y{:}X_3 \mid y)$ | $(X_3 \mid \emptyset)$ |
| `case` | $(\text{Bool} \mid E)$ |

$$E = \{\; X_2 \doteq \text{Nat},\;\; X_0 + X_1 \doteq X_2 + X_3,\;\; \text{Bool} \doteq X_3 \;\}$$

*Unificación paso a paso:*

| Paso | Regla | $E$ | $S$ acumulada |
|---|---|---|---|
| 0 | — | $\{X_2 \doteq \text{Nat},\; X_0+X_1 \doteq X_2+X_3,\; \text{Bool}\doteq X_3\}$ | $id$ |
| 1 | *elim* $X_2 := \text{Nat}$ | $\{X_0+X_1 \doteq \text{Nat}+X_3,\; \text{Bool}\doteq X_3\}$ | $\{X_2 := \text{Nat}\}$ |
| 2 | *decompose* ($+$) | $\{X_0 \doteq \text{Nat},\; X_1 \doteq X_3,\; \text{Bool}\doteq X_3\}$ | ídem |
| 3 | *elim* $X_0 := \text{Nat}$ | $\{X_1 \doteq X_3,\; \text{Bool}\doteq X_3\}$ | $+\{X_0 := \text{Nat}\}$ |
| 4 | *elim* $X_1 := X_3$ | $\{\text{Bool} \doteq X_3\}$ | $+\{X_1 := X_3\}$ |
| 5 | *swap* | $\{X_3 \doteq \text{Bool}\}$ | ídem |
| 6 | *elim* $X_3 := \text{Bool}$ | $\emptyset$ | $\{X_0 := \text{Nat}, X_1 := \text{Bool}, X_2 := \text{Nat}, X_3 := \text{Bool}\}$ |

$$\boxed{\;\{z : \text{Nat}\} \vdash \text{case left}_{\text{Bool}}(z) \text{ of left}(x) \leadsto \text{isZero}(x) \parallel \text{right}(y) \leadsto y \;:\; \text{Bool}\;}$$

**Diferencia con el ítem I:** acá la rama `right` devuelve $y$, así que su tipo $X_3$ queda **atado** por la ecuación de ramas $\text{Bool} \doteq X_3$. Eso fuerza $X_1 := \text{Bool}$ y la anotación del $\text{left}$ deja de ser libre. Además el scrutinee, al ser la variable libre $z$, obliga a $X_0 := \text{Nat}$ vía la ecuación $X_0 + X_1 \doteq X_2 + X_3$ combinada con $X_2 \doteq \text{Nat}$: la restricción del `isZero` **viaja** desde la rama hasta el contexto.

⚠️ Verificar — el enunciado escribe la gramática con constructores anotados ($\text{left}_\tau$, $\text{right}_\tau$) pero los ítems I y II usan $\text{left}(\cdot)$ sin anotación. Acá se asume que la anotación faltante es una **incógnita fresca** a inferir (que es lo que hace $\mathcal{I}$ con todas las anotaciones ausentes). Si la cátedra pidiera trabajar con el término ya anotado, la única diferencia es que en lugar de $X_1$ fresca se usa el $\sigma$ dado y la ecuación queda $\sigma \doteq X_3$.

**Chuleta**
> 1. Tipos: $\sigma ::= \dots \mid \sigma + \sigma$. → 2. $\mathcal{I}(\Gamma\mid\text{left}(M)) = (\tau + Y \mid E)$ con $Y$ **fresca** (la mitad no usada queda libre); $\text{right}(M)$ simétrico: $(X + \tau\mid E)$. → 3. `case` ⟹ **dos** ecuaciones: $\tau_{scrutinee} \doteq X + Y$ (con $x{:}X$ en la rama `left` e $y{:}Y$ en la `right`) y $\tau_1 \doteq \tau_2$ (ramas iguales); el tipo del `case` es $\tau_1$. → 4. Las ramas se analizan **extendiendo $\Gamma$** con $x{:}X$ e $y{:}Y$ respectivamente, $X,Y$ frescas. → 5. Unificación: *decompose* para $+$; $+$ choca con $\to$, $\times$, $\text{Nat}$, $\text{Bool}$. → 6. Si una rama no usa su variable, la mitad correspondiente **queda libre** en el tipo principal.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

### Ejercicio 10 — Extensión Listas
**Enunciado**
Definir las reglas del algoritmo de inferencia $\mathcal{I}$ para soportar listas y `foldr`:
$M ::= \dots \mid []_\tau \mid M :: M \mid \text{foldr } M \text{ base } \leadsto M; \text{rec}(h, r) \leadsto M$
Y aplicarlas a:
I. $\text{foldr } x :: [] \text{ base } \leadsto []; \text{rec}(h, r) \leadsto \text{isZero}(h) :: r$

**Explicación**
`foldr` es el operador más complejo para inferir, ya que involucra el tipo de la lista, el tipo del acumulador y la función de paso.

**Resolución paso a paso**
**Reglas de tipado para listas y `foldr`**

$$\frac{}{\Gamma \vdash []_\tau : [\tau]}\;\text{t-nil} \qquad \frac{\Gamma \vdash M : \tau \quad \Gamma \vdash N : [\tau]}{\Gamma \vdash M :: N : [\tau]}\;\text{t-cons}$$

$$\frac{\Gamma \vdash M : [\tau] \quad \Gamma \vdash M_b : \sigma \quad \Gamma, h : \tau,\, r : \sigma \vdash M_r : \sigma}{\Gamma \vdash \text{foldr } M \text{ base} \leadsto M_b;\, \text{rec}(h,r) \leadsto M_r : \sigma}\;\text{t-foldr}$$

Leer `t-foldr` así: $h$ es la **cabeza** (tipo de los elementos, $\tau$) y $r$ es el **resultado recursivo** sobre la cola (tipo del acumulador, $\sigma$); el paso recursivo debe devolver otra vez $\sigma$, igual que el caso base.

**Reglas nuevas del algoritmo $\mathcal{I}$**

$$\mathcal{I}(\Gamma \mid []) = ([X] \mid \emptyset) \qquad X \text{ fresca}$$

$$\mathcal{I}(\Gamma \mid M_1 :: M_2) = \bigl([\tau_1] \;\bigm|\; E_1 \cup E_2 \cup \{\, \tau_2 \doteq [\tau_1] \,\}\bigr)$$

$$\mathcal{I}\bigl(\Gamma \mid \text{foldr } M \text{ base}\leadsto M_b;\, \text{rec}(h,r)\leadsto M_r\bigr) = \bigl(\tau_b \;\bigm|\; E \cup E_b \cup E_r \cup \{\, \tau \doteq [X_h],\;\; X_r \doteq \tau_b,\;\; \tau_r \doteq \tau_b \,\}\bigr)$$
donde $X_h, X_r$ son **frescas**, $\mathcal{I}(\Gamma\mid M) = (\tau\mid E)$, $\mathcal{I}(\Gamma\mid M_b) = (\tau_b \mid E_b)$ y $\mathcal{I}(\Gamma, h{:}X_h,\, r{:}X_r \mid M_r) = (\tau_r \mid E_r)$.

**Cómo cambian las restricciones:** `[]` no genera ecuaciones (sólo una incógnita fresca); `::` genera **una** (la cola debe ser lista del tipo de la cabeza); y `foldr` genera **tres**, que son las tres "costuras" del esquema de recursión:

| Ecuación | Qué costura cierra |
|---|---|
| $\tau \doteq [X_h]$ | el primer argumento es una **lista**, y sus elementos tienen el tipo de $h$ |
| $X_r \doteq \tau_b$ | el **acumulador** ($r$) tiene el tipo del **caso base** |
| $\tau_r \doteq \tau_b$ | el **paso recursivo** devuelve el mismo tipo que el caso base |

Y la unificación se extiende con *decompose* para $[\cdot]$: $\{[\tau] \doteq [\sigma]\} \cup E \to \{\tau \doteq \sigma\} \cup E$, siendo $[\cdot]$ un constructor más para el *clash*.

---

**I. $\text{foldr } x :: [] \text{ base} \leadsto [];\; \text{rec}(h,r) \leadsto \text{isZero}(h) :: r$ — ✅ TIPABLE**

$x$ es **libre** ⟹ $\Gamma_0 = \{x : X_1\}$.

*Paso 1 — la lista $M = x :: []$:*

| Subtérmino | Tipo | Ecuaciones |
|---|---|---|
| $x$ | $X_1$ | — |
| $[]$ | $[X_2]$, $X_2$ fresca | — |
| $x :: []$ | $[X_1]$ | $[X_2] \doteq [X_1]$ |

*Paso 2 — el caso base $M_b = []$:* tipo $[X_3]$ con $X_3$ fresca, sin ecuaciones.

*Paso 3 — el paso recursivo $M_r = \text{isZero}(h) :: r$*, en el contexto $\Gamma_0, h : X_h,\, r : X_r$:

| Subtérmino | Tipo | Ecuaciones |
|---|---|---|
| $\text{isZero}(h)$ | $\text{Bool}$ | $X_h \doteq \text{Nat}$ |
| $\text{isZero}(h) :: r$ | $[\text{Bool}]$ | $X_r \doteq [\text{Bool}]$ |

*Paso 4 — ecuaciones propias del `foldr`:* $\;[X_1] \doteq [X_h]$ (lista), $\;X_r \doteq [X_3]$ (acumulador $=$ base), $\;[\text{Bool}] \doteq [X_3]$ (paso $=$ base).

$$E = \{\; [X_2] \doteq [X_1],\;\; X_h \doteq \text{Nat},\;\; X_r \doteq [\text{Bool}],\;\; [X_1] \doteq [X_h],\;\; X_r \doteq [X_3],\;\; [\text{Bool}] \doteq [X_3] \;\}$$

El tipo del término (antes de unificar) es $\tau_b = [X_3]$.

*Unificación paso a paso:*

| Paso | Regla | Efecto sobre $E$ | $S$ acumulada |
|---|---|---|---|
| 1 | *decompose* $[\cdot]$ | $[X_2]\doteq[X_1] \rightsquigarrow X_2 \doteq X_1$ | $id$ |
| 2 | *elim* $X_2 := X_1$ | se borra la ecuación | $\{X_2 := X_1\}$ |
| 3 | *elim* $X_h := \text{Nat}$ | $[X_1]\doteq[X_h] \rightsquigarrow [X_1] \doteq [\text{Nat}]$ | $+\{X_h := \text{Nat}\}$ |
| 4 | *decompose* + *elim* $X_1 := \text{Nat}$ | (arrastra $X_2 := \text{Nat}$) | $+\{X_1 := \text{Nat}\}$ |
| 5 | *elim* $X_r := [\text{Bool}]$ | $X_r \doteq [X_3] \rightsquigarrow [\text{Bool}] \doteq [X_3]$ | $+\{X_r := [\text{Bool}]\}$ |
| 6 | *decompose* + *swap* + *elim* $X_3 := \text{Bool}$ | $E = \emptyset$ | $+\{X_3 := \text{Bool}\}$ |

$$S = \{\, X_1 := \text{Nat},\; X_2 := \text{Nat},\; X_3 := \text{Bool},\; X_h := \text{Nat},\; X_r := [\text{Bool}] \,\}$$

Aplicando $S$ al tipo $[X_3]$ y al contexto $\Gamma_0$:

$$\boxed{\;\{x : \text{Nat}\} \vdash \text{foldr } x :: []_{\text{Nat}} \text{ base}\leadsto []_{\text{Bool}};\; \text{rec}(h,r)\leadsto \text{isZero}(h) :: r \;:\; [\text{Bool}]\;}$$

**Verificación semántica.** El término es el `map isZero` aplicado a la lista de un elemento $[x]$: recorre $[x] : [\text{Nat}]$, arranca de $[] : [\text{Bool}]$ y en cada paso hace `cons` de $\text{isZero}(h) : \text{Bool}$ sobre el acumulado $r : [\text{Bool}]$. Resultado $[\text{isZero}(x)] : [\text{Bool}]$ ✓. Notar cómo la restricción $X_h \doteq \text{Nat}$, nacida dentro del **paso recursivo**, viaja vía $\tau \doteq [X_h]$ hasta el contexto y fuerza $x : \text{Nat}$ — es el mismo fenómeno que en el Ejercicio 9.II.

**Chuleta**
> 1. Tipos: $\sigma ::= \dots \mid [\sigma]$. → 2. $\mathcal{I}(\Gamma\mid[]) = ([X]\mid\emptyset)$ con $X$ **fresca** (¡una fresca por cada `[]` que aparezca!). → 3. $\mathcal{I}(\Gamma\mid M_1 :: M_2) = ([\tau_1] \mid E_1\cup E_2\cup\{\tau_2 \doteq [\tau_1]\})$ — la **cola** debe ser lista de la **cabeza**. → 4. `foldr` ⟹ **tres** ecuaciones con $X_h, X_r$ frescas: $\tau_{lista} \doteq [X_h]$, $X_r \doteq \tau_{base}$, $\tau_{rec} \doteq \tau_{base}$; el tipo del `foldr` es $\tau_{base}$. → 5. El paso recursivo se analiza en $\Gamma, h{:}X_h, r{:}X_r$. → 6. Regla mnemotécnica: **$h$ tiene el tipo de los elementos, $r$ el del resultado**; base, $r$ y paso recursivo comparten tipo. → 7. Unificar con *decompose* para $[\cdot]$ y aplicar $S$ al tipo **y** al contexto (las restricciones del paso recursivo suelen fijar el tipo de las variables libres).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/inferencia_algoritmo_w]]
