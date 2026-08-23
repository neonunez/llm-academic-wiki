---
nombre: Definiciones y Demostraciones — Teoria
parcial: ambos
programa: 2C_2026
tipo: teoria
tema: definiciones_y_demostraciones
fuentes:
  vigente:
    - raw/cursada_2C_2026/teo/teo_clase1_demostraciones.pdf
  historico:
    - raw/clases/teo/5.teo_1P_definicion_demo.pdf
estado_verificacion: verificado_parcial_2C_2026
paginas_relacionadas:
  - "[[complejidad_computacional_teoria]]"
  - "[[demostraciones_induccion_guia]]"
  - "[[fuerza_bruta_backtracking_teoria]]"
  - "[[programacion_dinamica_teoria]]"
  - "[[greedy_teoria]]"
---

> 🟡 **Verificado parcialmente contra la cursada 2C-2026** · fuente: raw/cursada_2C_2026/teo/teo_clase1_demostraciones.pdf
> Los bloques marcados con 📎 siguen sin contrastar.

# Definiciones y Demostraciones — Teoria

La clase 1 de la cursada 2C-2026 ("Repaso de demostraciones — Induccion, correctitud y
complejidad asintotica") organiza el tema con este eje, que es el que sigue esta pagina:

1. Que es una demostracion (y a quien tiene que convencer).
2. Como se demuestra: la receta de 6 pasos.
3. Induccion (comun, fuerte, casos base, tuplas).
4. Correctitud de algoritmos recursivos.
5. Otras herramientas: contrarreciproco, contradiccion, palomar, minimo elemento.
6. Tips y conclusiones.

El repaso de complejidad asintotica de esa misma clase (definiciones de $O$, $\Omega$, $\Theta$
y como demostrar pertenencia) vive en [[complejidad_computacional_teoria]].

---

## Concepto y definicion

### Que es una demostracion, y a quien tiene que convencer

Una demostracion matematica es un **argumento convincente** sobre la veracidad de una
proposicion matematica. Inmediatamente aparece la pregunta: **¿convence a quien?**

El enunciado del Teorema de Pitagoras ("dado un triangulo rectangulo, la suma de los cuadrados
de los catetos es igual al cuadrado de la hipotenusa") no es una demostracion: alcanza con
preguntarse *¿esto los convence?, ¿como saben, o definen, si "esta bien"?* para ver que falta
todo el argumento.

Los dos extremos del espectro muestran por que la audiencia es el criterio:

- Una **demostracion heuristica** puede convencer a un apurado... y ser falsa. Ejemplo:
  "$n! + 1$ no es divisible por nadie debajo de $n$, luego es primo". Contraejemplo:
  $$4! + 1 = 25 = 5^2$$
- Una **demostracion totalmente formal** (por ejemplo, escrita en el lenguaje de programacion
  Lean 4) convence a una computadora, pero es **ilegible para un par humano**.

Lo que se considera una demostracion correcta **depende del contexto**: que podemos asumir del
lector, y para que estamos demostrando.

> **Definicion (2C-2026).** Una demostracion es un **argumento formal sobre la veracidad de una
> proposicion, que puede convencer a cualquier par de la comunidad cientifica**.

> 🔄 **Cambio respecto de cuatrimestres anteriores**
> **Ahora (2C-2026):** una demostracion es un argumento formal que puede **convencer a cualquier par de la comunidad cientifica**; el criterio de correccion es la **audiencia**. Lean aparece como ejemplo de formalismo *excesivo*: convence a una computadora pero es ilegible para un par humano.
> **Antes:** una demostracion es un **algoritmo** que combina definiciones y teoremas para obtener nuevos teoremas; Lean aparecia como ejemplo positivo (demostradores automaticos que leen demostraciones como programas).
> **Tipo:** enfoque de demostracion
> Fuente: raw/cursada_2C_2026/teo/teo_clase1_demostraciones.pdf

### El doble proposito de sus demostraciones

En el contexto de la materia, una demostracion tiene que:

1. **Convencer al lector de la veracidad de la proposicion.** Esto es comun a todas las
   demostraciones matematicas.
2. **Convencer al docente de que entienden como convencer a cualquiera.** El docente ya sabe que
   la proposicion es cierta; va a evaluar si sus argumentos convencerian a cualquier par.

Hay que ser un poco **paranoicos**: que no quede ninguna duda en la mente de ningun par que nos
lea. Se trata de desarrollar un **pensamiento critico-adversarial**.

### Formalidad y rigor

Son dos cosas distintas:

| Concepto | Que es |
|---|---|
| **Formalidad** | La **forma** en la que escribimos. Las demostraciones existen en un continuo de formalismo: desde argumentos heuristicos hasta demostraciones verificables por computadora |
| **Rigor** | La **implicacion logica** de nuestras oraciones: el lector deberia poder seguir la demostracion paso a paso, sin preguntarse "¿y esto por que vale?" a cada momento |

> **Importante.** Se espera que puedan escribir y leer demostraciones entre los niveles
> "razonablemente formal" y "obviamente formal". La formalidad se usa para **no cometer errores
> mientras aprenden**: deberia ayudarlos a identificar lagunas en sus razonamientos.

### Niveles de formalismo: un ejemplo

**Proposicion:** un conjunto de $n$ elementos tiene exactamente $2^n$ subconjuntos.

*Version heuristica:*

> Cada cosa puede o estar o no estar, asi que hay $2 \cdot 2 \cdots 2 = 2^n$ subconjuntos.

*Version razonablemente formal:*

> Sea $X$ un conjunto con $|X| = n$. Todo subconjunto $A \subseteq X$ queda determinado por su
> funcion indicadora $f_A : X \to \{0, 1\}$, donde $f_A(x) = 1$ si y solo si $x \in A$. La
> correspondencia $A \mapsto f_A$ es una biyeccion entre $\mathcal{P}(X)$ y las funciones de $X$
> en $\{0,1\}$, y hay exactamente $2^{|X|} = 2^n$ de tales funciones. Luego
> $|\mathcal{P}(X)| = 2^n$.

La segunda **nombra los objetos**, **explicita las relaciones**, y **cada oracion se sigue de la
anterior**.

### El antipatron: ¿los convence esta demostracion?

**Ejercicio:** calcular la complejidad de un algoritmo que utiliza $T(n)$ pasos para una entrada
de tamano $n$, donde $T(n) = 2\,T(n-4)$.

*Demostracion de un alumno (verbatim):*

> $$T(n) = 2T(n-4) = 2\big(2T(n-4-4)\big) = \cdots = 2^i\,T(n-4i)$$
> Como $n - 4i = 1 \iff i = \frac{n-1}{4}$. Luego,
> $$= 2^{\frac{n-1}{4}}\,T(1) = \left(2^{\frac{1}{4}}\right)^{n} 2^{-\frac{1}{4}} = O\!\left(\left(2^{\frac{1}{4}}\right)^{n}\right)$$

¿Los convence? ¿Y si $n$ no es congruente con 1 modulo 4? ¿Como sabemos que $T(1) = 1$?

**El resultado es cierto, pero la demostracion no muestra que el alumno entiende induccion,
funciones recursivas ni comportamiento asintotico.** La version rigurosa de esta misma
recurrencia esta mas abajo, en [[#Ahora si: $T(n) = 2\,T(n-4)$, con rigor|Ahora si: T(n) = 2 T(n-4), con rigor]].

### Terminologia

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

| Termino | Significado |
|---------|-------------|
| **Definicion** | Forma de introducir notacion nueva para un objeto matematico |
| **Axioma** | Afirmacion que se toma como valida sin demostrar (ej: axioma de induccion) |
| **Teorema/Lema/Proposicion/Corolario** | Afirmaciones demostradas |

---

## Como se demuestra: la receta de 6 pasos

Al escribir una demostracion, en general vamos a seguir estos pasos:

1. **Formalizar la consigna.** Traducir el enunciado a objetos matematicos.
2. **Comprender que se nos pide.** ¿Que asumimos? ¿Que hay que probar?
3. **Considerar ejemplos.** Jugar con casos chicos, buscar contraejemplos.
4. **Encontrar un argumento intuitivo.** ¿Por que el resultado es cierto?
5. **Elegir una estrategia.** Induccion, contradiccion, reduccion al absurdo, partir en casos,
   combinacion de estrategias, etc.
6. **Pasar en limpio.** Que el lector pueda seguir cada paso.

### Paso 1 — Formalizar la consigna

Rara vez nos dan el problema pre-formalizado. **Si formalizamos mal, todo lo que hagamos despues
es irrelevante.**

**Ejercicio:** una colonia de bacterias se triplica cada hora. Si al comenzar hay 5 bacterias,
¿cuantas hay despues de $n$ horas? Probar la respuesta.

- Habla de un proceso que se repite: una **sucesion definida por recurrencia** parece un buen
  modelo.
- ¿Se triplica exactamente? ¿Ninguna muere? ¿"Despues de $n$ horas" cuenta desde la hora 0 o
  desde la 1? **Si el enunciado no lo aclara, ¡preguntar!**

*Version formalizada:*

> Sea $b_0 = 5$, y $b_{n+1} = 3 \cdot b_n$ para todo $n \in \mathbb{N}$. Probar que:
> $\forall n \in \mathbb{N},\ b_n = 5 \cdot 3^n$.

**¿Que ganamos al formalizar?** La version formal:

- **Nombra los objetos** de los que habla (la sucesion $b$, la cantidad $b_n$, la hora $n$).
- **Explicita relaciones** formalmente sobre los mismos ($b_0 = 5$, $b_{n+1} = 3 \cdot b_n$,
  $b_n = 5 \cdot 3^n\ \forall n \in \mathbb{N}$).
- **Cuantifica** las variables usadas ("sea", "para todo", "existe").
- Usa **conectores logicos** ("si", "entonces", "luego", "porque").

Comparar con: *"despues de un rato hay el triple del triple del triple... de 5"*. ¿Cuantas veces
"el triple"? ¿$n$ o $n+1$? Distintas personas lo interpretan de distintas maneras.

### Paso 2 — Comprender que se nos pide: la conversacion

Una herramienta util: pensar la demostracion como una **conversacion** entre quien demuestra
(**Alicia**) y un **esceptico** (**Beto**).

| Objetivo | Quien juega primero |
|---|---|
| Probar $\forall x.\,P(x)$ | **Beto** elige el $x$ que quiere; Alicia tiene que responder para ese $x$. **No podemos elegir nosotros el caso comodo** |
| Probar $\exists x.\,P(x)$ | **Alicia** da un $x$ concreto y muestra que cumple $P$ |
| Probar $P \Rightarrow Q$ | Asumimos $P$ (¡y lo decimos!) y deducimos $Q$ |

En $\forall x.\exists y.\,P(x,y)$ el $y$ **puede depender** del $x$. En $\exists y.\forall x.\,P(x,y)$,
**no**. Son proposiciones completamente distintas.

**Ejemplo:** "para todo $\varepsilon > 0$ existe $\delta > 0$ tal que...": Beto da
$\varepsilon = 0{,}2$ y desafia; Alicia responde $\delta = 0{,}4$ y justifica. Nuestra
demostracion tiene que ganar esa conversacion **para cualquier jugada de Beto**.

### Paso 3 — Considerar ejemplos (pero no confundirlos con demostraciones)

- Probar casos chicos nos ayuda a entender el problema, conjeturar la respuesta, y detectar
  errores en la consigna o en nuestra intuicion.
- Buscar contraejemplos nos dice **que hipotesis son necesarias**.

> **Pero los ejemplos no demuestran.**
> **Conjetura de Goldbach.** Para todo $n \in \mathbb{N}$ par, $n > 2$, existen primos $p, q$
> tales que $n = p + q$.
> Todos los $n$ pares mayores que 2 que se verificaron hasta el momento cumplen la afirmacion...
> y jamas fue demostrada, despues de cientos de anos de intentos.

**"Verificar que es cierto para todos los casos que se me ocurren" no es una demostracion.**

### Pasos 4 a 6

El paso 4 (argumento intuitivo) y el 6 (pasar en limpio) no tienen receta: son el trabajo. El
paso 5 —elegir una estrategia— es lo que cubren las secciones que siguen: **induccion** (la
herramienta central de la materia), **correctitud de algoritmos recursivos** (induccion aplicada
a codigo) y las **otras herramientas**.

---

## Induccion

### El principio de induccion

Sea $P(n)$ una proposicion sobre los numeros naturales. Si probamos:

1. **Caso base:** $P(0)$ es cierta (podria ser otro).
2. **Paso inductivo:** para todo $n \in \mathbb{N}$, $P(n) \Rightarrow P(n+1)$.

entonces $P(n)$ es cierta para todo $n \in \mathbb{N}$.

$$P(0) \to P(1) \to P(2) \to P(3) \to P(4) \to P(5) \to \cdots$$

**Como el domino:** si cae la primera ficha, y cada ficha tira la siguiente, caen todas.

> 🔄 **Cambio respecto de cuatrimestres anteriores**
> **Ahora (2C-2026):** el caso base por defecto es **$P(0)$** ("podria ser otro"). Es coherente con todo el deck, donde $\mathbb{N}$ **incluye al 0** (ej: $b_0 = 5$, $P(0)$ en exponenciacion rapida, los cuatro casos base $P(0),\dots,P(3)$ de $T(n)=2T(n-4)$).
> **Antes:** el caso base por defecto era **$P(1)$** (o $P(a)$ para $n \geq a$).
> **Tipo:** notacion
> Fuente: raw/cursada_2C_2026/teo/teo_clase1_demostraciones.pdf

### Como se escribe una demostracion por induccion

1. **Definir explicitamente $P(n)$**, la proposicion sobre los naturales, con sus
   cuantificadores. *Este es el paso que mas se saltean... y donde nacen casi todos los errores.*
2. **Probar el caso base** (¡o los casos base — ver mas abajo!).
3. **Probar el paso inductivo:** asumir la hipotesis inductiva (HI), **decir que la asumimos**, y
   deducir $P(n+1)$, **marcando donde usamos la HI**.
4. **Concluir:** "por induccion, $P(n)$ vale para todo $n \in \mathbb{N}$".

> **Advertencia.** La induccion es **sobre naturales**. No es "sobre conjuntos", ni "sobre
> secuencias". Si quieren hacer induccion sobre otra estructura, la propiedad $P$ tiene que
> hablar de un **tamano natural** de esa estructura.

### Ejemplo: una suma geometrica

**Proposicion.** Para todo $n \in \mathbb{N}$,
$$\sum_{i=0}^{n} 3^i = \frac{3^{n+1} - 1}{2}$$

*El plan, antes de escribir:*

- **La propiedad:** $P(n) : \displaystyle\sum_{i=0}^{n} 3^i = \frac{3^{n+1}-1}{2}$.
- **Caso base:** $P(0)$. Con uno alcanza: el paso inductivo solo va a usar $P(n)$.
- **Paso inductivo:** separar el ultimo termino,
  $\displaystyle\sum_{i=0}^{n+1} 3^i = \left(\sum_{i=0}^{n} 3^i\right) + 3^{n+1}$: ahi entra la HI.

> ⚠️ Verificar — el PDF sólo da el plan; la demostración completa se hizo en el pizarrón.

*Revisen si:* definimos $P$, probamos el caso base y dijimos donde usamos la HI.

### El caso base no tiene por que ser 0

A veces la propiedad vale recien a partir de un $n_0 > 0$. La induccion funciona igual,
empezando el caso base en $n_0$.

**Proposicion.** Para todo $n \geq 4$, $n! > 2^n$.

- **¿Y para $n < 4$?** $0! = 1 = 2^0$, $1! = 1 < 2$, $2! = 2 < 4$, $3! = 6 < 8$: la propiedad es
  **falsa**. El caso base corrido **no es un capricho**.
- El caso base pasa a ser $P(4)$, y en el paso inductivo tomamos $n \geq 4$: la HI la tenemos
  **solo a partir de ahi**.

> ⚠️ Verificar — el PDF sólo da el plan; la demostración completa se hizo en el pizarrón.

*Pregunta para despues del pizarron:* ¿en que paso exacto se usa que $n \geq 4$?

**Ejemplo resuelto (material historico), con caso base corrido en 1:** demostrar que
$2^n \leq (n+1)!$ para todo $n \in \mathbb{N}$.

- **Base ($n=1$):** $2^1 = 2$ y $(1+1)! = 2$. Vale $2 \leq 2$.
- **Paso inductivo:** suponemos $2^n \leq (n+1)!$. Entonces:

$$2^{n+1} = 2 \cdot 2^n \leq 2 \cdot (n+1)! \leq (n+2)(n+1)! = (n+2)!$$

La ultima desigualdad vale porque $n+2 \geq 2$. $\blacksquare$

### Induccion fuerte (o global, o completa)

A veces para probar $P(n)$ no nos alcanza con $P(n-1)$: necesitamos la propiedad para varios (o
todos los) valores anteriores.

> **Principio de induccion fuerte.** Si para todo $n \in \mathbb{N}$ vale
> $$\Big(\forall k \in \mathbb{N}.\ k < n \Rightarrow P(k)\Big) \Rightarrow P(n)$$
> entonces $P(n)$ es cierta para todo $n \in \mathbb{N}$.

La hipotesis inductiva ahora es: **"$P$ vale para todos los $k < n$"**.

Es la herramienta natural cuando **la recursion "salta"**: $T(n)$ definido con $T(n-4)$, $a_n$
definido con $a_{n-1}$ y $a_{n-2}$, $\mathrm{Exp}(a,n)$ que llama a
$\mathrm{Exp}(a, \lfloor n/2 \rfloor)$, ...

Es **equivalente** a la induccion comun, pero **mucho mas comoda** para recursiones.

### ¡Cuidado con cuantos casos base necesitamos!

> **Advertencia.** Si nuestra demostracion de $P(n)$ usa $P(n-1), P(n-2), \ldots, P(n-k)$ para un
> $k \geq 1$ fijo, entonces **necesitamos $k$ casos base**. Para $n < k$, "$P(n-k)$" no tiene
> sentido: **nos caemos de $\mathbb{N}$**.

| La demostracion usa | Casos base a probar a mano |
|---|---|
| $P(n-1)$ y $P(n-2)$ | $P(0)$ y $P(1)$ |
| $P(n-4)$ | $P(0)$, $P(1)$, $P(2)$, $P(3)$ |
| $P(\lfloor n/2 \rfloor)$ con induccion fuerte | **Uno solo**, $P(0)$: porque $\lfloor n/2 \rfloor < n$ para todo $n \geq 1$ y nunca nos caemos de $\mathbb{N}$ |

> **Esta regla es la version general de dos de los [[#Errores comunes en demostraciones|errores comunes]]
> catalogados mas abajo:** el "caso base faltante" (el paso inductivo no cubre $n=2$) y el
> "usar hipotesis no establecida" (el paso usa $P(n-2)$ con un solo caso base). Ambos son
> instancias de contar mal cuantos casos base pide el paso inductivo. Los ejercicios 7 y 8 de
> [[demostraciones_induccion_guia]] son exactamente esos dos errores.

### Ahora si: $T(n) = 2\,T(n-4)$, con rigor

Volviendo al [[#El antipatron: ¿los convence esta demostracion?|antipatron del alumno]], *el plan
para hacerla bien:*

1. **Definir $T$ con su dominio:** sea $T : \mathbb{N} \to \mathbb{N}$ tal que $T(n) = 2\,T(n-4)$
   para todo $n \geq 4$. De $T(0), \ldots, T(3)$ no sabemos nada: sea
   $a = \max(T(0), T(1), T(2), T(3))$.
2. **Definir la propiedad:** $P(n) : T(n) \leq a \cdot 2^{\frac{n}{4}}$.
3. **Cuatro casos base** ($0 \leq n \leq 3$): la recursion resta 4.
4. **Paso inductivo (induccion fuerte):** para $n \geq 4$, $0 \leq n-4 < n$ legitima usar
   $P(n-4)$.
5. **Concluir con la definicion de $O$:** exhibir constantes concretas $c$ y $n_0$ (ver
   [[complejidad_computacional_teoria]]).

> ⚠️ Verificar — el PDF sólo da el plan; la demostración completa se hizo en el pizarrón.

Mismo resultado que el alumno del principio, pero **ahora sin baches**: dominio claro, cuatro
casos base, HI explicita, y la definicion de $O$ aplicada con constantes concretas.

### ¿Y si mi objeto tiene dos "tamanos"? Induccion en tuplas

A veces el estado natural del problema es un par $(a, b)$: una celda de una matriz, dos indices
de una recursion... ¿En que hacemos induccion?

> **Necesitamos un orden bien fundado.** Un orden $\prec$ sobre los pares tal que **no haya
> cadenas infinitas decrecientes**. Entonces podemos usar induccion fuerte: para probar
> $P(a,b)$ podemos asumir $P(a', b')$ para todo $(a', b') \prec (a, b)$.

Dos elecciones habituales:

- **Por una medida:** $(a', b') \prec (a, b)$ si $a' + b' < a + b$ (o si $b' < b$, si la recursion
  solo achica la segunda componente). Reduce todo a induccion en un natural.
- **Lexicografico:** $(a', b') \prec (a, b)$ si $a' < a$, o si $a' = a$ y $b' < b$.

**Lo importante: definir el orden explicitamente antes de largar la induccion.**

---

## Correctitud de algoritmos recursivos

Si nuestro algoritmo es recursivo, en general vamos a usar induccion para probar su correctitud:

1. **Definir una nocion de tamano de la entrada** (un natural que **decrece** en cada llamada
   recursiva).
2. **Definir $P(n)$:** "para toda entrada de tamano $n$, el algoritmo devuelve lo correcto".
3. **Probar $P$ por induccion** (casi siempre **fuerte**: las llamadas recursivas son a tamanos
   menores, no necesariamente a $n-1$).

### Ejemplo: exponenciacion rapida, recursiva

Sean $a \in \mathbb{N}$ y $n \in \mathbb{N}$.

```
procedure Exp(a, n)
    if n = 0 then
        return 1
    b ← Exp(a, ⌊n/2⌋)
    c ← b²
    if n mod 2 = 1 then
        c ← c × a
    return c
```

¿En que hacemos induccion? La llamada recursiva es con $\lfloor n/2 \rfloor < n$ (para
$n \geq 1$): **induccion fuerte en $n$, el exponente**.

*El plan de la demostracion:*

1. **La propiedad habla del exponente:** $P(n)$: para todo $a \in \mathbb{N}$,
   $\mathrm{Exp}(a, n) = a^n$. El $\forall a$ va **adentro** de $P(n)$: la HI sirve para
   cualquier base.
2. **Caso base $P(0)$:** el primer `if`.
3. **Paso inductivo con induccion fuerte:** usamos la HI en $\lfloor n/2 \rfloor < n$, **no** en
   $n-1$.
4. **Partir en casos segun la paridad de $n$**, igual que el algoritmo (el segundo `if`).

> ⚠️ Verificar — el PDF sólo da el plan; la demostración completa se hizo en el pizarrón.

Los algoritmos recursivos suelen ser **mas faciles de demostrar correctos que los iterativos**
(que necesitan invariantes): no hay estado que se modifica, solo llamadas a subproblemas menores.

> **Nota de cruce.** El mismo algoritmo aparece en [[divide_y_conquista_guia]] **Ejercicio 5
> (PotenciaLogaritmica)**, pero con **otro rol**: alli se pide *disenarlo* como algoritmo D&C y
> justificar su complejidad $O(\log b)$; aca se lo usa como caso de estudio de *correctitud* por
> induccion fuerte. Son dos preguntas distintas sobre el mismo codigo — vale tener las dos.

### De la demostracion al codigo (y a los tests)

Una **formula cerrada demostrada** es un **oraculo perfecto** para testear la version recursiva
(y viceversa):

```cpp
long long suma_geom(int n) {
    // 3^0 + 3^1 + ... + 3^n
    if (n == 0) return 1;
    return suma_geom(n - 1) + pot3(n);   // pot3(n) = 3^n
}

void test() {
    for (int n = 0; n <= 30; ++n) {
        // formula cerrada demostrada hoy: (3^(n+1) - 1) / 2
        assert(suma_geom(n) == (pot3(n + 1) - 1) / 2);
    }
}
```

El test compara **dos caminos independientes hacia el mismo valor**: si difieren, algo esta mal
(el codigo... o la demostracion).

> **Cuidado con los limites del tipo de dato:** $3^{31}$ no entra en un `int`.

---

## Otras herramientas: contrarreciproco, contradiccion, palomar, minimo elemento

> 🔄 **Cambio respecto de cuatrimestres anteriores**
> **Ahora (2C-2026):** el eje del tema es **induccion + correctitud de algoritmos recursivos**; contrarreciproco, contradiccion, principio del palomar y buen orden se presentan agrupados como "otras herramientas" para cuando el camino directo no sale.
> **Antes:** el tema se organizaba como **8 estrategias en paralelo con igual peso** (directa, por casos, contradiccion, contrarreciproco, por construccion, induccion, contraejemplos, doble implicacion).
> **Tipo:** alcance
> Fuente: raw/cursada_2C_2026/teo/teo_clase1_demostraciones.pdf

Las estrategias del listado viejo que la clase 1 vigente **no cubre** siguen en esta pagina, mas
abajo, marcadas con 📎.

### Contrarreciproco

Probar $P \Rightarrow Q$ es **equivalente** a probar $\neg Q \Rightarrow \neg P$.

**Ejemplo.** Si $n^2$ es par, entonces $n$ es par.

*Demostracion.* Por contrarreciproco: si $n$ es impar, $n = 2k+1$ para algun $k \in \mathbb{N}$,
entonces
$$n^2 = 4k^2 + 4k + 1 = 2(2k^2 + 2k) + 1$$
es impar. $\blacksquare$

> **ERROR COMUN:** el contrarreciproco de $P \Rightarrow Q$ es $\neg Q \Rightarrow \neg P$,
> **NO** $\neg P \Rightarrow \neg Q$.

### Contradiccion (absurdo)

Para probar $P$: **asumimos $\neg P$, y derivamos algo falso.** Decir explicitamente "asumimos
por contradiccion que...", y **marcar donde aparece el absurdo**.

> **Cuidado:** en una demostracion por contradiccion, **todo lo que deducimos vive bajo una
> suposicion falsa**. Ser ordenados es todavia mas importante.

Los dos ejemplos de contradiccion de la clase vigente son el
[[#El principio del palomar|principio del palomar]] y el
[[#El truco del "primer elemento que cumple"|divisor primo]], ambos mas abajo.

> 🔄 **Cambio respecto de cuatrimestres anteriores**
> **Ahora (2C-2026):** el ejemplo "$n^2$ par $\Rightarrow$ $n$ par" se usa **solo** para ilustrar contrarreciproco. Para contradiccion se usan el principio del palomar y la existencia de divisor primo.
> **Antes:** el mismo ejemplo "$n^2$ par $\Rightarrow$ $n$ par" se usaba **para las dos** estrategias, con esta version "por contradiccion": *supongamos $n^2$ par y $n$ impar ($n = 2k+1$); entonces $n^2 = 2(2k^2+2k)+1$ es impar, contradiccion*. Esa version es **un contrarreciproco disfrazado**: asume $n^2$ par pero **nunca usa esa hipotesis** — el argumento entero sale de "$n$ impar".
> **Tipo:** enfoque de demostracion
> Fuente: raw/cursada_2C_2026/teo/teo_clase1_demostraciones.pdf

### El principio del palomar

> **Principio del palomar (version simple).** Si repartimos $m$ objetos en $n$ cajas y $m > n$,
> entonces alguna caja tiene al menos **2** objetos.

*Demostracion.* Por contradiccion: supongamos que toda caja tiene a lo sumo 1 objeto. Sea $c_i$
la cantidad de objetos de la caja $i$. Entonces
$$m = \sum_{i=1}^{n} c_i \leq \sum_{i=1}^{n} 1 = n$$
contradiciendo $m > n$. Luego alguna caja tiene al menos 2 objetos. $\blacksquare$

La misma idea **con promedios**: alguna caja tiene al menos $\left\lceil \frac{m}{n} \right\rceil$
objetos ("no pueden estar todas por debajo del promedio").

> **Donde se usa en el wiki:**
> - [[grafos_practica]] **Ejercicio 1 — Misma cantidad de amigos**: $n$ personas, grados en
>   $\{0, \ldots, n-1\}$, pero grado $0$ y grado $n-1$ no pueden coexistir → solo $n-1$ valores
>   posibles para $n$ vertices → dos con el mismo grado.
> - [[grafos_guia]] **Ejercicio 6 — ModeladoBasico**: el mismo argumento planteado sobre el
>   modelado social.
> - [[grafos_guia]] **Ejercicio 2 — DobleGrado** es la version en lenguaje de grafos.
>
> El enunciado formal del principio y su demostracion viven **aca**; los ejercicios lo aplican.

### El truco del "primer elemento que cumple"

$\mathbb{N}$ esta **bien ordenado**: todo subconjunto no vacio de $\mathbb{N}$ tiene minimo. Esto
habilita un truco que muchas veces **reemplaza una induccion engorrosa**: "sea $i$ el primer
indice tal que...", "sea $x$ el minimo elemento que...".

**Ejemplo.** Todo natural $n \geq 2$ tiene un divisor primo.

*Demostracion.* Sea $D = \{d \in \mathbb{N} \mid d \geq 2,\ d \mid n\}$. $D \neq \emptyset$
porque $n \in D$. Sea $p = \min D$. Si $p$ no fuera primo, tendria un divisor $d$ con
$2 \leq d < p$; pero $d \mid p$ y $p \mid n$ implican $d \mid n$, entonces $d \in D$ y $d < p$,
contradiciendo la minimalidad de $p$. Luego $p$ es primo. $\blacksquare$

> **¡Hay que justificar que el conjunto es no vacio!** Si no, el "minimo" no existe.

*Adelanto:* vuelve todo el tiempo en el resto de la materia ("la primera iteracion en la
que...", "el primer momento en que...").

### Demostracion directa

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

Secuencia de implicaciones: $A \Rightarrow B \Rightarrow C \Rightarrow \cdots \Rightarrow Z$.

**Ejemplo:** demostrar que dos cuadrados perfectos consecutivos difieren en un numero impar.

Sean $a = (n+1)^2$ y $b = n^2$ cuadrados perfectos consecutivos con $a > b$. Entonces:

$$a - b = (n+1)^2 - n^2 = n^2 + 2n + 1 - n^2 = 2n + 1$$

que es impar. $\blacksquare$

### Por casos

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

Para demostrar $P \Rightarrow Q$, partir $P$ en $P_1, \ldots, P_q$ y probar $P_i \Rightarrow Q$
para todo $i$.

**Ejemplo:** demostrar que si $n \in \mathbb{Z}$, entonces $n(n+1)$ es par.

- **Caso $n$ par:** $n = 2k \Rightarrow n(n+1) = 2k(2k+1)$, que es par.
- **Caso $n$ impar:** $n = 2k+1 \Rightarrow n(n+1) = (2k+1)(2k+2) = 2(2k+1)(k+1)$, que es par.
  $\blacksquare$

### Por construccion

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

Para proposiciones de existencia, basta con mostrar un ejemplo.

**Ejemplo:** demostrar que existe $f : \mathbb{R} \to \mathbb{R}$ par e impar a la vez.

- Par: $f(x) = f(-x)$. Impar: $f(x) = -f(-x)$.
- Forzando ambas: $f(x) = 0$ para todo $x$. La funcion nula es par e impar. $\blacksquare$

### Contraejemplos

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

Si una afirmacion es falsa, basta encontrar un ejemplo que lo demuestre.

**Ejemplo:** "$AB = 0_{n \times n} \Rightarrow A = 0 \lor B = 0$" es falso.

$$A = \begin{pmatrix} 1 & 0 \\ 0 & 0 \end{pmatrix}, \quad B = \begin{pmatrix} 0 & 0 \\ 0 & 1 \end{pmatrix} \quad \Rightarrow \quad AB = \begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}$$

Ninguna es la matriz nula, pero el producto si lo es. $\blacksquare$

### Doble implicacion

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

Para demostrar $P \iff Q$ se debe demostrar **ambas direcciones**: $P \Rightarrow Q$ y
$Q \Rightarrow P$.

---

## Errores comunes en demostraciones

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

> Los dos errores de induccion de esta seccion son **instancias particulares** de la regla
> general de [[#¡Cuidado con cuantos casos base necesitamos!]]
> (clase 1, 2C-2026): contar mal cuantos casos base exige el paso inductivo.

### Razonamiento circular

Asumir lo que se quiere probar. Ejemplo: "Si los elementos son iguales, entonces $x_a = x_b$.
Como tomamos cualquier par..." — esto **asume** la tesis.

### Induccion: caso base faltante

Intentar probar que todos los elementos de un conjunto son iguales: el paso inductivo funciona
para $n \geq 3$, pero **falla para $n=2$** (no hay "conjunto previo" que conecte los dos
elementos). Falta verificar el caso base $n=2$.

*Es el caso "el paso inductivo usa mas de lo que el caso base cubre" de la regla general.*

### Induccion: usar hipotesis no establecida

Probar "$a^n = 1$ para todo $a \neq 0$": el paso inductivo usa $a^{n-1} = 1$ **y**
$a^{n-2} = 1$, pero la HI solo garantiza $P(n-1)$, no $P(n-2)$.

*Es exactamente el caso "$P(n-1)$ y $P(n-2)$ → hacen falta dos casos base" de la tabla de la
regla general.*

---

## Ejemplo resuelto: Poda por optimalidad (Ejercicio 3c de guia)

> 📎 Sin contrastar con la cursada 2C-2026 — este bloque viene de cuatrimestres anteriores y el material vigente ingestado hasta ahora no lo cubre.

### Enunciado

Dada una matriz simetrica $M$ de $n \times n$ numeros naturales y un numero $k$, encontrar un
subconjunto $I$ de $\{1, \ldots, n\}$ con $|I| = k$ que maximice $\sum_{i,j \in I} M_{ij}$.
Proponer una poda por optimalidad y mostrar que es correcta.

### Definiciones formales

- **Solucion parcial** hasta iteracion $it$: $I_{it} \subseteq \{1, \ldots, it\}$.
- **Extension** de $I_{it}$: un conjunto $I$ tal que $I_{it} \subseteq I$ y
  $I \setminus I_{it} \subseteq \{it+1, \ldots, n\}$.

### Poda propuesta

Si la mejor solucion hasta ahora es $I_{mejor}$ con $\sum_{i,j \in I_{mejor}} M_{ij} = q$, y la
solucion parcial $I_{it}$ cumple:

$$\sum_{i,j \in I_{it} \cup \{it+1, \ldots, n\}} M_{ij} \leq q$$

entonces no existe extension $I$ de $I_{it}$ tal que $\sum_{i,j \in I} M_{ij} > q$.

### Demostracion de correctitud

Sea $I$ cualquier extension de $I_{it}$. Como $I = I_{it} \cup (I \setminus I_{it})$ con
$I_{it} \cap (I \setminus I_{it}) = \emptyset$:

$$\sum_{i \in I}\sum_{j \in I} M_{ij} = \sum_{i \in I_{it}}\sum_{j \in I_{it}} M_{ij} + \sum_{i \in I_{it}}\sum_{j \in I \setminus I_{it}} M_{ij} + \sum_{i \in I \setminus I_{it}}\sum_{j \in I_{it}} M_{ij} + \sum_{i \in I \setminus I_{it}}\sum_{j \in I \setminus I_{it}} M_{ij}$$

Como $I \setminus I_{it} \subseteq \{it+1, \ldots, n\}$ y los $M_{ij}$ son numeros naturales (no
negativos), reemplazar $I \setminus I_{it}$ por el conjunto completo $\{it+1, \ldots, n\}$ solo
puede aumentar la suma:

$$\sum_{i \in I}\sum_{j \in I} M_{ij} \leq \sum_{i,j \in I_{it} \cup \{it+1, \ldots, n\}} M_{ij} \leq q$$

Por lo tanto, ninguna extension de $I_{it}$ puede superar $q$, y la poda es correcta.
$\blacksquare$

> **Nota sobre solucion incorrecta de cubawiki:** La poda "si agregando todos los indices
> restantes no llego a $k$, detengo esa rama" es una poda de **factibilidad**, no de
> optimalidad. No compara con la mejor solucion encontrada, solo verifica si se puede alcanzar
> tamano $k$.

---

## Tips para escribir demostraciones

**De la clase 1 (2C-2026):**

1. **Definan $P(n)$ explicitamente**, con todos sus cuantificadores, **antes de empezar**.
2. **Cuenten cuantos casos base** necesita su paso inductivo (¿usa $P(n-1)$? ¿$P(n-2)$?
   ¿$P(n-4)$?).
3. **Digan donde usan la HI**, y verifiquen que el valor donde la usan **cae dentro de
   $\mathbb{N}$** (y del rango donde vale).
4. **Ponganle nombre a todo, cuantifiquen todo, y no reusen nombres.**
5. Si "sea $x$ el minimo tal que...": **prueben que el conjunto es no vacio**.
6. **Relean su demostracion como Beto**, el esceptico: ¿en que oracion le mentirian?

**De material de cuatrimestres anteriores (complementarios, no contradicen a los de arriba):**

7. **Si estas en duda, explica de mas.**
8. **Empeza definiendo todo formalmente.**
9. Cualquier cosa que escribas, preguntate: ¿por que vale? Si la respuesta es "porque obvio", no
   sabes por que vale.
10. **¿Sin idea de como seguir?** Volve a las definiciones. ¿Que resultados vimos en teoria sobre
    los temas del ejercicio?
11. Para demostrar minimalidad, demostrar que cualquier otro es $\geq$. Para igualdad de
    conjuntos, doble contencion.

## Sobre como aprender esto

- **Nadie aprendio a andar en bicicleta viendo a otros andar.** Por cada minuto que pasen leyendo
  demostraciones, pasen cinco **escribiendo las suyas**.
- **Les va a tomar tiempo.** Es frecuente que un ejercicio lleve horas. No esta mal: el
  aprendizaje sucede cuando piensan, intentan, fallan y reflexionan, no cuando "termina el
  ejercicio".
- Si llegaron de $P$ a $Q$ pero **no estan seguros** de que lo que hicieron esta bien, **no
  terminaron** el ejercicio. Si no los convence a ustedes, no va a convencer a ningun par.
- **No acepten algo como cierto solo porque lo dice un docente (o una IA).** Si no lo pueden
  demostrar, no saben si es cierto.
- **No hay trucos: solo sudor y tiza.**

## Cuando se aplica

Este contenido es transversal a toda la materia. Cada tecnica (D&C, PD, Greedy, Backtracking)
requiere demostraciones de correctitud y optimalidad. Las estrategias aqui presentadas son las
herramientas fundamentales.

En particular, la seccion de **correctitud de algoritmos recursivos** es la que se aplica
directamente en D&C, Backtracking y PD top-down; la de **induccion fuerte** es la que aparece en
casi todas las demostraciones de correctitud del wiki.

## Bibliografia

Bibliografia recomendada por la catedra en la clase 1 (2C-2026):

- F. Lebron, *Demostraciones matematicas*.
- I. S. Sominskii, *El metodo de la induccion matematica*.
- G. Polya, *How to Solve It*.
- D. J. Velleman, *How to Prove It*.
- T. Cormen, C. Leiserson, R. Rivest, C. Stein, *Introduction to Algorithms*, caps. 2-4
  (analisis de algoritmos, notacion asintotica, recurrencias).
- J. Kleinberg, E. Tardos, *Algorithm Design*, cap. 2 (fundamentos de analisis de algoritmos).

## Ver tambien

- [[complejidad_computacional_teoria]] — definiciones de $O$, $\Omega$, $\Theta$ y como demostrar
  pertenencia (repaso de complejidad asintotica de esta misma clase)
- [[demostraciones_induccion_guia]] — 8 ejercicios de induccion; los ej. 7 y 8 son los errores
  clasicos de casos base catalogados aca
- [[grafos_practica]] — Ejercicio 1 aplica el principio del palomar
- [[grafos_guia]] — Ejercicios 2 y 6 aplican el principio del palomar
- [[divide_y_conquista_guia]] — Ejercicio 5 (PotenciaLogaritmica) es el mismo algoritmo de
  exponenciacion rapida, visto como diseno D&C en vez de como correctitud
- [[fuerza_bruta_backtracking_teoria]] — el ejemplo resuelto es una poda por optimalidad en
  backtracking
- [[greedy_teoria]] — demostraciones de optimalidad de algoritmos golosos usan intercambio
- [[programacion_dinamica_teoria]] — demostraciones por induccion para correctitud de recurrencias
