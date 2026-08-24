# Sistemas Digitales — Wiki

## 1. Contexto del proyecto

**Materia:** Sistemas Digitales
**Universidad:** UBA — Ciencias de la Computacion
**Sistema de evaluacion:** **un parcial unico** que cubre las 10 unidades del temario (programa `2C_2026`). Por convencion se rotula `1P`; **no existe 2P**
**Estrategia de estudio:** practica_parciales — parciales primero para identificar patrones, luego teoria, luego guias practicas
**Objetivo:** herramienta de consulta basada 100% en la base de conocimiento ingresada. El LLM escribe y mantiene la wiki; el usuario la consulta y navega en Obsidian.

**Temas por parcial** (resumen legible — la **fuente de verdad** es `programa.md`; el campo
`parcial:` del frontmatter es derivado de ahi y se propaga con `/programa`):

| Parcial | Temas |
|---------|-------|
| `1P` (parcial unico) | Representacion de la Informacion, Logica Combinatoria, Logica Secuencial, Diseño Modular, Arquitectura de Computadoras (partes 1 y 2), Programacion RISC-V, Microarquitectura |
| `2P` | — no existe |

**Diff de reubicaciones (programa `2C_2026`, propagado el 2026-08-24):**

| Tema | Antes | Ahora |
|---|---|---|
| representacion_de_informacion | 1P | 1P (parcial unico) |
| logica_combinatoria | 1P | 1P (parcial unico) |
| logica_secuencial | 1P | 1P (parcial unico) |
| arquitectura | 2P | **1P** ⬅️ reubicado |
| programacion_risc_v | 2P | **1P** ⬅️ reubicado |
| microarquitectura | 2P | **1P** ⬅️ reubicado |
| diseno_modular | — | **1P** 🆕 sin pagina propia (unidades 6 y 7) |

Consecuencias: los 6 parciales de `wiki/parciales_analizados/` fueron tomados bajo el esquema
viejo de dos parciales — sus rotulos `1P`/`2P` son **hechos historicos** y **ninguno sirve como
simulacro completo**. Los patrones de `tipos_ejercicio/` que venian de 2P llevan aviso de
reubicacion. Huecos del temario vigente sin cobertura en la wiki: Diseño Modular (unidades 6 y
7), punto fijo y flotante, restadores, comparadores — detalle en `programa.md`.

---

## 2. Estructura de directorios

```
sistemas_digitales/
├── CLAUDE.md                      ← este archivo
├── programa.md                    ← FUENTE DE VERDAD del reparto de temas por parcial
├── index.md                       ← catalogo completo del wiki
├── log.md                         ← registro append-only de operaciones
│
├── raw/                           ← PDFs originales, INMUTABLES
│   ├── clases_teoricas/           ← 6 PDFs — slides Beamer fotografiadas (vision)
│   │   ├── 1.teo_representacion_de_informacion.pdf   (64 pags)
│   │   ├── 2.teo_logica_combinatoria.pdf             (93 pags)
│   │   ├── 3.teo_logica_secuencial.pdf               (83 pags)
│   │   ├── 4.teo_arquitectura_parte_1.pdf            (160 pags)
│   │   ├── 4.teo_arquitectura_parte_2.pdf            (74 pags)
│   │   └── 5.teo_microarquitectura.pdf               (62 pags)
│   ├── guias_practicas/           ← 5 PDFs — guias de ejercicios
│   │   ├── 1.prac_representacion_de_informacion.pdf
│   │   ├── 2.prac_logica_digital_parte_1.pdf
│   │   ├── 2.prac_logica_digital_parte_2.pdf
│   │   ├── 3.prac_arquitectura_cpu.pdf
│   │   └── 4.prac_programacion_RISC-V.pdf
│   ├── parciales/
│   │   ├── 1P/                    ← 4 PDFs — fotografiados (vision)
│   │   │   ├── 1.parcial_1C_2025_resolucion.pdf
│   │   │   ├── 1.parcial_2C_2024_recuperatorio.pdf
│   │   │   ├── 1.parcial_2C_2024_resolucion_(1).pdf
│   │   │   └── 1.parcial_2C_2024_resolucion_(2).pdf
│   │   └── 2P/                    ← 4 PDFs — fotografiados (vision)
│   │       ├── 2.parcial_1C_2025_resolucion_(1).pdf
│   │       ├── 2.parcial_1C_2025_resolucion_(2).pdf
│   │       ├── 2.parcial_2C_2024_resolucion.pdf
│   │       └── 2.parcial_2C_2024_resolucion_recuperatorio.pdf
│   └── contenido_comunidad/       ← 1 PDF — resumen estudiantil (pdftotext)
│       └── resumen_sistemas_digitales.pdf
│
└── wiki/                          ← todo generado por el LLM
    ├── temas/                     ← paginas _teoria, _practica, _guia por tema
    ├── tipos_ejercicio/           ← patrones recurrentes en parciales
    ├── parciales_analizados/      ← cada parcial extraido y analizado
    ├── transcripciones/           ← para parciales fotografiados
    └── sintesis/                  ← paginas cross-tema a demanda
```

