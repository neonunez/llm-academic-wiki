---
nombre: Razonamiento ecuacional e inducción estructural — guía priorizada de entrenamiento
tipo: material_de_estudio
origen: raw/cursada_2C_2026/guias/guia2_razonamiento-demostracion.pdf
tipo_documento: guia
temas: [demostracion_de_propiedades]
parcial: 1P
programa: 2C_2026
generado: 2026-09-12
base_comparacion:
  parciales_analizados: 11
  tipos_ejercicio: 23
ingestado: false
---

# Razonamiento ecuacional e inducción estructural — guía priorizada de entrenamiento

**Fuente:** `raw/cursada_2C_2026/guias/guia2_razonamiento-demostracion.pdf` · **Tema:** `demostracion_de_propiedades` → **1P** (programa 2C_2026)

## Qué busca entrenar la guía

- Elegir entre reemplazo ecuacional, lema de generación, extensionalidad e inducción.
- Escribir una inducción completa: predicado, base, HI, tesis y justificación de cada igualdad.
- Generalizar parámetros cuando una llamada recursiva los modifica.
- Construir y usar lemas auxiliares sobre listas y árboles.

> La guía se declara como tal y su contenido es vigente. Aunque algunas variantes no tengan precedente histórico propio, se trabajan como 🟡 porque la cursada 2C 2026 es fuente de autoridad.

## Plan de trabajo

### Nivel 1 — adquirir la técnica
- Ej. 1 y 2: generación y extensionalidad.
- Ej. 3.i–v y 4.ii: inducción de listas y lemas de `++`.
- Ej. 9: inducción sobre naturales.

### Nivel 2 — consolidar
- Ej. 4.i, 5, 6 y 8: generalizar el acumulador o argumento que cambia.
- Ej. 7: decidir verdadero/falso antes de intentar demostrar.

### Nivel 3 — dificultad de parcial
- Ej. 10, 11, 12 y 14: inducción estructural sobre árboles, dos HI y lemas de orden.
- Ej. 13: inducción sobre un ADT de varias ramas y clasificación de recursión.

### Variantes opcionales
- Ej. 7, 8, 9 y 13 — amplían listas, `fold` y polinomios; conservan transferencia, pero no replican literalmente el patrón de árbol de los parciales.

## Selección rápida

| Ejercicio | Prioridad | Habilidad | Dependencia | Motivo |
|---|---|---|---|---|
| 1 | 🟡 | Lemas de generación | Ecuaciones | Base para desarmar datos no recursivos |
| 2 | 🟡 | Extensionalidad funcional | Ej. 1 | Base para igualdades entre funciones |
| 3 | 🔴 | Inducción en listas | Ecuaciones de listas | Mismo razonamiento inductivo evaluado |
| 4 | 🟡 | Generalización de acumulador | Ej. 3.iv–v | Variante clave con `foldl` |
| 5 | 🔴 | Inducción + extensionalidad | Ej. 3–4 | Transferencia directa a propiedades funcionales |
| 6 | 🟡 | HI generalizada sobre argumento | `foldr`, extensionalidad | Entrena reconocer parámetros que cambian |
| 7 | 🟡 | V/F, contraejemplos y lemas | Ej. 3 | Entrena propiedades no obvias |
| 8 | 🟡 | Fusión de folds | Ej. 3.v | Generalización para `foldl` |
| 9 | 🟡 | Inducción matemática | `foldNat` | Misma estructura en naturales |
| 10 | 🔴 | Inducción en AB y desigualdades | `max`, orden | Patrón directo de parcial |
| 11 | 🔴 | Inducción en AB con parámetro | Ej. 10 | Patrón directo de parcial |
| 12 | 🔴 | Inducción en AB + composición | `foldAB`, `inorder` | Patrón directo de parcial |
| 13 | 🟡 | Inducción en `Polinomio` | `foldPoli` | ADT de varias ramas |
| 14 | 🔴 | Inducción en AIH | Ej. 3–4, árboles | Patrón directo de parcial |

---

## 🟡 Ej. 1 — Extensionalidad y lemas de generación

