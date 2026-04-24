# Plan: LLM Wiki para Estudio Universitario — Algoritmos y Estructuras de Datos III

## Contexto

El usuario estudia Ciencias de la Computación en la UBA. El sistema de evaluación se basa en dos parciales por materia (1P y 2P), cada uno cubriendo 5-6 temas. La estrategia de estudio es: teoría en rasgos generales → práctica de guías (priorizando ejercicios que aparecen en parciales) → práctica intensiva con parciales pasados cerca del examen.

El objetivo es construir una herramienta basada en el patrón "LLM Wiki" de Andrej Karpathy (https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), adaptada a este caso: en lugar de ingestar markdown, se ingestan PDFs de distintos tipos (clases LaTeX, guías LaTeX, parciales fotografiados), y el conocimiento se compila en una wiki de markdown en Obsidian. El LLM escribe y mantiene la wiki; el usuario la consulta y navega.

**Materia piloto:** `Algoritmos_Estructuras_Datos_(III)` (nombre oficial: Técnicas de Diseño de Algoritmos)  
**Nombre del proyecto:** `llm-academic-wiki`
**Working directory:** `/Users/neonunez/Desktop/llm-academic-wiki/`
**Estructura:** un único repositorio git con una carpeta por materia. Cada materia tiene su propio `CLAUDE.md`, `index.md`, `log.md`, `raw/` y `wiki/` — completamente independientes entre sí.
**Alcance actual:** piloto con una sola materia (`Algoritmos_Estructuras_Datos_(III)`). La estructura multi-materia está diseñada desde el inicio para que la expansión a otras materias sea simplemente agregar una nueva carpeta con la misma estructura.  
**Herramientas:** Antigravity + Obsidian + git + pdftotext (poppler instalado en `/opt/homebrew/bin/`)

---

## Estado actual del repositorio

```
llm-academic-wiki/
└── Algoritmos_Estructuras_Datos_(III)/    ← materia piloto, 51 PDFs organizados
    ├── Clases/
    │   ├── teo/       (15 PDFs — LaTeX Beamer, texto extraíble)
    │   └── prac/      (20 PDFs — LaTeX Beamer, texto extraíble)
    ├── Guias_practicas/  (7 PDFs — LaTeX, texto extraíble)
    ├── Contenido_comunidad/  (1 PDF — Word export)
    └── Parciales/
        ├── 1P/   (4 PDFs — mix: 1 LaTeX digital + 3 fotografiados)
        └── 2P/   (4 PDFs — mix: 1 LaTeX digital + 3 fotografiados)
```

**Temas por parcial identificados:**

| Parcial | Temas |
|---------|-------|
| 1P | Divide & Conquer, Fuerza Bruta & Backtracking, Programación Dinámica (top-down + bottom-up), Greedy, Definiciones y Demostraciones |
| 2P | Grafos (representación + demos), Árboles, Árboles Generadores Mínimos, Caminos Mínimos, Flujo en Redes |

---

## Decisiones de Arquitectura (todas tomadas en sesión de planificación)

### D1 — Una wiki por materia (no por cuatrimestre)
Las materias son independientes. Mezclar 3 materias en una wiki genera ruido en las búsquedas y ensucia el `index.md`. La distinción 1P/2P se maneja con frontmatter dentro de la wiki de cada materia.

### D2 — PDFs originales viven en `raw/` (inmutables)
Los PDFs se mueven a `raw/` dentro del directorio de la materia. Son la fuente de verdad: el LLM los lee pero nunca los modifica. Para agregar un nuevo documento: soltar el PDF en la subcarpeta correcta de `raw/` y ejecutar ingest.

### D3 — Parsing PDF en ingest, nunca en query
Todos los PDFs se procesan una sola vez al ingestar. El resultado es markdown en `wiki/`. Las queries operan sobre markdown, nunca sobre los PDFs originales.

**Estrategia de parsing por tipo:**
- **LaTeX PDFs (clases, guías, parciales digitales):** `pdftotext` — extracción limpia y completa
- **PDFs fotografiados (parciales 2025 con 0-114 chars extraíbles):** Claude vision — el LLM lee la imagen y transcribe
- **Detección automática:** si `pdftotext` produce < 500 caracteres para un documento > 3 páginas, usar Claude vision como fallback

**Transcripciones intermedias SOLO para parciales fotografiados:** se guarda `wiki/transcripciones/[id]_raw.md` con la transcripción fiel antes de sintetizar. Esto permite verificar que Claude leyó correctamente la letra manuscrita. Para todos los demás tipos de PDF, se cita directo a `raw/`.

### D4 — Idioma del wiki: Español

### D5 — Ingest order importa
El orden correcto es: **parciales primero → clases → guías → comunidad**. Las páginas de práctica incluyen una bandera "¿Aparece en parciales?" por ejercicio, que solo puede completarse con conocimiento previo de los parciales.

### D6 — Síntesis explícita, no automática
Las páginas de `sintesis/` no se generan automáticamente. El LLM sugiere guardar cuando genera una respuesta particularmente reutilizable, pero el usuario decide. Comando explícito: *"guardá esto en sintesis/"*.

---

## Estructura de directorios final

