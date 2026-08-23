Ingestar un PDF al wiki. Argumento: $ARGUMENTS (ruta al PDF relativa a la materia, ej: raw/clases/teo/1.teo_1P_divide_&_conquer.pdf, o raw/cursada_2C_2026/teo/03_grafos.pdf)

## Regla previa — `programa.md` es la fuente de verdad del mapeo tema→parcial

Leer `programa.md` del working directory antes de asignar cualquier `parcial:`.
**Nunca** inferir el parcial desde el nombre del archivo en `raw/` ni desde el rotulo del
examen historico en que aparecio un ejercicio: esos rotulos reflejan el programa del
cuatrimestre en que se dicto/tomo el material, que puede diferir del vigente.
Todo frontmatter generado lleva `parcial:` (derivado) + `programa:` (version que refleja).

## Deteccion de modo

El comando tiene dos modos y los distingue **por la ruta del PDF**:

| | Modo CREAR | Modo RECONCILIACION |
|---|---|---|
| **Ruta** | Cualquier ruta bajo `raw/` **salvo** `raw/cursada_*/` | `raw/cursada_*/...` |
| **Que es el material** | Historico: cuatrimestres pasados | Cursada vigente: lo que estas cursando ahora |
| **Autoridad** | Base de conocimiento | **Fuente de verdad** — gana ante conflicto |
| **Supuesto** | La pagina no existe → la escribo | La pagina existe → la contrasto |
| **Busca pagina previa del tema** | No | Si, via `programa.md` + `index.md` |
| **Antes de escribir** | Escribe directo | **Muestra el diff y pide aprobacion** |
| **Resultado** | Pagina nueva | Merge + divergencias marcadas + badge + `fuentes` |
| **`estado_verificacion`** | `pendiente_verificacion` | `verificado_<vigencia>` |

Un solo comando, dos comportamientos. El modo que puede destruir trabajo ya verificado es el
unico que pide permiso.

---

# MODO CREAR

Comportamiento por defecto para todo lo que no este bajo `raw/cursada_*/`.

## Workflow — modo crear

1. **Verificar log.md** — si el archivo ya fue ingestado, informar y abortar
2. **Detectar tipo de PDF:**

   **2a. VERIFICAR QUE EL EXTRACTOR EXISTA — antes de interpretar cualquier resultado:**
   ```bash
   command -v pdftotext pdfinfo || echo "FALTA poppler"
   ```
   Si falta, **ABORTAR RUIDOSAMENTE**. No seguir. Un binario ausente devuelve 0 caracteres, y
   0 < 500, asi que la regla del umbral concluye "fotografiado" y manda a vision: **la ausencia
   de la herramienta es indistinguible de un PDF escaneado**, y el fallo empuja hacia la rama
   cara y peor. Esto ya paso una vez sobre un deck de 160 paginas con 88k de texto limpio.
   El tool `Read` con `pages` **no** sirve de fallback: depende de `pdftoppm`, mismo paquete.

   Instalar: `sudo apt-get install -y poppler-utils` (Debian/Ubuntu/WSL).
   Alternativa sin sudo: PyMuPDF en un venv (`pip install pymupdf`), extraer con
   `page.get_text()`. Sirve tambien para contar paginas (`doc.page_count`).

   **2b. Contar paginas:** `pdfinfo "$ARGUMENTS" | grep Pages`. **No usar `file`** para esto:
   reporta el `/Count` del primer nodo del arbol de paginas, que en un Beamer puede ser un
   subarbol — reporto "6 pages" sobre un PDF de 160.

   **2c. Recien ahora aplicar el umbral:**
   - `pdftotext "$ARGUMENTS" -` y contar caracteres
   - > 500 chars → PDF digital
   - < 500 chars para un documento > 3 paginas → PDF fotografiado (Claude vision)
