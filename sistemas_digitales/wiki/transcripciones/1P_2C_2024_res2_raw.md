---
tipo: transcripcion
fuente: raw/parciales/1P/1.parcial_2C_2024_resolucion_(2).pdf
metodo: claude_vision
paginas: 6
alumno: Kruel, Magali — LU 1257/23
nota: 9.5
corrector: Juan Alvarez Colotro
---

# Transcripcion — 1er Parcial 2C 2024 (res. 2)

**Alumno:** Kruel, Magali — LU: 1257/23 — 4 hojas
**Puntajes:** Ej1=3 | Ej2=1 | Ej3=1.5 | Ej4=4 — **Nota: 9.5**
**Corrector:** Juan Alvarez Colotro

---

## Pagina 1 — Caratula y enunciados

*Impresa. Encabezado:* SISTEMAS DIGITALES — Primer Parcial. Segundo Cuatrimestre 2024.

**Aclaraciones:** anote apellido, nombre, LU y numere todas las hojas. El parcial no es a libro abierto. Se aprueba con 6; ambos parciales aprobados para promocion directa.

**Ejercicio 1** (3 pts.) Responder y justificar:
- ¿Cuál es el rango de representación de un número de cuatro bits en signo y magnitud? ¿Cuál es el rango de representación de un número de ocho bits en complemento a dos?
- ¿Cómo se calcula el inverso aditivo de un número n en complemento a dos de k bits?
- Para dos números a y b de k bits, para una operación de suma cuyo resultado nombramos c, ¿cómo se determina el **carry**, sobre qué tipo de datos lo observamos? ¿Cómo se determina el **overflow**, sobre qué tipo de datos lo observamos? Explique por qué se definen de esta manera.

**Ejercicio 2** (1 punto) Responder:
1. Sea $p|q = \overline{p \cdot q}$ (NAND). ¿Alcanza este único operador para representar todas las funciones booleanas?
2. Sea $p \downarrow q = \overline{p+q}$ (NOR). ¿Alcanza este único operador para representar todas las funciones booleanas?
Consejo: AND, OR y NOT son suficientes para representar todas las funciones booleanas.

**Ejercicio 3** (2 pts.) Dibujar circuitos que implementen:
1. $f(A,B,C) = A \cdot B \cdot C$ usando 2 compuertas NOR y varias compuertas NOT.
2. $f(A,B) = \overline{((A \cdot B)+(\bar{B} \cdot A))} \cdot \bar{B}$ ¿Para qué valores de A y B la función devuelve un 1?

**Ejercicio 4** (4 pts.) **Registro bidireccional:** Diseñar un registro bidireccional de cuatro bits. Señales: clk, load (si vale 1 en flanco ascendente → almacena d₀–d₃), read (si vale 1 → emite el valor almacenado por las mismas líneas d₀–d₃). load y read nunca valen 1 simultáneamente. *Ayuda: utilice componentes de tres estados.*

---

## Pagina 2 — Ejercicio 1 (hoja 1, puntajes 1/1, 1/1, 1/1)

**Ej1.i — Rangos:**

- S+M, 4 bits: $[-2^{4-1}+1;\; 2^{4-1}-1] = [-7;\; 7]$ ✓
- C2, 8 bits: $[-128;\; 127]$ ✓

**Ej1.ii — Inverso aditivo:**

El inverso aditivo de un número n que ya está escrito en complemento a dos se calcula como $\text{inv}(n-1)$ ✓

*(Nota: "inv" = invertir todos los bits. $\text{inv}(n-1) = \overline{n-1}$. Equivalente a la formula estandar $\overline{n}+1$.)*

**Ej1.iii — Carry y Overflow:**

*Carry:* se determina mirando el $(k+1)$-ésimo bit de c. Para sumar 2 números de k bits, se hace la suma bit a bit; si esta suma se sale del rango de representación, se "pasa" 1 unidad a los bits a su izquierda — esa unidad se llama carry. Cuando estamos sumando los bits más significativos de a y b, si hay carry, no puede "pasarse" a vecinos izquierdos (no tienen), y debe ponerse junto con el resultado c. (carry = CarryOut, o el carry de salida)

*Overflow:*
- Para **sin signo**: el carry determina el overflow, ya que carry indica que la suma se sale del rango de representación.
- Para **complemento a dos**: se usa la siguiente regla — si dos números con mismo signo devuelven un número con signo opuesto, hay Overflow. Se detecta mirando los bits más significativos de cada número:

$$\ominus + \ominus = \oplus \Rightarrow \text{Overflow} \qquad \oplus + \oplus = \ominus \Rightarrow \text{Overflow}$$
$$\oplus + \ominus = \oplus \Rightarrow \text{OK} \qquad \ominus + \oplus = \ominus \Rightarrow \text{OK}$$

Corrector: ✓

---

## Pagina 4 — Ejercicio 2 (hoja 2, puntajes 0.5/0.5 + 0.5/0.5)

