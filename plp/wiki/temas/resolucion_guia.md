---
nombre: Resolución en Lógica — Guia de Ejercicios
parcial: 2P
programa: 2C_2026
tipo: guia
tema: resolucion
fuente: raw/guias_practicas/6.guia_2P_resolucion_en_logica.pdf
paginas_relacionadas:
  - "[[resolucion_teoria]]"
  - "[[resolucion_practica]]"
  - "[[resolucion_sld_y_prolog_teoria]]"
---

# Resolución en Lógica — Guía de Ejercicios

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Conversión a CNF y Forma Clausal (Proposicional) | 🔴 Si |
| Ej. 2 | Tautologías y resolución proposicional | ⚪ No |
| Ej. 3 | Demostración de tautologías mediante resolución | 🔴 Si |
| Ej. 4 | Problema lógico: Almuerzo de amigos | ⚪ No |
| Ej. 5 | Conversión a Forma Normal Negada (NNF) | 🔴 Si |
| Ej. 6 | Forma Normal de Skolem y Clausal (LPO) | 🔴 Si |
| Ej. 7 | Propiedades de los resolventes | ⚪ No |
| Ej. 8 | Problema lógico: Smullyan y el jefe de gobierno | ⚪ No |
| Ej. 9 | Validez lógica y resolución en LPO | 🔴 Si |
| Ej. 10 | Reglas clásicas en forma clausal (Modus Ponens, etc.) | 🔴 Si |
| Ej. 11 | Identificación de Cláusulas de Horn | 🔴 Si |
| Ej. 12 | Condiciones para la resolución SLD | 🔴 Si |
| Ej. 13 | Problema lógico: Alan el robot (SLD) | ⚪ No |
| Ej. 14 | Aritmética y paridad (SLD) | ⚪ No |
| Ej. 15 | Forma clausal y prueba SLD | 🔴 Si |
| Ej. 16 | Análisis de errores: Teorema del Bebedor | ⚪ No |
| Ej. 17 | Unificación y prueba: Contactos de Facebook | 🔴 Si |
| Ej. 18 | Relaciones familiares: Descendiente y Abuelo | 🔴 Si |
| Ej. 19 | Propiedades de relaciones binarias | ⚪ No |
| Ej. 20 | Programas Prolog: Números naturales | 🔴 Si |
| Ej. 21 | Programas Prolog: Flipper el delfín | ⚪ No |
| Ej. 22 | Programas Prolog: Preorder y Append | 🔴 Si |
| Ej. 23 | Consulta Prolog: Pares positivos | ⚪ No |
| Ej. 24 | Reglas de reducción (Cálculo Lambda) | ⚪ No |
| Ej. 25 | Generación infinita en Prolog | 🔴 Si |
| Ej. 26 | Paridad y transitividad en enteros | 🔴 Si |

---

## Ejercicios

### Ejercicio 1 — Conversión a Forma Clausal (Proposicional)

**Enunciado**
Convertir a Forma Normal Conjuntiva y luego a Forma Clausal (notación de conjuntos) las siguientes fórmulas proposicionales:

I. $P \Rightarrow P$
II. $(P \wedge Q) \Rightarrow P$
III. $(P \vee Q) \Rightarrow P$
IV. $\neg(P \Leftrightarrow \neg P)$
V. $\neg(P \wedge Q) \Rightarrow (\neg P \vee \neg Q)$
VI. $(P \wedge Q) \vee (P \wedge R)$
VII. $(P \wedge Q) \Rightarrow R$
VIII. $P \Rightarrow (Q \Rightarrow R)$

**Explicacion**
Pide aplicar el algoritmo de transformación: eliminar implicaciones ($A \Rightarrow B \equiv \neg A \vee B$), mover negaciones hacia adentro (De Morgan), y distribuir disyunciones sobre conjunciones para obtener una conjunción de disyunciones (CNF). Luego, cada disyunción es una cláusula (conjunto de literales).

**Resolucion paso a paso**
**I.** $P \Rightarrow P$
1. Eliminar $\Rightarrow$: $\neg P \vee P$
2. Ya está en NNF y en CNF (una sola disyunción).
3. Forma clausal: $\{\{\neg P, P\}\}$ — cláusula **tautológica** (contiene un par complementario).

**II.** $(P \wedge Q) \Rightarrow P$
1. Eliminar $\Rightarrow$: $\neg(P \wedge Q) \vee P$
2. NNF (De Morgan): $\neg P \vee \neg Q \vee P$
3. Forma clausal: $\{\{\neg P, \neg Q, P\}\}$ — tautológica.

**III.** $(P \vee Q) \Rightarrow P$
1. Eliminar $\Rightarrow$: $\neg(P \vee Q) \vee P$
2. NNF (De Morgan): $(\neg P \wedge \neg Q) \vee P$
3. CNF (distribuir $\vee$ sobre $\wedge$): $(\neg P \vee P) \wedge (\neg Q \vee P)$
4. Forma clausal: $\{\{\neg P, P\},\ \{\neg Q, P\}\}$ — la primera es tautológica, la segunda **no**.

**IV.** $\neg(P \Leftrightarrow \neg P)$
1. Eliminar $\Leftrightarrow$: $\neg[(P \Rightarrow \neg P) \wedge (\neg P \Rightarrow P)]$
2. Eliminar $\Rightarrow$: $\neg[(\neg P \vee \neg P) \wedge (P \vee P)]$
3. Idempotencia: $\neg[\neg P \wedge P]$
4. NNF (De Morgan + doble negación): $P \vee \neg P$
5. Forma clausal: $\{\{P, \neg P\}\}$ — tautológica.

**V.** $\neg(P \wedge Q) \Rightarrow (\neg P \vee \neg Q)$
1. Eliminar $\Rightarrow$: $\neg\neg(P \wedge Q) \vee \neg P \vee \neg Q$
2. NNF (doble negación): $(P \wedge Q) \vee \neg P \vee \neg Q$
3. CNF (distribuir): $(P \vee \neg P \vee \neg Q) \wedge (Q \vee \neg P \vee \neg Q)$
4. Forma clausal: $\{\{P, \neg P, \neg Q\},\ \{Q, \neg P, \neg Q\}\}$ — ambas tautológicas.

**VI.** $(P \wedge Q) \vee (P \wedge R)$
1. Ya está en NNF. Distribuir $\vee$ sobre $\wedge$ (dos veces):
$$(P \vee P) \wedge (P \vee R) \wedge (Q \vee P) \wedge (Q \vee R)$$
2. Forma clausal: $\{\{P\},\ \{P, R\},\ \{P, Q\},\ \{Q, R\}\}$
3. Simplificación por **subsunción**: $\{P\}$ subsume a $\{P,R\}$ y a $\{P,Q\}$, así que pueden descartarse:
$$\{\{P\},\ \{Q, R\}\}$$

**VII.** $(P \wedge Q) \Rightarrow R$
1. Eliminar $\Rightarrow$: $\neg(P \wedge Q) \vee R$
2. NNF: $\neg P \vee \neg Q \vee R$
3. Forma clausal: $\{\{\neg P, \neg Q, R\}\}$ — es una **cláusula de Horn** (un solo literal positivo): la regla `R :- P, Q.`

**VIII.** $P \Rightarrow (Q \Rightarrow R)$
1. Eliminar $\Rightarrow$ (dos veces): $\neg P \vee (\neg Q \vee R)$
2. Asociatividad: $\neg P \vee \neg Q \vee R$
3. Forma clausal: $\{\{\neg P, \neg Q, R\}\}$ — **idéntica a VII**, lo cual confirma la equivalencia $(P \wedge Q) \Rightarrow R \equiv P \Rightarrow (Q \Rightarrow R)$ (*currificación*).

**Chuleta**
> 1. Eliminar $\Rightarrow$ ($A \Rightarrow B \equiv \neg A \vee B$) y $\Leftrightarrow$ → 2. NNF (De Morgan + doble negación, negaciones sólo sobre átomos) → 3. Distribuir $\vee$ sobre $\wedge$ → 4. Cada disyunción es un conjunto de literales; el todo es un conjunto de conjuntos.
> 2. Simplificaciones finales: literales repetidos se colapsan (es un *conjunto*), cláusulas con $P$ y $\neg P$ son tautológicas, y una cláusula subsumida por otra se descarta.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_forma_clausal]]

---

### Ejercicio 2 — Tautologías y Resolución Proposicional

**Enunciado**
I. ¿Cuáles de las fórmulas del ejercicio anterior son tautologías? Demostrarlas utilizando el método de resolución para la lógica proposicional. Para las demás, indicar qué pasa si se intenta demostrarlas usando este método.
II. ¿Se deduce $(P \wedge Q)$ de $(\neg P \Rightarrow Q) \wedge (P \Rightarrow Q) \wedge (\neg P \Rightarrow \neg Q)$? Contestar utilizando el método de resolución para la lógica proposicional.

**Explicacion**
Para demostrar una tautología $\phi$ por resolución, se intenta derivar la cláusula vacía $\Box$ a partir de la negación de la fórmula ($\neg \phi$) en forma clausal. Si se deduce $\Box$, la fórmula original es una tautología (insatisfacibilidad de la negación).

**Resolucion paso a paso**
**I. ¿Cuáles del Ej. 1 son tautologías?**

Son tautologías **I, II, IV y V** (su forma clausal está formada sólo por cláusulas tautológicas). **No** lo son III, VI, VII y VIII.

*Método:* para probar que $\phi$ es tautología se pasa $\neg\phi$ a forma clausal y se busca $\Box$.

**I.** $\neg(P \Rightarrow P) \equiv P \wedge \neg P$ → cláusulas $\{P\}$, $\{\neg P\}$.
$$\frac{\{P\} \qquad \{\neg P\}}{\Box}$$

**II.** $\neg((P \wedge Q) \Rightarrow P) \equiv P \wedge Q \wedge \neg P$ → $\{P\}, \{Q\}, \{\neg P\}$.
Resolviendo $\{P\}$ con $\{\neg P\}$ se obtiene $\Box$ (la cláusula $\{Q\}$ no se usa).

**IV.** $\neg\neg(P \Leftrightarrow \neg P) \equiv P \Leftrightarrow \neg P \equiv \neg P \wedge P$ → $\{P\}, \{\neg P\}$ → $\Box$.

**V.** $\neg[\neg(P\wedge Q) \Rightarrow (\neg P \vee \neg Q)] \equiv \neg(P \wedge Q) \wedge P \wedge Q$ → cláusulas 1. $\{\neg P, \neg Q\}$, 2. $\{P\}$, 3. $\{Q\}$.
- De 1 y 2 (sobre $P$): 4. $\{\neg Q\}$
- De 4 y 3 (sobre $Q$): $\Box$

**¿Qué pasa con las que no son tautologías?** El conjunto de cláusulas de $\neg\phi$ se **satura** (no se pueden generar resolventes nuevos) sin llegar nunca a $\Box$. Como la resolución proposicional es refutacionalmente completa y el conjunto de cláusulas es finito, la saturación sin $\Box$ **prueba** que $\neg\phi$ es satisfacible, es decir, que $\phi$ no es tautología. Además, el conjunto saturado permite leer un contramodelo:

| Fórmula | Cláusulas de $\neg\phi$ | Resolventes | Contramodelo |
|---|---|---|---|
| III | $\{P,Q\}, \{\neg P\}$ | sólo $\{Q\}$, y ahí se satura | $P = F,\ Q = V$ |
| VI | $\{\neg P, \neg Q\}, \{\neg P, \neg R\}$ | ninguno (no hay literales complementarios) | $P = Q = R = F$ |
| VII y VIII | $\{P\}, \{Q\}, \{\neg R\}$ | ninguno | $P = Q = V,\ R = F$ |

**II. ¿Se deduce $(P \wedge Q)$ de $(\neg P \Rightarrow Q) \wedge (P \Rightarrow Q) \wedge (\neg P \Rightarrow \neg Q)$?**

**Sí.** Se pasa todo a forma clausal (premisas tal cual, conclusión negada):

| # | Origen | Cláusula |
|---|---|---|
| 1 | $\neg P \Rightarrow Q$ | $\{P, Q\}$ |
| 2 | $P \Rightarrow Q$ | $\{\neg P, Q\}$ |
| 3 | $\neg P \Rightarrow \neg Q$ | $\{P, \neg Q\}$ |
| 4 | $\neg(P \wedge Q)$ | $\{\neg P, \neg Q\}$ |

Refutación:
- De 1 y 3 (sobre $Q$): 5. $\{P\}$
- De 2 y 5 (sobre $P$): 6. $\{Q\}$
- De 4 y 5 (sobre $P$): 7. $\{\neg Q\}$
- De 6 y 7: $\Box$

Como $\{1,2,3,4\}$ es insatisfacible, las premisas implican $(P \wedge Q)$. (Verificación semántica: las tres premisas juntas sólo son verdaderas con $P = Q = V$.)

**Chuleta**
> 1. Tautología $\phi$ ⟺ $\neg\phi$ insatisfacible ⟹ negar, pasar a clausal, derivar $\Box$.
> 2. Si el conjunto se **satura** sin $\Box$ ⟹ no es tautología, y el conjunto saturado da el contramodelo.
> 3. Deducción $\Gamma \models \phi$: cláusulas de $\Gamma$ + cláusulas de $\neg\phi$ → buscar $\Box$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 3 — Demostración de Tautologías

**Enunciado**
Demostrar las siguientes tautologías utilizando el método de resolución para la lógica proposicional. Notar que no siempre es necesario usar todas las cláusulas.

- $(P \Rightarrow (P \Rightarrow Q)) \Rightarrow (P \Rightarrow Q)$
- $(R \Rightarrow \neg Q) \Rightarrow ((R \wedge Q) \Rightarrow P)$
- $((P \Rightarrow Q) \Rightarrow (R \Rightarrow \neg Q)) \Rightarrow \neg(R \wedge Q)$

**Explicacion**
Nuevamente, aplicar resolución por contradicción: negar la fórmula completa, pasar a forma clausal y buscar la cláusula vacía.

**Resolucion paso a paso**
**a) $(P \Rightarrow (P \Rightarrow Q)) \Rightarrow (P \Rightarrow Q)$**

Negación: $(P \Rightarrow (P \Rightarrow Q)) \wedge \neg(P \Rightarrow Q) \equiv (\neg P \vee \neg P \vee Q) \wedge P \wedge \neg Q$

| # | Cláusula |
|---|---|
| 1 | $\{\neg P, Q\}$  (los dos $\neg P$ colapsan: es un conjunto) |
| 2 | $\{P\}$ |
| 3 | $\{\neg Q\}$ |

- De 1 y 2 (sobre $P$): 4. $\{Q\}$
- De 4 y 3 (sobre $Q$): $\Box$ $\blacksquare$

**b) $(R \Rightarrow \neg Q) \Rightarrow ((R \wedge Q) \Rightarrow P)$**

Negación: $(\neg R \vee \neg Q) \wedge R \wedge Q \wedge \neg P$

| # | Cláusula |
|---|---|
| 1 | $\{\neg R, \neg Q\}$ |
| 2 | $\{R\}$ |
| 3 | $\{Q\}$ |
| 4 | $\{\neg P\}$ |

- De 1 y 2 (sobre $R$): 5. $\{\neg Q\}$
- De 5 y 3 (sobre $Q$): $\Box$ $\blacksquare$

La cláusula 4 **no se usa**: la tautología vale porque el antecedente y $R \wedge Q$ ya son contradictorios, sin importar $P$.

**c) $((P \Rightarrow Q) \Rightarrow (R \Rightarrow \neg Q)) \Rightarrow \neg(R \wedge Q)$**

Negación: $((P \Rightarrow Q) \Rightarrow (R \Rightarrow \neg Q)) \wedge R \wedge Q$

Primer conjunto: $\neg(\neg P \vee Q) \vee \neg R \vee \neg Q \equiv (P \wedge \neg Q) \vee \neg R \vee \neg Q$, y distribuyendo:
$$(P \vee \neg R \vee \neg Q) \wedge (\neg Q \vee \neg R \vee \neg Q)$$

| # | Cláusula |
|---|---|
| 1 | $\{P, \neg R, \neg Q\}$ |
| 2 | $\{\neg Q, \neg R\}$ |
| 3 | $\{R\}$ |
| 4 | $\{Q\}$ |

- De 2 y 3 (sobre $R$): 5. $\{\neg Q\}$
- De 5 y 4 (sobre $Q$): $\Box$ $\blacksquare$

De nuevo la cláusula 1 no interviene. **Moraleja del ejercicio:** conviene mirar primero las cláusulas unitarias y las que contienen los literales complementarios más "cerca" de la contradicción, en vez de resolver todos los pares a ciegas.

**Chuleta**
> 1. Negar la fórmula entera → 2. Clausal (ojo: los literales repetidos colapsan) → 3. Empezar por las **cláusulas unitarias** y resolver contra ellas → 4. $\Box$.
> Tip: no hace falta usar todas las cláusulas; si una letra proposicional aparece con un solo signo en todo el conjunto, esa cláusula es descartable.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_por_contradiccion]]

---

### Ejercicio 4 — Problema lógico: Almuerzo de amigos

**Enunciado**
Un grupo de amigos quería juntarse a comer en una casa, pero no decidían en cuál. Prevalecían dos propuestas: la casa de Fabiana, que era cómoda y espaciosa, y la de Manuel, más chica pero con un amplio jardín y parrilla al aire libre. Finalmente acordaron basar su elección en el pronóstico del tiempo. Si anunciaban lluvia, se reunirían en la casa de Fabiana; y si no, en la de Manuel (desde ya, la reunión tendría lugar en una sola casa).
Finalmente llegó el día de la reunión, y el grupo se juntó a comer en la casa de Fabiana, pero no llovió.
Utilizar las siguientes proposiciones para demostrar - mediante el método de resolución - que el pronóstico se equivocó (anunció lluvia y no llovió, o viceversa).
$P$ = “El pronóstico anunció lluvia.”
$F$ = “El grupo se reúne en la casa de Fabiana.”
$M$ = “El grupo se reúne en la casa de Manuel.”
$L$ = “Llueve en el día de la reunión.”
Ayuda: por la descripción de arriba sabemos que $P \Rightarrow F$, $\neg P \Rightarrow M$ y $\neg(F \wedge M)$, además de que $F$ y $\neg L$ son verdaderas. Pensar en lo que se quiere demostrar para decidir qué pares de cláusulas utilizar.

