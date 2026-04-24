---
nombre: Resolución en Lógica — Guia de Ejercicios
parcial: 2P
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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_forma_clausal]]

---

### Ejercicio 2 — Tautologías y Resolución Proposicional

**Enunciado**
I. ¿Cuáles de las fórmulas del ejercicio anterior son tautologías? Demostrarlas utilizando el método de resolución para la lógica proposicional. Para las demás, indicar qué pasa si se intenta demostrarlas usando este método.
II. ¿Se deduce $(P \wedge Q)$ de $(\neg P \Rightarrow Q) \wedge (P \Rightarrow Q) \wedge (\neg P \Rightarrow \neg Q)$? Contestar utilizando el método de resolución para la lógica proposicional.

**Explicacion**
Para demostrar una tautología $\phi$ por resolución, se intenta derivar la cláusula vacía $\Box$ a partir de la negación de la fórmula ($\neg \phi$) en forma clausal. Si se deduce $\Box$, la fórmula original es una tautología (insatisfacibilidad de la negación).

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_contradiccion]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_nnf]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_skolemizacion]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** ⚪ No

---

### Ejercicio 8 — Problema lógico: Smullyan y el jefe de gobierno

**Enunciado**
La computadora de la policía registró que el Sr. Smullyan no pagó una multa. Cuando el Sr. Smullyan pagó la multa, la computadora grabó este hecho pero, como el programa tenía errores, no borró el hecho que expresaba que no había pagado la multa. A partir de la información almacenada en la computadora, mostrar utilizando resolución que el jefe de gobierno es un espía.
Utilizar los siguientes predicados y constantes: $Pagó(X)$ para expresar que $X$ pagó su multa, $Espía(X)$ para $X$ es un espía, **smullyan** para el Sr. Smullyan y **jefeGob** para el jefe de gobierno.

**Explicacion**
Demostración de que una base de conocimiento inconsistente (contiene $A$ y $\neg A$) permite derivar cualquier fórmula (Explosion Principle).

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_validez_resolucion]]

---

### Ejercicio 10 — Aplicaciones del método de resolución

**Enunciado**
I. Expresar en forma clausal la regla del *modus ponens* y mostrar que es válida, usando resolución.
II. Lo mismo para la regla del *modus tollens*.
III. Lo mismo para la regla de especialización: de $\forall X. P(X)$ concluir $P(t)$ cualquiera sea el término $t$.

**Explicacion**
Validación de reglas de inferencia clásicas mediante el marco de resolución.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_reglas_inferencia]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/clausulas_horn]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/resolucion_sld_teoria]]

---

### Ejercicio 13 — Alan el robot (SLD)

**Enunciado**
Alan es un robot japonés. Cualquier robot que puede resolver un problema lógico es inteligente. Todos los robots japoneses pueden resolver todos los problemas de esta práctica. Todos los problemas de esta práctica son lógicos. Existe al menos un problema en esta práctica. ¿Quién es inteligente? Encontrarlo utilizando resolución SLD y composición de sustituciones.
Utilizar los siguientes predicados y constantes: $R(X)$ para expresar que $X$ es un robot, $Res(X, Y)$ para $X$ puede resolver $Y$, $PL(X)$ para $X$ es un problema lógico, $Pr(X)$ para $X$ es un problema de esta práctica, $I(X)$ para $X$ es inteligente, $J(X)$ para $X$ es japonés y la constante **alan** para Alan.

**Explicacion**
Modelado y ejecución de una traza SLD (similar a cómo funcionaría en Prolog) para encontrar una respuesta (answer extraction).

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_resolucion_general_vs_sld]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_errores_unificacion]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_prueba_relaciones]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/prolog_trazas_sld]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/prolog_traza_append_arboles]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/prolog_no_terminacion]]

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
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lpo_resolucion_enteros]]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/resolucion_forma_clausal]] · [[tipos_ejercicio/resolucion_por_contradiccion]] · [[tipos_ejercicio/resolucion_sld_justificacion]]
