---
nombre: Práctica 3 - Demostración en Lógica Proposicional
parcial: 1P
programa: 2C_2026
tipo: Guía de Ejercicios
tema: sistemas_deductivos_y_deduccion_natural
fuente: raw/guias_practicas/2.guia_1P_demostracion_en_logica_proposicional.pdf
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
Valuación: $P = V$, $Q = V$, $S = F$, $T = F$. Se evalúa de adentro hacia afuera usando las tablas de los conectivos ($\Leftrightarrow$ vale $V$ sólo si ambos lados coinciden).

| # | Fórmula | Evaluación | Valor |
|---|---|---|---|
| I | $\neg P \vee Q$ | $F \vee V$ | **V** |
| II | $P \vee (S \wedge T) \vee Q$ | $V \vee (F \wedge F) \vee V = V \vee F \vee V$ | **V** |
| III | $\neg(Q \vee S)$ | $\neg(V \vee F) = \neg V$ | **F** |
| IV | $(\neg P \vee S) \Leftrightarrow (\neg P \wedge \neg S)$ | izq: $F \vee F = F$; der: $F \wedge V = F$; $F \Leftrightarrow F$ | **V** |
| V | $(P \vee S) \wedge (T \vee Q)$ | $(V \vee F) \wedge (F \vee V) = V \wedge V$ | **V** |
| VI | $((P \vee S) \wedge (T \vee Q)) \Leftrightarrow (P \vee (S \wedge T) \vee Q)$ | $V \Leftrightarrow V$ (por V y II) | **V** |
| VII | $\neg Q \wedge \neg S$ | $F \wedge V$ | **F** |

Observación: IV da $V$ aunque ambos lados sean falsos — el bicondicional mide *coincidencia*, no verdad. Y VI resulta $V$ porque ambas fórmulas valen $V$ *en esta valuación*, lo cual no significa que sean lógicamente equivalentes (para eso habría que chequear las 16 valuaciones).

**Chuleta**
> 1. Sustituir $P=Q=V$, $S=T=F$ → 2. evaluar de adentro hacia afuera → 3. $\Leftrightarrow$ es $V$ sólo si ambos lados coinciden (aunque los dos sean $F$) → 4. Resultados: I=V, II=V, III=F, IV=V, V=V, VI=V, VII=F.

---

### Ejercicio 2
Mostrar que cualquier fórmula de la lógica proposicional que utilice los conectivos $\neg$ (negación), $\wedge$ (conjunción), $\vee$ (disyunción), $\Rightarrow$ (implicación) puede reescribirse a otra fórmula equivalente que usa sólo los conectivos $\neg$ y $\vee$.
**Sugerencia:** hacer inducción en la estructura de la fórmula.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Demostración de que el conjunto $\{\neg, \vee\}$ es funcionalmente completo.

**Resolución:**
**Idea.** Se define una función de traducción $T$ que reescribe cualquier fórmula a una que sólo usa $\neg$ y $\vee$, y se prueba por inducción estructural que $T$ preserva el significado.

**Definición de la traducción** (por recursión en la estructura de la fórmula):

$$
\begin{aligned}
T(P) &= P &&\text{(variable proposicional)}\\
T(\neg \tau) &= \neg T(\tau)\\
T(\tau \vee \sigma) &= T(\tau) \vee T(\sigma)\\
T(\tau \wedge \sigma) &= \neg(\neg T(\tau) \vee \neg T(\sigma))\\
T(\tau \Rightarrow \sigma) &= \neg T(\tau) \vee T(\sigma)
\end{aligned}
$$

**Paso 1 — $T(\tau)$ sólo usa $\neg$ y $\vee$.** Inducción estructural inmediata: los casos base son variables (sin conectivos) y cada caso inductivo construye la salida usando únicamente $\neg$ y $\vee$ sobre subtérminos que, por H.I., ya sólo usan $\neg$ y $\vee$.

**Paso 2 — $T$ preserva la semántica:** para toda valuación $v$ vale $v \models \tau \iff v \models T(\tau)$.

Inducción estructural en $\tau$.

- **Caso $\tau = P$.** $T(P) = P$, trivial.

- **Caso $\tau = \neg \rho$.** $v \models \neg\rho \iff v \not\models \rho \overset{\text{H.I.}}{\iff} v \not\models T(\rho) \iff v \models \neg T(\rho) = T(\neg\rho)$.

- **Caso $\tau = \rho \vee \sigma$.** $v \models \rho \vee \sigma \iff v \models \rho$ o $v \models \sigma \overset{\text{H.I.}}{\iff} v \models T(\rho)$ o $v \models T(\sigma) \iff v \models T(\rho) \vee T(\sigma)$.

- **Caso $\tau = \rho \wedge \sigma$.**
$$
v \models \rho \wedge \sigma
\iff v \models \rho \text{ y } v \models \sigma
\overset{\text{H.I.}}{\iff} v \models T(\rho) \text{ y } v \models T(\sigma)
$$
$$
\iff v \not\models \neg T(\rho) \text{ y } v \not\models \neg T(\sigma)
\iff v \not\models (\neg T(\rho) \vee \neg T(\sigma))
\iff v \models \neg(\neg T(\rho) \vee \neg T(\sigma))
$$
que es exactamente $T(\rho \wedge \sigma)$ (de Morgan semántico).

- **Caso $\tau = \rho \Rightarrow \sigma$.**
$$
v \models \rho \Rightarrow \sigma
\iff v \not\models \rho \text{ o } v \models \sigma
\overset{\text{H.I.}}{\iff} v \not\models T(\rho) \text{ o } v \models T(\sigma)
\iff v \models \neg T(\rho) \vee T(\sigma) = T(\rho \Rightarrow \sigma)
$$

Como $v \models \tau \iff v \models T(\tau)$ para toda $v$, las fórmulas $\tau$ y $T(\tau)$ son lógicamente equivalentes, y $T(\tau)$ usa sólo $\neg$ y $\vee$. Por lo tanto $\{\neg, \vee\}$ es **funcionalmente completo**. $\blacksquare$

**Observación.** Si se incluye $\bot$ en la gramática, basta agregar $T(\bot) = \neg(P \vee \neg P)$ para una variable fija $P$ (fórmula insatisfactible que sólo usa $\neg$ y $\vee$). Análogamente $\{\neg, \wedge\}$ y $\{\Rightarrow, \bot\}$ también son funcionalmente completos; $\{\wedge, \vee\}$ **no** lo es (ver Ejercicio 4).

**Chuleta**
> 1. Definir $T$ por recursión: $T(P)=P$, $T(\neg\tau)=\neg T(\tau)$, $T(\tau\vee\sigma)=T(\tau)\vee T(\sigma)$ → 2. los dos casos interesantes: $T(\tau\wedge\sigma)=\neg(\neg T\tau \vee \neg T\sigma)$ (de Morgan) y $T(\tau\Rightarrow\sigma)=\neg T\tau \vee T\sigma$ → 3. inducción estructural: $v \models \tau \iff v \models T(\tau)$, usando H.I. en cada subfórmula → 4. conclusión: $\{\neg,\vee\}$ es funcionalmente completo.

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

**Lema clave — qué significa que $\rho \Rightarrow \zeta$ sea contradicción.**

Por la tabla de verdad de $\Rightarrow$, para toda valuación $v$:
$$v(\rho \Rightarrow \zeta) = F \iff v(\rho) = V \ \text{ y } \ v(\zeta) = F$$

Que $\rho \Rightarrow \zeta$ sea **contradicción** quiere decir que esto pasa para **toda** valuación. Por lo tanto:
$$\rho \Rightarrow \zeta \text{ es contradicción} \iff \rho \text{ es tautología } \textbf{y} \ \zeta \text{ es contradicción}$$

Esta es la observación que resuelve los tres ítems: la hipótesis no dice algo sobre la combinación $\rho \Rightarrow \zeta$, dice algo mucho más fuerte sobre $\rho$ y $\zeta$ **por separado**.

De la otra hipótesis, $\tau \Rightarrow \sigma$ tautología, sólo sabemos que para toda $v$, si $v(\tau) = V$ entonces $v(\sigma) = V$ (no fija el valor de $\tau$ ni el de $\sigma$).

**I. $(\tau \Rightarrow \sigma) \vee (\rho \Rightarrow \zeta)$ — TAUTOLOGÍA**

Sea $v$ cualquier valuación. Por hipótesis $v(\tau \Rightarrow \sigma) = V$ (es tautología). Entonces
$$v\big((\tau \Rightarrow \sigma) \vee (\rho \Rightarrow \zeta)\big) = V \vee v(\rho \Rightarrow \zeta) = V \vee F = V$$

Vale para toda $v$, así que es tautología. (Basta con que **un** disyunto sea tautología; el otro no importa.) $\blacksquare$

**II. $(\tau \Rightarrow \rho) \vee (\sigma \Rightarrow \zeta)$ — TAUTOLOGÍA**

Por el lema, $\rho$ es tautología: $v(\rho) = V$ para toda $v$. Entonces el primer disyunto tiene consecuente verdadero:
$$v(\tau \Rightarrow \rho) = v(\tau) \Rightarrow V = V$$
(cualquier cosa implica algo verdadero). Luego $v\big((\tau \Rightarrow \rho) \vee (\sigma \Rightarrow \zeta)\big) = V \vee \dots = V$ para toda $v$. $\blacksquare$

**III. $(\rho \Rightarrow \sigma) \vee (\zeta \Rightarrow \sigma)$ — TAUTOLOGÍA**

Por el lema, $\zeta$ es contradicción: $v(\zeta) = F$ para toda $v$. Entonces el segundo disyunto tiene antecedente falso:
$$v(\zeta \Rightarrow \sigma) = F \Rightarrow v(\sigma) = V$$
(*ex falso quodlibet*: una implicación con antecedente falso es verdadera). Luego toda la disyunción vale $V$ para toda $v$. $\blacksquare$

**Resumen:** las tres son **tautologías**. Ninguna es contradicción ni contingencia.

**Trampa a evitar.** El error típico es leer "$\rho \Rightarrow \zeta$ es contradicción" como "$\rho$ y $\zeta$ son ambas falsas" o como una restricción débil. Es al revés: fuerza $\rho \equiv \top$ y $\zeta \equiv \bot$, que son los dos hechos que hacen verdaderos los disyuntos de II y III.

**Chuleta**
> 1. Lema: $\rho \Rightarrow \zeta$ contradicción $\iff$ $\rho$ tautología **y** $\zeta$ contradicción (única forma de que $\Rightarrow$ dé $F$: $V \Rightarrow F$) → 2. I: un disyunto ya es tautología ⟹ toda la $\vee$ es tautología → 3. II: $\rho \equiv \top$ ⟹ $\tau \Rightarrow \rho = V$ (consecuente verdadero) → 4. III: $\zeta \equiv \bot$ ⟹ $\zeta \Rightarrow \sigma = V$ (antecedente falso, *ex falso*) → 5. Las tres: **tautologías**.

---

### Ejercicio 4
Probar que cualquier fórmula que sea una tautología contiene un $\neg$ o una $\Rightarrow$.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Análisis de la preservación de la verdad. Sin negación ni implicación, una fórmula con átomos falsos siempre será falsa.

**Resolución:**

**Qué hay que probar.** Sea $\varphi$ una fórmula construida únicamente con variables proposicionales y los conectivos $\wedge$ y $\vee$ (es decir, sin $\neg$ y sin $\Rightarrow$). Queremos ver que $\varphi$ **no** es tautología. Esto es el contrarrecíproco del enunciado: si $\varphi$ es tautología, entonces contiene $\neg$ o $\Rightarrow$.

**La valuación testigo.** Definimos $v_F$ como la valuación que asigna $F$ a **toda** variable proposicional:
$$v_F(p) = F \quad \text{para toda variable } p$$

**Lema.** Para toda fórmula $\varphi$ sin $\neg$ ni $\Rightarrow$ vale $v_F(\varphi) = F$.

*Demostración por inducción estructural sobre $\varphi$.*

- **Caso base** ($\varphi = p$, variable proposicional): $v_F(p) = F$ por definición de $v_F$. ✓

- **Caso $\varphi = \psi \wedge \chi$:** por hipótesis inductiva $v_F(\psi) = F$ y $v_F(\chi) = F$. Entonces
$$v_F(\psi \wedge \chi) = v_F(\psi) \wedge v_F(\chi) = F \wedge F = F \quad ✓$$

- **Caso $\varphi = \psi \vee \chi$:** por hipótesis inductiva $v_F(\psi) = F$ y $v_F(\chi) = F$. Entonces
$$v_F(\psi \vee \chi) = v_F(\psi) \vee v_F(\chi) = F \vee F = F \quad ✓$$

No hay más casos: por hipótesis $\varphi$ no contiene $\neg$ ni $\Rightarrow$, y esos son los únicos constructores restantes del lenguaje. $\blacksquare$

**Cierre del argumento.** Si $\varphi$ no contiene $\neg$ ni $\Rightarrow$, el lema da $v_F(\varphi) = F$, así que existe una valuación que la falsifica y por lo tanto $\varphi$ no es tautología. Contrarrecíproco: toda tautología contiene al menos un $\neg$ o un $\Rightarrow$. $\blacksquare$

**Por qué son justo esos dos conectivos.** $\wedge$ y $\vee$ son *monótonos* y preservan el $F$: con todo en falso el resultado queda en falso, y nunca se puede "subir" a verdadero. $\neg$ es el único conectivo primitivo que invierte el valor, y $\Rightarrow$ lo esconde ($\psi \Rightarrow \chi \equiv \neg\psi \vee \chi$), que es como $F \Rightarrow F = V$ logra escapar del lema.

