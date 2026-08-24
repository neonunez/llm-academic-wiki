---
nombre: Cálculo Lambda (Tipado y Semántica) — Guia de Ejercicios
parcial: 1P
programa: 2C_2026
tipo: guia
tema: calculo_lambda_tipado
fuente: raw/guias_practicas/3.guia_1P_calculo_lamda_tipado_semantica_operacional.pdf
paginas_relacionadas:
  - "[[calculo_lambda_tipado_teoria]]"
  - "[[calculo_lambda_practica]]"
---

# Práctica Nº 4 - Cálculo-λ: Tipado y Semántica Operacional

Esta guía cubre los fundamentos sintácticos, el sistema de tipado simple y la semántica operacional del cálculo lambda, junto con extensiones comunes (pares, sumas, listas, deques).

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| [Ej. 1](#ejercicio-1-—-sintaxis) | Validez sintáctica de expresiones | ⚪ No |
| [Ej. 2](#ejercicio-2-—-gramática-completa) | Término que usa todas las reglas | ⚪ No |
| [Ej. 3](#ejercicio-3-—-subtérminos) | Identificación de subtérminos y ocurrencias | ⚪ No |
| [Ej. 4](#ejercicio-4-—-parentización-y-árboles) | Convención de paréntesis y árboles sintácticos | 🔴 Si |
| [Ej. 5](#ejercicio-5-—-no-tipable) | Término no tipable sin variables libres | ⚪ No |
| [Ej. 6](#ejercicio-6-—-derivaciones-de-tipado) | Construcción de derivaciones de tipado | 🔴 Si |
| [Ej. 7](#ejercicio-7-—-cambio-de-regla) | Análisis de impacto por cambio en regla de abstracción | 🔴 Si |
| [Ej. 8](#ejercicio-8-—-deducción-de-tipos) | Determinar tipo resultante de juicios | ⚪ No |
| [Ej. 9](#ejercicio-9-—-tipos-habitados) | Demostrar que tipos están habitados (combinadores) | 🔴 Si |
| [Ej. 10](#ejercicio-10-—-inferencia-manual) | Determinar tipos $\sigma$ y $\tau$ en juicios | 🔴 Si |
| [Ej. 11](#ejercicio-11-—-debilitamiento-y-fortalecimiento) | Propiedades del contexto de tipado | ⚪ No |
| [Ej. 12](#ejercicio-12-—-lema-de-sustitución) | Demostración del lema fundamental de sustitución | ⚪ No |
| [Ej. 13](#ejercicio-13-—-sustituciones) | Cálculo manual de sustituciones | 🔴 Si |
| [Ej. 14](#ejercicio-14-—-conmutación-de-sustituciones) | Propiedad de conmutación de sustituciones | ⚪ No |
| [Ej. 15](#ejercicio-15-—-valores) | Identificación de valores según la gramática | 🔴 Si |
| [Ej. 16](#ejercicio-16-—-programas-y-forma-normal) | Evaluación de programas y detección de errores | 🔴 Si |
| [Ej. 17](#ejercicio-17-—-determinismo) | Análisis de determinismo en la reducción | ⚪ No |
| [Ej. 18](#ejercicio-18-—-propiedades-de-succ-y-pred) | Evaluación de términos con succ/pred/isZero | ⚪ No |
| [Ej. 19](#ejercicio-19-—-regla-xi) | Impacto de permitir reducción bajo abstracciones | 🔴 Si |
| [Ej. 20](#ejercicio-20-—-extension-pares-productos) | Reglas y habitantes para productos (pares) | 🔴 Si |
| [Ej. 21](#ejercicio-21-—-extension-sumas-uniones-disjuntas) | Reglas y habitantes para co-productos (sumas) | 🔴 Si |
| [Ej. 22](#ejercicio-22-—-extension-listas) | Reglas y reducción para listas y foldr | 🔴 Si |
| [Ej. 23](#ejercicio-23-—-map) | Definición de map para listas | 🔴 Si |
| [Ej. 24](#ejercicio-24-—-listas-por-comprensión) | Extensión para listas por comprensión | 🔴 Si |
| [Ej. 25](#ejercicio-25-—-macros-booleanas) | Definición de Not, And, Or, Xor como macros | ⚪ No |
| [Ej. 26](#ejercicio-26-—-funciones-de-listas) | head, tail, iterate, zip, take como macros | 🔴 Si |
| [Ej. 27](#ejercicio-27-—-extension-deques-colas-bidireccionales) | Reglas y reducción para colas bidireccionales | 🔴 Si |

---

## SINTAXIS

### Ejercicio 1 — Sintaxis
**Enunciado**
Determinar qué expresiones son sintácticamente válidas (es decir, pueden ser generadas con las gramáticas presentadas) y determinar a qué categoría pertenecen (expresiones de términos o expresiones de tipos):

a) $x$ | b) $x x$ | c) $M$ | d) $M M$ | e) $\text{true false}$ | f) $\text{true succ}(\text{false true})$ | g) $\lambda x . \text{isZero}(x)$ | h) $\lambda x : \sigma . \text{succ}(x)$ | i) $\lambda x : \text{Bool} . \text{succ}(x)$ | j) $\lambda x : \text{if true then Bool else Nat} . x$ | k) $\sigma$ | l) $\text{Bool}$ | m) $\text{Bool} \to \text{Bool}$ | n) $\text{Bool} \to \text{Bool} \to \text{Nat}$ | ñ) $(\text{Bool} \to \text{Bool}) \to \text{Nat}$ | o) $\text{succ true}$ | p) $\lambda x : \text{Bool} . \text{if zero then true else zero succ}(\text{true})$

**Explicación**
Pide distinguir entre la sintaxis de términos (que representan programas/valores) y tipos (que clasifican términos). Hay que notar que algunas expresiones usan meta-variables ($M, \sigma$) y otras constantes de la gramática.

**Resolución paso a paso**
Las dos gramáticas en juego son:
- **Términos**: $M ::= x \mid \lambda x : \tau . M \mid M\,M \mid \text{true} \mid \text{false} \mid \text{if } M \text{ then } M \text{ else } M \mid \text{zero} \mid \text{succ}(M) \mid \text{pred}(M) \mid \text{isZero}(M)$
- **Tipos**: $\tau ::= \text{Bool} \mid \text{Nat} \mid \tau \to \tau$

Dos observaciones que deciden casi todo el ejercicio:
1. $M, N, \sigma, \tau, \rho$ son **meta-variables** del metalenguaje, no símbolos de la gramática. Los nombres de variables se toman de $\mathcal{X} = \{w, w_1, \dots, x, x_1, \dots, y, \dots, z, \dots\}$, y $M$ o $\sigma$ no pertenecen a $\mathcal{X}$.
2. $\text{succ}$, $\text{pred}$ e $\text{isZero}$ **no son términos por sí solos**: la gramática los genera únicamente en la forma $\text{succ}(M)$, con los paréntesis obligatorios. No son funciones y por lo tanto no se pueden aplicar.

| # | Expresión | ¿Válida? | Categoría |
|---|---|---|---|
| a | $x$ | Sí | Término (variable) |
| b | $x\,x$ | Sí | Término (aplicación). Sintáctica pero no tipable |
| c | $M$ | No | Meta-variable, no pertenece a $\mathcal{X}$ |
| d | $M\,M$ | No | Ídem c |
| e | $\text{true false}$ | Sí | Término (aplicación de $\text{true}$ a $\text{false}$). No tipa |
| f | $\text{true succ}(\text{false true})$ | Sí | Término: aplicación de $\text{true}$ a $\text{succ}(\text{false true})$ |
| g | $\lambda x . \text{isZero}(x)$ | No | Falta la anotación de tipo del ligador |
| h | $\lambda x : \sigma . \text{succ}(x)$ | No (esquema) | $\sigma$ es meta-variable de tipos; es un *esquema* de término, válido al instanciar $\sigma$ |
| i | $\lambda x : \text{Bool} . \text{succ}(x)$ | Sí | Término. No tipa |
| j | $\lambda x : \text{if true then Bool else Nat} . x$ | No | En la anotación va un tipo, y el $\text{if}$ es constructor de **términos** |
| k | $\sigma$ | No (esquema) | Meta-variable de tipos |
| l | $\text{Bool}$ | Sí | Tipo |
| m | $\text{Bool} \to \text{Bool}$ | Sí | Tipo |
| n | $\text{Bool} \to \text{Bool} \to \text{Nat}$ | Sí | Tipo, se lee $\text{Bool} \to (\text{Bool} \to \text{Nat})$ |
| ñ | $(\text{Bool} \to \text{Bool}) \to \text{Nat}$ | Sí | Tipo, distinto de n |
| o | $\text{succ true}$ | No | $\text{succ}$ solo aparece como $\text{succ}(M)$; no es un término aplicable |
| p | $\lambda x : \text{Bool} . \text{if zero then true else zero succ}(\text{true})$ | Sí | Término. No tipa |

**Detalle de los casos interesantes**

- **e) y f)**: la aplicación no exige que el término de la izquierda sea una abstracción. $\text{true false}$ se genera con $M\,M$, así que es sintácticamente válido; el sistema de tipos es el que lo rechaza (no existe $\tau$ con $\vdash \text{true} : \tau_1 \to \tau_2$). En f), la parentización es $\text{true}\,(\text{succ}(\text{false true}))$ porque $\text{succ}(\cdot)$ es un átomo sintáctico.
- **i)**: sintaxis correcta, tipado incorrecto ($\text{t-succ}$ pide $x : \text{Nat}$ y el contexto da $x : \text{Bool}$). Es el ejemplo canónico de que *ser un término* y *tipar* son cosas distintas.
- **p)**: por precedencia se lee $\lambda x : \text{Bool} . (\text{if zero then true else } (\text{zero succ}(\text{true})))$. Las tres partes del $\text{if}$ son términos, así que la expresión se genera; no tipa porque la guarda es $\text{Nat}$ y las ramas ni siquiera coinciden entre sí.

**Chuleta**
> 1. Chequear que sea generable por la gramática ANTES de pensar en tipos: **sintaxis ≠ tipado** (e, i, p son válidas y no tipan).
> 2. Rojo inmediato: $\lambda$ sin anotación de tipo (g), $\text{succ}/\text{pred}/\text{isZero}$ sin paréntesis (o), término en posición de tipo (j).
> 3. $M, N, \sigma, \tau$ son meta-variables → no pertenecen a la gramática concreta (c, d, h, k).
> 4. Categoría: si aparece $\to$, $\text{Bool}$ o $\text{Nat}$ solos → tipo; si aparece $\lambda$, aplicación, $\text{if}$ o constantes → término.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 2 — Gramática completa
**Enunciado**
Mostrar un término que utilice al menos una vez **todas** las reglas de generación de la gramática de los términos y exhibir su *árbol sintáctico*.

**Explicación**
Requiere construir un término "monstruo" que incluya abstracción, aplicación, booleanos (true, false, if), y naturales (zero, succ, pred, isZero).

**Resolución paso a paso**
Las reglas de generación de términos son diez: variable, abstracción, aplicación, $\text{true}$, $\text{false}$, $\text{if}$, $\text{zero}$, $\text{succ}$, $\text{pred}$, $\text{isZero}$. Hay que usarlas todas al menos una vez.

**Término propuesto**

$$M \;=\; (\lambda x : \text{Nat} . \text{if isZero}(\text{pred}(\text{succ}(x))) \text{ then } (\lambda y : \text{Bool} . y)\ \text{true} \text{ else false})\ \text{zero}$$

**Verificación de cobertura**

| Regla | Dónde aparece |
|---|---|
| variable | $x$ en $\text{succ}(x)$, $y$ en el cuerpo del segundo $\lambda$ |
| abstracción | $\lambda x : \text{Nat} . \dots$ y $\lambda y : \text{Bool} . y$ |
| aplicación | $(\lambda x \dots)\ \text{zero}$ y $(\lambda y : \text{Bool} . y)\ \text{true}$ |
| $\text{true}$ | argumento de la segunda aplicación |
| $\text{false}$ | rama $\text{else}$ |
| $\text{if}$ | cuerpo de la primera abstracción |
| $\text{zero}$ | argumento de la primera aplicación |
| $\text{succ}$ | $\text{succ}(x)$ |
| $\text{pred}$ | $\text{pred}(\text{succ}(x))$ |
| $\text{isZero}$ | guarda del $\text{if}$ |

**Yapa: además tipa y evalúa**

$\vdash M : \text{Bool}$, porque $x : \text{Nat} \vdash \text{pred}(\text{succ}(x)) : \text{Nat}$, luego la guarda es $\text{Bool}$ y ambas ramas son $\text{Bool}$; entonces $\vdash \lambda x : \text{Nat} . (\dots) : \text{Nat} \to \text{Bool}$ y se aplica a $\text{zero} : \text{Nat}$.

Su evaluación:
$$M \to \text{if isZero}(\text{pred}(\text{succ}(\text{zero}))) \dots \to \text{if isZero}(\text{zero}) \dots \to \text{if true} \dots \to (\lambda y : \text{Bool} . y)\ \text{true} \to \text{true}$$

**Árbol sintáctico**

```
                       @  (aplicación)
                     /   \
              λx:Nat      zero
                 |
                 if
            /    |    \
      isZero     @     false
         |      /  \
       pred  λy:Bool  true
         |      |
       succ     y
         |
         x
```

Cada nodo interno es un constructor de la gramática y las hojas son variables o constantes ($\text{zero}$, $\text{true}$, $\text{false}$, y la variable $y$ como cuerpo de su abstracción).

**Chuleta**
> 1. Listar las 10 reglas: var, $\lambda$, aplicación, true, false, if, zero, succ, pred, isZero.
> 2. Armar un $\text{if}$ con guarda $\text{isZero}(\text{pred}(\text{succ}(x)))$ (mete 3 reglas de una) y ramas $\text{true}$/$\text{false}$.
> 3. Envolverlo en $\lambda x : \text{Nat}$ y aplicarlo a $\text{zero}$; agregar $(\lambda y : \text{Bool} . y)\,\text{true}$ para cerrar aplicación + segunda variable.
> 4. Árbol: un nodo por constructor, hojas = variables y constantes.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 3 — Subtérminos
**Enunciado**
a) Marcar las ocurrencias del término $x$ como subtérmino en $\lambda x : \text{Nat} . \text{succ}((\lambda x : \text{Nat} . x) x)$.
b) ¿Ocurre $x_1$ como subtérmino en $\lambda x_1 : \text{Nat} . \text{succ}(x_2)$?
c) ¿Ocurre $x (y z)$ como subtérmino en $u x (y z)$?

**Explicación**
Concepto de subtérmino y ocurrencia. Es vital para entender el alcance de las variables y la sustitución.

**Resolución paso a paso**
Recordar la definición: los subtérminos de $M$ son $M$ mismo más los subtérminos de sus componentes inmediatas. **La ocurrencia del ligador** ($x$ en $\lambda x : \tau . M$) **no es un subtérmino**: forma parte del constructor de abstracción, no ocupa una posición de término.

**a) Ocurrencias de $x$ en $\lambda x : \text{Nat} . \text{succ}((\lambda x : \text{Nat} . x)\ x)$**

Marcando las posiciones de término:
$$\lambda x : \text{Nat} . \text{succ}((\lambda x : \text{Nat} . \underline{x}^{(1)})\ \underline{x}^{(2)})$$

Hay **dos** ocurrencias de $x$ como subtérmino:
- $\underline{x}^{(1)}$: cuerpo de la abstracción interna, **ligada por el $\lambda$ interno**.
- $\underline{x}^{(2)}$: argumento de la aplicación, **ligada por el $\lambda$ externo** (está fuera del alcance del interno).

Las dos ocurrencias de $x$ en las anotaciones $\lambda x : \text{Nat}$ son ocurrencias *ligadoras*, no subtérminos. Este ejercicio muestra que dos ocurrencias del mismo nombre pueden estar ligadas por ligadores distintos; renombrando ($\alpha$-conversión) queda claro: $\lambda x_1 : \text{Nat} . \text{succ}((\lambda x_2 : \text{Nat} . x_2)\ x_1)$.

**b) ¿Ocurre $x_1$ como subtérmino en $\lambda x_1 : \text{Nat} . \text{succ}(x_2)$?**

**No.** El conjunto de subtérminos es
$$\{\ \lambda x_1 : \text{Nat} . \text{succ}(x_2),\quad \text{succ}(x_2),\quad x_2\ \}$$
La única aparición de $x_1$ es la del ligador, que no cuenta como subtérmino. Confirmación por $\alpha$-equivalencia: el término es igual a $\lambda w : \text{Nat} . \text{succ}(x_2)$, donde $x_1$ ni siquiera aparece.

**c) ¿Ocurre $x\,(y\,z)$ como subtérmino en $u\,x\,(y\,z)$?**

**No.** Por asociatividad a izquierda, $u\,x\,(y\,z) = ((u\,x)\,(y\,z))$. Sus subtérminos son:
$$\{\ (u\,x)(y\,z),\quad u\,x,\quad u,\quad x,\quad y\,z,\quad y,\quad z\ \}$$
$x\,(y\,z)$ no está en la lista: $x$ y $(y\,z)$ son hermanos en niveles distintos del árbol, no forman un nodo. Sí sería subtérmino de $u\,(x\,(y\,z))$, que es un término **distinto**.

**Chuleta**
> 1. Subtérmino = nodo del árbol sintáctico. El $x$ del ligador $\lambda x : \tau$ **no** es un nodo.
> 2. Parentizar primero (aplicación asocia a izquierda) y recién ahí buscar el candidato como subárbol completo.
> 3. Test rápido: $\alpha$-renombrar las ligadas; si el nombre buscado desaparece, no ocurría como subtérmino.
> 4. Un mismo nombre puede tener ocurrencias ligadas por $\lambda$ distintos → indicar siempre cuál lo liga.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 4 — Parentización y árboles
**Enunciado**
Para los siguientes términos:
a) $u x (y z) (\lambda v : \text{Bool} . v y)$
b) $(\lambda x : \text{Bool} \to \text{Nat} \to \text{Bool} . \lambda y : \text{Bool} \to \text{Nat} . \lambda z : \text{Bool} . x z (y z)) u v w$
c) $w (\lambda x : \text{Bool} \to \text{Nat} \to \text{Bool} . \lambda y : \text{Bool} \to \text{Nat} . \lambda z : \text{Bool} . x z (y z)) u v$

Se pide:
I. Insertar todos los paréntesis de acuerdo a la convención usual.
II. Dibujar el árbol sintáctico de cada una de las expresiones.
III. Indicar en el árbol cuáles ocurrencias de variables aparecen ligadas y cuáles libres.
IV. ¿En cuál o cuáles de los términos anteriores ocurre la siguiente expresión como subtérmino?
$(\lambda x : \text{Bool} \to \text{Nat} \to \text{Bool} . \lambda y : \text{Bool} \to \text{Nat} . \lambda z : \text{Bool} . x z (y z)) u$

**Explicación**
Uso de la convención de asociatividad a izquierda para la aplicación y a derecha para el tipo flecha. Identificación de variables libres y ligadas.

**Resolución paso a paso**
**I. Parentización completa**

Convenciones: la aplicación asocia a **izquierda**; el $\to$ asocia a **derecha**; el cuerpo del $\lambda$ se extiende lo más posible a la derecha.

**a)** $u\,x\,(y\,z)\,(\lambda v : \text{Bool} . v\,y)$
$$\big(\big((u\,x)\,(y\,z)\big)\,\big(\lambda v : \text{Bool} . (v\,y)\big)\big)$$

**b)** $(\lambda x : \text{Bool} \to \text{Nat} \to \text{Bool} . \lambda y : \text{Bool} \to \text{Nat} . \lambda z : \text{Bool} . x\,z\,(y\,z))\,u\,v\,w$
$$\Big(\Big(\Big(\lambda x : \big(\text{Bool} \to (\text{Nat} \to \text{Bool})\big) . \big(\lambda y : (\text{Bool} \to \text{Nat}) . \big(\lambda z : \text{Bool} . \big((x\,z)\,(y\,z)\big)\big)\big)\Big)\,u\Big)\,v\Big)\,w$$

**c)** $w\,(\lambda x : \dots . \lambda y : \dots . \lambda z : \text{Bool} . x\,z\,(y\,z))\,u\,v$
$$\Big(\Big(\Big(w\,\big(\lambda x : \big(\text{Bool} \to (\text{Nat} \to \text{Bool})\big) . \big(\lambda y : (\text{Bool} \to \text{Nat}) . (\lambda z : \text{Bool} . ((x\,z)\,(y\,z)))\big)\big)\Big)\,u\Big)\,v\Big)$$

Notar la diferencia clave entre b) y c): en b) la abstracción está en **posición de función** y se aplica a $u, v, w$; en c) la abstracción es el **argumento** de $w$.

**II y III. Árboles sintácticos (con libres/ligadas marcadas)**

Notación: `@` = aplicación; `L` = ligada; `F` = libre.

**a)**
```
                @
              /   \
            @      λv:Bool
          /   \        |
        @      @       @
       / \    / \     / \
      u   x  y   z   v   y
     (F) (F)(F) (F) (L) (F)
```
$fv = \{u, x, y, z\}$. La única ocurrencia ligada es la de $v$ en $v\,y$, ligada por $\lambda v$. El $y$ del cuerpo es **libre**: $\lambda v$ no lo alcanza.

**b)**
```
                    @
                  /   \
                @      w (F)
              /   \
            @      v (F)
          /   \
        λx     u (F)
         |
        λy
         |
        λz
         |
         @
       /   \
      @     @
     / \   / \
    x   z y   z
   (L) (L)(L)(L)
```
$fv = \{u, v, w\}$. Todas las ocurrencias de $x, y, z$ dentro del cuerpo están ligadas por sus respectivos $\lambda$.

**c)**
```
                @
              /   \
            @      v (F)
          /   \
        @      u (F)
       / \
   w(F)  λx
          |
         λy
          |
         λz
          |
          @
        /   \
       @     @
      / \   / \
     x   z y   z
    (L) (L)(L)(L)
```
$fv = \{w, u, v\}$. Mismo cuerpo que b), mismas ligaduras internas.

**IV. ¿Dónde ocurre $(\lambda x : \dots . \lambda y : \dots . \lambda z : \text{Bool} . x\,z\,(y\,z))\,u$ como subtérmino?**

**Sólo en b).** En b) la parentización da $\big(\big((\lambda x \dots)\,u\big)\,v\big)\,w$: el nodo $(\lambda x \dots)\,u$ existe y es el subárbol más profundo de la cadena de aplicaciones.

En c) la estructura es $\big(\big(w\,(\lambda x \dots)\big)\,u\big)\,v$: la abstracción está apareada con $w$, no con $u$. En el árbol, $\lambda x$ y $u$ son hermanos de niveles distintos, nunca forman un nodo. En a) directamente no aparece la abstracción en cuestión.

**Chuleta**
> 1. Parentizar: aplicación a **izquierda** ($M\,N\,O = (M\,N)\,O$), flecha a **derecha** ($\sigma \to \tau \to \rho = \sigma \to (\tau \to \rho)$), el cuerpo del $\lambda$ se estira hasta el final.
> 2. Árbol: `@` binario para cada aplicación, un nodo por cada $\lambda$ con un solo hijo (el cuerpo).
> 3. Una ocurrencia es **ligada** si tiene un $\lambda$ del mismo nombre en el camino hacia la raíz; si no, es **libre**.
> 4. "¿Ocurre como subtérmino?" = ¿es un **subárbol completo**? En $(\lambda \dots)\,u\,v\,w$ sí; en $w\,(\lambda \dots)\,u$ no.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_sintaxis_arbol]]

---

## TIPADO

### Ejercicio 5 — No tipable
**Enunciado**
Mostrar un término que no sea tipable y que no tenga variables libres ni abstracciones.

**Explicación**
Busca un error de tipo "dinámico" que el sistema de tipos estático debería rechazar (ej: usar succ sobre un Booleano).

**Resolución paso a paso**
Se pide un término $M$ tal que: (i) no exista $\tau$ con $\vdash M : \tau$ derivable; (ii) $fv(M) = \emptyset$; (iii) $M$ no contenga ninguna abstracción.

**Término propuesto**
$$M = \text{succ}(\text{true})$$

**Verificación**

- **Sin variables libres**: $fv(\text{succ}(\text{true})) = fv(\text{true}) = \emptyset$. ✓
- **Sin abstracciones**: sólo usa $\text{succ}(\cdot)$ y la constante $\text{true}$. ✓
- **No tipable**: supongamos que existe $\tau$ tal que $\Gamma \vdash \text{succ}(\text{true}) : \tau$ es derivable. La única regla cuya conclusión tiene la forma $\text{succ}(\cdot)$ es $\text{t-succ}$, así que la derivación debe terminar en
$$\frac{\Gamma \vdash \text{true} : \text{Nat}}{\Gamma \vdash \text{succ}(\text{true}) : \text{Nat}}\ \text{t-succ}$$
Pero la única regla cuya conclusión tiene la forma $\text{true}$ es $\text{t-true}$, que sólo deriva $\Gamma \vdash \text{true} : \text{Bool}$. Por **unicidad de tipos**, $\text{true}$ no puede tener también tipo $\text{Nat}$ (y $\text{Bool} \neq \text{Nat}$ como tipos sintácticos). Contradicción. $\blacksquare$

**Otros testigos válidos**

- $\text{isZero}(\text{false})$ — mismo argumento con $\text{t-isZero}$.
- $\text{if zero then true else false}$ — la guarda debe ser $\text{Bool}$ y $\text{zero} : \text{Nat}$.
- $\text{if true then zero else false}$ — las ramas deben tener el mismo tipo.
- $\text{true false}$ — aplicación cuyo operador tiene tipo $\text{Bool}$, que no es de la forma $\sigma \to \tau$.

**Por qué importa la restricción "sin abstracciones"**

Sin ella la respuesta trivial sería $(\lambda x : \sigma . x\,x)$ o similares, es decir el clásico error de auto-aplicación. Al prohibir abstracciones, el único mecanismo de falla que queda es la **inconsistencia entre constructores base**: usar un $\text{Bool}$ donde se espera $\text{Nat}$ (o viceversa), o aplicar algo que no es función.

**Chuleta**
> 1. Sin abstracciones ni libres → el error tiene que ser de **choque entre constantes**.
> 2. Receta: meter un booleano donde va un natural. Respuesta corta: $\text{succ}(\text{true})$.
> 3. Justificar por **inversión + unicidad**: la única regla para $\text{succ}$ pide $\text{Nat}$, la única para $\text{true}$ da $\text{Bool}$, y $\text{Bool} \neq \text{Nat}$.
> 4. Alternativas: $\text{isZero}(\text{false})$, $\text{if zero then true else false}$, $\text{true false}$.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 6 — Derivaciones de tipado
**Enunciado**
Dar una derivación –o explicar por qué no es posible dar una derivación– para cada uno de los siguientes juicios de tipado:
a) $\vdash \text{if true then zero else succ}(\text{zero}) : \text{Nat}$
b) $x : \text{Nat}, y : \text{Bool} \vdash \text{if true then false else } (\lambda z : \text{Bool} . z) \text{ true} : \text{Bool}$
c) $\vdash \text{if } \lambda x : \text{Bool} . x \text{ then zero else succ}(\text{zero}) : \text{Nat}$
d) $x : \text{Bool} \to \text{Nat}, y : \text{Bool} \vdash x y : \text{Nat}$

**Explicación**
Construcción de árboles de derivación usando las reglas de tipado (T-If, T-Abs, T-App, T-Var, etc.).

**Resolución paso a paso**
**a) $\vdash \text{if true then zero else succ}(\text{zero}) : \text{Nat}$ — derivable**

$$
\dfrac{
  \dfrac{}{\vdash \text{true} : \text{Bool}}\ \text{t-true}
  \qquad
  \dfrac{}{\vdash \text{zero} : \text{Nat}}\ \text{t-zero}
  \qquad
  \dfrac{\dfrac{}{\vdash \text{zero} : \text{Nat}}\ \text{t-zero}}{\vdash \text{succ}(\text{zero}) : \text{Nat}}\ \text{t-succ}
}{
  \vdash \text{if true then zero else succ}(\text{zero}) : \text{Nat}
}\ \text{t-if}
$$

La regla $\text{t-if}$ pide guarda $\text{Bool}$ y ambas ramas del **mismo** tipo: las dos son $\text{Nat}$. ✓

