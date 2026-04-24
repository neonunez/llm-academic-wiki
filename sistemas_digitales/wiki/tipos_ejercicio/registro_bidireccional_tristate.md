---
nombre: Registro Bidireccional con Buffer Tristate
parcial: 1P
tema: logica_secuencial
apariciones_en_parciales:
  - parciales_analizados/1P_2C_2024  # Ej4
---

## Como reconocer este patron

El enunciado pide disenar un registro que comparte las lineas de datos para lectura y escritura (mismas lineas son entrada Y salida). Senales tipicas:
- `clk`, `load` (escritura en flanco ascendente), `read` (emit datos)
- `d0–dn`: lineas bidireccionales
- Ayuda: "utilice componentes de tres estados"

Palabras clave: *bidireccional*, *tres estados*, *tristate*, *load*, *read*, *lineas compartidas*.

## Template de resolucion

**Arquitectura:**
1. **N flip-flops D** (uno por bit): capturan los datos en el flanco ascendente de `clk` cuando `load=1`
2. **N buffers tristate**: controlados por `read`; cuando `read=1` emiten $Q_i$ hacia las lineas $d_i$; cuando `read=0` quedan en alta impedancia (Z) — las lineas quedan libres para recibir datos

**Modos:**
- Modo escritura (`load=1`, `read=0`): los buffers tristate estan en Z → las lineas $d_i$ son entradas; el FF-D captura en el flanco de `clk`
- Modo lectura (`read=1`, `load=0`): los buffers tristate activan → $d_i = Q_i$ (salida)

**Invariante:** `load` y `read` nunca valen 1 simultaneamente (cortocircuito logico)

**Diseño modular** (buena practica): definir un componente de 1 bit (`reg-bd-simple`) con 1 FF-D + 1 tristate, luego componer N veces

## Por que funciona

El buffer tristate permite que una linea fisica sea entrada o salida segun una senal de control. Sin tristate, si se conectara la salida Q del FF directamente a la linea de datos, habria conflicto (cortocircuito logico) cuando se intenta escribir.

## Apariciones en parciales

- [[parciales_analizados/1P_2C_2024]] — Ejercicio 4: registro bidireccional 4-bit con FF-D + tristate controlados por `load`/`read`

## Ejercicios que ejemplifican esto

- [[temas/logica_secuencial_guia]] — Ejercicio 15
