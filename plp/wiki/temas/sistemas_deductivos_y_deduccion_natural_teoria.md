---
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: sistemas_deductivos_y_deduccion_natural
fuente: raw/clases/teo/4.teo_1P_sistemas_deductivos_&_deduccion_natural.pdf
paginas_relacionadas: ["Deducción Natural", "Lógica Proposicional"]
---

# Sistemas deductivos y Deducción natural para lógica proposicional

## Motivación
Queremos poder hacer afirmaciones matemáticamente precisas sobre programas en distintos lenguajes de programación.
Ejemplos de afirmaciones:
- El tipo `(Bool -> Int)` está sintácticamente bien formado.
- La expresión `map` tiene tipo `((a -> b) -> [a] -> [b])`.
- La expresión `map` tiene tipo `((a -> a) -> [a] -> [a])`.
- La expresión `map` tiene tipo `Bool`.
- El programa `while (true) {}` no termina.
- El resultado de evaluar `(factorial 7)` es `5040`.
- Los algoritmos `quickSort` y `mergeSort` son indistinguibles.

Queremos tener mecanismos para demostrar dichas afirmaciones. En este contexto, las afirmaciones se llaman **juicios**.

## Sistemas deductivos
Un sistema deductivo sirve para razonar acerca de juicios. Está dado por reglas de inferencia, de la forma:
```
<premisa_1>   <premisa_2>  ...  <premisa_n>
------------------------------------------- <nombre de la regla>
              <conclusión>
```

Las reglas que no tienen premisas ($n = 0$) se llaman **axiomas**.
Las premisas son condiciones suficientes para la conclusión.
- **Lectura de arriba hacia abajo**: si tenemos evidencia de que valen las premisas, podemos deducir que vale la conclusión.
- **Lectura de abajo hacia arriba**: si queremos demostrar que vale la conclusión, alcanza con demostrar que valen las premisas.

### Derivación y Juicio Derivable
Una **derivación** es un árbol finito formado por reglas de inferencia. Parte de ciertas premisas y llega a una conclusión.
Un juicio es **derivable** si hay alguna derivación sin premisas que lo concluye.

## Fórmulas de la lógica proposicional
Las fórmulas son las expresiones que se pueden generar a partir de un conjunto infinito de variables proposicionales $\mathcal{P} = \{P, Q, R, \dots\}$ con la siguiente gramática:
$$ \tau, \sigma, \rho, \dots ::= P \mid (\tau \land \sigma) \mid (\tau \Rightarrow \sigma) \mid (\tau \lor \sigma) \mid \bot \mid \neg\tau $$

**Convenciones de notación**:
1. Omitimos los paréntesis más externos de las fórmulas: $\tau \land \neg(\sigma \lor \rho) = (\tau \land \neg(\sigma \lor \rho))$
2. La implicación es asociativa a derecha: $\tau \Rightarrow \sigma \Rightarrow \rho = (\tau \Rightarrow (\sigma \Rightarrow \rho))$
3. Ojo: los conectivos ($\land$, $\lor$) no son conmutativos ni asociativos. $\tau \lor (\sigma \lor \rho) \neq (\tau \lor \sigma) \lor \rho$, $\tau \land \sigma \neq \sigma \land \tau$

## Contextos y Juicios
Un **contexto** es un conjunto finito de fórmulas. Los notamos con letras griegas mayúsculas ($\Gamma, \Delta, \Sigma, \dots$).
Por ejemplo: $\Gamma = \{P \Rightarrow Q, \neg Q\}$. Generalmente omitimos las llaves; p. ej.: $P \Rightarrow Q, \neg Q$.

El sistema de deducción natural predica sobre juicios de la forma:
$$ \underbrace{\Gamma}_{\text{hipótesis}} \vdash \underbrace{\tau}_{\text{tesis}} $$
Informalmente, un juicio afirma que a partir de las hipótesis en el contexto $\Gamma$ es posible deducir la fórmula de la tesis.

## Deducción natural intuicionista (NJ) — reglas completas

### Axioma
$$ \frac{}{\Gamma, \tau \vdash \tau} ax $$

### Reglas de Introducción
- **Conjunción ($\land i$)**:
  $$ \frac{\Gamma \vdash \tau \quad \Gamma \vdash \sigma}{\Gamma \vdash \tau \land \sigma} \land i $$

- **Implicación ($\Rightarrow i$)**:
  $$ \frac{\Gamma, \tau \vdash \sigma}{\Gamma \vdash \tau \Rightarrow \sigma} \Rightarrow i $$

- **Disyunción ($\lor i_1, \lor i_2$)**:
  $$ \frac{\Gamma \vdash \tau}{\Gamma \vdash \tau \lor \sigma} \lor i_1 \quad \frac{\Gamma \vdash \sigma}{\Gamma \vdash \tau \lor \sigma} \lor i_2 $$

- **Negación ($\neg i$ o reducción al absurdo intuicionista)**:
  $$ \frac{\Gamma, \tau \vdash \bot}{\Gamma \vdash \neg\tau} \neg i $$

- **Falsedad ($\bot$)**: No tiene reglas de introducción.

### Reglas de Eliminación
- **Conjunción ($\land e_1, \land e_2$)**:
  $$ \frac{\Gamma \vdash \tau \land \sigma}{\Gamma \vdash \tau} \land e_1 \quad \frac{\Gamma \vdash \tau \land \sigma}{\Gamma \vdash \sigma} \land e_2 $$

