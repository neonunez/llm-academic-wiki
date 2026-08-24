---
nombre: Flags de ALU — CVZN con Tabla de Operaciones
parcial: 1P
programa: 2C_2026
tema: representacion_de_informacion
apariciones_en_parciales:
  - parciales_analizados/1P_1C_2025  # Ej1
---

## Como reconocer este patron

El enunciado da operandos (en decimal o hex/bin) y pide calcular los 4 flags de la ALU para cada operacion:
- Suma A+B
- Resta A-C (implementada como A + ~C + 1)

Puede combinarse con: conversion hex→bin, truncado, tabla de valores sin signo y CA2.

Palabras clave: *flags*, *ALU*, *carry*, *overflow*, *zero*, *negative*, *C*, *V*, *Z*, *N*.

## Template de resolucion

1. Convertir operandos al ancho deseado (hex→bin si es necesario, truncar si se pide)
2. Para cada operacion:

| Flag | Suma A+B | Resta A-B (= A + ~B + 1) |
|------|----------|--------------------------|
| C | carry final del bit k | 1 si hubo borrow (NOT del carry de la suma) |
| V | mismo signo + signo opuesto (NEG+NEG=POS o POS+POS=NEG) | mismo analisis sobre operandos originales |
| Z | resultado == 0 | resultado == 0 |
| N | MSB del resultado == 1 | MSB del resultado == 1 |

**Resta como suma:** $A - B = A + \overline{B} + 1$. El carry de esta suma, invertido, es el borrow ($C = 1$ si hubo borrow, es decir si el carry de la suma fue 0).

## Por que funciona

La ALU implementa la resta via complemento a dos. El borrow es el complemento del carry de la suma equivalente. El overflow se determina mirando los signos de los operandos originales (no de los complementados para la resta).

## Apariciones en parciales

- [[parciales_analizados/1P_1C_2025]] — Ejercicio 1: truncado hex→4 bits + tabla flags para A+B, A-C, B-C

## Ejercicios que ejemplifican esto

- [[temas/representacion_de_informacion_guia]] — Ejercicio 9 (pares con combinaciones C/V)
