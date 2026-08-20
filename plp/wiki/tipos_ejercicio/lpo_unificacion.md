---
nombre: LPO — Unificación de términos y tabla de MGU
parcial: 2P
tipo: tipo_ejercicio
---

# LPO — Unificación de términos y tabla de MGU

> ⚠️ **No confundir con inferencia de tipos.** Acá se unifican **términos de primer orden** (constantes, símbolos de función, predicados, variables). La unificación de **tipos** ($\to$, $\text{Nat}$, $\text{Bool}$) dentro del algoritmo W/I vive en [[tipos_ejercicio/inferencia_algoritmo_w]]. El algoritmo es literalmente el mismo (Martelli-Montanari); cambia el alfabeto: acá $f, g, a, c$ y predicados $P, Q$; allá el constructor binario $\to$ y las constantes de tipo.

## Como reconocer este patron

**Forma explícita (tabla / ejercicio de guía):**
- "Unir con flechas las expresiones que unifican entre sí. Para cada par unificable, exhibir el $mgu$."
- "Calcular el $mgu$ del siguiente conjunto de ecuaciones" / "¿unifican? Si no, justificar."
- Se da un lenguaje con aridades declaradas y dos filas/columnas de átomos y términos a cruzar.

**Forma camuflada (la que realmente aparece en parciales):**
- "Demostrar por resolución… **indicar en cada paso las cláusulas usadas y el $mgu$**".
- Un paso de resolución que se traba: hay que justificar que dos literales complementarios **no** unifican (típicamente por *occurs-check*) para concluir que el conjunto está **saturado** y la fórmula no es válida.
- Justificar por qué una demostración dada es **incorrecta**: casi siempre el error es una sustitución ilegal (sustituir un término no-variable, p. ej. $\{f(X) := c\}$) o saltearse el *occurs-check*.

**Señales sintácticas:** minúsculas = constantes ($a$, $c$, $do$, $pepe$); mayúsculas = variables ($X, Y, Z$); $f, g, n, sec, app, union$ = símbolos de función; $P, Q, \in, \leq, melodia$ = predicados. Si en cambio ves flechas $\to$, $\text{Nat}$, $\text{Bool}$ o $\chi_i$, es inferencia de tipos.

## Template de resolucion

### Paso 0 — Decidir si se renombra (*standardizing apart*)

Antes de tocar nada, fijar la convención, **y escribirla**:

| Lectura | Qué se hace | Consecuencia |
|---|---|---|
| **Variables compartidas** (literal) | $X$ de la fila 1 y $X$ de la fila 2 son **la misma** variable | Aparecen fallos por **occurs-check**: $P(f(X))$ vs. $P(X)$ **no** unifica |
| **Renombre previo** (*standardizing apart*) | Se renombran las variables de un lado: $X \mapsto X'$, $Y \mapsto Y'$ | Esos mismos pares **sí** unifican: $P(f(X))$ vs. $P(X')$ da $mgu = \{X' := f(X)\}$ |

- En una **tabla de unificación** (Ej. 5 de la guía de LPO) la convención del wiki es **variables compartidas**: es la lectura literal del enunciado y es la que hace que el ejercicio tenga fallos interesantes.
- En **resolución y SLD** el renombre es **obligatorio**: cada vez que se usa una cláusula del programa hay que refrescar sus variables ($M_1, N_1, M_2, N_2, \dots$), porque las variables de una cláusula son universales y locales a ella. Sin refrescar aparecen conflictos espurios y demostraciones falsamente bloqueadas.
- En el examen: **anotar explícitamente cuál de las dos lecturas se usa**. Con renombre previo el resultado de la tabla cambia (varios "no unifica" pasan a "unifica").

### Paso 1 — Reglas de Martelli-Montanari

Se trabaja sobre un **conjunto de ecuaciones** $E$ y se aplican reglas hasta llegar a forma resuelta o a falla.

