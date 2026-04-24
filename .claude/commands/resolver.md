Resolver ejercicios pendientes de una pagina de guia. Argumento: $ARGUMENTS (ruta a la pagina de guia, ej: wiki/temas/dc_guia.md)

## Contexto

Esta es la Fase 2 del workflow de guias. La Fase 1 (ingest) ya extrajo los enunciados y escribio las explicaciones, pero dejo las secciones `Resolucion paso a paso` y `Chuleta` como `[PENDIENTE — sesion de resolucion]`. Esta sesion dedica atencion completa a resolver cada ejercicio.

## Workflow

1. **Leer la pagina wiki indicada** — NO el PDF original. La pagina ya tiene los enunciados extraidos.
2. **Leer la pagina de teoria del mismo tema** (`[tema]_teoria.md`) para tener contexto teorico.
3. **Para cada ejercicio con `[PENDIENTE]`:**
   a. Resolver paso a paso con justificaciones claras
   b. Escribir la chuleta (pasos concisos tipo machete)
   c. Si hay incertidumbre: escribir la solucion de todas formas y marcar con `⚠️ Verificar — [nota explicando la duda]`
4. **Actualizar log.md** con entrada: `## [FECHA] resolver | [nombre_pagina]` indicando cuantos ejercicios se resolvieron

## Restricciones

- Aplica EXCLUSIVAMENTE a paginas `_guia.md` — las paginas de teoria y practica no lo necesitan
- No modificar enunciados ni explicaciones ya escritas en Fase 1
- Si un ejercicio ya esta resuelto (no tiene `[PENDIENTE]`), no tocarlo
- Formulas en LaTeX siempre
