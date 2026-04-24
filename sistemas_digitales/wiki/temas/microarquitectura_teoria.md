---
nombre: Microarquitectura — Teoria
parcial: 2P
tipo: teoria
tema: microarquitectura
fuente: raw/clases_teoricas/5.teo_microarquitectura.pdf
paginas_relacionadas:
  - "[[arquitectura_teoria_pt1]]"
  - "[[arquitectura_teoria_pt2]]"
  - "[[programacion_risc_v_guia_pt2]]"
  - "[[tipos_ejercicio/microarquitectura_ciclo_simple]]"
---

# Microarquitectura — Teoria

## Concepto y definicion

La **microarquitectura** se ubica conceptualmente entre la arquitectura (lo que se expone al programador) y la logica combinatoria y secuencial. Implementa:
- El soporte del **estado arquitectonico** (registros de proposito general + PC)
- La **logica de control** para actualizar ese estado segun la semantica de las instrucciones de la ISA

Distincion clave:
- El procesador puede tener elementos de memoria **fuera de la arquitectura** (estado interno no expuesto al programador), usados para implementar mecanismos propios.

---

## Instrucciones a evaluar

Subconjunto de RISC-V para justificar el diseno:

| Tipo | Instrucciones |
|------|---------------|
| Registros (tipo R) | `add`, `sub`, `and`, `or`, `slt` |
| Memoria (tipo I/S) | `lw`, `sw` |
| Salto (tipo B) | `beq` |

---

## Proceso de diseno

### Datapath

El **datapath** (camino de datos) conecta los elementos que realizan transformaciones sobre los datos. Se disena primero.

### Unidad de control

La **unidad de control** coordina los elementos del datapath manipulando sus senales de control. Se disena despues del datapath.

### Convencion de diagramas

| Tipo de linea | Significado |
|---|---|
| Gruesa | datos de 32 bits |
| Delgada | datos de 1 bit |
| Intermedia | datos de otro tamano |
| Azul | senales de control |

---

## Elementos de memoria del datapath

### PC (Program Counter)

- Salida `PC`: direccion de la instruccion actual
- Entrada `PCNext`: direccion de la proxima instruccion
- Elemento de memoria: se actualiza en el flanco ascendente de clock

### Memoria de instrucciones

- Entrada: direccion `A` de 32 bits
- Salida: `RD` — valor de 32 bits en esa posicion
- Solo lectura en el ciclo de ejecucion

### Archivo de registros

Contiene los 32 registros `x0`–`x31`:

| Puerto | Tipo | Descripcion |
|--------|------|-------------|
| A1 → RD1 | Lectura | Registro fuente 1 |
| A2 → RD2 | Lectura | Registro fuente 2 |
| A3 + WD3 + WE3 | Escritura | Escribe WD3 en A3 si WE3=1 (flanco ascendente) |

### Memoria de datos

- Entrada `A` (32-bit): direccion
- Si `WE=0` → lectura: salida `RD`
- Si `WE=1` → escritura: escribe `WD` en `A` en el flanco ascendente de clock

---

## Procesador de ciclo simple

Todas las operaciones se completan en **un unico ciclo de reloj**. La duracion del ciclo debe ser suficientemente larga para la operacion mas costosa → rendimiento no optimo pero didacticamente util.

---

## Instrucciones de memoria (lw / sw)

### lw — lectura de memoria

Ejecucion paso a paso:

1. **Fetch:** `PC` → `A` de memoria de instrucciones → instruccion codificada en `RD`
2. **Lectura de base:** bits `[19:15]` de instruccion → `A1` del archivo de registros → `RD1` (base)
3. **Extension de desplazamiento:** bits `[31:20]` (12-bit, C2) → extensor de signo → valor 32-bit
4. **Calculo de direccion:** ALU suma base + desplazamiento → direccion efectiva
5. **Lectura de memoria:** direccion → `A` de memoria de datos → `RD` (dato leido)
6. **Escritura en registro:** `RD` → `WD3` del archivo de registros; bits `[11:7]` → `A3`; `WE3=1`
7. **Actualizar PC:** sumador: `PC + 4` → `PCNext`

### sw — escritura a memoria

Misma logica para calcular la direccion, pero:
- bits `[24:20]` de instruccion → `A2` → `RD2` (valor a escribir)
- `RD2` → `WD` de memoria de datos; `WE=1`
- No se escribe en el archivo de registros

---

## Instrucciones con registros (tipo R)

Esquema comun: dos registros fuente, un registro destino, ALU realiza la operacion.

**Modificaciones al datapath:**

