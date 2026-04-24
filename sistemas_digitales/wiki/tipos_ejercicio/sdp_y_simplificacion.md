---
nombre: Suma de Productos y Simplificacion Algebraica
parcial: 1P
tema: logica_combinatoria
apariciones_en_parciales:
  - parciales_analizados/1P_1C_2025  # Ej2
---

## Como reconocer este patron

El enunciado da una tabla de verdad (o definicion de funcion por casos) y pide:
1. Escribir la SDP (suma de productos canonica)
2. Contar compuertas de la implementacion literal
3. Simplificar algebraicamente
4. Dibujar el circuito simplificado

Palabras clave: *suma de productos*, *SDP*, *minterminos*, *simplificacion*, *compuertas*.

## Template de resolucion

**Paso 1 — SDP canonica:**
- Para cada fila con $f=1$: escribir el AND de todas las variables (negada si vale 0 en esa fila)
- OR de todos los minterminos

**Paso 2 — Contar compuertas literales:**
- $m$ minterminos de $k$ variables: $m(k-1)$ AND + $k$ NOT + $(m-1)$ OR

**Paso 3 — Simplificar:**
- Buscar pares de minterminos que difieran en una sola variable: $X\bar{Y} + XY = X$
- Aplicar distributing: $A\bar{B}(\bar{C}+C) = A\bar{B}$
- Aplicar De Morgan cuando aparezca $\bar{A}\bar{B}$: usar NOR directamente

**Paso 4 — Circuito:**
- Dibujar de afuera hacia adentro (OR final, luego AND, luego NOT)
- Verificar con un punto de prueba de la tabla original

## Por que funciona

La SDP es una forma normal — todo se puede expresar como OR de AND de literales. La simplificacion reduce el numero de terminos explotando el complemento ($Y + \bar{Y} = 1$) y la absorcion.

## Apariciones en parciales

- [[parciales_analizados/1P_1C_2025]] — Ejercicio 2: tabla de verdad F(A,B,C) → SDP 13 compuertas → simplificacion → $\bar{A}\bar{B} + AC$ → 3 compuertas con NOR+AND+OR

## Ejercicios que ejemplifican esto

- [[temas/logica_combinatoria_guia]] — Ejercicio 5 (F y G con SDP + simplificacion)
- [[temas/logica_combinatoria_guia]] — Ejercicio 2 (expresabilidad del algebra de Boole)