**b) $x : \text{Nat}, y : \text{Bool} \vdash \text{if true then false else } (\lambda z : \text{Bool} . z)\ \text{true} : \text{Bool}$ — derivable**

Sea $\Gamma = x : \text{Nat},\ y : \text{Bool}$. La rama $\text{else}$ es la aplicación $(\lambda z : \text{Bool} . z)\ \text{true}$:

$$
\dfrac{
  \dfrac{\dfrac{}{\Gamma, z : \text{Bool} \vdash z : \text{Bool}}\ \text{t-var}}{\Gamma \vdash \lambda z : \text{Bool} . z : \text{Bool} \to \text{Bool}}\ \text{t-abs}
  \qquad
  \dfrac{}{\Gamma \vdash \text{true} : \text{Bool}}\ \text{t-true}
}{
  \Gamma \vdash (\lambda z : \text{Bool} . z)\ \text{true} : \text{Bool}
}\ \text{t-app}
$$

y con eso:

$$
\dfrac{
  \dfrac{}{\Gamma \vdash \text{true} : \text{Bool}}\ \text{t-true}
  \qquad
  \dfrac{}{\Gamma \vdash \text{false} : \text{Bool}}\ \text{t-false}
  \qquad
  \Gamma \vdash (\lambda z : \text{Bool} . z)\ \text{true} : \text{Bool}
}{
  \Gamma \vdash \text{if true then false else } (\lambda z : \text{Bool} . z)\ \text{true} : \text{Bool}
}\ \text{t-if}
$$

Observar que $x$ e $y$ nunca se usan: el contexto puede tener información de más (eso es exactamente *debilitamiento*, Ej. 11).

**c) $\vdash \text{if } \lambda x : \text{Bool} . x \text{ then zero else succ}(\text{zero}) : \text{Nat}$ — NO derivable**

Por **inversión**: la única regla cuya conclusión tiene la forma $\text{if } M \text{ then } N \text{ else } P$ es $\text{t-if}$, que exige $\vdash \lambda x : \text{Bool} . x : \text{Bool}$. Pero la única regla cuya conclusión tiene la forma $\lambda x : \sigma . M$ es $\text{t-abs}$, cuya conclusión es siempre un tipo flecha: $\vdash \lambda x : \text{Bool} . x : \text{Bool} \to \text{Bool}$. Por **unicidad de tipos**, ese es su único tipo, y $\text{Bool} \to \text{Bool} \neq \text{Bool}$. No hay derivación. $\blacksquare$

**d) $x : \text{Bool} \to \text{Nat},\ y : \text{Bool} \vdash x\,y : \text{Nat}$ — derivable**

Sea $\Gamma = x : \text{Bool} \to \text{Nat},\ y : \text{Bool}$.

$$
\dfrac{
  \dfrac{}{\Gamma \vdash x : \text{Bool} \to \text{Nat}}\ \text{t-var}
  \qquad
  \dfrac{}{\Gamma \vdash y : \text{Bool}}\ \text{t-var}
}{
  \Gamma \vdash x\,y : \text{Nat}
}\ \text{t-app}
$$

El tipo del argumento ($\text{Bool}$) coincide exactamente con el dominio del operador. ✓

**Chuleta**
> 1. Mirar el **constructor de la raíz** del término → determina unívocamente la última regla (inversión).
> 2. Subir por las premisas hasta llegar a axiomas ($\text{t-var}$, $\text{t-true}$, $\text{t-false}$, $\text{t-zero}$).
> 3. Chequeos que hacen fallar: guarda del $\text{if}$ debe ser $\text{Bool}$, ambas ramas el **mismo** tipo, el operador de una aplicación debe tener tipo $\sigma \to \tau$ con $\sigma$ = tipo del argumento.
> 4. Para justificar la NO derivabilidad: inversión + **unicidad de tipos** (un $\lambda$ sólo puede tener tipo flecha).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]

### Ejercicio 7 — Cambio de regla
**Enunciado**
Se modifica la regla de tipado de la abstracción y se la cambia por la siguiente regla:
$$\frac{\Gamma \vdash M : \tau}{\Gamma \vdash \lambda x : \sigma . M : \sigma \to \tau} \to_{i2}$$
Exhibir un juicio de tipado que sea derivable en el sistema original pero que no lo sea en el sistema actual.

**Explicación**
La nueva regla NO agrega la variable ligada $x$ al contexto $\Gamma$ para tipar el cuerpo $M$. Esto significa que $M$ no puede usar $x$ de forma libre.

**Resolución paso a paso**
**La diferencia entre las dos reglas**

$$\frac{\Gamma, x : \sigma \vdash M : \tau}{\Gamma \vdash \lambda x : \sigma . M : \sigma \to \tau}\ \to_i \text{(original)} \qquad\qquad \frac{\Gamma \vdash M : \tau}{\Gamma \vdash \lambda x : \sigma . M : \sigma \to \tau}\ \to_{i2} \text{(nueva)}$$

La regla nueva **no incorpora $x : \sigma$ al contexto** para tipar el cuerpo. Entonces el cuerpo $M$ no puede usar $x$ libremente: cualquier ocurrencia libre de $x$ en $M$ queda sin justificación en $\Gamma$.

**Juicio testigo**

$$\vdash \lambda x : \text{Bool} . x : \text{Bool} \to \text{Bool}$$

**Derivable en el sistema original:**
$$\dfrac{\dfrac{}{x : \text{Bool} \vdash x : \text{Bool}}\ \text{t-var}}{\vdash \lambda x : \text{Bool} . x : \text{Bool} \to \text{Bool}}\ \to_i$$

**No derivable en el sistema modificado:** la única regla cuya conclusión tiene la forma $\lambda x : \sigma . M$ es $\to_{i2}$, así que la derivación debería terminar con premisa
$$\vdash x : \text{Bool}$$
es decir, el juicio con **contexto vacío**. Pero la única regla cuya conclusión es una variable es $\text{t-var}$, que exige $x : \text{Bool} \in \emptyset$: absurdo. No hay derivación. $\blacksquare$

**Generalización**

En el sistema modificado, ningún término cerrado con una variable ligada efectivamente usada es tipable. En particular:
- $\vdash \lambda x : \sigma . x : \sigma \to \sigma$ (identidad) — se pierde.
- $\vdash \lambda x : \text{Nat} . \text{succ}(x) : \text{Nat} \to \text{Nat}$ — se pierde.
- Sobreviven sólo las funciones **constantes**, como $\vdash \lambda x : \text{Bool} . \text{zero} : \text{Bool} \to \text{Nat}$.

Es decir: con $\to_{i2}$ el cálculo deja de poder expresar cualquier función que dependa de su argumento. Además el sistema resultante **rompe la preservación de tipos**: se puede tipar $\vdash \lambda x : \text{Bool} . y$ sólo si $y \in \Gamma$, y las derivaciones dejan de ser cerradas bajo $\beta$-reducción de forma consistente.

**Observación adicional**: la implicación no vale en el otro sentido tampoco; el sistema nuevo no es más débil "prolijamente", simplemente es incoherente respecto de las variables ligadas.

**Chuleta**
> 1. Leer qué se pierde: $\to_{i2}$ **no agrega $x : \sigma$ al contexto**.
> 2. Consecuencia: el cuerpo no puede usar la variable ligada.
> 3. Testigo mínimo: la identidad $\vdash \lambda x : \text{Bool} . x : \text{Bool} \to \text{Bool}$ — derivable con $\to_i$, imposible con $\to_{i2}$ (haría falta $\vdash x : \text{Bool}$ con contexto vacío).
> 4. Moraleja: sólo sobreviven las funciones constantes.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]

### Ejercicio 8 — Deducción de tipos
**Enunciado**
Determinar qué tipo representa $\sigma$ en cada uno de los siguientes juicios de tipado.
a) $\vdash \text{succ}(\text{zero}) : \sigma$
b) $\vdash \text{isZero}(\text{succ}(\text{zero})) : \sigma$
c) $\vdash \text{if } (\text{if true then false else false}) \text{ then zero else succ}(\text{zero}) : \sigma$

**Explicación**
Propagación de tipos básica.

**Resolución paso a paso**
En los tres casos el tipo está **determinado unívocamente** (unicidad de tipos): basta propagar de abajo hacia arriba.

**a) $\vdash \text{succ}(\text{zero}) : \sigma$**

$\text{t-zero}$ da $\vdash \text{zero} : \text{Nat}$; $\text{t-succ}$ toma $\text{Nat}$ y devuelve $\text{Nat}$.
$$\boxed{\sigma = \text{Nat}}$$

**b) $\vdash \text{isZero}(\text{succ}(\text{zero})) : \sigma$**

$\vdash \text{succ}(\text{zero}) : \text{Nat}$ por a); $\text{t-isZero}$ toma $\text{Nat}$ y devuelve $\text{Bool}$.
$$\boxed{\sigma = \text{Bool}}$$

Este es el caso que más se confunde: $\text{succ}$ y $\text{pred}$ son $\text{Nat} \to \text{Nat}$, pero $\text{isZero}$ **cambia de tipo**, es $\text{Nat} \to \text{Bool}$.

**c) $\vdash \text{if } (\text{if true then false else false}) \text{ then zero else succ}(\text{zero}) : \sigma$**

Se resuelve de adentro hacia afuera:
1. $\text{if true then false else false}$: guarda $\text{true} : \text{Bool}$ ✓, ramas $\text{false} : \text{Bool}$ y $\text{false} : \text{Bool}$ ✓ ⇒ tipo $\text{Bool}$.
2. El $\text{if}$ externo: guarda de tipo $\text{Bool}$ ✓ (por el paso 1), ramas $\text{zero} : \text{Nat}$ y $\text{succ}(\text{zero}) : \text{Nat}$ ✓.

$$\boxed{\sigma = \text{Nat}}$$

Notar que el tipo del $\text{if}$ es el de sus **ramas**, no el de la guarda (que siempre es $\text{Bool}$).

**Chuleta**
> 1. $\text{zero} : \text{Nat}$; $\text{succ}, \text{pred} : \text{Nat} \to \text{Nat}$; $\text{isZero} : \text{Nat} \to \text{Bool}$; $\text{true}, \text{false} : \text{Bool}$.
> 2. $\text{if}$: guarda siempre $\text{Bool}$, y el tipo del $\text{if}$ = tipo **común de las ramas**.
> 3. Evaluar de adentro hacia afuera. Respuestas: a) $\text{Nat}$, b) $\text{Bool}$, c) $\text{Nat}$.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 9 — Tipos habitados
**Enunciado**
Decimos que un tipo $\tau$ está *habitado* si existe un término $M$ tal que el juicio $\vdash M : \tau$ es derivable. En ese caso, decimos que $M$ es un *habitante* de $\tau$. Demostrar que los siguientes tipos están habitados (para cualquier $\sigma, \tau$ y $\rho$):
a) $\sigma \to \tau \to \sigma$
b) $(\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$
c) $(\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$
d) $(\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$

**Explicación**
Encontrar los combinadores básicos (K, S, etc.). Está relacionado con la Correspondencia Curry-Howard (habitantes de tipos flecha como pruebas de implicación lógica).

**Resolución paso a paso**
Para demostrar que un tipo está habitado hay que **exhibir un término** y **dar su derivación de tipado**. La receta es puramente mecánica y viene de Curry-Howard: cada $\to$ en el tipo es un $\lambda$ en el término, y para producir el tipo del final hay que aplicar las hipótesis que uno se guardó.

**a) $\sigma \to \tau \to \sigma$ — habitante: $K$ (`const`)**

$$K = \lambda x : \sigma . \lambda y : \tau . x$$

Derivación (con $\Gamma = x : \sigma,\ y : \tau$):
$$
\dfrac{
  \dfrac{
    \dfrac{}{x : \sigma,\ y : \tau \vdash x : \sigma}\ \text{t-var}
  }{x : \sigma \vdash \lambda y : \tau . x : \tau \to \sigma}\ \text{t-abs}
}{\vdash \lambda x : \sigma . \lambda y : \tau . x : \sigma \to \tau \to \sigma}\ \text{t-abs}
$$

En Haskell: `const :: a -> b -> a`. En lógica: $\sigma \Rightarrow (\tau \Rightarrow \sigma)$, el axioma de debilitamiento.

**b) $(\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$ — habitante: $S$ (`ap`)**

$$S = \lambda f : \sigma \to \tau \to \rho . \lambda g : \sigma \to \tau . \lambda x : \sigma .\ f\,x\,(g\,x)$$

Derivación (con $\Gamma = f : \sigma \to \tau \to \rho,\ g : \sigma \to \tau,\ x : \sigma$):
$$
\dfrac{
  \dfrac{\dfrac{}{\Gamma \vdash f : \sigma \to \tau \to \rho}\ \text{t-var} \quad \dfrac{}{\Gamma \vdash x : \sigma}\ \text{t-var}}{\Gamma \vdash f\,x : \tau \to \rho}\ \text{t-app}
  \qquad
  \dfrac{\dfrac{}{\Gamma \vdash g : \sigma \to \tau}\ \text{t-var} \quad \dfrac{}{\Gamma \vdash x : \sigma}\ \text{t-var}}{\Gamma \vdash g\,x : \tau}\ \text{t-app}
}{\Gamma \vdash f\,x\,(g\,x) : \rho}\ \text{t-app}
$$
y tres $\text{t-abs}$ encima cierran el juicio $\vdash S : (\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$.

En Haskell: `(<*>)` de la mónada de funciones, o `\f g x -> f x (g x)`. En lógica: el axioma **S** de la lógica combinatoria / distributividad de la implicación.

**c) $(\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$ — habitante: `flip`**

$$F = \lambda f : \sigma \to \tau \to \rho . \lambda y : \tau . \lambda x : \sigma .\ f\,x\,y$$

Con $\Gamma = f : \sigma \to \tau \to \rho,\ y : \tau,\ x : \sigma$: $\Gamma \vdash f\,x : \tau \to \rho$ y $\Gamma \vdash y : \tau$, luego $\Gamma \vdash f\,x\,y : \rho$; tres $\text{t-abs}$ y listo. En Haskell: `flip :: (a -> b -> c) -> b -> a -> c`.

**d) $(\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$ — habitante: composición**

$$C = \lambda f : \tau \to \rho . \lambda g : \sigma \to \tau . \lambda x : \sigma .\ f\,(g\,x)$$

Con $\Gamma = f : \tau \to \rho,\ g : \sigma \to \tau,\ x : \sigma$: $\Gamma \vdash g\,x : \tau$ por $\text{t-app}$, luego $\Gamma \vdash f\,(g\,x) : \rho$ por $\text{t-app}$; tres $\text{t-abs}$. En Haskell: `(.) :: (b -> c) -> (a -> b) -> a -> c`.

**Para pensar (respuestas)**

- **¿Hay tipos no habitados?** Sí. Por ejemplo $\sigma \to \tau$ con $\sigma$ y $\tau$ variables de tipo distintas: no hay forma de fabricar un $\tau$ a partir de un $\sigma$. También $\text{Bool} \to \text{Nat}$ está habitado ($\lambda x : \text{Bool} . \text{zero}$), pero el esquema genérico $\sigma \to \tau$ no lo está para *todos* los $\sigma, \tau$.
- **Si se reemplaza $\to$ por $\Rightarrow$, ¿las fórmulas habitadas son siempre tautologías?** Sí. Por Curry-Howard, si $\vdash M : \tau$ entonces $M$ codifica una demostración en deducción natural intuicionista de $\tau$, y toda fórmula demostrable en NJ es tautología clásica (NJ es correcto respecto de la semántica clásica).
- **¿Las tautologías son siempre fórmulas habitadas?** **No.** El recíproco falla porque el cálculo-$\lambda$ simplemente tipado corresponde a la lógica **intuicionista**. Contraejemplos clásicos:
  - Ley de Peirce: $((\sigma \Rightarrow \tau) \Rightarrow \sigma) \Rightarrow \sigma$ es tautología pero $((\sigma \to \tau) \to \sigma) \to \sigma$ **no está habitado**.
  - Doble negación: $\neg\neg\sigma \Rightarrow \sigma$, es decir $((\sigma \to \bot) \to \bot) \to \sigma$.
  - Tercero excluido: $\sigma \lor \neg\sigma$, o sea $\sigma + (\sigma \to \bot)$.

**Chuleta**
> 1. Un $\to$ en el tipo = un $\lambda$ en el término. Escribir los $\lambda$ con sus tipos, en orden, hasta que quede un tipo atómico.
> 2. Mirar qué falta para producir ese tipo final y armarlo aplicando las hipótesis que quedaron en el contexto.
> 3. Los cuatro combinadores: $K = \lambda x . \lambda y . x$ (`const`), $S = \lambda f . \lambda g . \lambda x . f\,x\,(g\,x)$ (`ap`), `flip` $= \lambda f . \lambda y . \lambda x . f\,x\,y$, $(.) = \lambda f . \lambda g . \lambda x . f\,(g\,x)$.
> 4. Curry-Howard: habitado ⟹ tautología, pero NO al revés (Peirce, doble negación y tercero excluido son tautologías **no** habitadas).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_habitantes]]

### Ejercicio 10 — Inferencia manual
**Enunciado**
Determinar qué tipos representan $\sigma$ y $\tau$ en cada uno de los siguientes juicios de tipado. Si hay más de una solución, o si no hay ninguna, indicarlo.
a) $x : \sigma \vdash \text{isZero}(\text{succ}(x)) : \tau$
b) $\vdash (\lambda x : \sigma . x)(\lambda y : \text{Bool} . \text{zero}) : \sigma$
c) $y : \tau \vdash \text{if } (\lambda x : \sigma . x) \text{ then } y \text{ else succ}(\text{zero}) : \sigma$
d) $x : \sigma \vdash x y : \tau$
e) $x : \sigma, y : \tau \vdash x y : \tau$
f) $x : \sigma \vdash x \text{ true} : \tau$
g) $x : \sigma \vdash x \text{ true} : \sigma$
h) $x : \sigma \vdash x x : \tau$

**Explicación**
Inferencia de tipos manual resolviendo restricciones. Especial atención al caso h) (auto-aplicación), que no es tipable en Cálculo Lambda Simple.

**Resolución paso a paso**
Método: plantear las **restricciones** que impone cada regla de tipado y resolverlas. Tres desenlaces posibles: solución única, infinitas soluciones, o sin solución (típicamente por *occurs check* o por variable libre fuera del contexto).

**a) $x : \sigma \vdash \text{isZero}(\text{succ}(x)) : \tau$ — solución única**

$\text{t-succ}$ exige $x : \text{Nat}$ ⇒ $\sigma = \text{Nat}$. $\text{t-isZero}$ devuelve $\text{Bool}$ ⇒ $\tau = \text{Bool}$.
$$\boxed{\sigma = \text{Nat},\quad \tau = \text{Bool}}$$

**b) $\vdash (\lambda x : \sigma . x)(\lambda y : \text{Bool} . \text{zero}) : \sigma$ — solución única**

Ojo: $\sigma$ aparece **dos veces** (en la anotación y en el tipo del juicio), y tiene que ser el mismo tipo en ambos lugares.
1. $\vdash \lambda x : \sigma . x : \sigma \to \sigma$.
2. $\vdash \lambda y : \text{Bool} . \text{zero} : \text{Bool} \to \text{Nat}$.
3. $\text{t-app}$ exige que el dominio del operador coincida con el tipo del argumento: $\sigma = \text{Bool} \to \text{Nat}$.
4. El tipo resultante de la aplicación es el codominio, que es $\sigma$ — y el juicio pide justamente $\sigma$. Consistente.
$$\boxed{\sigma = \text{Bool} \to \text{Nat}}$$

**c) $y : \tau \vdash \text{if } (\lambda x : \sigma . x) \text{ then } y \text{ else succ}(\text{zero}) : \sigma$ — sin solución**

$\text{t-if}$ exige que la guarda tenga tipo $\text{Bool}$, pero $\lambda x : \sigma . x$ tiene tipo $\sigma \to \sigma$, que **nunca** es $\text{Bool}$ (un tipo flecha no es un tipo base). No hay $\sigma$ ni $\tau$ que sirvan. $\boxed{\text{Sin solución}}$

*(Aunque la guarda tipara, la rama $\text{else}$ forzaría $\sigma = \text{Nat}$ y entonces la guarda tendría que ser $\text{Nat}$, contradicción de nuevo.)*

**d) $x : \sigma \vdash x\,y : \tau$ — sin solución**

El término tiene $y$ **libre** y el contexto sólo declara $x$. Para tipar $y$ hace falta $\text{t-var}$, que exige $y : \rho \in \Gamma$: imposible. $\boxed{\text{Sin solución}}$

**e) $x : \sigma,\ y : \tau \vdash x\,y : \tau$ — infinitas soluciones**

$\text{t-app}$: $\sigma = \tau \to \rho$ y el resultado es $\rho$; el juicio pide que el resultado sea $\tau$ ⇒ $\rho = \tau$. Por lo tanto
$$\boxed{\sigma = \tau \to \tau,\ \text{con } \tau \text{ arbitrario}}$$
Infinitas soluciones: $\tau = \text{Bool}, \sigma = \text{Bool} \to \text{Bool}$; $\tau = \text{Nat}, \sigma = \text{Nat} \to \text{Nat}$; etc. Notar que acá **no** hay *occurs check* porque $\tau$ no aparece dentro de sí mismo: $\sigma$ está definido en términos de $\tau$, no $\tau$ en términos de $\tau$.

**f) $x : \sigma \vdash x\,\text{true} : \tau$ — infinitas soluciones**

$\text{true} : \text{Bool}$, así que $\text{t-app}$ exige $\sigma = \text{Bool} \to \tau$, con $\tau$ libre.
$$\boxed{\sigma = \text{Bool} \to \tau,\ \tau \text{ arbitrario}}$$

**g) $x : \sigma \vdash x\,\text{true} : \sigma$ — sin solución**

Mismo planteo que f) pero ahora el resultado también debe ser $\sigma$:
$$\sigma = \text{Bool} \to \sigma$$
Esta ecuación **no tiene solución** entre los tipos finitos: $\sigma$ ocurre en el lado derecho (*occurs check* fallido). Cualquier candidato tendría que ser $\text{Bool} \to (\text{Bool} \to (\text{Bool} \to \dots))$, un árbol infinito, que no es generable por $\tau ::= \text{Bool} \mid \text{Nat} \mid \tau \to \tau$. $\boxed{\text{Sin solución}}$

**h) $x : \sigma \vdash x\,x : \tau$ — sin solución (auto-aplicación)**

$\text{t-app}$ exige que el operador tenga tipo flecha con dominio igual al tipo del argumento, y ambos son $x : \sigma$:
$$\sigma = \sigma \to \tau$$
De nuevo falla el *occurs check*: $\sigma$ aparece estrictamente adentro de sí misma, y como los tipos son árboles **finitos**, el lado izquierdo tiene menos constructores que el derecho. $\boxed{\text{Sin solución}}$

Este es el caso más famoso: $\lambda x . x\,x$ (y por lo tanto $\Omega = (\lambda x . x\,x)(\lambda x . x\,x)$) **no es tipable** en el cálculo-$\lambda$ simplemente tipado. Esa es, en el fondo, la razón por la que el cálculo tipado **termina** y hace falta agregar $\text{fix}$ como primitiva para tener recursión general.

**Chuleta**
> 1. Recorrer el término y **anotar restricciones**: cada aplicación $M\,N$ impone $\text{tipo}(M) = \text{tipo}(N) \to \text{algo}$; cada $\text{if}$ impone guarda $= \text{Bool}$ y ramas iguales.
> 2. Cuidado con las **variables repetidas** en el enunciado ($\sigma$ en la anotación *y* en el resultado): son el mismo tipo.
> 3. Sin solución si: hay una variable libre fuera del contexto (d), choque de tipos base (c), u **occurs check** $\sigma = \dots \sigma \dots$ (g, h).
> 4. Infinitas soluciones si queda una variable de tipo libre sin restringir (e, f).
> 5. Resultados: a) $\text{Nat}, \text{Bool}$ · b) $\text{Bool} \to \text{Nat}$ · c) no · d) no · e) $\sigma = \tau \to \tau$ · f) $\sigma = \text{Bool} \to \tau$ · g) no · h) no.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/inferencia_algoritmo_w]]

### Ejercicio 11 — Debilitamiento y fortalecimiento
**Enunciado**
Demostrar las siguientes propiedades, procediendo por inducción en la derivación del juicio correspondiente:
1. Si $\Gamma \vdash M : \sigma$ es un juicio de tipado derivable y $x$ es una variable que no aparece en $\Gamma$, entonces $\Gamma, x : \tau \vdash M : \sigma$ es derivable para todo tipo $\tau$. Esta regla se conoce como *debilitamiento* o *weakening*.
2. Si $\Gamma, x : \tau \vdash M : \sigma$ es un juicio de tipado derivable tal que $x$ no aparece libre en $M$, entonces $\Gamma \vdash M : \sigma$ es derivable para todo tipo $\tau$. Esta regla se conoce como *fortalecimiento* o *strengthening*.
3. Dar un contraejemplo para fortalecimiento en el caso en el que $x$ aparece libre en $M$.

**Explicación**
Propiedades estructurales del contexto de tipado.

**Resolución paso a paso**
**1) Debilitamiento (weakening)**

*Enunciado.* Si $\Gamma \vdash M : \sigma$ es derivable y $x$ no aparece en $\Gamma$, entonces $\Gamma, x : \tau \vdash M : \sigma$ es derivable, para todo $\tau$.

*Demostración por inducción en la derivación de $\Gamma \vdash M : \sigma$*, analizando la última regla aplicada.

- **$\text{t-var}$**: entonces $M = y$ y $y : \sigma \in \Gamma$. Como $\Gamma \subseteq \Gamma, x : \tau$, sigue valiendo $y : \sigma \in \Gamma, x : \tau$ (y el contexto extendido es válido porque $x \notin \Gamma$, así que no hay variables repetidas). Aplicando $\text{t-var}$: $\Gamma, x : \tau \vdash y : \sigma$. ✓
- **$\text{t-true}$, $\text{t-false}$, $\text{t-zero}$**: son axiomas, válidos bajo **cualquier** contexto. Directo. ✓
- **$\text{t-succ}$** (análogo $\text{t-pred}$, $\text{t-isZero}$): $M = \text{succ}(N)$, $\sigma = \text{Nat}$, con premisa $\Gamma \vdash N : \text{Nat}$. Por HI, $\Gamma, x : \tau \vdash N : \text{Nat}$. Aplicando $\text{t-succ}$ se concluye. ✓
- **$\text{t-if}$**: $M = \text{if } N_1 \text{ then } N_2 \text{ else } N_3$ con premisas $\Gamma \vdash N_1 : \text{Bool}$, $\Gamma \vdash N_2 : \sigma$, $\Gamma \vdash N_3 : \sigma$. Tres aplicaciones de la HI y luego $\text{t-if}$. ✓
- **$\text{t-app}$**: $M = N\,P$ con $\Gamma \vdash N : \rho \to \sigma$ y $\Gamma \vdash P : \rho$. HI en ambas premisas + $\text{t-app}$. ✓
- **$\text{t-abs}$** (caso interesante): $M = \lambda y : \rho . N$, $\sigma = \rho \to \sigma'$, con premisa $\Gamma, y : \rho \vdash N : \sigma'$. Por $\alpha$-conversión podemos suponer $y \neq x$ e $y \notin dom(\Gamma)$ (elegimos un representante fresco de la clase de $\alpha$-equivalencia). Entonces $x$ tampoco aparece en $\Gamma, y : \rho$, y la HI da
$$\Gamma, y : \rho, x : \tau \vdash N : \sigma'$$
Como el contexto es un **conjunto** de asignaciones (el orden es irrelevante), esto es $\Gamma, x : \tau, y : \rho \vdash N : \sigma'$, y aplicando $\text{t-abs}$:
$$\Gamma, x : \tau \vdash \lambda y : \rho . N : \rho \to \sigma' \qquad ✓$$

$\blacksquare$

**2) Fortalecimiento (strengthening)**

*Enunciado.* Si $\Gamma, x : \tau \vdash M : \sigma$ es derivable y $x \notin fv(M)$, entonces $\Gamma \vdash M : \sigma$ es derivable.

