# Log — Paradigmas de Programación




## 2026-08-20 ingest | 19 ejercicios faltantes (deuda de Fase 1 saldada)

Ingestados y resueltos los 19 ejercicios que figuraban en el indice de su guia con link de anclaje pero no tenian seccion en el archivo:
- `logica_de_primer_orden_guia`: Ej. 3, 4, 6, 7, 10, 11, 12, 13, 15, 16 → la guia pasa de 6 a **16 ejercicios** (2032 lineas)
- `calculo_lambda_guia`: Ej. 17, 18, 19, 23, 24, 25, 26 → de 20 a **27 ejercicios** (2224 lineas)
- `unificacion_e_inferencia_guia`: Ej. 6, 7 → de 8 a **10 ejercicios**

Cada uno con enunciado fiel al PDF, explicacion, resolucion completa, chuleta y bandera. Las 3 guias quedan en 0 marcadores `[PENDIENTE]` y 0 links rotos.

**Anclajes del indice**: corregidos 8 que estaban rotos desde antes por tildes y titulos truncados (`calculo_lambda_guia` Ej. 2, 3, 20, 21, 27; `unificacion_e_inferencia_guia` Ej. 8, 9, 10). plp queda con 0 anclajes rotos.

**Nota de metodo**: los PDFs se extrajeron una sola vez a texto plano en el scratchpad y los agentes leyeron de ahi. La extraccion via PyMuPDF pierde las ligaduras `fi`/`ti` ("unican" por unifican, "denir" por definir): se verifico que ninguna llegara al wiki.

**Ambiguedades de enunciado detectadas** (marcadas `⚠️ Verificar` en el texto):
- FNN (Ej. 11) y FNP (Ej. 12) de LPO dependen de equivalencias NO intuicionistas; el enunciado no aclara si se permiten principios clasicos y sin ellos el teorema es falso.
- Varios enunciados de LPO no parentizan el alcance de cuantificadores y negaciones (Ej. 4, 15.i, 16.xvi): con "alcance maximo" cambian de respuesta o se vacian de contenido. Se resolvio con la lectura estandar, documentando la alternativa.
- Ej. 24 de lambda: la guia define listas por comprension sin anotacion de tipo; sin ella se rompe preservacion. Se agrego la anotacion, con la alternativa (macro sobre `foldr`) documentada.

## 2026-08-18 mantenimiento | frontmatter, tipos_ejercicio y deuda de ingesta

- **Frontmatter**: agregado a las 12 paginas que no lo tenian (11 `transcripciones/` + `sintesis/patrones_detectados.md`). plp queda al 100%, igual que tda y sistemas_digitales. Rutas `fuente:` verificadas contra el filesystem; campos sin dato determinable se omitieron en vez de inventarse.
- **4 paginas `tipos_ejercicio/` nuevas** (591 lineas): `lambda_habitantes`, `lambda_sintaxis_arbol`, `lpo_unificacion`, `lpo_semantica_modelos`. Las 4 banderas que decian `tipos_ejercicio pendiente:` ahora son links reales. Agregadas al `index.md`.
- **Enunciados truncados completados** en `logica_de_primer_orden_guia` (Ej. 2 +6 items, Ej. 8 +6 items; las resoluciones existentes ya cubrian los items faltantes, no hubo que extenderlas) y en `sistemas_deductivos_y_deduccion_natural_guia` (Ej. 11 +13 secuentes, Ej. 12 +10, Ej. 13 +8 — los 34 quedaron resueltos con derivacion completa).
- **2 transcripciones erroneas corregidas contra el PDF**: `programacion_logica_guia` Ej. 16 (heladeria — la base real tiene 7 hechos, no 2; resolucion reescrita, arbol SLD con 4 soluciones, item II cubre las 6 ubicaciones del `!`) y `calculo_lambda_guia` Ej. 16.VIII (el PDF dice `x`, no `fix`; resolucion principal corregida, la lectura con `fix` queda como nota).
- `⚠️ Verificar` en plp: 20 → 19 (uno se resolvio con la fuente real).

### Deuda de ingesta pendiente (Fase 1, NO resuelta)

