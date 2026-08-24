---
nombre: Haskell — recursión primitiva (rec) vs fold
parcial: 1P
programa: 2C_2026
tipo: tipo_ejercicio
tema: programacion_funcional
---

# Haskell — recursión primitiva (rec) vs fold

## Como reconocer este patron

- La función a implementar necesita acceder a la *forma* original de un subárbol, no solo al resultado procesado
- Típico: `reemplazarUno` (primer aparición en preorder), `puedeCompletarLecturas` (acceso a buffer previo), `estáEnFNN` (chequear si hijo de `No` es `Var`)
- El enunciado dice "primera aparición", "estado anterior", o necesitas chequear algo sobre la estructura original

## Template de resolucion

```haskell
-- recX recibe el subárbol ORIGINAL además del resultado recursivo
-- En el paso inductivo, usar el subárbol original para tomar decisiones

-- Patrón: "primera aparición en preorder"
reemplazarUno x y = recABNV
  (\v -> if x == v then Hoja y else Hoja v)
  (\v ar rec ->
      if x == v then Uni y ar          -- encontré en raíz: reemplazar raíz, resto original
      else Uni v rec)                   -- no está en raíz: recurrir
  (\i reci v d recd ->
      if x == v then Bi i y d           -- raíz
      else if elemABNV x i then Bi reci v d  -- está en izq (uso reci)
      else Bi i v recd)                 -- está en der (uso recd)

-- Patrón: "necesito el estado anterior del buffer"
puedeCompletarLecturas = recBuffer True
  (\_ _ _ rec -> rec)
  (\n b rec -> elem n (posicionesOcupadas b) && rec)
  -- b es el buffer ORIGINAL antes de esta lectura
```

**Regla de oro:**
- `fold` si solo necesito el *resultado* de los subárboles
- `rec` si necesito *la estructura original* de algún subárbol para tomar decisiones

## Por que funciona

`rec` (paramorfismo) preserva acceso al subárbol original antes de la recursión. Esto es esencial cuando la decisión en un nodo depende de si un elemento *existe en* un subárbol (requiere inspeccionar esa rama), no solo del resultado final de procesarla.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ejercicio 1d: estáEnFNN con recProp
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 1c: reemplazarUno con recABNV
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 1d: puedeCompletarLecturas con recBuffer

## Ejercicios que ejemplifican esto

- [[temas/programacion_funcional_guia]] — Ejercicio 6: sacarUna con recr (recursión primitiva sobre listas)
- [[temas/programacion_funcional_guia]] — Ejercicio 6c: insertarOrdenado con recr