*Demostración por inducción en la derivación*, con el mismo análisis de casos. La observación transversal es que **las variables libres de las premisas están contenidas en las del término de la conclusión** (salvo por las variables recién ligadas), así que la hipótesis $x \notin fv(\cdot)$ se propaga hacia arriba.

- **$\text{t-var}$**: $M = y$ con $y : \sigma \in \Gamma, x : \tau$. Como $fv(M) = \{y\}$ y $x \notin fv(M)$, resulta $y \neq x$, luego $y : \sigma \in \Gamma$ y vale $\Gamma \vdash y : \sigma$. ✓
- **Axiomas** ($\text{t-true}$, $\text{t-false}$, $\text{t-zero}$): valen en cualquier contexto, en particular en $\Gamma$. ✓
- **$\text{t-succ}$/$\text{t-pred}$/$\text{t-isZero}$**: $fv(\text{succ}(N)) = fv(N)$, así que $x \notin fv(N)$ y aplica la HI. ✓
- **$\text{t-if}$**: $fv(M) = fv(N_1) \cup fv(N_2) \cup fv(N_3)$, luego $x$ no es libre en ninguno de los tres. HI tres veces. ✓
- **$\text{t-app}$**: $fv(N\,P) = fv(N) \cup fv(P)$. Ídem. ✓
- **$\text{t-abs}$**: $M = \lambda y : \rho . N$ con $\Gamma, x : \tau, y : \rho \vdash N : \sigma'$. Por $\alpha$-conversión, $y \neq x$. Como $fv(M) = fv(N) \setminus \{y\}$ y $x \notin fv(M)$ con $x \neq y$, resulta $x \notin fv(N)$. Por HI, $\Gamma, y : \rho \vdash N : \sigma'$, y $\text{t-abs}$ concluye $\Gamma \vdash \lambda y : \rho . N : \rho \to \sigma'$. ✓

$\blacksquare$

**3) Contraejemplo para fortalecimiento con $x$ libre en $M$**

Tomar $\Gamma = \emptyset$, $M = x$, $\tau = \sigma = \text{Bool}$:
- $x : \text{Bool} \vdash x : \text{Bool}$ es derivable por $\text{t-var}$.
- $x$ **sí** aparece libre en $M = x$.
- $\vdash x : \text{Bool}$ **no** es derivable: la única regla para variables es $\text{t-var}$, que exige $x : \text{Bool} \in \emptyset$.

Por lo tanto la hipótesis $x \notin fv(M)$ es esencial. $\blacksquare$

**Corolario (la versión combinada que se usa en la práctica)**

Si $\Gamma \vdash M : \sigma$ y $fv(M) \subseteq dom(\Gamma) \cap dom(\Gamma')$, entonces $\Gamma' \vdash M : \sigma$: **sólo importa la parte del contexto que menciona las variables libres del término**.

**Chuleta**
> 1. Ambas se prueban por **inducción en la derivación** (no en el término), analizando la última regla.
> 2. Casos fáciles: axiomas (valen en cualquier $\Gamma$) y constructores (HI en cada premisa).
> 3. Caso $\text{t-abs}$: usar $\alpha$-conversión para elegir la variable ligada **fresca** y aprovechar que el contexto es un conjunto (se permutan las asignaciones).
> 4. En fortalecimiento la clave es $fv(\text{premisa}) \subseteq fv(\text{conclusión}) \cup \{\text{ligada}\}$.
> 5. Contraejemplo: $x : \text{Bool} \vdash x : \text{Bool}$ vale, $\vdash x : \text{Bool}$ no.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 12 — Lema de sustitución
**Enunciado**
Demostrar que si valen $\Gamma, x : \sigma \vdash M : \tau$ y $\Gamma \vdash N : \sigma$ entonces vale $\Gamma \vdash M\{x := N\} : \tau$.
*Sugerencia:* proceder por inducción en la estructura del término $M$.

**Explicación**
Es el lema clave para demostrar Preservación (Type Safety). La sustitución preserva el tipo.

**Resolución paso a paso**
**Enunciado.** Si $\Gamma, x : \sigma \vdash M : \tau$ y $\Gamma \vdash N : \sigma$, entonces $\Gamma \vdash M\{x := N\} : \tau$.

*Demostración por inducción en la estructura de $M$.* En cada caso usamos **inversión** sobre la derivación de $\Gamma, x : \sigma \vdash M : \tau$ (el constructor de la raíz de $M$ determina la última regla) y la definición de sustitución.

**Caso $M = x$.** Por inversión con $\text{t-var}$: $x : \tau \in \Gamma, x : \sigma$, y como los contextos no repiten variables, $\tau = \sigma$. Además $x\{x := N\} = N$. La hipótesis $\Gamma \vdash N : \sigma$ es exactamente $\Gamma \vdash x\{x := N\} : \tau$. ✓

**Caso $M = y$ con $y \neq x$.** Por inversión, $y : \tau \in \Gamma, x : \sigma$, y como $y \neq x$, resulta $y : \tau \in \Gamma$. Como $y\{x := N\} = y$, vale $\Gamma \vdash y : \tau$ por $\text{t-var}$. ✓

**Casos $M \in \{\text{true}, \text{false}, \text{zero}\}$.** La sustitución es la identidad ($\text{true}\{x := N\} = \text{true}$) y los axiomas valen en cualquier contexto, en particular en $\Gamma$. ✓

**Caso $M = \text{succ}(P)$** (idéntico para $\text{pred}$ e $\text{isZero}$). Por inversión con $\text{t-succ}$: $\tau = \text{Nat}$ y $\Gamma, x : \sigma \vdash P : \text{Nat}$. Por HI, $\Gamma \vdash P\{x := N\} : \text{Nat}$. Como $\text{succ}(P)\{x := N\} = \text{succ}(P\{x := N\})$, $\text{t-succ}$ da $\Gamma \vdash \text{succ}(P\{x := N\}) : \text{Nat}$. ✓
*(Para $\text{isZero}$ el tipo de la conclusión es $\text{Bool}$, el resto es igual.)*

**Caso $M = \text{if } P \text{ then } Q \text{ else } R$.** Por inversión con $\text{t-if}$: $\Gamma, x : \sigma \vdash P : \text{Bool}$, $\Gamma, x : \sigma \vdash Q : \tau$ y $\Gamma, x : \sigma \vdash R : \tau$. Tres aplicaciones de la HI y la definición
$$(\text{if } P \text{ then } Q \text{ else } R)\{x := N\} = \text{if } P\{x := N\} \text{ then } Q\{x := N\} \text{ else } R\{x := N\}$$
permiten aplicar $\text{t-if}$. ✓

**Caso $M = P\,Q$.** Por inversión con $\text{t-app}$: existe $\rho$ tal que $\Gamma, x : \sigma \vdash P : \rho \to \tau$ y $\Gamma, x : \sigma \vdash Q : \rho$. Por HI, $\Gamma \vdash P\{x := N\} : \rho \to \tau$ y $\Gamma \vdash Q\{x := N\} : \rho$. Como $(P\,Q)\{x := N\} = P\{x := N\}\,Q\{x := N\}$, $\text{t-app}$ concluye. ✓

**Caso $M = \lambda y : \rho . P$** (el caso interesante). Por $\alpha$-conversión elegimos el representante con
$$y \neq x, \qquad y \notin fv(N), \qquad y \notin dom(\Gamma)$$
Por inversión con $\text{t-abs}$: $\tau = \rho \to \rho'$ y $\Gamma, x : \sigma, y : \rho \vdash P : \rho'$, que por permutación del contexto es $\Gamma, y : \rho, x : \sigma \vdash P : \rho'$.

Necesitamos la segunda hipótesis en el contexto extendido: por **debilitamiento** (Ej. 11.1), de $\Gamma \vdash N : \sigma$ y $y \notin dom(\Gamma)$ obtenemos
$$\Gamma, y : \rho \vdash N : \sigma$$

Ahora la HI (instanciada con el contexto $\Gamma, y : \rho$) da
$$\Gamma, y : \rho \vdash P\{x := N\} : \rho'$$
y por $\text{t-abs}$:
$$\Gamma \vdash \lambda y : \rho . (P\{x := N\}) : \rho \to \rho'$$
Finalmente, como $y \neq x$ e $y \notin fv(N)$, la definición de sustitución da exactamente
$$(\lambda y : \rho . P)\{x := N\} = \lambda y : \rho . (P\{x := N\})$$
con lo que $\Gamma \vdash (\lambda y : \rho . P)\{x := N\} : \rho \to \rho'$. ✓

$\blacksquare$

**Por qué es *el* lema**

Es el ingrediente central de la **preservación de tipos**: en el paso $(\lambda x : \sigma . M)\,V \to M\{x := V\}$ hay que garantizar que el término resultante conserva el tipo. Por inversión, $\Gamma \vdash \lambda x : \sigma . M : \sigma \to \tau$ implica $\Gamma, x : \sigma \vdash M : \tau$, y $\Gamma \vdash V : \sigma$; el lema entrega $\Gamma \vdash M\{x := V\} : \tau$. Sin él no hay *type safety*.

Notar también dónde se usa la condición de evitar captura: si en el caso $\lambda$ no renombráramos $y$ cuando $y \in fv(N)$, el $N$ sustituido quedaría con su $y$ **capturado** por el ligador, cambiando su tipo (y su significado), y la demostración se caería.

**Chuleta**
> 1. Inducción **estructural en $M$**; en cada caso: inversión de la regla de tipado + definición de sustitución + HI.
> 2. Casos base: $M = x$ ⇒ $\tau = \sigma$ y queda la hipótesis $\Gamma \vdash N : \sigma$; $M = y \neq x$ ⇒ la sustitución no hace nada; constantes ⇒ trivial.
> 3. Constructores ($\text{succ}$, $\text{if}$, aplicación): la sustitución conmuta con el constructor ⇒ HI en cada premisa.
> 4. Caso $\lambda y : \rho . P$: $\alpha$-renombrar $y$ fresca ($y \neq x$, $y \notin fv(N)$), **debilitar** $\Gamma \vdash N : \sigma$ a $\Gamma, y : \rho \vdash N : \sigma$, HI, y $\text{t-abs}$.
> 5. Se usa para probar **preservación** en el paso $\beta$: $(\lambda x : \sigma . M)V \to M\{x := V\}$.

**¿Aparece en parciales?** ⚪ No

---

## SEMÁNTICA

### Ejercicio 13 — Sustituciones
**Enunciado**
Sean $\sigma, \tau, \rho$ tipos. Según la definición de sustitución, calcular:
a) $(\lambda y : \sigma . x (\lambda x : \tau . x))\{x := (\lambda y : \rho . x y)\}$
b) $(y (\lambda v : \sigma . x v))\{x := (\lambda y : \tau . v y)\}$
Renombrar variables en ambos términos para que las sustituciones no cambien su significado.

**Explicación**
Práctica de sustitución evitando la captura de variables. Requiere $\alpha$-conversión previa.

**Resolución paso a paso**
Recordar la definición de sustitución en el caso de la abstracción:
$$(\lambda y : \rho . P)\{x := N\} = \begin{cases} \lambda y : \rho . P & \text{si } x = y \\ \lambda y : \rho . (P\{x := N\}) & \text{si } x \neq y \text{ y } y \notin fv(N) \\ \lambda z : \rho . (P\{y := z\}\{x := N\}) & \text{si } x \neq y \text{ y } y \in fv(N),\ z \text{ fresca} \end{cases}$$
El tercer caso es la $\alpha$-conversión obligatoria para **evitar la captura**.

**a) $(\lambda y : \sigma . x\,(\lambda x : \tau . x))\{x := (\lambda y : \rho . x\,y)\}$**

Sea $N = \lambda y : \rho . x\,y$, con $fv(N) = \{x\}$.

*Paso 1 — identificar las ocurrencias libres de $x$ en el término de la izquierda.*
$$M = \lambda y : \sigma . \underbrace{x}_{\text{libre}}\,(\lambda x : \tau . \underbrace{x}_{\text{ligada por } \lambda x})$$
Sólo la primera ocurrencia de $x$ es libre; la de adentro está ligada por $\lambda x : \tau$, así que la sustitución **no la toca**.

*Paso 2 — chequear captura.* El ligador que se atraviesa hasta la ocurrencia libre es $\lambda y : \sigma$, y $y \notin fv(N) = \{x\}$: no hay captura. Igualmente conviene renombrar para que quede legible, ya que $N$ tiene su propia $y$ ligada.

*Renombramiento previo (α-conversión):* $M \equiv_\alpha \lambda y_1 : \sigma . x\,(\lambda x_1 : \tau . x_1)$.

*Paso 3 — resultado.*
$$\boxed{\ \lambda y_1 : \sigma .\ (\lambda y : \rho . x\,y)\ (\lambda x_1 : \tau . x_1)\ }$$

La $x$ que quedó adentro (dentro de $N$) sigue siendo **libre** en el resultado, como debe ser: la sustitución no debe ligarla.

**b) $(y\,(\lambda v : \sigma . x\,v))\{x := (\lambda y : \tau . v\,y)\}$**

Sea $N = \lambda y : \tau . v\,y$, con $fv(N) = \{v\}$.

*Paso 1 — ocurrencias libres de $x$.* En $M = y\,(\lambda v : \sigma . x\,v)$ hay una sola ocurrencia de $x$, y es libre, pero está **debajo del ligador $\lambda v : \sigma$**.

*Paso 2 — chequear captura.* ¡Acá sí hay problema! $v \in fv(N)$. Si sustituyéramos ingenuamente obtendríamos
$$y\,(\lambda v : \sigma . (\lambda y : \tau . v\,y)\,v)$$
donde la $v$ que venía libre en $N$ quedó **capturada** por $\lambda v : \sigma$: eso cambia el significado del término y es incorrecto.

*Paso 3 — $\alpha$-conversión obligatoria.* Renombramos la ligada $v$ por una fresca $w \notin fv(N) \cup fv(M)$:
$$M \equiv_\alpha y\,(\lambda w : \sigma . x\,w)$$
(De paso, para evitar confusión con la $y$ libre de $M$, renombramos también la ligada de $N$: $N \equiv_\alpha \lambda y_1 : \tau . v\,y_1$.)

*Paso 4 — resultado.*
$$\boxed{\ y\,(\lambda w : \sigma .\ (\lambda y_1 : \tau . v\,y_1)\ w)\ }$$

Chequeo final de variables libres: $fv(\text{resultado}) = \{y, v\}$. Es el resultado correcto: $fv(M\{x := N\}) = (fv(M) \setminus \{x\}) \cup fv(N) = \{y\} \cup \{v\}$. Si no hubiéramos renombrado, $v$ habría desaparecido del conjunto de libres — la señal inequívoca de que hubo captura.

**Chuleta**
> 1. Marcar **cuáles ocurrencias de $x$ son libres** en $M$ (las que están bajo un $\lambda x$ no se sustituyen).
> 2. Calcular $fv(N)$ y compararlo con los ligadores que hay en el camino hasta cada ocurrencia libre.
> 3. Si algún ligador $\lambda y$ tiene $y \in fv(N)$ → **$\alpha$-renombrar $y$ por una variable fresca antes de sustituir** (caso b: $v \to w$).
> 4. Sustituir y verificar con la fórmula $fv(M\{x := N\}) = (fv(M) \setminus \{x\}) \cup fv(N)$; si se perdió una libre, hubo captura.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_reduccion_pasos]]

### Ejercicio 14 — Conmutación de sustituciones
**Enunciado**
a) Por inducción en la estructura del término $M$, demostrar que si $x$ no aparece libre en $P$ y $x \neq y$, entonces:
$M\{x := N\}\{y := P\} = M\{y := P\}\{x := N\{y := P\}\}$
b) Dar un contraejemplo para la ecuación de arriba cuando $x$ aparece libre en $P$.

**Explicación**
Propiedad técnica de la sustitución.

**Resolución paso a paso**
**a) Demostración de $M\{x := N\}\{y := P\} = M\{y := P\}\{x := N\{y := P\}\}$, con $x \notin fv(P)$ y $x \neq y$**

*Inducción en la estructura de $M$.*

**Caso $M = x$.**
- Izquierda: $x\{x := N\}\{y := P\} = N\{y := P\}$.
- Derecha: $x\{y := P\} = x$ (pues $x \neq y$), y luego $x\{x := N\{y := P\}\} = N\{y := P\}$.

Coinciden. ✓

**Caso $M = y$.**
- Izquierda: $y\{x := N\} = y$ (pues $x \neq y$), y luego $y\{y := P\} = P$.
- Derecha: $y\{y := P\} = P$, y luego $P\{x := N\{y := P\}\} = P$, porque **$x \notin fv(P)$** y sustituir una variable que no ocurre libre no hace nada.

Coinciden. ✓ *(Éste es el único caso donde se usa la hipótesis $x \notin fv(P)$.)*

**Caso $M = z$ con $z \notin \{x, y\}$.** Ambos lados dan $z$: ninguna sustitución la afecta. ✓

**Casos $M \in \{\text{true}, \text{false}, \text{zero}\}$.** Ambos lados dan $M$: la sustitución es la identidad sobre constantes. ✓

**Caso $M = \text{succ}(M')$** (ídem $\text{pred}$, $\text{isZero}$). La sustitución conmuta con el constructor:
$$\text{succ}(M')\{x := N\}\{y := P\} = \text{succ}(M'\{x := N\}\{y := P\}) \overset{\text{HI}}{=} \text{succ}(M'\{y := P\}\{x := N\{y := P\}\})$$
que es el lado derecho. ✓

**Caso $M = M_1\,M_2$.** Igual: la sustitución se distribuye sobre la aplicación y se aplica la HI a $M_1$ y $M_2$. ✓

**Caso $M = \text{if } M_1 \text{ then } M_2 \text{ else } M_3$.** Ídem con tres HI. ✓

**Caso $M = \lambda z : \rho . M'$.** Por $\alpha$-conversión elegimos $z$ **fresca**, es decir
$$z \notin \{x, y\} \cup fv(N) \cup fv(P) \cup fv(N\{y := P\})$$
(siempre es posible, porque estos conjuntos son finitos). Bajo esa condición, las cuatro sustituciones atraviesan el ligador sin renombrar:
$$(\lambda z : \rho . M')\{x := N\}\{y := P\} = \lambda z : \rho . (M'\{x := N\}\{y := P\}) \overset{\text{HI}}{=} \lambda z : \rho . (M'\{y := P\}\{x := N\{y := P\}\})$$
que es exactamente $(\lambda z : \rho . M')\{y := P\}\{x := N\{y := P\}\}$. ✓

$\blacksquare$

**b) Contraejemplo cuando $x$ aparece libre en $P$**

Tomar
$$M = y, \qquad N = z, \qquad P = x \qquad (\text{con } x, y, z \text{ variables distintas})$$
Se cumple $x \neq y$, pero $x \in fv(P) = \{x\}$.

- **Izquierda:** $y\{x := z\}\{y := x\} = y\{y := x\} = \boxed{x}$
- **Derecha:** $y\{y := x\}\{x := z\{y := x\}\} = x\{x := z\} = \boxed{z}$

Como $x \neq z$, los dos lados son términos distintos. $\blacksquare$

**Intuición del contraejemplo:** al hacer primero $\{y := P\}$ se introduce en el término una $x$ *nueva* (la que venía adentro de $P$), y la sustitución posterior $\{x := \dots\}$ la pisa. En el lado izquierdo esa $x$ nunca queda expuesta a la sustitución de $x$, porque $\{x := N\}$ ya se hizo antes. La hipótesis $x \notin fv(P)$ es justamente la que impide que $P$ aporte $x$'s frescas.

**Dónde se usa esta propiedad:** es el lema técnico central en la demostración de confluencia y en la prueba de que la $\beta$-reducción está bien definida sobre clases de $\alpha$-equivalencia.

**Chuleta**
> 1. Inducción estructural en $M$; los constructores son todos rutina (la sustitución conmuta con ellos).
> 2. Los dos casos que importan: $M = x$ (ambos lados dan $N\{y := P\}$) y $M = y$ (ambos dan $P$, **usando $x \notin fv(P)$**).
> 3. Caso $\lambda z$: elegir $z$ fresca respecto de $x, y, fv(N), fv(P), fv(N\{y := P\})$.
> 4. Contraejemplo: $M = y$, $N = z$, $P = x$ ⇒ izquierda $= x$, derecha $= z$.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 15 — Valores
**Enunciado**
Dado el conjunto de valores visto en clase ($V ::= \lambda x : \tau . M \mid \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V)$), determinar si cada una de las siguientes expresiones es o no un valor:
a) $(\lambda x : \text{Bool} . x) \text{ true}$ | b) $\lambda x : \text{Bool} . \underline{2}$ | c) $\lambda x : \text{Bool} . \text{pred}(\underline{2})$ | d) $\lambda y : \text{Nat} . (\lambda x : \text{Bool} . \text{pred}(\underline{2})) \text{ true}$ | e) $x$ | f) $\text{succ}(\text{succ}(\text{zero}))$

**Explicación**
Un valor es un término que no puede reducirse más bajo la estrategia de evaluación dada. Las abstracciones siempre son valores (en evaluación call-by-value estándar).

**Resolución paso a paso**
Gramática de valores: $V ::= \lambda x : \tau . M \mid \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V)$.

Dos reglas de oro:
- **Toda abstracción es un valor**, sin importar cómo sea su cuerpo (en *call-by-value* no se reduce debajo del $\lambda$: no existe la regla $\xi$).
- $\text{succ}(M)$ es valor **sólo si** $M$ es valor (es $\text{succ}(V)$, no $\text{succ}(M)$); en cambio $\text{pred}$ e $\text{isZero}$ **nunca** producen valores.

| # | Expresión | ¿Valor? | Justificación |
|---|---|---|---|
| a | $(\lambda x : \text{Bool} . x)\ \text{true}$ | ❌ No | Es una aplicación, y ninguna aplicación está en la gramática de valores. De hecho es un redex: reduce a $\text{true}$ por $\text{e-appAbs}$ |
| b | $\lambda x : \text{Bool} . \underline{2}$ | ✅ Sí | Abstracción |
| c | $\lambda x : \text{Bool} . \text{pred}(\underline{2})$ | ✅ Sí | Abstracción. Que el cuerpo sea reducible es irrelevante: sin regla $\xi$ no se evalúa adentro del $\lambda$ |
| d | $\lambda y : \text{Nat} . (\lambda x : \text{Bool} . \text{pred}(\underline{2}))\ \text{true}$ | ✅ Sí | Abstracción. Idem c: el cuerpo tiene un redex pero no se toca |
| e | $x$ | ❌ No | Las variables no están en la gramática de valores. Además un valor se espera como resultado de evaluar un **programa** (término cerrado), y $x$ no es cerrado |
| f | $\text{succ}(\text{succ}(\text{zero}))$ | ✅ Sí | $\text{zero}$ es valor ⇒ $\text{succ}(\text{zero})$ es valor ⇒ $\text{succ}(\text{succ}(\text{zero}))$ es valor. Es el numeral $\underline{2}$ |

**Detalle sobre c) y d)**

Son la trampa clásica del ejercicio: uno tiende a pensar "el cuerpo se puede reducir ⇒ no es valor". Falso en *call-by-value*. La única forma de que el cuerpo de $\lambda x : \text{Bool} . \text{pred}(\underline{2})$ se evalúe es que la abstracción sea **aplicada** a un argumento y se dispare $\text{e-appAbs}$. Mientras tanto, es un valor y es una forma normal.

Comparar con el Ejercicio 19 de la guía: al agregar la regla $\xi$ ($M \to M' \Rightarrow \lambda x : \tau . M \to \lambda x : \tau . M'$) hay que **redefinir** los valores como "abstracciones cuyo cuerpo ya es una forma normal", y c) y d) dejarían de ser valores.

**Detalle sobre e)**

$x$ **es** una forma normal (no hay regla que la reduzca) pero **no es un valor**. Es el ejemplo mínimo de la distinción forma normal ≠ valor. En el cálculo restringido a programas esto no se presenta, porque los programas son cerrados.

**Chuleta**
> 1. Los valores son: $\lambda$-abstracciones, $\text{true}$, $\text{false}$, $\text{zero}$, y $\text{succ}(V)$ con $V$ valor.
> 2. **Toda abstracción es valor**, aunque su cuerpo tenga redexes (no hay regla $\xi$ en CBV) → b, c, d son valores.
> 3. Aplicaciones, $\text{if}$, $\text{pred}(\cdot)$, $\text{isZero}(\cdot)$ y **variables** nunca son valores → a, e no lo son.
> 4. $\text{succ}$ propaga: $\text{succ}(\text{succ}(\text{zero}))$ sí es valor.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_semantica_adt]]

### Ejercicio 16 — Programas y forma normal
**Enunciado**
Para el siguiente ejercicio, considerar el cálculo **sin** la regla $\text{pred}(\text{zero}) \to \text{zero}$.
Un *programa* es un término que tipa en el contexto vacío.
Para cada una de las siguientes expresiones:
a) Determinar si puede ser considerada un programa.
b) Si es un programa, ¿Cuál es el resultado de su evaluación? Determinar si se trata de una forma normal, y en caso de serlo, si es un **valor** o un **error**.

I. $(\lambda x : \text{Bool} . x) \text{ true}$
II. $\lambda x : \text{Nat} . \text{pred}(\text{succ}(x))$
III. $\lambda x : \text{Nat} . \text{pred}(\text{succ}(y))$
IV. $(\lambda x : \text{Bool} . \text{pred}(\text{isZero}(x))) \text{ true}$
V. $(\lambda f : \text{Nat} \to \text{Bool} . f \text{ zero}) (\lambda x : \text{Nat} . \text{isZero}(x))$
VI. $(\lambda f : \text{Nat} \to \text{Bool} . x) (\lambda x : \text{Nat} . \text{isZero}(x))$
VII. $(\lambda f : \text{Nat} \to \text{Bool} . f \text{ pred}(\text{zero})) (\lambda x : \text{Nat} . \text{isZero}(x))$
VIII. $x\ \lambda y : \text{Nat} . \text{succ}(y)$

**Explicación**
Diferencia entre forma normal (no reduce más) y valor (resultado deseado). Un error es una forma normal que no es un valor (término "trabado" o "stuck").

**Resolución paso a paso**
Recordar: **programa** = término cerrado y tipable en el contexto vacío. **Forma normal** = no reduce más. **Valor** = forma normal "buena" (está en la gramática de valores). **Error / stuck** = forma normal que **no** es valor.

Trabajamos **sin** la regla $\text{pred}(\text{zero}) \to \text{zero}$, así que $\text{pred}(\text{zero})$ queda trabado.

**I. $(\lambda x : \text{Bool} . x)\ \text{true}$**

Cerrado ✓. Tipa: $\vdash \lambda x : \text{Bool} . x : \text{Bool} \to \text{Bool}$ y $\vdash \text{true} : \text{Bool}$ ⇒ $\vdash M : \text{Bool}$. **Es programa.**
Evaluación: $(\lambda x : \text{Bool} . x)\ \text{true} \to \text{true}$ por $\text{e-appAbs}$ ($\text{true}$ ya es valor).
**Resultado: $\text{true}$, forma normal y valor.** ✓

**II. $\lambda x : \text{Nat} . \text{pred}(\text{succ}(x))$**

Cerrado ✓ ($x$ está ligada). Tipa: $x : \text{Nat} \vdash \text{succ}(x) : \text{Nat}$, luego $\text{pred}(\text{succ}(x)) : \text{Nat}$ y $\vdash M : \text{Nat} \to \text{Nat}$. **Es programa.**
Evaluación: **ya está evaluado**. Es una abstracción, y sin regla $\xi$ no se reduce el cuerpo.
**Resultado: el mismo término, forma normal y valor.** ✓

*(Notar que el cuerpo $\text{pred}(\text{succ}(x))$ tampoco reduciría por sí solo: $\text{e-predSucc}$ exige $\text{pred}(\text{succ}(V))$ con $V$ **valor**, y $x$ no lo es.)*

**III. $\lambda x : \text{Nat} . \text{pred}(\text{succ}(y))$**

$fv(M) = \{y\} \neq \emptyset$ ⇒ **no es cerrado** ⇒ no tipa en el contexto vacío. **No es programa.** (No corresponde evaluarlo.)

**IV. $(\lambda x : \text{Bool} . \text{pred}(\text{isZero}(x)))\ \text{true}$**

