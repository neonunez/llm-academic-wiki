---
nombre: Resolución — ¿fue SLD? Justificación
parcial: 2P
tipo: tipo_ejercicio
---

# Resolución — ¿fue SLD? Justificación

## Como reconocer este patron

- Después de la resolución, el enunciado pregunta "¿fue resolución SLD? Justificar"
- O pide analizar diferencias entre la resolución manual y cómo Prolog lo haría

## Template de resolucion

**Definición de resolución SLD:**
> La resolución es SLD (Selected Linear Definite) si y solo si:
> 1. **Lineal:** Cada resolvente $R_{i+1}$ se obtiene resolviendo $R_i$ (el resolvente anterior) con una cláusula del programa original
> 2. **Desde el objetivo:** La cadena comienza con la cláusula objetivo (negación de la meta)
> 3. **Cláusulas de Horn:** Todas las cláusulas del programa tienen ≤1 literal positivo

**Plantilla de respuesta:**
```
"La resolución [fue / NO fue] SLD porque:
- [Si sí] Todas las cláusulas son de Horn (≤1 literal positivo),
  la derivación es lineal (cada paso usa el resolvente anterior)
  y comienza desde la cláusula objetivo.
- [Si no] [Una de]:
  a) En el paso N, se resolvieron dos cláusulas de la KB sin usar el
     resolvente anterior (no fue lineal / no fue desde el objetivo)
  b) La cláusula {L1 ∨ L2} tiene dos literales positivos → no es de Horn
  c) No se siguió la estrategia objetivo + definición en todo momento"
```

**Casos frecuentes donde NO es SLD:**
- Cuando la KB tiene una disyunción positiva (ej: `{Libro(K), Radio(K)}`)
- Cuando la resolución fue en árbol (dos ramas que se juntan) en lugar de lineal
- Cuando se resolvieron dos cláusulas del programa entre sí en vez de siempre con el objetivo

## Por que funciona

SLD es la base del motor de Prolog. Si la resolución no es SLD, Prolog no la habría encontrado con su estrategia DFS estándar. Esta pregunta evalúa si el estudiante entiende la diferencia entre resolución general (completa pero no implementada en Prolog) y SLD (incompleta para no-Horn, pero es lo que Prolog usa).

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 1c: SÍ fue SLD (cláusulas de Horn, lineal desde objetivo)
- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 1c: NO fue SLD (cláusula {Libro(K), Radio(K)} no es Horn)
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 2c: NO fue SLD (resolución no fue lineal, se ramificó)
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 2d: NO fue SLD (no fue lineal, retoma resolventes viejos)
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 2d: NO fue SLD (resolución tuvo ramas no lineales)

## Ejercicios que ejemplifican esto

- [[temas/resolucion_guia]] — Ejercicio 11 (identificar cláusulas de Horn)
- [[temas/resolucion_guia]] — Ejercicio 12 (condiciones para resolución SLD)
- [[temas/resolucion_practica]] — Ejercicio 2, Variantes A y B (SLD vs no-SLD)
