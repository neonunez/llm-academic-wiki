---
nombre: Máquinas de estados finitos — explicación para comprender la clase
tipo: material_de_estudio
origen: "@raw/cursada_2C_2026/teo/teo-03b-secuenciales-FSM.pdf"
tipo_documento: teorica
temas: [logica_secuencial]
parcial: 1P
programa: 2C_2026
generado: 2026-09-07
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 14
ingestado: false
---

# Máquinas de estados finitos — explicación para comprender la clase

La clase presenta una forma sistemática de modelar circuitos secuenciales: separar el estado que se almacena, la lógica que calcula el próximo estado y la lógica que produce las salidas. A partir de ese modelo construye FSM de Moore y Mealy, las codifica con flip-flops y muestra una implementación en SystemVerilog y una variante microprogramada.

**Fuente:** `raw/cursada_2C_2026/teo/teo-03b-secuenciales-FSM.pdf` · **Tema:** `logica_secuencial` → **1P** (parcial único, programa `2C_2026`)
**Cómo leer esto:** 🔴 = dominar en profundidad · 🟡 = entender · ⚪ = contexto

> **Alcance:** este PDF es una clase teórica sobre FSM. Se explican sus tablas, diagramas, codificación y arquitectura; no se convierte cada ejemplo en una receta de resolución de examen.

## El problema que organiza la clase

Un circuito combinatorio calcula su salida a partir de las entradas actuales, pero no puede representar directamente una historia: no sabe si antes recibió un evento, cuánto tiempo lleva en una fase o qué paso de un protocolo está esperando. Un circuito secuencial agrega memoria, pero describir todos sus flip-flops y compuertas a la vez puede ocultar el comportamiento que se quiere diseñar.

La **máquina de estados finitos** resuelve esa dificultad separando dos niveles:

1. un conjunto finito de estados que resume la historia relevante;
2. funciones combinatorias que, a partir del estado actual y de las entradas, calculan el estado siguiente y las salidas.

El registro de estado actualiza el estado siguiente en el flanco de clock. De esta manera, el circuito puede reaccionar a secuencias sin necesitar conservar toda la historia, solo la parte necesaria para decidir qué ocurre después.

## Mapa conceptual

- Memoria y clock permiten distinguir estado actual de estado siguiente.
- El estado actual y las entradas alimentan la lógica de próximo estado.
- El registro de estado captura el próximo estado en el flanco de clock.
- El estado actual y, según el modelo, las entradas alimentan la lógica de salida.
- Si la salida depende solo del estado se obtiene Moore; si también depende de las entradas se obtiene Mealy.
- Las tablas y los diagramas describen el comportamiento abstracto antes de elegir flip-flops y compuertas.
- La codificación transforma nombres de estados en bits y permite sintetizar la lógica.
- Una tabla almacenada en memoria puede reemplazar la lógica combinatoria explícita: es una FSM microprogramada.

## Conocimientos previos necesarios

- **Circuito secuencial** — su comportamiento depende de entradas actuales y de un estado almacenado; no es solo una función instantánea de las entradas.
- **Flip-flop D** — en el flanco de clock captura su entrada: $Q(t+1)=D$. Es la celda que guarda cada bit del estado.
- **Lógica combinatoria** — calcula una función sin memoria. En una FSM se usa para calcular $D$, el próximo estado y las salidas.
- **Clock** — referencia temporal que hace que el cambio de estado ocurra de manera sincronizada.
- **Álgebra booleana** — permite obtener ecuaciones para los bits del estado siguiente y para las salidas a partir de tablas.

---

## 🟡 1. Modelo general de una FSM — diapositivas 5–14

### La idea intuitiva

Una FSM es como un pequeño sistema que recuerda únicamente “en qué situación se encuentra”. Según esa situación y lo que observa ahora, decide cuál será su próxima situación y qué debe mostrar hacia afuera.

### Qué problema resuelve

