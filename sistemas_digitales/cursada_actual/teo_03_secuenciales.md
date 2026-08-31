---
nombre: Circuitos secuenciales — explicación para comprender la clase
tipo: material_de_estudio
origen: "@raw/cursada_2C_2026/teo/teo-03-secuenciales.pdf"
tipo_documento: teorica
temas: [logica_secuencial, diseno_modular]
parcial: 1P
programa: 2C_2026
generado: 2026-08-30
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 14
ingestado: false
---

# Circuitos secuenciales — explicación para comprender la clase

La clase explica cómo un circuito puede recordar información, por qué la realimentación sola no alcanza para construir sistemas previsibles y cómo el clock organiza los cambios de estado. Desde ahí construye flip-flops, registros, buses compartidos, un register file y la idea inicial de memoria.

**Fuente:** `raw/cursada_2C_2026/teo/teo-03-secuenciales.pdf` · **Temas:** `logica_secuencial`, `diseno_modular` → **1P, parcial único** (programa `2C_2026`)
**Cómo leer esto:** 🔴 = dominar en profundidad · 🟡 = entender · ⚪ = contexto

> **Alcance:** aunque fue declarado correctamente como material de teoría, el PDF también contiene dos ejercicios de diseño resueltos. Se los usa para explicar los conceptos, sin convertir esta nota en una práctica. La clase no desarrolla FSM, pese a que estas forman la unidad 4 del programa vigente.

## El problema que organiza la clase

Un circuito combinatorio olvida inmediatamente: su salida queda determinada por las entradas presentes. Para almacenar un bit hace falta que la salida anterior influya sobre la salida futura, es decir, **realimentación**. Pero un lazo real tiene retardos y puede oscilar, entrar en carrera o quedar temporalmente indefinido.

La clase resuelve el problema en capas:

1. la realimentación produce memoria;
2. los latches permiten controlar esa memoria, pero siguen siendo sensibles a niveles;
3. los flip-flops restringen el cambio a un flanco de clock;
4. varios flip-flops forman registros;
5. los registros se interconectan mediante buses y buffers tristate;
6. muchos registros direccionables forman un register file y anticipan la memoria.

## Mapa conceptual

- Realimentación conduce a biestabilidad y memoria.
- El biestable se vuelve controlable mediante latches SR, JK y D.
- La sensibilidad a nivel deja carreras y tiempos difíciles de predecir.
- El clock y la sensibilidad a flanco motivan los flip-flops.
- Los requisitos temporales alrededor del flanco explican la metaestabilidad.
- Un segundo flip-flop da más tiempo de resolución a una entrada asíncrona.
- Un flip-flop D almacena un bit; $N$ flip-flops forman un registro de $N$ bits.
- El tristate permite que varios registros compartan un bus sin conducirlo simultáneamente.
- La selección de registros conduce al register file; direccionar muchas palabras conduce a la memoria.

## Conocimientos previos necesarios

- **Circuito combinatorio** — su salida es una función de las entradas actuales y no conserva estado.
- **Retardo de propagación** — una salida física no cambia instantáneamente después de cambiar una entrada.
- **Compuertas NOR y NAND** — permiten construir los latches básicos mediante realimentación cruzada.
- **Multiplexor** — selecciona una entrada según una señal de control; permite elegir entre cargar un dato o conservar el anterior.
- **Bus** — conjunto de líneas compartidas que transporta una palabra de varios bits.

---

## 🟡 1. Realimentación, biestabilidad y latches — diapositivas 8–51

### La idea intuitiva

Realimentar significa devolver una salida hacia una entrada. Entonces el circuito no responde únicamente a lo que recibe ahora: también queda condicionado por lo que produjo antes. Un lazo con dos configuraciones estables puede conservar un bit y se llama **biestable**.

### Qué problema resuelve

La realimentación introduce memoria. El problema siguiente es poder elegir de manera controlada qué valor recordar, mantener o borrar.

### Definición precisa

Un **latch** es un elemento de almacenamiento sensible al **nivel** de una señal de habilitación: mientras está habilitado puede reaccionar a sus entradas; cuando deja de estarlo conserva el último estado.

Para un latch SR construido con NOR:

| $S$ | $R$ | $Q^+$ | Significado |
|---:|---:|---:|---|
| 0 | 0 | $Q$ | conservar |
| 1 | 0 | 1 | set |
| 0 | 1 | 0 | reset |
| 1 | 1 | indefinido | combinación prohibida |

En la versión construida con NAND, las entradas son activas en bajo: se conserva con $(S,R)=(1,1)$ y la combinación prohibida es $(0,0)$.

El latch JK reemplaza el caso prohibido por toggle:

| $J$ | $K$ | $Q^+$ |
|---:|---:|---:|
| 0 | 0 | $Q$ |
| 1 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 1 | $\overline{Q}$ |

El latch D reduce las entradas a dato y enable:

$$Q^+=\begin{cases}
Q & E=0,\\
D & E=1.
\end{cases}$$

### Cómo funciona

En un latch SR, cada compuerta observa la salida de la otra. Un pulso de set fuerza una configuración estable y uno de reset fuerza la opuesta. Al retirar ambas órdenes, la realimentación sostiene el valor alcanzado.

Agregar enable no convierte al latch en sensible a flanco: mientras $E=1$, sigue siendo **transparente**. Por eso un cambio de $D$ durante todo ese intervalo puede propagarse a $Q$.

### Ejemplo mínimo

Si un latch D tiene $E=1$, un cambio $D:0\to1$ hace que $Q$ pase a 1 después del retardo físico. Si luego $E$ pasa a 0, $Q$ conserva 1 aunque $D$ vuelva a 0.

### Por qué funciona

La configuración almacenada se refuerza a sí misma mediante la realimentación. Las entradas de control rompen temporalmente ese equilibrio para llevar el circuito al estado deseado.

### Qué información conserva y cuál pierde

Conserva un bit: cuál de las dos configuraciones estables quedó seleccionada. No conserva la historia completa de cambios que llevaron hasta allí.

### Relación con otros conceptos

- **Se diferencia de:** un circuito combinatorio, que no tiene estado.
- **Necesita:** realimentación y retardos físicos no nulos.
- **Da lugar a:** flip-flops sensibles a flanco.
- **Se diferencia de:** un flip-flop, porque el latch responde durante un nivel completo del enable.

### Límites y contraejemplos

- En el SR-NOR, $S=R=1$ no representa un estado lógico válido.
- En el latch JK, $J=K=1$ define toggle, pero mientras el enable permanece activo la realimentación puede producir oscilación.
- Un latch D dentro de un lazo externo puede generar carreras porque permanece transparente durante el nivel activo.

### Confusiones frecuentes

- **“Realimentación implica siempre memoria útil.”** No: también puede producir oscilación o un estado no controlable.
- **“Enable es un flanco.”** No: el latch responde mientras el nivel está activo.
- **“$Q$ y $\overline Q$ siempre son complementarias.”** No durante una condición inválida o metaestable.

### Explicación para nene de 5

Imaginá una puerta que puede quedar trabada abierta o cerrada. Dos botones permiten empujarla hacia una de esas posiciones; cuando soltás los botones, el propio mecanismo la mantiene donde quedó. La puerta es el bit $Q$, los botones son las entradas de control y la traba que se sostiene sola es la realimentación.

---

## 🟡 2. Clock, flip-flops, enable y reset — diapositivas 52–78

### La idea intuitiva

En vez de permitir que cada parte cambie cuando quiera, el sistema usa un metrónomo. Todos los elementos de estado observan sus entradas y actualizan sus salidas en un instante acordado: el flanco del clock.

### Qué problema resuelve

El clock limita cuándo puede cambiar el estado. Esto vuelve predecible la evolución del circuito y evita que un dato atraviese múltiples etapas transparentes durante un mismo nivel.

### Definición precisa

El período $T_{clk}$ es la duración de un ciclo y la frecuencia es la cantidad de ciclos por unidad de tiempo:

$$f=\frac{1}{T_{clk}}.$$

Un **flip-flop D** sensible al flanco ascendente cumple:

$$Q^{t+1}=D \qquad \text{en } \uparrow clk,$$

mientras que fuera del flanco conserva $Q^t$.

Un **flip-flop JK** cumple, en el flanco activo:

$$Q^{t+1}=J\overline{Q^t}+\overline KQ^t.$$

Por lo tanto, $(J,K)=(1,1)$ niega el estado anterior una sola vez por ciclo, en lugar de oscilar continuamente.

Un FF-D con write enable puede describirse como:

$$D_{FF}=wren\cdot D_{ext}+\overline{wren}\cdot Q.$$

Un reset **asíncrono** actúa sin esperar al clock; un reset **síncrono** solo se aplica en el flanco activo.

### Cómo funciona

El flip-flop separa conceptualmente dos momentos: antes del flanco hay un estado actual estable; en el flanco se captura la entrada; después aparece el estado siguiente. Todos los flip-flops que comparten clock calculan sus nuevas salidas a partir de los valores anteriores, no de una mezcla de actualizaciones parciales.

El enable no detiene el clock. Selecciona qué llega a $D$: el dato externo para cargar o la propia salida $Q$ para mantener.

### Ejemplo mínimo

Supongamos $Q=0$. Si $D$ cambia varias veces pero vale 1 justo en el flanco ascendente y respeta la ventana temporal requerida, después del flanco $Q=1$. Los cambios de $D$ fuera del flanco no modifican inmediatamente $Q$.

### Por qué funciona

La sensibilidad a flanco reduce el intervalo de captura a un evento temporal definido. La realimentación mediante el MUX implementa hold sin alterar la red de clock.

### Qué información conserva y cuál pierde

Conserva el valor muestreado en el último flanco válido. Ignora los valores de $D$ que no fueron capturados.

### Relación con otros conceptos

- **Generaliza a:** registros, contadores y máquinas de estados.
- **Se diferencia de:** el latch, sensible a nivel.
- **Necesita:** clock y cumplimiento de restricciones temporales.
- **Da lugar a:** tablas de próximo estado calculadas ciclo a ciclo.

### Límites y contraejemplos

Un flip-flop no vuelve mágicamente síncrona a una entrada externa. Si la entrada cambia demasiado cerca del flanco, puede violar las restricciones temporales y entrar en metaestabilidad.

### Confusiones frecuentes

- **“El FF-D mantiene para siempre sin lógica adicional.”** Captura $D$ en cada flanco; para conservar a través de nuevos flancos necesita seleccionar nuevamente $Q$.
- **“Reset síncrono y asíncrono son equivalentes.”** El primero espera al flanco; el segundo no.
- **“Todos los valores cambian secuencialmente dentro del flanco.”** Los FF comparten el estado anterior y actualizan de manera simultánea desde el punto de vista lógico.

### Explicación para nene de 5

Es como sacar una foto cada vez que suena una campana. La foto guarda lo que había justo en ese momento, aunque las cosas se muevan entre campanadas. La campana es el clock, lo fotografiado es $D$ y la foto guardada es $Q$.

---

## 🟡 3. Metaestabilidad y sincronizadores — diapositivas 79–95

### La idea intuitiva

Un flip-flop necesita que su entrada se quede quieta alrededor del flanco. Si el dato cambia justo cuando se toma la “foto”, el circuito puede tardar un tiempo impredecible en decidir si guardó 0 o 1.

### Qué problema resuelve

Esta unidad explica por qué una entrada asíncrona no debe conectarse sin cuidado al estado de un sistema síncrono y cómo una segunda etapa reduce la probabilidad de que la indecisión se propague.

### Definición precisa

Una **violación de tiempo** ocurre cuando la entrada cambia dentro de la ventana en la que debía permanecer estable alrededor del flanco. La salida puede entrar en un estado metaestable y recién alcanzar luego un 0 o 1 válido tras un tiempo de resolución $T_r$ aleatorio.

La clase compara:

- sincronizador simple con lógica combinatoria:

$$T_r=T_{clk}-(T_{comb}+T_{setup});$$

- sincronizador doble:

$$T_r=T_{clk}-T_{setup}.$$

El segundo elimina $T_{comb}$ del margen entre la primera y la segunda captura, por lo que normalmente deja más tiempo para resolver la metaestabilidad.

### Cómo funciona

