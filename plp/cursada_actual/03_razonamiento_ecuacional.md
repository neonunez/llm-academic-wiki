---
nombre: Razonamiento ecuacional e inducción estructural — explicación para comprender la clase
tipo: material_de_estudio
origen: raw/cursada_2C_2026/teo/03-Razonamiento_ecuacional.pdf
tipo_documento: teorica
temas: [demostracion_de_propiedades]
parcial: 1P
programa: 2C_2026
generado: 2026-08-31
base_comparacion:
  parciales_analizados: 11
  tipos_ejercicio: 23
ingestado: false
---

# Razonamiento ecuacional e inducción estructural — explicación para comprender la clase

La clase explica por qué, bajo ciertas hipótesis, un programa funcional puede tratarse como un conjunto de ecuaciones y cómo demostrar propiedades que valen para todos los valores de un tipo inductivo. El recorrido va desde reemplazar iguales por iguales hasta la inducción estructural, la extensionalidad funcional, los isomorfismos de tipos y el fortalecimiento de pruebas que inicialmente se traban.

**Fuente:** `raw/cursada_2C_2026/teo/03-Razonamiento_ecuacional.pdf` · **Tema:** `demostracion_de_propiedades` → **1P** (programa 2C_2026)  
**Cómo leer esto:** 🔴 = dominar en profundidad · 🟡 = entender · ⚪ = contexto

## El problema que organiza la clase

Una definición funcional como

```haskell
doble x = x + x
```

sirve para ejecutar, pero también afirma una igualdad: cualquier aparición de `doble e` puede reemplazarse por `e + e`, y el reemplazo puede hacerse en ambos sentidos. La pregunta central es cuánto razonamiento matemático puede trasladarse a programas y qué hace falta para justificar propiedades universales como:

```haskell
forall xs. map f (xs ++ ys) = map f xs ++ map f ys
```

El reemplazo por definiciones permite avanzar cuando conocemos la forma del argumento. Cuando una variable puede representar cualquier valor de un tipo inductivo, la inducción estructural organiza todos los casos posibles. Para comparar funciones aparece además la extensionalidad: no se compara cómo están escritas, sino qué hacen con cada entrada.

## Mapa conceptual

- La equivalencia denotacional permite leer las ecuaciones del programa en ambas direcciones.
- El principio de reemplazo justifica las igualdades que valen directamente por definición.
- Una variable desconocida puede bloquear el reemplazo; la forma del tipo indica cómo dividir la prueba.
- Los constructores base producen casos base y cada campo recursivo produce una hipótesis inductiva.
- Formular correctamente el predicado determina qué información estará disponible en el paso inductivo.
- Los lemas de generación permiten abrir casos sin fingir que siempre hace falta inducción.
- La extensionalidad funcional reduce una igualdad entre funciones a igualdades sobre sus resultados.
- Dos funciones inversas en ambos sentidos muestran que dos tipos guardan la misma información: son isomorfos.
- Si una hipótesis inductiva queda débil, puede hacer falta un lema auxiliar o generalizar el predicado.

## Conocimientos previos necesarios

- **Ecuaciones de un programa funcional** — cada ecuación relaciona una forma del lado izquierdo con la expresión que la define.
- **Pattern matching** — los constructores determinan qué ecuación puede aplicarse.
- **Tipos algebraicos inductivos** — un valor se construye finitamente con los constructores declarados por `data`.
- **Recursión estructural** — una función procesa los argumentos recursivos inmediatos del constructor.
- **Funciones de orden superior y currificación** — una función parcialmente aplicada sigue siendo un valor funcional que puede compararse punto a punto.
- **Cuantificadores** — al elegir la variable de inducción, los restantes `forall` suelen quedar dentro del predicado inductivo.

---

## 🔴 1. Ecuaciones como equivalencias y principio de reemplazo — diap. 4–11

### La idea intuitiva

En ejecución usamos una ecuación como una instrucción para simplificar: de `doble 3` pasamos a `3 + 3`. En una demostración la ecuación no tiene una dirección privilegiada. Podemos expandir una definición o reconocer su lado derecho y volver a plegarlo bajo el nombre definido.

La igualdad expresa que dos expresiones tienen la misma denotación, no que el intérprete deba ejecutar exactamente los mismos pasos.

### Qué problema resuelve

Permite justificar transformaciones de programas, optimizaciones y equivalencias sin ejecutar todas las entradas posibles. También fija qué cuenta como un paso válido: no alcanza con que una transformación “parezca obvia”; debe apoyarse en una ecuación nombrada, una hipótesis o una ley ya establecida.

### Definición precisa

Sea $e_1=e_2$ una ecuación incluida en el programa. El **principio de reemplazo** permite:

1. reemplazar cualquier instancia de $e_1$ por la instancia correspondiente de $e_2$;
2. reemplazar cualquier instancia de $e_2$ por la instancia correspondiente de $e_1$.

