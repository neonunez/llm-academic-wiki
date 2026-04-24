---
tipo: teoria
tema: Correspondencia Curry-Howard, Recursión
fuente: raw/clases/teo/6.teo_2P_correspondencia_curry-howard_operador-de-punto-fijo_recursion.pdf
paginas_relacionadas: ["Cálculo Lambda Tipado", "Deducción Natural"]
---

# Correspondencia Curry-Howard y Recursión

La Correspondencia de Curry-Howard establece un puente profundo entre la lógica matemática (teoría de la demostración) y la computación (teoría de tipos).

## Pruebas como Programas, Fórmulas como Tipos

La observación fundamental es que las reglas de tipado del Cálculo-$\lambda$ se corresponden biunívocamente con las reglas de la Deducción Natural (NJ).

| Lógica (Deducción Natural) | Computación (Cálculo-$\lambda$ Tipado) |
| :--- | :--- |
| Fórmula $\sigma$ | Tipo $\sigma$ |
| Demostración $\Psi$ de $\sigma$ | Término $M$ de tipo $\sigma$ ($M : \sigma$) |
| Juicio derivable $\vdash \sigma$ | Tipo habitado (existe $M$ tal que $\vdash M : \sigma$) |
| Hipótesis | Variables libres |
| Implicación $\sigma \Rightarrow \tau$ | Tipo función $\sigma \to \tau$ |
| Conjunción $\sigma \land \tau$ | Tipo producto $\sigma \times \tau$ |
| Disyunción $\sigma \lor \tau$ | Tipo suma $\sigma + \tau$ |
| Absurdo $\perp$ | Tipo vacío $\perp$ |
| Verdadero $\top$ | Tipo unitario $\top$ (Unit) |

### Ejemplo: Identidad
La prueba de $\sigma \Rightarrow \sigma$ mediante el axioma y la introducción de la implicación se corresponde con el término identidad $\lambda x : \sigma . x$.

## Simplificación de Pruebas y Computación

Un **corte** (cut) en una demostración es una regla de introducción seguida inmediatamente por una de eliminación. La **eliminación de cortes** (cut-elimination) es el proceso de simplificar la prueba para obtener una versión directa (sin rodeos).

En computación, esto se corresponde exactamente con la **Reducción $\beta$**:
- Un corte en la implicación ($\Rightarrow i$ seguido de $\Rightarrow e$) se corresponde con la aplicación de una función a un argumento: $(\lambda x : \tau . M) N \to M\{x := N\}$.

### Correspondencia de Conectivos

#### Conjunción $\leftrightarrow$ Producto
- **Introducción ($\land i$)**: Creación de un par $\langle M, N \rangle$.
- **Eliminación ($\land e_1, \land e_2$)**: Proyecciones $fst(M)$ y $snd(M)$.
- **Reducción**: $fst(\langle M, N \rangle) \to M$.

#### Disyunción $\leftrightarrow$ Suma
- **Introducción ($\lor i_1, \lor i_2$)**: Constructores $left_\sigma(M)$ y $right_\tau(M)$.
- **Eliminación ($\lor e$)**: El operador `case M { left(x) -> N || right(y) -> P }`.
- **Reducción**: `case left(V) { ... }` evalúa la rama correspondiente.

#### Absurdo $\leftrightarrow$ Tipo Vacío
- **Eliminación ($\perp e$)**: El operador `case_tau M { }`. Como el tipo $\perp$ no tiene habitantes (constructores), este código se considera inalcanzable en un programa cerrado que termina.

## Consistencia de la Lógica

Gracias a la correspondencia, propiedades como la **Terminación** (Normalización Fuerte) y la **Preservación de Tipos** aseguran que la lógica NJ es consistente. 
- No existe un término cerrado $M$ de tipo $\perp$ en NJ, por lo tanto el juicio $\vdash \perp$ no es derivable.

## Recursión y el Operador de Punto Fijo

Para permitir recursión general en el Cálculo-$\lambda$, se extiende la sintaxis con el operador **fix**:
- **Regla de Tipado**:
  $$ \frac{\Gamma \vdash M : \tau \to \tau}{\Gamma \vdash fix\ M : \tau} t-fix $$
- **Semántica Operacional**:
  $$ fix\ (\lambda x : \tau . M) \to M\{x := fix\ (\lambda x : \tau . M)\} $$

### Impacto en la Lógica
La adición del operador `fix` permite definir funciones parciales y términos que no terminan (como $fix\ (\lambda x : \sigma . x)$). 
**Crítico**: Si se extiende NJ con `fix`, la lógica se vuelve **inconsistente**. Es posible derivar $\vdash fix\ (\lambda x : \perp . x) : \perp$, lo cual rompe la consistencia al permitir demostrar el absurdo.
