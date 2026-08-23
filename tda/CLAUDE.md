# Algoritmos y Estructuras de Datos III — Wiki

## 1. Contexto del proyecto

**Materia:** Tecnicas de Diseno de Algoritmos (nombre oficial: Algoritmos y Estructuras de Datos III)
**Universidad:** UBA — Ciencias de la Computacion
**Sistema de evaluacion:** dos parciales (1P y 2P), cada uno cubriendo 5-6 temas
**Estrategia de estudio:** teoria en rasgos generales → practica de guias (priorizando ejercicios que aparecen en parciales) → practica intensiva con parciales pasados cerca del examen
**Objetivo:** herramienta de consulta basada 100% en la base de conocimiento ingresada. El LLM escribe y mantiene la wiki; el usuario la consulta y navega en Obsidian.

**Temas por parcial:** definidos en **[[programa]]** (`programa.md`) — unica fuente de verdad.

> ⚠️ **La catedra reorganizo el reparto de temas por parcial en 2C-2026.** Los contenidos
> son los mismos; cambio en que parcial entra cada uno. **Nunca hardcodear el mapeo
> tema→parcial en este archivo ni en los comandos: leer siempre `programa.md`.**

Resumen vigente (2C 2026) — **ambos listados son explicitos de la catedra**, transcriptos en `programa.md`:

| Parcial | Temas |
|---------|-------|
| 1P | Teoria de Grafos, Arboles, Algoritmos sobre grafos (recorridos BFS/DFS), Divide & Conquer, Backtracking |
| 2P | Programacion Dinamica (Top-Down, Bottom-Up y **Reconstruccion**), Greedy, Camino minimo (Dijkstra/Bellman-Ford/Floyd y Dantzig/DAGs), Flujo maximo, + AGM ⚠️ |
| ambos | Complejidad computacional, Definiciones y Demostraciones (no figuran como bloque propio en ningun listado; son transversales) |

⚠️ **AGM no figura en el listado oficial de ningun parcial.** Decision del usuario (2026-08-22):
se queda en el 2P. **No moverlo sin confirmacion explicita** — ver la nota en `programa.md`.

### Dos significados de `1P`/`2P` — no confundirlos

| Dato | Significado | ¿Se actualiza con el programa? |
|------|-------------|-------------------------------|
| `parcial:` en `wiki/temas/`, `wiki/tipos_ejercicio/` | Para que parcial hay que **estudiarlo** | **Si** — derivado de `programa.md`, lleva `programa: <vigencia>` al lado |
| `parcial:` en `wiki/parciales_analizados/`, `wiki/transcripciones/` | Este examen **fue** un 1P/2P de tal cuatrimestre | **No** — hecho historico |
| `apariciones_en_parciales:` en `tipos_ejercicio/` | Este patron **aparecio** en estos examenes | **No** — hecho historico |
| Rotulos `1P`/`2P` en nombres de `raw/` | Orden y rotulo **originales del dictado** | **No** — `raw/` es inmutable |

Consecuencias operativas:

- Las banderas `🔴 Si` siguen siendo validas: significan "este tipo de ejercicio lo toman".
  Lo que cambio es *en que parcial*. Cuando el rotulo historico difiere del parcial vigente,
  la pagina lleva un aviso de reubicacion.
- Los parciales pasados **no son simulacros validos** del parcial actual. Sirven como banco
  de ejercicios filtrando **por tema**, no por el rotulo del examen.
- `/parcial <1P|2P>` cruza por tema segun `programa.md`, no por el rotulo de los examenes.

---

## 2. Estructura de directorios