Cerrado ✓, pero **no tipa**: en el cuerpo, $\text{isZero}(x) : \text{Bool}$ y $\text{t-pred}$ exige su argumento de tipo $\text{Nat}$. **No es programa.**
*(Si igualmente lo evaluáramos: $\to \text{pred}(\text{isZero}(\text{true}))$ y ahí se traba — $\text{isZero}$ espera $\text{Nat}$. Justamente el tipo de error que el sistema de tipos previene.)*

**V. $(\lambda f : \text{Nat} \to \text{Bool} . f\ \text{zero})\ (\lambda x : \text{Nat} . \text{isZero}(x))$**

Cerrado ✓. Tipa: el argumento es $\lambda x : \text{Nat} . \text{isZero}(x) : \text{Nat} \to \text{Bool}$, coincide con la anotación de $f$; el cuerpo $f\ \text{zero} : \text{Bool}$ ⇒ $\vdash M : \text{Bool}$. **Es programa.**
Evaluación (el argumento ya es valor, así que se dispara $\text{e-appAbs}$):
$$M \to (\lambda x : \text{Nat} . \text{isZero}(x))\ \text{zero} \to \text{isZero}(\text{zero}) \to \text{true}$$
**Resultado: $\text{true}$, forma normal y valor.** ✓

**VI. $(\lambda f : \text{Nat} \to \text{Bool} . x)\ (\lambda x : \text{Nat} . \text{isZero}(x))$**

La variable ligada del primer $\lambda$ es $f$, y el cuerpo es $x$: esa $x$ queda **libre** (la $x$ del segundo $\lambda$ es otra, ligada dentro del argumento). $fv(M) = \{x\}$ ⇒ **no es cerrado** ⇒ **no es programa.**
*(Es la trampa del ejercicio: hay que mirar cuál ligador alcanza cada ocurrencia.)*

**VII. $(\lambda f : \text{Nat} \to \text{Bool} . f\ \text{pred}(\text{zero}))\ (\lambda x : \text{Nat} . \text{isZero}(x))$**

Parentización: $\text{pred}(\text{zero})$ es un átomo sintáctico, así que el cuerpo es $f\ (\text{pred}(\text{zero}))$.
Cerrado ✓. Tipa: $\text{pred}(\text{zero}) : \text{Nat}$, $f : \text{Nat} \to \text{Bool}$ ⇒ cuerpo $: \text{Bool}$ ⇒ $\vdash M : \text{Bool}$. **Es programa.**
Evaluación:
1. El argumento $\lambda x : \text{Nat} . \text{isZero}(x)$ ya es valor ⇒ $\text{e-appAbs}$:
$$M \to (\lambda x : \text{Nat} . \text{isZero}(x))\ \text{pred}(\text{zero})$$
2. Ahora hace falta que el argumento sea un valor para volver a aplicar $\text{e-appAbs}$. Se intenta $\text{e-app2}$, que exige $\text{pred}(\text{zero}) \to N'$: **no hay ninguna regla aplicable**, porque quitamos $\text{pred}(\text{zero}) \to \text{zero}$ y $\text{e-predSucc}$ pide la forma $\text{pred}(\text{succ}(V))$.

**Resultado: $(\lambda x : \text{Nat} . \text{isZero}(x))\ \text{pred}(\text{zero})$ es forma normal pero NO es valor ⇒ es un ERROR (término trabado / stuck).**

Este caso es la moraleja del ejercicio: **al quitar la regla $\text{pred}(\text{zero}) \to \text{zero}$ se rompe la propiedad de progreso** — hay un término bien tipado y cerrado que no es valor y no puede seguir reduciendo. La preservación de tipos, en cambio, se mantiene.

**VIII. $x\ \lambda y : \text{Nat} . \text{succ}(y)$**

Parentización: la aplicación toma como argumento toda la abstracción que la sigue, o sea $M = x\ (\lambda y : \text{Nat} . \text{succ}(y))$.

$fv(M) = \{x\}$ ⇒ **no es cerrado** ⇒ no tipa en el contexto vacío. **No es programa.** (No corresponde evaluarlo.)

Es la tercera variante de la misma trampa que III y VI: el término está sintácticamente bien formado y hasta sería tipable en un contexto no vacío — con $x : (\text{Nat} \to \text{Nat}) \to \sigma$ tendríamos $\Gamma \vdash M : \sigma$ — pero *programa* exige contexto vacío, y ahí no hay nada que le dé tipo a $x$. Además, aun tipado en un contexto, $M$ sería una forma normal que **no** es valor (una aplicación con una variable en la posición de función queda trabada): un término *stuck*, como el de VII.

> **Nota (lectura alternativa).** Una transcripción previa de esta página leía el ítem como $\text{fix}\ (\lambda y : \text{Nat} . \text{succ}(y))$. **No es lo que dice la guía** — el PDF original dice `x λy: Nat. succ(y)` —, pero el caso es instructivo y vale la pena tenerlo a mano: asumiendo el cálculo extendido con $\text{fix}$ (regla de tipado $\dfrac{\Gamma \vdash M : \tau \to \tau}{\Gamma \vdash \text{fix } M : \tau}$ y regla de reducción $\text{fix}(\lambda y : \tau . M) \to M\{y := \text{fix}(\lambda y : \tau . M)\}$), ese término **sí** es cerrado y tipa con $\tau = \text{Nat}$, o sea que **es programa**, pero **diverge**:
> $$\text{fix}(\lambda y . \text{succ}(y)) \to \text{succ}(\text{fix}(\lambda y . \text{succ}(y))) \to \text{succ}(\text{succ}(\text{fix}(\lambda y . \text{succ}(y)))) \to \dots$$
> Nunca alcanza una forma normal: no hay resultado, la evaluación no termina. Muestra que agregar $\text{fix}$ hace perder la propiedad de **terminación** (y, vía Curry-Howard, la consistencia de la lógica asociada).

**Resumen**

| # | ¿Programa? | Resultado | Clasificación |
|---|---|---|---|
| I | Sí | $\text{true}$ | Forma normal, **valor** |
| II | Sí | él mismo | Forma normal, **valor** |
| III | No (variable libre $y$) | — | — |
| IV | No (no tipa: $\text{pred}$ sobre $\text{Bool}$) | — | — |
| V | Sí | $\text{true}$ | Forma normal, **valor** |
| VI | No (variable libre $x$) | — | — |
| VII | Sí | $(\lambda x : \text{Nat} . \text{isZero}(x))\ \text{pred}(\text{zero})$ | Forma normal, **ERROR** |
| VIII | No (variable libre $x$) | — | — |

**Chuleta**
> 1. ¿Programa? = **cerrado** ($fv = \emptyset$) **y** tipa con $\vdash$. Chequear las dos cosas: III, VI y VIII fallan por libres, IV falla por tipado.
> 2. Evaluar en CBV: reducir el operador, después el argumento hasta valor, después $\beta$. Sin regla $\xi$ ⇒ las abstracciones ya están listas (II).
> 3. Clasificar el final: **valor** si está en la gramática $V$; **error/stuck** si es forma normal pero no valor (VII, por sacar $\text{pred}(\text{zero}) \to \text{zero}$); **no termina** si diverge (no pasa en esta lista — ver la nota sobre $\text{fix}$ en VIII).
> 4. Moraleja: sacar una regla de reducción rompe **progreso**, no preservación.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_reduccion_pasos]]

### Ejercicio 17 — Determinismo
**Enunciado**
a) ¿Es cierto que la relación definida $\to$ está determinada (es una función parcial)? Más precisamente, ¿pasa que si $M \to N$ y $M \to N'$ entonces también vale $N = N'$?
b) ¿Vale lo mismo con muchos pasos? Es decir, ¿es cierto que si $M \twoheadrightarrow M'$ y $M \twoheadrightarrow M''$ entonces $M' = M''$?
c) ¿Acaso es cierto que si $M \to M'$ y $M \twoheadrightarrow M''$ entonces $M' = M''$?

**Explicación**
Pregunta si la semántica operacional *small-step* es determinista: dado un término, ¿hay a lo sumo un redex que se pueda contraer? La respuesta cambia radicalmente según se hable de **un paso** ($\to$) o de **muchos pasos** ($\twoheadrightarrow$, la clausura reflexo-transitiva): $\twoheadrightarrow$ nunca puede ser determinista, porque incluye el paso de cero pasos.

**Resolución paso a paso**
**Lema previo (valores = formas normales)**

*Si $V$ es un valor, entonces no existe $W$ tal que $V \to W$.*

Por inducción en la gramática de valores: $\text{true}$, $\text{false}$, $\text{zero}$ y $\lambda x : \tau . M$ no aparecen del lado izquierdo de ninguna regla (no hay regla $\xi$, ver Ej. 19); y $\text{succ}(V)$ sólo podría reducir por $\text{e-succ}$, que exige $V \to V'$, imposible por hipótesis inductiva. $\blacksquare$

Este lema es lo que hace funcionar todo el ejercicio: las reglas de congruencia piden que **algo reduzca**, y las reglas de computación piden que ese mismo lugar **ya sea un valor**. Como un valor no reduce, las dos familias de reglas nunca se pisan.

**a) Sí: $\to$ es determinista (es una función parcial).**

Se prueba por inducción estructural sobre $M$ (equivalentemente, sobre la derivación de $M \to N$), mostrando que en cada caso **a lo sumo una regla** es aplicable y que su premisa determina unívocamente el resultado.

| Forma de $M$ | Reglas candidatas | Por qué son excluyentes |
|---|---|---|
| $x$, $\text{true}$, $\text{false}$, $\text{zero}$, $\lambda x : \tau . M_1$ | ninguna | No reducen: el caso es vacío |
| $\text{if } M_1 \text{ then } M_2 \text{ else } M_3$ | $\text{e-ifTrue}$ ($M_1 = \text{true}$), $\text{e-ifFalse}$ ($M_1 = \text{false}$), $\text{e-if}$ ($M_1 \to M_1'$) | $\text{true}$ y $\text{false}$ son valores ⇒ no reducen ⇒ si aplica una de las dos primeras no aplica la tercera. Y si aplica $\text{e-if}$, por HI el $M_1'$ es único |
| $M_1\ M_2$ | $\text{e-app1}$ ($M_1 \to M_1'$), $\text{e-app2}$ ($M_1 = V$, $M_2 \to M_2'$), $\text{e-appAbs}$ ($M_1 = \lambda x : \tau . P$, $M_2 = V$) | $\text{e-app1}$ pide $M_1$ reducible; $\text{e-app2}$ y $\text{e-appAbs}$ piden $M_1$ **valor**: excluyentes por el lema. Entre las dos últimas: una pide $M_2$ reducible, la otra $M_2$ valor: idem |
| $\text{succ}(M_1)$ | $\text{e-succ}$ | Única regla; por HI $M_1'$ es único |
| $\text{pred}(M_1)$ | $\text{e-pred}$ ($M_1 \to M_1'$), $\text{e-predZero}$ ($M_1 = \text{zero}$), $\text{e-predSucc}$ ($M_1 = \text{succ}(V)$) | $\text{zero}$ y $\text{succ}(V)$ son valores ⇒ no reducen. Y $\text{zero} \neq \text{succ}(V)$ sintácticamente |
| $\text{isZero}(M_1)$ | $\text{e-isZero}$, $\text{e-isZeroZero}$, $\text{e-isZeroSucc}$ | Idem $\text{pred}$ |

En todos los casos el resultado queda unívocamente determinado, así que $M \to N$ y $M \to N'$ implican $N = N'$. $\blacksquare$

La lectura conceptual: la estrategia *call-by-value* fija **un único orden de evaluación** (primero la función, después el argumento, después $\beta$), así que en cada término hay a lo sumo **un** redex habilitado. Por eso $\to$ se puede pensar como una función parcial $\text{eval1} : \text{Term} \rightharpoonup \text{Term}$ (parcial porque las formas normales no tienen imagen).

**b) No.** $\twoheadrightarrow$ **no** es determinista, y el contraejemplo es inmediato: $\twoheadrightarrow$ es reflexiva.

Sea $M = (\lambda x : \text{Bool} . x)\ \text{true}$. Entonces:
- $M \twoheadrightarrow M$ (cero pasos, por reflexividad) ⇒ $M' = (\lambda x : \text{Bool} . x)\ \text{true}$
- $M \twoheadrightarrow \text{true}$ (un paso, $\text{e-appAbs}$) ⇒ $M'' = \text{true}$

y $M' \neq M''$. Con dos pasos intermedios pasa lo mismo: $\text{isZero}(\text{pred}(\text{succ}(\text{zero}))) \twoheadrightarrow \text{isZero}(\text{zero})$ y también $\twoheadrightarrow \text{true}$.

Lo que **sí** vale, y es la propiedad realmente útil, es la **unicidad de la forma normal**:

> Si $M \twoheadrightarrow M'$ y $M \twoheadrightarrow M''$ con $M'$ y $M''$ **formas normales**, entonces $M' = M''$.

*Prueba:* por inducción en la longitud de la primera reducción, usando a). Si $M$ es forma normal, ambas secuencias tienen longitud $0$ y $M' = M'' = M$. Si no, $M \to N$ es el único primer paso posible, así que ambas secuencias empiezan igual y se concluye por HI sobre $N$. $\blacksquare$

Corolario: cada programa tiene **a lo sumo un resultado**. Es exactamente lo que uno quiere de un lenguaje de programación, y lo que justifica hablar de "*el*" resultado de evaluar $M$.

**c) No, por la misma razón que b): el caso de cero pasos.**

Contraejemplo: $M = \text{isZero}(\text{pred}(\text{succ}(\text{zero})))$.
- $M \to \text{isZero}(\text{zero}) = M'$ (por $\text{e-predSucc}$ bajo $\text{e-isZero}$)
- $M \twoheadrightarrow M = M''$ (cero pasos)

y $M' \neq M''$. Incluso pidiendo al menos un paso el enunciado falla: $M \twoheadrightarrow \text{true}$ en dos pasos, y $\text{isZero}(\text{zero}) \neq \text{true}$.

Lo correcto es la versión "alineada" de la propiedad, que sí se deduce de a):

> Si $M \to M'$ y $M \twoheadrightarrow M''$, entonces **o bien** $M'' = M$ (cero pasos) **o bien** $M' \twoheadrightarrow M''$.

Es decir, $M'$ está siempre *en el camino* hacia $M''$: no hay bifurcación, sólo distinta cantidad de pasos recorridos.

**Resumen**

| Ítem | Enunciado | ¿Vale? | Motivo |
|---|---|---|---|
| a | $M \to N$, $M \to N'$ ⇒ $N = N'$ | ✅ Sí | En CBV hay a lo sumo un redex habilitado; valores no reducen |
| b | $M \twoheadrightarrow M'$, $M \twoheadrightarrow M''$ ⇒ $M' = M''$ | ❌ No | $\twoheadrightarrow$ es reflexiva: distinta cantidad de pasos, distinto resultado intermedio. Sí vale si ambos son formas normales |
| c | $M \to M'$, $M \twoheadrightarrow M''$ ⇒ $M' = M''$ | ❌ No | Idem: $M'' = M$ con cero pasos. Lo que vale es $M'' = M$ o $M' \twoheadrightarrow M''$ |

**Chuleta**
> 1. **$\to$ es determinista** (función parcial). Se prueba por inducción estructural, caso por caso de la gramática.
> 2. El motor de la prueba es el lema **"los valores son formas normales"**: separa las congruencias (piden reducible) de las computaciones (piden valor).
> 3. **$\twoheadrightarrow$ NO es determinista** — es reflexiva, así que $M \twoheadrightarrow M$ siempre; cualquier término reducible es contraejemplo.
> 4. Lo que sí vale: **unicidad de la forma normal** (si $M \twoheadrightarrow M'$ y $M \twoheadrightarrow M''$ con ambas formas normales ⇒ $M' = M''$). Eso es lo que se cita en un parcial.
> 5. Determinismo se **rompe** si se agrega la regla $\xi$ sin restringir las congruencias (ver Ej. 19).

**¿Aparece en parciales?** ⚪ No

### Ejercicio 18 — Propiedades de succ y pred
**Enunciado**
a) ¿Da lo mismo evaluar $\text{succ}(\text{pred}(M))$ que $\text{pred}(\text{succ}(M))$? ¿Por qué?
b) ¿Es verdad que para todo término $M$ vale $\text{isZero}(\text{succ}(M)) \twoheadrightarrow \text{false}$? Si no lo es, ¿para qué términos vale?
c) ¿Para qué términos $M$ vale $\text{isZero}(\text{pred}(M)) \twoheadrightarrow \text{true}$? (Hay infinitos).

**Explicación**
Los tres ítems miden lo mismo desde ángulos distintos: **$\text{pred}$ no es la inversa de $\text{succ}$**. La resta natural está truncada en $\text{zero}$ ($\text{pred}(\text{zero}) \to \text{zero}$, o directamente un error si se saca esa regla, como en el Ej. 16), y esa asimetría en un solo punto rompe las identidades "obvias". El segundo tema, más sutil, es que en *call-by-value* las reglas de cómputo ($\text{e-predSucc}$, $\text{e-isZeroSucc}$) exigen que el argumento **ya sea un valor**: si $M$ nunca llega a un valor, el término entero se traba y no reduce a nada.

**Resolución paso a paso**
**Observación previa: las congruencias evalúan $M$ primero**

En los tres ítems el término tiene a $M$ enterrado bajo uno o dos constructores unarios, y las únicas reglas aplicables mientras $M$ no sea un valor son las congruencias $\text{e-succ}$, $\text{e-pred}$, $\text{e-isZero}$. Así que toda la evaluación arranca igual:
$$\text{succ}(\text{pred}(M)) \twoheadrightarrow \text{succ}(\text{pred}(V)) \qquad\text{y}\qquad \text{pred}(\text{succ}(M)) \twoheadrightarrow \text{pred}(\text{succ}(V))$$
suponiendo que $M \twoheadrightarrow V$ con $V$ valor. Recién ahí se dispara una regla de cómputo. Conviene entonces razonar **por la forma del valor $V$ al que llega $M$**.

**a) No, no da lo mismo. Coinciden sólo cuando $M$ evalúa a un numeral distinto de cero.**

Con $M \twoheadrightarrow V$:

| $V$ | $\text{pred}(\text{succ}(M)) \twoheadrightarrow$ | $\text{succ}(\text{pred}(M)) \twoheadrightarrow$ | ¿Coinciden? |
|---|---|---|---|
| $\text{zero}$ | $\text{pred}(\text{succ}(\text{zero})) \to \text{zero}$ | $\text{succ}(\text{pred}(\text{zero})) \to \text{succ}(\text{zero}) = \underline{1}$ | ❌ **No** |
| $\text{succ}(V')$ | $\text{pred}(\text{succ}(\text{succ}(V'))) \to \text{succ}(V') = V$ | $\text{succ}(\text{pred}(\text{succ}(V'))) \to \text{succ}(V') = V$ | ✅ Sí |
| $\text{true}$, $\text{false}$, $\lambda x : \tau . P$ | $\text{pred}(\text{succ}(V)) \to V$ (¡reduce!) | $\text{succ}(\text{pred}(V))$ se **traba**: error | ❌ No (términos no tipables) |
| $M$ no llega a valor (p. ej. $M = x$) | se traba en $\text{pred}(\text{succ}(x))$ | se traba en $\text{succ}(\text{pred}(x))$ | ❌ No (formas normales distintas) |

El contraejemplo mínimo es $M = \text{zero}$:
$$\text{pred}(\text{succ}(\text{zero})) \to \text{zero} \qquad\text{vs.}\qquad \text{succ}(\text{pred}(\text{zero})) \to \text{succ}(\text{zero})$$

**El porqué:** $\text{pred} \circ \text{succ}$ es la identidad sobre los naturales, porque $\text{succ}(V)$ siempre expone un predecesor. Pero $\text{succ} \circ \text{pred}$ **pierde información en el cero**: $\text{pred}$ trunca ($0 - 1 = 0$) y después $\text{succ}$ suma uno sobre el valor ya truncado, así que devuelve $1$ en vez de $0$. En términos matemáticos, $\text{succ}$ es inyectiva pero no sobreyectiva ($\text{zero}$ no es sucesor de nadie), y $\text{pred}$ es su inversa a izquierda, no a derecha:
$$\text{pred}(\text{succ}(n)) = n \quad \forall n \qquad\qquad \text{succ}(\text{pred}(n)) = n \iff n \neq 0$$

*Variante sin la regla $\text{e-predZero}$* (el cálculo del Ej. 16): la diferencia es todavía más grosera. $\text{pred}(\text{succ}(\text{zero})) \to \text{zero}$ es un **valor**, mientras que $\text{succ}(\text{pred}(\text{zero}))$ es una forma normal **que no es valor**, es decir un **error**. No sólo dan distinto resultado: uno termina bien y el otro rompe.

*Nota de tipado:* si $M : \text{Nat}$, ambos términos tipan y tienen tipo $\text{Nat}$. O sea que el tipado **no** distingue estas dos expresiones; la diferencia es puramente semántica. Es un buen recordatorio de que la preservación de tipos garantiza que no se rompe, no que dé lo mismo.

**b) No es verdad para todo $M$. Vale exactamente cuando $M$ evalúa a un valor.**

La única regla que produce $\text{false}$ desde ese término es
$$\frac{}{\text{isZero}(\text{succ}(V)) \to \text{false}}\ \text{e-isZeroSucc}$$
y **exige $V$ valor**. Mientras $M$ no sea un valor, lo único que se puede hacer es propagar con $\text{e-isZero} + \text{e-succ}$.

*Contraejemplos:*
- $M = x$: $\text{isZero}(\text{succ}(x))$ es una **forma normal** (ninguna regla aplica: $x$ no reduce y $x$ no es valor) y no es $\text{false}$.
- $M = \text{pred}(\text{true})$: $\text{true}$ es valor pero no es $\text{zero}$ ni $\text{succ}(V)$, así que $\text{pred}(\text{true})$ se traba ⇒ $\text{isZero}(\text{succ}(\text{pred}(\text{true})))$ es un error, no $\text{false}$.
- Si el cálculo se extendiera con recursión ($\text{fix}$), cualquier $M$ divergente daría una reducción infinita.

*Caracterización:*
$$\text{isZero}(\text{succ}(M)) \twoheadrightarrow \text{false} \iff \exists V \text{ valor tal que } M \twoheadrightarrow V$$

($\Leftarrow$) Si $M \twoheadrightarrow V$, entonces $\text{isZero}(\text{succ}(M)) \twoheadrightarrow \text{isZero}(\text{succ}(V)) \to \text{false}$ por $\text{e-isZeroSucc}$.
($\Rightarrow$) Si nunca llega a un valor, la evaluación queda atrapada dentro de $M$ (por determinismo, Ej. 17, no hay otro redex) y jamás se alcanza $\text{false}$. $\blacksquare$

**Corolario práctico:** para todo **programa** $M$ (cerrado y con $M : \text{Nat}$) sí vale, y esto se sigue de progreso + preservación: un programa de tipo $\text{Nat}$ que termina llega a un valor numérico, y en este cálculo (sin $\text{fix}$) todo programa termina. La propiedad falla sólo para términos **abiertos** o **mal tipados**.

*Detalle fino:* con la gramática de valores de la cátedra ($V ::= \lambda x : \tau . M \mid \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V)$, ver Ej. 15), $\text{succ}(\text{true})$ **es** un valor, así que $\text{isZero}(\text{succ}(\text{true})) \to \text{false}$ igual. Por eso la caracterización pide "$M$ llega a un valor" y no "$M$ llega a un numeral": no hace falta que $M$ sea de tipo $\text{Nat}$.

**c) Vale exactamente para los $M$ tales que $M \twoheadrightarrow \text{zero}$ o $M \twoheadrightarrow \text{succ}(\text{zero})$.**

Otra vez por casos sobre el valor $V$ al que llega $M$:

| $V$ | $\text{pred}(V) \to$ | $\text{isZero}(\dots) \to$ | |
|---|---|---|---|
| $\text{zero}$ | $\text{zero}$ (por $\text{e-predZero}$) | $\text{true}$ | ✅ |
| $\text{succ}(\text{zero}) = \underline{1}$ | $\text{zero}$ (por $\text{e-predSucc}$) | $\text{true}$ | ✅ |
| $\text{succ}(\text{succ}(V'))$ | $\text{succ}(V')$ | $\text{false}$ | ❌ |
| $\text{true}$, $\text{false}$, $\lambda x : \tau . P$ | se traba | error | ❌ |
| $M$ no llega a valor | — | se traba | ❌ |

Es decir: **$M$ tiene que evaluar a $0$ o a $1$**. En símbolos,
$$\text{isZero}(\text{pred}(M)) \twoheadrightarrow \text{true} \iff M \twoheadrightarrow \text{zero} \ \text{ o }\ M \twoheadrightarrow \text{succ}(\text{zero})$$

*¿Por qué hay infinitos?* Porque la condición es sobre el **resultado** de $M$, no sobre su forma sintáctica, y hay infinitos términos distintos que evalúan a $\underline{0}$ o a $\underline{1}$. Familias infinitas explícitas:
- $\text{pred}^n(\text{succ}(\text{zero}))$ para todo $n \geq 0$: $\underline{1}, \text{pred}(\underline{1}) = \underline{0}, \text{pred}(\text{pred}(\underline{1})) = \underline{0}, \dots$ ✓ (todas evalúan a $0$ o a $1$)
- $\text{pred}^n(\underline{n})$ para todo $n \geq 1$ ⇒ evalúa a $\text{zero}$ ✓
- $(\lambda x : \text{Nat} . x)^n\ \text{zero}$, o $\text{if } \text{true} \text{ then } \text{zero} \text{ else } N$ para cualquier $N : \text{Nat}$ ✓
- Cualquier $\text{succ}(\text{pred}^n(\text{zero})) \twoheadrightarrow \underline{1}$ ✓

*Variante sin la regla $\text{e-predZero}$:* la primera fila de la tabla se cae ($\text{pred}(\text{zero})$ pasa a ser un error), y la caracterización se reduce a $M \twoheadrightarrow \text{succ}(\text{zero})$. Siguen siendo infinitos.

**Resumen**

| Ítem | Respuesta |
|---|---|
| a | ❌ No dan lo mismo. $\text{pred}(\text{succ}(M)) \twoheadrightarrow V$, pero $\text{succ}(\text{pred}(M)) \twoheadrightarrow \underline{1}$ cuando $V = \text{zero}$. Coinciden sii $M \twoheadrightarrow \text{succ}(V')$ |
| b | ❌ No para todo $M$. Vale sii $M$ evalúa a un valor; en particular, para todo programa $M : \text{Nat}$. Falla con $M$ abierto ($x$) o trabado ($\text{pred}(\text{true})$) |
| c | Sii $M \twoheadrightarrow \text{zero}$ o $M \twoheadrightarrow \text{succ}(\text{zero})$, o sea $M$ evalúa a $0$ o a $1$. Infinitos, p. ej. $\text{pred}^n(\underline{1})$ |

**Chuleta**
> 1. $\text{pred}$ es inversa a izquierda de $\text{succ}$, **no a derecha**: $\text{pred}(\text{succ}(n)) = n$ siempre, pero $\text{succ}(\text{pred}(0)) = 1 \neq 0$.
> 2. Contraejemplo de bolsillo para a): $M = \text{zero}$.
> 3. Todas las reglas de cómputo de $\text{pred}$/$\text{isZero}$ piden **valor** en el argumento ⇒ si $M$ no llega a valor, el término se traba y no reduce a $\text{true}$/$\text{false}$.
> 4. Por eso las propiedades "para todo $M$" casi siempre son falsas y hay que restringirlas a **programas** (cerrados y bien tipados), donde progreso + preservación garantizan que se llega a un valor.
> 5. $\text{isZero}(\text{pred}(M)) \twoheadrightarrow \text{true}$ ⟺ $M$ evalúa a $0$ o a $1$ (el truncamiento de $\text{pred}$ hace que el $0$ también cuente).

**¿Aparece en parciales?** ⚪ No

### Ejercicio 19 — Regla xi
**Enunciado**
Al agregar la siguiente regla para las abstracciones:
$$\frac{M \to M'}{\lambda x : \tau . M \to \lambda x : \tau . M'}\ (\xi)$$
a) Repensar el conjunto de valores para respetar esta modificación; pensar por ejemplo si $(\lambda x : \text{Bool} . (\lambda y : \text{Bool} . y)\ \text{true})$ es o no un valor.
b) ¿Qué reglas deberían modificarse para no perder el determinismo?
c) Utilizando el cálculo modificado y los valores definidos, reducir la siguiente expresión
$$(\lambda x : \text{Nat} \to \text{Nat} . x\ \underline{23})\ (\lambda x : \text{Nat} . \text{pred}(\text{succ}(\text{zero})))$$
¿Qué se puede concluir entonces? ¿Es una buena idea agregar esta regla?

