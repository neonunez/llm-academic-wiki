Chequeo de salud del wiki. Sin argumentos.

## Regla previa — `programa.md` es la fuente de verdad del mapeo tema→parcial

Leer `programa.md` del working directory antes de asignar cualquier `parcial:`.
**Nunca** inferir el parcial desde el nombre del archivo en `raw/` ni desde el rotulo del
examen historico en que aparecio un ejercicio: esos rotulos reflejan el programa del
cuatrimestre en que se dicto/tomo el material, que puede diferir del vigente.
Todo frontmatter generado lleva `parcial:` (derivado) + `programa:` (version que refleja).

## Workflow

1. **Leer index.md** para obtener el catalogo completo de paginas
2. **Verificar cada pagina listada:**
   - Existe el archivo referenciado?
   - Tiene frontmatter completo y valido?
   - Los links internos `[[...]]` apuntan a paginas existentes?
3. **Buscar paginas huerfanas** — archivos .md en wiki/ que no aparecen en index.md ni son referenciados por ninguna otra pagina
4. **Chequear coherencia con `programa.md`** — que el `parcial:` de cada pagina de `temas/` y
   `tipos_ejercicio/` coincida con el mapa vigente, y que lleve el `programa:` correcto.
   Reportar las que quedaron desincronizadas (se arreglan con `/programa`).
   Verificar tambien que NO se haya tocado el `parcial:` de `parciales_analizados/` ni de
   `transcripciones/` — ahi es dato historico.
5. **Cobertura de verificacion contra la cursada vigente** — ver seccion dedicada mas abajo
6. **Revisar banderas pendientes** — buscar `⚪ Pendiente` en paginas `_practica.md` y `_guia.md` que ya podrian completarse (cruzando con parciales_analizados/)
7. **Temas sin pagina propia** — temas mencionados en paginas existentes que no tienen su propia pagina de teoria/practica
8. **Contradicciones entre paginas** — definiciones o resoluciones que se contradicen entre paginas del mismo tema
9. **Cross-references faltantes** — paginas del mismo tema que no se referencian entre si en `paginas_relacionadas`

## Chequeo 5 — Cobertura de verificacion contra la cursada vigente

Cada pagina de `wiki/temas/` y `wiki/tipos_ejercicio/` declara de donde sale su contenido y si
ya paso por el filtro del material de la cursada actual:

```yaml
fuentes:
  vigente:   [raw/cursada_2C_2026/teo/...]
  historico: [raw/clases/teo/...]
estado_verificacion: verificado_2C_2026 | pendiente_verificacion | solo_historico
```

Leer la `vigencia` declarada en `programa.md` para saber cual es la cursada actual (el sufijo de
`verificado_<vigencia>` debe coincidir con ella).

### 5a. Conteo y progreso

Contar paginas por `estado_verificacion` y reportar el avance:

| Estado | Que significa |
|---|---|
| `verificado_<vigencia>` | El material de la cursada actual ya paso por esta pagina |
| `pendiente_verificacion` | Solo tiene material historico. Falta contrastarla |
| `solo_historico` | Contenido que ya no se dicta. Se conserva, no se estudia |

**Esto es una barra de progreso, no una lista de errores.** Durante buena parte del cuatrimestre
el estado normal es que la mayoria de las paginas esten en `pendiente_verificacion`, porque el
material se va dictando de a poco. Reportarlo como avance del cuatrimestre en una seccion propia,
**nunca** dentro de "problemas encontrados".

### 5b. Que falta contrastar

Listar las paginas en `pendiente_verificacion` agrupadas **por parcial vigente** (segun el mapa de
`programa.md`) y dentro de cada parcial **por tema**. Sirve como checklist de ingesta:

```
Falta contrastar — 1P
  grafos               grafos_teoria · grafos_practica · grafos_guia
  recorrido_en_grafos  recorrido_en_grafos_practica
Falta contrastar — 2P
  greedy               greedy_teoria · greedy_practica · greedy_guia
```

Priorizar visualmente los temas del parcial mas proximo.

### 5c. Inconsistencias — esto si va en "problemas encontrados"

A diferencia de 5a y 5b, lo siguiente son defectos reales de datos:

| Sintoma | Por que esta mal |
|---|---|
| Tiene `fuentes.vigente` pero `estado_verificacion: pendiente_verificacion` | Se ingesto material de la cursada pero no se marco como verificada |
| `estado_verificacion: verificado_<vigencia>` sin ninguna `fuentes.vigente` | Se marco verificada sin respaldo de fuente |
| Falta el campo `estado_verificacion` | Quedo fuera del backfill |
| `verificado_<vigencia>` pero perdio sus `fuentes.historico` | El merge piso la procedencia historica en vez de conservarla |
| Badge de autoridad ausente | La autoridad no se ve al leer la pagina, solo en el frontmatter |
| Badge que no coincide con el `estado_verificacion` del frontmatter | Frontmatter y cuerpo se contradicen — decir cual dice que |
| Sufijo de `verificado_<X>` distinto de la `vigencia` de `programa.md` | Quedo de una cursada anterior |

Para cada una, indicar archivo y correccion sugerida. No corregir automaticamente.


## Output

Producir un reporte estructurado con dos bloques bien separados:

**1. Avance de la cursada** (no son problemas)
- Conteo por `estado_verificacion` y porcentaje verificado
- Checklist de lo que falta contrastar, por parcial vigente y tema

**2. Problemas encontrados** (agrupados por tipo)
- Todo lo demas, incluidas las inconsistencias de 5c
- Acciones sugeridas para cada problema

NO modificar nada automaticamente — el usuario decide que resolver.

## Sugerencias adicionales

Al final del reporte, sugerir:
- Nuevas paginas de sintesis que podrian ser utiles
- Fuentes adicionales que podrian enriquecer el wiki

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
