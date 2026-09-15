---
nombre: Lógica proposicional — guía priorizada de entrenamiento
tipo: material_de_estudio
origen: raw/cursada_2C_2026/guias/guia_3_logica_proposicional.pdf
tipo_documento: guia
temas: [sistemas_deductivos_y_deduccion_natural]
parcial: 1P
programa: 2C_2026
generado: 2026-09-14
base_comparacion:
  parciales_analizados: 11
  tipos_ejercicio: 23
ingestado: false
---
# Lógica proposicional — guía priorizada de entrenamiento

**Fuente:** `raw/cursada_2C_2026/guias/guia_3_logica_proposicional.pdf` · **Tema:** `sistemas_deductivos_y_deduccion_natural` → **1P** (programa `2C_2026`)

> La guía es material vigente de `raw/cursada_2C_2026/`. Los ejercicios marcados `⋆` son el
> subconjunto mínimo recomendado por la cátedra. Esta nota no ingesta el PDF ni modifica la wiki:
> organiza el entrenamiento y resuelve sólo el subconjunto priorizado.

## Qué busca entrenar la guía

- Evaluar fórmulas proposicionales y razonar con tautologías, contradicciones y contingencias.
- Probar equivalencias por inducción estructural sobre la fórmula.
- Leer árboles de deducción natural de abajo hacia arriba: la meta determina la regla de introducción.
- Distinguir LJ (intuicionista) de LK/NK (clásica), en especial dónde hacen falta `PBC`, `LEM` o `¬¬e`.
- Usar debilitamiento, corte y el teorema de la deducción como propiedades del sistema, no como pasos de una derivación ordinaria.
- Transferir el mismo patrón a secuentes con `∧`, `∨`, `⇒`, `¬` y `⊥`.

## Plan de trabajo

### Nivel 1 — adquirir la técnica

- **Ej. 2:** traducción estructural a los conectivos `¬` y `∨`.
- **Ej. 5⋆, incisos I–V y VII–XII:** reglas de introducción/eliminación intuicionistas y leyes estructurales.
- **Ej. 7:** debilitamiento, corte e inversa de `⇒i`.

### Nivel 2 — consolidar

- **Ej. 5⋆, inciso VI y Ej. 6⋆:** reconocer exactamente el salto clásico.
- **Ej. 8:** generalizar el teorema de la deducción a una lista de hipótesis.
- **Ej. 9–10:** teoremas cerrados y tautologías como calentamiento antes de los secuentes.

### Nivel 3 — dificultad de parcial

- Rehacer el **Ej. 5⋆** sin mirar la solución, alternando metas positivas, negaciones,
  conjunciones, disyunciones y equivalencias.
- Rehacer **Ej. 6⋆** justificando una única regla clásica en cada prueba.
- Resolver los secuentes de **Ej. 11–13** sólo después de poder nombrar la regla final y las
  descargas de hipótesis. Son una batería de transferencia; los más largos son opcionales para
  el primer recorrido.

### Variantes opcionales

- **Ej. 1, 3 y 4:** semántica y metapropiedades. Sirven para controlar intuiciones, pero no
  aparecen como patrón compilado en los parciales analizados.
- **Ej. 11–13:** práctica masiva de secuentes. Conviene hacer una selección, no repetir los 34
  incisos en una sola sesión.

## Selección rápida

| Ejercicio | Prioridad | Habilidad | Dependencia | Motivo |
|---|---|---|---|---|
| 1 | ⚪ | Evaluación semántica | Tablas de verdad | Prepara el vocabulario, sin patrón propio en los parciales |
| 2 | 🟡 | Inducción estructural de fórmulas | Conectivos y equivalencias | Variante vigente que sostiene el razonamiento semántico |
| 3 | ⚪ | Tautologías bajo hipótesis semánticas | Ej. 1 | Buena transferencia, sin aparición propia |
| 4 | ⚪ | Contrarrecíproco semántico | Inducción estructural | Contexto para entender por qué `¬`/`⇒` son necesarios |
| 5⋆ | 🔴 | Deducción natural proposicional | Reglas LJ/LK | Coincide directamente con el patrón recurrente del 1P |
| 6⋆ | 🟡 | Deducción natural clásica | Ej. 5 | Variante adyacente: el mismo patrón con `PBC`/`LEM` |
| 7 | 🟡 | Metateoremas estructurales | Reglas del sistema | Base para reutilizar derivaciones y para Ej. 8 |
| 8 | 🟡 | Teorema de la deducción iterado | Ej. 7 | Generalización útil para convertir secuentes en teoremas |
| 9 | 🟡 | Teoremas clásicos | Ej. 5–6 | Practica `PBC`/`LEM` en fórmulas cerradas |
| 10 | 🟡 | Tautologías por deducción natural | Ej. 5 | Aplicación corta de reglas intuicionistas |
| 11 | ⚪ | Batería de secuentes LJ | Ej. 5 y 7 | Transferencia extensa; no hace falta en el primer recorrido |
| 12 | ⚪ | Secuentes LJ/LK mixtos | Ej. 6 y 11 | Incluye variantes clásicas y redundancias |
| 13 | ⚪ | Resolución proposicional vía `∨e` | Ej. 5–6 | Consolidación; incluye tres casos clásicos |

