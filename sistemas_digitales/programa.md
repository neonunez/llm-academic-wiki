---
nombre: Programa vigente — parcial unico
tipo: programa
vigencia: 2C_2026
actualizado: 2026-08-24
origen: oficial
esquema_evaluacion: parcial_unico
---

# Programa vigente — Sistemas Digitales

> **Esta es la unica fuente de verdad sobre que tema entra en que parcial.**
> El campo `parcial:` del frontmatter de `wiki/temas/` y `wiki/tipos_ejercicio/` es
> un campo **derivado** de esta tabla. Si cambia el programa, se edita **solo este
> archivo** y se corre `/programa` para propagar.

## 🚨 Cambio estructural: la materia pasa a tener UN SOLO PARCIAL

La catedra evalua con **un unico parcial que cubre las 10 unidades del temario**. No hay
1P y 2P.

Esto **invalida el corte con el que esta construida toda la wiki actual**. Los 6 parciales de
`wiki/parciales_analizados/` fueron tomados bajo un esquema de dos parciales (1P = hardware de
bajo nivel, 2P = arquitectura y RISC-V). Ese corte ya no existe.

### Convencion adoptada: el parcial unico se rotula `1P`

El sistema de comandos usa los valores `1P` / `2P` / `ambos`. Para no romperlos, **el parcial
unico se rotula `1P`** y todos los temas mapean ahi.

| | |
|---|---|
| `/parcial 1P` | Devuelve **todo** el programa — es la vista del parcial unico |
| `/parcial 2P` | No devuelve nada. **Correcto:** no existe un segundo parcial |
| `parcial: 2P` en frontmatter | Residuo del esquema viejo. `/programa` debe reescribirlo a `1P` |

**Propagado el 2026-08-24.** Estaban marcadas `2P` y pasaron a `1P`: **6** paginas de
`wiki/temas/` (`arquitectura_cpu_guia`, `arquitectura_teoria_pt1`, `_pt2`,
`microarquitectura_teoria`, `programacion_risc_v_guia`, `_pt2`) y **5** de
`wiki/tipos_ejercicio/` (`convencion_llamada_risc_v`, `funcion_recursiva_risc_v`,
`iteracion_arreglo_risc_v`, `structs_y_memoria_risc_v`, `microarquitectura_ciclo_simple`),
estas ultimas con aviso de reubicacion.

---

## Temario oficial (10 unidades, un parcial)

Transcripcion textual, con el mapeo a los temas internos de la wiki.

| # | Unidad oficial | Tema interno | Paginas |
|---|---|---|---|
| 1 | Introducción y Lógica Combinacional I: sistemas digitales, abstracción digital, funciones booleanas, tablas de verdad y compuertas | `logica_combinatoria` | `logica_combinatoria_teoria`, `_guia`, `hdl_system_verilog` ⭑ |
| 2 | Lógica Combinacional II: álgebra de Boole, equivalencia, SOP/POS, simplificación, lógica multinivel y X/Z | `logica_combinatoria` | idem |
| 3 | Lógica Secuencial I: estado, realimentación, latches, flip-flops, registros, sincronismo y timing | `logica_secuencial` | `logica_secuencial_teoria`, `_guia` |
| 4 | Lógica Secuencial II: FSM, máquinas de Moore y Mealy, tablas y diagramas de transición | `logica_secuencial` | idem |
| 5 | Representación de la información: sistemas de numeración, unsigned, complemento a dos, precisión, rango, carry, overflow, punto fijo y flotante | `representacion_de_informacion` | `representacion_de_informacion_teoria`, `_guia` |
| 6 | Diseño Modular I: diseño jerárquico, multiplexores, sumadores, restadores, comparadores, shifters y ALU | `diseno_modular` ⚠️ | **sin pagina propia** — disperso |
| 7 | Diseño Modular II: contadores, registros de desplazamiento, memorias y Register File | `diseno_modular` ⚠️ | **sin pagina propia** — disperso |
| 8 | Arquitectura RISC-V: ISA, registros, instrucciones, operandos, memoria, formatos, flujo de control y programación ASM | `arquitectura`, `programacion_risc_v` | `arquitectura_teoria_pt1`, `_pt2`, `arquitectura_cpu_guia`, `programacion_risc_v_guia`, `_pt2` |
| 9 | Microarquitectura I: arquitectura y microarquitectura, estado arquitectural, performance, ciclo de instrucción y datapath monociclo | `microarquitectura` | `microarquitectura_teoria` |
| 10 | Microarquitectura II: unidad de control, procesador monociclo completo, camino crítico y verificación | `microarquitectura` | idem |

