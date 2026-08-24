---
nombre: Haskell — funciones sobre árboles vía fold
parcial: 1P
programa: 2C_2026
tipo: tipo_ejercicio
tema: programacion_funcional
---

# Haskell — funciones sobre árboles vía fold

## Como reconocer este patron

- El enunciado pide definir `preorder`, `mapAT`, `variables`, `posicionesOcupadas`, `evaluar`, `hojas`, `rutas`, etc. usando el fold/rec definido en el inciso a)
- El inciso dice "sin recursión explícita" o "usando foldX"
- El tipo resultado es una lista, bool, o el mismo tipo

## Template de resolucion

```haskell
-- Patrón general: sustituir cada constructor por una función lambda
funcionX = foldX
  (<caso_base>)           -- e.g., []  /  False  /  0
  (<combinador>)          -- e.g., \x ri rm rd -> ...

-- Ejemplos frecuentes:
-- preorder (acumular en lista):
preorder = foldAT [] (\x ri rm rd -> x : (ri ++ rm ++ rd))

-- map (reconstruir misma estructura):
mapAT f = foldAT NilT (\x ri rm rd -> Tri (f x) ri rm rd)

-- pertenencia:
elemX e = foldX (== e) (\v rec -> v == e || rec)
                       (\reci v recd -> v == e || reci || recd)
```

**Heurística:** el tipo resultado `b` del fold debe ser el tipo de salida de la función que quieres implementar.

## Por que funciona

Cada llamada al fold reemplaza constructores del tipo por funciones. El resultado en cada nodo combina los resultados de los hijos recursivos. No hace falta escribir la recursión explícita.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 1b/c/d: preorder, mapAT, nivel con foldAT
- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ejercicio 1b/c/d: variables, evaluar, estáEnFNN
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 1b: elemABNV
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 1b/c/d: posicionesOcupadas, contenido, puedeCompletarLecturas
- [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 1b/c: rutas, valido

## Ejercicios que ejemplifican esto

- [[temas/programacion_funcional_guia]] — Ejercicio 3 (foldr sobre listas)
- [[temas/programacion_funcional_guia]] — Ejercicio 12 (altura, cantNodos, mejorSegun sobre AB)
- [[temas/programacion_funcional_guia]] — Ejercicio 13 (ramas, cantHojas, espejo)
- [[temas/programacion_funcional_guia]] — Ejercicio 15 (hojas, distancias, altura sobre RoseTree)
- [[temas/programacion_funcional_practica]] — foldAEB aplicaciones (altura, cantNodos)
