---
nombre: Programa vigente — distribucion de temas por parcial
tipo: programa
vigencia: 2C_2026
actualizado: 2026-08-22
---

# Programa vigente — Algoritmos y Estructuras de Datos III

> **Esta es la unica fuente de verdad sobre que tema entra en que parcial.**
> El campo `parcial:` del frontmatter de `wiki/temas/` y `wiki/tipos_ejercicio/` es
> un campo **derivado** de esta tabla. Si cambia el programa, se edita **solo este
> archivo** y se corre `/programa` para propagar.

**Cuatrimestre vigente:** 2C 2026
**Cambio importante:** la catedra reorganizo que contenidos entran en cada parcial
respecto de cuatrimestres anteriores. Los contenidos son los mismos; cambio el reparto.

---

## Tabla vigente (2C 2026)

### Primer Parcial (1P)

| Bloque del programa | Tema interno | Paginas |
|---|---|---|
| Teoria de Grafos | `grafos` | `grafos_teoria`, `grafos_practica`, `grafos_guia` |
| Teoria de Grafos | `arboles` | `arboles_teoria` |
| Algoritmos sobre grafos | `recorrido_en_grafos` | `recorrido_en_grafos_practica`, `recorrido_en_grafos_guia` |
| Divide & Conquer | `divide_y_conquista` | `divide_y_conquista_teoria`, `_practica`, `_guia` |
| Backtracking | `fuerza_bruta_backtracking` | `fuerza_bruta_backtracking_teoria`, `_practica`, `_guia` |

**El listado del 1P es explicito de la catedra.** Se transcribe textual:

> Teoria de Grafos
> Algoritmos sobre grafos
> Divide & Conquer
> Backtracking

**Alcance de "Algoritmos sobre grafos" en el 1P:** solo recorridos — BFS, DFS,
conexidad, componentes conexas, bipartitez, aristas puente, orden topologico.
**No** incluye AGM (ver nota en el 2P), caminos minimos ni flujo.

**Sobre "Teoria de Grafos":** incluye `arboles_teoria` (definicion de arbol, lemas, teoremas de
equivalencia, arboles enraizados, arboles generadores) y las **demostraciones sobre grafos**, que
en el programa viejo eran un tema aparte del 1P ("Definiciones y Demostraciones").

### Segundo Parcial (2P)

| Bloque del programa | Tema interno | Paginas |
|---|---|---|
| Programacion Dinamica: **Top-Down, Bottom-Up y Reconstruccion** | `programacion_dinamica` | `programacion_dinamica_teoria`, `_top_down_practica_pt1`, `_top_down_practica_pt2`, `_bottom_up_practica`, `_guia` |
| Greedy | `greedy` | `greedy_teoria`, `greedy_practica`, `greedy_guia` |
| Camino minimo: **Dijkstra / Bellman-Ford / Floyd y Dantzig / DAGs** | `caminos_minimos` | `caminos_minimos_teoria` (Dijkstra, BF, Floyd, Dantzig), `caminos_minimos_practica`, `caminos_minimos_todos_a_todos_y_dags_practica` (DAGs), `caminos_minimos_guia` |
| Flujo maximo | `flujo_en_redes` | `flujo_en_redes_teoria`, `_practica`, `_practica_pt2`, `_guia` |
| Arboles Generadores Minimos ⚠️ | `arboles_generadores_minimos` | `arboles_generadores_minimos_teoria`, `_practica`, `_guia` |

**El listado del 2P es explicito de la catedra**, no derivado por descarte. Se transcribe textual:

> Programacion Dinamica: Top-Down, Bottom-Up y Reconstruccion
> Greedy
> Camino minimo: Dijkstra/Bellman-Ford/Floyd y Dantzig/DAGs
> Flujo maximo

### ⚠️ AGM — decision tomada, no volver a "corregir"

**Arboles Generadores Minimos no figura en el listado oficial de ninguno de los dos parciales.**
Decision del usuario (2026-08-22): **se queda en el 2P**, asumiendo que el listado de la
catedra esta incompleto en ese punto.

No moverlo al 1P ni marcarlo fuera de programa sin confirmacion explicita del usuario.
Contexto de la decision: AGM tiene 8 ejercicios en parciales historicos (4 en `2P_1C_2024`,
4 en `2P_1C_2025`), 3 paginas de wiki y `tipos_ejercicio/agm_propiedades`. La hipotesis
alternativa era que cayera dentro de "Algoritmos sobre grafos" del 1P — descartada por el usuario.

### Notas de alcance dentro del 2P