3. **Si es parcial fotografiado:** crear `wiki/transcripciones/[id]_raw.md` con transcripcion fiel via Claude vision antes de sintetizar
4. **Crear/actualizar paginas wiki** segun tipo de documento:
   - **Parcial:** crear `wiki/parciales_analizados/[id].md` con frontmatter + enunciado + resolucion + explicacion + analisis + chuleta por ejercicio
   - **Clase teorica:** crear `wiki/temas/[tema]_teoria.md` — extraccion fiel y estructurada, sin simplificar. Si es demo (ej: demo_mochila): integrar en la pagina de teoria del tema correspondiente
   - **Clase practica:** crear `wiki/temas/[tema]_practica.md` — ejercicios con enunciado, explicacion, resolucion paso a paso, chuleta, bandera parcial
   - **Guia (Fase 1 SOLAMENTE):** crear `wiki/temas/[tema]_guia.md` — extraer enunciados, escribir explicacion, cruzar con parciales para bandera. Dejar Resolucion y Chuleta como `[PENDIENTE — sesion de resolucion]`. Si cubre multiples temas, distribuir ejercicios a la pagina de guia de cada tema
   - **Contenido comunidad:** integrar en paginas existentes del tema correspondiente
5. **Actualizar index.md** — agregar la pagina al catalogo bajo el encabezado del tema correspondiente
6. **Actualizar log.md** — agregar entrada: `## [FECHA] ingest | [nombre_archivo]` con paginas creadas/actualizadas y temas identificados

---

# MODO RECONCILIACION

Se activa cuando la ruta cae bajo `raw/cursada_*/`. El material de la cursada vigente es la
**fuente de verdad**: ante conflicto con el contenido historico, gana lo vigente.

## Workflow — modo reconciliacion

### Paso 1 — Extraer el PDF primero

**Contra-intuitivo pero necesario:** no se puede ubicar la pagina destino sin saber de que trata
el PDF. `programa.md` mapea temas→parcial, no archivos→tema. Los archivos historicos traian el
tema en el nombre (`5.teo_1P_definicion_demo.pdf`); los de la cursada no necesariamente
(`teo_clase1_demostraciones.pdf` — `clase1` no es un tema del wiki).

Extraer segun el Paso 2 del modo CREAR, **incluido el chequeo 2a de que el extractor exista**
(abortar ruidosamente si falta poppler, nunca interpretar su ausencia como una propiedad del PDF)
y el conteo de paginas con `pdfinfo`, no con `file`. Consolidar builds Beamer antes de seguir.

### Paso 2 — Ubicar la pagina canonica

Con el tema ya identificado del contenido:

1. Leer `programa.md` → confirmar que el tema existe en el mapa y con que `parcial` quedo
2. Leer `index.md` → ubicar la(s) pagina(s) de ese tema
3. Si el tema **no tiene pagina**, no hay nada que reconciliar: caer a modo CREAR y decirlo

**Un PDF puede cubrir mas de un tema.** Reconciliacion procesa **una pagina canonica por corrida**:
elegir la pagina del tema dominante, y **reportar** los otros temas al final para una corrida
aparte — sin tocarlos. Guardar el texto ya extraido y consolidado en
`.ingestas_pendientes/<archivo>.texto_consolidado.txt` para que la segunda corrida no tenga que
releer el PDF entero.

### Paso 3 — Leer la pagina existente

Leer completa la pagina canonica del tema. No diffear contra un resumen: el matching necesita
el texto real.

### Paso 4 — Diffear

Clasificar **cada bloque** de contenido en una de cuatro categorias:

| Clasificacion | Significa | Accion al escribir |
|---|---|---|
| `identico` | El material nuevo dice lo mismo | Nada. Solo confirma la verificacion |
| `nuevo` | Contenido que no estaba en la wiki | Agregar a la pagina |
| `divergente` | Dice algo distinto de lo que hay | Reescribir con lo nuevo + bloque 🔄 |
| `no cubierto por este PDF` | Esta en la wiki y el material nuevo simplemente no habla del tema | **Conservar intacto** + marca 📎. **Es el caso por defecto** |
| `ausente en lo nuevo` | Esta en la wiki y el material nuevo **reemplaza integralmente** ese alcance sin incluirlo | Degradar a `solo_historico`. **Nunca borrar** |