---

## 🟡 Ej. 2 — Reescritura usando sólo `¬` y `∨`

### Enunciado

Mostrar que toda fórmula construida con `¬`, `∧`, `∨` y `⇒` puede reescribirse en una fórmula equivalente que use solamente `¬` y `∨`. La sugerencia del PDF pide inducción en la estructura de la fórmula.

### Qué tenés que producir

Una traducción estructural `T` y una prueba de que preserva el valor de verdad para toda valuación.

### Qué conocimiento presupone

La gramática de fórmulas, las equivalencias semánticas de los conectivos y la diferencia entre
“la fórmula usa sólo ciertos conectivos” y “la fórmula es equivalente”.

### Pista de reconocimiento

No conviene reemplazar conectivos de una fórmula concreta. Definí `T` por casos sobre el constructor
exterior de la fórmula.

### Plan de resolución

1. Definir `T` sobre variables y cada conectivo.
2. Probar por inducción estructural que la salida sólo usa `¬` y `∨`.
3. En la misma inducción, probar `v ⊨ φ` si y sólo si `v ⊨ T(φ)`.

### Resolución paso a paso

Definimos:

$$
\begin{aligned}
T(P) &= P,\\
T(\neg\varphi) &= \neg T(\varphi),\\
T(\varphi\vee\psi) &= T(\varphi)\vee T(\psi),\\
T(\varphi\wedge\psi) &= \neg(\neg T(\varphi)\vee\neg T(\psi)),\\
T(\varphi\Rightarrow\psi) &= \neg T(\varphi)\vee T(\psi).
\end{aligned}
$$

- **Sólo aparecen `¬` y `∨`:** el caso base es una variable. En los casos inductivos, las
  subfórmulas ya fueron traducidas por la hipótesis inductiva y las nuevas construcciones usan
  únicamente `¬` y `∨`.
- **Negación y disyunción:** salen directamente de las definiciones y las hipótesis inductivas.
- **Conjunción:**
  $v\models\varphi\wedge\psi$ si y sólo si $v\models\varphi$ y $v\models\psi$; por las
  hipótesis inductivas, esto equivale a que ambas traducciones sean verdaderas; por De Morgan,
  equivale a $v\models\neg(\neg T(\varphi)\vee\neg T(\psi))$.
- **Implicación:** $v\models\varphi\Rightarrow\psi$ si y sólo si $v\not\models\varphi$ o
  $v\models\psi$; por las hipótesis inductivas, esto equivale a
  $v\models\neg T(\varphi)\vee T(\psi)$.

Por inducción, $\varphi$ y $T(\varphi)$ son equivalentes y `T(φ)` sólo usa `¬` y `∨`.

### Control del resultado

Para cada caso inductivo deben aparecer dos cosas: que la salida tiene la gramática restringida
y que preserva satisfacción. Probar sólo las equivalencias de los conectivos no alcanza para
justificar que la traducción funciona sobre fórmulas arbitrarias.

### Si te trabás

1. Mirá el constructor exterior de `φ`.
2. Escribí la hipótesis inductiva para cada subfórmula.
3. Aplicá `¬(¬A∨¬B) ≡ A∧B` y `¬A∨B ≡ A⇒B` en el sentido semántico.

### Variante que conviene intentar

Agregar un caso para `⊥` si la gramática lo incluye: fijada una variable `P`, se puede representar
`⊥` como `¬(P∨¬P)` usando sólo `¬` y `∨`.

### Chuleta

> Constructor exterior → traducir recursivamente → `∧` se vuelve `¬(¬A∨¬B)` → `⇒` se vuelve `¬A∨B` → probar preservación por inducción.

---

