---
nombre: Lógica de Primer Orden — Guia de Ejercicios
parcial: 2P
programa: 2C_2026
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
Aridades declaradas: $d$ de aridad 0 (constante), $f$ de aridad 2, $g$ de aridad 3. Un término se forma **sólo** con variables o con $h(t_1, \dots, t_n)$ donde $h \in \mathcal{F}$ y la aridad de $h$ es **exactamente** $n$.

| # | Cadena | ¿Término? | Motivo |
|---|---|---|---|
| i | $g(d, d)$ | ❌ No | $g$ tiene aridad 3 y recibe 2 argumentos |
| ii | $f(X, g(Y, Z), d)$ | ❌ No | $f$ tiene aridad 2 y recibe 3 argumentos (y además $g$ recibe 2) |
| iii | $g(X, f(d, Z), d)$ | ✅ Sí | todas las aridades cierran |
| iv | $g(X, h(Y, Z), d)$ | ❌ No | $h \notin \mathcal{F}$ (símbolo no declarado) |
| v | $f(f(g(d, X), \dots), g(f(d,d,X), d), Z)$ | ❌ No | múltiples violaciones de aridad |

**Verificación bottom-up del ítem iii** — *por qué: los términos se definen inductivamente, así que se chequea de las hojas a la raíz.*

1. $X$ es una variable → es término.
2. $d$ es símbolo de función de aridad 0 → $d$ es término (constante).
3. $Z$ es una variable → es término.
4. $f(d, Z)$: $f$ tiene aridad 2 y recibe los términos $d$ y $Z$ → es término.
5. $g(X, f(d,Z), d)$: $g$ tiene aridad 3 y recibe los términos $X$, $f(d,Z)$, $d$ → **es término**. $\checkmark$

**Desarme del ítem v** — basta una violación para que toda la cadena falle; acá hay siete:

$$f(\underbrace{f(g(d, X),\ f(g(d, X), Y, g(Y, d)),\ g(d, d))}_{\text{arg}_1},\ \underbrace{g(f(d, d, X), d)}_{\text{arg}_2},\ \underbrace{Z}_{\text{arg}_3})$$

| Subcadena | Problema |
|---|---|
| $f(\dots, \dots, \dots)$ más externo | $f$ es binaria y recibe 3 argumentos |
| $f(g(d,X), f(\dots), g(d,d))$ | $f$ binaria con 3 argumentos |
| $g(d, X)$ | $g$ ternaria con 2 argumentos |
| $f(g(d,X), Y, g(Y,d))$ | $f$ binaria con 3 argumentos |
| $g(Y, d)$ | $g$ ternaria con 2 argumentos |
| $g(d, d)$ | $g$ ternaria con 2 argumentos |
| $f(d, d, X)$ y $g(f(d,d,X), d)$ | $f$ binaria con 3 args; $g$ ternaria con 2 args |

**Conclusión:** el único término sobre $\mathcal{F}$ es el **ítem iii**.

**Chuleta**
> 1. Anotar la aridad de cada símbolo ($d/0$, $f/2$, $g/3$) → 2. Recorrer el árbol **bottom-up**: las hojas deben ser variables o constantes → 3. En cada nodo chequear (a) que el símbolo pertenezca a $\mathcal{F}$ y (b) que $\#\text{args} = \text{aridad}$ → 4. Una sola violación invalida toda la cadena → 5. Acá sólo sobrevive iii; v cae por el primer $f$ con 3 argumentos.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 2 — Fórmulas
**Enunciado**
Sean $c$ una constante, $f$ un símbolo de función de aridad 1 y $S$ y $B$, dos símbolos de predicado binarios. ¿Cuáles de las siguientes cadenas son fórmulas?
I. $S(c, X)$ | II. $B(c, f(c))$ | III. $f(c)$ | IV. $B(B(c, X), Y)$ | V. $S(B(c), Z)$ | VI. $(B(X, Y) \Rightarrow (\exists Z.S(Z, Y)))$ | VII. $(S(X, Y) \Rightarrow S(Y, f(f(X))))$ | VIII. $B(X, Y) \Rightarrow f(X)$ | IX. $S(X, f(Y)) \wedge B(X, Y)$ | X. $\forall X.B(X, f(X))$ | XI. $\exists X.B(Y, X(c))$

**Explicación**
Las fórmulas se construyen a partir de predicados (que toman términos como argumentos) y conectivos lógicos. No se pueden anidar predicados dentro de otros predicados ni funciones que devuelvan fórmulas.

**Resolución paso a paso**
Reglas en juego: un **término** se arma con variables y símbolos de función; una **fórmula atómica** es $P(t_1, \dots, t_n)$ con $P$ predicado y los $t_i$ **términos**. Por lo tanto:

- un predicado **nunca** puede ser argumento de otro predicado ni de una función,
- un término **nunca** es por sí solo una fórmula,
- una variable **nunca** puede usarse como símbolo de función.

Datos: $c$ constante (aridad 0), $f$ función de aridad 1, $S$ y $B$ predicados binarios.

| # | Cadena | ¿Fórmula? | Motivo |
|---|---|---|---|
| i | $S(c, X)$ | ✅ Sí | $S$ binario aplicado a los términos $c$ y $X$ |
| ii | $B(c, f(c))$ | ✅ Sí | $f(c)$ es término ($f$ unaria) y $B$ es binario |
| iii | $f(c)$ | ❌ No | es un **término**, no una fórmula: falta un predicado |
| iv | $B(B(c, X), Y)$ | ❌ No | $B(c,X)$ es una fórmula, no un término → no puede ser argumento de $B$ |
| v | $S(B(c), Z)$ | ❌ No | doble error: $B$ es binario y recibe 1 argumento, y un predicado no es término |
| vi | $(B(X, Y) \Rightarrow (\exists Z. S(Z, Y)))$ | ✅ Sí | conectivo $\Rightarrow$ entre dos fórmulas; $\exists Z$ cuantifica una fórmula |
| vii | $(S(X, Y) \Rightarrow S(Y, f(f(X))))$ | ✅ Sí | $f(f(X))$ es término bien formado ($f$ unaria anidada) |
| viii | $B(X, Y) \Rightarrow f(X)$ | ❌ No | el consecuente $f(X)$ es un término, no una fórmula |
| ix | $S(X, f(Y)) \wedge B(X, Y)$ | ✅ Sí | conjunción de dos fórmulas atómicas |
| x | $\forall X. B(X, f(X))$ | ✅ Sí | cuantificación de una fórmula atómica |
| xi | $\exists X. B(Y, X(c))$ | ❌ No | $X(c)$ usa una **variable** como símbolo de función (eso sería lógica de orden superior) |

**Criterio operativo** — *por qué: la gramática de LPO tiene dos niveles disjuntos.*

$$\underbrace{t ::= X \mid f(t_1,\dots,t_n)}_{\text{nivel término}} \qquad\qquad \underbrace{\sigma ::= P(t_1,\dots,t_n) \mid \perp \mid \sigma \Rightarrow \sigma \mid \dots \mid \forall X.\sigma \mid \exists X.\sigma}_{\text{nivel fórmula}}$$

Los niveles sólo se tocan en un punto: los argumentos de un predicado. Todo cruce en el otro sentido (una fórmula usada como argumento, un término usado como fórmula) es un error de sintaxis.

**Fórmulas válidas:** i, ii, vi, vii, ix, x.

**Chuleta**
> 1. Separar los dos niveles: términos (variables + funciones) vs. fórmulas (predicados + conectivos + cuantificadores) → 2. La raíz de una fórmula debe ser un predicado, un conectivo o un cuantificador — nunca una función → 3. Los argumentos de un predicado deben ser todos términos → 4. Chequear aridades igual que en el Ej. 1 → 5. Trampas típicas: predicado adentro de predicado (iv, v), término suelto como fórmula (iii, viii), variable aplicada como función (xi).

**¿Aparece en parciales?** ⚪ No

### Ejercicio 3 — Variables y sustituciones
**Enunciado**
Sea $\sigma = \exists X.P(Y, Z) \land \forall Y.\neg Q(Y, X) \lor P(Y, Z)$
I. Identificar todas las variables libres y ligadas.
II. Calcular $\sigma\{X := W\}$, $\sigma\{Y := W\}$, $\sigma\{Y := f(X)\}$ y $\sigma\{Z := g(Y, Z)\}$.

**Explicación**
Dos mecanismos en juego. **Ligadura:** un cuantificador $\forall X$ / $\exists X$ liga *todas* las ocurrencias de $X$ en su alcance; una ocurrencia que no cae bajo ningún cuantificador de su misma variable es **libre**. **Sustitución:** $\sigma\{X := t\}$ reemplaza únicamente las ocurrencias **libres** de $X$, y debe hacerlo **sin capturar**: si alguna variable libre de $t$ quedaría ligada por un cuantificador del camino, hay que renombrar ese cuantificador (α-conversión) antes de sustituir.

**Resolución paso a paso**

**Paso 0 — desambiguar el alcance.** El enunciado no tiene paréntesis, así que hay que fijar la convención de precedencia. Se usa la habitual: $\neg$ liga más fuerte que $\land$, que liga más fuerte que $\lor$, y **el alcance de un cuantificador se extiende lo más a la derecha posible**. Con eso:

$$\sigma \;=\; \exists X.\Big(P(Y, Z) \;\land\; \forall Y.\big(\neg Q(Y, X) \;\lor\; P(Y, Z)\big)\Big)$$

Árbol de alcances (numerando las ocurrencias de izquierda a derecha):

| Ocurrencia | Está bajo | Estado |
|---|---|---|
| $Y$ en $P(Y,Z)$ (1ª) | sólo $\exists X$ | **libre** |
| $Z$ en $P(Y,Z)$ (1ª) | sólo $\exists X$ | **libre** |
| $Y$ en $Q(Y,X)$ | $\exists X$, $\forall Y$ | **ligada** por $\forall Y$ |
| $X$ en $Q(Y,X)$ | $\exists X$, $\forall Y$ | **ligada** por $\exists X$ |
| $Y$ en $P(Y,Z)$ (2ª) | $\exists X$, $\forall Y$ | **ligada** por $\forall Y$ |
| $Z$ en $P(Y,Z)$ (2ª) | $\exists X$, $\forall Y$ | **libre** |

**I. Variables libres y ligadas**

- $fv(\sigma) = \{Y, Z\}$ — la $Y$ de la primera $P$ y las dos $Z$.
- Variables ligadas: $X$ (por $\exists X$, en $Q(Y,X)$) y $Y$ (por $\forall Y$, en $Q(Y,X)$ y en la segunda $P$).
- Nótese que $Y$ aparece **libre y ligada a la vez** en $\sigma$: son ocurrencias distintas de la misma variable. Esto es legal y es justamente lo que hace interesante el ítem II.

**II. Las cuatro sustituciones**

**(a) $\sigma\{X := W\}$**

$X$ no tiene **ninguna** ocurrencia libre en $\sigma$ (la única ocurrencia, en $Q(Y,X)$, está ligada por $\exists X$). Una sustitución sólo toca ocurrencias libres, así que no hay nada que reemplazar:

$$\sigma\{X := W\} \;=\; \sigma \;=\; \exists X.\big(P(Y, Z) \land \forall Y.(\neg Q(Y, X) \lor P(Y, Z))\big)$$

**(b) $\sigma\{Y := W\}$**

Hay una sola $Y$ libre: la de la primera $P$. Se reemplaza por $W$; la $Y$ de $Q$ y la de la segunda $P$ **no se tocan** (están ligadas por $\forall Y$). ¿Captura? $fv(W) = \{W\}$ y $W$ no es ligada por ningún cuantificador del camino ($\exists X$), así que no hace falta renombrar:

$$\sigma\{Y := W\} \;=\; \exists X.\big(P(W, Z) \land \forall Y.(\neg Q(Y, X) \lor P(Y, Z))\big)$$

**(c) $\sigma\{Y := f(X)\}$**

Misma única ocurrencia libre de $Y$, pero ahora $fv(f(X)) = \{X\}$ y la ocurrencia libre de $Y$ está **dentro del alcance de $\exists X$**. Sustituir a lo bruto daría $\exists X.(P(f(X), Z) \land \dots)$, donde esa $X$ —que venía libre desde afuera— quedaría **capturada** por $\exists X$. Hay que α-convertir el cuantificador a una variable fresca $X'$ (fresca = no aparece ni en $\sigma$ ni en $f(X)$):

1. α-conversión: $\sigma \;=_\alpha\; \exists X'.\big(P(Y, Z) \land \forall Y.(\neg Q(Y, X') \lor P(Y, Z))\big)$
2. Ahora sí, sustituir la $Y$ libre:

$$\sigma\{Y := f(X)\} \;=\; \exists X'.\big(P(f(X), Z) \land \forall Y.(\neg Q(Y, X') \lor P(Y, Z))\big)$$

La $X$ de $f(X)$ queda libre en el resultado, como debe ser: $fv(\sigma\{Y := f(X)\}) = \{X, Z\}$.

**(d) $\sigma\{Z := g(Y, Z)\}$**

$Z$ tiene **dos** ocurrencias libres, y están en contextos distintos:

- La primera ($P(Y,Z)$ inicial) está fuera del alcance de $\forall Y$. Ahí $g(Y,Z)$ entra tal cual: su $Y$ sigue siendo la $Y$ libre de afuera. ✔
- La segunda ($P(Y,Z)$ dentro de $\forall Y$) sí está bajo $\forall Y$, y $Y \in fv(g(Y,Z))$ → **captura**. Hay que renombrar $\forall Y$ a $Y'$ fresca.

1. α-conversión del cuantificador conflictivo: $\sigma \;=_\alpha\; \exists X.\big(P(Y, Z) \land \forall Y'.(\neg Q(Y', X) \lor P(Y', Z))\big)$
2. Sustituir las dos $Z$ libres:

$$\sigma\{Z := g(Y, Z)\} \;=\; \exists X.\big(P(Y, g(Y, Z)) \land \forall Y'.(\neg Q(Y', X) \lor P(Y', g(Y, Z)))\big)$$

Chequeo: $fv$ del resultado $= \{Y, Z\}$, y la $Y$ que entró por $g$ sigue apuntando a la $Y$ de afuera en **ambas** posiciones. Si no se hubiera renombrado, la segunda quedaría diciendo "para todo $Y$, ... $P(Y, g(Y,Z))$", que es una fórmula distinta.

⚠️ Verificar — la desambiguación del Paso 0. Si la cátedra usa la convención de **alcance mínimo** (el cuantificador liga sólo la fórmula atómica inmediata), el parseo sería $(\exists X.P(Y,Z)) \land (\forall Y.\neg Q(Y,X)) \lor P(Y,Z)$ y entonces: la $X$ de $Q(Y,X)$ pasaría a ser **libre** (con lo cual $\sigma\{X := W\}$ ya no sería la identidad), y la tercera $P(Y,Z)$ quedaría totalmente afuera, con su $Y$ libre. Conviene confirmar con el apunte de la materia cuál convención se asume; acá se tomó la estándar (alcance máximo a la derecha), que es la que hace que aparezcan los dos casos de captura del ítem II.

**Chuleta**
> 1. Antes que nada, **poner los paréntesis**: $\neg > \land > \lor > \Rightarrow$ y cuantificador con alcance máximo hacia la derecha → 2. Marcar cada ocurrencia de variable como libre/ligada bajando por el árbol y anotando qué cuantificadores están "abiertos" → 3. Una misma variable puede tener ocurrencias libres y ligadas a la vez → 4. $\sigma\{X := t\}$ toca **sólo las libres**; si $X$ no tiene ocurrencias libres, la sustitución es la identidad → 5. Antes de sustituir, comparar $fv(t)$ con las variables ligadas del camino: si se cruzan, **α-convertir a variable fresca** y recién ahí sustituir → 6. Verificación final: $fv(\sigma\{X := t\}) = (fv(\sigma) \setminus \{X\}) \cup fv(t)$ si $X \in fv(\sigma)$.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 4 — Sustituciones complejas
**Enunciado**
Dada $\sigma = \neg\forall X.(\exists Y.P(X, Y, Z)) \land \forall Z.P(X, Y, Z)$
I. Identificar todas las variables libres y ligadas.
II. Calcular $\sigma\{X := t\}$, $\sigma\{Y := t\}$ y $\sigma\{Z := t\}$ con $t = g(f(g(Y, Y)), Y)$.
III. Calcular $\sigma\{X := t,\ Y := t,\ Z := t\}$ con $t = g(f(g(Y, Y)), Y)$.
IV. Calcular $\sigma(\{X := t\} \circ \{Y := t\} \circ \{Z := t\})$ con $t = g(f(g(Y, Y)), Y)$.

**Explicación**
Es el Ejercicio 3 subido de nivel, y el ejercicio existe para exhibir **una sola cosa**: sustituir las tres variables *a la vez* no es lo mismo que sustituirlas *una después de la otra*. La razón es que el término $t$ que se inyecta contiene a $Y$, que es una de las variables que se están sustituyendo. En la sustitución **simultánea** cada ocurrencia libre se reemplaza por $t$ y ahí termina: lo que entró con $t$ ya no se vuelve a mirar. En la **composición** cada paso vuelve a recorrer todo el resultado del paso anterior, incluidas las copias de $t$ que dejó el paso previo, y las sustituciones se anidan. Además, la $Y$ de $t$ obliga a α-convertir el $\exists Y$ en el único punto donde habría captura.

**Resolución paso a paso**

**Paso 0 — desambiguar el alcance.** Con la convención estándar ($\neg$ liga más fuerte que $\land$, y el $\forall X$ tiene su cuerpo explícitamente entre paréntesis) la fórmula se parsea como una **conjunción de dos conjuntos disjuntos de cuantificadores**:

$$\sigma \;=\; \underbrace{\neg\forall X.\big(\exists Y.P(X, Y, Z)\big)}_{\text{conjunto izquierdo}} \;\land\; \underbrace{\forall Z.P(X, Y, Z)}_{\text{conjunto derecho}}$$

Esto es clave: cada conjunto cuantifica variables **distintas**, y por eso las tres variables aparecen libres en un lado y ligadas en el otro.

Abreviatura para todo el ejercicio:

$$t \;=\; g(f(g(Y, Y)), Y) \qquad fv(t) = \{Y\}$$

**I. Variables libres y ligadas**

| Ocurrencia | Está bajo | Estado |
|---|---|---|
| $X$ en $P(X,Y,Z)$ (izq.) | $\forall X$, $\exists Y$ | **ligada** por $\forall X$ |
| $Y$ en $P(X,Y,Z)$ (izq.) | $\forall X$, $\exists Y$ | **ligada** por $\exists Y$ |
| $Z$ en $P(X,Y,Z)$ (izq.) | $\forall X$, $\exists Y$ | **libre** |
| $X$ en $P(X,Y,Z)$ (der.) | $\forall Z$ | **libre** |
| $Y$ en $P(X,Y,Z)$ (der.) | $\forall Z$ | **libre** |
| $Z$ en $P(X,Y,Z)$ (der.) | $\forall Z$ | **ligada** por $\forall Z$ |

- $fv(\sigma) = \{X, Y, Z\}$ — la $Z$ del conjunto izquierdo, y la $X$ y la $Y$ del derecho.
- Variables ligadas: $X$ (por $\forall X$), $Y$ (por $\exists Y$) y $Z$ (por $\forall Z$), todas en el conjunto donde su cuantificador está abierto.
- Las **tres** variables tienen simultáneamente ocurrencias libres y ligadas. Cada una de las sustituciones de abajo va a tocar exactamente **una** ocurrencia.

**II. Las tres sustituciones simples**

**(a) $\sigma\{X := t\}$**

Única ocurrencia libre de $X$: la del conjunto derecho. Camino hasta ella: $\forall Z$. ¿Captura? $fv(t) = \{Y\}$ y $Y \neq Z$ → no hay conflicto, se sustituye directo. El $X$ del conjunto izquierdo está ligado por $\forall X$ y **no se toca**.

$$\sigma\{X := t\} \;=\; \neg\forall X.\big(\exists Y.P(X, Y, Z)\big) \land \forall Z.P\big(g(f(g(Y, Y)), Y),\ Y,\ Z\big)$$

**(b) $\sigma\{Y := t\}$**

Única ocurrencia libre de $Y$: la del conjunto derecho. Camino: $\forall Z$ → sin captura. La $Y$ del conjunto izquierdo está ligada por $\exists Y$ → intacta.

$$\sigma\{Y := t\} \;=\; \neg\forall X.\big(\exists Y.P(X, Y, Z)\big) \land \forall Z.P\big(X,\ g(f(g(Y, Y)), Y),\ Z\big)$$

**(c) $\sigma\{Z := t\}$ — acá sí hay captura**

Única ocurrencia libre de $Z$: la del conjunto **izquierdo**, y su camino es $\forall X$, $\exists Y$. Como $Y \in fv(t)$, meter $t$ ahí a lo bruto dejaría las tres $Y$ de $t$ atrapadas por el $\exists Y$. Hay que α-convertir:

1. α-conversión (variable fresca $Y'$, que no aparece ni en $\sigma$ ni en $t$):
   $$\sigma \;=_\alpha\; \neg\forall X.\big(\exists Y'.P(X, Y', Z)\big) \land \forall Z.P(X, Y, Z)$$
2. Ahora sí, reemplazar la $Z$ libre. La $Z$ del conjunto derecho está ligada por $\forall Z$ → no se toca.

$$\sigma\{Z := t\} \;=\; \neg\forall X.\big(\exists Y'.P(X, Y', g(f(g(Y, Y)), Y))\big) \land \forall Z.P(X, Y, Z)$$

Chequeo: $fv$ del resultado $= \{X, Y\}$ — la $Z$ libre desapareció y entró la $Y$ de $t$, libre como corresponde. Sin el renombre habría quedado "existe $Y$ tal que $P(X, Y, g(f(g(Y,Y)),Y))$", que dice otra cosa.

**III. La sustitución simultánea $\sigma\{X := t,\ Y := t,\ Z := t\}$**

Regla: se localizan **todas** las ocurrencias libres de $X$, $Y$ y $Z$ **en la fórmula original**, y se reemplazan **en un solo paso**. Lo que entra con $t$ es resultado final: no se vuelve a recorrer.

1. Ocurrencias libres a reemplazar: la $Z$ del conjunto izquierdo, y la $X$ y la $Y$ del derecho (las tres identificadas en I).
2. Captura: sólo la del conjunto izquierdo está bajo $\exists Y$ con $Y \in fv(t)$ → α-convertir $\exists Y \leadsto \exists Y'$. El lado derecho está bajo $\forall Z$ y $Z \notin fv(t)$ → sin conflicto.
3. Reemplazo simultáneo:

$$\sigma\{X := t, Y := t, Z := t\} \;=\; \neg\forall X.\big(\exists Y'.P(X, Y', t)\big) \land \forall Z.P(t, t, Z)$$

Es decir, escrito completo:

$$\neg\forall X.\Big(\exists Y'.P\big(X,\ Y',\ g(f(g(Y, Y)), Y)\big)\Big) \land \forall Z.P\big(g(f(g(Y, Y)), Y),\ g(f(g(Y, Y)), Y),\ Z\big)$$

Observar que las tres copias de $t$ son **iguales entre sí** y quedaron exactamente como estaban: la $Y$ que trajo cada $t$ nunca fue candidata a ser sustituida, porque las ocurrencias libres se fijaron *antes* de reemplazar nada.

**IV. La composición $\sigma(\{X := t\} \circ \{Y := t\} \circ \{Z := t\})$**

Convención usada: $\circ$ es la composición de funciones habitual, o sea **se aplica primero la de más a la derecha**:

$$\sigma\big(\rho_1 \circ \rho_2 \circ \rho_3\big) \;=\; \big(\big(\sigma\rho_3\big)\rho_2\big)\rho_1 \;=\; \Big(\big(\sigma\{Z := t\}\big)\{Y := t\}\Big)\{X := t\}$$

**Paso 1 — $\sigma\{Z := t\}$.** Ya está calculado en II(c):

$$\sigma_1 \;=\; \neg\forall X.\big(\exists Y'.P(X, Y', t)\big) \land \forall Z.P(X, Y, Z)$$

Y acá está el nudo del ejercicio: $\sigma_1$ **ahora tiene $Y$ libre dentro del conjunto izquierdo** (las tres $Y$ que trajo $t$), cosa que $\sigma$ no tenía.

