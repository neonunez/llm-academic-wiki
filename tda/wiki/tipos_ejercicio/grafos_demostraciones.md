---
nombre: Grafos — Demostrar propiedades de grafos
parcial: 2P
tema: grafos
apariciones_en_parciales:
  - raw/parciales/1P/1.parcial_1C_2024_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_2C_2025_resolucion(1).pdf
  - raw/parciales/2P/2.parcial_1C_2025_resolucion(1).pdf
---

# Grafos — Demostrar propiedades de grafos

## Como reconocer este patron

- Se da una propiedad sobre grafos (orientaciones, ciclos, conexidad, arboles) y se pide demostrar o refutar.
- Piden elegir cuales afirmaciones de una lista son verdaderas/falsas.
- Piden demostrar existencia de un subestructura (ciclo, sumidero, camino) con argumento constructivo o por absurdo.

## Template de resolucion

### Demo por absurdo

1. Suponer que la propiedad falla.
2. Derivar una contradiccion con las hipotesis (ciclo, desconexion, etc.).
3. Concluir que la propiedad debe valer.

**Ejemplo canonico (sumidero en orientacion aciclica):**
- Suponer que no hay sumidero.
- Desde cualquier vertice podemos seguir aristas salientes indefinidamente.
- Al haber finitos vertices, algun vertice se repite → ciclo → contradiccion con "aciclica".

### Demo constructiva

1. Construir explicitamente el objeto cuya existencia se quiere demostrar.
2. Verificar que cumple todas las propiedades requeridas.

**Ejemplo canonico (ciclo simple por $v$ y $w$):**
- $G - \{v,w\}$ tiene $\geq 2$ componentes $C_1, C_2, ...$
- Como $G - v$ es conexo, $w$ es adyacente a todas las componentes.
- Como $G - w$ es conexo, $v$ es adyacente a todas las componentes.
- Construir: $v \to a \in C_1 \xrightarrow{P_{C_1}} b \to w \to c \in C_2 \xrightarrow{P_{C_2}} d \to v$ (ciclo simple).

### Contraejemplo

Para refutar una propiedad universal, basta un contraejemplo concreto y pequeño.

**Ejemplos:**
- "Ciclo implica conexo" → FALSO: $C_3 \cup K_1$ (ciclo + nodo aislado).
- "Grafo conexo no es junta" → FALSO: $K_2$ es junta de dos $K_1$.

## Por que funciona

Las demos por absurdo en grafos explotan propiedades topologicas: finitud de vertices fuerza ciclos cuando no hay terminacion. Las demos constructivas usan conexidad de subgrafos para garantizar existencia de caminos.

## Casos vistos en parciales

**1P_1C_2024 Ej 5 — Orientaciones aciclicas:**
- Toda orientacion aciclica tiene al menos un sumidero (demo por absurdo: sino hay ciclo).
- Cantidad de orientaciones aciclicas es PAR (invertir todas las aristas crea una biyeccion de a pares).

**1P_1C_2024 Ej 6 — Orientaciones de $K_n$:**
- $K_n$ orientado aciclicamente tiene exactamente 1 sumidero (si hubiera 2, la arista entre ellos contradice que sean sumideros).
- $K_n$ tiene $n!$ orientaciones aciclicas (una por orden total de vertices).

**1P_1C_2024 Ej 7 — Propiedades varias:**
- 2 vertices de grado impar → existe camino entre ellos (paridad de suma de grados).
- Orientacion de $K_n$ → camino hamiltoniano (largo $n-1$).

**2P_2C_2025 Ej 2 — Ciclo simple por $v$ y $w$:**
- Hipotesis: $G-v$ conexo, $G-w$ conexo, $G-\{v,w\}$ no conexo.
- Demo constructiva usando componentes de $G-\{v,w\}$.
- ⚠️ Error comun: argumento por absurdo via puentes no cierra bien; usar constructiva siguiendo la ayuda.

**2P_1C_2025 Ej A1 — 2-colorabilidad:**
- Ciclo $C_n$ es 2-colorable $\Leftrightarrow$ $n$ par $\Leftrightarrow$ bipartito.

## Trampas frecuentes

- Usar argumento por absurdo cuando el enunciado sugiere demo constructiva (las componentes conexas son la ayuda explicita).
- No cerrar el argumento: mostrar que "algo existe" sin construirlo explicitamente.
- Confundir condiciones para arboles: conexo + $n-1$ aristas + sin ciclos (cualquier 2 de 3 implica la tercera).

## Apariciones en parciales

- **1P_1C_2024 Ej 5-7:** orientaciones aciclicas, propiedades de grafos, contraejemplos
- **2P_2C_2025 Ej 2:** ciclo simple por dos vertices — demo constructiva con componentes conexas
- **2P_1C_2025 Ej A1:** 2-colorabilidad de ciclos

## Ejercicios que ejemplifican esto

- [[grafos_teoria]] — definiciones de orientacion, sumidero, bipartito
- [[grafos_guia]] — demostraciones de propiedades estructurales
- [[recorrido_en_grafos_guia]] — demos usando BFS/DFS como herramienta
