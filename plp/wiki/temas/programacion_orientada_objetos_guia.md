---
nombre: Programación Orientada a Objetos — Guía de Ejercicios
parcial: 2P
programa: 2C_2026
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
Valuación: $P = V$, $Q = V$, $S = F$, $T = F$. Se evalúa de adentro hacia afuera usando las tablas de los conectivos ($\Leftrightarrow$ vale $V$ sólo si ambos lados coinciden).

| # | Fórmula | Evaluación | Valor |
|---|---|---|---|
| I | $\neg P \vee Q$ | $F \vee V$ | **V** |
| II | $P \vee (S \wedge T) \vee Q$ | $V \vee (F \wedge F) \vee V = V \vee F \vee V$ | **V** |
| III | $\neg(Q \vee S)$ | $\neg(V \vee F) = \neg V$ | **F** |
| IV | $(\neg P \vee S) \Leftrightarrow (\neg P \wedge \neg S)$ | izq: $F \vee F = F$; der: $F \wedge V = F$; $F \Leftrightarrow F$ | **V** |
| V | $(P \vee S) \wedge (T \vee Q)$ | $(V \vee F) \wedge (F \vee V) = V \wedge V$ | **V** |
| VI | $((P \vee S) \wedge (T \vee Q)) \Leftrightarrow (P \vee (S \wedge T) \vee Q)$ | $V \Leftrightarrow V$ (por V y II) | **V** |
| VII | $\neg Q \wedge \neg S$ | $F \wedge V$ | **F** |

Observación: IV da $V$ aunque ambos lados sean falsos — el bicondicional mide *coincidencia*, no verdad. Y VI resulta $V$ porque ambas fórmulas valen $V$ *en esta valuación*, lo cual no significa que sean lógicamente equivalentes (para eso habría que chequear las 16 valuaciones).

**Chuleta**
> 1. Sustituir $P=Q=V$, $S=T=F$ → 2. evaluar de adentro hacia afuera → 3. $\Leftrightarrow$ es $V$ sólo si ambos lados coinciden (aunque los dos sean $F$) → 4. Resultados: I=V, II=V, III=F, IV=V, V=V, VI=V, VII=F.

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
**Punto de partida: cómo se ve en Smalltalk**

```smalltalk
Object subclass: #Figura.
Figura >> dibujar
    ^ self subclassResponsibility

Figura subclass: #Circulo instanceVariableNames: 'radio'.
Circulo >> radio: unNumero      radio := unNumero. ^ self
Circulo >> dibujar              ^ 'circulo de radio ', radio printString

Figura subclass: #Rectangulo instanceVariableNames: 'base altura'.
Rectangulo >> base: b altura: h    base := b. altura := h. ^ self
Rectangulo >> dibujar              ^ 'rectangulo de ', base printString, 'x', altura printString
```

La selección del código a ejecutar la hace el **method lookup** sobre la clase del receptor: cada figura "sabe" dibujarse. No hay ningún `case` ni `if` sobre el tipo.

**I. ¿Cómo se modelaría en Haskell?**

*Opción A — tipo algebraico + pattern matching (la idiomática):*

```haskell
data Figura = Circulo Double
            | Rectangulo Double Double

dibujar :: Figura -> String
dibujar (Circulo r)      = "circulo de radio " ++ show r
dibujar (Rectangulo b h) = "rectangulo de " ++ show b ++ "x" ++ show h
```

*Opción B — clase de tipos (más parecida a la jerarquía de objetos):*

```haskell
class Dibujable a where
  dibujar :: a -> String

data Circulo    = Circulo Double
data Rectangulo = Rectangulo Double Double

instance Dibujable Circulo where
  dibujar (Circulo r) = "circulo de radio " ++ show r

instance Dibujable Rectangulo where
  dibujar (Rectangulo b h) = "rectangulo de " ++ show b ++ "x" ++ show h
```

La diferencia clave: en A el despacho es **por constructor, dentro de una función** (todas las alternativas viven juntas); en B es **por tipo, resuelto en compilación** vía el diccionario de instancia (una alternativa por instancia, igual que un método por clase).

**II. Cambios al agregar `Triángulo`**

| | Agregar un **tipo** nuevo (`Triángulo`) | Agregar una **operación** nueva (`area`) |
|---|---|---|
| Smalltalk (objetos) | **Barato**: se crea la subclase `Triangulo` con su `dibujar`. No se toca una sola línea del código existente. | **Caro**: hay que agregar el método `area` en cada clase de la jerarquía. |
| Haskell, opción A (`data`) | **Caro**: hay que modificar el `data Figura` y **todas** las funciones que hacen pattern matching sobre él (`dibujar`, `area`, ...). El compilador al menos avisa con `-Wincomplete-patterns`. | **Barato**: se escribe una función nueva con todos los casos, sin tocar nada de lo anterior. |
| Haskell, opción B (typeclass) | **Barato**: nuevo `data` + `instance Dibujable Triangulo`. | **Caro**: agregar el método a la `class` y a todas las instancias. |

Esto es exactamente el **problema de la expresión** (*expression problem*): los objetos son fáciles de extender por **tipos** y difíciles por **operaciones**; los tipos algebraicos con pattern matching, al revés. La descomposición del código es la traspuesta de la matriz tipo × operación.

Ventaja adicional de Smalltalk: la extensión se hace **sin recompilar ni tocar la superclase**, incluso en tiempo de ejecución. Ventaja de Haskell: el compilador garantiza exhaustividad — si olvidás un caso te enterás compilando, mientras que en Smalltalk te enterás con un `doesNotUnderstand:` en runtime.

**III. ¿Cómo se resolvería en Prolog?**

```prolog
dibujar(circulo(R), Texto) :-
    format(atom(Texto), 'circulo de radio ~w', [R]).
dibujar(rectangulo(B, H), Texto) :-
    format(atom(Texto), 'rectangulo de ~wx~w', [B, H]).

% agregar Triángulo = agregar UNA cláusula, sin tocar las anteriores
dibujar(triangulo(B, H), Texto) :-
    format(atom(Texto), 'triangulo de base ~w y altura ~w', [B, H]).
```