## 🔴 Ej. 5⋆ — Teoremas intuicionistas y una equivalencia clásica

### Enunciado

Demostrar en deducción natural los doce teoremas del PDF, sin principios clásicos salvo donde se indique:
modus ponens relativizado; negaciones; De Morgan; conmutatividad y asociatividad de `∧` y `∨`;
contraposición; y adjunción.

### Qué tenés que producir

Árboles de derivación con hipótesis descargadas de forma explícita. En el inciso VI hay que
separar la dirección intuicionista de la dirección clásica.

### Qué conocimiento presupone

Las reglas `⇒i/e`, `∧i/e`, `∨i/e`, `¬i/e`, `⊥e`; la convención
`¬A = A⇒⊥`; y que `A⇔B` abrevia dos implicaciones más una conjunción.

### Pista de reconocimiento

Leer la meta de abajo hacia arriba:

- meta `A⇒B` → asumir `A` y probar `B`;
- meta `¬A` → asumir `A` y buscar `⊥`;
- meta `A∧B` → probar ambos componentes;
- meta `A∨B` → construir un lado conocido;
- hipótesis `A∨B` → abrir dos ramas con `∨e`.

### Plan de resolución

Resolver primero el esqueleto, sin completar detalles: listar las hipótesis, marcar cada descarga
y recién después insertar las eliminaciones.

### Resolución paso a paso

Usá las siguientes derivaciones mínimas como plantillas para todos los incisos.

1. **Modus ponens relativizado**
   $$
   (\rho\Rightarrow\sigma\Rightarrow\tau),\ (\rho\Rightarrow\sigma),\ \rho
   \vdash \sigma\Rightarrow\tau,
   \quad \vdash\sigma,
   \quad \vdash\tau.
   $$
   Descargar primero `ρ`, luego `ρ⇒σ` y finalmente `ρ⇒σ⇒τ` con `⇒i`.

2. **Reducción al absurdo intuicionista**
   Bajo `ρ⇒⊥` y suponiendo `ρ`, aplicar `⇒e` para obtener `⊥`; descargar `ρ` con `¬i` y
   luego la hipótesis externa con `⇒i`.

3. **Introducción de doble negación**
   Suponer `¬ρ` bajo `ρ`; `¬e` produce `⊥`; descargar `¬ρ` para obtener `¬¬ρ` y luego
   descargar `ρ`.

4. **Eliminación de triple negación**
   Bajo `¬¬¬ρ`, para obtener `¬ρ` suponé `ρ`. Con la hipótesis auxiliar `¬ρ` derivá `⊥`,
   luego `¬¬ρ`; finalmente `¬¬¬ρ` y `¬¬ρ` producen `⊥`, y se descargan las hipótesis.

5. **De Morgan I**
   - De `¬(ρ∨σ)`, suponé `ρ` (respectivamente `σ`), introducí `ρ∨σ` y chocá con la
     negación. Construí `¬ρ∧¬σ`.
   - En sentido inverso, suponé `ρ∨σ`; en la rama `ρ` aplicá `¬ρ`, y en la rama `σ` aplicá
     `¬σ`. La disyunción queda en contradicción.

6. **De Morgan II**
   - `¬ρ∨¬σ ⊢ ¬(ρ∧σ)` es intuicionista: suponé `ρ∧σ`, abrí la disyunción y usá la
     componente correspondiente (`ρ` o `σ`) para producir `⊥`.
   - `¬(ρ∧σ) ⊢ ¬ρ∨¬σ` no es intuicionista. En LK, aplicá `LEM` a `ρ`; si vale `¬ρ`,
     introducí la disyunción por la izquierda; si vale `ρ`, suponé `σ`, obtené `ρ∧σ` y
     llegá a `¬σ`, que entra por la derecha.

7. **Conmutatividad de `∧`**
   De `ρ∧σ`, aplicar `∧e₂` y `∧e₁`, y recomponer `σ∧ρ` con `∧i`.

8. **Asociatividad de `∧`**
   En `((ρ∧σ)∧τ)`, extraer `ρ`, `σ` y `τ`; construir `ρ∧(σ∧τ)`. Repetir a la inversa.

9. **Contraposición**
   Bajo `ρ⇒σ`, `¬σ` y suponiendo `ρ`, obtener `σ` y `⊥`. Descargar `ρ` para formar `¬ρ`,
   luego `¬σ` y finalmente `ρ⇒σ`. Es intuicionista.

