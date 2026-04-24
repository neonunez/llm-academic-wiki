---
nombre: Demostración — inducción estructural en árboles
parcial: 1P
tipo: tipo_ejercicio
---

# Demostración — inducción estructural en árboles

## Como reconocer este patron

- El enunciado pide demostrar una propiedad `forall t::AB a . forall u . P(t, u)` o `forall t::AB . P(t)`
- La función principal de la propiedad tiene recursión sobre un árbol
- Puede requerir extensionalidad cruzada: inducción en `t`, subcasos en `u`

## Template de resolucion

```
Sea P(t) = [enunciado de la propiedad con 'forall' internos si los hay]

CASO BASE: t = Nil (o t = Hoja v)
  Reemplazar en la propiedad. Simplificar con las ecuaciones del tipo.
  Si hay otro parámetro libre (ej. u), abrir subcasos: u = Nil y u = Bin l r.

PASO INDUCTIVO: t = Bin i r d (o t = Tri x i m d, etc.)
  HI: P(i) y P(d)  [y P(m) si es ternario]
  Tesis: P(Bin i r d)
  
  1. Expandir ambos lados usando las ecuaciones de la función.
  2. Si hay otro parámetro libre (u), abrir subcasos.
  3. En el subcaso con constructor recursivo (u = Bin l r):
     - Expandir las funciones usando sus ecuaciones
     - Aplicar la HI sobre las ramas relevantes
  4. Concluir.
```

**Técnica del lema de generación de booleanos:**
Si el antecedente es `A || B || C = True`, abrir 3 subcasos: A=True, B=True, C=True.

## Por que funciona

La inducción estructural garantiza que la propiedad vale para todos los elementos del tipo porque el tipo es inductivo (finito, bien fundado). La hipótesis inductiva cubre exactamente los subelementos directos del constructor.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 2a: inducción en AEB, propiedad esPreRama
- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ejercicio 2a: inducción en AIH, simetría de mismaEstructura
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 2a: inducción en AB, propiedad elemAB/mapAB
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 2a: inducción en AB, propiedad altura/zipAB
- [[parciales_analizados/1.parcial_2C_2025_resolucion(1)]] — Ejercicio 2a: inducción en Arbol123, propiedad truncar

## Ejercicios que ejemplifican esto

- [[temas/demostracion_de_propiedades_guia]] — Ejercicio 10 (altura ≤ cantNodos en AB)
- [[temas/demostracion_de_propiedades_guia]] — Ejercicio 11 (propiedades de truncar)
- [[temas/demostracion_de_propiedades_guia]] — Ejercicio 12 (elemAB = elem . inorder)
- [[temas/demostracion_de_propiedades_guia]] — Ejercicio 14 (propiedades de AIH)
- [[temas/demostracion_de_propiedades_practica]] — Inducción sobre árboles binarios (cantNodos)
