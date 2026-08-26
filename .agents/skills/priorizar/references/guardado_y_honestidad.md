# Guardado, apendice y honestidad

## Apendice comun

Agregar al final de cualquiera de los tres modos. Es la justificacion de la seleccion, no el
material principal. En teoria, toda la contabilidad de parciales queda aqui.

```markdown
---

# Apendice — por que estas cosas y no otras

## Evidencia de la seleccion

| Unidad | Nivel | Apariciones | Patron |
|---|---|---|---|
| <unidad> | 🔴 | <id> Ej N · <id> Ej M | [[tipos_ejercicio/<patron>]] |

**Base de comparacion:** K parciales analizados, P patrones en `tipos_ejercicio/`.
<Declarar huecos de indice, fallback o degradacion a parciales crudos.>

## Lo que este documento NO cubre y igual toman

- [[tipos_ejercicio/<patron>]] — N apariciones. Material en [[<pagina>]]

## Divergencias detectadas

<Solo si existen. Reportar sin resolver: la reconciliacion corresponde a `/ingestar`.>
```

## Frontmatter

Sin `--dry`, crear `cursada_actual/<slug_del_pdf>.md`:

```yaml
---
nombre: <nombre pedagogico del material>
tipo: material_de_estudio
origen: <ruta tal como la paso el usuario>
tipo_documento: teorica | practica | guia
temas: [<slug>, ...]
parcial: <1P|2P|ambos>
programa: <vigencia>
generado: <YYYY-MM-DD>
base_comparacion:
  parciales_analizados: <K>
  tipos_ejercicio: <P>
ingestado: false
---
```

- Derivar `parcial` y `programa` desde `programa.md`.
- El slug se deriva del nombre del PDF, en snake_case y sin extension.
- Sobrescribir un material previo del mismo PDF: es regenerable.
- No actualizar `index.md` ni commitear.

## Log

Agregar exactamente una entrada:

```markdown
## <fecha> analisis | <archivo.pdf>
Material de estudio: `cursada_actual/<slug>.md` — N unidades explicadas (X criticas, Y probables), M patrones no cubiertos. Sin ingesta.
```

Si se regenera el mismo PDF, agregar una nueva entrada historica; `log.md` es append-only.
Con `--dry`, no escribir ni material ni log.

## Reglas de honestidad

1. **Ninguna aparicion sin cita.** Todo conteo debe tener links exactos a parciales analizados.
2. **No inventar patrones.** Solo usar patrones y parciales existentes en disco.
3. **Declarar la base.** Informar K parciales y P patrones.
4. **No inflar.** Si no hay coincidencias, decirlo sin fabricar secciones vacias.
5. **No reconciliar.** Una contradiccion PDF/wiki va a divergencias.
6. **No completar de memoria.** Si PDF/wiki no sostienen un paso, escribir `⚠️ Verificar` y la
   duda exacta.
7. **Explicar no es transcribir.** Reescribir con palabras propias; preservar formulas y codigo.
8. **Analogia fiel.** En `Explicacion para nene de 5`, simplificar vocabulario, no el contenido.
   Vincular explicitamente analogia y elementos formales para hacer visible cualquier limite.

## Frontera con otros workflows

- `/ingestar`: incorpora o reconcilia el PDF con la wiki; esta skill no.
- `/parcial`: vista de examen de toda la wiki; esta skill se restringe a un PDF.
- `/chuleta`: consolida templates existentes; esta skill selecciona y explica.
- `/resolver`: completa todos los pendientes de una guia ingestada; `priorizar guia` resuelve solo
  el subconjunto 🔴/🟡 de un PDF crudo y escribe una nota regenerable.