### Enunciado
Demostrar las involuciones de `intercambiar`, `asociarI/asociarD` y `espejar`, y las igualdades de `flip` y `curry/uncurry` dadas en la guía.

### Qué tenés que producir
Una cadena ecuacional por ítem; para pares y `Either`, todos los casos de constructor.

### Qué conocimiento presupone
Ecuaciones definicionales y lemas de generación de productos y sumas.

### Pista de reconocimiento
Si la variable tiene tipo producto o suma pero no es recursiva, no hagas inducción: reemplazala por `(x,y)`, `Left x` o `Right y`.

### Plan de resolución
1. Fijá los cuantificados arbitrarios.
2. Abrí los constructores sólo cuando el argumento no está ya construido.
3. Reducí de adentro hacia afuera con la ecuación correspondiente.

### Resolución paso a paso
- i: sea `p = (x,y)`. `intercambiar (intercambiar p) = intercambiar (y,x) = (x,y) = p`.
- ii: sea `p = (x,(y,z))`. `asociarD (asociarI p) = asociarD ((x,y),z) = (x,(y,z)) = p`.
- iii: casos `Left x` y `Right y`; `espejar` intercambia los constructores dos veces.
- iv: `flip (flip f) x y = flip f y x = f x y`.
- v: `curry (uncurry f) x y = uncurry f (x,y) = f x y`.

### Control del resultado
Cada lado termina exactamente en el argumento generado o en `f x y`.

### Si te trabás
1. Escribí el tipo de la variable bloqueada.
2. Aplicá el lema de generación de ese tipo.
3. No inventes HI: no hay llamada recursiva.

### Variante que conviene intentar
Rehacé iii sin omitir ninguna rama de `Either`.

### Chuleta
> Tipo no recursivo → generar sus constructores → reemplazar por ecuaciones → cerrar el caso.

---

## 🟡 Ej. 2 — Igualdad de funciones por extensionalidad

### Enunciado
Demostrar `flip . flip = id`, `uncurry (curry f) = f`, `flip const = const id` y la asociatividad de `(.)`.

### Qué tenés que producir
Una prueba que aplique ambos lados a suficientes argumentos frescos y luego descargue esos argumentos por extensionalidad.

### Qué conocimiento presupone
Ej. 1, `id`, `const` y `(.) f g x = f (g x)`.

### Pista de reconocimiento
La meta es una igualdad cuyo lado es una función: aplicá argumentos hasta que las ecuaciones hagan match.

### Plan de resolución
Aplicá extensionalidad una vez por flecha. Para `uncurry (curry f)`, además generá el par de entrada.

### Resolución paso a paso
- i: sobre `f x y`, ambos lados reducen a `f x y` por Ej. 1.iv e `id`.
- ii: para `p=(x,y)`, `uncurry (curry f) p = curry f x y = f (x,y)`.
- iii: para `x y`, `flip const x y = const y x = y = id y = const id x y`.
- iv: para `x`, ambos lados reducen a `h (g (f x))`.

### Control del resultado
Indicá explícitamente las aplicaciones sucesivas de extensionalidad; no alcanza con comparar funciones sin argumentos.

### Si te trabás
1. Contá las flechas del tipo.
2. Introducí esa cantidad de variables frescas.
3. Reducí ambos lados a la misma forma normal.

### Variante que conviene intentar
Probá primero `map id = id` del Ej. 5: combina esta técnica con inducción.

### Chuleta
> Meta `f = g` → aplicar argumentos frescos → normalizar ambos lados → extensionalidad hacia afuera.

---

## 🔴 Ej. 3 — Lemas fundamentales sobre listas

### Enunciado
Demostrar las siete propiedades de `length`, `duplicar`, `(++)`, `map`, `filter` y `elem` de la guía.

### Qué tenés que producir
Inducciones sobre `xs`; en vii, una prueba de la implicación con casos sobre la guarda de `filter`.

### Qué conocimiento presupone
Ecuaciones de listas, aritmética básica y generación de `Bool`.