El primer flip-flop puede quedar metaestable al muestrear la entrada asíncrona. El segundo no elimina ese evento: espera hasta el próximo flanco y muestrea la salida del primero después de casi un ciclo completo de resolución. Cuanto mayor sea el margen, menor es la probabilidad de que el estado indefinido alcance la lógica posterior y mayor es el MTBF (*Mean Time Between Failures*).

### Ejemplo mínimo

Una señal de botón cambia sin relación con el clock. Si se conecta directamente a la lógica, puede ser capturada durante la ventana crítica. Al pasarla por dos FF-D en serie, la primera etapa absorbe el riesgo y la segunda entrega una versión sincronizada un ciclo más tarde.

### Por qué funciona

La metaestabilidad no se “cura” de forma determinista; se reduce su probabilidad de propagación dando más tiempo físico para que la primera etapa alcance un nivel válido.

### Qué información conserva y cuál pierde

Conserva el nivel lógico finalmente resuelto. Introduce latencia y no preserva el instante exacto, dentro del ciclo, en que cambió la entrada asíncrona.

### Relación con otros conceptos

- **Necesita:** flip-flops y restricciones temporales.
- **Se diferencia de:** un filtro lógico; el sincronizador trata un problema temporal.
- **Da lugar a:** interfaces seguras entre señales asíncronas y lógica síncrona.

### Límites y contraejemplos

- Dos flip-flops reducen el riesgo, no lo llevan matemáticamente a cero.
- La fórmula del margen supone la organización temporal mostrada en la clase; no reemplaza el análisis completo de timing de un diseño real.
- Sin margen de resolución, la clase modela $T_r=0$ y un MTBF bajo.

### Confusiones frecuentes

- **“Metaestable significa que el FF queda indefinido para siempre.”** Eventualmente se estabiliza, pero el tiempo es impredecible.
- **“El segundo FF impide que el primero sea metaestable.”** No; evita, con alta probabilidad, que el problema se propague.
- **“Es solo un error de simulación.”** Es un fenómeno físico asociado a restricciones temporales.

### Explicación para nene de 5

Si le preguntás a alguien “¿rojo o azul?” justo mientras cambia de opinión, puede tardar en responder. Si otra persona espera un momento y recién después repite la respuesta, es mucho menos probable que escuche la duda. La primera persona es el primer flip-flop, la espera es $T_r$ y la segunda persona es el segundo flip-flop.

---

## 🟡 4. Registros de $N$ bits y salidas tristate — diapositivas 96–105

### La idea intuitiva

Un flip-flop guarda un bit. Para guardar una palabra se colocan $N$ flip-flops en paralelo, todos bajo las mismas señales de clock, reset y escritura. Para compartir las líneas con otros componentes, la salida debe poder desconectarse eléctricamente.

### Qué problema resuelve

El registro almacena palabras completas. El buffer de tres estados permite que el registro use un medio compartido sin imponer siempre sus 0 y 1 sobre él.

### Definición precisa

Un registro de $N$ bits contiene $N$ celdas de estado. Para cada bit:

$$Q_i^{t+1}=\begin{cases}
0 & reset\text{ activo},\\
D_i & wren=1\text{ en el flanco},\\
Q_i^t & wren=0\text{ en el flanco}.
\end{cases}$$

Un buffer tristate cumple:

$$C=\begin{cases}
A & en=1,\\
Hi\text{-}Z & en=0.
\end{cases}$$

$Hi$-$Z$ no es un tercer valor de dato: modela una resistencia muy alta, equivalente a considerar desconectado el pin de salida.

### Cómo funciona

Los $N$ FF-D capturan simultáneamente una palabra cuando `wren=1`. Agregar un tristate por bit produce `RegNbHiZ`: el registro solo conduce sus salidas cuando `en=1`. Al unir físicamente cada $D_i$ con su $Q_i$ controlada por tristate se obtiene `RegNbIO`, con líneas bidireccionales.

### Ejemplo mínimo

Para un registro de 4 bits que contiene `1010`:

- `en=1`: el bus observa `1010`;
- `en=0`: el registro queda en $Hi$-$Z$ y otro dispositivo puede conducir el bus;
- `wren=1` en el flanco: se captura la palabra que esté siendo conducida externamente.