Diferencias con el modelo de objetos:

- **Quién selecciona**: no hay method lookup por clase; selecciona la **unificación** de la cabeza de la cláusula con el objetivo, más el backtracking si varias unifican. La figura es un **término inerte** (`circulo(5)`), no un objeto: no tiene comportamiento propio ni estado encapsulado.
- **Extensibilidad**: agregar un tipo es barato (una cláusula más), igual que en Smalltalk. Agregar una operación también es barato (un predicado nuevo). Prolog escapa parcialmente al problema de la expresión, pero al precio de no tener encapsulamiento ni chequeos.
- **Direccionalidad**: los predicados son relaciones, no funciones. Se puede preguntar `dibujar(F, T)` con `F` libre y Prolog **genera** las figuras posibles. Ningún mensaje de Smalltalk se puede "correr para atrás".
- **Herencia**: no existe. Si se la quiere, se simula con predicados explícitos (`es_un(cuadrado, rectangulo).`) y una regla que suba por la jerarquía — o sea, hay que programar a mano el algoritmo de lookup.
- **Encapsulamiento**: nulo. Cualquier cláusula puede inspeccionar la estructura interna del término; en Smalltalk las variables de instancia son privadas y sólo se llega a ellas por mensajes.

**Chuleta**
> 1. Smalltalk: una subclase por figura, `dibujar` polimórfico, despacho por clase del receptor en runtime → 2. Haskell: `data` + pattern matching (todo el despacho junto en una función) o typeclass + instancias (una por tipo) → 3. Agregar `Triángulo`: trivial en Smalltalk y en typeclasses, obliga a tocar todas las funciones con `data`; agregar una **operación** es al revés = **problema de la expresión** → 4. Prolog: una cláusula por figura, selecciona la **unificación** de la cabeza + backtracking; términos inertes sin estado ni herencia, pero relaciones reversibles (`dibujar(F,T)` genera).

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
**Definiciones que hay que aplicar**

- **Receptor**: el objeto al que llega el mensaje. Es *el único* que decide qué método se ejecuta (el lookup arranca en su clase). Va siempre a la izquierda del selector.
- **Selector**: el nombre del mensaje. En los keyword se escribe con todos sus `:` juntos (`#indexOf:startingAt:` es **un** selector, no dos).
- **Colaboradores**: los demás objetos que participan del envío, es decir los **argumentos**. No influyen en la elección del método (salvo que se los use explícitamente para un segundo envío → *double dispatch*).
- **Precedencia**: unarios > binarios > keyword; a igual categoría, de izquierda a derecha.

**Análisis expresión por expresión**

| | Expresión | Receptor (clase) | Selector | Tipo | Colaboradores | Resultado |
|---|---|---|---|---|---|---|
| a | `10 numberOfDigitsInBase: 2` | `10` (`SmallInteger`) | `#numberOfDigitsInBase:` | keyword | `2` (`SmallInteger`) | `4` (10 en binario es `1010`) |
| b | `10 factorial` | `10` (`SmallInteger`) | `#factorial` | unario | **ninguno** | `3628800` |
| f | `1 = 2 ifTrue: [ 'what!?' ]` | *dos envíos*, ver abajo | | | | `nil` |
| h | `'Hello World' indexOf: $o startingAt: 6` | `'Hello World'` (`String`) | `#indexOf:startingAt:` | keyword (2 args) | `$o` (`Character`), `6` (`SmallInteger`) | `8` |
| j | `Object subclass: #SnakesAndLadders ...` | la **clase** `Object` (instancia de `Object class`) | `#subclass:instanceVariableNames:classVariableNames:package:` | keyword (4 args) | `#SnakesAndLadders` (`Symbol`) y los `String` de configuración | la clase nueva |

**Detalle de f) — el caso con trampa**

Por precedencia, el binario `=` se resuelve **antes** que el keyword `ifTrue:`, así que la expresión es `(1 = 2) ifTrue: [ 'what!?' ]`. Son **dos** envíos encadenados:

| # | Envío | Receptor | Selector | Colaborador | Devuelve |
|---|---|---|---|---|---|
| 1 | `1 = 2` | `1` (`SmallInteger`) | `#=` (binario) | `2` | `false` |
| 2 | `false ifTrue: [...]` | `false` (única instancia de `False`) | `#ifTrue:` (keyword) | el bloque `[ 'what!?' ]` (`BlockClosure`) | `nil` |

Lo importante: el condicional **no es sintaxis**, es un mensaje polimórfico. `True >> ifTrue: aBlock` hace `^ aBlock value` y `False >> ifTrue: aBlock` hace `^ nil`. Como el receptor es `false`, el bloque nunca se evalúa y el valor de toda la expresión es `nil`.

**Detalle de h)** — `#indexOf:startingAt:` es un solo mensaje con dos argumentos, no `indexOf:` seguido de `startingAt:`. Contando desde 1: `H`(1) `e`(2) `l`(3) `l`(4) `o`(5) `␣`(6) `W`(7) `o`(8)... Buscando `$o` a partir de la posición 6, la primera aparición está en **8** (la `o` de la posición 5 queda descartada por el `startingAt:`).

**Detalle de j) — el caso conceptualmente más fuerte**

Definir una clase **no es una construcción sintáctica del lenguaje**: es un envío de mensaje común y corriente a un objeto que resulta ser una clase. `Object` es un objeto (instancia de su metaclase `Object class`), recibe el mensaje `subclass:instanceVariableNames:classVariableNames:package:`, y como efecto crea y registra la clase nueva devolviéndola. Corolario: se pueden crear clases programáticamente en runtime, y el sistema de clases es reflexivo — todo, incluida la definición de clases, se hace enviando mensajes.

**Chuleta**
> 1. Receptor = objeto a la izquierda, es el que decide el método (lookup arranca en su clase); colaboradores = argumentos → 2. Precedencia unario > binario > keyword, izq. a der. → 3. Un keyword con varias partes es **un** selector (`#indexOf:startingAt:`) → 4. `1 = 2 ifTrue: [...]` = `(1 = 2) ifTrue: [...]`: receptor final es `false`, devuelve `nil`; el `if` es un mensaje polimórfico a `True`/`False`, no sintaxis → 5. `Object subclass: #X ...` = mensaje a la clase `Object`: hasta definir clases es enviar mensajes.

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
**Evaluación item por item**

