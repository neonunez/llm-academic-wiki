---
nombre: Logica Combinatoria — Guia de Ejercicios (Practica 2, Parte 1)
parcial: 1P
programa: 2C_2026
tipo: guia
tema: logica_combinatoria
fuente: "raw/guias_practicas/2.prac_logica_digital_parte_1.pdf, raw/guias_practicas/2.prac_logica_digital_parte_2.pdf"
paginas_relacionadas:
  - "[[logica_combinatoria_teoria]]"
  - "[[parciales_analizados/1P_2C_2024]]"
  - "[[parciales_analizados/1P_1C_2025]]"
  - "[[parciales_analizados/1P_2C_2024_recuperatorio]]"
---

# Logica Combinatoria — Guia de Ejercicios

Fuentes: `raw/guias_practicas/2.prac_logica_digital_parte_1.pdf` (enunciados + texto) y `raw/guias_practicas/2.prac_logica_digital_parte_2.pdf` (diagramas de circuitos resueltos, Ej 4/5/6/8/9/10). Practica 2, Logica Digital, 1C 2025.
Esta pagina cubre los ejercicios de **Circuitos Combinatorios** (Ej 1–10). Los ejercicios de Circuitos Secuenciales (Ej 11–19) estan en [[logica_secuencial_guia]].

Nota del enunciado: todas las compuertas son de 1 o 2 entradas salvo indicacion. Simbolos: XOR → $\oplus$, NAND → $|$, NOR → $\downarrow$.

---

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej 1 | Verificar equivalencias booleanas (V/F) | 🔴 Si |
| Ej 2 | ¿Toda funcion booleana es expresable con OR/AND/NOT? | 🔴 Si |
| Ej 3 | Universalidad de NAND y NOR | 🔴 Si |
| Ej 4 | Dibujar circuitos booleanos con NOR, XOR, NAND | 🔴 Si |
| Ej 5 | SDP desde tablas de verdad + simplificacion algebraica | 🔴 Si |
| Ej 6 | Inversor k-bits con entrada de control | ⚪ No |
| Ej 7 | Inverso aditivo en C2 con deteccion de overflow | 🔴 Si |
| Ej 8 | Demultiplexor 1 entrada, 2 control, 4 salidas | ⚪ No |
| Ej 9 | Codificador 4→2 con salida de validez | ⚪ No |
| Ej 10 | Decodificador 2→4 + reescribir DEMUX con decodificador | ⚪ No |

---

## Ejercicios

### Ejercicio 1 — Equivalencias booleanas (V/F)

**Enunciado**

Demostrar si las siguientes equivalencias de formulas booleanas son verdaderas o falsas:

a) $x \cdot z = (x + y) \cdot (x + \overline{y}) \cdot (x + z)$

b) $x \oplus (y \cdot z) = (x \oplus y) \cdot (x \oplus z)$, donde se aplica la propiedad distributiva de $\oplus$ respecto al producto.

Nota: $p \oplus q = (p \cdot \overline{q}) + (\overline{p} \cdot q)$.

**Explicacion**

Ejercicio de manipulacion algebraica sobre el algebra de Boole. Para cada inciso hay que reducir ambos lados de la igualdad a la misma expresion, o encontrar un contraejemplo que la refute.

- Inciso a): usa las propiedades de complemento y distribucion ($x + y)(x + \overline{y}) = x$).
- Inciso b): verifica si $\oplus$ distribuye sobre el producto. Esto NO es una propiedad estandar — hay que verificarlo con tabla de verdad o algebra.

**Resolucion paso a paso**

**Inciso a) — FALSA**

Simplificar el lado derecho:

Paso 1: aplicar distributividad de OR sobre AND al primer par:
$$(x + y) \cdot (x + \overline{y}) = x + (y \cdot \overline{y}) = x + 0 = x$$

Paso 2: reemplazar en el RHS:
$$x \cdot (x + z) = x \cdot x + x \cdot z = x + x \cdot z = x \quad \text{(absorcion)}$$

El RHS simplifica a $x$, no a $x \cdot z$.

Contraejemplo: $x = 1,\ z = 0,\ y = 0$:
- LHS: $1 \cdot 0 = 0$
- RHS: $(1+0)(1+1)(1+0) = 1 \cdot 1 \cdot 1 = 1$

LHS $\neq$ RHS → **FALSA**.

---

**Inciso b) — FALSA**

Contraejemplo con $x = 1,\ y = 0,\ z = 1$:
- LHS: $1 \oplus (0 \cdot 1) = 1 \oplus 0 = 1$
- RHS: $(1 \oplus 0) \cdot (1 \oplus 1) = 1 \cdot 0 = 0$

LHS $\neq$ RHS → **FALSA**.

Nota: la propiedad que SÍ vale es la dual: $x \cdot (y \oplus z) = (x \cdot y) \oplus (x \cdot z)$ (AND distribuye sobre XOR). El ejercicio verifica la direccion inversa, que no es valida.

**Chuleta**

1. Para verificar equivalencias booleanas: intentar simplificar ambos lados algebraicamente.
2. Si la simplificacion es dificil, buscar contraejemplo con valores concretos (x=1, y=0, z=1, etc.).
3. Identidad clave: $(A + B)(A + \overline{B}) = A + B\overline{B} = A$ (distributividad de OR sobre AND).
4. Absorcion: $A + A \cdot B = A$.
5. XOR NO distribuye sobre AND (sentido $\oplus$ sobre $\cdot$); AND SÍ distribuye sobre XOR.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/operadores_universales_nand_nor]] | aplicacion de algebra booleana para igualdades, mismo tipo que demostracion en [[parciales_analizados/1P_2C_2024]] Ej2 y [[parciales_analizados/1P_2C_2024_recuperatorio]] Ej2

---

### Ejercicio 2 — Expresabilidad con algebra de Boole

**Enunciado**

Una formula del algebra de Boole es: variable booleana, constante 1 o 0, o combinacion con OR ($+$), AND ($\cdot$) y negacion ($\overline{\phantom{x}}$).

