---
nombre: Cálculo Lambda — valores y semántica operacional de extensión ADT
parcial: 1P
programa: 2C_2026
tipo: tipo_ejercicio
tema: calculo_lambda_tipado
---

# Cálculo Lambda — valores y semántica operacional de extensión ADT

## Como reconocer este patron

- El enunciado extiende el cálculo lambda tipado y el inciso b) pide "definir el conjunto de valores y las reglas de semántica operacional"
- Hay que agregar constructores al conjunto V y dar reglas de cómputo (+ reglas de congruencia)

## Template de resolucion

```
-- 1. EXTENDER VALORES
V ::= ... | Constructor1(V, V) | Constructor2_sin_args

-- 2. REGLAS DE CÓMPUTO (reducción en un paso)
-- Una regla por patrón de destructor aplicado a valor:

destructor(Constructor(V1, V2)) --> resultado_con_V1_V2   [nombre_regla]

-- Ejemplo Dicc:
def?(Vacio, W)              --> False           (defV)
def?(definir(V,W,U), W')   --> if W==W' then True else def?(V,W')   (defX)
obtener(definir(V,W,U), W') --> if W==W' then U else obtener(V,W')  (obtX)

-- Ejemplo case:
case Hoja(V) of Hoja x ~> M1 ; Bin(i,d) ~> M2  --> M1{x:=V}
case Bin(V1,V2) of Hoja x ~> M1 ; Bin(i,d) ~> M2 --> M2{i:=V1, d:=V2}

-- 3. REGLAS DE CONGRUENCIA
-- Una por posición de subexpresión reducible:
-- Si M --> M', entonces Constructor(M, N) --> Constructor(M', N)  (congr1)
-- Si M --> M', entonces Constructor(V, M) --> Constructor(V, M')  (congr2)
-- Si M --> M', entonces destructor(M, N) --> destructor(M', N)    (congrDestr)
```

**Checklist:**
- ¿Qué formas toma un valor del nuevo tipo? (cerrado = no tiene redexes)
- ¿Un constructor es valor solo si sus argumentos lo son? Sí en casi todos los casos.
- ¿Cuántas reglas de congruencia hay? Una por posición que puede reducir.

## Por que funciona

Las reglas de cómputo describen qué pasa cuando un destructor/observador se aplica a un valor totalmente reducido. Las de congruencia indican cómo avanzar la evaluación hacia adentro hasta llegar a un valor.

## Apariciones en parciales

- [[parciales_analizados/1.parcial_1C_2024_resolucion(1)]] — Ejercicio 3b: semántica de Dicc (def?, obtener)
- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ejercicio 3b: semántica de AIH (case Hoja/Bin)
- [[parciales_analizados/1.parcial_1C_2025_resolucion(1)]] — Ejercicio 3b: semántica de listas ordenadas (head<, tail<)
- [[parciales_analizados/1.parcial_2C_2024_resolucion(1)]] — Ejercicio 3b: semántica de AT (foldAT con TNil/Tern)

## Ejercicios que ejemplifican esto

- [[temas/calculo_lambda_guia]] — Ejercicio con extensión pares (reglas π1, π2)
- [[temas/calculo_lambda_guia]] — Ejercicio con extensión listas (reglas head, tail)
- [[temas/calculo_lambda_practica]] — Ejercicio 4 (valores en semántica operacional)
- [[temas/calculo_lambda_practica]] — Ejercicio 6 (regla ζ — variación de semántica)