**Paso 2 — $\sigma_1\{Y := t\}$.** Las ocurrencias libres de $Y$ en $\sigma_1$ son ahora **cuatro**: las tres de adentro de $t$ (izq.) más la del conjunto derecho. Las de la izquierda están bajo $\exists Y'$, y $Y' \neq Y \notin$ conflicto, así que no hace falta renombrar de nuevo. Cada $Y$ de $t$ se reemplaza por $t$, produciendo el término anidado

$$t' \;:=\; t\{Y := t\} \;=\; g\Big(f\big(g(t,\, t)\big),\ t\Big) \;=\; g\Big(f\big(g(g(f(g(Y,Y)),Y),\, g(f(g(Y,Y)),Y))\big),\ g(f(g(Y,Y)),Y)\Big)$$

$$\sigma_2 \;=\; \neg\forall X.\big(\exists Y'.P(X, Y', t')\big) \land \forall Z.P(X, t, Z)$$

**Paso 3 — $\sigma_2\{X := t\}$.** Única $X$ libre: la del conjunto derecho (la de la izquierda sigue ligada por $\forall X$). Bajo $\forall Z$, sin captura:

$$\boxed{\;\sigma\big(\{X := t\} \circ \{Y := t\} \circ \{Z := t\}\big) \;=\; \neg\forall X.\big(\exists Y'.P(X, Y', t')\big) \land \forall Z.P(t, t, Z)\;}$$

**La comparación, que es el punto del ejercicio**

| | conjunto izquierdo | conjunto derecho |
|---|---|---|
| III — simultánea | $\exists Y'.P(X, Y', \mathbf{t})$ | $P(\mathbf{t}, \mathbf{t}, Z)$ |
| IV — composición | $\exists Y'.P(X, Y', \mathbf{t'})$ | $P(\mathbf{t}, \mathbf{t}, Z)$ |

Difieren en el conjunto izquierdo: $t$ contra $t'$. El motivo, en una línea: **la composición sustituye dentro de lo que ella misma acaba de insertar.** El paso $\{Z := t\}$ dejó tres $Y$ libres nuevas, y el paso siguiente $\{Y := t\}$ —que en la fórmula original no tenía nada que hacer de ese lado— las agarra y las expande. La simultánea no puede hacer eso por construcción. En general, para sustituciones cuyos términos mencionan variables del propio dominio:

$$\sigma\{X_1 := t_1, \dots, X_n := t_n\} \;\neq\; \sigma\big(\{X_1 := t_1\} \circ \dots \circ \{X_n := t_n\}\big)$$

y sólo coinciden cuando ningún $t_i$ contiene alguna $X_j$ del dominio (acá $t$ contiene a $Y$, y $Y$ está en el dominio → difieren).

**Vista alternativa: la composición como una sola sustitución.** Se puede colapsar $\rho = \{X := t\} \circ \{Y := t\} \circ \{Z := t\}$ evaluándola variable por variable ($\rho(V) = \{X:=t\}(\{Y:=t\}(\{Z:=t\}(V)))$):

- $Z \mapsto t \mapsto t\{Y:=t\} = t' \mapsto t'$ (no hay $X$ en $t'$) $\Rightarrow Z \mapsto t'$
- $Y \mapsto Y \mapsto t \mapsto t$ $\Rightarrow Y \mapsto t$
- $X \mapsto X \mapsto X \mapsto t$ $\Rightarrow X \mapsto t$

O sea $\rho = \{X := t,\ Y := t,\ Z := t'\}$ como sustitución simultánea, que aplicada a $\sigma$ da justo el resultado del recuadro. Es la forma rápida de resolver el ítem IV sin arrastrar la fórmula tres veces.

⚠️ Verificar — el **orden de la composición**. Acá se tomó $\circ$ como composición de funciones (primero la de la derecha, $\{Z := t\}$). Si la cátedra la lee de izquierda a derecha (primero $\{X := t\}$), el cómputo es simétrico y da

$$\neg\forall X.\big(\exists Y'.P(X, Y', t)\big) \land \forall Z.P(t', t, Z)$$

—el anidamiento $t'$ se muda al conjunto derecho, porque ahora es $\{X := t\}$ el que deja $Y$ libres nuevas y $\{Y := t\}$ el que las expande. En los dos órdenes la conclusión del ejercicio es la misma (composición $\neq$ simultánea), pero el término anidado cambia de lugar; conviene confirmar la convención con el apunte antes de entregarlo.

⚠️ Verificar — el **parseo del Paso 0**. Se asumió que el $\neg$ y el $\forall X$ alcanzan sólo al primer conjunto, respetando el paréntesis explícito del enunciado. Con la convención de alcance máximo a la derecha se leería $\neg\forall X.\big((\exists Y.P(X,Y,Z)) \land \forall Z.P(X,Y,Z)\big)$, y entonces la $X$ del conjunto derecho pasaría a estar **ligada**, con lo cual $fv(\sigma) = \{Y, Z\}$ y $\sigma\{X := t\}$ sería la identidad. La lectura de arriba es la que hace que los cuatro ítems tengan contenido (y que III y IV difieran), así que es casi seguramente la buscada.

**Chuleta**
> 1. Parsear y separar los conjuntos de cuantificadores; una misma variable puede estar libre en un conjunto y ligada en otro → 2. Listar las ocurrencias **libres** de cada variable del dominio: son las únicas que se tocan → 3. Antes de cada reemplazo, cruzar $fv(t)$ con los cuantificadores del camino; si se cruzan, **α-convertir a fresca** → 4. **Simultánea** $\{X_1 := t_1, \dots\}$: se fijan todas las posiciones sobre la fórmula original y se reemplaza de una; lo insertado no se vuelve a mirar → 5. **Composición** $\rho_1 \circ \rho_2$: se aplica $\rho_2$, y después $\rho_1$ recorre **todo el resultado**, incluidos los términos que metió $\rho_2$ → 6. Difieren en cuanto algún $t_i$ mencione una variable del dominio; si ningún $t_i$ lo hace, coinciden → 7. Truco: colapsar la composición a una sustitución simultánea aplicándola variable por variable, y recién ahí aplicarla una sola vez.

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
**Convención de trabajo:** $a$ y $c$ son constantes; $X, Y, Z$ variables; $f, g$ funciones; $P, Q$ predicados. Se toman las variables con el **mismo nombre como la misma variable** en ambas filas (es la lectura literal del enunciado y la que hace interesantes los fallos por *occurs-check*).

Fila 1: $P(f(X))$, $P(a)$, $P(Y)$, $Q(X,f(Y))$, $Q(X,f(Z))$, $Q(X,f(a))$, $X$, $f(X)$.
Fila 2: $P(X)$, $P(f(a))$, $P(g(Z))$, $Q(f(Y),X)$, $Q(f(Y),f(X))$, $Q(f(Y),Y)$, $f(f(c))$, $f(g(Y))$.

**Pares que unifican (con su $mgu$)**

| Fila 1 | Fila 2 | $mgu$ | Derivación breve |
|---|---|---|---|
| $P(f(X))$ | $P(f(a))$ | $\{X := a\}$ | *decompose* $P$, *decompose* $f$, queda $X \doteq a$ |
| $P(a)$ | $P(X)$ | $\{X := a\}$ | *decompose*, *swap* ($a \doteq X \to X \doteq a$) |
| $P(Y)$ | $P(X)$ | $\{Y := X\}$ | *decompose*, *elim* (cualquiera de las dos orientaciones sirve) |
| $P(Y)$ | $P(f(a))$ | $\{Y := f(a)\}$ | *decompose*, *elim* ($Y \notin fv(f(a))$) |
| $P(Y)$ | $P(g(Z))$ | $\{Y := g(Z)\}$ | *decompose*, *elim* |
| $Q(X,f(Y))$ | $Q(f(Y),X)$ | $\{X := f(Y)\}$ | ver derivación (A) |
| $Q(X,f(Z))$ | $Q(f(Y),X)$ | $\{X := f(Y),\ Z := Y\}$ | ver derivación (B) |
| $Q(X,f(Z))$ | $Q(f(Y),f(X))$ | $\{X := f(Y),\ Z := f(Y)\}$ | *decompose* $Q$; $X \doteq f(Y)$, $Z \doteq X$ |
| $Q(X,f(Z))$ | $Q(f(Y),Y)$ | $\{X := f(f(Z)),\ Y := f(Z)\}$ | $X \doteq f(Y)$, $f(Z) \doteq Y$ → *swap* + *elim* |
| $Q(X,f(a))$ | $Q(f(Y),X)$ | $\{X := f(a),\ Y := a\}$ | $X \doteq f(Y)$, $f(a) \doteq X$ → $f(a) \doteq f(Y)$ → $Y \doteq a$ |
| $Q(X,f(a))$ | $Q(f(Y),Y)$ | $\{X := f(f(a)),\ Y := f(a)\}$ | $X \doteq f(Y)$, $f(a) \doteq Y$ → *swap* + *elim* |
| $X$ | $f(f(c))$ | $\{X := f(f(c))\}$ | *elim* directo ($X \notin fv(f(f(c)))$) |
| $X$ | $f(g(Y))$ | $\{X := f(g(Y))\}$ | *elim* directo |
| $f(X)$ | $f(f(c))$ | $\{X := f(c)\}$ | *decompose* $f$, *elim* |
| $f(X)$ | $f(g(Y))$ | $\{X := g(Y)\}$ | *decompose* $f$, *elim* |

**(A) $Q(X, f(Y))$ vs. $Q(f(Y), X)$**

1. $E_0 = \{Q(X, f(Y)) \doteq Q(f(Y), X)\}$
2. *decompose* ($Q$ vs. $Q$, aridad 2): $E_1 = \{X \doteq f(Y),\ f(Y) \doteq X\}$
3. *elim* con $X := f(Y)$ — chequeo previo: $X \notin fv(f(Y)) = \{Y\}$ $\checkmark$. Aplicando la sustitución al resto: $E_2 = \{X \doteq f(Y),\ f(Y) \doteq f(Y)\}$
4. *decompose* + *delete* sobre $f(Y) \doteq f(Y)$: $E_3 = \{X \doteq f(Y)\}$
5. Forma resuelta → $mgu = \{X := f(Y)\}$. Verificación: ambos lados quedan $Q(f(Y), f(Y))$ $\checkmark$

**(B) $Q(X, f(Z))$ vs. $Q(f(Y), X)$**

1. $E_0 = \{Q(X, f(Z)) \doteq Q(f(Y), X)\}$
2. *decompose*: $E_1 = \{X \doteq f(Y),\ f(Z) \doteq X\}$
3. *elim* con $X := f(Y)$ ($X \notin fv(f(Y))$ $\checkmark$): $E_2 = \{X \doteq f(Y),\ f(Z) \doteq f(Y)\}$
4. *decompose*: $E_3 = \{X \doteq f(Y),\ Z \doteq Y\}$
5. Forma resuelta → $mgu = \{X := f(Y),\ Z := Y\}$. Verificación: ambos lados quedan $Q(f(Y), f(Y))$ $\checkmark$

**Pares que NO unifican (y por qué)**

| Fila 1 | Fila 2 | Falla | Detalle |
|---|---|---|---|
| $P(f(X))$ | $P(X)$ | **occurs-check** | *decompose* deja $f(X) \doteq X$ → *swap* → $X \doteq f(X)$ con $X \in fv(f(X))$ |
| $P(f(X))$ | $P(g(Z))$ | **clash** | $f \neq g$ |
| $P(a)$ | $P(f(a))$ | **clash** | constante $a$ contra función $f$ |
| $P(a)$ | $P(g(Z))$ | **clash** | constante $a$ contra función $g$ |
| $Q(X,f(Y))$ | $Q(f(Y),f(X))$ | **occurs-check** | $\{X \doteq f(Y),\ Y \doteq X\}$ → *elim* → $Y \doteq f(Y)$ |
| $Q(X,f(Y))$ | $Q(f(Y),Y)$ | **occurs-check** | $f(Y) \doteq Y$ → *swap* → $Y \doteq f(Y)$ |
| $Q(X,f(a))$ | $Q(f(Y),f(X))$ | **clash** | queda $X \doteq a$ y $X \doteq f(Y)$ → $a \doteq f(Y)$ |
| $X$ | $P(X)$, $Q(\dots)$ | **categoría** | un término no unifica con una fórmula atómica (y además habría occurs-check) |
| $P(\dots)$ | $Q(\dots)$, $f(\dots)$ | **clash** | símbolos de cabeza distintos |

⚠️ Verificar — si la cátedra pide **renombrar las variables de cada fila** antes de unificar (*standardizing apart*, como hace Prolog), los tres fallos por occurs-check pasan a ser exitosos: p. ej. $P(f(X))$ vs. $P(X')$ da $mgu = \{X' := f(X)\}$. La resolución de arriba usa la lectura literal (variables compartidas), que es la que hace que el ejercicio tenga fallos interesantes.

**Chuleta**
> 1. Comparar los símbolos de cabeza: distintos → **clash**, iguales → *decompose* → 2. Ecuación $t \doteq X$ con $t$ no variable → *swap* → 3. Ecuación $X \doteq t$: chequear $X \in fv(t)$ → si sí, **occurs-check**, si no, *elim* (sustituir $X$ en todo el resto) → 4. Repetir hasta forma resuelta $\{X_1 \doteq t_1, \dots\}$ con $X_i$ distintas y ausentes de los $t_j$ → 5. Ese conjunto **es** el $mgu$ → 6. Verificar siempre aplicando la sustitución a ambos lados.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_unificacion]]

### Ejercicio 6 — Algoritmo de unificación
**Enunciado**
Determinar, para cada uno de los siguientes pares de términos de primer orden, si son unificables o no. En cada caso justificar la respuesta exhibiendo una secuencia exitosa o fallida (según el caso) del algoritmo de **Martelli-Montanari**. Asimismo, en caso de que los términos sean unificables, indicar el $mgu$ (*most general unifier*).
Notación: $X, Y, Z$ variables; $a, b, c$ constantes; $f, g$ símbolos de función.
I. $f(X, X, Y)$ y $f(a, b, Z)$
II. $Y$ y $f(X)$
III. $f(g(c, Y), X)$ y $f(Z, g(Z, a))$
IV. $f(a)$ y $g(Y)$
V. $f(X)$ y $X$
VI. $g(X, Y)$ y $g(f(Y), f(X))$

**Explicación**
Martelli-Montanari resuelve la unificación como un sistema de ecuaciones $E = \{s_1 \doteq t_1, \dots\}$ que se va reescribiendo hasta llegar a **forma resuelta** ($E = \{X_1 \doteq u_1, \dots, X_n \doteq u_n\}$ con las $X_i$ distintas entre sí y sin aparecer en ningún $u_j$) o a **fallo**. Las reglas:

| Regla | De | A | Condición |
|---|---|---|---|
| *delete* | $\{t \doteq t\} \cup E$ | $E$ | — |
| *decompose* | $\{f(s_1..s_n) \doteq f(t_1..t_n)\} \cup E$ | $\{s_1 \doteq t_1, \dots, s_n \doteq t_n\} \cup E$ | mismo símbolo y aridad |
| *swap* | $\{t \doteq X\} \cup E$ | $\{X \doteq t\} \cup E$ | $t$ no es variable |
| *elim* | $\{X \doteq t\} \cup E$ | $\{X \doteq t\} \cup E\{X := t\}$ | $X \notin fv(t)$, $X$ ocurre en $E$ |
| **clash** | $\{f(\dots) \doteq g(\dots)\} \cup E$ | ⊥ | $f \neq g$ o aridades distintas |
| **occurs-check** | $\{X \doteq t\} \cup E$ | ⊥ | $X \in fv(t)$, $t \neq X$ |

Si se llega a forma resuelta, ese conjunto **es** el $mgu$ (leyendo $\doteq$ como $:=$). Las constantes son funciones de aridad $0$, así que $a \doteq b$ cae en *clash*. Y las variables de los dos términos se toman **compartidas** (mismo nombre = misma variable): es lo que hace que los ítems V y VI fallen.

**Resolución paso a paso**

**I. $f(X, X, Y)$ vs. $f(a, b, Z)$ → NO unifican (*clash*)**

1. $E_0 = \{f(X, X, Y) \doteq f(a, b, Z)\}$
2. *decompose* ($f$ vs. $f$, aridad 3 ✔): $E_1 = \{X \doteq a,\ X \doteq b,\ Y \doteq Z\}$
3. *elim* con $X := a$ — chequeo: $X \notin fv(a) = \emptyset$ ✔. Se propaga a las demás ecuaciones: $E_2 = \{X \doteq a,\ a \doteq b,\ Y \doteq Z\}$
4. $a \doteq b$: dos constantes distintas (símbolos de aridad $0$ con nombre distinto) → **clash** → ⊥

Intuición: la primera componente obliga a $X = a$ y la segunda a $X = b$; una variable no puede valer dos constantes distintas a la vez. (La tercera ecuación $Y \doteq Z$ sí era resoluble, pero alcanza con que una falle.)

**II. $Y$ vs. $f(X)$ → unifican, $mgu = \{Y := f(X)\}$**

1. $E_0 = \{Y \doteq f(X)\}$
2. Ya está con la variable a izquierda, así que va *elim* directo. Chequeo de ocurrencia: $Y \notin fv(f(X)) = \{X\}$ ✔ (son variables **distintas**; si el enunciado dijera $X$ y $f(X)$ esto sería el ítem V).
3. No hay otras ecuaciones donde propagar: $E_1 = \{Y \doteq f(X)\}$, que ya es forma resuelta.

$$mgu = \{Y := f(X)\}$$

Verificación: $Y\{Y := f(X)\} = f(X)$ y $f(X)\{Y := f(X)\} = f(X)$ ✔ (la $X$ queda libre, sin instanciar: eso es exactamente lo que hace que el unificador sea el **más general**).

**III. $f(g(c, Y), X)$ vs. $f(Z, g(Z, a))$ → unifican**

1. $E_0 = \{f(g(c, Y), X) \doteq f(Z, g(Z, a))\}$
2. *decompose* ($f$ vs. $f$, aridad 2 ✔): $E_1 = \{g(c, Y) \doteq Z,\ X \doteq g(Z, a)\}$
3. *swap* sobre la primera ($g(c,Y)$ no es variable): $E_2 = \{Z \doteq g(c, Y),\ X \doteq g(Z, a)\}$
4. *elim* con $Z := g(c, Y)$ — chequeo: $Z \notin fv(g(c,Y)) = \{Y\}$ ✔. Se propaga a la segunda ecuación: $E_3 = \{Z \doteq g(c, Y),\ X \doteq g(g(c, Y), a)\}$
5. *elim* con $X := g(g(c,Y), a)$ — chequeo: $X \notin fv(g(g(c,Y),a)) = \{Y\}$ ✔. No queda dónde propagar.
6. $E_4 = \{Z \doteq g(c,Y),\ X \doteq g(g(c,Y), a)\}$: variables de la izquierda distintas ($Z$, $X$) y ninguna aparece a la derecha → **forma resuelta**.

$$mgu = \{Z := g(c, Y),\ X := g(g(c, Y), a)\}$$

Verificación aplicando el $mgu$ a ambos lados:
- $f(g(c,Y), X) \leadsto f\big(g(c,Y),\ g(g(c,Y), a)\big)$
- $f(Z, g(Z,a)) \leadsto f\big(g(c,Y),\ g(g(c,Y), a)\big)$ ✔

Notar que $Y$ **no** se instancia: sobrevive como variable en el $mgu$, que es la marca de que la solución no está sobre-especializada.

**IV. $f(a)$ vs. $g(Y)$ → NO unifican (*clash*)**

1. $E_0 = \{f(a) \doteq g(Y)\}$
2. Los dos son términos con símbolo de función en la cabeza, pero $f \neq g$ → **clash** inmediato → ⊥

No hay nada que decomponer: la unificación es *estructural*, y ninguna sustitución puede cambiar el símbolo de cabeza de un término que no es una variable. (De paso, las aridades también difieren, $1$ vs. $1$ acá coinciden, pero bastaba con el nombre distinto.)

**V. $f(X)$ vs. $X$ → NO unifican (*occurs-check*)**

1. $E_0 = \{f(X) \doteq X\}$
2. *swap* ($f(X)$ no es variable): $E_1 = \{X \doteq f(X)\}$
3. *elim* requiere $X \notin fv(f(X))$, pero $fv(f(X)) = \{X\}$ → **occurs-check** → ⊥

Intuición: cualquier unificador $\theta$ tendría que cumplir $\theta(X) = f(\theta(X))$, o sea un término estrictamente más grande que sí mismo — imposible entre términos **finitos**. (Sobre términos infinitos/racionales sí existe la solución $X = f(f(f(\dots)))$; por eso Prolog, que por defecto omite el occurs-check, "resuelve" `X = f(X)` y arma una estructura cíclica.)

**VI. $g(X, Y)$ vs. $g(f(Y), f(X))$ → NO unifican (*occurs-check*)**

1. $E_0 = \{g(X, Y) \doteq g(f(Y), f(X))\}$
2. *decompose* ($g$ vs. $g$, aridad 2 ✔): $E_1 = \{X \doteq f(Y),\ Y \doteq f(X)\}$
3. *elim* con $X := f(Y)$ — chequeo: $X \notin fv(f(Y)) = \{Y\}$ ✔. Se propaga a la segunda: $E_2 = \{X \doteq f(Y),\ Y \doteq f(f(Y))\}$
4. Sobre $Y \doteq f(f(Y))$: $Y \in fv(f(f(Y)))$ → **occurs-check** → ⊥

Es el mismo fenómeno del ítem V, pero **diferido**: ninguna ecuación individual de $E_1$ es cíclica; la circularidad recién aparece después de propagar. Moraleja: el occurs-check hay que chequearlo en **cada** *elim*, no sólo al principio.

**Resumen**

| Ítem | Par | ¿Unifican? | $mgu$ / causa de falla |
|---|---|---|---|
| I | $f(X,X,Y)$, $f(a,b,Z)$ | ❌ | **clash** $a \doteq b$ (tras *decompose* + *elim*) |
| II | $Y$, $f(X)$ | ✔ | $\{Y := f(X)\}$ |
| III | $f(g(c,Y),X)$, $f(Z,g(Z,a))$ | ✔ | $\{Z := g(c,Y),\ X := g(g(c,Y),a)\}$ |
| IV | $f(a)$, $g(Y)$ | ❌ | **clash** $f \neq g$ (inmediato) |
| V | $f(X)$, $X$ | ❌ | **occurs-check** $X \doteq f(X)$ (inmediato) |
| VI | $g(X,Y)$, $g(f(Y),f(X))$ | ❌ | **occurs-check** $Y \doteq f(f(Y))$ (diferido) |

Los seis ítems están elegidos para cubrir el mapa completo de resultados: éxito trivial (II), éxito con propagación (III), clash inmediato (IV), clash diferido (I), occurs-check inmediato (V) y occurs-check diferido (VI).

⚠️ Verificar — en el ítem III el enunciado original trae un paréntesis de más (`f(g(c, Y), X))`); se leyó como $f(g(c,Y),\, X)$, que es la única lectura que respeta la aridad 2 de $f$ que exige el otro término $f(Z, g(Z,a))$.

**Chuleta**
> 1. Armar $E$ con la(s) ecuación(es) y no perder de vista que las variables homónimas son **la misma** variable → 2. Cabezas distintas (o aridades distintas) entre dos no-variables → **clash**, se corta → 3. Cabezas iguales → *decompose* argumento a argumento → 4. $t \doteq X$ con $t$ no variable → *swap* → 5. $X \doteq t$: **siempre** chequear $X \in fv(t)$ antes de eliminar; si está → **occurs-check**, si no → *elim* y **propagar $\{X := t\}$ a todas las demás ecuaciones** → 6. Repetir hasta forma resuelta o ⊥ → 7. Forma resuelta = $mgu$; las variables que no quedaron a la izquierda **no se instancian** (eso es "más general") → 8. Verificar siempre aplicando el $mgu$ a los dos términos y comprobando que dan idénticos.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_unificacion]]

### Ejercicio 7 — Propiedades de la unificación
**Enunciado**
Preguntas para pensar.
I. La relación entre términos "unifica con", ¿es reflexiva? ¿Es simétrica? ¿Es transitiva?
II. ¿Existe algún término $t$ tal que todo término $s$ unifique con él?
III. ¿Cómo aplicaría el algoritmo de unificación al problema de determinar si, dado un conjunto finito de términos, existe un unificador común a todos?

**Explicación**
Ejercicio conceptual sobre la relación $t \sim s$ definida como "$\exists \theta$ sustitución tal que $t\theta = s\theta$". Las dos primeras propiedades salen gratis de la definición; la tercera **no vale**, y entender por qué no vale es lo que evita el error clásico de unificar de a pares y creer que eso da un unificador común. El ítem III es la reparación de ese error: no se encadena de a dos, se resuelve **un solo sistema** con todas las ecuaciones juntas.

Convención (la misma del Ejercicio 6): las variables son **compartidas** entre los términos que se comparan; términos **finitos**; unificador $\theta$ = sustitución que iguala.

**Resolución paso a paso**

**I. Reflexividad, simetría y transitividad de $\sim$**

**Reflexiva: SÍ.** Para todo término $t$, la sustitución identidad $\varepsilon$ cumple $t\varepsilon = t = t\varepsilon$. En términos del algoritmo: $E_0 = \{t \doteq t\}$ se descarta con la regla *delete* en un paso y queda $E_1 = \emptyset$, que es forma resuelta con $mgu = \varepsilon$. No hay excepciones ni casos raros.

**Simétrica: SÍ.** La definición es una igualdad, y la igualdad es simétrica: si $\theta$ cumple $t\theta = s\theta$, esa **misma** $\theta$ cumple $s\theta = t\theta$. O sea que $t \sim s \iff s \sim t$, y además el conjunto de unificadores de $\{t \doteq s\}$ y el de $\{s \doteq t\}$ son literalmente **el mismo conjunto**, así que también comparten $mgu$ (a lo sumo el algoritmo lo alcanza por un camino distinto, insertando un *swap*). Por eso la ecuación se escribe $\doteq$ y no $\to$: no tiene orientación.

**Transitiva: NO.** Contraejemplo mínimo, con $a$ y $b$ constantes distintas:

$$a \sim X \quad (\theta = \{X := a\}) \qquad\text{y}\qquad X \sim b \quad (\theta = \{X := b\}) \qquad\text{pero}\qquad a \not\sim b \quad (\textbf{clash})$$

Otro con símbolos de función, por si se quiere algo menos degenerado: $f(X) \sim Y$ (con $\{Y := f(X)\}$) e $Y \sim g(Z)$ (con $\{Y := g(Z)\}$), pero $f(X) \not\sim g(Z)$ porque $f \neq g$.

La razón de fondo: una variable unifica con casi cualquier cosa, pero **cada unificación usa una sustitución distinta**. Que exista $\theta_1$ con $t_1\theta_1 = t_2\theta_1$ y $\theta_2$ con $t_2\theta_2 = t_3\theta_2$ no dice nada sobre la existencia de una **única** $\theta$ que sirva para las dos igualdades a la vez. Las variables actúan de "comodín" y el comodín puede rellenarse de forma incompatible en cada paso.

Conclusión: $\sim$ es **reflexiva y simétrica pero no transitiva**, o sea es una relación de *tolerancia*, **no** una relación de equivalencia. Corolario práctico: no existen "clases de unificabilidad"; no se puede particionar el conjunto de términos por esta relación.

**II. ¿Hay un $t$ que unifique con todo $s$?**

**Respuesta corta: no, pero por poco — y el "por poco" es exactamente el occurs-check.**

Primero se descartan los candidatos obvios. Si $t$ **no** es una variable, tiene un símbolo de cabeza $f$ de aridad $n$, y ninguna sustitución puede cambiarlo (las sustituciones sólo reemplazan variables, nunca reescriben la estructura). Entonces basta tomar $s = g(\dots)$ con $g \neq f$ (o el mismo $f$ con otra aridad, si el lenguaje lo permite) para obtener un **clash**. Descartados todos los términos no-variables.

Queda el caso $t = X$, una variable. Casi funciona: para todo $s$ con $X \notin fv(s)$ vale $X \sim s$ con $mgu = \{X := s\}$, en un solo paso de *elim*. Pero justamente:

$$s = f(X) \;\Longrightarrow\; \{X \doteq f(X)\} \;\Longrightarrow\; \textbf{occurs-check} \;\Longrightarrow\; X \not\sim f(X)$$

Así que tampoco una variable unifica con **absolutamente todo**. Como $t$ es o bien variable o bien no-variable, y los dos casos fallan:

$$\text{No existe } t \text{ tal que } \forall s.\ t \sim s$$

El enunciado preciso que sí es verdadero, y es el que conviene recordar:

> Una variable $X$ unifica con **todo término $s$ que no la contenga**, con $mgu = \{X := s\}$. Equivalentemente: si se renombran las variables de los dos términos para que sean disjuntas (*standardizing apart*, que es lo que hace Prolog al tomar una cláusula del programa), entonces una variable fresca unifica con cualquier término, y ahí la respuesta al ítem pasa a ser **sí**.

⚠️ Verificar — la respuesta de este ítem **depende de la convención** sobre las variables. Con variables compartidas (la lectura literal, usada acá y en el Ejercicio 6) la respuesta es **no**, por el occurs-check contra $f(X)$. Con *standardizing apart* previo la respuesta es **sí**, y el testigo es cualquier variable. Vale la pena escribir las dos en el parcial: la gracia del ejercicio es notar que el occurs-check es lo único que separa un caso del otro.

**III. Unificador común de un conjunto finito de términos**

Dado $T = \{t_1, t_2, \dots, t_n\}$, se busca decidir si existe $\theta$ con $t_1\theta = t_2\theta = \dots = t_n\theta$.

**Idea:** no hace falta modificar el algoritmo. Martelli-Montanari ya trabaja sobre **conjuntos de ecuaciones**, no sobre un par de términos, así que alcanza con darle el conjunto correcto.

**Procedimiento (cadena):**

1. Construir el sistema con $n - 1$ ecuaciones encadenadas:
   $$E = \{\, t_1 \doteq t_2,\ t_2 \doteq t_3,\ \dots,\ t_{n-1} \doteq t_n \,\}$$
2. Correr Martelli-Montanari sobre $E$ **entero, de una sola vez**.
3. Si termina en forma resuelta → existe unificador común, y la forma resuelta **es el $mgu$ del conjunto**. Si termina en ⊥ (clash u occurs-check) → no existe ninguno.

**Por qué es correcto.** Una sustitución $\theta$ resuelve $E$ $\iff$ $t_i\theta = t_{i+1}\theta$ para todo $i$ $\iff$ (por transitividad de la **igualdad** — que sí vale, a diferencia de la transitividad de $\sim$) $t_1\theta = \dots = t_n\theta$ $\iff$ $\theta$ es unificador común de $T$. O sea: el conjunto de soluciones de $E$ **es** el conjunto de unificadores comunes de $T$; y como MM devuelve un $mgu$ del sistema cuando hay solución, ese $mgu$ es el más general de todos los unificadores comunes.

**Variante equivalente (estrella):** $E' = \{t_1 \doteq t_2,\ t_1 \doteq t_3,\ \dots,\ t_1 \doteq t_n\}$. Mismo conjunto de soluciones, mismo resultado; sirve cualquier grafo conexo sobre los $t_i$ (hacen falta exactamente $n-1$ ecuaciones si no se quieren repetir).

**Variante incremental**, útil si se quiere reusar una implementación que sólo unifica **de a dos**:

1. $\theta_1 := mgu(t_1, t_2)$; si falla, cortar con "no unificable".
2. Para $i = 3 \dots n$: $\theta_{i-1} := mgu\big(t_1\theta_{i-2},\ t_i\theta_{i-2}\big) \circ \theta_{i-2}$; si algún paso falla, cortar.
3. El resultado final $\theta_{n-1}$ es un $mgu$ de $T$.

El punto crítico acá es el **$\circ$**: hay que aplicar el acumulado a $t_i$ antes de unificar, y componer el nuevo $mgu$ con el viejo. Si en cambio se unificara cada par $(t_i, t_{i+1})$ por separado y se pretendiera que todos unifiquen $\Rightarrow$ existe un unificador común, se estaría usando justamente la transitividad que el ítem I demostró **falsa**: con $T = \{a, X, b\}$ los dos pares consecutivos unifican y sin embargo no hay unificador común (habría que mandar $X$ a $a$ y a $b$ a la vez). Ese es el error que el ejercicio quiere que no se cometa.

**Casos borde:** $n = 0$ y $n = 1$ son trivialmente unificables con $\theta = \varepsilon$ (el sistema $E$ queda vacío). El costo es el de **una sola** corrida de MM sobre un sistema de tamaño $O(\sum_i |t_i|)$, no $n$ corridas independientes.

**Chuleta**
> 1. $\sim$ es **reflexiva** ($\varepsilon$, vía *delete*) y **simétrica** ($\doteq$ no tiene orientación; el *swap* es sólo cosmético) → 2. **NO es transitiva**: $a \sim X$, $X \sim b$, pero $a \not\sim b$. No es relación de equivalencia, es de tolerancia → 3. Motivo: cada unificación usa **su propia** sustitución; el comodín $X$ se rellena distinto en cada paso → 4. Ningún $t$ unifica con todo: si no es variable, muere por **clash** contra otra cabeza; si es la variable $X$, muere por **occurs-check** contra $f(X)$ → 5. Lo que sí vale: $X$ unifica con todo $s$ tal que $X \notin fv(s)$, con $mgu = \{X := s\}$ → 6. Unificador común de $\{t_1, \dots, t_n\}$: armar $E = \{t_1 \doteq t_2, \dots, t_{n-1} \doteq t_n\}$ y correr MM **una sola vez** sobre todo $E$ → 7. Nunca unificar de a pares por separado y sumar los resultados: eso es asumir transitividad, que es falsa.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 8 — Unificación de tipos
**Enunciado**
Sean las constantes $\text{Nat}$ y $\text{Bool}$ y la función binaria $\to$ (representada como un operador infijo). Determinar el resultado de aplicar el algoritmo MGU (*most general unifier*) sobre las siguientes ecuaciones. En caso de tener éxito, mostrar la sustitución resultante.
I. $\text{MGU } \{T_1 \to T_2 \doteq \text{Nat} \to \text{Bool}\}$
II. $\text{MGU } \{T_1 \to T_2 \doteq T_3\}$
III. $\text{MGU } \{T_1 \to T_2 \doteq T_2\}$
IV. $\text{MGU } \{(T_2 \to T_1) \to \text{Bool} \doteq T_2 \to T_3\}$
V. $\text{MGU } \{T_2 \to T_1 \to \text{Bool} \doteq T_2 \to T_3\}$
VI. $\text{MGU } \{T_1 \to \text{Bool} \doteq \text{Nat} \to \text{Bool},\ T_1 \doteq T_2 \to T_3\}$
VII. $\text{MGU } \{T_1 \to \text{Bool} \doteq \text{Nat} \to \text{Bool},\ T_2 \doteq T_1 \to T_1\}$
VIII. $\text{MGU } \{T_1 \to T_2 \doteq T_3 \to T_4,\ T_3 \doteq T_2 \to T_1\}$

**Explicación**
Aplicación del algoritmo de unificación al sistema de tipos flecha, fundamental para la inferencia.

**Resolución paso a paso**
Símbolos: constantes $\text{Nat}$ y $\text{Bool}$ (aridad 0), función binaria infija $\to$. Recordar que $\to$ **asocia a derecha**: $T_2 \to T_1 \to \text{Bool}$ es $T_2 \to (T_1 \to \text{Bool})$.

**i.** $\{T_1 \to T_2 \doteq \text{Nat} \to \text{Bool}\}$

1. *decompose* ($\to$ vs. $\to$): $\{T_1 \doteq \text{Nat},\ T_2 \doteq \text{Bool}\}$
2. Forma resuelta. **Éxito**: $mgu = \{T_1 := \text{Nat},\ T_2 := \text{Bool}\}$

**ii.** $\{T_1 \to T_2 \doteq T_3\}$

1. *swap* (el lado derecho es variable y el izquierdo no): $\{T_3 \doteq T_1 \to T_2\}$
2. Occurs-check: $T_3 \notin fv(T_1 \to T_2) = \{T_1, T_2\}$ $\checkmark$
3. **Éxito**: $mgu = \{T_3 := T_1 \to T_2\}$

**iii.** $\{T_1 \to T_2 \doteq T_2\}$

1. *swap*: $\{T_2 \doteq T_1 \to T_2\}$
2. Occurs-check: $T_2 \in fv(T_1 \to T_2)$ ✗
3. **Falla** por *occurs-check*. Intuición: sería un tipo infinito $T_2 = T_1 \to (T_1 \to (T_1 \to \dots))$.

**iv.** $\{(T_2 \to T_1) \to \text{Bool} \doteq T_2 \to T_3\}$

1. *decompose* en el $\to$ más externo: $\{T_2 \to T_1 \doteq T_2,\ \text{Bool} \doteq T_3\}$
2. *swap* en la primera: $\{T_2 \doteq T_2 \to T_1,\ \dots\}$
3. Occurs-check: $T_2 \in fv(T_2 \to T_1)$ ✗
4. **Falla** por *occurs-check*.

**v.** $\{T_2 \to T_1 \to \text{Bool} \doteq T_2 \to T_3\}$, es decir $\{T_2 \to (T_1 \to \text{Bool}) \doteq T_2 \to T_3\}$

1. *decompose*: $\{T_2 \doteq T_2,\ T_1 \to \text{Bool} \doteq T_3\}$
2. *delete* sobre $T_2 \doteq T_2$: $\{T_1 \to \text{Bool} \doteq T_3\}$
3. *swap*: $\{T_3 \doteq T_1 \to \text{Bool}\}$, con $T_3 \notin fv(T_1 \to \text{Bool})$ $\checkmark$
4. **Éxito**: $mgu = \{T_3 := T_1 \to \text{Bool}\}$

Comparar con **iv**: el paréntesis explícito es lo único que cambia, y hace la diferencia entre fallar y unificar.

**vi.** $\{T_1 \to \text{Bool} \doteq \text{Nat} \to \text{Bool},\ T_1 \doteq T_2 \to T_3\}$

1. *decompose* en la primera: $\{T_1 \doteq \text{Nat},\ \text{Bool} \doteq \text{Bool},\ T_1 \doteq T_2 \to T_3\}$
2. *delete*: $\{T_1 \doteq \text{Nat},\ T_1 \doteq T_2 \to T_3\}$
3. *elim* con $T_1 := \text{Nat}$: $\{T_1 \doteq \text{Nat},\ \text{Nat} \doteq T_2 \to T_3\}$
4. *swap*: $\{T_1 \doteq \text{Nat},\ T_2 \to T_3 \doteq \text{Nat}\}$ → cabeza $\to$ contra cabeza $\text{Nat}$
5. **Falla** por *clash*.

**vii.** $\{T_1 \to \text{Bool} \doteq \text{Nat} \to \text{Bool},\ T_2 \doteq T_1 \to T_1\}$

1. *decompose* + *delete* en la primera: $\{T_1 \doteq \text{Nat},\ T_2 \doteq T_1 \to T_1\}$
2. *elim* con $T_1 := \text{Nat}$: $\{T_1 \doteq \text{Nat},\ T_2 \doteq \text{Nat} \to \text{Nat}\}$
3. Occurs-check sobre $T_2$: $T_2 \notin fv(\text{Nat} \to \text{Nat})$ $\checkmark$
4. **Éxito**: $mgu = \{T_1 := \text{Nat},\ T_2 := \text{Nat} \to \text{Nat}\}$

**viii.** $\{T_1 \to T_2 \doteq T_3 \to T_4,\ T_3 \doteq T_2 \to T_1\}$

1. *decompose* en la primera: $\{T_1 \doteq T_3,\ T_2 \doteq T_4,\ T_3 \doteq T_2 \to T_1\}$
2. *elim* con $T_1 := T_3$: la tercera pasa a $T_3 \doteq T_2 \to T_3$
3. Occurs-check: $T_3 \in fv(T_2 \to T_3)$ ✗
4. **Falla** por *occurs-check*. (La otra orientación, $T_3 := T_1$, da $T_1 \doteq T_2 \to T_1$ y falla igual: el resultado de la unificación no depende del orden en que se aplican las reglas.)

**Resumen**

| # | Resultado | $mgu$ / causa de falla |
|---|---|---|
| i | ✅ Éxito | $\{T_1 := \text{Nat},\ T_2 := \text{Bool}\}$ |
| ii | ✅ Éxito | $\{T_3 := T_1 \to T_2\}$ |
| iii | ❌ Falla | occurs-check |
| iv | ❌ Falla | occurs-check |
| v | ✅ Éxito | $\{T_3 := T_1 \to \text{Bool}\}$ |
| vi | ❌ Falla | clash ($\to$ vs. $\text{Nat}$) |
| vii | ✅ Éxito | $\{T_1 := \text{Nat},\ T_2 := \text{Nat} \to \text{Nat}\}$ |
| viii | ❌ Falla | occurs-check |

**Chuleta**
> 1. Parentizar primero: $\to$ asocia a **derecha** → 2. Mismo constructor en ambos lados → *decompose* (izq con izq, der con der) → 3. $\text{Nat}$/$\text{Bool}$ contra $\to$ → **clash** → 4. Variable contra tipo → occurs-check y *elim* (propagar la sustitución a las ecuaciones restantes, incluidas las que faltan procesar) → 5. Occurs-check fallido = **tipo infinito** = programa mal tipado (`x x`) → 6. Éxitos: i, ii, v, vii. Fallas: iii, iv, viii (occurs), vi (clash).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

---

## DEDUCCIÓN NATURAL

### Ejercicio 9 — Deducción Natural
**Enunciado**
Demostrar en deducción natural que vale $\vdash \sigma$ para cada una de las siguientes fórmulas, **sin usar principios de razonamiento clásicos** (salvo indicación contraria).
Incluye: Diagonal, De Morgan (casos intuicionistas), Intercambio de cuantificadores, Drinker's Principle (clásico).

**Explicación**
Uso de las reglas de introducción y eliminación para $\forall$ y $\exists$. Atención a las restricciones de las variables frescas en $\forall I$ y $\exists E$.

**Resolución paso a paso**
**Reglas usadas** (de [[logica_de_primer_orden_teoria]] y [[sistemas_deductivos_y_deduccion_natural_teoria]]):

$$\frac{\Gamma \vdash \sigma}{\Gamma \vdash \forall X.\sigma}\ \forall i \quad (X \notin fv(\Gamma)) \qquad \frac{\Gamma \vdash \forall X.\sigma}{\Gamma \vdash \sigma\{X := t\}}\ \forall e$$

$$\frac{\Gamma \vdash \sigma\{X := t\}}{\Gamma \vdash \exists X.\sigma}\ \exists i \qquad \frac{\Gamma \vdash \exists X.\sigma \quad \Gamma, \sigma \vdash \tau}{\Gamma \vdash \tau}\ \exists e \quad (X \notin fv(\Gamma, \tau))$$

Las dos restricciones de **variable propia** son lo único que hay que vigilar: $\forall i$ exige que $X$ no esté libre en las hipótesis; $\exists e$ exige que $X$ no esté libre ni en las hipótesis ni en la conclusión. En todos los ítems de abajo las hipótesis son fórmulas **cerradas**, así que $fv(\Gamma) = \emptyset$ y las restricciones se verifican trivialmente — pero **siempre hay que escribir el chequeo**.

Recordar que $\sigma \Leftrightarrow \tau$ abrevia $(\sigma \Rightarrow \tau) \wedge (\tau \Rightarrow \sigma)$: cada doble implicación son **dos** derivaciones cerradas con $\wedge i$.

---

**i. Intercambio $(\forall)$: $\forall X.\forall Y.P(X,Y) \Leftrightarrow \forall Y.\forall X.P(X,Y)$**

Dirección $\Rightarrow$. Sea $\Gamma = \{\forall X.\forall Y.P(X,Y)\}$, con $fv(\Gamma) = \emptyset$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \forall X.\forall Y.P(X,Y)$ | $ax$ |
| 2 | $\Gamma \vdash \forall Y.P(X,Y)$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\Gamma \vdash P(X,Y)$ | $\forall e$ con $t := Y$ sobre 2 |
| 4 | $\Gamma \vdash \forall X.P(X,Y)$ | $\forall i$ sobre 3 |
| 5 | $\Gamma \vdash \forall Y.\forall X.P(X,Y)$ | $\forall i$ sobre 4 |
| 6 | $\vdash \forall X.\forall Y.P(X,Y) \Rightarrow \forall Y.\forall X.P(X,Y)$ | $\Rightarrow i$ sobre 5 |

*Restricciones:* paso 4 requiere $X \notin fv(\Gamma) = \emptyset$ $\checkmark$; paso 5 requiere $Y \notin fv(\Gamma) = \emptyset$ $\checkmark$.

La dirección $\Leftarrow$ es idéntica intercambiando los roles de $X$ e $Y$. Se cierra con $\wedge i$.

---

**ii. Intercambio $(\exists)$: $\exists X.\exists Y.P(X,Y) \Leftrightarrow \exists Y.\exists X.P(X,Y)$**

Dirección $\Rightarrow$. Sea $\Gamma = \{\exists X.\exists Y.P(X,Y)\}$ y $\Delta = \Gamma, \exists Y.P(X,Y)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \exists X.\exists Y.P(X,Y)$ | $ax$ |
| 2 | $\Delta \vdash \exists Y.P(X,Y)$ | $ax$ |
| 3 | $\Delta, P(X,Y) \vdash P(X,Y)$ | $ax$ |
| 4 | $\Delta, P(X,Y) \vdash \exists X.P(X,Y)$ | $\exists i$ con $t := X$ sobre 3 |
| 5 | $\Delta, P(X,Y) \vdash \exists Y.\exists X.P(X,Y)$ | $\exists i$ con $t := Y$ sobre 4 |
| 6 | $\Delta \vdash \exists Y.\exists X.P(X,Y)$ | $\exists e$ sobre 2 y 5 |
| 7 | $\Gamma \vdash \exists Y.\exists X.P(X,Y)$ | $\exists e$ sobre 1 y 6 |
| 8 | $\vdash \exists X.\exists Y.P(X,Y) \Rightarrow \exists Y.\exists X.P(X,Y)$ | $\Rightarrow i$ sobre 7 |

*Restricciones:* paso 6 elimina $\exists Y$ y requiere $Y \notin fv(\Delta, \tau)$ — se tiene $fv(\Delta) = fv(\exists Y.P(X,Y)) = \{X\}$ y $\tau = \exists Y.\exists X.P(X,Y)$ es cerrada $\checkmark$. Paso 7 elimina $\exists X$ y requiere $X \notin fv(\Gamma, \tau) = \emptyset$ $\checkmark$.

---

**iii. Intercambio $(\exists/\forall)$: $\exists X.\forall Y.P(X,Y) \Rightarrow \forall Y.\exists X.P(X,Y)$**

Sea $\Gamma = \{\exists X.\forall Y.P(X,Y)\}$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \exists X.\forall Y.P(X,Y)$ | $ax$ |
| 2 | $\Gamma, \forall Y.P(X,Y) \vdash \forall Y.P(X,Y)$ | $ax$ |
| 3 | $\Gamma, \forall Y.P(X,Y) \vdash P(X,Y)$ | $\forall e$ con $t := Y$ sobre 2 |
| 4 | $\Gamma, \forall Y.P(X,Y) \vdash \exists X.P(X,Y)$ | $\exists i$ con $t := X$ sobre 3 |
| 5 | $\Gamma \vdash \exists X.P(X,Y)$ | $\exists e$ sobre 1 y 4 |
| 6 | $\Gamma \vdash \forall Y.\exists X.P(X,Y)$ | $\forall i$ sobre 5 |
| 7 | $\vdash \exists X.\forall Y.P(X,Y) \Rightarrow \forall Y.\exists X.P(X,Y)$ | $\Rightarrow i$ sobre 6 |

*Restricciones:* paso 5 requiere $X \notin fv(\Gamma, \exists X.P(X,Y))$: $\Gamma$ es cerrada y en $\exists X.P(X,Y)$ la $X$ está **ligada** $\checkmark$. Paso 6 requiere $Y \notin fv(\Gamma) = \emptyset$ $\checkmark$.

**La recíproca $\forall Y.\exists X.P(X,Y) \Rightarrow \exists X.\forall Y.P(X,Y)$ NO es derivable.** El intento natural pide aplicar $\exists e$ dejando $X$ libre en la conclusión (o $\forall i$ sobre $Y$ con $X$ dependiendo de $Y$), y ahí es exactamente donde la restricción de variable propia bloquea la derivación. Contramodelo: $D = \mathbb{N}$, $P(x,y) \equiv (x > y)$ — para cada $y$ hay un $x$ mayor, pero no hay un $x$ mayor que todos.

---

**iv. Universal implica existencial: $\forall X.P(X) \Rightarrow \exists X.P(X)$**

| # | Juicio | Regla |
|---|---|---|
| 1 | $\forall X.P(X) \vdash \forall X.P(X)$ | $ax$ |
| 2 | $\forall X.P(X) \vdash P(X)$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\forall X.P(X) \vdash \exists X.P(X)$ | $\exists i$ con $t := X$ sobre 2 |
| 4 | $\vdash \forall X.P(X) \Rightarrow \exists X.P(X)$ | $\Rightarrow i$ sobre 3 |

*Observación:* vale porque en LPO los dominios son **no vacíos** (siempre hay algún término con el cual instanciar en $\forall e$).

---

**v. Diagonal $(\forall)$: $\forall X.\forall Y.P(X,Y) \Rightarrow \forall X.P(X,X)$**

Sea $\Gamma = \{\forall X.\forall Y.P(X,Y)\}$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \forall X.\forall Y.P(X,Y)$ | $ax$ |
| 2 | $\Gamma \vdash \forall Y.P(X,Y)$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\Gamma \vdash P(X,X)$ | $\forall e$ con $t := X$ sobre 2 |
| 4 | $\Gamma \vdash \forall X.P(X,X)$ | $\forall i$ sobre 3 |
| 5 | $\vdash \forall X.\forall Y.P(X,Y) \Rightarrow \forall X.P(X,X)$ | $\Rightarrow i$ sobre 4 |

*Restricción:* paso 4 requiere $X \notin fv(\Gamma) = \emptyset$ $\checkmark$. La clave es **instanciar dos veces con el mismo término** $X$ (pasos 2 y 3) antes de re-generalizar.

---

**vi. Diagonal $(\exists)$: $\exists X.P(X,X) \Rightarrow \exists X.\exists Y.P(X,Y)$**

Sea $\Gamma = \{\exists X.P(X,X)\}$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \exists X.P(X,X)$ | $ax$ |
| 2 | $\Gamma, P(X,X) \vdash P(X,X)$ | $ax$ |
| 3 | $\Gamma, P(X,X) \vdash \exists Y.P(X,Y)$ | $\exists i$ con $t := X$ sobre 2, pues $(\exists Y.P(X,Y))$ tiene cuerpo $P(X,Y)\{Y := X\} = P(X,X)$ |
| 4 | $\Gamma, P(X,X) \vdash \exists X.\exists Y.P(X,Y)$ | $\exists i$ con $t := X$ sobre 3 |
| 5 | $\Gamma \vdash \exists X.\exists Y.P(X,Y)$ | $\exists e$ sobre 1 y 4 |
| 6 | $\vdash \exists X.P(X,X) \Rightarrow \exists X.\exists Y.P(X,Y)$ | $\Rightarrow i$ sobre 5 |

*Restricción:* paso 5 requiere $X \notin fv(\Gamma, \exists X.\exists Y.P(X,Y))$: ambas cerradas $\checkmark$.

---

**vii. de Morgan (I): $\neg\exists X.P(X) \Leftrightarrow \forall X.\neg P(X)$ — ambas direcciones intuicionistas**

Dirección $\Rightarrow$. Sea $\Gamma = \{\neg\exists X.P(X)\}$, cerrada.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma, P(X) \vdash P(X)$ | $ax$ |
| 2 | $\Gamma, P(X) \vdash \exists X.P(X)$ | $\exists i$ con $t := X$ sobre 1 |
| 3 | $\Gamma, P(X) \vdash \neg\exists X.P(X)$ | $ax$ |
| 4 | $\Gamma, P(X) \vdash \perp$ | $\neg e$ sobre 2 y 3 |
| 5 | $\Gamma \vdash \neg P(X)$ | $\neg i$ sobre 4 |
| 6 | $\Gamma \vdash \forall X.\neg P(X)$ | $\forall i$ sobre 5 |
| 7 | $\vdash \neg\exists X.P(X) \Rightarrow \forall X.\neg P(X)$ | $\Rightarrow i$ sobre 6 |

*Restricción:* paso 6 requiere $X \notin fv(\Gamma)$; $fv(\neg\exists X.P(X)) = \emptyset$ $\checkmark$. **Ojo:** el $\neg i$ del paso 5 tiene que hacerse **antes** del $\forall i$, porque mientras $P(X)$ esté en el contexto se tiene $X \in fv(\Gamma, P(X))$ y $\forall i$ estaría prohibido.

Dirección $\Leftarrow$. Sea $\Gamma = \{\forall X.\neg P(X)\}$ y $\Delta = \Gamma, \exists X.P(X)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta \vdash \exists X.P(X)$ | $ax$ |
| 2 | $\Delta, P(X) \vdash \forall X.\neg P(X)$ | $ax$ |
| 3 | $\Delta, P(X) \vdash \neg P(X)$ | $\forall e$ con $t := X$ sobre 2 |
| 4 | $\Delta, P(X) \vdash P(X)$ | $ax$ |
| 5 | $\Delta, P(X) \vdash \perp$ | $\neg e$ sobre 4 y 3 |
| 6 | $\Delta \vdash \perp$ | $\exists e$ sobre 1 y 5 |
| 7 | $\Gamma \vdash \neg\exists X.P(X)$ | $\neg i$ sobre 6 |
| 8 | $\vdash \forall X.\neg P(X) \Rightarrow \neg\exists X.P(X)$ | $\Rightarrow i$ sobre 7 |

*Restricción:* paso 6 requiere $X \notin fv(\Delta, \perp)$: $\forall X.\neg P(X)$ y $\exists X.P(X)$ son cerradas y $fv(\perp) = \emptyset$ $\checkmark$. Se cierra el $\Leftrightarrow$ con $\wedge i$.

---

**viii. de Morgan (II): $\neg\forall X.P(X) \Leftrightarrow \exists X.\neg P(X)$**

Dirección $\Leftarrow$ (**intuicionista**). Sea $\Gamma = \{\exists X.\neg P(X)\}$ y $\Delta = \Gamma, \forall X.P(X)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta \vdash \exists X.\neg P(X)$ | $ax$ |
| 2 | $\Delta, \neg P(X) \vdash \forall X.P(X)$ | $ax$ |
| 3 | $\Delta, \neg P(X) \vdash P(X)$ | $\forall e$ con $t := X$ sobre 2 |
| 4 | $\Delta, \neg P(X) \vdash \neg P(X)$ | $ax$ |
| 5 | $\Delta, \neg P(X) \vdash \perp$ | $\neg e$ sobre 3 y 4 |
| 6 | $\Delta \vdash \perp$ | $\exists e$ sobre 1 y 5 |
| 7 | $\Gamma \vdash \neg\forall X.P(X)$ | $\neg i$ sobre 6 |
| 8 | $\vdash \exists X.\neg P(X) \Rightarrow \neg\forall X.P(X)$ | $\Rightarrow i$ sobre 7 |

*Restricción:* paso 6 requiere $X \notin fv(\Delta, \perp)$; todo cerrado $\checkmark$.

Dirección $\Rightarrow$ (**requiere principios clásicos**). Sea $\Gamma = \{\neg\forall X.P(X)\}$ y $\Delta = \Gamma, \neg\exists X.\neg P(X)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta, \neg P(X) \vdash \neg P(X)$ | $ax$ |
| 2 | $\Delta, \neg P(X) \vdash \exists X.\neg P(X)$ | $\exists i$ con $t := X$ sobre 1 |
| 3 | $\Delta, \neg P(X) \vdash \neg\exists X.\neg P(X)$ | $ax$ |
| 4 | $\Delta, \neg P(X) \vdash \perp$ | $\neg e$ sobre 2 y 3 |
| 5 | $\Delta \vdash P(X)$ | $PBC$ sobre 4 (**clásico**) |
| 6 | $\Delta \vdash \forall X.P(X)$ | $\forall i$ sobre 5 |
| 7 | $\Delta \vdash \neg\forall X.P(X)$ | $ax$ |
| 8 | $\Delta \vdash \perp$ | $\neg e$ sobre 6 y 7 |
| 9 | $\Gamma \vdash \exists X.\neg P(X)$ | $PBC$ sobre 8 (**clásico**) |
| 10 | $\vdash \neg\forall X.P(X) \Rightarrow \exists X.\neg P(X)$ | $\Rightarrow i$ sobre 9 |

*Restricción:* paso 6 requiere $X \notin fv(\Delta)$: $fv(\neg\forall X.P(X)) = fv(\neg\exists X.\neg P(X)) = \emptyset$ $\checkmark$ (nótese que en el paso 5 la hipótesis $\neg P(X)$ ya fue descargada por $PBC$; si siguiera en el contexto, $\forall i$ sería ilegal).

*Por qué es esencialmente clásico:* de $\neg\forall X.P(X)$ sabemos que "no todos cumplen $P$", pero constructivamente eso no produce un **testigo** concreto que falle. Sólo $PBC$/$LEM$ permite pasar de la negación de lo universal a la existencia del contraejemplo.

---

**xiii. Principio del bebedor: $\exists X.(P(X) \Rightarrow \forall X.P(X))$ — clásico**

Como el $\forall X$ interno vuelve a ligar $X$, la fórmula es, salvo $\alpha$-renombre, $\sigma = \exists X.(P(X) \Rightarrow \forall Y.P(Y))$, donde $\forall Y.P(Y)$ es **cerrada**.

Estrategia: $LEM$ sobre $\forall Y.P(Y)$ y $\vee e$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\vdash (\forall Y.P(Y)) \vee \neg(\forall Y.P(Y))$ | $LEM$ (**clásico**) |

*Caso 1:* $\Gamma_1 = \{\forall Y.P(Y)\}$

| # | Juicio | Regla |
|---|---|---|
| 2 | $\Gamma_1, P(X) \vdash \forall Y.P(Y)$ | $ax$ |
| 3 | $\Gamma_1 \vdash P(X) \Rightarrow \forall Y.P(Y)$ | $\Rightarrow i$ sobre 2 |
| 4 | $\Gamma_1 \vdash \exists X.(P(X) \Rightarrow \forall Y.P(Y))$ | $\exists i$ con $t := X$ sobre 3 |

*Caso 2:* $\Gamma_2 = \{\neg\forall Y.P(Y)\}$

| # | Juicio | Regla |
|---|---|---|
| 5 | $\Gamma_2 \vdash \exists Y.\neg P(Y)$ | ítem **viii** dirección $\Rightarrow$ (**clásico**) |
| 6 | $\Gamma_2, \neg P(X), P(X) \vdash P(X)$ | $ax$ |
| 7 | $\Gamma_2, \neg P(X), P(X) \vdash \neg P(X)$ | $ax$ |
| 8 | $\Gamma_2, \neg P(X), P(X) \vdash \perp$ | $\neg e$ sobre 6 y 7 |
| 9 | $\Gamma_2, \neg P(X), P(X) \vdash \forall Y.P(Y)$ | $\perp e$ sobre 8 |
| 10 | $\Gamma_2, \neg P(X) \vdash P(X) \Rightarrow \forall Y.P(Y)$ | $\Rightarrow i$ sobre 9 |
| 11 | $\Gamma_2, \neg P(X) \vdash \exists X.(P(X) \Rightarrow \forall Y.P(Y))$ | $\exists i$ con $t := X$ sobre 10 |
| 12 | $\Gamma_2 \vdash \exists X.(P(X) \Rightarrow \forall Y.P(Y))$ | $\exists e$ sobre 5 y 11 |

*Restricción del paso 12:* elimina $\exists X$ (renombrando la variable ligada de 5 a $X$) y requiere $X \notin fv(\Gamma_2, \sigma)$: $\Gamma_2 = \{\neg\forall Y.P(Y)\}$ es cerrada y en $\sigma$ la $X$ está ligada $\checkmark$.

*Cierre:*

| # | Juicio | Regla |
|---|---|---|
| 13 | $\vdash \exists X.(P(X) \Rightarrow \forall Y.P(Y))$ | $\vee e$ sobre 1, 4 y 12 |

*Lectura:* "en todo bar hay alguien tal que, si esa persona toma, entonces todos toman". Si todos toman, sirve cualquiera; si no, sirve alguno que **no** toma (su antecedente es falso, así que la implicación es verdadera por vacuidad). El razonamiento por casos sobre "todos toman o no" es lo que lo hace irremediablemente clásico.

**Chuleta**
> 1. Mirar el conectivo **principal de la meta** y aplicar su regla de introducción de abajo hacia arriba ($\Rightarrow i$, $\neg i$, $\forall i$, $\wedge i$) → 2. Mirar las **hipótesis** y aplicar eliminaciones ($\forall e$ instancia con el término que necesites, $\exists e$ abre un caso genérico) → 3. **$\forall i$ al final**: sólo cuando $X \notin fv(\Gamma)$ — descargar antes toda hipótesis que mencione $X$ → 4. **$\exists e$**: $X \notin fv(\Gamma, \tau)$, o sea la variable testigo no puede escaparse a la conclusión → 5. $\exists i$: hay que **elegir el testigo** $t$ y chequear que $\sigma\{X := t\}$ sea lo que ya probaste → 6. Si te trabás y la fórmula es del tipo $\neg\forall \to \exists\neg$, $\vee$ o "principio del bebedor": es **clásico**, meté $LEM$ o $PBC$ → 7. Regla de oro: $\neg\exists \Leftrightarrow \forall\neg$ es intuicionista; $\neg\forall \Rightarrow \exists\neg$ **no** lo es.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/deduccion_natural_lpo]]