```
DELETE     { X ≐ X } ∪ E              →  E
DECOMPOSE  { f(t₁..tₙ) ≐ f(s₁..sₙ) } ∪ E →  { t₁≐s₁, …, tₙ≐sₙ } ∪ E
SWAP       { t ≐ X } ∪ E              →  { X ≐ t } ∪ E        (t no es variable)
ELIM       { X ≐ t } ∪ E              →  { X ≐ t } ∪ E{X := t} (si X ∉ fv(t))

CLASH          falla si f ≠ g, o si f=g pero con distinta aridad
OCCURS-CHECK   falla si X ≐ t, X ≠ t y X ∈ fv(t)
```

**Forma resuelta:** $E = \{X_1 \doteq t_1, \dots, X_n \doteq t_n\}$ con las $X_i$ **distintas entre sí** y **ninguna $X_i$ apareciendo en ningún $t_j$**. Ese conjunto **es** el $mgu$: $\{X_1 := t_1, \dots, X_n := t_n\}$.

### Paso 2 — Bucle operativo (lo que se escribe en el examen)

```
1. Comparar los símbolos de cabeza de los dos lados.
     distintos (o misma cabeza con distinta aridad) → CLASH → NO unifican
     iguales                                        → DECOMPOSE
2. Ecuación con variable a la derecha y término compuesto a la izquierda → SWAP
3. Ecuación X ≐ t:
     chequear X ∈ fv(t)
       sí → OCCURS-CHECK → NO unifican
       no → ELIM: aplicar {X := t} a TODAS las ecuaciones restantes
            (también a las que todavía no procesaste)
4. Ecuación X ≐ X → DELETE
5. Repetir hasta forma resuelta o falla.
6. VERIFICAR: aplicar la sustitución a ambos términos originales
   y comprobar que quedan sintácticamente idénticos.
```

### Paso 3 — Derivación modelo

$Q(X, f(Z))$ contra $Q(f(Y), X)$ (variables compartidas):

1. $E_0 = \{\, Q(X, f(Z)) \doteq Q(f(Y), X) \,\}$
2. *decompose* ($Q$ vs. $Q$, aridad 2): $E_1 = \{\, X \doteq f(Y),\ f(Z) \doteq X \,\}$
3. *elim* con $X := f(Y)$ — chequeo previo $X \notin fv(f(Y)) = \{Y\}$ $\checkmark$ — y se propaga a la otra ecuación: $E_2 = \{\, X \doteq f(Y),\ f(Z) \doteq f(Y) \,\}$
4. *decompose*: $E_3 = \{\, X \doteq f(Y),\ Z \doteq Y \,\}$
5. Forma resuelta $\Rightarrow mgu = \{X := f(Y),\ Z := Y\}$
6. Verificación: ambos lados quedan $Q(f(Y), f(Y))$ $\checkmark$

### Paso 4 — Las DOS únicas causas de falla

**(a) Clash de símbolos.** Las cabezas no coinciden, o coinciden pero con aridad distinta. Casos típicos:

| Par | Por qué falla |
|---|---|
| $P(f(X))$ vs. $P(g(Z))$ | $f \neq g$ |
| $P(a)$ vs. $P(f(a))$ | constante $a$ (función de aridad 0) contra función $f$ de aridad 1 |
| $P(\dots)$ vs. $Q(\dots)$ | predicados distintos — no hay resolvente posible |
| $P(X)$ vs. $P(X, Y)$ | mismo símbolo, **distinta aridad** |
| $X$ (término) vs. $P(X)$ (átomo) | error de **categoría**: un término no unifica con una fórmula atómica |

Una constante es una función de aridad 0: por eso $a \doteq f(t)$ es un clash y no algo más exótico.

**(b) Occurs-check.** Queda $X \doteq t$ con $X \in fv(t)$ y $X \neq t$. Sustituir generaría un término **infinito**.

| Par | Derivación | Término infinito implicado |
|---|---|---|
| $P(f(X))$ vs. $P(X)$ | *decompose* → $f(X) \doteq X$ → *swap* → $X \doteq f(X)$ | $X = f(f(f(\dots)))$ |
| $Q(X, f(Y))$ vs. $Q(f(Y), Y)$ | $X \doteq f(Y)$, $f(Y) \doteq Y$ → *swap* → $Y \doteq f(Y)$ | $Y = f(f(\dots))$ |
| $R(X, f(X))$ vs. $R(g(Y), Y)$ | $X \doteq g(Y)$, $f(X) \doteq Y$ → $Y \doteq f(g(Y))$ | $Y = f(g(f(g(\dots))))$ |

