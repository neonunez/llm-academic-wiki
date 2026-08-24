---
nombre: LPO — Semántica, interpretaciones y contramodelos
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: logica_de_primer_orden
---

# LPO — Semántica, interpretaciones y contramodelos

## Como reconocer este patron

- El enunciado **da una interpretación** ($D_I$ + qué significan las constantes, funciones y predicados) y pide "hallar asignaciones que satisfagan / que no satisfagan" una fórmula
- Pide decidir si una fórmula es **satisfacible**, **lógicamente válida** o **insatisfacible**
- Dice "demostrar que $\phi$ **no** es lógicamente válida" → hay que **construir un contramodelo**
- Aparecen fórmulas con cuantificadores anidados en distinto orden ($\forall X \exists Y$ vs $\exists Y \forall X$) y se pregunta si una implica la otra
- Palabras clave: *interpretación*, *estructura*, *modelo*, *universo/dominio*, *asignación*, *satisface*, $\models$

## Template de resolucion

### Paso 0 — Escribir el diccionario de la interpretación

Una interpretación (estructura) $\mathcal{M} = (D_I, I)$ es **siempre** estas tres cosas:

| Componente | Qué hay que dar |
|---|---|
| **Dominio** $D_I$ | un conjunto **no vacío** (ej. $\mathbb{N}$, $\mathbb{Z}$, $\{a\}$, $\{0,1\}$) |
| **Interpretación** $I$ | por cada constante $c$: un elemento $c^I \in D_I$ <br> por cada función $f$ de aridad $n$: una función total $f^I : D_I^n \to D_I$ <br> por cada predicado $P$ de aridad $n$: una relación $P^I \subseteq D_I^n$ |
| **Asignación** $a$ | por cada variable **libre** $X$: un valor $a(X) \in D_I$ |

Si la fórmula es **cerrada** (sin variables libres) la asignación no importa: o vale en $\mathcal{M}$ o no vale.

### Paso 1 — Evaluar términos (de adentro hacia afuera)

$$\llbracket X \rrbracket_a = a(X) \qquad \llbracket c \rrbracket_a = c^I \qquad \llbracket f(t_1,\dots,t_n) \rrbracket_a = f^I(\llbracket t_1 \rrbracket_a, \dots, \llbracket t_n \rrbracket_a)$$

### Paso 2 — Evaluar la fórmula (de afuera hacia adentro)

```
ALGORITMO:
1. Atómica:  M,a ⊨ P(t1,...,tn)  sii  (⟦t1⟧a, ..., ⟦tn⟧a) ∈ P^I
2. Conectivos: tabla de verdad usual sobre los valores ya calculados
   M,a ⊨ ¬σ       sii  no vale M,a ⊨ σ
   M,a ⊨ σ ⇒ τ    sii  (no vale σ)  o  (vale τ)
3. Cuantificadores: recorrer el dominio
   M,a ⊨ ∀X.σ     sii  para TODO d ∈ D_I,     M, a[X:=d] ⊨ σ
   M,a ⊨ ∃X.σ     sii  para ALGÚN d ∈ D_I,    M, a[X:=d] ⊨ σ
4. Traducir la fórmula al lenguaje del dominio y resolver la
   ecuación/condición resultante
```

**Truco central:** cuando la interpretación es aritmética, **traducir símbolo por símbolo** y quedarse con una ecuación común. Ej. con $D_I = \mathbb{N}$, $c = 0$, $P = {=}$, $f_1 = \text{suc}$, $f_2 = +$, $f_3 = \times$:

$$P(f_2(X_1,X_1),\ f_3(f_1(X_1), f_1(X_1))) \quad\leadsto\quad 2n = (n+1)^2$$

y ahí se ve de una que **no tiene solución en $\mathbb{N}$** → insatisfacible en esa interpretación.

### Paso 3 — Clasificar (la diferencia operativa)

| Concepto | Definición | Qué hay que exhibir |
|---|---|---|
| **Satisfacible** | existe **algún** $\mathcal{M}$ y **alguna** $a$ con $\mathcal{M},a \models \phi$ | **un** modelo concreto |
| **Válida** ($\models \phi$) | vale en **toda** $\mathcal{M}$ y con **toda** $a$ | una **demostración general** (o derivación en DN / resolución) |
| **Insatisfacible** | no vale en **ninguna** $\mathcal{M}$ con ninguna $a$ | demostración general de $\neg\phi$, o refutación por resolución |
| **NO válida** | existe **un** $\mathcal{M}$, $a$ con $\mathcal{M},a \not\models \phi$ | **un contramodelo** |