> ⚠️ **`ausente en lo nuevo` requiere una precondicion fuerte y casi nunca se cumple.**
> Solo aplica cuando el material vigente es **exhaustivo sobre el tema**: una guia completa que
> reemplaza a la vieja, o una teorica que cubre toda la unidad. **Nunca desde una clase parcial.**
> Una teorica suelta casi nunca cubre todo lo que la pagina acumulo: que la clase 1 no mencione
> "doble implicacion" no significa que la catedra la haya sacado.
> Ante la duda, `no cubierto por este PDF`. Degradar de mas es la falla costosa: hace desaparecer
> material valido del radar del usuario justo cuando esta estudiando.

Para `divergente`, clasificar ademas el tipo: `notacion`, `alcance`, `enfoque de demostracion`
o `contradiccion`.

### Paso 5 — Tabla de correspondencia (solo si es guia)

Ver la seccion "Tabla de correspondencia" mas abajo.

### Paso 6 — GATE DE APROBACION (obligatorio)

**Mostrar el diff completo al usuario y esperar confirmacion explicita antes de escribir nada.**

Este paso **no se saltea nunca**, ni siquiera cuando el diff parece trivial. El modo
reconciliacion sobreescribe contenido que puede haber costado sesiones enteras de trabajo
(resoluciones de ejercicios, demostraciones), y un merge mal hecho es dificil de detectar
despues porque el resultado *parece* correcto.

Formato del gate:

```
## Diff — [nombre del PDF] → [[pagina_canonica]]

### Identico (N bloques)
[lista breve, una linea por bloque]

### Nuevo (N bloques)
[que se agregaria, con el contenido]

### Divergente (N bloques)  ⚠️ revisar con atencion
| Bloque | Antes (wiki) | Ahora (cursada) | Tipo |
|---|---|---|---|

### Ausente en lo nuevo (N bloques)
[que pasaria a solo_historico]

### Contenido que parece pertenecer a otra pagina
[ver "Contenido que cambia de pagina"]

¿Aplico estos cambios?
```

### Paso 6b — Persistir el diff

Antes de esperar la aprobacion, **guardar el diff calculado** en
`.ingestas_pendientes/<nombre_archivo>.diff.md`, junto con el texto consolidado en
`.ingestas_pendientes/<nombre_archivo>.texto_consolidado.txt`.

Motivo: el analisis (extraer, consolidar, diffear) es la parte cara. Si el diff vive solo en la
conversacion, quien apruebe tiene que rederivarlo desde cero. Persistirlo hace el gate
**componible** en vez de bloqueante: permite aprobar mas tarde, en otra sesion, o delegar la
escritura a otro agente. Es tambien lo que habilita correr el analisis de forma no interactiva.

Al terminar el Paso 8, borrar ambos archivos.

### Paso 7 — Escribir

Recien con la aprobacion:

- Mergear el contenido en la pagina canonica
- Insertar los bloques 🔄 en cada divergencia
- Marcar como `solo_historico` lo ausente en lo nuevo
- Escribir/actualizar `fuentes` y `estado_verificacion` en el frontmatter
- Poner el badge de autoridad arriba de la pagina
- Si es guia: escribir la seccion `## Correspondencia con la guia anterior`

### Paso 8 — Actualizar index.md y log.md

En reconciliacion la pagina **ya esta** en el catalogo, asi que no se agrega: se **actualiza** su
linea. Cada linea de `index.md` cierra citando su PDF fuente — sumar el vigente junto al historico
y refrescar el resumen de contenidos con lo que aporto el merge.


