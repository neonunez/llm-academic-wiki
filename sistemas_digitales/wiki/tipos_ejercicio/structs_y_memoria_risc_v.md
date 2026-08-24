---
nombre: Structs y Acceso a Memoria en RISC-V
parcial: 1P
programa: 2C_2026
tema: programacion_risc_v
apariciones_en_parciales:
  - parciales_analizados/2P_2C_2024  # Ej3 (BalanceDeudor 5 bytes)
  - parciales_analizados/2P_2C_2024_recuperatorio  # Ej3 (BalanceDeudor 9 bytes)
  - parciales_analizados/2P_1C_2025  # Ej2 (Aportante 4 bytes)
---

## Como reconocer este patron

El enunciado define una estructura con campos de distintos tamanios y pide:
1. Calcular cuantos bytes ocupa la estructura (y un arreglo de N elementos)
2. Implementar una funcion que recorre un arreglo de esas estructuras con condicion de parada (centinela o largo fijo)

Palabras clave: *struct*, *offset*, *lbu*, *lh*, *lw*, *centinela*, *arreglo de estructuras*.

## Template de resolucion

**Paso 1 — Calcular tamano:**
- Sumar los bytes de cada campo (la catedra usa structs SIN padding)
- Arreglo de N elementos: $N \times \text{sizeof}(\text{struct})$ + 1 byte de centinela (si aplica)

**Instrucciones por tipo de campo:**
| Tipo | Instruccion | Bytes |
|------|-------------|-------|
| uint8 / char | `lbu` (unsigned byte) | 1 |
| int8 | `lb` (signed byte) | 1 |
| uint16 | `lhu` (unsigned half) | 2 |
| int16 | `lh` (signed half, con extension de signo) | 2 |
| int32 / uint32 | `lw` (word) | 4 |

**Patron centinela:**
```asm
loop:
    lb   t0, 0(a0)          # leer campo identificador (offset 0)
    beqz t0, fin            # si ID == 0: fin del arreglo
    # procesar elemento...
    addi a0, a0, sizeof_struct   # avanzar al siguiente
    j    loop
```

**Acceso a campos por offset:**
```asm
    lbu  t1, 0(a0)          # campo en offset 0 (1 byte unsigned)
    lh   t2, 1(a0)          # campo en offset 1 (2 bytes signed)
    lw   t3, 3(a0)          # campo en offset 3 (4 bytes)
```

## Por que funciona

La catedra usa structs compactos sin alineacion (diferente a C con padding). Los offsets son la suma acumulada de los campos anteriores. `lh` extiende el signo automaticamente al registro de 32 bits; `lbu` extiende con ceros. Usar la instruccion incorrecta (ej: `lb` para uint8) puede dar valores incorrectos para valores >= 128.

## Apariciones en parciales

> ⚠️ **Reubicado por el programa vigente (2C_2026).** Programacion RISC-V era **2P** en el programa
> viejo, asi que los rotulos `1P`/`2P` de la lista de abajo corresponden a **como se
> tomaba antes**.
> Con el programa vigente la materia tiene **un solo parcial** (rotulado `1P`), asi que
> este patron es material de tu **parcial unico**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].

- [[parciales_analizados/2P_2C_2024]] — Ejercicio 3: `BalanceDeudor` (ID 1b + Consumos 2b + Pagos 2b = 5 bytes); arreglo centinela; `lbu` para ID, `lh` para Consumos y Pagos; avanzar de 5 en 5
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — Ejercicio 3: `BalanceDeudor` (ID 1b + Consumos 4b + Cant_pagos 2b + Pagos 2b = 9 bytes); `LB`, `LW`, `LH` por campo; avanzar de 9 en 9
- [[parciales_analizados/2P_1C_2025]] — Ejercicio 2: `Aportante` (edad 1b + anos 1b + aportes 2b = 4 bytes); `lbu` para edad/anos, `lh` para aportes; filtro `edad >= 65`; `div` para promedio

## Ejercicios que ejemplifican esto

- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 9 (struct InformacionAlumno)
- [[temas/arquitectura_cpu_guia]] — Ejercicios de acceso a memoria con offsets
