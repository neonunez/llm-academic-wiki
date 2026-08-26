---
nombre: Programa vigente — distribucion de temas por parcial
tipo: programa
vigencia: 2C_2026
actualizado: 2026-08-24
origen: oficial
---

# Programa vigente — Paradigmas de Programacion (PLP)

> **Esta es la unica fuente de verdad sobre que tema entra en que parcial.**
> El campo `parcial:` del frontmatter de `wiki/temas/` y `wiki/tipos_ejercicio/` es
> un campo **derivado** de esta tabla. Si cambia el programa, se edita **solo este
> archivo** y se corre `/programa` para propagar.

## Listado oficial de la catedra

Transcripcion textual. **Dos parciales.**

> **Temas a evaluar en el primer parcial**
> Programación funcional (en Haskell)
> Razonamiento ecuacional e inducción estructural
> Deducción natural para lógica proposicional
> Sistemas de tipos y reducción
>
> **Temas a evaluar en el segundo parcial**
> Inferencia y compilación
> Lógica de primer orden
> Resolución lógica
> Programación lógica (en Prolog)
> Programación orientada a objetos (en SmallTalk)

El reparto oficial **coincide** con el de los 11 parciales de `wiki/parciales_analizados/`
(1C 2024 a 2C 2025). El programa se mantuvo estable.

---

## Tabla vigente (2C 2026)

### Primer Parcial (1P)

Los 6 primeros parciales analizados tienen **exactamente la misma forma**: 3 ejercicios.

| Bloque oficial | Tema interno | Paginas | Ej tipico |
|---|---|---|---|
| Programación funcional (en Haskell) | `programacion_funcional` | `programacion_funcional_teoria`, `_practica`, `_guia` | Ej 1 |
| Razonamiento ecuacional e inducción estructural | `demostracion_de_propiedades` | `demostracion_de_propiedades_teoria`, `_practica`, `_guia` | Ej 2a |
| Deducción natural para lógica **proposicional** | `sistemas_deductivos_y_deduccion_natural` | `sistemas_deductivos_y_deduccion_natural_teoria`, `_practica`, `_guia` | Ej 2b |
| Sistemas de tipos y reducción | `calculo_lambda_tipado` | `calculo_lambda_tipado_teoria`, `calculo_lambda_practica`, `calculo_lambda_guia` | Ej 3 |

**Alcance de Programacion Funcional:** esquemas de recursion (`fold`, `rec`) sobre tipos
algebraicos inductivos, currificacion, evaluacion parcial, orden superior.

**Alcance de Deduccion Natural en el 1P: proposicional, y solo proposicional.** El listado
oficial lo acota explicitamente. La DN con cuantificadores es 2P — ver abajo.

**Alcance de "Sistemas de tipos y reducción":** calculo lambda tipado, semantica operacional,
habitantes, extension con ADTs, reduccion paso a paso.

### Segundo Parcial (2P)

| Bloque oficial | Tema interno | Paginas | Ej tipico |
|---|---|---|---|
| Inferencia y compilación | `unificacion_e_inferencia` | `unificacion_e_inferencia_de_tipos_teoria`, `_practica`, `_guia` | Ej 3a |
| Inferencia y compilación | `interpretacion` | `interpretacion_teoria` | — |
| Lógica de primer orden | `logica_de_primer_orden` | `logica_de_primer_orden_teoria`, `_guia` | Ej 2, Ej 3b |
| Resolución lógica | `resolucion` | `resolucion_teoria`, `resolucion_sld_y_prolog_teoria`, `_practica`, `_guia` | Ej 2 |
| Programación lógica (en Prolog) | `programacion_logica` | `programacion_logica_practica`, `programacion_logica_guia` | Ej 1 |
| Programación orientada a objetos (SmallTalk) | `programacion_orientada_objetos` | `programacion_orientada_objetos_teoria`, `_guia` | Ej 3a |

### ⚠️ Deduccion Natural cruza los dos parciales, pero por bloques distintos

Este es el punto mas facil de leer mal, porque la tecnica es la misma y el bloque oficial no.

| Donde | Que DN | Bloque oficial que la contiene | Pagina |
|---|---|---|---|
| 1P, Ej 2b | Proposicional / intuicionista | **Deducción natural para lógica proposicional** (1P) | `tipos_ejercicio/deduccion_natural_intuicionista` |
| 2P, Ej 3b | Con cuantificadores ∀/∃, a veces clasica (PBC/LEM) | **Lógica de primer orden** (2P) | `tipos_ejercicio/deduccion_natural_lpo` |