**Chuleta**
> 1. Contrarrecíproco: sin $\neg$ ni $\Rightarrow$ ⟹ no es tautología → 2. Testigo: $v_F$ = todo en $F$ → 3. Inducción estructural: base $v_F(p)=F$; $F \wedge F = F$; $F \vee F = F$ → 4. Falsificada por $v_F$ ⟹ no tautología → 5. Idea: $\wedge,\vee$ preservan $F$; sólo $\neg$ (y $\Rightarrow$, que lo contiene) puede dar vuelta el valor.

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
**Convenciones usadas en todo el ejercicio**
- $\neg\tau$ se comporta exactamente como $\tau \Rightarrow \bot$ (por eso $\neg i$ / $\neg e$ y $\Rightarrow i$ / $\Rightarrow e$ son intercambiables sobre negaciones).
- $\tau \Leftrightarrow \sigma$ abrevia $(\tau \Rightarrow \sigma) \wedge (\sigma \Rightarrow \tau)$: cada $\Leftrightarrow$ se prueba con **dos derivaciones** y un $\wedge i$ final.
- Estrategia general (lectura de abajo hacia arriba): si la tesis es $\tau \Rightarrow \sigma$, lo último fue $\Rightarrow i$; si es $\neg\tau$, lo último fue $\neg i$; si es $\tau \wedge \sigma$, fue $\wedge i$. Cuando hay un $\vee$ en el contexto, usar $\lor e$ lo antes posible.
- Todas las derivaciones siguientes son **intuicionistas (LJ)** salvo la dirección $\Rightarrow$ del inciso VIII, que se marca explícitamente.
- Se indica el término $\lambda$ asociado por **Curry-Howard** ($\Rightarrow \leadsto \to$, $\wedge \leadsto \times$, $\vee \leadsto +$, $\bot \leadsto$ tipo vacío).

---

**I. Modus ponens relativizado** — $(\rho \Rightarrow \sigma \Rightarrow \tau) \Rightarrow (\rho \Rightarrow \sigma) \Rightarrow \rho \Rightarrow \tau$

Sea $\Gamma = \rho \Rightarrow \sigma \Rightarrow \tau,\; \rho \Rightarrow \sigma,\; \rho$.

1. $\Gamma \vdash \rho \Rightarrow \sigma \Rightarrow \tau$ — $ax$
2. $\Gamma \vdash \rho$ — $ax$
3. $\Gamma \vdash \sigma \Rightarrow \tau$ — $\Rightarrow e$ (1, 2)
4. $\Gamma \vdash \rho \Rightarrow \sigma$ — $ax$
5. $\Gamma \vdash \sigma$ — $\Rightarrow e$ (4, 2)
6. $\Gamma \vdash \tau$ — $\Rightarrow e$ (3, 5)
7. $\rho \Rightarrow \sigma \Rightarrow \tau,\; \rho \Rightarrow \sigma \vdash \rho \Rightarrow \tau$ — $\Rightarrow i$ (**descarga $\rho$**)
8. $\rho \Rightarrow \sigma \Rightarrow \tau \vdash (\rho \Rightarrow \sigma) \Rightarrow \rho \Rightarrow \tau$ — $\Rightarrow i$ (**descarga $\rho \Rightarrow \sigma$**)
9. $\vdash (\rho \Rightarrow \sigma \Rightarrow \tau) \Rightarrow (\rho \Rightarrow \sigma) \Rightarrow \rho \Rightarrow \tau$ — $\Rightarrow i$ (**descarga $\rho \Rightarrow \sigma \Rightarrow \tau$**)

*Curry-Howard:* $\lambda x^{\rho \to \sigma \to \tau}. \lambda y^{\rho \to \sigma}. \lambda z^{\rho}.\, (x\, z)\, (y\, z)$ — es exactamente el combinador $S$.

---

**II. Reducción al absurdo** — $(\rho \Rightarrow \bot) \Rightarrow \neg\rho$

Sea $\Gamma = \rho \Rightarrow \bot,\; \rho$.

$$
\dfrac{\dfrac{\dfrac{\dfrac{}{\Gamma \vdash \rho \Rightarrow \bot}\,ax \quad \dfrac{}{\Gamma \vdash \rho}\,ax}{\Gamma \vdash \bot}\,\Rightarrow e}{\rho \Rightarrow \bot \vdash \neg\rho}\,\neg i}{\vdash (\rho \Rightarrow \bot) \Rightarrow \neg\rho}\,\Rightarrow i
$$

- $\neg i$ **descarga $\rho$**; $\Rightarrow i$ **descarga $\rho \Rightarrow \bot$**.
- El teorema formaliza que $\neg\rho$ y $\rho \Rightarrow \bot$ son la misma cosa (la vuelta es igual de directa).

*Curry-Howard:* $\lambda x^{\rho \to \bot}. \lambda y^{\rho}.\, x\, y$ — la identidad $\eta$-expandida, porque $\neg\rho$ y $\rho \to \bot$ son el mismo tipo.

---

**III. Introducción de la doble negación** — $\rho \Rightarrow \neg\neg\rho$

$$
\dfrac{\dfrac{\dfrac{\dfrac{}{\rho, \neg\rho \vdash \rho}\,ax \quad \dfrac{}{\rho, \neg\rho \vdash \neg\rho}\,ax}{\rho, \neg\rho \vdash \bot}\,\neg e}{\rho \vdash \neg\neg\rho}\,\neg i}{\vdash \rho \Rightarrow \neg\neg\rho}\,\Rightarrow i
$$

- $\neg i$ **descarga $\neg\rho$** (la hipótesis auxiliar), $\Rightarrow i$ **descarga $\rho$**.
- Ojo: la vuelta $\neg\neg\rho \Rightarrow \rho$ **no** es intuicionista (es la regla $\neg\neg e$ de LK).

*Curry-Howard:* $\lambda x^{\rho}. \lambda f^{\neg\rho}.\, f\, x$ — "dame un consumidor de $\rho$ y le paso mi $\rho$".

---

**IV. Eliminación de la triple negación** — $\neg\neg\neg\rho \Rightarrow \neg\rho$

Sea $\Gamma = \neg\neg\neg\rho,\; \rho$. Notar que $\neg\neg\neg\rho = \neg(\neg\neg\rho)$.

1. $\Gamma, \neg\rho \vdash \rho$ — $ax$
2. $\Gamma, \neg\rho \vdash \neg\rho$ — $ax$
3. $\Gamma, \neg\rho \vdash \bot$ — $\neg e$ (1, 2)
4. $\Gamma \vdash \neg\neg\rho$ — $\neg i$ (**descarga $\neg\rho$**) — es el inciso III instanciado
5. $\Gamma \vdash \neg(\neg\neg\rho)$ — $ax$
6. $\Gamma \vdash \bot$ — $\neg e$ (4, 5)
7. $\neg\neg\neg\rho \vdash \neg\rho$ — $\neg i$ (**descarga $\rho$**)
8. $\vdash \neg\neg\neg\rho \Rightarrow \neg\rho$ — $\Rightarrow i$ (**descarga $\neg\neg\neg\rho$**)

Moraleja: intuicionistamente $\neg\neg\neg\rho \Leftrightarrow \neg\rho$ (la vuelta es III con $\neg\rho$ en lugar de $\rho$), aunque $\neg\neg\rho \Leftrightarrow \rho$ **no** valga. Las negaciones colapsan recién a partir de tres.

*Curry-Howard:* $\lambda x^{\neg\neg\neg\rho}. \lambda y^{\rho}.\, x\, (\lambda f^{\neg\rho}.\, f\, y)$.

---

**V. Contraposición** — $(\rho \Rightarrow \sigma) \Rightarrow (\neg\sigma \Rightarrow \neg\rho)$

Sea $\Gamma = \rho \Rightarrow \sigma,\; \neg\sigma,\; \rho$.

1. $\Gamma \vdash \rho \Rightarrow \sigma$ — $ax$
2. $\Gamma \vdash \rho$ — $ax$
3. $\Gamma \vdash \sigma$ — $\Rightarrow e$ (1, 2)
4. $\Gamma \vdash \neg\sigma$ — $ax$
5. $\Gamma \vdash \bot$ — $\neg e$ (3, 4)
6. $\rho \Rightarrow \sigma,\; \neg\sigma \vdash \neg\rho$ — $\neg i$ (**descarga $\rho$**)
7. $\rho \Rightarrow \sigma \vdash \neg\sigma \Rightarrow \neg\rho$ — $\Rightarrow i$ (**descarga $\neg\sigma$**)
8. $\vdash (\rho \Rightarrow \sigma) \Rightarrow (\neg\sigma \Rightarrow \neg\rho)$ — $\Rightarrow i$ (**descarga $\rho \Rightarrow \sigma$**)

Esta dirección es intuicionista; la **contraposición clásica** $(\neg\rho \Rightarrow \neg\sigma) \Rightarrow (\sigma \Rightarrow \rho)$ no lo es (Ejercicio 6.V).

*Curry-Howard:* $\lambda f^{\rho \to \sigma}. \lambda g^{\neg\sigma}. \lambda x^{\rho}.\, g\, (f\, x)$ — composición de funciones.

---

**VI. Adjunción (currificación)** — $((\rho \wedge \sigma) \Rightarrow \tau) \Leftrightarrow (\rho \Rightarrow \sigma \Rightarrow \tau)$

*Dirección $\Rightarrow$.* Sea $\Gamma_1 = (\rho \wedge \sigma) \Rightarrow \tau,\; \rho,\; \sigma$.

1. $\Gamma_1 \vdash \rho$ — $ax$
2. $\Gamma_1 \vdash \sigma$ — $ax$
3. $\Gamma_1 \vdash \rho \wedge \sigma$ — $\wedge i$ (1, 2)
4. $\Gamma_1 \vdash (\rho \wedge \sigma) \Rightarrow \tau$ — $ax$
5. $\Gamma_1 \vdash \tau$ — $\Rightarrow e$ (4, 3)
6. $\vdash ((\rho \wedge \sigma) \Rightarrow \tau) \Rightarrow \rho \Rightarrow \sigma \Rightarrow \tau$ — tres $\Rightarrow i$ (**descargando $\sigma$, luego $\rho$, luego $(\rho \wedge \sigma) \Rightarrow \tau$**)

*Dirección $\Leftarrow$.* Sea $\Gamma_2 = \rho \Rightarrow \sigma \Rightarrow \tau,\; \rho \wedge \sigma$.

1. $\Gamma_2 \vdash \rho \wedge \sigma$ — $ax$
2. $\Gamma_2 \vdash \rho$ — $\wedge e_1$ (1)
3. $\Gamma_2 \vdash \sigma$ — $\wedge e_2$ (1)
4. $\Gamma_2 \vdash \rho \Rightarrow \sigma \Rightarrow \tau$ — $ax$
5. $\Gamma_2 \vdash \sigma \Rightarrow \tau$ — $\Rightarrow e$ (4, 2)
6. $\Gamma_2 \vdash \tau$ — $\Rightarrow e$ (5, 3)
7. $\vdash (\rho \Rightarrow \sigma \Rightarrow \tau) \Rightarrow (\rho \wedge \sigma) \Rightarrow \tau$ — dos $\Rightarrow i$ (**descargando $\rho \wedge \sigma$ y luego $\rho \Rightarrow \sigma \Rightarrow \tau$**)

Finalmente $\wedge i$ sobre ambas derivaciones cerradas da el $\Leftrightarrow$.

*Curry-Howard:* el par $\langle \mathsf{curry}, \mathsf{uncurry}\rangle$ con
$\mathsf{curry} = \lambda f^{(\rho\times\sigma)\to\tau}. \lambda x^{\rho}. \lambda y^{\sigma}.\, f\, \langle x, y\rangle$ y
$\mathsf{uncurry} = \lambda g^{\rho\to\sigma\to\tau}. \lambda p^{\rho\times\sigma}.\, g\, (\pi_1 p)\, (\pi_2 p)$.

---

**VII. de Morgan (I)** — $\neg(\rho \vee \sigma) \Leftrightarrow (\neg\rho \wedge \neg\sigma)$ — **ambas direcciones intuicionistas**

*Dirección $\Rightarrow$.* Sea $\Gamma = \neg(\rho \vee \sigma)$.

1. $\Gamma, \rho \vdash \rho$ — $ax$
2. $\Gamma, \rho \vdash \rho \vee \sigma$ — $\vee i_1$ (1)
3. $\Gamma, \rho \vdash \neg(\rho \vee \sigma)$ — $ax$
4. $\Gamma, \rho \vdash \bot$ — $\neg e$ (2, 3)
5. $\Gamma \vdash \neg\rho$ — $\neg i$ (**descarga $\rho$**)
6. $\Gamma \vdash \neg\sigma$ — idéntico a 1–5 usando $\vee i_2$ (**descarga $\sigma$**)
7. $\Gamma \vdash \neg\rho \wedge \neg\sigma$ — $\wedge i$ (5, 6)
8. $\vdash \neg(\rho \vee \sigma) \Rightarrow (\neg\rho \wedge \neg\sigma)$ — $\Rightarrow i$ (**descarga $\neg(\rho \vee \sigma)$**)

*Dirección $\Leftarrow$.* Sea $\Delta = \neg\rho \wedge \neg\sigma,\; \rho \vee \sigma$.

1. $\Delta \vdash \rho \vee \sigma$ — $ax$
2. $\Delta, \rho \vdash \bot$ — $\neg e$ entre $ax$ ($\rho$) y $\wedge e_1$ sobre $\neg\rho \wedge \neg\sigma$
3. $\Delta, \sigma \vdash \bot$ — $\neg e$ entre $ax$ ($\sigma$) y $\wedge e_2$ sobre $\neg\rho \wedge \neg\sigma$
4. $\Delta \vdash \bot$ — $\vee e$ (1, 2, 3) (**descarga $\rho$ en la rama izquierda y $\sigma$ en la derecha**)
5. $\neg\rho \wedge \neg\sigma \vdash \neg(\rho \vee \sigma)$ — $\neg i$ (**descarga $\rho \vee \sigma$**)
6. $\Rightarrow i$ y luego $\wedge i$ con la otra dirección.