¿Se pueden expresar todas las funciones totales $f : \{0,1\} \times \{0,1\} \to \{0,1\}$ usando formulas del algebra de Boole? Justificar.

Nota: una funcion total es aquella para la que todo elemento del dominio tiene imagen.

**Explicacion**

Pregunta sobre universalidad del algebra de Boole. La respuesta es Si, mediante el mecanismo de Suma de Productos (SDP): dada cualquier tabla de verdad, se puede construir una formula booleana equivalente tomando el OR de los minterms donde la funcion vale 1.

Conecta directamente con la teoria de SDP en [[logica_combinatoria_teoria]].

**Resolucion paso a paso**

**Respuesta: SÍ.** Toda funcion total $f: \{0,1\}^2 \to \{0,1\}$ es expresable con formulas del algebra de Boole.

**Demostracion constructiva via SDP:**

1. Dado cualquier $f$, construir su tabla de verdad: hay $2^2 = 4$ filas para 2 variables.

2. Identificar las filas donde $f = 1$.

3. Para cada fila $(a, b)$ con $f(a, b) = 1$, construir el mintermino:
$$t_{ab} = l_a \cdot l_b \quad \text{donde } l_v = \begin{cases} v & \text{si el valor de esa variable es } 1 \\ \overline{v} & \text{si el valor de esa variable es } 0 \end{cases}$$

4. La SDP es el OR de todos los minterminos: $F = \bigvee_{(a,b): f(a,b)=1} t_{ab}$

**Casos borde:**
- $f \equiv 1$ (siempre 1): SDP = OR de los 4 minterminos, que simplifica a la constante $1$.
- $f \equiv 0$ (siempre 0): no hay minterminos; la formula es la constante $0$ (valida en el algebra de Boole).

**Generalizacion:** el mismo argumento vale para cualquier numero de variables $n$ y para cualquier funcion $f: \{0,1\}^n \to \{0,1\}$.

**Conclusion:** el algebra de Boole {OR, AND, NOT} es **funcionalmente completo** — permite expresar toda funcion booleana.

**Chuleta**

1. Toda funcion booleana $\to$ SÍ, expresable con OR + AND + NOT.
2. Mecanismo: SDP (Suma de Productos).
3. Pasos: tabla de verdad → identificar filas con $f=1$ → minterminos → OR de todos.
4. Casos borde: $f \equiv 0$ → constante $0$; $f \equiv 1$ → constante $1$.
5. Argumento valido para cualquier numero de variables.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/sdp_y_simplificacion]] | concepto base para el Ej2 de todos los 1P analizados; SDP es el argumento central

---

### Ejercicio 3 — Universalidad de NAND y NOR

**Enunciado**

Determinar la veracidad o falsedad de las siguientes afirmaciones:

a) Sea $p | q = \overline{p \cdot q}$ (NAND). ¿Alcanza este unico operador para representar todas las funciones booleanas?

b) Sea $p \downarrow q = \overline{p + q}$ (NOR). ¿Alcanza este unico operador para representar todas las funciones booleanas?

**Explicacion**

Ambas respuestas son Si (verdadero). La demostracion requiere construir NOT, AND y OR usando solo NAND (o solo NOR) y luego invocar el resultado del Ej 2 (toda funcion es expresable con OR+AND+NOT).

Estrategia tipica:
- NOT con NAND: $\overline{A} = A | A$
- AND con NAND: $A \cdot B = \overline{A|B} = (A|B)|(A|B)$
- OR con NAND: $A + B = \overline{\overline{A} \cdot \overline{B}} = (A|A)|(B|B)$ via De Morgan

Trampa comun: el Ej en el recuperatorio 2C_2024 tenia como afirmacion negativa "no es posible representar NOR con NAND", que es falsa. Ver [[parciales_analizados/1P_2C_2024_recuperatorio]] Ej2.

**Resolucion paso a paso**

**Estrategia general:** para demostrar que un operador $\otimes$ es universal, alcanza con construir NOT, AND y OR usando solo $\otimes$. Por el Ej 2, {NOT, AND, OR} puede expresar cualquier funcion booleana.

---

**a) NAND es universal — VERDADERO**

Construir {NOT, AND, OR} usando solo NAND ($p | q = \overline{p \cdot q}$):

**NOT con NAND:**
$$\overline{A} = A | A = \overline{A \cdot A} = \overline{A} \quad \checkmark$$

**AND con NAND:**
$$A \cdot B = \overline{\overline{A \cdot B}} = \overline{A | B} = (A | B) | (A | B) \quad \checkmark$$
(doble negacion: NAND del NAND)

**OR con NAND** (via De Morgan: $A + B = \overline{\overline{A} \cdot \overline{B}}$):
$$A + B = \overline{\overline{A} \cdot \overline{B}} = \overline{A} | \overline{B} = (A|A) | (B|B) \quad \checkmark$$

Con {NOT, AND, OR} expresables en NAND, y sabiendo que {NOT, AND, OR} es completo → NAND es universal.

---

**b) NOR es universal — VERDADERO**

Construir {NOT, AND, OR} usando solo NOR ($p \downarrow q = \overline{p + q}$):

**NOT con NOR:**
$$\overline{A} = A \downarrow A = \overline{A + A} = \overline{A} \quad \checkmark$$

**OR con NOR:**
$$A + B = \overline{\overline{A + B}} = \overline{A \downarrow B} = (A \downarrow B) \downarrow (A \downarrow B) \quad \checkmark$$

**AND con NOR** (via De Morgan: $A \cdot B = \overline{\overline{A} + \overline{B}}$):
$$A \cdot B = \overline{\overline{A} + \overline{B}} = \overline{A} \downarrow \overline{B} = (A \downarrow A) \downarrow (B \downarrow B) \quad \checkmark$$

Con {NOT, AND, OR} expresables en NOR → NOR es universal.

**Chuleta**

