---
nombre: Logica Secuencial — Teoria
parcial: 1P
tipo: teoria
tema: logica_secuencial
fuente: raw/clases_teoricas/3.teo_logica_secuencial.pdf
fuente_adicional: raw/contenido_comunidad/resumen_sistemas_digitales.pdf
paginas_relacionadas:
  - "[[logica_combinatoria_teoria]]"
  - "[[logica_secuencial_guia]]"
  - "[[hdl_system_verilog]]"
  - "[[parciales_analizados/1P_1C_2025]]"
  - "[[parciales_analizados/1P_2C_2024]]"
  - "[[parciales_analizados/1P_2C_2024_recuperatorio]]"
---

# Logica Secuencial — Teoria

Fuente: `raw/clases_teoricas/3.teo_logica_secuencial.pdf` (83 pags, Beamer 1C 2025)

---

## Concepto y definicion

Los **circuitos secuenciales** extienden los combinatorios incorporando **retroalimentacion**: la salida depende no solo de las entradas actuales sino tambien del **estado previo** (memoria). Esto permite almacenar informacion en el tiempo.

Clasificacion:
- **Asincronicos**: cambian de estado en cualquier momento segun el nivel de las entradas.
- **Sincronicos**: cambian de estado solo en flancos del clock. **Los usados en la practica son sincronicos.**

Problema de los asincronicos: los tiempos de propagacion son impredecibles y pueden causar **carreras** (glitches) si existe un lazo en el circuito externo.

---

## Latches

Los latches son **sensibles al nivel** de sus entradas de control (no al flanco). Almacenan estado mientras la entrada de control esta activa.

### Latch RS (Reset-Set) — implementado con NOR

| S | R | Q | $\overline{Q}$ |
|---|---|---|---|
| 1 | 0 | 1 | 0 |
| 0 | 1 | 0 | 1 |
| 0 | 0 | $Q^*$ | $\overline{Q^*}$ |
| 1 | 1 | **inconsistente** | **inconsistente** |

- $Q^*$ = estado anterior (memoria).
- **S=1,R=1:** estado no valido — las salidas son inconsistentes con la especificacion y dependen de la implementacion fisica (carrera). Tarea: implementar con NANDs (en NAND el estado prohibido es S=0,R=0).

### Latch JK

Corrige el caso S=1,R=1 del RS:

| J | K | Q | $\overline{Q}$ |
|---|---|---|---|
| 1 | 0 | 1 | 0 |
| 0 | 1 | 0 | 1 |
| 0 | 0 | $Q^*$ | $\overline{Q^*}$ |
| 1 | 1 | $\overline{Q^*}$ | $Q^*$ |

- J=1,K=1: la salida esta ahora **definida** (niega el estado anterior).
- **Problema:** el circuito **oscila** (estado inestable) porque la realimentacion conmuta inmediatamente.

### Latch D

- Entradas: D (dato) y C (control/enable).
- Almacena 1 bit.

| D | C | Q |
|---|---|---|
| x | 0 | $Q^*$ |
| 0 | 1 | 0 |
| 1 | 1 | 1 |

- Cuando C=1: Q sigue a D transparentemente.
- Cuando C=0: Q mantiene el ultimo valor (latch).
- **Problemas:** los tiempos dependen de D (impredecibles) y puede causar carreras en lazos externos.

---

## Sincronizacion con Clock

Para controlar los momentos de transicion de estado se usa un **clock** (señal periodica). La solucion a los problemas del latch D es ser **sensible al flanco** en lugar del nivel.

### Detector de flanco

Circuito combinatorio que produce un pulso estrecho en el flanco ascendente de clock, aprovechando los tiempos de propagacion de la señal.

---

## Flip-Flops

Los flip-flops son **sensibles al flanco** del clock. El estado solo puede cambiar en el instante del flanco (tipicamente ascendente $\uparrow$).

Notacion: $T$ = instante actual, $T+1$ = siguiente ciclo de clock ($T_{clock}$ es el periodo; $T = n \cdot T_{clock}$).

### Flip-Flop D (Delay / D-type)

| D | clk | $Q^{T+1}$ |
|---|-----|-----------|
| x | 0 | $Q^T$ |
| 0 | $1\uparrow$ | 0 |
| 1 | $1\uparrow$ | 1 |

- En el flanco ascendente: $Q^{T+1} = D$.
- Fuera del flanco: $Q^{T+1} = Q^T$ (mantiene).
- **Simbolo:** cuadro con entradas D y clk, salida Q y $\overline{Q}$ (triangulo en la entrada de clock indica sensibilidad al flanco).

### Flip-Flop JK (con deteccion de flanco)

| J | K | clk | $Q^{T+1}$ |
|---|---|-----|-----------|
| 1 | 0 | $1\uparrow$ | 1 (Set) |
| 0 | 1 | $1\uparrow$ | 0 (Reset) |
| 0 | 0 | $1\uparrow$ | $Q^T$ (Hold) |
| 1 | 1 | $1\uparrow$ | $\overline{Q^T}$ (Toggle) |
| x | x | 0 | $Q^T$ |

- J=1,K=1: niega el valor anterior **cada ciclo de clock** (toggle). Estado y tiempo bien definidos — el flanco elimina la oscilacion del latch JK.

---

## Registros

### FF-D como celda de 1 bit

Un FF-D almacena 1 bit, pero **solo durante 1 ciclo de clock**: en cada flanco actualiza su salida con D. Para mantener el valor durante multiples ciclos se agrega una señal de control **WriteEnable (WE)**:

$$D_{entrada} = \begin{cases} D_{externo} & \text{si WE=1} \\ Q_{actual} & \text{si WE=0} \end{cases}$$

Implementacion: MUX 2:1 con selector WE en la entrada del FF-D. Si WE=0 realimenta Q para mantener el valor.

### Registro de N bits

N FF-D con enable en paralelo, compartiendo clock y WE. Señales de control: `clk`, `reset`, `WriteEnable`.

### Componentes de Tres Estados (Tristate)

| B (enable) | C (salida) |
|------------|------------|
| 0 | Hi-Z |
| 1 | A |

- **Hi-Z** = alta impedancia: el pin de salida queda electricamente desconectado del circuito.
- **Uso:** conectar multiples componentes a un **bus compartido**. Solo un componente tiene su tristate activo (B=1) a la vez.
- **Restriccion:** usar tristate solo en la **salida** de componentes, nunca en entradas.

---

## Memorias (intro)

Conceptualmente: $M$ posiciones de almacenamiento de $N$ bits cada una.  
Para acceder a una posicion se necesita una **direccion** (address), tipicamente codificada con $\lceil \log_2 M \rceil$ bits.

La implementacion usa un decodificador de direcciones + arreglo de registros.

---

## Formulas clave

$$Q^{T+1}_{FF-D} = D \quad (\text{en flanco de clock})$$

$$Q^{T+1}_{FF-JK} = J \cdot \overline{Q^T} + \overline{K} \cdot Q^T$$

$$D_{registro} = WE \cdot D_{externo} + \overline{WE} \cdot Q \quad \text{(con MUX)}$$

---

## Ejercicios de clase

### Ejercicio 0 — Registro 3-bit

a) Registro basico con señales `clk`, `reset`, `WriteEnable` y 3 entradas $e_0, e_1, e_2$ + 3 salidas $s_0, s_1, s_2$.

b) Agregar tristate en salidas: solo muestra el dato cuando `EnableOut=1`.

c) Unificar entradas y salidas en 3 pines bidireccionales (entrada-salida simultanea mediante tristate).

### Ejercicio 1 — Bus de N registros

a) Interconexion de $n$ registros del tipo diseñado en Ej0 sobre un bus compartido.

Señales de control: `WriteEnable-i`, `reset-i`, `EnableOut-i` para cada registro $R_i$.

b) Secuencia para copiar $R_1 \to R_0$:
1. `EnableOut-1 ← 1` (R1 pone su dato en el bus)
2. `WriteEnable-0 ← 1` (R0 esta listo para recibir)
3. ...flanco de clock... (R0 captura el dato del bus)
4. `WriteEnable-0 ← 0`
5. `EnableOut-1 ← 0`

> **Regla:** solo un registro debe tener `EnableOut=1` en cada instante para evitar cortocircuito en el bus.

---

---

## Maquinas de Estado Finitas (FSM)

> Fuente adicional: `raw/contenido_comunidad/resumen_sistemas_digitales.pdf`

Los circuitos secuenciales pueden modelarse formalmente como **Maquinas de Estados Finitas (FSM)**. Una FSM queda definida por:

1. Una lista de **estados** (cada estado representa una configuracion del circuito).
2. Un **estado inicial**.
3. Una lista de **funciones de transicion** que dictan como se pasa de un estado a otro en funcion de las entradas.

### Diagramas de estado

Representan graficamente el comportamiento del circuito: nodos = estados, aristas etiquetadas con la condicion de transicion (entrada) y/o la salida.

### FSM Moore

- La **salida depende unicamente del estado actual** (no de las entradas).
- La salida cambia **un ciclo de clock despues** de que se dispara la condicion de transicion.
- **No produce glitches** a la salida.
- Suele requerir **mas estados** que una FSM Mealy para el mismo comportamiento.

### FSM Mealy

- La **salida depende del estado actual Y de las entradas**.
- La salida puede cambiar **dentro del mismo ciclo** en que se dispara la condicion de transicion.
- **Produce glitches** a la salida.
- Requiere **menos estados** que Moore para el mismo comportamiento.

### Logica de proximo estado

Dado el estado actual y las entradas, se calculan los valores $D_1, D_0$ (entradas a los FF-D) que produciran el estado siguiente $Q_1(t+1), Q_0(t+1)$:

$$Q(t+1) = D \quad \text{(funcion del estado actual y de las entradas)}$$

Se implementa como un circuito combinatorio que recibe el estado actual y las entradas, y produce las entradas de los flip-flops.

### Logica de salida

- **Moore:** salida = $f(\text{estado actual})$ — circuito combinatorio con solo el estado como entrada.
- **Mealy:** salida = $f(\text{estado actual, entradas})$ — circuito combinatorio con estado + entradas.

### Codificacion de estados

Cada estado se asigna a una combinacion binaria de los FF de estado. Ej: con 2 FF se tienen 4 estados posibles (00, 01, 10, 11). La codificacion impacta en la complejidad de la logica de proximo estado y de salida.

---

## Ver tambien

- [[logica_combinatoria_teoria]] — MUX, compuertas, SDP (circuitos combinatorios base)
- [[hdl_system_verilog]] — descripcion de circuitos secuenciales en System Verilog (always_ff, reset)
- [[parciales_analizados/1P_1C_2025]] — Ej3: registro desplazamiento circular con FF-D
- [[parciales_analizados/1P_2C_2024]] — Ej4: registro bidireccional con tristate
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Ej4: registro desplazamiento bidireccional MUX+FF-D