En `log.md`, la entrada del modo reconciliacion registra el diff aplicado:

```markdown
## [FECHA] reconciliacion | [nombre_archivo]
Pagina canonica: [[pagina]]
Bloques: N identicos, N nuevos, N divergentes, N degradados a solo_historico
Divergencias: [lista con tipo]
estado_verificacion: pendiente_verificacion → verificado_<vigencia>
```

## Frontmatter de procedencia

Ademas del frontmatter obligatorio de siempre, el modo reconciliacion escribe:

```yaml
fuentes:
  vigente:
    - raw/cursada_2C_2026/teo/03_grafos.pdf
  historico:
    - raw/clases/teo/6.teo_2P_grafos.pdf
estado_verificacion: verificado_2C_2026
```

Valores de `estado_verificacion`:

| Valor | Significa |
|---|---|
| `verificado_<vigencia>` | El material de la cursada vigente paso por aca. Es lo que se dicta hoy |
| `pendiente_verificacion` | Solo tiene material historico. Todavia no se contrasto |
| `solo_historico` | Contenido que ya no se dicta. Se conserva, no se estudia |

`fuentes.historico` **acumula**, no se reemplaza: la pagina conserva la traza de todos los PDFs
que la alimentaron.

## Badge de autoridad

Va inmediatamente despues del frontmatter, antes del primer encabezado.

Verificado:

```markdown
> ✅ Verificado contra la cursada 2C-2026 · fuente: raw/cursada_2C_2026/teo/03_grafos.pdf
```

Verificado parcialmente (el caso mas comun tras un merge — ver "Verificacion por bloque"):

```markdown
> 🟡 **Verificado parcialmente contra la cursada 2C-2026** · fuente: raw/cursada_2C_2026/teo/03_grafos.pdf
> Los bloques marcados con 📎 siguen sin contrastar.
```

Pendiente:

```markdown
> ⚠️ Contenido de cuatrimestres anteriores, sin contrastar con la cursada actual.
```

El badge se reemplaza, no se acumula. Una pagina tiene exactamente uno, y **debe** coincidir con
el `estado_verificacion` del frontmatter.

## Verificacion por bloque

Un merge produce paginas **mixtas**: bloques contrastados contra la cursada vigente conviviendo
con bloques historicos que el material nuevo no toco. Un `estado_verificacion` booleano a nivel
pagina promete mas de lo que el merge entrega.

Por eso la verificacion se marca en dos niveles, igual que las divergencias:

| Nivel | Marca |
|---|---|
| Pagina — todo contrastado | `estado_verificacion: verificado_<vigencia>` + badge ✅ |
| Pagina — parcialmente contrastada | `estado_verificacion: verificado_parcial_<vigencia>` + badge 🟡 |
| Pagina — nada contrastado | `estado_verificacion: pendiente_verificacion` + badge ⚠️ |
| Bloque `no cubierto por este PDF` | marca 📎 inline, al inicio del bloque |

Badge de pagina parcialmente verificada:

```markdown
> 🟡 **Verificado parcialmente contra la cursada 2C-2026** · fuente: <ruta>
> Los bloques marcados con 📎 siguen sin contrastar.
```

Marca de bloque:

```markdown
> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el
> material vigente ingestado hasta ahora no lo cubre.
```

Cuando una ingesta posterior cubra un bloque 📎, se le saca la marca. Cuando no quede ninguna,
la pagina pasa de `verificado_parcial_<vigencia>` a `verificado_<vigencia>` y el badge a ✅.

## Bloque de divergencia

Se inserta **inline**, en el lugar del contenido que cambio:

```markdown
> 🔄 **Cambio respecto de cuatrimestres anteriores**
> **Ahora (2C-2026):** ...
> **Antes:** ...
> **Tipo:** notacion | alcance | enfoque de demostracion | contradiccion
> Fuente: raw/cursada_2C_2026/teo/03_grafos.pdf
```