Permite describir el comportamiento temporal sin enumerar directamente todos los cables internos. Por ejemplo, un controlador de semáforos no necesita guardar toda la secuencia de sensores recibida: alcanza con saber si está en “A verde”, “A amarillo”, “B verde” o “B amarillo”.

### Definición precisa

Una FSM queda determinada por:

- un conjunto finito de estados;
- un conjunto finito de entradas y salidas;
- una función de transición de estados;
- una función de salida;
- un estado inicial.

Con un registro de estado de $N$ bits se pueden representar hasta $2^N$ combinaciones de estado. No todas tienen que usarse como estados válidos. Si se usan $k$ estados, la cantidad mínima de bits necesaria cumple $2^N\geq k$.

En forma de funciones:

$$S_{siguiente}=F(S_{actual},\ entradas)$$

El registro de estado realiza la actualización en el clock:

$$S_{actual}\leftarrow S_{siguiente}$$

La salida se expresa de una de estas formas:

$$salida=G(S_{actual}) \qquad \text{(Moore)}$$

$$salida=G(S_{actual},\ entradas) \qquad \text{(Mealy)}$$

### Cómo funciona

El circuito se divide conceptualmente en tres bloques:

1. **Lógica de próximo estado:** recibe el estado almacenado y las entradas. Produce los bits que se conectan a las entradas $D$ de los flip-flops.
2. **Registro de estado:** en el flanco de clock captura esos bits. El valor capturado se convierte en el nuevo estado actual.
3. **Lógica de salida:** traduce el estado —y, en Mealy, también las entradas— a las señales externas.

El orden temporal importa: una entrada puede cambiar la lógica combinatoria durante el ciclo, pero el estado almacenado solo cambia cuando llega el flanco correspondiente. El estado nuevo se usa como estado actual durante el ciclo siguiente.

### Ejemplo mínimo

Una FSM con dos estados $S_0$ y $S_1$, una entrada $x$ y un flip-flop de estado puede definirse así:

- desde $S_0$, si $x=0$ se queda en $S_0$ y si $x=1$ pasa a $S_1$;
- desde $S_1$, si $x=0$ vuelve a $S_0$ y si $x=1$ se queda en $S_1$.

La tabla de transición es:

| Estado actual | $x$ | Estado siguiente |
|---|---:|---|
| $S_0$ | 0 | $S_0$ |
| $S_0$ | 1 | $S_1$ |
| $S_1$ | 0 | $S_0$ |
| $S_1$ | 1 | $S_1$ |

La tabla no es todavía un circuito físico: es una descripción completa de qué debe suceder para cada combinación válida.

### Por qué funciona

La FSM no intenta almacenar todos los eventos pasados. Agrupa historias que, desde el punto de vista del comportamiento futuro, son equivalentes. Dos historias pueden llevar al mismo estado si a partir de ese punto la máquina responderá igual ante las entradas futuras.

### Qué información conserva y cuál pierde

Conserva la información necesaria para elegir la próxima transición y la salida. Descarta detalles de la historia que no cambian esa decisión. Por eso una FSM es adecuada cuando el comportamiento puede resumirse mediante un número finito de situaciones.

### Relación con otros conceptos

- **Necesita:** flip-flops o algún registro para almacenar el estado.
- **Se diferencia de:** un circuito combinatorio, porque el estado introduce memoria temporal.
- **Da lugar a:** FSM de Moore, FSM de Mealy y FSM microprogramadas.
- **Se implementa con:** lógica combinatoria más un registro de estado.

### Límites y contraejemplos

Una FSM no representa exactamente un sistema que necesite recordar una cantidad arbitraria de datos o un contador sin cota. Puede modelar un contador acotado —porque tiene un número finito de estados—, pero no un contador matemático ilimitado sin aumentar indefinidamente la cantidad de estados.

### Confusiones frecuentes

- **Estado no es salida:** el estado es memoria interna; la salida es lo que el circuito expone.
- **Estado siguiente no cambia instantáneamente:** se calcula durante el ciclo y se captura en el flanco.
- **$N$ bits no significa exactamente $2^N$ estados útiles:** significa como máximo $2^N$ codificaciones; puede haber combinaciones inválidas.

