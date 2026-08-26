---
name: priorizar
description: Genera material de estudio priorizado desde un PDF de clase teorica, clase practica o guia, usando programa.md y los parciales ya analizados. Usar cuando el usuario invoque /priorizar o pida convertir material de cursada en una explicacion conceptual, practica resuelta o plan de entrenamiento sin ingestar el PDF.
compatibility: Requiere poppler (pdftotext y pdfinfo), programa.md y wiki/parciales_analizados/ en la materia actual.
---

# Priorizar material de cursada

Generar material personal en `cursada_actual/` a partir de un PDF. El cruce contra parciales decide
**que priorizar y con cuanta profundidad**; no debe convertir todo resultado en un informe de
frecuencias.

## Argumentos

Formato obligatorio:

```text
/priorizar <teoria|practica|guia> <ruta_pdf> [--dry]
```

1. El primer argumento debe ser exactamente `teoria`, `practica` o `guia`.
2. Debe existir una ruta de PDF despues del tipo.
3. Separar `--dry`, si aparece, de la ruta.
4. No inferir el tipo por la carpeta, el nombre ni el contenido.
5. Ante argumentos invalidos, abortar mostrando la sintaxis anterior.

Normalizar `teoria` como `tipo_documento: teorica`; conservar `practica` y `guia`.

## Contrato de no-ingesta

Este workflow solo puede escribir:

- `cursada_actual/<slug_pdf>.md` (salvo `--dry`);
- una entrada de analisis en `log.md`.

No copiar ni mover el PDF. No modificar `raw/`, `wiki/`, `index.md`, banderas, verificaciones ni
patrones. No commitear. Una contradiccion entre PDF y wiki se reporta como divergencia: no se
resuelve.

## Archivos de referencia de esta skill

Leer en este orden:

1. Siempre: [seleccion y prioridad](references/seleccion_y_prioridad.md).
2. Segun el tipo declarado, leer **solo una** plantilla completa:
   - `teoria`: [salida teorica](references/salida_teoria.md)
   - `practica`: [salida practica](references/salida_practica.md)
   - `guia`: [salida guia](references/salida_guia.md)
3. Antes de escribir: [guardado y honestidad](references/guardado_y_honestidad.md).

## Workflow obligatorio

### 1. Validar contexto y argumentos

- Leer `programa.md` antes de asignar cualquier `parcial:`. Si no existe, abortar.
- Confirmar que `wiki/parciales_analizados/` existe y no esta vacio. Si falta, abortar.
- Si `wiki/tipos_ejercicio/` no esta poblado, degradar a parciales crudos y avisar.
- Leer `CLAUDE.md`, `index.md` y las instrucciones de la materia necesarias para respetar slugs,
  vigencia y convenciones.

### 2. Extraer el PDF

Usar `scripts/extract_pdf.sh <pdf> <salida_temporal>` desde el directorio de esta skill. El script:

- aborta si faltan `pdftotext` o `pdfinfo`;
- informa paginas y caracteres;
- extrae el texto al archivo temporal indicado.

Interpretar el resultado:

- mas de 500 caracteres: PDF digital, usar el texto;
- menos de 500 caracteres y mas de 3 paginas: PDF fotografiado, usar vision;
- nunca crear una transcripcion en la wiki.

### 3. Segmentar con identificadores rastreables

- `teoria`: cada definicion, teorema, demostracion, tecnica o relacion conceptual; identificar por
  `§seccion` y/o rango de diapositivas.
- `practica`: cada ejercicio resuelto; conservar numero o titulo original.
- `guia`: cada ejercicio; conservar numeracion original.

Si el contenido parece de otro tipo, advertirlo en la cabecera pero respetar el tipo declarado.

### 4. Mapear temas y parcial

- Identificar slugs cruzando PDF, `index.md` y `programa.md`.
- Derivar siempre el parcial desde `programa.md`, nunca desde el nombre del PDF.
- Si cubre varios temas o parciales, declararlo y agrupar.
- Si no hay match, marcar `🆕 tema no cubierto por la wiki` sin forzarlo.

### 5. Cargar evidencia evaluable

Seguir exactamente la cascada de `references/seleccion_y_prioridad.md`:

- patrones del tema;
- sintesis opcional;
- chequeo de huecos del indice;
- drill-down solo a parciales citados por patrones coincidentes.

No releer todos los parciales si el indice derivado tiene cobertura.

### 6. Priorizar y hacer cruce inverso

Asignar 🔴/🟡/⚪/🆕 segun la referencia. Luego listar los patrones del mismo tema y parcial que el
PDF no cubre. La evidencia se reserva para el apendice.

### 7. Escribir segun el tipo

La diferencia pedagogica es obligatoria:

- **Teoria:** construir comprension y dominio conceptual. Los parciales regulan profundidad. No
  centrar cada concepto en como resolver un ejercicio.
- **Practica:** ensenar tecnicas mediante ejercicios modelo, decisiones y resoluciones razonadas.
- **Guia:** construir un plan progresivo de entrenamiento y resolver el subconjunto prioritario.

Usar la plantilla del archivo de referencia correspondiente sin mezclar modos.

### 8. Guardar y registrar

Aplicar `references/guardado_y_honestidad.md`. Con `--dry`, mostrar el resultado sin escribir el
material ni el log. Sin `--dry`, escribir el material y agregar exactamente una entrada a `log.md`.
