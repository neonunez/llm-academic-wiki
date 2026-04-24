Chequeo de salud del wiki. Sin argumentos.

## Workflow

1. **Leer index.md** para obtener el catalogo completo de paginas
2. **Verificar cada pagina listada:**
   - Existe el archivo referenciado?
   - Tiene frontmatter completo y valido?
   - Los links internos `[[...]]` apuntan a paginas existentes?
3. **Buscar paginas huerfanas** — archivos .md en wiki/ que no aparecen en index.md ni son referenciados por ninguna otra pagina
4. **Revisar banderas pendientes** — buscar `⚪ Pendiente` en paginas `_practica.md` y `_guia.md` que ya podrian completarse (cruzando con parciales_analizados/)
5. **Temas sin pagina propia** — temas mencionados en paginas existentes que no tienen su propia pagina de teoria/practica
6. **Contradicciones entre paginas** — definiciones o resoluciones que se contradicen entre paginas del mismo tema
7. **Cross-references faltantes** — paginas del mismo tema que no se referencian entre si en `paginas_relacionadas`

## Output

Producir un reporte estructurado con:
- Problemas encontrados (agrupados por tipo)
- Acciones sugeridas para cada problema
- NO modificar nada automaticamente — el usuario decide que resolver

## Sugerencias adicionales

Al final del reporte, sugerir:
- Nuevas paginas de sintesis que podrian ser utiles
- Fuentes adicionales que podrian enriquecer el wiki
