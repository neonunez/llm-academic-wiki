---
nombre: Práctica 2 - Razonamiento Ecuacional e Inducción Estructural
parcial: 1P
programa: 2C_2026
tipo: Guía de Ejercicios
tema: demostracion_de_propiedades
fuente: raw/guias_practicas/1.guia_1P_razonamiento_ecuacional_&_induccion_estructural.pdf
paginas_relacionadas: ["[[demostracion_de_propiedades_teoria]]", "[[demostracion_de_propiedades_practica]]"]
---

# Guía 2 — Razonamiento Ecuacional e Inducción Estructural

Esta guía se centra en la demostración formal de propiedades de funciones puras en Haskell utilizando razonamiento ecuacional, el principio de extensionalidad funcional y el principio de inducción estructural sobre diversos tipos de datos.

> [!IMPORTANT]
> En las demostraciones por inducción estructural, se deben justificar todos los pasos: axioma, lema, hipótesis inductiva (HI), etc. Es fundamental escribir el **esquema de inducción** utilizado.

---

## Extensionalidad y Lemas de Generación

### Ejercicio 1 ★
Sean las siguientes definiciones de funciones:

```haskell
- intercambiar (x,y) = (y,x)
- espejar (Left x) = Right x
  espejar (Right x) = Left x
- asociarI (x,(y,z)) = ((x,y),z)
- asociarD ((x,y),z) = (x,(y,z))
- flip f x y = f y x
- curry f x y = f (x,y)
- uncurry f (x,y) = f x y
```

Demostrar las siguientes igualdades usando los lemas de generación cuando sea necesario:
I. $\forall p :: (a,b) . \text{intercambiar} (\text{intercambiar } p) = p$
II. $\forall p :: (a,(b,c)) . \text{asociarD} (\text{asociarI } p) = p$
III. $\forall p :: \text{Either } a\ b . \text{espejar} (\text{espejar } p) = p$
IV. $\forall f :: a \to b \to c . \forall x :: a . \forall y :: b . \text{flip} (\text{flip } f) \ x \ y = f \ x \ y$
V. $\forall f :: a \to b \to c . \forall x :: a . \forall y :: b . \text{curry} (\text{uncurry } f) \ x \ y = f \ x \ y$

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Demostraciones básicas de involución y biyectividad mediante análisis de casos (lemas de generación) para tipos producto, suma y funciones.

**Resolución:**
Ecuaciones utilizadas:

```haskell
{INT}  intercambiar (x,y) = (y,x)
{ESP0} espejar (Left x)   = Right x
{ESP1} espejar (Right x)  = Left x
{AI}   asociarI (x,(y,z)) = ((x,y),z)
{AD}   asociarD ((x,y),z) = (x,(y,z))
{FLIP} flip f x y         = f y x
{CU}   curry f x y        = f (x,y)
{UN}   uncurry f (x,y)    = f x y
```

**Lemas de generación (LG) que se usan**
- **Pares:** si $p :: (a,b)$ entonces $\exists x::a.\ \exists y::b.\ p = (x,y)$.
- **Sumas:** si $p :: \text{Either } a\ b$ entonces, o bien $\exists x::a.\ p = \text{Left } x$, o bien $\exists y::b.\ p = \text{Right } y$.

Ninguno de estos tipos es recursivo, así que **no hay inducción**: alcanza con los lemas de generación más el principio de reemplazo.

---

**I.** $\forall p :: (a,b).\ \text{intercambiar} (\text{intercambiar } p) = p$

Sea $p::(a,b)$ arbitrario. Por LG de pares existen $x::a$, $y::b$ tales que $p = (x,y)$.

```haskell
  intercambiar (intercambiar p)
= intercambiar (intercambiar (x,y))   -- LG de pares
= intercambiar (y,x)                  -- {INT}
= (x,y)                               -- {INT}
= p                                   -- LG de pares
```

Como $p$ era arbitrario, vale para todo $p$. $\blacksquare$

---

**II.** $\forall p :: (a,(b,c)).\ \text{asociarD} (\text{asociarI } p) = p$

Sea $p::(a,(b,c))$. Por LG de pares, $p = (x,q)$ con $x::a$ y $q::(b,c)$; aplicando LG otra vez sobre $q$, $q = (y,z)$. Luego $p = (x,(y,z))$.

```haskell
  asociarD (asociarI p)
= asociarD (asociarI (x,(y,z)))   -- LG de pares (dos veces)
= asociarD ((x,y),z)              -- {AI}
= (x,(y,z))                       -- {AD}
= p                               -- LG de pares (dos veces)
```
$\blacksquare$

---

**III.** $\forall p :: \text{Either } a\ b.\ \text{espejar} (\text{espejar } p) = p$

Sea $p::\text{Either } a\ b$. Por LG de sumas hay exactamente dos casos.

*Caso $p = \text{Left } x$:*
```haskell
  espejar (espejar (Left x))
= espejar (Right x)          -- {ESP0}
= Left x                     -- {ESP1}
```

*Caso $p = \text{Right } y$:*
```haskell
  espejar (espejar (Right y))
= espejar (Left y)           -- {ESP1}
= Right y                    -- {ESP0}
```

En ambos casos se obtiene $p$, y por LG no hay más casos. $\blacksquare$

---

**IV.** $\forall f::a \to b \to c.\ \forall x::a.\ \forall y::b.\ \text{flip}(\text{flip } f)\ x\ y = f\ x\ y$

Sean $f$, $x$, $y$ arbitrarios. Vale **por definición** (sólo principio de reemplazo):

```haskell
  flip (flip f) x y
= (flip f) y x               -- {FLIP} instanciada con f := flip f
= f x y                      -- {FLIP}
```
$\blacksquare$

---

**V.** $\forall f::a \to b \to c.\ \forall x::a.\ \forall y::b.\ \text{curry}(\text{uncurry } f)\ x\ y = f\ x\ y$

```haskell
  curry (uncurry f) x y
= uncurry f (x,y)            -- {CU} instanciada con f := uncurry f
= f x y                      -- {UN}
```

Notar que acá **no** hace falta LG: el par $(x,y)$ ya viene construido, así que `uncurry` puede matchear directamente. $\blacksquare$

**Chuleta:**
> 1. Tipos **no recursivos** (pares, `Either`, funciones) → **lema de generación**, nunca inducción.
> 2. Reemplazá la variable por su forma generada: $p \rightsquigarrow (x,y)$, o `Left x` / `Right y` (un caso por constructor).
> 3. Aplicá las ecuaciones **de adentro hacia afuera**, una por línea, citando el nombre de la ecuación.
> 4. `flip`/`curry`/`uncurry` con todos sus argumentos aplicados → sale **"por definición"** (puro reemplazo).
> 5. Cerrá volviendo a la forma generada: $(x,y) = p$.

---

### Ejercicio 2 ★
Demostrar las siguientes igualdades utilizando el principio de extensionalidad funcional:

I. `flip . flip = id`
II. $\forall f :: (a,b) \to c . \text{uncurry} (\text{curry } f) = f$
III. `flip const = const id`
IV. $\forall f :: a \to b . \forall g :: b \to c . \forall h :: c \to d . ((h \cdot g) \cdot f) = (h \cdot (g \cdot f))$ con la definición usual de la composición: `(.) f g x = f (g x)`.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Uso del principio de extensionalidad: para demostrar $f = g$, basta demostrar que $\forall x, f(x) = g(x)$.

**Resolución:**
Ecuaciones adicionales:

```haskell
{ID}    id x       = x
{CONST} const x y  = x
{COMP}  (.) f g x  = f (g x)
```

Recordar el **principio de extensionalidad**: si $\forall x::a.\ f\ x = g\ x$ entonces $f = g$. Cuando las funciones tienen varios argumentos hay que aplicarlo **una vez por argumento**, de adentro hacia afuera.

---

**I.** `flip . flip = id`

Ambos lados tienen tipo $(a \to b \to c) \to (a \to b \to c)$. Sean $f::a \to b \to c$, $x::a$, $y::b$ arbitrarios:

```haskell
  ((flip . flip) f) x y
= (flip (flip f)) x y     -- {COMP}
= f x y                   -- Ejercicio 1.IV
= (id f) x y              -- {ID}
```

Por extensionalidad sobre $y$: $((\text{flip} \cdot \text{flip})\ f)\ x = (\text{id } f)\ x$.
Por extensionalidad sobre $x$: $(\text{flip} \cdot \text{flip})\ f = \text{id } f$.
Por extensionalidad sobre $f$: $\text{flip} \cdot \text{flip} = \text{id}$. $\blacksquare$

---

**II.** $\forall f::(a,b) \to c.\ \text{uncurry}(\text{curry } f) = f$

Sea $f$ arbitraria. Por extensionalidad basta ver que coinciden sobre todo $p::(a,b)$; por LG de pares, $p = (x,y)$:

```haskell
  uncurry (curry f) (x,y)
= curry f x y                -- {UN} con f := curry f
= f (x,y)                    -- {CU}
```

Como vale para todo $p$, por extensionalidad $\text{uncurry}(\text{curry } f) = f$. $\blacksquare$

---

**III.** `flip const = const id`

Ambos lados tienen tipo $b \to a \to a$. Sean $x::b$, $y::a$ arbitrarios:

```haskell
  flip const x y        |   const id x y
= const y x   -- {FLIP} |  = id y      -- {CONST}
= y           -- {CONST}|  = y         -- {ID}
```

Es decir, los dos lados reducen a $y$. Por extensionalidad sobre $y$ y luego sobre $x$: $\text{flip const} = \text{const id}$. $\blacksquare$

---

**IV.** $\forall f::a\to b.\ \forall g::b\to c.\ \forall h::c\to d.\ ((h \cdot g) \cdot f) = (h \cdot (g \cdot f))$

Sean $f,g,h$ arbitrarias y $x::a$ arbitrario:

```haskell
  ((h . g) . f) x       |    (h . (g . f)) x
= (h . g) (f x) -- {COMP}| = h ((g . f) x)   -- {COMP}
= h (g (f x))   -- {COMP}| = h (g (f x))     -- {COMP}
```

Ambos lados reducen a `h (g (f x))`. Por extensionalidad sobre $x$, $((h \cdot g) \cdot f) = (h \cdot (g \cdot f))$: la composición es **asociativa**. $\blacksquare$

**Chuleta:**
> 1. Meta de la forma $f = g$ → **extensionalidad**: aplicá ambos lados a variables frescas hasta poder usar las ecuaciones.
> 2. Reducí **cada lado por separado** a una misma forma normal.
> 3. Subí de nuevo quitando **un argumento por vez** (una aplicación de extensionalidad por argumento).
> 4. Si el argumento es de tipo producto/suma, primero **lema de generación** ($p = (x,y)$).
> 5. `(.)` sólo aporta `{COMP}`: $(f \cdot g)\ x = f\ (g\ x)$. `const x y = x`, `id x = x`.

---

## Inducción sobre Listas

En esta sección usaremos las definiciones de `length`, `foldr`, `foldl`, `map`, `filter`, `(++)`, `duplicar`, `append` y `reverse`.