*Curry-Howard:* $\langle\, \lambda h^{\neg(\rho+\sigma)}.\, \langle \lambda x^{\rho}. h\,(\mathsf{inl}\,x),\; \lambda y^{\sigma}. h\,(\mathsf{inr}\,y)\rangle,\;\; \lambda p^{\neg\rho \times \neg\sigma}. \lambda z^{\rho+\sigma}.\, \mathsf{case}\, z\, \{\mathsf{inl}(x) \to \pi_1 p\, x \;||\; \mathsf{inr}(y) \to \pi_2 p\, y\} \,\rangle$ — es la ley de currificación sobre sumas.

---

**VIII. de Morgan (II)** — $\neg(\rho \wedge \sigma) \Leftrightarrow (\neg\rho \vee \neg\sigma)$ — **la dirección $\Rightarrow$ es clásica**

*Dirección $\Leftarrow$ (intuicionista).* Sea $\Delta = \neg\rho \vee \neg\sigma,\; \rho \wedge \sigma$.

1. $\Delta \vdash \neg\rho \vee \neg\sigma$ — $ax$
2. $\Delta, \neg\rho \vdash \rho$ — $ax$ + $\wedge e_1$; junto con $ax$ ($\neg\rho$) da $\Delta, \neg\rho \vdash \bot$ por $\neg e$
3. $\Delta, \neg\sigma \vdash \sigma$ — $ax$ + $\wedge e_2$; junto con $ax$ ($\neg\sigma$) da $\Delta, \neg\sigma \vdash \bot$ por $\neg e$
4. $\Delta \vdash \bot$ — $\vee e$ (1, 2, 3) (**descarga $\neg\rho$ y $\neg\sigma$ en sus ramas**)
5. $\neg\rho \vee \neg\sigma \vdash \neg(\rho \wedge \sigma)$ — $\neg i$ (**descarga $\rho \wedge \sigma$**)
6. $\vdash (\neg\rho \vee \neg\sigma) \Rightarrow \neg(\rho \wedge \sigma)$ — $\Rightarrow i$

*Dirección $\Rightarrow$ (requiere LK).* Sea $\Gamma = \neg(\rho \wedge \sigma)$.

1. $\Gamma \vdash \rho \vee \neg\rho$ — **$LEM$** ← *ésta es la regla que vuelve clásica la derivación*
2. Rama $\rho$: $\Gamma, \rho, \sigma \vdash \rho \wedge \sigma$ ($\wedge i$ sobre dos $ax$); con $ax$ ($\neg(\rho\wedge\sigma)$) y $\neg e$ da $\Gamma, \rho, \sigma \vdash \bot$; por $\neg i$ (**descarga $\sigma$**) queda $\Gamma, \rho \vdash \neg\sigma$; por $\vee i_2$, $\Gamma, \rho \vdash \neg\rho \vee \neg\sigma$
3. Rama $\neg\rho$: $\Gamma, \neg\rho \vdash \neg\rho$ ($ax$); por $\vee i_1$, $\Gamma, \neg\rho \vdash \neg\rho \vee \neg\sigma$
4. $\Gamma \vdash \neg\rho \vee \neg\sigma$ — $\vee e$ (1, 2, 3) (**descarga $\rho$ y $\neg\rho$ en sus ramas**)
5. $\vdash \neg(\rho \wedge \sigma) \Rightarrow (\neg\rho \vee \neg\sigma)$ — $\Rightarrow i$

**¿Por qué la dirección $\Rightarrow$ es necesariamente clásica?** Instanciando $\sigma := \neg\rho$ se obtiene $\neg(\rho \wedge \neg\rho) \Rightarrow (\neg\rho \vee \neg\neg\rho)$. Como $\neg(\rho \wedge \neg\rho)$ **sí** es teorema de LJ, la fórmula daría el *tercero excluido débil* $\neg\rho \vee \neg\neg\rho$. Pero LJ tiene la **propiedad de la disyunción**: si $\vdash A \vee B$ es derivable en LJ (sin hipótesis), entonces $\vdash A$ o $\vdash B$ es derivable. Ni $\neg\rho$ ni $\neg\neg\rho$ son teoremas para $\rho$ atómica, así que la disyunción no puede derivarse en LJ. Se necesita $LEM$ (equivalentemente $PBC$ o $\neg\neg e$).

*Curry-Howard:* la dirección $\Leftarrow$ tiene término $\lambda z^{\neg\rho + \neg\sigma}. \lambda p^{\rho\times\sigma}.\, \mathsf{case}\, z\, \{\mathsf{inl}(f) \to f\,(\pi_1 p) \;||\; \mathsf{inr}(g) \to g\,(\pi_2 p)\}$. La dirección $\Rightarrow$ **no** tiene término del $\lambda$-cálculo simplemente tipado puro: necesita un operador de control (tipo `call/cc`), que es la contracara computacional de la lógica clásica.

---

**IX. Conmutatividad de $\wedge$** — $(\rho \wedge \sigma) \Rightarrow (\sigma \wedge \rho)$

$$
\dfrac{\dfrac{\dfrac{\dfrac{}{\rho \wedge \sigma \vdash \rho \wedge \sigma}\,ax}{\rho \wedge \sigma \vdash \sigma}\,\wedge e_2 \quad \dfrac{\dfrac{}{\rho \wedge \sigma \vdash \rho \wedge \sigma}\,ax}{\rho \wedge \sigma \vdash \rho}\,\wedge e_1}{\rho \wedge \sigma \vdash \sigma \wedge \rho}\,\wedge i}{\vdash (\rho \wedge \sigma) \Rightarrow (\sigma \wedge \rho)}\,\Rightarrow i
$$

$\Rightarrow i$ **descarga $\rho \wedge \sigma$**.

*Curry-Howard:* $\lambda p^{\rho \times \sigma}.\, \langle \pi_2 p,\; \pi_1 p \rangle$ — el `swap` de pares.

---

**X. Asociatividad de $\wedge$** — $((\rho \wedge \sigma) \wedge \tau) \Leftrightarrow (\rho \wedge (\sigma \wedge \tau))$

*Dirección $\Rightarrow$.* Sea $\Gamma = (\rho \wedge \sigma) \wedge \tau$.

1. $\Gamma \vdash (\rho \wedge \sigma) \wedge \tau$ — $ax$
2. $\Gamma \vdash \rho \wedge \sigma$ — $\wedge e_1$ (1)
3. $\Gamma \vdash \tau$ — $\wedge e_2$ (1)
4. $\Gamma \vdash \rho$ — $\wedge e_1$ (2)
5. $\Gamma \vdash \sigma$ — $\wedge e_2$ (2)
6. $\Gamma \vdash \sigma \wedge \tau$ — $\wedge i$ (5, 3)
7. $\Gamma \vdash \rho \wedge (\sigma \wedge \tau)$ — $\wedge i$ (4, 6)
8. $\Rightarrow i$ (**descarga $(\rho \wedge \sigma) \wedge \tau$**)

*Dirección $\Leftarrow$.* Simétrica: de $\rho \wedge (\sigma \wedge \tau)$ se extraen $\rho$ ($\wedge e_1$), $\sigma$ ($\wedge e_1 \circ \wedge e_2$) y $\tau$ ($\wedge e_2 \circ \wedge e_2$), se reagrupan con $\wedge i$ y se cierra con $\Rightarrow i$. Luego $\wedge i$ de ambas direcciones.

*Curry-Howard:* $\langle\, \lambda p.\, \langle \pi_1(\pi_1 p),\, \langle \pi_2(\pi_1 p),\, \pi_2 p \rangle \rangle,\;\; \lambda q.\, \langle \langle \pi_1 q,\, \pi_1(\pi_2 q) \rangle,\, \pi_2(\pi_2 q) \rangle \,\rangle$ — reasociación de pares anidados.

---

**XI. Conmutatividad de $\vee$** — $(\rho \vee \sigma) \Rightarrow (\sigma \vee \rho)$

Sea $\Gamma = \rho \vee \sigma$.

1. $\Gamma \vdash \rho \vee \sigma$ — $ax$
2. $\Gamma, \rho \vdash \rho$ — $ax$
3. $\Gamma, \rho \vdash \sigma \vee \rho$ — $\vee i_2$ (2)
4. $\Gamma, \sigma \vdash \sigma$ — $ax$
5. $\Gamma, \sigma \vdash \sigma \vee \rho$ — $\vee i_1$ (4)
6. $\Gamma \vdash \sigma \vee \rho$ — $\vee e$ (1, 3, 5) (**descarga $\rho$ en la rama izquierda y $\sigma$ en la derecha**)
7. $\vdash (\rho \vee \sigma) \Rightarrow (\sigma \vee \rho)$ — $\Rightarrow i$ (**descarga $\rho \vee \sigma$**)

*Curry-Howard:* $\lambda z^{\rho + \sigma}.\, \mathsf{case}\, z\, \{\mathsf{inl}(x) \to \mathsf{inr}(x) \;||\; \mathsf{inr}(y) \to \mathsf{inl}(y)\}$.

---

**XII. Asociatividad de $\vee$** — $((\rho \vee \sigma) \vee \tau) \Leftrightarrow (\rho \vee (\sigma \vee \tau))$

*Dirección $\Rightarrow$.* Sea $\Gamma = (\rho \vee \sigma) \vee \tau$ y llamemos $G = \rho \vee (\sigma \vee \tau)$ a la meta.

1. $\Gamma \vdash (\rho \vee \sigma) \vee \tau$ — $ax$
2. Rama $\rho \vee \sigma$: $\Gamma, \rho \vee \sigma \vdash \rho \vee \sigma$ ($ax$), y se abre un **$\vee e$ anidado**:
   - Sub-rama $\rho$: $\vee i_1$ da $\Gamma, \rho \vee \sigma, \rho \vdash G$
   - Sub-rama $\sigma$: $\vee i_1$ da $\sigma \vee \tau$, luego $\vee i_2$ da $\Gamma, \rho \vee \sigma, \sigma \vdash G$
   - $\vee e$ (**descarga $\rho$ y $\sigma$**) da $\Gamma, \rho \vee \sigma \vdash G$
3. Rama $\tau$: $ax$, luego $\vee i_2$ ($\sigma \vee \tau$) y $\vee i_2$ ($G$) dan $\Gamma, \tau \vdash G$
4. $\Gamma \vdash G$ — $\vee e$ (1, 2, 3) (**descarga $\rho \vee \sigma$ y $\tau$**)
5. $\Rightarrow i$ (**descarga $(\rho \vee \sigma) \vee \tau$**)

*Dirección $\Leftarrow$.* Simétrica: $\vee e$ externo sobre $\rho \vee (\sigma \vee \tau)$, con $\vee e$ anidado en la rama $\sigma \vee \tau$, reinyectando con $\vee i_1 / \vee i_2$ del lado izquierdo. Se cierra con $\wedge i$ de ambas direcciones.

*Curry-Howard:* $\lambda z.\, \mathsf{case}\, z\, \{\mathsf{inl}(w) \to \mathsf{case}\, w\, \{\mathsf{inl}(x) \to \mathsf{inl}(x) \;||\; \mathsf{inr}(y) \to \mathsf{inr}(\mathsf{inl}\, y)\} \;||\; \mathsf{inr}(t) \to \mathsf{inr}(\mathsf{inr}\, t)\}$ — reasociación de sumas anidadas (y su inversa).

**Chuleta**
> 1. Leer de abajo hacia arriba: meta $\tau\Rightarrow\sigma$ → $\Rightarrow i$; meta $\neg\tau$ → $\neg i$ (asumir $\tau$, buscar $\bot$); meta $\tau\wedge\sigma$ → $\wedge i$; meta $\tau\vee\sigma$ → $\vee i_1/\vee i_2$ → 2. hipótesis con $\vee$ → $\vee e$ inmediato (probar la meta en ambas ramas); hipótesis con $\wedge$ → $\wedge e_{1,2}$; hipótesis $\tau\Rightarrow\sigma$ → $\Rightarrow e$ si ya tenés $\tau$ → 3. $\bot$ en el contexto → $\bot e$ da cualquier cosa → 4. $\neg\tau$ es $\tau\Rightarrow\bot$: I=$S$, II/III/IV son juegos de $\neg i$ + $\neg e$, V es composición, VI es currificación, VII/VIII de Morgan, IX–XII estructurales → 5. sólo VIII($\Rightarrow$) necesita $LEM$: hacer $LEM$ sobre $\rho$ y $\vee e$ → 6. Curry-Howard: $\Rightarrow$ = $\lambda$/aplicación, $\wedge$ = par/proyecciones, $\vee$ = $\mathsf{inl}/\mathsf{inr}$ + $\mathsf{case}$, $\bot$ = tipo vacío.

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
**Reglas clásicas disponibles (LK = LJ + una de éstas; las tres son interderivables)**

$$
\dfrac{\Gamma \vdash \neg\neg\tau}{\Gamma \vdash \tau}\,\neg\neg e
\qquad
\dfrac{}{\Gamma \vdash \tau \vee \neg\tau}\,LEM
\qquad
\dfrac{\Gamma, \neg\tau \vdash \bot}{\Gamma \vdash \tau}\,PBC
$$