```
llm-academic-wiki/                     ← un único repo git para todas las materias
├── .gitignore
├── README.md                          ← descripción del proyecto
├── .claude/
│   └── commands/                      ← slash commands nativos de Antigravity
│       ├── ingestar.md                ← /ingestar <ruta>
│       ├── ingestar_batch.md          ← /ingestar_batch <carpeta>
│       ├── resolver.md                ← /resolver <ruta_pagina_guia>
│       ├── corregir.md                ← /corregir <ruta_pagina> "<observación>"
│       ├── lint.md                    ← /lint
│       ├── estado.md                  ← /estado
│       ├── chuleta.md                 ← /chuleta <tema>
│       ├── parcial.md                 ← /parcial <1P|2P>
│       ├── simular.md                 ← /simular [tema]
│       ├── sintesis.md                ← /sintesis <nombre>
│       └── fuente_original.md         ← /fuente_original [ruta]
│
├── Algoritmos_Estructuras_Datos_(III)/    ← materia piloto
│   ├── CLAUDE.md                      ← esquema propio de esta materia
│   ├── index.md                       ← catálogo exclusivo de esta materia
│   ├── log.md                         ← log exclusivo de esta materia
│   ├── raw/
│   └── wiki/
│
├── [Materia_2]/                       ← misma estructura, wiki completamente independiente
│   ├── CLAUDE.md
│   ├── index.md
│   ├── log.md
│   ├── raw/
│   └── wiki/
│
└── [Materia_3]/                       ← ídem
    ├── CLAUDE.md
    ...

─────────────────────────────────────────
Detalle de Algoritmos_Estructuras_Datos_(III)/
─────────────────────────────────────────

Algoritmos_Estructuras_Datos_(III)/
    ├── CLAUDE.md                      ← esquema: reglas, convenciones, workflows
    ├── index.md                       ← catálogo completo del wiki (actualizado en cada ingest)
    ├── log.md                         ← registro append-only de operaciones
    │
    ├── raw/                           ← PDFs originales, INMUTABLES
    │   ├── clases/
    │   │   ├── teo/
    │   │   └── prac/
    │   ├── guias_practicas/
    │   ├── parciales/
    │   │   ├── 1P/
    │   │   └── 2P/
    │   ├── contenido_comunidad/
    │   └── assets/                    ← imágenes descargadas por Obsidian Web Clipper
    │
    └── wiki/                          ← todo generado por el LLM
        ├── temas/                     ← una página _teoria + una _practica por tema
        ├── tipos_ejercicio/           ← patrones recurrentes en parciales
        ├── parciales_analizados/      ← cada parcial extraído y analizado
        ├── transcripciones/           ← SOLO para parciales fotografiados
        └── sintesis/                  ← páginas cross-tema generadas a demanda
```

**Nomenclatura de PDFs en raw/:** se preserva exactamente la nomenclatura original del usuario. Ejemplo: `1.teo_1P_divide_&_conquer.pdf`

---

## Tipos de páginas del wiki

### Regla fundamental de retrieval: páginas focalizadas, nunca monolíticas

Inspirado directamente en Karpathy: "a single source might touch 10–15 wiki pages." Un PDF no genera necesariamente una sola página wiki — puede generar varias si cubre múltiples temas, o sus ejercicios pueden distribuirse entre páginas existentes. Del mismo modo, varios PDFs del mismo tema pueden colapsar en una sola página si el contenido es acotado.

**El principio guía no es 1:1, sino que ninguna página sea demasiado extensa.** Páginas largas degradan el retrieval: el LLM debe leer más para encontrar lo relevante. El objetivo es que cada página wiki sea lo suficientemente focalizada como para que el LLM la lea completa y en contexto cuando sea pertinente. Esto es exactamente lo que señala Karpathy: una fuente puede tocar 10–15 páginas wiki distintas — el contenido se distribuye, no se concentra.

Esto optimiza el retrieval del LLM (lee solo lo necesario) y produce páginas que el usuario puede navegar directamente en Obsidian.

**Convención de nomenclatura para páginas de temas:**

| Caso | Nombre de página |
|------|-----------------|
| Un solo PDF de teoría para el tema | `[tema]_teoria.md` |
| Múltiples PDFs de teoría para el tema | `[tema]_teoria_pt1.md`, `[tema]_teoria_pt2.md` |
| Clase práctica | `[tema]_practica.md` (o `_practica_pt1.md` si hay varios) |
| Guía de ejercicios | `[tema]_guia.md` (o `_guia_pt1.md` si es muy larga) |

**Ejemplos concretos con los archivos de la materia:**
```
1.teo_1P_divide_&_conquer.pdf          → dc_teoria.md
3.prac_1P_pd_top_down_parte1.pdf       → pd_practica_top_down_pt1.md
3.prac_1P_pd_top_down_parte2.pdf       → pd_practica_top_down_pt2.md
4.prac_1P_programacion_dinamica_bu.pdf → pd_practica_bottom_up.md
9.teo_2P_caminos_minimos1.pdf          → caminos_minimos_teoria_pt1.md   (196 págs)
10.teo_2P_caminos_minimos2.pdf         → caminos_minimos_teoria_pt2.md
1.guia_1P_divide_&_conquer.pdf         → dc_guia.md
2.guia_1P_tecnicas_algoritmicas.pdf    → tecnicas_alg_guia.md
```

Cuando un tema tiene múltiples páginas, el `index.md` las agrupa bajo un encabezado de tema — el LLM lee el índice, identifica qué página leer, y va directo a ella.

---

### 1. Páginas de teoría (`[tema]_teoria.md` o `_pt[n].md`)

**Propósito:** Extracción fiel y estructurada del contenido teórico. NO se simplifica ni parafrasea — el LLM extrae preservando definiciones, teoremas y rigor. La simplificación ocurre en runtime cuando el usuario pregunta.

**Frontmatter:**
```yaml
---
nombre: Divide & Conquer — Teoría
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
- `## Concepto y definición` — qué es, extraído fielmente de la clase
- `## Cuándo se aplica` — condiciones / señales para identificar el paradigma
- `## Propiedades y teoremas` — texto original con fórmulas
- `## Demostraciones` — extraídas fielmente (sin simplificar en ingest)
- `## Fórmulas clave` — recurrencias, Master Theorem, etc.
- `## Ver también` — links a páginas relacionadas del mismo tema

---

### 2. Páginas de clase práctica (`[tema]_practica.md` o `_practica_pt[n].md`)

**Propósito:** Ejercicios resueltos en clase por el profesor. Contenido fiel al PDF de la clase práctica. Más conciso que la guía — son los ejercicios que el profesor eligió mostrar, generalmente los más representativos.

**Frontmatter:**
```yaml
---
nombre: Divide & Conquer — Clase Práctica
parcial: 1P
tipo: practica
tema: divide_y_conquista
fuente: raw/clases/prac/1.prac_1P_divide_&_conquer.pdf
paginas_relacionadas:
  - "[[dc_teoria]]"
  - "[[dc_guia]]"
---
```

**Secciones:**

```markdown
## Patrones de este tema en parciales
> [[tipos_ejercicio/dc_recurrencias]] · [[tipos_ejercicio/dc_diseno]]
(se completa después de analizar parciales)

## Ejercicios de clase

### Ejercicio — [título breve]

**Enunciado**
[texto extraído fielmente]

**Explicación**
[LLM explica qué concepto activa y qué hay que tener claro para encararlo]

**Resolución paso a paso**
1. [paso] — *por qué: [justificación]*
2. [paso] — *por qué: [justificación]*

**Chuleta**
> 1. Identificar X → 2. Plantear Y → 3. Calcular Z

**¿Aparece en parciales?** 🔴 Sí → [[tipos_ejercicio/dc_recurrencias]] | ⚪ No
```

