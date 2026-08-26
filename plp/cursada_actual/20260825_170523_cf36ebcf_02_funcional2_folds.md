---
nombre: Programación funcional — explicación para comprender Funcional 2 (folds)
tipo: material_de_estudio
origen: raw/cursada_2C_2026/teo/20260825-170523-cf36ebcf-02-Funcional2-Folds.pdf
tipo_documento: teorica
temas: [programacion_funcional]
parcial: 1P
programa: 2C_2026
generado: 2026-08-25
base_comparacion:
  parciales_analizados: 11
  tipos_ejercicio: 23
ingestado: false
---

# Programación funcional — explicación para comprender la clase de folds

La clase estudia cómo reconocer y abstraer una forma de recursión que aparece una y otra vez al procesar datos inductivos. El recorrido comienza con listas, donde surge `foldr`, y termina mostrando que cada tipo algebraico determina su propio esquema. En el medio se aclara qué garantiza esa disciplina, qué información pierde y qué alternativas existen cuando deja de alcanzar.

**Fuente:** `raw/cursada_2C_2026/teo/20260825-170523-cf36ebcf-02-Funcional2-Folds.pdf` · **Tema:** `programacion_funcional` → **1P** (programa 2C_2026)
**Cómo leer esto:** 🔴 = dominar en profundidad · 🟡 = entender · ⚪ = contexto

## El problema que organiza la clase

En la clase anterior aparecieron `map` y `filter`: dos funciones de orden superior que esconden recorridos recursivos frecuentes. La pregunta ahora es si existe una abstracción más general que capture no solo esos dos recorridos, sino cualquier función cuya recursión siga exactamente la estructura del dato.

La respuesta es el **plegado**. Un fold separa dos cosas que en una definición recursiva común aparecen mezcladas:

1. **La forma del recorrido**, determinada por los constructores del tipo.
2. **Qué resultado queremos construir**, determinado por las funciones que entregamos al fold.

Separarlas permite reutilizar el recorrido, razonar algebraicamente y garantizar terminación sobre datos finitos. Pero la separación también descarta información. Comprender qué conserva un fold y qué pierde es la clave para entender por qué a veces alcanza y por qué otras veces hace falta `rec`, `foldl` o recursión general.

## Mapa conceptual

- Varias funciones con el mismo esqueleto recursivo conducen a abstraer ese esqueleto en `foldr`.
- `foldr` se entiende como reemplazar los constructores `[]` y `(:)` por un valor y una función.
- Esa lectura revela que un fold no pertenece especialmente a las listas: la forma de cada tipo algebraico determina su fold.
- El fold captura exactamente la **recursión estructural**, que solo observa datos locales y resultados recursivos.
- Si hace falta conservar el subtérmino original, la recursión primitiva (`rec`) amplía la información disponible.
- Si el resultado debe acumularse desde el comienzo, aparece `foldl`; en Haskell perezoso importa distinguirlo de `foldl'`.
- Las restricciones de los esquemas permiten demostrar leyes, terminación e inducción estructural.
- Los tipos recursivos anidados, como `RoseTree`, muestran que la receta necesita distinguir entre recursión directa y recursión dentro de otra estructura.

## Conocimientos previos necesarios

- **Tipos y polimorfismo:** una variable de tipo como `b` puede representar cualquier tipo, incluso una función.
- **Currificación:** `a -> b -> c` se lee como `a -> (b -> c)`; una función puede recibir algunos argumentos y devolver otra función que espera los restantes.
- **Tipos algebraicos:** una declaración `data` enumera todas las formas de construir valores mediante sus constructores.
- **Pattern matching:** permite preguntar con qué constructor fue armado un valor y dar nombres a sus campos.
- **Evaluación no estricta:** Haskell evalúa una expresión solamente cuando su resultado hace falta; esto afecta de manera distinta a `foldr` y `foldl`.

---

## 🔴 1. Qué es plegar: separar el recorrido de lo que hacemos — diap. 7–13

### La idea intuitiva

Muchas funciones recursivas sobre listas parecen diferentes porque producen resultados distintos, pero recorren la lista de la misma manera. En el caso vacío eligen un resultado inicial; en el caso no vacío combinan la cabeza con el resultado de procesar la cola.

El fold toma ese recorrido común y lo escribe una sola vez. La función concreta aporta únicamente las dos piezas que varían: qué significa la lista vacía y cómo se combina un elemento con el resultado acumulado del resto.

### Qué problema resuelve

Consideremos tres funciones:

- `todosCincos` decide si todos los números son cinco;
- `totalMonedas` suma una propiedad costosa de cada persona;
- `concat` aplana una lista de listas.

Sus resultados son diferentes (`Bool`, `Int`, `[a]`), pero su forma es la misma:

```haskell
g []       = casoBase
g (x : xs) = combinar x (g xs)
```

Sin una abstracción, cada función vuelve a escribir el mismo mecanismo recursivo. `foldr` permite nombrar ese mecanismo.

