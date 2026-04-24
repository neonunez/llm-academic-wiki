---
nombre: Programación Orientada a Objetos — Guía de Ejercicios
parcial: 2P
tipo: guia
tema: programacion_orientada_objetos
fuente: raw/guias_practicas/8.guia_2P_programacion_orientada_a_objetos.pdf
paginas_relacionadas:
  - "[[programacion_orientada_objetos_teoria]]"
---

# Programación Orientada a Objetos — Guía de Ejercicios

## Indice de ejercicios

### Introducción y Comparación de Paradigmas
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 1 | Operadores de igualdad y diferencias con Haskell/Prolog | ⚪ No |
| Ej. 2 | Jerarquía de figuras y comparación paradigmática | 🔴 Si |
| Ej. 3 | Modelo de datos personales y comparación | ⚪ No |
| Ej. 4 | Potencial de los lenguajes y ventajas/desventajas | ⚪ No |

### Objetos y Mensajes
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 5 | Identificación de receptores y colaboradores | 🔴 Si |
| Ej. 6 | Evaluación de expresiones en Pharo | ⚪ No |
| Ej. 7 | Conceptos básicos: Unario, Binario, Keyword, Símbolo | 🔴 Si |

### Bloques, Métodos y Colecciones
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 8 | Evaluación de bloques y ámbitos | 🔴 Si |
| Ej. 9 | Closures: diferencias con Haskell lambdas y Prolog | 🔴 Si |
| Ej. 10 | Diferencias entre colecciones: OrderedCollection, Bag, Set, etc. | 🔴 Si |
| Ej. 11 | Ejercicio `factorialsList` | ⚪ No |
| Ej. 12 | Mensajes de orden superior: `collect:`, `select:`, `inject:into:` | 🔴 Si |
| Ej. 13 | Traza de ejecución de métodos con bloques | 🔴 Si |
| Ej. 14 | Implementación de `curry`, `flip` y `repetirVeces:` | 🔴 Si |
| Ej. 15 | Bloques infinitos en `BlockClosure` | ⚪ No |

### Method Dispatch, self y super
| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 16 | Verdadero/Falso sobre clases y despacho | 🔴 Si |
| Ej. 17 | Comportamiento de `self` y `super` | 🔴 Si |
| Ej. 18 | Jerarquía de Figuras y responsabilidad de subclase | 🔴 Si |
| Ej. 19 | Implementación de `mcm:` y diagrama de secuencia | 🔴 Si |
| Ej. 20 | Ejercicio `Counter` y `FlexibleCounter` | 🔴 Si |
| Ej. 21 | Jerarquía X e Y: despacho complejo | 🔴 Si |
| Ej. 22 | Jerarquía A, B, C: despacho y super | 🔴 Si |
| Ej. 23 | Sistema de Monedas y Conversiones | 🔴 Si |

---

## Introducción y Comparación de Paradigmas

### Ejercicio 1 — Operadores de Igualdad

**Enunciado**
Dado el siguiente código de Smalltalk:
```smalltalk
var1 := 'un texto' copy.
var2 := 'un texto' copy.
var3 := var1.

var1 = var2
var1 == var2
var1 == var3
```
I. ¿Cuál es el resultado de las últimas tres líneas? ¿Por qué?
II. Comparar con Haskell y Prolog. Listar operadores similares.

**Explicacion**
Diferencia entre igualdad semántica (`=`) e identidad de objeto (`==`). Es un concepto fundamental en POO con estado.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 2 — Jerarquía de Figuras

**Enunciado**
Modelo de figuras con `dibujar`:
```smalltalk
( Círculo new radio: 5 ) dibujar.
( Rectángulo new base: 4 altura: 3 ) dibujar.
```
I. ¿Cómo se modelaría en Haskell?
II. Cambios al agregar `Triángulo` en Smalltalk vs Haskell.
III. ¿Cómo se resolvería en Prolog? Diferencias.

**Explicacion**
Contrasta el polimorfismo de objetos con el Pattern Matching de los lenguajes funcionales y la unificación de Prolog.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Objetos y Mensajes

### Ejercicio 5 — Receptor y Colaboradores

**Enunciado**
Identificar receptor y colaboradores en:
a) `10 numberOfDigitsInBase: 2`
b) `10 factorial`
f) `1 = 2 ifTrue: [ 'what!?' ]`
h) `'Hello World' indexOf: $o startingAt: 6`
j) `Object subclass: #SnakesAndLadders ...`

**Explicacion**
Entender la estructura "Objeto Mensaje: Argumentos". Recordar que en Smalltalk, hasta la definición de una clase es un envío de mensaje.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Bloques, Métodos y Colecciones

### Ejercicio 8 — Evaluación de Bloques

**Enunciado**
Indicar valor devuelto o error:
a) `[:x | x + 1] value: 2`
b) `[|x| x := 10. x + 12] value`
e) `[:x | [:y | x + 1]] value: 2`
g) `[:x :y :z | x + y + z] valueWithArguments: #(1 2 3)`

**Explicacion**
Fundamentos de sintaxis de bloques (clousures) y pasaje de parámetros.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 12 — Mensajes de Orden Superior

**Enunciado**
Mostrar ejemplos de uso y qué evalúan:
a) `#collect:`
b) `#select:`
c) `#inject:into:`
d) `#reduce: (o #fold:)`
f) `#do:`

**Explicacion**
Equivalentes a `map`, `filter`, `fold` de Haskell, pero aplicados a colecciones de objetos.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 14 — Curry y Flip

**Enunciado**
Implementar métodos para:
a) `#curry`: convierte un bloque de dos parámetros en uno currificado.
b) `#flip`: devuelve un bloque similar con parámetros invertidos.
c) `#repetirVeces:`: envía un bloque a un número.

**Explicacion**
Implementación de conceptos funcionales dentro del modelo de objetos usando bloques.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Method Dispatch, self y super

### Ejercicio 18 — Responsabilidad de Subclase

**Enunciado**
Clase `Figura` con métodos `perimetro` (`^self lados sumarTodos`) y `lados` (`^self subclassResponsability`).
Implementar `Cuadrado` y `Círculo`. Para círculo, considerar que no tiene lados (aproximar $\pi$ por 3,14).

**Explicacion**
Uso de métodos abstractos para definir comportamiento genérico en la superclase que depende de implementaciones específicas en las subclases.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 20 — Counter y FlexibleCounter

**Enunciado**
Jerarquía de contadores con métodos `initialize`, `next`, `nextIf: condition`.
Analizar el despacho para:
```smalltalk
aCounter := FlexibleCounter new: [:v | v + 2].
aCounter nextIf: true.
```

**Explicacion**
Ejercicio clásico de parcial que evalúa el seguimiento de `self` y `super` a través de varios niveles de herencia.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

### Ejercicio 23 — Sistema de Monedas

**Enunciado**
Agregar a `Number` los métodos `pesos`, `dolares`, `reales`. Implementar la clase `Moneda` y subclases.
Implementar `Moneda >> cambioDe: #dolar a: #peso es: 1295`.
Permitir sumar monedas de distinto tipo: `20 dolares + 25900 pesos`.

**Explicacion**
Uso del patrón **Double Dispatch** para resolver operaciones entre objetos de distintas clases (o subclases) de forma elegante y extensible.

**Resolucion paso a paso**
[PENDIENTE — sesion de resolucion]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/smalltalk_method_lookup]]
