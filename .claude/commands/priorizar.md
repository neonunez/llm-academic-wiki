Analizar un PDF de la cursada actual contra los parciales ya ingestados y decir a que prestarle atencion. NO ingesta. Argumento: $ARGUMENTS (ruta a un PDF, dentro o fuera del repo, ej: raw/cursada_2C_2026/teo/clase1.pdf o ~/Downloads/guia5.pdf). Flag opcional: --dry (no guardar el informe)

## Regla previa — `programa.md` es la fuente de verdad del mapeo tema→parcial

Leer `programa.md` del working directory antes de asignar cualquier `parcial:`.
**Nunca** inferir el parcial desde el nombre del archivo en `raw/` ni desde el rotulo del
examen historico en que aparecio un ejercicio: esos rotulos reflejan el programa del
cuatrimestre en que se dicto/tomo el material, que puede diferir del vigente.

Si `programa.md` no existe, **abortar** e indicar que hay que crearlo. Sin el, este comando
no puede decir para que parcial hay que estudiar lo que analiza — que es justamente su trabajo.

---

## Que hace

Toma un documento que te dieron en la cursada (teorica, practica o guia) y lo **proyecta sobre
el indice de lo que la catedra evalua**, construido a partir de los parciales ya ingestados.
Devuelve una lista priorizada: que de ese PDF es material de parcial casi seguro, que es
contexto, y que hay que estudiar que ese PDF **no** cubre.

## Que NO hace — contrato de no-ingesta

Este comando es de **analisis**, no de ingesta. El PDF que recibe **no** entra a la base de
conocimiento. Explicitamente:

- ❌ No copia ni mueve el PDF a `raw/`
- ❌ No crea ni modifica nada en `wiki/temas/`
- ❌ No toca `index.md`
- ❌ No toca las banderas `¿Aparece en parciales?` de `_practica.md` / `_guia.md`
- ❌ No crea paginas en `wiki/tipos_ejercicio/` ni `wiki/parciales_analizados/`
- ❌ No marca nada como `verificado_<vigencia>`
- ❌ No commitea

Lo unico que escribe es su propio informe en `cursada_actual/` (ver Paso 8), que **no es wiki
compilado**: es una nota de trabajo, desechable y regenerable.

Si el documento merece entrar a la base de conocimiento, eso es `/ingestar` — otro comando,
otra decision, y el usuario la toma aparte.

## Precondiciones

| Necesita | Si falta |
|---|---|
| `programa.md` en el working directory | **Abortar** — ver Regla previa |
| `wiki/parciales_analizados/` no vacio | **Abortar** — sin parciales no hay contra que comparar. Correr `/ingestar_batch raw/parciales/` primero |
| `wiki/tipos_ejercicio/` poblado | Degradar: leer `parciales_analizados/` directo (mas lento, mismo resultado) y avisar que conviene correr `/tipos_ejercicio_scan` + `/tipos_ejercicio_run` para que las proximas corridas sean baratas |
| `wiki/sintesis/patrones_detectados.md` | Opcional. Si esta, da frecuencias y cross-parcial ya calculados |

---

## Paso 1 — Extraer el texto del PDF

Mismo protocolo que `/ingestar`. No improvisar otro.

**1a. Verificar que el extractor exista — antes de interpretar cualquier resultado:**
```bash
command -v pdftotext pdfinfo || echo "FALTA poppler"
```
Si falta, **ABORTAR RUIDOSAMENTE**. Un binario ausente devuelve 0 caracteres, y 0 < 500, asi
que la regla del umbral concluye "fotografiado" y manda a vision: **la ausencia de la
herramienta es indistinguible de un PDF escaneado**. Instalar: `sudo apt-get install -y
poppler-utils`.

**1b. Contar paginas:** `pdfinfo "<ruta>" | grep Pages`. **No usar `file`** para esto.

**1c. Aplicar el umbral:**
- `pdftotext "<ruta>" -` y contar caracteres
- \> 500 chars → PDF digital, usar el texto
- < 500 chars para un documento > 3 paginas → PDF fotografiado → Claude vision

**1d. No escribir transcripcion.** A diferencia de `/ingestar`, no se crea
`wiki/transcripciones/`. El texto extraido vive solo en esta sesion.

La ruta puede estar **fuera del repo** (`~/Downloads/...`). Es el caso esperado: material que
te acaban de dar y todavia no decidiste ingestar.

## Paso 2 — Clasificar y segmentar el documento

