---
nombre: Introducción a grafos — guía priorizada de entrenamiento
tipo: material_de_estudio
origen: "@raw/cursada_2C_2026/guias/guia_2_intro_grafos.pdf"
tipo_documento: guia
temas: [grafos, arboles, definiciones_y_demostraciones]
parcial: 1P
programa: 2C_2026
generado: 2026-09-01
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 13
ingestado: false
---
2
# Introducción a grafos — guía priorizada de entrenamiento

**Fuente:** `raw/cursada_2C_2026/guias/guia_2_intro_grafos.pdf` · **Temas:** `grafos`, `arboles` y `definiciones_y_demostraciones` → **1P** (programa `2C_2026`)

La guía entrena definiciones, contraejemplos y demostraciones estructurales sobre grafos y
 digrafos. El programa vigente ubica grafos y árboles en el 1P; las técnicas de demostración son
transversales a ambos parciales. Las estrellas de la guía indican el subconjunto mínimo de la
cátedra, pero **no son evidencia histórica de frecuencia**: la prioridad de este documento se
decidió cruzando las unidades con `wiki/tipos_ejercicio/` y los parciales analizados.

## Qué busca entrenar la guía

- Traducir definiciones de grafos, digrafos, caminos, ciclos, subgrafos, conexidad y árboles en argumentos formales.
- Elegir entre demostración directa, contrarrecíproco, reducción al absurdo, inducción y construcción explícita.
- Detectar el error de una inducción que demuestra una propiedad para una subfamilia, pero no para todos los objetos de la hipótesis.
- Usar cotas de aristas, grados y componentes para probar conexidad, biconexidad o existencia de triángulos.
- Reconocer cuándo una condición caracteriza un árbol y cuándo solo da información parcial.
- Construir ciclos o particiones a partir de caminos y componentes conexas.
- Separar propiedades invariantes de un grafo de las que dependen de una representación o de una elección de recorrido.

## Plan de trabajo

### Nivel 1 — adquirir la técnica

- **Ej. 2** — refutar una inducción defectuosa con un contraejemplo y localizar la frase falsa.
- **Ej. 4** — inducción sobre aristas para el Handshaking Lemma.
- **Ej. 5** — versión dirigida del balance entre grados de entrada y salida.
- **Ej. 6** — reducción al absurdo con la secuencia de grados.
- **Ej. 8** — construcción y unicidad del torneo transitivo.

### Nivel 2 — consolidar

- **Ej. 3** — distinguir las condiciones suficientes para que un grafo sea árbol.
- **Ej. 7** — demostrar una cota extremal para conexidad.
- **Ej. 9** — construir un ciclo a partir de dos caminos distintos.
- **Ej. 10** — probar una caracterización mediante particiones de los vértices.
- **Ej. 11** — combinar la cota de conexidad con el análisis de un punto de articulación.
- **Ej. 12** — inducción sobre vértices para hallar dos vértices no articulación.

### Nivel 3 — dificultad de parcial

- **Ej. 13** — usar el contrarrecíproco y fabricar un camino más largo.
- **Ej. 14** — componer unión, junta y complemento mediante dos implicaciones.
- **Ej. 16** — demostrar por inducción la cota de Mantel para triángulos.
- **Ej. 17** — probar la caracterización “bipartito o ciclo impar”.

### Variantes opcionales

- **Ej. 1** — hallar explícitamente el isomorfismo de los dibujos y justificarlo mediante invariantes.
- **Ej. 15** — analizar la consigna: la construcción escrita como unión disjunta es inconsistente con la conclusión.
- Rehacer los ejercicios 4, 5 y 6 cambiando la inducción por una demostración directa basada en el conteo de incidencias, y explicar qué técnica pide la consigna original.

> **Separación importante:** esta guía no cubre el tema `recorrido_en_grafos` (BFS/DFS), que también
> pertenece al 1P. Para ese bloque hay que trabajar con [[recorrido_en_grafos_guia]] y el patrón
> [[tipos_ejercicio/bfs_dfs_propiedades]].

## Selección rápida

| Ejercicio | Prioridad | Habilidad | Dependencia | Motivo |
|---|---|---|---|---|
| 1 | 🟡 | Isomorfismo e invariantes | grado, adyacencia | Material vigente; no hay patrón compilado específico |
| 2 | 🔴 | Contraejemplo y error de inducción | cuantificadores, inducción | Núcleo del patrón recurrente de demostraciones sobre grafos |
| 3 | 🔴 | Caracterizar árboles | árbol, grados, conexidad, ciclos | Variante directa de condiciones para árbol evaluada en `2P_2C_2025` |
| 4 | 🟡 | Inducción en cantidad de aristas | grado, arista incidente | Técnica base y variante del patrón de demostraciones |
| 5 | 🟡 | Grados de entrada/salida | digrafo, inducción | Generalización dirigida del conteo de grados |
| 6 | 🟡 | Absurdo y principio del palomar | rango posible de grados | Variante del patrón de propiedades de grafos |
| 7 | 🟡 | Cota extremal de conexidad | componentes, $K_n$ | Contenido vigente sin aparición específica compilada |
| 8 | 🟡 | Construcción + unicidad | torneo, grados de salida | Variante de orientaciones acíclicas evaluadas |
| 9 | 🟡 | Ciclo por dos caminos | camino, ciclo simple | Variante adyacente a ciclos construidos en parciales |
| 10 | 🟡 | Partición y conexidad | componentes, caminos | Contenido vigente; entrena una equivalencia estructural |
| 11 | 🟡 | Cota de biconexidad | punto de articulación, componentes | Contenido vigente; requiere combinar dos cotas |
| 12 | 🟡 | Inducción sobre vértices | articulación, componentes | Contenido vigente; prueba estructural de dificultad alta |
| 13 | 🟡 | Contrarrecíproco y caminos máximos | conexidad, longitud | Contenido vigente; la construcción debe ser explícita |
| 14 | 🟡 | Unión, junta y complemento | subgrafo, complemento | Variante de propiedades de grafos evaluadas |
| 15 | 🟡 | Auditar una afirmación inductiva | grados, unión disjunta | La consigna, tal como está escrita, produce un contraejemplo |
| 16 | 🟡 | Cota de Mantel por inducción | Handshaking, ciclos, vecinos | Contenido vigente sin patrón específico compilado |
| 17 | 🟡 | Bipartición y ciclos impares | bipartito, ciclo | Variante adyacente evaluada en `2P_1C_2025` |

---

## 🔴 Ejercicio 2 — Estamos todos conectados

### Enunciado

Federico afirma que todo grafo de $n\geq 2$ vértices cuyos grados son todos al menos $1$ es conexo
y ofrece una demostración por inducción. Hay que: (a) dar un contraejemplo; (b) localizar el error;
(c) analizar una versión “más rigurosa”; (d) analizar una versión que elimina un vértice arbitrario.

### Qué tenés que producir

Un contraejemplo concreto y una auditoría de cada paso inductivo: indicar qué familia de grafos
cubre realmente el paso y qué hipótesis se pierde al pasar al subgrafo.

### Conocimiento que presupone