Si una igualdad se obtiene usando solo estos reemplazos, se dice que vale **por definición**.

La clase trabaja bajo estas hipótesis:

1. datos finitos, es decir, valores de tipos inductivos;
2. funciones totales: las ecuaciones cubren todos los casos y la recursión termina;
3. el significado no depende del orden textual de las ecuaciones.

Relajar estas hipótesis es posible, pero requiere una teoría más cuidadosa. Para funciones parciales, la clase solo anticipa propiedades restringidas a los casos en que devuelven un valor.

### Cómo funciona

Conviene nombrar las ecuaciones y escribir una cadena donde cada igualdad cite su justificación:

```haskell
{L0} length []       = 0
{L1} length (_ : xs) = 1 + length xs
{S0} suma []         = 0
{S1} suma (x : xs)   = x + suma xs
```

Entonces:

```text
length ["a", "b"]
= 1 + length ["b"]       {L1}
= 1 + (1 + length [])    {L1}
= 1 + (1 + 0)            {L0}
= 1 + (1 + suma [])      {S0, de derecha a izquierda}
= 1 + suma [1]           {S1, de derecha a izquierda}
= suma [1,1]             {S1, de derecha a izquierda}
```

La sustitución puede ocurrir dentro de un contexto mayor: si dos subexpresiones son iguales, reemplazar una por otra conserva la igualdad de toda la expresión.

### Ejemplo mínimo

```haskell
{SUC} sucesor n = n + 1
```

```text
sucesor (factorial 10) + 1
= (factorial 10 + 1) + 1       {SUC}
= sucesor (factorial 10 + 1)   {SUC, de derecha a izquierda}
```

No fue necesario saber cuánto vale `factorial 10`.

### Por qué funciona

Una ecuación del programa declara que sus dos lados representan el mismo valor. La igualdad es congruente: poner expresiones iguales dentro del mismo contexto no permite distinguirlas. Por eso el reemplazo conserva significado.

La ausencia de efectos es esencial para la libertad de reutilizar o reordenar expresiones. En un lenguaje imperativo, evaluar dos veces `f(3)` podría modificar estado o producir resultados distintos; entonces reemplazar `f(3) + f(3)` por `2 * f(3)` no sería automáticamente válido.

### Qué información conserva y cuál pierde

El razonamiento conserva la **denotación observable** de la expresión. No conserva necesariamente:

- el orden de evaluación;
- la cantidad de pasos;
- la estructura sintáctica;
- el algoritmo usado internamente.

Dos implementaciones pueden ser extensionalmente iguales y, aun así, tener costos o recorridos diferentes.

### Relación con otros conceptos

- **Generaliza a:** cadenas largas de equivalencias y transformación de programas.
- **Se diferencia de:** reducción operacional, que sí elige una dirección de ejecución.
- **Necesita:** pureza y las hipótesis de totalidad adoptadas por la clase.
- **Da lugar a:** la parte algebraica de las pruebas inductivas.

### Límites y contraejemplos

Una expresión con variable puede quedar bloqueada. Con

```haskell
{NT} not True  = False
{NF} not False = True
```

no hay ecuación aplicable directamente a `not (not x)`, porque todavía no sabemos si `x` es `True` o `False`. El reemplazo no demuestra por sí solo que `not (not x) = x` para todo booleano; hace falta cubrir todas las formas posibles de `x`.

Tampoco se puede aplicar una ecuación fuera del patrón que define. Por ejemplo, la ecuación de `head (x:xs)` no autoriza a simplificar `head []`.

### Confusiones frecuentes

- Creer que las ecuaciones solo se usan de izquierda a derecha.
- Confundir “mismo significado” con “misma sintaxis” o “misma ejecución”.
- Aplicar una definición sin unificar correctamente su patrón.
- Usar propiedades matemáticas no declaradas ni demostradas sin citarlas.
- Olvidar que la teoría presentada presupone totalidad y datos finitos.

### Explicación para nene de 5

Imaginá que una caja dice que una ficha roja vale exactamente dos fichas azules. Para contar, podés cambiar una roja por dos azules, pero también dos azules por una roja. No cambió lo que tenés; solo cambió cómo está escrito.

Formalmente, la ficha roja es $e_1$, las dos azules son $e_2$ y la regla de la caja es la ecuación $e_1=e_2$. Reemplazar en cualquier dirección cambia la expresión, pero conserva su denotación.

---

## 🔴 2. Inducción estructural: probar según la forma del dato — diap. 13–20

### La idea intuitiva

Para afirmar algo sobre **todos** los valores de un tipo no hace falta enumerarlos. Basta seguir la receta con la que se construyen: verificar las piezas iniciales y demostrar que cada constructor recursivo conserva la propiedad cuando ya vale para sus subpiezas.

La inducción estructural es el principio de prueba que corresponde exactamente a los tipos inductivos y a la recursión estructural.

### Qué problema resuelve

