---
tipo: teoria
tema: Unificación, Inferencia de Tipos
fuente: raw/clases/teo/7.teo_2P_unificacion_inferencia_de_tipos.pdf
paginas_relacionadas: ["Cálculo Lambda Tipado", "Algoritmo W"]
---

# Unificación e Inferencia de Tipos

El problema de inferencia de tipos consiste en determinar si un término sin anotaciones de tipos es tipable y, en caso afirmativo, hallar el contexto, el término anotado y el tipo más general posible.

## El Algoritmo de Unificación (Martelli-Montanari)

La unificación es el proceso de resolver un sistema de ecuaciones entre tipos que contienen incógnitas ($X_1, X_2, \dots$).

### Conceptos Clave
- **Sustitución ($S$)**: Función que asocia incógnitas con tipos.
- **Unificador**: Una sustitución $S$ tal que para cada ecuación $\tau = \sigma$ en el sistema, $S(\tau) = S(\sigma)$.
- **Unificador más general (mgu)**: Un unificador $S$ tal que cualquier otro unificador $S'$ puede obtenerse instanciando $S$ ($S' = T \circ S$).

### Reglas de Martelli-Montanari
Se aplican sobre un conjunto de ecuaciones $E$:
1. **Delete**: $\{X_n = X_n\} \cup E \to E$
2. **Decompose**: $\{C(\tau_1, \dots, \tau_n) = C(\sigma_1, \dots, \sigma_n)\} \cup E \to \{\tau_1 = \sigma_1, \dots, \tau_n = \sigma_n\} \cup E$
3. **Swap**: $\{\tau = X_n\} \cup E \to \{X_n = \tau\} \cup E$ (si $\tau$ no es incógnita).
4. **Elim**: $\{X_n = \tau\} \cup E \to E\{X_n := \tau\}$ (si $X_n \notin fv(\tau)$). La sustitución $\{X_n := \tau\}$ se acumula.
5. **Clash**: $\{C(\dots) = C'(\dots)\} \cup E \to \text{falla}$ (si $C \neq C'$).
6. **Occurs-Check**: $\{X_n = \tau\} \cup E \to \text{falla}$ (si $X_n \in fv(\tau)$ y $X_n \neq \tau$).

## Algoritmo I de Inferencia de Tipos

Dado un término $U$ sin anotaciones, el algoritmo sigue estos pasos:

### 1. Rectificación
Se $\alpha$-renombran las variables para que no haya colisiones de nombres entre variables libres y ligadas, ni entre distintas variables ligadas.

### 2. Anotación
Se produce un contexto $\Gamma_0$ y un término $M_0$ donde cada variable y cada abstracción tiene una incógnita de tipo fresca.
- Ejemplo: $erase(M_0) = U$.

### 3. Generación de Restricciones
Se recorre el término $M_0$ recursivamente para generar un conjunto de ecuaciones $E$:
- **Variables**: Si $(x : \tau) \in \Gamma$, entonces $I(\Gamma \mid x) = (\tau \mid \emptyset)$.
- **Abstracción**: $I(\Gamma \mid \lambda x : \tau . M) = (\tau \to \sigma \mid E)$ donde $I(\Gamma, x : \tau \mid M) = (\sigma \mid E)$.
- **Aplicación**: $I(\Gamma \mid M_1 M_2) = (X_k \mid \{\tau_1 = \tau_2 \to X_k\} \cup E_1 \cup E_2)$ con $X_k$ fresca.
- **Condicional**: $I(\Gamma \mid \text{if } M_1 \text{ then } M_2 \text{ else } M_3) = (\tau_2 \mid \{\tau_1 = \text{Bool}, \tau_2 = \tau_3\} \cup E_1 \cup E_2 \cup E_3)$.

### 4. Unificación
Se calcula $S = mgu(E)$.
- Si el mgu existe, el término es tipable con tipo $S(\tau)$ en el contexto $S(\Gamma_0)$.
- Si no existe, el término no es tipable.

## Propiedades
- **Corrección**: Si el algoritmo termina con éxito, el juicio obtenido es válido y es el **más general posible** (Principal Type).
- **Terminación**: El algoritmo de unificación siempre termina reduciendo una métrica (n1: incógnitas, n2: tamaño, n3: swaps).