### Ejercicio 3 ★
Demostrar las siguientes propiedades:
I. $\forall xs :: [a] . \text{length} (\text{duplicar } xs) = 2 * \text{length } xs$
II. $\forall xs :: [a] . \forall ys :: [a] . \text{length} (xs ++ ys) = \text{length } xs + \text{length } ys$
III. $\forall xs :: [a] . \forall x :: a . [x] ++ xs = x:xs$
IV. $\forall xs :: [a] . xs ++ [] = xs$
V. $\forall xs :: [a] . \forall ys :: [a] . \forall zs :: [a] . (xs ++ ys) ++ zs = xs ++ (ys ++ zs)$
VI. $\forall xs :: [a] . \forall f :: (a \to b) . \text{length} (\text{map } f \ xs) = \text{length } xs$
VII. $\forall xs :: [a] . \forall p :: a \to \text{Bool} . \forall e :: a . (\text{elem } e \ (\text{filter } p \ xs) \implies \text{elem } e \ xs)$ (si vale `Eq a`).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Propiedades fundamentales de operaciones sobre listas demostradas por inducción estructural sobre $xs$.

**Resolución:**
Ecuaciones utilizadas:

```haskell
{L0}   length []       = 0
{L1}   length (x:xs)   = 1 + length xs
{D0}   duplicar []     = []
{D1}   duplicar (x:xs) = x : x : duplicar xs
{++0}  [] ++ ys        = ys
{++1}  (x:xs) ++ ys    = x : (xs ++ ys)
{M0}   map f []        = []
{M1}   map f (x:xs)    = f x : map f xs
{FI0}  filter p []     = []
{FI1}  filter p (x:xs) = if p x then x : filter p xs else filter p xs
{E0}   elem e []       = False
{E1}   elem e (x:xs)   = (e == x) || elem e xs
```

**Esquema de inducción sobre listas** (el mismo para todos los ítems salvo III):
1. Caso base: $P([])$
2. Caso inductivo: $\forall x::a.\ \forall xs::[a].\ (P(xs) \Rightarrow P(x:xs))$

---

**I.** $P(xs) \equiv \text{length}(\text{duplicar } xs) = 2 * \text{length } xs$. Inducción estructural sobre $xs$.

*Caso base $P([])$:*
```haskell
  length (duplicar [])
= length []              -- {D0}
= 0                      -- {L0}
= 2 * 0                  -- aritmética
= 2 * length []          -- {L0}
```

*Caso inductivo.* **HI:** $\text{length}(\text{duplicar } xs) = 2 * \text{length } xs$. **Tesis:** $\text{length}(\text{duplicar } (x\!:\!xs)) = 2 * \text{length } (x\!:\!xs)$.
```haskell
  length (duplicar (x:xs))
= length (x : x : duplicar xs)     -- {D1}
= 1 + length (x : duplicar xs)     -- {L1}
= 1 + (1 + length (duplicar xs))   -- {L1}
= 2 + 2 * length xs                -- HI
= 2 * (1 + length xs)              -- distributiva
= 2 * length (x:xs)                -- {L1}
```
$\blacksquare$

---

**II.** $P(xs) \equiv \forall ys::[a].\ \text{length}(xs +\!\!+ ys) = \text{length } xs + \text{length } ys$. Inducción sobre $xs$ ($ys$ queda fijo pero arbitrario).

*Caso base:*
```haskell
  length ([] ++ ys)
= length ys                    -- {++0}
= 0 + length ys                -- neutro de +
= length [] + length ys        -- {L0}
```

*Caso inductivo.* **HI:** $\text{length}(xs +\!\!+ ys) = \text{length } xs + \text{length } ys$.
```haskell
  length ((x:xs) ++ ys)
= length (x : (xs ++ ys))          -- {++1}
= 1 + length (xs ++ ys)            -- {L1}
= 1 + (length xs + length ys)      -- HI
= (1 + length xs) + length ys      -- asociatividad de +
= length (x:xs) + length ys        -- {L1}
```
$\blacksquare$

---

**III.** $\forall xs::[a].\ \forall x::a.\ [x] +\!\!+ xs = x\!:\!xs$

**No requiere inducción**: vale *por definición*, porque `[x]` es azúcar sintáctico de `x:[]`, o sea que ya está en forma de constructor.
```haskell
  [x] ++ xs
= (x:[]) ++ xs      -- notación de listas
= x : ([] ++ xs)    -- {++1}
= x : xs            -- {++0}
```
$\blacksquare$

---

**IV.** $P(xs) \equiv xs +\!\!+ [] = xs$. Inducción sobre $xs$ (acá sí hace falta: el que se consume es el argumento izquierdo).

*Caso base:* `[] ++ [] = []` por {++0}.

*Caso inductivo.* **HI:** $xs +\!\!+ [] = xs$.
```haskell
  (x:xs) ++ []
= x : (xs ++ [])    -- {++1}
= x : xs            -- HI
```
$\blacksquare$

> Este lema (`[]` es neutro **a derecha** de `++`) se usa una y otra vez en el resto de la práctica.

---

**V.** $P(xs) \equiv \forall ys, zs::[a].\ (xs +\!\!+ ys) +\!\!+ zs = xs +\!\!+ (ys +\!\!+ zs)$. Inducción sobre $xs$.

*Caso base:*
```haskell
  ([] ++ ys) ++ zs
= ys ++ zs            -- {++0}
= [] ++ (ys ++ zs)    -- {++0} (leída de derecha a izquierda)
```

*Caso inductivo.* **HI:** $(xs +\!\!+ ys) +\!\!+ zs = xs +\!\!+ (ys +\!\!+ zs)$.
```haskell
  ((x:xs) ++ ys) ++ zs
= (x : (xs ++ ys)) ++ zs      -- {++1}
= x : ((xs ++ ys) ++ zs)      -- {++1}
= x : (xs ++ (ys ++ zs))      -- HI
= (x:xs) ++ (ys ++ zs)        -- {++1}
```
$\blacksquare$ (asociatividad de `++`, el otro lema estrella de la guía).

---

**VI.** $P(xs) \equiv \forall f::a\to b.\ \text{length}(\text{map } f\ xs) = \text{length } xs$. Inducción sobre $xs$.

*Caso base:*
```haskell
  length (map f [])
= length []           -- {M0}
= length []
```

*Caso inductivo.* **HI:** $\text{length}(\text{map } f\ xs) = \text{length } xs$.
```haskell
  length (map f (x:xs))
= length (f x : map f xs)     -- {M1}
= 1 + length (map f xs)       -- {L1}
= 1 + length xs               -- HI
= length (x:xs)               -- {L1}
```
$\blacksquare$ (`map` preserva la longitud).

---

**VII.** $P(xs) \equiv \forall p::a\to\text{Bool}.\ \forall e::a.\ (\text{elem } e\ (\text{filter } p\ xs) \Rightarrow \text{elem } e\ xs)$. Inducción sobre $xs$; dentro del paso inductivo, análisis de casos sobre `p x` (lema de generación de `Bool`).

*Caso base:* `elem e (filter p []) = elem e [] = False` por {FI0} y {E0}. El antecedente es `False`, así que la implicación vale **por antecedente falso**. ✓

*Caso inductivo.* **HI:** $\text{elem } e\ (\text{filter } p\ xs) \Rightarrow \text{elem } e\ xs$.
Supongamos `elem e (filter p (x:xs)) = True`. Por LG de `Bool`, `p x` es `True` o `False`.

*Subcaso `p x = True`:*
```haskell
  elem e (filter p (x:xs))
= elem e (x : filter p xs)              -- {FI1} con p x = True
= (e == x) || elem e (filter p xs)      -- {E1}
```
Como la disyunción es `True`, alguno de los dos vale:
- si `e == x = True`, entonces `elem e (x:xs) = (e == x) || elem e xs = True` por {E1};
- si `elem e (filter p xs) = True`, por **HI** vale `elem e xs = True`, y entonces `elem e (x:xs) = (e == x) || True = True` por {E1}.

*Subcaso `p x = False`:*
```haskell
  elem e (filter p (x:xs))
= elem e (filter p xs)      -- {FI1} con p x = False
```
Luego el supuesto es `elem e (filter p xs) = True`, y por **HI** `elem e xs = True`, de donde `elem e (x:xs) = (e == x) || True = True` por {E1}.

En todos los casos vale la tesis. $\blacksquare$

**Chuleta:**
> 1. Elegí **inducción sobre la lista que se consume** (la que aparece pattern-matcheada en las ecuaciones).
> 2. Base `[]`: reducí ambos lados con {L0}/{++0}/{M0}/{D0} hasta `0` o `[]`.
> 3. Paso `x:xs`: aplicá {L1}/{++1}/{M1}/{D1} para **exponer la llamada recursiva** → metés la **HI** → reagrupás con aritmética.
> 4. `[x] ++ xs = x:xs` sale **por definición** (`[x]` ya es `x:[]`), sin inducción.
> 5. Implicaciones (vii): base por **antecedente falso**; paso con **análisis de casos sobre `p x`** y sobre la disyunción de {E1}.
> 6. Memorizá: `xs ++ [] = xs` (iv) y `(xs++ys)++zs = xs++(ys++zs)` (v) — son los lemas que vas a citar en toda la guía.

---

### Ejercicio 4 ★
Demostrar las siguientes propiedades:
I. `reverse = foldr (\x rec -> rec ++ [x]) []`
II. $\forall xs :: [a] . \forall ys :: [a] . \text{reverse} (xs ++ ys) = \text{reverse } ys ++ \text{reverse } xs$
III. $\forall xs :: [a] . \forall x :: a . \text{reverse} (xs ++ [x]) = x:\text{reverse } xs$

**Nota:** se puede utilizar cualquiera de las dos definiciones de `reverse` según sea conveniente.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Propiedades de inversión de listas, que suelen requerir lemas auxiliares sobre la asociatividad de `++`.

**Resolución:**
Ecuaciones utilizadas:

```haskell
{R0}   reverse = foldl (flip (:)) []
{F0}   foldr f z []     = z
{F1}   foldr f z (x:xs) = f x (foldr f z xs)
{FL0}  foldl f z []     = z
{FL1}  foldl f z (x:xs) = foldl f (f z x) xs
{FLIP} flip f x y       = f y x
```
Abreviamos $g = $ `\x rec -> rec ++ [x]` y `revF = foldr g []`.

---

**I.** `reverse = foldr (\x rec -> rec ++ [x]) []`

El problema es que `reverse` está definida con `foldl`, es decir **con acumulador**: si intentamos inducción directa sobre `xs`, la HI queda fijada al acumulador `[]` y no sirve para el paso inductivo (donde el acumulador pasa a ser `x:[]`). Hay que **generalizar el predicado sobre el acumulador**.

> **Lema (generalización):** $\forall xs::[a].\ \forall ys::[a].\ \text{foldl (flip (:))}\ ys\ xs = \text{revF } xs +\!\!+ ys$

*Demostración del lema*, por inducción sobre $xs$ con $P(xs) \equiv \forall ys::[a].\ \dots$ (el $\forall ys$ va **adentro** del predicado, eso es lo que hace utilizable la HI).