Destraba propiedades universales para las que una variable impide aplicar las ecuaciones. También ofrece una cobertura completa: cada valor finito fue construido por uno de los constructores del tipo, de modo que no queda una forma sin analizar.

### Definición precisa

Para un tipo esquemático

```haskell
data T = CBase1 parametros
       | ...
       | CRec parametros (campos de tipo T)
```

sea $P$ una propiedad sobre valores de tipo `T`. Si:

- $P$ vale para todos los constructores base;
- para cada constructor recursivo, suponer $P$ sobre **cada argumento recursivo inmediato** permite demostrar $P$ sobre el valor construido;

entonces:

$$\forall x :: T.\;P(x).$$

Para listas:

$$P([])$$

$$\forall x::a.\forall xs::[a].\;P(xs)\Rightarrow P(x:xs)$$

implican $\forall xs::[a].\;P(xs)$.

Para árboles binarios:

```haskell
data AB a = Nil | Bin (AB a) a (AB a)
```

hay dos hipótesis inductivas en el constructor `Bin`:

$$P(Nil)$$

$$\forall i,r,d.\;(P(i)\land P(d))\Rightarrow P(Bin\ i\ r\ d).$$

### Cómo funciona

El esquema se deriva mecánicamente de `data`:

1. cada constructor no recursivo genera un caso base;
2. cada constructor recursivo genera un caso inductivo;
3. cada campo del mismo tipo genera una hipótesis inductiva;
4. los campos no recursivos se consideran arbitrarios, pero no generan H.I.

Por ejemplo:

```haskell
data Poli a = X
            | Cte a
            | Suma (Poli a) (Poli a)
            | Prod (Poli a) (Poli a)
```

produce dos casos base (`X`, `Cte k`) y dos casos inductivos (`Suma p q`, `Prod p q`), cada uno con H.I. para `p` y `q`.

### Ejemplo mínimo

```haskell
data Nat = Zero | Suc Nat

{S0} suma Zero    m = m
{S1} suma (Suc n) m = Suc (suma n m)
```

Queremos probar:

$$\forall n::Nat.\;suma\ n\ Zero=n.$$

Definimos $P(n)\equiv suma\ n\ Zero=n$.

- **Caso base:**

```text
suma Zero Zero = Zero    {S0}
```

- **Caso inductivo:** suponemos como H.I.

```text
suma n Zero = n
```

  y demostramos:

```text
suma (Suc n) Zero
= Suc (suma n Zero)   {S1}
= Suc n               {H.I.}
```

### Por qué funciona

Todo valor finito del tipo se obtiene aplicando finitamente sus constructores. Los casos base cubren las construcciones sin subvalores recursivos. El paso inductivo permite subir desde subvalores ya cubiertos hacia un valor mayor. Así, la propiedad acompaña toda posible construcción del dato.

La correspondencia con la recursión estructural no es casual: la función se define descendiendo por los subdatos inmediatos y la prueba asciende usando propiedades de esos mismos subdatos.

### Qué información conserva y cuál pierde

El esquema conserva:

- la forma del constructor actual;
- los parámetros no recursivos arbitrarios;
- una H.I. por cada subestructura recursiva inmediata.

No entrega automáticamente:

- propiedades sobre valores no subordinados al constructor;
- una H.I. sobre un argumento que se dejó fuera de $P$;
- lemas algebraicos acerca de funciones auxiliares;
- una H.I. más fuerte que el predicado elegido.

### Relación con otros conceptos

- **Generaliza a:** listas, árboles, polinomios sintácticos y cualquier tipo inductivo.
- **Se diferencia de:** análisis por casos, que no supone la propiedad sobre subestructuras.
- **Necesita:** un tipo finito y un predicado unario bien formulado.
- **Da lugar a:** pruebas de corrección de funciones recursivas y leyes de folds.

### Límites y contraejemplos

Si en un caso recursivo no se usa ninguna H.I., probablemente solo hacía falta analizar constructores. También puede suceder que la inducción sea correcta pero insuficiente porque el predicado fijó demasiado pronto un parámetro; eso se corrige generalizando, no agregando una H.I. inventada.

El esquema presentado no cubre directamente valores infinitos ni razonamiento sobre no terminación, porque la clase presupone datos finitos y funciones totales.

### Confusiones frecuentes

- Generar una sola H.I. para un árbol con dos o tres hijos recursivos.
- Dar H.I. para campos que no son del tipo inductivo.
- Confundir la H.I. $P(i)$ con la tesis $P(Bin\ i\ r\ d)$.
- Hacer inducción sobre la variable que no guía las definiciones relevantes.
- Escribir “por inducción” sin exponer el predicado ni el esquema.

### Explicación para nene de 5

Pensá en árboles hechos con bloques. Hay un bloque `Nil` y un bloque `Bin` que une dos arbolitos. Primero comprobamos la regla para `Nil`. Después decimos: “si la regla ya funciona en el arbolito izquierdo y en el derecho, también funciona cuando los uno con `Bin`”. Así cubrimos cualquier árbol que pueda construirse.

