# Paradigmas de Programación — Wiki

## 1. Contexto del proyecto

**Materia:** Paradigmas de Programación (plp)
**Universidad:** UBA — Ciencias de la Computacion
**Sistema de evaluacion:** dos parciales (1P y 2P), de forma similar a Algoritmos y Estructuras de Datos III.
El rotulo `1P`/`2P` en el nombre de los archivos de `raw/` es el **rotulo original del dictado**, no la
fuente de verdad: para saber en que parcial entra un tema se lee siempre **[[programa]]** (`programa.md`).
**Estrategia de estudio:** teoria en rasgos generales → practica de guias (priorizando ejercicios que aparecen en parciales) → practica intensiva con parciales pasados cerca del examen (misma estrategia que Algoritmos III).
**Objetivo:** herramienta de consulta basada 100% en la base de conocimiento ingresada. El LLM escribe y mantiene la wiki; el usuario la consulta y navega en Obsidian.

**Temas por parcial:** definidos en **[[programa]]** (`programa.md`) — unica fuente de verdad.
**Nunca hardcodear el mapeo tema→parcial en este archivo ni en los comandos: leer siempre `programa.md`.**

Resumen vigente (2C 2026) — transcripcion del listado oficial de la catedra:

| Parcial | Bloques oficiales | Temas internos (slug) |
|---------|-------------------|-----------------------|
| 1P | Programación funcional (en Haskell) · Razonamiento ecuacional e inducción estructural · Deducción natural para lógica **proposicional** · Sistemas de tipos y reducción | `programacion_funcional`, `demostracion_de_propiedades`, `sistemas_deductivos_y_deduccion_natural`, `calculo_lambda_tipado` |
| 2P | Inferencia y compilación · Lógica de primer orden · Resolución lógica · Programación lógica (en Prolog) · Programación orientada a objetos (en SmallTalk) | `unificacion_e_inferencia`, `interpretacion`, `logica_de_primer_orden`, `resolucion`, `programacion_logica`, `programacion_orientada_objetos`, `correspondencia_curry_howard` |
| ambos | — | Ninguno |

`correspondencia_curry_howard` no figura en el listado oficial de ningun parcial; se deja en `2P`
por el rotulo del dictado (`6.teo_2P_...`). Ver `programa.md`.

### Reubicaciones: ninguna

**En PLP el reparto NO cambio.** El listado oficial de 2C 2026 coincide con el reparto bajo el que
se tomaron los 11 parciales de `wiki/parciales_analizados/` (1C 2024 a 2C 2025). Consecuencias:

- ✅ Los parciales pasados **si** sirven como simulacro completo de examen.
- ✅ No hay ningun tema `reubicado: true` ni ningun aviso de reubicacion en `tipos_ejercicio/`.
- La unica variacion observada es de **enfasis dentro del mismo programa**: el Ej 3a del 2P paso de
  Smalltalk a Inferencia de Tipos a partir de 2C 2024. Los dos bloques siguen en el listado oficial.

### Deducción Natural cruza los dos parciales, pero por bloques distintos

| Donde | Que DN | Bloque oficial | Tema interno |
|---|---|---|---|
| 1P, Ej 2b | Proposicional / intuicionista | Deducción natural para lógica proposicional | `sistemas_deductivos_y_deduccion_natural` |
| 2P, Ej 3b | Con cuantificadores ∀/∃ | Lógica de primer orden | `logica_de_primer_orden` |

Por eso `tipos_ejercicio/deduccion_natural_lpo` declara `tema: logica_de_primer_orden`, **no**
`sistemas_deductivos_y_deduccion_natural`. Ver `programa.md`.

### Dos significados de `1P`/`2P` — no confundirlos

| Dato | Significado | ¿Se actualiza con el programa? |
|------|-------------|-------------------------------|
| `parcial:` en `wiki/temas/`, `wiki/tipos_ejercicio/` | Para que parcial hay que **estudiarlo** | **Si** — derivado de `programa.md`, lleva `programa: <vigencia>` al lado |
| `parcial:` en `wiki/parciales_analizados/`, `wiki/transcripciones/` | Este examen **fue** un 1P/2P de tal cuatrimestre | **No** — hecho historico |
| `apariciones_en_parciales:` en `tipos_ejercicio/` | Este patron **aparecio** en estos examenes | **No** — hecho historico |
| Rotulos `1P`/`2P` en nombres de `raw/` | Orden y rotulo **originales del dictado** | **No** — `raw/` es inmutable |