### Definición precisa

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z []       = z
foldr f z (x : xs) = f x (foldr f z xs)
```

- `a` es el tipo de los elementos de la lista.
- `b` es el tipo del resultado que construye el plegado.
- `z :: b` interpreta la lista vacía.
- `f :: a -> b -> b` interpreta el constructor `(:)`: recibe la cabeza y el resultado de plegar la cola.

### Cómo funciona

La lista

```haskell
1 : (2 : (3 : []))
```

está construida exclusivamente con `(:)` y `[]`. Plegar con `foldr f z` reemplaza cada `(:)` por `f` y el `[]` final por `z`:

```haskell
foldr f z [1,2,3]
= f 1 (f 2 (f 3 z))
```

Por eso se llama plegado “a derecha”: la expresión resultante queda asociada hacia la derecha.

### Ejemplo mínimo

```haskell
suma :: [Int] -> Int
suma = foldr (+) 0
```

Para `[1,2,3]`:

```haskell
foldr (+) 0 [1,2,3]
= 1 + (2 + (3 + 0))
= 6
```

El `0` expresa qué vale la suma de la lista vacía y `(+)` expresa cómo incorporar una cabeza al resultado de la cola.

También se obtiene:

```haskell
foldr (:) [] = id
```

porque cada constructor es reemplazado por sí mismo: `(:)` por `(:)` y `[]` por `[]`.

### Por qué funciona

Una lista finita no contiene ninguna forma secreta adicional: está construida con `[]` o con `(:)`. Si especificamos qué hacer con ambos constructores, especificamos qué hacer con cualquier lista finita. El fold se encarga de aplicar esas decisiones en toda la estructura.

### Qué información conserva y cuál pierde

`foldr` conserva:

- el elemento actual `x`;
- el resultado `b` de plegar la cola.

No conserva automáticamente:

- la cola original `xs`;
- la llamada recursiva como una operación que el usuario pueda modificar;
- información que no haya sido codificada dentro de `b`.

Esta pérdida no es accidental: es precisamente la disciplina que permite abstraer el recorrido.

### Relación con otros conceptos

- **Generaliza a:** `map` y `filter`, que son casos particulares de `foldr`.
- **Se diferencia de:** recursión explícita, donde el programador controla cada llamada.
- **Necesita:** funciones de orden superior y polimorfismo.
- **Da lugar a:** folds de árboles y otros tipos algebraicos.

### Límites y contraejemplos

No toda función recursiva sobre listas tiene la forma de `foldr`. Si el caso recursivo necesita observar `xs` directamente o llamar a la función sobre algo distinto de `xs`, el recorrido ya no coincide con el esquema.

Por ejemplo, `insertarOrdenado` puede necesitar conservar toda la cola sin procesar:

```haskell
if y <= x
then y : x : xs
else x : insertarOrdenado y xs
```

En la primera rama aparece `xs`, no solamente el resultado recursivo.

### Confusiones frecuentes

- Pensar que plegar significa necesariamente sumar: la suma es solo una instancia.
- Creer que `b` debe coincidir con `a`: una lista de personas puede plegarse a un entero y una lista de enteros a un booleano.
- Pensar que `foldr` elimina el trabajo específico: no lo elimina; lo convierte en `f` y `z`.
- Confundir el elemento `x :: a` con el resultado de la cola `foldr f z xs :: b`.

### Explicación para nene de 5

Imaginá un tren de vagones. En lugar de mirar qué color tiene cada tren, construimos una máquina que sabe dos cosas: qué hacer cuando ya no quedan vagones y cómo unir el vagón que estamos mirando con lo que la máquina armó usando los vagones de atrás. Cambiando esas dos instrucciones, la misma máquina puede contar vagones, revisar si todos son rojos o copiar el tren.

Formalmente, el tren es la lista, el final sin vagones es `[]`, cada unión entre vagones es `(:)`, la instrucción para el final es `z` y la instrucción para combinar un vagón con el resultado del resto es `f`.

---

## 🔴 2. Recursión estructural: la condición exacta que captura el fold — diap. 15–24

### La idea intuitiva

La recursión estructural es una forma disciplinada de recursión: para resolver un dato, solo se permite usar sus partes inmediatas y los resultados de resolver recursivamente sus partes recursivas. No se puede inspeccionar libremente el resto ni inventar una llamada sobre un argumento diferente.

`foldr` no es simplemente una función cómoda; es la representación explícita de esa disciplina sobre listas.

### Qué problema resuelve

Decir “esta función recorre una lista” es demasiado impreciso. `suma`, `insertarOrdenado` y `selection sort` recorren listas, pero sus llamadas recursivas tienen formas diferentes y ofrecen garantías diferentes.

La definición precisa de recursión estructural permite:

- decidir si una función puede expresarse directamente con fold;
- saber qué información está disponible en cada caso;
- garantizar terminación sobre valores finitos totalmente definidos;
- usar inducción estructural para demostrar propiedades.

### Definición precisa

Para una función `g :: [a] -> b`, la forma estructural es:

```haskell
g []       = z
g (x : xs) = expresionQueUsa x (g xs)
```

con dos restricciones:

1. El caso base es fijo: no usa `g`.
2. El caso recursivo puede usar `x` y `g xs`, pero no puede usar `g` ni `xs` por separado.

No es obligatorio usar toda la información permitida. `length` ignora la cabeza y `head` ignora el resultado recursivo; ambas respetan la restricción porque no usan nada adicional.

### Cómo funciona

Cada llamada recursiva recibe un subtérmino inmediato de la estructura original. Para una lista no vacía, ese subtérmino es `xs`. Como la lista es finita, repetir el proceso termina llegando a `[]`.

El combinador del fold recibe exactamente la información autorizada por la definición estructural:

```haskell
f :: a -> b -> b
--   x    g xs
```

Por eso toda definición con esa forma puede reescribirse como una aplicación de `foldr`.

### Ejemplo mínimo

```haskell
length :: [a] -> Int
length []       = 0
length (_ : xs) = 1 + length xs
```

La cabeza está disponible pero no se necesita:

```haskell
length = foldr (\_ n -> n + 1) 0
```

En cambio:

```haskell
ssort (x : xs) =
  minimo (x : xs) : ssort (sacarMinimo (x : xs))