```
tda/
├── CLAUDE.md                      ← este archivo
├── programa.md                    ← temas por parcial del cuatrimestre vigente (fuente de verdad)
├── index.md                       ← catalogo completo del wiki
├── log.md                         ← registro append-only de operaciones
│
├── raw/                           ← PDFs originales, INMUTABLES
│   ├── cursada_2C_2026/           ← ★ CURSADA VIGENTE — fuente de autoridad
│   │   ├── teo/
│   │   ├── prac/
│   │   └── guias/
│   ├── clases/                    ← cuatrimestres pasados
│   │   ├── teo/                   ← 15 PDFs — LaTeX Beamer
│   │   └── prac/                  ← 20 PDFs — LaTeX Beamer
│   ├── guias_practicas/           ← 7 PDFs — LaTeX (cuatrimestres pasados)
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

### Procedencia y autoridad del material

`raw/` contiene material de **dos procedencias** con **autoridad distinta**:

| Procedencia | Carpetas | Autoridad |
|---|---|---|
| **Cursada vigente** | `raw/cursada_2C_2026/` | ★ **Manda.** Es lo que se dicta y se evalua ahora |
| Cuatrimestres pasados | `raw/clases/`, `raw/guias_practicas/` | Valido — mismos contenidos — pero **cede** ante el vigente |
| Parciales | `raw/parciales/` | Base de **que es importante** (ver abajo) |

Ante conflicto de **notacion, alcance, orden o enfoque de demostracion**, gana el material de la
cursada vigente. La cursada vigente se declara en `programa.md` (seccion "Cursada vigente").

#### Estado de verificacion

Cada pagina de `wiki/temas/` declara su procedencia en el frontmatter:

```yaml
fuentes:
  vigente:   [raw/cursada_2C_2026/teo/...]   # material de la cursada actual
  historico: [raw/clases/teo/...]            # cuatrimestres pasados
estado_verificacion: verificado_2C_2026 | pendiente_verificacion | solo_historico
```

| Estado | Significa | Badge en la pagina |
|---|---|---|
| `verificado_2C_2026` | Todo el contenido de la pagina fue contrastado | `> ✅ Verificado contra la cursada 2C-2026 · fuente: <ruta>` |
| `verificado_parcial_2C_2026` | Parte contrastada, parte no. Los bloques sin contrastar llevan 📎 | `> 🟡 Verificado parcialmente contra la cursada 2C-2026 · fuente: <ruta>` |
| `pendiente_verificacion` | Solo material de cuatrimestres pasados, sin contrastar | `> ⚠️ Sin verificar contra la cursada actual. ...` |
| `solo_historico` | Contenido que ya no se dicta. Se conserva, no se estudia | `> 📦 Contenido historico — ya no se dicta.` |

El badge va **inmediatamente despues del frontmatter**, antes del `# Titulo`. Debe coincidir
siempre con el `estado_verificacion` (`/lint` lo chequea).

Un merge produce paginas **mixtas**, asi que la verificacion se marca en dos niveles — igual que
las divergencias. Los bloques que el material vigente **no cubre** llevan su propia marca inline:

```markdown
> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el
> material vigente ingestado hasta ahora no lo cubre.
```

Cuando una ingesta posterior cubra un bloque 📎, se le saca la marca. Sin 📎 restantes, la pagina
pasa de `verificado_parcial_<vigencia>` a `verificado_<vigencia>`.

**No confundir 📎 con `solo_historico`.** 📎 = "la catedra todavia no lo dio o no lo ingestamos".
`solo_historico` = "el material vigente reemplaza integralmente ese alcance y no lo incluye", que
requiere evidencia fuerte y casi nunca se cumple desde una clase suelta.

Es esperable que durante buena parte del cuatrimestre la mayoria de las paginas esten en
`pendiente_verificacion`. Es informacion honesta, no una falla.

#### Marcado de divergencias

Cuando el material de la cursada vigente **difiere** del historico, no se pisa y se olvida: se
deja el contraste visible, porque el material viejo es el que tiene los ejercicios resueltos y
hace falta el puente para leerlos.

```markdown
> 🔄 **Cambio respecto de cuatrimestres anteriores**
> **Ahora (2C-2026):** [lo que dice el material actual]
> **Antes:** [lo que decia el material viejo]
> **Tipo:** notacion | alcance | enfoque de demostracion | contradiccion
> Fuente: raw/cursada_2C_2026/teo/...
```

#### Lo que NO cambia: la base de que es importante

**Los parciales historicos siguen siendo la base** para decidir que ejercicios y temas vale la
pena estudiar. Las banderas `🔴 Si → [[tipos_ejercicio/X]]` / `⚪ No` se calculan contra
`parciales_analizados/` y `tipos_ejercicio/` exactamente como siempre.

Los contenidos son los mismos entre cuatrimestres — solo cambio el reparto por parcial. Por eso
lo que tomaron historicamente sigue siendo indicador valido de importancia.
**No existe un sistema de señal paralelo:** los ⋆ de las guias se extraen como contenido, nada mas.

