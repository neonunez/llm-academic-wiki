Analizar y corregir una pagina wiki. Argumento: $ARGUMENTS (ruta a la pagina y observacion entre comillas, ej: wiki/temas/dc_teoria.md "la definicion del Master Theorem esta incompleta")

## Workflow

1. **Parsear argumentos:** separar la ruta de la pagina de la observacion (texto entre comillas)
2. **Leer la pagina wiki indicada** completa
3. **Leer paginas relacionadas** (campo `paginas_relacionadas` del frontmatter) para contexto
4. **Si la correccion involucra una resolucion:** leer la fuente original (campo `fuente:` del frontmatter) para contrastar
5. **Analizar la observacion en profundidad** — no hacer un fix superficial
6. **REPORTAR al usuario SIN MODIFICAR NADA:**
   - Que esta incorrecto o inconsistente en la pagina
   - Si el problema se replica en otras paginas relacionadas
   - Exactamente como se piensa corregir cada punto
7. **ESPERAR APROBACION EXPLICITA del usuario** — no ejecutar ninguna modificacion hasta recibirla
8. **Una vez aprobado:** aplicar todas las correcciones descriptas en el reporte
9. **Actualizar log.md:** `## [FECHA] corregir | [ruta_pagina] | [resumen de cambios]`

## Importante

Este comando esta disenado para ser deliberado y transparente. El usuario debe ver y aprobar los cambios ANTES de que se ejecuten. Nunca modificar la pagina antes de la aprobacion.