**Explicación**
La regla $\xi$ permite **reducir debajo de una abstracción**: el cuerpo de una función se evalúa aunque la función todavía no haya sido aplicada. Es el paso de *call-by-value* (y de cualquier estrategia débil) a una estrategia **fuerte**, la que se usa cuando lo que interesa es la forma normal $\beta$ completa (asistentes de pruebas, chequeo de igualdad de tipos dependientes) y no "el resultado de correr un programa".

Todo el ejercicio es un efecto dominó: si las abstracciones pasan a reducir, entonces **dejan de ser valores automáticamente**, y como el lema "los valores son formas normales" (Ej. 17) era el motor del determinismo, hay que reconstruir el conjunto de valores y retocar las reglas de cómputo para que las hipótesis vuelvan a ser excluyentes.

**Resolución paso a paso**
**Punto de partida: qué se rompe**

En el cálculo original vale (Ej. 15, Ej. 17):
- $V ::= \lambda x : \tau . M \mid \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V)$ — **toda** abstracción es valor, sin mirar el cuerpo.
- **Lema:** si $V$ es valor entonces $V$ es forma normal. La prueba del Ej. 17 dice textualmente que $\lambda x : \tau . M$ "no aparece del lado izquierdo de ninguna regla (no hay regla $\xi$)".

Al agregar $\xi$ esa frase se vuelve **falsa**: ahora $\lambda x : \tau . M$ **sí** aparece del lado izquierdo de una regla. El lema del Ej. 17 se cae, y con él la prueba de determinismo. Ejemplo mínimo:
$$\lambda x : \text{Bool} . (\lambda y : \text{Bool} . y)\ \text{true} \ \xrightarrow{\ \xi\ }\ \lambda x : \text{Bool} . \text{true}$$
Un "valor" que reduce. Eso es exactamente lo que hay que arreglar en a).

**a) Nuevo conjunto de valores**

La condición que un conjunto de valores debe cumplir es la del lema: **los valores no reducen**. Con $\xi$, una abstracción reduce sii su cuerpo reduce. Por lo tanto:

$$V ::= \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V) \mid \lambda x : \tau . N \quad \text{con } N \text{ forma normal}$$

O sea: **una abstracción es valor sii su cuerpo ya es una forma normal.**

Respondiendo al ejemplo del enunciado: $\lambda x : \text{Bool} . (\lambda y : \text{Bool} . y)\ \text{true}$ **no es un valor**, porque su cuerpo es un redex ($\text{e-appAbs}$). Reduce por $\xi$ a $\lambda x : \text{Bool} . \text{true}$, que **sí** lo es. Comparar con el Ej. 15: los ítems c) y d) de aquel ejercicio ($\lambda x : \text{Bool} . \text{pred}(\underline{2})$ y $\lambda y : \text{Nat} . (\lambda x : \text{Bool} . \text{pred}(\underline{2}))\ \text{true}$) **dejan de ser valores** con $\xi$.

*¿Por qué "forma normal" y no "valor" en el cuerpo?* Es la parte delicada. La definición más simple sería $V ::= \dots \mid \lambda x : \tau . V$ ("cuerpo valor"), pero **falla con términos abiertos**: el cuerpo de una abstracción tiene libre a $x$, y una variable es forma normal pero **no** es valor (Ej. 15.e). Con "cuerpo valor", el término
$$\lambda x : \text{Nat} . \text{pred}(\text{succ}(x))$$
no sería valor y tampoco reduciría ($\text{e-predSucc}$ exige $\text{succ}(V)$ con $V$ valor, y $x$ no lo es): quedaría trabado sin ser valor, o sea un **error**, y se rompería el progreso. Con "cuerpo forma normal" es valor, como corresponde. Formalmente hay que definir por mutua recursión los valores y las formas normales (que incluyen variables y aplicaciones trabadas $x\ N$).

⚠️ Verificar — la cátedra a veces presenta la versión simplificada $V ::= \dots \mid \lambda x : \tau . V$, que alcanza si uno se restringe a **programas** (términos cerrados). El razonamiento de arriba es el general; conviene confirmar cuál se pide.

**b) Reglas a modificar para no perder el determinismo**

El criterio general (el mismo del Ej. 17): **las congruencias piden que un subtérmino reduzca y las computaciones piden que ese mismo subtérmino sea un valor**; si "valor" y "reducible" dejan de ser complementarios en algún lugar, se pierde el determinismo.

El único lugar donde el cálculo original usaba "es una abstracción" como sinónimo de "es un valor" es la $\beta$:

$$\frac{}{(\lambda x : \tau . M)\ V \to M\{x := V\}}\ \text{e-appAbs}$$

Con $\xi$, si $M$ reduce a $M'$ tenemos **dos** reducciones distintas para el mismo término:
$$(\lambda x : \tau . M)\ V \xrightarrow{\ \text{e-appAbs}\ } M\{x := V\} \qquad\text{y}\qquad (\lambda x : \tau . M)\ V \xrightarrow{\ \text{e-app1} + \xi\ } (\lambda x : \tau . M')\ V$$
y en general $M\{x := V\} \neq (\lambda x : \tau . M')\ V$. **Determinismo perdido.**

La corrección es exigir que la abstracción sea un valor **con la nueva definición**:

$$\frac{}{(\lambda x : \tau . N)\ V \to N\{x := V\} }\ \text{e-appAbs}' \qquad (N \text{ forma normal, es decir } \lambda x : \tau . N \text{ es valor})$$

Con eso vuelven a ser excluyentes:

| Reglas para $M_1\ M_2$ | Pide de $M_1$ | Pide de $M_2$ |
|---|---|---|
| $\text{e-app1}$ | reducible (incluye reducir bajo el $\lambda$ vía $\xi$) | — |
| $\text{e-app2}$ | valor | reducible |
| $\text{e-appAbs}'$ | valor **y** abstracción | valor |

Como valor y reducible siguen siendo excluyentes (por construcción de a), el lema del Ej. 17 se recupera y la prueba de determinismo del Ej. 17.a vuelve a cerrar sin más cambios. El orden queda fijado: **primero se normaliza el cuerpo de la función, después el argumento, y recién ahí se hace la $\beta$.**

*Las demás reglas no se tocan*: $\text{e-if}$, $\text{e-succ}$, $\text{e-pred}$, $\text{e-isZero}$, $\text{e-predSucc}$, $\text{e-isZeroSucc}$, etc. ya estaban formuladas en términos de "valor", así que se adaptan solas al nuevo conjunto. Lo único que hay que rehacer son las **pruebas**, porque el conjunto de valores cambió.

*(Alternativa más radical, la de los cálculos fuertes de verdad: quedarse con la $\beta$ original y **aceptar** perder el determinismo, apoyándose en que el cálculo-$\lambda$ es confluente — Church-Rosser — así que la forma normal sigue siendo única aunque el camino no lo sea. Es la respuesta "correcta" teóricamente, pero no es lo que pide el ejercicio, que quiere conservar una semántica operacional determinista.)*

**c) Reducción del término**

$$M_0 = (\lambda x : \text{Nat} \to \text{Nat} . x\ \underline{23})\ (\lambda x : \text{Nat} . \text{pred}(\text{succ}(\text{zero})))$$

*Análisis previo de las dos partes:*
- **Función:** $\lambda x : \text{Nat} \to \text{Nat} . x\ \underline{23}$. Su cuerpo $x\ \underline{23}$ **es forma normal**: $x$ no reduce y no es una abstracción, así que ni $\text{e-app1}$, ni $\text{e-app2}$, ni $\text{e-appAbs}'$ aplican. Entonces la función **es un valor**.
- **Argumento:** $\lambda x : \text{Nat} . \text{pred}(\text{succ}(\text{zero}))$. Su cuerpo $\text{pred}(\text{succ}(\text{zero}))$ **reduce** (por $\text{e-predSucc}$), así que la abstracción **no es un valor** y hay que normalizarla antes de aplicar la $\beta$. Notar que $\underline{23} = \text{succ}^{23}(\text{zero})$ ya es un valor.

*Reducción (con el cálculo corregido de b), o sea determinista):*

1. Como la función ya es valor y el argumento reduce, aplica $\text{e-app2}$, y adentro $\xi$, y adentro $\text{e-predSucc}$:
$$(\lambda x : \text{Nat} \to \text{Nat} . x\ \underline{23})\ (\lambda x : \text{Nat} . \underbrace{\text{pred}(\text{succ}(\text{zero}))}_{\to\ \text{zero}}) \to (\lambda x : \text{Nat} \to \text{Nat} . x\ \underline{23})\ (\lambda x : \text{Nat} . \text{zero})$$

2. Ahora el argumento sí es valor (cuerpo $\text{zero}$, forma normal) y la función es un valor-abstracción: aplica $\text{e-appAbs}'$, sustituyendo $x := \lambda x : \text{Nat} . \text{zero}$ en $x\ \underline{23}$:
$$\to (\lambda x : \text{Nat} . \text{zero})\ \underline{23}$$

3. Otra $\beta$ ($\underline{23}$ es valor, la abstracción también): la $x$ no ocurre en el cuerpo, así que la sustitución no hace nada:
$$\to \text{zero}$$

Resultado: $M_0 \twoheadrightarrow \text{zero}$ en 3 pasos, y $\text{zero}$ es forma normal y valor. El tipo se preservó: $M_0 : \text{Nat}$.

*Contraste con el cálculo original (sin $\xi$):*

1. El argumento ya era valor ⇒ $\text{e-appAbs}$ directo: $\to (\lambda x : \text{Nat} . \text{pred}(\text{succ}(\text{zero})))\ \underline{23}$
2. $\text{e-appAbs}$: $\to \text{pred}(\text{succ}(\text{zero}))$
3. $\text{e-predSucc}$: $\to \text{zero}$

Mismo resultado, misma cantidad de pasos, **distinto orden**: sin $\xi$ el cuerpo se evalúa *después* de aplicar la función; con $\xi$ se evalúa *antes*, sin saber todavía si va a hacer falta.

**¿Qué se puede concluir? ¿Conviene agregar $\xi$?**

Conclusiones del ejemplo y del ejercicio en general:

1. **La confluencia se mantiene** (los dos caminos dan $\text{zero}$), pero el **determinismo** sólo sobrevive si se retoca la $\beta$ como en b). Agregar una regla nunca es gratis: hay que revisar todas las hipótesis "es un valor" del cálculo.
2. **Se hace trabajo especulativo.** El cuerpo de la función argumento se normaliza aunque la función podría no aplicarse nunca (si $x$ no apareciera en $x\ \underline{23}$, ese cómputo sería puro desperdicio) — o podría aplicarse $n$ veces y con $\xi$ el trabajo compartido se hace una sola vez. En este término da lo mismo, pero en general el costo cambia en ambas direcciones.
3. **Se evalúa con variables libres.** Reducir bajo un $\lambda$ obliga a manipular términos abiertos, con todo el problema de captura de variables (Ej. 13/14) y sin poder representar funciones como *closures* compiladas. Ningún lenguaje de programación real hace esto: en Haskell, ML, Scheme o Python el cuerpo de una función no se toca hasta que se la llama.
4. **La noción de "resultado" se enturbia.** Con $\xi$, "ser una función" ya no alcanza para ser un resultado: hay que mirar adentro. Y si el cálculo se extendiera con recursión ($\text{fix}$), un programa que simplemente **devuelve** una función de cuerpo divergente **dejaría de terminar**, cuando en CBV terminaba de inmediato. Ahí la extensión pasa de incómoda a directamente dañina.

**Veredicto:** como semántica de un **lenguaje de programación**, **no es buena idea**: complica el conjunto de valores, obliga a debilitar la $\beta$ para salvar el determinismo, computa cosas que pueden no necesitarse y puede convertir programas terminantes en divergentes, todo sin cambiar el resultado de los programas que sí terminan (el ejemplo c) da $\text{zero}$ en los dos cálculos). Sí es la regla adecuada en otro contexto: cuando lo que se quiere es la **forma normal $\beta$ completa** — comparar funciones por su forma normal, normalizar tipos dependientes, chequear igualdad de pruebas.

**Chuleta**
> 1. $\xi$: $\dfrac{M \to M'}{\lambda x : \tau . M \to \lambda x : \tau . M'}$ — reducir **debajo del $\lambda$**. Convierte la evaluación débil (CBV) en fuerte.
> 2. Consecuencia inmediata: **las abstracciones dejan de ser valores automáticamente**. Nuevo conjunto: $V ::= \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V) \mid \lambda x : \tau . N$ con $N$ forma normal.
> 3. Se cae el lema "valores = formas normales" del Ej. 17 (que se apoyaba justo en que **no** había $\xi$) y con él la prueba de determinismo.
> 4. Para recuperar el determinismo hay que **debilitar la $\beta$**: $(\lambda x : \tau . N)\ V \to N\{x := V\}$ sólo si $\lambda x : \tau . N$ es valor. Si no, $\text{e-appAbs}$ y $\text{e-app1}+\xi$ compiten.
> 5. En c) el resultado es $\text{zero}$ en 3 pasos con y sin $\xi$: cambia el **orden**, no el resultado. Moraleja: $\xi$ agrega costo y complicación sin ganancia para un lenguaje de programación (y con $\text{fix}$ puede romper la terminación).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_reduccion_pasos]]

---

## EXTENSIONES

### Ejercicio 20 — Extension Pares (Productos)
**Enunciado**
Este ejercicio extiende el cálculo-$\lambda$ tipado con *pares*. Las gramáticas de los tipos y los términos se extienden de la siguiente manera:
$\tau ::= \dots \mid \tau \times \tau$
$M ::= \dots \mid \langle M, M \rangle \mid \pi_1(M) \mid \pi_2(M)$
a) Definir reglas de tipado para los nuevos constructores.
b) Exhibir habitantes para:
I. Constructor de pares: $\sigma \to \tau \to (\sigma \times \tau)$
II. Proyecciones: $(\sigma \times \tau) \to \sigma$ y $(\sigma \times \tau) \to \tau$
III. Conmutatividad, Asociatividad, Currificación.
c) ¿Cómo se extiende el conjunto de los valores?
d) Definir reglas de semántica operacional.
e) Propiedades (Determinismo, Preservación, Progreso).

**Explicación**
Extensión básica de productos.

**Resolución paso a paso**
**a) Reglas de tipado**

$$\frac{\Gamma \vdash M : \sigma \qquad \Gamma \vdash N : \tau}{\Gamma \vdash \langle M, N \rangle : \sigma \times \tau}\ \text{t-par} \qquad \frac{\Gamma \vdash M : \sigma \times \tau}{\Gamma \vdash \pi_1(M) : \sigma}\ \text{t-}\pi_1 \qquad \frac{\Gamma \vdash M : \sigma \times \tau}{\Gamma \vdash \pi_2(M) : \tau}\ \text{t-}\pi_2$$

Vía Curry-Howard, $\text{t-par}$ es la introducción de la conjunción ($\wedge i$) y las proyecciones son sus eliminaciones ($\wedge e_1$, $\wedge e_2$).

**b) Habitantes**

**i) Constructor: $\sigma \to \tau \to (\sigma \times \tau)$**
$$\lambda x : \sigma . \lambda y : \tau . \langle x, y \rangle$$
Derivación: $x : \sigma, y : \tau \vdash \langle x, y \rangle : \sigma \times \tau$ por $\text{t-par}$ sobre dos $\text{t-var}$; dos $\text{t-abs}$ cierran.

**ii) Proyecciones: $(\sigma \times \tau) \to \sigma$ y $(\sigma \times \tau) \to \tau$**
$$\lambda p : \sigma \times \tau . \pi_1(p) \qquad\qquad \lambda p : \sigma \times \tau . \pi_2(p)$$

**iii) Conmutatividad: $(\sigma \times \tau) \to (\tau \times \sigma)$**
$$\lambda p : \sigma \times \tau . \langle \pi_2(p), \pi_1(p) \rangle$$

**iv) Asociatividad**

$((\sigma \times \tau) \times \rho) \to (\sigma \times (\tau \times \rho))$:
$$\lambda p : (\sigma \times \tau) \times \rho .\ \big\langle\ \pi_1(\pi_1(p)),\ \langle \pi_2(\pi_1(p)),\ \pi_2(p) \rangle\ \big\rangle$$

$(\sigma \times (\tau \times \rho)) \to ((\sigma \times \tau) \times \rho)$:
$$\lambda p : \sigma \times (\tau \times \rho) .\ \big\langle\ \langle \pi_1(p),\ \pi_1(\pi_2(p)) \rangle,\ \pi_2(\pi_2(p))\ \big\rangle$$

**v) Currificación**

$((\sigma \times \tau) \to \rho) \to (\sigma \to \tau \to \rho)$ (`curry`):
$$\lambda f : (\sigma \times \tau) \to \rho . \lambda x : \sigma . \lambda y : \tau .\ f\ \langle x, y \rangle$$

$(\sigma \to \tau \to \rho) \to ((\sigma \times \tau) \to \rho)$ (`uncurry`):
$$\lambda f : \sigma \to \tau \to \rho . \lambda p : \sigma \times \tau .\ f\ \pi_1(p)\ \pi_2(p)$$

**c) Extensión del conjunto de valores**

$$V ::= \dots \mid \langle V, V \rangle$$

Un par es valor **sólo si ambas componentes son valores**. Si se admitiera $\langle M, N \rangle$ como valor con $M, N$ arbitrarios se rompería la canonicidad (un "valor" podría contener redexes sin evaluar) y $\pi_1$ podría devolver un no-valor.

**d) Semántica operacional**

*Reglas de computación:*
$$\frac{}{\pi_1(\langle V_1, V_2 \rangle) \to V_1}\ \text{e-}\pi_1\text{Par} \qquad \frac{}{\pi_2(\langle V_1, V_2 \rangle) \to V_2}\ \text{e-}\pi_2\text{Par}$$

*Reglas de congruencia (¡no olvidarlas!):*
$$\frac{M \to M'}{\langle M, N \rangle \to \langle M', N \rangle}\ \text{e-par1} \qquad \frac{N \to N'}{\langle V, N \rangle \to \langle V, N' \rangle}\ \text{e-par2}$$
$$\frac{M \to M'}{\pi_1(M) \to \pi_1(M')}\ \text{e-}\pi_1 \qquad \frac{M \to M'}{\pi_2(M) \to \pi_2(M')}\ \text{e-}\pi_2$$

Son **4 congruencias** y **2 computaciones**. La clave del determinismo está en $\text{e-par2}$: exige que la **primera** componente ya sea un valor, fijando el orden de evaluación de izquierda a derecha.

**e) Propiedades**

**Determinismo.** *Si $M \to N_1$ y $M \to N_2$ entonces $N_1 = N_2$.* Por inducción en la derivación de $M \to N_1$, usando el lema auxiliar **"ningún valor reduce"**. Los casos nuevos:
- $M = \langle M_1, M_2 \rangle$: si $M_1$ no es valor, la única regla aplicable es $\text{e-par1}$ (porque $\text{e-par2}$ pide $V$ en la primera posición) y se concluye por HI. Si $M_1$ es valor, $\text{e-par1}$ no aplica (los valores no reducen) y sólo queda $\text{e-par2}$, HI de nuevo.
- $M = \pi_i(M')$: si $M'$ es de la forma $\langle V_1, V_2 \rangle$ es un valor, no reduce, así que $\text{e-}\pi_i$ no aplica y sólo queda $\text{e-}\pi_i\text{Par}$, que es determinista. Si $M'$ no es de esa forma, sólo puede aplicar la congruencia, y se usa la HI. ✓

**Preservación de tipos.** *Si $\Gamma \vdash M : \tau$ y $M \to N$ entonces $\Gamma \vdash N : \tau$.* Por inducción en la derivación de $M \to N$:
- $\pi_1(\langle V_1, V_2 \rangle) \to V_1$: por inversión, $\Gamma \vdash \pi_1(\langle V_1, V_2 \rangle) : \sigma$ implica $\Gamma \vdash \langle V_1, V_2 \rangle : \sigma \times \tau$, y esto a su vez $\Gamma \vdash V_1 : \sigma$. ✓ (ídem $\pi_2$.)
- Congruencias: inversión + HI + reconstruir con la misma regla de tipado. ✓
**Se verifica.**

**Progreso.** *Si $\vdash M : \tau$ entonces $M$ es valor o existe $N$ con $M \to N$.* Hace falta el **lema de formas canónicas** extendido: *si $\vdash V : \sigma \times \tau$ y $V$ es valor, entonces $V = \langle V_1, V_2 \rangle$*. Con eso:
- $M = \langle M_1, M_2 \rangle$: por HI cada $M_i$ es valor o reduce; si ambos son valores, $M$ es valor; si no, aplica $\text{e-par1}$ o $\text{e-par2}$.
- $M = \pi_1(M')$: por HI, $M'$ es valor o reduce. Si reduce, congruencia. Si es valor, por tipado $\vdash M' : \sigma \times \tau$, y por formas canónicas $M' = \langle V_1, V_2 \rangle$ ⇒ aplica $\text{e-}\pi_1\text{Par}$. ✓
**Se verifica.**

**Chuleta**
> 1. Tipado: $\dfrac{M : \sigma \quad N : \tau}{\langle M, N \rangle : \sigma \times \tau}$ y $\dfrac{M : \sigma \times \tau}{\pi_i(M) : \sigma \text{ o } \tau}$.
> 2. Habitantes = manipular proyecciones: conmutar $\lambda p . \langle \pi_2(p), \pi_1(p) \rangle$; asociar anidando $\pi_1(\pi_1(p))$; `curry` $= \lambda f . \lambda x . \lambda y . f \langle x, y \rangle$; `uncurry` $= \lambda f . \lambda p . f\,\pi_1(p)\,\pi_2(p)$.
> 3. Valores: $\langle V, V \rangle$ — **ambas** componentes valores.
> 4. Semántica: 2 de computación ($\pi_i(\langle V_1, V_2 \rangle) \to V_i$) + 4 de congruencia; $\text{e-par2}$ pide valor a izquierda ⇒ orden fijo ⇒ determinismo.
> 5. Preservación ✓ y progreso ✓ (con formas canónicas: valor de tipo $\sigma \times \tau$ es un par de valores).

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]

### Ejercicio 21 — Extension Sumas (Uniones Disjuntas)
**Enunciado**
Extensión con *uniones disjuntas* (co-productos):
$\tau ::= \dots \mid \tau + \tau$
$M ::= \dots \mid \text{left}_\tau(M) \mid \text{right}_\tau(M) \mid \text{case } M \text{ of left}(x) \leadsto M_1 \parallel \text{right}(y) \leadsto M_2$
a) Definir reglas de tipado.
b) Exhibir habitantes (Inyecciones, Análisis de casos, Conmutatividad, Asociatividad, Distributividad, Ley de los exponentes).
c) Valores, d) Semántica, e) Propiedades.

**Explicación**
Extensión de sumas, análogo a `Either` en Haskell.

**Resolución paso a paso**
**Convención de anotaciones.** Escribimos $\text{left}_\tau(M)$ cuando $M : \sigma$ y queremos el tipo $\sigma + \tau$, y $\text{right}_\sigma(M)$ cuando $M : \tau$ y queremos $\sigma + \tau$: **el subíndice anota la componente que no se puede inferir del argumento**. Sin esa anotación se perdería la unicidad de tipos ($\text{left}(M)$ podría tener tipo $\sigma + \tau$ para cualquier $\tau$).

**a) Reglas de tipado**

$$\frac{\Gamma \vdash M : \sigma}{\Gamma \vdash \text{left}_\tau(M) : \sigma + \tau}\ \text{t-left} \qquad \frac{\Gamma \vdash M : \tau}{\Gamma \vdash \text{right}_\sigma(M) : \sigma + \tau}\ \text{t-right}$$

$$\frac{\Gamma \vdash M : \sigma + \tau \qquad \Gamma, x : \sigma \vdash N_1 : \rho \qquad \Gamma, y : \tau \vdash N_2 : \rho}{\Gamma \vdash \text{case } M \text{ of left}(x) \leadsto N_1 \parallel \text{right}(y) \leadsto N_2 : \rho}\ \text{t-case}$$

Puntos críticos de $\text{t-case}$: las variables $x$ e $y$ se **ligan** en sus respectivas ramas (cada una con el tipo de su componente), y ambas ramas deben tener el **mismo** tipo $\rho$, que es el tipo del $\text{case}$. Es exactamente la regla $\vee e$ de deducción natural.

**b) Habitantes**

**i) Inyecciones: $\sigma \to (\sigma + \tau)$ y $\tau \to (\sigma + \tau)$**
$$\lambda x : \sigma . \text{left}_\tau(x) \qquad\qquad \lambda y : \tau . \text{right}_\sigma(y)$$

**ii) Análisis de casos: $(\sigma + \tau) \to (\sigma \to \rho) \to (\tau \to \rho) \to \rho$** (el `either` de Haskell, con los argumentos reordenados)
$$\lambda s : \sigma + \tau . \lambda f : \sigma \to \rho . \lambda g : \tau \to \rho .\ \text{case } s \text{ of left}(x) \leadsto f\,x \parallel \text{right}(y) \leadsto g\,y$$

**iii) Conmutatividad: $(\sigma + \tau) \to (\tau + \sigma)$**
$$\lambda s : \sigma + \tau .\ \text{case } s \text{ of left}(x) \leadsto \text{right}_\tau(x) \parallel \text{right}(y) \leadsto \text{left}_\sigma(y)$$
(Con $x : \sigma$, $\text{right}_\tau(x) : \tau + \sigma$ ✓; con $y : \tau$, $\text{left}_\sigma(y) : \tau + \sigma$ ✓.)

**iv) Asociatividad**

$((\sigma + \tau) + \rho) \to (\sigma + (\tau + \rho))$:
$$\lambda s : (\sigma + \tau) + \rho .\ \text{case } s \text{ of left}(a) \leadsto \big(\text{case } a \text{ of left}(x) \leadsto \text{left}_{\tau + \rho}(x) \parallel \text{right}(y) \leadsto \text{right}_\sigma(\text{left}_\rho(y))\big) \parallel \text{right}(z) \leadsto \text{right}_\sigma(\text{right}_\tau(z))$$

$(\sigma + (\tau + \rho)) \to ((\sigma + \tau) + \rho)$:
$$\lambda s : \sigma + (\tau + \rho) .\ \text{case } s \text{ of left}(x) \leadsto \text{left}_\rho(\text{left}_\tau(x)) \parallel \text{right}(b) \leadsto \big(\text{case } b \text{ of left}(y) \leadsto \text{left}_\rho(\text{right}_\sigma(y)) \parallel \text{right}(z) \leadsto \text{right}_{\sigma + \tau}(z)\big)$$

**v) Distributividad del producto sobre la suma**

$(\sigma \times (\tau + \rho)) \to ((\sigma \times \tau) + (\sigma \times \rho))$:
$$\lambda p : \sigma \times (\tau + \rho) .\ \text{case } \pi_2(p) \text{ of left}(y) \leadsto \text{left}_{\sigma \times \rho}(\langle \pi_1(p), y \rangle) \parallel \text{right}(z) \leadsto \text{right}_{\sigma \times \tau}(\langle \pi_1(p), z \rangle)$$

$((\sigma \times \tau) + (\sigma \times \rho)) \to (\sigma \times (\tau + \rho))$:
$$\lambda s : (\sigma \times \tau) + (\sigma \times \rho) .\ \text{case } s \text{ of left}(p) \leadsto \langle \pi_1(p), \text{left}_\rho(\pi_2(p)) \rangle \parallel \text{right}(q) \leadsto \langle \pi_1(q), \text{right}_\tau(\pi_2(q)) \rangle$$

**vi) Ley de los exponentes** ($\rho^{\sigma + \tau} \leftrightarrow \rho^\sigma \times \rho^\tau$)

