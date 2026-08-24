---
nombre: Smalltalk — tabla de ejecución (method lookup y self/super)
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: programacion_orientada_objetos
---

# Smalltalk — tabla de ejecución (method lookup y `self`/`super`)

## Como reconocer este patron

- El enunciado da una jerarquía de clases con herencia y pide el resultado de una expresión
- Involucra `self`, `super`, bloques (`[...]`) y `value`
- Pide "trazar la ejecución" o "realizar la tabla de ejecución"

## Template de resolucion

**Reglas de method lookup:**
```
1. self mensaje   → busca desde la clase del RECEPTOR (dinámico)
2. super mensaje  → busca desde la SUPERCLASE de donde está escrito el método
                    (estático en cuanto a inicio, dinámico en cuanto al receptor)
3. Bloque value   → evalúa el cuerpo del bloque; NO crea un nuevo self
                    (el self dentro del bloque es el receptor del método que lo creó)
4. Herencia       → si una clase no define el método, sube a la superclase
```

**Formato tabla de ejecución:**
```
| Paso | Expresion         | Receptor | Clase buscada | Método encontrado en | Resultado |
|------|-------------------|----------|---------------|----------------------|-----------|
| 1    | B new             | B        | B             | Object               | unB       |
| 2    | unB m1            | unB      | B             | A (heredado)         | [self eval] |
| 3    | [self eval] value | unB      | B             | -                    | self eval → |
| 4    | unB eval          | unB      | B             | B                    | 2         |
```

**Trucos para no equivocarse:**
- **`[self eval]`:** `self` dentro del bloque es el receptor original cuando se creó el bloque. Si el bloque fue creado en un método de A aplicado a `unB`, `self` = `unB`.
- **`[super eval]`:** `super` busca en la superclase de donde está escrito el método, **no** de donde está el receptor.
- **Herencia:** `C subclass: A` significa que si C no define un método, se busca en A (luego Object).

## Por que funciona

El **dynamic dispatch** (despacho dinámico) garantiza que `self` siempre se resuelve en tiempo de ejecución según el objeto receptor. `super` es una excepción que fija el inicio de la búsqueda en la superclase léxica pero mantiene el receptor dinámico.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 3a: clases A/B con `m1`, `m2`, `m3`, `eval`, `value` (resultado 2 y 1)
- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 3a.I: clases A/B/C con `a:b:` y bloque anidado (resultado 6)

## Ejercicios que ejemplifican esto

- [[temas/programacion_orientada_objetos_guia]] — Ejercicio 17 (comportamiento de self y super)
- [[temas/programacion_orientada_objetos_guia]] — Ejercicio 20 (Counter y FlexibleCounter, despacho multi-nivel)
- [[temas/programacion_orientada_objetos_guia]] — Ejercicio 21 (Jerarquía X/Y: despacho complejo)
- [[temas/programacion_orientada_objetos_guia]] — Ejercicio 22 (Jerarquía A/B/C con super)