```

no es estructural: la llamada recursiva no usa el subtérmino inmediato `xs`, sino otra lista calculada.

### Por qué funciona

La forma de la definición coincide con la forma inductiva del dato. Los constructores determinan los casos y los campos recursivos determinan las únicas llamadas permitidas. Esa correspondencia es la razón común detrás del fold, la terminación y la inducción estructural.

### Qué información conserva y cuál pierde

La disciplina conserva solo lo necesario para combinar resultados de subtérminos. A cambio pierde libertad para:

- volver a observar una parte original;
- cambiar el argumento de la recursión;
- expresar deliberadamente una computación que podría no terminar sobre un dato finito.

### Relación con otros conceptos

- **Generaliza a:** recursión estructural sobre cualquier tipo algebraico inductivo.
- **Se diferencia de:** recursión general, cuya llamada puede usar argumentos calculados arbitrariamente.
- **Necesita:** que el dato tenga una estructura inductiva reconocible.
- **Da lugar a:** inducción estructural y leyes algebraicas de folds.

### Límites y contraejemplos

Que una función termine no implica que sea estructural. `selection sort` termina porque su argumento se hace más corto, pero esa disminución no viene garantizada directamente por los constructores de lista.

También puede ocurrir que el resultado recursivo elegido no tenga información suficiente. Conocer solo `promedio xs` no permite calcular `promedio (x:xs)`, porque falta saber cuántos elementos participaron. La salida puede enriquecerse —por ejemplo con suma y cantidad— o calcularse mediante plegados auxiliares.

### Confusiones frecuentes

- Confundir “recursión sobre una lista” con “recursión estructural”.
- Creer que una definición deja de ser estructural si ignora `x` o `g xs`.
- Creer que terminación y estructuralidad son sinónimos.
- Elegir un resultado `b` que resume demasiado poco y concluir erróneamente que el fold no sirve.

### Explicación para nene de 5

Pensá en una torre de bloques. La regla dice que solo podés mirar el bloque de arriba y usar la respuesta que alguien ya calculó para la torre que queda debajo. No podés sacar bloques del medio ni volver a armar otra torre antes de continuar. Como cada vez queda una torre más bajita, al final llegás al piso.

Formalmente, el bloque de arriba es `x`, la torre restante es `xs`, la respuesta ya calculada es `g xs` y llegar al piso corresponde al constructor base `[]`.

---

## 🔴 3. La forma del tipo determina su fold — diap. 45–58

### La idea intuitiva

Un fold no se diseña a partir del significado informal de los datos, sino a partir de las maneras en que esos datos pueden construirse. Si un tipo tiene tres constructores, para consumir cualquier valor del tipo hay que explicar qué hacer en esos tres casos. Si un constructor contiene dos subdatos recursivos, el fold entrega dos resultados recursivos.

### Qué problema resuelve

`foldr` parece inicialmente una herramienta especial para listas. Sin embargo, árboles, expresiones, fórmulas y muchos otros valores también son inductivos. Reescribir manualmente el recorrido para cada función sobre esos tipos repite el mismo problema que ya vimos en listas.

La receta general permite obtener el esquema sin necesitar saber qué representa el tipo.

### Definición precisa

Para un tipo algebraico regular:

1. El fold recibe un parámetro por constructor.
2. El parámetro de cada constructor recibe sus campos en el mismo orden.
3. Cada campo recursivo del tipo original se reemplaza por el tipo resultado `b`.
4. La implementación contiene una ecuación por constructor y llama recursivamente al fold en los campos recursivos.

Ejemplo:

```haskell
data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB z g Nil = z
foldAB z g (Bin ti x td) =
  g (foldAB z g ti) x (foldAB z g td)
```

### Cómo funciona

`Nil` no tiene campos, así que su interpretación es un valor `z :: b`.

`Bin` tiene:

- un subárbol izquierdo `AB a`;
- un dato `a`;
- un subárbol derecho `AB a`.

Los subárboles no llegan al combinador como `AB a`: el fold ya los procesó y entrega dos resultados `b`. El dato local no es recursivo, por lo que sigue siendo `a`.

La misma mecánica funciona con un tipo sin significado conocido:

```haskell
data TG = CB
        | CC TG Char TG
        | CD Int TG
        | CE TG TG TG
        | CF TG Char
```

El tipo de `foldTG` se obtiene contando constructores y reemplazando cada campo `TG` por `b`. No hace falta imaginar qué representa `TG`.

### Ejemplo mínimo

Con `foldAB`, contar nodos, espejar y recorrer inorder son tres interpretaciones de los mismos constructores:

```haskell
cantNodos = foldAB 0   (\n _ m -> n + 1 + m)
espejo    = foldAB Nil (\ti x td -> Bin td x ti)
inorder   = foldAB []  (\xs x ys -> xs ++ [x] ++ ys)
```

El recorrido del árbol no cambia. Solo cambia qué significan `Nil` y `Bin` en el tipo de salida elegido.

### Por qué funciona

La declaración `data` es exhaustiva: afirma que no hay valores construidos de otras maneras. Un observador que cubre todos los constructores y procesa recursivamente todos los campos recursivos cubre, por lo tanto, todos los valores finitos del tipo.

### Qué información conserva y cuál pierde

El fold conserva:

- todos los campos no recursivos de cada constructor;
- un resultado por cada campo recursivo.

Pierde:

- los subárboles originales;
- la identidad concreta de una rama una vez reemplazada por `b`, salvo que `b` la reconstruya;
- el control del recorrido, que queda fijado por el esquema.

### Relación con otros conceptos

- **Generaliza a:** folds de listas, árboles, expresiones y fórmulas.
- **Se diferencia de:** análisis por casos de tipos no recursivos, donde no hay resultados recursivos.
- **Necesita:** constructores y pattern matching.
- **Da lugar a:** una forma sistemática de diseñar funciones sin recursión explícita.

### Límites y contraejemplos

La receta presentada es directa para tipos **regulares**, donde los campos recursivos son exactamente del tipo que se está definiendo. En `RoseTree a = Rose a [RoseTree a]`, la recursión aparece dentro de una lista; procesar el árbol exige también decidir cómo procesar esa lista.

Además, un fold no puede entregar automáticamente el subárbol original. Si una función necesita inspeccionarlo, el esquema correspondiente es más cercano a `rec`.

### Confusiones frecuentes

- Contar campos y creer que hay un parámetro del fold por campo: hay uno por constructor.
- Reemplazar también campos no recursivos por `b`.
- Pasar el subárbol original y el resultado al fold: eso describe `rec`, no fold.
- Diseñar el tipo del fold a partir del nombre o intención del tipo en vez de sus constructores.

### Explicación para nene de 5

Imaginá juguetes hechos con piezas permitidas por una caja: una pieza “vacía” y una pieza “nodo” que une dos juguetes más y una bolita. Para desarmar cualquier juguete, solo necesitás decidir qué hacer con la pieza vacía y qué hacer con la pieza nodo. No importa si el juguete representa una casa o un monstruo: las piezas son las mismas.

Formalmente, la lista de piezas permitidas es la declaración `data`, cada pieza es un constructor, los juguetes que aparecen dentro de una pieza son campos recursivos y las respuestas obtenidas al desarmarlos tienen tipo `b`.

---

## 🔴 4. El resultado de un fold también puede ser una función — diap. 12, 16, 74–75

### La idea intuitiva

El resultado `b` de un fold no tiene que ser un número, una lista o un booleano. Como las funciones también son valores, `b` puede ser una función que todavía espera información. En ese caso, plegar la estructura no produce inmediatamente la respuesta final: produce una máquina que sabrá responder cuando reciba el argumento que falta.

### Qué problema resuelve

Algunas funciones consumen una estructura y además reciben un parámetro externo:

```haskell
estructura -> parametro -> resultado
```

El valor apropiado para `b` puede ser:

```haskell
parametro -> resultado
```

Así cada resultado recursivo conserva una respuesta pendiente para cualquier valor futuro del parámetro.

### Definición precisa

Por currificación:

```haskell
foldr :: (a -> b -> b) -> b -> ([a] -> b)
```

Al fijar `f` y `z`, `foldr f z` ya es una función de listas. Pero también podemos instanciar `b` con un tipo función. La clase lo muestra con `(++)`:

```haskell
(++) :: [a] -> [a] -> [a]
(++) = foldr (\x h ys -> x : h ys) id
```

Aquí:

```haskell
b = [a] -> [a]
```

El resultado recursivo `h` es una función pendiente, no una lista terminada.

### Cómo funciona

Para el caso vacío necesitamos describir:

```haskell
[] ++ ys = ys
```

La función pendiente es entonces `id`.

Para el caso `x:xs`, el resultado recursivo `h` sabe cómo anteponer `xs` a una lista futura. El nuevo resultado debe esperar `ys`, colocar `x` adelante y usar `h ys`:

```haskell
\x h ys -> x : h ys
```

La misma idea permite que un fold sobre un árbol devuelva, por ejemplo, `Int -> [a]`: cada rama queda convertida en una función que responde qué elementos hay a una profundidad solicitada más tarde.

### Ejemplo mínimo

Para `zip`, se puede plegar la primera lista construyendo una función que todavía espera la segunda:

```haskell
zipConFold :: [a] -> [b] -> [(a,b)]
zipConFold = foldr paso (const [])
  where
    paso x rec ys = case ys of
      []     -> []
      y : zs -> (x,y) : rec zs
