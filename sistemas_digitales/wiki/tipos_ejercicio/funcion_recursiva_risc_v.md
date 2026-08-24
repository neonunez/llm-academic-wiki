---
nombre: Funcion Recursiva en RISC-V
parcial: 1P
programa: 2C_2026
tema: programacion_risc_v
apariciones_en_parciales:
  - parciales_analizados/2P_2C_2024  # Ej1 (Pascal)
  - parciales_analizados/2P_2C_2024_recuperatorio  # Ej1 (es_primo/cantidad_divisores)
  - parciales_analizados/2P_1C_2025  # Ej1 (rec: 2*rec(n-1) + 3*rec(n-2))
---

## Como reconocer este patron

El enunciado da una funcion matematica recursiva en pseudocodigo C y pide implementarla en RISC-V respetando la convencion de llamada. Puede pedir ademas:
- Explicar en que registros se almacenan los valores
- Como se garantiza la convencion entre llamadas recursivas
- Con dos llamadas recursivas (como Fibonacci/Pascal)

Palabras clave: *recursivo*, *convencion de llamada*, *saved registers*, *stack frame*, *ra*.

## Template de resolucion

**Prologo:**
```asm
func:
    addi sp, sp, -N        # N = 4 * (registros a preservar)
    sw   ra, (N-4)(sp)     # siempre guardar ra si hay jal
    sw   s0, (N-8)(sp)     # guardar cada s* que se use
    # ... mas sw si hay mas s*
```

**Casos base:** comparar con `bgt`/`blt`/`beq` + `li` para cargar constante de comparacion

**Caso recursivo:**
1. Preservar argumentos que se necesiten post-llamada en registros `s*`
2. Cargar argumentos en `a0`, `a1` para la llamada recursiva
3. `jal func`
4. Capturar resultado (`a0`) en registro `s*` antes de que se sobreescriba
5. Repetir para segunda llamada (si hay dos recursiones)
6. Calcular resultado final y dejarlo en `a0`

**Epilogo:**
```asm
L_return:
    lw   s0, (N-8)(sp)
    lw   ra, (N-4)(sp)
    addi sp, sp, N
    ret
```

**Regla de oro:** todo lo que se necesite despues de un `jal` debe estar en un `s*` (o en el stack). Los registros `t*` y `a*` son caller-saved — pueden cambiar tras la llamada.

## Por que funciona

El stack frame preserva el contexto de cada nivel de recursion. Los registros `s*` son callee-saved: la funcion llamada debe preservarlos, por lo que el llamador puede confiar en que sobreviven a las llamadas recursivas. `ra` debe guardarse porque `jal` lo sobreescribe.

## Apariciones en parciales

> ⚠️ **Reubicado por el programa vigente (2C_2026).** Programacion RISC-V era **2P** en el programa
> viejo, asi que los rotulos `1P`/`2P` de la lista de abajo corresponden a **como se
> tomaba antes**.
> Con el programa vigente la materia tiene **un solo parcial** (rotulado `1P`), asi que
> este patron es material de tu **parcial unico**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].

- [[parciales_analizados/2P_2C_2024]] — Ejercicio 1: pascal(fila, columna) con dos llamadas recursivas; `s1=fila`, `s2=columna`, `s3=resultado_primera_llamada`
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — Ejercicio 1: recursion mutua `es_primo` → `cantidad_divisores` → `cantidad_divisores_rec`; instruccion `REM`
- [[parciales_analizados/2P_1C_2025]] — Ejercicio 1: `rec(n) = 2*rec(n-1) + 3*rec(n-2)`; `s0=n`, `s1=2*rec(n-1)`; uso de `slli` como alternativa a `mul`

## Ejercicios que ejemplifican esto

- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 8a (factorial recursivo)
- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 8c (Fibonacci 3)
- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 2 (Fibonacci iterativo — convencion)
