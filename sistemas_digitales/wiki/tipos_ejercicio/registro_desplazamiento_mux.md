---
nombre: Registro de Desplazamiento con Multiplexor
parcial: 1P
tema: logica_secuencial
apariciones_en_parciales:
  - parciales_analizados/1P_2C_2024_recuperatorio  # Ej4
  - parciales_analizados/1P_1C_2025  # Ej3 (registro circular)
---

## Como reconocer este patron

El enunciado pide un registro que desplace sus bits hacia la derecha o izquierda segun una senal de control, o un registro circular. Senales tipicas:
- `clk`, `right/left` (direccion de desplazamiento)
- Posible demora de 1 ciclo
- Registro circular (el ultimo bit vuelve al primero)

Palabras clave: *desplazamiento*, *shift*, *bidireccional*, *right/left*, *circular*, *ring*.

## Template de resolucion

**Arquitectura:**
- **N multiplexores 2:1** (uno por bit), selector = `right/left`
  - Entrada right: vecino de la derecha ($Q_{i+1}$)
  - Entrada left: vecino de la izquierda ($Q_{i-1}$)
  - Extremos: relleno con 0 (o realimentacion para registro circular)
- **N flip-flops D**: implementan la demora de 1 ciclo automaticamente

**Conexiones:**
- Bit 0 (extremo izquierdo): entrada right = $Q_1$; entrada left = 0 (relleno) o $Q_{N-1}$ (circular)
- Bit i (intermedio): entrada right = $Q_{i+1}$; entrada left = $Q_{i-1}$
- Bit N-1 (extremo derecho): entrada right = 0 (relleno) o $Q_0$ (circular); entrada left = $Q_{N-2}$

**Tabla de estados** (registro circular 3-bit, estado inicial 100):
| Ciclo | Q0 | Q1 | Q2 |
|-------|----|----|-----|
| t0    | 1  | 0  | 0   |
| t1    | 0  | 1  | 0   |
| t2    | 0  | 0  | 1   |
| t3    | 1  | 0  | 0   | ← repite, periodo 3

## Por que funciona

El MUX selecciona el vecino adecuado segun la direccion. El FF-D introduce la demora: el nuevo valor de $Q_i$ se captura en el flanco de `clk` y se emite en el ciclo siguiente, implementando la semantica de "desplazamiento en el siguiente ciclo".

## Apariciones en parciales

- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Ejercicio 4: registro de desplazamiento bidireccional 4-bit con MUX + FF-D, demora 1 ciclo
- [[parciales_analizados/1P_1C_2025]] — Ejercicio 3: registro desplazamiento circular 3-bit, tabla de estados con ciclo de periodo 3

## Ejercicios que ejemplifican esto

- [[temas/logica_secuencial_guia]] — Ejercicio 17 (desplazador izquierda 4-bit)
- [[temas/logica_secuencial_guia]] — Ejercicio 15 (registro bidireccional)
