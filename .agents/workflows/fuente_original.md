Acceder al PDF original. Argumento opcional: $ARGUMENTS (ruta al PDF, ej: raw/clases/teo/1.teo_1P_divide_&_conquer.pdf)

## Workflow

1. **Si hay argumento:** usar la ruta indicada directamente
2. **Si no hay argumento:** inferir la fuente del contexto de la conversacion:
   - Buscar la ultima pagina wiki discutida
   - Leer su campo `fuente:` del frontmatter
   - Usar esa ruta
3. **Leer el PDF** usando pdftotext (o Claude vision si es fotografiado)
4. **Presentar el contenido** relevante al usuario

## Nota

Si este comando se usa recurrentemente para el mismo documento, es senal de que la pagina wiki correspondiente necesita ser mejorada — informar al usuario.