No es ceremonia: el material historico es el que tiene los ejercicios resueltos. Si cambio la
notacion, el bloque es el puente para poder leer las resoluciones viejas.

## Tabla de correspondencia (guias)

Cuando el PDF es una guia practica de la cursada vigente, los ejercicios casi nunca coinciden en
numeracion con los de la guia historica. **El matching es por enunciado, no por numero.**

**La numeracion nueva es la canonica** — es la guia que el usuario va a tener abierta al estudiar.
La numeracion vieja queda registrada en la tabla.

Cuatro casos:

| Caso | Como se detecta | Accion |
|---|---|---|
| `identico` | Mismo enunciado, aunque con otro numero | Conservar la resolucion existente. Adoptar el numero nuevo |
| `modificado` | Mismo ejercicio con cambios (constantes, incisos agregados, alcance) | Conservar la resolucion, marcada con `⚠️ Resolucion heredada — enunciado modificado, revisar` |
| `nuevo` | Sin contraparte en la guia historica | Fase 1: enunciado + explicacion + bandera. Resolucion y Chuleta como `[PENDIENTE — sesion de resolucion]` |
| `eliminado` | Estaba en la guia historica, no esta en la nueva | Conservar el ejercicio, degradar a `solo_historico`. **Nunca borrar** |

El caso `modificado` es el peligroso: una resolucion sutilmente desactualizada es **peor que no
tenerla**, porque el usuario le cree. De ahi la marca explicita, que reusa la convencion `⚠️` ya
existente en el wiki.

La tabla se muestra en el gate de aprobacion y, una vez aprobada, se **guarda** al final del
`_guia.md`:

```markdown
## Correspondencia con la guia anterior

> Guia vigente: `raw/cursada_2C_2026/guias/...` · Guia historica: `raw/guias_practicas/...`
> La numeracion de esta pagina es la de la guia vigente.

| Guia nueva | Guia vieja | Match | Accion |
|---|---|---|---|
| Ej. 1 MergeSort | Ej. 1 | identico | resolucion conservada |
| Ej. 5 MaximoMontana | Ej. 6 | identico, renumerado | resolucion conservada |
| Ej. 7 ComplexityQuest | Ej. 7 | modificado (12→15 recurrencias) | resolucion conservada + 3 PENDIENTE |
| Ej. 12 NuevoEjercicio | — | nuevo | Fase 1, resolucion PENDIENTE |
| — | Ej. 16 L-Tetris | eliminado | solo_historico |
```

Se guarda y no se descarta porque mas adelante, al ver una resolucion que habla del "ejercicio 6"
dentro del ejercicio 5, hay que poder reconstruir por que.

## Contenido que el PDF difiere explicitamente

Frecuente en catedras que trabajan en pizarron: la slide enuncia el problema y dice
*"→ Demostracion completa en el pizarron"*, dando el **plan** (que es $P(n)$, cuantos casos base,
donde entra la HI) pero no la prueba.

Regla:

1. Se clasifica como **`nuevo`** — el plan es contenido real y valioso
2. Se escribe el plan tal cual, **sin inventar la demostracion completa**
3. Lleva `> ⚠️ Verificar — el PDF solo da el plan; la demostracion completa se hizo en el pizarron.`
4. Si la pagina **ya tenia** una demostracion completa de ese mismo enunciado, se conserva como
   cuerpo y el plan nuevo va arriba: dice como la catedra vigente estructura la prueba
5. Si el plan nuevo **contradice** la estructura de la demo vieja, es `divergente` → bloque 🔄

Nunca reconstruir una demostracion y presentarla como material de catedra.

## Cross-references tras renumerar

`tipos_ejercicio/` y `parciales_analizados/` citan ejercicios mayormente **por nombre**
("MergeSort", "MaximoMontana"), asi que la renumeracion los rompe poco. Igualmente:
revisar y re-apuntar los que citen **por numero**.

