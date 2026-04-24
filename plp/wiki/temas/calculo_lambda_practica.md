---
nombre: Cálculo Lambda — Clase Practica
parcial: 1P
tipo: practica
tema: calculo_lambda_tipado
fuente: 
  - raw/clases/prac/4.prac_P1_calculo_lambda.pdf
  - raw/clases/prac/5.prac_P1_calculo_lambda_(2).pdf
paginas_relacionadas:
  - "[[calculo_lambda_tipado_teoria]]"
---

## Patrones de este tema en parciales
> [[tipos_ejercicio/lambda_tipado_extension_adt]] · [[tipos_ejercicio/lambda_tipado_semantica_adt]] · [[tipos_ejercicio/lambda_tipado_reduccion_pasos]] · [[tipos_ejercicio/lambda_derivacion_tipado]] · [[tipos_ejercicio/lambda_valores]] · [[tipos_ejercicio/lambda_cambio_reglas]]

## Ejercicios de clase

### Ejercicio 1 — Identificación de términos y variables libres

**Enunciado**
¿Cuáles de las siguientes expresiones son términos del cálculo lambda? En los casos que sí lo sean, dibujar su árbol sintáctico y marcar las ocurrencias libres de las variables.

a) $\lambda x : \text{Bool} \to \text{Bool}. x \text{ true}$
b) $x \ y \ \lambda x : \text{Bool} \to \text{Bool}. x \ y$
c) $(\lambda x : \text{Bool} \to \text{Bool}. x \ y)(\lambda y : \text{Bool}. x)$
d) $\lambda x : \text{Bool}$
e) $\lambda x . x$
f) $\text{if } x \text{ then } y \text{ else } \lambda z : \text{Bool} . z$
g) $\lambda y : \sigma . y$
h) $\text{true false}$
i) $x \ M$
j) $\text{if } x \text{ then } \lambda x : \text{Bool} . x$

**Explicacion**
Para que una expresión sea un término válido en el Cálculo Lambda Simplemente Tipado ($\lambda^{\to}$), debe respetar la gramática:
$M ::= x \mid \lambda x : \sigma . M \mid M \ M \mid \text{true} \mid \text{false} \mid \text{if } M \text{ then } M \text{ else } M$.
Las variables libres son aquellas que no están bajo el alcance de un $\lambda$ con su mismo nombre.

**Resolucion paso a paso**
- **a) Sí.** Término válido. Variable $x$ ligada por el $\lambda$. $\text{true}$ es constante. $fv(a) = \emptyset$.
- **b) Sí.** La aplicación asocia a izquierda: $(x \ y) \ (\lambda x : \dots)$. $x$ y $y$ al principio son libres. El $y$ al final también es libre. $fv(b) = \{x, y\}$.
- **c) Sí.** En el primer cuerpo $y$ es libre. En el segundo cuerpo $x$ es libre. $fv(c) = \{x, y\}$.
- **d) No.** Falta el cuerpo de la abstracción.
- **e) No.** En $\lambda^{\to}$ (simplemente tipado), el parámetro del $\lambda$ debe tener un tipo explícito ($\lambda x : \sigma . M$).
- **f) Sí.** Término condicional. $x$ e $y$ son libres. $z$ está ligada. $fv(f) = \{x, y\}$.
- **g) Sí.** $\sigma$ se trata como una variable de tipo. $y$ está ligada. $fv(g) = \emptyset$.
- **h) Sí.** Es una aplicación de dos constantes. Es un término sintácticamente válido, aunque no tipará (porque $\text{true}$ no es una función). $fv(h) = \emptyset$.
- **i) Sí** (asumiendo que $M$ es un término). $x$ es una variable libre.
- **j) No.** Falta la rama `else` del condicional.

**Chuleta**
> 1. Revisar gramática: $\lambda x : \sigma . M$ siempre requiere tipo y cuerpo.
> 2. `if` siempre requiere `then` y `else`.
> 3. Aplicación es asociativa a izquierda: $M N O = (M N) O$.

---

### Ejercicio 2 — Chequeo de tipos

**Enunciado**
Derivar los siguientes juicios de tipado, o explicar por qué no son válidos.

a) $\vdash (\lambda x : \text{Bool}. \lambda y : \text{Bool}. \text{if } x \text{ then true else } y) \text{ false} : \text{Bool} \to \text{Bool}$
b) $\{x : \text{Bool}\} \vdash \text{true} : \text{Bool}$
c) $\vdash \text{if } x \text{ then } x \text{ else } z : \text{Bool}$
d) $\{x : \text{Bool}\} \vdash \text{if } x \text{ then } x \text{ else } (\lambda y : \text{Bool}. y) : \text{Bool} \to \text{Bool}$