| | Expresión | Valor devuelto | Por qué |
|---|---|---|---|
| a | `[:x \| x + 1] value: 2` | `3` | Bloque de un parámetro activado con `value:`. La aridad del bloque coincide con la del mensaje. |
| b | `[\|x\| x := 10. x + 12] value` | `22` | `\|x\|` declara una **temporal del bloque** (no un parámetro), por eso se activa con `value` sin argumentos. Un bloque devuelve el valor de su **última** sentencia: `10 + 12`. |
| e | `[:x \| [:y \| x + 1]] value: 2` | **un `BlockClosure`**, *no* `3` | El cuerpo del bloque externo es un literal de bloque: al activarlo se devuelve el bloque interno `[:y \| x + 1]`, todavía sin evaluar, con `x` **capturado** valiendo 2. |
| g | `[:x :y :z \| x + y + z] valueWithArguments: #(1 2 3)` | `6` | `valueWithArguments:` recibe una **colección** con los argumentos; su tamaño debe coincidir con `numArgs` del bloque. |

**Sobre e) — es el punto del ejercicio**

Es currificación explícita. Para llegar al número hay que activar los dos niveles:

```smalltalk
| f |
f := [ :x | [ :y | x + 1 ] ].
(f value: 2) value: 99.   "→ 3 — el bloque interno ignora y, pero x sigue valiendo 2"
```

Es la evidencia de que el bloque es una **clausura**: sobrevive al retorno del contexto que lo creó y se lleva su entorno adentro. Análogo directo a `\x -> \y -> x + 1` en Haskell.

**Ámbitos: qué ve un bloque**

```smalltalk
| t b |
t := 1.
b := [ t + 10 ].     "captura la variable t, no su valor"
t := 5.
b value.             "→ 15, no 11"
```

Un bloque ve, en este orden: sus **parámetros**, sus **temporales** (`|x|`), las temporales y parámetros del **método/bloque que lo contiene**, las **variables de instancia** del receptor, y `self`/`super`/`thisContext` del método donde fue escrito. Captura las **variables** (por referencia), no una copia de sus valores.

**Errores frecuentes que pueden aparecer en variantes del ejercicio**

```smalltalk
[:x | x + 1] value.                      "ERROR: wrong number of arguments (espera 1, recibe 0)"
[:x | x + 1] value: 1 value: 2.          "ERROR: wrong number of arguments"
[:x :y | x + y] valueWithArguments: #(1). "ERROR: la colección debe tener numArgs elementos"
[] value.                                 "→ nil (bloque vacío)"
```

Y el clásico: `^` dentro de un bloque **no** devuelve del bloque, sino que hace *non-local return* del **método** que lo contiene (si ese método ya retornó, el bloque falla con `BlockCannotReturn`). El valor de un bloque es su última sentencia, sin `^`.

**Chuleta**
> 1. Bloque = objeto (`BlockClosure`); se activa con `value` / `value:` / `value:value:` / `valueWithArguments:` (colección) → 2. `[:x | ...]` = parámetro; `[|x| ...]` = temporal → se activa con `value` pelado → 3. Devuelve **la última sentencia**, sin `^` → 4. Bloque que devuelve bloque = bloque, no número: hay que activar los dos niveles (`(f value: 2) value: 9`) → 5. Captura **variables** del contexto, no valores (clausura) → 6. Aridad incorrecta = error; `^` adentro retorna del **método**, no del bloque.

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
Todos estos mensajes están definidos en `Collection` (y refinados en las subclases), y todos reciben un **bloque** como colaborador. Son el equivalente a `map`, `filter` y `fold` de Haskell, pero enviados como mensajes a la colección.

**a) `#collect:` — el `map`**

Aplica el bloque a cada elemento y devuelve una colección nueva con los resultados.

```smalltalk
#(1 2 3 4) collect: [ :x | x * x ]                 "→ #(1 4 9 16)"
(1 to: 5) collect: [ :x | x factorial ]            "→ #(1 2 6 24 120)"
#('hola' 'chau') collect: [ :s | s asUppercase ]   "→ #('HOLA' 'CHAU')"
```

Ojo: **preserva la clase del receptor**. Un `Set` devuelve `Set` (y por lo tanto el resultado puede *achicarse* si el bloque produce duplicados); un `Dictionary` colecta sobre los **valores**.

```smalltalk
(Set withAll: #(1 -1 2)) collect: [ :x | x abs ]   "→ un Set con 2 elementos, no 3"
```

**b) `#select:` — el `filter`**

Devuelve los elementos que satisfacen el predicado. Su dual es `#reject:`.

```smalltalk
#(1 2 3 4 5) select: [ :x | x even ]               "→ #(2 4)"
#(1 2 3 4 5) reject: [ :x | x even ]               "→ #(1 3 5)"
#(1 2 3 4 5) detect: [ :x | x > 3 ] ifNone: [ 0 ]  "→ 4 (el primero que cumple)"
#(1 2 3 4 5) count: [ :x | x odd ]                 "→ 3"
#(1 2 3) anySatisfy: [ :x | x > 2 ]                "→ true"
```

**c) `#inject:into:` — el `foldl` con semilla**

Recorre acumulando. El bloque recibe **primero el acumulador y después el elemento**, en ese orden.

```smalltalk
#(1 2 3 4) inject: 0 into: [ :acc :x | acc + x ]           "→ 10"
#(1 2 3 4) inject: 1 into: [ :acc :x | acc * x ]           "→ 24"
#('a' 'b' 'c') inject: '' into: [ :acc :x | acc , x ]      "→ 'abc'"
#(3 1 4 1 5) inject: 0 into: [ :acc :x | acc max: x ]      "→ 5"

"collect: y select: se pueden reimplementar con inject:into:"
#(1 2 3) inject: OrderedCollection new
         into: [ :acc :x | acc add: x * 2; yourself ]      "→ an OrderedCollection(2 4 6)"
```