**Nota:** Los PDFs originales tambien existen en las carpetas raiz (sin prefijo `raw/`) — son los archivos fuente de sistema. Usar siempre los de `raw/` para referencias del wiki.

---

## 3. Tipos de paginas y sus templates

### Regla fundamental: paginas focalizadas, nunca monoliticas

Un PDF no genera necesariamente una sola pagina wiki — puede generar varias si cubre multiples temas. Ninguna pagina debe ser demasiado extensa — paginas largas degradan el retrieval.

### Nomenclatura

| Caso | Nombre |
|------|--------|
| Teoria (un PDF) | `[tema]_teoria.md` |
| Teoria (multiples) | `[tema]_teoria_pt1.md`, `_pt2.md` |
| Guia | `[tema]_guia.md` (o `_pt1.md`) |

### 3.1 Paginas de teoria (`[tema]_teoria.md`)

Extraccion fiel y estructurada del contenido teorico. NO simplificar ni parafrasear — la simplificacion ocurre en runtime.

**Frontmatter:**
```yaml
---
nombre: Logica Combinatoria — Teoria
parcial: 1P
tipo: teoria
tema: logica_combinatoria
fuente: raw/clases_teoricas/2.teo_logica_combinatoria.pdf
paginas_relacionadas:
  - "[[logica_combinatoria_guia]]"
---
```

**Secciones:**
- `## Concepto y definicion`
- `## Cuando se aplica`
- `## Propiedades y teoremas`
- `## Formulas clave`
- `## Ver tambien`

### 3.2 Paginas de guia (`[tema]_guia.md`)

Ejercicios de la guia practica. Workflow de dos fases:
- **Fase 1 (ingest):** extraer enunciados, explicaciones, cruzar con parciales. Resolucion y Chuleta quedan `[PENDIENTE — sesion de resolucion]`
- **Fase 2 (`/resolver`):** sesion dedicada para resolver cada ejercicio

**Frontmatter:**
```yaml
---
nombre: Logica Combinatoria — Guia de Ejercicios
parcial: 1P
tipo: guia
tema: logica_combinatoria
fuente: raw/guias_practicas/2.prac_logica_digital_parte_1.pdf
paginas_relacionadas:
  - "[[logica_combinatoria_teoria]]"
---
```

**Secciones:**
```markdown
## Indice de ejercicios
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | ... | 🔴 Si |

## Ejercicios

### Ejercicio 1 — [titulo breve]

**Enunciado**
[texto extraido fielmente — Fase 1]

**Explicacion**
[que pide, que concepto activa — Fase 1]

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

**Chuleta**
[PENDIENTE — sesion de resolucion]

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/X]] | ⚪ No
```

### 3.3 Tipos de ejercicio (`tipos_ejercicio/[patron].md`)

Arma de examen. Nace del analisis de parciales.

**Frontmatter:**
```yaml
---
nombre: Logica Combinatoria — Simplificar con Karnaugh
parcial: 1P
tema: logica_combinatoria
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_2C_2024_resolucion_(1).pdf
---
```

