---
nombre: Clase de Repaso — Primer Parcial
parcial: 1P
programa: 2C_2026
tipo: repaso
fuente: raw/clases/prac/6.prac_P1_repaso_para_primer_parcial.pdf
---

Esta página recopila los ejercicios de la clase de repaso para el primer parcial del 2C 2025. Cubre Programación Funcional, Inducción, Deducción Natural y Cálculo Lambda.

## 1. Programación Funcional (Haskell)

### El tipo Melodia
Se define un tipo para representar melodías compuestas por sonidos y silencios:
```haskell
type Tono = Integer
data Melodia = Silencio
             | Nota Tono
             | Secuencia Melodia Melodia
             | Paralelo [Melodia]
```
- `Secuencia m1 m2`: `m2` empieza cuando termina `m1`.
- `Paralelo [m]`: Todas las melodías suenan simultáneamente. Suponemos que la lista no es vacía.

### Ejercicio 1.1 — Esquema de recursión (Fold)
**Enunciado:** Definir la función `foldMelodia`.

**Resolución:**
```haskell
foldMelodia :: b -> (Tono -> b) -> (b -> b -> b) -> ([b] -> b) -> Melodia -> b
foldMelodia fSil fNot fSec fPar mel = case mel of
    Silencio        -> fSil
    Nota t          -> fNot t
    Secuencia m1 m2 -> fSec (rec m1) (rec m2)
    Paralelo ms     -> fPar (map rec ms)
  where rec = foldMelodia fSil fNot fSec fPar
```

### Ejercicio 1.2 — Duración Total
**Enunciado:** Definir `duracionTotal :: Melodia -> Integer` usando `foldMelodia`. Los silencios y notas duran 1 unidad. En paralelo, la duración es la de la melodía más larga.

**Resolución:**
```haskell
duracionTotal :: Melodia -> Integer
duracionTotal = foldMelodia 1 (const 1) (+) maximum
```
*Nota: Se usa `maximum` porque en `Paralelo` todas suenan a la vez, por lo que el tiempo total es el máximo de las duraciones individuales.*

### Ejercicio 1.3 — Truncar
**Enunciado:** Definir `truncar :: Melodia -> Integer -> Melodia` que reproduce una melodía hasta una duración determinada.

**Resolución:**
```haskell
truncar :: Melodia -> Integer -> Melodia
truncar m n | n <= 0 = Silencio -- Opcional según interpretación, pero n debe ser > 0
truncar m n = case m of
    Silencio        -> Silencio
    Nota t          -> Nota t
    Secuencia m1 m2 -> let d1 = duracionTotal m1
                       in if n <= d1 
                          then truncar m1 n
                          else Secuencia m1 (truncar m2 (n - d1))
    Paralelo ms     -> Paralelo (map (\mi -> truncar mi n) ms)
```

---

## 2. Razonamiento Ecuacional e Inducción Estructural

### Definiciones
```haskell
data AB a = Nil | Bin (AB a) a (AB a)

altura :: AB a -> Int
{A0} altura Nil = 0
{A1} altura (Bin i r d) = 1 + max (altura i) (altura d)

zipAB :: AB a -> AB b -> AB (a, b)
{Z0} zipAB Nil _ = Nil
{Z1} zipAB (Bin i r d) Nil = Nil
{Z2} zipAB (Bin i r d) (Bin i' r' d') = Bin (zipAB i i') (r, r') (zipAB d d')
```

### Propiedad a demostrar
$\forall t :: AB \ a . \forall u :: AB \ b . \text{altura } t \geq \text{altura } (\text{zipAB } t \ u)$

**Demostración por inducción estructural en $t$:**

**Caso Base: $t = Nil$**
- Queremos ver: $\forall u . \text{altura Nil} \geq \text{altura (zipAB Nil } u)$
- Lado Izquierdo (LI): $\text{altura Nil} = 0$ por {A0}.
- Lado Derecho (LD): $\text{altura (zipAB Nil } u) = \text{altura Nil}$ por {Z0}.
- LD = 0 por {A0}.
- LI $\geq$ LD $\iff 0 \geq 0$ (Verdadero).

**Caso Inductivo: $t = Bin \ i \ r \ d$**
- **Hipótesis Inductivas:**
  - (HI1) $\forall u . \text{altura } i \geq \text{altura (zipAB } i \ u)$
  - (HI2) $\forall u . \text{altura } d \geq \text{altura (zipAB } d \ u)$
- **Queremos ver:** $\forall u . \text{altura (Bin } i \ r \ d) \geq \text{altura (zipAB (Bin } i \ r \ d) \ u)$

**Análisis por casos sobre $u$:**

- **Caso $u = Nil$:**
  - LI: $\text{altura (Bin } i \ r \ d)$.
  - LD: $\text{altura (zipAB (Bin } i \ r \ d) \ Nil) = \text{altura Nil} = 0$ por {Z1} y {A0}.
  - Como la altura de cualquier árbol es $\geq 0$, LI $\geq 0$ es verdadero.