**Explicacion**
Problema de modelado. Hay que formalizar las sentencias, agregar los hechos conocidos y usar resolución para demostrar el objetivo: $(P \wedge \neg L) \vee (\neg P \wedge L)$.

**Resolucion paso a paso**
**Formalización.** De la descripción y los hechos:

| # | Origen | Cláusula |
|---|---|---|
| 1 | $P \Rightarrow F$ | $\{\neg P, F\}$ |
| 2 | $\neg P \Rightarrow M$ | $\{P, M\}$ |
| 3 | $\neg(F \wedge M)$ | $\{\neg F, \neg M\}$ |
| 4 | se reunieron en lo de Fabiana | $\{F\}$ |
| 5 | no llovió | $\{\neg L\}$ |

**Objetivo:** el pronóstico se equivocó, es decir $(P \wedge \neg L) \vee (\neg P \wedge L)$.

Negando el objetivo (el pronóstico acertó): $\neg[(P \wedge \neg L) \vee (\neg P \wedge L)] \equiv (\neg P \vee L) \wedge (P \vee \neg L)$

| # | Cláusula |
|---|---|
| 6 | $\{\neg P, L\}$ |
| 7 | $\{P, \neg L\}$ |

**Refutación** (siguiendo la ayuda: apuntamos a probar $P$ y ya tenemos $\neg L$):

- De 3 y 4 (sobre $F$): 8. $\{\neg M\}$ — *no se reunieron en lo de Manuel*
- De 2 y 8 (sobre $M$): 9. $\{P\}$ — *entonces el pronóstico anunció lluvia*
- De 6 y 9 (sobre $P$): 10. $\{L\}$ — *si el pronóstico acertó, tuvo que llover*
- De 10 y 5 (sobre $L$): $\Box$ $\blacksquare$

**Lectura del resultado.** La refutación exhibe además cuál de los dos disyuntos se cumple: derivamos $\{P\}$ (paso 9) y teníamos $\{\neg L\}$ (cláusula 5), o sea $P \wedge \neg L$ — *anunció lluvia y no llovió*. Las cláusulas 1 y 7 no se usan.

**Chuleta**
> 1. Modelar: $\{\neg P,F\}$, $\{P,M\}$, $\{\neg F,\neg M\}$, $\{F\}$, $\{\neg L\}$ → 2. Negar el objetivo $(P \wedge \neg L)\vee(\neg P \wedge L)$ → $\{\neg P,L\}$ y $\{P,\neg L\}$.
> 3. Cadena: $\{\neg F,\neg M\}+\{F\} \Rightarrow \{\neg M\}$ → $+\{P,M\} \Rightarrow \{P\}$ → $+\{\neg P,L\} \Rightarrow \{L\}$ → $+\{\neg L\} \Rightarrow \Box$.
> Testigo: $P \wedge \neg L$ (anunció lluvia y no llovió).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 5 — Conversión a NNF (LPO)

**Enunciado**
Convertir a Forma Normal Negada (NNF) las siguientes fórmulas de primer orden:

I. $\forall X. \forall Y. (\neg Q(X, Y) \Rightarrow \neg P(X, Y))$
II. $\forall X. \forall Y. ((P(X, Y) \wedge Q(X, Y)) \Rightarrow R(X, Y))$
III. $\forall X. \exists Y. (P(X, Y) \Rightarrow Q(X, Y))$

**Explicacion**
La NNF requiere que las negaciones afecten únicamente a los predicados (literales). Se eliminan implicaciones y se aplican leyes de De Morgan para cuantificadores: $\neg \forall X. \phi \equiv \exists X. \neg \phi$ y $\neg \exists X. \phi \equiv \forall X. \neg \phi$.

**Resolucion paso a paso**
**I.** $\forall X. \forall Y. (\neg Q(X, Y) \Rightarrow \neg P(X, Y))$
1. Eliminar $\Rightarrow$: $\forall X. \forall Y. (\neg\neg Q(X,Y) \vee \neg P(X,Y))$
2. Doble negación: $\boxed{\forall X. \forall Y. (Q(X,Y) \vee \neg P(X,Y))}$

Las negaciones quedan sólo sobre átomos → es NNF. (Es el contrarrecíproco de $P \Rightarrow Q$.)

**II.** $\forall X. \forall Y. ((P(X,Y) \wedge Q(X,Y)) \Rightarrow R(X,Y))$
1. Eliminar $\Rightarrow$: $\forall X. \forall Y. (\neg(P(X,Y) \wedge Q(X,Y)) \vee R(X,Y))$
2. De Morgan: $\boxed{\forall X. \forall Y. (\neg P(X,Y) \vee \neg Q(X,Y) \vee R(X,Y))}$

**III.** $\forall X. \exists Y. (P(X,Y) \Rightarrow Q(X,Y))$
1. Eliminar $\Rightarrow$: $\boxed{\forall X. \exists Y. (\neg P(X,Y) \vee Q(X,Y))}$

Los cuantificadores **no se tocan** al pasar a NNF: sólo se mueven las negaciones. Como no había ninguna negación por delante de un cuantificador, no hizo falta usar $\neg \forall X. \phi \equiv \exists X. \neg\phi$ ni $\neg\exists X.\phi \equiv \forall X. \neg\phi$.

**Chuleta**
> 1. Eliminar $\Rightarrow$ y $\Leftrightarrow$ → 2. Empujar $\neg$ hacia adentro con De Morgan ($\neg(A\wedge B) \equiv \neg A \vee \neg B$), doble negación, y las de cuantificadores: $\neg\forall X.\phi \equiv \exists X.\neg\phi$, $\neg\exists X.\phi \equiv \forall X.\neg\phi$.
> 3. Fin: toda $\neg$ queda pegada a un predicado. NNF **no** mueve cuantificadores ni distribuye $\vee$ sobre $\wedge$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_forma_clausal]]

---

### Ejercicio 6 — Forma Normal de Skolem y Clausal (LPO)

**Enunciado**
Convertir a Forma Normal de Skolem y luego a Forma Clausal las siguientes fórmulas de primer orden:

I. $\exists X. \exists Y. X < Y$, siendo $<$ un predicado binario usado de forma infija.
II. $\forall X. \exists Y. X < Y$
III. $\forall X. \neg(P(X) \wedge \forall Y. (\neg P(Y) \vee Q(Y)))$
IV. $\exists X. \forall Y. (P(X, Y) \wedge Q(X) \wedge \neg R(Y))$
V. $\forall X. (P(X) \wedge \exists Y. (Q(Y) \vee \forall Z. \exists W. (P(Z) \wedge \neg Q(W))))$

**Explicacion**
La skolemización elimina cuantificadores existenciales. Si un $\exists$ está precedido por $\forall X_1, \dots, \forall X_n$, la variable se reemplaza por una función de Skolem $f(X_1, \dots, X_n)$. Si no hay universales precedentes, se reemplaza por una constante de Skolem $c$.

**Resolucion paso a paso**
**I.** $\exists X. \exists Y.\ X < Y$
1. Ya está en NNF y prenexa.
2. Skolemizar: ningún $\exists$ está bajo un $\forall$ → cada uno se reemplaza por una **constante de Skolem** nueva: $X := a$, $Y := b$.
$$a < b$$
3. Forma clausal: $\{\{a < b\}\}$

**II.** $\forall X. \exists Y.\ X < Y$
1. El $\exists Y$ está bajo $\forall X$ → **función de Skolem** de aridad 1: $Y := f(X)$.
$$\forall X.\ X < f(X)$$
2. Forma clausal (se borran los $\forall$): $\{\{X < f(X)\}\}$

Observar que I y II **no** son equivalentes: la constante $b$ es la misma para todos, la función $f$ da un testigo distinto para cada $X$.

**III.** $\forall X. \neg(P(X) \wedge \forall Y. (\neg P(Y) \vee Q(Y)))$
1. NNF (De Morgan y $\neg\forall \equiv \exists\neg$):
$$\forall X.\ (\neg P(X) \vee \exists Y.\ (P(Y) \wedge \neg Q(Y)))$$
2. Prenexa (el $\exists Y$ sale porque $Y$ no aparece libre en $\neg P(X)$):
$$\forall X. \exists Y.\ (\neg P(X) \vee (P(Y) \wedge \neg Q(Y)))$$
3. Skolemizar $Y := f(X)$:
$$\forall X.\ (\neg P(X) \vee (P(f(X)) \wedge \neg Q(f(X))))$$
4. CNF (distribuir):
$$\forall X.\ (\neg P(X) \vee P(f(X))) \wedge (\neg P(X) \vee \neg Q(f(X)))$$
5. Forma clausal:
$$\{\ \{\neg P(X),\ P(f(X))\},\quad \{\neg P(X),\ \neg Q(f(X))\}\ \}$$

**IV.** $\exists X. \forall Y. (P(X,Y) \wedge Q(X) \wedge \neg R(Y))$
1. Ya en NNF y prenexa. El $\exists X$ no tiene $\forall$ por delante → constante de Skolem $X := a$:
$$\forall Y.\ (P(a,Y) \wedge Q(a) \wedge \neg R(Y))$$
2. Forma clausal:
$$\{\ \{P(a,Y)\},\quad \{Q(a)\},\quad \{\neg R(Y)\}\ \}$$

Ojo: cada cláusula tiene sus propias variables (se renombran libremente), así que la $Y$ de la primera y la de la tercera son independientes.

**V.** $\forall X. (P(X) \wedge \exists Y. (Q(Y) \vee \forall Z. \exists W. (P(Z) \wedge \neg Q(W))))$
1. Ya está en NNF. Prenexa (ninguna variable choca):
$$\forall X. \exists Y. \forall Z. \exists W.\ (P(X) \wedge (Q(Y) \vee (P(Z) \wedge \neg Q(W))))$$
2. Skolemizar de izquierda a derecha:
   - $\exists Y$ tiene por delante $\forall X$ → $Y := f(X)$
   - $\exists W$ tiene por delante $\forall X$ y $\forall Z$ → $W := g(X,Z)$
$$\forall X. \forall Z.\ (P(X) \wedge (Q(f(X)) \vee (P(Z) \wedge \neg Q(g(X,Z)))))$$
3. CNF (distribuir $Q(f(X)) \vee (\cdot \wedge \cdot)$):
$$P(X) \wedge (Q(f(X)) \vee P(Z)) \wedge (Q(f(X)) \vee \neg Q(g(X,Z)))$$
4. Forma clausal:
$$\{\ \{P(X)\},\quad \{Q(f(X)),\ P(Z)\},\quad \{Q(f(X)),\ \neg Q(g(X,Z))\}\ \}$$

Simplificación: $\{P(X)\}$ **subsume** a $\{Q(f(X)), P(Z)\}$ (basta instanciar $X := Z$), así que la segunda cláusula puede descartarse.

**Chuleta**
> 1. NNF → 2. Prenexa (sacar cuantificadores, renombrando si hay choques) → 3. Skolemizar cada $\exists$: constante nueva si no tiene $\forall$ a la izquierda, función nueva de **todas** las variables universales que lo preceden → 4. CNF → 5. Cláusulas (borrar $\forall$, renombrar variables por cláusula).
> Regla de oro: `∃ bajo n universales → f de aridad n`. La skolemización preserva **satisfacibilidad**, no equivalencia.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_forma_clausal]]

---

### Ejercicio 7 — Propiedades de los resolventes

**Enunciado**
Para pensar (o jugar):
I. Exhibir una cláusula que arroje un resolvente consigo misma.
II. Exhibir dos cláusulas, cada una con no más de dos literales, que arrojen tres o más resolventes distintos entre sí.
III. Exhibir dos cláusulas que arrojen como resolvente $\Box$ si se unifican tres o más términos a la vez, pero no si se unifica solamente un término de cada lado.

**Explicacion**
Ejercicio teórico sobre el funcionamiento del algoritmo de resolución y unificación.

**Resolucion paso a paso**
**I. Una cláusula que resuelve consigo misma**

Hay que renombrar las variables de una copia antes de resolver.

- *Caso proposicional (el más simple):* $C = \{P, \neg P\}$. Resolviendo $P$ de la primera copia con $\neg P$ de la segunda se obtiene el resolvente $\{\neg P, P\} = C$.
- *Caso de primer orden (más interesante):* $C = \{P(X),\ \neg P(f(X))\}$. Copia renombrada $C' = \{P(Y),\ \neg P(f(Y))\}$. Resolviendo $\neg P(f(X))$ de $C$ con $P(Y)$ de $C'$, con $mgu = \{Y := f(X)\}$:
$$\text{resolvente} = \{P(X),\ \neg P(f(f(X)))\}$$
que es una cláusula **nueva** (no es una variante de $C$). Iterando se generan infinitas cláusulas: por eso la resolución en LPO es sólo un procedimiento de *semi-decisión*.

**II. Dos cláusulas con $\leq 2$ literales y $\geq 3$ resolventes distintos**

$$C_1 = \{P,\ \neg Q\} \qquad C_2 = \{\neg P,\ Q\}$$

| Literales resueltos | Resolvente |
|---|---|
| $P$ contra $\neg P$ | $\{\neg Q,\ Q\}$ |
| $\neg Q$ contra $Q$ | $\{P,\ \neg P\}$ |
| ambos a la vez (regla **general** de resolución) | $\Box$ |

Tres resolventes distintos entre sí. La versión de primer orden es análoga con $C_1 = \{P(X), \neg Q(X)\}$ y $C_2 = \{\neg P(Y), Q(Y)\}$, con $mgu = \{Y := X\}$ en los tres casos.

**III. Dos cláusulas que dan $\Box$ sólo unificando tres términos a la vez**

$$C_1 = \{P(X),\ P(Y)\} \qquad C_2 = \{\neg P(a)\}$$

- **Con la regla general**, unificando los **tres** términos $P(X) = P(Y) = P(a)$ con $mgu = \{X := a,\ Y := a\}$, la cláusula 1 se colapsa entera y el resolvente es
$$\Box$$
- **Con resolución binaria** (un literal de cada lado), sólo se puede hacer $P(X)$ contra $\neg P(a)$, con $mgu = \{X := a\}$, y el resolvente es $\{P(Y)\}$ — nunca $\Box$. Lo mismo con $P(Y)$.

Éste es exactamente el motivo por el que **la resolución binaria no es refutacionalmente completa**: hace falta la regla general (o agregarle una regla de **factorización**, que colapsaría $\{P(X),P(Y)\}$ en $\{P(X)\}$ antes de resolver).

Una variante con dos cláusulas de dos literales cada una y cuatro términos unificados: $C_1 = \{P(X), P(Y)\}$, $C_2 = \{\neg P(U), \neg P(V)\}$, con $mgu = \{Y := X, U := X, V := X\}$ → $\Box$; ningún paso binario entre ellas produce la cláusula vacía.

**Chuleta**
> 1. Auto-resolvente: renombrar la copia; $\{P(X), \neg P(f(X))\}$ resuelve consigo misma con $mgu=\{Y := f(X)\}$.
> 2. Tres resolventes: $\{P,\neg Q\}$ y $\{\neg P, Q\}$ → $\{\neg Q, Q\}$, $\{P,\neg P\}$ y $\Box$ (regla general).
> 3. $\{P(X),P(Y)\}$ + $\{\neg P(a)\}$: unificando los 3 términos → $\Box$; binaria sólo → $\{P(Y)\}$. Moraleja: **binaria sin factorización no es completa**.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 8 — Problema lógico: Smullyan y el jefe de gobierno

**Enunciado**
La computadora de la policía registró que el Sr. Smullyan no pagó una multa. Cuando el Sr. Smullyan pagó la multa, la computadora grabó este hecho pero, como el programa tenía errores, no borró el hecho que expresaba que no había pagado la multa. A partir de la información almacenada en la computadora, mostrar utilizando resolución que el jefe de gobierno es un espía.
Utilizar los siguientes predicados y constantes: $Pagó(X)$ para expresar que $X$ pagó su multa, $Espía(X)$ para $X$ es un espía, **smullyan** para el Sr. Smullyan y **jefeGob** para el jefe de gobierno.

**Explicacion**
Demostración de que una base de conocimiento inconsistente (contiene $A$ y $\neg A$) permite derivar cualquier fórmula (Explosion Principle).

**Resolucion paso a paso**
**Formalización.** La computadora almacena los dos hechos contradictorios:

| # | Origen | Cláusula |
|---|---|---|
| 1 | el registro original: no pagó | $\{\neg Pag\acute{o}(smullyan)\}$ |
| 2 | el hecho que se grabó al pagar | $\{Pag\acute{o}(smullyan)\}$ |

**Objetivo:** $Esp\acute{\imath}a(jefeGob)$. Se lo niega y se agrega:

| # | Origen | Cláusula |
|---|---|---|
| 3 | $\neg Esp\acute{\imath}a(jefeGob)$ | $\{\neg Esp\acute{\imath}a(jefeGob)\}$ |

**Refutación.**
$$\frac{\{\neg Pag\acute{o}(smullyan)\} \qquad \{Pag\acute{o}(smullyan)\}}{\Box}$$

Un solo paso, y la cláusula 3 **no se usa**. $\blacksquare$

