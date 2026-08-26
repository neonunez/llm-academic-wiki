# Material de la cursada 2C 2026

PDFs y documentos **de la cursada que se esta cursando ahora**. Esta carpeta es la
**fuente de autoridad**: ante cualquier conflicto con el material historico de `raw/clases/`
o `raw/guias_practicas/`, manda lo que esta aca.

Como todo `raw/`, es **inmutable**: no renombrar ni editar los archivos.

```
teo/      clases teoricas de este cuatrimestre
prac/     clases practicas de este cuatrimestre
guias/    guias de ejercicios de este cuatrimestre
```

## Usar con `/priorizar`

Desde la carpeta `plp/`:

```
/priorizar teoria raw/cursada_2C_2026/teo/<archivo>.pdf
```

El material de estudio generado se guarda en `cursada_actual/`. El comando no ingesta el PDF
ni modifica la wiki.

## Ingestar, si corresponde

```
/ingestar raw/cursada_2C_2026/teo/<archivo>.pdf
```

La ruta bajo `raw/cursada_*/` hace que `/ingestar` entre en **modo reconciliacion**: contrasta
contra la pagina canonica existente, muestra el diff y pide aprobacion antes de escribir.

**Orden de ingesta:** teoricas → practicas → guias → re-correr `/tipos_ejercicio`.

La base para decidir que es importante siguen siendo los parciales historicos ya ingestados.
Ver `programa.md` y `CLAUDE.md`.
