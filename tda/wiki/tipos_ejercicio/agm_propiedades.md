---
nombre: AGM — Propiedades y algoritmos
parcial: 2P
tema: arboles_generadores_minimos
apariciones_en_parciales:
  - raw/parciales/2P/2.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_1C_2025_resolucion(1).pdf
---

# AGM — Propiedades y algoritmos

## Como reconocer este patron

- Se dan afirmaciones sobre aristas y AGM y se pide decidir verdadero/falso.
- Se da un grafo especial (pesos iguales, pesos distintos, grafo completo) y se pregunta que algoritmo usar.
- Se pide demostrar una propiedad del AGM o dar un contraejemplo.
- Se pide construir/modelar un problema de red como AGM.

## Template de resolucion

### Propiedades fundamentales del AGM

| Condicion | Propiedad |
|-----------|-----------|
| Arista de peso minimo unico en $G$ | Pertenece a **todos** los AGM |
| Arista puente | Pertenece a **todos** los AGM |
| Arista en un ciclo $C$ | Existe algun AGM **sin** ella (la mas pesada del ciclo puede reemplazarse) |
| Arista de peso maximo | Puede estar en AGM si es puente |
| Pesos todos distintos | **AGM unico** |
| Pesos todos iguales | Todo arbol generador es AGM → usar DFS/BFS $O(n+m)$ |

### Propiedad de corte (Cut Property)

Si $e$ es la arista de menor peso que cruza algun corte $(S, V \setminus S)$, entonces $e$ pertenece a algun AGM.

### Propiedad de ciclo (Cycle Property)

Si $e$ es la arista de mayor peso en algun ciclo $C$, entonces $e$ **no** pertenece a ningun AGM.

### Agregar una arista que mejora el AGM

1. La nueva arista $e'$ crea un ciclo en el AGM actual.
2. Si $e'$ es mas liviana que la arista mas pesada $e_{max}$ del ciclo, intercambiarlas mejora el AGM.
3. Peso nuevo AGM = peso viejo - $w(e_{max})$ + $w(e')$.

### Reverse-delete algorithm

Ordenar aristas por peso decreciente. Mientras haya ciclos: eliminar la arista mas pesada del ciclo actual.
- **Correcto** (equivalente a Kruskal pero al reves).
- **Complejidad:** $\Theta(nm)$ — hasta $m - (n-1)$ ciclos, cada busqueda de ciclo es $O(n+m)$.

## Por que funciona

El AGM existe en grafos conexos (teorema). La unicidad con pesos distintos se sigue de que no hay empates en ninguna propiedad de corte. El reverse-delete es correcto por la propiedad de ciclo: la arista mas pesada de cada ciclo siempre puede eliminarse sin romper el AGM.

## Casos vistos en parciales

**2P_1C_2024 Ej 1 — Pesos todos iguales:**
- Cualquier arbol generador es AGM → DFS o BFS en $O(n+m)$ (mejor que Kruskal/Prim).

**2P_1C_2024 Ej 2 — Grafo completo $K_n$ con pesos 1..m:**
- Solo hay un AGM (pesos distintos → AGM unico).
- Las $n-1$ aristas mas livianas forman el AGM.

**2P_1C_2024 Ej 3 — Afirmaciones sobre aristas y AGM:**
- Verdaderas: arista peso minimo en AGM; puente en todos los AGMs; arista en ciclo → existe AGM sin ella.
- Falsas: "arista peso maximo no esta en ningun AGM" (puede ser puente); "$|E| > n-1$ implica arista no en AGMs" (puede haber empates).

**2P_1C_2024 Ej 4 — Reverse-delete:**
- Correcto, complejidad $\Theta(nm)$.

**2P_1C_2025 Ej A5 — Agregar arista que reduce AGM:**
- Construir ejemplo concreto: nueva arista forma ciclo, es mas liviana que la mas pesada del ciclo → peso del AGM baja.

**2P_1C_2025 Ej A8 — Piramide 3D (AGM maximo):**
- Nodo = cara, arista = borde compartido con peso = longitud.
- Minimizar bordes pegados = maximizar bordes doblados = **arbol generador maximo**.

## Trampas frecuentes

- Confundir "arista con peso maximo no esta en AGMs" (FALSO si es puente) con "arista mas pesada en un ciclo no esta en ningun AGM" (VERDAD).
- Olvidar que $|E| > n-1$ no implica arista sin AGM cuando hay empates de peso.
- En modelado de piramides/poliedros: minimizar bordes pegados es AGM **maximo**, no minimo.
- Confundir complejidad de reverse-delete ($\Theta(nm)$) con Kruskal ($O(m \log m)$) — reverse-delete es peor en general.

## Apariciones en parciales

- **2P_1C_2024 Ej 1-4:** pesos iguales, unicidad, propiedades de aristas, reverse-delete
- **2P_1C_2025 Ej A5:** ejemplo de arista que mejora AGM
- **2P_1C_2025 Ej A8:** piramide 3D — AGM maximo

## Ejercicios que ejemplifican esto

- [[arboles_generadores_minimos_guia]] — propiedades, correctitud de Kruskal y Prim
- [[arboles_generadores_minimos_practica]] — ejercicios de clase con propiedades de AGM
- [[arboles_generadores_minimos_teoria]] — demostracion de correctitud, propiedad de corte y ciclo