Como tiene semilla, **funciona sobre la colección vacía**: `#() inject: 0 into: [ :a :b | a + b ]` devuelve `0`.

**d) `#reduce:` / `#fold:` — el `foldl1`, sin semilla**

Igual que el anterior pero usando el primer elemento como valor inicial. El bloque recibe **dos elementos** de la colección, no un acumulador de otro tipo.

```smalltalk
#(3 1 4 1 5) reduce: [ :a :b | a max: b ]     "→ 5"
#(1 2 3 4) fold: [ :a :b | a + b ]            "→ 10"
#('Pa' 'ra' 'dig') fold: [ :a :b | a , b ]    "→ 'Paradig'"
#() reduce: [ :a :b | a + b ]                 "ERROR: colección vacía"
```

Regla práctica para elegir: si el acumulador es de **otro tipo** que los elementos, o la colección puede estar vacía → `inject:into:`. Si es del **mismo tipo** y la operación es asociativa (máximo, suma, concatenación) → `reduce:`/`fold:`.

**f) `#do:` — la iteración por efecto**

Evalúa el bloque para cada elemento y **devuelve el receptor**, no los resultados. Se usa por su efecto colateral (imprimir, mutar, acumular en una variable externa).

```smalltalk
#(1 2 3) do: [ :x | Transcript show: x printString; cr ]    "→ devuelve #(1 2 3)"

#(1 2 3) do: [ :x | Transcript show: x printString ]
         separatedBy: [ Transcript show: ', ' ]              "imprime: 1, 2, 3"

#(1 2 3) doWithIndex: [ :x :i | Transcript show: i printString, '->', x printString ]
#(1 2 3) reverseDo: [ :x | Transcript show: x printString ]  "imprime: 321"
```

**Tabla de equivalencias**

| Smalltalk | Haskell | Devuelve |
|---|---|---|
| `collect:` | `map` | colección nueva, misma clase que el receptor |
| `select:` / `reject:` | `filter p` / `filter (not . p)` | colección nueva con un subconjunto |
| `detect:ifNone:` | `find` | un elemento (o el valor del bloque `ifNone:`) |
| `inject:into:` | `foldl` | el acumulador |
| `reduce:` / `fold:` | `foldl1` | un elemento del mismo tipo (error si está vacía) |
| `do:` | `mapM_` | **el receptor** (se usa por efecto) |

Diferencia de fondo con Haskell: acá no hay funciones de orden superior "sueltas", hay **mensajes** enviados a la colección, y los bloques son objetos que viajan como colaboradores. Además las colecciones son **mutables**, así que `do:` con efectos es idiomático y no un caso raro.

**Chuleta**
> 1. `collect:` = map (conserva la clase del receptor; ojo `Set`, puede achicar) → 2. `select:`/`reject:` = filter y su dual; `detect:ifNone:` = find → 3. `inject: semilla into: [:acc :x | ...]` = foldl (**acumulador primero**; anda con colección vacía) → 4. `reduce:`/`fold:` = foldl1 sin semilla (mismo tipo, **error si está vacía**) → 5. `do:` = iterar por efecto y **devuelve el receptor**; variantes `do:separatedBy:`, `reverseDo:`, `doWithIndex:`.

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
La idea general: los bloques son objetos (instancias de `BlockClosure`), así que se les puede **agregar métodos** como a cualquier otra clase. Currificar o dar vuelta parámetros deja de ser una primitiva del lenguaje y pasa a ser comportamiento de un objeto.

**a) `#curry` — de binario a currificado**

```smalltalk
BlockClosure >> curry
    "[:x :y | ...]  →  [:x | [:y | ...]]"
    self numArgs = 2 ifFalse: [ ^ self error: 'curry espera un bloque de 2 parámetros' ].
    ^ [ :x | [ :y | self value: x value: y ] ]
```

Lo que hace posible la implementación es la **clausura**: el bloque devuelto captura `self` (el bloque original) y después `x`, y los mantiene vivos hasta que llegue `y`.

```smalltalk
| suma sumar5 |
suma := [ :x :y | x + y ].
(suma curry value: 3) value: 4.              "→ 7"

sumar5 := suma curry value: 5.               "aplicación parcial: queda un bloque de 1 parámetro"
sumar5 value: 10.                            "→ 15"
#(1 2 3) collect: sumar5                     "→ #(6 7 8)"
```

La operación inversa, por completitud:

```smalltalk
BlockClosure >> uncurry
    "[:x | [:y | ...]]  →  [:x :y | ...]"
    ^ [ :x :y | (self value: x) value: y ]
```

**b) `#flip` — invertir los parámetros**

```smalltalk
BlockClosure >> flip
    "[:x :y | ...]  →  bloque que evalúa el original con los argumentos al revés"
    self numArgs = 2 ifFalse: [ ^ self error: 'flip espera un bloque de 2 parámetros' ].
    ^ [ :x :y | self value: y value: x ]
```

```smalltalk
| resta |
resta := [ :x :y | x - y ].
resta value: 10 value: 3.              "→ 7"
resta flip value: 10 value: 3.         "→ -7   (evalúa 3 - 10)"

"combinado con curry: aplicación parcial sobre el SEGUNDO parámetro"
(resta flip curry value: 1) value: 10. "→ 9    (10 - 1)"
```

`flip` es involutiva: `unBloque flip flip` es equivalente al original.

**c) `#repetirVeces:` — repetir un bloque n veces**

```smalltalk
Integer >> repetirVeces: unBloque
    "Evalúa unBloque tantas veces como indique el receptor.
     Si el bloque toma un parámetro, se le pasa el número de iteración (1..self)."
    | i |
    i := 1.
    [ i <= self ] whileTrue: [
        unBloque numArgs = 0
            ifTrue:  [ unBloque value ]
            ifFalse: [ unBloque value: i ].
        i := i + 1 ].
    ^ self
```

```smalltalk
3 repetirVeces: [ Transcript show: 'hola'; cr ].         "imprime hola 3 veces"
5 repetirVeces: [ :i | Transcript show: i printString ]. "imprime 12345"
0 repetirVeces: [ Transcript show: 'nunca' ].            "no hace nada"
```