El tercero es exactamente el que bloquea la refutación de $[\forall X \exists Y. R(X,Y)] \Rightarrow \exists Y \forall X. R(X,Y)$: sin resolventes posibles el conjunto queda **saturado sin llegar a $\square$**, que es la prueba de que la fórmula no es válida.

**Errores que la cátedra busca:**
- Sustituir algo que **no es una variable**: $\sigma = \{f(X) := c\}$ es **ilegal** — una sustitución sólo asigna términos a variables (error plantado en el Ej. 17 de la guía de resolución).
- Aplicar *elim* sin propagar la sustitución a las ecuaciones **que faltan procesar**.
- Olvidar el occurs-check. Prolog real lo **omite** por eficiencia (`X = f(X)` cicla o crea un término cíclico); en el examen, salvo indicación contraria, **sí se chequea**.

## Por que funciona

**Terminación.** Cada regla decrementa una medida bien fundada: *decompose* baja la profundidad de los términos, *elim* **elimina definitivamente** una variable del resto del sistema (por eso el chequeo $X \notin fv(t)$ es imprescindible), *delete* baja la cantidad de ecuaciones. El algoritmo siempre termina: unificación de primer orden es **decidible**.

**Corrección y completitud.** Cada regla preserva el conjunto de unificadores del sistema: $\text{Unif}(E) = \text{Unif}(E')$ en cada paso. Por lo tanto, si el algoritmo llega a forma resuelta, la sustitución leída de ahí unifica los términos originales; y si falla, es porque el sistema equivalente no tiene ningún unificador — un clash pide igualar dos símbolos distintos (imposible en el álgebra de términos, que es libre) y un occurs-check pide un término de profundidad infinita (imposible: los términos son finitos por definición inductiva).

**Por qué es *más general* (MGU).** Si $\sigma$ es el resultado del algoritmo y $\theta$ es cualquier otro unificador, entonces existe $\rho$ tal que $\theta = \rho \circ \sigma$: el algoritmo nunca instancia más de lo estrictamente forzado por las ecuaciones — *elim* usa el término tal cual aparece, sin inventar constantes.

**Unicidad salvo renombre.** Si $\sigma$ y $\theta$ son ambos MGU de $E$, cada uno factoriza al otro, y la única sustitución invertible en el álgebra de términos es un **renombre de variables** (biyección de variables en variables). Consecuencias prácticas:
- $P(Y)$ vs. $P(X)$ admite $\{Y := X\}$ **y** $\{X := Y\}$: ambos son MGU, ambos valen.
- El resultado **no depende del orden** en que se aplican las reglas: si por un camino se llega a éxito, por cualquier otro también, y los MGU obtenidos difieren a lo sumo en un renombre. Si por un camino se falla, se falla por todos.
- En una corrección, un $mgu$ que difiere del esperado sólo por nombres de variables es **correcto**.

**Por qué importa para resolución y Prolog.** La regla de resolución de primer orden es
$$\frac{C_1 \cup \{\sigma_1, \dots, \sigma_p\} \qquad C_2 \cup \{\neg\tau_1, \dots, \neg\tau_q\}}{(C_1 \cup C_2)\,S} \qquad S = mgu(\sigma_1 \doteq \dots \doteq \sigma_p \doteq \tau_1 \doteq \dots \doteq \tau_q)$$
con las variables de $C_1$ y $C_2$ **previamente renombradas**. Usar el MGU (y no un unificador cualquiera) es lo que hace que la resolución sea **completa**: instanciar de más podría cerrar prematuramente una rama que era necesaria. La instanciación de la regla de especialización viene **gratis** con el $mgu$: $\{P(X)\}$ + $\{\neg P(t)\}$ da $\square$ con $mgu = \{X := t\}$, sin ningún paso separado de instanciación.

Ver también [[temas/resolucion_teoria]] y [[temas/logica_de_primer_orden_teoria]].

## Apariciones en parciales

La unificación de términos **nunca aparece como ejercicio aislado** (tipo tabla) en los parciales analizados: siempre viene **subordinada a un ejercicio de resolución o SLD**, donde hay que exhibir el $mgu$ de cada paso o justificar por qué dos literales no unifican. Apariciones reales:

- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 2b: el enunciado pide literalmente *"indicar en cada paso las cláusulas usadas y el mgu"*. Siete pasos con MGU explícitos sobre términos con $app/2$: $\{M \mapsto d,\ T_1 \mapsto \alpha,\ T_2 \mapsto \beta\}$, $\{M_1 \mapsto c,\ T_2 \mapsto (\beta \to \gamma)\}$, $\{N_2 \mapsto app(d,e)\}$, y el cierre $\{M_5 \mapsto app(app(c,e), app(d,e))\}$. La chuleta del propio parcial insiste en el **refresco de variables** ($M_1, N_1, M_2, N_2$) para evitar conflictos espurios.
- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 1b: cada resolvente lleva su unificación anotada: $n(f(C_6))$ contra $n(X_2)$ da $X_2 \leftarrow f(C_6)$; luego $Y_2 \leftarrow c$ y $X_1 \leftarrow f(n(Y_2))$; luego $X_4 \leftarrow f(n(c))$; cierre con $C_5 \leftarrow n(c)$. Unificación anidada contra funciones de Skolem.
- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 1b: MGU explícitos $\{X := \text{pepe},\ Y := K\}$ y $\{Z := R\}$, unificando variables contra **constantes de Skolem**.
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 2c: refutación sobre $vacio/1$ y $pertenece/2$; los MGU no se escriben pero cada resolvente exige unificar $union(\overline{x}, \overline{y})$ contra $union(X_3, Y_3)$ y variables contra constantes de Skolem $\overline{x}, \overline{y}$.
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 2c: el plan de refutación es puro razonamiento de unificación estructural — hacer *match* de $M$ contra $sec(sec(do,do),do)$ y descomponerlo hasta $do$, donde unifica con el hecho $nota(do)$.

**Corolario de estudio:** no hay que prepararse para "una tabla de unificación en el parcial", sino para **no perder puntos en los MGU de la resolución** y para saber justificar un fallo por occurs-check o clash cuando la refutación se satura.

## Ejercicios que ejemplifican esto

- [[temas/logica_de_primer_orden_guia]] — **Ejercicio 5** (tabla de unificación: 8×8 pares, con los tres fallos por occurs-check y los clashes; es el ejercicio que origina esta página)
- [[temas/logica_de_primer_orden_guia]] — Ejercicio 6 (aplicación directa de Martelli-Montanari)
- [[temas/logica_de_primer_orden_guia]] — Ejercicio 7 (propiedades de la unificación: reflexividad, simetría, transitividad)
- [[temas/logica_de_primer_orden_guia]] — Ejercicio 1 (aridades y términos bien formados — prerrequisito: sin aridades no hay clash bien diagnosticado)
- [[temas/logica_de_primer_orden_guia]] — Ejercicio 8 (mismo algoritmo sobre **tipos**; el desarrollo vive en [[tipos_ejercicio/inferencia_algoritmo_w]])
- [[temas/resolucion_guia]] — Ejercicio 7 (resolventes: auto-resolvente con copia renombrada, $mgu = \{Y := f(X)\}$; y por qué la resolución binaria sin factorización no es completa)
- [[temas/resolucion_guia]] — Ejercicio 9 (validez lógica: el ítem II falla por **occurs-check** con $\{R(X,f(X))\}$ y $\{\neg R(g(Y),Y)\}$ → conjunto saturado sin $\square$)
- [[temas/resolucion_guia]] — Ejercicio 10 (especialización: la instanciación viene gratis con el $mgu$)
- [[temas/resolucion_guia]] — Ejercicio 13 (Alan el robot: tabla objetivo / cláusula usada / $mgu$, y composición de MGU restringida a $X_0$)
- [[temas/resolucion_guia]] — Ejercicio 14 (suma y paridad en SLD: $mgu$ contra numerales $suc(suc(cero))$)
- [[temas/resolucion_guia]] — **Ejercicio 17** (Contactos de Facebook: detectar la sustitución **ilegal** $\{f(X) := c\}$ en una demostración dada)