**Secciones:**
- `## Como reconocer este patron`
- `## Template de resolucion`
- `## Por que funciona`
- `## Apariciones en parciales`
- `## Ejercicios que ejemplifican esto`

### 3.4 Parciales analizados (`parciales_analizados/[id].md`)

**ID format:** `[numero_parcial]P_[cuatrimestre]C_[año]` — ej: `1P_2C_2024`

**Frontmatter:**
```yaml
---
parcial: 1P
cuatrimestre: 2C
año: 2024
tipo_pdf: fotografiado
fuente: raw/parciales/1P/1.parcial_2C_2024_resolucion_(1).pdf
transcripcion: "[[transcripciones/1P_2C_2024_res1_raw]]"
temas_evaluados:
  - representacion_de_informacion
  - logica_combinatoria
---
```

**Por ejercicio:**
```markdown
## Ejercicio 1 — [tema]

### Enunciado
[extraido del PDF — fiel]

### Resolucion
[extraida del PDF]

### Explicacion
[LLM: que pide, que concepto usa, por que se resuelve asi]

### Analisis de la resolucion
[LLM evalua: correcta/incorrecta, senala errores si los hay]

### Chuleta
> 1. Identificar X → 2. Plantear Y → 3. Resolver Z
```

### 3.5 Transcripciones (`transcripciones/[id]_raw.md`)

Solo para PDFs fotografiados. Transcripcion fiel via Claude vision.

```yaml
---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_2C_2024_resolucion_(1).pdf
metodo: claude_vision
---
```

### 3.6 Sintesis (`sintesis/[nombre].md`)

A demanda. Paginas cross-tema generadas por consultas reutilizables.

---

## 4. Convenciones

- **Idioma:** espanol en todo el wiki. Nombres tecnicos en ingles si asi aparecen en las clases
- **Frontmatter:** obligatorio en todas las paginas
- **Links internos:** sintaxis Obsidian `[[nombre_pagina]]`
- **Citas a fuentes:** path relativo desde raiz de materia (ej: `raw/clases_teoricas/2.teo_logica_combinatoria.pdf`)
- **Nomenclatura:** snake_case, sin espacios
- **Formulas matematicas:** preservar SIEMPRE en notacion LaTeX
  - Inline: `$A \cdot B + \overline{A}$`
  - Bloque: `$$\sum_{i=0}^{n} f(i)$$`
  - Nunca parafrasear ni convertir formulas a texto plano — Obsidian las renderiza con MathJax
  - Si Claude vision no puede leer una formula, marcar con `[FORMULA ILEGIBLE — revisar fuente]`

---

## 5. Workflow de Ingest

```
ANTES DE INICIAR CUALQUIER SESION DE INGEST:
Leer log.md y verificar que archivos ya fueron procesados.
El ingest es resumible: cada sesion continua desde donde termino la anterior.
Nunca reingestar un archivo que ya aparece en log.md.

TAMAÑO DE SESION RECOMENDADO:
- PDFs cortos (parciales, transcripciones): hasta 4 por sesion
- PDFs medianos (clases teo, ~60-100 pags Beamer): 2-3 por sesion
- PDFs largos (arquitectura parte_1: 160 pags): 1 por sesion
- PDFs fotografiados (vision): 2-3 por sesion
Si el contexto supera el 60% de capacidad, cerrar la sesion,
hacer commit, y continuar en una nueva sesion.

ORDEN OBLIGATORIO:
1. parciales/1P/  — primero siempre (4 PDFs, todos vision)
2. parciales/2P/  — segundo (4 PDFs, todos vision)
3. clases_teoricas/ — por numero cronologico (6 PDFs, todos vision)
4. guias_practicas/ — por numero cronologico (5 PDFs)
5. contenido_comunidad/ — al final (1 PDF, pdftotext)

POR CADA DOCUMENTO:
a. Verificar si pdftotext extrae > 500 chars. Si no → usar Claude vision
b. Para parciales fotografiados: crear wiki/transcripciones/[id]_raw.md primero
c. Crear/actualizar las paginas relevantes del wiki
d. Actualizar index.md
e. Agregar entrada al log.md: ## [FECHA] ingest | [nombre_archivo]
```