Detalles a notar:

- No hay `for` ni `while` sintáctico: `whileTrue:` es un **mensaje enviado al bloque de condición**, con el cuerpo como colaborador. Es un método más, extensible por el programador — que es justamente el punto del ejercicio.
- Alternativa sin `whileTrue:`, delegando la iteración a un intervalo: `(1 to: self) do: [ :i | unBloque value ]`.
- En Pharo ya existe `Integer >> timesRepeat:` con exactamente esta semántica; `repetirVeces:` es su reimplementación pedida a mano.

> ⚠️ Verificar — el enunciado dice "envía un bloque a un número", que se interpretó como **receptor = número, colaborador = bloque** (`3 repetirVeces: [...]`, extensión de `Integer`). Si la cátedra pide la lectura opuesta (receptor = bloque), la implementación es simétrica:
> ```smalltalk
> BlockClosure >> repetirVeces: unaCantidad
>     | i |
>     i := 1.
>     [ i <= unaCantidad ] whileTrue: [ self value. i := i + 1 ].
>     ^ self
> ```

**Chuleta**
> 1. Los bloques son objetos → se extiende `BlockClosure` con métodos propios → 2. `curry` = `^ [:x | [:y | self value: x value: y]]`; funciona porque el bloque devuelto **captura** `self` y `x` (clausura) → 3. `flip` = `^ [:x :y | self value: y value: x]` (involutiva) → 4. `flip curry` = aplicación parcial sobre el segundo parámetro → 5. `Integer >> repetirVeces:` con `[ i <= self ] whileTrue: [ ... ]`; chequear `numArgs` para pasar o no el índice → 6. `whileTrue:` no es sintaxis: es un mensaje al bloque condición.

---

## Method Dispatch, self y super

### Ejercicio 18 — Responsabilidad de Subclase

**Enunciado**
Clase `Figura` con métodos `perimetro` (`^self lados sumarTodos`) y `lados` (`^self subclassResponsability`).
Implementar `Cuadrado` y `Círculo`. Para círculo, considerar que no tiene lados (aproximar $\pi$ por 3,14).

**Explicacion**
Uso de métodos abstractos para definir comportamiento genérico en la superclase que depende de implementaciones específicas en las subclases.

**Resolucion paso a paso**
**Idea de diseño**

`Figura` es una **clase abstracta** que implementa un *template method*: `perimetro` define el algoritmo genérico (sumar los lados) y delega el paso variable en `lados`, que cada subclase debe implementar. `subclassResponsibility` documenta y hace fallar explícitamente el método abstracto.

```smalltalk
Object subclass: #Figura
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'Guia-POO'

Figura >> perimetro
    ^ self lados sumarTodos

Figura >> lados
    "Método abstracto: cada subclase concreta debe devolver la colección de sus lados."
    ^ self subclassResponsibility
```

Auxiliar sobre colecciones (o se usa directamente `sum` de Pharo):

```smalltalk
Collection >> sumarTodos
    ^ self inject: 0 into: [ :acc :cada | acc + cada ]
```

**Cuadrado**

```smalltalk
Figura subclass: #Cuadrado
    instanceVariableNames: 'lado'
    classVariableNames: ''
    package: 'Guia-POO'

Cuadrado >> lado: unNumero
    lado := unNumero.
    ^ self

Cuadrado >> lados
    ^ Array new: 4 withAll: lado    "#(lado lado lado lado)"
```

**Círculo — el caso interesante**

Un círculo no tiene lados, pero **sí tiene un borde**. Se lo modela como una colección con un único "lado" cuya longitud es la circunferencia. Así el `perimetro` heredado sigue funcionando **sin escribir una sola línea más** en `Circulo`:

```smalltalk
Figura subclass: #Circulo
    instanceVariableNames: 'radio'
    classVariableNames: ''
    package: 'Guia-POO'

Circulo >> radio: unNumero
    radio := unNumero.
    ^ self

Circulo >> lados
    "Un círculo no tiene lados rectos, pero su borde es un único 'lado'
     de longitud igual a la circunferencia: 2 · π · r (π ≈ 3,14)."
    ^ Array with: (2 * 3.14 * radio)
```

**Traza del despacho**

`(Cuadrado new lado: 5) perimetro`

| # | Envío | Receptor (`self`) | Clase del receptor | Lookup arranca en | Método hallado en | Devuelve |
|---|---|---|---|---|---|---|
| 1 | `perimetro` | el cuadrado | `Cuadrado` | `Cuadrado` | **`Figura`** (no está en `Cuadrado`) | ↓ |
| 2 | `self lados` | **el cuadrado** (sigue siendo el mismo) | `Cuadrado` | `Cuadrado` | **`Cuadrado`** | `#(5 5 5 5)` |
| 3 | `sumarTodos` | `#(5 5 5 5)` | `Array` | `Array` | `Collection` | `20` |

El punto clave: aunque `perimetro` está **escrito** en `Figura`, `self` sigue siendo el cuadrado, así que la búsqueda de `lados` arranca en `Cuadrado` y encuentra la versión específica. Eso es lo que hace que la superclase pueda invocar código que todavía no existía cuando fue escrita.

`(Circulo new radio: 10) perimetro` → `Figura >> perimetro` → `Circulo >> lados` = `#(62.8)` → `sumarTodos` = **`62.8`**.

`Figura new perimetro` → `Figura >> perimetro` → `self lados` arranca en `Figura`, encuentra `^ self subclassResponsibility` → **error**: `Figura` es abstracta y no debe instanciarse.

**Variante de diseño (y por qué no se eligió)**

Se podría sobreescribir directamente el perímetro en el círculo:

```smalltalk
Circulo >> perimetro
    ^ 2 * 3.14 * radio
```

Funciona y es más directo de leer, pero rompe el contrato de la jerarquía: `Circulo` queda sin implementar `lados`, así que cualquier otro método de `Figura` que use `lados` (por ejemplo un `cantidadDeLados` o un `ladoMasLargo`) explota con `subclassResponsibility`. La solución con `lados` mantiene el *template method* intacto y el círculo se integra a todo el comportamiento heredado.