## Contenido que cambia de pagina

Si el contenido nuevo pertenece a **otra** pagina del wiki — la catedra movio un tema entre
unidades, como ya paso con el reparto de parciales — **reportarlo y preguntar**.

**Nunca mover bloques entre paginas por cuenta propia.** Mover contenido rompe links entrantes,
banderas y correspondencias de ejercicios; es una decision del usuario, no del comando.

## Banderas — el principio no cambia

Las banderas `🔴 Si → [[tipos_ejercicio/X]]` / `⚪ No` siguen saliendo de
`wiki/parciales_analizados/` y `wiki/tipos_ejercicio/` **exactamente como hasta ahora**. Los
parciales historicos siguen siendo la base de que ejercicios y temas son importantes: los
contenidos son los mismos, solo cambio el reparto por parcial.

- **No** inventar sistemas de senal paralelos ni banderas duales.
- Los ejercicios `nuevo` de una guia vigente reciben su bandera cruzandolos contra los patrones
  de `tipos_ejercicio/`, no contra un enunciado historico exacto. Un ejercicio nuevo de
  recurrencias es `🔴 Si → [[tipos_ejercicio/dc_teorema_maestro]]` aunque ese enunciado puntual
  nunca se haya tomado.
- Los `⋆` de las guias se extraen como **contenido de la guia**, igual que hoy. No son una
  segunda fuente de autoridad.

---

# COMUN A AMBOS MODOS

## Observacion critica sobre Beamer

Los PDFs de clases (teo y prac) son LaTeX Beamer. Cada "build" incremental ocupa una pagina PDF
separada. NO tratar cada pagina como contenido distinto — consolidar los builds en una sola
version final de cada elemento. Senal: bloques de texto casi identicos con pequenas adiciones al final.

En modo reconciliacion esto importa el doble: builds sin consolidar generan decenas de falsos
`divergente` en el diff.

### Procedimiento concreto

Estos decks imprimen el numero de slide logica en el pie de cada pagina, con formato `N / M`
(ej: `12 / 36`). Eso vuelve la consolidacion determinista:

1. Extraer el texto pagina por pagina
2. Parsear el pie para obtener `N` (slide logica) y `M` (total logico)
3. Agrupar las paginas por `N`
4. De cada grupo, **quedarse con el build mas largo** — es el ultimo, el que tiene todo

En el caso real: 160 paginas PDF → 36 slides logicas. Sin consolidar, el diff es basura.

Si el deck no imprime `N / M`, la senal de respaldo es textual: bloques casi identicos donde
cada uno agrega texto al final del anterior. Agrupar por prefijo comun y quedarse con el mas largo.

**No consolidar a ojo** cuando hay decenas de bloques distintos: ahi es donde se pierde contenido.


## Frontmatter obligatorio

Todas las paginas deben incluir frontmatter YAML con: nombre, parcial, programa, tipo, tema,
`fuentes` (plural, estructurado en `vigente` / `historico`), `estado_verificacion`,
paginas_relacionadas.
`parcial` se deriva de `programa.md` (nunca del nombre del PDF); `programa` es la version vigente
que refleja ese valor.

El campo singular `fuente:` es del esquema viejo y ya no se usa: las 34 paginas de `wiki/temas/`
estan migradas a `fuentes`.

## Convenciones

- Idioma: espanol (nombres tecnicos en ingles si asi aparecen en las clases)
- Links internos: sintaxis Obsidian `[[nombre_pagina]]`
- Citas a fuentes: path relativo desde raiz de materia
- Formulas: preservar en LaTeX ($...$ inline, $$...$$ bloque). Nunca parafrasear formulas a texto plano.
- Nomenclatura de archivos: snake_case
- `raw/` es **inmutable** en ambos modos: nunca renombrar ni editar los PDFs originales