### Ejercicio 10 — Derivación compleja
**Enunciado**
Demostrar en deducción natural:
$$(\forall X.\forall Y.R(X, f(Y))) \Rightarrow (\forall X.R(X, f(f(X))))$$

**Explicación**
Es el ejercicio "de una sola pieza" de deducción natural en LPO: no hay conectivos proposicionales más allá de la implicación externa, así que todo el trabajo está en **elegir bien los términos de instanciación** en $\forall e$ y en **verificar la restricción de variable propia** al cerrar con $\forall i$.

La clave está en que $\forall e$ permite instanciar con **cualquier término**, no sólo con variables: para llegar a $R(X, f(f(X)))$ hay que instanciar la $Y$ de la hipótesis con el término compuesto $t := f(X)$, que a su vez menciona la misma $X$ que después vamos a generalizar. Eso es legal — la restricción de $\forall i$ habla de las **hipótesis** ($X \notin fv(\Gamma)$), no de la forma del término usado antes.

Las dos reglas en juego:

$$\frac{\Gamma \vdash \forall X.\sigma}{\Gamma \vdash \sigma\{X := t\}}\ \forall e \quad (t \text{ libre para } X \text{ en } \sigma) \qquad \frac{\Gamma \vdash \sigma}{\Gamma \vdash \forall X.\sigma}\ \forall i \quad (X \notin fv(\Gamma))$$