*Caso base:*
```haskell
  foldl (flip (:)) ys []
= ys                          -- {FL0}
= [] ++ ys                    -- {++0}
= foldr g [] [] ++ ys         -- {F0}
= revF [] ++ ys
```

*Caso inductivo.* **HI:** $\forall ys.\ \text{foldl (flip (:))}\ ys\ xs = \text{revF } xs +\!\!+ ys$.
```haskell
  foldl (flip (:)) ys (x:xs)
= foldl (flip (:)) (flip (:) ys x) xs   -- {FL1}
= foldl (flip (:)) (x:ys) xs            -- {FLIP}: flip (:) ys x = (:) x ys = x:ys
= revF xs ++ (x:ys)                     -- HI instanciada con ys := x:ys
```
y por el otro lado
```haskell
  revF (x:xs) ++ ys
= (g x (revF xs)) ++ ys          -- {F1}
= (revF xs ++ [x]) ++ ys         -- definición de g (beta)
= revF xs ++ ([x] ++ ys)         -- Ej. 3.V (asociatividad de ++)
= revF xs ++ (x:ys)              -- Ej. 3.III
```
Ambos lados coinciden. ∎ (lema)

*Vuelta a la propiedad.* Por extensionalidad, sea $xs$ arbitrario:
```haskell
  reverse xs
= foldl (flip (:)) [] xs    -- {R0}
= revF xs ++ []             -- Lema con ys := []
= revF xs                   -- Ej. 3.IV
```
Por extensionalidad, `reverse = foldr (\x rec -> rec ++ [x]) []`. $\blacksquare$

De acá en adelante usamos libremente las ecuaciones derivadas
```haskell
{R1} reverse []     = []
{R2} reverse (x:xs) = reverse xs ++ [x]
```
(que se obtienen aplicando {F0} y {F1} a la definición recién demostrada).

---

**II.** $P(xs) \equiv \forall ys::[a].\ \text{reverse}(xs +\!\!+ ys) = \text{reverse } ys +\!\!+ \text{reverse } xs$. Inducción sobre $xs$.

*Caso base:*
```haskell
  reverse ([] ++ ys)
= reverse ys                        -- {++0}
= reverse ys ++ []                  -- Ej. 3.IV
= reverse ys ++ reverse []          -- {R1}
```

*Caso inductivo.* **HI:** $\text{reverse}(xs +\!\!+ ys) = \text{reverse } ys +\!\!+ \text{reverse } xs$.
```haskell
  reverse ((x:xs) ++ ys)
= reverse (x : (xs ++ ys))              -- {++1}
= reverse (xs ++ ys) ++ [x]             -- {R2}
= (reverse ys ++ reverse xs) ++ [x]     -- HI
= reverse ys ++ (reverse xs ++ [x])     -- Ej. 3.V
= reverse ys ++ reverse (x:xs)          -- {R2}
```
$\blacksquare$

---

**III.** $\forall xs::[a].\ \forall x::a.\ \text{reverse}(xs +\!\!+ [x]) = x : \text{reverse } xs$

**Corolario de II**, sin inducción nueva. Primero calculamos `reverse [x]`:
```haskell
  reverse [x]
= reverse (x:[])
= reverse [] ++ [x]     -- {R2}
= [] ++ [x]             -- {R1}
= [x]                   -- {++0}
```
y entonces
```haskell
  reverse (xs ++ [x])
= reverse [x] ++ reverse xs     -- Ej. 4.II
= [x] ++ reverse xs             -- cálculo anterior
= x : reverse xs                -- Ej. 3.III
```
$\blacksquare$

**Chuleta:**
> 1. `reverse` viene con `foldl` ⇒ hay **acumulador** ⇒ la HI se te queda corta ⇒ **generalizá**: $\forall ys.\ \text{foldl (flip (:))}\ ys\ xs = \text{revF } xs +\!\!+ ys$.
> 2. El $\forall ys$ va **dentro** del predicado $P(xs)$, así podés instanciar la HI con `x:ys`.
> 3. Instanciando $ys := []$ y usando `xs ++ [] = xs` obtenés las ecuaciones cómodas: `reverse [] = []`, `reverse (x:xs) = reverse xs ++ [x]`.
> 4. Con esas dos ecuaciones, II es inducción en `xs` + asociatividad de `++` (Ej. 3.V).
> 5. III **no** se demuestra de cero: sale de II calculando `reverse [x] = [x]`.

---

### Ejercicio 5
Demostrar las siguientes propiedades utilizando inducción estructural sobre listas, lemas de generación y el principio de extensionalidad funcional.

I. `reverse . reverse = id`
II. `append = (++)`
III. `map id = id`
IV. $\forall f :: a \to b . \forall g :: b \to c . \text{map } (g \cdot f) = \text{map } g \cdot \text{map } f$
V. $\forall f :: a \to b . \forall p :: b \to \text{Bool} . \text{map } f \cdot \text{filter } (p \cdot f) = \text{filter } p \cdot \text{map } f$
VI. $\forall f :: a \to b . \forall e :: a . \forall xs :: [a] . (\text{elem } e \ xs \implies \text{elem } (f \ e) \ (\text{map } f \ xs))$ (con `Eq a` y `Eq b`).
VII. $\forall xs :: [a] . \forall e :: a . (\text{elem } e \ xs \implies e \le \text{maximum } xs)$ (si vale `Ord a`).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Propiedades de orden superior (functorialidad de `map`) y teoremas de fusión.

**Resolución:**
Ecuaciones nuevas:

```haskell
{A0} append xs ys = foldr (:) ys xs
{M0'} maximum [x]      = x
{M1'} maximum (x:y:xs) = max x (maximum (y:xs))
{MAX} forall a b. a <= max a b  &&  b <= max a b
{CONG} forall x y f. (x == y  =>  f x == f y)
```
Seguimos usando {R1}, {R2} (Ej. 4.I), {++0}, {++1}, {M0}, {M1}, {FI0}, {FI1}, {E0}, {E1}, {F0}, {F1}.

---

**I.** `reverse . reverse = id`

Por extensionalidad basta probar $P(xs) \equiv \text{reverse}(\text{reverse } xs) = xs$ para todo $xs$. Inducción sobre $xs$.

*Caso base:*
```haskell
  reverse (reverse [])
= reverse []            -- {R1}
= []                    -- {R1}
```

*Caso inductivo.* **HI:** $\text{reverse}(\text{reverse } xs) = xs$.
```haskell
  reverse (reverse (x:xs))
= reverse (reverse xs ++ [x])     -- {R2}
= x : reverse (reverse xs)        -- Ej. 4.III
= x : xs                          -- HI
```
Finalmente `(reverse . reverse) xs = reverse (reverse xs) = xs = id xs` por {COMP} e {ID}, y por extensionalidad `reverse . reverse = id`. $\blacksquare$

---

**II.** `append = (++)`

Por extensionalidad (dos veces) basta probar $P(xs) \equiv \forall ys::[a].\ \text{append } xs\ ys = xs +\!\!+ ys$. Inducción sobre $xs$.

*Caso base:*
```haskell
  append [] ys
= foldr (:) ys []      -- {A0}
= ys                   -- {F0}
= [] ++ ys             -- {++0}
```

*Caso inductivo.* **HI:** $\text{append } xs\ ys = xs +\!\!+ ys$.
```haskell
  append (x:xs) ys
= foldr (:) ys (x:xs)          -- {A0}
= (:) x (foldr (:) ys xs)      -- {F1}
= x : append xs ys             -- {A0} (leída al revés)
= x : (xs ++ ys)               -- HI
= (x:xs) ++ ys                 -- {++1}
```
Por extensionalidad sobre $ys$ y luego sobre $xs$: `append = (++)`. $\blacksquare$

---

**III.** `map id = id`

Por extensionalidad, $P(xs) \equiv \text{map id } xs = xs$. Inducción sobre $xs$.

*Caso base:* `map id [] = []` por {M0}, y `id [] = []` por {ID}.

*Caso inductivo.* **HI:** $\text{map id } xs = xs$.
```haskell
  map id (x:xs)
= id x : map id xs      -- {M1}
= x : map id xs         -- {ID}
= x : xs                -- HI
= id (x:xs)             -- {ID}
```
$\blacksquare$

---

**IV.** $\forall f::a\to b.\ \forall g::b\to c.\ \text{map }(g \cdot f) = \text{map } g \cdot \text{map } f$

Por extensionalidad, $P(xs) \equiv \text{map }(g\cdot f)\ xs = (\text{map } g \cdot \text{map } f)\ xs$. Inducción sobre $xs$.

*Caso base:*
```haskell
  map (g . f) []          |    (map g . map f) []
= []            -- {M0}   |  = map g (map f [])   -- {COMP}
                          |  = map g []           -- {M0}
                          |  = []                 -- {M0}
```

*Caso inductivo.* **HI:** $\text{map }(g\cdot f)\ xs = \text{map } g\ (\text{map } f\ xs)$.
```haskell
  map (g . f) (x:xs)
= (g . f) x : map (g . f) xs      -- {M1}
= g (f x) : map (g . f) xs        -- {COMP}
= g (f x) : map g (map f xs)      -- HI
= map g (f x : map f xs)          -- {M1} (leída al revés)
= map g (map f (x:xs))            -- {M1}
= (map g . map f) (x:xs)          -- {COMP}
```
$\blacksquare$ (functorialidad de `map`).

---

**V.** $\forall f::a\to b.\ \forall p::b\to\text{Bool}.\ \text{map } f \cdot \text{filter }(p\cdot f) = \text{filter } p \cdot \text{map } f$

Por extensionalidad, $P(xs) \equiv \text{map } f\ (\text{filter }(p\cdot f)\ xs) = \text{filter } p\ (\text{map } f\ xs)$. Inducción sobre $xs$, con análisis de casos sobre `p (f x)`.

*Caso base:*
```haskell
  map f (filter (p . f) [])   |   filter p (map f [])
= map f []          -- {FI0}  | = filter p []       -- {M0}
= []                -- {M0}   | = []                -- {FI0}
```

*Caso inductivo.* **HI:** $\text{map } f\ (\text{filter }(p\cdot f)\ xs) = \text{filter } p\ (\text{map } f\ xs)$.
Notar que `(p . f) x = p (f x)` por {COMP}. Por LG de `Bool`, dos subcasos:

*Subcaso `p (f x) = True`:*
```haskell
  map f (filter (p . f) (x:xs))
= map f (x : filter (p . f) xs)     -- {FI1}, guarda verdadera
= f x : map f (filter (p . f) xs)   -- {M1}
= f x : filter p (map f xs)         -- HI

  filter p (map f (x:xs))
= filter p (f x : map f xs)         -- {M1}
= f x : filter p (map f xs)         -- {FI1}, guarda p (f x) = True
```

*Subcaso `p (f x) = False`:*
```haskell
  map f (filter (p . f) (x:xs))
= map f (filter (p . f) xs)         -- {FI1}, guarda falsa
= filter p (map f xs)               -- HI

  filter p (map f (x:xs))
= filter p (f x : map f xs)         -- {M1}
= filter p (map f xs)               -- {FI1}, guarda p (f x) = False
```
En ambos subcasos los dos lados coinciden. $\blacksquare$ (teorema de fusión `map`/`filter`).

