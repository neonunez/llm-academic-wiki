---
nombre: Iteracion sobre Arreglos en RISC-V
parcial: 1P
programa: 2C_2026
tema: programacion_risc_v
apariciones_en_parciales:
  - parciales_analizados/2P_2C_2024  # Ej2 (invertirArreglo)
  - parciales_analizados/2P_2C_2024_recuperatorio  # Ej2 (arreglo_par)
  - parciales_analizados/2P_1C_2025  # Ej2 (promedio aportantes)
---

## Como reconocer este patron

El enunciado da un arreglo de elementos y pide aplicar una operacion sobre cada uno (posiblemente llamando a otra funcion). Variantes:
- Iterativo con loop
- Recursivo (avanzar primero, procesar al regresar — post-order)
- Con condicion de filtro (solo procesar ciertos elementos)

## Template de resolucion

**Patron iterativo basico:**
```asm
func:                       # a0=puntero, a1=largo
    addi sp, sp, -N
    sw   ra, 0(sp)
    mv   s1, a0             # s1 = puntero (sobrevive jal)
    mv   s2, a1             # s2 = largo (sobrevive jal)
    li   s3, 0              # s3 = indice

loop:
    beq  s3, s2, return     # if indice == largo: fin
    lw   t0, 0(s1)          # t0 = arr[indice]
    # ... procesar t0, posiblemente jal a otra funcion
    sw   resultado, 0(s1)   # escribir resultado
    addi s3, s3, 1          # indice++
    addi s1, s1, 4          # ptr++ (4 bytes por int)
    j    loop

return:
    lw   ra, 0(sp)
    addi sp, sp, N
    ret
```

**Patron con filtro (ej: solo mayores de 65):**
```asm
    lbu  t3, 0(a0)          # leer campo de filtro
    blt  t3, t2, else_0     # si no cumple condicion → saltar
    # procesar...
else_0:
    addi a0, a0, sizeof_struct
    addi a1, a1, -1
    j    while_0
```

**Truco paridad sin REM:**
```asm
    andi t0, a0, 1      # extrae LSB (1 si impar)
    xori a0, t0, 1      # invierte: 1=par, 0=impar
```

## Por que funciona

Los registros `s*` preservan el puntero y el contador a traves de llamadas a funciones auxiliares (que pueden modificar `a*` y `t*`). El avance del puntero en bytes depende del tipo: 4 para int (word), 2 para half, 1 para byte.

## Apariciones en parciales

> ⚠️ **Reubicado por el programa vigente (2C_2026).** Programacion RISC-V era **2P** en el programa
> viejo, asi que los rotulos `1P`/`2P` de la lista de abajo corresponden a **como se
> tomaba antes**.
> Con el programa vigente la materia tiene **un solo parcial** (rotulado `1P`), asi que
> este patron es material de tu **parcial unico**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].

- [[parciales_analizados/2P_2C_2024]] — Ejercicio 2: `invertirArreglo` iterativo; `s1=arr`, `s2=largo`, `s3=indice`; llama a `inv` (xori+addi)
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — Ejercicio 2: `arreglo_par` recursivo post-order; truco `andi+xori` para paridad
- [[parciales_analizados/2P_1C_2025]] — Ejercicio 2: recorrido de arreglo de structs de 4 bytes con filtro `edad >= 65`; acumulacion de suma y conteo para promedio

## Ejercicios que ejemplifican esto

- [[temas/programacion_risc_v_guia]] — Ejercicio 11 (maximo de arreglo)
- [[temas/programacion_risc_v_guia]] — Ejercicio 13 (copiar elementos pares)
- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 5a (invertirArreglo)
- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 5b (PotenciasEnArreglo)
