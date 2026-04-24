Ingestar un PDF al wiki. Argumento: $ARGUMENTS (ruta al PDF relativa a la materia, ej: raw/clases/teo/1.teo_1P_divide_&_conquer.pdf)

## Workflow

1. **Verificar log.md** — si el archivo ya fue ingestado, informar y abortar
2. **Detectar tipo de PDF:**
   - Ejecutar `pdftotext "$ARGUMENTS" -` y contar caracteres
   - Si el resultado tiene > 500 chars → PDF digital (pdftotext)
   - Si el resultado tiene < 500 chars para un documento > 3 paginas → PDF fotografiado (Claude vision)
3. **Si es parcial fotografiado:** crear `wiki/transcripciones/[id]_raw.md` con transcripcion fiel via Claude vision antes de sintetizar
4. **Crear/actualizar paginas wiki** segun tipo de documento:
   - **Parcial:** crear `wiki/parciales_analizados/[id].md` con frontmatter + enunciado + resolucion + explicacion + analisis + chuleta por ejercicio
   - **Clase teorica:** crear `wiki/temas/[tema]_teoria.md` — extraccion fiel y estructurada, sin simplificar. Si es demo (ej: demo_mochila): integrar en la pagina de teoria del tema correspondiente
   - **Clase practica:** crear `wiki/temas/[tema]_practica.md` — ejercicios con enunciado, explicacion, resolucion paso a paso, chuleta, bandera parcial
   - **Guia (Fase 1 SOLAMENTE):** crear `wiki/temas/[tema]_guia.md` — extraer enunciados, escribir explicacion, cruzar con parciales para bandera. Dejar Resolucion y Chuleta como `[PENDIENTE — sesion de resolucion]`. Si cubre multiples temas, distribuir ejercicios a la pagina de guia de cada tema
   - **Contenido comunidad:** integrar en paginas existentes del tema correspondiente
5. **Actualizar index.md** — agregar la pagina al catalogo bajo el encabezado del tema correspondiente
6. **Actualizar log.md** — agregar entrada: `## [FECHA] ingest | [nombre_archivo]` con paginas creadas/actualizadas y temas identificados

## Observacion critica sobre Beamer

Los PDFs de clases (teo y prac) son LaTeX Beamer. Cada "build" incremental ocupa una pagina PDF separada. NO tratar cada pagina como contenido distinto — consolidar los builds en una sola version final de cada elemento. Senal: bloques de texto casi identicos con pequenas adiciones al final.

## Frontmatter obligatorio

Todas las paginas deben incluir frontmatter YAML con: nombre, parcial, tipo, tema, fuente, paginas_relacionadas.

## Convenciones

- Idioma: espanol (nombres tecnicos en ingles si asi aparecen en las clases)
- Links internos: sintaxis Obsidian `[[nombre_pagina]]`
- Citas a fuentes: path relativo desde raiz de materia
- Formulas: preservar en LaTeX ($...$ inline, $$...$$ bloque). Nunca parafrasear formulas a texto plano.
- Nomenclatura de archivos: snake_case