**Resolución paso a paso**

Sea $\Gamma = \{\forall X.\forall Y.R(X, f(Y))\}$. Es una fórmula **cerrada**, así que $fv(\Gamma) = \emptyset$ — dato que vamos a usar al final.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \forall X.\forall Y.R(X, f(Y))$ | $ax$ |
| 2 | $\Gamma \vdash \forall Y.R(X, f(Y))$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\Gamma \vdash R(X, f(f(X)))$ | $\forall e$ con $t := f(X)$ sobre 2 |
| 4 | $\Gamma \vdash \forall X.R(X, f(f(X)))$ | $\forall i$ sobre 3 |
| 5 | $\vdash (\forall X.\forall Y.R(X, f(Y))) \Rightarrow (\forall X.R(X, f(f(X))))$ | $\Rightarrow i$ sobre 4 |

La misma derivación en forma de árbol:

$$\dfrac{\dfrac{\dfrac{\dfrac{\overline{\Gamma \vdash \forall X.\forall Y.R(X,f(Y))}\ ax}{\Gamma \vdash \forall Y.R(X,f(Y))}\ \forall e\ (t := X)}{\Gamma \vdash R(X, f(f(X)))}\ \forall e\ (t := f(X))}{\Gamma \vdash \forall X.R(X,f(f(X)))}\ \forall i}{\vdash (\forall X.\forall Y.R(X,f(Y))) \Rightarrow (\forall X.R(X,f(f(X))))}\ \Rightarrow i$$

**Verificación de las restricciones**

*Paso 2 — $\forall e$ con $t := X$.* El cuerpo es $\sigma = \forall Y.R(X, f(Y))$ y la sustitución es $\sigma\{X := X\}$, o sea la identidad. Igual hay que chequear que $t = X$ sea **libre para** $X$ en $\sigma$: la única variable de $t$ es $X$, y el único cuantificador que la podría capturar sería un $\forall X$ / $\exists X$ interno — acá el cuantificador interno es sobre $Y \neq X$ $\checkmark$. Sin captura.

*Paso 3 — $\forall e$ con $t := f(X)$.* El cuerpo es $\sigma = R(X, f(Y))$ y calculamos
$$R(X, f(Y))\{Y := f(X)\} = R(X, f(f(X)))$$
que es exactamente la meta. Chequeo de captura: $fv(f(X)) = \{X\}$ y $\sigma = R(X, f(Y))$ **no tiene cuantificadores**, así que ninguna variable de $t$ puede quedar capturada $\checkmark$.

*Paso 4 — $\forall i$ sobre $X$ (restricción de variable propia).* Requiere $X \notin fv(\Gamma)$. Acá $\Gamma = \{\forall X.\forall Y.R(X, f(Y))\}$, donde las dos ocurrencias de variables están **ligadas** por sus cuantificadores, luego $fv(\Gamma) = \emptyset$ y en particular $X \notin fv(\Gamma)$ $\checkmark$. Es lo que legitima leer el paso 3 como "vale para una $X$ **genérica**".

*Paso 5 — $\Rightarrow i$.* Descarga la hipótesis de $\Gamma$ y deja el secuente cerrado $\vdash \sigma$, que es lo pedido $\checkmark$.

**Por qué el orden de instanciación importa**

El error típico es querer instanciar $Y$ **antes** que $X$, o instanciar el $\forall X$ externo directamente con $f(X)$. Comparemos:

| Intento | Resultado del paso 2 | ¿Sirve? |
|---|---|---|
| $\forall e$ con $t := X$, después $t := f(X)$ | $R(X, f(f(X)))$ | ✔ es la meta |
| $\forall e$ con $t := f(X)$, después $t := X$ | $R(f(X), f(X))$ | ❌ no es la meta |
| $\forall e$ con $t := f(X)$, después $t := f(X)$ | $R(f(X), f(f(X)))$ | ❌ no es la meta (y $\forall i$ generalizaría sobre una $X$ que quedó adentro de $f$, sin producir la forma buscada) |

La hipótesis dice "para todo primer argumento, y para todo $Y$, vale $R(\text{primero}, f(Y))$": el segundo argumento **siempre** está bajo un $f$, y el $Y$ de adentro es libre de elegir. Como queremos $f(f(X))$ en la segunda posición, hay que pedir $f(Y)$ con $Y := f(X)$ — no $Y := X$.

**Observación: la recíproca no vale**

$(\forall X.R(X, f(f(X)))) \Rightarrow (\forall X.\forall Y.R(X, f(Y)))$ **no** es derivable. La hipótesis sólo habla de los pares $(d, f(f(d)))$ — la "diagonal" — mientras que la conclusión pide todos los pares $(d, f(e))$. Contramodelo: $D = \mathbb{N}$, $f(n) = n+1$, $R(m, n) \equiv (n = m + 2)$. La hipótesis vale (para todo $m$, $m + 2 = m + 2$), pero la conclusión falla tomando $X := 0$, $Y := 5$, porque $f(5) = 6 \neq 2$.

Es el mismo fenómeno del ítem v del [Ej. 9](#ejercicio-9-—-deducción-natural) (Diagonal $\forall$): *especializar* dos cuantificadores a un mismo término se puede, *generalizar* de la diagonal a todos los pares no.

**Chuleta**
> 1. Escribir la meta y mirar su conectivo principal: $\Rightarrow$ → arrancar con $\Rightarrow i$ y pasar el antecedente a $\Gamma$ → 2. La nueva meta $\forall X.\tau$ → planificar cerrar con $\forall i$, pero **al final** → 3. Escribir $\tau$ (la meta sin el $\forall$) y compararla con la hipótesis para leer **qué término** hay que meter en cada $\forall e$: comparar posición por posición ($f(Y)$ vs. $f(f(X))$ ⟹ $Y := f(X)$) → 4. Instanciar de **afuera hacia adentro**, un $\forall e$ por cuantificador, anotando el $t$ de cada uno → 5. En cada $\forall e$ chequear que $t$ sea **libre para** la variable (sin captura por cuantificadores internos) → 6. Al aplicar $\forall i$, chequear $X \notin fv(\Gamma)$: si $\Gamma$ son fórmulas cerradas, sale gratis, pero **hay que escribirlo** → 7. Si la conclusión "diagonaliza" (repite una variable en dos posiciones), va de meta a hipótesis, nunca al revés.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/deduccion_natural_lpo]]

### Ejercicio 11 — FNN
**Enunciado**
Una fórmula $\sigma$ está en **forma normal negada** (f.n.n.) si se puede producir con la siguiente gramática:
$$\sigma ::= P(t_1, \dots, t_n) \mid \neg P(t_1, \dots, t_n) \mid \sigma \wedge \sigma \mid \sigma \vee \sigma \mid \forall X.\,\sigma \mid \exists X.\,\sigma$$
Es decir, una fórmula está en f.n.n. si no tiene ocurrencias del conectivo de la implicación ($\Rightarrow$) y todas las ocurrencias del conectivo de la negación ($\neg$) acompañan a fórmulas atómicas (la negación sólo puede encontrarse en las **hojas** de la fórmula). Demostrar que toda fórmula $\sigma$ es equivalente a una fórmula en forma normal negada: para cada fórmula $\sigma$ existe una fórmula $\sigma'$ en f.n.n. tal que $\vdash \sigma \Leftrightarrow \sigma'$.

**Explicación**
No hay que "resolver un caso": hay que dar un **algoritmo** que transforme cualquier $\sigma$ en f.n.n. y **demostrar por inducción estructural** que preserva equivalencia. El algoritmo es el de siempre — *empujar las negaciones hacia las hojas* — pero escrito con cuidado.

La trampa de la definición ingenua ("reescribir con las equivalencias hasta que no se pueda más") es que hay que argumentar terminación: cada reescritura de De Morgan **aumenta** el tamaño de la fórmula, así que la medida no es obvia. El truco estándar, y el que se pide en el parcial, es definir **dos funciones mutuamente recursivas** por inducción estructural sobre $\sigma$:

- $\mathrm{fnn}(\sigma)$ — la f.n.n. de $\sigma$;
- $\mathrm{fnn}^{\neg}(\sigma)$ — la f.n.n. de $\neg\sigma$ (o sea: "meté esta fórmula en f.n.n., pero negada").

Ambas recursiones llaman **siempre sobre subfórmulas estrictas** de su argumento, así que la definición es legítima por recursión estructural y la terminación es gratis.