Cuantificadores sobre grafos, conexidad, grado, inducción y diferencia entre “construir algunos
objetos” y “tomar un objeto arbitrario que satisface la hipótesis”.

### Pista de reconocimiento

Cuando una inducción sobre grafos dice “agreguemos un vértice”, preguntá si todo grafo del tamaño
siguiente puede obtenerse de esa manera preservando la hipótesis. Si no, el paso puede probar una
propiedad de una subfamilia, no el predicado universal $P(n+1)$.

### Plan de resolución

1. Refutar primero la afirmación con el grafo más pequeño posible.
2. Escribir el predicado universal $P(n)$.
3. Comparar la cuantificación de $P(n+1)$ con el objeto que usa el paso inductivo.
4. Revisar separadamente la versión que elimina un vértice: quitarlo puede bajar a cero los grados de sus vecinos.

### Resolución paso a paso

1. **Contraejemplo.** Tomar $G=K_2\cup K_2$. Tiene cuatro vértices, todos de grado $1$, pero sus dos componentes no están conectadas.
   - **Por qué:** satisface la hipótesis de grados positivos y viola la conclusión de conexidad.
2. **Error en la primera prueba.** El paso agrega un vértice a un grafo conexo y le agrega una arista hacia el grafo anterior.
   - **Por qué:** eso demuestra, como mucho, que los grafos construidos mediante esa operación son conexos. No demuestra que un grafo arbitrario de $n$ vértices con grados positivos haya sido construido así.
3. **La versión (c) sigue siendo falsa como inducción.** Su paso vuelve a elegir un grafo $G$ de $n$ vértices que ya es conexo, agrega un vértice $v$ y una arista. Eso prueba la propiedad para ese crecimiento controlado, pero no para todo grafo de $n+1$ vértices con grados positivos. El contraejemplo $K_2\cup K_2$ no aparece entre esas construcciones.
4. **Error exacto en (d).** La frase “el grafo $G-v$ tiene $n$ vértices y los grados de todos sus vértices son por lo menos $1$” es falsa. Si $v$ es un punto de articulación, sus vecinos pueden quedar aislados al quitarlo. Por ejemplo, en el camino $a-v-b$, al quitar $v$ quedan $a$ y $b$ con grado $0$.
5. El hecho de que $v$ tenga un vecino $w$ no arregla el problema: solo conecta $v$ con una componente, mientras que $G-v$ puede tener varias componentes y la hipótesis inductiva puede no ser aplicable.

### Control del resultado

El contraejemplo debe tener todos los grados positivos y ser disconexo. La auditoría debe citar una
frase cuyo antecedente no está justificado, no limitarse a decir “la inducción está mal”.

### Si te trabás

1. Dibujá dos aristas separadas: cada extremo tiene grado $1$.
2. Escribí “$P(n+1)$ habla de todo grafo, pero la prueba construye uno particular”.
3. Para (d), dibujá un camino de tres vértices y quitá el vértice central.

### Variante que conviene intentar

Reescribir una inducción válida para una familia que sí sea cerrada al agregar hojas, y marcar
explícitamente que esa nueva afirmación ya no es la afirmación universal de Federico.

### Chuleta

> Contraejemplo $K_2\cup K_2$ → la inducción constructiva cubre una subfamilia → en (d) falla “todos los grados de $G-v$ siguen siendo positivos”.

---

## 🔴 Ejercicio 3 — Árboles

### Enunciado

Dado un grafo simple de $n\geq 2$ vértices sin vértices de grado $0$, decidir cuáles condiciones garantizan
que sea un árbol:

- (a) $n-1$ aristas;
- (b) exactamente dos vértices de grado $1$;
- (c) exactamente dos vértices de grado $1$ y $n-1$ aristas;
- (d) exactamente dos vértices de grado $1$ y sin ciclos;
- (e) exactamente dos vértices de grado $1$ y conexo;
- (f) exactamente dos vértices de grado $1$ y todos los demás de grado $2$.

### Qué tenés que producir

Una clasificación verdadero/falso y un contraejemplo para cada ítem falso. No alcanza con usar
“parece un camino”: hay que justificar conexidad y ausencia de ciclos.

### Conocimiento que presupone

Definición de árbol, Handshaking Lemma, componentes conexas y que todo árbol no trivial tiene al
menos dos hojas.

### Pista de reconocimiento

Para las condiciones con $n-1$ aristas, separá el grafo en componentes. Un componente árbol con al
menos dos vértices tiene al menos dos hojas; un componente con ciclo tiene al menos tantas aristas
como vértices.

### Plan de resolución

Analizar primero (c) y (d), que combinan dos condiciones estructurales; luego construir contraejemplos
pequeños para (a), (b), (e) y (f).

### Resolución paso a paso

1. **(a) Falso.** $P_3\cup C_3$ tiene $n=6$, $5=n-1$ aristas y ningún vértice aislado, pero es disconexo.
2. **(b) Falso.** $P_3\cup C_3$ tiene exactamente dos vértices de grado $1$, pero no es conexo.
3. **(c) Verdadero.** Supongamos que $G$ fuera disconexo. Cada componente tiene al menos un vértice porque no hay grados $0$. Si una componente es un árbol no trivial, aporta al menos dos hojas; si todas las componentes fueran ciclos o contuvieran ciclos, el total de aristas sería al menos $n$, no $n-1$. Por lo tanto, con exactamente dos hojas solo puede haber una componente y esta debe ser acíclica. Luego $G$ es conexo y sin ciclos: es un árbol.
4. **(d) Verdadero.** Un grafo sin ciclos es un bosque. Cada componente no trivial de un bosque tiene al menos dos hojas. Como hay exactamente dos hojas y no hay vértices aislados, hay una sola componente. Por lo tanto es un árbol.
5. **(e) Falso.** Tomar un triángulo $a-b-c-a$ y agregar dos hojas $x$ e $y$, con aristas $(a,x)$ y $(b,y)$. El grafo es conexo y tiene exactamente dos vértices de grado $1$, pero conserva el ciclo $a-b-c-a$.
6. **(f) Falso.** Tomar $P_3\cup C_3$. Tiene exactamente dos vértices de grado $1$ y todos los demás tienen grado $2$, pero es disconexo y contiene un ciclo.

### Control del resultado

La clasificación final es:

$$\boxed{\text{(c) y (d) garantizan que }G\text{ es un árbol; (a), (b), (e), (f) no.}}$$

Verificá cada contraejemplo contando $n$, aristas, grados y componentes; no uses un grafo con vértices
de grado $0$ porque viola la hipótesis del enunciado.

### Si te trabás

1. Para (a) y (b), probá unir un camino con un ciclo.
2. Para (c), recordá que un ciclo agrega aristas sin aportar hojas.
3. Para (d), descomponé el grafo en sus componentes de bosque.

### Variante que conviene intentar

Probar la caracterización estándar: en un grafo sin vértices aislados, “exactamente dos hojas y
sin ciclos” fuerza una única componente. Después comparala con el ítem (c), que reemplaza “sin
ciclos” por “$n-1$ aristas”.

### Chuleta

> (c) y (d) sí. Para refutar: camino + ciclo. Para probar: bosque + dos hojas ⇒ una componente; o $n-1$ aristas + dos hojas ⇒ no puede haber componente extra ni ciclo.