- **Implicación ($\Rightarrow e$ o modus ponens)**:
  $$ \frac{\Gamma \vdash \tau \Rightarrow \sigma \quad \Gamma \vdash \tau}{\Gamma \vdash \sigma} \Rightarrow e $$

- **Disyunción ($\lor e$)**:
  $$ \frac{\Gamma \vdash \tau \lor \sigma \quad \Gamma, \tau \vdash \rho \quad \Gamma, \sigma \vdash \rho}{\Gamma \vdash \rho} \lor e $$

- **Falsedad ($\bot e$ o principio de explosión / ex falso quodlibet)**:
  $$ \frac{\Gamma \vdash \bot}{\Gamma \vdash \tau} \bot e $$

- **Negación ($\neg e$)**:
  $$ \frac{\Gamma \vdash \tau \quad \Gamma \vdash \neg\tau}{\Gamma \vdash \bot} \neg e $$

## Propiedades del sistema
**Teorema (Debilitamiento / Weakening)**
Si $\Gamma \vdash \tau$ es derivable, entonces $\Gamma, \sigma \vdash \tau$ es derivable.
$$ \frac{\Gamma \vdash \tau}{\Gamma, \sigma \vdash \tau} W $$
Se puede demostrar por inducción estructural en la derivación.

### Reglas derivadas
- **Modus tollens (MT)**:
  $$ \frac{\Gamma \vdash \tau \Rightarrow \sigma \quad \Gamma \vdash \neg\sigma}{\Gamma \vdash \neg\tau} MT $$

- **Introducción de la doble negación ($\neg\neg i$)**:
  $$ \frac{\Gamma \vdash \tau}{\Gamma \vdash \neg\neg\tau} \neg\neg i $$

## Lógica intuicionista vs. lógica clásica
Dos sistemas deductivos:
- **NJ**: sistema de deducción natural intuicionista.
- **NK**: sistema de deducción natural clásica.

NK extiende a NJ con principios de razonamiento clásicos. Si un juicio es derivable en NJ, también es derivable en NK. NJ es más restrictiva. Para hacer matemática, comúnmente usamos lógica clásica.
Interés de la lógica intuicionista en computación: permite razonar acerca de información. Las derivaciones en NJ se pueden entender como programas (NJ es la base de un lenguaje de programación funcional).

### Principios de razonamiento clásicos (NK)
- **Eliminación de la doble negación ($\neg\neg e$)**:
  $$ \frac{\Gamma \vdash \neg\neg\tau}{\Gamma \vdash \tau} \neg\neg e $$

- **Principio del tercero excluido (LEM - Law of Excluded Middle)**:
  $$ \frac{}{\Gamma \vdash \tau \lor \neg\tau} LEM $$

- **Reducción al absurdo clásico (PBC - Proof by Contradiction)**:
  $$ \frac{\Gamma, \neg\tau \vdash \bot}{\Gamma \vdash \tau} PBC $$

Cualquiera de ellos puede agregarse a NJ para formar NK. Se pueden deducir unos de los otros (ej. usando PBC se puede deducir LEM y viceversa).

## Semántica bivaluada

### Valuaciones
Una **valuación** es una función $v : \mathcal{P} \to \{V, F\}$ que asigna valores de verdad a las variables proposicionales.
Una valuación $v$ satisface una fórmula $\tau$ si $v \models \tau$, donde:
- $v \models P$ si y sólo si $v(P) = V$
- $v \models \tau \land \sigma$ si y sólo si $v \models \tau$ y $v \models \sigma$
- $v \models \tau \Rightarrow \sigma$ si y sólo si $v \not\models \tau$ o $v \models \sigma$
- $v \models \tau \lor \sigma$ si y sólo si $v \models \tau$ o $v \models \sigma$
- $v \models \bot$ nunca vale
- $v \models \neg\tau$ si y sólo si $v \not\models \tau$

Una valuación $v$ satisface un contexto $\Gamma$ ($v \models \Gamma$) si y sólo si $v$ satisface a todas las fórmulas de $\Gamma$.
Un contexto $\Gamma$ satisface una fórmula $\tau$ ($\Gamma \models \tau$) si y sólo si cualquier valuación $v$ que satisface a $\Gamma$ también satisface a $\tau$.

### Corrección y completitud
**Teorema (Corrección y completitud)**
Son equivalentes:
1. $\Gamma \vdash \tau$ es derivable en NK.
2. $\Gamma \models \tau$

**Demostración de corrección** ($\Gamma \vdash_{NK} \tau$ implica $\Gamma \models \tau$): Se demuestra por inducción estructural en la derivación.

**Demostración de completitud** ($\Gamma \models \tau$ implica $\Gamma \vdash_{NK} \tau$):
Se define que un contexto $\Gamma$ determina una variable $P \in \mathcal{P}$ si vale que $P \in \Gamma$ o que $\neg P \in \Gamma$.
Se apoya en el **Lema principal**: Si $\Gamma$ determina a todas las variables que aparecen en $\tau$, entonces:
1. O bien $\Gamma \vdash \tau$ es derivable en NK.
2. O bien $\Gamma \vdash \neg\tau$ es derivable en NK.
Este lema se demuestra por inducción estructural en $\tau$.