---

## 2. Estructura de directorios

```
plp/
├── CLAUDE.md                      ← este archivo
├── programa.md                    ← temas por parcial del cuatrimestre vigente (FUENTE DE VERDAD)
├── index.md                       ← catalogo completo del wiki
├── log.md                         ← registro append-only de operaciones
│
├── raw/                           ← PDFs originales, INMUTABLES
│   ├── clases/
│   │   ├── teo/                   ← 15 PDFs — LaTeX Beamer
│   │   └── prac/                  ← 20 PDFs — LaTeX Beamer
│   ├── guias_practicas/           ← 7 PDFs — LaTeX
│   ├── parciales/
│   │   ├── 1P/                    ← 4 PDFs — mix digital + fotografiado
│   │   └── 2P/                    ← 4 PDFs — mix digital + fotografiado
│   ├── contenido_comunidad/       ← 1 PDF — Word export
│   └── assets/                    ← imagenes de Obsidian Web Clipper
│
└── wiki/                          ← todo generado por el LLM
    ├── temas/                     ← paginas _teoria, _practica, _guia por tema
    ├── tipos_ejercicio/           ← patrones recurrentes en parciales
    ├── parciales_analizados/      ← cada parcial extraido y analizado
    ├── transcripciones/           ← SOLO para parciales fotografiados
    └── sintesis/                  ← paginas cross-tema a demanda
```

---

## 3. Tipos de paginas y sus templates

### Regla fundamental: paginas focalizadas, nunca monoliticas

Un PDF no genera necesariamente una sola pagina wiki — puede generar varias si cubre multiples temas. Varios PDFs del mismo tema pueden colapsar en una pagina si el contenido es acotado. Ninguna pagina debe ser demasiado extensa — paginas largas degradan el retrieval.

### Nomenclatura

| Caso | Nombre |
|------|--------|
| Teoria (un PDF) | `[tema]_teoria.md` |
| Teoria (multiples) | `[tema]_teoria_pt1.md`, `_pt2.md` |
| Practica | `[tema]_practica.md` (o `_pt1.md`) |
| Guia | `[tema]_guia.md` (o `_pt1.md`) |

### 3.1 Paginas de teoria (`[tema]_teoria.md`)

Extraccion fiel y estructurada del contenido teorico. NO simplificar ni parafrasear — la simplificacion ocurre en runtime.

**Frontmatter:**
```yaml
---
nombre: Divide & Conquer — Teoria
parcial: 1P
programa: 2C_2026
tipo: teoria
tema: divide_y_conquista
fuente: raw/clases/teo/1.teo_1P_divide_&_conquer.pdf
paginas_relacionadas:
  - "[[dc_practica]]"
  - "[[dc_guia]]"
---
```

**Secciones:**
- `## Concepto y definicion`
- `## Cuando se aplica`
- `## Propiedades y teoremas`
- `## Demostraciones`
- `## Formulas clave`
- `## Ver tambien`

### 3.2 Paginas de clase practica (`[tema]_practica.md`)

Ejercicios resueltos en clase por el profesor. Contenido fiel al PDF.

**Frontmatter:**
```yaml
---
nombre: Divide & Conquer — Clase Practica
parcial: 1P
programa: 2C_2026
tipo: practica
tema: divide_y_conquista
fuente: raw/clases/prac/1.prac_1P_divide_&_conquer.pdf
paginas_relacionadas:
  - "[[dc_teoria]]"
  - "[[dc_guia]]"
---
```