$((\sigma + \tau) \to \rho) \to ((\sigma \to \rho) \times (\tau \to \rho))$:
$$\lambda f : (\sigma + \tau) \to \rho .\ \big\langle\ \lambda x : \sigma . f\,(\text{left}_\tau(x)),\ \ \lambda y : \tau . f\,(\text{right}_\sigma(y))\ \big\rangle$$

$((\sigma \to \rho) \times (\tau \to \rho)) \to ((\sigma + \tau) \to \rho)$:
$$\lambda p : (\sigma \to \rho) \times (\tau \to \rho) . \lambda s : \sigma + \tau .\ \text{case } s \text{ of left}(x) \leadsto \pi_1(p)\,x \parallel \text{right}(y) \leadsto \pi_2(p)\,y$$

Este último par de habitantes es la versión computacional de la equivalencia lógica $((\sigma \vee \tau) \Rightarrow \rho) \Leftrightarrow ((\sigma \Rightarrow \rho) \wedge (\tau \Rightarrow \rho))$.

**c) Extensión del conjunto de valores**

$$V ::= \dots \mid \text{left}_\tau(V) \mid \text{right}_\sigma(V)$$

Las inyecciones son valores **sólo si su contenido ya es un valor** (igual que $\text{succ}(V)$).

**d) Semántica operacional**

*Computación:*
$$\frac{}{\text{case left}_\tau(V) \text{ of left}(x) \leadsto N_1 \parallel \text{right}(y) \leadsto N_2 \to N_1\{x := V\}}\ \text{e-caseLeft}$$
$$\frac{}{\text{case right}_\sigma(V) \text{ of left}(x) \leadsto N_1 \parallel \text{right}(y) \leadsto N_2 \to N_2\{y := V\}}\ \text{e-caseRight}$$

*Congruencia (3 reglas):*
$$\frac{M \to M'}{\text{left}_\tau(M) \to \text{left}_\tau(M')} \qquad \frac{M \to M'}{\text{right}_\sigma(M) \to \text{right}_\sigma(M')} \qquad \frac{M \to M'}{\text{case } M \text{ of } \dots \to \text{case } M' \text{ of } \dots}$$

Notar que las **ramas no se evalúan** hasta que se elige una: son cuerpos con variables ligadas, igual que el cuerpo de un $\lambda$.

**¿Progreso?** **Sí.** Formas canónicas: un valor cerrado de tipo $\sigma + \tau$ es necesariamente $\text{left}_\tau(V)$ o $\text{right}_\sigma(V)$. Entonces, si $\vdash \text{case } M \text{ of } \dots : \rho$, por HI $M$ es valor (y entonces aplica $\text{e-caseLeft}$ o $\text{e-caseRight}$) o reduce (y aplica la congruencia). El $\text{case}$ es **exhaustivo**: nunca queda trabado.

**e) Preservación de tipos**

Por inducción en la derivación de $M \to N$. Casos nuevos:

- **$\text{e-caseLeft}$**: supongamos $\Gamma \vdash \text{case left}_\tau(V) \text{ of left}(x) \leadsto N_1 \parallel \text{right}(y) \leadsto N_2 : \rho$. Por inversión de $\text{t-case}$: $\Gamma \vdash \text{left}_\tau(V) : \sigma + \tau$, $\Gamma, x : \sigma \vdash N_1 : \rho$ y $\Gamma, y : \tau \vdash N_2 : \rho$. Por inversión de $\text{t-left}$: $\Gamma \vdash V : \sigma$. Aplicando el **lema de sustitución** (Ej. 12) a $\Gamma, x : \sigma \vdash N_1 : \rho$ y $\Gamma \vdash V : \sigma$:
$$\Gamma \vdash N_1\{x := V\} : \rho \qquad ✓$$
- **$\text{e-caseRight}$**: simétrico, usando $\Gamma \vdash V : \tau$ y $\Gamma, y : \tau \vdash N_2 : \rho$.
- **Congruencias**: inversión, HI sobre la premisa, y se reconstruye con la misma regla de tipado (los tipos de las anotaciones y de las ramas no cambian). ✓

$\blacksquare$

**Chuleta**
> 1. Tipado: $\dfrac{M : \sigma}{\text{left}_\tau(M) : \sigma + \tau}$, $\dfrac{M : \tau}{\text{right}_\sigma(M) : \sigma + \tau}$, y $\text{t-case}$ que **liga $x : \sigma$ en la rama izquierda, $y : \tau$ en la derecha, ambas del mismo tipo $\rho$**.
> 2. Todo habitante que **consume** una suma empieza con un $\text{case}$; todo habitante que la **produce** termina en $\text{left}$/$\text{right}$ (cuidado con la anotación: es la componente que falta).
> 3. Valores: $\text{left}_\tau(V)$, $\text{right}_\sigma(V)$ — contenido ya evaluado.
> 4. Reducción: 2 de computación (elegir rama y **sustituir** la variable ligada) + 3 de congruencia.
> 5. Preservación = inversión + **lema de sustitución**. Progreso ✓ porque el $\text{case}$ es exhaustivo sobre las formas canónicas.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]

### Ejercicio 22 — Extension Listas
**Enunciado**
Extensión con *listas*:
$\tau ::= \dots \mid [\tau]$
$M ::= \dots \mid []_\tau \mid M :: N \mid \text{case } M \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} \mid \text{foldr } M \text{ base } \leadsto N; \text{rec}(h, r) \leadsto O$
a) Árbol sintáctico. b) Reglas de tipado. c) Juicio de tipado. d) Valores. e) Reglas de reducción.

**Explicación**
Implementación de listas con un operador de recursión estructural `foldr` integrado.

**Resolución paso a paso**
**a) Árboles sintácticos de los dos ejemplos**

*Ejemplo 1:* $\text{case } \text{zero} :: \text{succ}(\text{zero}) :: [\,]_\text{Nat} \text{ of } \{[\,] \leadsto \text{false} \mid x :: xs \leadsto \text{isZero}(x)\}$

El $::$ asocia a derecha: $\text{zero} :: (\text{succ}(\text{zero}) :: [\,]_\text{Nat})$.

```
                    case
             /        |        \
           ::       false     isZero    [liga x, xs]
         /   \                   |
      zero    ::                 x
            /   \
         succ   []_Nat
           |
         zero
```

Reduce a $\text{isZero}(\text{zero}) \to \text{true}$, como dice el enunciado.

*Ejemplo 2:* $\text{foldr } 1 :: 2 :: 3 :: (\lambda x : [\text{Nat}] . x)\ [\,]_\text{Nat} \text{ base} \leadsto \text{zero}; \text{rec}(head, rec) \leadsto head + rec$

La lista es $1 :: (2 :: (3 :: ((\lambda x : [\text{Nat}] . x)\ [\,]_\text{Nat})))$; notar que la cola no es literalmente $[\,]_\text{Nat}$ sino una **aplicación** que reduce a ella.

```
                       foldr
              /          |           \
             ::        zero          +        [liga head, rec]
           /   \                    /  \
          1     ::               head   rec
              /   \
             2     ::
                 /   \
                3     @
                    /   \
            λx:[Nat]    []_Nat
                 |
                 x
```

Reduce a $1 + (2 + (3 + \text{zero})) = 6$.

**b) Reglas de tipado**

$$\frac{}{\Gamma \vdash [\,]_\tau : [\tau]}\ \text{t-nil} \qquad\qquad \frac{\Gamma \vdash M : \tau \qquad \Gamma \vdash N : [\tau]}{\Gamma \vdash M :: N : [\tau]}\ \text{t-cons}$$

$$\frac{\Gamma \vdash M : [\sigma] \qquad \Gamma \vdash N : \rho \qquad \Gamma, h : \sigma, t : [\sigma] \vdash O : \rho}{\Gamma \vdash \text{case } M \text{ of } \{[\,] \leadsto N \mid h :: t \leadsto O\} : \rho}\ \text{t-caseL}$$

$$\frac{\Gamma \vdash M : [\sigma] \qquad \Gamma \vdash N : \rho \qquad \Gamma, h : \sigma, r : \rho \vdash O : \rho}{\Gamma \vdash \text{foldr } M \text{ base} \leadsto N; \text{rec}(h, r) \leadsto O : \rho}\ \text{t-foldr}$$

Diferencia clave entre las dos últimas: en el $\text{case}$, $t$ es la **cola** y tiene tipo $[\sigma]$; en el $\text{foldr}$, $r$ es el **resultado de la recursión** y tiene tipo $\rho$ (el tipo del resultado), no $[\sigma]$.

**c) Demostración del juicio de tipado**

$$x : \text{Bool},\ y : [\text{Bool}] \vdash \text{foldr } x :: x :: y \text{ base} \leadsto y; \text{rec}(y, x) \leadsto \text{if } y \text{ then } x \text{ else } [\,]_\text{Bool} : [\text{Bool}]$$

*Paso previo: marcar libres y ligadas.* El $\text{foldr}$ liga $y$ (como cabeza) y $x$ (como resultado recursivo) **sólo dentro de $O$**. Por lo tanto, en $O = \text{if } y \text{ then } x \text{ else } [\,]_\text{Bool}$ los nombres $x$ e $y$ **no** son los del contexto externo: hay *shadowing*. Renombrando para ver claro:
$$\text{foldr } \underbrace{x :: x :: y}_{\text{libres, del contexto}} \text{ base} \leadsto \underbrace{y}_{\text{libre}}; \text{rec}(\underbrace{y}_{\text{liga}}, \underbrace{x}_{\text{liga}}) \leadsto \text{if } \underbrace{y}_{\text{ligada}} \text{ then } \underbrace{x}_{\text{ligada}} \text{ else } [\,]_\text{Bool}$$

Sea $\Gamma = x : \text{Bool},\ y : [\text{Bool}]$. Instanciamos $\text{t-foldr}$ con $\sigma = \text{Bool}$ y $\rho = [\text{Bool}]$; entonces $h = y : \text{Bool}$ y $r = x : [\text{Bool}]$, o sea el contexto de la tercera premisa es $\Gamma' = \Gamma, y : \text{Bool}, x : [\text{Bool}]$ (las nuevas asignaciones **tapan** a las viejas).

*Premisa 1 — la lista:*
$$\dfrac{\dfrac{}{\Gamma \vdash x : \text{Bool}}\ \text{t-var} \qquad \dfrac{\dfrac{}{\Gamma \vdash x : \text{Bool}}\ \text{t-var} \qquad \dfrac{}{\Gamma \vdash y : [\text{Bool}]}\ \text{t-var}}{\Gamma \vdash x :: y : [\text{Bool}]}\ \text{t-cons}}{\Gamma \vdash x :: x :: y : [\text{Bool}]}\ \text{t-cons}$$

*Premisa 2 — el caso base:* $\dfrac{}{\Gamma \vdash y : [\text{Bool}]}\ \text{t-var}$, y $[\text{Bool}] = \rho$ ✓

*Premisa 3 — el paso recursivo,* en $\Gamma' = x : [\text{Bool}],\ y : \text{Bool}$:
$$\dfrac{\dfrac{}{\Gamma' \vdash y : \text{Bool}}\ \text{t-var} \qquad \dfrac{}{\Gamma' \vdash x : [\text{Bool}]}\ \text{t-var} \qquad \dfrac{}{\Gamma' \vdash [\,]_\text{Bool} : [\text{Bool}]}\ \text{t-nil}}{\Gamma' \vdash \text{if } y \text{ then } x \text{ else } [\,]_\text{Bool} : [\text{Bool}]}\ \text{t-if}$$

La guarda es $y : \text{Bool}$ ✓ y ambas ramas tienen tipo $[\text{Bool}] = \rho$ ✓.

Las tres premisas cierran $\text{t-foldr}$ y el juicio es **derivable**, con tipo $[\text{Bool}]$. $\blacksquare$

*(Todo el ejercicio es una trampa de shadowing: si uno se olvida de que $\text{rec}(y, x)$ redefine $x$ e $y$ dentro de $O$, concluye erróneamente que la guarda del $\text{if}$ tiene tipo $[\text{Bool}]$ y que no tipa.)*

**d) Extensión del conjunto de valores**

$$V ::= \dots \mid [\,]_\tau \mid V :: V$$

Una lista es valor si es la vacía o si **cabeza y cola son ambas valores**. Así los valores de tipo $[\tau]$ son exactamente las listas finitas totalmente evaluadas: $V_1 :: V_2 :: \dots :: V_n :: [\,]_\tau$, que es "la forma de las listas que un programa podría devolver".

**e) Reglas de reducción**

*Congruencias (4):*
$$\frac{M \to M'}{M :: N \to M' :: N}\ \text{e-cons1} \qquad \frac{N \to N'}{V :: N \to V :: N'}\ \text{e-cons2}$$
$$\frac{M \to M'}{\text{case } M \text{ of } \{\dots\} \to \text{case } M' \text{ of } \{\dots\}}\ \text{e-caseL} \qquad \frac{M \to M'}{\text{foldr } M \dots \to \text{foldr } M' \dots}\ \text{e-foldr}$$

*Computación del observador:*
$$\frac{}{\text{case } [\,]_\tau \text{ of } \{[\,] \leadsto N \mid h :: t \leadsto O\} \to N}\ \text{e-caseNil}$$
$$\frac{}{\text{case } V_1 :: V_2 \text{ of } \{[\,] \leadsto N \mid h :: t \leadsto O\} \to O\{h := V_1\}\{t := V_2\}}\ \text{e-caseCons}$$

*Computación del `foldr`:*
$$\frac{}{\text{foldr } [\,]_\tau \text{ base} \leadsto N; \text{rec}(h, r) \leadsto O \to N}\ \text{e-foldrNil}$$
$$\frac{}{\text{foldr } V_1 :: V_2 \text{ base} \leadsto N; \text{rec}(h, r) \leadsto O \to O\{h := V_1\}\{r := \text{foldr } V_2 \text{ base} \leadsto N; \text{rec}(h, r) \leadsto O\}}\ \text{e-foldrCons}$$

La regla $\text{e-foldrCons}$ es el corazón de la recursión estructural: sustituye $h$ por la cabeza y $r$ por **la llamada recursiva sobre la cola**, exactamente como el `foldr` de Haskell. Como la recursión siempre baja sobre una sublista estrictamente menor, el cálculo **sigue terminando** (a diferencia de agregar $\text{fix}$).

*Verificación con el ejemplo del enunciado:*
$$\text{foldr } \underline{1} :: \underline{2} :: \underline{3} :: [\,]_\text{Nat} \dots \to \underline{1} + (\text{foldr } \underline{2} :: \underline{3} :: [\,]_\text{Nat} \dots) \to^* \underline{1} + (\underline{2} + (\underline{3} + \text{zero})) \to^* \underline{6}\ ✓$$

**Chuleta**
> 1. Tipado: $[\,]_\tau : [\tau]$; $\dfrac{M : \tau \quad N : [\tau]}{M :: N : [\tau]}$; $\text{case}$ liga $h : \sigma$ y $t : [\sigma]$; $\text{foldr}$ liga $h : \sigma$ y $r : \rho$ (**$r$ es el resultado recursivo, tipo $\rho$, no $[\sigma]$**).
> 2. Ojo al **shadowing**: los nombres en $\text{rec}(h, r)$ tapan a los del contexto dentro de la rama.
> 3. Valores: $[\,]_\tau$ y $V :: V$ (cabeza y cola evaluadas).
> 4. Reducción: 4 congruencias + $\text{case}\,[\,] \to N$, $\text{case}\,V_1 :: V_2 \to O\{h := V_1\}\{t := V_2\}$, $\text{foldr}\,[\,] \to N$, $\text{foldr}\,V_1 :: V_2 \to O\{h := V_1\}\{r := \text{foldr } V_2 \dots\}$.
> 5. $\text{foldr}$ recursa sobre la **cola**, así que la terminación se preserva.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]

### Ejercicio 23 — Map
**Enunciado**
A partir de la extensión del Ejercicio 22 (listas), definir una nueva extensión que incorpore expresiones de la forma $\text{map}(M, N)$, donde $N$ es una lista y $M$ una función que se aplicará a cada uno de los elementos de $N$.
**Importante:** tener en cuenta las anotaciones de tipos al definir las reglas de tipado y semántica.

**Explicación**
Es el ejercicio de extensión más corto de la guía y el que más veces cae en parcial, porque se resuelve con la receta completa en miniatura: **sintaxis → tipado → valores → reglas de reducción (congruencias + cómputo) → verificación de determinismo, preservación y progreso**.

La única trampa —y por eso el enunciado la subraya— son las **anotaciones de tipo**. La lista vacía se escribe $[\,]_\tau$, con el tipo de sus elementos pegado al término. Pero $\text{map}$ **cambia el tipo de los elementos**: si $N : [\sigma]$ y $M : \sigma \to \tau$, el resultado es de tipo $[\tau]$. Al reducir $\text{map}$ sobre la lista vacía hay que producir $[\,]_\tau$… y $\tau$ **no aparece en ningún lado del término** $\text{map}(M, [\,]_\sigma)$: las abstracciones son a la Church, anotan sólo el dominio ($\lambda x : \sigma . P$), nunca el codominio. Sin una anotación extra, la regla de reducción no está bien definida.

**Resolución paso a paso**
**0) El problema de la anotación, en concreto**

$$\text{map}(\lambda x : \text{Nat} . \text{isZero}(x),\ [\,]_\text{Nat}) \to [\,]_{?}$$

Debería reducir a $[\,]_\text{Bool}$, pero para saber que es $\text{Bool}$ hay que **inferir el tipo del cuerpo** de la función, y una regla de semántica operacional no puede tipar: reduce por *pattern matching* sintáctico. Si en cambio pusiéramos $[\,]_\text{Nat}$, se rompería la **preservación de tipos** ($\text{map}$ tenía tipo $[\text{Bool}]$ y el resultado sería $[\text{Nat}]$).

Solución: **anotar el término $\text{map}$ con el tipo de los elementos del resultado.**

**1) Sintaxis**

No hacen falta tipos nuevos (el $[\tau]$ del Ej. 22 alcanza). Sólo un constructor de términos:
$$M, N ::= \dots \mid \text{map}_\tau(M, N)$$
donde $\tau$ es el tipo de los elementos de la lista **resultante**.

⚠️ Verificar — la notación exacta de la anotación varía según el enunciado/cuatrimestre: se ve $\text{map}_\tau(M,N)$, $\text{map}^\tau(M,N)$ y también $\text{map}(M, N)_\tau$. Lo que **no** varía es que la anotación tiene que estar: sin ella la regla de la lista vacía no preserva tipos. Vale la pena escribir esa justificación en el parcial.

**2) Reglas de tipado**

$$\frac{\Gamma \vdash M : \sigma \to \tau \qquad \Gamma \vdash N : [\sigma]}{\Gamma \vdash \text{map}_\tau(M, N) : [\tau]}\ \text{t-map}$$

Puntos a los que mirar:
- La $\tau$ de la anotación **debe coincidir** con el codominio de $M$; eso es lo que hace que el tipado siga siendo *checkeable* sintácticamente y que la anotación no sea arbitraria.
- $\sigma$ queda determinado por la lista y por el dominio de la función, que tienen que ser el mismo tipo.
- El resultado es $[\tau]$, no $[\sigma]$: el error clásico es copiar el tipo de la lista de entrada.

*Ejemplo:* $\vdash \text{map}_\text{Bool}(\lambda x : \text{Nat} . \text{isZero}(x),\ \text{zero} :: \text{succ}(\text{zero}) :: [\,]_\text{Nat}) : [\text{Bool}]$ ✓

**3) Conjunto de valores**

**No se agregan valores nuevos.** $\text{map}_\tau(M, N)$ es un *observador/transformador*: como $\text{pred}$, $\text{case}$ o $\text{foldr}$, nunca es un resultado, siempre reduce. Los valores siguen siendo los del Ej. 22:
$$V ::= \dots \mid [\,]_\tau \mid V :: V$$
y el resultado de un $\text{map}$ es una lista de valores, que ya está cubierta.

**4) Reglas de semántica operacional**

*Congruencias* (fijan el orden de evaluación: primero la función, después la lista — el mismo criterio *call-by-value* de $\text{e-app1}$/$\text{e-app2}$, que es lo que preserva el determinismo):
$$\frac{M \to M'}{\text{map}_\tau(M, N) \to \text{map}_\tau(M', N)}\ \text{e-map1} \qquad\qquad \frac{N \to N'}{\text{map}_\tau(V, N) \to \text{map}_\tau(V, N')}\ \text{e-map2}$$

*Cómputo* (por la forma del valor de la lista, que sólo puede ser $[\,]_\sigma$ o $V_1 :: V_2$):
$$\frac{}{\text{map}_\tau(V, [\,]_\sigma) \to [\,]_\tau}\ \text{e-mapNil}$$
$$\frac{}{\text{map}_\tau(V, V_1 :: V_2) \to (V\ V_1) :: \text{map}_\tau(V, V_2)}\ \text{e-mapCons}$$

Observaciones:
- En $\text{e-mapNil}$ se ve el porqué de la anotación: entra $[\,]_\sigma$ y sale $[\,]_\tau$, **cambiando la anotación**. Es el único lugar donde $\tau$ es imprescindible.
- $\text{e-mapCons}$ **no** evalúa $V\ V_1$ ni la llamada recursiva: sólo construye el término $(V\ V_1) :: \text{map}_\tau(V, V_2)$ y deja que las congruencias de $::$ del Ej. 22 ($\text{e-cons1}$, $\text{e-cons2}$) se encarguen. Es lo correcto en *small-step*: cada regla hace **un** paso.
- Como $\text{e-map2}$ exige $V$ valor y $\text{e-map1}$ exige $M$ reducible, y las dos de cómputo exigen ambos argumentos valores, las cuatro reglas son mutuamente excluyentes por el lema "valores = formas normales" (Ej. 17): **el determinismo se mantiene**.

**5) Verificación con un ejemplo**

$$\text{map}_\text{Bool}(\lambda x : \text{Nat} . \text{isZero}(x),\ \text{zero} :: \underline{1} :: [\,]_\text{Nat})$$
$$\xrightarrow{\text{e-mapCons}} ((\lambda x : \text{Nat} . \text{isZero}(x))\ \text{zero}) :: \text{map}_\text{Bool}(\lambda x : \text{Nat} . \text{isZero}(x),\ \underline{1} :: [\,]_\text{Nat})$$
$$\xrightarrow{\text{e-cons1} + \text{e-appAbs}} \text{isZero}(\text{zero}) :: \text{map}_\text{Bool}(\dots) \xrightarrow{\text{e-cons1} + \text{e-isZeroZero}} \text{true} :: \text{map}_\text{Bool}(\dots)$$
$$\xrightarrow{\text{e-cons2} + \text{e-mapCons}} \text{true} :: (((\lambda x : \text{Nat} . \text{isZero}(x))\ \underline{1}) :: \text{map}_\text{Bool}(\dots, [\,]_\text{Nat}))$$
$$\twoheadrightarrow \text{true} :: (\text{false} :: \text{map}_\text{Bool}(\dots, [\,]_\text{Nat})) \xrightarrow{\text{e-mapNil}} \text{true} :: \text{false} :: [\,]_\text{Bool}\ ✓$$

Resultado: un valor de tipo $[\text{Bool}]$, como predice $\text{t-map}$. Notar cómo la anotación viajó intacta hasta el último paso, que es donde se usa.

**6) Propiedades**

- **Determinismo:** ✓ Los cuatro casos nuevos son excluyentes (ver arriba). El lema del Ej. 17 no se toca porque $\text{map}$ no agrega valores.
- **Preservación de tipos:** ✓ Caso $\text{e-mapNil}$: si $\text{map}_\tau(V, [\,]_\sigma) : [\tau]$ entonces $[\,]_\tau : [\tau]$ por $\text{t-nil}$ (y **acá es donde se necesitaba la anotación**). Caso $\text{e-mapCons}$: por inversión, $V : \sigma \to \tau$, $V_1 : \sigma$ y $V_2 : [\sigma]$; entonces $V\ V_1 : \tau$ por $\text{t-app}$ y $\text{map}_\tau(V, V_2) : [\tau]$ por $\text{t-map}$, así que el cons tipa $[\tau]$ por $\text{t-cons}$ ✓. Las congruencias salen por HI.
- **Progreso:** ✓ Si $\text{map}_\tau(M, N)$ es un programa cerrado bien tipado y no es valor: si $M$ reduce, $\text{e-map1}$; si $M$ es valor, por el lema de formas canónicas $M$ es una abstracción (tipo $\sigma \to \tau$); si $N$ reduce, $\text{e-map2}$; y si $N$ es valor de tipo $[\sigma]$, es $[\,]_\sigma$ o $V_1 :: V_2$, cubiertos por $\text{e-mapNil}$/$\text{e-mapCons}$. **No hay términos trabados.**
- **Terminación:** ✓ La recursión de $\text{e-mapCons}$ baja siempre a la cola, estrictamente más corta.

**7) Alternativa: $\text{map}$ como azúcar sintáctica sobre `foldr`**

Como el Ej. 22 ya trae recursión estructural, $\text{map}$ se puede definir como **macro** en lugar de como extensión primitiva:
$$\text{map}_\tau(M, N) \ \triangleq\ \text{foldr } N \text{ base} \leadsto [\,]_\tau; \text{rec}(h, r) \leadsto (M\ h) :: r$$

Notar que **la anotación sigue haciendo falta**, ahora en el caso base $[\,]_\tau$: el problema no era de $\text{map}$ sino de que el tipo del resultado no es recuperable del término. Dos diferencias respecto de la versión primitiva:
- El término $M$ queda **duplicado** dentro del cuerpo del $\text{foldr}$ (se vuelve a sustituir en cada paso). Si $M$ no es un valor, la macro lo re-evalúa en cada elemento, mientras que la versión primitiva lo evalúa **una sola vez** gracias a $\text{e-map1}$. Semánticamente da igual (el cálculo es puro y determinista), pero el costo cambia.
- El orden de los pasos difiere: el $\text{foldr}$ recorre toda la lista antes de aplicar $M$ en la cabeza.

Si el enunciado dice "definir una extensión" conviene dar las reglas primitivas (secciones 1–4) y mencionar la macro como comentario; si dijera "definir como azúcar sintáctica", alcanza con la ecuación.

**Chuleta**
> 1. Sintaxis: $M ::= \dots \mid \text{map}_\tau(M, N)$, con $\tau$ = tipo de los elementos **del resultado**.
> 2. Tipado: $\dfrac{\Gamma \vdash M : \sigma \to \tau \quad \Gamma \vdash N : [\sigma]}{\Gamma \vdash \text{map}_\tau(M, N) : [\tau]}$. El resultado es $[\tau]$, **no** $[\sigma]$.
> 3. **Valores: ninguno nuevo.** $\text{map}$ siempre reduce; los valores siguen siendo $[\,]_\tau$ y $V :: V$.
> 4. Reducción: 2 congruencias ($\text{e-map1}$ la función, $\text{e-map2}$ la lista con la función ya valor) + $\text{map}_\tau(V, [\,]_\sigma) \to [\,]_\tau$ + $\text{map}_\tau(V, V_1 :: V_2) \to (V\ V_1) :: \text{map}_\tau(V, V_2)$.
> 5. **Por qué la anotación:** $\text{map}$ cambia el tipo de los elementos, y $[\,]$ lleva el tipo pegado. Sin $\tau$ en el término, $\text{e-mapNil}$ no puede producir $[\,]_\tau$ y se rompe la preservación de tipos. Es el punto que buscan corregir.
> 6. No evaluar $V\ V_1$ dentro de $\text{e-mapCons}$: *small-step* = un paso por regla; el resto lo hacen $\text{e-cons1}$/$\text{e-cons2}$.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]

### Ejercicio 24 — Listas por comprensión
**Enunciado**
A partir de la extensión del Ejercicio 22 (listas), agregar términos para representar **listas por comprensión**, con un selector y una guarda, de la forma $[\,M \mid x \leftarrow S, P\,]$, donde $x$ es el nombre de una variable que puede aparecer libre en los términos $M$ y $P$. La semántica es análoga a la de Haskell: para cada valor de la lista representada por el término $S$, se sustituye $x$ en $P$ y, de resultar verdadero, se agrega $M$ con $x$ sustituido al resultado. Definir las **reglas de tipado**, el **conjunto de valores** y las **reglas de semántica** para esta extensión.