1. **MUX SrcB:** permite elegir entre `RD2` (tipo R) o inmediato extendido (tipo I/S) como segundo operando de la ALU → controlado por `ALUSrc`
2. **MUX Result:** permite elegir entre salida de la ALU o `RD` de memoria de datos para escribir en `WD3` → controlado por `ResultSrc`
3. **ALUControl:** senala que operacion realizar en la ALU (`add`/`sub`/`and`/`or`/`slt`)

---

## Senales de control del datapath

| Senal | Modulo controlado | Descripcion |
|-------|-------------------|-------------|
| `RegWrite` | Archivo de registros | Habilita escritura en registro destino |
| `ImmSrc` | Extensor de signo | Tipo de extension (I / S / B) — 2 bits |
| `ALUSrc` | MUX SrcB | 0 = RD2 (tipo R), 1 = inmediato extendido |
| `ALUControl` | ALU | Operacion a realizar |
| `MemWrite` | Memoria de datos | Habilita escritura en memoria |
| `ResultSrc` | MUX Result | 0 = resultado ALU, 1 = dato de memoria |

---

## Instrucciones de salto condicional (beq)

**Codificacion del desplazamiento:** 13 bits logicos, codificados en 12 bits en la instruccion (el bit 0 siempre es 0 — las instrucciones estan alineadas a 4 bytes).

### Extension de signo — tabla ImmSrc

| ImmSrc | Tipo | Bits de instruccion | Descripcion |
|--------|------|---------------------|-------------|
| `00` | I | `[31:20]` | Inmediato 12-bit (lw, addi, etc.) |
| `01` | S | `[31:25]` + `[11:7]` | Inmediato 12-bit dividido (sw) |
| `10` | B | `[31:25]` + `[11:7]` reordenados | Desplazamiento 13-bit (beq) |

### Logica de salto

- Sumador adicional: `PC + inmediato_extendido` → direcion de salto
- **MUX PCNext:** selecciona entre `PC + 4` (no salta) y `PC + inmediato` (salta)
  - Selector = `PCSrc = Branch AND Z`
  - `Z` es el flag zero de la ALU (activo cuando los dos operandos son iguales)
- La condicion `beq` se cumple cuando `Z=1`

---

## Logica de control — diseno desacoplado

La unidad de control se divide jerarquicamente en dos partes:

### Controlador principal

Recibe el **opcode** (bits `[6:0]`) y genera las senales de control + `ALUOp`:

| Instruccion | opcode | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp |
|-------------|--------|----------|--------|--------|----------|-----------|--------|-------|
| lw | `0000011` | 1 | 00 | 1 | 0 | 1 | 0 | `00` |
| sw | `0100011` | 0 | 01 | 1 | 1 | x | 0 | `00` |
| tipo R | `0110011` | 1 | xx | 0 | 0 | 0 | 0 | `10` |
| beq | `1100011` | 0 | 10 | 0 | 0 | x | 1 | `01` |
| addi | `0010011` | 1 | 00 | 1 | 0 | 0 | 0 | `00` |

- `ALUOp=00` → siempre suma (lw/sw/addi en modo suma)
- `ALUOp=01` → siempre resta (beq: detectar igualdad via Z)
- `ALUOp=10` → el decodificador decide segun funct3/funct7

### Decodificador de ALU (ALU decoder)

Recibe `ALUOp` + `funct3` (bits `[14:12]`) + `funct7[5]` (bit `[30]`) y genera `ALUControl`:

| ALUOp | funct3 | funct7[5] | ALUControl | Operacion |
|-------|--------|-----------|------------|-----------|
| `00` | x | x | `000` | add |
| `01` | x | x | `001` | sub |
| `10` | `000` | `0` | `000` | add |
| `10` | `000` | `1` | `001` | sub |
| `10` | `010` | x | `101` | slt |
| `10` | `110` | x | `011` | or |
| `10` | `111` | x | `010` | and |

### PCSrc

$$\text{PCSrc} = \text{Branch} \;\text{AND}\; Z$$

Compuerta AND externa a la unidad de control: si `Branch=1` (la instruccion es beq) y `Z=1` (condicion cumplida) → `PCSrc=1` → tomar el salto.

---

## Formulas clave

**Direccion efectiva (lw/sw):**
$$\text{dir\_efectiva} = \text{base} + \text{sign\_ext}(\text{offset})$$

**PCNext sin salto:**
$$\text{PCNext} = \text{PC} + 4$$

**PCNext con salto (beq tomado):**
$$\text{PCNext} = \text{PC} + \text{sign\_ext}(\text{imm} \ll 1)$$

---

## Ver tambien

- [[arquitectura_teoria_pt1]] — ISA RISC-V, tipos de instruccion R/I/S/B/U/J, ciclo fetch-decode-execute
- [[arquitectura_teoria_pt2]] — ABI, pila, llamadas a funciones