### Por qué funciona

El paralelismo conserva todos los bits bajo el mismo límite de ciclo. El tristate desacopla eléctricamente la salida cuando el registro no es la fuente seleccionada.

### Qué información conserva y cuál pierde

Conserva la última palabra capturada. El bus no conserva datos por sí mismo: cuando nadie lo conduce queda flotante, y cuando dos fuentes incompatibles lo conducen hay contención.

### Relación con otros conceptos

- **Generaliza a:** registros bidireccionales, bancos de registros y memorias.
- **Necesita:** FF-D con enable.
- **Se diferencia de:** un MUX; ambos seleccionan fuentes, pero el tristate permite desconectar físicamente una salida de un bus compartido.
- **Da lugar a:** diseño modular de una celda y réplica $N$ veces.

### Límites y contraejemplos

- El tristate debe colocarse en salidas, no en entradas.
- En un bus compartido solo una fuente puede tener `en=1` a la vez.
- Activar lectura y escritura sobre las mismas líneas sin respetar el protocolo puede causar contención.

### Confusiones frecuentes

- **“$Hi$-$Z$ es 0.”** No: significa que el componente no conduce la línea.
- **“Bidireccional significa desplazar a izquierda y derecha.”** Aquí significa usar el mismo pin para entrada y salida; un registro de desplazamiento es otro circuito.
- **“El tristate almacena.”** No; el estado está en los FF-D.

### Explicación para nene de 5

Varios chicos comparten un micrófono. El que tiene permiso habla y los demás sueltan el botón; soltarlo no equivale a decir “cero”, sino a no hablar. Cada chico es un registro, el micrófono es el bus y el botón es `en`.

---

## 🟡 5. Interconexión de registros y protocolo de copia — diapositivas 106–110

### La idea intuitiva

Compartir cables exige coordinación: primero una única fuente coloca el dato en el bus; luego el destino habilita la escritura; finalmente un flanco captura el dato.

### Qué problema resuelve

Permite mover palabras entre $M$ registros sin conectar cada par mediante un conjunto independiente de cables.

### Definición precisa

Para copiar $R_1\to R_0$, partiendo de señales inactivas, la clase da esta secuencia:

1. `en1 ← 1`;
2. `wren0 ← 1`;
3. ocurre el flanco de `clk`;
4. `wren0 ← 0`;
5. `en1 ← 0`.

Durante toda la transferencia debe mantenerse el invariante:

$$\sum_{i=0}^{M-1} en_i\le 1.$$

### Cómo funciona

`en1` convierte a $R_1$ en la única fuente del bus. `wren0` hace que la entrada de $R_0$ tome ese bus. El dato queda efectivamente almacenado recién en el flanco. Desactivar después las señales devuelve al sistema al estado inactivo.

### Ejemplo mínimo

Si $R_1=0110$ y $R_0=0000$, activar `en1` hace visible `0110` en el bus. Con `wren0=1`, el próximo flanco produce $R_0=0110$. El contenido de $R_1$ no cambia.

### Por qué funciona

La separación entre conducción combinatoria y captura secuencial permite estabilizar el dato antes del flanco. El destino conserva la copia después de que la fuente libera el bus.

### Qué información conserva y cuál pierde

La copia conserva el contenido de la fuente y reemplaza el contenido previo del destino. El bus solo transporta el valor durante la operación.

### Relación con otros conceptos

- **Necesita:** registros bidireccionales y tristate.
- **Generaliza a:** transferencias controladas dentro de un datapath.
- **Da lugar a:** selección direccionada en un register file.

### Límites y contraejemplos

Si `en0=en1=1`, dos salidas conducen el mismo medio; si difieren en algún bit aparece contención. Si `wren0` no está activo en el flanco, el bus puede tener el valor correcto sin que $R_0$ lo almacene.

### Confusiones frecuentes

- **“Activar `wren` copia inmediatamente.”** La captura ocurre en el flanco.
- **“Pueden leer varios registros porque leer no modifica.”** En un único bus tristate no pueden conducirlo simultáneamente.

### Explicación para nene de 5

Un chico dice una palabra por el micrófono y otro prende su grabador. La palabra solo queda guardada cuando suena la campana. Hablar es `en1`, preparar el grabador es `wren0` y la campana es el flanco de clock.