**Clasificar por contenido, no por carpeta.** Un PDF en `teo/` puede ser una guia.

| Tipo | Señales | Unidad de analisis |
|---|---|---|
| Clase teorica | definiciones, teoremas, demostraciones, diapos | cada definicion / teorema / demo / tecnica |
| Clase practica | ejercicios ya resueltos, ejemplos guiados | cada ejercicio resuelto |
| Guia | ejercicios numerados sin resolver, consignas | cada ejercicio (respetar la numeracion original) |

Partir el documento en **unidades** y darle a cada una un identificador estable y rastreable:
el numero de ejercicio de la guia, o `§seccion` + rango de diapositivas. El usuario tiene que
poder abrir el PDF y encontrar exactamente lo que el informe le señala.

## Paso 3 — Mapear tema(s) y parcial

1. Identificar el o los `tema` internos del wiki que cubre el documento, cruzando contra
   `index.md` y el `CLAUDE.md` de la materia (nomenclatura de temas de esa materia).
2. Derivar el `parcial` de cada tema **desde `programa.md`**, nunca del nombre del PDF.
3. Si el documento cubre varios temas que caen en parciales distintos, decirlo arriba del
   informe y agrupar las unidades por tema.

   **Esquema de parcial unico.** Si el frontmatter de `programa.md` declara
   `esquema_evaluacion: parcial_unico` (hoy: Sistemas Digitales), el rotulo `1P` significa
   "el unico parcial" y **no** existe un 2P. En ese caso:
   - No agrupar por parcial: todo el temario entra en el mismo examen.
   - Los `parciales_analizados/` rotulados `1P` y `2P` son **ambos** base de comparacion
     valida — el corte viejo ya no aplica.
   - Escribir en la cabecera del informe la advertencia de que ningun parcial historico
     sirve como simulacro completo, con la fraccion del temario que cubria.
4. Si ningun tema del wiki matchea, **no forzar el match**: reportarlo como
   `🆕 tema no cubierto por la wiki` y seguir (ver Paso 5, regla del contenido sin precedente).

## Paso 4 — Cargar el indice de lo evaluable

**No releer todos los parciales.** La capa derivada ya existe y es exactamente este indice:

1. Leer **todas** las paginas de `wiki/tipos_ejercicio/` cuyo `tema` matchee el del documento.
   Cada una trae `## Como reconocer este patron` (las señales de enunciado) y
   `apariciones_en_parciales`. Eso es el material de cruce.

   **Si el filtro por `tema` no devuelve nada, NO concluir que no hay patrones.** El campo
   `tema:` falta en el frontmatter de `tipos_ejercicio/` de algunas materias (hoy: las 23
   paginas de PLP no lo tienen). Cascada de fallback, en orden:
   1. Matchear por **prefijo del nombre de archivo** (`haskell_*`, `lambda_*`, `prolog_*`,
      `resolucion_*` — la convencion de nombres ya codifica el tema)
   2. Matchear por el campo **`Tema:`** de `wiki/sintesis/patrones_detectados.md`
   3. Ultimo recurso: leer el `## Como reconocer este patron` de **todas** las paginas de
      `tipos_ejercicio/` de la materia y filtrar por contenido

   Al final del informe, avisar que el filtro barato fallo y sugerir correr `/programa` para
   normalizar el `tema:` de esas paginas.
2. Si existe `wiki/sintesis/patrones_detectados.md`, leerlo para frecuencias y `cross_parcial`.
3. **Drill-down selectivo:** abrir de `wiki/parciales_analizados/` **solo** los que aparezcan
   en las `apariciones_en_parciales` de los patrones que matchearon, para citar el enunciado
   real como evidencia. No abrir los demas.

4. **Chequeo de cobertura del indice.** Antes de cruzar, comparar los temas que declaran los
   `parciales_analizados/` del parcial correspondiente contra los temas que tienen al menos un
   `tipos_ejercicio/`. Si un tema fue evaluado pero no tiene ningun patron, el indice tiene un
   **hueco** para ese tema (hoy: `arquitectura` en Sistemas Digitales, evaluado en los 3
   parciales de 2P y sin ninguna pagina en `tipos_ejercicio/`).

   Con un hueco, para ese tema el cruce se hace **leyendo los `parciales_analizados/`
   directamente**, y el informe lo declara arriba:

   > ⚠️ Base parcial: el tema `<tema>` no tiene patrones en `tipos_ejercicio/`. El cruce para
   > ese tema se hizo contra los parciales crudos. Correr `/tipos_ejercicio_scan` para cerrarlo.

   Nunca reportar 🆕 "sin precedente" por un hueco del indice. Sin patron no significa sin
   aparicion — significa que nadie compilo el patron todavia. Confundir las dos cosas es el
   peor error que puede cometer este comando: manda a saltear justo lo que si toman.