Regla de oro de la asimetría:
- Para afirmar **satisfacible** o **NO válida** → basta **un ejemplo**. Barato.
- Para afirmar **válida** o **insatisfacible** → hay que argumentar sobre **todos** los modelos. Caro.
- $\phi$ es válida $\iff$ $\neg\phi$ es insatisfacible.

### Paso 4 — Construir un contramodelo (la técnica que se pide en el parcial)

```
RECETA DE CONTRAMODELO (para mostrar que φ NO es válida):
1. Mirar qué predicados/funciones/constantes aparecen en φ. Sólo esos
   hay que interpretar.
2. Elegir el dominio MÁS CHICO posible:
   - probar primero D_I = {a}         (1 elemento)
   - si con 1 no alcanza, D_I = {a,b}  (2 elementos)
   - casi nunca hace falta más; si sí, usar ℕ con una relación conocida
     (<, ≤, "ser el sucesor de")
3. Definir cada predicado por EXTENSIÓN, listando las tuplas que valen:
   P^I = {(a,a), (a,b)}   ← todo lo que no está en la lista, es falso
4. Instanciar: recorrer a mano cada d ∈ D_I y evaluar φ con la tabla.
5. Mostrar el cálculo que da FALSO. Ese es el contramodelo.
6. Escribir la conclusión: "existe una interpretación donde φ es falsa,
   por lo tanto φ no es lógicamente válida".
```

**Por qué el dominio chico:** con $|D_I| = 1$ los cuantificadores colapsan ($\forall X.\sigma \equiv \exists X.\sigma \equiv \sigma$) y no se puede distinguir nada — sirve para refutar fórmulas que dependen de que haya *dos* cosas distintas. Con $|D_I| = 2$ ya se puede romper casi cualquier fórmula falsa: es el tamaño mínimo donde $\forall$ y $\exists$ dejan de coincidir.

### Paso 5 — El error clásico: orden de los cuantificadores

$$\forall X.\exists Y.\ P(X,Y) \quad\not\Rightarrow\quad \exists Y.\forall X.\ P(X,Y)$$

- $\forall X \exists Y$: "para cada $X$ hay **algún** $Y$ (que puede depender de $X$)"
- $\exists Y \forall X$: "hay **un mismo** $Y$ que sirve para todos los $X$" ← mucho más fuerte

La dirección que **sí** vale siempre es la otra: $\exists Y.\forall X.\ P(X,Y) \Rightarrow \forall X.\exists Y.\ P(X,Y)$.

**Contramodelo concreto sobre los naturales.** Sea $\phi = (\forall X.\exists Y.\ P(X,Y)) \Rightarrow (\exists Y.\forall X.\ P(X,Y))$. Tomo:

- $D_I = \mathbb{N}$
- $P^I = \{(m,n) : m < n\}$, es decir $P(X,Y)$ se lee "$X < Y$"

Evaluación:
- **Antecedente** $\forall X.\exists Y.\ X < Y$: dado $n \in \mathbb{N}$ tomo $Y := n+1$ y vale $n < n+1$. → **verdadero**
- **Consecuente** $\exists Y.\forall X.\ X < Y$: pide un $m \in \mathbb{N}$ que sea mayor que **todos** los naturales, incluido él mismo ($m < m$ es falso). No existe. → **falso**
- Antecedente $\top$ y consecuente $\bot$ ⟹ $\phi$ es **falsa** en esta interpretación.

Por lo tanto $\phi$ **no es lógicamente válida**. $\blacksquare$

*Versión con dominio finito de 2 elementos*, si se pide el modelo más chico: $D_I = \{a,b\}$ con $P^I = \{(a,b),(b,a)\}$. El antecedente vale (para $a$ sirve $b$, para $b$ sirve $a$), pero ningún elemento fijo sirve para los dos ($(a,a) \notin P^I$ y $(b,b) \notin P^I$), así que el consecuente falla.

**Banco de fórmulas para practicar el método** (las dos primeras se refutan con contramodelo; las dos últimas son válidas — trampas clásicas):