```

El fold recorre estructuralmente la primera lista. La segunda queda como parámetro pendiente de la función producida.

### Por qué funciona

El polimorfismo no distingue entre “datos comunes” y funciones. Si `b` puede ser cualquier tipo, puede ser `Int -> [a]`, `[a] -> [a]` o cualquier otro tipo funcional. El fold combina funciones igual que combinaría números o listas.

### Qué información conserva y cuál pierde

Conserva el parámetro extra de forma diferida: cada resultado recursivo sabe responder cuando se lo aplique. No recupera la estructura original; solo amplía el tipo de la respuesta para incluir una dependencia futura.

### Relación con otros conceptos

- **Generaliza a:** evaluación parcial y funciones con estado o contexto pendiente.
- **Se diferencia de:** `rec`, que conserva subtérminos originales.
- **Necesita:** currificación, aplicación parcial y funciones como valores.
- **Da lugar a:** soluciones donde el fold produce `Info -> Resultado`.

### Límites y contraejemplos

Hacer que `b` sea una función sirve cuando la información adicional puede transmitirse aplicando resultados pendientes. No sirve por sí solo si la decisión exige inspeccionar el subtérmino original: en ese caso puede necesitarse `rec` y, eventualmente, que `rec` también devuelva una función.

### Confusiones frecuentes

- Tratar un resultado recursivo funcional como si ya fuera el resultado final.
- Olvidar que el caso base también debe devolver una función.
- Confundir “el fold devuelve una función” con “el fold conserva el árbol original”.
- Pensar que evaluación parcial significa evaluar parte de la estructura; aquí significa fijar algunos argumentos y producir una función para los restantes.

### Explicación para nene de 5

Imaginá que armás una máquina de jugo, pero todavía no sabés qué vaso van a traerte. Primero construís la máquina completa; más tarde alguien trae un vaso y la máquina sabe qué hacer con él. El resultado de tu trabajo no era el jugo servido, sino una máquina que esperaba un dato más.

Formalmente, construir la máquina es ejecutar el fold, el vaso pendiente es el parámetro extra y el tipo de la máquina es `parametro -> resultado`.

---

## 🔴 5. `rec`: conservar la estructura original cuando el fold la pierde — diap. 19–30, 58–60

### La idea intuitiva

Un fold reemplaza cada subtérmino por su resultado. Eso es suficiente si solo importa lo que cada subtérmino “produce”. Pero algunas funciones necesitan mirar también cómo era el subtérmino original. La recursión primitiva entrega ambas cosas: el original y el resultado de procesarlo.

### Qué problema resuelve

`insertarOrdenado` necesita conservar `xs` intacta si el nuevo elemento debe insertarse antes de la cabeza. Otras funciones pueden necesitar reconocer si un hijo fue construido con determinado constructor o consultar el estado representado por una estructura anterior.

`foldr` solo entrega `x` y `foldr f z xs`; la cola `xs` ya no está disponible. `recr` agrega exactamente esa información.

### Definición precisa

```haskell
recr :: b -> (a -> [a] -> b -> b) -> [a] -> b
recr z f []       = z
recr z f (x : xs) = f x xs (recr z f xs)
```

En el paso recursivo aparecen:

- `x :: a`, el dato local;
- `xs :: [a]`, la cola original;
- `recr z f xs :: b`, el resultado recursivo.

Para un tipo algebraico general, cada campo recursivo produce el par conceptual “subtérmino original + resultado procesado”.

### Cómo funciona

La recursión sigue bajando estructuralmente por `xs`, igual que en `foldr`. La diferencia no está en el argumento de la llamada, sino en la información que recibe el combinador.

```haskell
insertarOrdenado y =
  recr [y] (\x xs rec ->
    if y <= x
    then y : x : xs
    else x : rec)