Formalmente, los bloques son los constructores, la regla es $P$, las promesas sobre los arbolitos son $P(i)$ y $P(d)$, y la regla sobre el árbol unido es $P(Bin\ i\ r\ d)$.

---

## 🔴 3. Diseñar la prueba: predicado, cuantificadores, casos e H.I. — diap. 21–26

### La idea intuitiva

La inducción no es solo separar “base” y “paso”. Hay que empaquetar correctamente la afirmación dentro de un predicado de una variable. Lo que queda adentro del predicado estará disponible en la H.I.; lo que se fija afuera puede volverla demasiado débil.

Además, no toda división por constructores necesita H.I. A veces solo queremos saber qué formas puede tener un valor: eso es análisis por casos mediante un lema de generación.

### Qué problema resuelve

Organiza demostraciones con varios cuantificadores, implicaciones y funciones sobre más de un argumento. También evita dos errores opuestos: usar inducción cuando basta abrir casos y abrir casos cuando sí hace falta relacionar el resultado con subestructuras recursivas.

### Definición precisa

Para demostrar una propiedad sobre `xs`, los pasos conceptuales son:

1. entender la propiedad y elegir la variable cuya estructura dirige las definiciones;
2. formular $P(xs)$ dejando dentro los parámetros que deben permanecer arbitrarios;
3. escribir el esquema inducido por el tipo;
4. resolver cada caso base por reemplazo;
5. resolver cada caso inductivo, marcando exactamente dónde se usa cada H.I.

Ejemplo:

```haskell
{M0} map f []       = []
{M1} map f (x : xs) = f x : map f xs
{A0} [] ++ ys       = ys
{A1} (x : xs) ++ ys = x : (xs ++ ys)
```

Para probar

$$\forall f.\forall xs.\forall ys.\;map\ f\ (xs++ys)=map\ f\ xs++map\ f\ ys,$$

conviene inducir en `xs` y definir:

$$P(xs)\equiv\forall f.\forall ys.\;map\ f\ (xs++ys)=map\ f\ xs++map\ f\ ys.$$

Así la H.I. puede instanciarse para cualquier `f` e `ys` necesarios durante el paso.

### Cómo funciona

En el caso inductivo:

```text
map f ((x:xs) ++ ys)
= map f (x : (xs ++ ys))            {A1}
= f x : map f (xs ++ ys)            {M1}
= f x : (map f xs ++ map f ys)      {H.I.}
= (f x : map f xs) ++ map f ys      {A1}
= map f (x:xs) ++ map f ys          {M1}
```

Si la propiedad es una implicación $A\Rightarrow B$, se asume $A$ y se demuestra $B$. Si al expandir $A$ aparece una disyunción booleana, se analizan sus posibilidades. Por ejemplo, de

```text
(x == r) || elemAB x i || elemAB x d = True
```

surgen los casos en que la raíz coincide, el elemento está en el subárbol izquierdo o está en el derecho. Las H.I. corresponden a estos dos últimos subárboles.

Un **lema de generación** expresa que todo valor tiene alguna forma permitida por su tipo. Para listas finitas:

$$xs=[]\quad\text{o bien}\quad\exists y,ys.\;xs=y:ys.$$

Esto autoriza análisis por casos sin otorgar H.I.

### Ejemplo mínimo

Para demostrar $\forall x::Bool.\;not(not\ x)=x$:

- si `x = True`, `not (not True) = not False = True`;
- si `x = False`, `not (not False) = not True = False`.

Como `Bool` no tiene campos recursivos, esto es un análisis exhaustivo de constructores. Puede presentarse como su principio de inducción, pero no aparece ninguna H.I.

### Por qué funciona

El predicado define el contrato exacto de la H.I. Los cuantificadores internos permanecen disponibles para instanciarse después. Los lemas de generación son completos porque la declaración del tipo enumera todas las formas de construir valores.

Separar inducción de análisis por casos aclara de dónde proviene cada hecho: una H.I. relaciona una subestructura con la propiedad; un lema de generación solo informa la forma del dato.

### Qué información conserva y cuál pierde

Un predicado como

$$P(xs)\equiv\forall f,ys.\;E(xs,f,ys)$$

conserva la libertad de elegir `f` e `ys` al usar la H.I. En cambio, si se fija un acumulador concreto fuera del predicado, la H.I. solo habla de ese valor concreto y puede no coincidir con el acumulador modificado que aparece tras expandir la recursión.

El análisis por casos conserva la forma del constructor, pero no aporta ninguna afirmación inductiva sobre sus componentes.

### Relación con otros conceptos

- **Generaliza a:** pruebas con múltiples parámetros y propiedades condicionales.
- **Se diferencia de:** aplicar mecánicamente un esquema sin decidir qué cuantificar.
- **Necesita:** principio de reemplazo y lectura precisa del tipo.
- **Da lugar a:** lemas auxiliares y generalización cuando la H.I. todavía no alcanza.