---

### 3. Páginas de guía (`[tema]_guia.md` o `_guia_pt[n].md`)

**Propósito:** Ejercicios de la guía práctica oficial. Fiel a todos los ejercicios del PDF. Estas páginas son las más largas — si la guía cubre múltiples temas, el LLM distribuye los ejercicios a la página del tema correspondiente (una guía puede tocar múltiples páginas wiki). Si aun así resulta muy larga, se parte en `_guia_pt1.md` y `_guia_pt2.md`.

**Workflow de dos fases — exclusivo de guías:**
A diferencia de las páginas de teoría (extracción pura) y práctica (el profesor ya trajo las resoluciones), las guías contienen ejercicios sin resolver que el LLM debe resolver y explicar. Esta tarea cognitiva es lo suficientemente exigente como para merecer su propia sesión dedicada, separada del parseo inicial.
- **Fase 1 — Ingest:** extraer enunciados, identificar paradigmas, cruzar con parciales. Las secciones `Resolución` y `Chuleta` quedan como `[PENDIENTE — sesión de resolución]`.
- **Fase 2 — Resolución** (comando `/resolver`): sesión dedicada por guía, contexto limpio, el LLM resuelve cada ejercicio con máxima atención. El usuario puede intervenir ejercicio a ejercicio.

**Nota sobre guías multi-tema:** `2.guia_1P_tecnicas_algoritmicas.pdf` probablemente cubre D&C + Backtracking + PD. En ese caso sus ejercicios se distribuyen a `dc_guia.md`, `backtracking_guia.md` y `pd_guia.md` respectivamente — exactamente el patrón de Karpathy donde una fuente toca múltiples páginas.

**Frontmatter:**
```yaml
---
nombre: Divide & Conquer — Guía de Ejercicios
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
## Índice de ejercicios
| # | Descripción breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Diseñar algoritmo D&C para ... | 🔴 Sí |
| Ej. 2 | Analizar complejidad de ... | ⚪ No |
| Ej. 3 | ... | ⚪ Pendiente |

## Ejercicios

### Ejercicio 1 — [título breve]

**Enunciado**
[texto extraído fielmente de la guía — Fase 1]

**Explicación**
[LLM explica qué pide el ejercicio, qué concepto activa,
qué hay que tener claro para encararlo — Fase 1]

**Resolución paso a paso**
[PENDIENTE — sesión de resolución]

**Chuleta**
[PENDIENTE — sesión de resolución]

**¿Aparece en parciales?** 🔴 Sí → [[tipos_ejercicio/dc_recurrencias]] | ⚪ No
```

**Nota de ingest (Fase 1):** Se completan Enunciado, Explicación y ¿Aparece en parciales?. Resolución y Chuleta quedan como `[PENDIENTE]` hasta la sesión de resolución (`/resolver`).
**Nota de resolución (Fase 2):** Si el LLM tiene incertidumbre en una resolución, marcarla con `⚠️ Verificar` e incluir una nota explicando qué parte genera duda. El usuario decide si la acepta o la corrige.

---

### 4. `wiki/tipos_ejercicio/[patron].md`

**Propósito:** Arma de examen. Nace del análisis de parciales pasados. Cross-referencia ejercicios de guías y apariciones en exámenes. Orientado a memorización y reconocimiento rápido.

**Frontmatter:**
```yaml
---
nombre: D&C — Resolver recurrencia con Master Theorem
parcial: 1P
tema: divide_y_conquista
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf  # ej. 2
  - raw/parciales/1P/1.parcial_2C_2025_resolucion(1).pdf  # ej. 1
---
```

**Secciones:**
- `## Cómo reconocer este patrón` — señales en el enunciado que identifican el tipo
- `## Template de resolución` — pasos exactos, formato machete
- `## Por qué funciona` — justificación mínima necesaria
- `## Apariciones en parciales` — links a `parciales_analizados/` con nota de variantes por aparición
- `## Ejercicios que ejemplifican esto` — links a ejercicios específicos en `_practica.md` y `_guia.md`

---

### 5. `wiki/parciales_analizados/[id].md`

**Propósito:** Cada parcial pasado extraído, analizado y anotado por el LLM. Es la fuente de verdad para `tipos_ejercicio/` y para las banderas en `_practica.md` y `_guia.md`.

**Frontmatter:**
```yaml
---
parcial: 1P
cuatrimestre: 1C
año: 2024
tipo_pdf: digital        # o: fotografiado
fuente: raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
transcripcion: null      # o: wiki/transcripciones/parcial_1P_1C_2025_raw.md (si fotografiado)
temas_evaluados:
  - divide_y_conquista
  - backtracking
  - programacion_dinamica
---
```

**Estructura por ejercicio:**

```markdown
## Ejercicio 1 — Backtracking

### Enunciado
[extraído del PDF — fiel]

### Resolución
[extraída del PDF — con nota si hay correcciones del profesor visibles]

### Explicación
[LLM: qué pide el ejercicio, qué concepto usa, por qué se resuelve así,
qué hay que tener claro para llegar ahí — en lenguaje simple]

### Análisis de la resolución
[LLM evalúa: ¿está bien o mal? Si hay correcciones del profesor en el documento,
las interpreta. Señala errores y explica por qué están mal]

### Chuleta
> 1. Identificar X  
> 2. Plantear Y  
> 3. Resolver Z
```

---

### 6. `wiki/transcripciones/[id]_raw.md`

**Solo para parciales fotografiados.** Transcripción fiel hecha por Claude vision antes de la síntesis. Permite verificar que la interpretación fue correcta.

**Frontmatter:**
```yaml
---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_1C_2025_resolucion(1).pdf
metodo: claude_vision
---
```

Contenido: texto transcripto lo más fiel posible al original, indicando cuando algo es ilegible.

---

### 7. `wiki/sintesis/[nombre].md`

**A demanda.** Páginas cross-tema generadas cuando el usuario hace una consulta que produce síntesis valiosa. Ejemplos: `comparacion_tecnicas_1P.md`, `guia_rapida_1P.md`, `patrones_frecuentes_parciales.md`.

---

## CLAUDE.md — Esquema completo

El `CLAUDE.md` vive en la raíz de la materia y es el documento central que hace al LLM un wiki maintainer disciplinado. Debe incluir:

### Secciones del CLAUDE.md:

**1. Contexto del proyecto**
- Materia, universidad, sistema de evaluación (1P/2P, 5-6 temas cada uno)
- Estrategia de estudio del usuario (teoría general → práctica → parciales)
- Objetivo: herramienta de consulta basada 100% en la base de conocimiento ingresada

**2. Estructura de directorios** (el árbol completo con descripción de cada carpeta)

**3. Tipos de páginas y sus templates** (referencia a cada tipo con su frontmatter y secciones)

**4. Convenciones**
- Idioma: español en todo el wiki
- Frontmatter obligatorio en todas las páginas
- Links internos con sintaxis Obsidian: `[[nombre_pagina]]`
- Citas a fuentes: path relativo desde raíz de materia
- Nomenclatura de archivos: snake_case, sin espacios
- **Fórmulas matemáticas:** preservar siempre en notación LaTeX. Inline: `$T(n) = 2T(n/2) + n$`. Bloque: `$$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$`. Nunca parafrasear ni convertir fórmulas a texto plano — Obsidian las renderiza con MathJax. Si `pdftotext` produce caracteres corruptos en una fórmula, reconstruirla desde el contexto o marcarla con `[FÓRMULA ILEGIBLE — revisar fuente]` para revisión posterior.

**5. Workflow de Ingest** (operación principal)
```
ANTES DE INICIAR CUALQUIER SESIÓN DE INGEST:
Leer log.md y verificar qué archivos ya fueron procesados.
El ingest es resumible: cada sesión continúa desde donde terminó la anterior.
Nunca reingestar un archivo que ya aparece en log.md.

TAMAÑO DE SESIÓN RECOMENDADO:
El ingest consume contexto de forma acumulativa. Para mantener calidad:
- PDFs cortos (parciales, transcripciones): hasta 6 por sesión
- PDFs medianos (clases teo/prac, ~100-200 págs Beamer): 3-4 por sesión
- PDFs largos (guías con muchos ejercicios): 2-3 por sesión
- PDFs fotografiados (visión): 2-3 por sesión
Regla general: si el contexto supera el 60% de capacidad, cerrar la sesión,
hacer commit, y continuar en una nueva sesión.

ORDEN OBLIGATORIO:
1. parciales/1P/ y parciales/2P/ — primero siempre
2. clases/teo/ — por número cronológico
3. clases/prac/ — por número cronológico
4. guias_practicas/ — por número cronológico
5. contenido_comunidad/ — al final

POR CADA DOCUMENTO:
a. Verificar si pdftotext extrae > 500 chars. Si no → usar Claude vision
b. Para parciales fotografiados: crear wiki/transcripciones/[id]_raw.md primero
c. Crear/actualizar las páginas relevantes del wiki
d. Actualizar index.md
e. Agregar entrada al log.md: ## [FECHA] ingest | [nombre_archivo]
```

**6. Workflow de Query** (operación de consulta)
```
a. Leer index.md para identificar páginas relevantes
b. Leer las páginas relevantes del wiki
c. Sintetizar respuesta con citas (formato: [fuente])
d. Si la respuesta es síntesis valiosa y reutilizable → sugerir guardar en sintesis/
e. Respuestas basadas SOLO en la base de conocimiento, salvo que el usuario
   solicite explícitamente búsqueda web
```

**7. Workflow de Lint** (chequeo periódico de salud)
```
- Páginas sin links entrantes (huérfanas)
- Banderas "⚪ Pendiente" en _practica.md y _guia.md que ya pueden completarse
- Temas mencionados sin página propia
- Contradicciones entre páginas
- Sugerir nuevas consultas y fuentes
```

**8. Workflow de actualización de banderas** (post-ingest de parciales — paso de reconciliación)
```
Este workflow usa los parciales_analizados/ ya completos como fuente de verdad.
No es descubrimiento: es cruzar lo ya conocido con las páginas de práctica y guía.

- Leer todos los wiki/parciales_analizados/ e identificar patrones recurrentes
- Crear páginas en tipos_ejercicio/ para cada patrón identificado
- Revisar cada ejercicio en _practica.md y _guia.md
- Actualizar bandera de "⚪ Pendiente" a "🔴 Sí → [[tipos_ejercicio/X]]" o "⚪ No"
- Actualizar sección "Patrones de este tema en parciales" en cada _practica.md
```

**9. Comandos disponibles**
Los comandos están implementados como slash commands nativos de Antigravity en `.agents/workflows/`. Cada archivo contiene el workflow completo como prompt — al invocar el comando, Antigravity lo carga automáticamente. Los workflows completos están documentados en la sección "Comandos disponibles" de este plan.

Comandos disponibles:
- `/ingestar <ruta>` — ingestar un PDF
- `/ingestar_batch <carpeta>` — ingestar todos los PDFs de una carpeta en orden
- `/resolver <ruta_pagina_guia>` — Fase 2 exclusiva de guías: resolver ejercicios PENDIENTES en sesión dedicada
- `/corregir <ruta_pagina> "<observación>"` — análisis y reporte de correcciones con aprobación explícita del usuario antes de ejecutar
- `/lint` — chequeo de salud del wiki
- `/estado` — resumen ejecutivo del wiki
- `/chuleta <tema>` — chuletas consolidadas de un tema
- `/parcial <1P|2P>` — vista orientada a examen de un parcial
- `/simular [tema]` — generar ejercicio de práctica
- `/sintesis <nombre>` — guardar respuesta actual en sintesis/
- `/fuente_original [ruta]` — acceder al PDF original

**10. Restricciones**
- Nunca modificar archivos en raw/
- Nunca responder con información que no esté en el wiki (salvo web search explícito)
- Siempre actualizar index.md y log.md después de cada operación de escritura
- El wiki está en español; los nombres técnicos de algoritmos pueden quedar en inglés si así aparecen en las clases

---

## index.md — Estructura

El índice agrupa todas las páginas de un mismo tema bajo un encabezado, listando cada página con una línea descriptiva. Esto permite al LLM identificar exactamente qué página leer sin consumir contenido innecesario.