### Pista de reconocimiento
Inducí sobre el argumento que las definiciones consumen por pattern matching: el primer argumento de `(++)`, `map`, `filter` y `duplicar`.

### Plan de resolución
1. Para i, ii, iv, v y vi: base `[]`, paso `x:xs`, expandir, usar HI, reagrupar.
2. iii sale por definición: `[x] = x:[]`.
3. vii: suponé el antecedente y abrí `p x = True/False`; usá la HI sólo en la cola.

### Resolución paso a paso
- i: tras `{D1}` y dos `{L1}`, la HI deja `2 + 2*length xs = 2*length (x:xs)`.
- ii: la HI sobre `length (xs ++ ys)` deja `1 + (length xs + length ys)`.
- iii: `[x] ++ xs = (x:[]) ++ xs = x : xs`.
- iv: `(x:xs) ++ [] = x : (xs ++ []) = x:xs` por HI.
- v: expandí ambos `++`; la parte interna coincide por HI.
- vi: `length (map f (x:xs)) = 1 + length (map f xs) = 1 + length xs`.
- vii: con `p x=True`, el antecedente es `(e==x) || elem e (filter p xs)`; cada disyunto prueba `elem e (x:xs)`. Con `p x=False`, aplicá HI directamente a la cola.

### Control del resultado
La HI debe aplicarse a la llamada sobre `xs`, no sobre `x:xs`; en ii y v, `ys` y `zs` permanecen arbitrarios.

### Si te trabás
1. Escribí `P(xs)` incluyendo los cuantificadores que no cambian.
2. Desplegá hasta que aparezca la llamada en `xs`.
3. Citá asociatividad aritmética o de `++` sólo donde corresponda.

### Variante que conviene intentar
Usá iv y v como lemas nombrados antes de abordar Ej. 4.

### Chuleta
> Inducir sobre la lista consumida → base `[]` → paso `x:xs` → exponer recursión → HI → reagrupar.

---

## 🟡 Ej. 4 — `reverse` y acumuladores

### Enunciado
Demostrar la forma de `reverse` con `foldr`, que invierte concatenación y el corolario `reverse (xs ++ [x]) = x : reverse xs`.

### Qué tenés que producir
Un lema generalizado sobre el acumulador de `foldl` y luego una inducción en `xs`.

### Qué conocimiento presupone
Ej. 3.iii–v, extensionalidad y ecuaciones de `foldr/foldl`.

### Pista de reconocimiento
En el paso de `foldl`, el acumulador pasa de `ys` a `x:ys`: si la HI fijó `[]`, es demasiado débil.

### Plan de resolución
Probá primero `∀xs ys. foldl (flip (:)) ys xs = revF xs ++ ys`, con `revF = foldr (\x rec -> rec ++ [x]) []`.

### Resolución paso a paso
1. Base del lema: ambos lados reducen a `ys`.
2. Paso: instanciá la HI con `ys := x:ys`; usá asociatividad de `++` y `[x] ++ ys = x:ys`.
3. Instanciá `ys := []` para obtener `reverse = revF`.
4. Para ii, inducí en `xs`; en el paso usá `reverse (x:xs) = reverse xs ++ [x]` y asociatividad.
5. iii es ii con `ys=[x]`, calculando antes `reverse [x]=[x]`.

### Control del resultado
La HI del lema debe cuantificar `ys`; si no podés usarla con `x:ys`, falta generalización.

### Si te trabás
1. Marcá qué argumento cambia en `{FL1}`.
2. Mové ese argumento dentro de `P(xs)` con `∀`.
3. Reutilizá Ej. 3.v en vez de re-demostrar asociatividad.

### Variante que conviene intentar
Derivá las ecuaciones `reverse []=[]` y `reverse (x:xs)=reverse xs ++ [x]` antes de ii.

### Chuleta
> Acumulador que cambia → generalizarlo dentro de la HI → instanciar HI con el acumulador nuevo.

---

## 🔴 Ej. 5 — Identidades de `reverse`, `append`, `map` y `filter`