1. Para demostrar universalidad de operador $X$: construir NOT, AND, OR usando solo $X$.
2. NAND: $\overline{A} = A|A$; $A \cdot B = (A|B)|(A|B)$; $A+B = (A|A)|(B|B)$.
3. NOR: $\overline{A} = A \downarrow A$; $A+B = (A \downarrow B) \downarrow (A \downarrow B)$; $A \cdot B = (A \downarrow A) \downarrow (B \downarrow B)$.
4. Por el Ej 2, {NOT, AND, OR} completo → cualquier extension tambien lo es.
5. Corolario: NAND y NOR son intercambiables (se puede expresar cada uno con el otro).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/operadores_universales_nand_nor]] | [[parciales_analizados/1P_2C_2024]] Ej2, [[parciales_analizados/1P_2C_2024_recuperatorio]] Ej2 — patron de alta frecuencia en los parciales historicos rotulados 1P; con el programa vigente entra en tu **parcial unico**

---

### Ejercicio 4 — Dibujar circuitos booleanos

**Enunciado**

Dibujar circuitos que implementen las siguientes funciones booleanas:

a) $f(A, B, C) = A \cdot B \cdot C$ usando 2 compuertas NOR y varias compuertas NOT.

b) $f(A, B) = (A \cdot \overline{B}) + (\overline{B} \cdot A) \cdot B$. ¿Para que valores de A y B la funcion devuelve 1?

c) $f(A, B, C, D) = ((C \downarrow D) \oplus (B + A)) \cdot (((A | B) | C)) + (D \cdot B))$

**Explicacion**

- Inciso a): $A \cdot B \cdot C$ con NOR requiere usar De Morgan. $A \cdot B \cdot C = \overline{\overline{A} + \overline{B} + \overline{C}}$. Con NOR de 2 entradas y NOTs hay que aplicarlo en cascada.
- Inciso b): primero simplificar algebraicamente (la expresion puede colapsar), luego identificar los minterms.
- Inciso c): ejercicio de construccion de circuito compuesto con NAND, NOR, XOR y OR — no requiere simplificacion, solo dibujar segun la formula.

**Diagrama disponible** (`raw/guias_practicas/2.prac_logica_digital_parte_2.pdf`, p.1): inciso a muestra circuito NOR+NOT evaluado (1,1,1→1) y circuito original (0,0,0→0) — confirma ambas implementaciones de $A \cdot B \cdot C$; inciso b evaluado con A=0,B=0; inciso c con A=0,B=1,C=0,D=1 → salida=1.

**Resolucion paso a paso**

**Inciso a) — $A \cdot B \cdot C$ con 2 NOR y NOTs**

Aplicar De Morgan generalizado:
$$A \cdot B \cdot C = \overline{\overline{A} + \overline{B} + \overline{C}}$$

Descomponer en cascada para NOR de 2 entradas:

- Paso 1: calcular NOT A, NOT B, NOT C (3 compuertas NOT)
- Paso 2: $\text{NOR}_1 = \text{NOR}(\overline{A},\ \overline{B}) = \overline{\overline{A} + \overline{B}} = A \cdot B$
- Paso 3: $\text{NOT}(A \cdot B) = \overline{A \cdot B}$ (1 compuerta NOT sobre NOR1)
- Paso 4: $\text{NOR}_2 = \text{NOR}(\overline{A \cdot B},\ \overline{C}) = \overline{\overline{AB} + \overline{C}} = A \cdot B \cdot C$

Circuito:
```
NOT A ─┐
       NOR1 ─── NOT ─┐
NOT B ─┘              NOR2 ─── f = ABC
NOT C ───────────────┘
```

Verificacion con A=1, B=1, C=1:
- NOT A=0, NOT B=0, NOT C=0
- NOR1 = NOR(0,0) = 1; NOT(1) = 0
- NOR2 = NOR(0, 0) = 1 ✓

Compuertas usadas: 4 NOT + 2 NOR.

---

**Inciso b) — simplificacion de $f(A, B) = (A \cdot \overline{B}) + (\overline{B} \cdot A) \cdot B$**

Observar que $A \cdot \overline{B}$ y $\overline{B} \cdot A$ son la misma expresion. Sea $X = A \cdot \overline{B}$:

$$f = X + X \cdot B$$

Aplicar absorcion ($X + X \cdot Y = X$):
$$f = A \cdot \overline{B}$$

La funcion vale 1 unicamente cuando $A = 1$ y $B = 0$.

Circuito: 1 NOT (para $\overline{B}$) + 1 AND (de $A$ y $\overline{B}$).

Verificacion: A=0, B=0 → $0 \cdot 1 = 0$ ✓ (confirma el diagrama).

---

**Inciso c) — circuito directo para $f(A,B,C,D) = ((C \downarrow D) \oplus (B + A)) \cdot (((A | B) | C) + (D \cdot B))$**

No requiere simplificacion. Evaluar la estructura jerarquica de la formula:

- Rama izquierda del AND final:
  - $C \downarrow D = \overline{C + D}$ (NOR)
  - $B + A$ (OR)
  - $(C \downarrow D) \oplus (B + A)$ (XOR de los dos anteriores)
- Rama derecha del AND final:
  - $A | B = \overline{A \cdot B}$ (NAND)
  - $(A|B) | C = \overline{(A|B) \cdot C}$ (NAND del resultado anterior con C)
  - $D \cdot B$ (AND)
  - $((A|B)|C) + (D \cdot B)$ (OR de los dos anteriores)
- Resultado: AND de ambas ramas

Verificacion con A=0, B=1, C=0, D=1:
- $C \downarrow D = \overline{0+1} = 0$
- $B + A = 1$
- $0 \oplus 1 = 1$ (rama izquierda)
- $A|B = \overline{0 \cdot 1} = 1$
- $(A|B)|C = \overline{1 \cdot 0} = 1$
- $D \cdot B = 1$
- $1 + 1 = 1$ (rama derecha)
- $f = 1 \cdot 1 = 1$ ✓

**Chuleta**