19 ejercicios figuran en el indice de su guia con link de anclaje pero **no tienen seccion en el archivo** — nunca se ingestaron:
- `logica_de_primer_orden_guia`: Ej. 3, 4, 6, 7, 10, 11, 12, 13, 15, 16 (10 de 16)
- `calculo_lambda_guia`: Ej. 17, 18, 19, 23, 24, 25, 26 (7 de 27)
- `unificacion_e_inferencia_guia`: Ej. 6, 7 (2 de 10)

Los links de anclaje del indice de esas paginas no llevan a ningun lado. tda y sistemas_digitales no tienen este problema.

## 2026-08-18 resolver | 9 guias (Fase 2 completa)

- Resueltos los 216 marcadores `[PENDIENTE — sesion de resolucion]` en las 9 guias pendientes, via 9 sesiones paralelas (una por guia). Total: ~144 ejercicios.
- `resolucion_guia` 26 ej · `programacion_funcional_guia` 22 · `calculo_lambda_guia` 20 · `programacion_logica_guia` 18 · `demostracion_de_propiedades_guia` 14 · `sistemas_deductivos_y_deduccion_natural_guia` 9 · `programacion_orientada_objetos_guia` 9 · `unificacion_e_inferencia_guia` 8 · `logica_de_primer_orden_guia` 6.
- 20 ejercicios marcados `⚠️ Verificar` (ambiguedades reales del enunciado, no errores de resolucion).
- **Incidente corregido:** una colision de archivos temporales entre sesiones inyecto contenido de Smalltalk en los Ej. 3 y 4 de `sistemas_deductivos_y_deduccion_natural_guia` (guia de logica proposicional). Ambos fueron reescritos con la resolucion correcta. Barrido posterior sobre las 9 guias: sin otra contaminacion.
- **Deuda de ingesta detectada** (Fase 1, no resuelta aca): enunciados truncados o mal transcriptos en `logica_de_primer_orden_guia` (2 ejercicios "ver PDF para lista completa"), `sistemas_deductivos_..._guia` Ej. 11-13 (14/11/9 secuentes reducidos a uno de muestra), `programacion_logica_guia` Ej. 16 (hechos tales que `leGusta/1` falla siempre), `calculo_lambda_guia` Ej. 16.VIII (`fix` donde el PDF dice `x`).

## 2026-08-18 mantenimiento | reparacion de links

- 53 referencias rotas a `tipos_ejercicio/` corregidas; 4 sin pagina destino (`lambda_sintaxis_arbol`, `lambda_habitantes`, `lpo_unificacion`, `lpo_semantica_modelos`) quedan como marcador `tipos_ejercicio pendiente:` en vez de link fantasma.
- `index.md`: 14 encabezados de tema dejaron de ser wikilinks a paginas inexistentes (ahora texto en negrita, estilo tda).
- `resolucion_teoria.md`: `paginas_relacionadas` apuntaba a `clausulas_de_horn_teoria` (inexistente) → `resolucion_sld_y_prolog_teoria`.
- CLAUDE.md: tabla de comandos completa (15).
- Pendiente real: 216 marcadores `[PENDIENTE — sesion de resolucion]` en 9 guias — falta correr `/resolver`.

## 2026-04-23 scan | /tipos_ejercicio_scan
- Escaneados 11 parciales analizados.
- Identificados 9 patrones recurrentes (3 de 1P, 5 de 2P, 1 cross-parcial).
- Generado `wiki/sintesis/patrones_detectados.md`.

## 2026-04-23 ingest | 8.guia_2P_programacion_orientada_a_objetos.pdf
- Creado `wiki/temas/programacion_orientada_objetos_guia.md` (via vision + pdftoppm)
- Temas: Comparación de Paradigmas, Objetos/Mensajes, Bloques/Closures, Colecciones, Method Dispatch (self/super), Double Dispatch

- Creado `wiki/temas/programacion_logica_guia.md` (via vision + pdftoppm)
- Temas: Listas, Reversibilidad, Árboles Binarios, Grafos, Cut (!), Negación por Falla, Generate & Test