---

## 🟡 Ejercicio 1 — Isomorfismo

### Enunciado

Decidir si los dos grafos dibujados son isomorfos y, si lo son, dar una biyección que preserve la
adyacencia.

### Qué tenés que producir

Una función explícita y una verificación de que transforma cada arista en una arista. En la figura,
ambos grafos son $K_{3,3}$.

### Conocimiento que presupone

Definición de isomorfismo, grados, bipartición y grafo completo bipartito.

### Pista de reconocimiento

Antes de intentar emparejar vértices, compará cantidad de vértices, cantidad de aristas y secuencia
de grados. Después identificá las dos clases de la bipartición.

### Plan de resolución

Reconocer la bipartición de cada dibujo y enviar una clase de tres vértices a la otra clase de tres
vértices, y análogamente para la segunda clase.

### Resolución paso a paso

1. En el dibujo izquierdo, cada $u_i$ está unido a cada $v_j$: es $K_{3,3}$.
2. En el dibujo derecho, los vértices impares $\{w_1,w_3,w_5\}$ forman una clase y los pares $\{w_2,w_4,w_6\}$ la otra; cada vértice de una clase está unido a los tres de la otra. También es $K_{3,3}$.
3. Una biyección válida es
   $$f(u_1)=w_1,\quad f(u_2)=w_3,\quad f(u_3)=w_5,$$
   $$f(v_1)=w_2,\quad f(v_2)=w_4,\quad f(v_3)=w_6.$$
4. Si $(u_i,v_j)$ es una arista, $f(u_i)$ es impar y $f(v_j)$ es par, por lo que también son adyacentes en el dibujo derecho. No hay aristas dentro de cada clase en ninguno de los dos grafos.

### Control del resultado

La función debe ser biyectiva y preservar también la no adyacencia. Como ambos grafos son $K_{3,3}$,
mapear las clases de la bipartición como arriba verifica ambas cosas.

### Si te trabás

1. Calculá la secuencia de grados: todos deben ser $3$.
2. Separá los vértices del hexágono en posiciones impares y pares.
3. No hace falta respetar la posición geométrica del dibujo.

### Variante que conviene intentar

Proponé otra biyección permutando los tres vértices de cada clase. Todas esas funciones siguen siendo
isomorfismos.

### Chuleta

> Invariantes → reconocer $K_{3,3}$ → mapear clase $\{u_i\}$ a impares y clase $\{v_j\}$ a pares → verificar aristas y no aristas.

---

## 🟡 Ejercicio 4 — Suma de grados

### Enunciado

Demostrar por inducción en $|E(G)|$ que

$$2|E(G)|=\sum_{v\in V(G)}\deg(v).$$

### Qué tenés que producir

Una inducción cuyo objeto del paso sea un grafo arbitrario con una arista más que el caso inductivo.

### Conocimiento que presupone

Grado como cantidad de aristas incidentes e inducción estructural sobre aristas.

### Pista de reconocimiento

Para pasar de $m$ a $m+1$, quitá una arista $e=(u,v)$. Solo cambian los grados de $u$ y $v$.

### Plan de resolución

Definir $P(m)$ para todos los grafos con $m$ aristas, probar $P(0)$ y recuperar un grafo de $m+1$ aristas
quitando una arista cualquiera.

### Resolución paso a paso