10. **Adjunción / currificación**
    Para `((ρ∧σ)⇒τ)⇒(ρ⇒σ⇒τ)`, suponé `ρ` y `σ`, formá `ρ∧σ` y aplicá la hipótesis.
    Para la vuelta, suponé `ρ∧σ`, extraé ambas componentes y aplicá la función curried.
    Cerrá las dos direcciones con `∧i` para el bicondicional.

11. **Conmutatividad de `∨`**
    Abrir `ρ∨σ`; en la rama `ρ` introducir `σ∨ρ` por la derecha y en la rama `σ` por la
    izquierda.

12. **Asociatividad de `∨`**
    Abrir la disyunción externa y luego la interna cuando corresponda. En cada rama construir
    `ρ∨(σ∨τ)`; repetir en sentido inverso. Es una `∨e` anidada, no una igualdad sintáctica.

### Control del resultado

- Toda hipótesis auxiliar aparece con una descarga clara.
- El único salto clásico del ejercicio es la dirección `¬(ρ∧σ) ⇒ (¬ρ∨¬σ)`.
- No usar `¬¬e`, `LEM` o `PBC` en los demás incisos.
- En una equivalencia, probar ambas direcciones; no confundir `⇔` con una sola implicación.

### Si te trabás

1. Escribí sólo la última regla posible según la forma de la meta.
2. Si la meta es una negación, asumí su argumento; no intentes fabricar una fórmula positiva.
3. Si aparece una disyunción en hipótesis, `∨e` exige dos ramas con la misma conclusión.
4. En De Morgan II, preguntate si la dirección implicaría tercero excluido.

### Variante que conviene intentar

Escribir los términos de Curry–Howard de I, VII, IX y X: aplicación para `⇒`, par para `∧`
y suma/case para `∨`. La dirección clásica de De Morgan II no tiene término del lambda-cálculo
simplemente tipado puro.

### Chuleta

> Meta determina introducción → hipótesis determina eliminación → descargar en orden → `⊥` permite explosión → usar lógica clásica sólo si la meta positiva no puede construirse en LJ.

---

## 🟡 Ej. 6⋆ — Teoremas clásicos

### Enunciado

Demostrar con lógica clásica las siete fórmulas: absurdo clásico, ley de Peirce, tercero excluido,
consecuencia milagrosa, contraposición clásica, análisis de casos e implicación frente a disyunción.

### Qué tenés que producir

Para cada fórmula, señalar la regla clásica usada. No alcanza con decir “es una tautología”.

### Pista de reconocimiento

- `PBC`: asumir la negación de una meta positiva, llegar a `⊥` y descargarla.
- `LEM`: dividir en `τ` y `¬τ`, probar lo mismo en ambas ramas.
- Una implicación que concluye una negación puede seguir siendo intuicionista; una que elimina
  negaciones suele necesitar el salto clásico.

### Plan de resolución

Separar las fórmulas según la regla clásica mínima. Después reutilizar `¬e`, `⊥e`, `⇒i/e` y
`∨e` dentro de las ramas.

### Resolución paso a paso

1. **Absurdo clásico**
   Bajo `¬τ⇒⊥`, asumir `¬τ`; obtener `⊥` por `⇒e`; aplicar `PBC` para concluir `τ` y
   descargar la hipótesis exterior.

2. **Ley de Peirce**
   Bajo `((τ⇒ρ)⇒τ)`, asumir `¬τ`. Para construir `τ⇒ρ`, asumir `τ`; junto con `¬τ`
   obtener `⊥` y por `⊥e` obtener `ρ`. Aplicar la hipótesis para obtener `τ`, chocarla con
   `¬τ` y aplicar `PBC`. La regla clásica es una sola aplicación de `PBC`.

3. **Tercero excluido**
   Usar `LEM` directamente para `τ∨¬τ` (o derivarlo mediante `PBC`).

4. **Consecuencia milagrosa**
   Bajo `¬τ⇒τ`, asumir `¬τ`; aplicar la hipótesis para obtener `τ`, luego `⊥`; usar `PBC`
   para obtener `τ`.

5. **Contraposición clásica**
   Bajo `¬ρ⇒¬τ`, asumir `τ`; asumir `¬ρ`, obtener `¬τ` y chocar con `τ`; aplicar `PBC`
   para obtener `ρ`. La dirección opuesta, que agrega negaciones, ya era intuicionista en el
   Ej. 5.

