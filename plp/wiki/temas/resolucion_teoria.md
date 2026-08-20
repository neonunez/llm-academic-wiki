---
nombre: Teoría de Resolución
parcial: 2P
tipo: Clase teórica
tema: Resolución
fuente: plp/raw/clases/teo/10.teo_2P_resolucion_logica.pdf
paginas_relacionadas: [[logica_de_primer_orden_teoria]], [[resolucion_sld_y_prolog_teoria]]
---

# Teoría de Resolución

El método de resolución es un procedimiento de refutación utilizado para determinar la validez de fórmulas lógicas. Es el motor detrás de lenguajes como **Prolog**.

## Introducción y Motivación (Prolog)

En Prolog, un programa es un conjunto de **cláusulas de Horn** (reglas y hechos).
- **Regla**: `σ :- τ1, ..., τn` se interpreta como $\forall \vec{X}. ((\tau_1 \wedge \dots \wedge \tau_n) \Rightarrow \sigma)$.
- **Consulta (Query)**: `?- σ1, ..., σn` se interpreta como $\exists \vec{X}. (\sigma_1 \wedge \dots \wedge \sigma_n)$.

Prolog intenta refutar la negación de la consulta mediante el método de resolución.

---

## Resolución en Lógica Proposicional

Para demostrar que una fórmula $\sigma$ es válida, el método busca demostrar que su negación $\neg \sigma$ es **insatisfactible** ($\neg \sigma \vdash \perp$).

### Pasaje a Forma Clausal
1. **Eliminar implicaciones**: $\sigma \Rightarrow \tau \equiv \neg \sigma \vee \tau$.
2. **Forma Normal Negada (NNF)**: Empujar las negaciones hacia los átomos (Leyes de De Morgan y doble negación).
3. **Forma Normal Conjuntiva (CNF)**: Distribuir la disyunción ($\vee$) sobre la conjunción ($\wedge$).
4. **Notación Clausal**: 
   - Una **cláusula** es un conjunto de literales (ej: $\{P, \neg Q, R\}$).
   - Un conjunto de cláusulas representa la conjunción de las mismas.

### Regla de Resolución
Dadas dos cláusulas con literales complementarios:
$$ \frac{\{P, \ell_1, \dots, \ell_n\} \quad \{\neg P, \ell'_1, \dots, \ell'_m\}}{\{\ell_1, \dots, \ell_n, \ell'_1, \dots, \ell'_m\}} $$
La conclusión se llama **resolvente**. Si se llega a la cláusula vacía ($\square$ o $\{\}$), la fórmula original es insatisfactible.

---

## Resolución en Lógica de Primer Orden

Es un procedimiento de **semi-decisión**: si la fórmula es válida, el método terminará encontrando una refutación. Si no lo es, puede no terminar.

### Pasaje a Forma Clausal (FOL)
1. **Eliminar $\Rightarrow$ y pasar a NNF**.
2. **Forma Normal Prenexa**: Extraer los cuantificadores ($\forall, \exists$) hacia afuera.
3. **Skolemización**: Eliminar cuantificadores existenciales reemplazándolos por funciones de Skolem.
   - $\forall X. \exists Y. \sigma(X, Y) \to \forall X. \sigma(X, f(X))$ (donde $f$ es una función nueva).
   - $\exists Y. \sigma(Y) \to \sigma(c)$ (donde $c$ es una constante nueva).
   - *Nota: La skolemización preserva satisfactibilidad, pero no necesariamente validez.*
4. **Pasar a CNF** y eliminar cuantificadores universales (quedan implícitos).

### Regla de Resolución con Unificación
Dadas dos cláusulas (con variables renombradas para no solaparse):
$$ \frac{\{\sigma_1, \dots, \sigma_p, L_1, \dots, L_n\} \quad \{\neg \tau_1, \dots, \neg \tau_q, L'_1, \dots, L'_m\}}{S(\{L_1, \dots, L_n, L'_1, \dots, L'_m\})} $$
Donde $S = mgu(\sigma_1 = \dots = \sigma_p = \tau_1 = \dots = \tau_q)$.

### Completabilidad
- El método es **refutacionalmente completo**: si un conjunto de cláusulas es insatisfactible, existe una derivación de la cláusula vacía.
- La **Resolución Binaria** (tomar solo un literal de cada lado) NO es completa por sí sola; se requiere la regla general anterior o agregar una regla de **Factorización**.

## Resumen del Algoritmo
1. Negar la fórmula a probar.
2. Pasar a forma clausal (Skolemización incluida en FOL).
3. Aplicar reglas de resolución (con unificación en FOL) hasta obtener $\{\}$ o no poder generar más cláusulas.