> ⚠️ Verificar — el enunciado escribe `subclassResponsability`; el selector real en Pharo es `subclassResponsibility` (con "i"). Se usó el correcto del lenguaje.

**Chuleta**
> 1. `Figura` abstracta = *template method*: `perimetro` = `^ self lados sumarTodos`, y `lados` = `^ self subclassResponsibility` → 2. `Cuadrado >> lados` = `Array new: 4 withAll: lado` → 3. `Circulo >> lados` = `Array with: (2 * 3.14 * radio)`: un único "lado" = la circunferencia, así el `perimetro` heredado no se toca → 4. Clave del despacho: `self lados` dentro de `Figura` arranca la búsqueda en la clase **del receptor real**, no en `Figura` → 5. `Figura new perimetro` → error de `subclassResponsibility` (correcto: es abstracta) → 6. Sobreescribir `perimetro` en `Circulo` también anda, pero deja `lados` roto para el resto de la jerarquía.

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
**La jerarquía**

`Counter` cuenta de a 1; `FlexibleCounter` recibe un **bloque** que define cómo pasar del valor actual al siguiente.

```smalltalk
Object subclass: #Counter
    instanceVariableNames: 'value'
    classVariableNames: ''
    package: 'Guia-POO'

Counter class >> new
    ^ super new initialize

Counter >> initialize
    value := 0

Counter >> value
    ^ value

Counter >> next
    value := value + 1.
    ^ self value

Counter >> nextIf: condition
    ^ condition
        ifTrue:  [ self next ]
        ifFalse: [ self value ]
```

```smalltalk
Counter subclass: #FlexibleCounter
    instanceVariableNames: 'step'
    classVariableNames: ''
    package: 'Guia-POO'

FlexibleCounter class >> new: unBloque
    ^ self new setStep: unBloque

FlexibleCounter >> setStep: unBloque
    step := unBloque.
    ^ self

FlexibleCounter >> next
    "Sobreescribe next: el incremento lo decide el bloque, no el +1 fijo."
    value := step value: value.
    ^ self value
```

`FlexibleCounter` **no** redefine `initialize`, `value` ni `nextIf:`: los hereda. Sólo redefine `next`.

**Traza de `aCounter := FlexibleCounter new: [:v | v + 2]. aCounter nextIf: true.`**

*Fase 1 — creación (el receptor es la clase, así que el lookup va por el lado de la metaclase):*

| # | Envío | Receptor (`self`) | Clase del receptor | Lookup arranca en | Método hallado en | Efecto |
|---|---|---|---|---|---|---|
| 1 | `FlexibleCounter new: [:v \| v + 2]` | la clase `FlexibleCounter` | `FlexibleCounter class` | `FlexibleCounter class` | **`FlexibleCounter class`** | ↓ |
| 2 | `self new` | la clase `FlexibleCounter` (`self` sigue siendo la clase) | `FlexibleCounter class` | `FlexibleCounter class` | **`Counter class`** (no está en `FlexibleCounter class`) | ↓ |
| 3 | `super new` | la clase `FlexibleCounter` | `FlexibleCounter class` | **superclase de `Counter class`** = `Object class`/`Behavior` | `Behavior` (primitiva) | crea la instancia, con `value = nil` |
| 4 | `initialize` | la instancia nueva | `FlexibleCounter` | `FlexibleCounter` | **`Counter`** | `value := 0` |
| 5 | `setStep: [:v \| v + 2]` | la instancia | `FlexibleCounter` | `FlexibleCounter` | **`FlexibleCounter`** | `step := [:v \| v + 2]` |

Estado tras la creación: `aCounter` es un `FlexibleCounter` con `value = 0` y `step = [:v | v + 2]`.

*Fase 2 — el envío `aCounter nextIf: true` (acá está el punto del ejercicio):*

| # | Envío | Receptor (`self`) | Clase del receptor | Lookup arranca en | Método hallado en | Devuelve |
|---|---|---|---|---|---|---|
| 6 | `nextIf: true` | `aCounter` | `FlexibleCounter` | `FlexibleCounter` | **`Counter`** (`FlexibleCounter` no lo define) | ↓ |
| 7 | `true ifTrue: [...] ifFalse: [...]` | `true` | `True` | `True` | `True` | evalúa el **primer** bloque |
| 8 | `self next` | **`aCounter`** — `self` NO cambió al subir a `Counter` | `FlexibleCounter` | **`FlexibleCounter`** | **`FlexibleCounter >> next`** ← **clave** | ↓ |
| 9 | `step value: value` | el bloque | `BlockClosure` | — | — | `0 + 2 = 2`, y `value := 2` |
| 10 | `self value` | `aCounter` | `FlexibleCounter` | `FlexibleCounter` | **`Counter >> value`** | `2` |

**Resultado: `2`.** Y el estado queda `value = 2`.

**Por qué es el ejercicio clásico**

El método `nextIf:` está **escrito en `Counter`**, pero cuando ejecuta `self next` la búsqueda **no** arranca en `Counter`: arranca en `FlexibleCounter`, la clase del **objeto receptor**, que es lo único que importa para `self`. Por eso el resultado es `2` y no `1`. Esto es *late binding*: `Counter` invoca código escrito después de él, sin conocerlo.

**Contraste — qué pasaría con `super`**

Si `nextIf:` estuviera escrito como `^ condition ifTrue: [ super next ] ifFalse: [ ... ]`, la búsqueda de `next` arrancaría en la **superclase de la clase donde está escrito el método** (`Counter`) → o sea en `Object`, y daría `doesNotUnderstand:`. Y si el `super next` estuviera en `FlexibleCounter >> next`, arrancaría en `Counter` y ejecutaría el `+1` fijo.

| Escrito en el método | Búsqueda arranca en | Receptor (`self`) |
|---|---|---|
| `self next` (en `Counter >> nextIf:`) | clase del **objeto**: `FlexibleCounter` | `aCounter` |
| `super next` (en `Counter >> nextIf:`) | superclase de **`Counter`**: `Object` | `aCounter` (¡el mismo!) |
| `super next` (en `FlexibleCounter >> next`) | superclase de **`FlexibleCounter`**: `Counter` | `aCounter` |