### Explicación para nene de 5

Imaginá un robot que puede estar en pocas habitaciones: “esperando”, “caminando” o “terminado”. Mira una señal y decide a qué habitación irá después. El papelito que dice en qué habitación está es el **registro de estado**; la regla para elegir la próxima habitación es $F$; lo que el robot prende afuera es la **salida**. El robot no recuerda todo el camino: guarda solo la habitación actual porque eso alcanza para decidir.

---

## 🟡 2. Diagramas, tablas y codificación de estados — diapositivas 15–34

### La idea intuitiva

El mismo comportamiento puede escribirse como dibujo, tabla o ecuaciones. Cada representación muestra una parte distinta: el diagrama ayuda a seguir el flujo, la tabla enumera los casos y la codificación prepara la implementación con bits.

### Qué problema resuelve

Los nombres $S_0$, $S_1$, etc. son cómodos para pensar, pero los flip-flops almacenan ceros y unos. Hay que pasar de una descripción abstracta a una implementación sin perder ninguna transición ni salida.

### Definición precisa

En un **diagrama de estados**, cada nodo representa un estado y cada flecha una transición. Las etiquetas indican las condiciones de entrada y, según la convención, también las salidas. En la clase se adopta que las salidas son 0 salvo que se explicite lo contrario.

Una **tabla de transición** enumera $S_{actual}$, entradas y $S_{siguiente}$. Una **tabla de salida** enumera el estado y sus salidas —en Moore— o las combinaciones estado-entrada —en Mealy—.

La **codificación de estados** asigna un vector binario a cada estado. Para cuatro estados, por ejemplo:

| Estado | $S_1S_0$ |
|---|---|
| $S_0$ | 00 |
| $S_1$ | 01 |
| $S_2$ | 10 |
| $S_3$ | 11 |

### Cómo funciona

El flujo conceptual es:

1. nombrar los estados según las situaciones que distinguen comportamientos futuros;
2. dibujar o tabular todas las transiciones para cada entrada relevante;
3. especificar el estado inicial;
4. elegir una codificación binaria;
5. traducir cada fila a los bits del estado siguiente;
6. obtener las funciones booleanas de esos bits y de las salidas.

La codificación no cambia la conducta abstracta, pero sí puede cambiar la complejidad de la lógica resultante. También hay que decidir qué hacer con codificaciones inválidas: la implementación de la clase usa una transición segura de retorno al estado inicial en el ejemplo del semáforo.

### Ejemplo mínimo: controlador de semáforo

El ejemplo de la clase usa cuatro estados:

| Estado | Luz A | Luz B | Significado |
|---|---|---|---|
| $S_0$ | verde | roja | tránsito en A |
| $S_1$ | amarilla | roja | transición desde A |
| $S_2$ | roja | verde | tránsito en B |
| $S_3$ | roja | amarilla | transición desde B |

Con sensores $T_A$ y $T_B$:

- en $S_0$, si $T_A=1$ permanece; si $T_A=0$ pasa a $S_1$;
- $S_1$ pasa siempre a $S_2$;
- en $S_2$, si $T_B=1$ permanece; si $T_B=0$ pasa a $S_3$;
- $S_3$ pasa siempre a $S_0$.

Con la codificación de la tabla, la clase obtiene:

$$S_1^*=S_1\oplus S_0$$

$$S_0^*=S_1\cdot S_0\cdot T_A+S_1\cdot S_0\cdot T_B$$

La notación $S_i^*$ representa el bit del estado siguiente, no una negación. La tabla de salida codifica verde, amarillo y rojo y luego permite obtener ecuaciones para cada bit de las luces.

### Por qué funciona

La tabla garantiza que cada combinación relevante tenga una respuesta definida. La codificación hace que el registro pueda conservar el estado y que la lógica combinatoria pueda calcular la siguiente fila de la tabla.