### Límites y contraejemplos

Abrir `xs = []` o `xs = y:ys` no permite usar $P(ys)$ a menos que la prueba sea realmente inductiva. Recíprocamente, declarar una inducción pero no usar ninguna H.I. suele ocultar que solo se requería generación.

No se debe llamar “extensionalidad” a cualquier análisis de constructores. La extensionalidad funcional compara funciones punto a punto; abrir `Nil`/`Bin` para un árbol libre es un lema de generación o análisis estructural.

### Confusiones frecuentes

- Sacar fuera de $P$ parámetros que deberían seguir universalmente cuantificados.
- Usar una H.I. sin instanciar sus cuantificadores.
- Tratar una implicación como igualdad y olvidar asumir el antecedente.
- Concluir una disyunción booleana sin justificar sus casos.
- Llamar H.I. a una mera descripción del constructor.

### Explicación para nene de 5

Imaginá que te prometen una herramienta para arreglar cualquier autito de una caja. Si al pedir la herramienta dijiste “solo para el autito rojo”, después no podés usarla con el azul. Conviene pedir desde el comienzo “para cualquier color”.

Formalmente, el autito es la subestructura `xs`, el color es un parámetro como `f`, `ys` o un acumulador, y la herramienta es la H.I. Mantener $\forall$ esos parámetros dentro de $P(xs)$ hace que la H.I. sirva para cualquier instancia necesaria.

---

## 🟡 4. Extensionalidad funcional, observaciones y desigualdad — diap. 27–33

### La idea intuitiva

Dos funciones pueden estar escritas con algoritmos distintos y, sin embargo, ser iguales como funciones si ninguna entrada permite distinguir sus resultados. Esa es la mirada **extensional**. La mirada **intensional**, en cambio, se ocupa de cómo está construido el programa.

### Qué problema resuelve

Una igualdad como `swap . swap = id` compara valores funcionales. Sus definiciones no son sintácticamente iguales, por lo que el reemplazo no alcanza hasta aplicar ambas funciones a un argumento arbitrario.

### Definición precisa

Para $f,g::a\to b$:

$$f=g\Rightarrow \forall x::a.\;f\ x=g\ x.$$

El **principio de extensionalidad funcional** permite la vuelta:

$$\left(\forall x::a.\;f\ x=g\ x\right)\Rightarrow f=g.$$

La igualdad demostrada se interpreta con respecto a observaciones. Si $e_1=e_2::A$, ninguna observación admisible

```haskell
obs :: A -> Bool
```

puede aceptar uno y rechazar el otro.

### Cómo funciona

Para probar

```haskell
swap . swap = id :: (a,b) -> (a,b)
```

se toma un `p :: (a,b)` arbitrario. Mediante el lema de generación para pares, `p = (x,y)` para ciertos `x`, `y`. Entonces:

```text
(swap . swap) (x,y)
= swap (swap (x,y))   {def. (.)}
= swap (y,x)          {def. swap}
= (x,y)               {def. swap}
= id (x,y)            {def. id}
```

Como vale para todo argumento, las funciones son iguales por extensionalidad.

### Ejemplo mínimo

Para demostrar que dos funciones **no** son iguales basta encontrar una observación que las distinga. La clase propone:

```haskell
obs :: ((Int,Int) -> (Int,Int)) -> Bool
obs f = fst (f (1,2)) == 1
```

Entonces `obs id` reduce a `True`, mientras que `obs swap` reduce a `False`. Por lo tanto:

$$id\neq swap::(Int,Int)\to(Int,Int).$$

### Por qué funciona

Una función se observa aplicándola. Si todos los argumentos producen resultados iguales, no hay experimento funcional que distinga las funciones. Inversamente, una única entrada u observación diferenciadora refuta la igualdad universal.

### Qué información conserva y cuál pierde

La igualdad extensional conserva comportamiento observable. Deliberadamente ignora cómo se obtuvo:

- código fuente;
- estrategia interna;
- cantidad de comparaciones;
- complejidad temporal;
- nombres de funciones intermedias.

Por eso `quickSort` e `insertionSort` pueden compararse por el resultado que computan sin ser el mismo algoritmo.

### Relación con otros conceptos

- **Generaliza a:** funciones de varios argumentos, aplicando extensionalidad repetidas veces.
- **Se diferencia de:** igualdad intensional o sintáctica.
- **Necesita:** igualdad punto a punto.
- **Da lugar a:** pruebas de que dos conversiones son inversas.

### Límites y contraejemplos

Probar algunos ejemplos no prueba extensionalidad: hace falta un argumento arbitrario. Tampoco debe confundirse con abrir los constructores de un dato; para eso se usa generación o inducción.