## Paso 5 — Cruzar cada unidad y asignar prioridad

Para cada unidad del Paso 2, buscar el patron de `tipos_ejercicio/` que la reconoce (usando la
seccion `Como reconocer este patron`) y asignar:

| Nivel | Criterio |
|---|---|
| 🔴 **Critico** | El patron tiene **≥2 apariciones en parciales distintos** |
| 🟡 **Probable** | 1 aparicion, o es variante adyacente de un patron con apariciones |
| ⚪ **Contexto** | Sin aparicion propia, pero es prerequisito de una unidad 🔴/🟡 del mismo documento |
| 🆕 **Sin precedente** | No matchea ningun patron ni aparece en ningun parcial |

**Regla del contenido sin precedente.** 🆕 no significa "ignoralo". Significa dos cosas
distintas que hay que separar explicitamente en el informe:

- Si `programa.md` marca el tema como **nuevo o reubicado** en la vigencia actual, si el tema
  figura en los **huecos de cobertura** que declara `programa.md`, o si el PDF viene de
  `raw/cursada_*/` → **subir a 🟡**. El material de la cursada vigente es fuente de autoridad;
  "nunca lo tomaron" puede significar "todavia no". Caso testigo: el temario vigente de
  Sistemas Digitales lista punto fijo y flotante, restadores y comparadores, y ningun parcial
  historico los tomo — porque son de un esquema de evaluacion que ya no existe.
- Si el tema es viejo y estable y aun asi nunca se tomo → dejar en 🆕 y decir que es relleno
  teorico con baja probabilidad.

**Modificador de recencia.** Si todas las apariciones de un patron son de los cuatrimestres mas
viejos disponibles y los parciales recientes lo reemplazaron por otro patron del mismo bloque,
anotar **"en baja"** junto al nivel y explicar la sustitucion. No bajar el nivel — la
frecuencia es la frecuencia — pero el usuario tiene que ver la tendencia.
(Caso testigo: en PLP el Ej 3 del 2P paso de Smalltalk a Inferencia de Tipos desde 2C 2024.
**Los dos bloques siguen en el listado oficial de la catedra** — "en baja" describe la tendencia
de lo que se tomo, nunca que el tema haya salido del programa. Solo `programa.md` decide eso.)

**Para cada unidad, el informe debe decir cuatro cosas:**
1. El nivel y la evidencia que lo sostiene (cuantas apariciones, en cuales)
2. El link al `tipos_ejercicio/` y a los `parciales_analizados/` concretos
3. **En que forma te lo piden** — sacado del `Template de resolucion` del patron. Esto es lo
   que convierte el informe en algo accionable: no "estudia flags de ALU" sino "te dan hex de
   8 bits, truncas a 4 y completas la tabla CVZN para tres operaciones".
4. Si es una guia: **hacer / saltear**, y por que

## Paso 6 — Cruce inverso: que falta

Listar los patrones de `tipos_ejercicio/` del mismo tema y parcial que **no** estan cubiertos
por ninguna unidad del documento. Para cada uno: nombre, apariciones, y en que pagina del wiki
esta el material (`temas/<tema>_teoria`, `_practica`, `_guia`).

Este bloque es la mitad del valor del comando. Un teorico puede estar perfectamente alineado
con el parcial y aun asi dejar afuera el ejercicio que mas veces tomaron.

## Paso 7 — Emitir el informe

Formato fijo. Los conteos van con su fuente al lado; nada de porcentajes inventados.

```markdown
# Prioridades — <nombre del PDF>

**Tipo:** clase teorica | clase practica | guia
**Tema(s):** <tema> → **<1P|2P|ambos>** (programa <vigencia>)
**Cobertura:** toca N de los M patrones historicos del tema
**Base de comparacion:** K parciales analizados, P patrones en tipos_ejercicio/

## 🔴 Critico — esto lo toman

### <unidad> (<ubicacion en el PDF>)
- **Evidencia:** N apariciones → [[tipos_ejercicio/<patron>]]
- **Te lo piden asi:** <forma concreta, del Template de resolucion>
- **Ver:** [[parciales_analizados/<id>]] Ej N

## 🟡 Probable

<misma estructura>

## ⚪ Contexto — leer, no memorizar

<lista breve, una linea por unidad, diciendo a que 🔴 le da soporte>

## 🆕 Sin precedente en parciales

### <unidad>
- Sin apariciones en los K parciales analizados.
- **Lectura:** <tema nuevo/reubicado del programa vigente → tratar como 🟡>
  | <tema viejo y estable, nunca tomado → relleno teorico>

## ⚠️ Lo que NO cubre este PDF pero si toman

- [[tipos_ejercicio/<patron>]] — N apariciones. Material en [[temas/<tema>_teoria]]

## Plan

<3 a 6 pasos concretos y ordenados>
```

