---
nombre: Demostración de Propiedades (Razonamiento Ecuacional e Inducción Estructural)
parcial: 1P
programa: 2C_2026
tipo: Clase teórica
tema: demostracion_de_propiedades
fuente: raw/clases/teo/3.teo_1P_razonamiento_ecuacional_&_induccion_estructural.pdf
paginas_relacionadas: []
---

# Razonamiento Ecuacional e Inducción Estructural

Queremos demostrar que ciertas expresiones son equivalentes para justificar que un algoritmo es correcto y para posibilitar optimizaciones. Trabajaremos bajo la hipótesis de estructuras de datos finitas (tipos inductivos), funciones totales y que el programa no depende del orden de las ecuaciones.

## Principios de Razonamiento Ecuacional

Razonamos ecuacionalmente usando tres principios:

### 1. Principio de reemplazo (Igualdades por definición)
Sea `e1 = e2` una ecuación incluida en el programa. Se puede preservar la igualdad de expresiones al reemplazar cualquier instancia de `e1` por `e2`, o viceversa. Si una igualdad se puede demostrar usando solamente este principio, decimos que vale "por definición".

### 2. Principio de inducción estructural
Para probar una propiedad `P` sobre todas las instancias de un tipo `T`, basta probar `P` para cada uno de los constructores (asumiendo la Hipótesis Inductiva para los argumentos recursivos de los constructores recursivos).

### 3. Principio de extensionalidad funcional (Punto de vista extensional)
Dos funciones son iguales si son indistinguibles al observarlas (es decir, computan la misma función), a diferencia del punto de vista "intensional" (donde dos valores son iguales si están construidos de la misma manera).
- **Propiedad inmediata:** Si `f = g` entonces `(∀x :: a. f x = g x)`.
- **Principio de extensionalidad:** Si `(∀x :: a. f x = g x)` entonces `f = g`.

---

## Esquemas de Inducción

### Inducción sobre booleanos
Si `P(True)` y `P(False)` entonces `∀x :: Bool. P(x)`.

### Inducción sobre naturales
Dado `data Nat = Zero | Suc Nat`:
Si `P(Zero)` y `∀n :: Nat. (P(n) ⇒ P(Suc n))`, entonces `∀n :: Nat. P(n)`.
*(Donde `P(n)` es la Hipótesis Inductiva y `P(Suc n)` es la Tesis Inductiva)*.

### Inducción sobre pares
Si `∀x :: a. ∀y :: b. P((x, y))` entonces `∀p :: (a, b). P(p)`.

### Inducción estructural sobre listas
Dado `data [a] = [] | a : [a]`. Sea `P` una propiedad sobre expresiones de tipo `[a]` tal que:
1. **Caso base:** `P([])`
2. **Caso inductivo:** `∀x :: a. ∀xs :: [a]. (P(xs) ⇒ P(x : xs))`

Entonces `∀xs :: [a]. P(xs)`.

### Inducción estructural sobre árboles binarios
Dado `data AB a = Nil | Bin (AB a) a (AB a)`. Sea `P` tal que:
1. **Caso base:** `P(Nil)`
2. **Caso inductivo:** `∀i :: AB a. ∀r :: a. ∀d :: AB a. ((P(i) ∧ P(d)) ⇒ P(Bin i r d))`

Entonces `∀x :: AB a. P(x)`.

---

## Lemas de generación

Usando el principio de inducción estructural, se puede probar:
- **Lema de generación para pares:** Si `p :: (a, b)`, entonces `∃x :: a. ∃y :: b. p = (x, y)`.
- **Lema de generación para sumas (`Either`):** Si `e :: Either a b`, entonces:
  - o bien `∃x :: a. e = Left x`
  - o bien `∃y :: b. e = Right y`

---

## Corrección del razonamiento ecuacional y Desigualdades
Si demostramos `e1 = e2 :: A`, entonces `obs e1 = True` si y solo si `obs e2 = True` para toda posible "observación" `obs :: A -> Bool`.
Para demostrar que **no** vale una igualdad (una desigualdad), basta con encontrar una función de observación `obs` que las distinga (es decir, devuelva resultados diferentes).

---

## Isomorfismos de tipos

Dos tipos de datos `A` y `B` son isomorfos (`A ≃ B`) si:
1. Hay una función `f :: A -> B` total.
2. Hay una función `g :: B -> A` total.
3. Se puede demostrar que `g . f = id :: A -> A`.
4. Se puede demostrar que `f . g = id :: B -> B`.

### Ejemplos de Isomorfismos:
- **Currificación:** `((a, b) -> c) ≃ (a -> b -> c)`
  - `curry f x y = f (x, y)`
  - `uncurry f (x, y) = f x y`
- `(a, b) ≃ (b, a)`
- `(a, (b, c)) ≃ ((a, b), c)`
- `a -> b -> c ≃ b -> a -> c`
- `a -> (b, c) ≃ (a -> b, a -> c)`
- `Either a b -> c ≃ (a -> c, b -> c)`

---

## Casos de Estudio (Necesidad de generalizar)

A veces, para poder demostrar una propiedad por inducción, es necesario:
1. **Necesidad de usar lemas auxiliares:** Probar primero una propiedad más pequeña que pueda ser utilizada en el caso inductivo de la demostración principal.
2. **Necesidad de generalizar el predicado inductivo:** Si la hipótesis inductiva es muy débil o fija, se debe generalizar el predicado sobre todos los argumentos extraños. Por ejemplo, en funciones recursivas a la cola con acumulador, reemplazar una constante inicial por un "Para todo `k`".
   - *Original:* `P(xs) ≡ suma k (xs ++ ys) = suma (suma k xs) ys`
   - *Generalizado:* `Q(xs) ≡ ∀k' :: Int. suma k' (xs ++ ys) = suma (suma k' xs) ys`

---

## Bibliografía Adicional
- Capítulo 6 del libro de Bird. Richard Bird. *Thinking functionally with Haskell*. Cambridge University Press, 2015.