**Explicacion**
Se deben aplicar las reglas del sistema de tipado:
- **T-Var:** $\frac{x : \sigma \in \Gamma}{\Gamma \vdash x : \sigma}$
- **T-Abs:** $\frac{\Gamma, x : \sigma \vdash M : \tau}{\Gamma \vdash \lambda x : \sigma . M : \sigma \to \tau}$
- **T-App:** $\frac{\Gamma \vdash M : \sigma \to \tau \quad \Gamma \vdash N : \sigma}{\Gamma \vdash M N : \tau}$
- **T-If:** $\frac{\Gamma \vdash M : \text{Bool} \quad \Gamma \vdash N_1 : \tau \quad \Gamma \vdash N_2 : \tau}{\Gamma \vdash \text{if } M \text{ then } N_1 \text{ else } N_2 : \tau}$

**Resolucion paso a paso**
- **a) Válido.** 
  1. El término es una aplicación. Se debe probar que el $\lambda$ tiene tipo $\text{Bool} \to (\text{Bool} \to \text{Bool})$ y que `false` tiene tipo $\text{Bool}$.
  2. $\text{false} : \text{Bool}$ por **T-False**.
  3. El $\lambda$ tipa por **T-Abs** doble: $\{x : \text{Bool}, y : \text{Bool}\} \vdash \text{if } x \dots : \text{Bool}$.
  4. El condicional tipa por **T-If**: $x : \text{Bool}$, $\text{true} : \text{Bool}$ y $y : \text{Bool}$ (todas en el contexto).
- **b) Válido.** La constante `true` tipa siempre como `Bool` independientemente del contexto (**T-True**).
- **c) Inválido.** El contexto es vacío ($\emptyset$), pero el término contiene variables libres $x$ y $z$. No se pueden usar **T-Var** sin que estén en $\Gamma$.
- **d) Inválido.** La regla **T-If** requiere que ambas ramas (`then` y `else`) tengan el **mismo** tipo. Aquí $x$ tiene tipo `Bool` y $(\lambda y : \text{Bool}. y)$ tiene tipo $\text{Bool} \to \text{Bool}$. No coinciden.

---

### Ejercicio 3 — Chequeo de tipos con incógnitas

**Enunciado**
Derivar un juicio de tipado para el siguiente término identificando qué tipos pueden ser $\tau, \sigma$ y $\rho$:
$\lambda x : \rho . \lambda y : \sigma . \lambda z : \tau . x (y z)$

**Explicacion**
Debemos inferir las restricciones que imponen las aplicaciones:
1. $(y z)$ implica que $y$ debe ser una función que recibe el tipo de $z$. Si $z : \tau$, entonces $y : \tau \to \alpha$.
2. $x (y z)$ implica que $x$ debe ser una función que recibe el tipo resultante de $(y z)$, que es $\alpha$. Entonces $x : \alpha \to \beta$.

**Resolucion paso a paso**
- Asignamos tipos a las variables: $z : \tau$, $y : \sigma$, $x : \rho$.
- Por $(y z)$: $\sigma = \tau \to \alpha$ para algún $\alpha$.
- El tipo de $(y z)$ es $\alpha$.
- Por $x (y z)$: $\rho = \alpha \to \beta$ para algún $\beta$.
- El tipo del cuerpo total es $\beta$.
- El término completo tiene tipo: $(\alpha \to \beta) \to (\tau \to \alpha) \to \tau \to \beta$.
- Esto coincide con la composición de funciones.

**Chuleta**
> Para incógnitas, plantear ecuaciones de tipos basadas en aplicaciones: si hay $(M N)$, entonces $Tipo(M) = Tipo(N) \to \text{Algo}$.

---

### Ejercicio 4 — Valores en Semántica Operacional

**Enunciado**
¿Cuáles de los siguientes términos son valores ($V$) bajo la estrategia call-by-value?
$V ::= \text{true} \mid \text{false} \mid \lambda x : \sigma . M$

a) $\text{if true then } (\lambda x : \text{Bool}. x) \text{ else } (\lambda x : \text{Bool}. \text{false})$
b) $\lambda x : \text{Bool}. \text{false}$
c) $(\lambda x : \text{Bool}. x) \text{ false}$
d) $\text{true}$
e) $\text{if } x \text{ then true else false}$
f) $\lambda x : \text{Bool}. (\lambda y : \text{Bool}. x) \text{ false}$
g) $\lambda x : \text{Bool} \to \text{Bool}. x \text{ true}$