En los tres casos `self` es el mismo objeto: `super` sólo cambia **dónde empieza a buscar**, nunca quién es el receptor.

**Otros envíos, para fijar**

```smalltalk
aCounter nextIf: false.   "→ 2  (devuelve value sin modificarlo)"
aCounter nextIf: true.    "→ 4"
Counter new nextIf: true. "→ 1  (acá self next SÍ encuentra Counter >> next)"
```

> ⚠️ Verificar — el enunciado no transcribe el código de `Counter`/`FlexibleCounter`; se reconstruyó la versión canónica del ejercicio (`initialize` en `Counter`, `next` sobreescrito en `FlexibleCounter`, `nextIf:` sólo en `Counter`). Si la cátedra da otra distribución de métodos, el razonamiento de la traza es idéntico: sólo cambia la fila donde se encuentra cada método.

**Chuleta**
> 1. `self` = objeto receptor: el lookup arranca **siempre** en su clase, sin importar dónde esté escrito el método → 2. `super` = mismo receptor, pero el lookup arranca en la superclase de **la clase donde está escrito el método** → 3. `FlexibleCounter new: b` → `self new` (en `Counter class`) → `super new initialize` → `initialize` se encuentra en `Counter` → `setStep:` en `FlexibleCounter` → 4. `nextIf: true` se encuentra en `Counter`, pero su `self next` baja a **`FlexibleCounter >> next`** → `step value: 0` = **2** → 5. Resultado `2`, no `1`: *late binding*. Con `super next` habría dado el `+1` de `Counter`.

---

### Ejercicio 23 — Sistema de Monedas

**Enunciado**
Agregar a `Number` los métodos `pesos`, `dolares`, `reales`. Implementar la clase `Moneda` y subclases.
Implementar `Moneda >> cambioDe: #dolar a: #peso es: 1295`.
Permitir sumar monedas de distinto tipo: `20 dolares + 25900 pesos`.

**Explicacion**
Uso del patrón **Double Dispatch** para resolver operaciones entre objetos de distintas clases (o subclases) de forma elegante y extensible.

**Resolucion paso a paso**
**1) Extender `Number`: los mensajes que crean monedas**

En Smalltalk las clases del sistema son abiertas: se le pueden agregar métodos a `Number` como a cualquier clase propia. Se define en `Number` (no en `Integer`) para que ande con enteros, fracciones y flotantes.

```smalltalk
Number >> pesos     ^ Peso  nuevaCon: self
Number >> dolares   ^ Dolar nuevaCon: self
Number >> reales    ^ Real  nuevaCon: self
```

Como son mensajes **unarios**, tienen la máxima precedencia: en `20 dolares + 25900 pesos` primero se construyen las dos monedas y recién después se envía el `+`.

**2) La clase abstracta `Moneda`**

```smalltalk
Object subclass: #Moneda
    instanceVariableNames: 'monto'
    classVariableNames: 'Cambios'
    package: 'Guia-POO'

Moneda class >> nuevaCon: unNumero
    ^ self new setMonto: unNumero

Moneda >> setMonto: unNumero
    monto := unNumero.
    ^ self

Moneda >> monto
    ^ monto

Moneda >> simbolo
    "Cada subclase concreta se identifica con su símbolo."
    ^ self subclassResponsibility

Moneda >> printOn: unStream
    unStream print: monto; nextPutAll: ' '; nextPutAll: self simbolo
```

**3) Las subclases: sólo aportan su símbolo**

```smalltalk
Moneda subclass: #Peso  ...      Peso  >> simbolo    ^ #peso
Moneda subclass: #Dolar ...      Dolar >> simbolo    ^ #dolar
Moneda subclass: #Real  ...      Real  >> simbolo    ^ #real
```

Todo el comportamiento (crear, sumar, convertir, comparar) vive en `Moneda`. Agregar una moneda nueva = una subclase de tres líneas + su cotización.

**4) La tabla de cotizaciones**

Las cotizaciones son **compartidas por toda la jerarquía**, no propiedad de una moneda particular → variable de clase + método del lado de clase. Se carga en los dos sentidos para no tener que buscar la inversa después.

```smalltalk
Moneda class >> cambioDe: unSimbolo a: otroSimbolo es: unFactor
    "1 unidad de unSimbolo equivale a unFactor unidades de otroSimbolo."
    Cambios ifNil: [ Cambios := Dictionary new ].
    Cambios at: (Array with: unSimbolo with: otroSimbolo) put: unFactor.
    Cambios at: (Array with: otroSimbolo with: unSimbolo) put: 1 / unFactor

Moneda class >> factorDe: origen a: destino
    origen = destino ifTrue: [ ^ 1 ].
    ^ Cambios
        at: (Array with: origen with: destino)
        ifAbsent: [ self error: 'No hay cotización de ', origen, ' a ', destino ]
```

Se usa un `Array` de dos símbolos como clave porque los arrays comparan por contenido (`=` y `hash` estructurales), así que `#(#dolar #peso)` recupera siempre la misma entrada.

**5) La suma: DOUBLE DISPATCH**

```smalltalk
Moneda >> + otraMoneda
    "PRIMER DISPATCH: el método lo elige la clase de self (el receptor).
     Eso define en qué moneda queda expresado el resultado.
     SEGUNDO DISPATCH: en vez de preguntar '¿de qué clase sos?', se le ENVÍA
     un mensaje a otraMoneda; el método que corre lo decide la clase del ARGUMENTO."
    ^ self class nuevaCon: monto + (otraMoneda montoEn: self simbolo)

Moneda >> montoEn: unSimbolo
    "El self de acá es la OTRA moneda: su clase resuelve `simbolo`."
    ^ monto * (Moneda factorDe: self simbolo a: unSimbolo)

Moneda >> = otraMoneda
    ^ (otraMoneda isKindOf: Moneda)
        and: [ monto = (otraMoneda montoEn: self simbolo) ]

Moneda >> hash
    ^ (self montoEn: #peso) hash
```