**Ej2 — NAND y NOR universales:**

**(1) NAND:** Sí, alcanza. Para justificarlo, reescribo AND, OR y la negación:

- negación: $\bar{A} \overset{\text{idempotencia}}{=} \overline{A \cdot A} \approx \overline{p \cdot q},\; p=A,\; q=A$ ✓
- AND: $A \cdot B = \overline{\overline{A \cdot B}} \overset{\text{De Morgan}}{=} \overline{\bar{A}+\bar{B}} \overset{\text{identidad}}{=} \overline{1 \cdot (\bar{A}+\bar{B})} \approx \overline{p \cdot q},\; p=1,\; q=\overline{A+B}$ ✓
- OR: $A+B = \overline{\overline{A+B}} \overset{\text{De Morgan}}{=} \overline{\bar{A} \cdot \bar{B}} \approx \overline{p \cdot q},\; p=\bar{A},\; q=\bar{B}$ ✓

**(2) NOR:** Sí, alcanza. Para justificarlo, reescribo AND, OR y la negación:

- negación: $\bar{A} \overset{\text{idempotencia}}{=} \overline{A+A} \approx \overline{p+q},\; p=A,\; q=A$ ✓
- AND: $A \cdot B = \overline{\overline{A \cdot B}} \overset{\text{De Morgan}}{=} \overline{\bar{A}+\bar{B}} \approx \overline{p+q},\; p=\bar{A},\; q=\bar{B}$ ✓
- OR: $A+B = \overline{\overline{A+B}} \overset{\text{De Morgan}}{=} \overline{\bar{A} \cdot \bar{B}} \overset{\text{identidad}}{=} \overline{0+(\bar{A} \cdot \bar{B})} \approx \overline{p+q},\; p=0,\; q=\bar{A} \cdot \bar{B}$ ✓

---

## Pagina 5 — Ejercicio 3 (hoja 3, puntajes 0.5/1 + 1/1)

**Ej3.1 — $f(A,B,C) = A \cdot B \cdot C$ con 2 NOR + NOTs:**

*(0.5/1 — FALTA LA JUSTIFICACION, segun corrector)*

Dibuja el circuito directamente:
- A, B, C → NOT individuales → NOT(A), NOT(B) → NOR₁ → salida intermediaNOR₁ + NOT(C) → NOR₂ → f

El circuito es correcto (implementa $A \cdot B \cdot C$). El corrector indica "FALTA LA JUSTIFICACION" — descuenta 0.5 por ausencia de derivacion algebraica.

**Ej3.2 — $f(A,B) = \overline{((A \cdot B)+(\bar{B} \cdot A))} \cdot \bar{B}$:**

*(1/1 — aunque con observacion)*

Tabla de verdad:

| A | B | $\bar{B}$ | A·B | $\bar{B}$·A | $(A \cdot B)+(\bar{B} \cdot A)$ | $f(A,B)$ |
|---|---|-----------|-----|-------------|--------------------------------|----------|
| 0 | 0 | 1 | 0 | 0 | 0 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 0 | 1 | 1 | 0 |
| 1 | 1 | 0 | 1 | 0 | 1 | 0 |

$\Rightarrow \bar{A} \cdot \bar{B}$ devuelven 1.

"Veamos que $\bar{A} \cdot \bar{B} = \overline{A+B}$, por lo que basta con una compuerta NOR."

Circuito: A, B → NOR → f ✓

*Nota corrector: "FALTO LA RESPUESTA: A=0 y B=0"* — la alumna identifica $\bar{A}.\bar{B}$ algebraicamente pero no escribe la respuesta textual explícita. Corrector pone 1/1 de todas formas (la observacion es en rojo, no descuenta).

---

## Pagina 6 — Ejercicio 4 (hoja 4, puntaje 4/4)

**Ej4 — Registro bidireccional 4 bits:**

*(4/4)*

"Por cuestiones de prolijidad, haré un circuito simple y luego lo extenderé a 4 bits."

**Componente base (reg-bd-simple, 1 bit):**

- Registro que guarda 1 bit cuando clk=↑ y load=1, y retorna el valor guardado cuando read=1.
- Componentes: 1 Flip-Flop D + 1 buffer tristate + AND gate (clk·load)
- R = bit almacenado en FF-D
- Tristate: habilitado por read=1 → emite R sobre la linea D; deshabilitado (Z) cuando read=0 → linea D libre para entrada
- Diagrama: D → FF-D (reloj habilitado por AND de clk y load) → R → buffer tristate (control: read) → D

**Registro bidireccional 4 bits:**

- 4 instancias de reg-bd-simple, una por bit (d0, d1, d2, d3)
- El mismo clk, load y read se conectan a las cuatro instancias para que operen simultaneamente
- "Notar que se usan el mismo clk, load y read para los cuatro registros para que operen al mismo tiempo."

Corrector: ✓ 4/4