**Receta:** si la meta es una fórmula "positiva" que no se puede construir con las reglas de introducción de LJ, arrancar con $PBC$ (asumir $\neg$meta y buscar $\bot$) o con $LEM$ sobre la fórmula que falta y seguir con $\vee e$. Todo lo que sigue **usa exactamente una regla clásica**, señalada con ←.

---

**I. Absurdo clásico** — $(\neg\tau \Rightarrow \bot) \Rightarrow \tau$

Sea $\Gamma = \neg\tau \Rightarrow \bot$.

1. $\Gamma, \neg\tau \vdash \neg\tau \Rightarrow \bot$ — $ax$
2. $\Gamma, \neg\tau \vdash \neg\tau$ — $ax$
3. $\Gamma, \neg\tau \vdash \bot$ — $\Rightarrow e$ (1, 2)
4. $\Gamma \vdash \tau$ — **$PBC$** (**descarga $\neg\tau$**) ← *regla clásica*
5. $\vdash (\neg\tau \Rightarrow \bot) \Rightarrow \tau$ — $\Rightarrow i$ (**descarga $\neg\tau \Rightarrow \bot$**)

*Variante con $\neg\neg e$:* de 3, por $\neg i$ (descarga $\neg\tau$) se obtiene $\Gamma \vdash \neg\neg\tau$ y luego $\neg\neg e$ da $\Gamma \vdash \tau$. Esto muestra que **$PBC$ es exactamente $\neg i$ seguido de $\neg\neg e$**: intuicionistamente sólo se llega a $\neg\neg\tau$, y el salto final $\neg\neg\tau \to \tau$ es el que necesita LK.

---

**II. Ley de Peirce** — $((\tau \Rightarrow \rho) \Rightarrow \tau) \Rightarrow \tau$

Sea $\Gamma = (\tau \Rightarrow \rho) \Rightarrow \tau$.

1. $\Gamma, \neg\tau, \tau \vdash \tau$ — $ax$
2. $\Gamma, \neg\tau, \tau \vdash \neg\tau$ — $ax$
3. $\Gamma, \neg\tau, \tau \vdash \bot$ — $\neg e$ (1, 2)
4. $\Gamma, \neg\tau, \tau \vdash \rho$ — $\bot e$ (3) (*explosión: de $\bot$ sale cualquier cosa*)
5. $\Gamma, \neg\tau \vdash \tau \Rightarrow \rho$ — $\Rightarrow i$ (**descarga $\tau$**)
6. $\Gamma, \neg\tau \vdash (\tau \Rightarrow \rho) \Rightarrow \tau$ — $ax$
7. $\Gamma, \neg\tau \vdash \tau$ — $\Rightarrow e$ (6, 5)
8. $\Gamma, \neg\tau \vdash \neg\tau$ — $ax$
9. $\Gamma, \neg\tau \vdash \bot$ — $\neg e$ (7, 8)
10. $\Gamma \vdash \tau$ — **$PBC$** (**descarga $\neg\tau$**) ← *regla clásica*
11. $\vdash ((\tau \Rightarrow \rho) \Rightarrow \tau) \Rightarrow \tau$ — $\Rightarrow i$ (**descarga $(\tau \Rightarrow \rho) \Rightarrow \tau$**)

*Curry-Howard:* el tipo $((\tau \to \rho) \to \tau) \to \tau$ es exactamente el tipo de **`call/cc`**. No hay término del $\lambda$-cálculo simplemente tipado puro que lo habite; Peirce es el ejemplo canónico de que "lógica clásica = $\lambda$-cálculo con operadores de control".

---

**III. Tercero excluido** — $\tau \vee \neg\tau$

Si $LEM$ se toma como regla primitiva, es inmediato. Derivándolo a partir de $PBC$:

1. $\neg(\tau \vee \neg\tau), \tau \vdash \tau \vee \neg\tau$ — $ax$ + $\vee i_1$
2. $\neg(\tau \vee \neg\tau), \tau \vdash \neg(\tau \vee \neg\tau)$ — $ax$
3. $\neg(\tau \vee \neg\tau), \tau \vdash \bot$ — $\neg e$ (1, 2)
4. $\neg(\tau \vee \neg\tau) \vdash \neg\tau$ — $\neg i$ (**descarga $\tau$**)
5. $\neg(\tau \vee \neg\tau) \vdash \tau \vee \neg\tau$ — $\vee i_2$ (4)
6. $\neg(\tau \vee \neg\tau) \vdash \neg(\tau \vee \neg\tau)$ — $ax$
7. $\neg(\tau \vee \neg\tau) \vdash \bot$ — $\neg e$ (5, 6)
8. $\vdash \tau \vee \neg\tau$ — **$PBC$** (**descarga $\neg(\tau \vee \neg\tau)$**) ← *regla clásica*

**Por qué es imposible en LJ:** LJ cumple la *propiedad de la disyunción* (si $\vdash A \vee B$ es derivable sin hipótesis, entonces $\vdash A$ o $\vdash B$ lo es). Para $\tau$ atómica, ni $\vdash \tau$ ni $\vdash \neg\tau$ son derivables. Computacionalmente: un habitante de $\tau + \neg\tau$ sería un programa que decide cualquier proposición.

---

**IV. Consecuencia milagrosa** — $(\neg\tau \Rightarrow \tau) \Rightarrow \tau$

Sea $\Gamma = \neg\tau \Rightarrow \tau$.

1. $\Gamma, \neg\tau \vdash \neg\tau \Rightarrow \tau$ — $ax$
2. $\Gamma, \neg\tau \vdash \neg\tau$ — $ax$
3. $\Gamma, \neg\tau \vdash \tau$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, \neg\tau \vdash \bot$ — $\neg e$ (3, 2)
5. $\Gamma \vdash \tau$ — **$PBC$** (**descarga $\neg\tau$**) ← *regla clásica*
6. $\vdash (\neg\tau \Rightarrow \tau) \Rightarrow \tau$ — $\Rightarrow i$ (**descarga $\neg\tau \Rightarrow \tau$**)

Ojo: intuicionistamente sólo se llega hasta $\neg\neg\tau$ (paso 4 + $\neg i$). Es un caso particular de la Ley de Peirce con $\rho := \bot$.

---

**V. Contraposición clásica** — $(\neg\rho \Rightarrow \neg\tau) \Rightarrow (\tau \Rightarrow \rho)$

Sea $\Gamma = \neg\rho \Rightarrow \neg\tau,\; \tau$.

1. $\Gamma, \neg\rho \vdash \neg\rho \Rightarrow \neg\tau$ — $ax$
2. $\Gamma, \neg\rho \vdash \neg\rho$ — $ax$
3. $\Gamma, \neg\rho \vdash \neg\tau$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, \neg\rho \vdash \tau$ — $ax$
5. $\Gamma, \neg\rho \vdash \bot$ — $\neg e$ (4, 3)
6. $\Gamma \vdash \rho$ — **$PBC$** (**descarga $\neg\rho$**) ← *regla clásica*
7. $\neg\rho \Rightarrow \neg\tau \vdash \tau \Rightarrow \rho$ — $\Rightarrow i$ (**descarga $\tau$**)
8. $\vdash (\neg\rho \Rightarrow \neg\tau) \Rightarrow (\tau \Rightarrow \rho)$ — $\Rightarrow i$ (**descarga $\neg\rho \Rightarrow \neg\tau$**)

Comparar con el Ejercicio 5.V: la contraposición "hacia las negaciones" es intuicionista, la que **saca** negaciones no lo es.

---

**VI. Análisis de casos** — $(\tau \Rightarrow \rho) \Rightarrow (\neg\tau \Rightarrow \rho) \Rightarrow \rho$

Sea $\Gamma = \tau \Rightarrow \rho,\; \neg\tau \Rightarrow \rho$.

1. $\Gamma \vdash \tau \vee \neg\tau$ — **$LEM$** ← *regla clásica*
2. $\Gamma, \tau \vdash \tau \Rightarrow \rho$ ($ax$) y $\Gamma, \tau \vdash \tau$ ($ax$) $\Rightarrow$ $\Gamma, \tau \vdash \rho$ — $\Rightarrow e$
3. $\Gamma, \neg\tau \vdash \neg\tau \Rightarrow \rho$ ($ax$) y $\Gamma, \neg\tau \vdash \neg\tau$ ($ax$) $\Rightarrow$ $\Gamma, \neg\tau \vdash \rho$ — $\Rightarrow e$
4. $\Gamma \vdash \rho$ — $\vee e$ (1, 2, 3) (**descarga $\tau$ en la rama izquierda y $\neg\tau$ en la derecha**)
5. $\tau \Rightarrow \rho \vdash (\neg\tau \Rightarrow \rho) \Rightarrow \rho$ — $\Rightarrow i$ (**descarga $\neg\tau \Rightarrow \rho$**)
6. $\vdash (\tau \Rightarrow \rho) \Rightarrow (\neg\tau \Rightarrow \rho) \Rightarrow \rho$ — $\Rightarrow i$ (**descarga $\tau \Rightarrow \rho$**)

---

**VII. Implicación vs. disyunción** — $(\tau \Rightarrow \rho) \Leftrightarrow (\neg\tau \vee \rho)$

*Dirección $\Leftarrow$ (intuicionista, no hace falta LK).* Sea $\Delta = \neg\tau \vee \rho,\; \tau$.

1. $\Delta \vdash \neg\tau \vee \rho$ — $ax$
2. $\Delta, \neg\tau \vdash \bot$ — $\neg e$ entre $ax$ ($\tau$) y $ax$ ($\neg\tau$); luego $\Delta, \neg\tau \vdash \rho$ por $\bot e$
3. $\Delta, \rho \vdash \rho$ — $ax$
4. $\Delta \vdash \rho$ — $\vee e$ (1, 2, 3) (**descarga $\neg\tau$ y $\rho$**)
5. $\neg\tau \vee \rho \vdash \tau \Rightarrow \rho$ — $\Rightarrow i$ (**descarga $\tau$**)
6. $\vdash (\neg\tau \vee \rho) \Rightarrow (\tau \Rightarrow \rho)$ — $\Rightarrow i$

*Dirección $\Rightarrow$ (requiere LK).* Sea $\Gamma = \tau \Rightarrow \rho$.

1. $\Gamma \vdash \tau \vee \neg\tau$ — **$LEM$** ← *regla clásica*
2. Rama $\tau$: $\Gamma, \tau \vdash \rho$ por $\Rightarrow e$; luego $\vee i_2$ da $\Gamma, \tau \vdash \neg\tau \vee \rho$
3. Rama $\neg\tau$: $ax$ y $\vee i_1$ dan $\Gamma, \neg\tau \vdash \neg\tau \vee \rho$
4. $\Gamma \vdash \neg\tau \vee \rho$ — $\vee e$ (1, 2, 3) (**descarga $\tau$ y $\neg\tau$**)
5. $\vdash (\tau \Rightarrow \rho) \Rightarrow (\neg\tau \vee \rho)$ — $\Rightarrow i$

Finalmente $\wedge i$ sobre ambas direcciones da el $\Leftrightarrow$. **Por qué la dirección $\Rightarrow$ es necesariamente clásica:** instanciando $\rho := \tau$ y usando que $\vdash \tau \Rightarrow \tau$ sí es teorema de LJ ($ax$ + $\Rightarrow i$), un $\Rightarrow e$ daría $\vdash \neg\tau \vee \tau$, es decir el tercero excluido — que no es derivable en LJ por la propiedad de la disyunción.

**Chuleta**
> 1. Reconocer la meta "clásica": si es una fórmula positiva ($\tau$, $\tau\vee\neg\tau$, $\rho$) que LJ no puede construir → arrancar por lo clásico → 2. **$PBC$**: asumir $\neg$meta, derivar $\bot$, descargar (sirve para I, II, III, IV, V) → 3. **$LEM$ + $\vee e$**: partir en caso $\tau$ / caso $\neg\tau$ y probar la meta en ambas ramas (sirve para VI, VII$\Rightarrow$, de Morgan II) → 4. dentro de las ramas, usar $\neg e$ para fabricar $\bot$ y $\bot e$ para conseguir cualquier fórmula que falte (truco clave en Peirce) → 5. equivalencias: $PBC$ = $\neg i$ + $\neg\neg e$; Peirce = `call/cc`; ninguna tiene término $\lambda$ puro.

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
Las tres propiedades son *metateoremas*: no se demuestran **dentro** del sistema con una derivación, sino **sobre** el sistema (por inducción en la derivación, o construyendo una derivación a partir de otra).

---

**I. Debilitamiento (Weakening).** Si $\Gamma \vdash \sigma$ es válido, entonces $\Gamma, \tau \vdash \sigma$ es válido.

*Demostración por inducción estructural en la derivación de $\Gamma \vdash \sigma$* (analizando cuál fue la **última regla** aplicada). Recordar que los contextos son **conjuntos**, así que el orden no importa y agregar una fórmula repetida no cambia nada.

