# llm-academic-wiki

Sistema de wikis academicas personales basado en el patron LLM Wiki de Andrej Karpathy, adaptado para estudio universitario en la UBA (Ciencias de la Computacion).

## Estructura del repositorio

Una carpeta por materia. Cada materia tiene su propio `CLAUDE.md`, `index.md`, `log.md`, `raw/` y `wiki/` — completamente independientes entre si.

```
llm-academic-wiki/
├── .agents/workflows/              ← slash commands (compartidos entre materias)
├── tda/                                ← materia piloto (Tecnicas de Diseno de Algoritmos)
│   ├── CLAUDE.md
│   ├── index.md
│   ├── log.md
│   ├── raw/                       ← PDFs originales, INMUTABLES
│   └── wiki/                      ← contenido generado por el LLM
└── [Materia_N]/                   ← misma estructura
```

## Instruccion de uso

Siempre inicializar Antigravity desde la carpeta de la materia a estudiar, nunca desde la raiz:

```bash
cd llm-academic-wiki/tda/
claude
```

## Materias activas

| Materia | Ruta | Estado |
|---------|------|--------|
| Tecnicas de Diseno de Algoritmos | `tda/` | En construccion |
| Paradigmas de Programación | `plp/` | En construccion |

## Slash commands disponibles

Los comandos viven en `.agents/workflows/` y son agnósticos a la materia — operan sobre el working directory:

| Comando | Descripcion |
|---------|-------------|
| `/ingestar <ruta>` | Ingestar un PDF al wiki |
| `/ingestar_batch <carpeta>` | Ingestar todos los PDFs de una carpeta |
| `/resolver <ruta_pagina_guia>` | Resolver ejercicios pendientes de una guia |
| `/corregir <ruta_pagina> "<obs>"` | Corregir una pagina con aprobacion previa |
| `/lint` | Chequeo de salud del wiki |
| `/estado` | Resumen ejecutivo del wiki |
| `/chuleta <tema>` | Chuletas consolidadas de un tema |
| `/parcial <1P\|2P>` | Vista orientada a examen |
| `/simular [tema]` | Generar ejercicio de practica |
| `/resumen <tema>` | Resumen pedagogico de un tema para arrancar a resolver ejercicios |
| `/sintesis <nombre>` | Guardar sintesis en wiki |
| `/fuente_original [ruta]` | Acceder al PDF original |

## Procedimiento para agregar una nueva materia

1. Crear carpeta con estructura estandar de `raw/` y `wiki/` (adaptar subcarpetas de `raw/` al material disponible)
2. Soltar los PDFs en las subcarpetas de `raw/`
3. Inicializar Antigravity desde la carpeta de la materia: `cd llm-academic-wiki/[Nombre_Materia]/ && claude`
4. Proveer contexto especifico: nombre oficial, sistema de evaluacion, organizacion tematica, tipo de material, particularidades, estrategia de estudio
5. El LLM genera `CLAUDE.md`, `index.md` y `log.md` de la materia adaptados al contexto
6. Correr el pipeline de ingest: `/ingestar_batch` respetando el orden del `CLAUDE.md`
7. Actualizar este archivo agregando la materia a la tabla de materias activas

## Herramientas

- `pdftotext` (poppler) en `/opt/homebrew/bin/` — extraer texto de PDFs LaTeX
- Antigravity — LLM agent + vision para PDFs imagen
- Obsidian — navegacion del wiki
- Git — control de versiones
