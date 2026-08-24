---
nombre: Cálculo Lambda — tipos habitados y construcción del habitante
parcial: 1P
programa: 2C_2026
tipo: tipo_ejercicio
tema: calculo_lambda_tipado
---

# Cálculo Lambda — tipos habitados y construcción del habitante

> Núcleo del tema en **1P** (Cálculo Lambda Tipado). Reaparece en **2P** leído vía **Curry-Howard**: "¿existe un término de tipo $\tau$?" es la misma pregunta que "¿es $\tau$ demostrable en deducción natural intuicionista (NJ)?", y puede venir disfrazado de ejercicio de resolución sobre el predicado $Tipo(M, \tau)$.

## Como reconocer este patron

- Aparece la palabra **habitado** / **habitante**: *"decimos que $\tau$ está habitado si existe $M$ tal que $\vdash M : \tau$"*.
- El enunciado pide **exhibir un término**: *"dar un término cerrado de tipo $\tau$"*, *"demostrar que los siguientes tipos están habitados"*, *"¿existe $M$ tal que $\vdash M : \tau$?"*.
- El tipo dado es **puramente estructural**: sólo variables de tipo ($\sigma, \tau, \rho$) y flechas, sin `Bool` ni `Nat`. Señal fuerte: la respuesta es un **combinador** ($K$, $S$, `flip`, $\circ$).
- Variante negativa: *"¿hay tipos no habitados?"*, *"¿toda tautología es un tipo habitado?"* → la respuesta es **no**, y hay que dar el contraejemplo clásico (Peirce, doble negación, tercero excluido).
- Variante 2P (Curry-Howard): el mismo tipo escrito con $\Rightarrow$ y la consigna *"demostrar en NJ"*; o codificado en lógica de primer orden como $\exists M.\,Tipo(M, \tau)$ para probarlo **por resolución**.

## Template de resolucion

### Receta mecánica: cada $\to$ del tipo es un $\lambda$ del término

```
1. PELAR el tipo de izquierda a derecha (→ asocia a derecha):
   τ₁ → τ₂ → … → τₙ → α
   Escribir un λ por cada flecha del "spine", con su anotación:
   λ x₁:τ₁ . λ x₂:τ₂ . … . λ xₙ:τₙ . ⟨?⟩
   El contexto queda Γ = x₁:τ₁, …, xₙ:τₙ y falta producir ⟨?⟩ : α (α atómico).

2. BUSCAR en Γ quién produce α:
   - ¿alguna xᵢ : α?              → listo, el cuerpo es xᵢ
   - ¿alguna xᵢ : ρ₁ → … → ρₖ → α? → el cuerpo es xᵢ N₁ … Nₖ,
                                      y ahora hay k subproblemas: Nⱼ : ρⱼ

3. RESOLVER cada subproblema recursivamente con los pasos 1-2
   (mismo Γ, posiblemente extendido si ρⱼ es un tipo flecha).

4. ESCRIBIR LA DERIVACIÓN de abajo hacia arriba:
   las aplicaciones con t-app, y luego n usos de t-abs que descargan
   x₁ … xₙ hasta cerrar el juicio ⊢ M : τ.
```

### Los cuatro habitantes que hay que saber de memoria