1. Para $X \cdot Y \cdot Z$ con NOR: usar De Morgan → $\overline{\overline{X}+\overline{Y}+\overline{Z}}$; descomponer NOR en cascada con NOTs intermedios.
2. Antes de dibujar un circuito, simplificar algebraicamente (buscar absorcion, idempotencia, complemento).
3. Para circuitos compuestos sin simplificacion: evaluar jerarquicamente de adentro hacia afuera.
4. Tip parciales: si el enunciado pide circuito con una compuerta especifica, buscar la identidad De Morgan que transforma el AND/OR a esa compuerta.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/circuito_con_compuerta_especifica]] | [[parciales_analizados/1P_2C_2024]] Ej3 (A·B·C con NOR), [[parciales_analizados/1P_2C_2024_recuperatorio]] Ej3 ((A+B)·C con NAND)

---

### Ejercicio 5 — SDP desde tabla de verdad + simplificacion

**Enunciado**

Dadas las funciones F y G definidas por tablas de verdad:

Tabla para $F(A,B,C)$:

| A | B | C | F |
|---|---|---|---|
| 1 | 1 | 0 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 1 | 1 | 1 |
| 0 | 0 | 0 | 0 |

Tabla para $G(D,E,F)$:

| D | E | F | G |
|---|---|---|---|
| 0 | 0 | 0 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 1 |
| 1 | 1 | 0 | 1 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 1 | 1 |

a) Escribir la suma de productos para ambas funciones. Calcular la cantidad de compuertas que la implementacion literal requeriria en cada caso.

b) ¿Se pueden simplificar las expresiones usando propiedades del algebra booleana? Para cada funcion decidir si es posible y, en caso de que lo sea, dibujar el circuito con la menor cantidad de compuertas.

**Explicacion**

Ejercicio canonico de SDP + simplificacion algebraica. Patron clave de los parciales historicos rotulados 1P; con el programa vigente entra en tu **parcial unico**.

- Fase 1: identificar minterms (filas con F=1), escribir el AND de cada minterm, luego el OR de todos.
- Fase 2: aplicar propiedades (idempotencia, absorcion, De Morgan) para reducir el numero de compuertas.
- Contar compuertas: cada minterm de k variables = k−1 compuertas AND, mas 1 por los NOT de variables negadas, mas 1 compuerta OR para unirlos.

**Diagrama disponible** (`raw/guias_practicas/2.prac_logica_digital_parte_2.pdf`, p.1): circuito G(D,E,F) evaluado con D=1, E=0, F=1 → G=0.

**Resolucion paso a paso**

**Parte a) — SDP literal**

**F(A,B,C):** filas con F=1:

| A | B | C | Mintermino |
|---|---|---|---|
| 1 | 0 | 0 | $A \cdot \overline{B} \cdot \overline{C}$ |
| 1 | 0 | 1 | $A \cdot \overline{B} \cdot C$ |
| 0 | 1 | 1 | $\overline{A} \cdot B \cdot C$ |
| 1 | 1 | 1 | $A \cdot B \cdot C$ |

$$F = A\overline{B}\overline{C} + A\overline{B}C + \overline{A}BC + ABC$$

Conteo de compuertas (implementacion literal):
- 4 minterminos × 2 AND (para 3 entradas con AND de 2 entradas) = **8 AND**
- NOT por variable negada: NOT A, NOT B, NOT C = **3 NOT**
- OR final para 4 minterminos (arbol binario): **3 OR**
- **Total: 14 compuertas**

---

**G(D,E,F):** filas con G=1:

| D | E | F | Mintermino |
|---|---|---|---|
| 0 | 0 | 0 | $\overline{D} \cdot \overline{E} \cdot \overline{F}$ |
| 0 | 0 | 1 | $\overline{D} \cdot \overline{E} \cdot F$ |
| 0 | 1 | 1 | $\overline{D} \cdot E \cdot F$ |
| 1 | 0 | 0 | $D \cdot \overline{E} \cdot \overline{F}$ |
| 1 | 1 | 0 | $D \cdot E \cdot \overline{F}$ |
| 1 | 1 | 1 | $D \cdot E \cdot F$ |

$$G = \overline{D}\overline{E}\overline{F} + \overline{D}\overline{E}F + \overline{D}EF + D\overline{E}\overline{F} + DE\overline{F} + DEF$$

Conteo de compuertas (implementacion literal):
- 6 minterminos × 2 AND = **12 AND**
- NOT D, NOT E, NOT F = **3 NOT**
- OR final para 6 minterminos (arbol): **5 OR**
- **Total: 20 compuertas**

---

**Parte b) — Simplificacion algebraica**

**Simplificacion de F:**

Agrupar por factor comun:

$$F = A\overline{B}(\overline{C} + C) + BC(\overline{A} + A)$$
$$= A\overline{B} \cdot 1 + BC \cdot 1$$
$$\boxed{F = A\overline{B} + BC}$$

Compuertas simplificadas:
- 1 NOT (para $\overline{B}$)
- AND($A$, $\overline{B}$): 1 AND
- AND($B$, $C$): 1 AND
- OR de los dos terminos: 1 OR
- **Total: 4 compuertas** (reduccion de 14 → 4)

---

**Simplificacion de G:**

Agrupar:

Grupo 1: $\overline{D}\overline{E}\overline{F} + \overline{D}\overline{E}F = \overline{D}\overline{E}(\overline{F} + F) = \overline{D}\overline{E}$

Grupo 2: $D\overline{E}\overline{F} + DE\overline{F} = D\overline{F}(\overline{E} + E) = D\overline{F}$

Grupo 3: $\overline{D}EF + DEF = EF(\overline{D} + D) = EF$

$$\boxed{G = \overline{D}\overline{E} + D\overline{F} + EF}$$

Compuertas simplificadas:
- 3 NOT (para $\overline{D}$, $\overline{E}$, $\overline{F}$)
- AND($\overline{D}$, $\overline{E}$): 1 AND
- AND($D$, $\overline{F}$): 1 AND
- AND($E$, $F$): 1 AND
- OR de tres terminos: 2 OR (arbol)
- **Total: 8 compuertas** (reduccion de 20 → 8)

