---
nombre: Haskell — fold con currificación y evaluación parcial
parcial: 1P
tipo: tipo_ejercicio
---

# Haskell — fold con currificación y evaluación parcial

## Como reconocer este patron

- El enunciado dice "usar currificación y evaluación parcial"
- La función a implementar toma una estructura Y un parámetro extra (Int, profundidad, contador)
- Ejemplos: `nivel :: AT a -> Int -> [a]`, `deshacer :: Buffer a -> Int -> Buffer a`

## Template de resolucion

```haskell
-- La clave: hacer que el fold devuelva una FUNCIÓN (Int -> resultado)
-- en lugar de devolver el resultado directamente

nivel :: AT a -> Int -> [a]
nivel = foldAT
  (\i -> [])                          -- NilT: siempre lista vacía para cualquier nivel
  (\x ri rm rd -> \i ->               -- Tri: lambda que espera el nivel
      if i == 0
      then [x]
      else ri (i-1) ++ rm (i-1) ++ rd (i-1))

deshacer :: Buffer a -> Int -> Buffer a
deshacer = recBuffer
  (const Empty)
  (\n x b rec -> \e -> if e == 0 then Write n x b else rec (e-1))
  (\n b rec   -> \e -> if e == 0 then Read n b    else rec (e-1))
```

**Señal clave:** el tipo resultado del fold es `Int -> [a]` o `Int -> X a`, no `[a]` o `X a` directamente.

## Por que funciona

El fold construye, para cada nodo, una función que espera el parámetro extra (`i` o `e`). Al aplicar esa función al argumento concreto, se obtiene el resultado. Esto evita pasar el argumento extra manualmente en cada llamada recursiva.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 1d: `nivel` con foldAT
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 1d: `nivel` con foldABNV
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 1e: `deshacer` con recBuffer

## Ejercicios que ejemplifican esto

- [[temas/programacion_funcional_guia]] — Ejercicio 7 II: `armarPares` (zip con evaluación parcial)
- [[temas/programacion_funcional_guia]] — Ejercicio 12 IV: `esABB` (posible uso de rango mín/máx)
