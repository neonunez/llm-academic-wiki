---
tipo: transcripcion
fuente: raw/parciales/2P/2.parcial_1C_2025_resolucion_(2).pdf
metodo: claude_vision
paginas: 5
---

# Transcripcion — 2do Parcial 1C 2025 — Resolucion (2)

**Alumno:** Matico  
**Fecha:** 19/06/2025  
**Notas:** Ej.1 = Bien | Ej.2 = Bien | Ej.3 = Bien

---

## Pagina 1 — Enunciado (identico a res_(1))

**Encabezado:**  
SISTEMAS DIGITALES — 1C 2025 — 2do Parcial — 19/06/2025

Ejercicio 1, Ejercicio 2, Ejercicio 3 con enunciados identicos al PDF de resolucion_(1). Ver [[transcripciones/2P_1C_2025_res1_raw]].

---

## Pagina 3 — Resolucion Ejercicio 1

```
Ej 1) rec:   # a0 = n                              nuevo stack
             addi sp, sp, -16                       pointer
             sw   ra, 0(sp)    # Tomo espacio en el stack y
             sw   s0, 4(sp)    # guardo en memoria los valores
             sw   s1, 8(sp)    # que debo preservar (ya que los
                               # reescribo en rec).

             # caso base:
             li   a1, 1
             ble  a0, a1, fin  # si a0 <= a1 salta; si n<=1 devuelvo n
             mv   s0, a0       # s0 = n; lo guardo para mantenerlo luego en s0 de rec
             addi a0, a0, -1   # a0 = n-1
             jal  rec          # a0 = rec(n-1)
             slli s1, a0, 1    # s1 = 2 * a0; lo guardo para mantenerlo luego en s1
             addi a0, s0, -2   # a0 = n-2
             jal  rec          # a0 = rec(n-2)
             # mul/add:
             li   a1, 3        # a1 = 3
             mul  a0, a0, a1   # a0 = 3 * rec(n-2)
             add  a0, s1, a0   # a0 = 2*rec(n-1) + 3*rec(n-2)

Fin:
             lw   s1, 8(sp)
             lw   s0, 4(sp)    # Recupero valores que debo
             lw   ra, 0(sp)    # preservar y restauro stack
             addi sp, sp, 16   # pointer.
             ret
```

**Justificacion del alumno (escrita debajo del codigo):**

"Como lo explique en los comentarios, uso registros que se deben preservar en la funcion, pero como los guardo en memoria al principio y al final los recupero, preservo los valores que tenian antes de entrar a la funcion (los registros son ra, s0, s1). El a0 por convencion tiene el valor de retorno de la misma (y el que respeta esto en la funcion), ademas uso a0 y a1 pero estos no los guardo porque son volatiles. Como dije antes, el resultado estara en a0 al terminar la funcion como dicta la convencion."

"Los valores que estan en registros volatiles y quiero mantener, los guardo en registros preservables para asegurarme que la funcion llamada no los va a modificar (por convencion)."

---

## Pagina 4 — Resolucion Ejercicio 2

```
Ej 2) Asumo que tengo aportantes y largo como constantes en .data.

AporteProm:
    addi sp, sp, -16      # Guardo ra en stack (por las dudas) → No es necesario
    sw   ra, 0(sp)

    li   t0, 0            # t0 = cant personas >= 65 la edad
    li   t1, 0            # t1 = suma aportes
    li   t2, 65           # t2 = 65
    la   a0, aportantes   # Cargo puntero al arreglo en a0
    la   a1, largo        # Cargo dir del valor largo
    lbu  a1, 0(a1)        # Recupero valor de largo de memoria
                          # (lo tome como bu porque en el ejemplo
                          # lo definen como byte y las longitudes
                          # siempre son positivas), en a1

while:                    # si a1 == 0, termina
    beqz a1, FinWhile
    lbu  a2, 0(a0)        # a2 = edad
    blt  a2, t2, noSuma   # si edad < 65 no cuento nada
    addi t0, t0, 1        # cant++
    addi a0, a0, 2        # nuevo puntero a pesos (2 bytes)
    lh   a2, 0(a0)        # a2 = pesos
    add  t1, t1, a2       # agrega pesos a aportes totales

[nota al margen: "deberia ir aca el noSuma, antes del while, y no sumar despues del while"]

    addi a1, a1, -1       # largo--
    addi a0, a0, 2        # nuevo puntero al siguiente aportante
    j    while

FinWhile:
    div  a0, t1, t0       # a0 = suma aportes / cant personas con mas de 65 anos

    lw   ra, 0(sp)        # mmmm
    addi sp, sp, 16       # Recupero ra y valor del sp
    ret                   # a0 = aporte promedio de personas con edad >= 65

* noSuma:
    addi a1, a1, -1       # largo--
    addi a0, a0, 4        # Paso al siguiente aportante. Antes a0 estaba
                          # en el 1er byte (edad) y aportante tiene 4 bytes de tamano
    j    while
```

**Justificacion del alumno:**

"Como no uso ningun valor registro preservable, no hace falta que los guarde en memoria (solo guardo ra y recupero ra). Uso registros volatiles a0-a2 y t0-t2 (los elegi de forma arbitraria, usando los 'a' para cargar info de .data). Respeto la convencion del valor de retorno ya que lo guardo en a0."

---

## Pagina 5 — Resolucion Ejercicio 3

**Ej 3 — Extensor de signo y senales de control:**

"El extensor de signo en este caso esta con la senal ImmSrc correspondiente a instrucciones de saltos, es decir, que tiene inmediato de 13 bits con el bit 0 sin representar (ya que siempre es 0 para los saltos porque el PC tiene direcciones pares (las instrucciones son words de 4 bytes)). Este inmediato se extiende primero agregando el bit 0 con el valor 0 y extendiendo el signo a 32 bits. Al agregar este ultimo 0, los bits menos significativos pasan de ser 1010=0xA a ser 0100=0x4, y por eso el resultado de extender 0xFFA es 0xFFFFFFF4 (demas los F vienen de la extension del signo negativo)."

"Como beq salta a L7 si x4==x4, y estoy comparando el mismo registro, esta condicion se cumple y el PCSrc envia la senal 1 al multiplexor de PCNext, seteando PC Next en la direccion de la etiqueta L7 (se calcula sumando el inmediato que extendimos antes (offset) mas el valor anterior del PC (PCTarget)). Este nuevo valor de PCNext determina la direccion de la proxima instruccion a ejecutar (PCTarget)."

"Las senales PCSrc, ImmSrc: anteriormente dije que valores tenian para esta instruccion. En general:
- PCSrc indica si el nuevo valor del [PC] se va a obtener de sumarle 4 al PC (senal 0) o de sumarle un inmediato (offset) arbitrario (senal 1).
- ImmSrc indica como se va a extender el inmediato y cuantos bits tiene el inmediato (depende del tipo de operacion).
- ALUSrc indica si el segundo operando del ALU viene de los registros o de un inmediato (senal 0 para registros y 1 para inmediatos); en este caso la ALU realiza una operacion con registros (senal 0): x4 y x4.
- ALUControl indica a la ALU que operacion debe hacer. En este caso seria una resta para hacer x4-x4 y poder ver si se enciende el flag Zero (si son iguales)."

"Todas estas senales son senales de control (PCSrc, ImmSrc, ALUSrc, ALUControl), cuyos valores son definidos por la unidad de control. La unidad de control es la encargada de decodificar la instruccion y a partir de eso definir los valores de las senales de control. En este caso ademas, [la unidad de control] es la encargada de revisar si el flag zero esta en unos y setear (con PCSrc) si se hace el salto."