Los ejercicios **nuevos** que traigan las guias de la cursada vigente reciben su bandera cruzando
contra los **patrones** de `tipos_ejercicio/`, no contra enunciados exactos: un ejercicio nuevo de
recurrencias es `🔴 Si → [[tipos_ejercicio/dc_teorema_maestro]]` aunque ese enunciado puntual nunca
se haya tomado.

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
parcial: 1P          # derivado de programa.md
programa: 2C_2026    # version del programa que refleja 'parcial'
tipo: teoria
tema: divide_y_conquista
fuentes:
  vigente:
    - raw/cursada_2C_2026/teo/...     # vacio hasta que se ingeste la cursada
  historico:
    - raw/clases/teo/1.teo_1P_divide_&_conquer.pdf
estado_verificacion: pendiente_verificacion
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
parcial: 1P          # derivado de programa.md
programa: 2C_2026
tipo: practica
tema: divide_y_conquista
fuentes:
  vigente: []
  historico:
    - raw/clases/prac/1.prac_1P_divide_&_conquer.pdf
estado_verificacion: pendiente_verificacion
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
parcial: 1P          # derivado de programa.md
programa: 2C_2026
tipo: guia
tema: divide_y_conquista
fuentes:
  vigente: []
  historico:
    - raw/guias_practicas/1.guia_1P_divide_&_conquer.pdf
estado_verificacion: pendiente_verificacion
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
parcial: 1P          # derivado de programa.md (para que parcial estudiarlo)
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

DOS MODOS SEGUN LA PROCEDENCIA:

- Ruta bajo `raw/cursada_*/`  → modo RECONCILIACION (contrastar contra la pagina canonica
  existente, mostrar diff, pedir aprobacion, mergear). Ver /ingestar.
- Cualquier otra ruta         → modo CREAR (comportamiento clasico).

ORDEN OBLIGATORIO — material historico (ya completado):
1. parciales/1P/ y parciales/2P/ — primero siempre
2. clases/teo/ — por numero cronologico
3. clases/prac/ — por numero cronologico
4. guias_practicas/ — por numero cronologico
5. contenido_comunidad/ — al final

ORDEN OBLIGATORIO — cursada vigente (raw/cursada_2C_2026/):
0. Cualquier material que revele QUE SE EVALUA (parciales que reparta la catedra,
   enunciados modelo, listas de ejercicios obligatorios) — antes que todo lo demas.
   El principio de "parciales primero" sigue vigente: son la base de que es importante.
1. teo/   — primero: definen notacion y alcance. Saberlo antes evita rehacer el
            matching de ejercicios de las guias
2. prac/
3. guias/ — matching de ejercicios por enunciado (no por numero)
4. Re-correr /tipos_ejercicio — los ejercicios nuevos de las guias necesitan su bandera

TAMAÑO DE SESION EN MODO RECONCILIACION:
El merge consume bastante mas contexto que escribir en pagina en blanco (hay que leer la
pagina existente + el PDF nuevo + diffear). Reducir a 2 PDFs de teo/prac por sesion,
1 guia por sesion.

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
a. Leer programa.md si la consulta involucra "que entra en el parcial X"
b. Leer index.md para identificar paginas relevantes
b. Leer las paginas relevantes del wiki
c. Sintetizar respuesta con citas (formato: [fuente])
d. Si la respuesta es sintesis valiosa y reutilizable → sugerir guardar en sintesis/
e. Respuestas basadas SOLO en la base de conocimiento, salvo que el usuario
   solicite explicitamente busqueda web
f. PRECEDENCIA: si un bloque marcado como vigente (cursada 2C-2026) contradice a uno
   historico, gana el vigente — Y HAY QUE DECIRLO EN LA RESPUESTA, no resolver el
   conflicto en silencio. Ej: "asi se dicta este cuatrimestre; en el material viejo
   figuraba como X"
g. Si la pagina consultada esta en `pendiente_verificacion`, aclararlo cuando la
   pregunta sea sobre notacion, alcance o que entra — son justo los puntos donde el
   material viejo puede haber quedado desactualizado
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

- Leer programa.md para saber a que parcial pertenece cada tema HOY
- Leer todos los wiki/parciales_analizados/ e identificar patrones recurrentes
  (sus rotulos 1P/2P son historicos — no usarlos para asignar el parcial vigente)