---

**VI.** $\forall f::a\to b.\ \forall e::a.\ \forall xs::[a].\ (\text{elem } e\ xs \Rightarrow \text{elem }(f\ e)\ (\text{map } f\ xs))$

$P(xs) \equiv$ la implicación de arriba. Inducción sobre $xs$.

*Caso base:* `elem e [] = False` por {E0} ⇒ implicación verdadera **por antecedente falso**. ✓

*Caso inductivo.* **HI:** $\text{elem } e\ xs \Rightarrow \text{elem }(f\ e)\ (\text{map } f\ xs)$.
Supongamos `elem e (x:xs) = (e == x) || elem e xs = True` ({E1}). Además
```haskell
  elem (f e) (map f (x:xs))
= elem (f e) (f x : map f xs)              -- {M1}
= (f e == f x) || elem (f e) (map f xs)    -- {E1}
```
- Si `e == x = True`: por {CONG} vale `f e == f x = True`, luego la disyunción es `True`. ✓
- Si `elem e xs = True`: por **HI** vale `elem (f e) (map f xs) = True`, luego la disyunción es `True`. ✓

$\blacksquare$

---

**VII.** $\forall xs::[a].\ \forall e::a.\ (\text{elem } e\ xs \Rightarrow e \le \text{maximum } xs)$

`maximum` sólo está definida para listas **no vacías** y hace pattern matching sobre **dos** constructores (`[x]` y `x:y:xs`), así que en el paso inductivo hay que abrir $xs$ con el **lema de generación de listas** ($xs = []$ o $xs = y\!:\!ys$).

$P(xs) \equiv \forall e::a.\ (\text{elem } e\ xs \Rightarrow e \le \text{maximum } xs)$. Inducción sobre $xs$.

*Caso base $xs = []$:* `elem e [] = False` ⇒ antecedente falso ⇒ vale. ✓

*Caso inductivo $xs = x:xs'$.* **HI:** $\forall e.\ (\text{elem } e\ xs' \Rightarrow e \le \text{maximum } xs')$. Supongamos `elem e (x:xs') = True`, es decir `(e == x) || elem e xs' = True` por {E1}. Por LG sobre $xs'$:

*Subcaso $xs' = []$:* entonces `elem e [] = False`, así que necesariamente `e == x = True`, o sea $e = x$. Y `maximum [x] = x` por {M0'}, luego $e \le x = \text{maximum } [x]$. ✓

