---
nombre: Haskell — fold/rec para tipo algebraico nuevo
parcial: 1P
tipo: tipo_ejercicio
---

# Haskell — fold/rec para tipo algebraico nuevo

## Como reconocer este patron

- El enunciado define un `data` nuevo (árbol ternario, árbol con constructor extra, árbol de archivos, buffer, etc.)
- El inciso a) pide "Dar el tipo y definir `foldX` y/o `recX`"
- Suele decir "solo en este inciso se permite recursión explícita"

## Template de resolucion

```haskell
-- fold: tantos argumentos como constructores del tipo
foldX :: <caso_base_1> -> <caso_rec_1> -> ... -> X a -> b
foldX f1 f2 ... (Constructor1 ...) = f1 ...
foldX f1 f2 ... (ConstructorRec x sub1 sub2) =
    f2 x (foldX f1 f2 ... sub1) (foldX f1 f2 ... sub2)

-- rec: igual que fold, pero en constructores recursivos
-- se pasa TAMBIÉN el subtérmino original (no solo el resultado)
recX :: <caso_base_1> -> <caso_rec_1_extendido> -> ... -> X a -> b
recX f1 f2 ... (Constructor1 ...) = f1 ...
recX f1 f2 ... (ConstructorRec x sub1 sub2) =
    f2 x sub1 (recX f1 f2 ... sub1) sub2 (recX f1 f2 ... sub2)
```

**Regla de oro para el tipo de `foldX`:**
- Un argumento por constructor
- Para constructores sin recursión: toma los tipos de los campos tal cual
- Para constructores con recursión: reemplaza el subtipo `X a` por `b` (el tipo resultado)

**Regla de oro para `recX`:**
- Igual que fold, pero en los constructores recursivos también recibe el subárbol original `X a` antes del resultado `b`

## Por que funciona

`fold` es el catamorfismo del tipo: reemplaza cada constructor por una función.
`rec` es el paramorfismo: igual pero mantiene acceso al subárbol antes de la recursión, necesario cuando el resultado en un nodo depende de la *forma* de los hijos (no solo de su valor procesado).

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 1: foldAT (árbol ternario)
- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ejercicio 1: foldProp y recProp (lógica proposicional)
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 1: foldABNV y recABNV
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 1: foldBuffer y recBuffer
- [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 1: foldFS y recFS

## Ejercicios que ejemplifican esto

- [[temas/programacion_funcional_guia]] — Ejercicio 12 (foldAB, recAB)
- [[temas/programacion_funcional_guia]] — Ejercicio 14 (foldAIH)
- [[temas/programacion_funcional_guia]] — Ejercicio 9 (foldNat)
- [[temas/programacion_funcional_guia]] — Ejercicio 11 (foldPoli)
- [[temas/programacion_funcional_guia]] — Ejercicio 15 (foldRose)
- [[temas/programacion_funcional_practica]] — foldAEB, foldRose, foldPoli
