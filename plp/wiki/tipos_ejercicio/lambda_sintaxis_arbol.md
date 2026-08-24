---
nombre: Cálculo Lambda — parentización y árbol sintáctico
parcial: 1P
programa: 2C_2026
tipo: tipo_ejercicio
tema: calculo_lambda_tipado
---

# Cálculo Lambda — parentización y árbol sintáctico

## Como reconocer este patron

- El enunciado pide **"insertar todos los paréntesis de acuerdo a la convención usual"** o "parentizar completamente"
- Pide **"dibujar el árbol sintáctico"** de un término
- Pide **"indicar qué ocurrencias de variables son libres y cuáles ligadas"**, o calcular $fv(M)$
- Pide **"¿ocurre X como subtérmino de M?"** — la respuesta depende enteramente de cómo parentiza
- Pide **"rectificar el término"** (renombrar ligadas para que no colisionen con libres) — variante que aparece en 2P como paso previo al algoritmo de inferencia
- Señal fuerte: el término se escribe **sin paréntesis** y con varias aplicaciones seguidas ($u\,x\,(y\,z)\,\dots$), o con tipos flecha encadenados ($\text{Bool} \to \text{Nat} \to \text{Bool}$)

Este patrón casi nunca vale puntos por sí solo, pero es **prerrequisito de todo lo demás**: si parentizás mal, la derivación de tipado, el algoritmo W/I y la reducción salen mal aunque el resto del procedimiento sea correcto.

## Template de resolucion

### Paso 1 — Las tres convenciones (memorizar literal)

| Convención | Regla | Ejemplo |
|---|---|---|
| **Aplicación asocia a IZQUIERDA** | $M\,N\,P = (M\,N)\,P$ | $u\,x\,y = ((u\,x)\,y)$, **no** $u\,(x\,y)$ |
| **Cuerpo del $\lambda$ se estira a la DERECHA** | $\lambda x{:}\tau.\,M\,N = \lambda x{:}\tau.\,(M\,N)$ | el $\lambda$ se come todo hasta el `)` que lo cierra o el fin del término |
| **Flecha de tipos asocia a DERECHA** | $\sigma \to \tau \to \rho = \sigma \to (\tau \to \rho)$ | $\text{Bool} \to \text{Nat} \to \text{Bool} = \text{Bool} \to (\text{Nat} \to \text{Bool})$ |

Corolario de precedencias: **la aplicación liga más fuerte que $\lambda$ y que `if`**. Es decir, $\lambda$ e `if` tienen *menor* precedencia; la aplicación se arma primero.

### Paso 2 — Algoritmo de parentización

```
1. Parentizar los TIPOS de cada anotación λx:τ primero (flecha a derecha).
   Bool -> Nat -> Bool   =>   Bool -> (Nat -> Bool)

2. Localizar cada λ y cada if. Su cuerpo/rama-else se extiende hasta el
   final del término o hasta el paréntesis que ya lo cierra.
   Encerrar ese cuerpo entre paréntesis.

3. Dentro de cada bloque, agrupar las aplicaciones DE A DOS, de izquierda
   a derecha:
        M1 M2 M3 M4  =>  ((M1 M2) M3)  =>  (((M1 M2) M3) M4)
   Un paréntesis YA ESCRITO en el enunciado es un átomo: no se rompe.

4. Repetir 2-3 recursivamente dentro de cada subtérmino.
```

Ejemplo completo (Ej. 4a de la guía):
$$u\,x\,(y\,z)\,(\lambda v{:}\text{Bool}.\,v\,y) \;=\; \Big(\big((u\,x)\,(y\,z)\big)\,\big(\lambda v{:}\text{Bool}.\,(v\,y)\big)\Big)$$

### Paso 3 — Dibujar el árbol sintáctico

Un nodo por constructor de la gramática:

| Constructor | Nodo | Hijos |
|---|---|---|
| $x$ (variable) | hoja con el nombre | — |
| $M\,N$ (aplicación) | `@` | 2: función (izq) y argumento (der) |
| $\lambda x{:}\tau.\,M$ (abstracción) | `λx:τ` | **1**: el cuerpo $M$ |
| $\text{if } M \text{ then } N \text{ else } P$ | `if` | 3 |
| $\text{true}$, $\text{false}$, $\text{zero}$ | hoja | — |

Regla mecánica: **cada `(` de la parentización completa es un nodo**. El término entero es la raíz.

```
      u x (y z) (λv:Bool. v y)

                @
              /   \
            @      λv:Bool
          /   \        |
        @      @       @
       / \    / \     / \
      u   x  y   z   v   y
     (F) (F)(F) (F) (L) (F)
```

Truco: en una cadena de aplicaciones $M_1\,M_2\,\dots\,M_n$, el árbol es un **peine que baja hacia la izquierda** — $M_n$ cuelga arriba a la derecha, $M_1$ queda en la hoja más profunda de la izquierda.

