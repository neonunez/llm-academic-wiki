---
nombre: Representacion Numerica — Rangos y Codificacion
parcial: 1P
programa: 2C_2026
tema: representacion_de_informacion
apariciones_en_parciales:
  - parciales_analizados/1P_2C_2024  # Ej1
  - parciales_analizados/1P_2C_2024_recuperatorio  # Ej1
  - parciales_analizados/1P_1C_2025  # Ej1
---

## Como reconocer este patron

El enunciado pide una o mas de:
- Calcular el rango de representacion de k bits en S+M o C2
- Explicar la diferencia de rango entre S+M y C2
- Codificar numeros en S+M, C2, sin signo (conversion decimal→binario)
- Interpretar patrones de bits como S+M o C2 (conversion binario→decimal)
- Variantes: bits cableados a 0, extension de precision

Palabras clave: *rango*, *signo y magnitud*, *complemento a dos*, *representable*, *codificar*.

## Template de resolucion

**Rangos:**
- S+M de k bits: $[-(2^{k-1}-1),\ +(2^{k-1}-1)]$; doble cero ($0000$ y $1000\ldots$)
- C2 de k bits: $[-2^{k-1},\ +2^{k-1}-1]$; asimetrico (un negativo extra)
- Sin signo de k bits: $[0,\ 2^k-1]$

**Conversion decimal → C2:**
1. Si positivo: binario normal
2. Si negativo: NOT(valor absoluto) + 1

**Conversion C2 → decimal:**
- Si MSB=0: valor posicional normal
- Si MSB=1: $-2^{k-1} + \sum_{i=0}^{k-2} b_i \cdot 2^i$

**Variante S+M con bit cableado:**
- Si el bit $j$ esta cableado a 0: los bits de magnitud libres se reducen en 1 → rango $\pm(2^{k-2}-1)$ si el bit fijo es el segundo MSB

## Por que funciona

S+M separa signo y magnitud fisicamente (bit separado). C2 usa aritmetica modular: $-x = \overline{x} + 1$, que permite hacer sumas directas sin circuito especial para el signo. La asimetria de C2 es consecuencia de tener $2^k$ patrones para $2^k$ numeros sin cero duplicado.

## Apariciones en parciales

- [[parciales_analizados/1P_2C_2024]] — Ejercicio 1: rangos S+M 4-bit y C2 8-bit
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Ejercicio 1: rangos C2 8-bit solo negativos, S+M con bit fijo
- [[parciales_analizados/1P_1C_2025]] — Ejercicio 1: truncado hex→bin + tabla sin signo/CA2

## Ejercicios que ejemplifican esto

- [[temas/representacion_de_informacion_guia]] — Ejercicios 4, 5, 6, 11
