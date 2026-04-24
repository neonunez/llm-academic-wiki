Resumen de un tema para arrancar a resolver ejercicios. Argumento: $ARGUMENTS (nombre del tema, ej: divide_y_conquista)

## Workflow

1. **Leer index.md** e identificar todas las páginas del tema
2. **Leer las páginas fuente** en este orden:
   - `wiki/temas/[tema]_teoria.md` (o `_pt1`, `_pt2`, etc.) — conceptos y demostraciones
   - `wiki/temas/[tema]_practica.md` — ejercicios de clase, patrones recurrentes
   - `wiki/temas/[tema]_guia.md` — ejercicios resueltos representativos
   - `wiki/tipos_ejercicio/[tema]_*` — patrones identificados en parciales
3. **Sintetizar** en orden pedagógico: definición → propiedades → demostraciones esenciales → algoritmos → patrones de ejercicios
4. **Filtro de relevancia:** incluir solo lo que tiene impacto directo en resolver ejercicios. Omitir contenido puramente formal sin aplicación práctica visible
5. **Tono y claridad:** el resumen está dirigido a alguien que ve el tema **por primera vez**. Cada concepto, demostración y patrón debe explicarse de forma clara y accesible — no asumir conocimiento previo del tema. Priorizar ejemplos concretos, intuición antes de formalismo, y lenguaje directo. El objetivo es que el usuario pueda leer el resumen y quedar listo para resolver ejercicios sin haber visto el material original
6. **Guardar** como `wiki/sintesis/[tema]_resumen.md`
7. **Actualizar** `index.md` y `log.md`

## Estructura del output

```yaml
---
nombre: [Tema] — Resumen
tipo: sintesis
subtipo: resumen
tema: [tema]
parcial: [1P|2P|ambos]
fecha_creacion: [fecha]
paginas_fuente:
  - "[[tema_teoria]]"
  - "[[tema_practica]]"
  - "[[tema_guia]]"
---
```

```
## Qué es y cuándo se aplica
[2-3 párrafos: definición con intuición antes que formalismo, condiciones de uso con ejemplos
concretos. Escrito para alguien que ve el tema por primera vez. Sin relleno.]

## Conceptos clave
[Lista de definiciones con 1-2 líneas cada una. LaTeX donde corresponda.]

## Demostraciones esenciales
[Solo las demos que explican por qué funciona el algoritmo o que aparecen en parciales.
Para cada una: enunciado → intuición de por qué es verdad → pasos con justificación de cada uno.
Claridad sobre rigor: si hay que sacrificar algo, que no sea la comprensión. No reproducir
demostraciones mecánicas que no aporten entendimiento.]

## Algoritmos y complejidad
[Pseudocódigo o descripción estructurada. Complejidad temporal y espacial con justificación
de por qué esa complejidad. LaTeX para recurrencias.]

## Patrones de ejercicios

### Patrón — [nombre]
**Cuándo aparece:** [descripción breve]
**Cómo resolverlo:**
1. [paso] — *por qué: [justificación]*
2. ...
**Ejemplo:** [ejercicio representativo de la guía o práctica, resuelto brevemente]

[Repetir para cada patrón relevante del tema]

## Checklist antes de resolver
> - [ ] Identifiqué el patrón del ejercicio
> - [ ] Sé qué estructura/algoritmo aplicar
> - [ ] Conozco la complejidad esperada
> - [ ] [ítem específico del tema]

## Ver también
- [[tema_teoria]] — fuente completa
- [[tema_practica]] — ejercicios de clase
- [[tema_guia]] — guía de ejercicios
```

## Nota sobre extensión

Este resumen debe ser más largo que una chuleta pero no reproducir el wiki completo.
Meta: que el usuario pueda leerlo en 10-15 minutos y quedar listo para resolver ejercicios.
Si el tema es extenso (ej: programacion_dinamica), crear `[tema]_resumen_pt1.md` y `_pt2.md`.

## Nota si faltan fuentes

Si `_teoria.md` no existe aún para el tema, avisar al usuario y ofrecer basarse solo
en `_practica.md` y `_guia.md` como fuentes.