### Paso 4 — Libres vs. ligadas, leído sobre el árbol

```
Una ocurrencia de x es LIGADA  <=>  subiendo desde esa hoja hasta la raíz
                                    se cruza algún nodo λx (mismo nombre).
Una ocurrencia de x es LIBRE   <=>  no se cruza ninguno.
```

- Se marca **por ocurrencia**, no por nombre: el mismo nombre puede tener una ocurrencia libre y otra ligada en el mismo término.
- Si hay varios $\lambda x$ anidados, liga el **más cercano** (el primero que se encuentra subiendo). Esto es *shadowing*.
- La $x$ de la anotación $\lambda x{:}\tau$ es la **ocurrencia ligadora**: no es un nodo del árbol ni un subtérmino.
- $fv(M)$ = conjunto de nombres con al menos una ocurrencia libre.

Definición inductiva de respaldo, por si hay que justificar:
$$fv(x) = \{x\} \qquad fv(M\,N) = fv(M) \cup fv(N) \qquad fv(\lambda x{:}\tau.\,M) = fv(M) \setminus \{x\}$$

### Paso 5 — "¿Ocurre P como subtérmino de M?"

**Subtérmino = subárbol completo**, es decir un nodo con *todos* sus descendientes. Procedimiento:

1. Parentizar $M$ completamente.
2. Parentizar $P$ completamente.
3. Buscar $P$ como nodo. Si las piezas de $P$ están en el árbol pero como **hermanos de niveles distintos**, la respuesta es **no**.

Contraste típico:

| Término | ¿Ocurre $(\lambda\dots)\,u$? | Por qué |
|---|---|---|
| $(\lambda\dots)\,u\,v\,w = \big(\big((\lambda\dots)\,u\big)\,v\big)\,w$ | **Sí** | $(\lambda\dots)\,u$ es el nodo más profundo del peine |
| $w\,(\lambda\dots)\,u\,v = \big(\big(w\,(\lambda\dots)\big)\,u\big)\,v$ | **No** | $\lambda\dots$ ya está apareado con $w$; nunca forma nodo con $u$ |

### Paso 6 (variante 2P) — Rectificar

Rectificar = renombrar por $\alpha$-conversión las variables **ligadas** que comparten nombre con alguna **libre** (o con otra ligada de un $\lambda$ externo), de modo que todos los ligadores usen nombres frescos y distintos.

```
1. Calcular fv(M).
2. Recorrer los λ de afuera hacia adentro.
3. Si el ligador λx tiene x ∈ fv(M), o ya se usó ese nombre en un λ
   más externo => renombrar x por un nombre fresco en el ligador y en
   TODAS las ocurrencias que ese λ liga (no en las libres).
4. Las ocurrencias libres NUNCA se tocan.
```

Ejemplo (2P 2C 2025): $(\lambda y.\,\text{map } x \mapsto \text{if } x \text{ then } y \text{ else } 0 \text{ in } \dots \bullet x)\,(y\,x)$ — acá $x$ e $y$ aparecen libres *y* ligadas; se renombra $x \mapsto e$, $y \mapsto z$ **sólo en las posiciones ligadas**, y el $(y\,x)$ final queda intacto porque ahí son libres.

### Errores tipicos al restaurar parentesis

| Error | Síntoma | Corrección |
|---|---|---|
| Parentizar la aplicación a derecha | escribir $u\,(x\,y)$ en vez de $(u\,x)\,y$ | la aplicación es **a izquierda**, siempre |
| Cerrar el $\lambda$ antes de tiempo | $\lambda x{:}\tau.\,M\,N$ leído como $(\lambda x{:}\tau.\,M)\,N$ | el cuerpo **se estira**: es $\lambda x{:}\tau.\,(M\,N)$ |
| Parentizar la flecha a izquierda | $(\sigma \to \tau) \to \rho$ cuando decía $\sigma \to \tau \to \rho$ | flecha **a derecha**; $(\sigma\to\tau)\to\rho$ es un tipo **distinto** |
| Mezclar asociatividades en la unificación | en el algoritmo W aparece un *occur check* espurio ($X = X \to X$) | re-parentizar el tipo antes de descomponer la ecuación |
| Tratar la $x$ del ligador como ocurrencia | contar ocurrencias de más, o decir que $x$ ocurre como subtérmino de $\lambda x{:}\tau.\,\text{succ}(y)$ | el ligador **no** es nodo del árbol |
| Marcar libre/ligada por nombre y no por ocurrencia | decir "$y$ es ligada" cuando sólo una de sus dos ocurrencias lo es | marcar **cada hoja** por separado |
| Ignorar el shadowing | atribuir la ocurrencia al $\lambda$ externo | liga el $\lambda$ **más cercano** subiendo hacia la raíz |
| Confundir "está adentro" con "es subtérmino" | responder que $x\,(y\,z)$ es subtérmino de $u\,x\,(y\,z)$ | tiene que ser un **subárbol completo** |

