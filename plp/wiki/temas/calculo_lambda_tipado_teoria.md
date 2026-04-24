---
tipo: teoria
tema: Cálculo Lambda Tipado
fuente: raw/clases/teo/5.teo_1P_caculo_lambda.pdf
paginas_relacionadas: ["Cálculo Lambda Tipado"]
---

# Cálculo-λ (Tipado)

El cálculo-$\lambda$ es un lenguaje de programación definido de manera rigurosa que se basa solo en dos operaciones: construir funciones y aplicarlas.
- Es el núcleo de lenguajes de programación funcionales y asistentes de demostración (Lisp, OCaml, Haskell, Coq, Agda, Lean).
- Está fuertemente conectado con la teoría de la demostración, matemática constructiva y teoría de categorías.

## El Cálculo-$\lambda_b$ (con booleanos)

### Sintaxis de los tipos
$$ \tau, \sigma, \rho, \dots ::= \text{bool} \mid \tau \to \sigma $$
Asumimos que el constructor de tipos "$\to$" es **asociativo a derecha**:
$\tau \to \sigma \to \rho = \tau \to (\sigma \to \rho)$

### Sintaxis de los términos
Asumiendo un conjunto infinito numerable de variables $\mathcal{X} = \{x, y, z, \dots\}$:
$$
M, N, P, \dots ::= x \mid \lambda x : \tau . M \mid M N \mid \text{true} \mid \text{false} \mid \text{if } M \text{ then } N \text{ else } P
$$
Asumimos que la aplicación es **asociativa a izquierda**:
$M N P = (M N) P$
La abstracción y el "if" tienen **menor precedencia** que la aplicación:
$\lambda x : \tau . M N = \lambda x : \tau . (M N)$

### Variables libres y ligadas, y Alfa equivalencia
- Ocurrencia **ligada**: aparece adentro de una abstracción "$\lambda x$".
- Ocurrencia **libre**: no está ligada. $fv(M)$ denota el conjunto de variables libres de $M$.
- **Alfa equivalencia**: Los términos que difieren solo en el nombre de variables ligadas se consideran iguales ($\lambda x : \tau . \lambda y : \sigma . x = \lambda a : \tau . \lambda b : \sigma . a$).

### Sistema de tipos
Un **contexto de tipado** $\Gamma$ es un conjunto finito de pares $(x_i : \tau_i)$ sin variables repetidas.
El sistema de tipos predica sobre **juicios de tipado**: $\Gamma \vdash M : \tau$.

**Reglas de tipado:**
$$ \frac{}{\Gamma \vdash \text{true} : \text{bool}} \text{t-true} \quad \frac{}{\Gamma \vdash \text{false} : \text{bool}} \text{t-false} $$

$$ \frac{\Gamma \vdash M : \text{bool} \quad \Gamma \vdash N : \tau \quad \Gamma \vdash P : \tau}{\Gamma \vdash \text{if } M \text{ then } N \text{ else } P : \tau} \text{t-if} $$

$$ \frac{}{\Gamma, x : \tau \vdash x : \tau} \text{t-var} \quad \frac{\Gamma, x : \tau \vdash M : \sigma}{\Gamma \vdash \lambda x : \tau . M : \tau \to \sigma} \text{t-abs} $$

$$ \frac{\Gamma \vdash M : \tau \to \sigma \quad \Gamma \vdash N : \tau}{\Gamma \vdash M N : \sigma} \text{t-app} $$

