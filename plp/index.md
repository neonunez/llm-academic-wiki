# Índice — Paradigmas de Programación

Última actualización: 2026-08-24 · Programa vigente: **2C_2026** (ver [[programa]])

> **El reparto de temas por parcial NO cambió.** El listado oficial de la cátedra para 2C 2026
> coincide con el reparto bajo el que se tomaron los 11 parciales de `wiki/parciales_analizados/`
> (1C 2024 a 2C 2025). Consecuencia práctica: **los parciales pasados sirven como simulacro
> completo de examen**, sin necesidad de reinterpretar rótulos. No hay ningún tema reubicado.

## Transversales

Ninguno. Deducción Natural *parece* transversal y no lo es: el bloque oficial de DN del 1P es
**solo proposicional**, y la DN con cuantificadores pertenece al bloque "Lógica de primer orden"
del 2P. Ver [[programa]].

## Temas — 1P

- **Programación Funcional** (`programacion_funcional`)
  - [[programacion_funcional_teoria]] - Teoría de Programación Funcional
  - [[programacion_funcional_practica]] - Práctica de Programación Funcional (Haskell)
  - [[programacion_funcional_guia]] - Guía de Ejercicios N° 1

- **Demostración de Propiedades** (`demostracion_de_propiedades`)
  - [[demostracion_de_propiedades_teoria]] - Razonamiento Ecuacional e Inducción Estructural
  - [[demostracion_de_propiedades_practica]] - Práctica de Razonamiento e Inducción
  - [[demostracion_de_propiedades_guia]] - Guía de Ejercicios N° 2

- **Sistemas Deductivos y Deducción Natural** (`sistemas_deductivos_y_deduccion_natural`) — proposicional
  - [[sistemas_deductivos_y_deduccion_natural_teoria]] - Teoría de Sistemas Deductivos y Deducción Natural
  - [[sistemas_deductivos_y_deduccion_natural_practica]] - Práctica de Deducción Natural (LJ y LK)
  - [[sistemas_deductivos_y_deduccion_natural_guia]] - Guía de Ejercicios N° 3
  - **Lógica Proposicional**: [[sistemas_deductivos_y_deduccion_natural_teoria]] — cubierto como base de deduccion natural

- **Cálculo Lambda Tipado** (`calculo_lambda_tipado`)
  - [[calculo_lambda_tipado_teoria]] - Teoría de Cálculo Lambda Tipado
  - [[calculo_lambda_practica]] - Práctica de Cálculo Lambda Tipado
  - [[calculo_lambda_guia]] - Guía de Ejercicios N° 4 (27 ejercicios, todos resueltos)

## Temas — 2P

- **Unificación e Inferencia de Tipos** (`unificacion_e_inferencia`)
  - [[unificacion_e_inferencia_de_tipos_teoria]] - Teoría de Unificación e Inferencia de Tipos
  - [[unificacion_e_inferencia_practica]] - Práctica de Inferencia de Tipos
  - [[unificacion_e_inferencia_guia]] - Guía de Ejercicios N° 5 (10 ejercicios, todos resueltos)
  - **Algoritmo W**: [[unificacion_e_inferencia_de_tipos_teoria]] — Algoritmo W/I para inferencia de tipos · [[tipos_ejercicio/inferencia_algoritmo_w]] — ejercicios paso a paso

- **Interpretación** (`interpretacion`)
  - [[interpretacion_teoria]] - Teoría de Interpretación

- **Lógica de Primer Orden** (`logica_de_primer_orden`)
  - [[logica_de_primer_orden_teoria]] - Teoría de Lógica de Primer Orden
  - [[logica_de_primer_orden_guia]] - Guía de Ejercicios N° 6 (16 ejercicios, todos resueltos)

- **Resolución** (`resolucion`)
  - [[resolucion_teoria]] - Teoría de Resolución
  - [[resolucion_sld_y_prolog_teoria]] - Resolución SLD y Semántica de Prolog
  - [[resolucion_practica]] - Práctica de Resolución en LPO
  - [[resolucion_guia]] - Guía de Ejercicios N° 7
  - **Cláusulas de Horn**: [[resolucion_sld_y_prolog_teoria]] — cubierto como fundamento de resolucion SLD

- **Programación Lógica (Prolog)** (`programacion_logica`)
  - [[resolucion_sld_y_prolog_teoria]] - Resolución SLD y Semántica de Prolog
  - [[programacion_logica_practica]] - Práctica de Programación Lógica (Parte 1)
  - [[programacion_logica_guia]] - Guía de Ejercicios N° 8

- **Programación Orientada a Objetos (Smalltalk)** (`programacion_orientada_objetos`)
  - [[programacion_orientada_objetos_teoria]] - Teoría de Programación Orientada a Objetos (Smalltalk)
  - [[programacion_orientada_objetos_guia]] - Guía de Ejercicios N° 9

- **Correspondencia Curry-Howard** (`correspondencia_curry_howard`)
  - [[correspondencia_curry_howard_y_recursion_teoria]] - Correspondencia Curry-Howard y Recursión