### Enunciado
Demostrar las siete igualdades/implicaciones de la guía, incluyendo `reverse . reverse = id`, `append = (++)`, leyes de `map`, fusión `map/filter` y la cota de `maximum`.

### Qué tenés que producir
Pruebas por inducción en listas, con extensionalidad para metas funcionales y análisis de casos para guardas o disyunciones.

### Qué conocimiento presupone
Ej. 3–4, congruencia de `==` y cotas superiores de `max`.

### Pista de reconocimiento
Una igualdad de funciones requiere extensionalidad antes de elegir la inducción; una guarda `if` exige separar sus valores booleanos.

### Plan de resolución
- i usa el corolario 4.iii y la HI.
- ii despliega `foldr (:)` y vuelve a plegar `(++)`.
- iii–iv inducen en la lista tras extensionalidad.
- v separa `p (f x)`.
- vi separa `e==x` o pertenencia a la cola.
- vii abre la cola en `[]` o `y:ys`, porque `maximum` tiene esos dos patrones.

### Resolución paso a paso
1. i: `reverse (reverse (x:xs)) = reverse (reverse xs ++ [x]) = x:reverse (reverse xs) = x:xs`.
2. ii: `append (x:xs) ys = x:append xs ys = x:(xs++ys) = (x:xs)++ys`.
3. iii: `map id (x:xs) = x:map id xs = x:xs`.
4. iv: expandí `map (g.f)` y `map g (map f ...)`; ambos quedan `g (f x) : ...` por HI.
5. v: si `p (f x)`, ambos lados conservan `f x`; si no, ambos lo descartan; cerrá con HI.
6. vi: si `e==x`, congruencia da `f e == f x`; si `e` está en la cola, aplicá HI.
7. vii: en `[x]`, el antecedente fuerza `e=x`; en `x:y:xs`, separá si `e==x` o está en la cola y acotá con `max`.

### Control del resultado
No uses la HI para transformar una función completa: primero aplicala al argumento lista concreto.

### Si te trabás
1. Para i, volvé a Ej. 4.iii.
2. Para v, fijá el valor de la guarda antes de reducir `filter`.
3. Para vii, recordá que `maximum []` no está definida.

### Variante que conviene intentar
Rehacé iv como igualdad puntual y recién al final descargá `xs`, `f` y `g`.

### Chuleta
> Igualdad funcional → extensionalidad; `if` → casos; árbol/lista → una HI por subestructura recursiva.

---

## 🟡 Ej. 6 — Equivalencia entre `zip` y `zip'`

### Enunciado
Demostrar `zip = zip'`, donde `zip` está expresada con `foldr` y devuelve una función.

### Qué tenés que producir
Extensionalidad e inducción en la primera lista, con HI cuantificada sobre la segunda.

### Qué conocimiento presupone
`foldr`, extensionalidad y Ej. 4.i.

### Pista de reconocimiento
La llamada recursiva usa `tail ys`, no el `ys` original: generalizá `ys`.

### Plan de resolución
Definí `P(xs) ≡ ∀ys. zip xs ys = zip' xs ys`; luego inducí en `xs`.

### Resolución paso a paso
1. Base: `zip [] ys = const [] ys = [] = zip' [] ys`.
2. Paso: desplegá el `foldr` y beta-reducí su lambda.
3. En la rama no vacía, reemplazá `zip xs (tail ys)` por `zip' xs (tail ys)` usando la HI.
4. Plegá con la ecuación recursiva de `zip'`; la rama vacía da `[]` en ambos lados.
5. Descargá `ys` y luego `xs` por extensionalidad.

### Control del resultado
La HI debe poder instanciarse con `tail ys`.

### Si te trabás
1. Escribí `∀ys` dentro de `P`.
2. Abrí `null ys` en `True/False`.
3. En la rama `False`, recién ahí aplicá HI.

### Variante que conviene intentar
Compará qué cambia respecto de Ej. 8.i: aquí el segundo argumento sí cambia.

### Chuleta
> `fold` que devuelve función + llamada con argumento transformado → cuantificar ese argumento en la HI.

---