- Creado `wiki/temas/resolucion_guia.md` (via vision + pdftoppm)
- Temas: Resolución Proposicional, Resolución LPO, Skolemización, Cláusulas de Horn, Resolución SLD, Traza de Prolog

- Creado `wiki/temas/logica_de_primer_orden_guia.md` (via vision + pdftoppm)
- Temas: Sintaxis LPO, Unificación (MGU), Deducción Natural, Semántica (Interpretaciones)

## 2026-04-23 ingest | 4.guia_2P_inferencia_de_tipos.pdf
- Creado `wiki/temas/unificacion_e_inferencia_guia.md` (via vision + pdftoppm)
- Temas: Algoritmo I, Unificación (MGU), Generación de Restricciones, Extensiones (Pares, Sumas, Listas)

## 2026-04-23 ingest | 3.guia_1P_calculo_lamda_tipado_semantica_operacional.pdf
- Creado `wiki/temas/calculo_lambda_guia.md` (via vision + pdftoppm)
- Temas: Cálculo Lambda Tipado, Semántica Operacional, Extensiones (Pares, Sumas, Listas, Deques)


## 2026-04-23 ingest | 2.guia_1P_demostracion_en_logica_proposicional.pdf
- Creado `wiki/temas/sistemas_deductivos_y_deduccion_natural_guia.md` (via vision + pdftoppm)
- Temas: Lógica Proposicional, Semántica, Deducción Natural (LJ, LK)


## 2026-04-23 ingest | 1.guia_1P_razonamiento_ecuacional_&_induccion_estructural.pdf
- Creado `wiki/temas/demostracion_de_propiedades_guia.md` (via vision + pdftoppm)
- Temas: Razonamiento Ecuacional, Inducción Estructural, Extensionalidad Funcional


## 2026-04-23 ingest | 0.guia_1P_programacion_funcional.pdf
- Creado `wiki/temas/programacion_funcional_guia.md` (via vision + pdftoppm)
- Temas: Programación Funcional, Esquemas de Recursión, Generación Infinita


## 2026-04-22 ingest | 1.parcial_1C_2024_resolucion(1).pdf
- Creado `wiki/transcripciones/1.parcial_1C_2024_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/1.parcial_1C_2024_resolucion(1).md`
- Temas: Programación Funcional, Demostración de Propiedades, Cálculo Lambda Tipado

## 2026-04-22 ingest | 1.parcial_1C_2024_recuperatorio_resolucion(1).pdf
- Creado `wiki/transcripciones/1.parcial_1C_2024_recuperatorio_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1).md`
- Temas: Programación Funcional, Lógica Proposicional, Demostración de Propiedades, Algoritmo W, Cálculo Lambda Tipado

## 2026-04-22 ingest | 1.parcial_1C_2025_resolucion(1).pdf
- Creado `wiki/transcripciones/1.parcial_1C_2025_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/1.parcial_1C_2025_resolucion(1).md`
- Temas: Programación Funcional, Demostración de Propiedades, Deducción Natural, Cálculo Lambda Tipado

## 2026-04-22 ingest | 1.parcial_1C_2025_resolucion(2).pdf
- Creado `wiki/transcripciones/1.parcial_1C_2025_resolucion(2)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/1.parcial_1C_2025_resolucion(2).md`
- Temas: Programación Funcional, Demostración de Propiedades, Deducción Natural, Cálculo Lambda Tipado

## 2026-04-22 ingest | 1.parcial_2C_2024_resolucion(1).pdf
- Creado `wiki/transcripciones/1.parcial_2C_2024_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/1.parcial_2C_2024_resolucion(1).md`
- Temas: Programación Funcional, Demostración de Propiedades, Deducción Natural, Cálculo Lambda Tipado

## 2026-04-22 ingest | 1.parcial_2C_2025_resolucion(1).pdf
- Creado `wiki/transcripciones/1.parcial_2C_2025_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/1.parcial_2C_2025_resolucion(1).md`
- Temas: Programación Funcional, Demostración de Propiedades, Deducción Natural, Cálculo Lambda Tipado