**Explicación**
Es el `[ f x | x <- xs, p x ]` de Haskell metido dentro del cálculo. La receta es la misma del Ej. 23 (sintaxis → tipado → valores → reducción), pero con dos ingredientes nuevos que son los que se corrigen:

1. **$[\,M \mid x \leftarrow S, P\,]$ es un ligador.** La variable $x$ **liga** en $M$ y en $P$, pero **no** en $S$ (igual que en Haskell: la lista de la que se extrae no puede referirse a la variable que se está extrayendo). Eso se refleja en el contexto de las premisas de tipado: $S$ se tipa en $\Gamma$, y $M$ y $P$ en $\Gamma, x : \sigma$.
2. **Vuelve el problema de la anotación del Ej. 23.** El término reduce a $[\,]_\tau$ cuando $S$ se agota, y $\tau$ es el tipo de $M$, que **no** se puede leer del término sin tipar. Igual que con $\text{map}$, hay que **anotar**: escribimos $[\,M \mid x \leftarrow S, P\,]_\tau$.

**Resolución paso a paso**
**1) Sintaxis**

No hacen falta tipos nuevos: el $[\tau]$ del Ej. 22 alcanza. Sólo un constructor de términos, ligador de $x$:
$$M, N, S, P ::= \dots \mid [\,M \mid x \leftarrow S, P\,]_\tau$$
donde $\tau$ es el tipo de los elementos **del resultado** (es decir, el tipo de $M$).

*Variables libres:* $\text{fv}([\,M \mid x \leftarrow S, P\,]_\tau) = \text{fv}(S) \cup ((\text{fv}(M) \cup \text{fv}(P)) \setminus \{x\})$.

⚠️ Verificar — el enunciado de la guía escribe $[M \mid x \leftarrow S, P]$ **sin** anotación de tipo. Acá se la agregamos porque, tal cual está, la regla del caso base no está bien definida (ver punto 4) y se rompe preservación. En el parcial conviene escribir la versión anotada **y justificar por qué**: es exactamente el punto que el Ej. 23 quería enseñar. La alternativa aceptada es no anotar y definir el término directamente como macro sobre $\text{foldr}$ (punto 7), donde la anotación se esconde en el $[\,]_\tau$ del caso base — o sea que tampoco desaparece.

**2) Reglas de tipado**

$$\frac{\Gamma \vdash S : [\sigma] \qquad \Gamma, x : \sigma \vdash P : \text{Bool} \qquad \Gamma, x : \sigma \vdash M : \tau}{\Gamma \vdash [\,M \mid x \leftarrow S, P\,]_\tau : [\tau]}\ \text{t-comp}$$

Lo que se corrige de esta regla:
- $S$ se tipa en $\Gamma$ **pelado**: $x$ no está a la vista ahí.
- $M$ y $P$ se tipan en $\Gamma, x : \sigma$, con $\sigma$ = tipo de los **elementos** de $S$ (no $[\sigma]$: el error clásico es darle a $x$ el tipo de la lista).
- La guarda $P$ tiene tipo $\text{Bool}$, obligatorio.
- El resultado es $[\tau]$ con $\tau$ = tipo de $M$, que **en general no es $[\sigma]$**: la comprensión, como $\text{map}$, cambia el tipo de los elementos.
- $\Gamma, x : \sigma$ **tapa** cualquier $x$ previo del contexto (*shadowing*), igual que en el $\text{foldr}$ del Ej. 22.

*Ejemplo:* $\vdash [\,\text{isZero}(x) \mid x \leftarrow \text{zero} :: \underline{1} :: [\,]_\text{Nat},\ \text{isZero}(x)\,]_\text{Bool} : [\text{Bool}]$, con $\sigma = \text{Nat}$ y $\tau = \text{Bool}$ ✓

**3) Conjunto de valores**

**No se agregan valores nuevos.** La comprensión es un *transformador*, como $\text{map}$, $\text{case}$ o $\text{foldr}$: nunca es un resultado, siempre reduce. Los valores siguen siendo los del Ej. 22:
$$V ::= \dots \mid [\,]_\tau \mid V :: V$$

**4) Reglas de semántica operacional**

*Congruencia (1 sola):* únicamente se evalúa $S$. A $M$ y $P$ **no** se los toca: tienen $x$ libre, o sea que son términos abiertos, y reducir debajo de un ligador es justamente lo que el cálculo *call-by-value* no hace (Ej. 19).
$$\frac{S \to S'}{[\,M \mid x \leftarrow S, P\,]_\tau \to [\,M \mid x \leftarrow S', P\,]_\tau}\ \text{e-comp}$$

*Cómputo* (por la forma del valor de $S$, que sólo puede ser $[\,]_\sigma$ o $V_1 :: V_2$):
$$\frac{}{[\,M \mid x \leftarrow [\,]_\sigma, P\,]_\tau \to [\,]_\tau}\ \text{e-compNil}$$
$$\frac{}{[\,M \mid x \leftarrow V_1 :: V_2, P\,]_\tau \to \text{if } P\{x := V_1\} \text{ then } M\{x := V_1\} :: [\,M \mid x \leftarrow V_2, P\,]_\tau \text{ else } [\,M \mid x \leftarrow V_2, P\,]_\tau}\ \text{e-compCons}$$

Observaciones:
- En $\text{e-compNil}$ se ve por qué hacía falta la anotación: entra $[\,]_\sigma$ y sale $[\,]_\tau$. Es el único lugar donde $\tau$ es imprescindible.
- $\text{e-compCons}$ **no** evalúa ni la guarda ni el elemento: sólo **arma** el $\text{if}$ y deja que $\text{e-if}$ (congruencia del $\text{if}$ del cálculo base) y $\text{e-ifTrue}$/$\text{e-ifFalse}$ hagan el trabajo. Un paso por regla, como corresponde en *small-step*.
- La sustitución $\{x := V_1\}$ es la sustitución **con evitación de captura** del Ej. 13: si $V_1$ tuviera variables libres que $M$ o $P$ ligan, hay que $\alpha$-renombrar. (Como $V_1$ sale de reducir un programa cerrado, en la práctica es cerrado, pero la regla debe estar bien definida en general.)
- Usar el $\text{if}$ del cálculo base en el lado derecho es legítimo y es lo más limpio: **no** hace falta partir $\text{e-compCons}$ en dos reglas según el valor de la guarda, porque la guarda todavía no está evaluada.

*Variante equivalente (dos reglas, guarda ya evaluada).* Si se prefiere no apoyarse en el $\text{if}$, hay que evaluar la guarda desde adentro del término, lo cual exige agregar una forma intermedia. Es más largo y no aporta: la versión con $\text{if}$ es la esperada.

**5) Verificación con un ejemplo**

$$[\,\text{succ}(x) \mid x \leftarrow \text{zero} :: \underline{1} :: [\,]_\text{Nat},\ \text{isZero}(x)\,]_\text{Nat}$$

$$\xrightarrow{\text{e-compCons}} \text{if } \text{isZero}(\text{zero}) \text{ then } \text{succ}(\text{zero}) :: [\,\text{succ}(x) \mid x \leftarrow \underline{1} :: [\,]_\text{Nat}, \text{isZero}(x)\,]_\text{Nat} \text{ else } [\,\text{succ}(x) \mid x \leftarrow \underline{1} :: [\,]_\text{Nat}, \text{isZero}(x)\,]_\text{Nat}$$

$$\xrightarrow{\text{e-if} + \text{e-isZeroZero}} \text{if } \text{true} \text{ then } \dots \xrightarrow{\text{e-ifTrue}} \underline{1} :: [\,\text{succ}(x) \mid x \leftarrow \underline{1} :: [\,]_\text{Nat}, \text{isZero}(x)\,]_\text{Nat}$$

$$\xrightarrow{\text{e-cons2} + \text{e-compCons}} \underline{1} :: (\text{if } \text{isZero}(\underline{1}) \text{ then } \underline{2} :: [\,\dots \mid x \leftarrow [\,]_\text{Nat}, \dots\,]_\text{Nat} \text{ else } [\,\dots \mid x \leftarrow [\,]_\text{Nat}, \dots\,]_\text{Nat})$$

$$\twoheadrightarrow \underline{1} :: (\text{if } \text{false} \text{ then } \dots) \xrightarrow{\text{e-ifFalse}} \underline{1} :: [\,\text{succ}(x) \mid x \leftarrow [\,]_\text{Nat}, \text{isZero}(x)\,]_\text{Nat} \xrightarrow{\text{e-compNil}} \underline{1} :: [\,]_\text{Nat}\ ✓$$

Resultado: la lista de los sucesores de los ceros, es decir $[\underline{1}]$. En Haskell, `[ succ x | x <- [0,1], x == 0 ] == [1]` ✓. Y el tipo es $[\text{Nat}]$, como predice $\text{t-comp}$.

**6) Propiedades**

- **Determinismo:** ✓ Los tres casos nuevos son mutuamente excluyentes: $\text{e-comp}$ pide que $S$ reduzca, y las dos de cómputo piden que $S$ sea valor (y de formas distintas). Vale por el lema "valores = formas normales" del Ej. 17, que no se toca porque la comprensión **no agrega valores**.
- **Preservación:** ✓ $\text{e-compNil}$: si $[\,M \mid x \leftarrow [\,]_\sigma, P\,]_\tau : [\tau]$, entonces $[\,]_\tau : [\tau]$ por $\text{t-nil}$ (acá se usa la anotación). $\text{e-compCons}$: por inversión $V_1 : \sigma$, $V_2 : [\sigma]$, $\Gamma, x : \sigma \vdash P : \text{Bool}$ y $\Gamma, x : \sigma \vdash M : \tau$; por el **lema de sustitución** (Ej. 12) $P\{x := V_1\} : \text{Bool}$ y $M\{x := V_1\} : \tau$; entonces la rama *then* tipa $[\tau]$ por $\text{t-cons}$ + $\text{t-comp}$, la rama *else* tipa $[\tau]$ por $\text{t-comp}$, y el $\text{if}$ tipa $[\tau]$ por $\text{t-if}$ ✓. La congruencia sale por HI.
- **Progreso:** ✓ Si $[\,M \mid x \leftarrow S, P\,]_\tau$ es un programa cerrado bien tipado y no es valor (nunca lo es): si $S$ reduce, $\text{e-comp}$; si $S$ es valor de tipo $[\sigma]$, por **formas canónicas** es $[\,]_\sigma$ o $V_1 :: V_2$, cubiertos por las dos reglas de cómputo. **No hay términos trabados.**
- **Terminación:** ✓ Cada paso de $\text{e-compCons}$ deja una comprensión sobre la **cola**, estrictamente más corta; la lista es finita por construcción (Ej. 22).

**7) Alternativa: la comprensión como macro sobre `foldr`**

Como el Ej. 22 ya trae recursión estructural, la comprensión se puede definir como **azúcar sintáctica**, sin agregar ni una regla:
$$[\,M \mid x \leftarrow S, P\,]_\tau \ \triangleq\ \text{foldr } S \text{ base} \leadsto [\,]_\tau; \text{rec}(x, r) \leadsto \text{if } P \text{ then } M :: r \text{ else } r$$
con $r$ una variable **fresca** ($r \notin \text{fv}(M) \cup \text{fv}(P)$; si no, hay que renombrar).

Encaja perfecto porque el $\text{foldr}$ ya liga la cabeza, y si la llamamos $x$ queda ligada exactamente donde el enunciado pide: en $M$ y en $P$. Notar que **la anotación no desaparece**, sólo se muda al caso base $[\,]_\tau$: el problema nunca fue de la comprensión, sino de que el tipo del resultado no es recuperable del término.

Si el enunciado dice "definir las reglas de tipado, valores y semántica" (como acá) hay que dar la **extensión primitiva** (puntos 1–4) y mencionar la macro como comentario final.

**Chuleta**
> 1. Sintaxis: $M ::= \dots \mid [\,M \mid x \leftarrow S, P\,]_\tau$. **Es ligador:** $x$ liga en $M$ y $P$, **no** en $S$.
> 2. Tipado: $\dfrac{\Gamma \vdash S : [\sigma] \quad \Gamma, x : \sigma \vdash P : \text{Bool} \quad \Gamma, x : \sigma \vdash M : \tau}{\Gamma \vdash [\,M \mid x \leftarrow S, P\,]_\tau : [\tau]}$. La guarda es $\text{Bool}$; $x : \sigma$ (elemento), no $[\sigma]$; el resultado es $[\tau]$, **no** $[\sigma]$.
> 3. **Valores: ninguno nuevo.** Siempre reduce.
> 4. Reducción: **1 sola congruencia** (sobre $S$; a $M$ y $P$ no se los toca porque son abiertos) + $[\,M \mid x \leftarrow [\,]_\sigma, P\,]_\tau \to [\,]_\tau$ + $[\,M \mid x \leftarrow V_1 :: V_2, P\,]_\tau \to \text{if } P\{x := V_1\} \text{ then } M\{x := V_1\} :: [\dots V_2 \dots] \text{ else } [\dots V_2 \dots]$.
> 5. **Por qué la anotación $\tau$:** mismo argumento que $\text{map}$ (Ej. 23). Sin ella, $\text{e-compNil}$ no sabe qué $[\,]$ producir y se rompe preservación.
> 6. Macro equivalente: $\text{foldr } S \text{ base} \leadsto [\,]_\tau; \text{rec}(x, r) \leadsto \text{if } P \text{ then } M :: r \text{ else } r$, con $r$ fresca.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]

### Ejercicio 25 — Macros booleanas
**Enunciado**
*(Conectivos booleanos.)* Definir como **macros (azúcar sintáctica)** los términos $\text{Not}$, $\text{And}$, $\text{Or}$, $\text{Xor}$, que simulen desde la reducción los conectivos clásicos usuales; por ejemplo, $\text{And }M\ N \twoheadrightarrow \text{true} \iff M \twoheadrightarrow \text{true}$ y $N \twoheadrightarrow \text{true}$.

Notar que definir una macro **no** es lo mismo que hacer una extensión. Por ejemplo, definir el término $I_\sigma \stackrel{\text{def}}{=} \lambda x : \sigma . x$, que es la función identidad del tipo $\sigma$, es distinto de extender la sintaxis del lenguaje con términos de la forma $I(M)$, lo cual además requeriría agregar nuevas reglas de tipado y de evaluación.

**Explicación**
El ejercicio es corto pero es **el** ejercicio conceptual sobre la diferencia macro vs. extensión, y esa distinción es lo que se corrige (aparece como aclaración en varios enunciados de parcial, incluido el Ej. 27).

Una **macro** es una **abreviatura de notación**: $\text{And} \triangleq \dots$ significa que, donde se escribe $\text{And}$, hay que leer el término del lado derecho. La macro se *expande* antes de mirar el término, y lo que queda es un término del cálculo original.

Consecuencia central, y la respuesta que hay que escribir:

> **Una macro NO agrega tipos, NI términos, NI valores, NI reglas de tipado, NI reglas de reducción.** Por lo tanto **no hay nada que demostrar de nuevo**: determinismo, preservación, progreso y terminación se heredan gratis, porque el término expandido ya es un término del cálculo base y esas propiedades valen para todos sus términos.

Una **extensión**, en cambio (Ej. 20–24, 27), agrega constructores a la gramática, y con ellos: reglas de tipado nuevas, valores nuevos (o la aclaración de que no hay), reglas de reducción nuevas, y casos nuevos en las inducciones de todas las propiedades.

El cálculo base ya trae $\text{Bool}$, $\text{true}$, $\text{false}$ y $\text{if } M \text{ then } N \text{ else } O$. Con eso solo alcanza: los cuatro conectivos son *tablas de verdad escritas con `if`*.

**Resolución paso a paso**
**1) Las definiciones**

$$\text{Not} \ \triangleq\ \lambda x : \text{Bool} . \text{ if } x \text{ then false else true}$$
$$\text{And} \ \triangleq\ \lambda x : \text{Bool} . \lambda y : \text{Bool} . \text{ if } x \text{ then } y \text{ else false}$$
$$\text{Or} \ \triangleq\ \lambda x : \text{Bool} . \lambda y : \text{Bool} . \text{ if } x \text{ then true else } y$$
$$\text{Xor} \ \triangleq\ \lambda x : \text{Bool} . \lambda y : \text{Bool} . \text{ if } x \text{ then } (\text{Not } y) \text{ else } y$$

Detalles que valen puntos:
- $\text{And}$ **no** se escribe $\text{if } x \text{ then (if } y \text{ then true else false) else false}$. Eso funciona, pero $\text{if } y \text{ then true else false}$ es $y$: sobra. Lo mismo con $\text{Or}$.
- $\text{Xor}$ expandido es $\lambda x . \lambda y . \text{if } x \text{ then } ((\lambda z : \text{Bool} . \text{if } z \text{ then false else true})\ y) \text{ else } y$ — la macro $\text{Not}$ dentro de otra macro se expande igual, no hay nada especial. Equivalentemente, sin usar $\text{Not}$: $\lambda x . \lambda y . \text{if } x \text{ then (if } y \text{ then false else true) else } y$.
- También vale $\text{Xor} \triangleq \lambda x . \lambda y . \text{Or }(\text{And } x\ (\text{Not } y))\ (\text{And }(\text{Not } x)\ y)$, pero es innecesariamente largo y en *call-by-value* evalúa las cuatro subexpresiones siempre.

**2) Tipado: no hace falta ninguna regla nueva**

Los cuatro términos tipan con las reglas que ya están ($\text{t-abs}$, $\text{t-var}$, $\text{t-if}$, $\text{t-true}$, $\text{t-false}$):

$$\vdash \text{Not} : \text{Bool} \to \text{Bool} \qquad \vdash \text{And},\ \text{Or},\ \text{Xor} : \text{Bool} \to \text{Bool} \to \text{Bool}$$

*Derivación de $\text{Not}$ (las otras son análogas):*
$$\dfrac{\dfrac{\dfrac{}{x : \text{Bool} \vdash x : \text{Bool}}\ \text{t-var} \quad \dfrac{}{x : \text{Bool} \vdash \text{false} : \text{Bool}}\ \text{t-false} \quad \dfrac{}{x : \text{Bool} \vdash \text{true} : \text{Bool}}\ \text{t-true}}{x : \text{Bool} \vdash \text{if } x \text{ then false else true} : \text{Bool}}\ \text{t-if}}{\vdash \lambda x : \text{Bool} . \text{if } x \text{ then false else true} : \text{Bool} \to \text{Bool}}\ \text{t-abs}$$

Notar que $\to$ asocia a **derecha**: $\text{Bool} \to \text{Bool} \to \text{Bool}$ es $\text{Bool} \to (\text{Bool} \to \text{Bool})$, o sea que $\text{And}$ está **currificada** y $\text{And }M$ (aplicación parcial) es un término perfectamente válido de tipo $\text{Bool} \to \text{Bool}$.

**3) Verificación contra las tablas de verdad**

Alcanza con reducir los cuatro casos. Recordar que la aplicación asocia a izquierda: $\text{And }M\ N = (\text{And }M)\ N$, y que en *call-by-value* la $\beta$ ($\text{e-appAbs}$) sólo dispara cuando el argumento **ya es un valor**; $\text{true}$ y $\text{false}$ lo son.

*$\text{Not}$:*
$$\text{Not true} \to \text{if true then false else true} \to \text{false} \qquad \text{Not false} \to \text{if false then false else true} \to \text{true}\ ✓$$

*$\text{And}$* (dos $\beta$ y después el $\text{if}$):
$$\text{And true true} \twoheadrightarrow \text{if true then true else false} \to \text{true} \qquad \text{And true false} \twoheadrightarrow \text{if true then false else false} \to \text{false}$$
$$\text{And false true} \twoheadrightarrow \text{if false then true else false} \to \text{false} \qquad \text{And false false} \twoheadrightarrow \text{false}\ ✓$$

*$\text{Or}$:*
$$\text{Or true } y \twoheadrightarrow \text{if true then true else } y \to \text{true} \qquad \text{Or false } V \twoheadrightarrow \text{if false then true else } V \to V\ ✓$$

*$\text{Xor}$:*
$$\text{Xor true true} \twoheadrightarrow \text{Not true} \twoheadrightarrow \text{false} \qquad \text{Xor true false} \twoheadrightarrow \text{Not false} \twoheadrightarrow \text{true}$$
$$\text{Xor false true} \twoheadrightarrow \text{true} \qquad \text{Xor false false} \twoheadrightarrow \text{false}\ ✓$$

**4) La demostración que pide el enunciado**

$$\text{And } M\ N \twoheadrightarrow \text{true} \iff M \twoheadrightarrow \text{true} \ \text{ y } \ N \twoheadrightarrow \text{true} \qquad (\text{con } \vdash M : \text{Bool},\ \vdash N : \text{Bool})$$

*Preliminar.* $M$ y $N$ son **programas** de tipo $\text{Bool}$: cerrados y bien tipados. Por **terminación** + **progreso** + **preservación** (Ej. 16–18), cada uno reduce a un valor de tipo $\text{Bool}$, y por **formas canónicas** ese valor es $\text{true}$ o $\text{false}$. Por **determinismo** (Ej. 17), ese valor es **único**: no puede pasar que $M \twoheadrightarrow \text{true}$ y $M \twoheadrightarrow \text{false}$ a la vez. Sin estos tres lemas la equivalencia no se puede cerrar; conviene citarlos explícitamente.

*($\Leftarrow$)* Supongamos $M \twoheadrightarrow \text{true}$ y $N \twoheadrightarrow \text{true}$. En *call-by-value*:
$$(\text{And } M)\ N \twoheadrightarrow (\text{And true})\ N \to (\lambda y : \text{Bool} . \text{if true then } y \text{ else false})\ N \twoheadrightarrow (\lambda y . \dots)\ \text{true} \to \text{if true then true else false} \to \text{true}$$
(los pasos sobre $M$ se levantan con $\text{e-app2}$ dentro de $\text{And }M$, y los pasos sobre $N$ con $\text{e-app2}$ de la aplicación externa, que ya tiene una abstracción a la izquierda). ✓

*($\Rightarrow$)* Por contrarrecíproco. Si $M \twoheadrightarrow \text{false}$, entonces $\text{And } M\ N \twoheadrightarrow \text{if false then } V_N \text{ else false} \to \text{false}$, y como $\text{false}$ es forma normal y la reducción es determinista, $\text{And } M\ N \not\twoheadrightarrow \text{true}$. Si $M \twoheadrightarrow \text{true}$ pero $N \twoheadrightarrow \text{false}$, entonces $\text{And } M\ N \twoheadrightarrow \text{if true then false else false} \to \text{false}$, ídem. Como no hay más casos (el preliminar), queda probado. $\blacksquare$

Las de $\text{Or}$ ($\text{Or } M\ N \twoheadrightarrow \text{true} \iff M \twoheadrightarrow \text{true}$ **o** $N \twoheadrightarrow \text{true}$) y $\text{Xor}$ ($\twoheadrightarrow \text{true} \iff$ exactamente uno de los dos $\twoheadrightarrow \text{true}$) son idénticas cambiando la tabla.

**5) Perezoso vs. estricto: la discusión que suelen pedir**

Con estas definiciones, $\text{And}$ es una **función**, y el cálculo es *call-by-value*: por $\text{e-app2}$, **ambos argumentos se evalúan completamente antes de la $\beta$**, incluso cuando el primero ya es $\text{false}$ y la respuesta está decidida. No hay cortocircuito. El `&&` de Haskell, en cambio, es perezoso en el segundo argumento: `False && undefined == False`.

- **En el cálculo base esto no se nota**: sin $\text{fix}$ todo programa bien tipado **termina** (Ej. 18), así que evaluar de más sólo cuesta pasos, nunca cambia el resultado. La equivalencia del punto 4 vale igual.
- **En cuanto haya divergencia sí se nota.** Con $\text{fix}$, o con el $\bot_\text{Bool}$ del Ej. 26, $\text{And false } \bot_\text{Bool}$ **no termina**, mientras que la lectura clásica del conectivo daría $\text{false}$.

*Si se quiere cortocircuito*, hay que definir la macro **sobre los términos** en lugar de como función, o sea como abreviatura de una construcción con dos argumentos sintácticos:
$$\text{And}(M, N) \ \triangleq\ \text{if } M \text{ then } N \text{ else false} \qquad \text{Or}(M, N) \ \triangleq\ \text{if } M \text{ then true else } N$$
Acá $N$ queda **debajo del $\text{if}$**, y el $\text{if}$ sólo evalúa la rama elegida ($\text{e-ifTrue}$/$\text{e-ifFalse}$): $\text{And}(\text{false}, \bot_\text{Bool}) \to \text{false}$ ✓. Sigue siendo una macro (cero reglas nuevas), pero **ya no es un término de primera clase**: no se puede pasar $\text{And}$ como argumento ni aplicarla parcialmente, porque sólo existe *aplicada a dos términos*. Ese es el *trade-off*, y decirlo es lo que distingue una respuesta completa.

$\text{Xor}$ **no puede** cortocircuitar en ningún caso: su resultado depende siempre de los dos argumentos.

**6) Qué NO hay que hacer (el error que corrige el enunciado)**

- ❌ Escribir reglas de tipado $\dfrac{\Gamma \vdash M : \text{Bool}}{\Gamma \vdash \text{Not}(M) : \text{Bool}}$ y reglas de reducción $\text{Not}(\text{true}) \to \text{false}$. Eso es una **extensión**, no una macro, y obliga a rehacer determinismo, preservación y progreso.
- ❌ Agregar $\text{Not}$, $\text{And}$… al conjunto de valores. No son valores nuevos; $\text{Not}$ *ya* es un valor porque es una abstracción, y lo es por $V ::= \lambda x : \tau . M$, que ya estaba.
- ❌ Decir "hay que probar preservación para $\text{And}$". No: $\text{And}$ es un término del cálculo base, y la preservación ya vale para todos los términos del cálculo base.

**Chuleta**
> 1. $\text{Not} \triangleq \lambda x : \text{Bool} . \text{if } x \text{ then false else true}$.
> 2. $\text{And} \triangleq \lambda x . \lambda y . \text{if } x \text{ then } y \text{ else false}$; $\text{Or} \triangleq \lambda x . \lambda y . \text{if } x \text{ then true else } y$; $\text{Xor} \triangleq \lambda x . \lambda y . \text{if } x \text{ then Not } y \text{ else } y$.
> 3. Tipos: $\text{Not} : \text{Bool} \to \text{Bool}$; los otros tres $: \text{Bool} \to \text{Bool} \to \text{Bool}$ (currificados).
> 4. **Macro ≠ extensión.** Una macro es notación: **cero** tipos, términos, valores, reglas de tipado o de reducción nuevos ⇒ determinismo, preservación, progreso y terminación **se heredan, no se demuestran**.
> 5. La equivalencia $\text{And } M\ N \twoheadrightarrow \text{true} \iff M, N \twoheadrightarrow \text{true}$ se prueba por casos usando **terminación + progreso + formas canónicas** (todo programa $: \text{Bool}$ llega a $\text{true}$ o $\text{false}$) y **determinismo** (llega a uno solo).
> 6. Como funciones son **estrictas** (CBV evalúa los dos argumentos): sin cortocircuito. Se nota sólo si hay divergencia ($\text{fix}$, $\bot$). Para cortocircuitar: macro sintáctica $\text{And}(M, N) \triangleq \text{if } M \text{ then } N \text{ else false}$, que deja $N$ bajo el $\text{if}$ — pero deja de ser un término de primera clase.

**¿Aparece en parciales?** ⚪ No

### Ejercicio 26 — Funciones de listas
**Enunciado**
Definir las siguientes funciones en **Cálculo Lambda con Listas** (visto en el Ejercicio 22). Pueden definirse como **macros** o como **extensiones** al cálculo.

*Nota:* en este ejercicio usamos la notación $M : \sigma$ para decir que la expresión $M$ a definir debe tener tipo $\sigma$ **en cualquier contexto**.

a) $\text{head}_\sigma : [\sigma] \to \sigma$ y $\text{tail}_\sigma : [\sigma] \to [\sigma]$ (asumir que $\bot_\sigma \stackrel{\text{def}}{=} \text{fix }\lambda x : \sigma . x$).
b) $\text{iterate}_\sigma : (\sigma \to \sigma) \to \sigma \to [\sigma]$ que dadas $f$ y $x$ genera la lista **infinita** $x :: f\ x :: f(f\ x) :: f(f(f\ x)) :: \dots$
c) $\text{zip}_{\rho,\sigma} : [\rho] \to [\sigma] \to [\rho \times \sigma]$ que se comporta como la función homónima de Haskell.
d) $\text{take}_\sigma : \text{Nat} \to ([\sigma] \to [\sigma])$ que se comporta como la función homónima de Haskell.

