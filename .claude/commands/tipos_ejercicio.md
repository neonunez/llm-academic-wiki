Paso 9 del pipeline: generar tipos_ejercicio/ y actualizar banderas en _practica.md y _guia.md. Ejecutar desde la carpeta de la materia.

## Contexto

Este es un paso de reconciliacion post-ingest y post-resolver. Los `parciales_analizados/` ya estan completos y son la fuente de verdad. El objetivo es identificar patrones recurrentes en parciales, crear paginas `wiki/tipos_ejercicio/` y actualizar las banderas "¿Aparece en parciales?" en las paginas de practica y guia.

NO es descubrimiento — es cruzar conocimiento ya existente en disco.

## Paso 1 — Leer el CLAUDE.md de la materia

Leer `CLAUDE.md` en el working directory para conocer las convenciones especificas de la materia (nomenclatura de temas, estructura de paginas, etc.).

## Paso 2 — Leer todos los parciales_analizados/

```bash
ls wiki/parciales_analizados/
```

Leer cada archivo. Para cada parcial, extraer:
- Temas evaluados
- Tipo de ejercicio por ejercicio (ej: "circuito combinatorio con mux", "conversion flip-flop")
- Frecuencia de aparicion de cada patron entre distintos parciales

## Paso 3 — Identificar patrones recurrentes

Un patron es recurrente si:
- Aparece en 2 o mas parciales distintos, o
- Es un tipo de ejercicio caracteristico del tema aunque aparezca una sola vez

Construir lista de patrones con:
- `nombre_patron` en snake_case
- descripcion breve
- apariciones: lista de [archivo_parcial, numero_ejercicio]

## Paso 4 — Crear paginas tipos_ejercicio/

Para cada patron identificado, crear `wiki/tipos_ejercicio/[nombre_patron].md`:

```markdown
---
nombre: [descripcion del patron]
tema: [tema]
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

## Paso 5 — Actualizar banderas en _practica.md y _guia.md

Para cada archivo `_practica.md` y `_guia.md` en `wiki/temas/`:

1. Leer el archivo
2. Para cada ejercicio con `⚪ Pendiente` o `⚪ No` en la bandera `¿Aparece en parciales?`:
   - Cruzar con los patrones identificados en el Paso 3
   - Si el tipo de ejercicio aparece en algun parcial: actualizar a `🔴 Si → [[tipos_ejercicio/[nombre_patron]]]`
   - Si no aparece: dejar como `⚪ No`
3. Actualizar la seccion `## Patrones de este tema en parciales` al inicio de cada `_practica.md` con links a los `tipos_ejercicio/` del tema

## Paso 6 — Actualizar index.md

Completar la seccion `## Tipos de ejercicio` en `index.md` con una linea por cada pagina creada:

```markdown
## Tipos de ejercicio

- [[tipos_ejercicio/[nombre_patron]]] — [descripcion breve]
```

Si la seccion no existe, crearla.

## Paso 7 — Commit

```bash
git add -A
git commit -m "wiki: generar tipos_ejercicio y actualizar banderas"
```

## Paso 8 — Reportar al usuario

Imprimir resumen:
- Patrones identificados: N
- Paginas tipos_ejercicio/ creadas: N
- Banderas actualizadas: N (en X archivos _practica.md y _guia.md)
