# Algoritmos y Estructuras de Datos III — Wiki

## 1. Contexto del proyecto

**Materia:** Tecnicas de Diseno de Algoritmos (nombre oficial: Algoritmos y Estructuras de Datos III)
**Universidad:** UBA — Ciencias de la Computacion
**Sistema de evaluacion:** dos parciales (1P y 2P), cada uno cubriendo 5-6 temas
**Estrategia de estudio:** teoria en rasgos generales → practica de guias (priorizando ejercicios que aparecen en parciales) → practica intensiva con parciales pasados cerca del examen
**Objetivo:** herramienta de consulta basada 100% en la base de conocimiento ingresada. El LLM escribe y mantiene la wiki; el usuario la consulta y navega en Obsidian.

**Temas por parcial:**

| Parcial | Temas |
|---------|-------|
| 1P | Divide & Conquer, Fuerza Bruta & Backtracking, Programacion Dinamica (top-down + bottom-up), Greedy, Definiciones y Demostraciones |
| 2P | Grafos (representacion + demos), Arboles, Arboles Generadores Minimos, Caminos Minimos, Flujo en Redes |

---

## 2. Estructura de directorios

```
tda/
├── CLAUDE.md                      ← este archivo
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
- **Frontmatter:** obligatorio en todas las paginas
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

Implementados como slash commands en `.agents/workflows/`. Cada archivo contiene el workflow completo.

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

---

## 10. Restricciones

- **Nunca modificar archivos en raw/** — son inmutables
- **Nunca responder con informacion fuera del wiki** (salvo web search explicito del usuario)
- **Siempre actualizar index.md y log.md** despues de cada operacion de escritura
- **Idioma del wiki:** espanol; nombres tecnicos en ingles si asi aparecen en clases
- **Formulas:** siempre LaTeX, nunca texto plano

---

## Notas especiales sobre archivos

- **Archivos con mismo numero de tema** (ej: `3.teo_1P_demo_mochila.pdf` y `3.teo_1P_programacion_dinamica.pdf`): pertenecen al mismo tema, integrar en la misma pagina de teoria
- **`6.prac_1P_repaso_para_primer_parcial.pdf` y `14.prac_2P_repaso_para_segundo_parcial.pdf`:** materiales de repaso, pueden generar paginas en sintesis/
- **`3.guia_1P_teoria_algoritmica_de_grafos.pdf`:** numerada como 1P pero cubre contenido de grafos — verificar y asignar `parcial: ambos` si corresponde
- **Parciales con multiples resoluciones** (`resolucion(1)` y `resolucion(2)` del mismo examen): crear una sola pagina e incluir ambas, anotando discrepancias
- **PATH de pdftotext:** `/opt/homebrew/bin/pdftotext`