```markdown
# Índice — Algoritmos y Estructuras de Datos III

Última actualización: [fecha]

## Temas — 1P

### Divide & Conquer
- [[dc_teoria]] — Paradigma D&C, recurrencias, Master Theorem · fuente: 1.teo_1P_...
- [[dc_practica]] — Ejercicios resueltos en clase · fuente: 1.prac_1P_...
- [[dc_guia]] — Guía de ejercicios (8 ejercicios) · fuente: 1.guia_1P_...

### Programación Dinámica
- [[pd_teoria]] — Teoría PD (incluye demos mochila y monedas) · fuente: 3.teo_1P_...
- [[pd_practica_top_down_pt1]] — Top-down parte 1 · fuente: 3.prac_1P_..._parte1
- [[pd_practica_top_down_pt2]] — Top-down parte 2 · fuente: 3.prac_1P_..._parte2
- [[pd_practica_bottom_up]] — Bottom-up · fuente: 4.prac_1P_...
- [[pd_guia]] — Guía de ejercicios · fuente: 2.guia_1P_tecnicas_algoritmicas (parcial)

### [otros temas 1P...]

## Temas — 2P

### Caminos Mínimos
- [[caminos_minimos_teoria_pt1]] — Dijkstra, propiedades · fuente: 9.teo_2P_... (196 págs)
- [[caminos_minimos_teoria_pt2]] — Bellman-Ford, Floyd · fuente: 10.teo_2P_...
- [[caminos_minimos_practica]] — Ejercicios uno-a-todos · fuente: 10.prac_2P_...
- [[caminos_minimos_guia]] — Guía recorrido mínimo · fuente: 5.guia_2P_...

### [otros temas 2P...]

## Tipos de ejercicio
- [[tipos_ejercicio/dc_recurrencias]] — Resolver recurrencias con Master Theorem
- [[tipos_ejercicio/backtracking_subconjuntos]] — Generar subconjuntos con backtracking
- ...

## Parciales analizados
- [[parciales_analizados/1P_1C_2024]] — D&C, Backtracking, PD · digital · 15 págs
- [[parciales_analizados/1P_1C_2025]] — [temas] · fotografiado · 9 págs
- ...

## Síntesis
- (vacío al inicio, se completa a demanda)
```

---

## log.md — Estructura

```markdown
# Log — Algoritmos y Estructuras de Datos III

## [2026-04-07] ingest | 1.parcial_1C_2024_resolucion(1).pdf
Páginas creadas: parciales_analizados/1P_1C_2024.md
Temas identificados: divide_y_conquista, backtracking, programacion_dinamica

## [2026-04-07] ingest | 1.teo_1P_divide_&_conquer.pdf
Páginas creadas: temas/dc_teoria.md
```

Parseable con: `grep "^## \[" log.md | tail -10`

---

## Comandos disponibles

El usuario interactúa con la wiki mediante slash commands nativos de Antigravity, implementados como archivos `.md` en `.agents/workflows/`. Esta sección define el workflow completo de cada uno — el contenido de cada archivo del comando debe ser exactamente este workflow redactado como prompt.

### Operaciones core

**`/ingestar <ruta>`**
Procesa un único PDF. Flujo:
1. Detectar tipo (pdftotext > 500 chars → digital, si no → Claude vision)
2. Si es parcial fotografiado: crear `wiki/transcripciones/[id]_raw.md` primero
3. Crear/actualizar las páginas wiki correspondientes (según tipo de documento)
4. Actualizar `index.md` y `log.md`

**`/ingestar_batch <carpeta>`**
Ingesta todos los PDFs de una carpeta en orden numérico. Ejecuta `/ingestar` internamente por cada archivo. Diseñado para el setup inicial. El orden debe respetar el definido en D5: parciales → teo → prac → guías → comunidad. Si se llama con una subcarpeta específica, ingesta solo esa.

**`/lint`**
Chequeo periódico de salud del wiki. Revisa:
- Páginas sin links entrantes (huérfanas)
- Banderas `⚪ Pendiente` en `_practica.md` y `_guia.md` que ya pueden resolverse
- Temas mencionados en páginas sin página propia
- Contradicciones entre páginas
- Cross-references faltantes
Produce un reporte y sugiere acciones. No modifica nada automáticamente — el usuario decide qué resolver.

---

### Navegación y estado

**`/estado`**
Resumen ejecutivo del wiki en una pantalla:
- Total de páginas por tipo (teoría, práctica, guía, tipos_ejercicio, parciales, síntesis)
- PDFs en `raw/` vs páginas generadas
- Cantidad de banderas `⚪ Pendiente` pendientes
- Fecha y archivo del último ingest (desde `log.md`)

---

### Estudio y examen

**`/chuleta <tema>`**
Agrega en una sola respuesta todas las chuletas del tema indicado: las de `_practica.md`, `_guia.md` y la página de `tipos_ejercicio/` correspondiente. Orientado a repaso rápido antes del examen. Ejemplo: `/chuleta divide_y_conquista`.

**`/parcial <1P|2P>`**
Vista consolidada orientada a examen para el parcial indicado:
- Temas evaluados y su frecuencia en parciales pasados
- Tipos de ejercicio recurrentes (links a `tipos_ejercicio/`)
- Patrones más frecuentes por tema
- Links a todos los `parciales_analizados/` de ese parcial

**`/simular [tema]`**
Genera un ejercicio de práctica inédito basado en los patrones de `parciales_analizados/`. Sin argumento: elige el tema aleatoriamente entre los del parcial más próximo. Con argumento: `/simular backtracking`. El LLM genera el enunciado, lo resuelve paso a paso y lo anota como ejercicio simulado (no se guarda en wiki salvo que el usuario lo pida).

---

### Corrección y mantenimiento

**`/corregir <ruta_pagina> "<observación>"`**
Análisis exhaustivo y corrección de cualquier página wiki a partir de una observación del usuario. Diseñado para usarse una vez que la base de conocimiento está consolidada y el usuario detecta un error, imprecisión o contenido desactualizado navegando el wiki en Obsidian o durante el estudio.

La `<observación>` es el argumento central del comando — puede ser tan específica o general como el usuario quiera:
- `"el paso 3 de la resolución del ejercicio 2 está mal, no se puede aplicar greedy acá"`
- `"la definición de árbol AVL es incompleta, falta la condición de balance"`
- `"la chuleta no refleja el caso base correctamente"`

Flujo:
1. Leer la página wiki indicada completa
2. Leer las páginas relacionadas (`paginas_relacionadas` del frontmatter) para tener contexto
3. Si la corrección involucra una resolución: leer también la fuente original (`fuente:` del frontmatter) para contrastar
4. Analizar la observación del usuario en profundidad — no hacer un fix superficial
5. **Reportar al usuario** (sin modificar nada aún):
   - Qué está incorrecto o inconsistente en la página
   - Si el problema se replica en otras páginas relacionadas
   - Exactamente cómo se piensa corregir cada punto
