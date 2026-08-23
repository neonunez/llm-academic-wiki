# Material de la cursada 2C 2026

PDFs y documentos **de la cursada que se esta cursando ahora**. Esta carpeta es la
**fuente de autoridad**: ante cualquier conflicto con el material de `raw/clases/` o
`raw/guias_practicas/` (cuatrimestres pasados), manda lo que esta aca.

Como todo `raw/`, es **inmutable**: no renombrar ni editar los archivos.

```
teo/      clases teoricas de este cuatrimestre
prac/     clases practicas de este cuatrimestre
guias/    guias de ejercicios de este cuatrimestre
```

## Como ingestar

```
/ingestar raw/cursada_2C_2026/teo/<archivo>.pdf
```

La ruta bajo `raw/cursada_*/` hace que `/ingestar` entre en **modo reconciliacion**:
en vez de crear una pagina nueva, contrasta contra la pagina canonica existente del tema,
muestra el diff y pide aprobacion antes de escribir.

**Orden de ingesta:** teoricas → practicas → guias → re-correr `/tipos_ejercicio`.
Las teoricas van primero porque definen notacion y alcance; saberlo antes evita rehacer
el matching de ejercicios de las guias.

**La base de que es importante siguen siendo los parciales historicos** (`raw/parciales/`,
ya ingestados). Las banderas 🔴/⚪ salen de ahi, sin cambios.

Ver `programa.md` (seccion "Cursada vigente") y `CLAUDE.md` (seccion "Procedencia y autoridad").