**Por qué esto "demuestra" que el jefe de gobierno es un espía.** El método de resolución prueba $\Gamma \models \sigma$ mostrando que $\Gamma \cup \{\neg\sigma\}$ es insatisfacible. Acá $\Gamma$ ya es insatisfacible **por sí sola**, así que $\Gamma \cup \{\neg\sigma\}$ lo es para *cualquier* $\sigma$: se deriva $\Box$ sin siquiera mirar la conclusión.

Esto es el **principio de explosión** (*ex falso quodlibet*): $\bot \models \sigma$ para toda $\sigma$. De una base de conocimiento inconsistente se sigue todo — que el jefe de gobierno es espía, que no lo es, y que Smullyan es un delfín.

**Nota técnica.** No existe ninguna refutación que *use* la cláusula 3: el predicado $Esp\acute{\imath}a$ aparece sólo ahí, con un único signo, así que no tiene con quién resolver. La moraleja práctica es que el valor de una demostración por resolución depende de que las premisas sean consistentes; un bug que deja basura en la base (como el del enunciado) destruye toda garantía del sistema.

**Chuleta**
> 1. La base guarda $\{Pag\acute{o}(smullyan)\}$ y $\{\neg Pag\acute{o}(smullyan)\}$ → resuelven en un paso a $\Box$.
> 2. Como $\Gamma$ ya es insatisfacible, $\Gamma \cup \{\neg\sigma\}$ lo es para toda $\sigma$ ⟹ se prueba cualquier cosa (*ex falso quodlibet*).
> 3. La cláusula del objetivo negado ni se usa: es la señal de que el "teorema" sale de una inconsistencia, no de las premisas relevantes.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 9 — Validez lógica y Resolución (LPO)

**Enunciado**
¿Cuáles de las siguientes fórmulas son lógicamente válidas? Demostrar las que lo sean usando resolución.

I. $[\exists X. \forall Y. R(X, Y)] \Rightarrow \forall Y. \exists X. R(X, Y)$
II. $[\forall X. \exists Y. R(X, Y)] \Rightarrow \exists Y. \forall X. R(X, Y)$
III. $\exists X. [P(X) \Rightarrow \forall X. P(X)]$
IV. $\exists X. [P(X) \vee Q(X)] \Rightarrow [\exists X. P(X) \vee \exists X. Q(X)]$
V. $\forall X. [P(X) \vee Q(X)] \Rightarrow [\forall X. P(X) \vee \forall X. Q(X)]$
VI. $[\exists X. P(X) \wedge \forall X. Q(X)] \Rightarrow \exists X. [P(X) \wedge Q(X)]$
VII. $\forall X. \exists Y. \forall Z. \exists W. [P(X, Y) \vee \neg P(W, Z)]$
VIII. $\forall X. \forall Y. \forall Z. ([\neg P(f(a)) \vee \neg P(Y) \vee Q(Y)] \wedge P(f(Z)) \wedge [\neg P(f(f(X))) \vee \neg Q(f(X))])$

**Explicacion**
Estudio de la validez de fórmulas de LPO. La resolución se aplica sobre la negación de la implicación.

**Resolucion paso a paso**
**Resumen.** Son lógicamente válidas **I, III, IV, VI y VII**. No lo son **II, V** ni **VIII** (esta última es, de hecho, *insatisfacible*).

---

**I.** $[\exists X. \forall Y. R(X,Y)] \Rightarrow \forall Y. \exists X. R(X,Y)$ — **VÁLIDA**

Negación: $\exists X\forall Y. R(X,Y) \ \wedge\ \exists Y \forall X. \neg R(X,Y)$ (ya en NNF).
Skolemizar: $X := a$ en el primer conjunto, $Y := b$ en el segundo.

| # | Cláusula |
|---|---|
| 1 | $\{R(a, Y)\}$ |
| 2 | $\{\neg R(X, b)\}$ |

De 1 y 2 con $mgu = \{Y := b,\ X := a\}$: $\Box$ $\blacksquare$

**II.** $[\forall X. \exists Y. R(X,Y)] \Rightarrow \exists Y. \forall X. R(X,Y)$ — **NO VÁLIDA**

Contramodelo: universo $\mathbb{N}$, $R(x,y) :=$ "$y > x$". Todo $x$ tiene alguien mayor, pero no hay un $y$ mayor que todos.

Con resolución se ve por qué no sale: cláusulas 1. $\{R(X, f(X))\}$ y 2. $\{\neg R(g(Y), Y)\}$. Para resolver habría que unificar $R(X, f(X))$ con $R(g(Y), Y)$:
$$X = g(Y),\qquad f(X) = Y \ \Longrightarrow\ Y = f(g(Y))$$
que falla por **occurs-check**. No hay resolventes: el conjunto está saturado sin $\Box$.

**III.** $\exists X. [P(X) \Rightarrow \forall X. P(X)]$ — **VÁLIDA**

Primero se renombra la variable ligada interna para evitar la captura: $\exists X. [P(X) \Rightarrow \forall Z. P(Z)]$.

Negación y NNF: $\forall X. [P(X) \wedge \exists Z. \neg P(Z)]$. Prenexa: $\forall X \exists Z. (P(X) \wedge \neg P(Z))$. Skolemizar $Z := f(X)$:

| # | Cláusula |
|---|---|
| 1 | $\{P(X)\}$ |
| 2 | $\{\neg P(f(Y))\}$ |

De 1 y 2 con $mgu = \{X := f(Y)\}$: $\Box$ $\blacksquare$

**IV.** $\exists X.[P(X) \vee Q(X)] \Rightarrow [\exists X. P(X) \vee \exists X. Q(X)]$ — **VÁLIDA**

Negación: $\exists X (P(X) \vee Q(X)) \wedge \forall X \neg P(X) \wedge \forall X \neg Q(X)$. Skolemizar $X := a$ en el primero:

| # | Cláusula |
|---|---|
| 1 | $\{P(a), Q(a)\}$ |
| 2 | $\{\neg P(X)\}$ |
| 3 | $\{\neg Q(Y)\}$ |

- De 1 y 2, $mgu=\{X := a\}$: 4. $\{Q(a)\}$
- De 4 y 3, $mgu=\{Y := a\}$: $\Box$ $\blacksquare$

**V.** $\forall X.[P(X) \vee Q(X)] \Rightarrow [\forall X. P(X) \vee \forall X. Q(X)]$ — **NO VÁLIDA**

Contramodelo: universo $\{1,2\}$, $P = \{1\}$, $Q = \{2\}$. Todo elemento cumple $P$ o $Q$, pero ni todos cumplen $P$ ni todos cumplen $Q$.

Cláusulas de la negación: 1. $\{P(X), Q(X)\}$, 2. $\{\neg P(a)\}$, 3. $\{\neg Q(b)\}$ — con **dos constantes de Skolem distintas**, porque los dos $\exists$ vienen de cuantificadores independientes. Resolventes posibles: $\{Q(a)\}$ (de 1 y 2) y $\{P(b)\}$ (de 1 y 3), y ahí se satura: $Q(a)$ no unifica con $Q(b)$ ni $P(b)$ con $P(a)$. Nunca se llega a $\Box$.

> El error típico es skolemizar ambos con la misma constante: eso "demostraría" una fórmula falsa.

**VI.** $[\exists X. P(X) \wedge \forall X. Q(X)] \Rightarrow \exists X.[P(X) \wedge Q(X)]$ — **VÁLIDA**

Negación: $\exists X P(X) \wedge \forall X Q(X) \wedge \forall X \neg(P(X) \wedge Q(X))$. Skolemizando $X := a$ en el primero:

| # | Cláusula |
|---|---|
| 1 | $\{P(a)\}$ |
| 2 | $\{Q(X)\}$ |
| 3 | $\{\neg P(Y), \neg Q(Y)\}$ |

- De 1 y 3, $mgu = \{Y := a\}$: 4. $\{\neg Q(a)\}$
- De 4 y 2, $mgu = \{X := a\}$: $\Box$ $\blacksquare$

**VII.** $\forall X. \exists Y. \forall Z. \exists W.\ [P(X,Y) \vee \neg P(W,Z)]$ — **VÁLIDA**

*Intuición:* dado $X$, si existe algún $Y$ con $P(X,Y)$, se elige ése y el disyunto izquierdo alcanza. Si no existe (o sea $\forall Y. \neg P(X,Y)$), se toma $W := X$ y $\neg P(X,Z)$ vale para todo $Z$.

Negación: $\exists X \forall Y \exists Z \forall W.\ [\neg P(X,Y) \wedge P(W,Z)]$. Skolemizar $X := a$ y $Z := g(Y)$:

| # | Cláusula |
|---|---|
| 1 | $\{\neg P(a, Y)\}$ |
| 2 | $\{P(W, g(Y'))\}$ |

De 1 y 2, unificando $P(a,Y)$ con $P(W, g(Y'))$: $mgu = \{W := a,\ Y := g(Y')\}$ → $\Box$ $\blacksquare$

**VIII.** $\forall X \forall Y \forall Z\ ([\neg P(f(a)) \vee \neg P(Y) \vee Q(Y)] \wedge P(f(Z)) \wedge [\neg P(f(f(X))) \vee \neg Q(f(X))])$ — **NO VÁLIDA**

Es una conjunción de cláusulas universalmente cuantificada, así que su forma clausal es ella misma:

| # | Cláusula |
|---|---|
| 1 | $\{\neg P(f(a)),\ \neg P(Y),\ Q(Y)\}$ |
| 2 | $\{P(f(Z))\}$ |
| 3 | $\{\neg P(f(f(X))),\ \neg Q(f(X))\}$ |

Más aún: la fórmula es **insatisfacible** (es su *negación* la que resulta válida). Resolviendo sobre sus propias cláusulas:

- De 2 y 3, $mgu = \{Z := f(X)\}$: 4. $\{\neg Q(f(X))\}$
- De 2 y 1 (sobre $\neg P(f(a))$), $mgu = \{Z := a\}$: 5. $\{\neg P(Y), Q(Y)\}$
- De 5 y 2, $mgu = \{Y := f(Z')\}$: 6. $\{Q(f(Z'))\}$
- De 6 y 4, $mgu = \{X := Z'\}$: $\Box$

*Lectura semántica del argumento:* la cláusula 2 obliga a que $P$ valga en toda imagen de $f$; entonces 3 obliga a $\neg Q(f(X))$ para todo $X$, y 1 obliga a $Q(f(a))$. Contradicción. Como no tiene ningún modelo, en particular no es válida.

**Chuleta**
> 1. Validez de $\phi$ ⟺ $\neg\phi$ insatisfacible. Negar, NNF, prenexa, **skolemizar** (constantes/funciones nuevas y distintas por cada $\exists$), clausal, buscar $\Box$.
> 2. Válidas: I ($\exists\forall \Rightarrow \forall\exists$ sí), III (paradoja del bebedor), IV ($\exists$ distribuye sobre $\vee$), VI, VII.
> 3. No válidas: II ($\forall\exists \not\Rightarrow \exists\forall$; falla el occurs-check), V ($\forall$ **no** distribuye sobre $\vee$; dos constantes de Skolem distintas), VIII (insatisfacible).
> Señal de "no válida": el conjunto de cláusulas se satura sin $\Box$ ⟹ leer el contramodelo.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_por_contradiccion]]

---

### Ejercicio 10 — Aplicaciones del método de resolución

**Enunciado**
I. Expresar en forma clausal la regla del *modus ponens* y mostrar que es válida, usando resolución.
II. Lo mismo para la regla del *modus tollens*.
III. Lo mismo para la regla de especialización: de $\forall X. P(X)$ concluir $P(t)$ cualquiera sea el término $t$.

**Explicacion**
Validación de reglas de inferencia clásicas mediante el marco de resolución.

**Resolucion paso a paso**
**I. Modus ponens:** de $P$ y $P \Rightarrow Q$ concluir $Q$.

Validez ⟺ $[P \wedge (P \Rightarrow Q)] \Rightarrow Q$ es tautología. Forma clausal de premisas + conclusión negada:

| # | Origen | Cláusula |
|---|---|---|
| 1 | $P$ | $\{P\}$ |
| 2 | $P \Rightarrow Q$ | $\{\neg P, Q\}$ |
| 3 | $\neg Q$ | $\{\neg Q\}$ |

- De 1 y 2 (sobre $P$): 4. $\{Q\}$
- De 4 y 3: $\Box$ $\blacksquare$

Observar que el paso 1–2 **es** el modus ponens: la regla de resolución es una generalización directa de MP.

**II. Modus tollens:** de $P \Rightarrow Q$ y $\neg Q$ concluir $\neg P$.

| # | Origen | Cláusula |
|---|---|---|
| 1 | $P \Rightarrow Q$ | $\{\neg P, Q\}$ |
| 2 | $\neg Q$ | $\{\neg Q\}$ |
| 3 | $\neg\neg P$ (conclusión negada) | $\{P\}$ |

- De 1 y 2 (sobre $Q$): 4. $\{\neg P\}$
- De 4 y 3: $\Box$ $\blacksquare$

MP y MT usan **la misma cláusula** $\{\neg P, Q\}$: en forma clausal la asimetría entre ambas reglas desaparece, porque una cláusula no distingue antecedente de consecuente.

**III. Especialización:** de $\forall X. P(X)$ concluir $P(t)$, para cualquier término $t$.

| # | Origen | Cláusula |
|---|---|---|
| 1 | $\forall X. P(X)$ | $\{P(X)\}$ |
| 2 | $\neg P(t)$ | $\{\neg P(t)\}$ |

De 1 y 2 con $mgu = \{X := t\}$: $\Box$ $\blacksquare$

*Detalle:* si $t$ contiene variables, al negar la conclusión $\forall (\ldots) P(t)$ esas variables se vuelven existenciales y se skolemizan, quedando términos cerrados; en cualquier caso $X$ (variable universal, libre en la cláusula) unifica con $t$ sin problemas. La regla de especialización está **incorporada en la unificación** de la regla de resolución de primer orden: no hace falta un paso aparte de instanciación.

**Chuleta**
> 1. MP: $\{P\}$ + $\{\neg P, Q\}$ → $\{Q\}$; con $\{\neg Q\}$ → $\Box$. La resolución *es* MP generalizado.
> 2. MT: $\{\neg P, Q\}$ + $\{\neg Q\}$ → $\{\neg P\}$; con $\{P\}$ → $\Box$. Misma cláusula que MP.
> 3. Especialización: $\{P(X)\}$ + $\{\neg P(t)\}$ con $mgu=\{X := t\}$ → $\Box$. La instanciación viene gratis con el mgu.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_por_contradiccion]]

---

### Ejercicio 11 — Cláusulas de Horn

**Enunciado**
Dadas las siguientes cláusulas:
- $\{P(X), \neg P(X), Q(a)\}$
- $\{P(X), \neg Q(Y), \neg R(X, Y)\}$
- $\{\neg P(X, X, Z), \neg Q(X, Y), \neg Q(Y, Z)\}$
- $\{M(1, 2, X)\}$

I. ¿Cuáles son cláusulas de Horn?
II. Para cada cláusula de Horn indicar si es una cláusula de definición (hecho o regla) o una cláusula objetivo.
III. Dar, para cada cláusula, la fórmula de primer orden que le corresponde.

**Explicacion**
Una cláusula de Horn tiene a lo sumo un literal positivo.
- Hecho: 1 literal positivo, 0 negativos.
- Regla: 1 literal positivo, $\geq 1$ negativos.
- Objetivo (Query): 0 literales positivos, $\geq 1$ negativos.

**Resolucion paso a paso**
**I. ¿Cuáles son cláusulas de Horn?** (a lo sumo **un** literal positivo)

| Cláusula | Literales positivos | ¿Horn? |
|---|---|---|
| $\{P(X), \neg P(X), Q(a)\}$ | $P(X)$ y $Q(a)$ → **2** | ❌ No |
| $\{P(X), \neg Q(Y), \neg R(X,Y)\}$ | $P(X)$ → 1 | ✅ Sí |
| $\{\neg P(X,X,Z), \neg Q(X,Y), \neg Q(Y,Z)\}$ | ninguno → 0 | ✅ Sí |
| $\{M(1,2,X)\}$ | $M(1,2,X)$ → 1 | ✅ Sí |

**II. Clasificación de las de Horn**

| Cláusula | Positivos / Negativos | Tipo |
|---|---|---|
| $\{P(X), \neg Q(Y), \neg R(X,Y)\}$ | 1 / 2 | **Definición — regla** |
| $\{\neg P(X,X,Z), \neg Q(X,Y), \neg Q(Y,Z)\}$ | 0 / 3 | **Objetivo** (*goal*) |
| $\{M(1,2,X)\}$ | 1 / 0 | **Definición — hecho** |

**III. Fórmula de primer orden correspondiente**

Recordar que una cláusula es la clausura universal de la disyunción de sus literales.

**(a)** $\{P(X), \neg P(X), Q(a)\}$:
$$\forall X.\ (P(X) \vee \neg P(X) \vee Q(a))$$
Es una **tautología** (contiene un par complementario) — inútil como premisa, y además no es de Horn.

**(b)** $\{P(X), \neg Q(Y), \neg R(X,Y)\}$:
$$\forall X \forall Y.\ (P(X) \vee \neg Q(Y) \vee \neg R(X,Y))\ \equiv\ \forall X \forall Y.\ ((Q(Y) \wedge R(X,Y)) \Rightarrow P(X))$$
En Prolog: `p(X) :- q(Y), r(X,Y).`

**(c)** $\{\neg P(X,X,Z), \neg Q(X,Y), \neg Q(Y,Z)\}$:
$$\forall X \forall Y \forall Z.\ (\neg P(X,X,Z) \vee \neg Q(X,Y) \vee \neg Q(Y,Z))\ \equiv\ \forall X\forall Y\forall Z.\ \neg(P(X,X,Z) \wedge Q(X,Y) \wedge Q(Y,Z))$$
Equivalentemente, es la negación de $\exists X\exists Y\exists Z. (P(X,X,Z) \wedge Q(X,Y) \wedge Q(Y,Z))$: exactamente lo que se obtiene al negar la consulta `?- p(X,X,Z), q(X,Y), q(Y,Z).`