### Qué información conserva y cuál pierde

La codificación conserva la identidad de cada estado mediante bits. La elección concreta de 00, 01, etc. no conserva una “distancia” física entre estados: los valores binarios son etiquetas, no necesariamente una medida de cercanía o de orden.

### Relación con otros conceptos

- **Generaliza a:** tablas de estados usadas para analizar circuitos con flip-flops.
- **Necesita:** álgebra booleana y flip-flops D para pasar de tabla a circuito.
- **Da lugar a:** ecuaciones de próximo estado y ecuaciones de salida.
- **Se diferencia de:** una tabla de verdad puramente combinatoria porque incluye estado actual y estado siguiente.

### Límites y contraejemplos

Una mala elección de estados puede mezclar situaciones que requieren respuestas distintas. Una mala codificación o una tabla incompleta puede dejar estados inválidos sin comportamiento definido. El diagrama no elimina esos problemas: solo los hace visibles si se lo revisa contra la tabla.

### Confusiones frecuentes

- El estado $S_1$ no debe confundirse con el bit $S_1$ de una codificación de dos bits.
- Una flecha etiquetada con una entrada es una condición, no necesariamente una salida.
- La salida codificada en bits no es lo mismo que el nombre humano “verde” o “rojo”.

### Explicación para nene de 5

Es como un juego de cuatro casilleros. Cada casillero tiene un cartel de colores y una regla que dice a cuál casillero ir según los sensores. Primero ponemos números de dos bits a los casilleros; después construimos cables que calculan esos números. Los carteles describen las salidas y los números describen el estado guardado.

---

## 🟡 3. Moore y Mealy — diapositivas 16–23

### La idea intuitiva

La diferencia está en si la salida mira solamente el cartel del estado o si además mira la señal que entra en este instante. Moore espera a que el estado cambie para cambiar su salida; Mealy puede reaccionar directamente a la entrada.

### Qué problema resuelve

Elegir entre Moore y Mealy permite balancear estabilidad temporal, cantidad de estados y velocidad de respuesta. No es una diferencia de nombres: cambia qué señales alimentan la lógica de salida.

### Definición precisa

En una FSM **Moore**:

$$salida=G(S_{actual})$$

La salida depende solo del estado actual. Por eso, en el modelo de la clase, cambia un clock después de que se dispara la condición que provocó la transición. Es menos sensible a variaciones de las entradas durante el ciclo y no produce glitches en la salida debido a ellas.

En una FSM **Mealy**:

$$salida=G(S_{actual}, entrada)$$

La salida puede cambiar dentro del mismo ciclo en que cambia la entrada y se satisface la condición. Esa respuesta más inmediata puede producir glitches. Para un comportamiento equivalente, Mealy generalmente necesita menos estados que Moore.

### Cómo funciona

En Moore, cada estado lleva asociada una salida. El diagrama suele escribir la salida dentro del nodo. En Mealy, cada transición puede llevar una etiqueta del tipo `entrada/salida`, porque la salida depende de la transición condicionada por la entrada.

La elección debe considerar:

- si la salida puede tolerar cambios antes del próximo flanco;
- si se prioriza respuesta inmediata;
- si resulta importante evitar glitches;
- cuántos estados hacen comprensible y manejable el diseño.

### Ejemplo mínimo

Para detectar la secuencia `10` en una entrada serial:

- una Moore puede tener un estado que indique “se recibió 1” y otro estado de detección cuya salida vale 1 durante un ciclo;
- una Mealy puede producir la salida al observar 0 mientras ya se estaba en el estado “se recibió 1”, sin necesitar necesariamente un estado adicional de detección.

El PDF propone diseñar ambas versiones y comparar sus diferencias; no fija en las diapositivas un único diagrama completo para la tarea.

### Por qué funciona

Moore desacopla la salida de cambios inmediatos en las entradas: la salida solo depende del registro de estado. Mealy agrega las entradas a la lógica de salida, de modo que puede responder sin esperar a que el nuevo estado se registre.