## Por que funciona

La gramática del cálculo lambda es ambigua si se la escribe sin paréntesis: $M\,N\,P$ admite dos árboles de derivación, y $\lambda x{:}\tau.\,M\,N$ también. Las convenciones de asociatividad y precedencia son exactamente el mecanismo que **desambigua** la notación: fijan una única lectura, y por lo tanto un único árbol sintáctico.

Todo lo demás del cálculo lambda está definido **por inducción estructural sobre ese árbol** — $fv(M)$, la sustitución $M\{x := N\}$, las reglas de tipado, las reglas de reducción. Cada regla mira la forma del *nodo raíz* del término. Por eso, si el árbol está mal armado, la regla que se aplica es la equivocada y todo el ejercicio se cae: un $\big((\lambda x.M)\,N\big)\,P$ mal leído como $(\lambda x.M)\,(N\,P)$ genera una $\beta$-reducción distinta y un tipo distinto.

Las nociones de libre y ligada también son estructurales: el $\lambda$ delimita un **alcance** (su único hijo, el cuerpo), y una ocurrencia es ligada precisamente cuando cae dentro del alcance de un ligador homónimo. De ahí que "recorrer el camino a la raíz" sea un procedimiento correcto y completo. La $\alpha$-equivalencia — que permite rectificar — es válida justamente porque el nombre de una variable ligada no participa de ninguna regla: sólo importa **qué ligador la liga**, o sea la forma del árbol.

## Apariciones en parciales

**Este patrón no aparece como ítem puntuado independiente en ningún parcial analizado.** No hay ningún ejercicio de parcial que diga "parentizar" o "dibujar el árbol sintáctico". Aparece siempre como **sub-habilidad embebida** dentro de ejercicios de inferencia y de semántica, y es ahí donde se pierden puntos:

- [[parciales_analizados/1.parcial_1C_2024_recuperatorio_resolucion(1)]] — **Ej. 2b.i**: algoritmo W sobre $(\lambda x.\,x\,(\lambda x.\,\text{Succ}(x)))\,(\lambda x.\,x)$. El término tiene tres $\lambda x$ anidados (shadowing puro). La nota de corrección registra que *el alumno se equivocó con los paréntesis y llegó a un Occur Check espurio* (`X5 = X5 -> X5`); con la parentización correcta el término sí tipa, con tipo $(\text{Nat} \to \text{Nat}) \to (\text{Nat} \to \text{Nat})$. El análisis del mismo parcial cierra con: *"un error común es mezclar asociatividades; las flechas asocian a derecha (`A -> B -> C` es `A -> (B -> C)`), lo cual hay que respetar en las sustituciones"*.
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — **Ej. 3a.i**: "Rectificar el término". Exige distinguir ocurrencia por ocurrencia cuáles de $x$ e $y$ son libres y cuáles ligadas, y renombrar sólo las ligadas ($x \mapsto e$, $y \mapsto z$).
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — **Ej. 3a.i**: "Rectificar término" sobre un `foldRG` con $(\lambda z.\,x)(z\,y)$ — mismo mecanismo: $z$ ligada en un lado y libre en el otro.

Lectura para el examen: **estudiarlo como higiene, no como ejercicio**. El rédito está en no perder un ejercicio de 3-4 puntos de inferencia o de reducción por una parentización mal hecha en el primer renglón, y en resolver la rectificación de 2P en un minuto.

## Ejercicios que ejemplifican esto

- [[temas/calculo_lambda_guia]] — **Ejercicio 4** (origen de esta página): parentización completa, árbol sintáctico, marcado de libres/ligadas y "¿ocurre como subtérmino?" sobre tres términos, incluyendo el contraste $(\lambda\dots)\,u\,v\,w$ vs. $w\,(\lambda\dots)\,u\,v$
- [[temas/calculo_lambda_guia]] — **Ejercicio 3**: subtérminos y ocurrencias; el inciso c) ($x\,(y\,z)$ en $u\,x\,(y\,z)$) es el caso testigo de por qué hay que parentizar antes de buscar
- [[temas/calculo_lambda_guia]] — **Ejercicio 1**: validez sintáctica; los incisos m/n/ñ ($\text{Bool} \to \text{Bool} \to \text{Nat}$ vs. $(\text{Bool} \to \text{Bool}) \to \text{Nat}$) practican la asociatividad de la flecha
- [[temas/calculo_lambda_guia]] — **Ejercicio 13**: sustituciones — la sustitución sólo alcanza a las **ocurrencias libres**, así que exige el marcado del Paso 4
- [[temas/calculo_lambda_practica]] — **Ejercicio 1**: dibujar el árbol sintáctico y marcar las ocurrencias libres de 10 expresiones (incluye $x\,y\,\lambda x{:}\dots$, donde la asociatividad a izquierda decide la lectura)
