Resumen ejecutivo del wiki. Sin argumentos.

## Regla previa — `programa.md` es la fuente de verdad del mapeo tema→parcial

Leer `programa.md` del working directory antes de asignar cualquier `parcial:`.
**Nunca** inferir el parcial desde el nombre del archivo en `raw/` ni desde el rotulo del
examen historico en que aparecio un ejercicio: esos rotulos reflejan el programa del
cuatrimestre en que se dicto/tomo el material, que puede diferir del vigente.
Todo frontmatter generado lleva `parcial:` (derivado) + `programa:` (version que refleja).

## Workflow

1. **Contar paginas por tipo** leyendo index.md:
   - Teoria (`_teoria.md`)
   - Practica (`_practica.md`)
   - Guia (`_guia.md`)
   - Tipos de ejercicio (`tipos_ejercicio/`)
   - Parciales analizados (`parciales_analizados/`)
   - Programa vigente (`programa.md`): version, y si hay paginas con `programa:` desincronizado
   - Sintesis (`sintesis/`)
   - Transcripciones (`transcripciones/`)
2. **Contar PDFs en raw/** vs paginas generadas en wiki/
3. **Contar banderas pendientes:**
   - `⚪ Pendiente` en paginas de practica y guia
   - `[PENDIENTE — sesion de resolucion]` en guias no resueltas
4. **Ultimo ingest:** fecha y archivo del ultimo registro en log.md
5. **Cobertura por tema:** para cada tema, listar que tipos de pagina existen (teoria/practica/guia/tipos_ejercicio)
6. **Cobertura de verificacion contra la cursada vigente** — ver seccion dedicada mas abajo

## Cobertura de verificacion contra la cursada vigente

Leer la `vigencia` de `programa.md` (ej. `2C_2026`) y el mapa tema→parcial. Despues recorrer
`wiki/temas/` y `wiki/tipos_ejercicio/` leyendo el campo `estado_verificacion` de cada pagina:
`verificado_<vigencia>` / `pendiente_verificacion` / `solo_historico`.

Armar una tabla por tema, **ordenada poniendo primero los temas del parcial mas proximo**:

| Tema | Parcial | Paginas | Verificadas | Pendientes |
|------|---------|---------|-------------|------------|
| grafos | 1P | 3 | 2 | 1 |
| recorrido_en_grafos | 1P | 2 | 0 | 2 |
| greedy | 2P | 3 | 0 | 3 |

Y calcular el **porcentaje global de avance**: verificadas / (verificadas + pendientes).
Las paginas `solo_historico` quedan fuera del denominador — no son material a verificar.

Marcar visualmente los temas del parcial mas proximo (los que estan al 0% son los mas urgentes)
y los que ya estan al 100%.

**Encuadre:** esto es progreso del cuatrimestre, no una lista de fallas. Que la mayoria de las
paginas figure como pendiente es lo esperado mientras el material se va dictando. Presentarlo
como avance; los defectos de datos son problema de `/lint`, no de aca.

Si ninguna pagina tiene el campo `estado_verificacion`, reportar "sin datos de verificacion"
en vez de 0% — significa que todavia no se corrio el backfill.

## Output

Presentar en una tabla compacta de una pantalla. Ejemplo:

```
Estado del wiki — Algoritmos y Estructuras de Datos III
─────────────────────────────────────────────────────────
PDFs en raw/: N | Paginas wiki: M | Cobertura de ingest: X%

Por tipo: Teoria 10 | Practica 8 | Guia 5 | Tipos ej. 3 | Parciales 4 | Sintesis 0

Banderas pendientes: 12 ⚪ | Guias sin resolver: 3

Ultimo ingest: [FECHA] <archivo>

Verificacion cursada 2C_2026: 12/47 paginas (26%)
  1P (parcial mas proximo)
    grafos                 ███░░  2/3
    recorrido_en_grafos    ░░░░░  0/2   ← sin contrastar
    divide_y_conquista     █████  3/3
  2P
    greedy                 ░░░░░  0/3
    programacion_dinamica  █░░░░  1/5
```

## Estados de verificacion parcial

Ademas de los tres estados base, una pagina mergeada puede quedar en
`verificado_parcial_<vigencia>`: parte del contenido fue contrastado contra la cursada vigente y
parte no. Los bloques **no** contrastados llevan la marca 📎 inline.

Chequeos adicionales:

- Contar bloques 📎 por pagina y reportarlos como "lo que falta contrastar" **dentro** de esa
  pagina, no solo a nivel pagina completa
- Coherencia: una pagina en `verificado_parcial_*` **debe** tener al menos un 📎; una en
  `verificado_*` (sin `_parcial`) **no debe** tener ninguno
- Badge 🟡 ↔ `verificado_parcial_*`, badge ✅ ↔ `verificado_*`, badge ⚠️ ↔ `pendiente_verificacion`
- Una pagina sin 📎 restantes que siga en `verificado_parcial_*` esta lista para promover a
  `verificado_*` — reportarlo como accion sugerida, no como error

En el conteo de avance, `verificado_parcial_*` cuenta como **medio**: ni verificada ni pendiente.
Reportarla en su propia columna en vez de forzarla a una de las dos.
