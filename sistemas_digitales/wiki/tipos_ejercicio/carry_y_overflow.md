---
nombre: Carry y Overflow en Complemento a Dos
parcial: 1P
tema: representacion_de_informacion
apariciones_en_parciales:
  - parciales_analizados/1P_2C_2024  # Ej1
  - parciales_analizados/1P_2C_2024_recuperatorio  # Ej1
  - parciales_analizados/1P_1C_2025  # Ej1
---

## Como reconocer este patron

El enunciado pide:
- Definir o detectar carry y overflow en una suma de k bits
- Indicar si el resultado de una suma/resta en C2 es representable
- Dar pares de numeros con combinaciones de carry/overflow
- Calcular flags de ALU (C, V, Z, N) para operaciones dadas

Palabras clave: *carry*, *overflow*, *desbordamiento*, *representable*, *flags*, *acarreo*.

## Template de resolucion

**Carry (C):**
- Suma: bit extra que "sale" por la izquierda del ancho disponible
- Resta (implementada como suma): $C = 1$ si hubo borrow
- Formula: $C_k = (a_k \cdot b_k) + (C_{k-1} \cdot (a_k + b_k))$

**Overflow (V) en C2:**
- Regla de signo: mismo signo en operandos + signo opuesto en resultado
  - POS + POS = NEG → overflow
  - NEG + NEG = POS → overflow
  - Signos distintos → NUNCA overflow
- Formula: $V = C_{out} \oplus C_{in}$ (XOR de carries entrante y saliente del bit de signo)

**Flags ALU completos:**
- C = carry/borrow
- V = overflow (mismo signo → signo opuesto)
- Z = resultado == 0
- N = MSB del resultado == 1

**Distincion clave:** carry ≠ overflow. En C2, el carry puede ser correcto (ej: suma de dos negativos). Solo el overflow indica error semantico.

## Por que funciona

El carry es un fenomeno fisico (el resultado necesita un bit mas). El overflow es semantico (el resultado no cabe en el rango con signo del tipo de dato). En SS (sin signo), carry = error. En C2, carry puede ser legitimo; solo overflow indica resultado incorrecto.

## Apariciones en parciales

- [[parciales_analizados/1P_2C_2024]] — Ejercicio 1: carry, overflow SS vs C2, formula $V = C_k \oplus C_{k-1}$
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Ejercicio 1: suma C2 con deteccion overflow NEG+NEG=POS; paridad de resultado; c negativo sin overflow
- [[parciales_analizados/1P_1C_2025]] — Ejercicio 1: flags CVZN para sumas y restas A+B, A-C, B-C

## Ejercicios que ejemplifican esto

- [[temas/representacion_de_informacion_guia]] — Ejercicios 2, 7, 8, 9
