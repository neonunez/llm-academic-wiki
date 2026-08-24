---
nombre: Inferencia de Tipos — Clase Practica
parcial: 2P
programa: 2C_2026
tipo: practica
tema: unificacion_e_inferencia
fuente: raw/clases/prac/7.prac_P2_infefencia_de_tipos.pdf
paginas_relacionadas:
  - "[[unificacion_e_inferencia_de_tipos_teoria]]"
---

## Conceptos Clave
La inferencia de tipos busca encontrar el **Tipo Principal** de un término. Un juicio $\Gamma \triangleright M : \tau$ es el más general si cualquier otro juicio válido para $M$ es una instancia de este.

### Algoritmo de Inferencia ($\mathcal{I}$)
El algoritmo recibe un contexto $\Gamma$ y un término $M$, y devuelve un par $(\tau, E)$ donde $\tau$ es el tipo del término y $E$ es un conjunto de ecuaciones (restricciones).
1. **Paso 1: Anotación**: Se etiqueta el término con variables de tipo frescas ($X_1, X_2, \dots$).
2. **Paso 2: Generación de Restricciones ($E$)**: Se recorre el término recursivamente aplicando las reglas.
3. **Paso 3: Unificación**: Se resuelve el sistema de ecuaciones $E$ usando el algoritmo de Unificación (MGU). El tipo final es $S(\tau)$ donde $S$ es el unificador.

---

## Ejercicios de clase

### Ejercicio 1 — Inferencia "a ojo"
Encontrar el juicio de tipado más general para:

a) $\lambda x. y$
b) $f \ \text{true}$
c) $\text{isZero}(x)$

**Resolución:**
- **a) $\lambda x. y$:** Como $x$ no se usa en el cuerpo, su tipo es libre ($X_1$). Como $y$ es una variable libre, su tipo debe estar en el contexto o ser libre ($X_2$).
  - Juicio: $\{y : X_2\} \triangleright \lambda x. y : X_1 \to X_2$.
- **b) $f \ \text{true}$:** $f$ debe ser una función que reciba un `Bool`.
  - Juicio: $\{f : \text{Bool} \to X_1\} \triangleright f \ \text{true} : X_1$.
- **c) $\text{isZero}(x)$:** $x$ debe ser de tipo `Nat`.
  - Juicio: $\{x : \text{Nat}\} \triangleright \text{isZero}(x) : \text{Bool}$.

---

### Ejercicio 2 — Algoritmo $\mathcal{I}$ paso a paso
Calcular $\mathcal{I}(\emptyset \mid \lambda x. \lambda f. f \ x)$.

**Resolución:**
1. **Anotación:** $\lambda x : X_1 . \lambda f : X_2 . f \ x$.
2. **Generación de restricciones:**
   - $\mathcal{I}(\{x:X_1, f:X_2\} \mid f \ x) = (\tau_{app} \mid E_{app})$
   - $\mathcal{I}(\{x:X_1, f:X_2\} \mid f) = (X_2 \mid \emptyset)$
   - $\mathcal{I}(\{x:X_1, f:X_2\} \mid x) = (X_1 \mid \emptyset)$
   - Para la aplicación $f \ x$, generamos $E = \{ X_2 = X_1 \to X_3 \}$ (donas $X_3$ es fresca).
   - El tipo resultante es $X_3$.
3. **Ascenso de los lambdas:**
   - $\mathcal{I}(\emptyset \mid \lambda x. \lambda f. f \ x) = (X_1 \to X_2 \to X_3 \mid \{ X_2 = X_1 \to X_3 \})$.
4. **Unificación:**
   - Resolviendo $X_2 = X_1 \to X_3$, obtenemos la sustitución $S = [X_2 \mapsto X_1 \to X_3]$.
   - Aplicando $S$ al tipo: $X_1 \to (X_1 \to X_3) \to X_3$.
   - **Tipo Principal:** $X_1 \to (X_1 \to X_3) \to X_3$.

---

### Ejercicio 3 — Extensión para Listas
Se agregan las siguientes reglas al algoritmo $\mathcal{I}$:

- **Constructor Vacío:** $\mathcal{I}(\Gamma \mid []_\tau) = ([\tau] \mid \emptyset)$
- **Constructor Cons:** $\mathcal{I}(\Gamma \mid M_1 :: M_2) = (\tau_2 \mid E_1 \cup E_2 \cup \{ \tau_2 = [\tau_1] \})$
  donde $\mathcal{I}(\Gamma \mid M_1) = (\tau_1 \mid E_1)$ y $\mathcal{I}(\Gamma \mid M_2) = (\tau_2 \mid E_2)$.
- **Análisis de Casos (`case`):**
  $\mathcal{I}(\Gamma \mid \text{case } M_1 \text{ of } [] \leadsto M_2 ; h :: t \leadsto M_3) = (\tau_2 \mid E_1 \cup E_2 \cup E_3 \cup \{ \tau_1 = [X_h], \tau_2 = \tau_3 \})$
  donde $X_h$ es fresca, y $M_3$ se analiza en el contexto $\Gamma, h:X_h, t:[X_h]$.

**Ejercicio Práctico:** Inferir el tipo de:
`case succ(0) :: [] of [] -> 0 ; x :: y -> x`

**Resolución:**
1. **Analizar $M_1 = \text{succ}(0) :: []$:**
   - $\mathcal{I}(\Gamma \mid \text{succ}(0)) = (\text{Nat} \mid \emptyset)$
   - $\mathcal{I}(\Gamma \mid []) = ([X_1] \mid \emptyset)$
   - RestricciónCons: $[X_1] = [\text{Nat}] \implies X_1 = \text{Nat}$.
   - Tipo $M_1$: $[\text{Nat}]$.
2. **Analizar rama $M_2 = 0$:**
   - Tipo $M_2$: $\text{Nat}$.
3. **Analizar rama $M_3 = x$:**
   - Contexto: $\{x : X_h, y : [X_h]\}$.
   - Tipo $M_3$: $X_h$.
4. **Restricciones del case:**
   - Tipo $M_1 = [X_h] \implies [\text{Nat}] = [X_h] \implies X_h = \text{Nat}$.
   - Tipo $M_2 = \text{Tipo } M_3 \implies \text{Nat} = X_h$.
5. **Resultado:** El término es válido y tiene tipo **Nat**.

---

## Chuleta de Inferencia
> 1. Cada vez que hay una aplicación $(M \ N)$, surge una ecuación: $Tipo(M) = Tipo(N) \to X_{fresca}$.
> 2. En un `if` o `case`, todas las ramas de resultado deben tener el mismo tipo.
> 3. Las variables libres deben tener tipos consistentes en todo el término.

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/inferencia_algoritmo_w]]