---

## 🟡 6. Register file y memoria — diapositivas 111–116

### La idea intuitiva

En vez de tener una señal de enable y otra de escritura para cada registro, se usa un índice para elegir cuál leer o escribir. Esa colección direccionable es un **register file**. Si se escala la misma idea a muchas posiciones de $N$ bits, aparece la memoria.

### Qué problema resuelve

Reduce el costo de control al seleccionar registros mediante direcciones. Permite acceder a una palabra entre muchas sin exponer individualmente todas sus señales.

### Definición precisa

El ejemplo SystemVerilog define:

$$NUM\_REGS=2^{ADDR\_WIDTH}.$$

Cada entrada del arreglo `rf` contiene `DATA_WIDTH` bits. Hay dos puertos A y B con índice, dato de entrada, dato de salida y write enable. Las lecturas son síncronas y **read-first**: en el flanco se obtiene el contenido previo a cualquier escritura del mismo ciclo. El índice cero se lee como cero y sus escrituras se descartan.

Conceptualmente, una memoria tiene $M$ posiciones de $N$ bits. Para identificar $M$ posiciones hacen falta:

$$\left\lceil\log_2 M\right\rceil$$

bits de dirección.

### Cómo funciona

El índice selecciona una posición. En el ejemplo, un `always_ff` actualiza las salidas A y B en el flanco; otro bloque realiza escrituras cuando el enable correspondiente está activo. La organización read-first fija qué versión del dato se observa cuando lectura y escritura coinciden.

En la memoria conceptual, un decodificador selecciona la posición escrita y un MUX selecciona la posición leída.

### Ejemplo mínimo

Con `ADDR_WIDTH=5` hay $2^5=32$ registros. Si el puerto A usa índice 3, su lectura devuelve `rf[3]` en el flanco. Si usa índice 0, devuelve cero independientemente del arreglo interno.

### Por qué funciona

La dirección codifica en pocos bits cuál de muchas celdas participa. El decodificador expande esa selección para escritura y el MUX concentra muchas posibles fuentes en una salida.

### Qué información conserva y cuál pierde

Conserva una palabra por posición. La interfaz oculta la implementación física: el usuario observa índices, datos y enables, no cada FF interno.

### Relación con otros conceptos

- **Generaliza a:** memorias de $M\times N$ bits.
- **Necesita:** registros, MUX y decodificadores.
- **Se diferencia de:** un registro aislado, porque requiere dirección.
- **Da lugar a:** el register file arquitectural de RISC-V.

### Límites y contraejemplos

- La lectura del ejemplo es síncrona; no debe suponerse que todos los register files tienen idéntica temporización.
- El reset mostrado pone en cero las salidas registradas, no recorre el arreglo para borrar todas sus posiciones.
- El código define dos puertos de escritura; el PDF no especifica como contrato pedagógico qué debería ocurrir si ambos escriben simultáneamente la misma posición. ⚠️ Verificar esa política antes de reutilizar el módulo.

### Confusiones frecuentes

- **“$ADDR\_WIDTH$ es la cantidad de registros.”** Es la cantidad de bits del índice; la cantidad es $2^{ADDR\_WIDTH}$.
- **“Resetear las salidas borra el banco.”** No en el código mostrado.
- **“Register file y memoria son idénticos.”** Comparten la idea de almacenamiento direccionable, pero su interfaz, cantidad de puertos y temporización pueden diferir.

### Explicación para nene de 5

Es un mueble con cajones numerados. En vez de tener un botón distinto para cada cajón, decís un número y elegís cuál abrir o en cuál guardar algo. El número es la dirección, cada cajón es un registro y el mueble completo es el register file.

---

## Síntesis de la clase

### El hilo completo en pocas palabras

La realimentación permite recordar, pero sin control temporal puede oscilar o correr. Los latches controlan el dato aunque siguen abiertos durante un nivel. Los flip-flops capturan en un flanco y hacen posible razonar por ciclos. Sus restricciones temporales explican la metaestabilidad y el uso de sincronizadores. Al replicarlos aparecen registros; con tristates se comparte un bus; con índices aparece el register file y, por extensión, la memoria.