### Propiedades del sistema de tipos
- **Unicidad de tipos**: Si $\Gamma \vdash M : \tau$ y $\Gamma \vdash M : \sigma$ son derivables, entonces $\tau = \sigma$.
- **Weakening + Strengthening**: Si $\Gamma \vdash M : \tau$ es derivable y $fv(M) \subseteq dom(\Gamma \cap \Gamma')$, entonces $\Gamma' \vdash M : \tau$ es derivable.

## Semántica operacional (small-step)
Un programa es un término $M$ tipable y cerrado ($fv(M) = \emptyset$).
La semántica operacional predica sobre juicios de evaluación $M \to N$ donde $M$ y $N$ son programas.
Los **valores** son los posibles resultados de evaluar programas: $V ::= \text{true} \mid \text{false} \mid \lambda x : \tau . M$.

**Reglas de evaluación para expresiones booleanas:**
$$ \frac{}{\text{if true then } M \text{ else } N \to M} \text{e-ifTrue} \quad \frac{}{\text{if false then } M \text{ else } N \to N} \text{e-ifFalse} $$

$$ \frac{M \to M'}{\text{if } M \text{ then } N \text{ else } P \to \text{if } M' \text{ then } N \text{ else } P} \text{e-if} $$

**Reglas de evaluación para funciones:**
$$ \frac{M \to M'}{M N \to M' N} \text{e-app1} \quad \frac{N \to N'}{(\lambda x : \tau . M) N \to (\lambda x : \tau . M) N'} \text{e-app2} $$

$$ \frac{}{(\lambda x : \tau . M) V \to M\{x := V\}} \text{e-appAbs} $$

### Sustitución
La operación $M\{x := N\}$ denota el término que resulta de reemplazar todas las ocurrencias libres de $x$ en $M$ por $N$, renombrando variables ligadas en caso de conflicto para evitar capturar variables libres de $N$.

### Propiedades de la evaluación
- **Determinismo**: Si $M \to N_1$ y $M \to N_2$ entonces $N_1 = N_2$.
- **Preservación de tipos**: Si $\vdash M : \tau$ y $M \to N$ entonces $\vdash N : \tau$.
- **Progreso**: Si $\vdash M : \tau$ entonces o bien $M$ es un valor, o existe $N$ tal que $M \to N$.
- **Terminación**: Si $\vdash M : \tau$, entonces no hay una cadena infinita de pasos.
- **Canonicidad**: Programas bien tipados de tipo `bool` terminan en `true` o `false`. Los de tipo `tau -> sigma` terminan en abstracciones.

*Slogan: Well typed programs cannot go wrong. (Robin Milner)*

## El Cálculo $\lambda_{bn}$ (extensión con números naturales)

### Sintaxis y Valores
- **Tipos**: $\tau, \sigma, \dots ::= \dots \mid \text{nat}$
- **Términos**: $M ::= \dots \mid \text{zero} \mid \text{succ}(M) \mid \text{pred}(M) \mid \text{isZero}(M)$
- **Valores**: $V ::= \dots \mid \text{zero} \mid \text{succ}(V)$

### Reglas de tipado
$$ \frac{}{\Gamma \vdash \text{zero} : \text{nat}} \text{t-zero} \quad \frac{\Gamma \vdash M : \text{nat}}{\Gamma \vdash \text{succ}(M) : \text{nat}} \text{t-succ} $$

$$ \frac{\Gamma \vdash M : \text{nat}}{\Gamma \vdash \text{pred}(M) : \text{nat}} \text{t-pred} \quad \frac{\Gamma \vdash M : \text{nat}}{\Gamma \vdash \text{isZero}(M) : \text{bool}} \text{t-isZero} $$

### Semántica operacional
$$ \frac{M \to M'}{\text{succ}(M) \to \text{succ}(M')} \text{e-succ} \quad \frac{M \to M'}{\text{pred}(M) \to \text{pred}(M')} \text{e-pred} \quad \frac{}{\text{pred}(\text{succ}(V)) \to V} \text{e-predSucc} $$

$$ \frac{M \to M'}{\text{isZero}(M) \to \text{isZero}(M')} \text{e-isZero} \quad \frac{}{\text{isZero}(\text{zero}) \to \text{true}} \text{e-isZeroZero} \quad \frac{}{\text{isZero}(\text{succ}(V)) \to \text{false}} \text{e-isZeroSucc} $$

*Nota: Una forma normal (f.n.) que no es un valor se llama **término de error** (ej. `pred(zero)` si no se define regla).*