**Secciones por ejercicio:**
```markdown
## Patrones de este tema en parciales
> [[tipos_ejercicio/dc_recurrencias]] · [[tipos_ejercicio/dc_diseno]]
(se completa despues de analizar parciales)

## Ejercicios de clase

### Ejercicio — [titulo breve]

**Enunciado**
[texto extraido fielmente]

**Explicacion**
[que concepto activa y que hay que tener claro]

**Resolucion paso a paso**
1. [paso] — *por que: [justificacion]*

**Chuleta**
> 1. Identificar X → 2. Plantear Y → 3. Calcular Z

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/X]] | ⚪ No
```

### 3.3 Paginas de guia (`[tema]_guia.md`)

Ejercicios de la guia practica oficial. Workflow de dos fases:
- **Fase 1 (ingest):** extraer enunciados, explicaciones, cruzar con parciales. Resolucion y Chuleta quedan `[PENDIENTE — sesion de resolucion]`
- **Fase 2 (`/resolver`):** sesion dedicada para resolver cada ejercicio

**Guias multi-tema:** distribuir ejercicios a la pagina de guia del tema correspondiente.

**Frontmatter:**
```yaml
---
nombre: Divide & Conquer — Guia de Ejercicios
parcial: 1P
programa: 2C_2026
tipo: guia
tema: divide_y_conquista
fuente: raw/guias_practicas/1.guia_1P_divide_&_conquer.pdf
paginas_relacionadas:
  - "[[dc_teoria]]"
  - "[[dc_practica]]"
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

### 3.4 Tipos de ejercicio (`tipos_ejercicio/[patron].md`)

Arma de examen. Nace del analisis de parciales. Orientado a memorizacion y reconocimiento rapido.

**Frontmatter:**
```yaml
---
nombre: D&C — Resolver recurrencia con Master Theorem
parcial: 1P
programa: 2C_2026
tema: divide_y_conquista
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
---
```

**Secciones:**
- `## Como reconocer este patron`
- `## Template de resolucion`
- `## Por que funciona`
- `## Apariciones en parciales`
- `## Ejercicios que ejemplifican esto`

### 3.5 Parciales analizados (`parciales_analizados/[id].md`)

Cada parcial extraido, analizado y anotado. Fuente de verdad para tipos_ejercicio y banderas.

**ID format:** `[numero_parcial]P_[cuatrimestre]C_[año]` — ej: `1P_1C_2024`

**Frontmatter:**
```yaml
---
parcial: 1P
cuatrimestre: 1C
año: 2024
tipo_pdf: digital
fuente: raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
transcripcion: null
temas_evaluados:
  - divide_y_conquista
  - backtracking
---
```

**Por ejercicio:**
```markdown
## Ejercicio 1 — Backtracking

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

### 3.6 Transcripciones (`transcripciones/[id]_raw.md`)

Solo para parciales fotografiados. Transcripcion fiel via Claude vision.

```yaml
---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_1C_2025_resolucion(1).pdf
metodo: claude_vision
---
```

### 3.7 Sintesis (`sintesis/[nombre].md`)

A demanda. Paginas cross-tema generadas por consultas reutilizables.

---

## 4. Convenciones

- **Idioma:** espanol en todo el wiki. Nombres tecnicos de algoritmos en ingles si asi aparecen en las clases
- **Frontmatter:** obligatorio en todas las paginas. `tema:` es el **slug snake_case** del mapa de
  `programa.md` (nunca texto libre en castellano); `parcial:` es `1P`/`2P` (nunca `1`/`2`) y siempre
  lleva `programa: <vigencia>` inmediatamente debajo
- **Links internos:** sintaxis Obsidian `[[nombre_pagina]]`
- **Citas a fuentes:** path relativo desde raiz de materia (ej: `raw/clases/teo/1.teo_1P_divide_&_conquer.pdf`)
- **Nomenclatura:** snake_case, sin espacios
- **Formulas matematicas:** preservar SIEMPRE en notacion LaTeX
  - Inline: `$T(n) = 2T(n/2) + n$`
  - Bloque: `$$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$`
  - Nunca parafrasear ni convertir formulas a texto plano — Obsidian las renderiza con MathJax
  - Si `pdftotext` produce caracteres corruptos en una formula, reconstruirla desde el contexto o marcar con `[FORMULA ILEGIBLE — revisar fuente]`

---

## 5. Workflow de Ingest

```
ANTES DE INICIAR CUALQUIER SESION DE INGEST:
Leer log.md y verificar que archivos ya fueron procesados.
El ingest es resumible: cada sesion continua desde donde termino la anterior.
Nunca reingestar un archivo que ya aparece en log.md.