## 2026-04-22 ingest | 2.parcial_1C_2024_resolucion(1).pdf
- Creado `wiki/transcripciones/2.parcial_1C_2024_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/2.parcial_1C_2024_resolucion(1).md`
- Temas: Lógica de Primer Orden, Programación Lógica (Prolog), Programación Orientada a Objetos (Smalltalk), Deducción Natural

## 2026-04-22 ingest | 2.parcial_1C_2024_recuperatorio_resolucion(1).pdf
- Creado `wiki/transcripciones/2.parcial_1C_2024_recuperatorio_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1).md`
- Temas: Lógica de Primer Orden, Programación Lógica (Prolog), Programación Orientada a Objetos (Smalltalk), Deducción Natural

## 2026-04-22 ingest | 2.parcial_2C_2024_resolucion(1).pdf
- Creado `wiki/transcripciones/2.parcial_2C_2024_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/2.parcial_2C_2024_resolucion(1).md`
- Temas: Lógica de Primer Orden, Programación Lógica (Prolog), Resolución, Cláusulas de Horn, Deducción Natural, Inferencia de Tipos

## 2026-04-22 ingest | 2.parcial_2C_2025_resolucion(1).pdf
- Creado `wiki/transcripciones/2.parcial_2C_2025_resolucion(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/2.parcial_2C_2025_resolucion(1).md`
- Temas: Programación Lógica, Lógica de Primer Orden, Resolución, Cálculo Lambda Tipado, Deducción Natural

## 2026-04-23 ingest | 2.parcial_2C_2025_recuperatorio(1).pdf
- Creado `wiki/transcripciones/2.parcial_2C_2025_recuperatorio(1)_raw.md` (via vision)
- Creado `wiki/parciales_analizados/2.parcial_2C_2025_recuperatorio(1).md`
- Temas: Programación Lógica, Lógica de Primer Orden, Resolución, Cálculo Lambda Tipado, Deducción Natural

## 2026-04-23 ingest | 0.teo_1P_repaso.pdf
- Creado `wiki/temas/programacion_funcional_teoria.md`
- Temas: Programación Funcional

## 2026-04-23 ingest | 1.teo_1P_programacion_funcional.pdf
- Actualizado `wiki/temas/programacion_funcional_teoria.md`
- Temas: Programación Funcional

## 2026-04-23 ingest | 2.teo_1P_esquemas_recursion_&_tipos_datos_inductivos.pdf
- Actualizado `wiki/temas/programacion_funcional_teoria.md`
- Temas: Programación Funcional

## 2026-04-23 ingest | 3.teo_1P_razonamiento_ecuacional_&_induccion_estructural.pdf
- Creado `wiki/temas/demostracion_de_propiedades_teoria.md`
- Temas: Demostración de Propiedades

## 2026-04-23 ingest | 4.teo_1P_sistemas_deductivos_&_deduccion_natural.pdf
- Creado `wiki/temas/sistemas_deductivos_y_deduccion_natural_teoria.md`
- Temas: Deducción Natural, Lógica Proposicional

## 2026-04-23 ingest | 5.teo_1P_caculo_lambda.pdf
- Creado `wiki/temas/calculo_lambda_tipado_teoria.md`
- Temas: Cálculo Lambda Tipado

## 2026-04-23 ingest | 6.teo_2P_correspondencia_curry-howard_operador-de-punto-fijo_recursion.pdf
- Creado `wiki/temas/correspondencia_curry_howard_y_recursion_teoria.md`
- Temas: Correspondencia Curry-Howard, Recursión

## 2026-04-23 ingest | 7.teo_2P_unificacion_inferencia_de_tipos.pdf
- Creado `wiki/temas/unificacion_e_inferencia_de_tipos_teoria.md`
- Temas: Unificación, Inferencia de Tipos