**(d)** $\{M(1,2,X)\}$:
$$\forall X.\ M(1,2,X)$$
En Prolog: `m(1,2,X).` — un hecho con una variable universal.

**Chuleta**
> 1. Contar literales **positivos**: $\leq 1$ ⟹ Horn.
> 2. 1 positivo y 0 negativos = **hecho**; 1 positivo y $\geq 1$ negativos = **regla**; 0 positivos = **objetivo**.
> 3. Traducción: $\{A, \neg B_1, \ldots, \neg B_n\} \equiv \forall \vec{X}. ((B_1 \wedge \cdots \wedge B_n) \Rightarrow A)$; $\{\neg B_1, \ldots, \neg B_n\} \equiv \forall \vec{X}. \neg(B_1 \wedge \cdots \wedge B_n)$ = negación de la consulta.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_sld_justificacion]]

---

### Ejercicio 12 — Resolución SLD

**Enunciado**
Indicar cuáles de las siguientes condiciones son necesarias para que una demostración por resolución sea SLD.
- Realizarse de manera lineal (utilizando en cada paso el resolvente obtenido en el paso anterior).
- Utilizar únicamente cláusulas de Horn.
- Utilizar cada cláusula a lo sumo una vez.
- Empezar por una cláusula objetivo (sin literales positivos).
- Empezar por una cláusula que provenga de la negación de lo que se quiere demostrar.
- Recorrer el espacio de búsqueda de arriba hacia abajo y de izquierda a derecha.
- Utilizar la regla de resolución binaria en lugar de la general.

**Explicacion**
SLD (Selected Linear Resolution for Definite clauses) es el motor de Prolog. Es lineal, sobre cláusulas de Horn, empieza por el goal y es completa para este fragmento.

**Resolucion paso a paso**
| Condición | ¿Necesaria? | Justificación |
|---|---|---|
| Realizarse de manera **lineal** (usar en cada paso el resolvente anterior) | ✅ **Sí** | Es la **L** de SLD. Cada paso resuelve el objetivo actual $N_i$ contra una cláusula del programa, produciendo $N_{i+1}$. Nunca se resuelven entre sí dos cláusulas del programa. |
| Utilizar únicamente **cláusulas de Horn** | ✅ **Sí** | Es la **D** (*definite*). El programa debe ser de cláusulas de definición (exactamente un literal positivo) y el objetivo una cláusula sin positivos. Si alguna cláusula tuviera dos positivos, la resolvente podría dejar de ser un objetivo y se rompe el esquema. |
| Utilizar **cada cláusula a lo sumo una vez** | ❌ **No** | Al contrario: la recursión exige reusar la misma cláusula muchas veces (ej.: `natural(suc(X)) :- natural(X).`). Sólo hay que renombrar las variables en cada uso. |
| **Empezar por una cláusula objetivo** (sin literales positivos) | ✅ **Sí** | La derivación arranca en $N_0$, que debe ser negativa. Si no hubiera ninguna cláusula objetivo, el conjunto sería satisfacible (basta interpretar todo predicado como verdadero) y no habría nada que refutar. |
| Empezar por una cláusula que provenga de la **negación de lo que se quiere demostrar** | ❌ **No** | Lo que se exige es que $N_0$ sea *una* cláusula objetivo, no necesariamente la que vino de negar la tesis. Ver el **Ej. 19**: la refutación SLD arranca en $\{\neg R(X,X)\}$ (la irreflexividad, que es una premisa) mientras que la negación de la tesis es el **hecho** $\{R(a,b)\}$. |
| Recorrer el espacio de búsqueda **de arriba hacia abajo y de izquierda a derecha** | ❌ **No** | Eso es la estrategia de búsqueda concreta de **Prolog** (orden textual de las cláusulas + DFS + selección del primer literal), no parte de la definición de SLD. SLD deja libres la **regla de selección** del literal y el **orden de búsqueda**; de hecho SLD es completo para Horn, mientras que Prolog no lo es (ver Ej. 20, 23 y 25). |
| Utilizar la regla de **resolución binaria** en lugar de la general | ✅ **Sí** | En cada paso SLD se resuelve **un** literal seleccionado del objetivo contra **el** (único) literal positivo — la cabeza — de la cláusula de definición: un literal de cada lado. No hace falta la regla general ni la factorización, porque para cláusulas de Horn la resolución SLD ya es refutacionalmente completa. |

**Resumen:** necesarias 1, 2, 4 y 7. No necesarias 3, 5 y 6.

**Chuleta**
> **SLD = Selección + Lineal + Definite.** Necesario: linealidad, sólo Horn, arrancar en *alguna* cláusula objetivo, y resolver un literal contra la cabeza (binaria).
> **No** necesario: usar cada cláusula una sola vez (la recursión las reusa), que el objetivo inicial venga de negar la tesis, ni el orden arriba-abajo / izquierda-derecha (eso es **Prolog**, no SLD).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_sld_justificacion]]

---

### Ejercicio 13 — Alan el robot (SLD)

**Enunciado**
Alan es un robot japonés. Cualquier robot que puede resolver un problema lógico es inteligente. Todos los robots japoneses pueden resolver todos los problemas de esta práctica. Todos los problemas de esta práctica son lógicos. Existe al menos un problema en esta práctica. ¿Quién es inteligente? Encontrarlo utilizando resolución SLD y composición de sustituciones.
Utilizar los siguientes predicados y constantes: $R(X)$ para expresar que $X$ es un robot, $Res(X, Y)$ para $X$ puede resolver $Y$, $PL(X)$ para $X$ es un problema lógico, $Pr(X)$ para $X$ es un problema de esta práctica, $I(X)$ para $X$ es inteligente, $J(X)$ para $X$ es japonés y la constante **alan** para Alan.

**Explicacion**
Modelado y ejecución de una traza SLD (similar a cómo funcionaría en Prolog) para encontrar una respuesta (answer extraction).

**Resolucion paso a paso**
**Formalización y forma clausal**

| Enunciado | Fórmula | Cláusula |
|---|---|---|
| Alan es un robot japonés | $R(alan) \wedge J(alan)$ | 1. $\{R(alan)\}$ · 2. $\{J(alan)\}$ |
| Todo robot que puede resolver un problema lógico es inteligente | $\forall X \forall Y.((R(X) \wedge PL(Y) \wedge Res(X,Y)) \Rightarrow I(X))$ | 3. $\{\neg R(X), \neg PL(Y), \neg Res(X,Y), I(X)\}$ |
| Todo robot japonés resuelve todos los problemas de esta práctica | $\forall X \forall Y.((R(X) \wedge J(X) \wedge Pr(Y)) \Rightarrow Res(X,Y))$ | 4. $\{\neg R(X), \neg J(X), \neg Pr(Y), Res(X,Y)\}$ |
| Todo problema de esta práctica es lógico | $\forall X.(Pr(X) \Rightarrow PL(X))$ | 5. $\{\neg Pr(X), PL(X)\}$ |
| Existe al menos un problema en esta práctica | $\exists X. Pr(X)$ → Skolem $p$ | 6. $\{Pr(p)\}$ |

Todas son cláusulas de definición (un literal positivo) ⟹ se puede usar **SLD**.

**Consulta:** ¿quién es inteligente? $\exists X. I(X)$. Objetivo inicial (negación):
$$N_0 = \{\neg I(X_0)\}$$

**Derivación SLD**

| Paso | Objetivo | Cláusula usada | mgu |
|---|---|---|---|
| 0 | $\{\neg I(X_0)\}$ | 3 (cabeza $I(X)$) | $\sigma_1 = \{X := X_0\}$ |
| 1 | $\{\neg R(X_0),\ \neg PL(Y),\ \neg Res(X_0,Y)\}$ | 1 | $\sigma_2 = \{X_0 := alan\}$ |
| 2 | $\{\neg PL(Y),\ \neg Res(alan, Y)\}$ | 5 (cabeza $PL(X)$) | $\sigma_3 = \{X := Y\}$ |
| 3 | $\{\neg Pr(Y),\ \neg Res(alan, Y)\}$ | 6 | $\sigma_4 = \{Y := p\}$ |
| 4 | $\{\neg Res(alan, p)\}$ | 4 (cabeza $Res(X,Y')$) | $\sigma_5 = \{X := alan,\ Y' := p\}$ |
| 5 | $\{\neg R(alan),\ \neg J(alan),\ \neg Pr(p)\}$ | 1 | $\sigma_6 = id$ |
| 6 | $\{\neg J(alan),\ \neg Pr(p)\}$ | 2 | $\sigma_7 = id$ |
| 7 | $\{\neg Pr(p)\}$ | 6 | $\sigma_8 = id$ |
| 8 | $\Box$ | — | — |

**Composición de sustituciones.** La sustitución respuesta es $\sigma_1 \sigma_2 \cdots \sigma_8$ restringida a la variable de la consulta:
$$\sigma = \{X_0 := alan\}$$

**Respuesta: Alan es inteligente.** $\blacksquare$

*Lectura del argumento:* Alan es robot y japonés → resuelve todos los problemas de la práctica → existe uno ($p$) → ese problema es lógico → Alan es un robot que resuelve un problema lógico → es inteligente. Notar que la premisa "existe al menos un problema en esta práctica" es **imprescindible**: sin la constante de Skolem $p$ no habría con qué instanciar $Y$ y la derivación se traba.

**Chuleta**
> 1. Modelar y clausalizar; el $\exists$ de "existe al menos un problema" → constante de Skolem $p$.
> 2. $N_0 = \{\neg I(X_0)\}$ → regla de inteligencia → $\{\neg R, \neg PL, \neg Res\}$ → $R(alan)$ fija $X_0 := alan$ → $PL$ vía "los de la práctica son lógicos" → $Pr(p)$ → $Res(alan,p)$ vía "japoneses resuelven todo" → descargar $R$, $J$, $Pr$ → $\Box$.
> 3. Componer los mgu y restringir a $X_0$: **$X_0 := alan$**.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 14 — Suma y Paridad (SLD)

**Enunciado**
Sean las siguientes cláusulas (en forma clausal), donde **suma** y **par** son predicados, **suc** es una función y **cero** una constante:
1. $\{\neg suma(X, Y, Z), suma(X, suc(Y), suc(Z))\}$
2. $\{suma(X, cero, X)\}$
3. $\{\neg suma(X, X, Y), par(Y)\}$
Demostrar utilizando resolución que suponiendo (1), (2), (3) se puede probar $par(suc(suc(cero)))$. Si es posible, aplicar resolución SLD. En caso contrario, utilizar resolución general. Mostrar en cada aplicación de la regla de resolución la sustitución utilizada.

**Explicacion**
Traza de resolución para un sistema aritmético simple.

**Resolucion paso a paso**
**Cláusulas**

| # | Cláusula | Tipo |
|---|---|---|
| 1 | $\{\neg suma(X,Y,Z),\ suma(X, suc(Y), suc(Z))\}$ | regla |
| 2 | $\{suma(X, cero, X)\}$ | hecho |
| 3 | $\{\neg suma(X,X,Y),\ par(Y)\}$ | regla |

Las tres tienen exactamente un literal positivo ⟹ son cláusulas de definición. Negando lo que se quiere probar, $\neg par(suc(suc(cero)))$, se obtiene una cláusula objetivo ⟹ **se puede aplicar resolución SLD**.

$$N_0 = \{\neg par(suc(suc(cero)))\}$$

**Derivación SLD**

**Paso 1** — $N_0$ con la cláusula 3 (cabeza $par(Y)$):
$$mgu:\quad par(Y) = par(suc(suc(cero))) \ \Rightarrow\ \sigma_1 = \{Y := suc(suc(cero))\}$$
$$N_1 = \{\neg suma(X,\ X,\ suc(suc(cero)))\}$$

**Paso 2** — $N_1$ con la cláusula 1 (cabeza $suma(X_1, suc(Y_1), suc(Z_1))$, variables renombradas):
$$suma(X, X, suc(suc(cero))) \ =\ suma(X_1, suc(Y_1), suc(Z_1))$$
Descomponiendo: $X_1 = X$, $X = suc(Y_1)$, $suc(suc(cero)) = suc(Z_1) \Rightarrow Z_1 = suc(cero)$.
$$\sigma_2 = \{X := suc(Y_1),\ X_1 := suc(Y_1),\ Z_1 := suc(cero)\}$$
$$N_2 = \{\neg suma(suc(Y_1),\ Y_1,\ suc(cero))\}$$

**Paso 3** — $N_2$ con la cláusula 2 (cabeza $suma(X_2, cero, X_2)$):
$$suma(suc(Y_1), Y_1, suc(cero)) = suma(X_2, cero, X_2)$$
Descomponiendo: $X_2 = suc(Y_1)$, $Y_1 = cero$, $X_2 = suc(cero)$ — consistente, con
$$\sigma_3 = \{Y_1 := cero,\ X_2 := suc(cero)\}$$
$$N_3 = \Box \qquad \blacksquare$$

**Verificación aritmética.** La derivación instancia $X := suc(cero)$ en el paso 2, es decir usa $suma(1,1,2)$: primero $1 + 0 = 1$ (hecho, cláusula 2), luego la regla 1 sube a $1 + 1 = 2$, y la regla 3 concluye $par(2)$ porque $2 = 1 + 1$ es la suma de un número consigo mismo. Efectivamente $par(suc(suc(cero)))$ vale.

**Sobre el método.** Es SLD en sentido estricto: cada $N_{i+1}$ se obtiene resolviendo el objetivo $N_i$ (siempre unitario, así que la regla de selección es trivial) contra una cláusula de definición del programa. Además es el orden que hubiera seguido Prolog, ya que en cada paso hay una única cláusula cuya cabeza unifica.

**Chuleta**
> 1. Las 3 cláusulas son de definición y el objetivo es negativo ⟹ **SLD**.
> 2. $\{\neg par(suc^2(cero))\}$ →(3) $\{\neg suma(X,X,suc^2(cero))\}$ →(1, $X := suc(Y_1)$, $Z_1 := suc(cero)$) $\{\neg suma(suc(Y_1),Y_1,suc(cero))\}$ →(2, $Y_1 := cero$) $\Box$.
> 3. Leído en aritmética: $1+0=1$, luego $1+1=2$, luego $par(2)$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 15 — Forma Clausal y SLD

**Enunciado**
I. Pasar las siguientes fórmulas en lógica de primer orden a forma clausal.
a) $\forall C. (V(C) \vee \exists E. P(E, C))$
b) $\neg \exists C. (V(C) \wedge \exists E. P(E, C))$
c) $\forall E. \forall C. (P(E, i(C)) \Leftrightarrow P(E, C))$

II. A partir de las cláusulas definidas en el punto anterior, ¿puede demostrarse $\forall C. (V(i(C)) \Rightarrow V(C))$ usando resolución SLD? Si se puede, hacerlo. Si no, demostrarlo usando el método de resolución general.

**Explicacion**
Combinación de skolemización compleja y elección del método de resolución adecuado (SLD vs General) según la forma de las cláusulas (Horn vs no-Horn).

**Resolucion paso a paso**
**I. Pasaje a forma clausal**

**a)** $\forall C.\ (V(C) \vee \exists E.\ P(E,C))$
1. Ya está en NNF. Prenexa: $\forall C \exists E.\ (V(C) \vee P(E,C))$
2. Skolemizar ($\exists E$ bajo $\forall C$ ⟹ función $f$): $\forall C.\ (V(C) \vee P(f(C), C))$
3. Cláusula:
$$1.\quad \{V(C),\ P(f(C), C)\}$$

**b)** $\neg\exists C.\ (V(C) \wedge \exists E.\ P(E,C))$
1. NNF: $\forall C.\ (\neg V(C) \vee \neg \exists E.\ P(E,C)) \equiv \forall C \forall E.\ (\neg V(C) \vee \neg P(E,C))$
2. No hay $\exists$ ⟹ nada que skolemizar.
$$2.\quad \{\neg V(C),\ \neg P(E,C)\}$$

**c)** $\forall E \forall C.\ (P(E, i(C)) \Leftrightarrow P(E,C))$
1. Eliminar $\Leftrightarrow$: $\forall E \forall C.\ ((P(E,i(C)) \Rightarrow P(E,C)) \wedge (P(E,C) \Rightarrow P(E,i(C))))$
2. Eliminar $\Rightarrow$ y separar la conjunción:
$$3.\quad \{\neg P(E, i(C)),\ P(E,C)\} \qquad 4.\quad \{\neg P(E,C),\ P(E, i(C))\}$$

**II. ¿Se puede demostrar $\forall C.(V(i(C)) \Rightarrow V(C))$ con SLD?**

**No.** La cláusula 1, $\{V(C),\ P(f(C),C)\}$, tiene **dos literales positivos**: no es de Horn. SLD exige que *todas* las cláusulas de definición tengan exactamente un literal positivo, así que el método no es aplicable. Hay que usar **resolución general**.

**Negación de la tesis:** $\neg\forall C.(V(i(C)) \Rightarrow V(C)) \equiv \exists C.(V(i(C)) \wedge \neg V(C))$. Skolemizando $C := a$:
$$5.\quad \{V(i(a))\} \qquad\qquad 6.\quad \{\neg V(a)\}$$

**Refutación por resolución general**

| Paso | Cláusulas | mgu | Resolvente |
|---|---|---|---|
| i | 6 y 1 (sobre $V$) | $\{C := a\}$ | 7. $\{P(f(a),\ a)\}$ |
| ii | 7 y 4 (sobre $P(E,C)$) | $\{E := f(a),\ C := a\}$ | 8. $\{P(f(a),\ i(a))\}$ |
| iii | 8 y 2 (sobre $P(E,C)$) | $\{E := f(a),\ C := i(a)\}$ | 9. $\{\neg V(i(a))\}$ |
| iv | 9 y 5 | $id$ | $\Box$ |