**Explicación**
Es el ejercicio de "programar en cálculo-$\lambda$": traducir cinco funciones de la *Prelude* de Haskell a términos del cálculo con listas. Cuatro cosas que hay que tener presentes antes de empezar:

1. **Elegir macros, no extensiones.** El enunciado deja las dos puertas abiertas, pero todas se pueden escribir como macros y por eso conviene: una macro es notación pura, así que **no agrega tipos, ni valores, ni reglas de tipado, ni reglas de reducción**, y por lo tanto determinismo, preservación y progreso se heredan gratis (ver Ej. 25). Si en cambio se hicieran como extensiones habría que dar, por cada función, su regla de tipado, sus congruencias, sus reglas de cómputo, y agregar los casos correspondientes en las tres inducciones. Es más trabajo y más superficie de error.
2. **"En cualquier contexto"** significa: los términos que damos son **cerrados**, con lo cual $\vdash M : \sigma$ y, por **debilitamiento** (Ej. 11), $\Gamma \vdash M : \sigma$ para todo $\Gamma$. No hace falta demostrarlo caso por caso, basta con nombrar el lema.
3. **$\bot_\sigma$ es el "error" del cálculo.** El cálculo tipado no tiene excepciones: $\text{head}$ de la lista vacía tiene que devolver *algo* de tipo $\sigma$, y no hay ningún habitante canónico de un $\sigma$ arbitrario. La salida es $\bot_\sigma = \text{fix }(\lambda x : \sigma . x)$, que **tipa** con tipo $\sigma$ pero **diverge**: es el análogo de `head [] = ⊥` en Haskell.
$$\text{fix}(\lambda x : \sigma . x) \to x\{x := \text{fix}(\lambda x : \sigma . x)\} = \text{fix}(\lambda x : \sigma . x) \to \dots$$
4. **Hay recursión disponible en dos sabores** y elegir bien es la mitad del ejercicio:
   - el $\text{foldr}$ del Ej. 22 — **recursión estructural**, siempre termina;
   - $\text{fix}$ — **recursión general**, más flexible pero puede divergir.

   Regla práctica: si la recursión baja sobre la lista, usar $\text{foldr}$; si genera lista (como $\text{iterate}$), hace falta $\text{fix}$.

Para c) se necesita además la extensión de **pares** del Ej. 20 (el tipo $\rho \times \sigma$ y el constructor $\langle \cdot, \cdot \rangle$); no es algo que definamos acá, es una dependencia del enunciado.

**Resolución paso a paso**
**0) Recordatorio: $\text{fix}$**

$$\frac{\Gamma \vdash M : \tau \to \tau}{\Gamma \vdash \text{fix } M : \tau}\ \text{t-fix} \qquad\qquad \frac{}{\text{fix}(\lambda x : \tau . M) \to M\{x := \text{fix}(\lambda x : \tau . M)\}}\ \text{e-fix} \qquad\qquad \frac{M \to M'}{\text{fix } M \to \text{fix } M'}\ \text{e-fix1}$$

El enunciado lo habilita al dar $\bot_\sigma$ con $\text{fix}$.

**a) `head` y `tail`**

$$\text{head}_\sigma \ \triangleq\ \lambda l : [\sigma] . \text{case } l \text{ of } \{[\,] \leadsto \bot_\sigma \mid h :: t \leadsto h\}$$
$$\text{tail}_\sigma \ \triangleq\ \lambda l : [\sigma] . \text{case } l \text{ of } \{[\,] \leadsto \bot_{[\sigma]} \mid h :: t \leadsto t\}$$

*Tipado.* Por $\text{t-caseL}$ con $\rho = \sigma$: la rama $[\,]$ da $\bot_\sigma : \sigma$ (por $\text{t-fix}$, ya que $\lambda x : \sigma . x : \sigma \to \sigma$) y la rama $h :: t$ da $h : \sigma$ en $\Gamma, h : \sigma, t : [\sigma]$. Ambas $\sigma$ ✓, y con $\text{t-abs}$:
$$\vdash \text{head}_\sigma : [\sigma] \to \sigma \qquad\qquad \vdash \text{tail}_\sigma : [\sigma] \to [\sigma]$$
Para $\text{tail}$ es igual con $\rho = [\sigma]$; ojo que ahí el $\bot$ es $\bot_{[\sigma]} = \text{fix}(\lambda x : [\sigma] . x)$, **no** $\bot_\sigma$: la anotación acompaña al tipo de la rama.

*Comportamiento.* $\text{head}_\sigma\ (V_1 :: V_2) \to \text{case } V_1 :: V_2 \text{ of } \{\dots\} \to h\{h := V_1\}\{t := V_2\} = V_1$ ✓, y $\text{head}_\sigma\ [\,]_\sigma \twoheadrightarrow \bot_\sigma$, que diverge ✓.

**Punto fino:** el $\text{case}$ **no** evalúa las ramas, sólo la elegida ($\text{e-caseNil}$/$\text{e-caseCons}$ sustituyen y descartan la otra). Por eso $\text{head}$ de una lista no vacía **termina** aunque la rama muerta contenga $\bot_\sigma$. Si se hubiera escrito, por ejemplo, $(\lambda a : \sigma . \lambda b : \sigma . \dots)\ \bot_\sigma\ h$, en *call-by-value* divergiría siempre.

**b) `iterate`**

$$\text{iterate}_\sigma \ \triangleq\ \text{fix }\big(\lambda it : (\sigma \to \sigma) \to \sigma \to [\sigma] . \ \lambda f : \sigma \to \sigma . \ \lambda x : \sigma . \ x :: it\ f\ (f\ x)\big)$$

*Tipado.* El argumento de $\text{fix}$ tiene tipo $\tau \to \tau$ con $\tau = (\sigma \to \sigma) \to \sigma \to [\sigma]$: dentro, $x : \sigma$, $it\ f\ (f\ x) : [\sigma]$ y el cons tipa $[\sigma]$ por $\text{t-cons}$ ✓. Por $\text{t-fix}$:
$$\vdash \text{iterate}_\sigma : (\sigma \to \sigma) \to \sigma \to [\sigma]$$

*Desplegado.* $\text{iterate}_\sigma\ V_f\ V_x \twoheadrightarrow V_x :: \text{iterate}_\sigma\ V_f\ (V_f\ V_x) \twoheadrightarrow V_x :: (V_f\ V_x) :: \text{iterate}_\sigma\ V_f\ (V_f\ (V_f\ V_x)) \twoheadrightarrow \dots$ — exactamente la lista pedida.

**Acá hay que decir algo que el enunciado no dice, y es lo que separa una respuesta buena de una completa:** con la semántica *call-by-value* de la guía, $\text{iterate}$ **nunca llega a un valor**.

Razón: en el Ej. 22 los valores son $[\,]_\tau$ y $V :: V$ — con **cabeza y cola ambas valores**. Una lista infinita no puede ser un valor. Y la congruencia $\text{e-cons2}$ obliga a evaluar la cola apenas la cabeza es valor, así que $V_x :: \text{iterate}_\sigma\ V_f\ (V_f\ V_x)$ dispara el siguiente desplegado, y el siguiente, indefinidamente. **La reducción no termina**: es una divergencia *productiva* (cada vuelta agrega un elemento) pero divergencia al fin.

El término es igualmente **el correcto**: es el único que se puede escribir, tipa, y bajo una estrategia **perezosa** (*call-by-name* / *call-by-need*, la de Haskell) produce la lista infinita elemento a elemento, que es lo que permite escribir `take 3 (iterate f x)`. La diferencia no está en la definición sino en la **estrategia de evaluación**.

⚠️ Verificar — cómo se espera que se responda este punto varía: algunos cuatrimestres piden sólo el término (y basta con lo de arriba), otros piden explícitamente discutir por qué en CBV no termina. Conviene escribir el término **y** el párrafo de estrategia: el término solo puede leerse como que no se vio el problema.

**c) `zip`**

*Versión con $\text{foldr}$ (sin $\text{fix}$, termina siempre).* El truco es que el $\text{foldr}$ recorre la primera lista y **devuelve una función** que espera la segunda; el tipo del acumulador es $\rho_{\text{fold}} = [\sigma] \to [\rho \times \sigma]$:

$$\text{zip}_{\rho,\sigma} \ \triangleq\ \lambda l : [\rho] . \ \text{foldr } l \text{ base} \leadsto (\lambda m : [\sigma] . [\,]_{\rho \times \sigma});\ \text{rec}(h, r) \leadsto \lambda m : [\sigma] . \text{case } m \text{ of } \{[\,] \leadsto [\,]_{\rho \times \sigma} \mid h' :: t' \leadsto \langle h, h'\rangle :: r\ t'\}$$

*Versión con $\text{fix}$ (más directa de leer):*
$$\text{zip}_{\rho,\sigma} \ \triangleq\ \text{fix }\big(\lambda z : [\rho] \to [\sigma] \to [\rho \times \sigma] . \lambda l : [\rho] . \lambda m : [\sigma] . \text{case } l \text{ of } \{[\,] \leadsto [\,]_{\rho \times \sigma} \mid h :: t \leadsto \text{case } m \text{ of } \{[\,] \leadsto [\,]_{\rho \times \sigma} \mid h' :: t' \leadsto \langle h, h'\rangle :: z\ t\ t'\}\}\big)$$

*Tipado:* $\vdash \text{zip}_{\rho,\sigma} : [\rho] \to [\sigma] \to [\rho \times \sigma]$. En la versión con $\text{foldr}$, $\text{t-foldr}$ se instancia con $\sigma_{\text{elem}} = \rho$ y $\rho_{\text{fold}} = [\sigma] \to [\rho \times \sigma]$; en la versión con $\text{fix}$, $\text{t-fix}$ con $\tau = [\rho] \to [\sigma] \to [\rho \times \sigma]$.

Detalles:
- **Los dos `case` anidados son necesarios**: `zip` corta con la lista **más corta**, así que hay que mirar las dos. Las dos ramas vacías devuelven $[\,]_{\rho \times \sigma}$ (nunca $[\,]_\rho$ ni $[\,]_\sigma$ — la anotación es la del **resultado**).
- El elemento se arma con el constructor de pares del Ej. 20: $\langle h, h'\rangle : \rho \times \sigma$.
- La versión con $\text{foldr}$ **termina siempre** (recursión estructural sobre $l$); la de $\text{fix}$ también termina para listas finitas, pero eso hay que argumentarlo, no viene gratis.

*Ejemplo:* $\text{zip}_{\text{Nat},\text{Bool}}\ (\underline{1} :: \underline{2} :: [\,]_\text{Nat})\ (\text{true} :: [\,]_\text{Bool}) \twoheadrightarrow \langle \underline{1}, \text{true}\rangle :: [\,]_{\text{Nat} \times \text{Bool}}$ ✓ (corta con la más corta).

**d) `take`**

*Versión con $\text{foldr}$ (sin $\text{fix}$).* Mismo truco que en c): el acumulador es una función, ahora $\rho_{\text{fold}} = \text{Nat} \to [\sigma]$:

$$\text{take}_\sigma \ \triangleq\ \lambda n : \text{Nat} . \lambda l : [\sigma] . \big(\text{foldr } l \text{ base} \leadsto (\lambda m : \text{Nat} . [\,]_\sigma);\ \text{rec}(h, r) \leadsto \lambda m : \text{Nat} . \text{if } \text{isZero}(m) \text{ then } [\,]_\sigma \text{ else } h :: r\ (\text{pred}(m))\big)\ n$$

*Versión con $\text{fix}$:*
$$\text{take}_\sigma \ \triangleq\ \text{fix }\big(\lambda tk : \text{Nat} \to [\sigma] \to [\sigma] . \lambda n : \text{Nat} . \lambda l : [\sigma] . \text{if } \text{isZero}(n) \text{ then } [\,]_\sigma \text{ else } \text{case } l \text{ of } \{[\,] \leadsto [\,]_\sigma \mid h :: t \leadsto h :: tk\ (\text{pred}(n))\ t\}\big)$$

*Tipado:* $\vdash \text{take}_\sigma : \text{Nat} \to [\sigma] \to [\sigma]$, y como $\to$ asocia a **derecha**, eso **es** $\text{Nat} \to ([\sigma] \to [\sigma])$, el tipo que pide el enunciado ✓. Los paréntesis del enunciado son sólo un recordatorio de que $\text{take }n$ (aplicación parcial) ya es una función de listas en listas.

Detalles:
- Hay **dos** condiciones de corte y ninguna se puede omitir: $n = 0$ y lista vacía. `take 5 [1,2]` tiene que dar `[1,2]`, no colgarse.
- Se chequea **primero** $\text{isZero}(n)$ y después la lista: así $\text{take}_\sigma\ \text{zero}\ l \twoheadrightarrow [\,]_\sigma$ sin mirar $l$.
- Con $\text{pred}$ del cálculo base y $\text{pred}(\text{zero}) = \text{zero}$ (Ej. 18), no hay riesgo de "restar de más".

*Ejemplo:* $\text{take}_\text{Nat}\ \underline{2}\ (\underline{7} :: \underline{8} :: \underline{9} :: [\,]_\text{Nat}) \twoheadrightarrow \underline{7} :: \underline{8} :: [\,]_\text{Nat}$ ✓

**Nota sobre `take` + `iterate`.** En Haskell la gracia de `take 3 (iterate f x)` es que la pereza corta la lista infinita. Acá **no funciona en CBV**: por la congruencia del $\text{foldr}$ (o por $\text{e-app2}$ en la versión con $\text{fix}$), el argumento $l$ debe reducirse a un **valor** antes de que $\text{take}$ haga nada, y $\text{iterate}$ nunca llega a valor (punto b). Cada función por separado es correcta; la combinación necesita evaluación perezosa. Vale la pena escribirlo: es la observación que cierra el ejercicio.

**Cierre: qué se agregó al cálculo**

**Nada.** Las cinco son **macros**: abreviaturas de términos escritos con lo que ya había ($\lambda$, aplicación, $\text{if}$, $\text{isZero}$, $\text{pred}$, $\text{case}$, $\text{foldr}$, $::$, $[\,]_\tau$, $\langle\cdot,\cdot\rangle$, $\text{fix}$).

- Tipos nuevos: **ninguno**.
- Términos/valores nuevos: **ninguno** (cada macro *es* un $\lambda$-término, y como abstracción ya es valor por la gramática vieja).
- Reglas de tipado nuevas: **ninguna** — sólo hay que **exhibir el juicio** $\vdash \text{f} : \tau$, que se deriva con las reglas existentes.
- Reglas de reducción nuevas: **ninguna**.
- Propiedades: determinismo, preservación y progreso **se heredan**; no hay que rehacer ninguna inducción. La **terminación** es lo único que cambia, y no por las macros sino por $\text{fix}$: $\bot$ e $\text{iterate}$ divergen a propósito.

**Chuleta**
> 1. $\text{head}_\sigma \triangleq \lambda l : [\sigma] . \text{case } l \text{ of } \{[\,] \leadsto \bot_\sigma \mid h :: t \leadsto h\}$; $\text{tail}_\sigma$ ídem con $\bot_{[\sigma]}$ y $t$. El $\text{case}$ **no evalúa la rama muerta**, por eso el $\bot$ no molesta.
> 2. $\bot_\sigma = \text{fix}(\lambda x : \sigma . x)$: tipa $\sigma$, diverge. Es el "error" del cálculo tipado.
> 3. $\text{iterate}_\sigma \triangleq \text{fix}(\lambda it . \lambda f . \lambda x . x :: it\ f\ (f\ x))$. **En CBV no termina**: las listas infinitas no son valores ($V ::= [\,] \mid V :: V$) y $\text{e-cons2}$ fuerza la cola. Correcto sólo bajo evaluación perezosa.
> 4. **Truco clave para $\text{zip}$ y $\text{take}$ sin $\text{fix}$:** el $\text{foldr}$ recorre **una** lista y devuelve una **función** que espera el otro argumento ($\rho_{\text{fold}} = [\sigma] \to [\rho \times \sigma]$ y $\text{Nat} \to [\sigma]$ respectivamente). Recursión estructural ⇒ termina.
> 5. $\text{zip}$: **dos** $\text{case}$ anidados (corta con la más corta); las ramas vacías devuelven $[\,]_{\rho \times \sigma}$, con la anotación **del resultado**. Necesita pares (Ej. 20).
> 6. $\text{take}$: **dos** cortes ($\text{isZero}(n)$ primero, lista vacía después). $\text{Nat} \to ([\sigma] \to [\sigma])$ es lo mismo que $\text{Nat} \to [\sigma] \to [\sigma]$ ($\to$ asocia a derecha).
> 7. Son **macros**: cero reglas de tipado y cero reglas de reducción nuevas; sólo hay que exhibir el juicio de tipado. Determinismo/preservación/progreso se heredan.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_semantica_adt]]

### Ejercicio 27 — Extension Deques (Colas bidireccionales)
**Enunciado**
Extender con *colas bidireccionales* (`deque`):
$\tau ::= \dots \mid \text{Cola}_\tau$
$M ::= \dots \mid \langle \rangle_\tau \mid M \bullet M \mid \text{próximo}(M) \mid \text{desencolar}(M) \mid \text{case } M \text{ of } \langle \rangle \leadsto M_2; c \bullet x \leadsto M_3$
1. Reglas de tipado. 2. Valores y reducción. 3. Ejemplo de reducción. 4. Macro $\text{último}_\tau$.

**Explicación**
Extensión avanzada que suele aparecer en parciales recientes (ej: 2024, 2025).

**Resolución paso a paso**
La sutileza de este ejercicio: la cola se **construye por atrás** ($M \bullet N$ agrega $N$ al final) pero $\text{próximo}$ y $\text{desencolar}$ operan sobre el **frente**. Por eso, para saber a qué reduce $\text{próximo}(V)$ hay que **mirar más de un nivel** del término.

**1. Reglas de tipado**

$$\frac{}{\Gamma \vdash \langle\rangle_\tau : \text{Cola}_\tau}\ \text{t-colaVacia} \qquad\qquad \frac{\Gamma \vdash M : \text{Cola}_\tau \qquad \Gamma \vdash N : \tau}{\Gamma \vdash M \bullet N : \text{Cola}_\tau}\ \text{t-encolar}$$

$$\frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{próximo}(M) : \tau}\ \text{t-próximo} \qquad\qquad \frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{desencolar}(M) : \text{Cola}_\tau}\ \text{t-desencolar}$$

$$\frac{\Gamma \vdash M_1 : \text{Cola}_\sigma \qquad \Gamma \vdash M_2 : \rho \qquad \Gamma, c : \text{Cola}_\sigma, x : \sigma \vdash M_3 : \rho}{\Gamma \vdash \text{case } M_1 \text{ of } \langle\rangle \leadsto M_2;\ c \bullet x \leadsto M_3 : \rho}\ \text{t-caseCola}$$

En $\text{t-caseCola}$, $c$ se liga a la cola sin el último elemento (tipo $\text{Cola}_\sigma$) y $x$ al último elemento encolado (tipo $\sigma$); ambas ramas deben tener el mismo tipo $\rho$.

**2. Valores y reglas de reducción**

*Valores:*
$$V ::= \dots \mid \langle\rangle_\tau \mid V \bullet V$$
Una cola es valor si es la vacía o si tanto la cola de adentro como el elemento agregado ya son valores. Los valores de tipo $\text{Cola}_\tau$ tienen entonces la forma canónica
$$\langle\rangle_\tau \bullet V_1 \bullet V_2 \bullet \dots \bullet V_n$$
donde $V_1$ es el **primero encolado** (el frente) y $V_n$ el **último**.

*Computación del `case` (observa por atrás — directo, porque coincide con la estructura del valor):*
$$\frac{}{\text{case } \langle\rangle_\tau \text{ of } \langle\rangle \leadsto M_2;\ c \bullet x \leadsto M_3 \to M_2}\ \text{e-caseColaVacia}$$
$$\frac{}{\text{case } V_1 \bullet V_2 \text{ of } \langle\rangle \leadsto M_2;\ c \bullet x \leadsto M_3 \to M_3\{c := V_1\}\{x := V_2\}}\ \text{e-caseColaEnc}$$

*Computación de `próximo` (observa por adelante — hay que mirar dos niveles):*
$$\frac{}{\text{próximo}(\langle\rangle_\tau \bullet V) \to V}\ \text{e-próximoUno} \qquad \frac{}{\text{próximo}((V_1 \bullet V_2) \bullet V_3) \to \text{próximo}(V_1 \bullet V_2)}\ \text{e-próximoMas}$$

Es decir: si la cola tiene **un solo** elemento, ese es el próximo; si tiene dos o más, el último encolado ($V_3$) se descarta y se sigue buscando hacia adentro. Ahí está la "pista" del enunciado: el patrón de la segunda regla necesita inspeccionar $\langle\rangle_\tau \bullet \cdot$ vs. $(\cdot \bullet \cdot) \bullet \cdot$, o sea dos niveles.

*Computación de `desencolar`:*
$$\frac{}{\text{desencolar}(\langle\rangle_\tau \bullet V) \to \langle\rangle_\tau}\ \text{e-descolarUno} \qquad \frac{}{\text{desencolar}((V_1 \bullet V_2) \bullet V_3) \to \text{desencolar}(V_1 \bullet V_2) \bullet V_3}\ \text{e-descolarMas}$$

La segunda regla **reconstruye** la cola: saca el frente de la parte interna y vuelve a encolar $V_3$ al final.

*Congruencias:* son **5**:
$$\frac{M \to M'}{M \bullet N \to M' \bullet N} \quad \frac{N \to N'}{V \bullet N \to V \bullet N'} \quad \frac{M \to M'}{\text{próximo}(M) \to \text{próximo}(M')} \quad \frac{M \to M'}{\text{desencolar}(M) \to \text{desencolar}(M')} \quad \frac{M \to M'}{\text{case } M \text{ of } \dots \to \text{case } M' \text{ of } \dots}$$

*Sobre las propiedades:* el determinismo se mantiene (las reglas de $\text{próximo}$/$\text{desencolar}$ discriminan por patrones **disjuntos**, y $\bullet$ evalúa de izquierda a derecha). En cambio **no vale progreso**: $\text{próximo}(\langle\rangle_\tau)$ y $\text{desencolar}(\langle\rangle_\tau)$ tipan pero son formas normales que no son valores — términos de error, exactamente como $\text{pred}(\text{zero})$ del Ej. 16. Para recuperar progreso habría que hacer que $\text{próximo}$ devuelva una suma / opcional, o agregar reglas que reduzcan a un término de error explícito.

**3. Reducción paso a paso**

$$\text{case } \langle\rangle_\text{Nat} \bullet \underline{1} \bullet \underline{0} \text{ of } \langle\rangle \leadsto \text{próximo}(\langle\rangle_\text{Bool});\ c \bullet x \leadsto \text{isZero}(x)$$

Primero parentizar: $\bullet$ asocia a **izquierda**, así que el término observado es $\big((\langle\rangle_\text{Nat} \bullet \underline{1}) \bullet \underline{0}\big)$, con $\underline{1} = \text{succ}(\text{zero})$ y $\underline{0} = \text{zero}$.

*Chequeo previo de tipado:* $\langle\rangle_\text{Nat} \bullet \underline{1} \bullet \underline{0} : \text{Cola}_\text{Nat}$; la rama vacía $\text{próximo}(\langle\rangle_\text{Bool}) : \text{Bool}$ y la rama $c \bullet x$ da $\text{isZero}(x) : \text{Bool}$ con $x : \text{Nat}$ ✓. Ambas ramas $\rho = \text{Bool}$, el término tipa.

*Paso 1.* El término observado ya es un **valor** de la forma $V_1 \bullet V_2$ con $V_1 = \langle\rangle_\text{Nat} \bullet \underline{1}$ y $V_2 = \underline{0}$ (no hace falta ninguna congruencia). Aplica $\text{e-caseColaEnc}$:
$$\to \text{isZero}(x)\{c := \langle\rangle_\text{Nat} \bullet \underline{1}\}\{x := \text{zero}\} = \text{isZero}(\text{zero})$$

*Paso 2.* Por $\text{e-isZeroZero}$:
$$\to \text{true}$$

**Resultado: $\text{true}$** (un valor, en dos pasos).

Observación importante: la rama $\langle\rangle$ contenía $\text{próximo}(\langle\rangle_\text{Bool})$, que es un término **trabado**. Como el $\text{case}$ nunca la evalúa (las ramas no se reducen hasta elegir una), el programa termina bien. Si la cola hubiera sido vacía, el programa se habría trabado — evidencia concreta de que falla el progreso.

**4. Macro $\text{último}_\tau$**

Devuelve el último elemento encolado; el $\text{case}$ da acceso directo a él:

$$\text{último}_\tau \stackrel{def}{=} \lambda q : \text{Cola}_\tau .\ \text{case } q \text{ of } \langle\rangle \leadsto \text{próximo}(\langle\rangle_\tau);\ c \bullet x \leadsto x$$

- Rama $c \bullet x$: devuelve $x$, que es exactamente el último encolado. ✓
- Rama $\langle\rangle$: la cola está vacía y no hay último elemento. Se necesita **algún** término de tipo $\tau$; usamos $\text{próximo}(\langle\rangle_\tau)$, que tipa como $\tau$ pero es una **forma normal que no es valor** (un término de error). El enunciado permite exactamente esto ("puede colgarse o llegar a una forma normal bien tipada que no sea un valor").
- Alternativa igualmente válida si se dispone de $\text{fix}$: $\bot_\tau = \text{fix}\ (\lambda z : \tau . z)$, que directamente diverge.

*Juicio de tipado:*
$$\vdash \text{último}_\tau : \text{Cola}_\tau \to \tau$$

Se justifica con $\text{t-abs}$ sobre $\text{t-caseCola}$ instanciada con $\sigma = \tau$ y $\rho = \tau$: la primera premisa es $q : \text{Cola}_\tau \vdash q : \text{Cola}_\tau$ ($\text{t-var}$), la segunda es $q : \text{Cola}_\tau \vdash \text{próximo}(\langle\rangle_\tau) : \tau$ ($\text{t-próximo}$ sobre $\text{t-colaVacia}$), y la tercera es $q : \text{Cola}_\tau, c : \text{Cola}_\tau, x : \tau \vdash x : \tau$ ($\text{t-var}$).

**Chuleta**
> 1. Tipado: $\langle\rangle_\tau : \text{Cola}_\tau$; $\dfrac{M : \text{Cola}_\tau \quad N : \tau}{M \bullet N : \text{Cola}_\tau}$; $\text{próximo} : \text{Cola}_\tau \to \tau$; $\text{desencolar} : \text{Cola}_\tau \to \text{Cola}_\tau$; el $\text{case}$ liga $c : \text{Cola}_\sigma$ y $x : \sigma$ y ambas ramas dan $\rho$.
> 2. Valores: $\langle\rangle_\tau$ y $V \bullet V$ ⇒ forma canónica $\langle\rangle_\tau \bullet V_1 \bullet \dots \bullet V_n$ (el frente es $V_1$, el más profundo a izquierda).
> 3. La cola se construye por atrás y $\text{próximo}$ mira adelante ⇒ **dos niveles**: $\text{próximo}(\langle\rangle \bullet V) \to V$ y $\text{próximo}((V_1 \bullet V_2) \bullet V_3) \to \text{próximo}(V_1 \bullet V_2)$; ídem $\text{desencolar}$, pero re-encolando $V_3$.
> 4. El $\text{case}$ va directo: $\text{case } V_1 \bullet V_2 \to M_3\{c := V_1\}\{x := V_2\}$. Congruencias: **5**.
> 5. $\text{último}_\tau = \lambda q : \text{Cola}_\tau . \text{case } q \text{ of } \langle\rangle \leadsto \text{próximo}(\langle\rangle_\tau);\ c \bullet x \leadsto x$, de tipo $\text{Cola}_\tau \to \tau$; la rama vacía es un término trabado bien tipado.
> 6. Progreso **falla** ($\text{próximo}(\langle\rangle_\tau)$ es stuck); determinismo y preservación se mantienen.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/lambda_tipado_extension_adt]]