### Observacion critica sobre Beamer

Los PDFs de clases son slides Beamer fotografiadas. Cada "build" incremental puede ocupar paginas PDF separadas con contenido repetido. NO tratar cada pagina como contenido distinto — consolidar en la version final de cada elemento.

### Parciales con multiples resoluciones

Los parciales `resolucion_(1)` y `resolucion_(2)` del mismo examen son resoluciones alternativas del mismo examen — crear una sola pagina e incluir ambas, anotando discrepancias.

---

## 6. Workflow de Query

```
a. Leer index.md para identificar paginas relevantes
b. Leer las paginas relevantes del wiki
c. Sintetizar respuesta con citas (formato: [fuente])
d. Si la respuesta es sintesis valiosa y reutilizable → sugerir guardar en sintesis/
e. Respuestas basadas SOLO en la base de conocimiento, salvo que el usuario
   solicite explicitamente busqueda web
```

---

## 7. Workflow de Lint

```
- Paginas sin links entrantes (huerfanas)
- Banderas "⚪ Pendiente" en _guia.md que ya pueden completarse
- Temas mencionados sin pagina propia
- Contradicciones entre paginas
- Sugerir nuevas consultas y fuentes
```

---

## 8. Workflow de actualizacion de banderas

```
Este workflow usa los parciales_analizados/ como fuente de verdad.

- Leer todos los wiki/parciales_analizados/ e identificar patrones recurrentes
- Crear paginas en tipos_ejercicio/ para cada patron identificado
- Revisar cada ejercicio en _guia.md
- Actualizar bandera de "⚪ Pendiente" a "🔴 Si → [[tipos_ejercicio/X]]" o "⚪ No"
```

---

## 9. Comandos disponibles

Implementados como slash commands en `.claude/commands/` (la raiz del repo). Cada archivo contiene el workflow completo.

| Comando | Descripcion |
|---------|-------------|
| `/ingestar <ruta>` | Ingestar un PDF al wiki |
| `/ingestar_batch <carpeta>` | Ingestar todos los PDFs de una carpeta |
| `/resolver <ruta_guia>` | Fase 2: resolver ejercicios pendientes de una guia |
| `/corregir <ruta> "<obs>"` | Corregir pagina con aprobacion previa |
| `/lint` | Chequeo de salud del wiki |
| `/estado` | Resumen ejecutivo del wiki |
| `/chuleta <tema>` | Chuletas consolidadas de un tema |
| `/parcial <1P\|2P>` | Vista orientada a examen (`1P` devuelve todo el programa; `2P` no devuelve nada — no existe) |
| `/simular [tema]` | Generar ejercicio de practica |
| `/sintesis <nombre>` | Guardar sintesis en wiki |
| `/fuente_original [ruta]` | Acceder al PDF original |
| `/resumen <tema>` | Resumen pedagogico de un tema para arrancar a resolver ejercicios |
| `/tipos_ejercicio_scan` | Detectar patrones recurrentes cruzando parciales analizados |
| `/tipos_ejercicio_run` | Crear paginas `tipos_ejercicio/` y actualizar banderas |
| `/tipos_ejercicio` | Paso 9 del pipeline: scan + run en una pasada |
| `/programa` | Propagar `programa.md` cuando la catedra cambia que temas entran en cada parcial |

---

## 10. Restricciones

- **Nunca modificar archivos en raw/** — son inmutables
- **Nunca responder con informacion fuera del wiki** (salvo web search explicito del usuario)
- **Siempre actualizar index.md y log.md** despues de cada operacion de escritura
- **Idioma del wiki:** espanol; nombres tecnicos en ingles si asi aparecen en clases
- **Formulas:** siempre LaTeX, nunca texto plano
- **PATH de pdftotext:** `/opt/homebrew/bin/pdftotext`