Verificacion: $G(1,0,1) = \overline{1}\cdot\overline{0} + 1\cdot\overline{1} + 0\cdot1 = 0 + 0 + 0 = 0$ ✓ (el diagrama confirma D=1,E=0,F=1→G=0).

**Chuleta**

1. SDP: identificar filas con salida 1 → mintermino = AND de todas las variables (negada si vale 0) → OR de todos los minterminos.
2. Contar compuertas literal: $m$ minterminos de $k$ variables → $m(k-1)$ AND + $k$ NOT + $(m-1)$ OR.
3. Simplificar: buscar pares/grupos que difieran en una sola variable ($X\overline{Y} + XY = X$), factorizar comun.
4. Verificar la simplificacion evaluando la formula original y la simplificada con el mismo punto de prueba.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/sdp_y_simplificacion]] | [[tipos_ejercicio/circuito_con_compuerta_especifica]] | [[parciales_analizados/1P_1C_2025]] Ej2 (SDP F(A,B,C) + simplificacion hasta NOR+AND+OR)

---

### Ejercicio 6 — Inversor k-bits con control

**Enunciado**

Armar un circuito que invierta o no tres entradas de acuerdo al valor de una entrada adicional de control.

Un inversor de k-bits es un circuito de $k+1$ entradas $(e_k, \ldots, e_0)$ y $k$ salidas $(s_{k-1}, \ldots, s_0)$:

$$s_i = \overline{e_i} \quad \text{si } e_k = 1 \quad \forall i < k$$
$$s_i = e_i \quad \text{si } e_k = 0 \quad \forall i < k$$

Ejemplos:
```
inversor(1, 011) = 100
inversor(0, 011) = 011
inversor(1, 100) = 011
inversor(1, 101) = 010
```

**Explicacion**

El circuito realiza un XOR bit a bit entre cada entrada $e_i$ y el bit de control $e_k$:

$$s_i = e_i \oplus e_k$$

Cuando $e_k = 0$: $s_i = e_i \oplus 0 = e_i$ (pasa igual).
Cuando $e_k = 1$: $s_i = e_i \oplus 1 = \overline{e_i}$ (invierte).

El circuito usa k compuertas XOR, una por bit, con el control conectado a todos. Este patron se usa en el inverso aditivo en C2 (NOT + 1).

**Diagrama disponible** (`raw/guias_practicas/2.prac_logica_digital_parte_2.pdf`, p.1): 3 compuertas XOR, cada una conecta $e_i$ con el bit de control. Evaluado: control=1, bits_entrada=[1,0,0] (MSB a LSB) → salidas=[0,1,1] (inversion bitwise confirmada).

**Resolucion paso a paso**

**Formula para cada salida ($k=3$):**

$$s_i = e_i \oplus e_3 \quad \text{para } i \in \{0, 1, 2\}$$

**Justificacion:** la identidad $A \oplus 1 = \overline{A}$ y $A \oplus 0 = A$ hace que XOR con el bit de control actue como inversor condicional.

**Circuito (k=3): 4 entradas, 3 salidas, 3 compuertas XOR**

```
e3 (control) ─┬─────────────┬─────────────┬───
              │             │             │
e2 ──────── XOR ── s2    e1 ─ XOR ── s1   e0 ─ XOR ── s0
```

Las tres XOR son identicas e independientes — el control $e_3$ se conecta en paralelo a todas.

**Verificacion de ejemplos:**

| inversor | $e_3$ | $e_2,e_1,e_0$ | $s_2,s_1,s_0$ | esperado |
|---|---|---|---|---|
| (1, 011) | 1 | 0,1,1 | $0\oplus1, 1\oplus1, 1\oplus1$ = 1,0,0 | 100 ✓ |
| (0, 011) | 0 | 0,1,1 | $0\oplus0, 1\oplus0, 1\oplus0$ = 0,1,1 | 011 ✓ |
| (1, 100) | 1 | 1,0,0 | $1\oplus1, 0\oplus1, 0\oplus1$ = 0,1,1 | 011 ✓ |
| (1, 101) | 1 | 1,0,1 | $1\oplus1, 0\oplus1, 1\oplus1$ = 0,1,0 | 010 ✓ |

**Compuertas: 3 XOR** (una por bit de datos).

**Chuleta**

1. Inversor controlado de k bits: $k$ compuertas XOR, todas con $e_k$ (control) como segunda entrada.
2. Formula: $s_i = e_i \oplus e_k$.
3. Propiedad XOR: $A \oplus 0 = A$ (pasa igual); $A \oplus 1 = \overline{A}$ (invierte).
4. Patron reutilizable: base del inverso aditivo en C2 (etapa de NOT bitwise antes de sumar 1).

**¿Aparece en parciales?** ⚪ No — concepto auxiliar, no vi este circuito especifico en parciales analizados

---

### Ejercicio 7 — Inverso aditivo en C2 con deteccion de overflow

**Enunciado**

a) Disenar un componente con 4 entradas $e_0, \ldots, e_3$ y 4 salidas $s_0, \ldots, s_3$ que calcule el inverso aditivo del numero codificado en complemento a 2 por la entrada.

b) Modificar el circuito anterior para que en una nueva salida indique si el numero de la entrada no tiene un inverso aditivo representable con 4 bits en complemento a 2.

**Explicacion**

- Inciso a): el inverso aditivo en C2 es $\sim n + 1$ (NOT bit a bit + 1). El circuito combina el inversor del Ej 6 con un sumador de 1 bit. Ver [[temas/representacion_de_informacion_guia]] Ej11.
- Inciso b): el unico numero sin inverso representable en C2 de 4 bits es $-8$ (el minimo, `1000`). Su "inverso" seria $+8$, que no entra en 4 bits. La condicion de overflow: entrada = `1000` (todos los bits menos el MSB en 0 y MSB=1).

**Resolucion paso a paso**

**Inciso a) — circuito para inverso aditivo en C2 de 4 bits**

El inverso aditivo en complemento a 2 se calcula como:
$$-n = \overline{n} + 1 \pmod{2^4}$$

**Implementacion:**