⭑ **`hdl_system_verilog` es transversal a las unidades 1-4.** Cubre modelado combinacional
(mux, compuertas, Hi-Z, X/Z) y secuencial (bloques `always`, flip-flops, FSM Moore/Mealy).
Su `tema:` canonico es **`logica_combinatoria`** — es donde arranca y donde esta el grueso del
contenido — con `logica_secuencial` como secundario anotado en su frontmatter. Como ambos
mapean a `1P`, la eleccion no cambia nada derivado; importa solo para el filtro por tema de
`/priorizar` y `/chuleta`.

---

## ⚠️ Huecos de cobertura detectados contra el temario oficial

Contenido que la catedra evalua y que **la wiki no cubre**. Verificado por busqueda directa
sobre `wiki/` el 2026-08-24.

| Hueco | Unidad | Estado en la wiki |
|---|---|---|
| **Punto fijo y punto flotante** | 5 — Representación | **Cero menciones en toda la wiki.** Ni teoria, ni guia, ni parciales. Es el hueco mas grande |
| **Restadores** | 6 — Diseño Modular I | Cero menciones |
| **Comparadores** | 6 — Diseño Modular I | Cero menciones |
| **Diseño Modular como bloque** | 6 y 7 | No existe como tema. Sus contenidos estan dispersos: mux/sumador/ALU en `logica_combinatoria_teoria`, registros de desplazamiento y contadores en `logica_secuencial_*`, Register File y memorias en `arquitectura_teoria_pt1` |

Ninguno de estos huecos tiene apariciones en los 6 parciales analizados — **pero eso no
significa que no los tomen**: significa que no los tomaron bajo el esquema viejo de dos
parciales. Con un parcial unico que declara explicitamente "punto fijo y flotante" y
"restadores, comparadores", el precedente historico no cubre esa parte del temario.

**Regla para `/priorizar` sobre estos huecos:** contenido de la cursada que caiga aca es
🆕 sin precedente **escalado a 🟡** — el temario oficial vigente lo lista y el historico no lo
contradice, solo lo omite.

**Accion pendiente:** conseguir e ingestar material de Diseño Modular y de punto flotante.
`raw/clases_teoricas/` tiene 5 teoricas para 10 unidades — el material historico disponible
esta incompleto respecto del temario vigente.

---

## Cursada vigente y procedencia del material

**Cursada vigente:** `2C_2026`.
**Carpeta de material:** `raw/cursada_2C_2026/{teo,prac,guias}/` — preparada para recibir PDFs.

Toda la wiki de Sistemas Digitales proviene hoy de material historico
(`raw/clases_teoricas/`, `raw/guias_practicas/`, `raw/contenido_comunidad/`), tomado bajo el
esquema de dos parciales. Todas las paginas estan de hecho en `pendiente_verificacion`.

**Esta es la materia donde el material de la cursada vigente mas importa**, porque es la unica
de las tres cuyo esquema de evaluacion cambio. El material nuevo se deposita en la subcarpeta
correspondiente y, si se ingesta con `/ingestar`, la ruta vigente activa el modo reconciliacion.
Priorizar las unidades sin cobertura (6, 7 y punto flotante de la 5).

Para material de la cursada que **no** se quiere ingestar y solo se quiere convertir en material
de estudio priorizado contra los parciales, usar
`/priorizar <teoria|practica|guia> <ruta_pdf>` — escribe en `cursada_actual/`, no toca la wiki.

## Mapa tema → parcial (formato para maquinas)

```yaml
vigencia: 2C_2026
esquema: parcial_unico       # "1P" = el unico parcial; no existe 2P
temas:
  representacion_de_informacion: 1P
  logica_combinatoria: 1P
  logica_secuencial: 1P
  diseno_modular: 1P         # sin pagina propia todavia
  arquitectura: 1P           # era 2P bajo el esquema viejo
  programacion_risc_v: 1P    # era 2P bajo el esquema viejo
  microarquitectura: 1P      # era 2P bajo el esquema viejo
```