Por eso el tema `sistemas_deductivos_y_deduccion_natural` es **`1P`, no `ambos`**: el bloque
oficial de DN es solo el proposicional. La DN sobre LPO no es una reaparicion de ese bloque —
es parte de "Lógica de primer orden", que es un bloque de 2P por derecho propio.

Consecuencia practica: `tipos_ejercicio/deduccion_natural_lpo` debe declarar
`tema: logica_de_primer_orden` (hoy no declara `tema` — ver Deuda tecnica).

Evidencia: el Ej 3b del `2.parcial_2C_2025_resolucion(1)` pide
$(\neg \forall Y . P(Y)) \Rightarrow \exists X . (P(X) \Rightarrow Q(X))$ "usando principios
clasicos" — cuantificadores, no proposicional.

### ⚠️ El Ej 3 del 2P alterna entre Smalltalk e Inferencia

**Los dos bloques estan en el listado oficial.** Ninguno salio del programa. Lo que cambia es
cual se toma:

| Parcial | Ej 3a |
|---|---|
| `2.parcial_1C_2024_resolucion(1)` | Objetos (Smalltalk) |
| `2.parcial_1C_2024_recuperatorio` | Objetos (Smalltalk) |
| `2.parcial_2C_2024_resolucion(1)` | Inferencia de Tipos |
| `2.parcial_2C_2025_resolucion(1)` | Inferencia de Tipos |
| `2.parcial_2C_2025_recuperatorio(1)` | Inferencia de Tipos |

**Los 3 parciales mas recientes tomaron Inferencia.** Ambos siguen siendo material de parcial y
hay que estudiar los dos — el listado oficial los incluye. Pero si hay que repartir tiempo,
Inferencia tiene la tendencia a favor. `/priorizar` marca esa asimetria con **"en baja"** sobre
Smalltalk, sin bajarle el nivel de prioridad.

### Teoria de apoyo sin bloque oficial propio

| Tema interno | Pagina | Situacion |
|---|---|---|
| `correspondencia_curry_howard` | `correspondencia_curry_howard_y_recursion_teoria` | Dictada como `6.teo_2P_...`, **no figura en el listado oficial de ningun parcial**. Es el puente entre tipado y deduccion natural, y sostiene tanto el Ej 3 del 1P como el del 2P. Se deja en `2P` por el rotulo del dictado. Sin apariciones propias en parciales |

### Transversales (`ambos`)

Ninguno. Ver la nota de Deduccion Natural arriba: parece transversal y no lo es.

---

## Cursada vigente y procedencia del material

**Cursada vigente:** `2C_2026`.
**Carpeta de material:** `raw/cursada_2C_2026/{teo,prac,guias}/` — preparada para recibir PDFs.

Toda la wiki de PLP proviene hoy de material historico (`raw/clases/`, `raw/guias_practicas/`),
por lo que todas las paginas estan de hecho en `pendiente_verificacion`, aunque el campo
`estado_verificacion` aun no se haya escrito en su frontmatter.

El material nuevo se deposita en la subcarpeta correspondiente. Si se ingesta con `/ingestar`,
la ruta vigente activa el modo reconciliacion y ese material pasa a ser **fuente de autoridad**
ante cualquier conflicto con el historico.

Para material de la cursada que **no** se quiere ingestar y solo se quiere convertir en material
de estudio priorizado contra los parciales, usar
`/priorizar <teoria|practica|guia> <ruta_pdf>` — escribe en `cursada_actual/`, no toca la wiki.

### Lo que NO cambia: la base de que es importante

Los parciales historicos (`raw/parciales/`, ya ingestados) **siguen siendo la base** para decidir
que ejercicios y temas vale la pena estudiar. Las banderas `🔴 Si → [[tipos_ejercicio/X]]` / `⚪ No`
se calculan contra `parciales_analizados/` y `tipos_ejercicio/`.

En PLP esa base es especialmente fuerte: **la forma del parcial es casi invariante** a lo largo
de 11 examenes. Saber que el Ej 1 del 1P es siempre un `fold`/`rec` sobre un tipo inductivo nuevo
es informacion accionable, no una estadistica.