### Qué información conserva y cuál pierde

Ambas conservan el mismo tipo de información de historia mediante estados. Moore restringe la salida a lo que representa el estado; Mealy conserva además la posibilidad de usar la entrada instantánea para decidir la salida.

### Relación con otros conceptos

- **Moore necesita:** lógica de salida conectada al estado actual.
- **Mealy necesita:** lógica de salida conectada al estado actual y a las entradas.
- **Moore se diferencia de Mealy:** por la dependencia funcional de la salida, no por usar un tipo distinto de memoria.
- **Ambas se implementan con:** lógica de próximo estado, registro de estado y lógica de salida.

### Límites y contraejemplos

“Mealy tiene menos estados” es una tendencia, no una garantía para cualquier especificación. “Moore no tiene glitches” se refiere a glitches provocados por las entradas en el modelo sincrónico; no significa que cualquier circuito físico sea inmune a todo problema eléctrico o temporal.

### Confusiones frecuentes

- Que la salida de Moore cambie después no significa que la transición no haya ocurrido: cambió el estado y la salida refleja ese estado en el ciclo siguiente.
- Mealy no significa “asincrónica”: sigue pudiendo formar parte de un circuito sincrónico; lo que cambia es la dependencia combinatoria de la salida.
- Más estados no implica automáticamente un diseño mejor.

### Explicación para nene de 5

En el juego de casilleros, una máquina Moore mira solo el casillero para decidir qué luz prender. Una máquina Mealy mira el casillero y también el botón que acabás de apretar. Por eso Mealy puede prender la luz enseguida, mientras Moore espera a llegar al próximo casillero. El casillero es el estado, la luz es la salida y el botón es la entrada.

---

## 🟡 4. Implementación síncrona y SystemVerilog — diapositivas 35–57

### La idea intuitiva

Una vez definido el comportamiento abstracto, el hardware se arma como una memoria pequeña rodeada de lógica. El registro recuerda el estado; dos bloques `always_comb` calculan lo que sigue y lo que se observa.

### Qué problema resuelve

La implementación debe garantizar que el estado se actualice en el clock, que el reset lleve la máquina a una situación conocida y que todos los casos tengan asignaciones para evitar estados o salidas accidentales en simulación y síntesis.

### Definición precisa

El esqueleto conceptual mostrado para el controlador de tráfico contiene:

- un tipo enumerado `state_t` para nombrar los estados;
- `current_state` y `next_state`;
- un bloque secuencial que carga `next_state` en `current_state`;
- un bloque combinatorio para la lógica de estado siguiente;
- un bloque combinatorio para la lógica de salida.

El registro de estado se expresa como:

```systemverilog
always_ff @(posedge clk or posedge reset) begin
  if (reset)
    current_state <= S0;
  else
    current_state <= next_state;
end
```

La lógica de próximo estado parte de una asignación por defecto y luego sobrescribe los casos:

```systemverilog
always_comb begin
  next_state = current_state;
  unique case (current_state)
    S0: if (!T_A) next_state = S1;
    S1: next_state = S2;
    S2: if (!T_B) next_state = S3;
    S3: next_state = S0;
    default: next_state = S0;
  endcase
end
```

La lógica de salida selecciona las señales asociadas con `current_state`:

```systemverilog
always_comb begin
  unique case (current_state)
    S0: begin L_A = GREEN;  L_B = RED;    end
    S1: begin L_A = YELLOW; L_B = RED;    end
    S2: begin L_A = RED;    L_B = GREEN;  end
    S3: begin L_A = RED;    L_B = YELLOW; end
    default: begin L_A = RED; L_B = RED; end
  endcase
end
```

### Cómo funciona

`always_ff` representa el almacenamiento: usa asignación no bloqueante `<=` y solo actualiza en los eventos del clock o reset indicados. `always_comb` representa lógica sin memoria: la salida debe quedar definida para todas las ramas relevantes.