```

Cuando `y <= x`, la función conserva la cola original. Cuando no, usa el resultado recursivo.

### Ejemplo mínimo

En un árbol, imaginemos que queremos saber si el hijo directo de un nodo tiene una forma particular. Un fold entrega únicamente la respuesta calculada para ese hijo; un `rec` puede entregar también el hijo original, permitiendo hacer pattern matching sobre su constructor.

No se trata de que el resultado booleano sea insuficiente por accidente: el fold eliminó deliberadamente la forma concreta del hijo.

### Por qué funciona

`rec` mantiene la misma disminución estructural que garantiza llegar al caso base, pero amplía la interfaz del combinador. La función puede decidir entre reutilizar el original y usar el resultado procesado.

La clase también señala que `rec` no agrega poder computacional esencial respecto de `foldr`: puede expresarse mediante un fold con un resultado enriquecido y un ajuste final. Su ventaja principal es describir de forma directa la información que la función necesita.

### Qué información conserva y cuál pierde

Conserva tanto los subtérminos originales como sus resultados. Aun así, el recorrido recursivo principal sigue fijado por la estructura: `rec` no permite llamar libremente a la función sobre cualquier argumento.

### Relación con otros conceptos

- **Generaliza a:** recursión primitiva sobre árboles y otros tipos algebraicos.
- **Se diferencia de:** fold, que solo conserva resultados; recursión general, que permite argumentos arbitrarios.
- **Necesita:** identificar una dependencia real de la estructura original.
- **Da lugar a:** decisiones locales que combinan inspección y resultados recursivos.

### Límites y contraejemplos

Tener el subtérmino original invita a recorrerlo de nuevo. Si en cada nodo se llama a otra función lineal sobre `xs`, una solución que podría ser de una pasada puede terminar siendo cuadrática.

Además, usar `rec` cuando no hace falta oculta la abstracción correcta: si todos los casos dependen solo de resultados recursivos, el fold expresa mejor la intención.

### Confusiones frecuentes

- Elegir `rec` porque una función parece difícil, sin verificar qué información necesita.
- Creer que `rec` es sinónimo de recursión general.
- Usar el original y olvidar el resultado recursivo, repitiendo recorridos innecesarios.
- Pasar originales en el tipo de un `foldX`, mezclando dos esquemas diferentes.

### Explicación para nene de 5

Imaginá que mandás dibujos a una máquina que los convierte en números. Un fold te devuelve solo el número de cada dibujo. Pero a veces querés ver el dibujo y también conocer su número. `rec` te entrega las dos cosas juntas.

Formalmente, el dibujo es el subtérmino original `xs` o un subárbol, y el número es el resultado recursivo de tipo `b`.

---

## 🟡 6. `foldl`: acumular desde el principio — diap. 32–43

### La idea intuitiva

`foldr` deja la combinación pendiente alrededor del resultado de procesar el resto. `foldl`, en cambio, lleva hacia adelante un acumulador que representa el resultado construido hasta el momento.

### Qué problema resuelve

Cuando interesa expresar una repetición con estado —similar a un `foreach`— es natural actualizar un acumulador en cada elemento y continuar con la cola.

### Definición precisa

```haskell
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f z []       = z
foldl f z (x : xs) = foldl f (f z x) xs
```

Las asociaciones son opuestas:

```haskell
foldl f z [x1,x2,x3] = f (f (f z x1) x2) x3
foldr f z [x1,x2,x3] = f x1 (f x2 (f x3 z))
```

### Cómo funciona

En cada paso, `f z x` construye el nuevo acumulador y la llamada continúa con la cola. Conceptualmente equivale a recorrer la lista con una variable mutable `ac`, aunque el código funcional construye nuevos valores en lugar de mutarla.

### Ejemplo mínimo

```haskell
foldl (+) 0 [1,2,3]
→ foldl (+) (0+1) [2,3]
→ foldl (+) ((0+1)+2) [3]
→ ((0+1)+2)+3
```

En Haskell perezoso, estas sumas pueden quedar pendientes. `foldl'` fuerza el acumulador en cada paso y evita acumular esa cadena de expresiones.

### Por qué funciona

La llamada recursiva es la operación principal y recibe el estado actualizado. Eso expresa una recursión a la cola. Sin embargo, la pereza de Haskell significa que el estado puede no evaluarse inmediatamente; por eso `foldl` y `foldl'` tienen comportamientos de memoria diferentes.

### Relación con otros conceptos

- **Se diferencia de:** `foldr`, que combina desde la estructura derecha de la expresión.
- **Necesita:** un acumulador que resuma el prefijo ya recorrido.
- **Da lugar a:** una correspondencia directa con iteraciones `foreach`.

### Límites y contraejemplos

`foldl` debe alcanzar el final de la lista antes de devolver el resultado. Sobre una lista infinita no termina. `foldr` puede producir resultados sobre listas infinitas si su combinador no necesita evaluar el segundo argumento.

### Confusiones frecuentes

- Creer que `foldl` común siempre usa memoria constante en Haskell.
- Cambiar `foldr` por `foldl` ignorando el orden de asociación.
- Usar `foldl` sobre una lista infinita esperando una respuesta temprana.

### Explicación para nene de 5

Imaginá que caminás por una fila de monedas con una alcancía. En cada moneda actualizás cuánto llevás y seguís caminando. La alcancía es el acumulador; la moneda actual es `x`; pasar a la siguiente moneda es la llamada recursiva sobre `xs`.

En Haskell perezoso, `foldl` puede meter en la alcancía papelitos que dicen “sumar después” en lugar de sumar enseguida; `foldl'` obliga a contar cada moneda antes de continuar.

---

## 🟡 7. Los teoremas de dualidad: cuándo los dos folds coinciden — diap. 38–43

### La idea intuitiva

