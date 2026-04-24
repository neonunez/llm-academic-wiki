---
nombre: Circuito con Compuerta Especifica (NOR/NAND restringido)
parcial: 1P
tema: logica_combinatoria
apariciones_en_parciales:
  - parciales_analizados/1P_2C_2024  # Ej3
  - parciales_analizados/1P_2C_2024_recuperatorio  # Ej3
  - parciales_analizados/1P_1C_2025  # Ej2
---

## Como reconocer este patron

El enunciado da una funcion booleana y restricciones sobre las compuertas a usar:
- "$f(A,B,C) = A \cdot B \cdot C$ con 2 compuertas NOR"
- "implementar con unicamente compuertas AND/OR de 2 entradas y NOR"
- Luego suele preguntar: ¿para que valores la funcion devuelve 1/0?

La segunda parte del ejercicio suele ser simplificacion de una expresion compleja → identificar que es una funcion canonica simple (NOR, NAND, XNOR).

## Template de resolucion

**Parte 1 — implementar con compuerta restringida:**

1. Aplicar De Morgan para convertir la funcion a la compuerta objetivo:
   - AND con NOR: $A \cdot B = \overline{\overline{A} + \overline{B}} = \text{NOR}(\overline{A}, \overline{B})$
   - AND con NAND: distribuir → $\text{NAND-de-NAND}$; $(A+B)C = AC+BC = \text{NAND}(\text{NAND}(A,C), \text{NAND}(B,C))$
   - OR con NAND: $A + B = \overline{\overline{A} \cdot \overline{B}} = \text{NAND}(\overline{A}, \overline{B})$
2. Descomponer en cascada si hay mas de 2 entradas

**Parte 2 — simplificar expresion compleja:**

1. Aplicar identidades: $A(B + \bar{B}) = A$, absorcion $A + AB = A$, De Morgan
2. Identificar la forma minimal → tabla de verdad si la simplificacion no es obvia
3. Responder la pregunta ("la funcion devuelve 1 cuando...") enumerando TODOS los casos

**Identidades clave:**
- $\bar{A}\bar{B} = \overline{A+B}$ → usar NOR directamente
- $\bar{A}+\bar{B} = \overline{AB}$ → usar NAND directamente
- $AB + \bar{A}\bar{B} = \overline{A \oplus B}$ (XNOR)

## Por que funciona

De Morgan permite convertir AND en NOR y OR en NAND. La simplificacion algebraica reduce la SDP canonica a una expresion minimal que puede ser una sola compuerta (NOR, NAND, XNOR).

## Apariciones en parciales

- [[parciales_analizados/1P_2C_2024]] — Ejercicio 3: $A \cdot B \cdot C$ con 2 NOR; simplificacion $\overline{((AB)+(\bar{B}A))} \cdot \bar{B}$ → NOR(A,B)
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Ejercicio 3: $(A+B) \cdot C$ con 3 NAND; XNOR $AB + \bar{A}\bar{B}$
- [[parciales_analizados/1P_1C_2025]] — Ejercicio 2: SDP + simplificacion → NOR+AND+OR (3 compuertas)

## Ejercicios que ejemplifican esto

- [[temas/logica_combinatoria_guia]] — Ejercicio 4 (circuitos con NOR/NAND/XOR)
- [[temas/logica_combinatoria_guia]] — Ejercicio 5 (SDP + simplificacion algebraica)
