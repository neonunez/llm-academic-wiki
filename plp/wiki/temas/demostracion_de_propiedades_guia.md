---
nombre: Práctica 2 - Razonamiento Ecuacional e Inducción Estructural
parcial: 1P
tipo: Guía de Ejercicios
tema: Demostración de Propiedades
fuente: plp/raw/guias_practicas/1.guia_1P_razonamiento_ecuacional_&_induccion_estructural.pdf
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
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

**Chuleta:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 6 ★
Dadas las funciones `zip` (vía `foldr`) y `zip'` (vía recursión explícita):
Demostrar que `zip = zip'` utilizando inducción estructural y el principio de extensionalidad.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Equivalencia entre esquemas de recursión y definiciones explícitas.

**Resolución:**
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

---

### Ejercicio 8
Dadas las definiciones usuales de `foldr` y `foldl`, demostrar las siguientes propiedades:
I. $\forall f :: a \to b \to b . \forall z :: b . \forall xs, ys :: [a] . \text{foldr } f \ z \ (xs ++ ys) = \text{foldr } f \ (\text{foldr } f \ z \ ys) \ xs$
II. $\forall f :: b \to a \to b . \forall z :: b . \forall xs, ys :: [a] . \text{foldl } f \ z \ (xs ++ ys) = \text{foldl } f \ (\text{foldl } f \ z \ xs) \ ys$

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Teoremas de distribución de folds sobre la concatenación.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

## Otras Estructuras de Datos

### Ejercicio 9
Demostrar que la función `potencia` definida en la práctica 1 usando `foldNat` funciona correctamente mediante inducción en el exponente.

**¿Aparece en parciales?** ⚪ No

**Explicación:**
Inducción matemática (sobre `Integer >= 0`) vista como inducción estructural sobre el tipo de los naturales.

**Resolución:**
[PENDIENTE — sesión de resolución]

---

### Ejercicio 10 ★
Dadas las funciones `altura` y `cantNodos` definidas en la práctica 1 para árboles binarios, demostrar la siguiente propiedad:
$\forall x :: AB \ a . \text{altura } x \le \text{cantNodos } x$

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Relación entre métricas de árboles binarios.

**Resolución:**
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

---

### Ejercicio 12 ★
Demostrar la siguiente propiedad sobre árboles binarios:
`Eq a => \forall e :: a . elemAB e = elem e . inorder`

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/induccion_estructural_arboles]]

**Explicación:**
Consistencia entre la búsqueda directa en el árbol y la búsqueda en su aplanamiento (*inorder*).

**Resolución:**
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

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
[PENDIENTE — sesión de resolución]

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/induccion_estructural_arboles]]