1. Etapa 1 — NOT bitwise (inversor fijo, control=1):
   $$n'_i = \overline{e_i} \quad \forall i \in \{0,1,2,3\}$$
   Usa 4 compuertas NOT (equivalente al Ej 6 con $e_k = 1$ fijo).

2. Etapa 2 — sumar 1 (sumador ripple carry de 4 bits con $C_{in} = 1$, segundo operando = 0000):

   Por cada bit $i$ (Full Adder con $B_i = 0$):
   $$S_i = n'_i \oplus 0 \oplus C_i = n'_i \oplus C_i$$
   $$C_{i+1} = (n'_i \cdot 0) + (C_i \cdot (n'_i \oplus 0)) = C_i \cdot n'_i$$

   Con $C_0 = 1$:
   - $s_0 = n'_0 \oplus 1 = \overline{n'_0} = e_0$; $C_1 = n'_0 \cdot 1 = n'_0 = \overline{e_0}$
   - $s_1 = n'_1 \oplus C_1$; $C_2 = n'_1 \cdot C_1$
   - $s_2 = n'_2 \oplus C_2$; $C_3 = n'_2 \cdot C_2$
   - $s_3 = n'_3 \oplus C_3$

   El carry se propaga hasta que encuentra el primer $n'_i = 0$ (es decir, el primer $e_i = 1$).

**Componentes:** 4 NOT + 4 XOR (para $S_i$) + 3 AND (para carries $C_1, C_2, C_3$) = 11 compuertas.

Verificacion: $-3$ en C2 de 4 bits. $3 = 0011$, NOT = $1100$, $+1 = 1101 = -3$ en C2 ✓.

---

**Inciso b) — deteccion de overflow**

En C2 de 4 bits, el rango es $[-8, +7]$. El unico numero sin inverso representable es $-8 = \mathtt{1000}_2$, porque $-(-8) = +8$ requiere 5 bits.

Condicion de overflow (entrada es exactamente `1000`):
$$\text{overflow} = e_3 \cdot \overline{e_2} \cdot \overline{e_1} \cdot \overline{e_0}$$

El MSB es 1 ($e_3 = 1$) y todos los demas bits son 0.

**Implementacion de la salida de overflow:**
- Los NOT $\overline{e_2}, \overline{e_1}, \overline{e_0}$ ya existen de la etapa 1.
- AND de cuatro terminos: AND($e_3$, $\overline{e_2}$, $\overline{e_1}$, $\overline{e_0}$) → 3 AND de 2 entradas en cascada.

Verificacion: $e = 1000 \Rightarrow e_3=1, \overline{e_2}=1, \overline{e_1}=1, \overline{e_0}=1 \Rightarrow \text{overflow}=1$ ✓

**Chuleta**

1. Inverso aditivo C2: $-n = \overline{n} + 1$ → NOT de todos los bits + sumador ripple carry con $C_{in}=1$.
2. Circuito: 4 NOT + 4 XOR (sumas) + 3 AND (carries).
3. Overflow: unico numero sin inverso = minimo negativo = $\mathtt{1000\ldots0}_2$ (MSB=1, resto=0).
4. Deteccion de overflow: $e_{n-1} \cdot \overline{e_{n-2}} \cdots \overline{e_0}$ — AND del MSB con los NOT de todos los demas bits.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/carry_y_overflow]] | inverso aditivo en parciales 1P (ver [[parciales_analizados/1P_2C_2024]] Ej1, [[temas/representacion_de_informacion_guia]] Ej11)

---

### Ejercicio 8 — Demultiplexor 4 salidas

**Enunciado**

Dibujar el diagrama logico de un demultiplexor de 2 lineas de control, 1 linea de entrada y 4 lineas de salida. El circuito dirige la unica linea de entrada a una de cuatro lineas de salida segun las dos lineas de control:

| $c_1$ | $c_0$ | salida activa |
|-------|-------|---------------|
| 0 | 0 | $s_0 = e_0$, $s_i = 0$ si $i \neq 0$ |
| 0 | 1 | $s_1 = e_0$, $s_i = 0$ si $i \neq 1$ |
| 1 | 0 | $s_2 = e_0$, $s_i = 0$ si $i \neq 2$ |
| 1 | 1 | $s_3 = e_0$, $s_i = 0$ si $i \neq 3$ |

**Explicacion**

Cada salida $s_i$ se activa solo cuando la combinacion de control selecciona esa salida:

$$s_0 = e_0 \cdot \overline{c_1} \cdot \overline{c_0}$$
$$s_1 = e_0 \cdot \overline{c_1} \cdot c_0$$
$$s_2 = e_0 \cdot c_1 \cdot \overline{c_0}$$
$$s_3 = e_0 \cdot c_1 \cdot c_0$$

El circuito usa 4 compuertas AND de 3 entradas (o compuestas) y los NOTs de los bits de control.

El Ej 10b pide reescribir este DEMUX usando el decodificador del Ej 10a.

**Diagrama disponible** (`raw/guias_practicas/2.prac_logica_digital_parte_2.pdf`, p.1): 2 NOT (para $\overline{c_1}$, $\overline{c_2}$) + 4 AND de 3 entradas. Evaluado: c1=1, c2=1, entrada=1 → s0=0, s1=0, s2=0, s3=1.

**Resolucion paso a paso**

**Derivacion de las formulas por SDP:**

Para $s_0$: activa cuando $c_1=0, c_0=0$ → mintermino $\overline{c_1} \cdot \overline{c_0}$; AND con $e_0$ (la entrada se habilita).
Para $s_1$: activa cuando $c_1=0, c_0=1$ → $\overline{c_1} \cdot c_0$; AND con $e_0$.
Para $s_2$: activa cuando $c_1=1, c_0=0$ → $c_1 \cdot \overline{c_0}$; AND con $e_0$.
Para $s_3$: activa cuando $c_1=1, c_0=1$ → $c_1 \cdot c_0$; AND con $e_0$.

**Circuito optimizado** (compartiendo nodos intermedios):