$\blacksquare$

**Lectura del argumento.** Si $a$ no cumple $V$, por la cláusula 1 debe existir un $E = f(a)$ con $P(f(a), a)$. Por (c) esa propiedad se traslada de $C$ a $i(C)$, o sea $P(f(a), i(a))$. Pero (b) dice que nada puede cumplir $V$ y tener un $P$ asociado, así que $\neg V(i(a))$ — contradiciendo la hipótesis $V(i(a))$.

**¿Por qué no es SLD, más allá de la forma de las cláusulas?** Además de que 1 no es de Horn, el primer paso resuelve el objetivo 6 contra 1 produciendo un resolvente **positivo** ($\{P(f(a),a)\}$), que ya no es una cláusula objetivo: se rompe el invariante de SLD "objetivo + definición ⟹ objetivo". La derivación sí es **lineal** (cada paso usa el resolvente anterior), pero linealidad no alcanza para ser SLD.

**Chuleta**
> 1. Clausal: (a) $\{V(C), P(f(C),C)\}$ — Skolem $f$; (b) $\{\neg V(C), \neg P(E,C)\}$; (c) $\Leftrightarrow$ se parte en dos: $\{\neg P(E,i(C)), P(E,C)\}$ y $\{\neg P(E,C), P(E,i(C))\}$.
> 2. **No es SLD**: la cláusula (a) tiene dos positivos ⟹ no es de Horn.
> 3. General: negar tesis → $\{V(i(a))\}$, $\{\neg V(a)\}$; luego $\{\neg V(a)\}+$(a) → $\{P(f(a),a)\}$ → (c$_2$) → $\{P(f(a),i(a))\}$ → (b) → $\{\neg V(i(a))\}$ → $\Box$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_sld_justificacion]]

---

### Ejercicio 16 — El Teorema del Bebedor

**Enunciado**
Un lógico estaba sentado en un bar cuando se le ocurrió usar el método de resolución para demostrar el teorema del bebedor: siempre que haya alguien en el bar, habrá allí alguien tal que, si está bebiendo, todos en el bar están bebiendo. Sin embargo, el lógico en cuestión había bebido demasiado y la prueba no le salió muy bien. Esto fue lo que escribió en una servilleta del bar:

Teorema del bebedor: $(\exists X. enBar(X)) \Rightarrow \exists Y. (enBar(Y) \wedge (bebe(Y) \Rightarrow \forall Z. (enBar(Z) \Rightarrow bebe(Z))))$
Elimino implicaciones: $(\neg \exists X. enBar(X)) \vee \exists Y. (enBar(Y) \wedge (\neg bebe(Y) \vee \forall Z. (\neg enBar(Z) \vee bebe(Z))))$
Skolemizo: $(\neg enBar(c)) \vee (enBar(k) \wedge (\neg bebe(k) \vee \forall Z. (\neg enBar(Z) \vee bebe(Z))))$
Paso a Forma Clausal:
1. $\{\neg enBar(c)\}$
2. $\{enBar(k)\}$
3. $\{\neg bebe(k)\}$
4. $\{\neg enBar(Z), bebe(Z)\}$

Aplico resolución:
De 3 y 4 con $\sigma = \{k \leftarrow Z\}$:
5. $\{\neg enBar(Z)\}$
De 5 y 1 con $\sigma = \{Z \leftarrow c\}$:
$\Box$

a) Identificar los 5 errores cometidos en la demostración. (La fórmula original es correcta, notar que salteó pasos importantes e hizo mal otros).
b) Demostrar el teorema de manera correcta, usando resolución.
c) Indicar si la resolución utilizada en el punto b) es o no SLD. Justificar.

**Explicacion**
Análisis crítico de una transformación a forma clausal y una prueba. El teorema del bebedor es una tautología clásica de LPO.

**Resolucion paso a paso**
**a) Los cinco errores**

1. **No negó la fórmula.** La resolución es un método de **refutación**: hay que partir de $\neg\phi$ y derivar $\Box$. El lógico transformó a forma clausal la fórmula *original* — si de ahí saliera $\Box$, habría probado que el teorema es **insatisfacible**, justo lo contrario de lo que quería.

2. **No pasó a NNF.** Dejó $\neg\exists X.\ enBar(X)$ tal cual, sin empujar la negación hacia adentro. Lo correcto es $\forall X.\ \neg enBar(X)$. El paso importa porque decide qué cuantificador queda sobre $X$ y, por lo tanto, si se skolemiza o no.

3. **Skolemizó una variable universal.** Como consecuencia del error anterior, reemplazó la $X$ de $\neg\exists X. enBar(X)$ por la constante $c$. Una vez llevada la negación adentro, esa $X$ está bajo un $\forall$: **los universales no se skolemizan**, quedan como variables libres de la cláusula. Además saltó los pasos de forma prenexa sin justificar que se podían mover los cuantificadores.

4. **Rompió mal la fórmula en cláusulas.** El conectivo principal de la fórmula skolemizada es una **disyunción**:
$$(\neg enBar(c)) \ \vee\ (enBar(k) \wedge (\neg bebe(k) \vee \forall Z.(\ldots)))$$
y él la partió en cuatro cláusulas como si fuera una conjunción. Antes de separar hay que **distribuir $\vee$ sobre $\wedge$** (paso a CNF); las cláusulas correctas tendrían todas el literal $\neg enBar(c)$ adentro.

5. **Sustitución mal aplicada.** Escribió $\sigma = \{k \leftarrow Z\}$, pero $k$ es una **constante de Skolem**, no una variable: sólo se pueden sustituir variables. El mgu de $bebe(k)$ y $bebe(Z)$ es $\{Z := k\}$, y aplicándolo a $\{\neg enBar(Z), bebe(Z)\}$ el resolvente correcto es $\{\neg enBar(k)\}$, **no** $\{\neg enBar(Z)\}$. Con el resolvente correcto el paso siguiente ni siquiera existe: $\{\neg enBar(k)\}$ y $\{\neg enBar(c)\}$ son ambas negativas, no resuelven entre sí.

**b) Demostración correcta**

$$\phi = (\exists X.\ enBar(X)) \Rightarrow \exists Y.\ (enBar(Y) \wedge (bebe(Y) \Rightarrow \forall Z.\ (enBar(Z) \Rightarrow bebe(Z))))$$

1. **Negar:** $\neg\phi = (\exists X. enBar(X)) \wedge \neg\exists Y.(enBar(Y) \wedge (bebe(Y) \Rightarrow \forall Z.(enBar(Z) \Rightarrow bebe(Z))))$
2. **Eliminar $\Rightarrow$ y NNF** en el segundo conjunto:
$$\forall Y.\ \neg\big(enBar(Y) \wedge (\neg bebe(Y) \vee \forall Z.(\neg enBar(Z) \vee bebe(Z)))\big)$$
$$\equiv\ \forall Y.\ \big(\neg enBar(Y) \vee (bebe(Y) \wedge \exists Z.(enBar(Z) \wedge \neg bebe(Z)))\big)$$
3. **Prenexa y skolemización:** el $\exists X$ del primer conjunto no tiene universales por delante ⟹ constante $a$. El $\exists Z$ está bajo $\forall Y$ ⟹ función $g(Y)$:
$$enBar(a)\ \wedge\ \forall Y.\big(\neg enBar(Y) \vee (bebe(Y) \wedge enBar(g(Y)) \wedge \neg bebe(g(Y)))\big)$$
4. **CNF y forma clausal:**

| # | Cláusula | Tipo |
|---|---|---|
| 1 | $\{enBar(a)\}$ | hecho |
| 2 | $\{\neg enBar(Y),\ bebe(Y)\}$ | regla |
| 3 | $\{\neg enBar(Y),\ enBar(g(Y))\}$ | regla |
| 4 | $\{\neg enBar(Y),\ \neg bebe(g(Y))\}$ | **objetivo** |

5. **Refutación** (partiendo de la cláusula objetivo 4):

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg enBar(Y_0),\ \neg bebe(g(Y_0))\}$ | 1 | $\{Y_0 := a\}$ |
| 1 | $\{\neg bebe(g(a))\}$ | 2 (cabeza $bebe(Y)$) | $\{Y := g(a)\}$ |
| 2 | $\{\neg enBar(g(a))\}$ | 3 (cabeza $enBar(g(Y'))$) | $\{Y' := a\}$ |
| 3 | $\{\neg enBar(a)\}$ | 1 | $id$ |
| 4 | $\Box$ | — | — |

$\blacksquare$

*Lectura:* si el teorema fuera falso, para cada persona $Y$ del bar existiría un $g(Y)$ que está en el bar y **no** bebe, y además $Y$ sí bebería. Aplicándolo a $a$ (el que hay en el bar) se obtiene $g(a)$ en el bar; pero entonces $g(a)$ tendría que beber (cláusula 2) y no beber (cláusula 4). Contradicción.

**c) ¿Es SLD?**

**Sí.** Las cuatro cláusulas son de Horn: 1 es un hecho, 2 y 3 son reglas (un literal positivo cada una) y 4 no tiene positivos, o sea es una cláusula objetivo. La derivación de b) arranca en la cláusula objetivo 4, es **lineal** (cada paso usa el objetivo anterior), y en cada paso resuelve **un** literal seleccionado del objetivo contra la cabeza de una cláusula de definición, obteniendo siempre un nuevo objetivo. Cumple todas las condiciones de SLD.

> Notar que $N_0$ (la cláusula 4) proviene de la negación de la tesis — pero eso, como se vio en el **Ej. 12**, no es un requisito, sino una casualidad de este caso.

**Chuleta**
> **Errores:** 1) no negó la fórmula; 2) no pasó a NNF ($\neg\exists X.enBar(X)$ debía ser $\forall X.\neg enBar(X)$); 3) skolemizó una variable universal ($c$); 4) partió una **disyunción** en cláusulas sin distribuir a CNF; 5) $\sigma=\{k \leftarrow Z\}$ sustituye una constante — el mgu es $\{Z := k\}$ y el resolvente $\{\neg enBar(k)\}$.
> **Prueba correcta:** negar → NNF → Skolem ($a$ para $\exists X$, $g(Y)$ para $\exists Z$ bajo $\forall Y$) → cláusulas $\{enBar(a)\}$, $\{\neg enBar(Y), bebe(Y)\}$, $\{\neg enBar(Y), enBar(g(Y))\}$, $\{\neg enBar(Y), \neg bebe(g(Y))\}$ → desde la última: $\to \{\neg bebe(g(a))\} \to \{\neg enBar(g(a))\} \to \{\neg enBar(a)\} \to \Box$.
> **Sí es SLD:** todas Horn, arranca en la objetivo, lineal, un literal contra la cabeza.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 17 — Contactos de Facebook

**Enunciado**
Dadas las siguientes afirmaciones:
- Toda persona tiene un contacto en Facebook: $\forall X. \exists Y. esContacto(X, Y)$
  1. $\{esContacto(X, f(X))\}$
- La relación entre contactos es simétrica: $\forall X. \forall Y. (esContacto(X, Y) \Rightarrow esContacto(Y, X))$
  2. $\{\neg esContacto(X, Y), esContacto(Y, X)\}$

I. La siguiente es una demostración de que toda persona es contacto de sí misma, es decir, de $\forall X. esContacto(X, X)$.
- Negando la conclusión: $\neg \forall X. esContacto(X, X)$
- Forma normal negada: $\exists X. \neg esContacto(X, X)$
- Skolemizando y en forma clausal: 3. $\{\neg esContacto(c, c)\}$
- De 1 y 3, con $\sigma = \{X := c, f(X) := c\}$: $\Box$
¿Es correcta? Si no lo es, indicar el o los errores.

II. ¿Puede deducirse de las dos premisas que toda persona es contacto de alguien (es decir, de $\forall Y. \exists X. esContacto(X, Y)$)? En caso afirmativo dar una demostración, y en caso contrario explicar por qué.

**Explicacion**
Errores comunes en unificación (unificar una variable con un término que la contiene, o skolemización incorrecta).

**Resolucion paso a paso**
**I. ¿Es correcta la demostración de $\forall X. esContacto(X,X)$?**

**No.** La preparación está bien: negar, pasar a NNF ($\exists X. \neg esContacto(X,X)$) y skolemizar el $\exists$ con una constante nueva da correctamente
$$3.\quad \{\neg esContacto(c,c)\}$$

El error está en el **último paso**:

1. **$\sigma = \{X := c,\ f(X) := c\}$ no es una sustitución.** Una sustitución asigna términos a **variables**; $f(X)$ es un término compuesto y no puede estar del lado izquierdo.

2. **Las cláusulas 1 y 3 no unifican.** Aplicando Martelli–Montanari a $esContacto(X, f(X)) = esContacto(c,c)$:
$$\{X = c,\ f(X) = c\} \ \xrightarrow{\text{Elim } X := c}\ \{X = c,\ f(c) = c\} \ \xrightarrow{\text{Clash}}\ \text{FALLA}$$
   $f$ es un símbolo de función y $c$ una constante (símbolo de función de aridad 0): son símbolos distintos ⟹ **clash**. No existe mgu, así que no hay resolvente y mucho menos $\Box$.

3. **La conclusión es directamente falsa:** $\forall X. esContacto(X,X)$ **no** se deduce de las premisas. Contramodelo: universo $\{1,2\}$, $esContacto = \{(1,2),(2,1)\}$, $f(1) = 2$, $f(2) = 1$. Se cumplen las dos premisas (todos tienen un contacto, la relación es simétrica) y sin embargo nadie es contacto de sí mismo.

> El error es el arquetipo de "confundir la función de Skolem con un valor concreto": $f(X)$ denota *algún* contacto de $X$, no necesariamente $X$ ni una constante particular.

**II. ¿Puede deducirse $\forall Y. \exists X.\ esContacto(X,Y)$?**

**Sí.**

Negación de la tesis: $\neg\forall Y \exists X. esContacto(X,Y) \equiv \exists Y \forall X.\ \neg esContacto(X,Y)$. Skolemizando $Y := b$ (constante nueva):
$$3'.\quad \{\neg esContacto(X, b)\}$$

Todas las cláusulas son de Horn (1 es un hecho, 2 una regla, 3' un objetivo) ⟹ se puede hacer **SLD** arrancando en 3':

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg esContacto(X, b)\}$ | 2, cabeza $esContacto(Y_2, X_2)$ | $\{Y_2 := X,\ X_2 := b\}$ |
| 1 | $\{\neg esContacto(b, X)\}$ | 1, cabeza $esContacto(X_1, f(X_1))$ | $\{X_1 := b,\ X := f(b)\}$ |
| 2 | $\Box$ | — | — |

$\blacksquare$

*Lectura:* $b$ tiene un contacto, a saber $f(b)$ (premisa 1); por simetría (premisa 2) $f(b)$ tiene a $b$ como contacto, o sea $b$ **es** contacto de alguien. El testigo es $X := f(b)$.

**Por qué II sale y I no.** En II la constante de Skolem $b$ aparece en la *segunda* componente del predicado, que es exactamente donde la premisa 1 pone el término libre $X_1$ — unifica sin problema. En I había que unificar $f(X)$ con la constante $c$ en la misma posición, lo que es imposible.

**Chuleta**
> **I:** mal. $\sigma=\{X := c, f(X) := c\}$ no es sustitución (sólo se sustituyen variables), y $esContacto(X,f(X))$ **no unifica** con $esContacto(c,c)$: $f(c) = c$ da **clash**. Además la tesis es falsa (contramodelo: dos personas contacto mutuo, ninguna de sí misma).
> **II:** sí. Negar → $\{\neg esContacto(X, b)\}$ con $b$ constante de Skolem. SLD: $\to$(simetría) $\{\neg esContacto(b,X)\}$ $\to$(hecho, $X := f(b)$) $\Box$. Testigo: $f(b)$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_forma_clausal]]

---

### Ejercicio 18 — Descendiente y Abuelo

**Enunciado**
Dadas las siguientes definiciones de **Descendiente** y **Abuelo** a partir de la relación **Progenitor**:
- $\{\neg Progenitor(X, Y), Descendiente(Y, X)\}$
- $\{\neg Descendiente(X, Y), \neg Descendiente(Y, Z), Descendiente(X, Z)\}$
- $\{\neg Abuelo(X, Y), Progenitor(X, medio(X, Y))\}$
- $\{\neg Abuelo(X, Y), Progenitor(medio(X, Y), Y)\}$

Demostrar usando resolución general que los nietos son descendientes; es decir, que:
$\forall X. \forall Y. (Abuelo(X, Y) \Rightarrow Descendiente(Y, X))$
Ayuda: tratar de aplicar el método a ciegas puede traer problemas. Conviene tener en mente lo que se quiere demostrar.

**Explicacion**
Prueba de transitividad y composición de relaciones.

**Resolucion paso a paso**
**Cláusulas del problema**

| # | Cláusula | Lectura |
|---|---|---|
| 1 | $\{\neg Progenitor(X,Y),\ Descendiente(Y,X)\}$ | el hijo es descendiente del progenitor |
| 2 | $\{\neg Descendiente(X,Y),\ \neg Descendiente(Y,Z),\ Descendiente(X,Z)\}$ | transitividad |
| 3 | $\{\neg Abuelo(X,Y),\ Progenitor(X, medio(X,Y))\}$ | el abuelo es progenitor del "del medio" |
| 4 | $\{\neg Abuelo(X,Y),\ Progenitor(medio(X,Y), Y)\}$ | el del medio es progenitor del nieto |

**Negación de la tesis.** $\neg\forall X\forall Y.(Abuelo(X,Y) \Rightarrow Descendiente(Y,X)) \equiv \exists X \exists Y.(Abuelo(X,Y) \wedge \neg Descendiente(Y,X))$. Skolemizando $X := a$, $Y := b$:

| # | Cláusula |
|---|---|
| 5 | $\{Abuelo(a,b)\}$ |
| 6 | $\{\neg Descendiente(b,a)\}$ |

**Refutación por resolución general** (siguiendo la ayuda: primero se explota $Abuelo(a,b)$ para fabricar los dos eslabones, después se los pega con la transitividad)

| Paso | Cláusulas | mgu | Resolvente |
|---|---|---|---|
| i | 3 y 5 | $\{X := a,\ Y := b\}$ | 7. $\{Progenitor(a,\ medio(a,b))\}$ |
| ii | 4 y 5 | $\{X := a,\ Y := b\}$ | 8. $\{Progenitor(medio(a,b),\ b)\}$ |
| iii | 1 y 7 | $\{X := a,\ Y := medio(a,b)\}$ | 9. $\{Descendiente(medio(a,b),\ a)\}$ |
| iv | 1 y 8 | $\{X := medio(a,b),\ Y := b\}$ | 10. $\{Descendiente(b,\ medio(a,b))\}$ |
| v | 2 y 10 (sobre el 1er literal) | $\{X := b,\ Y := medio(a,b)\}$ | 11. $\{\neg Descendiente(medio(a,b), Z),\ Descendiente(b, Z)\}$ |
| vi | 11 y 9 | $\{Z := a\}$ | 12. $\{Descendiente(b,a)\}$ |
| vii | 12 y 6 | $id$ | $\Box$ |

$\blacksquare$

*Por qué la ayuda advierte contra aplicar el método a ciegas:* la cláusula 2 (transitividad) resuelve consigo misma y con casi todo, generando infinitas cláusulas $\{\neg D(X,Y_1), \neg D(Y_1,Y_2), \ldots, D(X,Z)\}$ cada vez más largas. Hay que dirigir la búsqueda hacia la tesis: fabricar primero los dos eslabones concretos $Descendiente(medio(a,b),a)$ y $Descendiente(b, medio(a,b))$, y recién entonces usar la transitividad **una sola vez**.

**Nota: también se puede hacer con SLD.** Las cláusulas 1–4 son reglas, 5 es un hecho y 6 es una cláusula objetivo — todas de Horn. Una derivación SLD partiendo de 6:

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg D(b,a)\}$ | 2, cabeza $D(X,Z)$ | $\{X := b,\ Z := a\}$ |
| 1 | $\{\neg D(b,Y),\ \neg D(Y,a)\}$ | 1, cabeza $D(Y_1,X_1)$ | $\{Y_1 := b,\ X_1 := Y\}$ |
| 2 | $\{\neg Prog(Y,b),\ \neg D(Y,a)\}$ | 4, cabeza $Prog(medio(X_2,Y_2),Y_2)$ | $\{Y_2 := b,\ Y := medio(X_2,b)\}$ |
| 3 | $\{\neg Abuelo(X_2,b),\ \neg D(medio(X_2,b), a)\}$ | 5 | $\{X_2 := a\}$ |
| 4 | $\{\neg D(medio(a,b), a)\}$ | 1, cabeza $D(Y_3,X_3)$ | $\{Y_3 := medio(a,b),\ X_3 := a\}$ |
| 5 | $\{\neg Prog(a,\ medio(a,b))\}$ | 3, cabeza $Prog(X_4, medio(X_4,Y_4))$ | $\{X_4 := a,\ Y_4 := b\}$ |
| 6 | $\{\neg Abuelo(a,b)\}$ | 5 | $id$ |
| 7 | $\Box$ | — | — |

(En la tabla se abrevia $D = Descendiente$ y $Prog = Progenitor$.)

**Chuleta**
> 1. Negar tesis → $\{Abuelo(a,b)\}$ y $\{\neg Descendiente(b,a)\}$ (dos constantes de Skolem).
> 2. Con las reglas 3 y 4 sobre $Abuelo(a,b)$: $Prog(a, medio(a,b))$ y $Prog(medio(a,b), b)$ → con la regla 1: $D(medio(a,b),a)$ y $D(b,medio(a,b))$.
> 3. Transitividad **una sola vez** para pegar los eslabones → $D(b,a)$ → con $\{\neg D(b,a)\}$ → $\Box$.
> Trampa: resolver a ciegas con la transitividad genera cláusulas infinitamente largas; dirigir la búsqueda desde la tesis.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_por_contradiccion]]

---

### Ejercicio 19 — Propiedades de relaciones binarias

**Enunciado**
En este ejercicio usaremos el método de resolución para demostrar una propiedad de las relaciones binarias; a saber, que una relación no vacía no puede ser a la vez irreflexiva, simétrica y transitiva.
Para esto se demostrará la propiedad deseada para una relación arbitraria $R$.
Dadas las siguientes definiciones:
1. $R$ es irreflexiva: $\forall X. \neg R(X, X)$
2. $R$ es simétrica: $\forall X. \forall Y. (R(X, Y) \Rightarrow R(Y, X))$
3. $R$ es transitiva: $\forall X. \forall Y. \forall Z. ((R(X, Y) \wedge R(Y, Z)) \Rightarrow R(X, Z))$
4. $R$ es no vacía: $\exists X. \exists Y. R(X, Y)$
Utilizando resolución, demostrar que si $R$ cumple las propiedades 1 a 3, entonces es vacía. Indicar si el método de resolución utilizado es o no SLD (y justificar).

**Explicacion**
Inconsistencia entre irreflexividad y (simetría + transitividad) para relaciones no vacías.

**Resolucion paso a paso**
**Cláusulas**

| # | Origen | Cláusula | Tipo |
|---|---|---|---|
| 1 | irreflexiva: $\forall X. \neg R(X,X)$ | $\{\neg R(X,X)\}$ | **objetivo** |
| 2 | simétrica | $\{\neg R(X,Y),\ R(Y,X)\}$ | regla |
| 3 | transitiva | $\{\neg R(X,Y),\ \neg R(Y,Z),\ R(X,Z)\}$ | regla |
| 4 | $\neg$(R es vacía) $= \exists X \exists Y. R(X,Y)$, Skolem $a,b$ | $\{R(a,b)\}$ | hecho |

*Planteo:* se quiere probar que 1 + 2 + 3 $\models$ "$R$ es vacía", es decir $\neg\exists X\exists Y. R(X,Y)$. Negando la tesis se obtiene $\exists X\exists Y. R(X,Y)$, que skolemizado da el hecho 4. Hay que refutar $\{1,2,3,4\}$.

**Refutación por resolución general**

| Paso | Cláusulas | mgu | Resolvente |
|---|---|---|---|
| i | 4 y 2 | $\{X := a,\ Y := b\}$ | 5. $\{R(b,a)\}$ |
| ii | 4 y 3 (1er literal) | $\{X := a,\ Y := b\}$ | 6. $\{\neg R(b,Z),\ R(a,Z)\}$ |
| iii | 6 y 5 | $\{Z := a\}$ | 7. $\{R(a,a)\}$ |
| iv | 7 y 1 | $\{X := a\}$ | $\Box$ |

$\blacksquare$

*Lectura:* si $a\,R\,b$, por simetría $b\,R\,a$; por transitividad $a\,R\,a$; y eso contradice la irreflexividad. Como $a$ y $b$ eran testigos arbitrarios (constantes de Skolem), la relación no puede tener ningún par.

**¿Es SLD la derivación anterior?** **No.** El paso i resuelve la cláusula 4 (un hecho) contra la 2 (una regla): dos cláusulas de definición entre sí, sin que intervenga ningún objetivo. El resolvente $\{R(b,a)\}$ es positivo, o sea no es una cláusula objetivo. Se rompe el esquema "objetivo + definición ⟹ objetivo".

**Versión SLD.** Las cuatro cláusulas son de Horn, y la única sin literales positivos es la 1 (irreflexividad) — así que ésa tiene que ser el objetivo inicial:

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg R(X,X)\}$ | 3, cabeza $R(X_3,Z_3)$ | $\{X_3 := X,\ Z_3 := X\}$ |
| 1 | $\{\neg R(X, Y_3),\ \neg R(Y_3, X)\}$ | 4 | $\{X := a,\ Y_3 := b\}$ |
| 2 | $\{\neg R(b,a)\}$ | 2, cabeza $R(Y_2,X_2)$ | $\{Y_2 := b,\ X_2 := a\}$ |
| 3 | $\{\neg R(a,b)\}$ | 4 | $id$ |
| 4 | $\Box$ | — | — |

Ahora **sí es SLD**: todas las cláusulas son de Horn, se arranca en una cláusula objetivo, la derivación es lineal y cada paso resuelve un literal seleccionado del objetivo contra la cabeza de una cláusula de definición.

> Este ejercicio es el contraejemplo clásico a la condición "empezar por la negación de lo que se quiere demostrar" del **Ej. 12**: la negación de la tesis es el *hecho* $\{R(a,b)\}$, mientras que el objetivo inicial de la derivación SLD es la **premisa** de irreflexividad.

**Chuleta**
> 1. Cláusulas: $\{\neg R(X,X)\}$, $\{\neg R(X,Y), R(Y,X)\}$, $\{\neg R(X,Y),\neg R(Y,Z),R(X,Z)\}$, y $\{R(a,b)\}$ (negación de "es vacía", skolemizada).
> 2. General: $R(a,b)$ + simetría → $R(b,a)$; + transitividad → $R(a,a)$; + irreflexividad → $\Box$. **No es SLD** (resuelve dos definiciones entre sí).
> 3. SLD: arrancar en $\{\neg R(X,X)\}$ →(trans) $\{\neg R(X,Y),\neg R(Y,X)\}$ →($R(a,b)$) $\{\neg R(b,a)\}$ →(sim) $\{\neg R(a,b)\}$ →($R(a,b)$) $\Box$.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 20 — Números Naturales en Prolog

**Enunciado**
Considerar las siguientes definiciones en Prolog:
```prolog
natural(cero).
natural(suc(X)) :- natural(X).

mayorOIgual(suc(X), Y) :- mayorOIgual(X, Y).
mayorOIgual(X, X) :- natural(X).
```
- ¿Qué sucede al realizar la consulta `?- mayorOIgual(suc(suc(N)), suc(cero))?`
- Utilizar el método de resolución para probar la validez de la consulta del ítem 1. Para ello, convertir las cláusulas a forma clausal.
- Indicar si el método de resolución utilizado es o no SLD, y justificar. En caso de ser SLD, ¿respeta el orden en que Prolog hubiera resuelto la consulta?

**Explicacion**
Traza de ejecución de Prolog y su relación con SLD. El orden de las cláusulas afecta la terminación y el espacio de búsqueda.

**Resolucion paso a paso**
**1) ¿Qué sucede con la consulta `?- mayorOIgual(suc(suc(N)), suc(cero)).`?**

**Se cuelga** (bucle infinito), a pesar de que la consulta tiene solución.

Prolog prueba las cláusulas en orden textual, y la primera de `mayorOIgual` es la recursiva:

```
?- mayorOIgual(suc(suc(N)), suc(cero)).
   cl.3: mayorOIgual(suc(X),Y) :- mayorOIgual(X,Y).   [X := suc(N), Y := suc(cero)]
?- mayorOIgual(suc(N), suc(cero)).
   cl.3 otra vez                                       [X := N]
?- mayorOIgual(N, suc(cero)).            % N sigue sin instanciar
   cl.3 otra vez: unifica N con suc(X')                [N := suc(X')]
?- mayorOIgual(X', suc(cero)).
   ... y así al infinito, instanciando N := suc(suc(suc(...)))
```

Como la búsqueda es **DFS** y esta rama es infinita, Prolog nunca hace backtracking hacia la cláusula 4 (`mayorOIgual(X,X) :- natural(X).`), que es la que resolvería la consulta con `N = cero` (o sea $2 \geq 1$).

**2) Prueba por resolución**

Forma clausal del programa y de la consulta negada:

| # | Cláusula | Tipo |
|---|---|---|
| 1 | $\{natural(cero)\}$ | hecho |
| 2 | $\{natural(suc(X)),\ \neg natural(X)\}$ | regla |
| 3 | $\{mayorOIgual(suc(X), Y),\ \neg mayorOIgual(X,Y)\}$ | regla |
| 4 | $\{mayorOIgual(X,X),\ \neg natural(X)\}$ | regla |

Consulta: $\exists N.\ mayorOIgual(suc(suc(N)), suc(cero))$; negada:
$$N_0 = \{\neg mayorOIgual(suc(suc(N)),\ suc(cero))\}$$

**Derivación**

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg mayorOIgual(suc(suc(N)), suc(cero))\}$ | 3, cabeza $mayorOIgual(suc(X_1),Y_1)$ | $\{X_1 := suc(N),\ Y_1 := suc(cero)\}$ |
| 1 | $\{\neg mayorOIgual(suc(N), suc(cero))\}$ | 4, cabeza $mayorOIgual(X_2,X_2)$ | $\{N := cero,\ X_2 := suc(cero)\}$ |
| 2 | $\{\neg natural(suc(cero))\}$ | 2, cabeza $natural(suc(X_3))$ | $\{X_3 := cero\}$ |
| 3 | $\{\neg natural(cero)\}$ | 1 | $id$ |
| 4 | $\Box$ | — | — |

Detalle del paso 1: unificar $mayorOIgual(suc(N), suc(cero))$ con $mayorOIgual(X_2, X_2)$ obliga a $X_2 = suc(N)$ y $X_2 = suc(cero)$, de donde $suc(N) = suc(cero)$ y por *decompose* $N := cero$.

**Sustitución respuesta:** $\{N := cero\}$, es decir $mayorOIgual(suc(suc(cero)), suc(cero))$ — $2 \geq 1$. $\blacksquare$

**3) ¿Es SLD? ¿Respeta el orden de Prolog?**

**Sí es SLD.** Las cuatro cláusulas del programa son de definición (un literal positivo cada una), $N_0$ es una cláusula objetivo, cada paso resuelve el objetivo actual contra una cláusula del programa (linealidad) y produce otro objetivo, y en cada paso se resuelve un único literal seleccionado contra la cabeza.

**No respeta el orden de Prolog.** En el paso 1 elegimos la cláusula 4, pero Prolog habría probado primero la cláusula 3 (aparece antes en el programa) y se habría metido en la rama infinita descrita en el punto 1. Nuestra derivación corresponde a recorrer el mismo árbol SLD con otra estrategia de búsqueda (por ejemplo **BFS**, que sí es completa) o simplemente eligiendo bien la rama.

**Cómo arreglarlo:** invertir el orden de las cláusulas de `mayorOIgual`:
```prolog
mayorOIgual(X, X) :- natural(X).
mayorOIgual(suc(X), Y) :- mayorOIgual(X, Y).
```
Con este orden Prolog intenta primero el caso base: falla al unificar $mayorOIgual(suc(suc(N)), suc(cero))$ con $mayorOIgual(X,X)$ (daría $suc(N) = cero$, *clash*), pasa a la regla recursiva, y en el siguiente nivel el caso base sí unifica con $N := cero$. Encuentra la respuesta. **El orden de las cláusulas es relevante para la terminación** — ésa es la incompletitud de Prolog frente a SLD.

**Chuleta**
> 1. Prolog **se cuelga**: prueba primero la regla recursiva, que unifica siempre ($N := suc(N')$…) y genera una rama DFS infinita; nunca llega al caso base.
> 2. SLD a mano: $\{\neg mOI(suc(suc(N)),suc(cero))\}$ →(regla rec.) $\{\neg mOI(suc(N),suc(cero))\}$ →(caso base $mOI(X,X)$, $N := cero$) $\{\neg natural(suc(cero))\}$ → $\{\neg natural(cero)\}$ → $\Box$. Respuesta $N := cero$.
> 3. **Es SLD**, pero **no** en el orden de Prolog (elegimos el caso base antes que la recursión). Se arregla poniendo `mayorOIgual(X,X) :- natural(X).` primero.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_sld_justificacion]]

---

### Ejercicio 21 — Flipper el delfín

**Enunciado**
Dado el siguiente programa en Prolog, pasarlo a forma clausal y demostrar utilizando resolución que hay alguien que es inteligente pero analfabeto.
```prolog
analfabeto(X) :- vivo(X), noSabeLeer(X).
vivo(X) :- delfin(X).
inteligente(flipper).
inteligente(alan).
noSabeLeer(X) :- mesa(X).
noSabeLeer(X) :- delfin(X).
delfin(flipper).
```

**Explicacion**
Ejercicio de modelado Prolog y resolución para encontrar un testigo.

**Resolucion paso a paso**
**Forma clausal del programa**

| # | Cláusula Prolog | Cláusula |
|---|---|---|
| 1 | `analfabeto(X) :- vivo(X), noSabeLeer(X).` | $\{analfabeto(X),\ \neg vivo(X),\ \neg noSabeLeer(X)\}$ |
| 2 | `vivo(X) :- delfin(X).` | $\{vivo(X),\ \neg delfin(X)\}$ |
| 3 | `inteligente(flipper).` | $\{inteligente(flipper)\}$ |
| 4 | `inteligente(alan).` | $\{inteligente(alan)\}$ |
| 5 | `noSabeLeer(X) :- mesa(X).` | $\{noSabeLeer(X),\ \neg mesa(X)\}$ |
| 6 | `noSabeLeer(X) :- delfin(X).` | $\{noSabeLeer(X),\ \neg delfin(X)\}$ |
| 7 | `delfin(flipper).` | $\{delfin(flipper)\}$ |

**Objetivo.** "Hay alguien inteligente pero analfabeto": $\exists X.\ (inteligente(X) \wedge analfabeto(X))$. Negando:
$$8.\quad N_0 = \{\neg inteligente(X_0),\ \neg analfabeto(X_0)\}$$

Todas las cláusulas del programa son de definición ⟹ **SLD**.

