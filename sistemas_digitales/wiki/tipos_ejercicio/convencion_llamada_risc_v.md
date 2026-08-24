---
nombre: Convencion de Llamada RISC-V — Callee/Caller-Saved
parcial: 1P
programa: 2C_2026
tema: programacion_risc_v
apariciones_en_parciales:
  - parciales_analizados/2P_2C_2024  # Ej1, Ej2
  - parciales_analizados/2P_2C_2024_recuperatorio  # Ej1, Ej2
  - parciales_analizados/2P_1C_2025  # Ej1
---

## Como reconocer este patron

El enunciado pide respetar la convencion de llamada, explicar que registros se usan, o implementar una funcion que llama a otra. Clave cuando el enunciado dice:
- "Respetar la convencion de llamada"
- "Explicar en que registros se almacenan los valores"
- Funcion con `jal` a otra funcion

## Template de resolucion

**Registros por rol:**

| Registro | Tipo | Quien preserva |
|---|---|---|
| `a0`–`a7` | argumentos / retorno | caller-saved (puede cambiar tras jal) |
| `t0`–`t6` | temporales | caller-saved |
| `s0`–`s11` | saved | callee-saved (el callee los preserva si los usa) |
| `ra` | return address | callee-saved (guardar si se hace jal) |
| `sp` | stack pointer | callee-saved (restaurar antes de ret) |

**Funciones que NO llaman a nadie (hoja):**
- No necesitan guardar `ra`
- Pueden usar `t*` y `a*` libremente
- Si usan `s*`, deben guardarlos

**Funciones que llaman a otras:**
- Guardar `ra` (sera sobreescrito por `jal`)
- Guardar en `s*` todo lo que se necesite despues del `jal`
- Los `a*` y `t*` del llamador se pierden tras el `jal`

**Patron para preservar argumentos a traves de una llamada:**
```asm
mv  s1, a0        # preservar argumento en registro s
jal  otra_func    # a0 puede cambiar
# s1 sigue valido
```

## Por que funciona

La convencion es un contrato: el callee garantiza que los registros `s*` y `sp` tienen los mismos valores al retornar. El caller asume que los `t*` y `a*` pueden cambiar. Esto permite composicion de funciones sin coordinacion explicita sobre cada registro.

## Apariciones en parciales

> ⚠️ **Reubicado por el programa vigente (2C_2026).** Programacion RISC-V era **2P** en el programa
> viejo, asi que los rotulos `1P`/`2P` de la lista de abajo corresponden a **como se
> tomaba antes**.
> Con el programa vigente la materia tiene **un solo parcial** (rotulado `1P`), asi que
> este patron es material de tu **parcial unico**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].

- [[parciales_analizados/2P_2C_2024]] — Ej1: `s1=fila`, `s2=columna`, `s3=resultado_primera_llamada` sobreviven a llamadas recursivas; Ej2: `s1=arr`, `s2=largo`, `s3=indice` sobreviven a llamadas a `inv`
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — Ej1: tres funciones con sus propios frames; Ej2: uso de `s0` sin guardarlo (violacion detectada por corrector)
- [[parciales_analizados/2P_1C_2025]] — Ej1: `s0=n`, `s1=2*rec(n-1)`; bug t0 caller-saved antes de jal

## Ejercicios que ejemplifican esto

- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 1 (debuggear violaciones de convencion)
- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 4 (conceptual: obligaciones caller/callee)
- [[temas/programacion_risc_v_guia_pt2]] — Ejercicio 5a (inv + invertirArreglo)
