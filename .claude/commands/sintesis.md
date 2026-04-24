Guardar la respuesta actual como pagina de sintesis. Argumento: $ARGUMENTS (nombre de la pagina, ej: comparacion_tecnicas_1P)

## Workflow

1. **Tomar la ultima respuesta sustancial** de la conversacion actual
2. **Crear `wiki/sintesis/$ARGUMENTS.md`** con:

```yaml
---
nombre: [titulo descriptivo basado en el contenido]
tipo: sintesis
temas: [lista de temas que cubre]
fecha_creacion: [fecha actual]
---
```

3. **Formatear el contenido** preservando estructura, formulas LaTeX y links internos
4. **Agregar links internos** a paginas del wiki referenciadas en la sintesis
5. **Actualizar index.md** — agregar la pagina bajo la seccion "Sintesis"
6. **Actualizar log.md** — `## [FECHA] sintesis | [nombre]`

## Nota

Las paginas de sintesis son cross-tema — nacen de consultas que producen sintesis valiosa y reutilizable. Ejemplos: `comparacion_tecnicas_1P.md`, `guia_rapida_1P.md`, `patrones_frecuentes_parciales.md`.