**Explicacion**
Un valor es un término que ya no puede reducirse más bajo la estrategia elegida. En call-by-value, los valores son constantes y abstracciones (independientemente de si su cuerpo es reducible o no).

**Resolucion paso a paso**
- **a) No.** Es un condicional que puede reducirse (a la rama `then`).
- **b) Sí.** Es una abstracción $\lambda$.
- **c) No.** Es una aplicación que puede reducirse (redex).
- **d) Sí.** Es una constante booleana.
- **e) No.** Es un condicional (aunque no sea un redex si $x$ es libre, no entra en la definición de valor).
- **f) Sí.** Es una abstracción $\lambda$. En call-by-value **no** se reduce dentro del cuerpo de un $\lambda$ hasta que se aplique.
- **g) Sí.** Es una abstracción $\lambda$.

---

### Ejercicio 5 — Extensión con Números Naturales

**Enunciado**
a) ¿Mantiene la extensión de naturales las propiedades de determinismo, preservación de tipos y progreso?
b) ¿Qué términos representan las expresiones $0, 1$ y $2$? ¿Cómo reducen?

**Explicacion**
La extensión típica agrega:
- Tipos: $\text{Nat}$
- Términos: $\text{zero} \mid \text{succ } M \mid \text{iszero } M \mid \text{pred } M$
- Valores: $v ::= \dots \mid \text{nv}$ donde $\text{nv} ::= \text{zero} \mid \text{succ } \text{nv}$

**Resolucion paso a paso**
- **a) Sí.** Si las reglas de reducción están bien planteadas (ej: no permitir reducir dentro de `succ` si queremos call-by-value estricto sobre valores numéricos), las propiedades se mantienen.
- **b) Representación:**
  - $\underline{0} = \text{zero}$
  - $\underline{1} = \text{succ zero}$
  - $\underline{2} = \text{succ (succ zero)}$
- **Reducción:**
  - $\text{pred (succ } v) \to v$
  - $\text{iszero zero} \to \text{true}$
  - $\text{iszero (succ } v) \to \text{false}$

---

### Ejercicio 6 — Cambio de reglas semánticas (Regla $\zeta$)

**Enunciado**
Supongamos que agregamos la regla para abstracciones:
Si $M \to N$, entonces $\lambda x : \tau . M \to \lambda x : \tau . N$ ($\zeta$)

1. Repensar el conjunto de valores para respetar esta modificación. ¿$\lambda x : \text{Bool} . \text{id}_{\text{Bool}} \text{ true}$ es un valor? ¿Y $\lambda x : \text{Bool} . x$?
2. ¿Qué reglas deberían modificarse para no perder el determinismo?
3. Reducir: $\lambda z : \text{Nat} \to \text{Nat} . (\lambda x : \text{Nat} \to \text{Nat} . x \ 23) \lambda z : \text{Nat} . 0$

**Explicacion**
La regla $\zeta$ permite reducir **dentro** de un $\lambda$. Esto acerca la semántica a la estrategia de **orden normal** o **reducción completa**.

**Resolucion paso a paso**
1. **Valores:** Ahora un $\lambda$ solo es valor si su cuerpo es una **forma normal** (no se puede reducir más).
   - $\lambda x : \text{Bool} . \text{id}_{\text{Bool}} \text{ true}$ **NO** es valor, porque el cuerpo es un redex.
   - $\lambda x : \text{Bool} . x$ **SÍ** es valor (forma normal).
2. **Determinismo:** Para mantenerlo, hay que definir prioridades. Si un término es $(\lambda x . M) V$, ¿reducimos el $\lambda$ (beta) o reducimos dentro de $V$ o $M$? Se suele requerir que el argumento sea valor y que el cuerpo no sea reducible para aplicar beta si se busca una estrategia específica, o fijar un orden de búsqueda de redexes.
3. **Reducción:**
   $(\lambda z : \text{Nat} \to \text{Nat} . (\lambda x : \dots . x \ 23) \lambda z : \text{Nat} . 0)$
   Aplicando la regla $\zeta$ al $\lambda$ externo:
   $\to \lambda z : \dots . ((\lambda z : \text{Nat} . 0) \ 23)$  (aplicando beta dentro)
   $\to \lambda z : \dots . 0$ (aplicando el segundo beta)

---

## Extensiones del Cálculo Lambda

### Ejercicio 7 — Extensión con Pares