## 🟡 Ej. 7 — Propiedades de `nub`, `union` e `intersect`

### Enunciado
Decidir V/F y justificar seis propiedades de pertenencia y longitud sobre conjuntos representados por listas.

### Qué tenés que producir
Demostraciones para i–iv y vi; un contraejemplo para v.

### Qué conocimiento presupone
Ej. 3, inducción y congruencia de `==` provista por el enunciado.

### Pista de reconocimiento
Antes de demostrar una igualdad de longitudes de `union`, probá listas con repetidos.

### Plan de resolución
I–IV y VI son verdaderas; V es falsa con `xs=[1]`, `ys=[1]`.

### Resolución paso a paso
1. i: inducí en `xs`, separando `p x`; la congruencia conecta `e==x` con `p e = p x`.
2. ii: usá i con el filtro que elimina repeticiones y abrí `e==x`.
3. iii: probá el lema `elem e (xs++ys) = elem e xs || elem e ys`; luego `union = nub (xs++ys)` e ii.
4. iv: instanciá i con el predicado `\z -> elem z ys`.
5. v: `union [1] [1] = [1]`, pero las longitudes del lado derecho suman `2`.
6. vi: probá `length (filter p zs) ≤ length zs`, luego `length (nub zs) ≤ length zs`, y combiná con `length (xs++ys)`.

### Control del resultado
La propiedad v es igualdad, no cota: un solo repetido la refuta.

### Si te trabás
1. Buscá un contraejemplo mínimo antes de inducir.
2. Nombrá el lema de `elem` sobre `++`.
3. Para vi, separá la cota de `filter` de la de `nub`.

### Variante que conviene intentar
Cambiá `union` por concatenación y revisá cuáles afirmaciones pasan a ser inmediatas.

### Chuleta
> V/F primero: repetidos atacan `union`; pertenencia se prueba con lemas de `filter`, `nub` y `++`.

---

## 🟡 Ej. 8 — Fusión de `foldr` y `foldl` con `(++)`

### Enunciado
Demostrar las dos distribuciones de `foldr` y `foldl` sobre concatenación.

### Qué tenés que producir
Dos inducciones en `xs`; en `foldl`, una HI generalizada en el acumulador `z`.

### Qué conocimiento presupone
Ecuaciones de folds y `(++)`.

### Pista de reconocimiento
En `foldr` el acumulador queda fijo; en `foldl` cambia a `f z x`.

### Plan de resolución
Inducí sobre la lista izquierda de `(++)`.

### Resolución paso a paso
- i: base por `{++0}` y `{F0}`. Paso: expandí `{++1}`, `{F1}`, aplicá HI y replegá `{F1}`.
- ii: definí `P(xs) ≡ ∀z ys. foldl f z (xs++ys) = foldl f (foldl f z xs) ys`. En el paso, instanciá HI con `z := f z x` y replegá `{FL1}`.

### Control del resultado
Si en ii tu HI sólo sirve para un `z` fijo, no puede justificar el paso.

### Si te trabás
1. Marcá el acumulador antes y después de `{FL1}`.
2. Generalizá sólo ese parámetro.
3. No hace falta generalizar `z` en i.

### Variante que conviene intentar
Explicá por qué i no necesita la generalización que ii sí.

### Chuleta
> `foldr`: HI directa. `foldl`: acumulador cambia → `∀z` dentro de la HI.

---

## 🟡 Ej. 9 — Corrección de `potencia`

### Enunciado
Demostrar por inducción en el exponente que `potencia b = foldNat 1 (b*)` calcula $b^n$.

### Qué tenés que producir
Inducción matemática en $n \ge 0$.

### Qué conocimiento presupone
Ecuaciones de `foldNat` de la práctica 1.

### Pista de reconocimiento
El natural se comporta como `Zero | Suc`; el paso usa $n+1$.

### Plan de resolución
Tomá $P(n) ≡ \forall b.\ potencia\ b\ n = b^n$.