La noción de observación depende de la semántica adoptada. En esta clase se razona bajo las hipótesis de pureza, totalidad y datos finitos declaradas al comienzo.

### Confusiones frecuentes

- Afirmar `f = g` después de probar solo `f 0 = g 0`.
- Comparar el texto de dos funciones en lugar de sus resultados.
- Omitir una aplicación de extensionalidad cuando el resultado sigue siendo una función.
- Creer que igualdad extensional implica igual costo o igual ejecución.

### Explicación para nene de 5

Hay dos máquinas con cajas de colores distintos. Ponemos cualquier pelota en ambas y siempre sale la misma figura. Aunque por dentro tengan engranajes diferentes, como máquinas hacen lo mismo.

Formalmente, las máquinas son $f$ y $g$, cada pelota es un argumento $x$, y que siempre salga la misma figura es $\forall x.\;f\ x=g\ x$. Eso permite concluir $f=g$ extensionalmente.

---

## 🟡 5. Isomorfismos de tipos: misma información con distinta forma — diap. 34–39

### La idea intuitiva

Dos tipos pueden organizar los datos de manera diferente sin guardar información diferente. Si podemos convertir de uno al otro y volver sin perder nada, representan dos formatos de la misma información.

### Qué problema resuelve

Permite distinguir una diferencia meramente estructural de una diferencia informativa. También conecta transformaciones conocidas —como currificar y descurrificar— con ecuaciones demostrables mediante extensionalidad.

### Definición precisa

Dos tipos $A$ y $B$ son **isomorfos**, escrito $A\simeq B$, si existen funciones totales

```haskell
f :: A -> B
g :: B -> A
```

tales que:

$$g\circ f=id_A$$

$$f\circ g=id_B.$$

No basta con poder convertir en ambas direcciones: ambas composiciones deben recuperar exactamente el valor original.

### Cómo funciona

Para

```haskell
f :: (String,(Int,Bool)) -> ((Bool,String),Int)
f (s,(i,b)) = ((b,s),i)

g :: ((Bool,String),Int) -> (String,(Int,Bool))
g ((b,s),i) = (s,(i,b))
```

las conversiones solo reordenan componentes. Probar `g . f = id` y `f . g = id` muestra formalmente que no se descartó ni inventó información.

### Ejemplo mínimo

La currificación establece:

$$((a,b)\to c)\simeq(a\to b\to c).$$

```haskell
curry   f x y   = f (x,y)
uncurry f (x,y) = f x y
```

Para demostrar `uncurry . curry = id` hacen falta dos usos de extensionalidad: uno para una función `f :: (a,b) -> c` y otro para su argumento `p :: (a,b)`. Luego se abre `p = (x,y)` y se reemplazan las definiciones.

### Por qué funciona

Si ir y volver es la identidad en ambos lados, cada valor de un tipo corresponde a un valor del otro sin colisiones ni pérdidas. Cada conversión deshace exactamente a la otra.

### Qué información conserva y cuál pierde

Un isomorfismo conserva toda la información necesaria para reconstruir el valor original. Puede cambiar:

- agrupación de pares;
- orden de componentes;
- forma de recibir argumentos;
- elección entre una función sobre una suma y un par de funciones.

Si una conversión descarta un componente o mezcla dos valores de modo irreversible, no puede satisfacer ambas leyes de identidad.

### Relación con otros conceptos

- **Generaliza a:** $(a,b)\simeq(b,a)$ y $(a,(b,c))\simeq((a,b),c)$.
- **Se diferencia de:** tener solo una función de conversión.
- **Necesita:** totalidad, composición, identidad y extensionalidad funcional.
- **Da lugar a:** leyes como $a\to(b,c)\simeq(a\to b,a\to c)$ y `Either a b -> c ≃ (a -> c, b -> c)`.

### Límites y contraejemplos

La existencia de `show :: A -> String` no prueba que `A ≃ String`: podría no existir una inversa total o distintos valores podrían mostrarse igual. Del mismo modo, proyectar `fst :: (a,b) -> a` pierde `b`, por lo que no puede invertirse para recuperar cualquier par original.

### Confusiones frecuentes

- Creer que dos conversiones cualesquiera ya forman un isomorfismo.
- Probar una sola composición y omitir la otra.
- Olvidar extensionalidad porque las identidades comparan funciones.
- Confundir “mismos habitantes escritos distinto” con igualdad literal de tipos.

### Explicación para nene de 5

Guardás tres juguetes en una mochila con bolsillos distintos. Podés moverlos a otra mochila y después devolver cada juguete exactamente a su lugar, sin perder ni duplicar ninguno. Las mochilas ordenan distinto, pero guardan la misma información.

Formalmente, las mochilas son $A$ y $B$, mover de una a otra es $f$, volver es $g$, y recuperar siempre el contenido original son las leyes $g\circ f=id_A$ y $f\circ g=id_B$.

---

## 🟡 6. Cuando una inducción se traba: lemas auxiliares y generalización — diap. 23–24 y 40–43

