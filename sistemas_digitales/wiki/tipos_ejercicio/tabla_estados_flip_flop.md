---
nombre: Tabla de Estados de Circuito con Flip-Flops
parcial: 1P
programa: 2C_2026
tema: logica_secuencial
apariciones_en_parciales:
  - parciales_analizados/1P_1C_2025  # Ej3
---

## Como reconocer este patron

El enunciado da un circuito con flip-flops D (y posiblemente compuertas combinatorias entre ellos) y pide completar la tabla de estados ciclo a ciclo hasta encontrar un ciclo que se repita.

Palabras clave: *flip-flops D*, *tabla de estados*, *tabla de verdad secuencial*, *ciclo*, *periodo*, *clock*.

## Template de resolucion

**Paso 1 — Leer las funciones de transicion del circuito:**
- Identificar a que esta conectado el D de cada FF (puede ser $Q$ o $\bar{Q}$ de otro FF, o una combinacion)
- Escribir: $Q_i' = f_i(Q_0, Q_1, \ldots, Q_{n-1})$

**Paso 2 — Calcular la tabla fila a fila:**
- Partir del estado inicial dado
- Aplicar las funciones de transicion para obtener el estado siguiente
- Continuar hasta que el estado actual iguale alguno anterior → fin del ciclo

**Paso 3 — Identificar el ciclo:**
- El periodo = distancia entre los dos estados iguales (cantidad de estados distintos antes de repetir)
- El ciclo comienza en el primer estado que se repite

**Ejemplo (registro circular 3-bit):**
Funciones: $Q_0' = Q_2$, $Q_1' = Q_0$, $Q_2' = Q_1$

| Ciclo | Q0 | Q1 | Q2 |
|-------|----|----|-----|
| $t_0$ | 1  | 0  | 0   |
| $t_1$ | 0  | 1  | 0   |
| $t_2$ | 0  | 0  | 1   |
| $t_3$ | 1  | 0  | 0   | ← igual a $t_0$ → periodo 3

## Por que funciona

Los FF-D son sincrónicos: todos capturan el nuevo estado simultaneamente en el flanco de clock. El estado siguiente depende solo del estado actual (circuito de Moore/Mealy). La tabla de estados es un simulador paso a paso del automata finito determinista.

## Apariciones en parciales

- [[parciales_analizados/1P_1C_2025]] — Ejercicio 3: 3 FF-D conectados como registro circular (Q0'=Q2, Q1'=Q0, Q2'=Q1); estado inicial (1,0,0); ciclo de periodo 3

## Ejercicios que ejemplifican esto

- [[temas/logica_secuencial_guia]] — Ejercicios 12, 13 (tablas de estados con JK y circuitos compuestos)