### Resolución paso a paso
1. Base: `potencia b 0 = foldNat 1 (b*) 0 = 1 = b^0`.
2. Paso: `potencia b (n+1) = b * potencia b n = b * b^n = b^(n+1)` por HI.
3. Verificá que `{FN1}` es aplicable porque $n+1>0$.

### Control del resultado
La conclusión vale para todo exponente no negativo y termina porque el argumento decrece hasta `0`.

### Si te trabás
1. Escribí la tesis matemática explícita.
2. Reemplazá `n+1-1` por `n`.
3. Aplicá HI antes de la ley de potencias.

### Variante que conviene intentar
Compará este esquema con inducción sobre una lista: `0`/`n+1` reemplaza `[]`/`x:xs`.

### Chuleta
> Naturales: base 0 → paso n+1 → desplegar `foldNat` → HI → ley de potencias.

---

## 🔴 Ej. 10 — Altura acotada por cantidad de nodos

### Enunciado
Demostrar $\forall t::AB\ a.\ altura\ t \le cantNodos\ t$.

### Qué tenés que producir
Inducción en `AB`, con dos HI y un lema de no negatividad.

### Qué conocimiento presupone
Definiciones de `altura`, `cantNodos`, monotonía de `max` y del orden.

### Pista de reconocimiento
El constructor `Bin i r d` tiene dos subárboles: necesitás HI para `i` y para `d`.

### Plan de resolución
Antes, probá $cantNodos\ t\ge0$. Después inducí en $t$.

### Resolución paso a paso
1. Base: `altura Nil = 0 = cantNodos Nil`.
2. Paso: `altura (Bin i r d) = 1 + max (altura i) (altura d)`.
3. Por ambas HI y monotonía: $\le 1 + max(cantNodos\ i)(cantNodos\ d)$.
4. Por no negatividad, $max\ a\ b \le a+b$ para esos conteos.
5. Reescribí como `cantNodos (Bin i r d)`.

### Control del resultado
Justificá por qué el lema de no negatividad permite usar $max\ a\ b \le a+b$.

### Si te trabás
1. Escribí las dos HI por separado.
2. No reemplaces `max` por suma sin justificarlo.
3. Probá primero el lema auxiliar por la misma inducción de árbol.

### Variante que conviene intentar
Cambiá la tesis por una cota sobre una sola rama y observá qué HI necesitás.

### Chuleta
> Árbol binario → dos HI → expandir métricas → monotonicidad → lema de orden → cerrar.

---

## 🔴 Ej. 11 — `truncar` y altura

### Enunciado
Demostrar $altura\ t\ge0$ y, para $n\ge0$, $altura(truncar\ t\ n)=min\ n\ (altura\ t)$.

### Qué tenés que producir
Una inducción estructural para cada propiedad; en ii, casos sobre `n==0` y uso de los lemas de `min/max` provistos.

### Qué conocimiento presupone
Ej. 10, definición de `truncar`, y los dos lemas aritméticos del enunciado.

### Pista de reconocimiento
El árbol se recorre recursivamente y `n-1` llega a las ramas: la HI debe valer para todo $n\ge0$.

### Plan de resolución
Tomá $P(t) ≡ \forall n\ge0.\ altura(truncar\ t\ n)=min\ n\ (altura\ t)$.

### Resolución paso a paso
1. i: base `Nil`; paso `Bin` usa que $1+max$ de valores no negativos sigue siendo no negativo.
2. ii, base `Nil`: ambos lados son `0` porque `truncar Nil n=Nil` y `min n 0=0`.
3. En `Bin`, si `n=0`, `truncar` da `Nil` y ambos lados son `0`.
4. Si `n>0`, expandí `truncar`, `altura` y las dos HI con $n-1$.
5. Reasociá `1+max(min\ (n-1)\ hi)(min\ (n-1)\ hd)` con los lemas dados hasta $min\ n\ (1+max\ hi\ hd)$.

### Control del resultado
Chequeá que $n-1\ge0$ antes de invocar las HI.

### Si te trabás
1. Separá `n==0` primero.
2. Escribí las HI cuantificadas en `n`.
3. Sustituí las ramas sólo después de expandir `truncar`.