## Mapa tema → parcial (formato para maquinas)

```yaml
vigencia: 2C_2026
temas:
  programacion_funcional: 1P
  demostracion_de_propiedades: 1P
  sistemas_deductivos_y_deduccion_natural: 1P
  calculo_lambda_tipado: 1P
  unificacion_e_inferencia: 2P
  interpretacion: 2P
  logica_de_primer_orden: 2P
  resolucion: 2P
  programacion_logica: 2P
  programacion_orientada_objetos: 2P
  correspondencia_curry_howard: 2P
```

---

## Como leer el material historico

| Dato | Significado | ¿Cambia con el programa? |
|---|---|---|
| `parcial:` en `wiki/temas/` y `wiki/tipos_ejercicio/` | "Para que parcial **tenes que estudiar** esto" | **Si** — derivado de este archivo |
| `parcial:` en `wiki/parciales_analizados/` y `wiki/transcripciones/` | "Este examen **fue** un 1P/2P de tal cuatrimestre" | **No** — hecho historico |
| `apariciones_en_parciales:` en `tipos_ejercicio/` | "Este patron **aparecio** en estos examenes" | **No** — hecho historico |
| Nombres de `raw/` (`teo_1P_...`) | Orden y rotulo **originales del dictado** | **No** — `raw/` es inmutable |

**A diferencia de TDA, en PLP el reparto no cambio.** Los rotulos historicos de `raw/` y de
`parciales_analizados/` coinciden con el listado oficial vigente. Por eso, y solo por eso:

- ✅ Los parciales pasados **si** sirven como simulacro completo de examen.
- ✅ No hay ningun tema `reubicado: true`.

Si en algun momento la catedra reorganiza el reparto, esa equivalencia se rompe y hay que
documentarlo en el Historial de abajo — igual que se hizo en TDA.

---

## Deuda tecnica del frontmatter (para la proxima corrida de `/programa`)

Detectada al construir este archivo. No afecta al contenido de la wiki, si a los comandos que
filtran por frontmatter:

1. **Las 23 paginas de `wiki/tipos_ejercicio/` no declaran `tema:`.** Rompe el filtro por tema
   de `/priorizar` y `/chuleta`. Asignar segun el mapa de arriba; en particular
   `deduccion_natural_lpo` → `tema: logica_de_primer_orden`.
2. **`parcial:` inconsistente en `wiki/temas/`:** unas paginas dicen `1P`/`2P` y otras `1`/`2`
   (`demostracion_de_propiedades_practica`, `programacion_funcional_practica`,
   `programacion_logica_practica`, `resolucion_practica`,
   `sistemas_deductivos_y_deduccion_natural_practica`). Normalizar a `1P`/`2P`.
3. **4 teoricas sin `parcial:`:** `calculo_lambda_tipado_teoria`,
   `correspondencia_curry_howard_y_recursion_teoria`,
   `sistemas_deductivos_y_deduccion_natural_teoria`,
   `unificacion_e_inferencia_de_tipos_teoria`.
4. **`tema:` es texto libre en castellano** ("Demostración de Propiedades") en vez del slug
   snake_case del mapa. Normalizar al slug.
5. **`fuente:` con prefijo inconsistente:** unas rutas empiezan con `plp/`, otras no.

---

## Historial de programas

### 2C 2026 — vigente

Listado oficial de la catedra, sin cambios respecto del reparto bajo el que se tomaron los 11
parciales de `wiki/parciales_analizados/` (1C 2024 a 2C 2025).

Unica variacion observada en ese periodo: el Ej 3a del 2P paso de Smalltalk a Inferencia de
Tipos a partir de 2C 2024. Es un cambio de enfasis **dentro del mismo programa** — los dos
bloques figuran en el listado oficial —, no un movimiento de tema entre parciales.

---

## Procedimiento cuando cambie el programa

1. Editar la **Tabla vigente** y el **Mapa tema → parcial** de este archivo.
2. Agregar la entrada al **Historial de programas** con el diff de movimientos.
3. Correr `/programa` — propaga `parcial:` + `programa:` al frontmatter de
   `wiki/temas/` y `wiki/tipos_ejercicio/`, y regenera el agrupamiento de `index.md`.
4. **No tocar** `raw/`, `parciales_analizados/`, `transcripciones/` ni
   `apariciones_en_parciales`.