**Enunciado**
a) Definir como macro la función $curry_{\sigma,\tau,\delta}$ que sirve para currificar funciones que reciben pares como argumento.
b) Verificar el siguiente juicio de tipado: $\emptyset \vdash \pi_1((\lambda x : \text{Nat}. \langle x, \text{True} \rangle) \ 0) : \text{Nat}$
c) Reducir el término anterior a un valor.

**Explicacion**
La extensión con pares introduce el tipo $\sigma \times \tau$ y los constructores/proyectores:
- **T-Pair:** $\frac{\Gamma \vdash M : \sigma \quad \Gamma \vdash N : \tau}{\Gamma \vdash \langle M, N \rangle : \sigma \times \tau}$
- **T-Proj:** $\frac{\Gamma \vdash M : \sigma \times \tau}{\Gamma \vdash \pi_1(M) : \sigma}$ (análogo para $\pi_2$)
- **Reducción:** $\pi_1(\langle M, N \rangle) \to M$

**Resolucion paso a paso**
- **a) Macro curry:**
  Una función que recibe un par tiene tipo $(\sigma \times \tau) \to \delta$. Su versión currificada tiene tipo $\sigma \to \tau \to \delta$.
  $\text{curry} \stackrel{def}{=} \lambda f : (\sigma \times \tau) \to \delta. \lambda x : \sigma. \lambda y : \tau. f \langle x, y \rangle$
- **b) Juicio de tipado:**
  1. $0 : \text{Nat}$ (T-Zero).
  2. $\{x : \text{Nat}\} \vdash x : \text{Nat}$ (T-Var) y $\{x : \text{Nat}\} \vdash \text{True} : \text{Bool}$ (T-True).
  3. Por **T-Pair**: $\{x : \text{Nat}\} \vdash \langle x, \text{True} \rangle : \text{Nat} \times \text{Bool}$.
  4. Por **T-Abs**: $\emptyset \vdash \lambda x : \text{Nat}. \langle x, \text{True} \rangle : \text{Nat} \to (\text{Nat} \times \text{Bool})$.
  5. Por **T-App**: $\emptyset \vdash (\lambda x : \dots) \ 0 : \text{Nat} \times \text{Bool}$.
  6. Por **T-Proj**: $\emptyset \vdash \pi_1(\dots) : \text{Nat}$. **Válido.**
- **c) Reducción:**
  $\pi_1((\lambda x : \text{Nat}. \langle x, \text{True} \rangle) \ 0)$
  $\to \pi_1(\langle 0, \text{True} \rangle)$ (aplicando Beta)
  $\to 0$ (aplicando Proyección)
  Valor final: $0$.

---

### Ejercicio 8 — Extensión con Árboles Binarios (vía `case`)

**Enunciado**
a) Reducir el siguiente término:
`case if (λx : Bool.x) True then Bin(Nil, 1, Nil) else Nil of Nil leadsto False ; Bin(i, r, d) leadsto iszero(r)`
b) Definir una nueva extensión que incorpore expresiones de la forma $map(M, N)$, donde $N$ es un árbol y $M$ una función que se aplicará a cada elemento.

**Explicacion**
El uso de `case` para árboles permite un análisis de casos exhaustivo similar al `case` de uniones disjuntas o al `match` de Haskell.

**Resolucion paso a paso**
- **a) Reducción:**
  1. Evaluamos la condición del `if`: $(\lambda x : \text{Bool}. x) \text{ True} \to \text{True}$.
  2. Resolvemos el `if`: $\text{if True then Bin}(\dots) \text{ else Nil} \to \text{Bin}(\text{Nil}, 1, \text{Nil})$.
  3. Evaluamos el `case`:
     `case Bin(Nil, 1, Nil) of Nil leadsto ... ; Bin(i, r, d) leadsto iszero(r)`
  4. El término es un constructor `Bin`, por lo que unifica con el segundo patrón: $i = \text{Nil}, r = 1, d = \text{Nil}$.
  5. Evaluamos el cuerpo del patrón: $\text{iszero}(1) \to \text{False}$.
  Valor final: **False**.
- **b) Definición de map:**
  Podemos definir `map` usando recursión (asumiendo que tenemos un operador de punto fijo o recursión primitiva) o mediante reglas de reducción:
  - $map(M, \text{Nil}) \to \text{Nil}$
  - $map(M, \text{Bin}(i, r, d)) \to \text{Bin}(map(M, i), M \ r, map(M, d))$
  
  **Regla de tipado:**
  $\frac{\Gamma \vdash M : \sigma \to \tau \quad \Gamma \vdash N : AB_\sigma}{\Gamma \vdash map(M, N) : AB_\tau}$