**Si el documento es una guia**, el bloque `## Plan` se reemplaza por:

```markdown
## Plan de ejercicios

**Hacer si o si (N):** Ej 3, 7, 12 — cada uno con el patron que entrena
**Hacer si sobra tiempo (N):** Ej 1, 5
**Saltear (N):** Ej 2, 4, 9 — y por que (patron sin apariciones / duplica a otro / fuera de programa)
**Orden sugerido:** <secuencia, con el criterio: de mas tomado a menos, o por dependencia>
```

## Paso 8 — Guardar el informe

Salvo que se haya pasado `--dry`:

```bash
mkdir -p cursada_actual
```

Escribir `cursada_actual/<slug_del_pdf>.md` con el informe del Paso 7 precedido de:

```yaml
---
nombre: Prioridades — <nombre del PDF>
tipo: analisis_previo
origen: <ruta del PDF tal como la paso el usuario>
tipo_documento: teorica | practica | guia
temas: [<tema>, ...]
parcial: <1P|2P|ambos>          # derivado de programa.md
programa: <vigencia>
generado: <fecha>
base_comparacion:
  parciales_analizados: K
  tipos_ejercicio: P
ingestado: false                 # este PDF NO entro a la base de conocimiento
---
```

`cursada_actual/` es hermana de `raw/` y `wiki/`, **fuera del wiki compilado**, a proposito:
son notas de trabajo del cuatrimestre en curso, no conocimiento verificado. Se pueden borrar
enteras sin perder nada — se regeneran corriendo el comando de nuevo.

**No** actualizar `index.md`. **No** commitear.

Agregar **una** linea a `log.md`:

```markdown
## [FECHA] analisis | <nombre_archivo.pdf>
Informe: cursada_actual/<slug>.md — N unidades (X criticas, Y probables, Z sin precedente), M patrones no cubiertos. Sin ingesta.
```

---

## Reglas de honestidad

Son la diferencia entre un informe util y uno que da falsa confianza.

1. **Ninguna aparicion sin cita.** Si el informe dice "3 apariciones", tienen que estar los 3
   links a `parciales_analizados/`. Si no se pueden citar, el conteo esta mal.
2. **No inventar patrones.** Solo se cruza contra `tipos_ejercicio/` y `parciales_analizados/`
   que existen en disco. Si algo parece un patron pero no esta en la wiki, va a 🆕 con una
   nota, no a 🔴.
3. **Declarar la base de comparacion arriba.** "K parciales, P patrones". Un informe basado en
   2 parciales no vale lo que uno basado en 11, y el usuario tiene que verlo sin preguntar.
4. **No inflar.** Si el PDF no toca ningun patron conocido, decirlo en una linea y no rellenar
   el informe con secciones vacias.
5. **El PDF no es autoridad sobre el wiki en este comando.** Si el documento contradice una
   pagina del wiki, **reportar la divergencia y no resolverla**: resolverla es reconciliacion,
   y eso es `/ingestar` en modo reconciliacion, que pide aprobacion antes de escribir.

## Relacion con otros comandos

| Comando | Diferencia |
|---|---|
| `/ingestar` (modo reconciliacion) | Tambien lee material de la cursada vigente, pero **escribe wiki** y pide aprobacion. `/priorizar` no escribe wiki nunca. Un PDF puede pasar por los dos: primero `/priorizar` para decidir si vale la pena, despues `/ingestar` si vale |
| `/parcial <1P\|2P>` | Vista de examen sobre **todo el wiki**. `/priorizar` es la misma lente restringida a **un documento entrante** |
| `/chuleta <tema>` | Consolida templates de resolucion ya escritos. `/priorizar` decide **cuales** de esos templates importan para lo que te acaban de dar |
| `/resolver` | Resuelve ejercicios de una pagina de guia **ya ingestada**. `/priorizar` opera sobre un PDF crudo y solo dice cuales resolver |