6. **Análisis de casos**
   Obtener `τ∨¬τ` por `LEM`. En la rama `τ`, usar `τ⇒ρ`; en la rama `¬τ`, usar
   `¬τ⇒ρ`; cerrar con `∨e` y descargar las dos hipótesis externas.

7. **Implicación vs. disyunción**
   - `¬τ∨ρ ⊢ τ⇒ρ` es intuicionista: abrir la disyunción; en la rama `¬τ`, `τ` da `⊥` y
     luego `ρ`; en la rama `ρ`, usar el axioma.
   - `τ⇒ρ ⊢ ¬τ∨ρ` usa `LEM` sobre `τ`: con `τ`, obtener `ρ` y elegir la derecha; con
     `¬τ`, elegir la izquierda. Combinar ambas direcciones con `∧i`.

### Control del resultado

Anotar al margen `PBC` o `LEM` en cada punto clásico. En particular, no usar la contraposición
clásica para justificar la contraposición del Ej. 5: son direcciones distintas.

### Si te trabás

1. Si la meta es una variable y sólo podés obtener su doble negación, falta `PBC`/`¬¬e`.
2. Si la meta es una disyunción y no sabés qué lado construir, probá `LEM` sobre una fórmula
   relevante.
3. En Peirce, construí primero la implicación auxiliar bajo `¬τ`.

### Variante que conviene intentar

Rehacer I, IV y V con `¬¬e` en vez de `PBC`; el punto exacto donde se vuelve clásica es el salto
de `¬¬τ` a `τ`.

### Chuleta

> Meta positiva difícil → `PBC`; elección entre dos casos → `LEM` + `∨e`; marcar el salto clásico.

---

## 🟡 Ej. 7 — Debilitamiento, corte e inversa de `⇒i`

### Enunciado

Probar: (I) si `Γ⊢σ`, entonces `Γ,τ⊢σ`; (II) si `Γ,τ⊢σ` y `Γ⊢τ`, entonces `Γ⊢σ`; (III) si
`Γ⊢τ⇒σ`, entonces `Γ,τ⊢σ`.

### Qué tenés que producir

Metademostraciones sobre derivaciones. No hay que dibujar una derivación concreta de `σ` sin
conocer cuál es la derivación original.

### Resolución paso a paso

1. **Debilitamiento:** inducción estructural sobre la última regla de la derivación de
   `Γ⊢σ`. En el caso axioma, el mismo `ax` sigue siendo válido con una hipótesis extra. En cada
   regla inductiva se aplica la hipótesis inductiva a todas las premisas y se reaplica la regla.
   En `⇒i`, `¬i` y `∨e`, recordar que el contexto es un conjunto: se agrega `τ` también dentro
   de las subderivaciones y se conserva la descarga original.

2. **Corte:** desde `Γ,τ⊢σ`, aplicar `⇒i` para obtener `Γ⊢τ⇒σ`. Combinarlo con la derivación
   dada `Γ⊢τ` mediante `⇒e` y concluir `Γ⊢σ`. No hace falta inducción.

3. **Inversa de `⇒i`:** debilitar `Γ⊢τ⇒σ` a `Γ,τ⊢τ⇒σ`; usar `ax` para
   `Γ,τ⊢τ`; aplicar `⇒e` y obtener `Γ,τ⊢σ`.

El punto central es el teorema de la deducción:

$$
\Gamma,\tau\vdash\sigma\quad\Longleftrightarrow\quad\Gamma\vdash\tau\Rightarrow\sigma.
$$

### Control del resultado

Distinguir una regla sobre una derivación (debilitamiento) de una nueva derivación (corte). En
corte, `τ` se descarga al construir `τ⇒σ` y luego se consume por `⇒e`.

### Si te trabás

1. Para debilitamiento, mirá la última regla, no la fórmula final.
2. Para corte, convertí primero la hipótesis extra en antecedente de una implicación.
3. Para III, debilitamiento es necesario antes de aplicar `⇒e`.

### Variante que conviene intentar

Escribir el caso inductivo de debilitamiento para `∨e`, que es donde más fácilmente se pierde el
contexto común.

### Chuleta

> Debilitar = transportar una derivación; cortar = abstraer y aplicar; inversa = debilitar + axioma + modus ponens.

---

## 🟡 Ej. 8 — Lista de hipótesis y currificación

### Enunciado

Para `[]⇒*σ = σ` y `[τ₁,…,τₙ]⇒*σ = τ₁⇒([τ₂,…,τₙ]⇒*σ)`, probar por inducción en `n` que
`τ₁,…,τₙ⊢σ` si y sólo si `⊢[τ₁,…,τₙ]⇒*σ`.

