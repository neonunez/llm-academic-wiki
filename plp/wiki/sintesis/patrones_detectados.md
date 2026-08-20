---
nombre: Patrones detectados
tipo: sintesis
tema: cross-tema
fuente: "wiki/parciales_analizados/"
---
# Patrones detectados — Paradigmas de Programación (PLP)

Generado por /tipos_ejercicio_scan. Usar como input de /tipos_ejercicio_run.

## Resumen

- Total patrones: 9
- Patrones 1P: 3
- Patrones 2P: 5
- Patrones cross-parcial: 1 (Deducción Natural)

## Patrones

### Esquemas de Recursión (Haskell)

- **Descripcion:** Definición de `fold` y `rec` para tipos algebraicos (Rose trees, FS, etc.) y su uso para implementar funciones.
- **Parcial:** 1P
- **Tema:** Programación Funcional
- **Cross-parcial:** no
- **Frecuencia:** 4 apariciones
- **Apariciones:**
  - [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 1: Rose-trees
  - [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 1: FileSystem (Rose-tree)
  - [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 1: Árboles n-arios
  - [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 1: Estructura de datos recursiva

### Inducción Estructural

- **Descripcion:** Demostración de propiedades de funciones Haskell sobre tipos inductivos.
- **Parcial:** 1P
- **Tema:** Demostración de Propiedades
- **Cross-parcial:** no
- **Frecuencia:** 3 apariciones
- **Apariciones:**
  - [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 2a: Tamaño de árboles truncados
  - [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 2: Propiedades de fold
  - [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 2: Inducción sobre listas

### Deducción Natural

- **Descripcion:** Pruebas formales de lógica proposicional o de primer orden usando reglas de Gentzen y PBC/RAA.
- **Parcial:** ambos
- **Tema:** Sistemas Deductivos
- **Cross-parcial:** si
- **Frecuencia:** 5 apariciones
- **Apariciones:**
  - [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 2b: Lógica proposicional
  - [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ejercicio 3b: Lógica de primer orden (Beard Paradox)
  - [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ejercicio 3b: Propiedades de predicados
  - [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 2: Lógica proposicional clásica

### Extensiones del Cálculo Lambda Tipado

- **Descripcion:** Agregar nuevos tipos (listas, colas, anillos) y reglas semánticas/de tipado al cálculo lambda.
- **Parcial:** 1P
- **Tema:** Cálculo Lambda
- **Cross-parcial:** no
- **Frecuencia:** 3 apariciones
- **Apariciones:**
  - [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 3: Anillos y rotación
  - [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 3: Listas y head/tail
  - [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 3: Pares y proyecciones

### Forma Clausal y Skolemización

- **Descripcion:** Conversión de fórmulas de lógica de primer orden a un conjunto de cláusulas.
- **Parcial:** 2P
- **Tema:** Resolución Lógica
- **Cross-parcial:** no
- **Frecuencia:** 4 apariciones
- **Apariciones:**
  - [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ejercicio 2a: Vacío y Unión
  - [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ejercicio 2a: Predicados de conjuntos
  - [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ejercicio 2a: Cuantificadores anidados

### Resolución Lógica y SLD

- **Descripcion:** Derivación de la cláusula vacía y justificación de si la resolución es SLD o Lineal.
- **Parcial:** 2P
- **Tema:** Resolución Lógica
- **Cross-parcial:** no
- **Frecuencia:** 4 apariciones
- **Apariciones:**
  - [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ejercicio 2c/d: Resolución no-SLD (ramificada)
  - [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ejercicio 2c/d: Resolución lineal
  - [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ejercicio 2c/d: Resolución SLD (cláusulas de Horn)

### Inferencia de Tipos (Algoritmo I)

- **Descripcion:** Aplicación del algoritmo de inferencia (W/I) para deducir tipos y MGU en términos lambda.
- **Parcial:** 2P
- **Tema:** Unificación e Inferencia
- **Cross-parcial:** no
- **Frecuencia:** 3 apariciones
- **Apariciones:**
  - [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ejercicio 3a: Colas y map
  - [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ejercicio 3a: Listas y fold
  - [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ejercicio 3a: Árboles y recursión

### Programación Lógica (Prolog)

- **Descripcion:** Implementación de predicados reversibles, uso de NAF (not) y generación justa (fairness).
- **Parcial:** 2P
- **Tema:** Programación Lógica
- **Cross-parcial:** no
- **Frecuencia:** 4 apariciones
- **Apariciones:**
  - [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ejercicio 1: Melodías y secuencias (Fairness)
  - [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ejercicio 1: Grafos y caminos (NAF)
  - [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ejercicio 1: Árboles y ancestros

### Modelo de Objetos (Smalltalk)

- **Descripcion:** Diseño de jerarquías de clases, dispatch dinámico, herencia y encapsulamiento.
- **Parcial:** 2P
- **Tema:** POO
- **Cross-parcial:** no
- **Frecuencia:** 2 apariciones
- **Apariciones:**
  - [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ejercicio 4: Extensiones de sistema
  - [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ejercicio 4: Jerarquía de Figuras