`foldr` y `foldl` colocan paréntesis en lados opuestos. A veces mover esos paréntesis no cambia el resultado; otras veces sí. Los teoremas de dualidad especifican exactamente cuándo puede hacerse la transformación.

### Definición precisa

Si `f` es asociativa y `z` es su elemento neutro, para toda lista finita:

$$\operatorname{foldr}\ f\ z\ xs = \operatorname{foldl}\ f\ z\ xs$$

Un segundo teorema permite combinadores distintos `f` y `g`. Si:

$$x\mathbin{f}(y\mathbin{g}z)=(x\mathbin{f}y)\mathbin{g}z$$

$$x\mathbin{f}z_0=z_0\mathbin{g}x$$

entonces:

$$\operatorname{foldr}\ f\ z_0\ xs = \operatorname{foldl}\ g\ z_0\ xs$$

Sin hipótesis sobre `f`, siempre vale para listas finitas:

$$\operatorname{foldr}\ f\ z\ xs = \operatorname{foldl}\ (\operatorname{flip}\ f)\ z\ (\operatorname{reverse}\ xs)$$

### Cómo funciona

El primer teorema permite reasociar la misma operación. El segundo coordina dos operaciones diferentes. El tercero compensa la dirección del recorrido invirtiendo la lista y los argumentos del combinador.

### Ejemplo mínimo

Suma con `0` cumple el primer teorema porque `(+)` es asociativa y `0` es neutro. Resta con `0` no cumple las hipótesis:

```haskell
foldr (-) 0 [1,2,3] = 1 - (2 - (3 - 0))
foldl (-) 0 [1,2,3] = ((0 - 1) - 2) - 3
```

### Por qué funciona

Los teoremas describen transformaciones algebraicas de las expresiones anidadas producidas por ambos folds. No dependen de una implementación particular, sino de las propiedades de los combinadores.

### Límites y contraejemplos

La hipótesis “lista finita” es indispensable. Aunque dos expresiones coincidan algebraicamente para toda lista finita, `foldl` no puede producir un resultado sobre una lista infinita, mientras que `foldr` a veces sí.

### Confusiones frecuentes

- Recordar la igualdad y olvidar asociatividad, neutro o finitud.
- Pensar que conmutatividad es la condición central del primer teorema: la clase exige asociatividad y neutro.
- Suponer que dos folds con combinadores diferentes nunca pueden coincidir.

### Explicación para nene de 5

Si juntás tres cajas, podés juntar primero las dos de la derecha o primero las dos de la izquierda. Si el modo de juntar cajas siempre da lo mismo sin importar dónde ponés los paréntesis, ambos caminos terminan igual. Pero si la operación fuera “quitar”, cambiar el orden puede cambiar el resultado.

Formalmente, las cajas son los elementos, la forma de juntarlas es `f`, poder mover los paréntesis es asociatividad y la caja que no cambia nada es el neutro `z`.

---

## 🟡 8. Diseñar un resultado intermedio que conserve suficiente información — diap. 23, 58–60

### La idea intuitiva

A veces parece que un fold no alcanza, pero el problema no es el esquema: elegimos un resultado `b` demasiado pobre. Si el resultado recursivo pierde una distinción necesaria, puede enriquecerse para transportar más información hacia arriba.

### Qué problema resuelve

El promedio de una cola no basta para calcular el promedio al agregar una cabeza: también hace falta saber cuántos elementos había. Del mismo modo, una lista vacía `[]` no puede representar a la vez “no encontré el elemento” y “lo encontré en la raíz y no tiene ancestros”.

### Definición precisa

La clase propone para ancestros un resultado total:

```haskell
buscarAncestros :: Eq a => AB a -> a -> Maybe [a]
```

- `Nothing`: el elemento no está.
- `Just []`: está en la raíz.
- `Just xs`: está y `xs` contiene sus ancestros.

Luego ese `Maybe` puede combinarse mediante `foldAB` en una sola pasada.

### Cómo funciona

Cada subárbol entrega una respuesta completa. El nodo actual no necesita volver a preguntarle al subárbol si contiene el elemento: la presencia y el camino ya están codificados en `Maybe [a]`.

### Ejemplo mínimo

En un árbol de una sola raíz `r`:

```haskell
buscarAncestros arbol r = Just []
buscarAncestros arbol ausente = Nothing
```

Si se usara `[]` para ambos casos, el padre no podría distinguirlos.

### Por qué funciona

El fold puede combinar cualquier tipo `b`. Elegir un tipo suma como `Maybe` preserva una distinción lógica que una lista sola borraría. El diseño del resultado forma parte del diseño del algoritmo.

### Relación con otros conceptos

- **Se diferencia de:** `rec`; aquí no se conserva el subárbol original, sino una respuesta suficientemente informativa.
- **Necesita:** tipos algebraicos y funciones totales auxiliares.
- **Da lugar a:** soluciones lineales que evitan recorridos repetidos.

### Límites y contraejemplos

Enriquecer `b` sirve cuando la información necesaria puede calcularse recursivamente desde los hijos. Si la decisión depende de la forma original exacta de un subtérmino y no se quiere reconstruirla dentro de `b`, `rec` puede expresar mejor la intención.

### Confusiones frecuentes

- Concluir demasiado pronto que hace falta `rec`.
- Usar un mismo valor para dos estados semánticamente distintos.
- Diseñar primero el combinador sin decidir qué información debe transportar `b`.

### Explicación para nene de 5

Si preguntás “¿encontraste el juguete?”, no alcanza con que te entreguen una bolsa vacía: podría significar que no lo encontraron o que lo encontraron justo acá y no hubo que caminar. Es mejor recibir una tarjeta que diga claramente “no” o “sí, y este fue el camino”.

Formalmente, la tarjeta es `Maybe`, `Nothing` significa “no encontrado” y `Just camino` significa “encontrado con estos ancestros”.

---

## 🟡 9. Tipos recursivos anidados: por qué `RoseTree` requiere otra mirada — diap. 49, 61–63

### La idea intuitiva