El PDF usa `typedef enum logic [1:0]` para asociar estados con dos bits. La codificación explícita puede forzarse —por ejemplo, `S0 = 2'b00`—; una enumeración sin ancho explícito puede generar una representación innecesariamente grande para el hardware pensado.

El `default` del cálculo de próximo estado recupera un estado seguro si aparece una codificación no válida. En el ejemplo de salidas, un estado inválido enciende rojo en ambas calles como comportamiento seguro.

### Ejemplo mínimo

Una FSM de cuatro estados necesita dos bits de estado. La dirección de una tabla microprogramada puede concatenar la entrada con esos bits:

$$addr=\{input\_bit,current\_state\}$$

Así, una entrada de un bit y un estado de dos bits forman una dirección de tres bits, con ocho combinaciones posibles.

### Por qué funciona

Separar estado, próximo estado y salida refleja directamente las tres partes del modelo formal. La separación también ayuda a verificar cada una: el bloque secuencial debe ser el único que almacena, mientras que los bloques combinatorios solo calculan.

### Qué información conserva y cuál pierde

El código conserva los nombres y la estructura de la FSM. La herramienta de síntesis puede convertir los bloques en flip-flops y compuertas. La simulación puede revelar combinaciones no cubiertas, estados inválidos o salidas no asignadas; el código no reemplaza la verificación del diagrama y de las tablas.

### Relación con otros conceptos

- **Implementa:** FSM Moore o Mealy según las señales usadas por el bloque de salida.
- **Necesita:** flip-flops D, clock y reset.
- **Se relaciona con:** [[hdl_system_verilog]], que desarrolla `always_ff`, `always_comb`, reset y `case`.
- **Generaliza a:** una ROM o tabla de control en una FSM microprogramada.

### Límites y contraejemplos

El fragmento de código no demuestra por sí solo que la tabla de transición sea correcta. Un `case` puede compilar y aun así tener una transición equivocada. Tampoco se debe usar lógica secuencial dentro de `always_comb` para “guardar” valores: eso cambia el circuito previsto.

### Confusiones frecuentes

- `current_state = next_state` dentro del bloque combinatorio no reemplaza el registro: la captura real ocurre en `always_ff`.
- La asignación por defecto `next_state = current_state` implementa permanencia; no es una actualización de memoria dentro de `always_comb`.
- Un reset asíncrono activo en alto, como el del ejemplo, no debe confundirse con un reset síncrono.
- `unique case` ayuda a expresar que se espera una sola alternativa, pero no corrige una tabla mal diseñada.

### Explicación para nene de 5

Hay una cajita que guarda el nombre de la habitación actual y un reloj que dice cuándo cambiarlo. Un ayudante mira la habitación y los sensores y escribe en un papel la próxima habitación. Otro ayudante mira la habitación y decide qué luces mostrar. El reloj copia el papel en la cajita. En SystemVerilog, la cajita es `always_ff` y los ayudantes son `always_comb`.

---

## ⚪ 5. FSM microprogramada — diapositivas 58–75

### La idea intuitiva

En vez de fabricar una red de compuertas distinta para cada combinación de estado y entrada, se puede guardar una tabla en una memoria y usar el estado más las entradas como dirección. La memoria devuelve el próximo estado y las salidas.

### Qué problema resuelve

Permite cambiar el comportamiento del camino de control modificando el contenido de la tabla, sin cambiar todo el hardware combinatorio. Es una forma de separar la estructura física de las reglas almacenadas.

### Definición precisa

Una FSM microprogramada reemplaza la lógica combinatoria de próximo estado y salida por una tabla o memoria direccionada por las entradas y el estado actual:

$$addr=\{entradas,estado\}$$

La palabra almacenada contiene, por ejemplo, `next_state` y `next_out_flag`. La memoria es combinatoria desde el punto de vista del modelo de la clase; el registro de estado sigue siendo necesario para recordar el estado entre clocks.

### Cómo funciona

El ejemplo de la clase cuenta cuatro unos recibidos en una entrada serial:

- cuatro estados representan haber contado 0, 1, 2 o 3 unos;
- dos bits alcanzan para codificarlos;
- la máquina avanza solo cuando `input_bit=1`;
- al recibir el cuarto uno produce `output_flag=1` durante un ciclo y vuelve al estado inicial;
- la dirección de la tabla concatena `input_bit` y `current_state`;
- ocho direcciones cubren las combinaciones de una entrada de un bit y dos bits de estado.

La tabla se puede escribir en SystemVerilog con un `case` sobre `addr_in`. La salida de la tabla puede concatenar el flag y el próximo estado, por ejemplo `{next_out_flag, next_state}`.

### Ejemplo mínimo

Si `addr_in` tiene tres bits, existen ocho filas. Una fila puede representar:

```systemverilog
3'b111: {next_out_flag, next_state} = {1'b1, 2'b00};
```

La interpretación es: ante esa combinación de entrada y estado, activar la salida y regresar al estado `00`.

### Por qué funciona

Una tabla de verdad es una memoria conceptual de respuestas: para cada dirección devuelve una palabra. Como todas las combinaciones de entrada y estado tienen una dirección, la tabla puede reemplazar una red de AND/OR equivalente.

### Qué información conserva y cuál pierde

Conserva la asociación completa entre situación actual y respuesta. La implementación no expone por sí misma una simplificación booleana de las ecuaciones; gana flexibilidad de reprogramación a cambio de usar una estructura de memoria y decodificación.

### Relación con otros conceptos

- **Es una variante de:** FSM convencional.
- **Necesita:** registro de estado y memoria o ROM combinatoria.
- **Da lugar a:** caminos de control microprogramados en procesadores.
- **Se diferencia de:** un contador simple porque la tabla puede codificar respuestas arbitrarias para cada estado y entrada.

### Límites y contraejemplos

Microprogramar no elimina la necesidad de dimensionar correctamente estados, entradas y palabra de control. Si faltan filas o hay estados inválidos, la máquina sigue necesitando una respuesta segura. Una memoria “propiamente dicha” además incluye almacenamiento; la tabla combinatoria mostrada en la clase se usa como descripción de la función de control.

### Confusiones frecuentes

- La tabla de control no reemplaza al registro de estado.
- Una dirección de ROM no es el estado: combina estado actual con entradas.
- “Reconfigurable” significa cambiar el contenido de la tabla dentro de la arquitectura disponible, no que cualquier cambio sea gratis o que cambie el número de bits de estado.

### Explicación para nene de 5

Es como un libro de instrucciones: buscás una página usando “dónde estoy” y “qué vi”, y la página dice “a dónde voy” y “qué luz prendo”. El libro es la tabla, el papelito que recuerda dónde estabas es el registro de estado y el reloj es el momento de pasar a la nueva página.

---

## Síntesis de la clase

### El hilo completo en pocas palabras

Un circuito secuencial puede resumir su historia en un estado finito. La lógica de próximo estado observa ese estado y las entradas; un registro captura el resultado en el clock; la lógica de salida produce las señales según Moore o Mealy. Diagramas y tablas describen el comportamiento, la codificación lo transforma en bits y SystemVerilog separa el registro de los bloques combinatorios. Si la tabla de reglas se almacena en una memoria, se obtiene una FSM microprogramada.

### Definiciones que hay que poder reconstruir

- Una FSM está compuesta por estados finitos, entradas, salidas, transición, salida y estado inicial.
- $S_{siguiente}=F(S_{actual},entradas)$.
- Moore: $salida=G(S_{actual})$.
- Mealy: $salida=G(S_{actual},entradas)$.
- Con $N$ bits de estado hay como máximo $2^N$ codificaciones.
- El registro de estado captura el próximo estado en el flanco de clock.

### Relaciones que hay que entender