1. **Predicado:** $P(m)$: para todo grafo $G$ con $|E(G)|=m$, vale $\sum_v\deg_G(v)=2m$.
2. **Base $m=0$.** No hay aristas, todos los grados son $0$ y la suma es $0=2\cdot 0$.
3. **Paso inductivo.** Sea $G$ arbitrario con $m+1$ aristas y sea $e=(u,v)$ una arista. Definí $G'=G-e$. Entonces $|E(G')|=m$.
4. Por HI, $\sum_x\deg_{G'}(x)=2m$. Al volver a agregar $e$, el grado de $u$ y el de $v$ suben en $1$; todos los demás quedan iguales.
5. Así,
   $$\sum_x\deg_G(x)=\sum_x\deg_{G'}(x)+2=2m+2=2(m+1).$$

### Control del resultado

La prueba debe usar un grafo arbitrario de $m+1$ aristas, no solo grafos construidos agregando una
arista a una forma especial.

### Si te trabás

Escribí por separado qué pasa con $u$, $v$ y un vértice $x\notin\{u,v\}$.

### Variante que conviene intentar

Rehacerla por conteo directo: cada arista incide en exactamente dos extremos y por eso aporta $2$
a la suma total.

### Chuleta

> Quitar una arista → HI da $2m$ → al reponerla suben dos grados → $2m+2$.

---

## 🟡 Ejercicio 5 — Equilibrio de un digrafo

### Enunciado

Demostrar por inducción en $|E(D)|$ que para todo digrafo $D$,

$$\sum_{v\in V(D)}d_{in}(v)=\sum_{v\in V(D)}d_{out}(v)=|E(D)|.$$

### Qué tenés que producir

Una prueba paralela a la del Handshaking Lemma, distinguiendo el extremo inicial y final de un arco.

### Conocimiento que presupone

Digrafos, grados de entrada y salida, inducción en aristas.

### Pista de reconocimiento

Al quitar un arco $u\to v$, desaparece exactamente una contribución en la suma de grados de salida
y una en la suma de grados de entrada.

### Plan de resolución

Probar las dos igualdades simultáneamente para un digrafo arbitrario.

### Resolución paso a paso

1. **Predicado:** $P(m)$: para todo digrafo con $m$ arcos, ambas sumas de grados valen $m$.
2. **Base $m=0$.** No hay arcos; todos los grados de entrada y salida son $0$.
3. **Paso.** Sea $D$ arbitrario con $m+1$ arcos y elegí $e=u\to v$. Definí $D'=D-e$.
4. Por HI, las dos sumas en $D'$ valen $m$. Al reponer $e$, $d_{out}(u)$ aumenta en $1$ y $d_{in}(v)$ aumenta en $1$.
5. Por lo tanto, ambas sumas pasan a valer $m+1=|E(D)|$.

### Control del resultado

No confundas “un arco aporta uno al grado de salida” con “aporta uno a ambos grados del mismo
vértice”: aporta al grado de salida de la cola y al de entrada de la cabeza.

### Si te trabás

Dibujá $u\to v$ y anotá: cola = salida, cabeza = entrada.

### Variante que conviene intentar

Derivar la igualdad directamente: cada arco se cuenta exactamente una vez en la suma de salidas y
exactamente una vez en la suma de entradas.

### Chuleta

> Un arco $u\to v$ → $+1$ en $d_{out}(u)$ y $+1$ en $d_{in}(v)$ → ambas sumas cuentan los $m$ arcos.

---

## 🟡 Ejercicio 6 — Doble grado

### Enunciado

Demostrar por reducción al absurdo que todo grafo no trivial tiene al menos dos vértices del mismo grado.

### Qué tenés que producir

Una contradicción que use simultáneamente el rango posible de grados y la incompatibilidad entre grado
$0$ y grado $n-1$.

### Conocimiento que presupone

En un grafo simple de $n$ vértices, $0\leq d(v)\leq n-1$.

### Pista de reconocimiento

Si los $n$ grados fueran todos distintos, ocuparían los $n$ valores posibles $0,1,\ldots,n-1$.
Preguntá si $0$ y $n-1$ pueden aparecer juntos.

### Plan de resolución

Suponer todos los grados distintos, forzar el conjunto completo de valores y producir una contradicción
entre los dos extremos.

### Resolución paso a paso

1. Sea $G$ un grafo simple con $n\geq 2$ vértices. Suponer que todos sus grados son distintos.
2. Cada grado pertenece a $\{0,1,\ldots,n-1\}$. Como hay $n$ vértices y $n$ valores posibles, los grados deben ser exactamente ese conjunto.
3. Entonces existe un vértice $x$ de grado $0$ y otro $y$ de grado $n-1$.
4. $y$ es adyacente a todos los demás, en particular a $x$, pero $x$ no puede tener ningún vecino. Contradicción.
5. Luego los grados no son todos distintos; al menos dos vértices tienen el mismo grado.

### Control del resultado

No digas solamente “por palomar”: hay $n$ vértices y $n$ valores posibles, pero la contradicción
adicional muestra por qué en realidad no pueden usarse todos los valores.

### Si te trabás

Recordá: grado $0$ significa aislado y grado $n-1$ significa conectado con todos.

### Variante que conviene intentar

Resolver la versión social: personas = vértices y amistad = arista.

### Chuleta

> Suponer grados distintos → aparecen $0$ y $n-1$ → aislado y universal no pueden coexistir → contradicción.

---

## 🟡 Ejercicio 7 — Muchas aristas implica conexo

### Enunciado

Demostrar por inducción en la cantidad de vértices que todo grafo de $n$ vértices con más de

$$\frac{(n-1)(n-2)}2$$

aristas es conexo.

### Qué tenés que producir

Una inducción para un grafo arbitrario, cuidando el caso en que todos los vértices son universales.

### Conocimiento que presupone

Grafo completo, grado máximo y que quitar un vértice reduce el número de aristas en su grado.

### Pista de reconocimiento

Para un grafo de $n+1$ vértices, si algún vértice tiene grado a lo sumo $n-1$, quitarlo deja más de
la cota inductiva. Si todos tienen grado $n$, el grafo es completo.

### Plan de resolución

Usar la formulación equivalente con $n+1$ vértices y separar los dos casos según exista o no un
vértice no universal.

### Resolución paso a paso

1. **Predicado:** $P(n)$: todo grafo de $n$ vértices con más de $\frac{(n-1)(n-2)}2$ aristas es conexo.
2. **Base.** Para $n=2$, tener más de $0$ aristas obliga a tener la única arista y el grafo es conexo.
3. **Paso.** Sea $G$ un grafo arbitrario de $n+1$ vértices con
   $$m>\frac{n(n-1)}2.$$
4. Si todos los vértices tienen grado $n$, $G=K_{n+1}$ y es conexo.
5. Si no, existe $v$ con $d(v)\leq n-1$. En $G-v$ quedan
   $$m-d(v)>\frac{n(n-1)}2-(n-1)=\frac{(n-1)(n-2)}2.$$
6. Por HI, $G-v$ es conexo. Como $d(v)\geq 0$ no alcanza por sí solo para conectar $v$; pero el caso $d(v)=0$ es imposible: entonces $m\leq\binom n2=\frac{n(n-1)}2$, contradicción. Por lo tanto $d(v)\geq1$ y $v$ tiene un vecino en el grafo conexo $G-v$. Así $G$ es conexo.

### Control del resultado

El paso debe justificar tanto la cota de $G-v$ como que el vértice quitado vuelve a quedar conectado.
La cota estricta se conserva porque se resta a lo sumo $n-1$.

### Si te trabás

Separá “grado $n$” (universal) de “grado a lo sumo $n-1$” (no universal).

### Variante que conviene intentar

Probar el resultado por contrarrecíproco: un grafo disconexo tiene como máximo
$K_{n-1}\cup K_1$, con $\frac{(n-1)(n-2)}2$ aristas.

### Chuleta

> No universal $v$ → quitar $v$ conserva la cota → HI conecta $G-v$ → $d(v)\neq0$ → agregar $v$ mantiene conexidad.

---

## 🟡 Ejercicio 8 — Unicidad de digrafo orientado

### Enunciado

Demostrar que para cada $n$ existe un único grafo orientado cuyos vértices tienen todos grados de
salida distintos. “Único” se entiende salvo renombrar vértices.

### Qué tenés que producir

Existencia constructiva y unicidad mediante una reducción inductiva al vértice de grado de salida máximo.

### Conocimiento que presupone

Grafo orientado, grados de salida, torneo transitivo e isomorfismo.

### Pista de reconocimiento

Los grados de salida están entre $0$ y $n-1$. Si son todos distintos, tienen que ser exactamente
$0,1,\ldots,n-1$; el vértice de grado $n-1$ tiene una relación forzada con todos.

### Plan de resolución

Construir el torneo transitivo y luego demostrar que cualquier otro grafo se reduce al mismo objeto
al quitar el vértice universal de salida.

### Resolución paso a paso

1. **Existencia.** Tomar vértices $v_1,\ldots,v_n$ y orientar $v_i\to v_j$ cuando $i<j$. Entonces
   $$d_{out}(v_i)=n-i,$$
   así que aparecen todos los valores $n-1,n-2,\ldots,0$.
2. **Unicidad.** Sea $D$ otro grafo orientado con grados de salida todos distintos. Los valores posibles son $0,\ldots,n-1$, por lo que aparecen todos.
3. El único vértice $x$ con grado $n-1$ apunta a todos. Ningún otro vértice puede apuntar a $x$, porque entre cada par se orienta una sola arista.
4. Al quitar $x$, los grados de salida de los restantes no cambian y siguen siendo distintos, ahora con valores $0,\ldots,n-2$. Por inducción, el subgrafo restante es el torneo transitivo salvo isomorfismo.
5. Reinsertar $x$ como vértice que apunta a todos produce exactamente el torneo transitivo de tamaño $n$. Por lo tanto, $D$ es isomorfo a la construcción.

### Control del resultado

La prueba de unicidad debe ser “salvo isomorfismo”: los nombres concretos de los vértices pueden
cambiar, pero la relación de adyacencia queda determinada por el orden de los grados.

### Si te trabás

Empezá por el vértice con grado de salida $n-1$ y repetí el argumento en el resto.

### Variante que conviene intentar

Orientar $v_i\to v_j$ cuando $i>j$ y comprobar que es el mismo grafo salvo renombrar el orden.

### Chuleta

> Construir torneo transitivo → grados $0,\ldots,n-1$ → quitar el único vértice de grado $n-1$ → HI → reinsertar.

---

## 🟡 Ejercicio 9 — Dos caminos implican ciclo

### Enunciado

Sean $P$ y $Q$ dos caminos distintos de $v$ a $w$. Demostrar directamente que existe un ciclo cuyas
aristas pertenecen a $P$ o a $Q$.

### Qué tenés que producir

Dos subcaminos con los mismos extremos y vértices internos disjuntos.

### Conocimiento que presupone

Camino simple, ciclo, último vértice común y concatenación de caminos.

### Pista de reconocimiento

Recorrer ambos caminos desde $v$ y tomar el último vértice común antes de que sus tramos hacia $w$ queden
separados.

### Plan de resolución

Elegir un vértice común $x$ tal que los subcaminos desde $x$ hasta $w$ no tengan otro vértice común
interno; unir el tramo de $P$ con el tramo inverso de $Q$.

### Resolución paso a paso

1. Escribir $P=v_0,\ldots,v_p$ y $Q=w_0,\ldots,w_q$, con $v_0=w_0=v$ y $v_p=w_q=w$.
2. Como ambos terminan en $w$, tienen vértices comunes. Elegir $x=v_i=w_j$ de modo que sea el último punto de encuentro antes de los tramos finales.
3. Entonces $P[x,w]$ y $Q[x,w]$ tienen los mismos extremos y no comparten vértices internos.
4. Recorrer $P[x,w]$ de $x$ a $w$ y luego $Q[x,w]$ en sentido inverso, de $w$ a $x$. La concatenación es un ciclo simple.
5. Como $P\neq Q$, al menos una de las dos partes contiene una arista distinta; el ciclo tiene longitud al menos $3$ en un grafo simple.

### Control del resultado

No alcanza con concatenar los caminos completos: pueden cruzarse varias veces. La elección del último
vértice común es la que elimina las repeticiones internas.

### Si te trabás

Marcá los vértices comunes de $P$ y $Q$ en orden y elegí el último antes del tramo final.

### Variante que conviene intentar

Usar el primer punto de divergencia y el primer reencuentro posterior; justificar que ambos subcaminos
internos son disjuntos.

### Chuleta

> Último vértice común $x$ → $P[x,w]$ + reverso de $Q[x,w]$ → ciclo con aristas de $P\cup Q$.

---

## 🟡 Ejercicio 10 — Subgrafos y particiones conexas

### Enunciado

Para un grafo conexo, estudiar particiones de $V(G)$ en dos conjuntos no vacíos $A$ y $B$ y demostrar
que $G$ es conexo si y solo si toda partición tiene una arista con un extremo en cada parte.

### Qué tenés que producir

Un ejemplo donde $G[A]$ y $G[B]$ no sean conexos, y una demostración formal de la equivalencia.

### Conocimiento que presupone

Subgrafo inducido, camino y componentes conexas.

### Pista de reconocimiento

Si un camino empieza en $A$ y termina en $B$, en algún paso debe cambiar de parte.

### Plan de resolución

Resolver primero el ejemplo; luego probar una dirección por caminos y la otra por contrarrecíproco.

### Resolución paso a paso

1. **Ejemplo.** En el camino $a-b-c-d$, tomar $A=\{a,c\}$ y $B=\{b,d\}$. Ambos subgrafos inducidos son dos vértices aislados, por lo que no son conexos. No todo grafo admite tal partición: $K_3$ no puede dividirse en dos partes no vacías que sean ambas disconexas.
2. **($\Rightarrow$).** Supongamos $G$ conexo y una partición $A,B$ sin aristas cruzadas. Elegí $a\in A$ y $b\in B$. Como $G$ es conexo, existe un camino $a=x_0,\ldots,x_k=b$. La secuencia comienza en $A$ y termina en $B$, así que existe un índice $i$ con $x_i\in A$ y $x_{i+1}\in B$; eso es una arista cruzada, contradicción.
3. **($\Leftarrow$).** Probemos el contrarrecíproco. Si $G$ es disconexo, elegí una componente conexa $C$ y definí $A=V(C)$, $B=V(G)\setminus V(C)$. Ambas partes son no vacías y no hay aristas entre ellas, porque una arista las uniría en una misma componente. Por lo tanto existe una partición sin arista cruzada.
4. Concluimos la equivalencia.

### Control del resultado

La dirección de conexo a arista cruzada debe usar un camino y localizar el primer cambio de parte;
no alcanza con una figura intuitiva.

### Si te trabás

En el contrarrecíproco, tomá una componente completa como una de las partes.

### Variante que conviene intentar

Probar que la relación “pertenecer a la misma componente conexa” es una relación de equivalencia.

### Chuleta

> Camino de $A$ a $B$ → en algún paso cruza → si es disconexo, componente + resto no tienen aristas cruzadas.

---

## 🟡 Ejercicio 11 — Muchas aristas implica biconexo

### Enunciado

Demostrar por absurdo que un grafo de $n$ vértices con al menos

$$2+\frac{(n-1)(n-2)}2$$

aristas es biconexo. Luego estudiar si se pueden mejorar las cotas a partir de algún $n_0$.

### Qué tenés que producir

Una cota superior para las aristas de un grafo con punto de articulación y el análisis de la cuestión
sobre funciones reales.

### Conocimiento que presupone

Punto de articulación, componentes de $G-v$ y cantidad máxima de aristas dentro de una componente.

### Pista de reconocimiento

Si $v$ es articulación, $G-v$ tiene al menos dos componentes. Para maximizar aristas, concentrá los
$n-1$ vértices restantes en una componente de tamaño $n-2$ y otra de tamaño $1$.

### Plan de resolución

Primero obtener conexidad con el Ej. 7; después suponer que existe una articulación y acotar las
aristas por componentes.

### Resolución paso a paso

1. La cota del Ej. 7 implica que $G$ es conexo porque tiene más de $\frac{(n-1)(n-2)}2$ aristas.
2. Supongamos, por absurdo, que $G$ tiene un punto de articulación $v$. Las componentes de $G-v$ tienen tamaños $s_1,\ldots,s_k$, con $k\geq2$ y suma $n-1$.
3. No hay aristas entre componentes. Todas las aristas incidentes a $v$ son a lo sumo $n-1$, y dentro de las componentes hay a lo sumo $\sum_i\binom{s_i}{2}$ aristas.
4. Esa suma se maximiza concentrando todos los vértices salvo uno en una componente:
   $$\sum_i\binom{s_i}{2}\leq\binom{n-2}{2}.$$
5. Luego
   $$|E(G)|\leq (n-1)+\binom{n-2}{2}=1+\frac{(n-1)(n-2)}2,$$
   que contradice $|E(G)|\geq2+\frac{(n-1)(n-2)}2$.
6. No hay punto de articulación; junto con conexidad, $G$ es biconexo.
7. **Sobre (b):** para cantidades enteras de aristas, las cotas son exactas: $K_{n-1}\cup K_1$ alcanza la cota máxima de un grafo disconexo, y $K_{n-2}$ unido a un vértice articulador universal y a una hoja alcanza la cota máxima con articulación. Como el enunciado permite $c(n)\in\mathbb R$, se puede escribir artificialmente $c(n)=\frac{(n-1)(n-2)}2+\frac12$ y análogamente $c(n)=2+\frac{(n-1)(n-2)}2-\frac12$; por la integralidad de $|E|$, la condición “al menos $c(n)$” sigue exigiendo la misma cantidad entera de aristas. No es una mejora combinatoria real, solo un efecto de redondeo.

### Control del resultado

La cota con articulación debe terminar en $1+\frac{(n-1)(n-2)}2$, estrictamente menor que el umbral
pedido. Si aparece una cota más alta, revisá si contaste aristas entre componentes de $G-v$.

### Si te trabás

Dibujá un vértice articulador unido a una componente grande y a una hoja.

### Variante que conviene intentar

Obtener la cota de conexidad directamente por componentes, sin usar el Ej. 7.

### Chuleta

> Conexo por Ej. 7 → si hubiera articulación: máximo $n-1+\binom{n-2}{2}=1+\binom{n-1}{2}$ → contradicción con $2+\binom{n-1}{2}$.

---

## 🟡 Ejercicio 12 — Conexo tiene dos vértices que no son articulación

### Enunciado

Demostrar por inducción que todo grafo conexo con al menos dos vértices tiene dos vértices distintos
cuya eliminación conserva la conexidad.

### Qué tenés que producir

Una inducción fuerte que trate por separado el caso sin articulaciones y el caso con una articulación.

### Conocimiento que presupone

Componentes conexas, punto de articulación e inducción fuerte.

### Pista de reconocimiento

Si $v$ es articulación, analizá cada subgrafo formado por una componente de $G-v$ más $v$.

### Plan de resolución

Si ya hay dos vértices no articulación, terminar. Si no, elegir una articulación, aplicar HI en dos
componentes aumentadas por ella y volver a unirlas a través de $v$.

### Resolución paso a paso

1. **Base $n=2$.** El grafo conexo es $K_2$. Al quitar cualquiera de sus vértices queda un grafo de un vértice, conexo; hay dos elecciones.
2. **Paso inductivo.** Sea $G$ conexo con $n+1$ vértices.
3. Si no tiene puntos de articulación, cualquier par de vértices sirve.
4. Si tiene un punto de articulación $v$, sean $C_1,C_2,\ldots,C_k$ ($k\geq2$) las componentes de $G-v$. Para cada $i$, definí $H_i=G[C_i\cup\{v\}]$. Cada $H_i$ es conexo y tiene al menos dos vértices, pero menos que $G$.
5. Por HI, $H_1$ tiene dos vértices cuya eliminación lo deja conexo. Al menos uno es distinto de $v$; llamalo $x\in C_1$. Análogamente, obtené $y\in C_2$ cuya eliminación deja $H_2$ conexo.
6. En $G-x$, la parte $C_1\cup\{v\}$ sigue conectada y cada otra componente $C_i$ se conecta con $v$ porque $G$ era conexo. Por lo tanto $G-x$ es conexo. El mismo argumento vale para $G-y$.
7. $x\neq y$, porque pertenecen a componentes distintas. Son los dos vértices buscados.

### Control del resultado

Hay que elegir vértices fuera de $v$ y demostrar que las otras componentes siguen conectadas a través
de $v$ después de quitar $x$ o $y$.

### Si te trabás

Usá dos componentes distintas de $G-v$; cada una aporta un vértice que no puede ser $v$.

### Variante que conviene intentar

Dar una demostración alternativa usando un árbol generador y dos hojas del árbol. Esa variante no
reemplaza la inducción pedida, pero sirve para controlar el resultado.

### Chuleta

> Sin articulación: cualquiera. Con articulación $v$: componentes $C_i$ → aplicar HI a $C_i\cup\{v\}$ → elegir uno fuera de $v$ en dos componentes.

---

## 🟡 Ejercicio 13 — Caminos cruzados

### Enunciado

En un grafo conexo, demostrar por el contrarrecíproco que todo par de caminos de longitud máxima
tiene un vértice en común.

### Qué tenés que producir

Si dos caminos máximos fueran disjuntos, construir uno estrictamente más largo.

### Conocimiento que presupone

Camino simple, conexidad y elección de un camino entre dos conjuntos de vértices.

### Pista de reconocimiento

Elegí un camino $R$ mínimo que una un vértice de $P$ con uno de $Q$; sus vértices internos quedan
fuera de ambos caminos.

### Plan de resolución

Suponer dos caminos disjuntos de longitud máxima $L$, unirlos con $R$ y elegir en cada camino el
extremo más lejano del punto de unión.

### Resolución paso a paso

1. Supongamos que $P$ y $Q$ son disjuntos y ambos tienen longitud máxima $L$.
2. Como $G$ es conexo, existe un camino $R$ que une algún $p\in V(P)$ con algún $q\in V(Q)$. Elegirlo mínimo garantiza que sus vértices internos no pertenecen a $P\cup Q$; además $|R|\geq1$.
3. En $P$, uno de los dos extremos está a distancia al menos $\lceil L/2\rceil$ de $p$. Elegí ese tramo. En $Q$, elegí análogamente el tramo desde $q$ al extremo más lejano.
4. Concatenar el tramo de $P$, $R$ y el tramo de $Q$. Los tres pedazos solo se tocan en sus extremos, así que forman un camino simple.
5. Su longitud es al menos
   $$\left\lceil\frac L2\right\rceil+1+\left\lceil\frac L2\right\rceil\geq L+1,$$
   contradicción con la maximalidad de $L$.
6. Por contrarrecíproco, dos caminos de longitud máxima tienen un vértice en común.

### Control del resultado

El camino construido debe ser simple. Por eso hace falta que $R$ sea mínimo y que $P$ y $Q$ sean
disjuntos.

### Si te trabás

Partí cada camino en los dos tramos desde el punto de unión y quedate con el más largo.

### Variante que conviene intentar

Probar la afirmación usando un árbol generador: los extremos de un diámetro de un árbol no pueden
quedar completamente separados de otro diámetro máximo.

### Chuleta

> Suponer $P,Q$ disjuntos de longitud $L$ → unirlos con $R$ → mitad larga de $P$ + $R$ + mitad larga de $Q$ tiene longitud $>L$.

---

## 🟡 Ejercicio 14 — Unión vs. junta

### Enunciado

Relacionar unión disjunta, junta y complemento. La parte (a) pide demostrar que $G$ es unión si y solo
si es disconexo. La parte (b), tal como aparece en el texto extraído, dice que “$G$ es junta si y solo
si $G$ es unión”; la conclusión (c) y las definiciones indican que allí falta el complemento.

### Qué tenés que producir

La prueba de (a), la corrección conceptual de (b) y la conclusión (c), sin ocultar la discrepancia
tipográfica.

### Conocimiento que presupone

Complemento de un grafo, componentes conexas, unión disjunta y junta.

### Pista de reconocimiento

Complementar intercambia “no hay aristas entre las partes” con “están todas las aristas entre las partes”.

### Plan de resolución

Probar (a) en ambas direcciones; luego demostrar la afirmación coherente
$G$ es junta si y solo si $\overline G$ es unión; finalmente aplicar (a) a $\overline G$.

### Resolución paso a paso

1. **(a), unión implica disconexo.** Si $G=G_1\cup G_2$ con ambas partes no vacías y disjuntas, no hay aristas entre $V(G_1)$ y $V(G_2)$; por lo tanto no hay camino que cruce de una parte a la otra.
2. **(a), disconexo implica unión.** Si $G$ es disconexo, tomar una componente $C$ y el resto de las componentes. No hay aristas entre ellas, así que $G=C\cup(G-C)$.
3. **(b), versión coherente.** Si $G=G_1+G_2$, hay todas las aristas entre las partes; al complementar, no queda ninguna entre ellas. Entonces $\overline G=\overline{G_1}\cup\overline{G_2}$.
4. En la otra dirección, si $\overline G=H_1\cup H_2$, no hay aristas entre las partes en $\overline G$, por lo que hay todas las aristas entre ellas en $G$; luego $G$ es la junta de los subgrafos inducidos correspondientes.
5. **(c).** Por (a) aplicado a $\overline G$:
   $$G\text{ es junta}\iff \overline G\text{ es unión}\iff \overline G\text{ es disconexo}.$$

### Control del resultado

La junta no se caracteriza por que $G$ mismo sea unión; se caracteriza por que su complemento sea unión
o, equivalentemente, disconexo.

### Si te trabás

Probá con el grafo vacío de dos vértices: es unión, pero no junta bajo la definición usual.

### Variante que conviene intentar

Mostrar que $G$ es junta si y solo si $\overline G$ es disconexo usando únicamente la definición de
complemento y el Ej. 10.

### Chuleta

> Unión ⇔ disconexo. Complemento de junta = unión. Entonces junta ⇔ complemento disconexo.

---

## 🟡 Ejercicio 15 — Unicidad de grados

### Enunciado

Se define $G_2=K_2$ y $G_{n+1}=G_n\cup K_1$ para $n\geq2$. La guía pide demostrar que $G_n$ tiene
un único par de vértices de igual grado.

### Qué tenés que producir

Auditar si la afirmación es verdadera bajo la definición de unión disjunta escrita en la guía.

### Conocimiento que presupone

Unión disjunta y conteo de grados.

### Pista de reconocimiento

Calculá explícitamente los primeros tres grafos antes de intentar una inducción.

### Plan de resolución

Verificar $G_2$, $G_3$ y $G_4$. Si aparece más de un par, no existe una resolución inductiva honesta
sin corregir la consigna.

### Resolución paso a paso

1. $G_2=K_2$ tiene secuencia de grados $(1,1)$: un único par igual.
2. $G_3=K_2\cup K_1$ tiene grados $(1,1,0)$: sigue habiendo un único par igual.
3. $G_4=G_3\cup K_1$ tiene grados $(1,1,0,0)$: hay un par de grado $1$ y otro par de grado $0$.
4. Por lo tanto la afirmación “un único par” ya es falsa para $n=4$. No se puede completar la inducción con la definición de unión disjunta dada.

### Control del resultado

No intentes “probar” una afirmación que falla en el tercer caso. La respuesta correcta es mostrar el
contraejemplo y señalar la incompatibilidad.

### Si te trabás

Escribí la secuencia de grados, no solo dibujes el grafo: cada $K_1$ nuevo aporta otro grado $0$.

### Variante que conviene intentar

Determinar qué operación alternativa produciría la secuencia sugerida
$(0,1,1,2,3,\ldots)$; esa operación no es la unión disjunta indicada y requiere una consigna nueva.

### Chuleta

> $G_4=K_2\cup K_1\cup K_1$ → grados $(1,1,0,0)$ → dos pares → consigna falsa tal como está escrita.

---

## 🟡 Ejercicio 16 — Triángulo inductivo

### Enunciado

Demostrar por inducción que todo grafo de $2n$ vértices con más de $n^2$ aristas tiene un triángulo.
Determinar si se puede mejorar la cota.

### Qué tenés que producir

Una prueba inductiva de la cota para grafos sin triángulos y un ejemplo que muestre que el umbral es exacto.

### Conocimiento que presupone

Handshaking Lemma, ciclo/triángulo y que en un grafo sin triángulos dos vecinos de un vértice no pueden
ser adyacentes.

### Pista de reconocimiento

Es más limpio probar por inducción la cota de Mantel: un grafo sin triángulos con $N$ vértices tiene
a lo sumo $\lfloor N^2/4\rfloor$ aristas.

### Plan de resolución

Inducir en $N$. Elegir una arista $uv$, quitar sus dos extremos y usar que $N(u)$ y $N(v)$ no comparten
vecinos en un grafo sin triángulos.

### Resolución paso a paso

1. Sea $M(N)$ la afirmación: todo grafo sin triángulos de $N$ vértices tiene a lo sumo $\lfloor N^2/4\rfloor$ aristas.
2. **Bases $N=1,2$.** Son inmediatas: no puede haber triángulos y la cantidad de aristas no supera la cota.
3. **Paso inductivo.** Si el grafo no tiene aristas, la cota es trivial. Si tiene una arista $uv$, quitar $u$ y $v$ deja un grafo sin triángulos de $N-2$ vértices. Por HI tiene a lo sumo $\left\lfloor (N-2)^2/4\right\rfloor$ aristas.
4. Como no hay triángulos, ningún vértice distinto de $u,v$ puede ser vecino de ambos. Por lo tanto $d(u)+d(v)\leq N$.
5. Las aristas eliminadas al quitar $u,v$ son $d(u)+d(v)-1$, porque la arista $uv$ se contó dos veces en la suma de grados. Así,
   $$|E(G)|\leq\left\lfloor\frac{(N-2)^2}{4}\right\rfloor+N-1\leq\left\lfloor\frac{N^2}{4}\right\rfloor.$$
6. Para $N=2n$, un grafo sin triángulos tiene a lo sumo $n^2$ aristas. Por contraposición, si tiene más de $n^2$, contiene un triángulo.
7. La cota no puede bajar en términos enteros: $K_{n,n}$ tiene $2n$ vértices, $n^2$ aristas y ningún triángulo porque es bipartito.

### Control del resultado

El paso clave es $d(u)+d(v)\leq N$: si hubiera un vecino común de $u$ y $v$, formaría un triángulo
con la arista $uv$.

### Si te trabás

Al quitar $u$ y $v$, recordá restar $d(u)+d(v)-1$, no $d(u)+d(v)$.

### Variante que conviene intentar

Para $N=2n$, usar directamente la forma especializada de Mantel: sin triángulos, $|E|\leq n^2$.

### Chuleta

> Sin triángulos + arista $uv$ → $d(u)+d(v)\leq N$ → quitar $u,v$ → HI → $|E|\leq\lfloor N^2/4\rfloor$ → $K_{n,n}$ muestra exactitud.

---

## 🟡 Ejercicio 17 — Bipartito o ciclo

### Enunciado

Probar que $G-v$ es bipartito para todo $v\in V(G)$ si y solo si $G$ es bipartito o es un ciclo impar.
La ida debe hacerse por contrarrecíproco y la vuelta directamente.

### Qué tenés que producir

Las dos direcciones, distinguiendo el caso de un ciclo impar de un grafo que simplemente contiene un
ciclo impar.

### Conocimiento que presupone

Caracterización de grafos bipartitos por ausencia de ciclos impares y subgrafos inducidos.

### Pista de reconocimiento

Si $G$ no es bipartito, contiene un ciclo impar $C$. Si $G$ no es exactamente ese ciclo, hay una forma de
quitar un vértice sin destruir todos los ciclos impares.

### Plan de resolución

Para el contrarrecíproco separar: vértice fuera de $C$; o todos los vértices en $C$ pero existe una
arista extra.

### Resolución paso a paso

1. **Vuelta directa, $G$ bipartito.** Todo $G-v$ es un subgrafo de un grafo bipartito y, por lo tanto, es bipartito.
2. **Vuelta directa, $G=C_{2k+1}$.** Al quitar cualquier vértice queda un camino, que se puede colorear alternando dos colores.
3. **Ida por contrarrecíproco.** Supongamos que $G$ no es bipartito y que no es un ciclo impar. Como no es bipartito, contiene un ciclo impar $C$.
4. Si existe un vértice $x$ fuera de $C$, entonces $C\subseteq G-x$, de modo que $G-x$ sigue teniendo un ciclo impar y no es bipartito.
5. Si todos los vértices están en $C$ pero $G\neq C$, existe una arista extra, necesariamente una cuerda de $C$. La cuerda divide $C$ en dos caminos; al combinarla con cada camino produce dos ciclos cuyas longitudes suman una cantidad impar. Uno de ellos es impar y omite algún vértice de $C$ (ambos caminos de una cuerda tienen al menos dos aristas). Quitando un vértice omitido, ese ciclo impar sobrevive; por lo tanto algún $G-v$ no es bipartito.
6. El contrarrecíproco prueba que, si todos los $G-v$ son bipartitos, entonces $G$ es bipartito o un ciclo impar.

### Control del resultado

En el caso de la cuerda, hay que elegir un vértice que no pertenezca al ciclo impar construido; no alcanza
con quitar un vértice cualquiera del ciclo original.

### Si te trabás

Un ciclo impar extraído de $G$ sobrevive al quitar cualquier vértice fuera de él.

### Variante que conviene intentar

Probar primero el lema “un grafo es bipartito si y solo si no tiene ciclos impares” y usarlo como caja
negra en ambas direcciones.

### Chuleta

> Bipartito → todo subgrafo. Ciclo impar → al quitar un vértice queda camino. No bipartito + no ciclo → algún ciclo impar sobrevive a quitar un vértice.

---

# Ejercicios redundantes u opcionales

- **Ej. 1** — el dibujo agrega una tarea de reconocimiento de isomorfismo que no aparece como patrón compilado, pero conviene practicarla por ser una definición central.
- **Ej. 9** — repite el lema “dos caminos distintos implican ciclo” que ya aparece en la práctica histórica de grafos; sirve como variante de construcción directa.
- **Ej. 15** — no es una variante opcional en sentido matemático: debe auditarse, pero no debe contarse como una demostración lograda porque la afirmación falla.
- **Ej. 16** — la formulación pide inducción en $n$, mientras la prueba más segura induce en la cantidad total $N$ de vértices; practicar luego la especialización $N=2n$.

## Criterio para considerar dominada la guía

- Puedo elegir la técnica de demostración que corresponde a la forma de la consigna y justificar la elección.
- Puedo detectar cuándo un paso inductivo habla de una construcción particular y no de un objeto arbitrario.
- Puedo clasificar las seis condiciones del Ej. 3 y producir contraejemplos que respeten todas las hipótesis.
- Puedo probar el Handshaking Lemma y su versión dirigida sin confundir grados de entrada y salida.
- Puedo construir un ciclo a partir de dos caminos y un camino más largo a partir de dos caminos máximos disjuntos.
- Puedo pasar de una partición sin aristas cruzadas a disconexidad usando caminos, no solo intuición.
- Puedo acotar aristas de grafos disconexos, con articulación y sin triángulos.
- Puedo explicar por qué $K_{n,n}$ y $K_{n-1}\cup K_1$ muestran que ciertas cotas no mejoran en términos enteros.
- Puedo señalar la discrepancia del Ej. 14(b) y el contraejemplo del Ej. 15 sin “arreglar” silenciosamente la guía.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Ej. 2 — auditoría de inducción y contraejemplos | 🔴 | patrón con apariciones en `1P_1C_2024` Ej. 5–7, `2P_2C_2025` Ej. 2 y `2P_1C_2025` A1 | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 3 — condiciones suficientes para árbol | 🔴 | `2P_2C_2025` Ej. 1.I; además coincide con el subcaso “árboles” del patrón | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 4, 5, 6 y 8 — demostraciones de grados y orientaciones | 🟡 | variantes en `1P_1C_2024` Ej. 5–7 y `2P_1C_2025` A1 | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 9 y 11 — ciclo/conexidad estructural | 🟡 | variante en `2P_2C_2025` Ej. 2 | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 14 — unión/junta y complemento | 🟡 | propiedad de junta y contraejemplo en `1P_1C_2024` Ej. 7 | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 17 — bipartición y ciclo impar | 🟡 | `2P_1C_2025` A1: ciclo 2-colorable si y solo si su longitud es par | [[tipos_ejercicio/grafos_demostraciones]] |
| Ej. 1, 7, 10, 12, 13, 15 y 16 | 🟡 | sin patrón específico compilado; contenido de la guía vigente, que eleva un tema sin precedente a 🟡 | — |

**Base de comparación:** 6 parciales analizados, 13 patrones en `wiki/tipos_ejercicio/`.
El patrón compilado que coincide por `tema: grafos` es [[tipos_ejercicio/grafos_demostraciones]],
con 3 exámenes citados. Los patrones de `recorrido_en_grafos` no se usaron para asignar prioridad
a esta guía porque BFS/DFS es un tema separado en `programa.md`. Las estrellas de la guía no se
contaron como apariciones históricas.

## Lo que este documento NO cubre y igual toman

- [[tipos_ejercicio/bfs_dfs_propiedades]] — 4 apariciones históricas (`1P_1C_2024`, `2P_1C_2024`,
  `2P_2C_2025` y `2P_1C_2025`). Es el patrón de BFS/DFS del tema separado
  `recorrido_en_grafos`, también del 1P, y se estudia en [[recorrido_en_grafos_guia]]. No forma
  parte de esta guía de introducción a definiciones y demostraciones.

## Divergencias detectadas

- **Ej. 14(b), posible error tipográfico de la guía:** el texto extraído afirma “$G$ es un grafo junta
  si y solo si $G$ es un grafo unión”, pero eso contradice la parte (c) y la relación matemática
  esperada. Se trabajó con la lectura coherente “$G$ es junta si y solo si $\overline G$ es unión” y
  se deja la discrepancia visible. ⚠️ Verificar contra el PDF visual antes de usarla como enunciado literal.
- **Ej. 15, afirmación falsa bajo la definición escrita:** la unión disjunta produce grados
  $(1,1,0,0)$ en $G_4$, así que no hay un único par de grados iguales. No se reconcilia ni se inventa
  una operación alternativa.
- **Ej. 2(c), demostración todavía inválida:** aunque el predicado está escrito con cuantificadores,
  el paso sigue construyendo un grafo particular y no prueba el caso universal. Es una divergencia
  entre la formalización de la consigna y la validez de su prueba, no una corrección silenciosa.