En un árbol binario, los hijos aparecen directamente como campos del mismo tipo. En un rose tree, los hijos están guardados dentro de una lista. Para recorrer el árbol también hay que recorrer esa lista, así que intervienen dos estructuras inductivas.

### Qué problema resuelve

La receta regular dice “reemplazar cada campo recursivo por un resultado `b`”. Pero el campo de `Rose` no es `RoseTree a`: es `[RoseTree a]`. Hay que decidir cómo aplicar la recursión a todos los árboles de la lista y cómo combinar sus resultados.

### Definición precisa

```haskell
data RoseTree a = Rose a [RoseTree a]

foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose h (Rose x ts) = h x (map (foldRose h) ts)
```

`map (foldRose h) ts` aplica el plegado a cada hijo y produce una lista de resultados `[b]`.

### Cómo funciona

El recorrido del árbol llama al recorrido de lista (`map`) para alcanzar todos los hijos. Sin orden superior, aparecerían dos funciones mutuamente recursivas: una procesa árboles y otra procesa listas de árboles.

### Ejemplo mínimo

```haskell
sumRose (Rose x ts) = x + sum (map sumRose ts)
```

- `map sumRose ts` procesa cada hijo;
- `sum` combina los resultados de la lista;
- `x + ...` incorpora la raíz.

### Por qué funciona

La recursión anidada se descompone en dos recorridos estructurales: uno sobre `RoseTree` y otro sobre listas. La función de orden superior `map` hace visible esa composición.

### Relación con otros conceptos

- **Generaliza a:** tipos cuya recursión aparece dentro de otro functor o contenedor.
- **Se diferencia de:** tipos regulares con campos recursivos directos.
- **Necesita:** folds o maps del contenedor externo.
- **Da lugar a:** más de una convención posible para definir el esquema.

### Límites y contraejemplos

La clase vigente advierte que `foldRose` entrega a `h` la lista completa de resultados, dejando sin disciplinar qué recorrido adicional hace `h` sobre ella. Para imponer disciplina también sobre la lista habría que plegarla explícitamente y decidir cuánto de ese plegado forma parte del esquema. Por eso no hay una única convención inevitable.

### Confusiones frecuentes

- Reemplazar `[RoseTree a]` directamente por `b` en vez de obtener resultados para todos sus elementos.
- Confundir `[b]` con `b`.
- Decir que la definición habitual es la única forma posible del fold.

### Explicación para nene de 5

Imaginá una carpeta que contiene una lista de otras carpetas. Para revisar la carpeta grande tenés dos trabajos: abrir cada carpetita y también recorrer la lista para no saltearte ninguna. No es igual que una caja que tiene exactamente un hijo izquierdo y uno derecho.

Formalmente, la carpeta es `RoseTree`, la lista de carpetitas es `[RoseTree a]`, revisar cada una es `map (foldRose h)` y la lista de respuestas tiene tipo `[b]`.

---

## 🟡 10. Qué compramos al restringir la recursión — diap. 25–27, 65–72

### La idea intuitiva

Aceptar una restricción parece una pérdida, pero permite obtener propiedades que la recursión general no ofrece automáticamente. Al obligar a que el programa siga la estructura finita del dato, podemos razonar sobre él usando esa misma estructura.

### Qué problema resuelve

Una definición con recursión general puede no terminar y puede llamar a la función de maneras difíciles de analizar. Un esquema explícito delimita las formas permitidas y habilita leyes reutilizables.

### Definición precisa

Sobre valores finitos totalmente definidos, una recursión estructural termina porque cada llamada se hace sobre un subtérmino inmediato. Además admite inducción estructural.

La clase presenta también una ley de fusión/distribución:

$$\operatorname{foldr}\ (f \circ g)\ z = \operatorname{foldr}\ f\ z \circ \operatorname{map}\ g$$

Por ejemplo:

```haskell
totalMonedas
  = foldr ((+) . cantMonedas) 0
  = foldr (+) 0 . map cantMonedas
```

La segunda forma separa la transformación costosa de la combinación.

### Cómo funciona

La terminación y la inducción usan la misma observación: cada paso reduce el problema a los campos recursivos de un constructor. Las leyes algebraicas abstraen esa forma una vez y luego se aplican a todas las instancias bien tipadas.

### Ejemplo mínimo

Si `cantMonedas` es costosa, `map cantMonedas` deja explícitas las transformaciones independientes de cada persona. Estas pueden distribuirse entre máquinas. Para distribuir también la reducción hace falta que la operación combinadora tenga propiedades como asociatividad.

### Por qué funciona

El esquema fija el recorrido y vuelve visibles sus parámetros variables. Esa separación permite demostrar una propiedad sobre el esquema general en lugar de repetir la prueba para cada función concreta.

### Relación con otros conceptos

- **Generaliza a:** derivación algebraica de programas y MapReduce.
- **Se diferencia de:** recursión general, que conserva mayor poder expresivo.
- **Necesita:** leyes sobre combinadores y datos finitos para ciertas igualdades.
- **Da lugar a:** inducción estructural, tema de la clase siguiente.

### Límites y contraejemplos

La recursión estructural sí pierde poder: no puede expresar una función que deba divergir sobre un valor finito, como un intérprete que reproduce un `while (true)`. Los valores infinitos de Haskell también exigen considerar evaluación no estricta: no hay un constructor base finito al que necesariamente llegar.

La regla correcta no es “usar folds para todo”, sino usar el esquema cuando sus restricciones coinciden con el problema y saber por qué no cuando hace falta recursión general.

### Confusiones frecuentes

- Creer que el fold es solo una abreviatura sintáctica.
- Afirmar que toda función puede escribirse estructuralmente sin perder comportamiento.
- Aplicar una ley de transformación sin verificar sus tipos o hipótesis algebraicas.
- Confundir “termina sobre datos finitos” con “termina sobre cualquier valor de Haskell”.

### Explicación para nene de 5

En un juego libre podés hacer cualquier movimiento, pero es difícil asegurar que alguna vez termine. En un juego donde siempre tenés que sacar una pieza de la torre, sabés que una torre finita finalmente queda vacía y podés explicar lo que pasa según cuántas piezas tenía.