- Crear paginas en tipos_ejercicio/ para cada patron identificado
- Revisar cada ejercicio en _practica.md y _guia.md
- Actualizar bandera de "⚪ Pendiente" a "🔴 Si → [[tipos_ejercicio/X]]" o "⚪ No"
- Si el rotulo historico difiere del parcial vigente, agregar el aviso de reubicacion
- Actualizar seccion "Patrones de este tema en parciales" en cada _practica.md
```

---

## 9. Comandos disponibles

Implementados como slash commands en `.claude/commands/` (la raiz del repo). Cada archivo contiene el workflow completo.

| Comando | Descripcion |
|---------|-------------|
| `/ingestar <ruta>` | Ingestar un PDF al wiki. Bajo `raw/cursada_*/` entra en modo reconciliacion |
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
| `/programa` | Propagar `programa.md` al frontmatter y al `index.md` cuando cambie el reparto de temas |

---

## 10. Restricciones

- **Nunca modificar archivos en raw/** — son inmutables
- **Nunca responder con informacion fuera del wiki** (salvo web search explicito del usuario)
- **Siempre actualizar index.md y log.md** despues de cada operacion de escritura
- **Idioma del wiki:** espanol; nombres tecnicos en ingles si asi aparecen en clases
- **Formulas:** siempre LaTeX, nunca texto plano
- **Nunca inferir el parcial de un tema** desde el nombre del archivo en `raw/` ni desde los
  parciales historicos — leer `programa.md`
- **Nunca reescribir `parcial:` en `parciales_analizados/`, `transcripciones/` ni
  `apariciones_en_parciales`** — son registro historico
- **Nunca borrar contenido historico al mergear la cursada vigente** — degradarlo a
  `solo_historico`, que es reversible; borrar no lo es
- **Nunca escribir un merge de reconciliacion sin aprobacion previa del usuario** — el diff
  se muestra y se espera confirmacion
- **Nunca inventar sistemas de señal paralelos a las banderas** — la base de que es importante
  siguen siendo los parciales historicos

---

## Notas especiales sobre archivos

- **Archivos con mismo numero de tema** (ej: `3.teo_1P_demo_mochila.pdf` y `3.teo_1P_programacion_dinamica.pdf`): pertenecen al mismo tema, integrar en la misma pagina de teoria
- **`6.prac_1P_repaso_para_primer_parcial.pdf` y `14.prac_2P_repaso_para_segundo_parcial.pdf`:** materiales de repaso, pueden generar paginas en sintesis/
- **`3.guia_1P_teoria_algoritmica_de_grafos.pdf`:** numerada como 1P por orden de dictado; con el programa vigente grafos entra en el 1P, asi que `parcial: 1P`
- **Parciales con multiples resoluciones** (`resolucion(1)` y `resolucion(2)` del mismo examen): crear una sola pagina e incluir ambas, anotando discrepancias
- **Rotulos `1P`/`2P` en los nombres de `raw/`:** corresponden al programa vigente cuando se
  dicto el material (hasta 1C-2026). Leerlos como orden de dictado, **no** como el parcial
  actual del tema. Ej: `6.teo_2P_grafos.pdf` es material de tu **1P** con el programa vigente
- **Extraccion de texto de PDFs — LEER ANTES DE INGESTAR:**
  - Esta maquina es **WSL2/Linux**. Instalar con `sudo apt-get install -y poppler-utils`
    (provee `pdftotext`, `pdfinfo` y `pdftoppm`)
  - **Verificar que exista antes de interpretar cualquier resultado:** `command -v pdftotext`.
    Un binario ausente devuelve 0 caracteres, y la regla del umbral (<500 chars → fotografiado)
    concluye "escaneado" y manda a vision. **La ausencia de la herramienta es indistinguible de
    un PDF escaneado.** Abortar ruidosamente si falta; nunca tratarlo como propiedad del PDF
  - El tool `Read` con `pages` **no** es fallback: depende de `pdftoppm`, mismo paquete
  - Alternativa sin sudo: PyMuPDF en un venv (`pip install pymupdf`)
  - **Contar paginas con `pdfinfo`, nunca con `file`:** `file` reporta el `/Count` del primer
    nodo del arbol de paginas, que en un Beamer puede ser un subarbol (reporto "6 pages" sobre
    un PDF de 160)
