---
nombre: Teoría de Lógica de Primer Orden
parcial: 2P
programa: 2C_2026
tipo: Clase teórica
tema: logica_de_primer_orden
fuente: raw/clases/teo/9.teo_logica_de_primer_orden.pdf
paginas_relacionadas: [[sistemas_deductivos_y_deduccion_natural_teoria]], [[unificacion_e_inferencia_de_tipos_teoria]]
---

# Teoría de Lógica de Primer Orden

La Lógica de Primer Orden (LPO) extiende a la lógica proposicional permitiendo razonar sobre elementos de un universo mediante **términos** y **cuantificadores**. Es el fundamento de la programación lógica (Prolog).

## Sintaxis

### Lenguajes de Primer Orden
Un lenguaje $L$ está dado por:
1. **Símbolos de función ($F$):** Tienen una aridad $n \ge 0$. Las de aridad 0 se llaman **constantes**.
2. **Símbolos de predicado ($P$):** Tienen una aridad $n \ge 0$.

### Términos ($T$)
Se definen inductivamente:
- Una variable $X$ es un término.
- Si $f$ es un símbolo de función de aridad $n$ y $t_1, \dots, t_n$ son términos, entonces $f(t_1, \dots, t_n)$ es un término.

### Fórmulas
Extensión de la gramática proposicional:
$$ \sigma ::= P(t_1, \dots, t_n) \mid \perp \mid \sigma \Rightarrow \sigma \mid \sigma \wedge \sigma \mid \sigma \vee \sigma \mid \neg \sigma \mid \forall X. \sigma \mid \exists X. \sigma $$

- **Variables Libres vs. Ligadas**: Una variable está ligada si está bajo el alcance de un cuantificador.
- **Sustitución**: $\sigma\{X := t\}$ reemplaza las ocurrencias libres de $X$ por el término $t$, evitando la captura de variables.

## Deducción Natural para Primer Orden

Se agregan reglas para los cuantificadores a las ya conocidas de lógica proposicional.

### Cuantificador Universal ($\forall$)
- **Introducción ($\forall i$)**:
  $$ \frac{\Gamma \vdash \sigma}{\Gamma \vdash \forall X. \sigma} \text{ si } X \notin fv(\Gamma) $$
- **Eliminación ($\forall e$)**:
  $$ \frac{\Gamma \vdash \forall X. \sigma}{\Gamma \vdash \sigma\{X := t\}} $$

### Cuantificador Existencial ($\exists$)
- **Introducción ($\exists i$)**:
  $$ \frac{\Gamma \vdash \sigma\{X := t\}}{\Gamma \vdash \exists X. \sigma} $$
- **Eliminación ($\exists e$)**:
  $$ \frac{\Gamma \vdash \exists X. \sigma \quad \Gamma, \sigma \vdash \tau}{\Gamma \vdash \tau} \text{ si } X \notin fv(\Gamma, \tau) $$

## Semántica

### Estructuras y Modelos
Una **estructura** $\mathcal{M} = (M, I)$ consiste en:
- Un universo $M$ (conjunto no vacío).
- Una función de interpretación $I$ que asigna funciones $M^n \to M$ a símbolos de función y subconjuntos $M^n$ a símbolos de predicado.

Una **asignación** $a: X \to M$ permite interpretar términos y fórmulas.

### Resultados Fundamentales
- **Teorema de Gödel (1929)**: Una teoría $T$ es consistente si y solo si tiene un modelo.
- **Corrección y Completitud**: Una fórmula es derivable ($\vdash \sigma$) si y solo si es válida ($\models \sigma$).
- **Problema de la Decisión**: No existe un algoritmo general para decidir la validez de cualquier fórmula de primer orden (es un problema indecidible).

## Unificación de Términos

El algoritmo de unificación busca un **unificador más general (m.g.u.)** para un conjunto de ecuaciones entre términos.

### Reglas de Martelli-Montanari
1. **Delete**: $\{X = X\} \cup E \to E$
2. **Decompose**: $\{f(t_1, \dots, t_n) = f(s_1, \dots, s_n)\} \cup E \to \{t_1 = s_1, \dots, t_n = s_n\} \cup E$
3. **Swap**: $\{t = X\} \cup E \to \{X = t\} \cup E$ (si $t$ no es variable)
4. **Elim**: $\{X = t\} \cup E \to E\{X := t\} \cup \{X = t\}$ (si $X \notin fv(t)$)
5. **Clash**: Falla si $f \neq g$.
6. **Occurs-Check**: Falla si $X \neq t$ y $X \in fv(t)$.