### La idea intuitiva

Una prueba puede estar bien encaminada y aun así quedarse sin una igualdad necesaria. Hay dos causas frecuentes:

1. falta una propiedad intermedia sobre una función auxiliar;
2. la H.I. habla de un caso demasiado particular y no puede aplicarse al estado modificado que produce la recursión.

En el primer caso se demuestra un lema. En el segundo se fortalece el predicado.

### Qué problema resuelve

Permite completar pruebas sobre composiciones, concatenación, reversa y funciones con acumuladores. La dificultad no está en hacer más reemplazos, sino en reconocer qué afirmación adicional permitiría conectar ambos lados.

### Definición precisa

Un **lema auxiliar** es una propiedad independiente que se demuestra antes y se usa como igualdad en la prueba principal. Por ejemplo, para relacionar `foldr` y `foldl` aparece:

$$foldl\ g\ z\ (xs++[x])=g\ (foldl\ g\ z\ xs)\ x.$$

La **generalización del predicado** reemplaza una propiedad particular $P$ por una más fuerte $Q$ con parámetros universalmente cuantificados. Si $Q$ implica $P$, demostrar $Q$ puede ser más fácil porque produce una H.I. reutilizable.

### Cómo funciona

#### Lema auxiliar

Para demostrar

```haskell
ceros . reverse = reverse . ceros
```

con

```haskell
reverse []       = []
reverse (x:xs)   = reverse xs ++ [x]
ceros []         = []
ceros (_:xs)     = 0 : ceros xs
```

la expansión del caso inductivo introduce `ceros (reverse xs ++ [x])`. La H.I. habla de `ceros (reverse xs)`, pero no distribuye `ceros` sobre `(++)`. Falta demostrar:

$$\forall xs,ys.\;ceros(xs++ys)=ceros\ xs++ceros\ ys.$$

Ese lema crea el puente algebraico que la H.I. principal no contiene.

#### Generalización

Para

```haskell
suma k []       = k
suma k (x:xs)   = suma (x+k) xs
```

una propiedad fijada en un acumulador puede producir una H.I. sobre `n`, mientras que el paso requiere aplicarla a `x+n`. Se fortalece a:

$$Q(xs)\equiv\forall k::Int.\;suma\ k\ (xs++ys)=suma\ (suma\ k\ xs)\ ys.$$

Como la H.I. vale para todo `k`, puede instanciarse en el acumulador actualizado.

La conversión eficiente de dígitos usa la misma idea:

$$numeroAc\ 0\ xs=numero\ xs$$

se fortalece a

$$\forall ac::Int.\;numeroAc\ ac\ xs=ac\cdot10^{length\ xs}+numero\ xs.$$

Al tomar $ac=0$ se recupera la propiedad original.

### Ejemplo mínimo

Supongamos que la H.I. dice solo `f 0 xs = g xs`, pero el caso recursivo deja `f (0+x) xs`. La H.I. no coincide. Una afirmación más fuerte,

$$\forall ac.\;f\ ac\ xs=h\ ac\ (g\ xs),$$

puede instanciarse con $ac=0+x$. Fortalecer la meta entrega una herramienta inductiva más flexible.

### Por qué funciona

Un lema aísla una transformación estable que puede reutilizarse. La generalización funciona porque una afirmación universal más fuerte genera una H.I. con más grados de libertad. Aunque parezca paradójico, a menudo es más fácil demostrar una propiedad fuerte por inducción que una versión débil cuya H.I. no acompaña la recursión.

### Qué información conserva y cuál pierde

Un buen fortalecimiento conserva como caso particular la meta original y agrega justamente el parámetro que cambia durante la llamada recursiva. Una generalización arbitraria puede ser falsa o tan amplia que no ayude.

Un lema encapsula información algebraica que no proviene automáticamente de la estructura inductiva. La inducción principal no “sabe” cómo interactúan `ceros` y `(++)` hasta que eso se demuestra.

### Relación con otros conceptos

- **Generaliza a:** pruebas de correctitud de versiones con acumulador.
- **Se diferencia de:** agregar pasos de cálculo sin una igualdad justificante.
- **Necesita:** diagnosticar la expresión exacta donde la prueba se traba.
- **Da lugar a:** demostraciones modulares y reutilización de leyes.

### Límites y contraejemplos

No todo atasco indica un lema: puede haberse elegido la variable de inducción incorrecta o formulado mal el predicado. Tampoco basta inventar una propiedad conveniente; el lema debe ser verdadero y demostrarse.

La propiedad fortalecida debe implicar la original. Si cambia el objetivo sin permitir recuperar el caso pedido, no es una generalización útil de esa meta.

### Confusiones frecuentes