## 2026-04-23 ingest | 8.teo_2P_interpretacion.pdf
- Creado `wiki/temas/interpretacion_teoria.md`
- Temas: Interpretación, Estrategias de Evaluación, Clausuras
## 2026-04-23 ingest | 9.teo_logica_de_primer_orden.pdf
- Creado `wiki/temas/logica_de_primer_orden_teoria.md`
- Temas: Lógica de Primer Orden, Deducción Natural, Unificación
## 2026-04-23 ingest | 10.teo_2P_resolucion_logica.pdf
- Creado `wiki/temas/resolucion_teoria.md`
- Temas: Resolución, Forma Clausal, Skolemización, Prolog

## 2026-04-23 ingest | 11.teo_2P_resolucion_SLD_prolog.pdf
- Creado `wiki/temas/resolucion_sld_y_prolog_teoria.md`
- Temas: Resolución SLD, Semántica de Prolog, Cut, Negación por Falla

## 2026-04-23 ingest | 12.teo_2P_programacion_orientada_objetos.pdf
- Creado `wiki/temas/programacion_orientada_objetos_teoria.md`
- Temas: POO, Smalltalk, Polimorfismo, Method Dispatch, Bloques

## 2026-04-23 ingest | 0.prac_1P_programacion_funcional_haskell.pdf
- Creado `wiki/temas/programacion_funcional_practica.md`
- Temas: Programación Funcional, Haskell, Orden Superior, foldr

## 2026-04-23 ingest | 1.prac_1P_programacion_funcional_(2).pdf
- Actualizado `wiki/temas/programacion_funcional_practica.md`
- Temas: Programación Funcional, Árboles (AEB, RoseTree), Polinomios, Esquemas de Recursión, Conjuntos funcionales

## 2026-04-23 ingest | 2.prac_1P_programacion_funcional_(3).pdf
- Creado `wiki/temas/demostracion_de_propiedades_practica.md`
- Temas: Razonamiento Ecuacional, Inducción Estructural, Lemas, Generalización de Propiedades

## 2026-04-23 ingest | 3.prac_P1_sistemas_deductivos.pdf
- Creado `wiki/temas/sistemas_deductivos_y_deduccion_natural_practica.md`
- Temas: Deducción Natural, Lógica Intuicionista vs Clásica, Debilitamiento (Weakening)

## 2026-04-23 ingest | 4.prac_P1_calculo_lambda.pdf
- Creado `wiki/temas/calculo_lambda_practica.md`
- Temas: Cálculo Lambda Tipado, Semántica Operacional, Tipado, Valores

## 2026-04-23 ingest | 5.prac_P1_calculo_lambda_(2).pdf
- Actualizado `wiki/temas/calculo_lambda_practica.md` con extensiones
- Temas: Pares, Uniones Disjuntas, Árboles Binarios, case-trees, map-trees

## 2026-04-23 ingest | 6.prac_P1_repaso_para_primer_parcial.pdf
- Creado `wiki/parciales/repaso_1P.md` con ejercicios integrales
- Temas: Funcional (Haskell), Inducción Estructural, Deducción Natural, Cálculo Lambda (Deques)

## 2026-04-23 ingest | 7.prac_P2_infefencia_de_tipos.pdf
- Creado `wiki/temas/unificacion_e_inferencia_practica.md`
- Temas: Algoritmo I, Generación de Restricciones, Unificación, Extensión para Listas

## 2026-04-23 ingest | 8.prac_P2_programacion_logica_(1).pdf
- Creado `wiki/temas/programacion_logica_practica.md`
- Temas: Programación Lógica, Prolog, Aritmética, Listas, member, append

## 2026-04-23 ingest | 9.prac_P2_programacion_logica_(2).pdf
- Actualizado `wiki/temas/programacion_logica_practica.md` (ahora Práctica Integral)
- Temas: Negación por Falla, Operador Cut (!), Metapredicados (setof, findall), Generación Infinita

## 2026-04-23 ingest | 10.prac_P2_resolucion_logica_primer_orden.pdf
- Creado `wiki/temas/resolucion_practica.md`
- Temas: Cláusulas de Horn, Resolución General, Resolución SLD, Unificación (MGU), Prolog