### Resolución paso a paso

La inducción debe probar una versión más fuerte:

$$
\forall\Gamma,\sigma,\vec\tau.
\quad \Gamma,\vec\tau\vdash\sigma
\iff
\Gamma\vdash[\vec\tau]\Rightarrow^*\sigma.
$$

- **Base `n=0`:** `[]⇒*σ` es `σ`; ambos lados son `Γ⊢σ`.
- **Paso:** para `[τ₁,…,τₙ₊₁]`, reescribir el contexto como
  `(Γ,τ₁),τ₂,…,τₙ₊₁`. Aplicar la hipótesis inductiva al contexto `Γ,τ₁` y a la lista
  restante. Se obtiene
  `Γ,τ₁⊢[τ₂,…,τₙ₊₁]⇒*σ`. Por el teorema de la deducción esto equivale a
  `Γ⊢τ₁⇒([τ₂,…,τₙ₊₁]⇒*σ)`, que es exactamente la definición de
  `Γ⊢[τ₁,…,τₙ₊₁]⇒*σ`.
- Tomar `Γ=∅` recupera el enunciado del PDF.

### Control del resultado

La hipótesis inductiva debe cuantificar también el contexto `Γ`; si se fija `Γ=∅`, el paso no
permite aplicar la hipótesis al contexto intermedio `Γ,τ₁`.

### Si te trabás

1. Generalizá antes de inducir.
2. Pelá sólo `τ₁`.
3. Aplicá el teorema de la deducción para volver a introducirlo como flecha.

### Variante que conviene intentar

Traducir un secuente con tres hipótesis a
`τ₁⇒τ₂⇒τ₃⇒σ` y reconstruir el contexto mediante la inversa de `⇒i`.

### Chuleta

> Generalizar `Γ` → base vacía → pelar la primera hipótesis → teorema de la deducción → currificación.

---

## 🟡 Ej. 9 — Dos teoremas clásicos adicionales

### Enunciado

Probar:

1. `((P⇒Q)⇒Q)⇒((Q⇒P)⇒P)`.
2. `(P⇒Q)⇒((¬P⇒Q)⇒Q)`.

### Resolución paso a paso

**i.** Llamá `A = (P⇒Q)⇒Q`. Suponé `A` y, para construir la conclusión, suponé
`B = Q⇒P`. Aplicá `LEM` a `P`:

- en la rama `P`, la meta `P` es un axioma;
- en la rama `¬P`, construí `P⇒Q`: suponé `P`, chocá con `¬P`, y obtené `Q` por
  `⊥e`. Aplicá `A` para obtener `Q`; finalmente aplicá `B` a ese `Q` y obtené `P`.

Cerrar con `∨e`, descargar `B` y luego `A`. La prueba es clásica por el `LEM` aplicado a `P`.

**ii.** Suponé `f:P⇒Q` y `g:¬P⇒Q`. Aplicá `LEM` a `P`:

- en la rama `P`, `f` da `Q`;
- en la rama `¬P`, `g` da `Q`.

Cerrar con `∨e` y descargar `g` y `f`.

### Control del resultado

En el inciso i, `B` ya es la función `Q⇒P` que se aplica al `Q` obtenido desde `A`; no hay
que usar `B` para construir su propio antecedente. En ambos incisos, marcar la única división
clásica y todas las descargas.

### Chuleta

> Para `((P⇒Q)⇒Q)⇒((Q⇒P)⇒P)`: asumir las dos funciones → `LEM(P)` → en `¬P`, usar
`A` para fabricar `Q` y `B` para fabricar `P`.

---

## 🟡 Ej. 10 — Tautologías por deducción natural

### Enunciado

Probar:

1. `(P⇒(P⇒Q))⇒(P⇒Q)`.
2. `(R⇒¬Q)⇒((R∧Q)⇒P)`.
3. `((P⇒Q)⇒(R⇒¬Q))⇒¬(R∧Q)`.

### Resolución paso a paso

1. Bajo `f:P⇒(P⇒Q)`, suponé `P`. Para probar `P⇒Q`, suponé una segunda `P`; dos
   aplicaciones de `⇒e` a `f` producen `Q`. Descargar las dos hipótesis `P` y luego `f`.