6. **Esperar aprobación explícita del usuario** — no ejecutar ninguna modificación hasta recibirla
7. Una vez aprobado: aplicar todas las correcciones descriptas en el reporte
8. Agregar entrada al `log.md`: `## [FECHA] corregir | [ruta_pagina] | [resumen de cambios]`

---

### Resolución de guías

**`/resolver <ruta_pagina_guia>`**
Fase 2 del workflow de guías. Toma una página `_guia.md` ya parseada (con secciones `[PENDIENTE]`) y la resuelve completamente en una sesión dedicada. Flujo:
1. Leer la página wiki indicada (no el PDF original)
2. Para cada ejercicio con `[PENDIENTE]`: resolver paso a paso, escribir justificaciones y chuleta
3. Si hay incertidumbre en una resolución: escribir la solución de todas formas y marcar `⚠️ Verificar — [nota explicando la duda]`
4. Actualizar `log.md` con entrada de tipo `resolver`

Aplica **exclusivamente a guías** — teoría y práctica no lo necesitan porque o son extracción pura o las resoluciones ya vienen en el PDF.

---

### Síntesis y fuentes

**`/sintesis <nombre>`**
Guarda la respuesta actual de la conversación en `wiki/sintesis/<nombre>.md` con frontmatter apropiado y actualiza `index.md`. El LLM sugiere usar este comando cuando genera una respuesta cross-tema particularmente reutilizable, pero el usuario siempre decide.

**`/fuente_original [ruta]`**
Accede al PDF original. Sin argumento: infiere la fuente del contexto de la conversación usando el campo `fuente:` de la última página wiki discutida. Con argumento: va directo al PDF indicado. Útil cuando la página wiki no capturó un detalle específico del original. Si se usa recurrentemente para el mismo documento, es señal de que esa página wiki necesita ser mejorada.

---

## Pasos de implementación para la sesión constructora

El agente constructor debe ejecutar los siguientes pasos en orden:

### Paso 1 — Setup del repositorio
- Inicializar git en `/Users/neonunez/Desktop/llm-academic-wiki/` (un único repo para todas las materias)
- Crear `.gitignore` (excluir `.DS_Store`, archivos temporales). **Los PDFs en `raw/` se commitean intencionalmente** — el repo privado en GitHub sirve como backup completo incluyendo las fuentes originales. **`.agents/workflows/` se commitea también** — los slash commands son parte del proyecto y deben versionarse.
- Crear `README.md` con descripción del proyecto

### Paso 2 — Reorganizar estructura de directorios
- Crear la carpeta `raw/` dentro de `Algoritmos_Estructuras_Datos_(III)/`
- Mover los PDFs actuales a sus rutas correspondientes dentro de `raw/`:
  - `Clases/teo/` → `raw/clases/teo/`
  - `Clases/prac/` → `raw/clases/prac/`
  - `Guias_practicas/` → `raw/guias_practicas/`
  - `Parciales/1P/` → `raw/parciales/1P/`
  - `Parciales/2P/` → `raw/parciales/2P/`
  - `Contenido_comunidad/` → `raw/contenido_comunidad/`
- Crear las carpetas del wiki: `wiki/temas/`, `wiki/tipos_ejercicio/`, `wiki/parciales_analizados/`, `wiki/transcripciones/`, `wiki/sintesis/`

### Paso 3 — Crear archivos base

**CLAUDE.md raíz** en `/Users/neonunez/Desktop/llm-academic-wiki/CLAUDE.md`:
- Descripción del proyecto: `llm-academic-wiki` — sistema de wikis académicas personales basado en el patrón LLM Wiki de Andrej Karpathy, adaptado para estudio universitario
- Estructura del repo: una carpeta por materia, cada una con su propio `CLAUDE.md`, `index.md`, `log.md`, `raw/` y `wiki/` — completamente independientes entre sí
- Instrucción de uso: siempre inicializar Antigravity desde la carpeta de la materia a estudiar, nunca desde la raíz
- Lista de materias activas con ruta y estado: `Algoritmos_Estructuras_Datos_(III)/` — piloto, en construcción
- Referencia a los slash commands disponibles en `.agents/workflows/` y descripción breve de cada uno
- **Procedimiento para agregar una nueva materia:** el sistema está diseñado para escalar. Para agregar una materia: (1) crear su carpeta con la estructura estándar de `raw/` y `wiki/`, (2) inicializar Antigravity desde esa carpeta, (3) proveer el contexto específico de la materia (nombre, sistema de evaluación, temas, tipo de material, particularidades), (4) el LLM genera el `CLAUDE.md` de la materia adaptado a ese contexto, (5) correr el pipeline de ingest, (6) actualizar este archivo agregando la materia a la lista de activas. Ver sección "Expansión a nuevas materias" del plan para el detalle completo.

**Slash commands** en `.agents/workflows/`: crear un archivo `.md` por cada comando con su workflow completo como prompt. Los workflows están definidos en la sección "Comandos disponibles" de este plan. Cada archivo es autocontenido — Antigravity lo carga completo al invocar el comando:
- `ingestar.md` — workflow de ingest de un PDF
- `ingestar_batch.md` — workflow de ingest batch por carpeta
- `resolver.md` — workflow Fase 2 de guías
- `corregir.md` — workflow de corrección con aprobación previa
- `lint.md` — workflow de chequeo de salud
- `estado.md` — workflow de resumen ejecutivo
- `chuleta.md` — workflow de chuletas por tema
- `parcial.md` — workflow de vista orientada a examen
- `simular.md` — workflow de ejercicio simulado
- `sintesis.md` — workflow de guardado de síntesis
- `fuente_original.md` — workflow de acceso a PDF original

**CLAUDE.md de la materia** en `Algoritmos_Estructuras_Datos_(III)/CLAUDE.md` con el esquema completo definido en este plan. La sección de comandos (sección 9) referencia los archivos en `.agents/workflows/` en lugar de repetir los workflows.

**Archivos base del wiki:**
- `index.md` con estructura base (vacía, lista para llenarse en ingest)
- `log.md` con cabecera