## Tipos de ejercicio

### Van en tu 1P
- [[tipos_ejercicio/haskell_fold_tipo_arboles]] — Definir fold/rec para tipo algebraico nuevo
- [[tipos_ejercicio/haskell_funciones_sobre_arboles]] — Implementar funciones vía fold (preorder, map, nivel, variables, etc.)
- [[tipos_ejercicio/haskell_currificacion_evaluacion_parcial]] — fold que devuelve función (Int -> ...) con evaluación parcial
- [[tipos_ejercicio/haskell_recursion_primitiva_rec]] — Cuándo usar rec en lugar de fold
- [[tipos_ejercicio/induccion_estructural_arboles]] — Demostración por inducción sobre tipos árbol
- [[tipos_ejercicio/deduccion_natural_intuicionista]] — Árbol de deducción natural intuicionista
- [[tipos_ejercicio/lambda_tipado_extension_adt]] — Reglas de tipado para extensión ADT del cálculo lambda
- [[tipos_ejercicio/lambda_tipado_semantica_adt]] — Valores y semántica operacional para extensión ADT
- [[tipos_ejercicio/lambda_tipado_reduccion_pasos]] — Reducción paso a paso de término lambda
- [[tipos_ejercicio/lambda_habitantes]] — Cálculo Lambda: tipos habitados y construcción del habitante
- [[tipos_ejercicio/lambda_sintaxis_arbol]] — Cálculo Lambda: parentización y árbol sintáctico

> Los dos últimos son material de **1P** por su tema (`calculo_lambda_tipado`, bloque "Sistemas de
> tipos y reducción"), aunque sus apariciones registradas caigan dentro de ejercicios de 2P
> (habitación por resolución, rectificación de términos antes de inferir). No es una reubicación de
> programa: es la misma técnica reaparecida como sub-habilidad de otro bloque.

### Van en tu 2P
- [[tipos_ejercicio/inferencia_algoritmo_w]] — Inferencia de tipos con Algoritmo W/I paso a paso
- [[tipos_ejercicio/deduccion_natural_lpo]] — Deducción natural con cuantificadores LPO (∃E, ∀I, ∃I)
- [[tipos_ejercicio/lpo_unificacion]] — LPO: unificación de términos y tabla de MGU
- [[tipos_ejercicio/lpo_semantica_modelos]] — LPO: semántica, interpretaciones y contramodelos
- [[tipos_ejercicio/resolucion_forma_clausal]] — Transformar LPO a forma clausal (CNF + Skolemización)
- [[tipos_ejercicio/resolucion_por_contradiccion]] — Refutación por contradicción (negar meta + derivar □)
- [[tipos_ejercicio/resolucion_sld_justificacion]] — Justificar si la resolución fue SLD o no
- [[tipos_ejercicio/prolog_listas_append]] — Operaciones sobre listas con `append` (sublista, tokenizar, permutacion...)
- [[tipos_ejercicio/prolog_generar_testear]] — Generate & test con generadores infinitos (diagonalización)
- [[tipos_ejercicio/prolog_maximo_doble_not]] — Máximo/mínimo global con doble negación (`not`)
- [[tipos_ejercicio/prolog_reversibilidad]] — Análisis de reversibilidad de predicados
- [[tipos_ejercicio/smalltalk_method_lookup]] — Tabla de ejecución con self/super (Smalltalk)

## Parciales analizados

> Tomados bajo **el mismo reparto que el programa vigente (2C_2026)**. Los rótulos `1P`/`2P` de
> esta lista se leen tal cual: valen como simulacro completo del examen que vas a rendir.

- [[1.parcial_1C_2024_resolucion(1)]] - Primer Parcial 1C 2024
- [[1.parcial_1C_2024_recuperatorio_resolucion(1)]] - Recuperatorio Primer Parcial 1C 2024
- [[1.parcial_1C_2025_resolucion(1)]] - Primer Parcial 1C 2025
- [[1.parcial_1C_2025_resolucion(2)]] - Primer Parcial 1C 2025 (Res. Ernesto ITTIG)
- [[1.parcial_2C_2024_resolucion(1)]] - Primer Parcial 2C 2024
- [[1.parcial_2C_2025_resolucion(1)]] - Primer Parcial 2C 2025
- [[2.parcial_1C_2024_resolucion(1)]] - Segundo Parcial 1C 2024
- [[2.parcial_1C_2024_recuperatorio_resolucion(1)]] - Segundo Parcial 1C 2024 (Recuperatorio)
- [[2.parcial_2C_2024_resolucion(1)]] - Segundo Parcial 2C 2024
- [[2.parcial_2C_2025_resolucion(1)]] - Segundo Parcial 2C 2025
- [[2.parcial_2C_2025_recuperatorio(1)]] - Recuperatorio Segundo Parcial 2C 2025

## Clases de Repaso
- [[repaso_1P]] - Clase de Repaso Primer Parcial (2C 2025)

## Síntesis
- [[patrones_detectados]] - Síntesis de patrones de ejercicios en parciales