TAMAÑO DE SESION RECOMENDADO:
- PDFs cortos (parciales, transcripciones): hasta 6 por sesion
- PDFs medianos (clases teo/prac, ~100-200 pags Beamer): 3-4 por sesion
- PDFs largos (guias con muchos ejercicios): 2-3 por sesion
- PDFs fotografiados (vision): 2-3 por sesion
Si el contexto supera el 60% de capacidad, cerrar la sesion,
hacer commit, y continuar en una nueva sesion.

ORDEN OBLIGATORIO:
1. parciales/1P/ y parciales/2P/ — primero siempre
2. clases/teo/ — por numero cronologico
3. clases/prac/ — por numero cronologico
4. guias_practicas/ — por numero cronologico
5. contenido_comunidad/ — al final

POR CADA DOCUMENTO:
a. Verificar si pdftotext extrae > 500 chars. Si no → usar Claude vision
b. Para parciales fotografiados: crear wiki/transcripciones/[id]_raw.md primero
c. Crear/actualizar las paginas relevantes del wiki
d. Actualizar index.md
e. Agregar entrada al log.md: ## [FECHA] ingest | [nombre_archivo]
```

### Observacion critica sobre Beamer

Los PDFs de clases son LaTeX Beamer. Cada "build" incremental ocupa una pagina PDF separada. Un ejercicio en 5 pasos genera 5 paginas PDF con contenido repetido. NO tratar cada pagina como contenido distinto — consolidar en la version final de cada elemento. Senal: bloques de texto casi identicos con pequenas adiciones.

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
- Banderas "⚪ Pendiente" en _practica.md y _guia.md que ya pueden completarse
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
- Revisar cada ejercicio en _practica.md y _guia.md
- Actualizar bandera de "⚪ Pendiente" a "🔴 Si → [[tipos_ejercicio/X]]" o "⚪ No"
- Actualizar seccion "Patrones de este tema en parciales" en cada _practica.md
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
| `/parcial <1P\|2P>` | Vista orientada a examen |
| `/simular [tema]` | Generar ejercicio de practica |
| `/sintesis <nombre>` | Guardar sintesis en wiki |
| `/fuente_original [ruta]` | Acceder al PDF original |
| `/resumen <tema>` | Resumen pedagogico de un tema para arrancar a resolver ejercicios |
| `/tipos_ejercicio_scan` | Detectar patrones recurrentes cruzando parciales analizados |
| `/tipos_ejercicio_run` | Crear paginas `tipos_ejercicio/` y actualizar banderas |
| `/tipos_ejercicio` | Paso 9 del pipeline: scan + run en una pasada |
| `/programa` | Propagar `programa.md` cuando la catedra cambia que temas entran en cada parcial |
| `/priorizar <ruta_pdf>` | Analizar un PDF de la cursada contra los parciales. **No ingesta** |

---

## 10. Restricciones

- **Nunca modificar archivos en raw/** — son inmutables
- **Nunca responder con informacion fuera del wiki** (salvo web search explicito del usuario)
- **Siempre actualizar index.md y log.md** despues de cada operacion de escritura
- **Idioma del wiki:** espanol; nombres tecnicos en ingles si asi aparecen en clases
- **Formulas:** siempre LaTeX, nunca texto plano

---

## Notas especiales sobre archivos

- **Archivos con mismo numero de tema**: pertenecen al mismo tema, integrar en la misma pagina de teoria o practica segun corresponda.
- **Archivos de repaso**: materiales como `0.teo_1P_repaso.pdf` y `6.prac_P1_repaso_para_primer_parcial.pdf` se pueden usar para generar paginas en sintesis/.
- **Parciales con multiples resoluciones** (`resolucion(1)` y `resolucion(2)` del mismo examen): crear una sola pagina e incluir ambas, anotando discrepancias.
- **PATH de pdftotext:** `/opt/homebrew/bin/pdftotext`