### Variante que conviene intentar
Contrastá el caso `n=0` con el de $n>0$: es el origen de la partición.

### Chuleta
> Parámetro decreciente a las ramas → `∀n≥0` en HI → caso 0 / positivo → HI con n−1 → lemas de min/max.

---

## 🔴 Ej. 12 — `elemAB = elem . inorder`

### Enunciado
Demostrar, para `Eq a`, $\forall e::a.\ elemAB\ e = elem\ e . inorder$.

### Qué tenés que producir
Extensionalidad sobre `e` y árbol, seguida de inducción estructural sobre el árbol.

### Qué conocimiento presupone
`foldAB`, `foldr`, `inorder`, `elem`, asociatividad de `||` y el lema de `elem` sobre `++`.

### Pista de reconocimiento
`inorder (Bin i x d)` concatena tres fragmentos; demostrà que `elem` sobre esa concatenación equivale a la disyunción de las tres búsquedas.

### Plan de resolución
Para cada `e`, inducí en el árbol $t$ la igualdad puntual `elemAB e t = elem e (inorder t)`.

### Resolución paso a paso
1. Base `Nil`: ambos `fold` dan `False`/`[]`, y `elem e []=False`.
2. Paso `Bin i x d`: expandí `elemAB` como `(e==x)||elemAB e i||elemAB e d`.
3. Aplicá ambas HI.
4. Expandí `inorder` como `inorder i ++ (x:inorder d)` y el lema de `elem` sobre `++` dos veces.
5. Reasociá `||` para obtener la misma expresión; descargá argumentos por extensionalidad.

### Control del resultado
No confundas el orden de `inorder` con el de la disyunción: la asociatividad, no la conmutatividad, basta si preservás el orden.

### Si te trabás
1. Nombrá $E(xs,ys): elem\ e\ (xs++ys)=elem\ e\ xs||elem\ e\ ys$.
2. Aplicalo primero a `inorder i` y luego a `x:inorder d`.
3. Recién entonces usá las HI.

### Variante que conviene intentar
Probá la propiedad sobre `foldAB` sin abreviar `inorder`.

### Chuleta
> Dos folds sobre árbol → inducción en árbol → HI por rama → convertir concatenación en `||` → reagrupar.

---

## 🟡 Ej. 13 — Polinomios, raíz y derivada

### Enunciado
Demostrar las cuatro propiedades de `foldPoli`, raíces, evaluación/derivación y constantes no negativas; clasificar la recursión de `derivado`.

### Qué tenés que producir
Inducciones sobre `Polinomio`, distinguiendo `X`, `Cte`, `Suma` y `Prod`.

### Qué conocimiento presupone
Ecuaciones de `foldPoli`, álgebra elemental y definición de `derivado`.

### Pista de reconocimiento
Cada constructor de `Polinomio` es un caso; `Suma` y `Prod` aportan dos HI.

### Plan de resolución
Usá inducción por estructura del polinomio; para ii, la raíz de un factor anula el producto.

### Resolución paso a paso
1. i: todos los constructores se reconstruyen con el mismo constructor, por lo que el `foldPoli` es `id`.
2. ii: de `evaluar r p=0`, expandí `evaluar r (Prod p q)` hasta `0 * evaluar r q = 0`.
3. iii: inducí en `p`; en `Prod (Cte k) p`, expandí derivada y evaluación y distribuí $k$ sobre la suma.
4. iv: `X` y `Cte` son inmediatos; `Suma` y `Prod` usan las HI porque `sinConstantesNegativas` combina con `&&`.
5. `derivado` es recursión estructural: las llamadas recursivas se hacen sólo sobre subpolinomios directos.

### Control del resultado
En iii, conservá explícitamente el factor `Cte k` en ambas ramas de la regla del producto.

### Si te trabás
1. Hacé una tabla de los cuatro constructores.
2. Para ii, evaluá el producto antes de hablar de raíces.
3. Para iv, verificá que `&&` requiere ambas HI.

### Variante que conviene intentar
Contrastá `derivado` con una función que recurriera sobre un polinomio recién construido: esa ya no sería estructural.