- **Caso $ax$.** La derivación es $\dfrac{}{\Gamma' , \sigma \vdash \sigma}\,ax$, con $\Gamma = \Gamma', \sigma$. Entonces $\Gamma, \tau = \Gamma', \sigma, \tau$ y el juicio $\Gamma', \tau, \sigma \vdash \sigma$ es también una instancia de $ax$. ✔

- **Caso $\wedge i$.** Última regla $\dfrac{\Gamma \vdash \sigma_1 \quad \Gamma \vdash \sigma_2}{\Gamma \vdash \sigma_1 \wedge \sigma_2}$. Por H.I. sobre cada premisa, $\Gamma, \tau \vdash \sigma_1$ y $\Gamma, \tau \vdash \sigma_2$; reaplicando $\wedge i$ se obtiene $\Gamma, \tau \vdash \sigma_1 \wedge \sigma_2$. ✔

- **Caso $\Rightarrow i$** (el caso interesante, porque la premisa extiende el contexto). Última regla $\dfrac{\Gamma, \sigma_1 \vdash \sigma_2}{\Gamma \vdash \sigma_1 \Rightarrow \sigma_2}$. Por H.I. aplicada a la premisa (agregando $\tau$), $\Gamma, \sigma_1, \tau \vdash \sigma_2$, que como conjunto es $\Gamma, \tau, \sigma_1 \vdash \sigma_2$. Reaplicando $\Rightarrow i$ (descargando $\sigma_1$): $\Gamma, \tau \vdash \sigma_1 \Rightarrow \sigma_2$. ✔

- **Caso $\vee e$.** Última regla $\dfrac{\Gamma \vdash \sigma_1 \vee \sigma_2 \quad \Gamma, \sigma_1 \vdash \sigma \quad \Gamma, \sigma_2 \vdash \sigma}{\Gamma \vdash \sigma}$. H.I. en las tres premisas da $\Gamma, \tau \vdash \sigma_1 \vee \sigma_2$, $\Gamma, \tau, \sigma_1 \vdash \sigma$ y $\Gamma, \tau, \sigma_2 \vdash \sigma$; reaplicando $\vee e$ se concluye. ✔

- **Resto de los casos** ($\wedge e_1$, $\wedge e_2$, $\Rightarrow e$, $\vee i_1$, $\vee i_2$, $\neg i$, $\neg e$, $\bot e$, y las reglas clásicas $\neg\neg e$, $LEM$, $PBC$): idénticos en forma — se aplica H.I. a cada premisa y se reaplica la misma regla, porque **ninguna regla del sistema requiere que el contexto sea exactamente cierto conjunto**; sólo lo extienden. ✔ $\blacksquare$

---

**II. Regla de corte (cut).** Si $\Gamma, \tau \vdash \sigma$ y $\Gamma \vdash \tau$ son válidos, entonces $\Gamma \vdash \sigma$ es válido.

*Demostración (construcción directa, sin inducción):*

$$
\dfrac{\dfrac{\Gamma, \tau \vdash \sigma}{\Gamma \vdash \tau \Rightarrow \sigma}\,\Rightarrow i \qquad \Gamma \vdash \tau}{\Gamma \vdash \sigma}\,\Rightarrow e
$$

1. De la derivación de $\Gamma, \tau \vdash \sigma$, aplicando $\Rightarrow i$ (**descarga $\tau$**), se obtiene una derivación de $\Gamma \vdash \tau \Rightarrow \sigma$.
2. Con la derivación de $\Gamma \vdash \tau$ que tenemos por hipótesis, $\Rightarrow e$ da $\Gamma \vdash \sigma$. $\blacksquare$

*Lectura Curry-Howard:* si $x : \tau \vdash M : \sigma$ y $\vdash N : \tau$, entonces $(\lambda x^\tau . M)\, N : \sigma$, y la eliminación del corte es precisamente la **reducción $\beta$**: $(\lambda x^\tau . M)\, N \to M\{x := N\}$. "Cortar" un lema = inlinear su demostración.

---

**III. $\Rightarrow_i^{-1}$ (inversa de la introducción de la implicación).** Si $\Gamma \vdash \tau \Rightarrow \sigma$ es válido, entonces $\Gamma, \tau \vdash \sigma$ también.

*Demostración:*

1. $\Gamma \vdash \tau \Rightarrow \sigma$ — hipótesis
2. $\Gamma, \tau \vdash \tau \Rightarrow \sigma$ — **Debilitamiento** (parte I) aplicado a 1
3. $\Gamma, \tau \vdash \tau$ — $ax$
4. $\Gamma, \tau \vdash \sigma$ — $\Rightarrow e$ (2, 3) $\blacksquare$

Juntando III con $\Rightarrow i$ se obtiene el **teorema de la deducción**: $\Gamma, \tau \vdash \sigma$ es válido **si y sólo si** $\Gamma \vdash \tau \Rightarrow \sigma$ es válido. Es la herramienta central del Ejercicio 8.

**Chuleta**
> 1. Debilitamiento: **inducción estructural en la derivación**, caso por caso según la última regla; base $ax$ sigue siendo $ax$; en $\Rightarrow i$/$\neg i$/$\vee e$ usar que el contexto es un **conjunto** (el orden no importa) → 2. Corte: no hace falta inducción — $\Rightarrow i$ sobre $\Gamma,\tau\vdash\sigma$ y después $\Rightarrow e$ con $\Gamma\vdash\tau$ → 3. $\Rightarrow_i^{-1}$: debilitar con $\tau$, sumar $ax$ ($\tau$) y hacer $\Rightarrow e$ → 4. combinando III con $\Rightarrow i$: **teorema de la deducción** ($\Gamma,\tau\vdash\sigma \iff \Gamma\vdash\tau\Rightarrow\sigma$) → 5. Curry-Howard: corte = redex $\beta$, eliminar cortes = normalizar.

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
**Enunciado a probar:** $\tau_1, \dots, \tau_n \vdash \sigma$ es válido $\iff$ $\vdash [\tau_1, \dots, \tau_n] \Rightarrow^* \sigma$ es válido.

**Generalización necesaria.** La inducción **no cierra** con el enunciado tal cual, porque al pelar $\tau_1$ hay que trabajar con un contexto no vacío. Se prueba entonces el enunciado más fuerte:

> **(★)** Para todo contexto $\Gamma$, toda lista $[\tau_1, \dots, \tau_n]$ y toda fórmula $\sigma$:
> $$\Gamma, \tau_1, \dots, \tau_n \vdash \sigma \quad \text{es válido} \iff \quad \Gamma \vdash [\tau_1, \dots, \tau_n] \Rightarrow^* \sigma \quad \text{es válido}$$

El enunciado original es el caso $\Gamma = \emptyset$.

**Herramienta.** El teorema de la deducción del Ejercicio 7:
$$\Gamma', \tau \vdash \sigma \text{ válido} \iff \Gamma' \vdash \tau \Rightarrow \sigma \text{ válido}$$
($\Rightarrow$ es la regla $\Rightarrow i$ descargando $\tau$; $\Leftarrow$ es la propiedad $\Rightarrow_i^{-1}$ del Ejercicio 7.III).

---

**Demostración de (★) por inducción en $n$** (la longitud de la lista), con $\Gamma$ y $\sigma$ **universalmente cuantificados** en la hipótesis inductiva.

**Caso base $n = 0$.** La lista es vacía y por definición $([\,] \Rightarrow^* \sigma) = \sigma$. Entonces ambos lados de (★) son literalmente el mismo juicio $\Gamma \vdash \sigma$, y la equivalencia vale trivialmente. ✔

**Paso inductivo.** Supongamos (★) para listas de longitud $n$ (para *todo* $\Gamma$ y *todo* $\sigma$). Sea la lista $[\tau_1, \tau_2, \dots, \tau_{n+1}]$ de longitud $n+1$. Entonces:

$$
\begin{aligned}
\Gamma, \tau_1, \tau_2, \dots, \tau_{n+1} \vdash \sigma
&\iff (\Gamma, \tau_1), \tau_2, \dots, \tau_{n+1} \vdash \sigma
&& \text{(el contexto es un conjunto)}\\[2pt]
&\iff \Gamma, \tau_1 \vdash [\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma
&& \text{(H.I. con contexto } \Gamma, \tau_1 \text{ y lista de largo } n)\\[2pt]
&\iff \Gamma \vdash \tau_1 \Rightarrow ([\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma)
&& \text{(teorema de la deducción, Ej. 7)}\\[2pt]
&\iff \Gamma \vdash [\tau_1, \tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma
&& \text{(definición de } \Rightarrow^*)
\end{aligned}
$$

Notar dónde se usa cada dirección del teorema de la deducción: de izquierda a derecha es $\Rightarrow i$ **descargando $\tau_1$**; de derecha a izquierda es $\Rightarrow_i^{-1}$ (debilitamiento + $ax$ + $\Rightarrow e$). Esto completa el paso inductivo. ✔

Tomando $\Gamma = \emptyset$ en (★) se obtiene el enunciado pedido:
$$\tau_1, \dots, \tau_n \vdash \sigma \iff\; \vdash [\tau_1, \dots, \tau_n] \Rightarrow^* \sigma \qquad \blacksquare$$

**Consecuencia práctica.** Todo secuente con hipótesis se puede convertir en un **teorema cerrado** (y viceversa): por eso el Ejercicio 5 pide teoremas $\vdash \sigma$ y los Ejercicios 11–13 piden secuentes $\Gamma \vdash \sigma$ — son la misma clase de problema. La H.I. debe cuantificar sobre $\Gamma$ y $\sigma$: es el punto donde este ejercicio se cae si uno no generaliza.

*Curry-Howard:* (★) es la currificación iterada — un programa con $n$ argumentos libres $x_1 : \tau_1, \dots, x_n : \tau_n$ y cuerpo $M : \sigma$ es lo mismo que un programa cerrado $\lambda x_1 \dots \lambda x_n . M$ de tipo $\tau_1 \to \dots \to \tau_n \to \sigma$.

**Chuleta**
> 1. **Generalizar el enunciado** a "para todo $\Gamma$: $\Gamma, \tau_1..\tau_n \vdash \sigma \iff \Gamma \vdash [\tau_1..\tau_n] \Rightarrow^* \sigma$" (sin esto la inducción no cierra) → 2. inducción en $n$; base $n=0$: $[\,]\Rightarrow^*\sigma = \sigma$, los dos lados son el mismo juicio → 3. paso $n+1$: meter $\tau_1$ en el contexto, aplicar **H.I.** al resto de la lista, y pelar $\tau_1$ con el **teorema de la deducción** ($\Rightarrow i$ / $\Rightarrow_i^{-1}$ del Ej. 7) → 4. tomar $\Gamma = \emptyset$ → 5. moraleja: hipótesis en el contexto $\equiv$ implicaciones anidadas $\equiv$ currificación.

---

### Ejercicios 9 - 10
Teoremas y tautologías adicionales para practicar.

---

## Ejercicios Extra de Deducción Natural

### Ejercicio 11
Probar que los siguientes secuentes son válidos **sin usar principios de razonamiento clásicos**:

I. $(P \wedge Q) \wedge R,\; S \wedge T \vdash Q \wedge S$
II. $(P \wedge Q) \wedge R \vdash P \wedge (Q \wedge R)$
III. $P \Rightarrow (P \Rightarrow Q),\; P \vdash Q$
IV. $Q \Rightarrow (P \Rightarrow R),\; \neg R,\; Q \vdash \neg P$
V. $\vdash (P \wedge Q) \Rightarrow P$
VI. $P \Rightarrow \neg Q,\; Q \vdash \neg P$
VII. $P \Rightarrow Q \vdash (P \wedge R) \Rightarrow (Q \wedge R)$
VIII. $Q \Rightarrow R \vdash (P \vee Q) \Rightarrow (P \vee R)$
IX. $(P \vee Q) \vee R \vdash P \vee (Q \vee R)$
X. $P \wedge (Q \vee R) \vdash (P \wedge Q) \vee (P \wedge R)$
XI. $(P \wedge Q) \vee (P \wedge R) \vdash P \wedge (Q \vee R)$
XII. $\neg P \vee Q \vdash P \Rightarrow Q$
XIII. $P \Rightarrow Q,\; P \Rightarrow \neg Q \vdash \neg P$
XIV. $P \Rightarrow (Q \Rightarrow R),\; P,\; \neg R \vdash \neg Q$

### Ejercicio 12
Probar que los siguientes secuentes son válidos:

I. $(P \wedge \neg Q) \Rightarrow R,\; \neg R,\; P \vdash Q$
II. $\neg P \Rightarrow Q \vdash \neg Q \Rightarrow P$
III. $P \vee Q \vdash R \Rightarrow (P \vee Q) \wedge R$
IV. $(P \vee (Q \Rightarrow P)) \wedge Q \vdash P$
V. $P \Rightarrow Q,\; R \Rightarrow S \vdash (P \wedge R) \Rightarrow (Q \wedge S)$
VI. $P \Rightarrow Q \vdash ((P \wedge Q) \Rightarrow P) \wedge (P \Rightarrow (P \wedge Q))$
VII. $P \Rightarrow (Q \wedge R) \vdash (P \Rightarrow Q) \wedge (P \Rightarrow R)$
VIII. $(P \Rightarrow Q) \wedge (P \Rightarrow R) \vdash P \Rightarrow (Q \wedge R)$
IX. $P \vee (P \wedge Q) \vdash P$
X. $P \Rightarrow (Q \vee R),\; Q \Rightarrow S,\; R \Rightarrow S \vdash P \Rightarrow S$
XI. $(P \wedge Q) \vee (P \wedge R) \vdash P \wedge (Q \vee R)$

*A diferencia del Ejercicio 11, acá el enunciado no prohíbe los principios clásicos: los incisos I y II los **necesitan**; los otros nueve salen en LJ.*

### Ejercicio 13
Probar que los siguientes secuentes son válidos:

I. $\neg P \Rightarrow \neg Q \vdash Q \Rightarrow P$
II. $\neg P \vee \neg Q \vdash \neg(P \wedge Q)$
III. $\neg P,\; P \vee Q \vdash Q$
IV. $P \vee Q,\; \neg Q \vee R \vdash P \vee R$
V. $P \wedge \neg P \vdash \neg(R \Rightarrow Q) \wedge (R \Rightarrow Q)$
VI. $\neg(\neg P \vee Q) \vdash P$
VII. $\vdash \neg P \Rightarrow (P \Rightarrow (P \Rightarrow Q))$
VIII. $P \wedge Q \vdash \neg(\neg P \vee \neg Q)$
IX. $\vdash (P \Rightarrow Q) \vee (Q \Rightarrow R)$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/deduccion_natural_intuicionista]]

**Explicación:**
Batería de ejercicios para mecanizar el uso de las reglas de Deducción Natural.

**Resolución:**
Los tres ejercicios suman **34 secuentes** (14 + 11 + 9). Van todos resueltos abajo, agrupados por ejercicio, después del método general.

**Mapa de cuáles necesitan lógica clásica**

| Ejercicio | Secuentes en LJ (intuicionistas) | Secuentes que necesitan LK |
|---|---|---|
| 11 | **todos** (I–XIV) | ninguno (el enunciado lo prohíbe) |
| 12 | III–XI | **I** ($PBC$), **II** ($PBC$) |
| 13 | II, III, IV, V, VII, VIII | **I** ($PBC$), **VI** ($PBC$), **IX** ($LEM$) |

---

**Método general (sirve para los 34 secuentes)**

1. **Mirar la meta** (lo que está a la derecha del $\vdash$) y aplicar la regla de **introducción** correspondiente, leyendo de abajo hacia arriba: meta $\tau \Rightarrow \sigma \to \Rightarrow i$; meta $\tau \wedge \sigma \to \wedge i$; meta $\neg\tau \to \neg i$; meta $\tau \vee \sigma \to \vee i_1$ o $\vee i_2$ (sólo si sabés cuál lado probar; si no, la meta va a salir de un $\vee e$ o de $LEM$).
2. **Mirar el contexto** y aplicar reglas de **eliminación**: $\wedge$ en hipótesis $\to \wedge e_{1,2}$ inmediato; $\vee$ en hipótesis $\to \vee e$ lo antes posible (probar la meta en **ambas** ramas); $\tau \Rightarrow \sigma$ en hipótesis $\to \Rightarrow e$ apenas consigas $\tau$.
3. Si aparece $\bot$, $\bot e$ te da **cualquier** fórmula (comodín).
4. **Si te trabás y la meta es positiva** (una variable, una disyunción, algo que no podés construir): pasar a LK con $PBC$ (asumir $\neg$meta, buscar $\bot$) o $LEM$ + $\vee e$. Los cinco secuentes marcados en la tabla son exactamente los que lo requieren.

Convención: el contexto es un **conjunto**, así que el debilitamiento (Ej. 7.I) es implícito — cuando escribo $\Gamma, \rho \vdash \dots$ doy por hecho que todo lo derivable de $\Gamma$ sigue derivable.

---

**Ejercicio 11 — los 14 secuentes (todos en LJ)**

**I. $(P \wedge Q) \wedge R,\; S \wedge T \vdash Q \wedge S$**

Sea $\Gamma = (P \wedge Q) \wedge R,\; S \wedge T$.

1. $\Gamma \vdash (P \wedge Q) \wedge R$ — $ax$
2. $\Gamma \vdash P \wedge Q$ — $\wedge e_1$ (1)
3. $\Gamma \vdash Q$ — $\wedge e_2$ (2)
4. $\Gamma \vdash S \wedge T$ — $ax$
5. $\Gamma \vdash S$ — $\wedge e_1$ (4)
6. $\Gamma \vdash Q \wedge S$ — $\wedge i$ (3, 5)

Sin descargas de hipótesis: es pura "plomería" de proyecciones. *Curry-Howard:* $\langle \pi_2 (\pi_1 x),\; \pi_1 y \rangle$ con $x : (P \times Q) \times R$, $y : S \times T$.

---

**II. $(P \wedge Q) \wedge R \vdash P \wedge (Q \wedge R)$**

Sea $\Gamma = (P \wedge Q) \wedge R$.

1. $\Gamma \vdash (P \wedge Q) \wedge R$ — $ax$
2. $\Gamma \vdash P \wedge Q$ — $\wedge e_1$ (1)
3. $\Gamma \vdash R$ — $\wedge e_2$ (1)
4. $\Gamma \vdash P$ — $\wedge e_1$ (2)
5. $\Gamma \vdash Q$ — $\wedge e_2$ (2)
6. $\Gamma \vdash Q \wedge R$ — $\wedge i$ (5, 3)
7. $\Gamma \vdash P \wedge (Q \wedge R)$ — $\wedge i$ (4, 6)

Sin descargas. Es la asociatividad de $\wedge$ del Ejercicio 5.X, versión secuente. *Curry-Howard:* $\langle \pi_1(\pi_1 x),\, \langle \pi_2(\pi_1 x),\, \pi_2 x \rangle \rangle$.

---

**III. $P \Rightarrow (P \Rightarrow Q),\; P \vdash Q$** (contracción)

Sea $\Gamma = P \Rightarrow (P \Rightarrow Q),\; P$.

1. $\Gamma \vdash P \Rightarrow (P \Rightarrow Q)$ — $ax$
2. $\Gamma \vdash P$ — $ax$
3. $\Gamma \vdash P \Rightarrow Q$ — $\Rightarrow e$ (1, 2)
4. $\Gamma \vdash Q$ — $\Rightarrow e$ (3, 2)

Sin descargas. La gracia es usar **dos veces** la misma hipótesis $P$ (pasos 2 y 4): eso es lícito porque el contexto es un conjunto. *Curry-Howard:* $f\,x\,x$.

---

**IV. $Q \Rightarrow (P \Rightarrow R),\; \neg R,\; Q \vdash \neg P$**

Sea $\Gamma = Q \Rightarrow (P \Rightarrow R),\; \neg R,\; Q$. Meta $\neg P$ $\to$ arrancar por $\neg i$: asumir $P$ y buscar $\bot$.

1. $\Gamma, P \vdash Q \Rightarrow (P \Rightarrow R)$ — $ax$
2. $\Gamma, P \vdash Q$ — $ax$
3. $\Gamma, P \vdash P \Rightarrow R$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, P \vdash P$ — $ax$
5. $\Gamma, P \vdash R$ — $\Rightarrow e$ (3, 4)
6. $\Gamma, P \vdash \neg R$ — $ax$
7. $\Gamma, P \vdash \bot$ — $\neg e$ (5, 6)
8. $\Gamma \vdash \neg P$ — $\neg i$ (**descarga $P$**)

---

**V. $\vdash (P \wedge Q) \Rightarrow P$**

$$
\dfrac{\dfrac{\dfrac{}{P \wedge Q \vdash P \wedge Q}\,ax}{P \wedge Q \vdash P}\,\wedge e_1}{\vdash (P \wedge Q) \Rightarrow P}\,\Rightarrow i
$$

$\Rightarrow i$ **descarga $P \wedge Q$**. *Curry-Howard:* $\lambda p^{P \times Q}.\, \pi_1 p$ — la primera proyección.

---

**VI. $P \Rightarrow \neg Q,\; Q \vdash \neg P$**

Sea $\Gamma = P \Rightarrow \neg Q,\; Q$.

1. $\Gamma, P \vdash P \Rightarrow \neg Q$ — $ax$
2. $\Gamma, P \vdash P$ — $ax$
3. $\Gamma, P \vdash \neg Q$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, P \vdash Q$ — $ax$
5. $\Gamma, P \vdash \bot$ — $\neg e$ (4, 3)
6. $\Gamma \vdash \neg P$ — $\neg i$ (**descarga $P$**)

Es el *modus tollens* intuicionista: de $P \Rightarrow \neg Q$ y $Q$ sale $\neg P$ (no hace falta LK porque la meta ya es una negación).

---

**VII. $P \Rightarrow Q \vdash (P \wedge R) \Rightarrow (Q \wedge R)$**

Sea $\Gamma = P \Rightarrow Q,\; P \wedge R$.

1. $\Gamma \vdash P \wedge R$ — $ax$
2. $\Gamma \vdash P$ — $\wedge e_1$ (1)
3. $\Gamma \vdash R$ — $\wedge e_2$ (1)
4. $\Gamma \vdash P \Rightarrow Q$ — $ax$
5. $\Gamma \vdash Q$ — $\Rightarrow e$ (4, 2)
6. $\Gamma \vdash Q \wedge R$ — $\wedge i$ (5, 3)
7. $P \Rightarrow Q \vdash (P \wedge R) \Rightarrow (Q \wedge R)$ — $\Rightarrow i$ (**descarga $P \wedge R$**)

*Curry-Howard:* $\lambda f. \lambda p.\, \langle f\,(\pi_1 p),\, \pi_2 p\rangle$ — es el `first` de un par (functorialidad de $\wedge$).

---

**VIII. $Q \Rightarrow R \vdash (P \vee Q) \Rightarrow (P \vee R)$**

Sea $\Gamma = Q \Rightarrow R,\; P \vee Q$. Hay un $\vee$ en el contexto $\to$ $\vee e$ enseguida.

1. $\Gamma \vdash P \vee Q$ — $ax$
2. $\Gamma, P \vdash P$ — $ax$
3. $\Gamma, P \vdash P \vee R$ — $\vee i_1$ (2)
4. $\Gamma, Q \vdash Q \Rightarrow R$ — $ax$
5. $\Gamma, Q \vdash Q$ — $ax$
6. $\Gamma, Q \vdash R$ — $\Rightarrow e$ (4, 5)
7. $\Gamma, Q \vdash P \vee R$ — $\vee i_2$ (6)
8. $\Gamma \vdash P \vee R$ — $\vee e$ (1, 3, 7) (**descarga $P$ en la rama izquierda y $Q$ en la derecha**)
9. $Q \Rightarrow R \vdash (P \vee Q) \Rightarrow (P \vee R)$ — $\Rightarrow i$ (**descarga $P \vee Q$**)

*Curry-Howard:* es el `second` de una suma: $\lambda f. \lambda z.\, \mathsf{case}\, z\, \{\mathsf{inl}(x) \to \mathsf{inl}(x) \;||\; \mathsf{inr}(y) \to \mathsf{inr}(f\,y)\}$.

---

**IX. $(P \vee Q) \vee R \vdash P \vee (Q \vee R)$**

Sea $\Gamma = (P \vee Q) \vee R$ y $G = P \vee (Q \vee R)$ la meta. Es el Ejercicio 5.XII (dirección $\Rightarrow$) sin el $\Rightarrow i$ final: **$\vee e$ anidado**.

1. $\Gamma \vdash (P \vee Q) \vee R$ — $ax$
2. $\Gamma, P \vee Q \vdash P \vee Q$ — $ax$
3. $\Gamma, P \vee Q, P \vdash P$ — $ax$; $\vee i_1$ da $\Gamma, P \vee Q, P \vdash G$
4. $\Gamma, P \vee Q, Q \vdash Q$ — $ax$; $\vee i_1$ da $Q \vee R$ y $\vee i_2$ da $\Gamma, P \vee Q, Q \vdash G$
5. $\Gamma, P \vee Q \vdash G$ — $\vee e$ (2, 3, 4) (**descarga $P$ y $Q$**)
6. $\Gamma, R \vdash R$ — $ax$; $\vee i_2$ da $Q \vee R$ y $\vee i_2$ da $\Gamma, R \vdash G$
7. $\Gamma \vdash G$ — $\vee e$ (1, 5, 6) (**descarga $P \vee Q$ y $R$**)

---

**X. $P \wedge (Q \vee R) \vdash (P \wedge Q) \vee (P \wedge R)$** (distributividad, ida)

Sea $\Gamma = P \wedge (Q \vee R)$ y $G = (P \wedge Q) \vee (P \wedge R)$.

1. $\Gamma \vdash P \wedge (Q \vee R)$ — $ax$
2. $\Gamma \vdash P$ — $\wedge e_1$ (1)
3. $\Gamma \vdash Q \vee R$ — $\wedge e_2$ (1)
4. $\Gamma, Q \vdash P$ — 2 (debilitamiento) — y $\Gamma, Q \vdash Q$ — $ax$
5. $\Gamma, Q \vdash P \wedge Q$ — $\wedge i$ (4); $\vee i_1$ da $\Gamma, Q \vdash G$
6. $\Gamma, R \vdash P \wedge R$ — $\wedge i$ (2 debilitado + $ax$); $\vee i_2$ da $\Gamma, R \vdash G$
7. $\Gamma \vdash G$ — $\vee e$ (3, 5, 6) (**descarga $Q$ y $R$**)

Clave: hacer $\wedge e$ **antes** del $\vee e$, para tener $P$ disponible dentro de las dos ramas.

---

**XI. $(P \wedge Q) \vee (P \wedge R) \vdash P \wedge (Q \vee R)$** (distributividad, vuelta)

Sea $\Delta = (P \wedge Q) \vee (P \wedge R)$ y $G = P \wedge (Q \vee R)$.

1. $\Delta \vdash (P \wedge Q) \vee (P \wedge R)$ — $ax$
2. $\Delta, P \wedge Q \vdash P$ — $ax$ + $\wedge e_1$; $\Delta, P \wedge Q \vdash Q$ — $ax$ + $\wedge e_2$
3. $\Delta, P \wedge Q \vdash Q \vee R$ — $\vee i_1$ (2); $\Delta, P \wedge Q \vdash G$ — $\wedge i$
4. $\Delta, P \wedge R \vdash P$ — $ax$ + $\wedge e_1$; $\Delta, P \wedge R \vdash R$ — $ax$ + $\wedge e_2$
5. $\Delta, P \wedge R \vdash Q \vee R$ — $\vee i_2$ (4); $\Delta, P \wedge R \vdash G$ — $\wedge i$
6. $\Delta \vdash G$ — $\vee e$ (1, 3, 5) (**descarga $P \wedge Q$ y $P \wedge R$**)

X + XI dan la equivalencia distributiva $P \wedge (Q \vee R) \Leftrightarrow (P \wedge Q) \vee (P \wedge R)$, **enteramente intuicionista** (a diferencia de de Morgan II).

---

**XII. $\neg P \vee Q \vdash P \Rightarrow Q$**

Sea $\Gamma = \neg P \vee Q,\; P$. Es la dirección **fácil** (intuicionista) del Ejercicio 6.VII.

1. $\Gamma \vdash \neg P \vee Q$ — $ax$
2. $\Gamma, \neg P \vdash P$ — $ax$; $\Gamma, \neg P \vdash \neg P$ — $ax$
3. $\Gamma, \neg P \vdash \bot$ — $\neg e$ (2)
4. $\Gamma, \neg P \vdash Q$ — $\bot e$ (3) (*explosión*)
5. $\Gamma, Q \vdash Q$ — $ax$
6. $\Gamma \vdash Q$ — $\vee e$ (1, 4, 5) (**descarga $\neg P$ y $Q$**)
7. $\neg P \vee Q \vdash P \Rightarrow Q$ — $\Rightarrow i$ (**descarga $P$**)

La **recíproca** ($P \Rightarrow Q \vdash \neg P \vee Q$) sí necesita LK — ver Ejercicio 6.VII.

---

**XIII. $P \Rightarrow Q,\; P \Rightarrow \neg Q \vdash \neg P$**

Sea $\Gamma = P \Rightarrow Q,\; P \Rightarrow \neg Q$.

1. $\Gamma, P \vdash P$ — $ax$
2. $\Gamma, P \vdash P \Rightarrow Q$ — $ax$
3. $\Gamma, P \vdash Q$ — $\Rightarrow e$ (2, 1)
4. $\Gamma, P \vdash P \Rightarrow \neg Q$ — $ax$
5. $\Gamma, P \vdash \neg Q$ — $\Rightarrow e$ (4, 1)
6. $\Gamma, P \vdash \bot$ — $\neg e$ (3, 5)
7. $\Gamma \vdash \neg P$ — $\neg i$ (**descarga $P$**)

*Reductio* genuinamente intuicionista: la meta ya era una negación, así que $\neg i$ alcanza y no hace falta $PBC$.

---

**XIV. $P \Rightarrow (Q \Rightarrow R),\; P,\; \neg R \vdash \neg Q$**

Sea $\Gamma = P \Rightarrow (Q \Rightarrow R),\; P,\; \neg R$.

1. $\Gamma, Q \vdash P \Rightarrow (Q \Rightarrow R)$ — $ax$
2. $\Gamma, Q \vdash P$ — $ax$
3. $\Gamma, Q \vdash Q \Rightarrow R$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, Q \vdash Q$ — $ax$
5. $\Gamma, Q \vdash R$ — $\Rightarrow e$ (3, 4)
6. $\Gamma, Q \vdash \neg R$ — $ax$
7. $\Gamma, Q \vdash \bot$ — $\neg e$ (5, 6)
8. $\Gamma \vdash \neg Q$ — $\neg i$ (**descarga $Q$**)

Mismo esqueleto que IV (modus tollens sobre una implicación currificada).

---

**Ejercicio 12 — los 11 secuentes**

**I. $(P \wedge \neg Q) \Rightarrow R,\; \neg R,\; P \vdash Q$** — **necesita LK**

Sea $\Gamma = (P \wedge \neg Q) \Rightarrow R,\; \neg R,\; P$. La meta $Q$ es una variable "de la nada": ninguna regla de introducción de LJ la construye $\to$ arrancar por $PBC$.

1. $\Gamma, \neg Q \vdash P$ — $ax$
2. $\Gamma, \neg Q \vdash \neg Q$ — $ax$
3. $\Gamma, \neg Q \vdash P \wedge \neg Q$ — $\wedge i$ (1, 2)
4. $\Gamma, \neg Q \vdash (P \wedge \neg Q) \Rightarrow R$ — $ax$
5. $\Gamma, \neg Q \vdash R$ — $\Rightarrow e$ (4, 3)
6. $\Gamma, \neg Q \vdash \neg R$ — $ax$
7. $\Gamma, \neg Q \vdash \bot$ — $\neg e$ (5, 6)
8. $\Gamma \vdash Q$ — **$PBC$** (**descarga $\neg Q$**) ← *la regla que vuelve clásica la derivación*

Intuicionistamente sólo se llega hasta $\Gamma \vdash \neg\neg Q$ (paso 7 + $\neg i$); el salto a $Q$ es exactamente $\neg\neg e$.

---

**II. $\neg P \Rightarrow Q \vdash \neg Q \Rightarrow P$** — **necesita LK**

Sea $\Gamma = \neg P \Rightarrow Q,\; \neg Q$. Meta $P$ (variable) $\to$ $PBC$.

1. $\Gamma, \neg P \vdash \neg P \Rightarrow Q$ — $ax$
2. $\Gamma, \neg P \vdash \neg P$ — $ax$
3. $\Gamma, \neg P \vdash Q$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, \neg P \vdash \neg Q$ — $ax$
5. $\Gamma, \neg P \vdash \bot$ — $\neg e$ (3, 4)
6. $\Gamma \vdash P$ — **$PBC$** (**descarga $\neg P$**) ← *regla clásica*
7. $\neg P \Rightarrow Q \vdash \neg Q \Rightarrow P$ — $\Rightarrow i$ (**descarga $\neg Q$**)

Otra contraposición que **saca** negaciones (comparar con Ej. 5.V vs. 6.V): en LJ sólo se obtiene $\neg\neg P$.

---

**III. $P \vee Q \vdash R \Rightarrow (P \vee Q) \wedge R$** (LJ)

Sea $\Gamma = P \vee Q,\; R$. No hace falta abrir el $\vee$: se usa la hipótesis **entera**.

1. $\Gamma \vdash P \vee Q$ — $ax$
2. $\Gamma \vdash R$ — $ax$
3. $\Gamma \vdash (P \vee Q) \wedge R$ — $\wedge i$ (1, 2)
4. $P \vee Q \vdash R \Rightarrow (P \vee Q) \wedge R$ — $\Rightarrow i$ (**descarga $R$**)

Trampa clásica del ejercicio: uno tiende a hacer $\vee e$ por reflejo; acá sería trabajo inútil.

---

**IV. $(P \vee (Q \Rightarrow P)) \wedge Q \vdash P$** (LJ)

Sea $\Gamma = (P \vee (Q \Rightarrow P)) \wedge Q$.

1. $\Gamma \vdash (P \vee (Q \Rightarrow P)) \wedge Q$ — $ax$
2. $\Gamma \vdash P \vee (Q \Rightarrow P)$ — $\wedge e_1$ (1)
3. $\Gamma \vdash Q$ — $\wedge e_2$ (1)
4. $\Gamma, P \vdash P$ — $ax$
5. $\Gamma, Q \Rightarrow P \vdash Q \Rightarrow P$ — $ax$
6. $\Gamma, Q \Rightarrow P \vdash Q$ — 3 (debilitamiento)
7. $\Gamma, Q \Rightarrow P \vdash P$ — $\Rightarrow e$ (5, 6)
8. $\Gamma \vdash P$ — $\vee e$ (2, 4, 7) (**descarga $P$ y $Q \Rightarrow P$**)

Meta positiva pero **no** hace falta LK: el $P$ sale del $\vee e$, no de la nada.

---

**V. $P \Rightarrow Q,\; R \Rightarrow S \vdash (P \wedge R) \Rightarrow (Q \wedge S)$** (LJ)

Sea $\Gamma = P \Rightarrow Q,\; R \Rightarrow S,\; P \wedge R$.

1. $\Gamma \vdash P \wedge R$ — $ax$
2. $\Gamma \vdash P$ — $\wedge e_1$ (1)
3. $\Gamma \vdash R$ — $\wedge e_2$ (1)
4. $\Gamma \vdash P \Rightarrow Q$ — $ax$
5. $\Gamma \vdash Q$ — $\Rightarrow e$ (4, 2)
6. $\Gamma \vdash R \Rightarrow S$ — $ax$
7. $\Gamma \vdash S$ — $\Rightarrow e$ (6, 3)
8. $\Gamma \vdash Q \wedge S$ — $\wedge i$ (5, 7)
9. $P \Rightarrow Q,\; R \Rightarrow S \vdash (P \wedge R) \Rightarrow (Q \wedge S)$ — $\Rightarrow i$ (**descarga $P \wedge R$**)

*Curry-Howard:* el producto de funciones, $\lambda p.\, \langle f(\pi_1 p),\, g(\pi_2 p)\rangle$.

---

**VI. $P \Rightarrow Q \vdash ((P \wedge Q) \Rightarrow P) \wedge (P \Rightarrow (P \wedge Q))$** (LJ)

Dos derivaciones y un $\wedge i$ final.

*Conjunto izquierdo* — $(P \wedge Q) \Rightarrow P$ (ni siquiera usa la hipótesis):

1. $P \Rightarrow Q,\; P \wedge Q \vdash P \wedge Q$ — $ax$
2. $P \Rightarrow Q,\; P \wedge Q \vdash P$ — $\wedge e_1$ (1)
3. $P \Rightarrow Q \vdash (P \wedge Q) \Rightarrow P$ — $\Rightarrow i$ (**descarga $P \wedge Q$**)

*Conjunto derecho* — $P \Rightarrow (P \wedge Q)$. Sea $\Delta = P \Rightarrow Q,\; P$:

4. $\Delta \vdash P$ — $ax$
5. $\Delta \vdash P \Rightarrow Q$ — $ax$
6. $\Delta \vdash Q$ — $\Rightarrow e$ (5, 4)
7. $\Delta \vdash P \wedge Q$ — $\wedge i$ (4, 6)
8. $P \Rightarrow Q \vdash P \Rightarrow (P \wedge Q)$ — $\Rightarrow i$ (**descarga $P$**)

9. $P \Rightarrow Q \vdash ((P \wedge Q) \Rightarrow P) \wedge (P \Rightarrow (P \wedge Q))$ — $\wedge i$ (3, 8)

Moraleja: bajo $P \Rightarrow Q$, las fórmulas $P$ y $P \wedge Q$ son equivalentes.

---

**VII. $P \Rightarrow (Q \wedge R) \vdash (P \Rightarrow Q) \wedge (P \Rightarrow R)$** (LJ)

Sea $\Gamma = P \Rightarrow (Q \wedge R),\; P$.

1. $\Gamma \vdash P \Rightarrow (Q \wedge R)$ — $ax$
2. $\Gamma \vdash P$ — $ax$
3. $\Gamma \vdash Q \wedge R$ — $\Rightarrow e$ (1, 2)
4. $\Gamma \vdash Q$ — $\wedge e_1$ (3)
5. $P \Rightarrow (Q \wedge R) \vdash P \Rightarrow Q$ — $\Rightarrow i$ (**descarga $P$**)
6. $\Gamma \vdash R$ — $\wedge e_2$ (3)
7. $P \Rightarrow (Q \wedge R) \vdash P \Rightarrow R$ — $\Rightarrow i$ (**descarga $P$**)
8. $P \Rightarrow (Q \wedge R) \vdash (P \Rightarrow Q) \wedge (P \Rightarrow R)$ — $\wedge i$ (5, 7)

---

**VIII. $(P \Rightarrow Q) \wedge (P \Rightarrow R) \vdash P \Rightarrow (Q \wedge R)$** (LJ)

Sea $\Gamma = (P \Rightarrow Q) \wedge (P \Rightarrow R),\; P$.

1. $\Gamma \vdash (P \Rightarrow Q) \wedge (P \Rightarrow R)$ — $ax$
2. $\Gamma \vdash P \Rightarrow Q$ — $\wedge e_1$ (1)
3. $\Gamma \vdash P \Rightarrow R$ — $\wedge e_2$ (1)
4. $\Gamma \vdash P$ — $ax$
5. $\Gamma \vdash Q$ — $\Rightarrow e$ (2, 4)
6. $\Gamma \vdash R$ — $\Rightarrow e$ (3, 4)
7. $\Gamma \vdash Q \wedge R$ — $\wedge i$ (5, 6)
8. $(P \Rightarrow Q) \wedge (P \Rightarrow R) \vdash P \Rightarrow (Q \wedge R)$ — $\Rightarrow i$ (**descarga $P$**)

VII + VIII dan $P \Rightarrow (Q \wedge R) \Leftrightarrow (P \Rightarrow Q) \wedge (P \Rightarrow R)$ — la distributividad de $\Rightarrow$ sobre $\wedge$, intuicionista en las dos direcciones. *Curry-Howard:* es el isomorfismo $A \to (B \times C) \cong (A \to B) \times (A \to C)$.

---

**IX. $P \vee (P \wedge Q) \vdash P$** (LJ — ley de absorción)

Sea $\Gamma = P \vee (P \wedge Q)$.

1. $\Gamma \vdash P \vee (P \wedge Q)$ — $ax$
2. $\Gamma, P \vdash P$ — $ax$
3. $\Gamma, P \wedge Q \vdash P \wedge Q$ — $ax$; $\Gamma, P \wedge Q \vdash P$ — $\wedge e_1$
4. $\Gamma \vdash P$ — $\vee e$ (1, 2, 3) (**descarga $P$ y $P \wedge Q$**)

Meta positiva sin LK: las dos ramas del $\vee e$ ya dan $P$.

---

**X. $P \Rightarrow (Q \vee R),\; Q \Rightarrow S,\; R \Rightarrow S \vdash P \Rightarrow S$** (LJ)

Sea $\Gamma = P \Rightarrow (Q \vee R),\; Q \Rightarrow S,\; R \Rightarrow S,\; P$.

1. $\Gamma \vdash P \Rightarrow (Q \vee R)$ — $ax$
2. $\Gamma \vdash P$ — $ax$
3. $\Gamma \vdash Q \vee R$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, Q \vdash Q \Rightarrow S$ — $ax$; $\Gamma, Q \vdash Q$ — $ax$; $\Gamma, Q \vdash S$ — $\Rightarrow e$
5. $\Gamma, R \vdash R \Rightarrow S$ — $ax$; $\Gamma, R \vdash R$ — $ax$; $\Gamma, R \vdash S$ — $\Rightarrow e$
6. $\Gamma \vdash S$ — $\vee e$ (3, 4, 5) (**descarga $Q$ y $R$**)
7. $P \Rightarrow (Q \vee R),\; Q \Rightarrow S,\; R \Rightarrow S \vdash P \Rightarrow S$ — $\Rightarrow i$ (**descarga $P$**)

Es el **análisis de casos intuicionista**: acá el $Q \vee R$ viene *dado* por una hipótesis, por eso no hace falta $LEM$ (comparar con el Ejercicio 6.VI, donde el $\vee$ hay que fabricarlo).

---

**XI. $(P \wedge Q) \vee (P \wedge R) \vdash P \wedge (Q \vee R)$** (LJ)

Idéntico al Ejercicio 11.XI (el enunciado lo repite): $\vee e$ sobre la hipótesis, en cada rama $\wedge e_{1,2}$ + $\vee i_{1,2}$ + $\wedge i$. Ver la derivación completa arriba.

---

**Ejercicio 13 — los 9 secuentes**

**I. $\neg P \Rightarrow \neg Q \vdash Q \Rightarrow P$** — **necesita LK** (es la contraposición clásica, Ej. 6.V)

Sea $\Gamma = \neg P \Rightarrow \neg Q,\; Q$.

1. $\Gamma, \neg P \vdash \neg P \Rightarrow \neg Q$ — $ax$
2. $\Gamma, \neg P \vdash \neg P$ — $ax$
3. $\Gamma, \neg P \vdash \neg Q$ — $\Rightarrow e$ (1, 2)
4. $\Gamma, \neg P \vdash Q$ — $ax$
5. $\Gamma, \neg P \vdash \bot$ — $\neg e$ (4, 3)
6. $\Gamma \vdash P$ — **$PBC$** (**descarga $\neg P$**) ← *regla clásica*
7. $\neg P \Rightarrow \neg Q \vdash Q \Rightarrow P$ — $\Rightarrow i$ (**descarga $Q$**)

Comparar con el Ejercicio 5.V: la contraposición que **agrega** negaciones es intuicionista; la que las **saca** es clásica.

---

**II. $\neg P \vee \neg Q \vdash \neg(P \wedge Q)$** (LJ — de Morgan II, dirección fácil)

Sea $\Delta = \neg P \vee \neg Q,\; P \wedge Q$. Meta $\neg(P \wedge Q)$ $\to$ $\neg i$: asumir $P \wedge Q$ y buscar $\bot$.

1. $\Delta \vdash \neg P \vee \neg Q$ — $ax$
2. $\Delta, \neg P \vdash P$ — $ax$ + $\wedge e_1$; con $ax$ ($\neg P$) y $\neg e$ da $\Delta, \neg P \vdash \bot$
3. $\Delta, \neg Q \vdash Q$ — $ax$ + $\wedge e_2$; con $ax$ ($\neg Q$) y $\neg e$ da $\Delta, \neg Q \vdash \bot$
4. $\Delta \vdash \bot$ — $\vee e$ (1, 2, 3) (**descarga $\neg P$ y $\neg Q$**)
5. $\neg P \vee \neg Q \vdash \neg(P \wedge Q)$ — $\neg i$ (**descarga $P \wedge Q$**)

La **recíproca** ($\neg(P \wedge Q) \vdash \neg P \vee \neg Q$) sí es clásica — ver Ejercicio 5.VIII.

---

**III. $\neg P,\; P \vee Q \vdash Q$** (LJ — silogismo disyuntivo)

Sea $\Gamma = \neg P,\; P \vee Q$.

1. $\Gamma \vdash P \vee Q$ — $ax$
2. $\Gamma, P \vdash P$ — $ax$; $\Gamma, P \vdash \neg P$ — $ax$; $\Gamma, P \vdash \bot$ — $\neg e$
3. $\Gamma, P \vdash Q$ — $\bot e$ (2) (*explosión*)
4. $\Gamma, Q \vdash Q$ — $ax$
5. $\Gamma \vdash Q$ — $\vee e$ (1, 3, 4) (**descarga $P$ y $Q$**)

Meta positiva y aun así **intuicionista**: el $\vee$ ya está en el contexto, no hay que inventarlo con $LEM$.

---

**IV. $P \vee Q,\; \neg Q \vee R \vdash P \vee R$** (LJ — resolución proposicional)

Sea $\Gamma = P \vee Q,\; \neg Q \vee R$ y $G = P \vee R$. Dos $\vee e$, uno anidado dentro del otro.

1. $\Gamma \vdash P \vee Q$ — $ax$
2. **Rama $P$:** $\Gamma, P \vdash P$ — $ax$; $\vee i_1$ da $\Gamma, P \vdash G$
3. **Rama $Q$:** hay que abrir el segundo $\vee$.
   - $\Gamma, Q \vdash \neg Q \vee R$ — $ax$
   - Sub-rama $\neg Q$: $\Gamma, Q, \neg Q \vdash \bot$ — $\neg e$ ($ax$ $Q$, $ax$ $\neg Q$); $\bot e$ da $\Gamma, Q, \neg Q \vdash G$
   - Sub-rama $R$: $\Gamma, Q, R \vdash R$ — $ax$; $\vee i_2$ da $\Gamma, Q, R \vdash G$
   - $\Gamma, Q \vdash G$ — $\vee e$ (**descarga $\neg Q$ y $R$**)
4. $\Gamma \vdash G$ — $\vee e$ (1, 2, 3) (**descarga $P$ y $Q$**)

Es exactamente la **regla de resolución** ($P \vee Q$ y $\neg Q \vee R$ resuelven a $P \vee R$) derivada dentro de deducción natural — la conexión con el tema *Resolución* de la materia.

---

**V. $P \wedge \neg P \vdash \neg(R \Rightarrow Q) \wedge (R \Rightarrow Q)$** (LJ — *ex falso quodlibet*)

Sea $\Gamma = P \wedge \neg P$. El contexto es contradictorio, así que la meta (que es ella misma una contradicción) sale por explosión.

1. $\Gamma \vdash P \wedge \neg P$ — $ax$
2. $\Gamma \vdash P$ — $\wedge e_1$ (1)
3. $\Gamma \vdash \neg P$ — $\wedge e_2$ (1)
4. $\Gamma \vdash \bot$ — $\neg e$ (2, 3)
5. $\Gamma \vdash \neg(R \Rightarrow Q)$ — $\bot e$ (4)
6. $\Gamma \vdash R \Rightarrow Q$ — $\bot e$ (4)
7. $\Gamma \vdash \neg(R \Rightarrow Q) \wedge (R \Rightarrow Q)$ — $\wedge i$ (5, 6)

No hay descargas. Con $\bot$ en mano se deriva **cualquier** par de fórmulas, incluso una y su negación: por eso una hipótesis contradictoria arruina un sistema.

---

**VI. $\neg(\neg P \vee Q) \vdash P$** — **necesita LK**

Sea $\Gamma = \neg(\neg P \vee Q)$. Meta $P$ (variable) $\to$ $PBC$.

1. $\Gamma, \neg P \vdash \neg P$ — $ax$
2. $\Gamma, \neg P \vdash \neg P \vee Q$ — $\vee i_1$ (1)
3. $\Gamma, \neg P \vdash \neg(\neg P \vee Q)$ — $ax$
4. $\Gamma, \neg P \vdash \bot$ — $\neg e$ (2, 3)
5. $\Gamma \vdash P$ — **$PBC$** (**descarga $\neg P$**) ← *regla clásica*

Intuicionistamente sólo se obtiene $\neg\neg P$ (paso 4 + $\neg i$), que es estrictamente más débil. *(Con la misma idea, $\vee i_2$ en el paso 2 da $\Gamma \vdash \neg Q$, esta vez **sin** LK.)*

---

**VII. $\vdash \neg P \Rightarrow (P \Rightarrow (P \Rightarrow Q))$** (LJ)

Sea $\Gamma = \neg P,\; P$ (las dos ocurrencias de $P$ colapsan: el contexto es un **conjunto**).

1. $\Gamma \vdash P$ — $ax$
2. $\Gamma \vdash \neg P$ — $ax$
3. $\Gamma \vdash \bot$ — $\neg e$ (1, 2)
4. $\Gamma \vdash Q$ — $\bot e$ (3)
5. $\neg P,\; P \vdash P \Rightarrow Q$ — $\Rightarrow i$ (**descarga $P$**)
6. $\neg P \vdash P \Rightarrow (P \Rightarrow Q)$ — $\Rightarrow i$ (**descarga $P$**)
7. $\vdash \neg P \Rightarrow (P \Rightarrow (P \Rightarrow Q))$ — $\Rightarrow i$ (**descarga $\neg P$**)

Detalle fino: con contextos-conjunto, los pasos 5 y 6 descargan "la misma" hipótesis $P$ dos veces (una descarga puede eliminar cero, una o varias ocurrencias). En una presentación con contextos-lista habría que duplicar $P$ explícitamente.

---

**VIII. $P \wedge Q \vdash \neg(\neg P \vee \neg Q)$** (LJ)

Sea $\Delta = P \wedge Q,\; \neg P \vee \neg Q$. Meta $\neg(\dots)$ $\to$ $\neg i$.

1. $\Delta \vdash \neg P \vee \neg Q$ — $ax$
2. $\Delta, \neg P \vdash P$ — $ax$ + $\wedge e_1$; con $ax$ ($\neg P$) y $\neg e$ da $\Delta, \neg P \vdash \bot$
3. $\Delta, \neg Q \vdash Q$ — $ax$ + $\wedge e_2$; con $ax$ ($\neg Q$) y $\neg e$ da $\Delta, \neg Q \vdash \bot$
4. $\Delta \vdash \bot$ — $\vee e$ (1, 2, 3) (**descarga $\neg P$ y $\neg Q$**)
5. $P \wedge Q \vdash \neg(\neg P \vee \neg Q)$ — $\neg i$ (**descarga $\neg P \vee \neg Q$**)

Es la doble negación de de Morgan: intuicionistamente $P \wedge Q \Rightarrow \neg(\neg P \vee \neg Q)$ vale, pero la vuelta $\neg(\neg P \vee \neg Q) \Rightarrow P \wedge Q$ **no** (se prueba igual que VI, con $PBC$ para cada componente).

---

**IX. $\vdash (P \Rightarrow Q) \vee (Q \Rightarrow R)$** — **necesita LK**

Meta: una disyunción de la que **no** sabemos cuál lado vale $\to$ no sirve $\vee i$ solo; hay que fabricar un $\vee$ con $LEM$. Hacemos $LEM$ sobre $Q$.

1. $\vdash Q \vee \neg Q$ — **$LEM$** ← *regla clásica*
2. **Rama $Q$:** $Q, P \vdash Q$ — $ax$; $\Rightarrow i$ (**descarga $P$**) da $Q \vdash P \Rightarrow Q$; $\vee i_1$ da $Q \vdash (P \Rightarrow Q) \vee (Q \Rightarrow R)$
3. **Rama $\neg Q$:** $\neg Q, Q \vdash \bot$ — $\neg e$ ($ax$, $ax$); $\bot e$ da $\neg Q, Q \vdash R$; $\Rightarrow i$ (**descarga $Q$**) da $\neg Q \vdash Q \Rightarrow R$; $\vee i_2$ da $\neg Q \vdash (P \Rightarrow Q) \vee (Q \Rightarrow R)$
4. $\vdash (P \Rightarrow Q) \vee (Q \Rightarrow R)$ — $\vee e$ (1, 2, 3) (**descarga $Q$ en la rama izquierda y $\neg Q$ en la derecha**)

**Por qué es imposible en LJ:** es un teorema cerrado con $\vee$ en la raíz, así que por la **propiedad de la disyunción** de LJ tendría que valer $\vdash P \Rightarrow Q$ o $\vdash Q \Rightarrow R$; ninguna de las dos es teorema con $P, Q, R$ atómicas. Es una instancia de la *linealidad de Dummett* ($(A \Rightarrow B) \vee (B \Rightarrow A)$), válida clásicamente y no en LJ.

**Chuleta**
> 1. Meta primero: $\Rightarrow$ → $\Rightarrow i$ (descargar antecedente), $\wedge$ → $\wedge i$, $\neg$ → $\neg i$ (asumir y buscar $\bot$) → 2. contexto después: $\wedge$ → $\wedge e$, $\vee$ → $\vee e$ (probar la meta en las dos ramas), $\Rightarrow$ → $\Rightarrow e$ cuando tengas el antecedente → 3. $\bot$ en mano → $\bot e$ da lo que falte → 4. **meta positiva y trabado** → LK: $PBC$ (asumir $\neg$meta, llegar a $\bot$) o $LEM$ + $\vee e$ → 5. Ej. 11 = **todo LJ** (plomería de $\wedge$/$\vee$/$\Rightarrow$); del Ej. 12 sólo I y II son clásicos ($PBC$ sobre la variable de la meta) y del Ej. 13 sólo I, VI ($PBC$) y IX ($LEM$) — el resto también sale en LJ → 6. señal de que **no** hace falta LK aunque la meta sea positiva: el $\vee$ ya está en el contexto (Ej. 12.IV/IX, Ej. 13.III/IV) o hay un $\bot$ a mano (Ej. 13.V).

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/deduccion_natural_intuicionista]]