**Derivación SLD** (seleccionando siempre el primer literal, como Prolog)

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg inteligente(X_0),\ \neg analfabeto(X_0)\}$ | 3 | $\{X_0 := flipper\}$ |
| 1 | $\{\neg analfabeto(flipper)\}$ | 1, cabeza $analfabeto(X_1)$ | $\{X_1 := flipper\}$ |
| 2 | $\{\neg vivo(flipper),\ \neg noSabeLeer(flipper)\}$ | 2, cabeza $vivo(X_2)$ | $\{X_2 := flipper\}$ |
| 3 | $\{\neg delfin(flipper),\ \neg noSabeLeer(flipper)\}$ | 7 | $id$ |
| 4 | $\{\neg noSabeLeer(flipper)\}$ | 6, cabeza $noSabeLeer(X_3)$ | $\{X_3 := flipper\}$ |
| 5 | $\{\neg delfin(flipper)\}$ | 7 | $id$ |
| 6 | $\Box$ | — | — |

**Sustitución respuesta:** $\{X_0 := flipper\}$. **Flipper es inteligente pero analfabeto.** $\blacksquare$

**¿Coincide con lo que haría Prolog?** Casi. Prolog seguiría el mismo camino salvo por un backtracking en el paso 4: probaría primero la cláusula 5 (`noSabeLeer(X) :- mesa(X).`), generando el subobjetivo `mesa(flipper)`, que **falla** porque no hay ninguna cláusula para `mesa`; recién entonces vuelve y usa la cláusula 6. Con `alan` no habría salido: `alan` no es delfín, así que ni `vivo(alan)` ni `noSabeLeer(alan)` son derivables — por eso Prolog acierta al probar primero la cláusula 3 (`inteligente(flipper)`), que aparece antes que la 4.

**Chuleta**
> 1. Cada regla `cabeza :- c1, c2.` → $\{cabeza, \neg c_1, \neg c_2\}$; cada hecho → cláusula unitaria.
> 2. Objetivo: negar $\exists X.(inteligente(X) \wedge analfabeto(X))$ → $\{\neg inteligente(X_0), \neg analfabeto(X_0)\}$.
> 3. SLD: $X_0 := flipper$ (hecho) → desplegar `analfabeto` → `vivo` → `delfin(flipper)` ✓ → `noSabeLeer` vía `delfin` → `delfin(flipper)` ✓ → $\Box$. Respuesta: **flipper**.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 22 — Preorder y Append

**Enunciado**
Considerar las siguientes definiciones en prolog:
```prolog
preorder(nil, []).
preorder(bin(I, R, D), [R|L]) :-
    append(LI, LD, L),
    preorder(I, LI),
    preorder(D, LD).

append([], YS, YS).
append([X|XS], YS, [X|LS]) :- append(XS, YS, LS).
```
- ¿Qué sucede al realizar la consulta `?- preorder(bin(bin(nil, 2, nil), 1, nil), Lista).?`
- Utilizar el método de resolución para encontrar la solución al problema.
- Indicar si el método de resolución utilizado es o no SLD, y justificar. En caso de ser SLD, ¿respeta el orden en que Prolog hubiera resuelto la consulta?

**Explicacion**
Traza compleja que involucra múltiples predicados y recursión.

**Resolucion paso a paso**
**1) ¿Qué sucede con `?- preorder(bin(bin(nil,2,nil),1,nil), Lista).`?**

Devuelve **`Lista = [1,2]`**, pero por un camino con bastante backtracking, y si se le piden más soluciones **se cuelga**.

El motivo es que la regla llama a `append(LI, LD, L)` con las **tres** variables sin instanciar: en ese modo `append` funciona como *generador* de todas las particiones de una lista, incluso de longitud creciente e infinita. Recién después se testea con `preorder(I,LI)` y `preorder(D,LD)`. Es un **generate & test** con generador infinito:

```
preorder(bin(bin(nil,2,nil),1,nil), Lista)
  ↳ cl.2:  I = bin(nil,2,nil), R = 1, D = nil, Lista = [1|L]
     ↳ append(LI, LD, L)
        · 1ra alternativa: LI = [], LD = L      → preorder(bin(nil,2,nil), [])  ✗ FALLA
        · 2da alternativa: LI = [X], LD = LS, L = [X|LS]
             ↳ preorder(bin(nil,2,nil), [X]) → X = 2  ✓
             ↳ preorder(nil, LD) → LD = []           ✓   ⟹ L = [2], Lista = [1,2]
```

Al pedir la segunda solución, `append` sigue generando `LI` de longitud 2, 3, … y ninguna vuelve a funcionar: la búsqueda no termina.

**2) Forma clausal y resolución**

| # | Cláusula |
|---|---|
| 1 | $\{preorder(nil, [\,])\}$ |
| 2 | $\{preorder(bin(I,R,D),\ [R \mid L]),\ \neg append(LI,LD,L),\ \neg preorder(I,LI),\ \neg preorder(D,LD)\}$ |
| 3 | $\{append([\,],\ YS,\ YS)\}$ |
| 4 | $\{append([X \mid XS],\ YS,\ [X \mid LS]),\ \neg append(XS,YS,LS)\}$ |

Objetivo (consulta negada): $N_0 = \{\neg preorder(bin(bin(nil,2,nil),1,nil),\ L_0)\}$

**Derivación SLD** (eligiendo el literal conveniente en cada paso — ver punto 3)

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg preorder(bin(bin(nil,2,nil),1,nil), L_0)\}$ | 2 | $\{I := bin(nil,2,nil),\ R := 1,\ D := nil,\ L_0 := [1 \mid L]\}$ |
| 1 | $\{\neg append(LI,LD,L),\ \neg preorder(bin(nil,2,nil), LI),\ \neg preorder(nil, LD)\}$ | 2 (renombrada) | $\{I' := nil,\ R' := 2,\ D' := nil,\ LI := [2 \mid L']\}$ |
| 2 | $\{\neg append(LI',LD',L'),\ \neg preorder(nil,LI'),\ \neg preorder(nil,LD'),\ \neg append([2 \mid L'],LD,L),\ \neg preorder(nil,LD)\}$ | 1 (sobre $preorder(nil,LI')$) | $\{LI' := [\,]\}$ |
| 3 | $\{\neg append([\,],LD',L'),\ \ldots\}$ | 3 | $\{YS := LD',\ L' := LD'\}$ |
| 4 | $\{\neg preorder(nil,LD'),\ \neg append([2 \mid LD'],LD,L),\ \neg preorder(nil,LD)\}$ | 1 | $\{LD' := [\,]\}$ |
| 5 | $\{\neg append([2],LD,L),\ \neg preorder(nil,LD)\}$ | 1 | $\{LD := [\,]\}$ |
| 6 | $\{\neg append([2],[\,],L)\}$ | 4 | $\{X := 2,\ XS := [\,],\ YS := [\,],\ L := [2 \mid LS]\}$ |
| 7 | $\{\neg append([\,],[\,],LS)\}$ | 3 | $\{YS' := [\,],\ LS := [\,]\}$ |
| 8 | $\Box$ | — | — |

**Composición de sustituciones:** $L_0 := [1 \mid L]$, $L := [2 \mid LS]$, $LS := [\,]$, de donde
$$\boxed{Lista = [1, 2]}$$
$\blacksquare$

**3) ¿Es SLD? ¿Respeta el orden de Prolog?**

**Sí es SLD:** las cuatro cláusulas del programa son de definición, $N_0$ es una cláusula objetivo, la derivación es lineal y cada paso resuelve un literal seleccionado del objetivo contra la cabeza de una cláusula del programa, dando otro objetivo.

**No respeta el orden de Prolog.** Prolog usa la regla de selección "primer literal de izquierda a derecha", así que en el paso 1 habría atacado `append(LI,LD,L)` (el primer literal del cuerpo de la regla 2) antes que los `preorder`. Nosotros elegimos primero los `preorder`, que son los que **instancian** las listas y evitan que `append` genere a ciegas. Ambas derivaciones llegan a la misma respuesta $[1,2]$; la nuestra la encuentra en 8 pasos, mientras que Prolog explora además las ramas fallidas del generador.

> Éste es el mismo fenómeno de los Ej. 20, 23 y 25: **SLD deja libre la regla de selección**, y elegir bien puede ser la diferencia entre terminar y colgarse. Reordenar el cuerpo de la regla como
> ```prolog
> preorder(bin(I,R,D), [R|L]) :- preorder(I,LI), preorder(D,LD), append(LI,LD,L).
> ```
> hace que Prolog siga esencialmente nuestra derivación (los `preorder` instancian `LI` y `LD`, y `append` se usa en modo constructor, determinístico).

**Chuleta**
> 1. `append(LI,LD,L)` con todo libre = **generador infinito** de particiones ⟹ Prolog da `[1,2]` con backtracking, y se cuelga si se le piden más soluciones.
> 2. Clausal: la regla de `preorder` → $\{preorder(bin(I,R,D),[R \mid L]), \neg append(LI,LD,L), \neg preorder(I,LI), \neg preorder(D,LD)\}$.
> 3. SLD eligiendo primero los `preorder`: instancian $LI := [2]$, $LD := [\,]$; después `append([2],[],L)` → $L = [2]$ ⟹ $Lista = [1,2]$.
> 4. **Es SLD pero no el orden de Prolog** (él toma el primer literal, o sea `append`, antes). Arreglo: poner `append` al final del cuerpo.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/prolog_listas_append]]

---

### Ejercicio 23 — Consulta Prolog: Pares positivos

**Enunciado**
Dada la siguiente base de conocimientos en Prolog:
```prolog
parPositivo(X, Y) :- mayor(X, 0), mayor(Y, 0).
natural(0).
natural(suc(N)) :- natural(N).
mayor(suc(X), 0) :- natural(X).
mayor(suc(X), suc(Y)) :- mayor(X, Y).
```
a) Explicar con palabras qué sucede al realizar la siguiente consulta: `parPositivo(A, B), mayor(A, B).`
b) Expresar la base de conocimientos y la consulta anterior como fórmulas lógicas, y luego encontrar una solución a la consulta utilizando resolución SLD.

**Explicacion**
Análisis de la semántica operacional de Prolog y extracción de respuestas.

**Resolucion paso a paso**
**a) ¿Qué sucede con `parPositivo(A, B), mayor(A, B).`?**

**Se cuelga.** Prolog resuelve de izquierda a derecha:

1. `parPositivo(A,B)` se despliega en `mayor(A,0), mayor(B,0)`.
2. `mayor(A,0)`: la única cláusula que unifica es `mayor(suc(X),0) :- natural(X).` (la otra pide `suc(Y)` en la segunda posición). Con `natural(X)` y el hecho `natural(0)` primero, sale **`A = suc(0)`**.
3. Igual para `mayor(B,0)`: primera solución **`B = suc(0)`**.
4. `mayor(suc(0), suc(0))` → regla 5 → `mayor(0,0)`, que no unifica con ninguna cabeza (`mayor(suc(X),0)` ni `mayor(suc(X),suc(Y))`) ⟹ **falla**.
5. Backtracking: el punto de elección más reciente es el `natural(Y)` de `mayor(B,0)`, que genera `B = suc(suc(0))`, `suc(suc(suc(0)))`, … indefinidamente. Ninguno funciona, porque `A` quedó fijo en el mínimo positivo `suc(0)` y se pide `A > B`.

Como el generador de `B` es infinito, Prolog **nunca** vuelve atrás a cambiar `A`. Bucle infinito, aunque la consulta sí tiene solución (por ejemplo `A = suc(suc(0))`, `B = suc(0)`).

**b) Forma lógica y resolución SLD**

| # | Fórmula | Cláusula |
|---|---|---|
| 1 | $\forall X \forall Y.((mayor(X,0) \wedge mayor(Y,0)) \Rightarrow parPositivo(X,Y))$ | $\{parPositivo(X,Y),\ \neg mayor(X,0),\ \neg mayor(Y,0)\}$ |
| 2 | $natural(0)$ | $\{natural(0)\}$ |
| 3 | $\forall N.(natural(N) \Rightarrow natural(suc(N)))$ | $\{natural(suc(N)),\ \neg natural(N)\}$ |
| 4 | $\forall X.(natural(X) \Rightarrow mayor(suc(X),0))$ | $\{mayor(suc(X),0),\ \neg natural(X)\}$ |
| 5 | $\forall X \forall Y.(mayor(X,Y) \Rightarrow mayor(suc(X),suc(Y)))$ | $\{mayor(suc(X),suc(Y)),\ \neg mayor(X,Y)\}$ |

Consulta: $\exists A \exists B.\ (parPositivo(A,B) \wedge mayor(A,B))$. Negada:
$$N_0 = \{\neg parPositivo(A,B),\ \neg mayor(A,B)\}$$

**Derivación SLD** (seleccionando `mayor(A,B)` **antes** que los generadores)

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg parPositivo(A,B),\ \neg mayor(A,B)\}$ | 1 | $\{X := A,\ Y := B\}$ |
| 1 | $\{\neg mayor(A,0),\ \neg mayor(B,0),\ \neg mayor(A,B)\}$ | 5 (sobre $mayor(A,B)$) | $\{A := suc(X_5),\ B := suc(Y_5)\}$ |
| 2 | $\{\neg mayor(suc(X_5),0),\ \neg mayor(suc(Y_5),0),\ \neg mayor(X_5,Y_5)\}$ | 4 (sobre $mayor(X_5,Y_5)$) | $\{X_5 := suc(X_4),\ Y_5 := 0\}$ |
| 3 | $\{\neg mayor(suc(suc(X_4)),0),\ \neg mayor(suc(0),0),\ \neg natural(X_4)\}$ | 2 | $\{X_4 := 0\}$ |
| 4 | $\{\neg mayor(suc(suc(0)),0),\ \neg mayor(suc(0),0)\}$ | 4 | $\{X := suc(0)\}$ |
| 5 | $\{\neg natural(suc(0)),\ \neg mayor(suc(0),0)\}$ | 3 | $\{N := 0\}$ |
| 6 | $\{\neg natural(0),\ \neg mayor(suc(0),0)\}$ | 2 | $id$ |
| 7 | $\{\neg mayor(suc(0),0)\}$ | 4 | $\{X := 0\}$ |
| 8 | $\{\neg natural(0)\}$ | 2 | $id$ |
| 9 | $\Box$ | — | — |

**Sustitución respuesta:** $\{A := suc(suc(0)),\ B := suc(0)\}$ — es decir $A = 2$, $B = 1$: ambos positivos y $A > B$. $\blacksquare$

**Observación.** La derivación **es** SLD (todas las cláusulas son de Horn, se arranca en el objetivo, es lineal). Lo que cambia respecto de Prolog es la **regla de selección**: elegimos el literal `mayor(A,B)` primero, que actúa como *restricción* e instancia `A` y `B` a un par correcto de entrada; los `mayor(_,0)` quedan después como simples verificaciones. Prolog, obligado a ir de izquierda a derecha, genera primero y testea después — y ahí se cuelga.

**Chuleta**
> a) **Se cuelga**: Prolog fija `A = suc(0)` (el mínimo positivo) y después genera `B = suc(0), suc(suc(0)), …` buscando `mayor(A,B)`, que nunca puede valer. Generador infinito ⟹ nunca vuelve a cambiar `A`.
> b) SLD eligiendo `mayor(A,B)` **primero**: regla 5 → $A := suc(X)$, $B := suc(Y)$; regla 4 → $X := suc(X')$, $Y := 0$; se verifica todo con `natural(0)`. Respuesta $A = suc(suc(0))$, $B = suc(0)$.
> Moraleja: **restringir antes de generar**.

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 24 — Reglas de Reducción

**Enunciado**
Sea la siguiente base de conocimientos en Prolog, que describe una parte de las reglas de reducción de un cierto lenguaje:
```prolog
reduce(const * X * _, X).
reduce(id * X, X).
reduce(flip * F * X * Y, F * Y * X).
reduce(M * N, M1 * N) :- reduce(M, M1).
```
Donde el operador `*` representa la aplicación. Este operador asocia a izquierda. Si les resulta más cómodo, pueden reescribir las expresiones de la forma `A * B` como `ap(A, B)`.
Se realiza la siguiente consulta:
`? reduce(flip * const * X * Y, A), reduce(A, Z), reduce(const * id * X * Y, B), reduce(B, Z).`
a) Reescribir la base de conocimientos y la consulta como fórmulas lógicas.
b) Resolver la consulta utilizando el método de resolución para obtener los valores de $A$ y $B$.
c) La resolución utilizada en el punto anterior, ¿fue SLD? Justificar. En caso afirmativo, ¿fue la misma resolución que habría utilizado Prolog?

**Explicacion**
Modelado de semántica operacional de un lenguaje funcional (estilo combinadores) en Prolog.

**Resolucion paso a paso**
**a) Base de conocimiento y consulta como fórmulas**

Escribiendo $A * B$ como $ap(A,B)$ (recordar que `*` asocia a **izquierda**: `const * X * _` $= ap(ap(const, X), Z)$):

| # | Cláusula Prolog | Cláusula |
|---|---|---|
| 1 | `reduce(const * X * _, X).` | $\{reduce(ap(ap(const, X), Z),\ X)\}$ |
| 2 | `reduce(id * X, X).` | $\{reduce(ap(id, X),\ X)\}$ |
| 3 | `reduce(flip * F * X * Y, F * Y * X).` | $\{reduce(ap(ap(ap(flip,F),X),Y),\ ap(ap(F,Y),X))\}$ |
| 4 | `reduce(M * N, M1 * N) :- reduce(M, M1).` | $\{reduce(ap(M,N),\ ap(M_1,N)),\ \neg reduce(M,M_1)\}$ |

Las 1–3 son **hechos** (universalmente cuantificados) y la 4 es una **regla**:
$$\forall M \forall N \forall M_1.\ (reduce(M,M_1) \Rightarrow reduce(ap(M,N),\ ap(M_1,N)))$$