### Chuleta
> ADT con cuatro constructores → un caso por constructor; `Suma`/`Prod` → dos HI; la regla del producto guía la cuenta.

---

## 🔴 Ej. 14 — Hojas y espejo en árboles homogéneos

### Enunciado
Demostrar asociatividad de `hojas` respecto de `Bin`, que `espejo . espejo = id`, y que `hojas (espejo x) = reverse (hojas x)`.

### Qué tenés que producir
Cadenas ecuacionales para i y una inducción en `AIH` para ii–iii.

### Qué conocimiento presupone
Ej. 3.v, Ej. 4.ii–iii y las ecuaciones de `hojas` y `espejo`.

### Pista de reconocimiento
`espejo` intercambia las ramas; para iii, esa inversión corresponde exactamente a `reverse` de una concatenación.

### Plan de resolución
Primero usá asociatividad de `++`; después inducí sobre `x`.

### Resolución paso a paso
1. i: ambos lados reducen a `hojas x ++ hojas y ++ hojas z`; usá asociatividad de `++`.
2. ii, base `Hoja h`: espejo dos veces devuelve `Hoja h`. Paso: espejo dos veces de `Bin i d` usa las HI de ambas ramas.
3. iii, base: `reverse [h]=[h]`. Paso: `hojas (espejo (Bin i d)) = hojas (espejo d) ++ hojas (espejo i)`; por HI es `reverse (hojas d) ++ reverse (hojas i)`, que es `reverse (hojas i ++ hojas d)` por Ej. 4.ii.

### Control del resultado
En iii, el orden de las ramas debe invertirse una sola vez: por `espejo`, no otra vez al aplicar el lema de `reverse`.

### Si te trabás
1. Escribí las dos HI.
2. Expandí `espejo` antes de `hojas`.
3. Usá el lema de `reverse (xs++ys)` de derecha a izquierda si hace falta.

### Variante que conviene intentar
Probá que `espejo` preserva la cantidad de hojas.

### Chuleta
> Espejo invierte ramas → HI por ambas ramas → `reverse` invierte `++` → cerrar por asociatividad.

---

## Ejercicios redundantes u opcionales

- **Ej. 7** — vale la pena por V/F; no es una forma literal de parcial.
- **Ej. 8** — profundiza la generalización de acumuladores; practicar después de Ej. 4 y 6.
- **Ej. 9** — transfiere el esquema a naturales.
- **Ej. 13** — entrena un ADT distinto; hacerlo después de dominar árboles binarios.

## Criterio para considerar dominada la guía

- Puedo nombrar el principio correcto antes de calcular: reemplazo, generación, extensionalidad o inducción.
- Puedo escribir una HI con todos los parámetros que cambian en la llamada recursiva.
- Puedo completar Ej. 10, 11, 12 o 14 justificando cada uso de HI y lema.
- Puedo detectar que una igualdad sobre `union` falla por duplicados y dar un contraejemplo mínimo.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Ej. 3 | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Ej. 5 | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Ej. 10 | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Ej. 11 | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Ej. 12 | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Ej. 14 | 🔴 | [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] Ej. 2a · [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] Ej. 2a | [[tipos_ejercicio/induccion_estructural_arboles]] |
| Ej. 1, 2, 4, 6–9 y 13 | 🟡 | Sin aparición propia; material vigente 2C 2026 | — |

**Base de comparación:** 11 parciales analizados, 23 patrones en `tipos_ejercicio/`.

## Lo que este documento NO cubre y igual toman

- Ninguno: [[tipos_ejercicio/induccion_estructural_arboles]] queda cubierto por Ej. 3, 5 y 10–12, 14.

## Divergencias detectadas

- En el Ej. 14, el PDF escribe `hojas (Bin i d) = hojas a ++ hojas d`; el identificador `a` no está ligado. Esta nota usa `hojas i ++ hojas d`, que coincide con el constructor y con [[temas/demostracion_de_propiedades_guia]]. No se modificó la fuente ni la wiki.