- **Caso $u = Bin \ i' \ r' \ d'$:**
  - LI: $1 + \max(\text{altura } i, \text{altura } d)$ por {A1}.
  - LD: $\text{altura (zipAB (Bin } i \ r \ d) \ (Bin \ i' \ r' \ d'))$
  - LD: $\text{altura (Bin (zipAB } i \ i') \ (r, r') \ (\text{zipAB } d \ d'))$ por {Z2}.
  - LD: $1 + \max(\text{altura (zipAB } i \ i'), \text{altura (zipAB } d \ d'))$ por {A1}.
  - Por HI1 (con $u = i'$): $\text{altura } i \geq \text{altura (zipAB } i \ i')$.
  - Por HI2 (con $u = d'$): $\text{altura } d \geq \text{altura (zipAB } d \ d')$.
  - Por propiedad de monotonía de `max`: $\max(a, b) \geq \max(a', b')$ si $a \geq a'$ y $b \geq b'$.
  - Entonces, $1 + \max(\text{altura } i, \text{altura } d) \geq 1 + \max(\text{altura (zipAB } i \ i'), \text{altura (zipAB } d \ d'))$.
  - LI $\geq$ LD verificado. $\square$

---

## 3. Deducción Natural

### Teorema
Demostrar: $\rho \Rightarrow (\sigma \vee (\rho \Rightarrow \tau)) \Rightarrow (\sigma \vee \tau)$ (sin usar principios clásicos).

**Prueba:**
1. $[\rho \Rightarrow (\sigma \vee (\rho \Rightarrow \tau))]^1$ (Hip)
2. $[\rho]^2$ (Hip)
3. $\sigma \vee (\rho \Rightarrow \tau)$ ($\Rightarrow E$ 1, 2)
4. $[\sigma]^3$ (Hip para $\vee E$)
5. $\sigma \vee \tau$ ($\vee I_1$ 4)
6. $[\rho \Rightarrow \tau]^3$ (Hip para $\vee E$)
7. $\tau$ ($\Rightarrow E$ 6, 2)
8. $\sigma \vee \tau$ ($\vee I_2$ 7)
9. $\sigma \vee \tau$ ($\vee E$ 3, 4-5, 6-8)
10. $(\rho \Rightarrow (\sigma \vee (\rho \Rightarrow \tau))) \Rightarrow (\sigma \vee \tau)$ ($\Rightarrow I^1$ 9)
    *(Nota: El enunciado pide demostrar esto. Si el primer $\rho$ es una premisa, el resultado es el que buscamos).*

---

## 4. Cálculo Lambda: Extensión con Deques (Colas)

### Gramática
- Tipos: $\tau ::= \dots \mid \text{Cola}_\tau$
- Términos: $M ::= \dots \mid \langle \rangle_\tau \mid M \bullet M \mid \text{próximo}(M) \mid \text{desencolar}(M) \mid \text{case } M \text{ of } \langle \rangle \leadsto M ; c \bullet x \leadsto M$
  - $\langle \rangle_\tau$: Cola vacía.
  - $M_1 \bullet M_2$: Agrega $M_2$ al **final** de $M_1$.
  - $\text{próximo}(M)$: Devuelve el **primer** elemento.
  - $\text{desencolar}(M)$: Devuelve la cola sin el primer elemento.
  - `case M of < > leadsto M2 ; c leadsto x leadsto M3`: Permite operar desde el **final** (accediendo al último elemento $x$ y al resto de la cola $c$).

### Reglas de Tipado
- **T-Empty:** $\Gamma \vdash \langle \rangle_\tau : \text{Cola}_\tau$
- **T-Snoc:** $\frac{\Gamma \vdash M_1 : \text{Cola}_\tau \quad \Gamma \vdash M_2 : \tau}{\Gamma \vdash M_1 \bullet M_2 : \text{Cola}_\tau}$
- **T-Next:** $\frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{próximo}(M) : \tau}$
- **T-Pop:** $\frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{desencolar}(M) : \text{Cola}_\tau}$
- **T-Case:** $\frac{\Gamma \vdash M : \text{Cola}_\tau \quad \Gamma \vdash M_2 : \sigma \quad \Gamma, c : \text{Cola}_\tau, x : \tau \vdash M_3 : \sigma}{\Gamma \vdash \text{case } M \text{ of } \langle \rangle \leadsto M_2 ; c \bullet x \leadsto M_3 : \sigma}$

### Valores y Reducción
- **Valores:** $V ::= \dots \mid \langle \rangle_\tau \mid V \bullet V$
- **Reducciones:**
  1. $\text{próximo}(\langle \rangle \bullet V) \to V$
  2. $\text{próximo}((c \bullet x) \bullet y) \to \text{próximo}(c \bullet x)$
  3. $\text{desencolar}(\langle \rangle \bullet V) \to \langle \rangle$
  4. $\text{desencolar}((c \bullet x) \bullet y) \to \text{desencolar}(c \bullet x) \bullet y$
  5. $\text{case } \langle \rangle \text{ of } \dots \langle \rangle \leadsto M_2 \dots \to M_2$
  6. $\text{case } (c \bullet x) \text{ of } \dots c \bullet x \leadsto M_3 \to M_3$

### Ejercicio de Reducción
Reducir: `case <> • 1 • 0 of <> leadsto próximo(<>); c • x leadsto isZero(x)`
1. El término es un constructor `(<> • 1) • 0`. Unifica con el patrón `c • x` donde $c = (\langle \rangle \bullet 1)$ y $x = 0$.
2. Reemplazamos en el cuerpo: `isZero(0)`.
3. Resultado: `True`.

### Macro `último`
**Enunciado:** Definir `último` que devuelva el último elemento encolado.
$\text{ultimo}_\tau \stackrel{def}{=} \lambda q : \text{Cola}_\tau . \text{case } q \text{ of } \langle \rangle \leadsto \text{error} ; c \bullet x \leadsto x$
*(Nota: Si la cola está vacía, el comportamiento depende de la definición de error o forma normal deseada).*