```
e0 ───────┬────────────────────────────────────
          │
c1 ── NOT($\overline{c_1}$) ─┬── AND(e0, $\overline{c_1}$) ─┬── AND($\cdot$, $\overline{c_0}$) ─ s0
                             │                               └── AND($\cdot$, $c_0$) ── s1
c0 ── NOT($\overline{c_0}$) ─┴── AND(e0, $c_1$) ────┬── AND($\cdot$, $\overline{c_0}$) ─ s2
                                                     └── AND($\cdot$, $c_0$) ── s3
```

Nodos intermedios: $P = e_0 \cdot \overline{c_1}$ (usado por $s_0$ y $s_1$) y $Q = e_0 \cdot c_1$ (usado por $s_2$ y $s_3$).

Compuertas: 2 NOT + 2 AND (nodos P, Q) + 4 AND (salidas) = **2 NOT + 6 AND**

**Verificacion:** $c_1=1, c_0=1, e_0=1$:
- $\overline{c_1}=0$, $\overline{c_0}=0$
- $P = 1 \cdot 0 = 0$, $Q = 1 \cdot 1 = 1$
- $s_0 = 0 \cdot 0 = 0$, $s_1 = 0 \cdot 1 = 0$
- $s_2 = 1 \cdot 0 = 0$, $s_3 = 1 \cdot 1 = 1$ ✓

**Chuleta**

1. DEMUX de $2^n$ salidas: decodificar las $n$ lineas de control (minterminos) y AND cada resultado con la entrada $e_0$.
2. Para 2 lineas de control: 2 NOT + 4 AND de 2 entradas en paralelo (o 6 AND optimizando nodos comunes).
3. Cada salida $s_i$ = mintermino$_i(c_1, c_0) \cdot e_0$.
4. Relacion clave: DEMUX = decodificador con $e_0$ como habilitador (ver Ej 10b).

**¿Aparece en parciales?** ⚪ No — circuito estandar, no detectado en los parciales analizados

---

### Ejercicio 9 — Codificador 4→2 con salida de validez

**Enunciado**

a) Dibujar el diagrama logico de un codificador de 4 lineas de entrada ($e_i$) y 2 lineas de salida ($s_i$). Si unicamente $e_i$ esta alta, las salidas representan el numero $i$ en notacion sin signo. No esta definido el resultado si no se cumple que exactamente una entrada vale 1.

b) Dotar al circuito anterior de una salida adicional que indique si el estado de la entrada es valido o invalido.

**Explicacion**

- Inciso a): derivar $s_1, s_0$ en funcion de $e_0, e_1, e_2, e_3$:
  - $s_1 = e_2 + e_3$ (bit alto del numero de entrada activa)
  - $s_0 = e_1 + e_3$ (bit bajo)
- Inciso b): la entrada es valida si exactamente una de las cuatro esta activa. La salida de validez = OR de todos los ei XOR si-mas-de-uno-activo. Simplificacion: $valido = e_0 \oplus e_1 \oplus e_2 \oplus e_3$ no es suficiente — se necesita verificar "exactamente uno" con AND-de-pares-negados o con circuito de paridad especifico.

**Diagrama disponible** (`raw/guias_practicas/2.prac_logica_digital_parte_2.pdf`, p.1-2): version basica usa 2 OR ($s_1 = e_2 + e_3$, $s_0 = e_1 + e_3$); version con validez agrega logica adicional para senal "valido". Evaluado: e2=1 activo (resto=0) → s1=1, s0=0, valido=1.

**Resolucion paso a paso**

**Inciso a) — codificador basico 4→2**

Tabla de verdad (exactamente una entrada activa — condicion one-hot):

| $e_3$ | $e_2$ | $e_1$ | $e_0$ | $s_1$ | $s_0$ | numero |
|---|---|---|---|---|---|---|
| 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 | 1 | 0 | 2 |
| 1 | 0 | 0 | 0 | 1 | 1 | 3 |

Derivando por SDP (o por inspeccion):
- $s_1 = e_2 + e_3$ (vale 1 cuando la entrada activa es 2 o 3)
- $s_0 = e_1 + e_3$ (vale 1 cuando la entrada activa es 1 o 3)

**Circuito:** 2 compuertas OR.

Verificacion: $e_2 = 1$ (resto = 0) → $s_1 = 0 + 1 = 1$, $s_0 = 0 + 0 = 0$ → numero $10_2 = 2$ ✓

---

**Inciso b) — salida de validez**

La entrada es valida si **exactamente una** $e_i$ vale 1.

Condicion "al menos una activa":
$$V_{\geq 1} = e_0 + e_1 + e_2 + e_3$$

Condicion "mas de una activa" (algun par simultaneo):
$$V_{>1} = e_0 e_1 + e_0 e_2 + e_0 e_3 + e_1 e_2 + e_1 e_3 + e_2 e_3$$

Condicion de validez:
$$\text{valido} = V_{\geq 1} \cdot \overline{V_{>1}}$$

**Implementacion simplificada** (practica en parciales, confirmada por el diagrama):

Para 4 entradas, la senal de validez se puede implementar como:

$$\text{valido} = (e_0 + e_1 + e_2 + e_3) \cdot \overline{e_0 e_1} \cdot \overline{e_0 e_2} \cdot \overline{e_0 e_3} \cdot \overline{e_1 e_2} \cdot \overline{e_1 e_3} \cdot \overline{e_2 e_3}$$

O equivalentemente usando la propiedad de que "exactamente uno" puede verificarse con:
- Un OR para "alguna activa"
- Un NOR de pares para "ningun par activo simultaneamente"

Componentes adicionales: 1 OR de 4 entradas + 6 NAND (pares) + AND final.

⚠️ Verificar — la implementacion exacta de la senal de validez depende del diagrama del PDF; la formula conceptual es correcta pero la implementacion circuital puede diferir en simplificacion.

Verificacion: $e_2=1$, resto=0: $V_{\geq 1}=1$, ningun par activo → $V_{>1}=0$ → $\text{valido} = 1 \cdot 1 = 1$ ✓