| Tipo | Habitante | Haskell | Lectura lógica |
|---|---|---|---|
| $\sigma \to \tau \to \sigma$ | $K = \lambda x{:}\sigma.\,\lambda y{:}\tau.\,x$ | `const` | debilitamiento |
| $(\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$ | $S = \lambda f.\,\lambda g.\,\lambda x.\ f\,x\,(g\,x)$ | `(<*>)` | distributividad de $\Rightarrow$ |
| $(\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$ | $\lambda f.\,\lambda y.\,\lambda x.\ f\,x\,y$ | `flip` | permutación de premisas |
| $(\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$ | $\lambda f.\,\lambda g.\,\lambda x.\ f\,(g\,x)$ | `(.)` | transitividad de $\Rightarrow$ |

Bonus: $\sigma \to \sigma$ tiene habitante $I = \lambda x{:}\sigma.\,x$ (identidad / reflexividad).

### Esqueleto de derivación (caso $K$)

$$
\dfrac{
  \dfrac{
    \dfrac{}{x{:}\sigma,\ y{:}\tau \vdash x : \sigma}\ \text{t-var}
  }{x{:}\sigma \vdash \lambda y{:}\tau.\,x : \tau \to \sigma}\ \text{t-abs}
}{\vdash \lambda x{:}\sigma.\,\lambda y{:}\tau.\,x : \sigma \to \tau \to \sigma}\ \text{t-abs}
$$

### Cómo argumentar que un tipo **NO** está habitado

No alcanza con "no se me ocurre". El argumento estándar:

1. Suponer $\vdash M : \tau$ con $M$ **cerrado y en forma normal** (vale por normalización fuerte: si hay habitante, hay uno normal del mismo tipo).
2. Pelar el tipo: $M$ tiene que ser $\lambda x_1 \dots \lambda x_n.\,N$ con $N : \alpha$ atómico bajo $\Gamma = x_1{:}\tau_1, \dots, x_n{:}\tau_n$.
3. $N$ normal y de tipo atómico $\Rightarrow$ $N$ es una **aplicación encabezada por una variable** de $\Gamma$ ($N = x_i\,N_1 \dots N_k$).
4. Revisar los tipos de $\Gamma$: si **ninguna** $x_i$ tiene a $\alpha$ como tipo final de su spine, no hay forma de producir $\alpha$ $\Rightarrow$ **no habitado**.

Caso mínimo: $\sigma \to \tau$ con $\sigma \neq \tau$ variables distintas. El contexto es $x{:}\sigma$ y hace falta un $\tau$: no hay de dónde sacarlo.

## Por que funciona

**Curry-Howard**, tal como está en la teoría: fórmulas $=$ tipos, demostraciones $=$ términos.

| Lógica (NJ) | Cálculo-$\lambda$ tipado |
|---|---|
| Fórmula $\sigma$ | Tipo $\sigma$ |
| $\vdash \sigma$ demostrable | $\sigma$ **habitado**: existe $M$ con $\vdash M : \tau$ |
| Demostración de $\sigma$ | Término $M : \sigma$ |
| Hipótesis (descargadas por $\Rightarrow i$) | Variables ligadas por $\lambda$ |
| $\Rightarrow i$ / $\Rightarrow e$ | t-abs / t-app |
| $\sigma \Rightarrow \tau$ · $\sigma \land \tau$ · $\sigma \lor \tau$ · $\bot$ · $\top$ | $\sigma \to \tau$ · $\sigma \times \tau$ · $\sigma + \tau$ · tipo vacío · Unit |
| Eliminación de cortes | Reducción $\beta$ |

Por eso la receta de arriba funciona: **es literalmente la búsqueda de prueba en NJ**. Pelar flechas $=$ aplicar $\Rightarrow i$ hasta que la meta sea atómica; buscar en $\Gamma$ quién produce la meta $=$ aplicar $\Rightarrow e$ (modus ponens) sobre las hipótesis disponibles.

**La asimetría clave — habitado $\Rightarrow$ tautología, pero NO al revés:**

- **(⟹)** Si $\vdash M : \tau$, entonces $M$ codifica una demostración en NJ de $\tau$, y NJ es correcto respecto de la semántica clásica $\Rightarrow$ $\tau$ es tautología.
- **(⟸ falla)** El cálculo-$\lambda$ simplemente tipado corresponde a NJ, que es **intuicionista**: no tiene tercero excluido ni reducción al absurdo clásica. Hay tautologías clásicas sin habitante.

| Tautología clásica | Como tipo | ¿Habitado? |
|---|---|---|
| $\sigma \Rightarrow \sigma$ | $\sigma \to \sigma$ | ✅ $\lambda x{:}\sigma.\,x$ |
| $\sigma \Rightarrow \tau \Rightarrow \sigma$ | $\sigma \to \tau \to \sigma$ | ✅ $K$ |
| $\sigma \Rightarrow \neg\neg\sigma$ | $\sigma \to ((\sigma \to \bot) \to \bot)$ | ✅ $\lambda x.\,\lambda k.\ k\,x$ |
| $\neg\neg\neg\sigma \Rightarrow \neg\sigma$ | $(((\sigma\to\bot)\to\bot)\to\bot) \to (\sigma\to\bot)$ | ✅ (triple $\to$ simple sí vale) |
| **Ley de Peirce** $((\sigma \Rightarrow \tau) \Rightarrow \sigma) \Rightarrow \sigma$ | $((\sigma \to \tau) \to \sigma) \to \sigma$ | ❌ **NO** |
| **Doble negación** $\neg\neg\sigma \Rightarrow \sigma$ | $((\sigma \to \bot) \to \bot) \to \sigma$ | ❌ **NO** |
| **Tercero excluido** $\sigma \lor \neg\sigma$ | $\sigma + (\sigma \to \bot)$ | ❌ **NO** |
| $\neg(\sigma \land \tau) \Rightarrow \neg\sigma \lor \neg\tau$ (De Morgan) | $((\sigma\times\tau)\to\bot) \to ((\sigma\to\bot) + (\tau\to\bot))$ | ❌ **NO** |
| $\bot$ | tipo vacío | ❌ **NO** (es la consistencia de NJ) |

**Peirce en criollo:** para producir el $\sigma$ final sólo tenés $f : (\sigma \to \tau) \to \sigma$. Para usar $f$ necesitás un $\sigma \to \tau$, o sea saber fabricar un $\tau$ a partir de un $\sigma$ — y $\tau$ es una variable arbitraria de la que no hay ninguna hipótesis. La búsqueda se cicla y nunca cierra.

**Cuidado con `fix`:** al agregar el operador de punto fijo la propiedad se rompe. $\text{fix}\,(\lambda x{:}\tau.\,x) : \tau$ tipa para **cualquier** $\tau$, incluso $\bot$ — todos los tipos pasan a estar "habitados" por términos divergentes y la lógica se vuelve **inconsistente**. Los argumentos de no-habitación valen sólo en el cálculo **sin** `fix` (donde hay normalización fuerte).

## Apariciones en parciales

- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — **Ejercicio 2**: la habitación mecanizada en lógica de primer orden. Se dan las cláusulas $\forall T_1 T_2 M N.\,(Tipo(M, T_1 \to T_2) \land Tipo(N, T_1)) \Rightarrow Tipo(app(M,N), T_2)$ (la regla t-app) más los hechos $\exists M.\,Tipo(M, \alpha \to (\beta \to \gamma))$, $\exists M.\,Tipo(M, \alpha \to \beta)$ y $\exists M.\,Tipo(M, \alpha)$, y el inciso b) pide **probar por resolución que existe un término de tipo $\gamma$**. El habitante que sale de la refutación es $app(app(c, e),\ app(d, e))$ — es decir, $S$ aplicado a las tres constantes de Skolem: $c\,e\,(d\,e)$.

No se detectaron apariciones del patrón en su forma directa ("dar el habitante + derivación de tipado") en los parciales analizados de 1P. Estudiarlo igual: es el puente conceptual entre el Ejercicio 2b de deducción natural (que **sí** cae siempre en 1P, ver [[tipos_ejercicio/deduccion_natural_intuicionista]]) y el tipado del Ejercicio 3.

## Ejercicios que ejemplifican esto

- [[temas/calculo_lambda_guia]] — **Ejercicio 9** ("Tipos habitados"): incisos a) $\sigma \to \tau \to \sigma$ ($K$), b) $(\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$ ($S$), c) $(\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$ (`flip`), d) $(\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$ (composición). Incluye el "para pensar" sobre tipos no habitados y sobre tautologías que no son tipos habitados.
- [[temas/calculo_lambda_guia]] — **Ejercicio 10** (inferencia manual): el reverso de la moneda — juicios *sin solución* por *occurs check* ($x\,x$) o por variable libre fuera del contexto.
- [[temas/calculo_lambda_guia]] — **Ejercicio 11** (debilitamiento y fortalecimiento): justifica formalmente por qué se puede arrastrar el contexto $\Gamma$ mientras se arma el habitante.
- [[temas/correspondencia_curry_howard_y_recursion_teoria]] — tabla fórmulas/tipos y el efecto de `fix` sobre la consistencia.
- [[temas/calculo_lambda_tipado_teoria]] — reglas t-var, t-abs, t-app usadas en cada derivación.
- [[temas/sistemas_deductivos_y_deduccion_natural_guia]] — los mismos enunciados escritos como secuentes intuicionistas.
