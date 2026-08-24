---
nombre: Programación Orientada a Objetos (Smalltalk) — Teoría
parcial: 2P
programa: 2C_2026
tipo: teoria
tema: programacion_orientada_objetos
fuente: raw/clases/teo/12.teo_2P_programacion_orientada_objetos.pdf
paginas_relacionadas:
  - "[[interpretacion_teoria]]"
---

# Programación Orientada a Objetos (Smalltalk)

La Programación Orientada a Objetos (POO) es un paradigma donde el cómputo se entiende como una red de **objetos** que interactúan entre sí mediante el envío de **mensajes**. **Smalltalk** es el lenguaje canónico de este paradigma, donde "todo es un objeto".

## Conceptos Fundamentales

*   **Objeto**: Entidad que combina **estado** (datos/atributos) y **comportamiento** (métodos).
*   **Mensaje**: La única forma de interactuar con un objeto. Un objeto responde a un mensaje ejecutando un método.
*   **Clase**: Molde o plantilla que define el comportamiento y la estructura de sus **instancias**.
*   **Encapsulamiento**: El estado de un objeto es privado; solo es accesible y modificable a través de sus métodos.
*   **Herencia**: Mecanismo para definir nuevas clases a partir de otras existentes, permitiendo la reutilización de código y la especialización.
    *   **Subclase**: Clase que hereda de una **superclase**.
    *   **Sobreescritura (Override)**: Una subclase redefine un método de su superclase.
    *   **Clase Abstracta**: Clase diseñada para ser heredada pero que no debe tener instancias (ej: `Number`).

---

## Sintaxis de Smalltalk

Smalltalk se considera más un "entorno" que solo un lenguaje. Su sintaxis es mínima y se basa en el envío de mensajes.

### Tipos de Mensajes
1.  **Unarios**: Sin parámetros. Ej: `1 class`, `3 squared`.
2.  **Binarios**: Un operador y un argumento. Ej: `1 + 2`, `3 / 4`.
3.  **Keywords**: Tienen uno o más argumentos precedidos por dos puntos. Ej: `a at: 1 put: 'hola'`.

**Precedencia**: Unarios > Binarios > Keywords. De izquierda a derecha para mensajes del mismo tipo (excepto que se usen paréntesis).
*Ejemplo*: `1 + 2 * 3` en Smalltalk evalúa a `9` (porque `1+2` es `3`, y luego `3*3` es `9`), a menos que se escriba `1 + (2 * 3)`.

### Elementos del Lenguaje
*   **Variables locales**: Se declaran entre pipes `| x y |`.
*   **Asignación**: `:=`.
*   **Retorno**: `^`.
*   **Pseudo-variables**: `self` (el receptor actual), `super` (el receptor, pero busca métodos en la superclase), `nil`, `true`, `false`.
*   **Literales**: `$a` (carácter), `#simbolo` (símbolo), `'string'` (string), `#(1 2 3)` (array literal).

---

## Polimorfismo y Estructuras de Control

El **Polimorfismo** permite que distintos objetos respondan al mismo mensaje de maneras diferentes. Smalltalk lleva esto al extremo: **no existen palabras reservadas para `if`, `while` o `for`**. Se implementan mediante polimorfismo y envíos de mensajes.

### Ejemplo: El Condicional
Se define una clase `Boolean` con subclases `True` y `False`.
*   En `True`: el método `ifTrue: b1 ifFalse: b2` ejecuta `b1`.
*   En `False`: el mismo método ejecuta `b2`.
Esto permite que el programador extienda el lenguaje definiendo sus propias estructuras.

---

## Bloques (Closures)

Un bloque es un objeto que representa una secuencia de comandos diferida.
*   **Sintaxis**: `[ :x :y | x + y ]`.
*   **Evaluación**: Se activan con el mensaje `value`, `value:`, etc.
*   Los bloques capturan el contexto donde fueron creados (clausuras).

---

## Algoritmo de Method Dispatch

Cuando un objeto `O` recibe un mensaje con selector `S`, el sistema busca el método `M` a ejecutar:

1.  Comenzar la búsqueda en la clase `C` del objeto `O`.
2.  Si `C` define un método para `S`, devolver `M`.
3.  Si no, ir a la superclase de `C`.
4.  Si se llega a `nil` (encima de `Object`), enviar el mensaje `doesNotUnderstand:`.

### Diferencia entre `self` y `super`
*   `self m`: La búsqueda de `m` comienza en la **clase del objeto receptor**.
*   `super m`: La búsqueda de `m` comienza en la **superclase de la clase donde está escrito el método actual**.
*   *Nota*: En ambos casos, el receptor (`self`) es el mismo objeto.

---

## Manejo de Errores: `doesNotUnderstand:`
Si no se encuentra un método, el objeto recibe `doesNotUnderstand:`. Por defecto, esto lanza una excepción, pero puede ser sobreescrito para implementar técnicas como **proxies** o **reificación** de mensajes.

---

## Estructuras de Datos Comunes
*   **Colecciones**: `OrderedCollection`, `Set`, `Dictionary`. Usan el mensaje `do: [ :e | ... ]` para iterar.
*   **Streams**: Objetos que representan sucesiones (posiblemente infinitas). Aceptan el mensaje `next` o `prox`.