**Chuleta**

1. Codificador $2^n \to n$: derivar cada bit de salida por SDP de las entradas que lo activan.
2. Para 4→2: $s_1 = e_2 + e_3$; $s_0 = e_1 + e_3$.
3. Circuito basico: 2 OR solamente.
4. Salida de validez: OR de todas las entradas (al menos una) AND NOT de todos los pares (ninguna colision).

**¿Aparece en parciales?** ⚪ No — circuito estandar, no detectado en los parciales analizados

---

### Ejercicio 10 — Decodificador 2→4 + DEMUX con decodificador

**Enunciado**

a) Dibujar con compuertas logicas el circuito de un decodificador de 2 lineas de entrada ($e_i$) y 4 lineas de salida ($s_i$):

| $e_1$ | $e_0$ | $s_3$ | $s_2$ | $s_1$ | $s_0$ |
|-------|-------|-------|-------|-------|-------|
| 0 | 0 | 0 | 0 | 0 | 1 |
| 0 | 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 0 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 | 0 | 0 |

b) Usando el circuito anterior, reescribir el demultiplexor de 1 linea de entrada, 2 lineas de control y 4 lineas de salida.

**Explicacion**

- Inciso a): el decodificador activa exactamente la salida $s_i$ correspondiente a la combinacion de entradas. Formulas:
  $$s_0 = \overline{e_1} \cdot \overline{e_0}, \quad s_1 = \overline{e_1} \cdot e_0, \quad s_2 = e_1 \cdot \overline{e_0}, \quad s_3 = e_1 \cdot e_0$$
- Inciso b): el DEMUX del Ej 8 = decodificador para el control + un AND por salida con la entrada $e_0$: $s_i = \text{dec}_{i}(c_1, c_0) \cdot e_0$. Esto muestra la dualidad DEMUX–decodificador.

**Diagrama disponible** (`raw/guias_practicas/2.prac_logica_digital_parte_2.pdf`, p.2): 2 NOT + 4 AND de 2 entradas (una por salida). Evaluado: e1=1, e0=1 → s0=0, s1=0, s2=0, s3=1 (selecciona $s_{e_1 e_0} = s_{11_2} = s_3$).

**Resolucion paso a paso**

**Inciso a) — decodificador 2→4**

Cada salida es el mintermino de las entradas que corresponde a su indice (en binario):

$$s_0 = \overline{e_1} \cdot \overline{e_0} \quad (00_2 = 0)$$
$$s_1 = \overline{e_1} \cdot e_0 \quad (01_2 = 1)$$
$$s_2 = e_1 \cdot \overline{e_0} \quad (10_2 = 2)$$
$$s_3 = e_1 \cdot e_0 \quad (11_2 = 3)$$

**Circuito:**

```
e1 ─┬── NOT($\overline{e_1}$) ─┬── AND($\overline{e_1}$, $\overline{e_0}$) ── s0
    │                         └── AND($\overline{e_1}$, $e_0$) ─── s1
    ├─────────────────────────┬── AND($e_1$, $\overline{e_0}$) ───── s2
e0 ─┬── NOT($\overline{e_0}$) ─┘   
    └─────────────────────────── AND($e_1$, $e_0$) ─────── s3
```

Componentes: **2 NOT + 4 AND** de 2 entradas.

Verificacion: $e_1=1, e_0=1$: $\overline{e_1}=0, \overline{e_0}=0$
- $s_0 = 0 \cdot 0 = 0$, $s_1 = 0 \cdot 1 = 0$, $s_2 = 1 \cdot 0 = 0$, $s_3 = 1 \cdot 1 = 1$ ✓

---

**Inciso b) — DEMUX construido con decodificador**

El DEMUX del Ej 8 puede reescribirse como:
$$s_i = \text{dec}_i(c_1, c_0) \cdot e_0 \quad \forall i \in \{0, 1, 2, 3\}$$

donde $\text{dec}_i$ es la i-esima salida del decodificador 2→4 con entradas $c_1, c_0$.

**Construccion:**
1. Conectar las 2 lineas de control ($c_1, c_0$) a las entradas ($e_1, e_0$) del decodificador.
2. Agregar 4 compuertas AND adicionales: AND($\text{dec}_i$, $e_0$) para cada salida $s_i$.

Compuertas totales del DEMUX: 2 NOT + 4 AND (decodificador) + 4 AND (habilitador por $e_0$) = **2 NOT + 8 AND**

**Dualidad DEMUX–decodificador:**
- Decodificador: selecciona cual salida se activa segun las entradas de control.
- DEMUX: igual que un decodificador pero con la senal de datos $e_0$ como habilitador — cada salida del decodificador se AND-ea con $e_0$.
- Cuando $e_0=1$: el DEMUX se comporta exactamente como un decodificador.
- Cuando $e_0=0$: todas las salidas del DEMUX son 0 independientemente del control.

**Chuleta**

1. Decodificador $n \to 2^n$: cada salida es el mintermino de las entradas correspondiente a su indice.
2. Para 2→4: 2 NOT + 4 AND de 2 entradas.
3. DEMUX = decodificador + AND de cada salida con la linea de datos.
4. Relacion: $s_i^{DEMUX} = \text{dec}_i(control) \cdot e_0$ — el dato $e_0$ es el "habilitador" del decodificador.

**¿Aparece en parciales?** ⚪ No — circuito estandar, no detectado en los parciales analizados

---

## Ver tambien

- [[logica_combinatoria_teoria]] — fundamentos algebraicos (De Morgan, SDP, circuitos estandar)
- [[logica_secuencial_guia]] — ejercicios de la misma guia (circuitos secuenciales, Ej 11–19)
- [[temas/representacion_de_informacion_guia]] — Ej 11 (inverso aditivo C2), Ej 9 (flags ALU)
- [[parciales_analizados/1P_2C_2024]] — Ej2 (NAND/NOR), Ej3 (circuito NOR), Ej4 (registro bidireccional)
- [[parciales_analizados/1P_1C_2025]] — Ej2 (SDP + simplificacion)
