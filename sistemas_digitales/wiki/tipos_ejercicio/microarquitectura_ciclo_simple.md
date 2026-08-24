---
nombre: Microarquitectura de Ciclo Simple — Datapath e Instrucciones
parcial: 1P
programa: 2C_2026
tema: microarquitectura
apariciones_en_parciales:
  - parciales_analizados/2P_2C_2024  # Ej4 (or tipo R)
  - parciales_analizados/2P_2C_2024_recuperatorio  # Ej4 (ResultSrc, bits instruccion)
  - parciales_analizados/2P_1C_2025  # Ej3 (beq, extensor de signo tipo B)
---

## Como reconocer este patron

El enunciado da una instruccion especifica (tipo R, I, B, S) y pide:
- Que componentes del datapath estan involucrados y en que orden
- Que valores tienen las senales de control (AluSrc, ResultSrc, RegWrite, etc.)
- Que pasa si una senal de control tiene un valor incorrecto
- Calcular el inmediato extendido para instrucciones tipo B/I/S
- Cual es la proxima instruccion (para branches)

Palabras clave: *microarquitectura*, *ciclo simple*, *datapath*, *senales de control*, *AluSrc*, *ResultSrc*, *ImmSrc*, *PCSrc*.

## Template de resolucion

**Senales de control por tipo de instruccion:**

| Senal | Tipo R (or) | Tipo I (lw) | Tipo S (sw) | Tipo B (beq) |
|---|---|---|---|---|
| AluSrc | 0 (registro) | 1 (inmediato) | 1 (inmediato) | 0 (registro) |
| ResultSrc | 0 (ALU) | 1 (memoria) | — | — |
| RegWrite | 1 | 1 | 0 | 0 |
| MemWrite | 0 | 0 | 1 | 0 |
| PCSrc | 0 | 0 | 0 | Branch AND Zero |
| ImmSrc | — | 00 (tipo I) | 01 (tipo S) | 10 (tipo B) |

**Formato tipo B y calculo de PCTarget:**
- Los bits del inmediato NO son contiguos en la instruccion
- imm[12] = inst[31], imm[11] = inst[7], imm[10:5] = inst[30:25], imm[4:1] = inst[11:8], imm[0] = 0
- Extender con signo (bit 12 es el signo)
- PCTarget = PC + ImmExt

**Componentes siempre involucrados:**
1. PC (program counter)
2. Memoria de instrucciones
3. Banco de registros (lectura)
4. Unidad de control
5. ALU

**Diferencias clave:**
- Tipo R vs lw: AluSrc (0 vs 1), ResultSrc (0 vs 1)
- Tipo R vs sw: RegWrite (1 vs 0), MemWrite (0 vs 1)
- beq vs tipo R: PCSrc puede ser 1 (salto), ALUControl=SUB (para comparar)

## Por que funciona

El datapath de ciclo simple ejecuta cada instruccion en un unico ciclo de reloj. La unidad de control decodifica el opcode y genera las senales que configuran los MUX y habilitan los modulos. ResultSrc=1 selecciona datos de memoria (solo load); ResultSrc=0 selecciona la ALU (todo lo demas).

## Apariciones en parciales

> ⚠️ **Reubicado por el programa vigente (2C_2026).** Microarquitectura era **2P** en el programa
> viejo, asi que los rotulos `1P`/`2P` de la lista de abajo corresponden a **como se
> tomaba antes**.
> Con el programa vigente la materia tiene **un solo parcial** (rotulado `1P`), asi que
> este patron es material de tu **parcial unico**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].

- [[parciales_analizados/2P_2C_2024]] — Ejercicio 4: `or x4, x5, x6` (tipo R); AluSrc=0, ResultSrc=0, WE3=1, MemWrite=0
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — Ejercicio 4: ¿que pasa si ResultSrc=1 para `or`? (basura de memoria); bits 24-20 = 0 → rs2=x0 → `or` con cero = copia
- [[parciales_analizados/2P_1C_2025]] — Ejercicio 3: `beq x4, x4, L7`; ImmSrc=10 (tipo B); extensor de signo → ImmExt=0xFFFFFFF4=-12; PCTarget=0x100C-12=0x1000; PCSrc=Branch AND Zero

## Ejercicios que ejemplifican esto

- [[temas/arquitectura_cpu_guia]] — Ejercicios de ciclo fetch-decode-execute
- [[temas/microarquitectura_teoria]] — Teoria del datapath de ciclo simple
