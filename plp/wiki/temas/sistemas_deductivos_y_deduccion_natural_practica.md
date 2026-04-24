---
nombre: Sistemas Deductivos y Deducción Natural (Práctica)
parcial: 1
tipo: Clase práctica
tema: Deducción Natural
fuente: raw/clases/prac/3.prac_P1_sistemas_deductivos.pdf
paginas_relacionadas: [[sistemas_deductivos_y_deduccion_natural_teoria]]
---

# Sistemas Deductivos y Deducción Natural — Práctica

Esta clase cubre la aplicación práctica de las reglas de inferencia de la lógica proposicional, diferenciando entre lógica intuicionista y clásica, y las propiedades de los sistemas deductivos.

## Lógica Proposicional: Semántica y Equivalencia

Una proposición $\tau$ es lógicamente equivalente a $\sigma$ si son satisfechas por las mismas valuaciones ($v \vDash \tau \iff v \vDash \sigma$).

**Ejercicio**: Mostrar que $\{\neg, \lor\}$ es un conjunto funcionalmente completo.
- $\tau \land \sigma \equiv \neg(\neg \tau \lor \neg \sigma)$
- $\tau \Rightarrow \sigma \equiv \neg \tau \lor \sigma$

---

## El Sistema de Deducción Natural

Se basa en **secuentes** de la forma $\Gamma \vdash \tau$, donde $\Gamma$ es el contexto (conjunto de premisas) y $\tau$ es la conclusión.

### Reglas de Inferencia (Resumen)

| Conectivo | Introducción | Eliminación |
| :--- | :--- | :--- |
| **Conjunción ($\land$)** | $\frac{\Gamma \vdash \tau \quad \Gamma \vdash \sigma}{\Gamma \vdash \tau \land \sigma} \land_i$ | $\frac{\Gamma \vdash \tau \land \sigma}{\Gamma \vdash \tau} \land_{e1} \quad \frac{\Gamma \vdash \tau \land \sigma}{\Gamma \vdash \sigma} \land_{e2}$ |
| **Implicación ($\Rightarrow$)** | $\frac{\Gamma, \tau \vdash \sigma}{\Gamma \vdash \tau \Rightarrow \sigma} \Rightarrow_i$ | $\frac{\Gamma \vdash \tau \Rightarrow \sigma \quad \Gamma \vdash \tau}{\Gamma \vdash \sigma} \Rightarrow_e$ |
| **Disyunción ($\lor$)** | $\frac{\Gamma \vdash \tau}{\Gamma \vdash \tau \lor \sigma} \lor_{i1} \quad \frac{\Gamma \vdash \sigma}{\Gamma \vdash \tau \lor \sigma} \lor_{i2}$ | $\frac{\Gamma \vdash \tau \lor \sigma \quad \Gamma, \tau \vdash \rho \quad \Gamma, \sigma \vdash \rho}{\Gamma \vdash \rho} \lor_e$ |
| **Negación ($\neg$)** | $\frac{\Gamma, \tau \vdash \perp}{\Gamma \vdash \neg \tau} \neg_i$ | $\frac{\Gamma \vdash \tau \quad \Gamma \vdash \neg \tau}{\Gamma \vdash \perp} \neg_e$ |
| **Falsedad ($\perp$)** | - | $\frac{\Gamma \vdash \perp}{\Gamma \vdash \tau} \perp_e$ |

### Lógica Intuicionista (LJ) vs. Clásica (LK)
- **LJ**: Utiliza solo las reglas básicas anteriores.
- **LK**: Agrega la regla de **Eliminación de la Doble Negación**: $\frac{\Gamma \vdash \neg\neg \tau}{\Gamma \vdash \tau} \neg\neg_e$.

---

## Ejercicios de Derivación

### Teoremas Intuicionistas
Se demuestran sin usar $\neg\neg_e$, $LEM$ o $PBC$.

1. **Introducción de doble negación**: $\rho \Rightarrow \neg\neg \rho$
   - $\rho, \neg\rho \vdash \perp$ por $\neg_e$.
   - $\rho \vdash \neg\neg \rho$ por $\neg_i$ (descargando $\neg\rho$).
   - $\vdash \rho \Rightarrow \neg\neg \rho$ por $\Rightarrow_i$.

2. **Eliminación de triple negación**: $\neg\neg\neg \rho \Rightarrow \neg \rho$
   - Hista: Usar la regla de introducción de doble negación sobre el $\rho$ que se quiere probar.

### Teoremas Clásicos
Requieren obligatoriamente lógica clásica.

1. **Ley de Peirce**: $((\rho \Rightarrow \sigma) \Rightarrow \rho) \Rightarrow \rho$
2. **Análisis de casos**: $(\tau \Rightarrow \sigma) \Rightarrow (\neg \tau \Rightarrow \sigma) \Rightarrow \sigma$
   - Hint: Se puede derivar usando $LEM$ ($\tau \lor \neg \tau$) y luego $\lor_e$.

---

## Propiedades: Debilitamiento (Weakening)

**Enunciado**: Si $\Gamma \vdash \sigma$, entonces $\Gamma, \tau \vdash \sigma$.

**Demostración**: Se realiza por **inducción en la estructura de la derivación**.
- **Caso Base (ax)**: Si la derivación es una instancia de axioma $\Gamma, \sigma \vdash \sigma$, entonces $\Gamma, \tau, \sigma \vdash \sigma$ también es un axioma.
- **Paso Inductivo**: Se analiza cada regla de inferencia. Si la última regla fue $\land_i$, por H.I. los subárboles son válidos con el contexto extendido, y se vuelve a aplicar $\land_i$.

---

## Chuletas para el Examen

> [!TIP]
> **Estrategias de Derivación:**
> 1.  Si la conclusión es $\tau \Rightarrow \sigma$, lo último que hiciste fue $\Rightarrow_i$.
> 2.  Si tienes una disyunción $\tau \lor \sigma$ en las premisas, usa $\lor_e$ lo antes posible.
> 3.  Si te trabas en lógica clásica, intenta empezar con $LEM$ sobre la fórmula que te falta o usa $PBC$ (asumir lo contrario y llegar a $\perp$).

> [!IMPORTANT]
> **Diferencia Crítica**: En lógica intuicionista, de $\neg\neg \tau$ NO puedes pasar a $\tau$. Solo puedes hacerlo en lógica clásica.

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/deduccion_natural_intuicionista]]