- **Reconstruccion (PD):** la catedra la nombra como subtema explicito. En la wiki esta cubierta
  en `programacion_dinamica_teoria` (seccion propia, "Reconstruccion de la solucion") y aplicada
  en ~6 ejercicios de `programacion_dinamica_guia` (Vacations, Fire, TravesiaVital, Farmer) y en
  `programacion_dinamica_top_down_practica_pt1`. No tiene pagina propia: buscarla ahi.
- **Flujo de costo minimo (MCMF):** el bullet oficial dice "Flujo maximo". Los ejercicios 22-24 de
  `flujo_en_redes_guia` son MCMF. Decision del usuario (2026-08-22): **entran igual**, se leen
  como extension del bloque de flujo.

### Transversales (`ambos`)

| Tema interno | Paginas | Por que |
|---|---|---|
| `complejidad_computacional` | `complejidad_computacional_teoria` | No figura como bloque propio en ningun listado oficial. Notacion asintotica: prerequisito de D&C (1P) y del analisis de PD (2P) |
| `definiciones_y_demostraciones` | `definiciones_y_demostraciones_teoria`, `demostraciones_induccion_guia` | No figura como bloque propio en ningun listado oficial. Las demos sobre grafos caen dentro de "Teoria de Grafos" (1P); las de correctitud greedy/PD, dentro de sus bloques (2P). Por eso: transversal |

---

## Cursada vigente y procedencia del material

**Cursada vigente:** `2C_2026` — mismo valor que `vigencia` en el frontmatter de este archivo.
**Carpeta de material:** `raw/cursada_2C_2026/` (`teo/`, `prac/`, `guias/`).

El material de la cursada vigente es la **fuente de autoridad**. El de cuatrimestres pasados
(`raw/clases/`, `raw/guias_practicas/`) sigue siendo valido — son los mismos contenidos — pero
cede ante el nuevo en cualquier conflicto de notacion, alcance o enfoque.

### Estados de verificacion

Cada pagina de `wiki/temas/` declara en su frontmatter de donde viene su contenido:

```yaml
fuentes:
  vigente:   [raw/cursada_2C_2026/teo/...]     # material de la cursada actual
  historico: [raw/clases/teo/...]              # cuatrimestres pasados
estado_verificacion: verificado_2C_2026 | pendiente_verificacion | solo_historico
```

| Estado | Significa |
|---|---|
| `verificado_2C_2026` | El material de la cursada actual paso por aca. Refleja lo que se dicta hoy |
| `pendiente_verificacion` | Solo tiene material de cuatrimestres pasados. **Sin contrastar** |
| `solo_historico` | Contenido que ya no se dicta. Se conserva, no se estudia |

Es esperable que durante buena parte del cuatrimestre la mayoria de las paginas esten en
`pendiente_verificacion`. Eso es informacion honesta, no una falla. `/lint` y `/estado` dan el avance.

### Lo que NO cambia: la base de que es importante

Los parciales historicos (`raw/parciales/`, ya ingestados) **siguen siendo la base** para decidir
que ejercicios y temas vale la pena estudiar. Las banderas `🔴 Si → [[tipos_ejercicio/X]]` / `⚪ No`
se calculan contra `parciales_analizados/` y `tipos_ejercicio/` exactamente como siempre.

Los contenidos son los mismos entre cuatrimestres — solo cambio el reparto por parcial (ver arriba).
Por eso lo que tomaron historicamente sigue siendo un indicador valido de importancia.
**No hay un sistema de señal paralelo**: los ⋆ de las guias se extraen como contenido, nada mas.

### Orden de ingesta de la cursada

1. **Teoricas** — definen notacion y alcance
2. **Practicas**
3. **Guias** — matching de ejercicios por enunciado
4. **Re-correr `/tipos_ejercicio`** — los ejercicios nuevos de las guias necesitan su bandera

Las teoricas van primero porque si cambio la notacion, saberlo antes evita rehacer el matching.
Si en algun momento la catedra reparte parciales, enunciados modelo o listas de ejercicios
obligatorios, **eso entra antes que todo lo demas** — el principio de "parciales primero" sigue vigente.

## Mapa tema → parcial (formato para maquinas)

```yaml
vigencia: 2C_2026
temas:
  grafos: 1P
  arboles: 1P
  recorrido_en_grafos: 1P
  divide_y_conquista: 1P
  fuerza_bruta_backtracking: 1P
  programacion_dinamica: 2P
  greedy: 2P
  arboles_generadores_minimos: 2P
  caminos_minimos: 2P
  flujo_en_redes: 2P
  complejidad_computacional: ambos
  definiciones_y_demostraciones: ambos
```

---

## Como leer el material historico

Esta es la parte critica. La wiki contiene dos clases de dato con la etiqueta `1P`/`2P`
y **significan cosas distintas**:

| Dato | Significado | ¿Cambia con el programa? |
|---|---|---|
| `parcial:` en `wiki/temas/` y `wiki/tipos_ejercicio/` | "Para que parcial **tenes que estudiar** esto" | **Si** — derivado de este archivo |
| `parcial:` en `wiki/parciales_analizados/` y `wiki/transcripciones/` | "Este examen **fue** un 1P/2P de tal cuatrimestre" | **No** — es un hecho historico |
| `apariciones_en_parciales:` en `tipos_ejercicio/` | "Este patron **aparecio** en estos examenes" | **No** — es un hecho historico |
| Nombres de `raw/` (`1.teo_1P_...`) | Orden y rotulo **originales del dictado** | **No** — `raw/` es inmutable |

### Consecuencia 1 — las banderas 🔴 siguen valiendo, pero cambian de sentido

Una bandera `🔴 Si` en un ejercicio significa **"este tipo de ejercicio lo toman"**.
Sigue siendo cierta. Lo que cambio es *cuando* te lo pueden tomar.

Ejemplo: `tipos_ejercicio/grafos_demostraciones` aparecio historicamente en parciales
rotulados 2P. Con el programa vigente, grafos entra en tu **1P** → ese patron es
material de tu primer parcial, aunque sus apariciones digan "2P".

### Consecuencia 2 — los parciales pasados ya no son simulacros validos

Un `1P_1C_2025` completo **no se parece** al 1P que vas a rendir: aquel tenia PD y
Greedy, el tuyo tiene Grafos y Recorridos.

- ✅ Siguen siendo un **banco de ejercicios excelente**, filtrando por tema.
- ❌ **No** los uses como simulacro de examen completo.
- `/parcial 1P` arma la vista cruzando **por tema segun esta tabla**, no por el rotulo
  del examen en que salieron: junta ejercicios de grafos que estan en parciales 2P
  historicos con ejercicios de D&C que estan en parciales 1P historicos.

### Consecuencia 3 — las paginas de repaso son de otro programa

`sintesis/repaso_1P` y `sintesis/repaso_2P` son clases de consulta de cuatrimestres
anteriores. Su contenido responde al **reparto viejo** de temas. Siguen siendo utiles
como material, pero no como guia de que entra en tu parcial.

---

## Historial de programas

### 2C 2026 — vigente

Reorganizacion de la catedra. Movimientos respecto del programa anterior:

| Tema | Antes | Ahora |
|---|---|---|
| Teoria de Grafos | 2P | **1P** ⬅️ |
| Arboles | 2P | **1P** ⬅️ |
| Recorridos (BFS/DFS) | 2P | **1P** ⬅️ |
| Programacion Dinamica | 1P | **2P** ➡️ |
| Greedy | 1P | **2P** ➡️ |
| Divide & Conquer | 1P | 1P (sin cambio) |
| Backtracking | 1P | 1P (sin cambio) |
| AGM / Caminos Minimos / Flujo | 2P | 2P (sin cambio) |

### Hasta 1C 2026 — historico

Este es el reparto bajo el cual fueron tomados **todos** los parciales de
`wiki/parciales_analizados/`, y el que explica los rotulos `1P`/`2P` en `raw/`.

- **1P:** Divide & Conquer, Fuerza Bruta & Backtracking, Programacion Dinamica
  (top-down + bottom-up), Greedy, Definiciones y Demostraciones
- **2P:** Grafos (representacion + demos), Arboles, Arboles Generadores Minimos,
  Caminos Minimos, Flujo en Redes

---

## Procedimiento cuando vuelva a cambiar el programa

1. Editar la **Tabla vigente** y el **Mapa tema → parcial** de este archivo.
2. Agregar la entrada al **Historial de programas** con el diff de movimientos.
3. Correr `/programa` — propaga `parcial:` + `programa:` al frontmatter de
   `wiki/temas/` y `wiki/tipos_ejercicio/`, y regenera el agrupamiento de `index.md`.
4. **No tocar** `raw/`, `parciales_analizados/`, `transcripciones/` ni
   `apariciones_en_parciales`.

## Procedimiento cuando arranca una cursada nueva

1. Crear `raw/cursada_<vigencia>/{teo,prac,guias}/` y soltar el material ahi.
2. Actualizar `vigencia` en el frontmatter y la seccion **Cursada vigente** de este archivo.
3. Re-marcar las paginas a `pendiente_verificacion` con la vigencia nueva (el material verificado
   contra la cursada anterior deja de estar verificado contra la actual).
4. Ingestar en el orden de arriba con `/ingestar raw/cursada_<vigencia>/...` (modo reconciliacion).