Consulta:
$$\exists A \exists B \exists Z.\ \big(reduce(ap(ap(ap(flip,const),X),Y),\ A) \wedge reduce(A,Z) \wedge reduce(ap(ap(ap(const,id),X),Y),\ B) \wedge reduce(B,Z)\big)$$

Objetivo inicial (negación de la consulta):
$$N_0 = \{\neg reduce(ap(ap(ap(flip,const),X),Y),\ A),\ \neg reduce(A,Z),\ \neg reduce(ap(ap(ap(const,id),X),Y),\ B),\ \neg reduce(B,Z)\}$$

**b) Resolución**

| Paso | Literal seleccionado | Cláusula | mgu | Efecto |
|---|---|---|---|---|
| 0 | $\neg reduce(ap(ap(ap(flip,const),X),Y),\ A)$ | 3 | $\{F := const,\ X_3 := X,\ Y_3 := Y,\ A := ap(ap(const,Y),X)\}$ | $A = const * Y * X$ |
| 1 | $\neg reduce(ap(ap(const,Y),X),\ Z)$ | 1 | $\{X_1 := Y,\ Z_1 := X,\ Z := Y\}$ | $Z = Y$ |
| 2 | $\neg reduce(ap(ap(ap(const,id),X),Y),\ B)$ | 4 | $\{M := ap(ap(const,id),X),\ N := Y,\ B := ap(M_1, Y)\}$ | nuevo subobjetivo $\neg reduce(ap(ap(const,id),X),\ M_1)$ |
| 3 | $\neg reduce(ap(ap(const,id),X),\ M_1)$ | 1 | $\{X_1' := id,\ Z_1' := X,\ M_1 := id\}$ | $B = id * Y$ |
| 4 | $\neg reduce(ap(id,Y),\ Y)$ | 2 | $\{X_2 := Y\}$ | $\Box$ |

$$\boxed{A = const * Y * X \qquad B = id * Y \qquad Z = Y}$$

*Detalle del paso 2:* la cláusula 1 **no** unifica con $reduce(ap(ap(ap(const,id),X),Y),\ B)$: descomponiendo $ap(ap(const,X_1),Z_1) = ap(ap(ap(const,id),X),Y)$ queda $ap(const, X_1) = ap(ap(const,id), X)$ y de ahí $const = ap(const,id)$ ⟹ **clash**. Tampoco la 2 ($id = ap(\ldots)$, clash) ni la 3 ($flip = const$, clash). La única aplicable es la 4, que reduce en la posición de la *función* — y por eso hace falta un paso extra respecto de la rama de `flip`.

*Lectura de la reducción:* `flip const X Y` $\to$ `const Y X` $\to$ `Y`, y `const id X Y` $\to$ `id Y` $\to$ `Y`. Los dos caminos convergen en el mismo $Z = Y$, que es justamente lo que la consulta exigía al usar la misma variable $Z$ en el segundo y el cuarto literal. $\blacksquare$

**c) ¿Fue SLD? ¿La misma que Prolog?**

**Sí, fue SLD.** Las cuatro cláusulas del programa tienen exactamente un literal positivo (son de definición), $N_0$ es una cláusula objetivo, la derivación es lineal y en cada paso se resuelve un literal seleccionado del objetivo contra la cabeza de una cláusula, obteniendo otro objetivo.

**Sí, es la misma que hubiera hecho Prolog.** Respetamos la regla de selección de izquierda a derecha (primero el literal de `flip`, después `reduce(A,Z)`, después el de `const`, después `reduce(B,Z)`) y, en cada paso, la cláusula elegida es la primera del programa cuya cabeza unifica:

| Paso | Cláusulas que Prolog descarta antes | Cláusula usada |
|---|---|---|
| 0 | 1 ($const \neq ap(flip,const)$), 2 ($id \neq ap(\ldots)$) | 3 |
| 1 | — | 1 |
| 2 | 1, 2, 3 (todas por *clash*) | 4 |
| 3 | — | 1 |
| 4 | 1 ($ap(const,X_1) \neq id$) | 2 |

La única diferencia con nuestra derivación son los intentos fallidos de unificación, que no generan resolventes ni ramas de backtracking (fallan al unificar la cabeza, antes de crear un subobjetivo).

**Chuleta**
> 1. `A * B` = $ap(A,B)$, asocia a izquierda: `const * X * _` = $ap(ap(const,X),Z)$.
> 2. `flip const X Y` →(cl.3) $A = const * Y * X$ →(cl.1) $Z = Y$. `const id X Y`: cl.1/2/3 dan **clash**, así que va por cl.4 → subobjetivo `reduce(const * id * X, M1)` →(cl.1) $M_1 = id$, $B = id * Y$ →(cl.2) $\Box$.
> 3. **Respuesta:** $A = const * Y * X$, $B = id * Y$, $Z = Y$. Es SLD **y** coincide con Prolog (selección izq-der, primera cláusula que unifica).

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 25 — Generación infinita en Prolog

**Enunciado**
El siguiente es un programa escrito en Prolog que define los números naturales, su relación de orden estricto, y un intento fallido de generar todos los pares de naturales.
```prolog
natural(0).
natural(suc(X)) :- natural(X).

mayor(suc(X), X).
mayor(suc(X), Y) :- mayor(X, Y).

parDeNat(X, Y) :- natural(X), natural(Y).
```
Puede observarse que el programa no funciona correctamente, ya que, por ejemplo, la siguiente consulta se cuelga en lugar de arrojar una solución:
`?- parDeNat(X, Y), mayor(X, Y).`
Sin embargo, las definiciones son lógicamente correctas. Veámoslo usando resolución.
a) Convertir la base de conocimientos a forma clausal.
b) Utilizar el método de resolución para hallar una solución a la consulta.
c) La resolución realizada en el punto anterior ¿fue SLD? Justificar. En caso afirmativo, ¿en qué difiere de lo que habría hecho Prolog? En caso contrario, ¿sería posible encontrar una solución mediante resolución SLD? (No es necesario escribirla, solo justificar por qué es o no es posible.)

**Explicacion**
Diferencia entre completitud lógica y la estrategia de búsqueda de Prolog (DFS). SLD es completo si el espacio de búsqueda es finito o si se usa una estrategia de búsqueda completa (como BFS), pero Prolog puede entrar en ramas infinitas.

**Resolucion paso a paso**
**a) Forma clausal**

| # | Cláusula Prolog | Cláusula | Tipo |
|---|---|---|---|
| 1 | `natural(0).` | $\{natural(0)\}$ | hecho |
| 2 | `natural(suc(X)) :- natural(X).` | $\{natural(suc(X)),\ \neg natural(X)\}$ | regla |
| 3 | `mayor(suc(X), X).` | $\{mayor(suc(X),\ X)\}$ | hecho |
| 4 | `mayor(suc(X), Y) :- mayor(X, Y).` | $\{mayor(suc(X),Y),\ \neg mayor(X,Y)\}$ | regla |
| 5 | `parDeNat(X,Y) :- natural(X), natural(Y).` | $\{parDeNat(X,Y),\ \neg natural(X),\ \neg natural(Y)\}$ | regla |

Consulta `?- parDeNat(X,Y), mayor(X,Y).` $\equiv \exists X \exists Y.(parDeNat(X,Y) \wedge mayor(X,Y))$; negada:
$$6.\quad N_0 = \{\neg parDeNat(X_0,Y_0),\ \neg mayor(X_0,Y_0)\}$$

**b) Resolución**

| Paso | Objetivo | Cláusula | mgu |
|---|---|---|---|
| 0 | $\{\neg parDeNat(X_0,Y_0),\ \neg mayor(X_0,Y_0)\}$ | 5 | $\{X := X_0,\ Y := Y_0\}$ |
| 1 | $\{\neg natural(X_0),\ \neg natural(Y_0),\ \neg mayor(X_0,Y_0)\}$ | 3 (sobre $mayor(X_0,Y_0)$) | $\{X_0 := suc(X_3),\ Y_0 := X_3\}$ |
| 2 | $\{\neg natural(suc(X_3)),\ \neg natural(X_3)\}$ | 2 | $\{X_2 := X_3\}$ |
| 3 | $\{\neg natural(X_3)\}$  *(los dos literales colapsan: la cláusula es un **conjunto**)* | 1 | $\{X_3 := 0\}$ |
| 4 | $\Box$ | — | — |

**Sustitución respuesta:** $\{X_3 := 0\}$, y componiendo con el paso 1:
$$\boxed{X = suc(0),\qquad Y = 0}$$
Efectivamente $1 > 0$ y ambos son naturales. $\blacksquare$

**c) ¿Fue SLD? ¿En qué difiere de Prolog?**

**Sí, fue SLD.** Las cinco cláusulas del programa son de definición (un literal positivo cada una) y $N_0$ es una cláusula objetivo; la derivación es lineal y cada paso resuelve un literal seleccionado del objetivo actual contra la cabeza de una cláusula del programa, produciendo otro objetivo.

**Diferencia con Prolog: la regla de selección.** Prolog elige siempre el **primer** literal, así que ataca `natural(X)` y `natural(Y)` antes que `mayor(X,Y)`:

```
?- parDeNat(X,Y), mayor(X,Y).
   natural(X) → X = 0
   natural(Y) → Y = 0
   mayor(0,0) → ✗ falla (0 no unifica con suc(_))
   backtracking sobre natural(Y): Y = suc(0), suc(suc(0)), suc(suc(suc(0))), ...
   mayor(0, Y) falla siempre (X = 0 es el mínimo)
   ... y el generador de Y es infinito ⟹ nunca se vuelve a cambiar X
```

Nosotros seleccionamos primero `mayor(X,Y)`, que no genera sino que **restringe**: el hecho `mayor(suc(X),X)` instancia de un saque el par $(suc(X_3), X_3)$, que ya cumple la relación; los `natural` quedan como verificaciones sobre términos parcialmente instanciados y terminan enseguida.

El programa es entonces **lógicamente correcto** (existe una refutación SLD, y por completitud de SLD para Horn tenía que existir) pero la **estrategia concreta de Prolog** — selección del primer literal + DFS + orden textual de cláusulas — no la encuentra. Con búsqueda BFS, o simplemente reescribiendo la consulta como
```prolog
?- mayor(X, Y), parDeNat(X, Y).
```
Prolog sí responde `X = suc(0), Y = 0`. Es el mismo fenómeno de los Ej. 20, 22 y 23: **restringir antes de generar**.

**Chuleta**
> a) Cada regla `h :- b1,b2.` → $\{h, \neg b_1, \neg b_2\}$; consulta negada → $\{\neg parDeNat(X,Y), \neg mayor(X,Y)\}$.
> b) SLD eligiendo `mayor(X,Y)` primero: hecho $mayor(suc(X_3),X_3)$ instancia $X := suc(X_3)$, $Y := X_3$; después $natural(suc(X_3))$ y $natural(X_3)$ colapsan y cierran con $X_3 := 0$. Respuesta $X = suc(0)$, $Y = 0$.
> c) **Sí es SLD**; difiere de Prolog en la **regla de selección** (Prolog toma el primer literal ⟹ genera `natural` infinitamente y se cuelga). Arreglo: `?- mayor(X,Y), parDeNat(X,Y).`

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/prolog_generar_testear]]

---

### Ejercicio 26 — Paridad y Transitividad

**Enunciado**
a) Representar en forma clausal las siguientes fórmulas de lógica de primer orden referidas a números enteros.
I. $\forall X. (par(X) \Rightarrow \exists Y. (Y > X \wedge \neg par(Y)))$ - Para todo $X$ par existe un impar mayor que él.
II. $\forall X. (\neg par(X) \Rightarrow \exists Y. (Y > X \wedge par(Y)))$ - Para todo $X$ impar existe un par mayor que él.
III. $\forall X. \forall Y. \forall Z. ((X > Y \wedge Y > Z) \Rightarrow X > Z)$ - La relación de mayor es transitiva.

b) Usando resolución demostrar que para todo par existe otro par mayor, es decir, $\forall X. (par(X) \Rightarrow \exists Y. (Y > X \wedge par(Y)))$.
c) Indicar si la demostración es SLD y justificar.

**Explicacion**
Prueba de propiedades en un sistema de enteros con paridad y orden.

**Resolucion paso a paso**
**a) Forma clausal**

**I.** $\forall X.\ (par(X) \Rightarrow \exists Y.(Y > X \wedge \neg par(Y)))$
1. NNF: $\forall X.\ (\neg par(X) \vee \exists Y.(Y > X \wedge \neg par(Y)))$
2. Prenexa y skolemización ($\exists Y$ bajo $\forall X$ ⟹ función $f$): $\forall X.\ (\neg par(X) \vee (f(X) > X \wedge \neg par(f(X))))$
3. CNF y cláusulas:
$$1.\ \{\neg par(X),\ f(X) > X\} \qquad 2.\ \{\neg par(X),\ \neg par(f(X))\}$$

**II.** $\forall X.\ (\neg par(X) \Rightarrow \exists Y.(Y > X \wedge par(Y)))$
1. NNF: $\forall X.\ (par(X) \vee \exists Y.(Y > X \wedge par(Y)))$
2. Skolemización con una función **nueva** $g$: $\forall X.\ (par(X) \vee (g(X) > X \wedge par(g(X))))$
3. Cláusulas:
$$3.\ \{par(X),\ g(X) > X\} \qquad 4.\ \{par(X),\ par(g(X))\}$$

**III.** $\forall X \forall Y \forall Z.\ ((X > Y \wedge Y > Z) \Rightarrow X > Z)$
$$5.\ \{\neg (X > Y),\ \neg (Y > Z),\ X > Z\}$$

*Lectura de las funciones de Skolem:* $f(X)$ es "un impar mayor que $X$" y $g(X)$ es "un par mayor que $X$".

**b) Demostración de $\forall X.(par(X) \Rightarrow \exists Y.(Y > X \wedge par(Y)))$**

Negación de la tesis: $\exists X.\ (par(X) \wedge \forall Y.\ \neg(Y > X \wedge par(Y)))$. Skolemizando $X := a$:
$$6.\ \{par(a)\} \qquad\qquad 7.\ \{\neg(Y > a),\ \neg par(Y)\}$$

**Refutación por resolución general**

| Paso | Cláusulas | mgu | Resolvente |
|---|---|---|---|
| i | 6 y 1 | $\{X := a\}$ | 8. $\{f(a) > a\}$ |
| ii | 6 y 2 | $\{X := a\}$ | 9. $\{\neg par(f(a))\}$ |
| iii | 9 y 3 | $\{X := f(a)\}$ | 10. $\{g(f(a)) > f(a)\}$ |
| iv | 9 y 4 | $\{X := f(a)\}$ | 11. $\{par(g(f(a)))\}$ |
| v | 10 y 5 (1er literal) | $\{X := g(f(a)),\ Y := f(a)\}$ | 12. $\{\neg(f(a) > Z),\ g(f(a)) > Z\}$ |
| vi | 12 y 8 | $\{Z := a\}$ | 13. $\{g(f(a)) > a\}$ |
| vii | 13 y 7 | $\{Y := g(f(a))\}$ | 14. $\{\neg par(g(f(a)))\}$ |
| viii | 14 y 11 | $id$ | $\Box$ |

$\blacksquare$

**Testigo:** el par mayor que $a$ es $g(f(a))$ — *"el par mayor que el impar mayor que $a$"*. El argumento es: $a$ es par ⟹ existe un impar $f(a) > a$ ⟹ existe un par $g(f(a)) > f(a)$ ⟹ por transitividad $g(f(a)) > a$, y es par.

**c) ¿Es SLD la demostración?**

**No, y no puede serlo.** Las cláusulas 3 y 4,
$$\{par(X),\ g(X) > X\} \qquad \{par(X),\ par(g(X))\}$$
tienen **dos literales positivos** cada una ⟹ **no son cláusulas de Horn**. SLD exige que todas las cláusulas de definición tengan exactamente un literal positivo, así que el método no es aplicable a este conjunto.

Independientemente de eso, la derivación de b) tampoco cumple la forma de SLD: los pasos i–iv resuelven pares de cláusulas donde **ninguna es un objetivo** (por ejemplo 6 y 1 son dos cláusulas positivas), y varios resolventes intermedios ($\{f(a)>a\}$, $\{par(g(f(a)))\}$) son cláusulas positivas, no objetivos. Se rompe el invariante "objetivo + definición ⟹ objetivo".

> El origen del problema es semántico: la premisa II dice "*todo impar tiene un par mayor*", y "ser impar" se expresa como $\neg par$, un literal **negativo en el antecedente**, que al pasar al consecuente de la implicación se convierte en un segundo literal positivo. Una relación con negación esencial de este tipo no se puede escribir como programa Prolog puro.

**Chuleta**
> a) I → $\{\neg par(X), f(X)>X\}$ y $\{\neg par(X), \neg par(f(X))\}$ (Skolem $f$ = "impar mayor"). II → $\{par(X), g(X)>X\}$ y $\{par(X), par(g(X))\}$ (Skolem $g$ = "par mayor"). III → $\{\neg(X>Y), \neg(Y>Z), X>Z\}$.
> b) Negar tesis → $\{par(a)\}$, $\{\neg(Y>a), \neg par(Y)\}$. Cadena: $par(a)$ → $f(a)>a$ y $\neg par(f(a))$ → $g(f(a))>f(a)$ y $par(g(f(a)))$ → transitividad → $g(f(a))>a$ → con la tesis negada $\neg par(g(f(a)))$ → $\Box$. Testigo: $g(f(a))$.
> c) **No es SLD**: las cláusulas de II tienen **dos** literales positivos ⟹ no son de Horn.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_por_contradiccion]]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/resolucion_forma_clausal]] · [[tipos_ejercicio/resolucion_por_contradiccion]] · [[tipos_ejercicio/resolucion_sld_justificacion]]