Formalmente, las reglas del juego son el esquema de recursión, sacar una pieza es llamar sobre un subtérmino y llegar a la torre vacía es alcanzar un constructor base.

---

## ⚪ Contexto para leer una vez

- **Rod Burstall** — introdujo en 1969 la conexión entre definir funciones siguiendo la forma del dato y demostrar propiedades mediante inducción estructural.
- **Richard Bird y Lambert Meertens** — desarrollaron un enfoque algebraico para derivar programas aplicando leyes, en lugar de escribirlos primero y verificarlos después.
- **John Backus** — defendió un estilo funcional construido con formas de combinación que permitieran leyes útiles; una de ellas era la reducción, es decir, el plegado.
- **Equivalentes en otros lenguajes** — `inject:into:` en Smalltalk y `reduce` de streams en Java también expresan plegados, aunque la clase señala diferencias de dirección.

---

## Síntesis de la clase

### El hilo completo en pocas palabras

La clase parte de funciones concretas que repiten el mismo esqueleto. Al extraer lo que cambia aparece `foldr`, que puede entenderse como reemplazar los constructores de una lista. Esa interpretación revela una idea general: los constructores de cualquier tipo algebraico determinan cómo consumirlo estructuralmente.

La disciplina ofrece al combinador solo datos locales y resultados recursivos. Gracias a esa restricción, la recursión termina sobre valores finitos y admite leyes e inducción. Cuando la función necesita información que el fold descartó, hay dos preguntas diferentes: ¿elegimos un `b` demasiado pobre, o realmente necesitamos el subtérmino original? En el primer caso se enriquece el resultado; en el segundo aparece `rec`.

`foldl` presenta otra organización: lleva un acumulador desde el comienzo. La pereza de Haskell obliga a distinguir el esquema conceptual de su comportamiento operacional y a conocer `foldl'`. Finalmente, `RoseTree` muestra que la recursión dentro de otra estructura requiere combinar los esquemas de ambas.

### Definiciones que hay que poder reconstruir

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z []       = z
foldr f z (x : xs) = f x (foldr f z xs)
```

```haskell
recr :: b -> (a -> [a] -> b -> b) -> [a] -> b
recr z f []       = z
recr z f (x : xs) = f x xs (recr z f xs)
```

```haskell
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f z []       = z
foldl f z (x : xs) = foldl f (f z x) xs
```

```haskell
foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB z g Nil = z
foldAB z g (Bin ti x td) =
  g (foldAB z g ti) x (foldAB z g td)
```

### Relaciones que hay que entender

- `map` y `filter` son instancias de `foldr`.
- `foldr` captura exactamente la recursión estructural sobre listas.
- El tipo `b` expresa toda la información que sobrevive al plegado.
- `b` puede ser una función gracias a currificación y polimorfismo.
- `rec` conserva subtérminos originales además de resultados.
- `foldl` usa un acumulador; `foldl'` lo fuerza en Haskell perezoso.
- La forma del tipo determina el fold solo de manera directa en tipos regulares.
- La misma estructura inductiva sustenta el fold, la terminación y la inducción estructural.

### Puente hacia la práctica

- **Forma del tipo → esquema:** en práctica se transforma en poder escribir el tipo y las ecuaciones de `foldX` o `recX` para un `data` nuevo.
- **Elegir `b`:** se aplica al definir funciones que cuentan, recorren, validan o reconstruyen una estructura usando el esquema.
- **Resultado funcional:** se aplica cuando una función recibe una estructura y un parámetro extra; el esquema puede construir `Parametro -> Resultado`.
- **Fold vs. rec:** se aplica al decidir si alcanzan los resultados recursivos o si hace falta conservar los subtérminos originales.
- **Resultado enriquecido:** se aplica antes de elegir `rec`: conviene preguntar si un `Maybe`, un par u otro tipo intermedio puede conservar la información necesaria en una sola pasada.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Forma del tipo y construcción de `foldX`/`recX` | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1 · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 1 | [[tipos_ejercicio/haskell_fold_tipo_arboles]] |
| Fold como interpretación de constructores y elección de `b` | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 1b–d · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 1b–d · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1b · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1b–e · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 1b–c | [[tipos_ejercicio/haskell_funciones_sobre_arboles]] |
| Fold/rec cuyo resultado es una función | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 1d · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1d · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1e | [[tipos_ejercicio/haskell_currificacion_evaluacion_parcial]] |
| Elegir `rec` cuando hace falta la estructura original | 🔴 | [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 1d · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 1c · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 1d | [[tipos_ejercicio/haskell_recursion_primitiva_rec]] |
| `foldl`, dualidad, resultados enriquecidos y leyes | 🟡 | Sin patrón compilado propio; se priorizan por provenir de la cursada vigente | — |
| `RoseTree` y recursión anidada | 🟡 | Variante adyacente: el filesystem de [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 1 es un árbol n-ario | [[tipos_ejercicio/haskell_fold_tipo_arboles]] |

**Base de comparación:** 11 parciales analizados, 23 patrones totales en `tipos_ejercicio/`; 4 patrones corresponden a `programacion_funcional`. El índice derivado tiene cobertura para el tema y no fue necesario abrir parciales ajenos a los patrones coincidentes.

## Lo que este documento NO cubre y igual toman

No quedan patrones compilados de `programacion_funcional` fuera del documento. La aplicación extensa de estos conceptos está en [[programacion_funcional_practica]] y [[programacion_funcional_guia]].

## Divergencias detectadas

- **Convención de `foldRose`:** [[programacion_funcional_practica]] presenta `foldRose :: (a -> [b] -> b) -> RoseTree a -> b` como esquema de recursión. La clase vigente usa la misma definición, pero agrega una precisión ausente en la página histórica: no la considera recursión estructural completamente disciplinada porque el combinador recibe toda la lista de resultados. Esta diferencia se reporta sin modificar la wiki; reconciliarla corresponde a `/ingestar`.