---

## Como leer el material historico

| Dato | Significado | ¿Cambia con el programa? |
|---|---|---|
| `parcial:` en `wiki/temas/` y `wiki/tipos_ejercicio/` | "Para que parcial **tenes que estudiar** esto" | **Si** — derivado de este archivo. Hoy: siempre `1P` |
| `parcial:` en `wiki/parciales_analizados/` y `wiki/transcripciones/` | "Este examen **fue** un 1P/2P de tal cuatrimestre" | **No** — hecho historico |
| `apariciones_en_parciales:` en `tipos_ejercicio/` | "Este patron **aparecio** en estos examenes" | **No** — hecho historico |
| Nombres de `raw/` | Orden **original del dictado** | **No** — `raw/` es inmutable |

### Consecuencia 1 — las banderas 🔴 siguen valiendo

Una bandera `🔴 Si` significa **"este tipo de ejercicio lo toman"**. Sigue siendo cierta. Lo
que cambio es que ahora **todo** te lo pueden tomar en el mismo examen.

### Consecuencia 2 — los parciales pasados ya NO son simulacros validos

Ni los 1P ni los 2P historicos se parecen al parcial que vas a rendir:

- Un `1P_1C_2025` cubre 3 unidades de 10. Es **un tercio** de tu parcial.
- Un `2P_2C_2024` cubre otras 3. Tampoco alcanza.
- Tu parcial unico cubre las 10, incluyendo unidades **sin ningun precedente historico**
  (Diseño Modular, punto flotante).

- ✅ Siguen siendo un **banco de ejercicios excelente**, filtrando por tema.
- ❌ **No** los uses como simulacro de examen completo.
- ✅ Un simulacro razonable seria **combinar un 1P y un 2P historicos** y agregar ejercicios
  de Diseño Modular y punto flotante de otra fuente.

### Consecuencia 3 — todos los temas ex-2P estan reubicados

`arquitectura`, `programacion_risc_v` y `microarquitectura` pasaron de `2P` a `1P`. Al correr
`/tipos_ejercicio_run`, sus patrones llevan `reubicado: true`: sus `apariciones_en_parciales`
dicen "2P" y hoy son material del unico parcial.

---

## Historial de programas

### 2C 2026 — vigente

**La materia pasa de dos parciales a un parcial unico** que cubre las 10 unidades del temario.

| Tema | Antes | Ahora |
|---|---|---|
| representacion_de_informacion | 1P | **1P** (parcial unico) |
| logica_combinatoria | 1P | **1P** (parcial unico) |
| logica_secuencial | 1P | **1P** (parcial unico) |
| arquitectura | 2P | **1P** ⬅️ |
| programacion_risc_v | 2P | **1P** ⬅️ |
| microarquitectura | 2P | **1P** ⬅️ |
| diseno_modular | — | **1P** 🆕 (unidades 6 y 7, sin cobertura en la wiki) |

Ademas, el temario vigente explicita contenido que el material historico no cubre: punto fijo
y flotante, restadores, comparadores.

### Hasta 1C 2026 — historico

Esquema de **dos parciales**, bajo el cual fueron tomados **todos** los parciales de
`wiki/parciales_analizados/`:

- **1P:** Representacion de la Informacion, Logica Combinatoria, Logica Secuencial
- **2P:** Programacion RISC-V, Arquitectura, Microarquitectura

El corte era limpio: los 6 parciales analizados coinciden sin una sola excepcion.

---

## Procedimiento cuando cambie el programa

1. Editar la **Tabla vigente** y el **Mapa tema → parcial** de este archivo.
2. Agregar la entrada al **Historial de programas** con el diff de movimientos.
3. Correr `/programa` — propaga `parcial:` + `programa:` al frontmatter de
   `wiki/temas/` y `wiki/tipos_ejercicio/`, y regenera el agrupamiento de `index.md`.
4. **No tocar** `raw/`, `parciales_analizados/`, `transcripciones/` ni
   `apariciones_en_parciales`.