*Subcaso $xs' = y:ys$:* por {M1'}, `maximum (x:y:ys) = max x (maximum (y:ys))`.
- Si `e == x = True`: $e = x \le \max\ x\ (\text{maximum }(y\!:\!ys))$ por {MAX}. ✓
- Si `elem e (y:ys) = True`: por **HI** (aplicada a $xs' = y\!:\!ys$) vale $e \le \text{maximum }(y\!:\!ys) \le \max\ x\ (\text{maximum }(y\!:\!ys))$ por {MAX} y transitividad de $\le$. ✓

$\blacksquare$

> La ayuda del enunciado ($w \le x \wedge y \le z \Rightarrow \max w\ y \le \max x\ z$, monotonía de `max`) sirve para una variante de la demostración en la que se acota cada rama por separado; acá alcanzó con {MAX} (que `max` es cota superior de sus dos argumentos) más transitividad.

**Chuleta:**
> 1. Igualdad **entre funciones** → extensionalidad primero, inducción sobre la lista después.
> 2. `reverse . reverse = id`: base trivial; paso usa `reverse (xs ++ [x]) = x : reverse xs` (Ej. 4.III) y recién ahí la HI.
> 3. `append`/`map`/`filter` definidas con `foldr` → desplegá con {F0}/{F1}, reagrupá y volvé a plegar (*"leída al revés"*).
> 4. Cuando hay un `if` (`filter`) → **análisis de casos sobre la guarda** (`p x`, `p (f x)`): dos subcasos, siempre.
> 5. Implicaciones → base **por antecedente falso**; paso, casos sobre la disyunción de {E1} (`e == x` vs. `elem e xs`); la rama del `==` usa **congruencia**.
> 6. `maximum` matchea `[x]` y `x:y:xs` ⇒ en el paso inductivo abrí la cola con **lema de generación** (`[]` vs. `y:ys`).

---

### Ejercicio 6 ★
Dadas las funciones `zip` (vía `foldr`) y `zip'` (vía recursión explícita):
Demostrar que `zip = zip'` utilizando inducción estructural y el principio de extensionalidad.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Equivalencia entre esquemas de recursión y definiciones explícitas.

**Resolución:**
Ecuaciones:

```haskell
{Z0}  zip = foldr (\x rec ys -> if null ys
                               then []
                               else (x, head ys) : rec (tail ys))
                  (const [])
{Z'0} zip' []     ys = []
{Z'1} zip' (x:xs) ys = if null ys then [] else (x, head ys) : zip' xs (tail ys)
```
Abreviamos $h = $ `\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)`.

**Observación clave:** `zip` está definida como un `foldr` que devuelve **una función** (`[b] -> [(a,b)]`), y esa función se aplica a `tail ys` en la llamada recursiva. Por eso el predicado inductivo tiene que estar **generalizado sobre `ys`**: si fijáramos `ys`, la HI no se podría instanciar en `tail ys`.

**Esquema:** por extensionalidad (dos veces), basta probar por inducción estructural sobre $xs$ el predicado
$$P(xs) \equiv \forall ys::[b].\ \text{zip } xs\ ys = \text{zip' } xs\ ys$$

*Caso base $P([])$:* sea $ys$ arbitrario.
```haskell
  zip [] ys
= foldr h (const []) [] ys    -- {Z0}
= (const []) ys               -- {F0}
= []                          -- {CONST}
= zip' [] ys                  -- {Z'0}
```

*Caso inductivo.* **HI:** $\forall ys::[b].\ \text{zip } xs\ ys = \text{zip' } xs\ ys$.
**Tesis:** $\forall ys::[b].\ \text{zip }(x\!:\!xs)\ ys = \text{zip' }(x\!:\!xs)\ ys$. Sea $ys$ arbitrario.
```haskell
  zip (x:xs) ys
= foldr h (const []) (x:xs) ys                                      -- {Z0}
= h x (foldr h (const []) xs) ys                                    -- {F1}
= if null ys then [] else (x, head ys) : (foldr h (const []) xs) (tail ys)
                                                                    -- beta (definición de h)
= if null ys then [] else (x, head ys) : zip xs (tail ys)           -- {Z0}
= if null ys then [] else (x, head ys) : zip' xs (tail ys)          -- HI instanciada con ys := tail ys
= zip' (x:xs) ys                                                    -- {Z'1}
```

(Formalmente, el paso de la HI se hace dentro de cada rama del `if`: por LG de `Bool`, si `null ys = True` ambos lados dan `[]`; si `null ys = False`, ambos lados dan `(x, head ys) : zip' xs (tail ys)`.)

Como $ys$ era arbitrario, vale $P(x\!:\!xs)$. Por el principio de inducción, $P(xs)$ para todo $xs$; por extensionalidad sobre $ys$ y luego sobre $xs$, `zip = zip'`. $\blacksquare$

> **Machete:** 1. `foldr` que devuelve función → **generalizar sobre el segundo argumento** ($\forall ys$ dentro de $P$) → 2. base: `foldr h z [] ys = const [] ys = []` → 3. paso: desplegar {F1}, beta-reducir el lambda, replegar `foldr h (const []) xs` como `zip xs` → 4. aplicar HI con `ys := tail ys` → 5. plegar con {Z'1}.

---

### Ejercicio 7 ★
Dadas las funciones `nub`, `union` e `intersect`:
Indicar si las siguientes propiedades son verdaderas o falsas. Si son verdaderas, realizar una demostración. Si son falsas, presentar un contraejemplo.

I. $\text{Eq } a \implies \forall xs :: [a] . \forall e :: a . \forall p :: a \to \text{Bool} . \text{elem } e \ xs \ \&\& \ p \ e = \text{elem } e \ (\text{filter } p \ xs)$
II. $\text{Eq } a \implies \forall xs :: [a] . \forall e :: a . \text{elem } e \ xs = \text{elem } e \ (\text{nub } xs)$
III. $\text{Eq } a \implies \forall xs :: [a] . \forall ys :: [a] . \forall e :: a . \text{elem } e \ (\text{union } xs \ ys) = (\text{elem } e \ xs) \ || \ (\text{elem } e \ ys)$
IV. $\text{Eq } a \implies \forall xs :: [a] . \forall ys :: [a] . \forall e :: a . \text{elem } e \ (\text{intersect } xs \ ys) = (\text{elem } e \ xs) \ \&\& \ (\text{elem } e \ ys)$
V. $\text{Eq } a \implies \forall xs :: [a] . \forall ys :: [a] . \text{length} (\text{union } xs \ ys) = \text{length } xs + \text{length } ys$
VI. $\text{Eq } a \implies \forall xs :: [a] . \forall ys :: [a] . \text{length} (\text{union } xs \ ys) \le \text{length } xs + \text{length } ys$

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Análisis de propiedades de conjuntos representados por listas.

**Resolución:**
Ecuaciones:

```haskell
{N0} nub []     = []
{N1} nub (x:xs) = x : filter (\y -> x /= y) (nub xs)
{U0} union xs ys     = nub (xs ++ ys)
{I0} intersect xs ys = filter (\e -> elem e ys) xs
{CONG} forall x y f. (x == y  =>  f x == f y)
```

| Ítem | Veredicto |
|---|---|
| I | ✅ Verdadera |
| II | ✅ Verdadera |
| III | ✅ Verdadera |
| IV | ✅ Verdadera (corolario de I) |
| V | ❌ **Falsa** (contraejemplo) |
| VI | ✅ Verdadera |

---

**I.** `elem e xs && p e = elem e (filter p xs)` — **Verdadera**

$P(xs) \equiv \forall e::a.\ \forall p::a\to\text{Bool}.\ \text{elem } e\ xs\ \&\&\ p\ e = \text{elem } e\ (\text{filter } p\ xs)$. Inducción sobre $xs$.

*Caso base:*
```haskell
  elem e [] && p e            |   elem e (filter p [])
= False && p e     -- {E0}    | = elem e []            -- {FI0}
= False            -- {&&}    | = False                -- {E0}
```

*Caso inductivo.* **HI:** $\text{elem } e\ xs\ \&\&\ p\ e = \text{elem } e\ (\text{filter } p\ xs)$.
```haskell
  elem e (x:xs) && p e
= ((e == x) || elem e xs) && p e                    -- {E1}
= ((e == x) && p e) || (elem e xs && p e)           -- distributiva de && sobre ||
= ((e == x) && p e) || elem e (filter p xs)         -- HI
```
Por LG de `Bool` abrimos `p x`:

*Subcaso `p x = True`:*
```haskell
  elem e (filter p (x:xs))
= elem e (x : filter p xs)              -- {FI1}
= (e == x) || elem e (filter p xs)      -- {E1}
```
Hay que ver que `((e == x) && p e) || elem e (filter p xs) = (e == x) || elem e (filter p xs)`:
- si `e == x = True`, por {CONG} `p e == p x`, y como `p x = True` resulta `p e = True`; entonces `(True && True) = True` y ambos lados valen `True`;
- si `e == x = False`, ambos lados se reducen a `elem e (filter p xs)` (`False && _ = False` y `False || z = z`).

*Subcaso `p x = False`:* `elem e (filter p (x:xs)) = elem e (filter p xs)` por {FI1}. Hay que ver que `((e == x) && p e) || elem e (filter p xs) = elem e (filter p xs)`:
- si `e == x = True`, por {CONG} `p e = p x = False`, luego `(True && False) = False` y queda `False || z = z`;
- si `e == x = False`, queda `False || z = z`.

$\blacksquare$

⚠️ Verificar — la demostración usa esencialmente la propiedad {CONGRUENCIA ==} que da el enunciado (`e == x ⇒ p e == p x`). Si se trabajara con una instancia de `Eq` no congruente (por ejemplo, un `==` que identifica valores distinguibles por `p`), la propiedad sería falsa.

---

**II.** `elem e xs = elem e (nub xs)` — **Verdadera**

$P(xs) \equiv \forall e.\ \text{elem } e\ xs = \text{elem } e\ (\text{nub } xs)$. Inducción sobre $xs$.

*Caso base:* `elem e (nub []) = elem e []` por {N0}. ✓

*Caso inductivo.* **HI:** $\text{elem } e\ xs = \text{elem } e\ (\text{nub } xs)$. Sea $q = $ `\y -> x /= y`.
```haskell
  elem e (nub (x:xs))
= elem e (x : filter q (nub xs))              -- {N1}
= (e == x) || elem e (filter q (nub xs))      -- {E1}
= (e == x) || (elem e (nub xs) && q e)        -- Ej. 7.I (con la lista nub xs)
= (e == x) || (elem e xs && (x /= e))         -- HI y beta
= (e == x) || (elem e xs && not (e == x))     -- simetría de == y definición de /=
```
Por LG de `Bool` sobre `e == x`:
- `e == x = True`: la expresión da `True`, y `elem e (x:xs) = True || elem e xs = True` por {E1}. ✓
- `e == x = False`: la expresión da `False || (elem e xs && True) = elem e xs`, y `elem e (x:xs) = False || elem e xs = elem e xs` por {E1}. ✓

$\blacksquare$

---

**III.** `elem e (union xs ys) = elem e xs || elem e ys` — **Verdadera**

> **Lema (`elem` distribuye sobre `++`):** $\forall xs, ys.\ \forall e.\ \text{elem } e\ (xs +\!\!+ ys) = \text{elem } e\ xs\ ||\ \text{elem } e\ ys$

*Demostración del lema*, por inducción sobre $xs$:
```haskell
-- base
  elem e ([] ++ ys)          |   elem e [] || elem e ys
= elem e ys       -- {++0}   | = False || elem e ys     -- {E0}
                             | = elem e ys              -- neutro de ||
-- paso, HI: elem e (xs ++ ys) = elem e xs || elem e ys
  elem e ((x:xs) ++ ys)
= elem e (x : (xs ++ ys))                  -- {++1}
= (e == x) || elem e (xs ++ ys)            -- {E1}
= (e == x) || (elem e xs || elem e ys)     -- HI
= ((e == x) || elem e xs) || elem e ys     -- asociatividad de ||
= elem e (x:xs) || elem e ys               -- {E1}
```
∎ (lema)

Con eso:
```haskell
  elem e (union xs ys)
= elem e (nub (xs ++ ys))          -- {U0}
= elem e (xs ++ ys)                -- Ej. 7.II
= elem e xs || elem e ys           -- Lema
```
$\blacksquare$

---

**IV.** `elem e (intersect xs ys) = elem e xs && elem e ys` — **Verdadera**

Corolario inmediato de I, tomando $p = $ `\z -> elem z ys`:
```haskell
  elem e (intersect xs ys)
= elem e (filter (\z -> elem z ys) xs)     -- {I0}
= elem e xs && (\z -> elem z ys) e         -- Ej. 7.I (leída al revés)
= elem e xs && elem e ys                   -- beta
```
$\blacksquare$

---

**V.** `length (union xs ys) = length xs + length ys` — **Falsa**

*Contraejemplo:* $xs = [1]$, $ys = [1]$ (con `a = Int`).
```haskell
  union [1] [1]
= nub ([1] ++ [1])                                   -- {U0}
= nub [1,1]                                          -- {++0},{++1}
= 1 : filter (\y -> 1 /= y) (nub [1])                -- {N1}
= 1 : filter (\y -> 1 /= y) [1]                      -- nub [1] = [1]
= 1 : []                                             -- {FI1}, guarda 1 /= 1 = False
= [1]
```
Entonces `length (union [1] [1]) = 1`, mientras que `length [1] + length [1] = 2`. Como $1 \neq 2$, la observación `length` distingue ambos lados y la igualdad **no vale**. La razón conceptual: `union` elimina duplicados. $\blacksquare$

---

**VI.** `length (union xs ys) <= length xs + length ys` — **Verdadera**

> **Lema A:** $\forall p.\ \forall zs.\ \text{length}(\text{filter } p\ zs) \le \text{length } zs$

*Inducción sobre $zs$.* Base: `length (filter p []) = length [] = 0 <= 0` por {FI0},{L0}. Paso (HI: $\text{length}(\text{filter } p\ zs) \le \text{length } zs$), casos sobre `p z`:
- `p z = True`: `length (filter p (z:zs)) = 1 + length (filter p zs) <= 1 + length zs = length (z:zs)` por {FI1},{L1}, HI y monotonía de `+`.
- `p z = False`: `length (filter p (z:zs)) = length (filter p zs) <= length zs <= 1 + length zs = length (z:zs)`. ∎

> **Lema B:** $\forall zs.\ \text{length}(\text{nub } zs) \le \text{length } zs$

*Inducción sobre $zs$.* Base: `length (nub []) = length [] = 0` por {N0}. Paso (HI: $\text{length}(\text{nub } zs) \le \text{length } zs$):
```haskell
  length (nub (z:zs))
= length (z : filter q (nub zs))       -- {N1}, q = \y -> z /= y
= 1 + length (filter q (nub zs))       -- {L1}
<= 1 + length (nub zs)                 -- Lema A
<= 1 + length zs                       -- HI
= length (z:zs)                        -- {L1}
```
∎

Con los dos lemas:
```haskell
  length (union xs ys)
= length (nub (xs ++ ys))         -- {U0}
<= length (xs ++ ys)              -- Lema B
= length xs + length ys           -- Ej. 3.II
```
$\blacksquare$

> **Machete:** 1. V/F: si sospechás falso, buscá **duplicados** o listas vacías → contraejemplo con `length` como observación → 2. I y III son los lemas madre: `elem` sobre `filter` y `elem` sobre `++` → 3. II sale usando I con `p = (x /=)` → 4. IV es I instanciada → 5. VI = cota de `filter` + cota de `nub` + `length` de `++`.

---

### Ejercicio 8
Dadas las definiciones usuales de `foldr` y `foldl`, demostrar las siguientes propiedades:
I. $\forall f :: a \to b \to b . \forall z :: b . \forall xs, ys :: [a] . \text{foldr } f \ z \ (xs ++ ys) = \text{foldr } f \ (\text{foldr } f \ z \ ys) \ xs$
II. $\forall f :: b \to a \to b . \forall z :: b . \forall xs, ys :: [a] . \text{foldl } f \ z \ (xs ++ ys) = \text{foldl } f \ (\text{foldl } f \ z \ xs) \ ys$

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Teoremas de distribución de folds sobre la concatenación.

**Resolución:**
Ecuaciones:

```haskell
{F0}  foldr f z []     = z
{F1}  foldr f z (x:xs) = f x (foldr f z xs)
{FL0} foldl f z []     = z
{FL1} foldl f z (x:xs) = foldl f (f z x) xs
```

---

**I.** $\forall f::a\to b\to b.\ \forall z::b.\ \forall xs, ys::[a].\ \text{foldr } f\ z\ (xs +\!\!+ ys) = \text{foldr } f\ (\text{foldr } f\ z\ ys)\ xs$

**Esquema:** inducción estructural sobre $xs$ (es la lista que `++` consume). $f$, $z$ e $ys$ quedan fijos pero arbitrarios: acá **no hace falta generalizar**, porque el acumulador de `foldr` (`z`) no cambia entre llamadas recursivas.

$P(xs) \equiv \text{foldr } f\ z\ (xs +\!\!+ ys) = \text{foldr } f\ (\text{foldr } f\ z\ ys)\ xs$

*Caso base:*
```haskell
  foldr f z ([] ++ ys)              |   foldr f (foldr f z ys) []
= foldr f z ys           -- {++0}   | = foldr f z ys             -- {F0}
```

*Caso inductivo.* **HI:** $\text{foldr } f\ z\ (xs +\!\!+ ys) = \text{foldr } f\ (\text{foldr } f\ z\ ys)\ xs$.
```haskell
  foldr f z ((x:xs) ++ ys)
= foldr f z (x : (xs ++ ys))                 -- {++1}
= f x (foldr f z (xs ++ ys))                 -- {F1}
= f x (foldr f (foldr f z ys) xs)            -- HI
= foldr f (foldr f z ys) (x:xs)              -- {F1}
```
$\blacksquare$

---

**II.** $\forall f::b\to a\to b.\ \forall z::b.\ \forall xs, ys::[a].\ \text{foldl } f\ z\ (xs +\!\!+ ys) = \text{foldl } f\ (\text{foldl } f\ z\ xs)\ ys$

**Esquema:** inducción estructural sobre $xs$, pero **generalizando el acumulador**: en `foldl` el `z` cambia en cada paso (`f z x`), así que el predicado debe cuantificarlo adentro.

$$P(xs) \equiv \forall z::b.\ \forall ys::[a].\ \text{foldl } f\ z\ (xs +\!\!+ ys) = \text{foldl } f\ (\text{foldl } f\ z\ xs)\ ys$$

*Caso base:* sean $z$, $ys$ arbitrarios.
```haskell
  foldl f z ([] ++ ys)              |   foldl f (foldl f z []) ys
= foldl f z ys           -- {++0}   | = foldl f z ys              -- {FL0}
```

*Caso inductivo.* **HI:** $\forall z::b.\ \forall ys.\ \text{foldl } f\ z\ (xs +\!\!+ ys) = \text{foldl } f\ (\text{foldl } f\ z\ xs)\ ys$.
```haskell
  foldl f z ((x:xs) ++ ys)
= foldl f z (x : (xs ++ ys))                       -- {++1}
= foldl f (f z x) (xs ++ ys)                       -- {FL1}
= foldl f (foldl f (f z x) xs) ys                  -- HI instanciada con z := f z x
= foldl f (foldl f z (x:xs)) ys                    -- {FL1} (leída al revés)
```
$\blacksquare$

> **Machete:** 1. Inducción sobre `xs` (la lista que consume `++`) → 2. `foldr`: el `z` **no cambia**, HI directa → 3. `foldl`: el `z` **cambia** ⇒ predicado $\forall z$ adentro, y la HI se instancia con `f z x` → 4. cerrar replegando {F1}/{FL1} al revés.

---

## Otras Estructuras de Datos

### Ejercicio 9
Demostrar que la función `potencia` definida en la práctica 1 usando `foldNat` funciona correctamente mediante inducción en el exponente.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Inducción matemática (sobre `Integer >= 0`) vista como inducción estructural sobre el tipo de los naturales.

**Resolución:**
Definiciones de la práctica 1 que usamos:

```haskell
foldNat :: b -> (b -> b) -> Integer -> b
{FN0} foldNat z s 0 = z
{FN1} foldNat z s n = s (foldNat z s (n-1))     -- para n > 0

potencia :: (Num a) => a -> Integer -> a
{PO}  potencia b = foldNat 1 (b*)
```

**Qué significa "funciona correctamente":** que la función denota la potencia matemática, es decir
$$P(n) \equiv \forall b.\ \text{potencia } b\ n = b^{n}$$
para todo $n \ge 0$.

**Esquema de inducción.** El tipo `Integer` restringido a los no negativos es isomorfo a `data Nat = Zero | Suc Nat`, con `Zero ≈ 0` y `Suc n ≈ n+1`. Su esquema de inducción es la inducción matemática:
1. Caso base: $P(0)$
2. Caso inductivo: $\forall n \ge 0.\ (P(n) \Rightarrow P(n+1))$

*Caso base $P(0)$:*
```haskell
  potencia b 0
= foldNat 1 (b*) 0     -- {PO}
= 1                    -- {FN0}
= b^0                  -- definición de potencia matemática
```

*Caso inductivo.* **HI:** $\text{potencia } b\ n = b^{n}$ (con $n \ge 0$). **Tesis:** $\text{potencia } b\ (n+1) = b^{n+1}$.
```haskell
  potencia b (n+1)
= foldNat 1 (b*) (n+1)             -- {PO}
= (b*) (foldNat 1 (b*) ((n+1)-1))  -- {FN1}, aplicable porque n+1 > 0
= b * foldNat 1 (b*) n             -- aritmética y beta
= b * potencia b n                 -- {PO}
= b * b^n                          -- HI
= b^(n+1)                          -- definición de potencia matemática
```

Por el principio de inducción sobre los naturales, $\text{potencia } b\ n = b^n$ para todo $n \ge 0$. $\blacksquare$

**Terminación / totalidad:** el argumento de `foldNat` decrece estrictamente en cada llamada (`n` → `n-1`) y está acotado inferiormente por `0`, que es el caso base; por eso la recursión termina para todo `n >= 0` (y `potencia` es total en ese dominio, como pide el enunciado de la práctica 1).

⚠️ Verificar — las definiciones de `foldNat` y `potencia` se toman de la resolución estándar del Ej. 9 de la práctica 1 (`potencia b = foldNat 1 (b*)`, o equivalentemente `potencia b n = foldNat 1 (*b) n`). Si en tu resolución de la práctica 1 el orden de los argumentos es al revés (`potencia n b`), hay que renombrar, pero la estructura de la demostración es idéntica.

> **Machete:** 1. Enunciar $P(n) \equiv$ `potencia b n` $= b^n$ → 2. inducción **matemática** (naturales ≅ `Zero | Suc`) → 3. base: {FN0} da `1` $= b^0$ → 4. paso: {FN1} saca un `b *` afuera, adentro queda `potencia b n` → aplicar HI → 5. cerrar con $b \cdot b^n = b^{n+1}$.

---

### Ejercicio 10 ★
Dadas las funciones `altura` y `cantNodos` definidas en la práctica 1 para árboles binarios, demostrar la siguiente propiedad:
$\forall x :: AB \ a . \text{altura } x \le \text{cantNodos } x$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Relación entre métricas de árboles binarios.

**Resolución:**
Definiciones (práctica 1, ejercicio 12):

```haskell
data AB a = Nil | Bin (AB a) a (AB a)

{FAB0} foldAB z f Nil         = z
{FAB1} foldAB z f (Bin i r d) = f (foldAB z f i) r (foldAB z f d)

altura    = foldAB 0 (\ri _ rd -> 1 + max ri rd)
{AL0} altura Nil         = 0
{AL1} altura (Bin i r d) = 1 + max (altura i) (altura d)

cantNodos = foldAB 0 (\ri _ rd -> 1 + ri + rd)
{CN0} cantNodos Nil         = 0
{CN1} cantNodos (Bin i r d) = 1 + cantNodos i + cantNodos d
```

**Esquema de inducción estructural sobre `AB a`:**
1. Caso base: $P(\text{Nil})$
2. Caso inductivo: $\forall i::AB\ a.\ \forall r::a.\ \forall d::AB\ a.\ ((P(i) \wedge P(d)) \Rightarrow P(\text{Bin } i\ r\ d))$

---

> **Lema previo:** $\forall t::AB\ a.\ \text{cantNodos } t \ge 0$

*Inducción sobre $t$.* Base: `cantNodos Nil = 0 >= 0` por {CN0}. Paso, con HI $\text{cantNodos } i \ge 0$ y $\text{cantNodos } d \ge 0$: `cantNodos (Bin i r d) = 1 + cantNodos i + cantNodos d >= 1 + 0 + 0 = 1 >= 0` por {CN1} y monotonía de `+`. ∎

Este lema es necesario porque en el paso inductivo vamos a usar que, para $a, b \ge 0$, vale $\max a\ b \le a + b$.

---

**Propiedad:** $P(t) \equiv \text{altura } t \le \text{cantNodos } t$. Inducción estructural sobre $t$.

*Caso base $P(\text{Nil})$:*
```haskell
  altura Nil
= 0                -- {AL0}
<= 0               -- reflexividad de <=
= cantNodos Nil    -- {CN0}
```

*Caso inductivo.* **HI:** $\text{altura } i \le \text{cantNodos } i$ **y** $\text{altura } d \le \text{cantNodos } d$.
**Tesis:** $\text{altura }(\text{Bin } i\ r\ d) \le \text{cantNodos }(\text{Bin } i\ r\ d)$.
```haskell
  altura (Bin i r d)
= 1 + max (altura i) (altura d)                -- {AL1}
<= 1 + max (cantNodos i) (cantNodos d)         -- HI (dos veces) + monotonía de max
<= 1 + cantNodos i + cantNodos d               -- max a b <= a + b, válido pues a,b >= 0 (Lema)
= cantNodos (Bin i r d)                        -- {CN1}
```
Por transitividad de $\le$, $\text{altura }(\text{Bin } i\ r\ d) \le \text{cantNodos }(\text{Bin } i\ r\ d)$. $\blacksquare$

*Lectura intuitiva:* la altura cuenta los nodos de **una** rama, y `cantNodos` los cuenta **todos**; se da la igualdad exactamente cuando el árbol es un "peine" (cada nodo tiene a lo sumo un hijo no `Nil`).

> **Machete:** 1. Inducción estructural sobre `AB`: base `Nil`, paso `Bin i r d` con **dos** HI (izquierda y derecha) → 2. desplegá {AL1} y {CN1} → 3. la HI entra bajo `max` por **monotonía de `max`** → 4. rematá con `max a b <= a + b` (necesita el lema `cantNodos t >= 0`) → 5. transitividad de `<=`.

---

### Ejercicio 11
Dada la función `truncar :: AB a -> Int -> AB a`:
Demostrar las siguientes propiedades:
I. $\forall t :: AB \ a . \text{altura } t \ge 0$
II. $\forall t :: AB \ a . \forall n :: \text{Int} . (n \ge 0 \implies (\text{altura } (\text{truncar } t \ n) = \min \ n \ (\text{altura } t)))$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Propiedades de poda de árboles.

**Resolución:**
Ecuaciones:

```haskell
{T0} truncar Nil _         = Nil
{T1} truncar (Bin i r d) n = if n == 0 then Nil
                             else Bin (truncar i (n-1)) r (truncar d (n-1))
{AL0} altura Nil         = 0
{AL1} altura (Bin i r d) = 1 + max (altura i) (altura d)
```
Lemas dados por el enunciado:
```haskell
{LEMA1} forall x y z :: Int. max (min x y) (min x z) = min x (max y z)
{LEMA2} forall x y z :: Int. z + min x y = min (z+x) (z+y)
```

---

**I.** $P(t) \equiv \text{altura } t \ge 0$. Inducción estructural sobre $t :: AB\ a$.

*Caso base:* `altura Nil = 0 >= 0` por {AL0}. ✓

*Caso inductivo.* **HI:** $\text{altura } i \ge 0$ y $\text{altura } d \ge 0$.
```haskell
  altura (Bin i r d)
= 1 + max (altura i) (altura d)     -- {AL1}
>= 1 + max 0 0                      -- HI (dos veces) + monotonía de max
= 1                                 -- aritmética
>= 0
```
$\blacksquare$

---

**II.** $\forall t::AB\ a.\ \forall n::\text{Int}.\ (n \ge 0 \Rightarrow \text{altura}(\text{truncar } t\ n) = \min n\ (\text{altura } t))$

**Esquema:** inducción estructural sobre $t$, **generalizando sobre `n`** (el $\forall n$ va adentro del predicado): en el paso inductivo las llamadas recursivas usan `n-1`, así que la HI tiene que valer para *cualquier* `n` no negativo, no sólo para el `n` que estamos mirando.

$$P(t) \equiv \forall n::\text{Int}.\ \big(n \ge 0 \Rightarrow \text{altura}(\text{truncar } t\ n) = \min n\ (\text{altura } t)\big)$$

*Caso base $P(\text{Nil})$:* sea $n \ge 0$.
```haskell
  altura (truncar Nil n)
= altura Nil            -- {T0}
= 0                     -- {AL0}
= min n 0               -- porque n >= 0
= min n (altura Nil)    -- {AL0}
```
✓

*Caso inductivo $P(\text{Bin } i\ r\ d)$.* **HI:** $\forall n \ge 0.\ \text{altura}(\text{truncar } i\ n) = \min n\ (\text{altura } i)$, e ídem para $d$.
Sea $n \ge 0$. Por LG de `Bool` sobre la guarda `n == 0`:

*Subcaso $n = 0$:*
```haskell
  altura (truncar (Bin i r d) 0)
= altura Nil                        -- {T1}, guarda verdadera
= 0                                 -- {AL0}
= min 0 (altura (Bin i r d))        -- porque altura t >= 0 (propiedad I)
```
✓ (acá se usa el ítem I: sin él no podríamos concluir que el mínimo es `0`).

*Subcaso $n > 0$* (o sea $n - 1 \ge 0$, lo que habilita usar la HI):
```haskell
  altura (truncar (Bin i r d) n)
= altura (Bin (truncar i (n-1)) r (truncar d (n-1)))                  -- {T1}, guarda falsa
= 1 + max (altura (truncar i (n-1))) (altura (truncar d (n-1)))       -- {AL1}
= 1 + max (min (n-1) (altura i)) (min (n-1) (altura d))               -- HI (dos veces), con n-1 >= 0
= 1 + min (n-1) (max (altura i) (altura d))                           -- {LEMA1} con x := n-1
= min (1 + (n-1)) (1 + max (altura i) (altura d))                     -- {LEMA2} con z := 1
= min n (1 + max (altura i) (altura d))                               -- aritmética
= min n (altura (Bin i r d))                                          -- {AL1}
```
✓

Por el principio de inducción estructural sobre `AB a`, la propiedad vale para todo $t$ y todo $n \ge 0$. $\blacksquare$

> **Machete:** 1. `truncar` llama con `n-1` ⇒ **generalizar**: $\forall n \ge 0$ **dentro** de $P(t)$ → 2. base `Nil`: `min n 0 = 0` porque `n >= 0` → 3. paso: casos `n == 0` (usa la propiedad I, `altura >= 0`) y `n > 0` → 4. en `n > 0`: {T1} + {AL1} + HI con `n-1` → 5. sacar el `min` afuera con {LEMA1} y meter el `1 +` adentro con {LEMA2} → 6. replegar {AL1}.

---

### Ejercicio 12 ★
Demostrar la siguiente propiedad sobre árboles binarios:
`Eq a => \forall e :: a . elemAB e = elem e . inorder`

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Consistencia entre la búsqueda directa en el árbol y la búsqueda en su aplanamiento (*inorder*).

**Resolución:**
Ecuaciones:

```haskell
{FAB0} foldAB z f Nil         = z
{FAB1} foldAB z f (Bin i r d) = f (foldAB z f i) r (foldAB z f d)

{I0} inorder = foldAB [] (\ri x rd -> ri ++ (x:rd))
{A0} elemAB e = foldAB False (\ri x rd -> (e == x) || ri || rd)
{E0} elem e = foldr (\x rec -> (e == x) || rec) False
```
De {I0}, {A0}, {E0} y {FAB0}/{FAB1}/{F0}/{F1} se derivan las ecuaciones de trabajo:
```haskell
{IN0} inorder Nil         = []
{IN1} inorder (Bin i r d) = inorder i ++ (r : inorder d)
{AB0} elemAB e Nil         = False
{AB1} elemAB e (Bin i r d) = (e == r) || elemAB e i || elemAB e d
{EL0} elem e []     = False
{EL1} elem e (x:xs) = (e == x) || elem e xs
```

> **Lema (`elem` distribuye sobre `++`):** $\forall xs, ys::[a].\ \text{elem } e\ (xs +\!\!+ ys) = \text{elem } e\ xs\ ||\ \text{elem } e\ ys$
> (demostrado por inducción sobre $xs$ en el **Ejercicio 7.III**).

---

**Propiedad:** $\text{Eq } a \Rightarrow \forall e::a.\ \text{elemAB } e = \text{elem } e \cdot \text{inorder}$

Sea $e::a$ arbitrario. Por **extensionalidad funcional**, basta probar
$$P(t) \equiv \text{elemAB } e\ t = \text{elem } e\ (\text{inorder } t)$$
para todo $t :: AB\ a$ (notar que $(\text{elem } e \cdot \text{inorder})\ t = \text{elem } e\ (\text{inorder } t)$ por {COMP}).

**Esquema:** inducción estructural sobre `AB a` (base `Nil`, paso `Bin i r d` con HI sobre $i$ y sobre $d$).

*Caso base $P(\text{Nil})$:*
```haskell
  elemAB e Nil            |   elem e (inorder Nil)
= False        -- {AB0}   | = elem e []             -- {IN0}
                          | = False                 -- {EL0}
```
✓

*Caso inductivo.* **HI:** $\text{elemAB } e\ i = \text{elem } e\ (\text{inorder } i)$ **y** $\text{elemAB } e\ d = \text{elem } e\ (\text{inorder } d)$.
```haskell
  elem e (inorder (Bin i r d))
= elem e (inorder i ++ (r : inorder d))                        -- {IN1}
= elem e (inorder i) || elem e (r : inorder d)                 -- Lema (Ej. 7.III)
= elem e (inorder i) || ((e == r) || elem e (inorder d))       -- {EL1}
= (e == r) || elem e (inorder i) || elem e (inorder d)         -- conmutatividad y asociatividad de ||
= (e == r) || elemAB e i || elemAB e d                         -- HI (dos veces)
= elemAB e (Bin i r d)                                         -- {AB1}
```
✓

Por inducción estructural vale $P(t)$ para todo $t$, y por extensionalidad $\text{elemAB } e = \text{elem } e \cdot \text{inorder}$ para todo $e$. $\blacksquare$

*Lectura:* buscar en el árbol y buscar en su aplanamiento *inorder* son observacionalmente indistinguibles — el aplanamiento no pierde ni agrega elementos.

> **Machete:** 1. Igualdad de funciones ⇒ **extensionalidad** sobre el árbol `t` → 2. inducción estructural sobre `AB` con dos HI → 3. base: ambos lados dan `False` → 4. paso: desplegá `inorder (Bin i r d) = inorder i ++ (r : inorder d)` → 5. partí el `elem` sobre `++` con el **lema de Ej. 7.III** → 6. reordená el `||` (conmutativo y asociativo) para que quede `(e==r) || ... || ...` → 7. meté las HI y replegá {AB1}.

---

### Ejercicio 13 ★
Dados el tipo `Polinomio` y su esquema `foldPoli` definidos en la práctica 1, demostrar las siguientes propiedades:

I. $\text{Num } a \implies \forall p :: \text{Polinomio } a . \forall q :: \text{Polinomio } a . \forall r :: a . (\text{esRaiz } r \ p \implies \text{esRaiz } r \ (\text{Prod } p \ q))$
II. $\text{Num } a \implies \forall p :: \text{Polinomio } a . \forall k :: a . \forall e :: a . \text{evaluar } e \ (\text{derivado } (\text{Prod } (\text{Cte } k) \ p)) = \text{evaluar } e \ (\text{Prod } (\text{Cte } k) \ (\text{derivado } p))$
III. $\text{Num } a \implies \forall p :: \text{Polinomio } a . (\text{sinConstantesNegativas } p \implies \text{sinConstantesNegativas } (\text{derivado } p))$

**Pregunta:** La recursión utilizada en la definición de la función `derivado` ¿es estructural, primitiva o ninguna de las dos?

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Cálculo simbólico y propiedades algebraicas de polinomios.

**Resolución:**
Definiciones (práctica 1, ejercicio 11 + enunciado de esta guía):

```haskell
data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a)

foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
{FP0} foldPoli fx fc fs fp X          = fx
{FP1} foldPoli fx fc fs fp (Cte k)    = fc k
{FP2} foldPoli fx fc fs fp (Suma p q) = fs (foldPoli fx fc fs fp p) (foldPoli fx fc fs fp q)
{FP3} foldPoli fx fc fs fp (Prod p q) = fp (foldPoli fx fc fs fp p) (foldPoli fx fc fs fp q)

{E}  evaluar n = foldPoli n id (+) (*)
{D}  derivado poli = case poli of
       X        -> Cte 1
       Cte _    -> Cte 0
       Suma p q -> Suma (derivado p) (derivado q)
       Prod p q -> Suma (Prod (derivado p) q) (Prod (derivado q) p)
{S}  sinConstantesNegativas = foldPoli True (>=0) (&&) (&&)
{ER} esRaiz n p = evaluar n p == 0
```
Ecuaciones derivadas (desplegando {E} y {S} con {FP0}–{FP3}):
```haskell
{EV0} evaluar n X          = n
{EV1} evaluar n (Cte k)    = k
{EV2} evaluar n (Suma p q) = evaluar n p + evaluar n q
{EV3} evaluar n (Prod p q) = evaluar n p * evaluar n q
{SC0} sinConstantesNegativas X          = True
{SC1} sinConstantesNegativas (Cte k)    = k >= 0
{SC2} sinConstantesNegativas (Suma p q) = sinConstantesNegativas p && sinConstantesNegativas q
{SC3} sinConstantesNegativas (Prod p q) = sinConstantesNegativas p && sinConstantesNegativas q
```
Ecuaciones derivadas de {D}:
```haskell
{D0} derivado X          = Cte 1
{D1} derivado (Cte k)    = Cte 0
{D2} derivado (Suma p q) = Suma (derivado p) (derivado q)
{D3} derivado (Prod p q) = Suma (Prod (derivado p) q) (Prod (derivado q) p)
```

**Esquema de inducción estructural sobre `Polinomio a`:**
1. Casos base: $P(X)$ y $\forall k::a.\ P(\text{Cte } k)$
2. Casos inductivos: $((P(p) \wedge P(q)) \Rightarrow P(\text{Suma } p\ q))$ y $((P(p) \wedge P(q)) \Rightarrow P(\text{Prod } p\ q))$

---

**I.** $\forall p, q::\text{Polinomio } a.\ \forall r::a.\ (\text{esRaiz } r\ p \Rightarrow \text{esRaiz } r\ (\text{Prod } p\ q))$

**No hace falta inducción**: sale por razonamiento ecuacional puro. Supongamos `esRaiz r p`, es decir `evaluar r p == 0` es `True`, o sea $\text{evaluar } r\ p = 0$.
```haskell
  esRaiz r (Prod p q)
= evaluar r (Prod p q) == 0                -- {ER}
= (evaluar r p * evaluar r q) == 0         -- {EV3}
= (0 * evaluar r q) == 0                   -- hipótesis: evaluar r p = 0
= 0 == 0                                   -- 0 es absorbente del producto
= True                                     -- reflexividad de ==
```
$\blacksquare$ (si $r$ es raíz de $p$, lo es de cualquier múltiplo de $p$).

---

**II.** $\forall p::\text{Polinomio } a.\ \forall k, e::a.\ \text{evaluar } e\ (\text{derivado }(\text{Prod }(\text{Cte } k)\ p)) = \text{evaluar } e\ (\text{Prod }(\text{Cte } k)\ (\text{derivado } p))$

Tampoco requiere inducción: es cálculo directo (la "regla de la constante" de la derivada).

*Lado izquierdo:*
```haskell
  evaluar e (derivado (Prod (Cte k) p))
= evaluar e (Suma (Prod (derivado (Cte k)) p) (Prod (derivado p) (Cte k)))   -- {D3}
= evaluar e (Suma (Prod (Cte 0) p) (Prod (derivado p) (Cte k)))              -- {D1}
= evaluar e (Prod (Cte 0) p) + evaluar e (Prod (derivado p) (Cte k))         -- {EV2}
= (evaluar e (Cte 0) * evaluar e p) + (evaluar e (derivado p) * evaluar e (Cte k))
                                                                            -- {EV3} (dos veces)
= (0 * evaluar e p) + (evaluar e (derivado p) * k)                           -- {EV1} (dos veces)
= 0 + evaluar e (derivado p) * k                                             -- 0 absorbente
= evaluar e (derivado p) * k                                                 -- 0 neutro de +
```

*Lado derecho:*
```haskell
  evaluar e (Prod (Cte k) (derivado p))
= evaluar e (Cte k) * evaluar e (derivado p)     -- {EV3}
= k * evaluar e (derivado p)                     -- {EV1}
```

Ambos coinciden por **conmutatividad del producto**. $\blacksquare$

⚠️ Verificar — el último paso usa que `*` es conmutativo. La clase `Num` de Haskell no impone esa ley por contrato, pero es la hipótesis estándar de la materia (los tipos numéricos usuales forman un anillo conmutativo). Si se quisiera evitarla, habría que definir `derivado (Prod p q) = Suma (Prod (derivado p) q) (Prod p (derivado q))`.

---

**III.** $\forall p::\text{Polinomio } a.\ (\text{sinConstantesNegativas } p \Rightarrow \text{sinConstantesNegativas }(\text{derivado } p))$

$P(p) \equiv$ la implicación de arriba. Inducción estructural sobre $p$.

*Caso base $P(X)$:*
```haskell
  sinConstantesNegativas (derivado X)
= sinConstantesNegativas (Cte 1)     -- {D0}
= 1 >= 0                             -- {SC1}
= True
```
✓ (vale incluso sin usar el antecedente).

*Caso base $P(\text{Cte } k)$:*
```haskell
  sinConstantesNegativas (derivado (Cte k))
= sinConstantesNegativas (Cte 0)     -- {D1}
= 0 >= 0                             -- {SC1}
= True
```
✓ (también independiente del antecedente: la derivada de una constante es `Cte 0`, nunca negativa).

*Caso inductivo $P(\text{Suma } p\ q)$.* **HI:** $\text{sCN } p \Rightarrow \text{sCN }(\text{derivado } p)$ y $\text{sCN } q \Rightarrow \text{sCN }(\text{derivado } q)$.
Supongamos `sinConstantesNegativas (Suma p q) = True`; por {SC2} eso es `sCN p && sCN q = True`, luego **ambos** son `True`. Entonces:
```haskell
  sinConstantesNegativas (derivado (Suma p q))
= sinConstantesNegativas (Suma (derivado p) (derivado q))          -- {D2}
= sCN (derivado p) && sCN (derivado q)                             -- {SC2}
= True && True                                                     -- HI (dos veces)
= True
```
✓

*Caso inductivo $P(\text{Prod } p\ q)$.* Supongamos `sCN (Prod p q) = sCN p && sCN q = True` ({SC3}), luego ambos son `True`.
```haskell
  sinConstantesNegativas (derivado (Prod p q))
= sCN (Suma (Prod (derivado p) q) (Prod (derivado q) p))                       -- {D3}
= sCN (Prod (derivado p) q) && sCN (Prod (derivado q) p)                       -- {SC2}
= (sCN (derivado p) && sCN q) && (sCN (derivado q) && sCN p)                   -- {SC3} (dos veces)
= (True && True) && (True && True)                                             -- HI + supuesto
= True
```
✓

$\blacksquare$

⚠️ Verificar — `sinConstantesNegativas` usa `(>=0)`, lo cual exige `Ord a` además de `Num a` (el enunciado sólo escribe `Num a`); además se asume $1 \ge 0$ y $0 \ge 0$ en el tipo `a`, cierto para los tipos numéricos ordenados usuales.

---

**Pregunta: ¿la recursión de `derivado` es estructural, primitiva o ninguna?**

Es **recursión primitiva**, no estructural.

- En el caso `Suma p q` sólo se usan los resultados recursivos `derivado p` y `derivado q`: eso sí sería estructural.
- Pero en el caso `Prod p q` el resultado usa **también los subtérminos originales** `p` y `q` sin transformar: `Suma (Prod (derivado p) q) (Prod (derivado q) p)`.

`foldPoli` (recursión estructural) sólo entrega los **resultados** de las llamadas recursivas, no los subárboles, así que `derivado` **no** se puede escribir con `foldPoli` sin trucos. En cambio sí se escribe con el esquema de **recursión primitiva** `recPoli`, cuyas funciones para `Suma`/`Prod` reciben tanto los subpolinomios como sus resultados recursivos:

```haskell
recPoli :: b -> (a -> b) -> (Polinomio a -> b -> Polinomio a -> b -> b)
                         -> (Polinomio a -> b -> Polinomio a -> b -> b)
                         -> Polinomio a -> b
derivado = recPoli (Cte 1) (const (Cte 0))
                   (\_ rp _ rq -> Suma rp rq)
                   (\p rp q rq -> Suma (Prod rp q) (Prod rq p))
```

> **Machete:** 1. Desplegá `evaluar`/`sinConstantesNegativas` como ecuaciones por constructor ({EV0}–{EV3}, {SC0}–{SC3}) → 2. I y II salen **sin inducción**, puro reemplazo + `0` absorbente/neutro → 3. III: inducción con **cuatro casos** (`X`, `Cte k`, `Suma`, `Prod`); los dos bases dan `True` solos → 4. en `Prod`, la derivada es una `Suma` de dos `Prod`: abrí con {SC2} y {SC3} y metés HI → 5. `derivado` usa `p` y `q` crudos ⇒ **recursión primitiva**, no estructural.

---

### Ejercicio 14
Considerar las siguientes definiciones para `AIH`:
- `hojas :: AIH a -> [a]`
- `espejo :: AIH a -> AIH a`

Demostrar las siguientes propiedades:
I. $\forall x :: \text{AIH } a . \forall y :: \text{AIH } a . \forall z :: \text{AIH } a . \text{hojas } (\text{Bin } x \ (\text{Bin } y \ z)) = \text{hojas } (\text{Bin } (\text{Bin } x \ y) \ z)$
II. `espejo . espejo = id`
III. $\forall x :: \text{AIH } a . \text{hojas } (\text{espejo } x) = \text{reverse } (\text{hojas } x)$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Propiedades de árboles con información en las hojas. La propiedad I muestra la "asociatividad" de la estructura en términos de sus hojas.

**Resolución:**
Ecuaciones:

```haskell
data AIH a = Hoja a | Bin (AIH a) (AIH a)

{H0} hojas (Hoja h)  = [h]
{H1} hojas (Bin i d) = hojas i ++ hojas d
{ES0} espejo (Hoja h)  = Hoja h
{ES1} espejo (Bin i d) = Bin (espejo d) (espejo i)
```

**Esquema de inducción estructural sobre `AIH a`:**
1. Caso base: $\forall h::a.\ P(\text{Hoja } h)$
2. Caso inductivo: $\forall i, d::AIH\ a.\ ((P(i) \wedge P(d)) \Rightarrow P(\text{Bin } i\ d))$

Notar que en `AIH` el **caso base ya tiene información** (`Hoja h`), a diferencia de `AB` donde el caso base es `Nil`.

---

**I.** $\forall x, y, z :: \text{AIH } a.\ \text{hojas}(\text{Bin } x\ (\text{Bin } y\ z)) = \text{hojas}(\text{Bin }(\text{Bin } x\ y)\ z)$

**No requiere inducción:** es consecuencia directa de {H1} y de la **asociatividad de `++`** (Ej. 3.V).

```haskell
  hojas (Bin x (Bin y z))
= hojas x ++ hojas (Bin y z)          -- {H1}
= hojas x ++ (hojas y ++ hojas z)     -- {H1}
= (hojas x ++ hojas y) ++ hojas z     -- Ej. 3.V (asociatividad de ++), leída al revés
= hojas (Bin x y) ++ hojas z          -- {H1}
= hojas (Bin (Bin x y) z)             -- {H1}
```
$\blacksquare$

*Lectura:* los dos árboles son **distintos** como valores (punto de vista intensional), pero indistinguibles si sólo observamos su lista de hojas: `hojas` "olvida" la forma del árbol y sólo conserva el orden.

---

**II.** `espejo . espejo = id`

Por **extensionalidad**, basta probar $P(t) \equiv \text{espejo}(\text{espejo } t) = t$ para todo $t::AIH\ a$. Inducción estructural sobre $t$.

*Caso base:*
```haskell
  espejo (espejo (Hoja h))
= espejo (Hoja h)          -- {ES0}
= Hoja h                   -- {ES0}
```

*Caso inductivo.* **HI:** $\text{espejo}(\text{espejo } i) = i$ **y** $\text{espejo}(\text{espejo } d) = d$.
```haskell
  espejo (espejo (Bin i d))
= espejo (Bin (espejo d) (espejo i))        -- {ES1}
= Bin (espejo (espejo i)) (espejo (espejo d))
                                            -- {ES1}: espeja y da vuelta, los dos swaps se cancelan
= Bin i d                                   -- HI (dos veces)
```
Finalmente `(espejo . espejo) t = espejo (espejo t) = t = id t` por {COMP} e {ID}; por extensionalidad, `espejo . espejo = id`. $\blacksquare$ (`espejo` es una **involución**, y por lo tanto `AIH a` es isomorfo a sí mismo vía `espejo`).

---

**III.** $\forall x::\text{AIH } a.\ \text{hojas}(\text{espejo } x) = \text{reverse}(\text{hojas } x)$

$P(t) \equiv \text{hojas}(\text{espejo } t) = \text{reverse}(\text{hojas } t)$. Inducción estructural sobre $t$. Usamos el **lema del Ej. 4.II**: $\text{reverse}(xs +\!\!+ ys) = \text{reverse } ys +\!\!+ \text{reverse } xs$.

*Caso base:*
```haskell
  hojas (espejo (Hoja h))   |   reverse (hojas (Hoja h))
= hojas (Hoja h)  -- {ES0}  | = reverse [h]              -- {H0}
= [h]             -- {H0}   | = reverse [] ++ [h]        -- {R2}
                            | = [] ++ [h]                -- {R1}
                            | = [h]                      -- {++0}
```
✓

*Caso inductivo.* **HI:** $\text{hojas}(\text{espejo } i) = \text{reverse}(\text{hojas } i)$ **y** $\text{hojas}(\text{espejo } d) = \text{reverse}(\text{hojas } d)$.
```haskell
  hojas (espejo (Bin i d))
= hojas (Bin (espejo d) (espejo i))            -- {ES1}
= hojas (espejo d) ++ hojas (espejo i)         -- {H1}
= reverse (hojas d) ++ reverse (hojas i)       -- HI (dos veces)
= reverse (hojas i ++ hojas d)                 -- Ej. 4.II, leída al revés
= reverse (hojas (Bin i d))                    -- {H1}
```
✓

$\blacksquare$

⚠️ Verificar — en el PDF de la guía la ecuación {H1} está escrita como `hojas (Bin i d) = hojas a ++ hojas d`: la `a` es una errata evidente por `i` (no hay ninguna variable `a` ligada en esa ecuación). La demostración usa la versión corregida `hojas (Bin i d) = hojas i ++ hojas d`.

> **Machete:** 1. `AIH` tiene **caso base con información** (`Hoja h`) y un solo constructor recursivo binario → dos HI → 2. I sale **sin inducción**: puro {H1} + asociatividad de `++` → 3. II: extensionalidad + inducción; el doble swap de {ES1} se cancela → 4. III: {ES1} invierte el orden de los hijos, y eso es exactamente lo que hace `reverse (xs ++ ys) = reverse ys ++ reverse xs` (Ej. 4.II) leída al revés.

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/induccion_estructural_arboles]]