- Usar el lema que justamente se intenta demostrar.
- Generalizar después de haber fijado el parámetro fuera del predicado sin reformular toda la inducción.
- Elegir un lema demasiado específico, que solo repite el atasco.
- Creer que una H.I. puede aplicarse a un acumulador distinto sin cuantificación universal.
- No comprobar que la propiedad fuerte recupera la original.

### Explicación para nene de 5

Querés abrir una puerta, pero tu llave solo sirve cuando la perilla está en cero. Cada vez que avanzás, la perilla cambia. En vez de pedir una llave para cero, pedís una llave que funcione para cualquier número. Entonces también funciona para el número nuevo.

Formalmente, la perilla es el acumulador `ac`, la llave es la H.I. y “para cualquier número” es $\forall ac$. Un lema auxiliar sería otra herramienta demostrada aparte, como una pieza que permite unir dos engranajes de la prueba.

---

## Síntesis de la clase

### El hilo completo en pocas palabras

Un programa funcional puro ofrece ecuaciones que pueden leerse en ambas direcciones. El reemplazo demuestra igualdades cuando las expresiones exponen una forma conocida. Cuando una variable puede tener cualquiera de las formas de un tipo inductivo, la inducción estructural cubre constructores base y recursivos, con una H.I. por subestructura. Formular bien el predicado decide la fuerza de esas hipótesis. La extensionalidad permite comparar funciones punto a punto; con ella se prueban también las leyes inversas de los isomorfismos. Si una inducción se traba, el diagnóstico suele conducir a un lema auxiliar o a una propiedad más general.

### Definiciones que hay que poder reconstruir

- Principio de reemplazo y significado de una igualdad por definición.
- Hipótesis de trabajo: datos finitos, funciones totales e independencia del orden de ecuaciones.
- Principio general de inducción estructural derivado de los constructores de `data`.
- Diferencia entre H.I., tesis inductiva y análisis por casos.
- Lema de generación.
- Principio de extensionalidad funcional.
- Observación que distingue dos expresiones y refuta una igualdad.
- Isomorfismo $A\simeq B$ mediante funciones inversas en ambos sentidos.
- Lema auxiliar y generalización de un predicado inductivo.

### Relaciones que hay que entender

- La reducción usa ecuaciones en una dirección; la equivalencia permite ambas.
- La recursión estructural sobre datos y la inducción estructural sobre propiedades siguen el mismo esqueleto.
- Los cuantificadores dentro de $P$ determinan qué puede instanciarse al usar la H.I.
- La generación aporta formas posibles; la inducción agrega hipótesis sobre subestructuras.
- La igualdad funcional requiere observar argumentos arbitrarios.
- Un isomorfismo es una conservación total de información demostrada por dos leyes de identidad.
- Una prueba trabada puede requerir una ley faltante o una H.I. más fuerte; son problemas distintos.

### Puente hacia la práctica

El principio de reemplazo se convierte en cadenas ecuacionales justificadas. La inducción estructural se convierte en la habilidad de leer un `data`, construir el esquema exacto y alinear cada H.I. con las llamadas recursivas. La formulación del predicado aparece al decidir qué parámetros deben quedar universalmente cuantificados. Los lemas de generación permiten abrir un segundo árbol, una lista o un booleano cuando una definición está bloqueada. Extensionalidad aparece al comparar funciones o funciones parcialmente aplicadas. Finalmente, lemas y generalización permiten reparar casos inductivos donde la expansión produce concatenaciones o acumuladores modificados.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Ecuaciones y reemplazo | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Inducción estructural | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Predicado, cuantificadores, casos e H.I. | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Extensionalidad y observaciones | 🟡 | Variante adyacente en [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a y [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Isomorfismos de tipos | 🟡 | Sin aparición propia en el patrón; contenido vigente de esta clase | — |
| Lemas auxiliares y generalización | 🟡 | Lema provisto en [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a; sin patrón independiente compilado | [[tipos_ejercicio/induccion_estructural_arboles]] |

**Base de comparación:** 11 parciales analizados, 23 patrones en `tipos_ejercicio/`. Para `demostracion_de_propiedades` hay un patrón compilado, [[tipos_ejercicio/induccion_estructural_arboles]], con cinco apariciones verificadas en parciales distintos. `wiki/sintesis/patrones_detectados.md` conserva un conteo anterior de tres apariciones; se tomó como autoridad el patrón actual y se verificaron sus cinco enlaces reales.

## Lo que este documento NO cubre y igual toman

Ninguno dentro de `demostracion_de_propiedades`: el único patrón compilado del tema, [[tipos_ejercicio/induccion_estructural_arboles]], está cubierto. La deducción natural que suele compartir el Ej. 2 pertenece al tema separado `sistemas_deductivos_y_deduccion_natural`.

## Divergencias detectadas

- La síntesis histórica [[sintesis/patrones_detectados]] informa tres apariciones de inducción estructural, mientras que [[tipos_ejercicio/induccion_estructural_arboles]] enumera cinco parciales reales. Este material usa los cinco enlaces verificados y no modifica la wiki.