## 2026-08-24 programa | 2C_2026
Cambio de reparto: **ninguno**. El listado oficial de la catedra para 2C 2026 coincide con el
reparto bajo el que se tomaron los 11 parciales de `wiki/parciales_analizados/` (1C 2024 a 2C 2025).
Esta corrida no movio ningun tema entre parciales: salda la **deuda tecnica de frontmatter**
documentada en `programa.md` y propaga `programa: 2C_2026`.

Paginas actualizadas: 28 en temas/, 23 en tipos_ejercicio/ (51 en total).
- `tema:` normalizado a slug snake_case del mapa: 20 paginas de temas/
- `tema:` agregado (no existia): 23 paginas de tipos_ejercicio/
- `parcial:` normalizado de `1`/`2` a `1P`/`2P`: 5 paginas
- `parcial:` agregado donde faltaba: 4 teoricas
- `fuente:` sin prefijo `plp/`: 8 paginas (los 33 PDFs referenciados existen en raw/)
- `programa: 2C_2026` agregado debajo de `parcial:`: las 51 paginas

Avisos de reubicacion: **ninguno**. Ningun `parcial:` cambio de valor, asi que no corresponde
ningun aviso. Dos patrones tienen `parcial:` distinto del rotulo mayoritario de sus apariciones
(`lambda_habitantes`, `lambda_sintaxis_arbol`: tema 1P, apariciones en examenes 2P) pero eso es
reaparicion de una tecnica de 1P como sub-habilidad de un ejercicio de 2P, **no** un cambio de
programa. Documentado como nota en `index.md`, sin escribir aviso en las paginas.

Prosa desactualizada: ninguna. No hay en `wiki/temas/` ninguna afirmacion del tipo "es tema 2P"
que contradiga el programa vigente.

`index.md` reagrupado por parcial vigente (Transversales → 1P → 2P → Tipos de ejercicio → Parciales
analizados → Repaso → Sintesis). Se corrigio la ubicacion de `lambda_habitantes` y
`lambda_sintaxis_arbol`, que figuraban bajo 2P contra su propio `parcial: 1P`.
`repaso_1P` NO se marco como historico: el programa no cambio, el material sigue vigente.
`CLAUDE.md` actualizado: la tabla de temas por parcial ahora apunta a `programa.md`.
No se modifico raw/, parciales_analizados/, transcripciones/, `apariciones_en_parciales:`,
las banderas 🔴/⚪ ni el cuerpo de ninguna pagina.

## 2026-08-25 analisis | 20260825-170523-cf36ebcf-02-Funcional2-Folds.pdf
Material de estudio: `cursada_actual/20260825_170523_cf36ebcf_02_funcional2_folds.md` — 12 unidades explicadas (4 criticas, 8 probables), 0 patrones no cubiertos. Sin ingesta.

## 2026-08-25 mantenimiento | estructura de salida de /priorizar
Separados tres modos pedagogicos: teoria para comprension conceptual, practica para tecnicas mediante ejercicios modelo y guia para entrenamiento progresivo. En teoria se reemplazo la comprobacion de comprension por `Explicacion para nene de 5`; la evidencia y la aplicacion a ejercicios quedan fuera del desarrollo conceptual.

## 2026-08-25 mantenimiento | /priorizar migrado a Agent Skill
Implementacion canonica creada en `.agents/skills/priorizar/`, con referencias separadas para seleccion, teoria, practica, guia y guardado, mas extractor PDF. `.claude/commands/priorizar.md` y `.pi/prompts/priorizar.md` quedan como wrappers; la skill es la unica fuente de verdad.

## 2026-08-25 analisis | 20260825-170523-cf36ebcf-02-Funcional2-Folds.pdf
Material de estudio regenerado: `cursada_actual/20260825_170523_cf36ebcf_02_funcional2_folds.md` — 10 unidades explicadas (5 criticas, 5 probables), 0 patrones no cubiertos. Sin ingesta.

## 2026-08-25 mantenimiento | descubrimiento de /priorizar en Pi
Agregada configuracion local `.pi/settings.json` en las tres materias activas para cargar el wrapper compartido de `/priorizar`. Verificado con el resource loader de Pi: skill y prompt se descubren sin diagnosticos desde `plp/`, `tda/` y `sistemas_digitales/`.