Las equivalencias que hacen falta (todas se demuestran en deducción natural, varias ya aparecen en el [Ej. 9](#ejercicio-9-—-deducción-natural)):

| # | Equivalencia | ¿Intuicionista? |
|---|---|---|
| E1 | $\sigma \Rightarrow \tau \Leftrightarrow \neg\sigma \vee \tau$ | ❌ (dirección $\Rightarrow$ es clásica) |
| E2 | $\neg\neg\sigma \Leftrightarrow \sigma$ | ❌ ($\neg\neg e$ es clásica) |
| E3 | $\neg(\sigma \wedge \tau) \Leftrightarrow \neg\sigma \vee \neg\tau$ | ❌ (dirección $\Rightarrow$ es clásica) |
| E4 | $\neg(\sigma \vee \tau) \Leftrightarrow \neg\sigma \wedge \neg\tau$ | ✔ |
| E5 | $\neg(\sigma \Rightarrow \tau) \Leftrightarrow \sigma \wedge \neg\tau$ | ❌ (dirección $\Rightarrow$ es clásica) |
| E6 | $\neg\forall X.\sigma \Leftrightarrow \exists X.\neg\sigma$ | ❌ (dirección $\Rightarrow$ es clásica — Ej. 9.viii) |
| E7 | $\neg\exists X.\sigma \Leftrightarrow \forall X.\neg\sigma$ | ✔ (Ej. 9.vii) |

**Resolución paso a paso**

**Paso 1 — Definición del algoritmo**

Por recursión estructural simultánea sobre $\sigma$:

$$
\begin{array}{lcl}
\mathrm{fnn}(P(\bar t)) &=& P(\bar t) \\
\mathrm{fnn}(\neg\sigma) &=& \mathrm{fnn}^{\neg}(\sigma) \\
\mathrm{fnn}(\sigma \wedge \tau) &=& \mathrm{fnn}(\sigma) \wedge \mathrm{fnn}(\tau) \\
\mathrm{fnn}(\sigma \vee \tau) &=& \mathrm{fnn}(\sigma) \vee \mathrm{fnn}(\tau) \\
\mathrm{fnn}(\sigma \Rightarrow \tau) &=& \mathrm{fnn}^{\neg}(\sigma) \vee \mathrm{fnn}(\tau) \\
\mathrm{fnn}(\forall X.\sigma) &=& \forall X.\,\mathrm{fnn}(\sigma) \\
\mathrm{fnn}(\exists X.\sigma) &=& \exists X.\,\mathrm{fnn}(\sigma)
\end{array}
\qquad
\begin{array}{lcl}
\mathrm{fnn}^{\neg}(P(\bar t)) &=& \neg P(\bar t) \\
\mathrm{fnn}^{\neg}(\neg\sigma) &=& \mathrm{fnn}(\sigma) \\
\mathrm{fnn}^{\neg}(\sigma \wedge \tau) &=& \mathrm{fnn}^{\neg}(\sigma) \vee \mathrm{fnn}^{\neg}(\tau) \\
\mathrm{fnn}^{\neg}(\sigma \vee \tau) &=& \mathrm{fnn}^{\neg}(\sigma) \wedge \mathrm{fnn}^{\neg}(\tau) \\
\mathrm{fnn}^{\neg}(\sigma \Rightarrow \tau) &=& \mathrm{fnn}(\sigma) \wedge \mathrm{fnn}^{\neg}(\tau) \\
\mathrm{fnn}^{\neg}(\forall X.\sigma) &=& \exists X.\,\mathrm{fnn}^{\neg}(\sigma) \\
\mathrm{fnn}^{\neg}(\exists X.\sigma) &=& \forall X.\,\mathrm{fnn}^{\neg}(\sigma)
\end{array}
$$

Notar que **no hay renombres**: ningún cuantificador se mueve de lugar, sólo cambia de sabor ($\forall \leftrightarrow \exists$). Por lo tanto no puede haber captura de variables y vale $fv(\mathrm{fnn}(\sigma)) = fv(\mathrm{fnn}^{\neg}(\sigma)) = fv(\sigma)$.

**Paso 2 — Buena definición (terminación)**

Cada ecuación de la izquierda tiene, del lado derecho, llamadas a $\mathrm{fnn}$ o $\mathrm{fnn}^{\neg}$ aplicadas **únicamente a subfórmulas propias** del argumento. Como la relación "ser subfórmula propia" es bien fundada sobre las fórmulas de LPO, la recursión simultánea está bien definida y termina. (Es exactamente el mismo argumento que la recursión estructural sobre árboles: la altura decrece.)

**Paso 3 — $\mathrm{fnn}(\sigma)$ está en f.n.n.**

Por inducción estructural sobre $\sigma$, probando **simultáneamente** las dos afirmaciones:
$$\mathcal{P}(\sigma): \quad \mathrm{fnn}(\sigma) \text{ está en f.n.n.} \quad \wedge \quad \mathrm{fnn}^{\neg}(\sigma) \text{ está en f.n.n.}$$

- *Caso $\sigma = P(\bar t)$:* $\mathrm{fnn}(\sigma) = P(\bar t)$ y $\mathrm{fnn}^{\neg}(\sigma) = \neg P(\bar t)$: las dos son producciones de la gramática (átomo y átomo negado) $\checkmark$.
- *Caso $\sigma = \neg\rho$:* por HI $\mathrm{fnn}(\rho)$ y $\mathrm{fnn}^{\neg}(\rho)$ están en f.n.n.; $\mathrm{fnn}(\neg\rho) = \mathrm{fnn}^{\neg}(\rho)$ y $\mathrm{fnn}^{\neg}(\neg\rho) = \mathrm{fnn}(\rho)$ $\checkmark$.
- *Casos $\wedge$, $\vee$, $\Rightarrow$:* los resultados son $\wedge$ / $\vee$ de dos fórmulas que están en f.n.n. por HI, y la gramática es cerrada por $\wedge$ y $\vee$ $\checkmark$. Observar que ninguna ecuación produce un $\Rightarrow$ $\checkmark$.
- *Casos $\forall$, $\exists$:* los resultados son $\forall X.\rho'$ o $\exists X.\rho'$ con $\rho'$ en f.n.n. por HI, y la gramática es cerrada por ambos cuantificadores $\checkmark$.

En ningún caso aparece un $\neg$ delante de algo que no sea un átomo: los únicos $\neg$ que el algoritmo **escribe** son los del caso base de $\mathrm{fnn}^{\neg}$ $\checkmark$.

**Paso 4 — Corrección: $\vdash \sigma \Leftrightarrow \mathrm{fnn}(\sigma)$**

De nuevo inducción estructural simultánea, ahora sobre el par de propiedades
$$\mathcal{Q}(\sigma): \quad \vdash \sigma \Leftrightarrow \mathrm{fnn}(\sigma) \quad \wedge \quad \vdash \neg\sigma \Leftrightarrow \mathrm{fnn}^{\neg}(\sigma)$$

Se usa libremente el **lema de congruencia**: si $\vdash \sigma \Leftrightarrow \sigma'$ y $\vdash \tau \Leftrightarrow \tau'$, entonces $\vdash (\sigma \star \tau) \Leftrightarrow (\sigma' \star \tau')$ para $\star \in \{\wedge, \vee, \Rightarrow\}$, y $\vdash (Q X.\sigma) \Leftrightarrow (Q X.\sigma')$ para $Q \in \{\forall, \exists\}$. (Las versiones de conectivos son deducción natural proposicional rutinaria; las de cuantificadores salen con $\forall i$ / $\exists e$ y valen porque las hipótesis son **vacías**, así que la restricción de variable propia se cumple trivialmente.)

| Caso | $\vdash \sigma \Leftrightarrow \mathrm{fnn}(\sigma)$ | $\vdash \neg\sigma \Leftrightarrow \mathrm{fnn}^{\neg}(\sigma)$ |
|---|---|---|
| $P(\bar t)$ | reflexividad de $\Leftrightarrow$ | reflexividad de $\Leftrightarrow$ |
| $\neg\rho$ | HI: $\vdash \neg\rho \Leftrightarrow \mathrm{fnn}^{\neg}(\rho)$ | **E2** + HI: $\vdash \neg\neg\rho \Leftrightarrow \rho \Leftrightarrow \mathrm{fnn}(\rho)$ |
| $\rho \wedge \pi$ | congruencia + HI | **E3** + HI |
| $\rho \vee \pi$ | congruencia + HI | **E4** + HI |
| $\rho \Rightarrow \pi$ | **E1** + HI | **E5** + HI |
| $\forall X.\rho$ | congruencia + HI | **E6** + HI |
| $\exists X.\rho$ | congruencia + HI | **E7** + HI |

Detallando un caso, el de $\forall$ negado (el más interesante):
$$\neg\forall X.\rho \overset{\text{E6}}{\Longleftrightarrow} \exists X.\neg\rho \overset{\text{HI} + \text{congr.}}{\Longleftrightarrow} \exists X.\mathrm{fnn}^{\neg}(\rho) = \mathrm{fnn}^{\neg}(\forall X.\rho)$$
donde la HI usada es $\vdash \neg\rho \Leftrightarrow \mathrm{fnn}^{\neg}(\rho)$ — la **segunda** mitad de $\mathcal{Q}(\rho)$. Es justamente por esto que las dos propiedades hay que probarlas **juntas**: la de $\mathrm{fnn}$ sola no cierra.

Tomando $\sigma' := \mathrm{fnn}(\sigma)$ queda demostrado el enunciado. $\blacksquare$

**Paso 5 — Ejemplo completo**

$$\sigma = \neg\big(\forall X.(P(X) \Rightarrow \exists Y.Q(X,Y))\big) \vee R(a)$$

| Paso | Fórmula | Ecuación aplicada |
|---|---|---|
| 0 | $\neg(\forall X.(P(X) \Rightarrow \exists Y.Q(X,Y))) \vee R(a)$ | — |
| 1 | $\mathrm{fnn}(\neg(\forall X.\dots)) \vee \mathrm{fnn}(R(a))$ | $\mathrm{fnn}$ de $\vee$ |
| 2 | $\mathrm{fnn}^{\neg}(\forall X.(P(X) \Rightarrow \exists Y.Q(X,Y))) \vee R(a)$ | $\mathrm{fnn}$ de $\neg$; caso base |
| 3 | $\exists X.\,\mathrm{fnn}^{\neg}(P(X) \Rightarrow \exists Y.Q(X,Y)) \vee R(a)$ | **E6** ($\mathrm{fnn}^{\neg}$ de $\forall$) |
| 4 | $\exists X.\big(\mathrm{fnn}(P(X)) \wedge \mathrm{fnn}^{\neg}(\exists Y.Q(X,Y))\big) \vee R(a)$ | **E5** ($\mathrm{fnn}^{\neg}$ de $\Rightarrow$) |
| 5 | $\exists X.\big(P(X) \wedge \forall Y.\,\mathrm{fnn}^{\neg}(Q(X,Y))\big) \vee R(a)$ | **E7** ($\mathrm{fnn}^{\neg}$ de $\exists$) |
| 6 | $\exists X.\big(P(X) \wedge \forall Y.\neg Q(X,Y)\big) \vee R(a)$ | caso base de $\mathrm{fnn}^{\neg}$ |

Resultado: $\sigma' = \exists X.(P(X) \wedge \forall Y.\neg Q(X,Y)) \vee R(a)$. Chequeo: no quedan $\Rightarrow$ $\checkmark$; el único $\neg$ está pegado al átomo $Q(X,Y)$ $\checkmark$; $fv(\sigma') = fv(\sigma) = \emptyset$ $\checkmark$.

Lectura informal: "no todo el que $P$ tiene un $Q$-compañero, o vale $R(a)$" $\equiv$ "hay alguien que cumple $P$ y no tiene ningún $Q$-compañero, o vale $R(a)$".

**Observaciones**

- **La f.n.n. no es única.** $\mathrm{fnn}$ es *una* elección determinista; $\neg P \vee \neg Q$ y $\neg Q \vee \neg P$ son ambas f.n.n. equivalentes de $\neg(P \wedge Q)$.
- **No hay explosión de tamaño.** Cada nodo del árbol sintáctico de $\sigma$ produce a lo sumo un nodo en $\mathrm{fnn}(\sigma)$: el crecimiento es **lineal**. Esto la diferencia de la forma normal conjuntiva, donde distribuir $\vee$ sobre $\wedge$ puede ser exponencial.
- **Es el paso previo obligado** de la forma normal prenexa ([Ej. 12](#ejercicio-12-—-fnp)) y, después, de la forma clausal usada en resolución: sacar la implicación y las negaciones internas es lo que permite luego mover los cuantificadores sin reglas para $\Rightarrow$.

⚠️ Verificar — la demostración usa **principios de razonamiento clásicos** (E1, E2, E3, E5 y E6 no son intuicionistas; ver Ej. 9.viii). El enunciado de la guía no aclara si están permitidos, a diferencia del Ej. 9 que lo dice explícitamente. Sin ellos el teorema **es falso**: en lógica intuicionista $\neg\neg P$ no tiene f.n.n. equivalente.

**Chuleta**
> 1. No es "resolver un caso": es dar **algoritmo + inducción estructural** → 2. Definir **dos** funciones mutuamente recursivas, $\mathrm{fnn}(\sigma)$ y $\mathrm{fnn}^{\neg}(\sigma) \approx \mathrm{fnn}(\neg\sigma)$ — con una sola no cierra la inducción → 3. Terminación: todas las llamadas son sobre **subfórmulas propias** $\Rightarrow$ recursión estructural bien fundada (no intentar medir por tamaño: De Morgan lo agranda) → 4. Casos de $\mathrm{fnn}^{\neg}$: $\neg\neg \to$ saco, $\wedge \to \vee$, $\vee \to \wedge$, $\Rightarrow$ da $\sigma \wedge \neg\tau$, $\forall \to \exists$, $\exists \to \forall$, átomo $\to$ átomo negado → 5. Probar **dos** propiedades por inducción: "el resultado está en f.n.n." y "$\vdash \sigma \Leftrightarrow \mathrm{fnn}(\sigma)$ **y** $\vdash \neg\sigma \Leftrightarrow \mathrm{fnn}^{\neg}(\sigma)$" → 6. Citar el **lema de congruencia** para reemplazar equivalentes dentro de un contexto → 7. Aclarar que es clásico ($\neg\neg e$, De Morgan $\wedge$, $\neg\forall \to \exists\neg$) → 8. Ningún cuantificador cambia de posición $\Rightarrow$ **no hace falta renombrar** (eso recién aparece en la f.n.p.).

**¿Aparece en parciales?** ⚪ No

### Ejercicio 12 — FNP
**Enunciado**
Una fórmula $\sigma$ está en **forma normal prenexa** (f.n.p.) si es de la forma $Q_1 X_1. \dots Q_n X_n.\ \tau$ donde cada $Q_i$ es un cuantificador ($\forall$ o $\exists$) y $\tau$ es una fórmula en forma normal negada **sin ocurrencias de cuantificadores**. Demostrar que toda fórmula $\sigma$ es equivalente a una fórmula en forma normal prenexa: para cada fórmula $\sigma$ existe una fórmula $\sigma'$ en f.n.p. tal que $\vdash \sigma \Leftrightarrow \sigma'$.

**Explicación**
Continuación directa del [Ej. 11](#ejercicio-11-—-fnn). La estructura de la demostración es en **tres etapas**:

1. **f.n.n.** — poner $\sigma$ en forma normal negada (Ej. 11). Esto elimina $\Rightarrow$ y deja las $\neg$ en las hojas. Es lo que hace fácil la etapa 3: no hay que preocuparse por que el antecedente de una implicación **invierte** el cuantificador al sacarlo.
2. **Rectificación** ($\alpha$-conversión) — renombrar variables ligadas para que todas sean **distintas entre sí y distintas de las libres**. Es lo que evita la **captura** al mover cuantificadores.
3. **Prenexación** — sacar los cuantificadores al frente con las equivalencias de extracción, que después de la etapa 2 se aplican **sin condiciones laterales**.

Las equivalencias de extracción (con $Q \in \{\forall, \exists\}$ y $\star \in \{\wedge, \vee\}$):

| # | Equivalencia | Condición |
|---|---|---|
| P1 | $(\forall X.\rho) \wedge \pi \Leftrightarrow \forall X.(\rho \wedge \pi)$ | $X \notin fv(\pi)$ |
| P2 | $(\forall X.\rho) \vee \pi \Leftrightarrow \forall X.(\rho \vee \pi)$ | $X \notin fv(\pi)$ |
| P3 | $(\exists X.\rho) \wedge \pi \Leftrightarrow \exists X.(\rho \wedge \pi)$ | $X \notin fv(\pi)$ |
| P4 | $(\exists X.\rho) \vee \pi \Leftrightarrow \exists X.(\rho \vee \pi)$ | $X \notin fv(\pi)$ |
| P1'–P4' | idem con el cuantificador en el **argumento derecho** | $X \notin fv(\rho)$ |
| $\alpha$ | $Q X.\rho \Leftrightarrow Q Z.\,\rho\{X := Z\}$ | $Z \notin fv(\rho)$ y $Z$ libre para $X$ en $\rho$ |

**Las condiciones laterales no son decorativas**: P2 y P4 con $X \in fv(\pi)$ son directamente **falsas**, no sólo indemostrables. Notar además que las versiones para $\vee$ (P2, P4) valen **en ambas direcciones**, y las de $\wedge$ también — a diferencia de los ítems x y xii del [Ej. 9](#ejercicio-9-—-deducción-natural), que son estos mismos enunciados y donde la dirección $\Rightarrow$ de $\forall/\vee$ requiere principios clásicos.

**Resolución paso a paso**

**Paso 1 — Reducción al caso f.n.n.**

Por el Ej. 11, existe $\sigma_1$ en f.n.n. con $\vdash \sigma \Leftrightarrow \sigma_1$. Como $\Leftrightarrow$ es transitiva, basta demostrar el teorema para fórmulas **ya en f.n.n.**: si conseguimos $\sigma'$ en f.n.p. con $\vdash \sigma_1 \Leftrightarrow \sigma'$, entonces $\vdash \sigma \Leftrightarrow \sigma'$.

Esto también garantiza la parte "$\tau$ en f.n.n." del enunciado: la matriz que va a quedar al final son las hojas de $\sigma_1$, que son átomos y átomos negados.

**Paso 2 — Rectificación**

Decimos que $\rho$ está **rectificada** si (a) no hay dos cuantificadores que liguen la misma variable, y (b) ninguna variable ligada aparece también libre en $\rho$.

*Lema.* Toda $\rho$ es $\alpha$-equivalente a una $\rho^r$ rectificada, con $\vdash \rho \Leftrightarrow \rho^r$, misma forma (f.n.n. si $\rho$ lo era) y $fv(\rho^r) = fv(\rho)$.

*Demostración (bosquejo).* Inducción estructural recorriendo $\rho$ de la raíz a las hojas: cada vez que se encuentra un $Q X.\pi$, se elige una variable **fresca** $Z$ (que no ocurra en toda la fórmula original ni entre las ya elegidas — hay infinitas variables disponibles) y se reemplaza por $Q Z.\pi\{X := Z\}$, usando la regla $\alpha$. La condición "$Z$ libre para $X$" se cumple por frescura. $\square$

**Paso 3 — Prenexación (inducción estructural)**

Sea $\rho$ en f.n.n. y rectificada. Definimos $\mathrm{pnf}(\rho)$ por recursión estructural:

$$
\begin{array}{lcl}
\mathrm{pnf}(P(\bar t)) &=& P(\bar t) \\
\mathrm{pnf}(\neg P(\bar t)) &=& \neg P(\bar t) \\
\mathrm{pnf}(\forall X.\rho) &=& \forall X.\,\mathrm{pnf}(\rho) \\
\mathrm{pnf}(\exists X.\rho) &=& \exists X.\,\mathrm{pnf}(\rho) \\
\mathrm{pnf}(\rho \star \pi) &=& \vec{Q}\vec{X}.\ \vec{Q'}\vec{Y}.\ (\rho_0 \star \pi_0) \quad \text{donde } \mathrm{pnf}(\rho) = \vec{Q}\vec{X}.\rho_0,\ \mathrm{pnf}(\pi) = \vec{Q'}\vec{Y}.\pi_0
\end{array}
$$

con $\star \in \{\wedge, \vee\}$ y $\vec{Q}\vec{X}$, $\vec{Q'}\vec{Y}$ los prefijos de cuantificadores respectivos (posiblemente vacíos).

*Terminación:* todas las llamadas son sobre subfórmulas propias $\checkmark$.

*La salida es f.n.p.:* por inducción, $\mathrm{pnf}(\rho)$ es siempre prefijo de cuantificadores + matriz sin cuantificadores; la matriz se arma con $\wedge$/$\vee$ de matrices sin cuantificadores y hojas atómicas o atómicas negadas, o sea está en f.n.n. sin cuantificadores $\checkmark$. Acá se ve por qué la etapa 1 era necesaria: si hubiera un $\Rightarrow$, la regla para el caso binario tendría que **invertir** los cuantificadores del argumento izquierdo ($(\forall X.\rho) \Rightarrow \pi \Leftrightarrow \exists X.(\rho \Rightarrow \pi)$), y una $\neg$ interna haría lo mismo.

*Corrección:* $\vdash \rho \Leftrightarrow \mathrm{pnf}(\rho)$, por inducción estructural.

- Casos base: identidad $\checkmark$.
- Casos $\forall X.\rho$ / $\exists X.\rho$: HI + lema de congruencia para cuantificadores $\checkmark$.
- Caso $\rho \star \pi$: por HI, $\vdash \rho \Leftrightarrow \vec{Q}\vec{X}.\rho_0$ y $\vdash \pi \Leftrightarrow \vec{Q'}\vec{Y}.\pi_0$. Por congruencia, $\vdash (\rho \star \pi) \Leftrightarrow ((\vec{Q}\vec{X}.\rho_0) \star (\vec{Q'}\vec{Y}.\pi_0))$. Ahora se aplican **P1–P4** repetidamente, primero sacando los $\vec{Q}\vec{X}$ (uno por uno, de adentro hacia afuera del prefijo) y luego los $\vec{Q'}\vec{Y}$.

  **Las condiciones laterales se cumplen gracias a la rectificación**: cada $X_i$ del prefijo izquierdo es una variable ligada de $\rho$, luego (por rectificación de la fórmula entera) no ocurre libre en $\pi$ ni entre las $\vec{Y}$; simétricamente para las $Y_j$ $\checkmark$. Formalmente es una inducción interna sobre la longitud del prefijo.

Componiendo las tres etapas: $\sigma' := \mathrm{pnf}((\mathrm{fnn}(\sigma))^r)$ está en f.n.p. y $\vdash \sigma \Leftrightarrow \sigma'$. $\blacksquare$

**Paso 4 — Ejemplo con renombre**

$$\sigma = (\forall X.P(X)) \Rightarrow (\exists X.Q(X))$$

| Etapa | Fórmula | Justificación |
|---|---|---|
| 0 | $(\forall X.P(X)) \Rightarrow (\exists X.Q(X))$ | — |
| 1 (f.n.n.) | $\mathrm{fnn}^{\neg}(\forall X.P(X)) \vee \mathrm{fnn}(\exists X.Q(X))$ | E1/E5 del Ej. 11 |
| 1 | $(\exists X.\neg P(X)) \vee (\exists X.Q(X))$ | E6 + caso base |
| 2 (rectif.) | $(\exists X.\neg P(X)) \vee (\exists Z.Q(Z))$ | $\alpha$ con $Z$ fresca |
| 3 (prenex) | $\exists X.\big(\neg P(X) \vee (\exists Z.Q(Z))\big)$ | **P4**, con $X \notin fv(\exists Z.Q(Z)) = \emptyset$ $\checkmark$ |
| 3 | $\exists X.\exists Z.(\neg P(X) \vee Q(Z))$ | **P4'**, con $Z \notin fv(\neg P(X)) = \{X\}$ $\checkmark$ |

Resultado: $\sigma' = \exists X.\exists Z.(\neg P(X) \vee Q(Z))$, prefijo $\exists\exists$ y matriz $\neg P(X) \vee Q(Z)$ sin cuantificadores y en f.n.n. $\checkmark$

**Paso 5 — Por qué la rectificación no es opcional (captura)**

$$\tau = (\forall X.R(X,Y)) \wedge (\exists Y.S(Y)) \qquad fv(\tau) = \{Y\}$$

Sacar el $\forall X$ es inofensivo: $X \notin fv(\exists Y.S(Y)) = \emptyset$ $\checkmark$, y da $\forall X.\big(R(X,Y) \wedge \exists Y.S(Y)\big)$.

Sacar ahora el $\exists Y$ **sin renombrar** violaría la condición de P3', porque $Y \in fv(R(X,Y))$. Si igual se hace:
$$\underbrace{\forall X.\exists Y.(R(X,Y) \wedge S(Y))}_{\text{MAL}}$$
la $Y$ que era **libre** en $R(X,Y)$ quedó **capturada** por el $\exists Y$. Ya no son la misma fórmula: la original tiene $Y$ libre, la "prenexada" es cerrada. Contramodelo: $D = \{0,1\}$, $R = \{(0,0),(1,0)\}$, $S = \{1\}$, asignación $Y \mapsto 0$. La original vale ($\forall X.R(X,0)$ $\checkmark$ y $S(1)$ $\checkmark$), y la mal-prenexada pide un mismo $Y$ que sirva para las dos conjunciones: $Y = 0$ falla en $S$, $Y = 1$ falla en $R$ → **falsa**.

Con rectificación previa ($\exists W.S(W)$, $W$ fresca) sale bien:
$$\tau' = \forall X.\exists W.\big(R(X,Y) \wedge S(W)\big) \qquad fv(\tau') = \{Y\}\ \checkmark$$

**Observaciones**

- **La f.n.p. no es única.** Cuantificadores provenientes de **ramas distintas** del árbol se pueden intercalar en cualquier orden ($\exists X.\exists Z$ o $\exists Z.\exists X$ acá dan lo mismo). Lo que **no** se puede alterar es el orden relativo de cuantificadores **anidados** uno dentro de otro: $\forall X.\exists Y$ y $\exists Y.\forall X$ no son equivalentes (Ej. 9.iii).
- **Para qué sirve.** La f.n.p. es el paso previo a la **skolemización** y a la **forma clausal** que consume el método de resolución: con todos los cuantificadores al frente se pueden reemplazar los $\exists$ por funciones de Skolem de los $\forall$ que los preceden, quedarse con el prefijo universal implícito y distribuir la matriz a FNC. Ver [[resolucion_teoria]] y [[tipos_ejercicio/resolucion_forma_clausal]].
- **Costo.** Las etapas 1 y 2 son lineales; la etapa 3 también (sólo reordena). La explosión aparece recién al pasar la matriz a FNC.

⚠️ Verificar — la demostración hereda del Ej. 11 el uso de **principios de razonamiento clásicos** (la etapa 1 es clásica; las extracciones P1–P4' en cambio son intuicionistas salvo la dirección $\Rightarrow$ de $\forall/\vee$, cf. Ej. 9.x). El enunciado no aclara qué sistema deductivo se supone.

**Chuleta**
> 1. **Tres etapas, en este orden**: f.n.n. (Ej. 11) → rectificar → sacar cuantificadores. Saltearse la primera obliga a reglas para $\Rightarrow$ y $\neg$ que **invierten** el cuantificador → 2. **Rectificar** = renombrar toda variable ligada por una fresca, distinta de las otras ligadas y de todas las libres ($\alpha$-conversión) → 3. Después de rectificar, las condiciones laterales $X \notin fv(\pi)$ de P1–P4 se cumplen **solas**: hay que decirlo, no chequearlo caso por caso → 4. Extracción: $(Q X.\rho) \star \pi \Leftrightarrow Q X.(\rho \star \pi)$ para $\star \in \{\wedge, \vee\}$, con $Q$ **sin cambiar** → 5. Si aparece un $\Rightarrow$ o una $\neg$ por encima del cuantificador, el cuantificador **se da vuelta** ($\forall \leftrightarrow \exists$): otra razón para hacer f.n.n. primero → 6. Sacar de a uno, **de adentro hacia afuera**, y anotar la regla en cada paso → 7. Chequeo final: prefijo puro + matriz sin cuantificadores en f.n.n. + **mismas variables libres** que la fórmula original (si cambiaron, hubo captura) → 8. No reordenar cuantificadores anidados: $\forall\exists \neq \exists\forall$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_forma_clausal]]

---

## SEMÁNTICA

### Ejercicio 13 — Semántica en Z
**Enunciado**
Sea $L$ el lenguaje de primer orden que incluye (junto con las variables, conectivos y cuantificadores) la constante $a_1$, el símbolo de función $f$ de aridad 2 y el símbolo de predicado $P$ de aridad 2. Sea $\sigma$ la fórmula
$$\forall X_1.\forall X_2.\big(P(f(X_1, X_2), a_1) \Rightarrow P(X_1, X_2)\big)$$
Definamos una interpretación $I$ para $L$ como sigue: $D_I$ es $\mathbb{Z}$, $a_1$ es $0$, $f(X,Y)$ es $X - Y$, $P(X,Y)$ es $X < Y$.
Escribir la interpretación de $\sigma$ en castellano. ¿El enunciado es verdadero o falso? Hallar una interpretación de $\sigma$ en la cual el enunciado tenga el valor de verdad opuesto.

**Explicación**
Una **interpretación** (o estructura) $I$ para un lenguaje $L$ consta de:
- un **dominio** no vacío $D_I$,
- un elemento de $D_I$ para cada símbolo de constante,
- una función $D_I^n \to D_I$ para cada símbolo de función de aridad $n$,
- una relación $\subseteq D_I^n$ para cada símbolo de predicado de aridad $n$.

$\sigma$ es una **sentencia** (no tiene variables libres: $X_1$ y $X_2$ están ligadas por los $\forall$), así que su valor de verdad **no depende de la asignación**: en cada interpretación es lisa y llanamente verdadera o falsa.

Dos cosas distintas que conviene no mezclar:
- **$\sigma$ es verdadera en $I$** ($I \models \sigma$, "$I$ es modelo de $\sigma$") — lo que se pregunta en la primera parte.
- **$\sigma$ es lógicamente válida** ($\models \sigma$) — verdadera en **toda** interpretación. La tercera parte del enunciado pide exhibir una interpretación donde $\sigma$ es falsa, lo que prueba de paso que $\sigma$ **no** es lógicamente válida (misma técnica del [Ej. 15](#ejercicio-15-—-validez-lógica)).

**Resolución paso a paso**

**Paso 1 — La interpretación $I$**

| Elemento | Interpretación en $I$ |
|---|---|
| Dominio $D_I$ | $\mathbb{Z} = \{\dots, -2, -1, 0, 1, 2, \dots\}$ |
| $a_1$ (constante) | el número $0$ |
| $f$ (función binaria) | la resta: $(x,y) \mapsto x - y$ |
| $P$ (predicado binario) | el orden estricto: $P^I = \{(x,y) \in \mathbb{Z}^2 : x < y\}$ |

**Paso 2 — Traducción de $\sigma$ al castellano**

Se traduce de adentro hacia afuera:

| Subfórmula / término | Traducción |
|---|---|
| $f(X_1, X_2)$ | $x_1 - x_2$ |
| $a_1$ | $0$ |
| $P(f(X_1,X_2), a_1)$ | $x_1 - x_2 < 0$ |
| $P(X_1, X_2)$ | $x_1 < x_2$ |
| $\sigma$ | $\forall x_1 \in \mathbb{Z}.\ \forall x_2 \in \mathbb{Z}.\ (x_1 - x_2 < 0 \Rightarrow x_1 < x_2)$ |

En castellano: **"para todo par de números enteros, si la resta del primero menos el segundo es negativa, entonces el primero es menor que el segundo"**.

**Paso 3 — ¿Verdadero o falso en $I$?**

**Verdadero.** Es exactamente la propiedad de compatibilidad del orden de $\mathbb{Z}$ con la suma: para todos $x_1, x_2 \in \mathbb{Z}$,
$$x_1 - x_2 < 0 \iff x_1 - x_2 + x_2 < 0 + x_2 \iff x_1 < x_2$$
Como vale el $\Rightarrow$ (de hecho vale el $\Leftrightarrow$), el antecedente nunca es verdadero con el consecuente falso, así que **$I \models \sigma$**.

Notar que la implicación no es vacua: hay pares que activan el antecedente (p. ej. $x_1 = 1, x_2 = 5$: $1 - 5 = -4 < 0$ $\checkmark$ y $1 < 5$ $\checkmark$), y también pares que lo falsean y hacen valer la implicación por vacuidad ($x_1 = 5, x_2 = 1$: $4 < 0$ es falso).

**Paso 4 — Una interpretación $J$ donde $\sigma$ es falsa**

Para falsear una sentencia $\forall X_1.\forall X_2.(\alpha \Rightarrow \beta)$ hay que exhibir **un** par de elementos del dominio con $\alpha$ verdadera y $\beta$ falsa. La modificación más barata es cambiar **un solo símbolo** y dejar el resto igual.

*Opción A (cambiar $f$): $D_J = \mathbb{Z}$, $a_1^J = 0$, $f^J(x,y) = x + y$, $P^J = {<}$.*

La traducción pasa a ser: $\forall x_1, x_2 \in \mathbb{Z}.\ (x_1 + x_2 < 0 \Rightarrow x_1 < x_2)$.

Testigo: $x_1 = 0$, $x_2 = -1$.

| Parte | Cálculo | Valor |
|---|---|---|
| $f^J(0, -1) = 0 + (-1)$ | $-1$ | — |
| Antecedente $P^J(-1, 0)$ | $-1 < 0$ | **V** |
| Consecuente $P^J(0, -1)$ | $0 < -1$ | **F** |
| $\text{V} \Rightarrow \text{F}$ | | **F** |

Como la instancia con $x_1 = 0, x_2 = -1$ es falsa, el $\forall\forall$ es falso: **$J \not\models \sigma$** $\checkmark$

*Opción B (cambiar $P$): $D_J = \mathbb{Z}$, $a_1^J = 0$, $f^J(x,y) = x - y$, $P^J = {>}$.*

Traducción: $\forall x_1, x_2.\ (x_1 - x_2 > 0 \Rightarrow x_1 > x_2)$ — que **también es verdadera**. ❌ No sirve: cambiar $<$ por $>$ deja la equivalencia intacta porque la resta y el orden se dan vuelta juntos. Sirve en cambio $P^J = {\leq}$ con $f^J(x,y) = x - y$: $x_1 - x_2 \leq 0 \Rightarrow x_1 \leq x_2$ sigue valiendo… tampoco. La lección: **hay que romper el vínculo entre $f$ y $P$**, no aplicarles la misma simetría.

*Opción C (cambiar el dominio a algo finito): $D_J = \{0, 1\}$, $a_1^J = 0$, $f^J(x,y) = $ la función constante $1$, $P^J = \{(1,0)\}$.*

Testigo: $x_1 = 1$, $x_2 = 0$.
- Antecedente: $P^J(f^J(1,0),\ 0) = P^J(1, 0)$ → $(1,0) \in P^J$ → **V**.
- Consecuente: $P^J(1, 0)$ → **V**. ❌ No sirve tampoco.

Cambiando a $P^J = \{(1,1)\}$ y $f^J(x,y) = 1$, con $a_1^J = 1$:
- Antecedente: $P^J(1, 1)$ → **V**.
- Consecuente con $x_1 = 1, x_2 = 0$: $P^J(1,0)$ → **F**.
- Instancia $\text{V} \Rightarrow \text{F}$ → **F** $\checkmark$

**Alcanza con una**; la Opción A es la más clara y la más fácil de justificar en un parcial.

**Paso 5 — Conclusión**

- En $I$ (enteros, $f = $ resta, $P = <$): $\sigma$ es **verdadera**.
- En $J$ (enteros, $f = $ suma, $P = <$): $\sigma$ es **falsa**.
- Por lo tanto $\sigma$ es **satisfacible** (tiene modelo: $I$) pero **no lógicamente válida** (tiene contramodelo: $J$).

**Observaciones**

- **Por qué $\sigma$ es verdadera en $I$ y no por casualidad.** La fórmula dice "$f(X_1,X_2) < a_1 \Rightarrow X_1 < X_2$", y en $I$ la resta es precisamente el testigo de la diferencia de orden. Cualquier grupo ordenado con $f = $ resta y $a_1 = $ neutro hace verdadera a $\sigma$ (p. ej. $\mathbb{Q}$, $\mathbb{R}$ con las mismas lecturas).
- **Sentencia vs. fórmula abierta.** Acá no hubo que hablar de asignaciones porque $\sigma$ es cerrada; en el [Ej. 14](#ejercicio-14-—-semántica-aritmética), en cambio, casi todos los ítems tienen variables libres y la respuesta es "qué asignaciones".
- **Un contramodelo no necesita ser "natural".** En la Opción C el dominio tiene dos elementos y las interpretaciones son tablas arbitrarias: eso es perfectamente legal. Lo único obligatorio es que $D_J \neq \emptyset$ y que cada símbolo reciba algo del tipo correcto.

**Chuleta**
> 1. Escribir el diccionario en una tabla: dominio, cada constante, cada función, cada predicado → 2. **Traducir de adentro hacia afuera**: primero los términos, después los átomos, al final los conectivos y cuantificadores → 3. Si la fórmula es **cerrada** (sin variables libres), no hay asignación que elegir: es V o F en cada interpretación, punto → 4. Para decidir el valor de un $\forall X.(\alpha \Rightarrow \beta)$: preguntarse si existe algún elemento con $\alpha$ **V** y $\beta$ **F** → 5. Para **falsear** el enunciado alcanza con **un** testigo; para afirmarlo hay que dar un argumento general (acá: $x - y < 0 \iff x < y$) → 6. Para construir la interpretación opuesta, cambiar **un solo símbolo** y recalcular; el truco típico es romper el vínculo entre la función y el predicado (resta $\to$ suma) → 7. Cuidado con cambios "simétricos" que no cambian nada: pasar $<$ a $>$ **junto con** la resta deja la fórmula verdadera → 8. Si nada natural funciona, ir a un dominio **finito** ($\{0,1\}$) y definir $f$ y $P$ por tabla → 9. Moraleja: modelo $\Rightarrow$ satisfacible; contramodelo $\Rightarrow$ no lógicamente válida.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_semantica_modelos]]

---

### Ejercicio 14 — Semántica aritmética
**Enunciado**
Sea $N$ la interpretación aritmética donde $D_I = \mathbb{N}$, $c^0 = 0$, $P^2 = \text{"="}$, $f^1_1 = \text{sucesor}$, $f^2_2 = "+", f^2_3 = "\times"$.
Hallar asignaciones que satisfagan (y que no) fórmulas como:
I. $P(f_2(X_1, X_1), f_3(f_1(X_1), f_1(X_1)))$
IV. $\forall X_1 . P(f_3(X_1, X_2), X_3)$

**Explicación**
Evaluación de fórmulas en una estructura (modelo). Diferencia entre verdad lógica (en todo modelo) y satisfacibilidad (en algún modelo con alguna asignación).

**Resolución paso a paso**
**La interpretación $N$**

| Elemento | Interpretación |
|---|---|
| Dominio $D_I$ | $\mathbb{N} = \{0, 1, 2, \dots\}$ |
| $c$ (constante, $c^0$) | el número $0$ |
| $P$ (predicado binario, $P^2$) | la igualdad $=$ |
| $f_1$ (función unaria, $f^1_1$) | sucesor: $n \mapsto n+1$ |
| $f_2$ (función binaria, $f^2_2$) | suma: $(m,n) \mapsto m+n$ |
| $f_3$ (función binaria, $f^2_3$) | producto: $(m,n) \mapsto m \times n$ |

Una **asignación** $a$ manda cada variable libre $X_i$ a un elemento de $\mathbb{N}$. Se evalúa primero cada término y después el predicado.

---

**i.** $P(f_2(X_1, X_1),\ f_3(f_1(X_1), f_1(X_1)))$

*Evaluación de los términos* con $a(X_1) = n$:
- $f_2(X_1,X_1) \leadsto n + n = 2n$
- $f_1(X_1) \leadsto n+1$, luego $f_3(f_1(X_1), f_1(X_1)) \leadsto (n+1) \times (n+1) = (n+1)^2$

*Traducción:* $2n = (n+1)^2$.

*Análisis:* $(n+1)^2 = n^2 + 2n + 1 = 2n \iff n^2 + 1 = 0$, que **no tiene solución en $\mathbb{N}$** (ni en $\mathbb{Z}$).

- **Asignación que satisface:** no existe. La fórmula es **insatisfacible en $N$**.
- **Asignación que no satisface:** cualquiera, p. ej. $a(X_1) = 0$ → $0 = 1$ es falso; $a(X_1) = 3$ → $6 = 16$ es falso.

---

**ii.** $P(f_2(X_1, c), X_2) \Rightarrow P(f_2(X_1, X_2), X_3)$

*Traducción:* $(X_1 + 0 = X_2) \Rightarrow (X_1 + X_2 = X_3)$.

- **Satisface** (antecedente falso): $a(X_1) = 0,\ a(X_2) = 1,\ a(X_3)$ cualquiera → $0 = 1$ es falso → la implicación vale.
- **Satisface** (ambos verdaderos): $a(X_1) = 1,\ a(X_2) = 1,\ a(X_3) = 2$ → $1 = 1$ $\checkmark$ y $1+1 = 2$ $\checkmark$.
- **No satisface:** $a(X_1) = 1,\ a(X_2) = 1,\ a(X_3) = 0$ → antecedente $1 = 1$ verdadero, consecuente $2 = 0$ falso.

---

**iii.** $\neg P(f_3(X_1, X_2),\ f_3(X_2, X_3))$

*Traducción:* $X_1 \times X_2 \neq X_2 \times X_3$.

- **Satisface:** $a(X_1) = 1,\ a(X_2) = 1,\ a(X_3) = 2$ → $1 \neq 2$ $\checkmark$.
- **No satisface:** cualquier asignación con $a(X_1) = a(X_3)$, p. ej. todo en $1$ → $1 = 1$, o con $a(X_2) = 0$ → $0 = 0$.

---

**iv.** $\forall X_1.\ P(f_3(X_1, X_2), X_3)$

*Traducción:* "para todo $n \in \mathbb{N}$ vale $n \times a(X_2) = a(X_3)$". $X_1$ está **ligada**, así que sólo importan los valores de $X_2$ y $X_3$.

*Análisis:* tomando $n = 0$ queda $0 = a(X_3)$, o sea $a(X_3) = 0$; tomando $n = 1$ queda $a(X_2) = a(X_3) = 0$. Recíprocamente, si $a(X_2) = a(X_3) = 0$ entonces $n \times 0 = 0$ para todo $n$. Conclusión: **satisface si y sólo si $a(X_2) = 0$ y $a(X_3) = 0$**.

- **Satisface:** $a(X_2) = 0,\ a(X_3) = 0$ → $n \times 0 = 0$ para todo $n$ $\checkmark$.
- **No satisface:** $a(X_2) = 1,\ a(X_3) = 1$ → falla para $n = 0$ ($0 \times 1 = 0 \neq 1$). Otro: $a(X_2)=0,\ a(X_3)=5$ → $0 \neq 5$.

---

**v.** $\forall X_1.(P(f_3(X_1, c), X_1) \Rightarrow P(X_1, X_2))$

*Traducción:* "para todo $n$: $(n \times 0 = n) \Rightarrow (n = a(X_2))$".

*Análisis:* $n \times 0 = 0$ siempre, así que el antecedente $n \times 0 = n$ es verdadero **sólo cuando $n = 0$**. Para $n \neq 0$ la implicación vale por vacuidad. Queda entonces una única condición: para $n = 0$ hay que tener $0 = a(X_2)$. Conclusión: **satisface si y sólo si $a(X_2) = 0$**.

- **Satisface:** $a(X_2) = 0$.
- **No satisface:** $a(X_2) = 1$ (con $n = 0$: antecedente $0 = 0$ verdadero, consecuente $0 = 1$ falso).

---

**Nota conceptual:** ser *satisfacible* (existe un modelo y una asignación que la hacen verdadera) es mucho más débil que ser *lógicamente válida* (verdadera en **todo** modelo y con **toda** asignación). El ítem i muestra una fórmula que ni siquiera es satisfacible **en esta interpretación** — aunque sí lo es en otras (p. ej. con $D_I = \mathbb{Z}$ y $f_1$ interpretada como predecesor, o cambiando $P$ por $\leq$).

**Chuleta**
> 1. Escribir el diccionario: $D_I = \mathbb{N}$, $c = 0$, $P = {=}$, $f_1 = \text{suc}$, $f_2 = +$, $f_3 = \times$ → 2. **Traducir la fórmula a aritmética** reemplazando símbolo por símbolo, de adentro hacia afuera → 3. Las variables **libres** son los parámetros que elegís; las **ligadas** por $\forall$/$\exists$ recorren todo $\mathbb{N}$ → 4. Para satisfacer una $\Rightarrow$: lo más barato es **falsear el antecedente** → 5. Para refutar un $\forall X_1$: alcanza con **un** contraejemplo (probar $n = 0$ y $n = 1$ primero, casi siempre alcanza) → 6. Resolver la ecuación/inecuación resultante en $\mathbb{N}$; si no tiene solución, la fórmula es insatisfacible en $N$ (caso i: $2n = (n+1)^2$) → 7. Resultados: i insatisfacible; ii, iii tienen ambas; iv sólo con $X_2 = X_3 = 0$; v sólo con $X_2 = 0$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_semantica_modelos]]

---

### Ejercicio 15 — Validez lógica
**Enunciado**
Demostrar que ninguna de las siguientes fórmulas es lógicamente válida.
i. $\forall X_1.\exists X_2.P(X_1, X_2) \Rightarrow \exists X_2.\forall X_1.P(X_1, X_2)$
ii. $\forall X_1.\forall X_2.(P(X_1, X_2) \Rightarrow P(X_2, X_1))$
iii. $\forall X_1.\neg Q(X_1) \Rightarrow Q(c)$
iv. $(\forall X_1.P(X_1, X_1)) \Rightarrow \exists X_2.\forall X_1.P(X_1, X_2)$

**Explicación**
Una fórmula $\sigma$ es **lógicamente válida** ($\models \sigma$) si es verdadera en **toda** interpretación bajo **toda** asignación. Negar eso es un enunciado existencial:
$$\not\models \sigma \iff \text{existe una interpretación } I \text{ y una asignación } a \text{ con } I, a \not\models \sigma$$

O sea: **no hay que demostrar nada por inducción ni derivar nada** — alcanza con exhibir **un** contramodelo y evaluar. La técnica (ver [[tipos_ejercicio/lpo_semantica_modelos]]):

1. **Elegir el dominio más chico que pueda funcionar.** Casi siempre $|D| = 1$ o $|D| = 2$. Si con $|D| = 1$ la fórmula sale verdadera siempre, hay que subir a $2$ — y conviene decir *por qué*.
2. **Definir los predicados por extensión**, como conjuntos de tuplas. No hace falta que "signifiquen" algo.
3. **Instanciar y evaluar**: mostrar el testigo que hace verdadero el antecedente y falso el consecuente (o que falsea la fórmula entera).
4. **Chequear las variables libres**: si la fórmula tiene alguna, hay que dar también la asignación. Acá las cuatro son **cerradas** (en iii, $c$ es una constante, no una variable), así que sólo hay que dar $I$.

Truco práctico: para falsear $\alpha \Rightarrow \beta$ hay que hacer $\alpha$ **verdadera** y $\beta$ **falsa**. Poner el predicado vacío o total suele falsear las dos partes a la vez y **no sirve**.

*Sobre el alcance de los cuantificadores en i y iii:* escritas sin paréntesis, admiten la lectura de "alcance máximo" ($\forall X_1.\exists X_2.(P(X_1,X_2) \Rightarrow \dots)$). La lectura pretendida es la otra — los cuantificadores del antecedente **cierran antes** del $\Rightarrow$ — y es la que se usa abajo; en iii se verifica que ambas lecturas dan lo mismo.

**Resolución paso a paso**

---

**i.** $\forall X_1.\exists X_2.P(X_1, X_2) \Rightarrow \exists X_2.\forall X_1.P(X_1, X_2)$

Esta es la implicación **prohibida** entre cuantificadores: la válida es $\exists\forall \Rightarrow \forall\exists$ ([Ej. 9](#ejercicio-9-—-deducción-natural).iii), no la recíproca. Intuitivamente, el antecedente permite que el $X_2$ testigo **dependa** de $X_1$; el consecuente exige un $X_2$ **uniforme**, el mismo para todos.

*Contramodelo.* $|D| = 1$ no alcanza: con un solo elemento $d$, $\forall x.\exists y.P(x,y)$ equivale a $P(d,d)$ y $\exists y.\forall x.P(x,y)$ también, así que la implicación siempre vale. Hace falta $|D| = 2$.

$$D_I = \{0, 1\}, \qquad P^I = \{(0,1),\ (1,0)\} \quad (\text{es decir } P(x,y) \equiv x \neq y)$$

| Parte | Evaluación | Valor |
|---|---|---|
| $\exists X_2.P(0, X_2)$ | testigo $X_2 = 1$: $(0,1) \in P^I$ | **V** |
| $\exists X_2.P(1, X_2)$ | testigo $X_2 = 0$: $(1,0) \in P^I$ | **V** |
| **Antecedente** $\forall X_1.\exists X_2.P(X_1,X_2)$ | vale para $0$ y para $1$ | **V** |
| $\forall X_1.P(X_1, 0)$ | falla en $X_1 = 0$: $(0,0) \notin P^I$ | **F** |
| $\forall X_1.P(X_1, 1)$ | falla en $X_1 = 1$: $(1,1) \notin P^I$ | **F** |
| **Consecuente** $\exists X_2.\forall X_1.P(X_1,X_2)$ | ningún $X_2$ sirve | **F** |
| **Fórmula** | $\text{V} \Rightarrow \text{F}$ | **F** $\checkmark$ |

*Sobre la lectura de alcance máximo.* Si se leyera $\forall X_1.\exists X_2.\big(P(X_1,X_2) \Rightarrow \exists X_2'.\forall X_1'.P(X_1',X_2')\big)$, este modelo **no** la falsea: como el consecuente es F, la implicación interna equivale a $\neg P(X_1,X_2)$, y $\forall X_1.\exists X_2.\ x_1 = x_2$ es verdadera acá. ⚠️ Verificar — bajo esa lectura la fórmula sí es lógicamente válida en el fragmento con dominio no vacío (para cada $X_1$ se elige $X_2$ que falsee $P$, salvo que $P$ sea total, y si $P$ es total el consecuente vale), con lo cual el enunciado sólo tiene sentido con la lectura de la tabla. El enunciado original no pone los paréntesis; se resolvió con la lectura estándar $(\forall\exists) \Rightarrow (\exists\forall)$.

---

**ii.** $\forall X_1.\forall X_2.(P(X_1, X_2) \Rightarrow P(X_2, X_1))$

Dice "$P$ es simétrica". Falsear = dar cualquier relación **no simétrica**.

*Contramodelo.* $|D| = 1$ no alcanza: con $D = \{d\}$ el único par posible es $(d,d)$ y toda relación es simétrica. Hace falta $|D| = 2$.

$$D_I = \{0, 1\}, \qquad P^I = \{(0,1)\}$$

Instancia $X_1 := 0$, $X_2 := 1$:

| Parte | Evaluación | Valor |
|---|---|---|
| Antecedente $P(0,1)$ | $(0,1) \in P^I$ | **V** |
| Consecuente $P(1,0)$ | $(1,0) \notin P^I$ | **F** |
| Instancia | $\text{V} \Rightarrow \text{F}$ | **F** |
| **Fórmula** $\forall\forall(\dots)$ | falla en $(0,1)$ | **F** $\checkmark$ |

*Lectura concreta equivalente:* $D_I = \mathbb{N}$ con $P = {<}$ también sirve ($1 < 2$ pero $2 \not< 1$); el modelo de dos elementos es preferible porque la evaluación es finita y se chequea a ojo.

---

**iii.** $\forall X_1.\neg Q(X_1) \Rightarrow Q(c)$

Dice "si nadie cumple $Q$, entonces $c$ cumple $Q$" — obviamente falso apenas $Q$ sea vacío. Falsear = hacer el antecedente **V** ($Q$ vacío) y el consecuente **F** ($c \notin Q$), que es la **misma** condición.

*Contramodelo.* Acá sí alcanza con **un** elemento (el dominio no puede ser vacío en LPO):

$$D_I = \{0\}, \qquad c^I = 0, \qquad Q^I = \emptyset$$

| Parte | Evaluación | Valor |
|---|---|---|
| $\neg Q(0)$ | $0 \notin Q^I$ | **V** |
| **Antecedente** $\forall X_1.\neg Q(X_1)$ | único elemento, vale | **V** |
| **Consecuente** $Q(c) = Q(0)$ | $0 \notin Q^I$ | **F** |
| **Fórmula** | $\text{V} \Rightarrow \text{F}$ | **F** $\checkmark$ |

*Con la lectura de alcance máximo* $\forall X_1.(\neg Q(X_1) \Rightarrow Q(c))$: la instancia $X_1 := 0$ da $\text{V} \Rightarrow \text{F}$ = **F**, y el $\forall$ falla. El mismo contramodelo sirve para las dos lecturas $\checkmark$

*Observación:* la fórmula **no** es insatisfacible: en $D = \{0\}$, $c = 0$, $Q = \{0\}$ el antecedente es F y la implicación vale. Es una fórmula **contingente**, y eso es todo lo que hace falta.

---

**iv.** $(\forall X_1.P(X_1, X_1)) \Rightarrow \exists X_2.\forall X_1.P(X_1, X_2)$

Dice "si $P$ es reflexiva entonces hay un elemento con el que todos se relacionan". Falso: la reflexividad sólo llena la **diagonal**, y el consecuente pide una **columna llena**.

*Contramodelo.* Con $|D| = 1$ la diagonal **es** toda la matriz, así que reflexiva $\Rightarrow$ total y la implicación vale. Hace falta $|D| = 2$.

$$D_I = \{0, 1\}, \qquad P^I = \{(0,0),\ (1,1)\} \quad (\text{la igualdad})$$

| Parte | Evaluación | Valor |
|---|---|---|
| $P(0,0)$, $P(1,1)$ | ambos en $P^I$ | **V** |
| **Antecedente** $\forall X_1.P(X_1,X_1)$ | | **V** |
| $\forall X_1.P(X_1, 0)$ | falla en $X_1 = 1$: $(1,0) \notin P^I$ | **F** |
| $\forall X_1.P(X_1, 1)$ | falla en $X_1 = 0$: $(0,1) \notin P^I$ | **F** |
| **Consecuente** $\exists X_2.\forall X_1.P(X_1,X_2)$ | ninguna columna llena | **F** |
| **Fórmula** | $\text{V} \Rightarrow \text{F}$ | **F** $\checkmark$ |

*Relación con i:* iv es i con el antecedente reforzado. El antecedente $\forall X_1.P(X_1,X_1)$ **implica** $\forall X_1.\exists X_2.P(X_1,X_2)$ (tomando $X_2 := X_1$), así que cualquier contramodelo de iv lo es también de i — y en efecto la relación "$=$" de iv también falsea i. Un **único** modelo ($D = \{0,1\}$, $P = {=}$) alcanza para los dos ítems.

---

**Resumen**

| Ítem | Dominio mínimo | Contramodelo | Por qué falla |
|---|---|---|---|
| i | $2$ | $P = {\neq}$ sobre $\{0,1\}$ | el testigo depende de $X_1$; no hay uno uniforme |
| ii | $2$ | $P = \{(0,1)\}$ | relación no simétrica |
| iii | $1$ | $Q = \emptyset$, $c = 0$ | antecedente V y consecuente F son lo mismo |
| iv | $2$ | $P = {=}$ sobre $\{0,1\}$ | diagonal llena $\neq$ columna llena |

**Observaciones**

- **Contramodelo vs. no derivabilidad.** Exhibir un contramodelo demuestra $\not\models \sigma$; por **corrección** del sistema deductivo ($\vdash \sigma \Rightarrow \models \sigma$), eso implica también $\not\vdash \sigma$. Es la forma estándar de probar que algo **no** se puede derivar en DN: intentar y fracasar no demuestra nada, el contramodelo sí.
- **Por qué el dominio finito y chico.** Con $|D| = n$ y predicados dados por extensión, evaluar un $\forall$/$\exists$ es recorrer $n$ casos: la verificación es **mecánica y completa**. Con $\mathbb{N}$ hay que argumentar.
- **El dominio nunca es vacío.** Por eso en iii hizo falta poner $D = \{0\}$ y no $D = \emptyset$; y por eso $\forall X.P(X) \Rightarrow \exists X.P(X)$ **sí** es válida (Ej. 9.iv).

**Chuleta**
> 1. "No es lógicamente válida" = **exhibir un contramodelo**, nada de inducción ni derivaciones → 2. Dar siempre: **dominio**, interpretación de cada constante/función, cada predicado **por extensión** (conjunto de tuplas), y la asignación si hay variables libres → 3. Empezar por $|D| = 1$; si la fórmula sale V siempre, subir a $|D| = 2$ y **decir por qué** ($|D|=1$ hace toda relación simétrica, reflexiva $\Rightarrow$ total, $\forall \equiv \exists$) → 4. Para falsear $\alpha \Rightarrow \beta$: $\alpha$ **V** y $\beta$ **F**; predicado vacío o total suele falsear ambos y no sirve → 5. Para falsear un $\forall$: **un** testigo; para falsear un $\exists$: recorrer **todos** los elementos → 6. Presentar la evaluación en tabla, fila por fila, hasta llegar a $\text{V} \Rightarrow \text{F}$ → 7. Patrones que se repiten: $\forall\exists \not\Rightarrow \exists\forall$ (matriz sin columna llena), simetría (un par suelto $\{(0,1)\}$), $\forall\neg Q \Rightarrow Q(c)$ ($Q$ vacío) → 8. Corolario gratis: contramodelo $\Rightarrow$ tampoco es derivable en DN (por corrección).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_semantica_modelos]]

---

### Ejercicio 16 — Extra DN
**Enunciado**
(Ejercicios extra de deducción natural — opcional.) Dar derivaciones en DN de las siguientes fórmulas.
i. $(\forall X.P(X)) \Rightarrow P(a)$
ii. $P(a) \Rightarrow \exists X.P(X)$
iii. $(\forall X.\forall Y.(R(X,Y) \Rightarrow \neg R(Y,X))) \Rightarrow \forall X.\neg R(X,X)$
iv. $(\forall X.\forall Y.R(X,Y)) \Rightarrow \forall X.R(X,X)$
v. $(\exists X.P(X)) \Rightarrow (\forall Y.Q(Y)) \Rightarrow \forall X.\forall Y.(P(X) \Rightarrow Q(Y))$
vi. $(\forall X.(P(X) \Rightarrow Q(X))) \wedge (\exists X.P(X)) \Rightarrow \exists X.Q(X)$
vii. $(\neg\forall X.(P(X) \vee Q(X))) \Rightarrow \neg\forall X.P(X)$
viii. $(\exists X.(P(X) \Rightarrow Q(X))) \Rightarrow (\forall X.P(X)) \Rightarrow \exists X.Q(X)$
ix. $(\forall X.(P(X) \Rightarrow Q(X))) \wedge (\neg\exists X.Q(X)) \Rightarrow \forall X.\neg P(X)$
x. $(\forall X.(\exists Y.R(Y,X) \Rightarrow P(X))) \Rightarrow (\exists X.\exists Y.R(X,Y)) \Rightarrow \exists X.P(X)$
xi. $(\exists X.(P(X) \vee Q(X))) \Rightarrow (\forall X.\neg Q(X)) \Rightarrow \exists X.P(X)$
xii. $(\neg\forall X.\exists Y.R(X,Y)) \Rightarrow \neg\forall X.R(X,X)$
xiii. $(\neg\exists X.\forall Y.R(Y,X) \Rightarrow \exists X.\exists Y.\neg R(X,Y))$
xiv. $\neg(\forall X.P(X) \wedge \exists X.\neg P(X))$
xv. $(\exists X.(R(X,X) \wedge P(X))) \Rightarrow \neg\forall X.(P(X) \Rightarrow \neg\exists Y.R(X,Y))$
xvi. $(\exists X.P(X) \Rightarrow \forall X.Q(X)) \Rightarrow \forall Y.(P(Y) \Rightarrow Q(Y))$
xvii. $\neg(\forall X.(P(X) \wedge Q(X))) \wedge \forall X.P(X) \Rightarrow \neg\forall X.Q(X)$
xviii. $(\forall X.(R(X,X) \Rightarrow Q(X))) \wedge \exists X.\forall Y.R(X,Y) \Rightarrow \exists X.Q(X)$

**Explicación**
Batería de práctica sobre las mismas reglas del [Ej. 9](#ejercicio-9-—-deducción-natural) y el [Ej. 10](#ejercicio-10-—-derivación-compleja). Se recuerdan las reglas de cuantificadores:

$$\frac{\Gamma \vdash \sigma}{\Gamma \vdash \forall X.\sigma}\ \forall i\ \ (X \notin fv(\Gamma)) \qquad \frac{\Gamma \vdash \forall X.\sigma}{\Gamma \vdash \sigma\{X := t\}}\ \forall e$$

$$\frac{\Gamma \vdash \sigma\{X := t\}}{\Gamma \vdash \exists X.\sigma}\ \exists i \qquad \frac{\Gamma \vdash \exists X.\sigma \quad \Gamma, \sigma \vdash \tau}{\Gamma \vdash \tau}\ \exists e\ \ (X \notin fv(\Gamma, \tau))$$

Método, en el orden en que conviene aplicarlo:

1. **Meta primero.** Si la meta es $\alpha \Rightarrow \beta$ → $\Rightarrow i$; si es $\neg\alpha$ → $\neg i$ (asumir $\alpha$, buscar $\perp$); si es $\forall X.\alpha$ → $\forall i$; si es $\alpha \wedge \beta$ → $\wedge i$.
2. **Hipótesis después.** $\wedge e$ para partir conjunciones, $\forall e$ para instanciar, $\exists e$ para abrir el testigo genérico, $\vee e$ para partir en casos.
3. **$\exists i$ al final**, eligiendo el testigo $t$ que ya se tiene probado.
4. **Las dos restricciones de variable propia** son lo único delicado. Regla mnemotécnica: *descargar antes de generalizar*. Si la hipótesis que menciona $X$ sigue en el contexto, ni $\forall i$ ni $\exists e$ se pueden aplicar (ver ix y xiii).

**Todos los ítems salvo el xiii son intuicionistas**; el xiii necesita $PBC$ porque va de una negación de existencial a un existencial de negación.

**Resolución paso a paso**

---

**i.** $(\forall X.P(X)) \Rightarrow P(a)$ — sea $\Gamma = \{\forall X.P(X)\}$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \forall X.P(X)$ | $ax$ |
| 2 | $\Gamma \vdash P(a)$ | $\forall e$ con $t := a$ sobre 1 |
| 3 | $\vdash (\forall X.P(X)) \Rightarrow P(a)$ | $\Rightarrow i$ sobre 2 |

*Restricciones:* ninguna ($\forall e$ no tiene). Sólo hay que ver que $a$ es un **término cerrado**, así que es libre para $X$ $\checkmark$

---

**ii.** $P(a) \Rightarrow \exists X.P(X)$ — sea $\Gamma = \{P(a)\}$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash P(a)$ | $ax$ |
| 2 | $\Gamma \vdash \exists X.P(X)$ | $\exists i$ con $t := a$ sobre 1 |
| 3 | $\vdash P(a) \Rightarrow \exists X.P(X)$ | $\Rightarrow i$ sobre 2 |

Los ítems i y ii son las reglas $\forall e$ y $\exists i$ "envueltas" en un $\Rightarrow i$: son los casos base de todo lo demás.

---

**iii.** $(\forall X.\forall Y.(R(X,Y) \Rightarrow \neg R(Y,X))) \Rightarrow \forall X.\neg R(X,X)$ — "asimétrica $\Rightarrow$ irreflexiva".

Sea $\Gamma = \{\forall X.\forall Y.(R(X,Y) \Rightarrow \neg R(Y,X))\}$, cerrada.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \forall X.\forall Y.(R(X,Y) \Rightarrow \neg R(Y,X))$ | $ax$ |
| 2 | $\Gamma \vdash \forall Y.(R(X,Y) \Rightarrow \neg R(Y,X))$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\Gamma \vdash R(X,X) \Rightarrow \neg R(X,X)$ | $\forall e$ con $t := X$ sobre 2 |
| 4 | $\Gamma, R(X,X) \vdash R(X,X) \Rightarrow \neg R(X,X)$ | $ax$ (3 debilitado) |
| 5 | $\Gamma, R(X,X) \vdash R(X,X)$ | $ax$ |
| 6 | $\Gamma, R(X,X) \vdash \neg R(X,X)$ | $\Rightarrow e$ sobre 4 y 5 |
| 7 | $\Gamma, R(X,X) \vdash \perp$ | $\neg e$ sobre 6 y 5 |
| 8 | $\Gamma \vdash \neg R(X,X)$ | $\neg i$ sobre 7 |
| 9 | $\Gamma \vdash \forall X.\neg R(X,X)$ | $\forall i$ sobre 8 |
| 10 | $\vdash \dots$ | $\Rightarrow i$ sobre 9 |

*Restricciones:* paso 9 requiere $X \notin fv(\Gamma) = \emptyset$ $\checkmark$. **El $\neg i$ del paso 8 tiene que ir antes**: mientras $R(X,X)$ esté en el contexto, $X \in fv(\Gamma, R(X,X))$ y $\forall i$ estaría prohibido.

*Truco del paso 3:* la doble instanciación con el **mismo** término $X$ es lo que colapsa $R(X,Y) \Rightarrow \neg R(Y,X)$ en la autocontradicción $R(X,X) \Rightarrow \neg R(X,X)$.

---

**iv.** $(\forall X.\forall Y.R(X,Y)) \Rightarrow \forall X.R(X,X)$ — versión "diagonal" sin negaciones.

Sea $\Gamma = \{\forall X.\forall Y.R(X,Y)\}$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \forall X.\forall Y.R(X,Y)$ | $ax$ |
| 2 | $\Gamma \vdash \forall Y.R(X,Y)$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\Gamma \vdash R(X,X)$ | $\forall e$ con $t := X$ sobre 2 |
| 4 | $\Gamma \vdash \forall X.R(X,X)$ | $\forall i$ sobre 3 |
| 5 | $\vdash \dots$ | $\Rightarrow i$ sobre 4 |

*Restricciones:* paso 4 requiere $X \notin fv(\Gamma) = \emptyset$ $\checkmark$

---

**v.** $(\exists X.P(X)) \Rightarrow (\forall Y.Q(Y)) \Rightarrow \forall X.\forall Y.(P(X) \Rightarrow Q(Y))$

($\Rightarrow$ asocia a derecha.) Sea $\Gamma = \{\exists X.P(X),\ \forall Y.Q(Y)\}$, cerrada.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma, P(X) \vdash \forall Y.Q(Y)$ | $ax$ |
| 2 | $\Gamma, P(X) \vdash Q(Y)$ | $\forall e$ con $t := Y$ sobre 1 |
| 3 | $\Gamma \vdash P(X) \Rightarrow Q(Y)$ | $\Rightarrow i$ sobre 2 |
| 4 | $\Gamma \vdash \forall Y.(P(X) \Rightarrow Q(Y))$ | $\forall i$ sobre 3 |
| 5 | $\Gamma \vdash \forall X.\forall Y.(P(X) \Rightarrow Q(Y))$ | $\forall i$ sobre 4 |
| 6 | $\vdash \dots$ | $\Rightarrow i$ dos veces sobre 5 |

*Restricciones:* paso 4 requiere $Y \notin fv(\Gamma) = \emptyset$ $\checkmark$; paso 5 requiere $X \notin fv(\Gamma) = \emptyset$ $\checkmark$. **Es esencial que el $\Rightarrow i$ del paso 3 vaya antes de los dos $\forall i$**: con $P(X)$ en el contexto, $X$ estaría libre en las hipótesis.

*Observación:* la hipótesis $\exists X.P(X)$ **no se usa**. La fórmula $(\forall Y.Q(Y)) \Rightarrow \forall X.\forall Y.(P(X) \Rightarrow Q(Y))$ ya es derivable; el $\exists$ es decorativo (debilitamiento).

---

**vi.** $(\forall X.(P(X) \Rightarrow Q(X))) \wedge (\exists X.P(X)) \Rightarrow \exists X.Q(X)$ — *modus ponens* bajo cuantificadores.

Sea $\Gamma = \{(\forall X.(P(X) \Rightarrow Q(X))) \wedge (\exists X.P(X))\}$, cerrada.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash (\forall X.(P(X) \Rightarrow Q(X))) \wedge (\exists X.P(X))$ | $ax$ |
| 2 | $\Gamma \vdash \forall X.(P(X) \Rightarrow Q(X))$ | $\wedge e_1$ sobre 1 |
| 3 | $\Gamma \vdash \exists X.P(X)$ | $\wedge e_2$ sobre 1 |
| 4 | $\Gamma, P(X) \vdash \forall X.(P(X) \Rightarrow Q(X))$ | $ax$ (2 debilitado) |
| 5 | $\Gamma, P(X) \vdash P(X) \Rightarrow Q(X)$ | $\forall e$ con $t := X$ sobre 4 |
| 6 | $\Gamma, P(X) \vdash P(X)$ | $ax$ |
| 7 | $\Gamma, P(X) \vdash Q(X)$ | $\Rightarrow e$ sobre 5 y 6 |
| 8 | $\Gamma, P(X) \vdash \exists X.Q(X)$ | $\exists i$ con $t := X$ sobre 7 |
| 9 | $\Gamma \vdash \exists X.Q(X)$ | $\exists e$ sobre 3 y 8 |
| 10 | $\vdash \dots$ | $\Rightarrow i$ sobre 9 |

*Restricciones:* paso 9 requiere $X \notin fv(\Gamma, \exists X.Q(X))$: $\Gamma$ es cerrada y en $\exists X.Q(X)$ la $X$ está **ligada** $\checkmark$

---

**vii.** $(\neg\forall X.(P(X) \vee Q(X))) \Rightarrow \neg\forall X.P(X)$ — contrarrecíproco de $\forall P \Rightarrow \forall(P \vee Q)$.

Sea $\Gamma = \{\neg\forall X.(P(X) \vee Q(X))\}$ y $\Delta = \Gamma, \forall X.P(X)$; ambos cerrados.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta \vdash \forall X.P(X)$ | $ax$ |
| 2 | $\Delta \vdash P(X)$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\Delta \vdash P(X) \vee Q(X)$ | $\vee i_1$ sobre 2 |
| 4 | $\Delta \vdash \forall X.(P(X) \vee Q(X))$ | $\forall i$ sobre 3 |
| 5 | $\Delta \vdash \neg\forall X.(P(X) \vee Q(X))$ | $ax$ |
| 6 | $\Delta \vdash \perp$ | $\neg e$ sobre 5 y 4 |
| 7 | $\Gamma \vdash \neg\forall X.P(X)$ | $\neg i$ sobre 6 |
| 8 | $\vdash \dots$ | $\Rightarrow i$ sobre 7 |

*Restricciones:* paso 4 requiere $X \notin fv(\Delta) = \emptyset$ $\checkmark$ (las dos hipótesis son cerradas: en $\forall X.P(X)$ la $X$ está ligada).

*Nota:* el contrarrecíproco de una implicación **intuicionista** ($\alpha \Rightarrow \beta$ da $\neg\beta \Rightarrow \neg\alpha$) es intuicionista. La dirección peligrosa es la otra ($\neg\beta \Rightarrow \neg\alpha$ da $\alpha \Rightarrow \beta$), que sí es clásica.

---

**viii.** $(\exists X.(P(X) \Rightarrow Q(X))) \Rightarrow (\forall X.P(X)) \Rightarrow \exists X.Q(X)$

Sea $\Gamma = \{\exists X.(P(X) \Rightarrow Q(X)),\ \forall X.P(X)\}$, cerrada, y $\Delta = \Gamma, P(X) \Rightarrow Q(X)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \exists X.(P(X) \Rightarrow Q(X))$ | $ax$ |
| 2 | $\Delta \vdash P(X) \Rightarrow Q(X)$ | $ax$ |
| 3 | $\Delta \vdash \forall X.P(X)$ | $ax$ |
| 4 | $\Delta \vdash P(X)$ | $\forall e$ con $t := X$ sobre 3 |
| 5 | $\Delta \vdash Q(X)$ | $\Rightarrow e$ sobre 2 y 4 |
| 6 | $\Delta \vdash \exists X.Q(X)$ | $\exists i$ con $t := X$ sobre 5 |
| 7 | $\Gamma \vdash \exists X.Q(X)$ | $\exists e$ sobre 1 y 6 |
| 8 | $\vdash \dots$ | $\Rightarrow i$ dos veces sobre 7 |

*Restricciones:* paso 7 requiere $X \notin fv(\Gamma, \exists X.Q(X)) = \emptyset$ $\checkmark$

---

**ix.** $(\forall X.(P(X) \Rightarrow Q(X))) \wedge (\neg\exists X.Q(X)) \Rightarrow \forall X.\neg P(X)$ — *modus tollens* generalizado.

Sea $\Gamma = \{(\forall X.(P(X) \Rightarrow Q(X))) \wedge (\neg\exists X.Q(X))\}$, cerrada, y $\Delta = \Gamma, P(X)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash (\forall X.(P(X) \Rightarrow Q(X))) \wedge (\neg\exists X.Q(X))$ | $ax$ |
| 2 | $\Gamma \vdash \forall X.(P(X) \Rightarrow Q(X))$ | $\wedge e_1$ sobre 1 |
| 3 | $\Gamma \vdash \neg\exists X.Q(X)$ | $\wedge e_2$ sobre 1 |
| 4 | $\Delta \vdash P(X) \Rightarrow Q(X)$ | $\forall e$ con $t := X$ sobre 2 (debilitado) |
| 5 | $\Delta \vdash P(X)$ | $ax$ |
| 6 | $\Delta \vdash Q(X)$ | $\Rightarrow e$ sobre 4 y 5 |
| 7 | $\Delta \vdash \exists X.Q(X)$ | $\exists i$ con $t := X$ sobre 6 |
| 8 | $\Delta \vdash \neg\exists X.Q(X)$ | $ax$ (3 debilitado) |
| 9 | $\Delta \vdash \perp$ | $\neg e$ sobre 8 y 7 |
| 10 | $\Gamma \vdash \neg P(X)$ | $\neg i$ sobre 9 |
| 11 | $\Gamma \vdash \forall X.\neg P(X)$ | $\forall i$ sobre 10 |
| 12 | $\vdash \dots$ | $\Rightarrow i$ sobre 11 |

*Restricciones:* paso 11 requiere $X \notin fv(\Gamma) = \emptyset$ $\checkmark$. **Otra vez el orden importa**: $\neg i$ (paso 10) descarga $P(X)$ y recién ahí $\forall i$ es legal.

*Observación:* junto con el Ej. 9, esto muestra la equivalencia intuicionista $\neg\exists X.Q(X) \Leftrightarrow \forall X.\neg Q(X)$ en acción.

---

**x.** $(\forall X.(\exists Y.R(Y,X) \Rightarrow P(X))) \Rightarrow (\exists X.\exists Y.R(X,Y)) \Rightarrow \exists X.P(X)$

El ítem con **dos $\exists e$ anidados** y el único donde hay que cuidar la elección de variables frescas. Renombramos la hipótesis por $\alpha$-conversión a $\forall Z.(\exists W.R(W,Z) \Rightarrow P(Z))$ para que no choque con los testigos.

Sea $\Gamma = \{\forall Z.(\exists W.R(W,Z) \Rightarrow P(Z)),\ \exists X.\exists Y.R(X,Y)\}$ (cerrada), $\Delta = \Gamma, \exists V.R(U,V)$ y $\Theta = \Delta, R(U,V)$, con $U, V$ **frescas**.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \exists X.\exists Y.R(X,Y)$ | $ax$ |
| 2 | $\Delta \vdash \exists V.R(U,V)$ | $ax$ |
| 3 | $\Theta \vdash R(U,V)$ | $ax$ |
| 4 | $\Theta \vdash \exists W.R(W,V)$ | $\exists i$ con $t := U$ sobre 3 |
| 5 | $\Theta \vdash \forall Z.(\exists W.R(W,Z) \Rightarrow P(Z))$ | $ax$ |
| 6 | $\Theta \vdash \exists W.R(W,V) \Rightarrow P(V)$ | $\forall e$ con $t := V$ sobre 5 |
| 7 | $\Theta \vdash P(V)$ | $\Rightarrow e$ sobre 6 y 4 |
| 8 | $\Theta \vdash \exists X.P(X)$ | $\exists i$ con $t := V$ sobre 7 |
| 9 | $\Delta \vdash \exists X.P(X)$ | $\exists e$ sobre 2 y 8 |
| 10 | $\Gamma \vdash \exists X.P(X)$ | $\exists e$ sobre 1 y 9 |
| 11 | $\vdash \dots$ | $\Rightarrow i$ dos veces sobre 10 |

*Restricciones:*
- Paso 6: $V$ debe ser **libre para $Z$** en $\exists W.R(W,Z) \Rightarrow P(Z)$ — se cumple porque $V \neq W$ (por eso se renombró) $\checkmark$
- Paso 9 (elimina $\exists V$): $V \notin fv(\Delta, \exists X.P(X))$. Se tiene $fv(\Delta) = fv(\exists V.R(U,V)) = \{U\}$ y la conclusión es cerrada $\checkmark$
- Paso 10 (elimina $\exists U$): $U \notin fv(\Gamma, \exists X.P(X)) = \emptyset$ $\checkmark$

*Idea:* el testigo $V$ (el **segundo** componente del par que da $\exists X\exists Y.R(X,Y)$) es el que hay que enchufar en el $\forall Z$, porque la hipótesis pide $\exists W.R(W,Z)$ — o sea que $Z$ esté en la **segunda** posición de $R$. Enchufar $U$ sería el error típico.

---

**xi.** $(\exists X.(P(X) \vee Q(X))) \Rightarrow (\forall X.\neg Q(X)) \Rightarrow \exists X.P(X)$ — silogismo disyuntivo cuantificado.

Sea $\Gamma = \{\exists X.(P(X) \vee Q(X)),\ \forall X.\neg Q(X)\}$ (cerrada) y $\Delta = \Gamma, P(X) \vee Q(X)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \exists X.(P(X) \vee Q(X))$ | $ax$ |
| 2 | $\Delta \vdash P(X) \vee Q(X)$ | $ax$ |
| 3 | $\Delta, P(X) \vdash P(X)$ | $ax$ |
| 4 | $\Delta, P(X) \vdash \exists X.P(X)$ | $\exists i$ con $t := X$ sobre 3 |
| 5 | $\Delta, Q(X) \vdash \forall X.\neg Q(X)$ | $ax$ |
| 6 | $\Delta, Q(X) \vdash \neg Q(X)$ | $\forall e$ con $t := X$ sobre 5 |
| 7 | $\Delta, Q(X) \vdash Q(X)$ | $ax$ |
| 8 | $\Delta, Q(X) \vdash \perp$ | $\neg e$ sobre 6 y 7 |
| 9 | $\Delta, Q(X) \vdash \exists X.P(X)$ | $\perp e$ sobre 8 |
| 10 | $\Delta \vdash \exists X.P(X)$ | $\vee e$ sobre 2, 4 y 9 |
| 11 | $\Gamma \vdash \exists X.P(X)$ | $\exists e$ sobre 1 y 10 |
| 12 | $\vdash \dots$ | $\Rightarrow i$ dos veces sobre 11 |

*Restricciones:* paso 11 requiere $X \notin fv(\Gamma, \exists X.P(X)) = \emptyset$ $\checkmark$. El $\perp e$ (*ex falso*) del paso 9 es **intuicionista**, no hace falta $PBC$.

---

**xii.** $(\neg\forall X.\exists Y.R(X,Y)) \Rightarrow \neg\forall X.R(X,X)$

Contrarrecíproco de $\forall X.R(X,X) \Rightarrow \forall X.\exists Y.R(X,Y)$. Sea $\Gamma = \{\neg\forall X.\exists Y.R(X,Y)\}$ y $\Delta = \Gamma, \forall X.R(X,X)$; cerrados.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta \vdash \forall X.R(X,X)$ | $ax$ |
| 2 | $\Delta \vdash R(X,X)$ | $\forall e$ con $t := X$ sobre 1 |
| 3 | $\Delta \vdash \exists Y.R(X,Y)$ | $\exists i$ con $t := X$ sobre 2 |
| 4 | $\Delta \vdash \forall X.\exists Y.R(X,Y)$ | $\forall i$ sobre 3 |
| 5 | $\Delta \vdash \neg\forall X.\exists Y.R(X,Y)$ | $ax$ |
| 6 | $\Delta \vdash \perp$ | $\neg e$ sobre 5 y 4 |
| 7 | $\Gamma \vdash \neg\forall X.R(X,X)$ | $\neg i$ sobre 6 |
| 8 | $\vdash \dots$ | $\Rightarrow i$ sobre 7 |

*Restricciones:* paso 4 requiere $X \notin fv(\Delta) = \emptyset$ $\checkmark$. Paso 3: se instancia $\exists i$ con $t := X$, o sea $R(X,Y)\{Y := X\} = R(X,X)$ — la diagonal es un caso particular del existencial.

---

**xiii.** $(\neg\exists X.\forall Y.R(Y,X)) \Rightarrow \exists X.\exists Y.\neg R(X,Y)$ — **el único clásico**.

*Por qué es clásico:* de "no hay una columna llena" se quiere concluir "hay un par que falla". Constructivamente, la negación de un existencial no produce testigos. Hace falta $PBC$ (o $LEM$) **dos veces**.

Sea $\Gamma = \{\neg\exists X.\forall Y.R(Y,X)\}$ y $\Delta = \Gamma, \neg\exists X.\exists Y.\neg R(X,Y)$; ambos cerrados. $U, V$ frescas.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta, \neg R(U,V) \vdash \neg R(U,V)$ | $ax$ |
| 2 | $\Delta, \neg R(U,V) \vdash \exists Y.\neg R(U,Y)$ | $\exists i$ con $t := V$ sobre 1 |
| 3 | $\Delta, \neg R(U,V) \vdash \exists X.\exists Y.\neg R(X,Y)$ | $\exists i$ con $t := U$ sobre 2 |
| 4 | $\Delta, \neg R(U,V) \vdash \neg\exists X.\exists Y.\neg R(X,Y)$ | $ax$ |
| 5 | $\Delta, \neg R(U,V) \vdash \perp$ | $\neg e$ sobre 4 y 3 |
| 6 | $\Delta \vdash R(U,V)$ | $PBC$ sobre 5 (**clásico**) |
| 7 | $\Delta \vdash \forall Y.R(Y,V)$ | $\forall i$ sobre 6 (generalizando $U$, luego $\alpha$) |
| 8 | $\Delta \vdash \exists X.\forall Y.R(Y,X)$ | $\exists i$ con $t := V$ sobre 7 |
| 9 | $\Delta \vdash \neg\exists X.\forall Y.R(Y,X)$ | $ax$ |
| 10 | $\Delta \vdash \perp$ | $\neg e$ sobre 9 y 8 |
| 11 | $\Gamma \vdash \exists X.\exists Y.\neg R(X,Y)$ | $PBC$ sobre 10 (**clásico**) |
| 12 | $\vdash \dots$ | $\Rightarrow i$ sobre 11 |

*Restricciones:* paso 7 requiere $U \notin fv(\Delta) = \emptyset$ $\checkmark$ — y acá se ve por qué el $PBC$ del paso 6 es indispensable **antes** del $\forall i$: descarga la hipótesis $\neg R(U,V)$, que era la única que mencionaba $U$. Con esa hipótesis todavía en el contexto, $\forall i$ sería ilegal.

*Estructura de la prueba:* $PBC$ externo (11) para conseguir la meta existencial; adentro, $PBC$ interno (6) para conseguir cada átomo $R(U,V)$ a partir de "no hay contraejemplo"; con los átomos se arma la columna llena que $\Gamma$ prohíbe. Es la misma forma que el ítem ix del [Ej. 9](#ejercicio-9-—-deducción-natural) ($\neg\forall \Rightarrow \exists\neg$).

---

**xiv.** $\neg(\forall X.P(X) \wedge \exists X.\neg P(X))$ — no contradicción cuantificada.

Sea $\Gamma = \{\forall X.P(X) \wedge \exists X.\neg P(X)\}$, cerrada, y $\Delta = \Gamma, \neg P(X)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \forall X.P(X) \wedge \exists X.\neg P(X)$ | $ax$ |
| 2 | $\Gamma \vdash \forall X.P(X)$ | $\wedge e_1$ sobre 1 |
| 3 | $\Gamma \vdash \exists X.\neg P(X)$ | $\wedge e_2$ sobre 1 |
| 4 | $\Delta \vdash \forall X.P(X)$ | $ax$ (2 debilitado) |
| 5 | $\Delta \vdash P(X)$ | $\forall e$ con $t := X$ sobre 4 |
| 6 | $\Delta \vdash \neg P(X)$ | $ax$ |
| 7 | $\Delta \vdash \perp$ | $\neg e$ sobre 6 y 5 |
| 8 | $\Gamma \vdash \perp$ | $\exists e$ sobre 3 y 7 |
| 9 | $\vdash \neg(\forall X.P(X) \wedge \exists X.\neg P(X))$ | $\neg i$ sobre 8 |

*Restricciones:* paso 8 requiere $X \notin fv(\Gamma, \perp) = \emptyset$ $\checkmark$ — la conclusión $\perp$ es cerrada, que es el caso más cómodo posible de $\exists e$.

---

**xv.** $(\exists X.(R(X,X) \wedge P(X))) \Rightarrow \neg\forall X.(P(X) \Rightarrow \neg\exists Y.R(X,Y))$

Sea $\Gamma = \{\exists X.(R(X,X) \wedge P(X))\}$, $\Delta = \Gamma, \forall X.(P(X) \Rightarrow \neg\exists Y.R(X,Y))$ (cerrados) y $\Theta = \Delta, R(U,U) \wedge P(U)$ con $U$ fresca.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta \vdash \exists X.(R(X,X) \wedge P(X))$ | $ax$ |
| 2 | $\Theta \vdash R(U,U) \wedge P(U)$ | $ax$ |
| 3 | $\Theta \vdash R(U,U)$ | $\wedge e_1$ sobre 2 |
| 4 | $\Theta \vdash P(U)$ | $\wedge e_2$ sobre 2 |
| 5 | $\Theta \vdash \forall X.(P(X) \Rightarrow \neg\exists Y.R(X,Y))$ | $ax$ |
| 6 | $\Theta \vdash P(U) \Rightarrow \neg\exists Y.R(U,Y)$ | $\forall e$ con $t := U$ sobre 5 |
| 7 | $\Theta \vdash \neg\exists Y.R(U,Y)$ | $\Rightarrow e$ sobre 6 y 4 |
| 8 | $\Theta \vdash \exists Y.R(U,Y)$ | $\exists i$ con $t := U$ sobre 3 |
| 9 | $\Theta \vdash \perp$ | $\neg e$ sobre 7 y 8 |
| 10 | $\Delta \vdash \perp$ | $\exists e$ sobre 1 y 9 |
| 11 | $\Gamma \vdash \neg\forall X.(P(X) \Rightarrow \neg\exists Y.R(X,Y))$ | $\neg i$ sobre 10 |
| 12 | $\vdash \dots$ | $\Rightarrow i$ sobre 11 |

*Restricciones:* paso 10 requiere $U \notin fv(\Delta, \perp)$: las dos fórmulas de $\Delta$ son cerradas y $U$ es fresca $\checkmark$. Paso 6: $U$ es libre para $X$ ($U \neq Y$) $\checkmark$

*Idea:* el mismo testigo $U$ sirve para las tres cosas — cumple $R(U,U)$, cumple $P(U)$, y $R(U,U)$ es el testigo de $\exists Y.R(U,Y)$ que contradice lo que la hipótesis universal prohíbe.

---

**xvi.** $(\exists X.P(X) \Rightarrow \forall X.Q(X)) \Rightarrow \forall Y.(P(Y) \Rightarrow Q(Y))$

Sea $\Gamma = \{\exists X.P(X) \Rightarrow \forall X.Q(X)\}$ (cerrada) y $\Delta = \Gamma, P(Y)$.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Delta \vdash P(Y)$ | $ax$ |
| 2 | $\Delta \vdash \exists X.P(X)$ | $\exists i$ con $t := Y$ sobre 1 |
| 3 | $\Delta \vdash \exists X.P(X) \Rightarrow \forall X.Q(X)$ | $ax$ |
| 4 | $\Delta \vdash \forall X.Q(X)$ | $\Rightarrow e$ sobre 3 y 2 |
| 5 | $\Delta \vdash Q(Y)$ | $\forall e$ con $t := Y$ sobre 4 |
| 6 | $\Gamma \vdash P(Y) \Rightarrow Q(Y)$ | $\Rightarrow i$ sobre 5 |
| 7 | $\Gamma \vdash \forall Y.(P(Y) \Rightarrow Q(Y))$ | $\forall i$ sobre 6 |
| 8 | $\vdash \dots$ | $\Rightarrow i$ sobre 7 |

*Restricciones:* paso 7 requiere $Y \notin fv(\Gamma) = \emptyset$ $\checkmark$; nótese que $P(Y)$ ya fue descargada en el paso 6 $\checkmark$

*Alcance:* se lee el antecedente como $(\exists X.P(X)) \Rightarrow (\forall X.Q(X))$. Con la lectura de alcance máximo ($\exists X.(P(X) \Rightarrow \forall X'.Q(X'))$) la fórmula **no** es válida — contramodelo: $D = \{0,1\}$, $P = \{0\}$, $Q = \emptyset$ (el antecedente vale con testigo $X = 1$, el consecuente falla en $Y = 0$).

---

**xvii.** $\neg(\forall X.(P(X) \wedge Q(X))) \wedge \forall X.P(X) \Rightarrow \neg\forall X.Q(X)$

Sea $\Gamma = \{\neg(\forall X.(P(X) \wedge Q(X))) \wedge \forall X.P(X)\}$ y $\Delta = \Gamma, \forall X.Q(X)$; cerrados.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash \neg(\forall X.(P(X) \wedge Q(X))) \wedge \forall X.P(X)$ | $ax$ |
| 2 | $\Gamma \vdash \neg\forall X.(P(X) \wedge Q(X))$ | $\wedge e_1$ sobre 1 |
| 3 | $\Gamma \vdash \forall X.P(X)$ | $\wedge e_2$ sobre 1 |
| 4 | $\Delta \vdash P(X)$ | $\forall e$ con $t := X$ sobre 3 (debilitado) |
| 5 | $\Delta \vdash \forall X.Q(X)$ | $ax$ |
| 6 | $\Delta \vdash Q(X)$ | $\forall e$ con $t := X$ sobre 5 |
| 7 | $\Delta \vdash P(X) \wedge Q(X)$ | $\wedge i$ sobre 4 y 6 |
| 8 | $\Delta \vdash \forall X.(P(X) \wedge Q(X))$ | $\forall i$ sobre 7 |
| 9 | $\Delta \vdash \neg\forall X.(P(X) \wedge Q(X))$ | $ax$ (2 debilitado) |
| 10 | $\Delta \vdash \perp$ | $\neg e$ sobre 9 y 8 |
| 11 | $\Gamma \vdash \neg\forall X.Q(X)$ | $\neg i$ sobre 10 |
| 12 | $\vdash \dots$ | $\Rightarrow i$ sobre 11 |

*Restricciones:* paso 8 requiere $X \notin fv(\Delta) = \emptyset$ $\checkmark$ (todas las hipótesis son cerradas; las $X$ que aparecen están ligadas).

*Idea:* es el contrarrecíproco de la distribución $\forall P \wedge \forall Q \Rightarrow \forall(P \wedge Q)$ — intuicionista.

---

**xviii.** $(\forall X.(R(X,X) \Rightarrow Q(X))) \wedge \exists X.\forall Y.R(X,Y) \Rightarrow \exists X.Q(X)$

Sea $\Gamma = \{(\forall X.(R(X,X) \Rightarrow Q(X))) \wedge \exists X.\forall Y.R(X,Y)\}$ (cerrada) y $\Delta = \Gamma, \forall Y.R(U,Y)$ con $U$ fresca.

| # | Juicio | Regla |
|---|---|---|
| 1 | $\Gamma \vdash (\forall X.(R(X,X) \Rightarrow Q(X))) \wedge \exists X.\forall Y.R(X,Y)$ | $ax$ |
| 2 | $\Gamma \vdash \forall X.(R(X,X) \Rightarrow Q(X))$ | $\wedge e_1$ sobre 1 |
| 3 | $\Gamma \vdash \exists X.\forall Y.R(X,Y)$ | $\wedge e_2$ sobre 1 |
| 4 | $\Delta \vdash \forall Y.R(U,Y)$ | $ax$ |
| 5 | $\Delta \vdash R(U,U)$ | $\forall e$ con $t := U$ sobre 4 |
| 6 | $\Delta \vdash \forall X.(R(X,X) \Rightarrow Q(X))$ | $ax$ (2 debilitado) |
| 7 | $\Delta \vdash R(U,U) \Rightarrow Q(U)$ | $\forall e$ con $t := U$ sobre 6 |
| 8 | $\Delta \vdash Q(U)$ | $\Rightarrow e$ sobre 7 y 5 |
| 9 | $\Delta \vdash \exists X.Q(X)$ | $\exists i$ con $t := U$ sobre 8 |
| 10 | $\Gamma \vdash \exists X.Q(X)$ | $\exists e$ sobre 3 y 9 |
| 11 | $\vdash \dots$ | $\Rightarrow i$ sobre 10 |

*Restricciones:* paso 10 requiere $U \notin fv(\Gamma, \exists X.Q(X)) = \emptyset$ $\checkmark$. Paso 5: instanciar el $\forall Y$ con la **misma** $U$ del testigo es lo que produce la diagonal $R(U,U)$ que pide la primera hipótesis.

---

**Resumen por técnica**

| Técnica dominante | Ítems |
|---|---|
| $\forall e$ / $\exists i$ directos | i, ii, iv, v, xii |
| Instanciar dos veces con el **mismo** término (diagonal) | iii, iv, xii, xviii |
| $\exists e$ para abrir un testigo | vi, viii, x, xi, xiv, xv, xviii |
| $\neg i$ + $\neg e$ (reducción al absurdo intuicionista) | iii, vii, ix, xii, xiv, xv, xvii |
| $\vee e$ + $\perp e$ | xi |
| **$PBC$ (clásico)** | xiii |
| $\exists e$ **anidado** + renombre | x |

**Observaciones**

- **Los tres errores que aparecen siempre.** (1) Hacer $\forall i$ con la hipótesis testigo todavía en el contexto — el $\neg i$ o el $\Rightarrow i$ van **antes** (iii, v, ix, xiii, xvi). (2) Dejar que la variable de $\exists e$ **se escape** a la conclusión. (3) Instanciar $\forall e$ con un término que queda **capturado** por un cuantificador interno — por eso en x se renombró primero.
- **Casos base útiles.** i y ii son literalmente $\forall e$ y $\exists i$ con un $\Rightarrow i$ arriba; conviene reconocerlos como sub-derivaciones de todo lo demás.
- **Dónde está la frontera clásica.** Sólo xiii. La regla general: $\neg\exists \Leftrightarrow \forall\neg$ y $\exists\neg \Rightarrow \neg\forall$ son intuicionistas; $\neg\forall \Rightarrow \exists\neg$ (y su prima $\neg\exists\forall \Rightarrow \exists\exists\neg$) **no** lo son.

⚠️ Verificar — el enunciado no aclara si se permiten principios clásicos. Se resolvió intuicionísticamente donde se pudo y se marcó explícitamente el único ítem (xiii) que requiere $PBC$; si la consigna heredara la restricción del Ej. 9 ("sin usar principios de razonamiento clásicos"), el xiii **no sería derivable**.

**Chuleta**
> 1. **Meta primero, hipótesis después**: $\Rightarrow i$ / $\neg i$ / $\forall i$ / $\wedge i$ según el conectivo principal de la meta; después $\wedge e$, $\forall e$, $\exists e$, $\vee e$ sobre las hipótesis → 2. **$\exists i$ último**, cuando ya tenés probado $\sigma\{X := t\}$ y sabés qué $t$ poner → 3. **Descargar antes de generalizar**: el $\neg i$ / $\Rightarrow i$ que saca del contexto la hipótesis con $X$ va **antes** del $\forall i$ (iii, v, ix, xiii, xvi) → 4. $\forall i$: chequear $X \notin fv(\Gamma)$ — con hipótesis cerradas es trivial, **pero hay que escribirlo** → 5. $\exists e$: chequear $X \notin fv(\Gamma, \tau)$; si $\tau = \perp$ o $\tau$ es cerrada, sale gratis → 6. Testigos **frescos**: si hay dos $\exists e$ anidados, usar dos variables nuevas y renombrar la hipótesis universal si hace falta (x) → 7. Patrón "diagonal": instanciar $\forall X.\forall Y$ dos veces con el **mismo** término (iii, iv, xviii) → 8. Patrón "contrarrecíproco": para $\neg\beta \Rightarrow \neg\alpha$, asumir $\neg\beta$ y $\alpha$, derivar $\beta$, chocar (vii, xii, xvii) → 9. De $\perp$ se deduce cualquier cosa con $\perp e$, y eso es **intuicionista**; $PBC$ sólo si de verdad hace falta → 10. Regla de oro: si la meta es un $\exists$ y las hipótesis son todas **negativas**, es clásico (xiii).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/deduccion_natural_lpo]]