- El estado es memoria; la lógica de próximo estado y la lógica de salida son combinatorias.
- Moore estabiliza la salida y puede usar más estados; Mealy responde antes y puede producir glitches.
- La tabla, el diagrama, las ecuaciones y el código son representaciones del mismo comportamiento, no temas independientes.
- Una codificación no cambia el comportamiento abstracto, pero sí afecta la lógica implementada.
- Una FSM microprogramada cambia la red combinatoria por una tabla direccionable.

### Puente hacia la práctica

- **Modelo de FSM:** reconocer qué parte de la historia debe guardar el estado y distinguir estado actual de estado siguiente.
- **Diagramas y tablas:** traducir entre diagrama, tabla de transición y tabla de salida sin perder condiciones.
- **Codificación:** convertir estados a bits y obtener funciones de los bits de próximo estado.
- **Moore/Mealy:** decidir qué señales alimentan la salida y anticipar la diferencia temporal.
- **Implementación HDL:** separar registro, lógica de próximo estado y lógica de salida; incluir casos por defecto y reset.
- **FSM microprogramada:** interpretar una tabla como memoria cuya dirección combina entrada y estado.

---

# Apéndice — por qué estas cosas y no otras

## Evidencia de la selección

| Unidad | Nivel | Apariciones | Patrón |
|---|---|---|---|
| Modelo de FSM y tablas de transición | 🟡 | 1P_1C_2025 Ej. 3 | [[tipos_ejercicio/tabla_estados_flip_flop]] |
| Moore/Mealy, codificación y lógica de salida | 🆕 → 🟡 | Sin aparición directa en los parciales analizados; contenido explícito de la cursada vigente | — |
| Implementación secuencial de FSM | 🟡 | 1P_1C_2025 Ej. 3 como antecedente de tablas con FF-D | [[tipos_ejercicio/tabla_estados_flip_flop]] |
| Registros y flip-flops como soporte de estado | 🟡 | 1P_1C_2025 Ej. 3; 1P_2C_2024 recuperatorio Ej. 4; 1P_2C_2024 Ej. 4 | [[tipos_ejercicio/tabla_estados_flip_flop]], [[tipos_ejercicio/registro_desplazamiento_mux]], [[tipos_ejercicio/registro_bidireccional_tristate]] |

**Base de comparación:** 6 parciales analizados, 14 patrones en `wiki/tipos_ejercicio/`. El programa `2C_2026` declara un parcial único `1P`; los exámenes históricos se usan como banco de ejercicios por tema, no como simulacros completos. El PDF proviene de `raw/cursada_2C_2026/`, por lo que el contenido vigente sin precedente histórico se escala de 🆕 a 🟡.

`wiki/sintesis/` no contiene una síntesis de patrones; la selección se hizo con las páginas de `wiki/tipos_ejercicio/` cuyo `tema:` es `logica_secuencial` y luego con los tres parciales citados por esas páginas. No fue necesario degradar a todos los parciales crudos: el índice de patrones tiene cobertura para este tema.

## Lo que este documento NO cubre y igual toman

- [[tipos_ejercicio/registro_desplazamiento_mux]] — 2 apariciones. Material en [[temas/logica_secuencial_guia]]
- [[tipos_ejercicio/registro_bidireccional_tristate]] — 1 aparición. Material en [[temas/logica_secuencial_guia]]
- [[tipos_ejercicio/tabla_estados_flip_flop]] — 1 aparición. Material en [[temas/logica_secuencial_guia]]

Estos patrones comparten el soporte secuencial de la FSM, pero el PDF no desarrolla registros de desplazamiento, buses bidireccionales/tristate ni la resolución completa de circuitos con flip-flops. La clase sí introduce tablas y estados, por eso se incluyen como puente conceptual, no como unidades resueltas.

## Divergencias detectadas

No se detectaron contradicciones entre el PDF y las páginas consultadas de la wiki. La página existente [[temas/logica_secuencial_teoria]] ya mencionaba FSM Moore/Mealy; este material amplía esa cobertura con el modelo general, el ejemplo del semáforo, SystemVerilog y FSM microprogramada. La reconciliación o incorporación de este PDF a la wiki queda fuera de este workflow.