### Paso 4 — Ingest de parciales (PRIMERO)
Para cada parcial en `raw/parciales/1P/` y `raw/parciales/2P/`:
1. Detectar si es digital (pdftotext > 500 chars) o fotografiado
2. Si fotografiado: crear `wiki/transcripciones/[id]_raw.md` con Claude vision
3. Crear `wiki/parciales_analizados/[id].md` con estructura completa (enunciado + resolución + explicación LLM + análisis + chuleta por ejercicio)
4. Actualizar `index.md` y `log.md`

### Paso 5 — Ingest de clases teóricas
Para cada archivo en `raw/clases/teo/`, en orden numérico:
1. Extraer texto con pdftotext
2. Crear **una página wiki por PDF**: `wiki/temas/[tema]_teoria.md` o `[tema]_teoria_pt[n].md` si el tema ya tiene página de teoría previa
3. Si el archivo es una demo (ej: `3.teo_1P_demo_mochila.pdf`): integrar **siempre** en la página de teoría del tema correspondiente (mismo número de tema). Las demos no justifican página propia — su contenido es conciso y pertenece conceptualmente a la teoría del tema.
4. Actualizar `index.md` (agrupando páginas del mismo tema bajo un encabezado) y `log.md`

### Paso 6 — Ingest de clases prácticas
Para cada archivo en `raw/clases/prac/`, en orden numérico:
1. Extraer texto con pdftotext
2. Crear **una página wiki por PDF**: `wiki/temas/[tema]_practica.md` o `[tema]_practica_pt[n].md` si ya existe clase práctica para ese tema
3. Actualizar `index.md` y `log.md`

### Paso 7 — Ingest de guías prácticas (Fase 1: parseo únicamente)

**Este paso es solo Fase 1.** Las resoluciones se generan en una sesión dedicada posterior con `/resolver`. Una guía = una sesión completa.

Para cada archivo en `raw/guias_practicas/`, en orden numérico:
1. Extraer texto con pdftotext
2. Identificar qué temas cubre la guía (puede ser uno o varios)
3. Si cubre **un solo tema**: crear `wiki/temas/[tema]_guia.md`
4. Si cubre **múltiples temas**: distribuir los ejercicios a la página de guía del tema correspondiente (`[tema_a]_guia.md`, `[tema_b]_guia.md`, etc.)
5. Por cada ejercicio: extraer enunciado fielmente, escribir Explicación (paradigma, qué hay que tener claro), cruzar con parciales para setear ¿Aparece en parciales?. Dejar `Resolución` y `Chuleta` como `[PENDIENTE — sesión de resolución]`
6. Incluir al inicio de cada página un `## Índice de ejercicios` con tabla resumen (descripción breve + bandera ¿Parcial?)
7. Actualizar `index.md` y `log.md`

### Paso 8 — Ingest de contenido comunidad
Para cada archivo en `raw/contenido_comunidad/`:
1. Extraer texto, identificar qué temas cubre
2. Integrar información relevante en las páginas de temas correspondientes (con nota de fuente)
3. Actualizar `index.md` y `log.md`

### Paso 9 — Generar tipos_ejercicio y actualizar banderas

**Este es un paso de reconciliación, no de descubrimiento.** Los `parciales_analizados/` ya existen y están completos desde el Paso 4 — aquí se cruza ese conocimiento acumulado con las páginas `_practica.md` y `_guia.md` generadas en los Pasos 5–8. El agente debe tratar los `parciales_analizados/` como la fuente de verdad para determinar qué patrones son recurrentes y cuáles ejercicios aparecen en exámenes.

1. Leer todos los `wiki/parciales_analizados/` (completados en Paso 4) e identificar patrones recurrentes entre parciales
2. Crear `wiki/tipos_ejercicio/[patron].md` por cada patrón identificado, con los links a las apariciones en parciales ya conocidos
3. Actualizar las banderas `⚪ Pendiente` en todas las páginas `_practica.md` y `_guia.md`:
   - Si el tipo de ejercicio aparece en algún parcial → `🔴 Sí → [[tipos_ejercicio/X]]`
   - Si no aparece → `⚪ No`
4. Actualizar la sección `## Patrones de este tema en parciales` al inicio de cada `_practica.md` con links a las páginas `tipos_ejercicio/` correspondientes

### Paso 10 — Setup de Obsidian
- Crear vault de Obsidian apuntando a la raíz `/Users/neonunez/Desktop/llm-academic-wiki/`
- El vault cubre todas las materias del repo. El Graph View mostrará conexiones cross-materia, lo cual es una ventaja. Cada materia queda aislada lógicamente por su propio `CLAUDE.md` e `index.md`.
- Configurar "Attachment folder path" → `raw/assets/` dentro de la materia activa (para futuros clips web — separado de los PDFs fuente para no mezclar tipos de archivo)
- **Habilitar MathJax (LaTeX):** Settings → Editor → activar "Render math in reading view". Verificar que `$...$` y `$$...$$` rendericen correctamente — es imprescindible para las fórmulas del wiki.
- Habilitar plugin Dataview
- Configurar Graph View

### Paso 11 — Commit inicial
- `git add` de toda la estructura
- Commit con mensaje descriptivo

---

## Expansión a nuevas materias

El sistema está diseñado para escalar. Agregar una nueva materia es repetir el mismo pipeline sobre una carpeta nueva — los comandos, las convenciones y Obsidian no cambian.

### Qué es genérico (no cambia entre materias)
- **`.agents/workflows/`** — los 11 comandos operan sobre el working directory, son agnósticos a la materia
- **Convenciones de wiki** — mismos tipos de página, mismo frontmatter, mismos workflows
- **Obsidian** — el vault ya apunta a la raíz; la nueva materia aparece automáticamente en el Graph View

### Qué es específico por materia
Solo el `CLAUDE.md` de la materia. Cada materia puede tener:
- Sistema de evaluación distinto (parciales, TPs, coloquios, examen final, etc.)
- Distinta cantidad de temas por parcial
- Distinta organización del material (puede no tener guías, o tener TPs en vez de guías, etc.)
- Tipo de PDFs distintos (todo digital, todo fotografiado, mix, etc.)
- Idioma del material (inglés, español, mix)

### Procedimiento para agregar una nueva materia

**Paso A — Crear estructura de carpetas**
```
llm-academic-wiki/
└── [Nombre_Materia]/
    ├── raw/
    │   ├── clases/teo/
    │   ├── clases/prac/
    │   ├── guias_practicas/     ← omitir si la materia no tiene guías
    │   ├── parciales/
    │   │   ├── 1P/
    │   │   └── 2P/
    │   ├── contenido_comunidad/
    │   └── assets/
    └── wiki/
        ├── temas/
        ├── tipos_ejercicio/
        ├── parciales_analizados/
        ├── transcripciones/
        └── sintesis/
```
Adaptar las subcarpetas de `raw/` según cómo esté organizado el material de esa materia.

