Ingestar todos los PDFs de una carpeta en orden. Argumento: $ARGUMENTS (ruta a la carpeta relativa a la materia, ej: raw/parciales/1P/)

## Workflow

1. **Verificar log.md** — identificar que archivos de la carpeta ya fueron ingestados para no re-procesarlos
2. **Listar PDFs** de la carpeta en orden numerico (por el prefijo numerico del nombre)
3. **Filtrar** los ya ingestados (basandose en log.md)
4. **Para cada PDF pendiente**, ejecutar el workflow de `/ingestar` internamente:
   - Detectar tipo (digital vs fotografiado)
   - Crear/actualizar paginas wiki
   - Actualizar index.md y log.md
5. **Control de sesion:** el ingest consume contexto acumulativamente. Tamanos recomendados por sesion:
   - PDFs cortos (parciales, transcripciones): hasta 6
   - PDFs medianos (clases teo/prac, ~100-200 pags Beamer): 3-4
   - PDFs largos (guias con muchos ejercicios): 2-3
   - PDFs fotografiados (vision): 2-3
   Si el contexto supera el 60% de capacidad, informar al usuario, hacer commit, y sugerir continuar en una nueva sesion.

## Orden obligatorio de ingest (si se ingesta todo desde cero)

1. `raw/parciales/1P/` y `raw/parciales/2P/` — primero siempre
2. `raw/clases/teo/` — por numero cronologico
3. `raw/clases/prac/` — por numero cronologico
4. `raw/guias_practicas/` — por numero cronologico
5. `raw/contenido_comunidad/` — al final

Este orden permite que las banderas "Aparece en parciales?" se completen correctamente al ingestar clases y guias.

## Resumibilidad

El ingest es resumible: cada sesion continua desde donde termino la anterior. Nunca reingestar un archivo que ya aparece en log.md.