2. Bajo `f:R⇒¬Q`, suponé `R∧Q`. Extraer `R` y `Q`; `f` produce `¬Q`; `¬e` da `⊥`;
   `⊥e` produce `P`. Descargar `R∧Q` y luego `f`.
3. Bajo `h:(P⇒Q)⇒(R⇒¬Q)`, suponé `R∧Q`. Extraer `R` y `Q`. Construir `P⇒Q`:
   suponé `P` y usá `Q` extraído del par. Aplicar `h` produce `R⇒¬Q`; aplicarlo a `R`
   produce `¬Q`; chocar con `Q` y descargar `R∧Q` mediante `¬i`.

### Control del resultado

El inciso 3 no requiere `PBC`: la `Q` del par alcanza para construir la función `P⇒Q`.

### Chuleta

> Repetir una hipótesis permite dos aplicaciones; un par da sus dos componentes; una
> contradicción dentro de `¬i` cierra la negación.

---

## Ejercicios 11–13 — variantes y batería de secuentes (⚪ contexto)

Se conservan todos porque entrenan la misma mecánica, pero no se resuelven en el primer recorrido.
La cátedra los presenta como ejercicios extra y no hay un patrón separado para cada familia en
`wiki/tipos_ejercicio/`. Usarlos como control después de dominar Ej. 5–10.

### Ejercicio 11 — sin principios clásicos

Resolver por `∨e`/`∧e`/`⇒e`/`¬i` los 14 secuentes del PDF:

- `Q⇒R ⊢ (P∨Q)⇒(P∨R)`;
- `((P∧Q)∧R),(S∧T) ⊢ Q∧S`;
- `((P∧Q)∧R) ⊢ P∧(Q∧R)`;
- `P⇒(P⇒Q),P ⊢ Q`;
- `Q⇒(P⇒R),¬R,Q ⊢ ¬P`;
- `⊢(P∧Q)⇒P`;
- `P⇒¬Q,Q ⊢ ¬P`;
- `P⇒Q ⊢ (P∧R)⇒(Q∧R)`;
- `(P∨Q)∨R ⊢ P∨(Q∨R)`;
- `P∧(Q∨R) ⊢ (P∧Q)∨(P∧R)`;
- `(P∧Q)∨(P∧R) ⊢ P∧(Q∨R)`;
- `¬P∨Q ⊢ P⇒Q`;
- `P⇒Q,P⇒¬Q ⊢ ¬P`;
- `P⇒(Q⇒R),P,¬R ⊢ ¬Q`.

### Ejercicio 12 — secuentes con y sin lógica clásica

Los 11 incisos son:

- `(P∧¬Q)⇒R,¬R,P ⊢ Q`;
- `¬P⇒Q ⊢ ¬Q⇒P`;
- `P∨Q ⊢ R⇒(P∨Q)∧R`;
- `(P∨(Q⇒P))∧Q ⊢ P`;
- `P⇒Q,R⇒S ⊢ (P∧R)⇒(Q∧S)`;
- `P⇒Q ⊢ ((P∧Q)⇒P)∧(P⇒(P∧Q))`;
- `P⇒(Q∧R) ⊢ (P⇒Q)∧(P⇒R)`;
- `(P⇒Q)∧(P⇒R) ⊢ P⇒(Q∧R)`;
- `P∨(P∧Q) ⊢ P`;
- `P⇒(Q∨R),Q⇒S,R⇒S ⊢ P⇒S`;
- `(P∧Q)∨(P∧R) ⊢ P∧(Q∨R)`.

Los incisos I y II necesitan lógica clásica (`PBC`); los otros se resuelven en LJ. Esto es un
buen control de que “meta positiva” no implica automáticamente “lógica clásica”: en IV, IX y XI
la información positiva ya está en las hipótesis.

### Ejercicio 13 — secuentes adicionales

Los 9 incisos son:

- `¬P⇒¬Q ⊢ Q⇒P`;
- `¬P∨¬Q ⊢ ¬(P∧Q)`;
- `¬P,P∨Q ⊢ Q`;
- `P∨Q,¬Q∨R ⊢ P∨R`;
- `P∧¬P ⊢ ¬(R⇒Q)∧(R⇒Q)`;
- `¬(¬P∨Q) ⊢ P`;
- `⊢¬P⇒(P⇒(P⇒Q))`;
- `P∧Q ⊢ ¬(¬P∨¬Q)`;
- `⊢(P⇒Q)∨(Q⇒R)`.