**Paso B — Soltar los PDFs en `raw/`**
Organizarlos en las subcarpetas correspondientes antes de inicializar.

**Paso C — Inicializar Antigravity desde la carpeta de la materia**
```
cd llm-academic-wiki/[Nombre_Materia]/
claude
```
Antigravity carga automáticamente el root `CLAUDE.md` (convenciones generales) y detecta que no hay `CLAUDE.md` de materia todavía.

**Paso D — Brindar el contexto específico de la materia**
No es un comando formal — es la primera instrucción en lenguaje natural de la sesión. Debe incluir:

| Campo | Descripción | Ejemplo |
|-------|-------------|---------|
| Nombre oficial | Nombre completo de la materia | "Análisis Matemático II" |
| Sistema de evaluación | Cómo se aprueba | "2 parciales + recuperatorio, sin final" |
| Organización temática | Temas por parcial o unidad | "1P: límites, derivadas, integrales. 2P: series, EDOs" |
| Tipo de material disponible | Qué hay en `raw/` | "Clases teóricas en PDF, guías de ejercicios, sin parciales pasados" |
| Particularidades del material | Beamer, fotografiado, idioma, etc. | "Todo digital LaTeX, algunas clases en inglés" |
| Estrategia de estudio | Cómo el usuario estudia esta materia | "Priorizo teoría antes que práctica" |

Con esta información el LLM genera el `CLAUDE.md`, `index.md` y `log.md` de la materia, adaptados a su contexto específico.

**Paso E — Correr el pipeline de ingest**
Exactamente igual que con la materia piloto: `/ingestar_batch` respetando el orden definido en el `CLAUDE.md` recién generado.

**Paso F — Actualizar el root `CLAUDE.md`**
Agregar la nueva materia a la lista de materias activas. Un cambio de una línea.

---

## Herramientas y dependencias

| Herramienta | Propósito | Estado |
|-------------|-----------|--------|
| `pdftotext` (poppler) | Extraer texto de PDFs LaTeX | ✅ Instalado en `/opt/homebrew/bin/` |
| Antigravity | LLM agent + vision para PDFs imagen | ✅ Activo |
| Obsidian | IDE para navegar el wiki | ✅ Instalado |
| Git | Control de versiones del wiki | Pendiente init |
| GitHub (repo privado) | Backup remoto | Pendiente crear |

---

## Observación crítica sobre parsing de PDFs Beamer

**Los PDFs de clases (teo y prac) están hechos con LaTeX Beamer. Esto tiene una implicación fundamental para el parsing que el agente constructor debe entender antes de ingestar cualquier archivo.**

Beamer genera presentaciones donde cada "build" incremental de una slide ocupa una página PDF separada. Es decir, un ejercicio que se desarrolla en 5 pasos genera 5 páginas PDF — una por cada paso revelado. Por eso `1.prac_1P_divide_&_conquer.pdf` tiene 209 páginas pero solo 13.527 palabras extraíbles: la mayoría del contenido se repite entre páginas consecutivas.

**Consecuencia directa para el parsing:**
- **No tratar cada página PDF como una unidad de contenido distinta.** Hacerlo generaría contenido duplicado masivo en el wiki.
- **El contenido real son los ejercicios, no las páginas.** Un ejercicio de 5 pasos en Beamer = 1 ejercicio en el wiki, no 5.
- Al extraer con `pdftotext`, el texto resultante ya colapsa las páginas en texto lineal, pero el LLM debe reconocer la repetición y quedarse con la versión final/completa de cada elemento.
- **Señal para identificar builds de Beamer:** bloques de texto casi idénticos que se repiten con pequeñas adiciones al final. El LLM debe consolidarlos en uno solo.

**Datos de referencia verificados:**

| PDF | Páginas | Palabras reales | Ejercicios estimados | Palabras por ejercicio |
|-----|---------|-----------------|---------------------|------------------------|
| `1.prac_1P_divide_&_conquer.pdf` | 209 | 13.527 | ~10-15 | ~900-1.350 |
| `9.prac_2P_arbol_generador_minimo.pdf` | 162 | 10.996 | ~10-15 | ~730-1.100 |
| `9.teo_2P_caminos_minimos_en_grafos1.pdf` | 196 | 17.862 | ~8-10 conceptos | ~1.800-2.200 |

La página wiki resultante de estos PDFs queda en **5.000-8.000 palabras** — manejable para retrieval. Si el agente no considera el fenómeno Beamer y trata cada página como contenido único, generaría páginas wiki de 50.000+ palabras con contenido duplicado, inutilizando el retrieval.

---

## Notas importantes para el agente constructor

1. **El PATH de poppler** es `/opt/homebrew/bin/` — usar siempre path absoluto o exportar en los comandos bash: `export PATH="/opt/homebrew/bin:$PATH"`

2. **Detección de PDF fotografiado:** correr `pdftotext [archivo] -` y contar caracteres. Si el resultado tiene < 500 chars para un documento de más de 3 páginas, el PDF es imagen → usar Claude vision

3. **Parciales con múltiples resoluciones** del mismo examen (ej: `resolucion(1)` y `resolucion(2)`): crear una sola página `parciales_analizados/[id].md` e incluir ambas resoluciones, anotando discrepancias entre ellas y cuál es correcta según el análisis del LLM

4. **Archivos con mismo número de tema** (ej: `3.teo_1P_demo_mochila.pdf` y `3.teo_1P_programacion_dinamica.pdf`): pertenecen al mismo tema, se integran en la misma página de teoría

5. **Archivo `6.prac_1P_repaso_para_primer_parcial.pdf` (74 páginas) y `14.prac_2P_repaso_para_segundo_parcial.pdf`:** son materiales de repaso que pueden generar páginas en `sintesis/` además de enriquecer los temas individuales

6. **La guía `3.guia_1P_teoria_algoritmica_de_grafos.pdf`** aparece numerada como 1P pero cubre contenido de grafos (2P): verificar su contenido durante el ingest y asignar `parcial: ambos` si corresponde

7. **Formato de IDs para parciales_analizados:** `[numero_parcial]P_[cuatrimestre]C_[año]` — ej: `1P_1C_2024`, `2P_2C_2025`
