Propagar el reparto de temas por parcial desde `programa.md` a todo el wiki. Sin argumentos (o `--check` para solo reportar sin escribir).

## Cuando usarlo

Cuando la catedra cambia **que temas entran en cada parcial**. El flujo es:

1. Editas a mano `programa.md`: la **Tabla vigente**, el **Mapa tema → parcial** y una entrada
   nueva en **Historial de programas** con el diff de movimientos.
2. Corres `/programa`. Este comando propaga ese cambio al resto del wiki.

## Que es fuente de verdad y que es derivado

| Archivo | Rol |
|---|---|
| `programa.md` | **Fuente de verdad.** Solo se edita a mano |
| `wiki/temas/*.md` → `parcial:`, `programa:` | Derivado — lo escribe este comando |
| `wiki/tipos_ejercicio/*.md` → `parcial:`, `programa:` | Derivado — lo escribe este comando |
| `index.md` (agrupamiento por parcial) | Derivado — lo reagrupa este comando |
| `wiki/parciales_analizados/*`, `wiki/transcripciones/*` | **Historico — NO TOCAR JAMAS** |
| `apariciones_en_parciales:` en `tipos_ejercicio/` | **Historico — NO TOCAR JAMAS** |
| Nombres de archivo en `raw/` | **Inmutable — NO RENOMBRAR JAMAS** |

## Workflow

### Paso 1 — Leer el programa

Leer `programa.md`. Extraer el bloque YAML **Mapa tema → parcial** y el campo `vigencia`.
Leer tambien el **Historial de programas** para conocer el reparto anterior y poder calcular
el diff (que temas se movieron y en que direccion).

### Paso 2 — Propagar frontmatter

Para cada `.md` en `wiki/temas/` y `wiki/tipos_ejercicio/`:

1. Leer su campo `tema:`
2. Buscar ese tema en el mapa. Si no esta → **reportar como error, no adivinar**
3. Escribir `parcial: <valor del mapa>` y, inmediatamente debajo, `programa: <vigencia>`
4. Registrar los que cambiaron de valor

### Paso 3 — Avisos de reubicacion en `tipos_ejercicio/`

Para cada patron cuyo `parcial:` vigente difiera del rotulo mayoritario de sus
`apariciones_en_parciales:`, insertar (o actualizar) este bloque justo debajo del encabezado
`## Apariciones en parciales`:

```markdown
> ⚠️ **Reubicado por el programa vigente (<vigencia>).** <Tema> era **<parcial viejo>** en el
> programa viejo, asi que los rotulos `1P`/`2P` de la lista de abajo corresponden a **como se
> tomaba antes**.
> Con el programa vigente este patron es material de tu **<parcial nuevo>**.
> Los ejercicios siguen siendo validos; lo unico que cambio es en que parcial te los toman.
> Ver [[programa]].
```

Si un patron **dejo** de estar reubicado, borrar su aviso.

### Paso 4 — Prosa desactualizada

Buscar en `wiki/temas/` menciones en el cuerpo del tipo `"es tema 2P"`, `"evaluado en 1P"`,
`"patron de 2P"` que contradigan el programa vigente. Reescribirlas separando los dos hechos:

> 🔴 Si — <descripcion>; aparece en parciales historicos rotulados <viejo>, con el programa
> vigente entra en tu **<nuevo>**

**No** tocar las banderas 🔴/⚪ en si — siguen siendo validas, solo cambia el parcial.

### Paso 5 — Reagrupar `index.md`

Reescribir `index.md` agrupando las paginas por el parcial vigente, conservando **textual** la
descripcion de cada bullet. Secciones: Transversales → 1P → 2P → Tipos de ejercicio (subdivididos
en "Van en tu 1P" / "Van en tu 2P") → Parciales analizados (marcados como programa viejo) →
Sintesis. Aviso arriba de todo si el programa cambio respecto de los parciales historicos.

### Paso 6 — Sintesis y repasos

Las paginas `sintesis/repaso_*` preparaban un parcial bajo el programa viejo. Verificar que
lleven `parcial: historico_<rotulo>`, `programa: historico_hasta_<vigencia anterior>` y el aviso
de material desactualizado. Actualizar el texto del aviso con el diff nuevo.

### Paso 7 — Actualizar `CLAUDE.md` de la materia

Refrescar la tabla resumen de "Temas por parcial" y el diff de reubicaciones. La tabla del
`CLAUDE.md` es un **resumen legible**, no la fuente de verdad — debe apuntar a `programa.md`.

### Paso 8 — Log

Agregar entrada a `log.md`:

```markdown
## [FECHA] programa | <vigencia>
Cambio de reparto: [lista de temas movidos con direccion]
Paginas actualizadas: N en temas/, M en tipos_ejercicio/
Avisos de reubicacion: [lista]
index.md reagrupado. No se modifico raw/, parciales_analizados/ ni transcripciones/.
```

## Output

```
## Propagacion del programa <vigencia>

### Movimientos
| Tema | Antes | Ahora |
|---|---|---|

### Paginas actualizadas
- temas/: N (X cambiaron de parcial)
- tipos_ejercicio/: M (Y cambiaron, Z con aviso de reubicacion)

### Prosa reescrita
- [archivo:linea] — [antes] → [despues]

### Sin tocar (correcto)
- raw/, parciales_analizados/, transcripciones/, apariciones_en_parciales

### Requiere tu atencion
- [temas sin mapear, contradicciones, prosa ambigua que no me anime a reescribir]
```

## Modo `--check`

Con `--check`, no escribir nada: solo reportar que paginas estan desincronizadas respecto de
`programa.md`. Util para correr dentro de `/lint`.