| Fórmula | ¿Válida? / Contramodelo mínimo |
|---|---|
| $(\forall X.\ P(X) \vee Q(X)) \Rightarrow (\forall X.P(X)) \vee (\forall X.Q(X))$ | $D_I=\{a,b\}$, $P^I=\{a\}$, $Q^I=\{b\}$ |
| $(\exists X.P(X)) \wedge (\exists X.Q(X)) \Rightarrow \exists X.(P(X) \wedge Q(X))$ | $D_I=\{a,b\}$, $P^I=\{a\}$, $Q^I=\{b\}$ |
| $\exists X.(P(X) \Rightarrow \forall Y.P(Y))$ | **Válida** (dominio no vacío): si todos cumplen $P$, sirve cualquier $X$; si alguno no cumple, ése hace falso el antecedente |
| $(\forall X.\ P(X) \Rightarrow Q(X)) \Rightarrow (\forall X.P(X) \Rightarrow \forall X.Q(X))$ | **Válida** (no confundir con la recíproca, que **no** lo es: $D_I=\{a,b\}$, $P^I=\{a\}$, $Q^I=\emptyset$) |

## Por que funciona

La semántica de LPO es **composicional**: el valor de verdad de una fórmula depende únicamente del valor de sus subfórmulas bajo la asignación corriente. Eso hace que evaluar sea un procedimiento mecánico de abajo hacia arriba, sin creatividad.

La validez es una cuantificación universal sobre **todas** las estructuras posibles — clase que ni siquiera es un conjunto — así que probarla directamente es inviable; por eso existen la deducción natural y la resolución (por **corrección y completitud**, $\vdash \phi \iff \models \phi$). Pero su **negación** es existencial: alcanza con exhibir un solo testigo. Refutar es barato, demostrar es caro, y por eso el enunciado que dice "mostrá que NO es válida" siempre se responde con un contramodelo y nunca con una derivación.

El dominio chico funciona porque una fórmula falsa lo es por una razón estructural (dos elementos que se comportan distinto, un predicado que no es total, un testigo que no es uniforme), y esa razón casi siempre se puede replicar en un universo de 1 o 2 elementos. Sólo cuando la falsedad depende de una **cadena infinita** (como "no hay máximo", el caso de $\forall X \exists Y.\ X<Y$) hace falta un dominio infinito como $\mathbb{N}$.

Ojo con la indecidibilidad: no existe algoritmo general que decida validez en LPO (problema de la decisión). Buscar contramodelos a mano es una heurística, no un método completo.

## Apariciones en parciales

**No hay apariciones reales de este patrón** en los parciales analizados hasta ahora. En los cinco 2P relevados ([[parciales_analizados/2.parcial_1C_2024_resolucion(1)]], [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]], [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]], [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]], [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]]) la Lógica de Primer Orden se evalúa siempre por el lado **sintáctico/deductivo**: formalización, forma clausal + skolemización, resolución por contradicción, justificación de SLD y deducción natural — nunca se pide construir una interpretación ni un contramodelo.

Vale igual como material de estudio: la semántica es lo que da sentido a los conceptos de *válida* / *insatisfacible* que sí se usan en [[tipos_ejercicio/resolucion_por_contradiccion]] y [[tipos_ejercicio/deduccion_natural_lpo]], y el orden de cuantificadores es un error recurrente al formalizar enunciados en lenguaje natural, que **eso sí** aparece en todos los parciales.

## Ejercicios que ejemplifican esto

- [[temas/logica_de_primer_orden_guia]] — **Ejercicio 14** (Semántica aritmética): interpretación $N$ con $D_I = \mathbb{N}$, $c=0$, $P = {=}$, $f_1 = \text{suc}$, $f_2 = +$, $f_3 = \times$; hallar asignaciones que satisfagan y que no. Es el ejercicio que origina esta página.
- [[temas/logica_de_primer_orden_guia]] — **Ejercicio 13** (Semántica en $\mathbb{Z}$): misma mecánica sobre el dominio de los enteros. *(indexado en la guía, resolución pendiente)*
- [[temas/logica_de_primer_orden_guia]] — **Ejercicio 15** (Validez lógica): demostrar que ciertas fórmulas **no** son lógicamente válidas → es literalmente el Paso 4 de esta página. *(indexado en la guía, resolución pendiente)*
- [[temas/logica_de_primer_orden_teoria]] — sección *Semántica*: estructuras, modelos, teorema de Gödel, corrección y completitud.
