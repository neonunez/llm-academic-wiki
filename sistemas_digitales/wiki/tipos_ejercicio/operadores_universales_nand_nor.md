---
nombre: Universalidad de NAND y NOR
parcial: 1P
programa: 2C_2026
tema: logica_combinatoria
apariciones_en_parciales:
  - parciales_analizados/1P_2C_2024  # Ej2
  - parciales_analizados/1P_2C_2024_recuperatorio  # Ej2
---

## Como reconocer este patron

El enunciado pregunta si un operador solo (NAND o NOR) alcanza para representar todas las funciones booleanas, o si se puede construir NAND con NOR y viceversa. Puede formularse como:
- Demostrar/refutar que X es universal
- Verdadero/Falso: "No es posible representar NOR con NAND" (trampa: es falso)
- Construir NOT, AND, OR con solo NAND o solo NOR

Palabras clave: *universal*, *NAND*, *NOR*, *operador*, *funciones booleanas*.

## Template de resolucion

**Estrategia general:** demostrar universalidad de $X$ = construir {NOT, AND, OR} usando solo $X$.

**NAND es universal:**
$$\overline{A} = A | A$$
$$A \cdot B = (A | B) | (A | B)$$
$$A + B = (A|A) | (B|B)$$

**NOR es universal:**
$$\overline{A} = A \downarrow A$$
$$A + B = (A \downarrow B) \downarrow (A \downarrow B)$$
$$A \cdot B = (A \downarrow A) \downarrow (B \downarrow B)$$

**NAND con NOR** (5 compuertas NOR):
$$\text{NAND}(a,b) = [(a \downarrow a) \downarrow (b \downarrow b)] \downarrow [(a \downarrow a) \downarrow (b \downarrow b)]$$

**NOR con NAND** (5 compuertas NAND):
$$\text{NOR}(a,b) = [(a | a) | (b | b)] | [(a | a) | (b | b)]$$

**Trampa clasica:** "No es posible representar NOR con NAND" → FALSO (siempre son intercambiables).

## Por que funciona

Tanto NAND como NOR son funcionalmente completos porque pueden simular {NOT, AND, OR}, que por el teorema de SDP pueden expresar cualquier funcion booleana.

## Apariciones en parciales

- [[parciales_analizados/1P_2C_2024]] — Ejercicio 2: demostrar que NAND y NOR son universales
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Ejercicio 2: V/F sobre afirmaciones; detectar que "NOR no se puede con NAND" es falso

## Ejercicios que ejemplifican esto

- [[temas/logica_combinatoria_guia]] — Ejercicios 1, 2, 3