I y VI requieren `PBC`; IX requiere `LEM`; los demás son intuicionistas. El inciso IV es
especialmente valioso como transferencia: la conclusión `P∨R` se obtiene abriendo dos
premisas disyuntivas con `∨e`, es decir, la resolución proposicional aparece como una derivación
natural.

### Cómo usar esta batería

1. Antes de derivar, escribir la forma de la meta y la última regla candidata.
2. Marcar cada hipótesis que se abre y la descarga correspondiente.
3. Si la meta es positiva, buscar primero una hipótesis `∨`, una contradicción o una implicación
   aplicable; sólo después considerar `PBC`/`LEM`.
4. Comparar una derivación de Ej. 11 con la fórmula cerrada equivalente del Ej. 5 usando Ej. 8.

---

## Ejercicios redundantes u opcionales

- **Ej. 1, 3 y 4** — trabajan semántica y metapropiedades; son útiles para comprender, pero no
  tienen un patrón compilado propio en los parciales relevados.
- **Ej. 11–13** — los 34 secuentes son redundantes para el primer recorrido. Elegir luego los
  que fallen al simular un parcial.
- Dentro del **Ej. 5**, las leyes de conmutatividad/asociatividad repiten el mismo esquema de
  introducción y eliminación; hacer una de cada familia en detalle y luego completar las demás.

## Criterio para considerar dominada la guía

- Puedo decidir si una meta pide `⇒i`, `¬i`, `∧i`, `∨i` o una regla clásica antes de empezar.
- Puedo construir y descargar correctamente hipótesis anidadas.
- Puedo distinguir `¬¬ρ` de `ρ` y marcar exactamente cuándo aparece `PBC`, `LEM` o `¬¬e`.
- Puedo probar las dos direcciones de una equivalencia sin confundirlas.
- Puedo demostrar debilitamiento, corte y la inversa de `⇒i` como metateoremas.
- Puedo resolver un secuente con una disyunción en el contexto usando `∨e` en todas sus ramas.
- Puedo explicar por qué la dirección fácil de De Morgan II es intuicionista y la otra no.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Ej. 5⋆ — deducción natural proposicional | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2 · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2b · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2b · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2b | [[tipos_ejercicio/deduccion_natural_intuicionista]] |
| Ej. 6⋆ — variante clásica | 🟡 | Variante adyacente del mismo patrón; sin aparición propia citada | [[tipos_ejercicio/deduccion_natural_intuicionista]] |
| Ej. 7–10 — reglas y teoremas de apoyo | 🟡 | Sin aparición propia; prerequisitos y variaciones vigentes | [[tipos_ejercicio/deduccion_natural_intuicionista]] |

**Base de comparación:** 11 parciales analizados, 23 páginas en `wiki/tipos_ejercicio/`. El
índice de patrones tiene cobertura para `sistemas_deductivos_y_deduccion_natural`; se hizo
drill-down sólo a los cuatro parciales citados por `deduccion_natural_intuicionista`. El quinto
examen citado en esa página, `1.parcial_1C_2024_recuperatorio_resolucion(1)`, está marcado allí
como “no aplica directamente” y no se contó como aparición.

El conteo de cuatro apariciones en parciales distintos hace crítico el patrón; no se infiere
frecuencia para los ejercicios semánticos ni para la batería extra.

## Lo que este documento NO cubre y igual toman

Ningún patrón compilado del mismo tema y parcial queda fuera: el único patrón coincidente,
`[[tipos_ejercicio/deduccion_natural_intuicionista]]`, está cubierto por Ej. 5 y sus variantes
de Ej. 6, 9, 10 y la batería de secuentes. `[[tipos_ejercicio/deduccion_natural_lpo]]` no se
incluye: `programa.md` lo asigna a `logica_de_primer_orden` del 2P, mientras que esta guía es
Deducción Natural proposicional del 1P.

## Divergencias detectadas

- El PDF vigente proviene de `raw/cursada_2C_2026/` y la guía histórica de la wiki proviene de
  `raw/guias_practicas/2.guia_1P_demostracion_en_logica_proposicional.pdf`. La numeración y el
  agrupamiento de los ejercicios extra de la wiki no coinciden completamente con el PDF vigente;
  esta nota conserva el enunciado vigente y no reconcilia la wiki.
- La extracción textual del PDF presenta algunos símbolos desordenados por maquetación (por
  ejemplo, la numeración de varios incisos de Ej. 5). Se normalizó únicamente la numeración a
  partir del orden y del contenido visible del PDF; la fuente no fue modificada.