### Definiciones que hay que poder reconstruir

- Circuito secuencial: salida dependiente de entradas actuales y estado previo.
- Latch: almacenamiento sensible a nivel.
- Flip-flop: almacenamiento sensible a flanco.
- Metaestabilidad: estado físico temporalmente indefinido tras una violación de tiempo.
- Registro de $N$ bits: $N$ celdas de estado en paralelo bajo control común.
- $Hi$-$Z$: salida eléctricamente desconectada, no valor lógico cero.
- Register file: conjunto direccionable de registros con puertos de lectura/escritura.

### Relaciones que hay que entender

- Realimentación → memoria, pero también riesgo de oscilación.
- Latch transparente → necesidad de captura por flanco.
- Flanco + ventana temporal → posibilidad de metaestabilidad.
- Más tiempo de resolución → menor probabilidad de falla.
- FF-D + MUX de realimentación → registro con write enable.
- Registro + tristate → componente conectable a bus compartido.
- Índice + arreglo de registros → register file.

### Puente hacia la práctica

- La semántica simultánea de los FF-D permite obtener funciones de próximo estado y seguir circuitos ciclo a ciclo.
- La composición modular de registros y tristates se transforma en diseños de buses y registros bidireccionales.
- El MUX delante de un FF permite elegir entre conservar, cargar o transformar el estado; esa idea se reutiliza en registros de desplazamiento.
- El protocolo `fuente habilitada → destino preparado → flanco` se reutiliza en transferencias entre registros.
- El register file conecta esta clase con la arquitectura y la microarquitectura de RISC-V.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Realimentación y latches | 🟡 | Sin aparición directa; contenido vigente y prerrequisito de FF/registros | — |
| Clock y flip-flops | 🟡 | [[parciales_analizados/1P_1C_2025]] Ej 3, como base de análisis de estado | [[tipos_ejercicio/tabla_estados_flip_flop]] |
| Metaestabilidad y sincronizadores | 🟡 | Sin precedente histórico; escalado por provenir de la cursada vigente y estar dentro del timing de la unidad 3 | — |
| Registro con tristate y líneas bidireccionales | 🟡 | [[parciales_analizados/1P_2C_2024]] Ej 4 | [[tipos_ejercicio/registro_bidireccional_tristate]] |
| Interconexión y copia entre registros | 🟡 | Variante adyacente de [[parciales_analizados/1P_2C_2024]] Ej 4 | [[tipos_ejercicio/registro_bidireccional_tristate]] |
| Register file y memoria | 🟡 | Sin precedente histórico; contenido vigente de Diseño Modular II | — |

**Base de comparación:** 6 parciales analizados, 14 patrones en `tipos_ejercicio/`. Para `logica_secuencial` hay 3 patrones compilados; se abrieron únicamente los 3 parciales citados por esos patrones. No fue necesario degradar a parciales crudos. Como `programa.md` declara `esquema_evaluacion: parcial_unico`, se usaron como banco temático tanto los parciales históricos 1P como 2P, pero ninguno representa por sí solo el examen vigente completo.

No hay unidades 🔴: ningún patrón cubierto directamente por este PDF aparece en al menos dos parciales distintos. Los temas sin precedente se elevaron a 🟡 porque el PDF pertenece a `raw/cursada_2C_2026/` y el programa vigente es la autoridad.

## Lo que este documento NO cubre y igual toman

- [[tipos_ejercicio/registro_desplazamiento_mux]] — 2 apariciones: [[parciales_analizados/1P_2C_2024_recuperatorio]] Ej 4 y [[parciales_analizados/1P_1C_2025]] Ej 3. Material en [[temas/logica_secuencial_guia]].
- [[tipos_ejercicio/tabla_estados_flip_flop]] — 1 aparición: [[parciales_analizados/1P_1C_2025]] Ej 3. El PDF explica los FF, pero no enseña el procedimiento completo de tabla de estados. Material en [[temas/logica_secuencial_guia]].

Además, la unidad oficial 4 incluye FSM Moore y Mealy, ausentes de este PDF y sin un patrón compilado propio; están desarrolladas en [[temas/logica_secuencial_teoria]].