**6) Uso**

```smalltalk
Moneda cambioDe: #dolar a: #peso es: 1295.
Moneda cambioDe: #real  a: #peso es: 240.

20 dolares + 25900 pesos.        "→ 40 dolar     (el resultado queda en la moneda del RECEPTOR)"
25900 pesos + 20 dolares.        "→ 51800 peso"
(20 dolares + 25900 pesos) = (40 dolares).   "→ true"
```

**Traza de `20 dolares + 25900 pesos`**

Por precedencia, los unarios primero: `(20 dolares) + (25900 pesos)`.

| # | Envío | Receptor (`self`) | Clase del receptor | Lookup arranca en | Método hallado en | Devuelve |
|---|---|---|---|---|---|---|
| 1 | `20 dolares` | `20` | `SmallInteger` | `SmallInteger` | **`Number`** (extensión) | ↓ |
| 2 | `Dolar nuevaCon: 20` | la clase `Dolar` | `Dolar class` | `Dolar class` | **`Moneda class`** | `unDolar(monto=20)` |
| 3 | `25900 pesos` | `25900` | `SmallInteger` | `SmallInteger` | **`Number`** | `unPeso(monto=25900)` |
| 4 | `unDolar + unPeso` | `unDolar` | `Dolar` | `Dolar` | **`Moneda >> +`** | ← **1er dispatch** |
| 5 | `self simbolo` | `unDolar` | `Dolar` | `Dolar` | **`Dolar >> simbolo`** | `#dolar` |
| 6 | `unPeso montoEn: #dolar` | **`unPeso`** (cambió el receptor) | `Peso` | `Peso` | **`Moneda >> montoEn:`** | ← **2do dispatch** |
| 7 | `self simbolo` (dentro de `montoEn:`) | `unPeso` | `Peso` | `Peso` | **`Peso >> simbolo`** | `#peso` |
| 8 | `Moneda factorDe: #peso a: #dolar` | la clase `Moneda` | `Moneda class` | `Moneda class` | `Moneda class` | `1/1295` |
| 9 | `25900 * (1/1295)` | `25900` | `SmallInteger` | — | — | `20` |
| 10 | `self class nuevaCon: (20 + 20)` | la clase `Dolar` (`self class` del paso 4) | `Dolar class` | `Dolar class` | **`Moneda class`** | `unDolar(monto=40)` |

**Resultado: `40 dolar`.**

**Por qué esto es double dispatch y por qué importa**

El método `+` **nunca pregunta de qué clase es el argumento**. No hay `ifTrue:`, ni `isKindOf:`, ni `case`. Lo que hace es **reenviarle un mensaje al colaborador** (`montoEn:`), de modo que la resolución final del cómputo depende de **dos** clases: la del receptor (paso 4-5, decide la moneda de salida) y la del argumento (pasos 6-7, aporta su símbolo y su cotización).

Consecuencia práctica — agregar el euro no toca **ni una línea** del código existente:

```smalltalk
Moneda subclass: #Euro ...
Euro >> simbolo    ^ #euro
Moneda cambioDe: #euro a: #peso es: 1400.
"y ya funciona: 10 euros + 20 dolares, 5 dolares + 3 euros, etc."
```

Con un `+` que discriminara por tipo, cada moneda nueva obligaría a modificar el `+` de todas las demás (crecimiento cuadrático). Es la misma razón por la que `Number` usa *coercion* con double dispatch (`generality`/`retryRelationalOp:coercing:`) entre `SmallInteger`, `Fraction` y `Float`.

**Variante "pura" del patrón (la del libro)**

Si no se quisiera usar un símbolo intermedio, el double dispatch canónico es un método por combinación:

```smalltalk
Moneda >> + otraMoneda      ^ otraMoneda sumarleA: self
Peso   >> sumarleA: unaMoneda   ^ unaMoneda sumarPesos: monto
Dolar  >> sumarleA: unaMoneda   ^ unaMoneda sumarDolares: monto
```

Es el patrón textual (el segundo método se elige por la clase del argumento), pero requiere $n^2$ métodos. La versión con `simbolo` + tabla de cotizaciones conserva el double dispatch y escala linealmente, por eso es la que conviene presentar.

> ⚠️ Verificar — el enunciado escribe `Moneda >> cambioDe: #dolar a: #peso es: 1295` (notación de método de **instancia**), pero la tabla de cotizaciones es información compartida por toda la jerarquía, así que se implementó del lado de **clase** (`Moneda class >>` con variable de clase `Cambios`). Si la cátedra exige la firma de instancia, alcanza con delegar: `Moneda >> cambioDe: a: b es: f  ^ self class cambioDe: a a: b es: f`.
>
> ⚠️ Verificar — el enunciado no aclara en qué moneda debe quedar el resultado de `20 dolares + 25900 pesos`. Se adoptó el criterio estándar "queda en la moneda del receptor" (→ `40 dolares`). El criterio alternativo (convertir todo a una moneda base fija) sólo cambia el paso 10 de la traza: `^ Peso nuevaCon: ...` en lugar de `self class nuevaCon: ...`.

**Chuleta**
> 1. `Number >> pesos/dolares/reales` = `^ Peso nuevaCon: self` — son unarios, se evalúan **antes** que el `+` → 2. `Moneda` abstracta con `monto`; cada subclase sólo define `simbolo` (`^ #peso`) → 3. Cotizaciones en variable de **clase** `Cambios`, cargadas en ambos sentidos (`f` y `1/f`), clave = `Array with: origen with: destino` → 4. **Double dispatch**: `Moneda >> +` = `^ self class nuevaCon: monto + (otraMoneda montoEn: self simbolo)` — no pregunta el tipo del argumento, **le manda un mensaje** → 5. El receptor fija la moneda de salida; el argumento aporta su `simbolo` y se convierte → `20 dolares + 25900 pesos = 40 dolar` → 6. Extender = subclase nueva + cotización, cero cambios en el código viejo (vs. $n^2$ métodos si se discriminara por tipo).

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/smalltalk_method_lookup]]
