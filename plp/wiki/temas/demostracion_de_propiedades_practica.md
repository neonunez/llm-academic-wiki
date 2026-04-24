---
nombre: Demostración de Propiedades (Práctica)
parcial: 1
tipo: Clase práctica
tema: Demostración de Propiedades
fuente: raw/clases/prac/2.prac_1P_programacion_funcional_(3).pdf
paginas_relacionadas: [[demostracion_de_propiedades_teoria]], [[programacion_funcional_practica]]
---

# Demostración de Propiedades — Práctica

Esta clase se enfoca en técnicas de razonamiento ecuacional e inducción estructural para demostrar la corrección de programas funcionales en Haskell.

## Razonamiento Ecuacional y Extensionalidad

Para demostrar que dos funciones $f$ y $g$ son iguales ($f = g$), se utiliza el principio de **extensionalidad**:
$$\forall x . f(x) = g(x) \implies f = g$$

### Ejemplo: Conjuntos Funcionales
Dadas las definiciones:
- `{V} vacio = \_ -> False`
- `{I} interseccion c d = \e -> c e && d e`
- `{D} diferencia c d = \e -> c e && not (d e)`

**Propiedad**: `interseccion d (diferencia c d) = vacio`

**Demostración**:
Por extensionalidad, sea $e$ un elemento arbitrario:
```haskell
interseccion d (diferencia c d) e
= (d e) && (diferencia c d e)              -- Por {I}
= (d e) && (c e && not (d e))              -- Por {D}
= (d e) && not (d e) && (c e)              -- Por conmutatividad/asociatividad del &&
= False && (c e)                           -- Por contradicción
= False                                    -- Por neutro de &&
= vacio e                                  -- Por {V}
```
Como vale para todo $e$, las funciones son iguales.

---

## Inducción Estructural

El esquema general para una propiedad $P(t)$ sobre un tipo inductivo:
1.  **Casos Base**: Demostrar $P$ para los constructores no recursivos.
2.  **Paso Inductivo**: Para cada constructor recursivo, asumir que la propiedad vale para sus argumentos recursivos (**Hipótesis Inductiva**) y demostrar que vale para el nuevo elemento.

### Inducción sobre Listas
**Propiedad**: `elem e xs => elem (f e) (map f xs)`

**Definiciones**:
- `{E0} elem e [] = False`
- `{E1} elem e (x:xs) = (e == x) || elem e xs`
- `{M0} map f [] = []`
- `{M1} map f (x:xs) = f x : map f xs`

**Demostración por inducción sobre `xs`**:
- **Caso Base (`xs = []`)**:
  `elem e []` es `False`. Por antecedente falso, la implicación es verdadera.
- **Caso Inductivo (`xs = x:xs'`)**:
  - **H.I.**: `elem e xs' => elem (f e) (map f xs')`
  - **Tesis**: `elem e (x:xs') => elem (f e) (map f (x:xs'))`
  
  Asumimos `elem e (x:xs')`. Por `{E1}`, esto significa `(e == x) || elem e xs'`.
  - **Subcaso `e == x`**:
    `elem (f e) (map f (x:xs'))`
    `= elem (f e) (f x : map f xs')` (por `{M1}`)
    `= (f e == f x) || elem (f e) (map f xs')` (por `{E1}`)
    Como `e == x`, por congruencia `f e == f x`, por lo tanto la disyunción es `True`.
  - **Subcaso `elem e xs'`**:
    Por H.I., sabemos que `elem (f e) (map f xs')` es `True`.
    Por `{E1}`, `elem (f e) (f x : map f xs') = (f e == f x) || elem (f e) (map f xs')`.
    Como el segundo término es `True` por H.I., la disyunción es `True`.

---

## Generalización de Propiedades

A veces, la H.I. no es lo suficientemente fuerte para completar el paso inductivo (común en funciones que usan acumuladores como `foldl`).

### Ejemplo: `length ys = length (reverse ys)`
Donde `reverse = foldl (flip (:)) []`.

**Problema**: Al intentar inducción sobre `ys`, nos encontramos con un acumulador que cambia.
**Solución**: Generalizar a:
$$\forall ys, zs . \text{length } zs + \text{length } ys = \text{length } (\text{foldl (flip (:)) } zs \text{ } ys)$$

---

## Inducción sobre Árboles Binarios

**Propiedad**: `cantNodos t = length (inorder t)`

**Lema Necesario**: `length (xs ++ ys) = length xs + length ys`

**Esquema de Inducción**:
1.  **Caso Base**: $P(Nil)$
2.  **Caso Inductivo**: $(P(i) \land P(d)) \implies P(Bin \text{ } i \text{ } r \text{ } d)$

---

## Chuletas de Demostración

> [!TIP]
> **Pasos a seguir:**
> 1.  Entender la propiedad y convencerse de que es verdadera.
> 2.  Plantear el predicado $P(x)$ y el esquema de inducción.
> 3.  **Identificar la estructura de inducción**: Siempre elegir la que tiene recursión estructural en las funciones involucradas (ej: para `foldr`, inducción sobre la lista).
> 4.  Resolver casos base.
> 5.  Resolver paso inductivo usando explícitamente la H.I.

> [!WARNING]
> **Atención con los Lemas**: Si te trabas en el paso inductivo porque te queda una expresión compleja, probablemente necesites un lema auxiliar (ej: asociatividad de `++` o propiedades de `length`).

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/induccion_estructural_arboles]]
