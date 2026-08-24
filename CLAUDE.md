# llm-academic-wiki

Sistema de wikis academicas personales basado en el patron LLM Wiki de Andrej Karpathy, adaptado para estudio universitario en la UBA (Ciencias de la Computacion).

## Estructura del repositorio

Una carpeta por materia. Cada materia tiene su propio `CLAUDE.md`, `index.md`, `log.md`, `raw/` y `wiki/` — completamente independientes entre si.

```
llm-academic-wiki/
├── .claude/commands/           ← slash commands (compartidos entre materias)
├── .agents/workflows/          ← symlink a .claude/commands/
├── tda/                                ← materia piloto (Tecnicas de Diseno de Algoritmos)
│   ├── CLAUDE.md
│   ├── programa.md                 ← temas por parcial del cuatrimestre vigente
│   ├── index.md
│   ├── log.md
│   ├── raw/                       ← PDFs originales, INMUTABLES
│   │   └── cursada_<XC_AAAA>/     ← material de la cursada vigente (fuente de autoridad)
│   ├── wiki/                      ← contenido generado por el LLM
│   └── cursada_actual/            ← informes de /priorizar, NO es wiki compilado
└── [Materia_N]/                   ← misma estructura
```

## Instruccion de uso

Siempre inicializar Claude Code desde la carpeta de la materia a estudiar, nunca desde la raiz:

```bash
cd llm-academic-wiki/tda/
claude
```

## Materias activas

| Materia | Ruta | Estado |
|---------|------|--------|
| Tecnicas de Diseno de Algoritmos | `tda/` | Wiki completa · reparto de temas por parcial actualizado a 2C-2026 |
| Paradigmas de Programación | `plp/` | Guias completas y resueltas — 33 ej. con `⚠️ Verificar` · `programa.md` oficial (2 parciales) · frontmatter normalizado 2026-08-24 |
| Sistemas Digitales | `sistemas_digitales/` | ⚠️ **PARCIAL UNICO** (10 unidades) · reparto propagado 2026-08-24 · huecos sin cubrir: Diseño Modular (unidades 6-7), punto fijo/flotante, restadores, comparadores |

## Slash commands disponibles

Los comandos viven en `.claude/commands/` (`.agents/workflows/` es un symlink a esa carpeta, para otros agentes) y son agnósticos a la materia — operan sobre el working directory:

| Comando | Descripcion |
|---------|-------------|
| `/ingestar <ruta>` | Ingestar un PDF al wiki. Bajo `raw/cursada_*/` entra en modo reconciliacion |
| `/ingestar_batch <carpeta>` | Ingestar todos los PDFs de una carpeta |
| `/resolver <ruta_pagina_guia>` | Resolver ejercicios pendientes de una guia |
| `/priorizar <ruta_pdf>` | Analizar un PDF de la cursada contra los parciales y decir a que prestarle atencion. **No ingesta** |
| `/corregir <ruta_pagina> "<obs>"` | Corregir una pagina con aprobacion previa |
| `/lint` | Chequeo de salud del wiki |
| `/estado` | Resumen ejecutivo del wiki |
| `/chuleta <tema>` | Chuletas consolidadas de un tema |
| `/parcial <1P\|2P>` | Vista orientada a examen |
| `/simular [tema]` | Generar ejercicio de practica |
| `/resumen <tema>` | Resumen pedagogico de un tema para arrancar a resolver ejercicios |
| `/sintesis <nombre>` | Guardar sintesis en wiki |
| `/fuente_original [ruta]` | Acceder al PDF original |
| `/tipos_ejercicio_scan` | Detectar patrones recurrentes cruzando parciales analizados |
| `/tipos_ejercicio_run` | Crear paginas `tipos_ejercicio/` y actualizar banderas |
| `/tipos_ejercicio` | Paso 9 del pipeline: scan + run en una pasada |
| `/programa` | Propagar `programa.md` cuando la catedra cambia que temas entran en cada parcial |

## Procedimiento para agregar una nueva materia

1. Crear carpeta con estructura estandar de `raw/` y `wiki/` (adaptar subcarpetas de `raw/` al material disponible)
2. Soltar los PDFs en las subcarpetas de `raw/`. El material de la cursada que se esta cursando
   va en `raw/cursada_<XC_AAAA>/{teo,prac,guias}/` — es la fuente de autoridad ante conflictos
3. Inicializar Claude Code desde la carpeta de la materia: `cd llm-academic-wiki/[Nombre_Materia]/ && claude`
4. Proveer contexto especifico: nombre oficial, sistema de evaluacion, organizacion tematica, tipo de material, particularidades, estrategia de estudio
5. El LLM genera `CLAUDE.md`, `index.md` y `log.md` de la materia adaptados al contexto
6. Correr el pipeline de ingest: `/ingestar_batch` respetando el orden del `CLAUDE.md`
7. Crear `programa.md` con el mapa tema→parcial vigente (fuente de verdad; el `parcial:` del
   frontmatter se deriva de ahi, nunca del nombre del PDF)
8. Actualizar este archivo agregando la materia a la tabla de materias activas

## Herramientas

- `pdftotext` (poppler) en `/opt/homebrew/bin/` — extraer texto de PDFs LaTeX
- Claude Code — LLM agent + vision para PDFs imagen
- Obsidian — navegacion del wiki
- Git — control de versiones
