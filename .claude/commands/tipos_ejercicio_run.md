Paso 9 del pipeline: crear paginas tipos_ejercicio/ y actualizar banderas. Requiere haber corrido /tipos_ejercicio_scan primero. Argumento: $ARGUMENTS (parcial: 1P o 2P)

## Regla previa — `programa.md` es la fuente de verdad del mapeo tema→parcial

Leer `programa.md` del working directory antes de asignar cualquier `parcial:`.
**Nunca** inferir el parcial desde el nombre del archivo en `raw/` ni desde el rotulo del
examen historico en que aparecio un ejercicio: esos rotulos reflejan el programa del
cuatrimestre en que se dicto/tomo el material, que puede diferir del vigente.
Todo frontmatter generado lleva `parcial:` (derivado) + `programa:` (version que refleja).

## Contexto

Lee `wiki/sintesis/patrones_detectados.md` como fuente de verdad (generado por /tipos_ejercicio_scan). Crea las paginas `tipos_ejercicio/` y actualiza banderas solo para el parcial indicado en $ARGUMENTS. Los patrones cross-parcial (ambos) se incluyen en ambas corridas.

Correr dos veces: `/tipos_ejercicio_run 1P` y luego `/tipos_ejercicio_run 2P`.

## Paso 1 — Leer CLAUDE.md y patrones detectados

Leer `CLAUDE.md` para convenciones de la materia.

Leer `wiki/sintesis/patrones_detectados.md`. Filtrar patrones donde `parcial` sea `$ARGUMENTS` o `ambos`.

## Paso 2 — Crear paginas tipos_ejercicio/

Para cada patron filtrado, crear `wiki/tipos_ejercicio/[nombre_patron].md` si no existe ya:

```markdown
---
nombre: [descripcion del patron]
tema: [tema]
parcial: [1P | 2P | ambos]   # del tema segun programa.md
programa: [vigencia]
apariciones_en_parciales:
  - parciales_analizados/[id]  # ej N
---

## Como reconocer este patron

[senales en el enunciado que identifican el tipo]

## Template de resolucion

[pasos exactos, formato machete]

## Por que funciona

[justificacion minima necesaria]

## Apariciones en parciales

- [[parciales_analizados/[id]]] — Ejercicio N: [descripcion breve]

## Ejercicios que ejemplifican esto

- [[temas/[tema]_guia]] — Ejercicio N
- [[temas/[tema]_practica]] — Ejercicio N
```

Si la pagina ya existe (porque se corrio para el otro parcial), skipear — no sobreescribir.

## Paso 3 — Identificar paginas a actualizar

```bash
ls wiki/temas/*_practica.md wiki/temas/*_guia.md 2>/dev/null
```

Filtrar solo las paginas cuyo frontmatter tenga `parcial: $ARGUMENTS` o `parcial: ambos`
(ese campo ya viene derivado de `programa.md`).

Si el patron esta marcado `reubicado: true`, insertar el aviso de reubicacion justo debajo
del encabezado `## Apariciones en parciales`, explicando que los rotulos de la lista son del
programa viejo y en que parcial entra hoy.

## Paso 4 — Actualizar banderas

Para cada pagina filtrada:

1. Leer el archivo
2. Para cada ejercicio con `⚪ Pendiente` o `⚪ No` en la bandera `¿Aparece en parciales?`:
   - Cruzar el tipo de ejercicio con los patrones de `patrones_detectados.md`
   - Si hay match: cambiar a `🔴 Si → [[tipos_ejercicio/[nombre_patron]]]`
   - Si no hay match: cambiar a `⚪ No`
3. Actualizar seccion `## Patrones de este tema en parciales` en cada `_practica.md` con links a los `tipos_ejercicio/` del tema

## Paso 5 — Actualizar index.md

Completar la seccion `## Tipos de ejercicio` en `index.md` agregando las paginas nuevas creadas en este run. No duplicar entradas ya existentes.

## Paso 6 — Commit

```bash
git add -A
git commit -m "wiki: tipos_ejercicio $ARGUMENTS — N patrones, M banderas actualizadas"
```

## Paso 7 — Reportar

- Patrones procesados para $ARGUMENTS: N
- Paginas tipos_ejercicio/ creadas: N (skipeadas por ya existir: N)
- Paginas actualizadas: N (_practica: X, _guia: Y)
- Banderas cambiadas: N
