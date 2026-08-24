---
nombre: Resolución en Lógica de Primer Orden - Práctica
parcial: 2P
programa: 2C_2026
tipo: clase_practica
tema: resolucion
fuente: raw/clases/prac/10.prac_P2_resolucion_logica_primer_orden.pdf
paginas_relacionadas: ["[[resolucion_teoria]]", "[[resolucion_sld_y_prolog_teoria]]", "[[logica_de_primer_orden_teoria]]"]
---

# Resolución en Lógica de Primer Orden — Práctica

Guía práctica sobre el método de resolución general y su variante **SLD**, núcleo del funcionamiento de Prolog.

---

## Repaso de Conceptos Clave

### Cláusulas de Horn
Son cláusulas con **a lo sumo un literal positivo**. Se dividen en:
- **Cláusulas de Definición** (Programa):
    - **Hechos**: `{P}` (un solo literal positivo).
    - **Reglas**: `{P, ¬Q1, ..., ¬Qn}` (un literal positivo y uno o más negativos).
- **Cláusulas Objetivo (Goal)**: `{¬Q1, ..., ¬Qn}` (ningún literal positivo).

### Resolución SLD (Selective Linear Definitional)
Un caso particular de resolución donde:
1. Se comienza con una **cláusula objetivo** $N_0$.
2. En cada paso $i$, se resuelve el objetivo actual $N_i$ con una **cláusula de definición** para obtener un nuevo objetivo $N_{i+1}$.
3. El proceso finaliza al alcanzar la **cláusula vacía** ($\Box$).

---

## Ejercicio 1: Enemigos y Amigos

**Enunciado**: "Los enemigos de mis enemigos son mis amigos".
Base de conocimiento:
1. `{amigo(A, B), ¬enemigo(A, C), ¬enemigo(C, B)}`
2. `{enemigo(Reed, Galactus)}`
3. `{enemigo(Galactus, Ben)}`
4. `{enemigo(Galactus, Johnny)}`

**Consulta**: `?- amigo(Reed, X).` (Objetivo: `{¬amigo(Reed, X)}`)

**Resolución SLD**:
1. $N_0$: `{¬amigo(Reed, X)}`
2. Resolviendo $N_0$ con (1) [$A/Reed, B/X$]:
   $N_1$: `{¬enemigo(Reed, C), ¬enemigo(C, X)}`
3. Resolviendo $N_1$ con (2) [$C/Galactus$]:
   $N_2$: `{¬enemigo(Galactus, X)}`
4. Resolviendo $N_2$ con (3) [$X/Ben$]:
   $N_3$: $\Box$

**Sustitución Respuesta**: $\{X = Ben\}$.
*Nota: También existe otra resolución válida con (4) que daría $X = Johnny$.*

---

## Ejercicio 2: Propiedades de Relaciones (2P 1C 2011)

**Enunciado**: Demostrar que una relación no vacía no puede ser simultáneamente irreflexiva, simétrica y transitiva.
Para ello, probamos que si cumple las tres, entonces es vacía ($\forall X . \neg \exists Y . R(X, Y)$).

**Cláusulas**:
1. **Irreflexiva**: `{¬R(X1, X1)}`
2. **Simétrica**: `{¬R(X2, Y2), R(Y2, X2)}`
3. **Transitiva**: `{¬R(X3, Y3), ¬R(Y3, Z3), R(X3, Z3)}`
4. **Negación de la Tesis** (R no es vacía $\rightarrow \exists X, Y . R(X, Y)$): `{R(a, b)}` (Cláusula Objetivo)

### Variante A: Resolución No-SLD (Lineal pero no SLD)
1. Resolviendo (4) con (2): `{R(b, a)}` [$X2/a, Y2/b$]
2. Resolviendo (5) con (3): `{¬R(X, b), R(X, a)}` [$Y3/b, Z3/a$]
3. Resolviendo (6) con (4): `{R(a, a)}` [$X/a$]
4. Resolviendo (7) con (1): $\Box$ [$X1/a$]

> [!WARNING]
> Esta resolución **no es SLD** porque en el paso 4 se resuelven dos cláusulas que no son el objetivo actual con una definición, o bien no se mantiene la estructura de "objetivo + definición $\rightarrow$ nuevo objetivo" de forma estricta según el orden de Prolog.

### Variante B: Resolución SLD
1. $N_0$: `{¬R(X1, X1)}` (Tomamos la irreflexividad como objetivo de contradicción)
2. Resolviendo $N_0$ con (3): `{¬R(X1, Y3), ¬R(Y3, X1)}` [$X3/X1, Z3/X1$]
3. Resolviendo $N_1$ con (4): `{¬R(b, a)}` [$X1/a, Y3/b$]
4. Resolviendo $N_2$ con (2): `{¬R(a, b)}` [$X2/a, Y2/b$]
5. Resolviendo $N_3$ con (4): $\Box$

---

## Ejercicio 3: Prolog y el Orden de las Cláusulas

Considere:
1. `natural(0).`
2. `natural(suc(X)) :- natural(X).`
3. `menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).`
4. `menorOIgual(X, X) :- natural(X).`

**Consulta**: `?- menorOIgual(0, X).`

En Prolog, esto entra en un **bucle infinito**.
**¿Por qué?**
Prolog busca en orden. Al intentar resolver `menorOIgual(0, X)`, unifica con la regla (3) transformándolo en `menorOIgual(0, Y)`. Esta sub-meta vuelve a unificar con (3) infinitamente, generando `suc(suc(suc(...)))` sin llegar nunca a probar el caso base (4).

**Solución**: El orden de las cláusulas importa. Intercambiar (3) y (4) permitiría encontrar `X = 0` primero.

---

## Ejercicio 4: Recorrido Preorder

**Programa**:
```prolog
preorder(nil, []).
preorder(bin(I, R, D), [R|L]) :- append(LI, LD, L), preorder(I, LI), preorder(D, LD).

append([], YS, YS).
append([X|XS], YS, [X|L]) :- append(XS, YS, L).
```

**Cláusulas**:
1. `{preorder(nil, [])}`
2. `{preorder(bin(I, R, D), [R|L]), ¬append(LI, LD, L), ¬preorder(I, LI), ¬preorder(D, LD)}`
3. `{append([], YS, YS)}`
4. `{append([X|XS], YS, [X|L]), ¬append(XS, YS, L)}`

**Análisis**:
- El método que utiliza Prolog es **SLD** con una estrategia de búsqueda **en profundidad (DFS)** y **orden de arriba a abajo, izquierda a derecha**.
- En la resolución manual, podemos elegir cualquier literal para resolver, pero para que sea "tipo Prolog" debemos seguir estrictamente el orden de los literales en el cuerpo de las reglas.

---

## Patrones de este tema en parciales

> [[tipos_ejercicio/resolucion_forma_clausal]] · [[tipos_ejercicio/resolucion_por_contradiccion]] · [[tipos_ejercicio/resolucion_sld_justificacion]]
