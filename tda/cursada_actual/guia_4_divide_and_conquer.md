---
nombre: Divide & Conquer — guia priorizada de entrenamiento
tipo: material_de_estudio
origen: raw/cursada_2C_2026/guias/guia_4_divide_and_conquer.pdf
tipo_documento: guia
temas: [divide_y_conquista]
parcial: 1P
programa: 2C_2026
generado: 2026-09-03
base_comparacion:
  parciales_analizados: 6
  tipos_ejercicio: 2
ingestado: false
---

# Divide & Conquer — guia priorizada de entrenamiento

**Fuente:** `raw/cursada_2C_2026/guias/guia_4_divide_and_conquer.pdf` · **Tema:** `divide_y_conquista` → **1P** (programa 2C_2026)

> La guia se declara como `guia`, aunque su encabezado dice “Práctica 4”. Se respeta el tipo indicado. Los ejercicios con $\star$ son el subconjunto mínimo recomendado por la propia guía.
>
> **Revision de evidencia (2026-09-14):** la version anterior marcaba los 16 ejercicios como 🔴 por asignarlos al patron amplio `dc_diseno`. Eso confundia “ser un ejercicio de D&C” con “tener precedente concreto en parciales”. Abajo, 🔴 = aparecio de forma directa o practicamente equivalente; 🟡 = entrena una tecnica parecida a una evaluada; ⚪ = sin precedente parcial identificable; 🆕 = incorporacion vigente sin precedente historico.

## Que busca entrenar la guia

- Reconocer las etapas **divide / conquer / combine** y traducirlas a una recurrencia.
- Distinguir cuándo aplica el Teorema Maestro y cuándo una recurrencia con resta constante requiere otro análisis.
- Diseñar D&C que descarte regiones imposibles, propague información suficiente al combinar o trate un caso cruzado.
- Justificar correctitud mediante un invariante de búsqueda o una partición exhaustiva de casos.

## Plan de trabajo

### Nivel 1 — precedentes directos de parcial
- **Ej. 3 (Complexity quest):** practicar TM y distinguirlo de recurrencias con resta constante. En parciales se pidieron recurrencias concretas y el análisis de algoritmos recursivos.
- **Ej. 4 (Izquierda dominante):** resolver sin ayuda. Es prácticamente el mismo esquema que `es_derecha_dominante` de 1P-2C-2025: dos mitades, retorno `(booleano, suma)` y combine $O(1)$.
- **Ej. 11 (Contar inversiones):** resolver y demostrar. Apareció explícitamente en el recuperatorio 2P-1C-2025.

### Nivel 2 — variantes parecidas que conviene entrenar
- **Ej. 1–2:** automatizar los casos canónicos de TM antes del Ej. 3.
- **Ej. 5, 8, 13 y 14:** entrenar búsqueda/poda sobre un intervalo; el antecedente más cercano es el ejercicio de huecos con poda de 1P-1C-2024.
- **Ej. 9:** practicar la partición izquierda/derecha/cruzada y un combine lineal; es transferencia útil de los ejercicios evaluados de diseño y merge.

### Nivel 3 — sin precedente directo
- **Ej. 6, 7, 10, 12 y 16:** hacerlos después de los niveles 1–2; aportan repertorio de D&C, pero no hay un paralelo puntual en los parciales analizados.
- **Ej. 15:** hacerlo si la guía vigente lo indica: es una búsqueda binaria de factibilidad útil, pero es nuevo respecto de los parciales disponibles.

### Si falta tiempo
1. **3, 4 y 11**.
2. **1, 2, 5, 8, 9, 13 y 14**.
3. **6, 7, 10, 12, 15 y 16**.

Esto ordena por evidencia histórica; no reemplaza una exigencia explícita de la cátedra en la guía vigente.

## Seleccion rapida

| Ejercicio | Prioridad | Habilidad | Evidencia contra parciales |
|---|---|---|---|
| 1. MergeSort | 🟡 | Identificar recurrencia y TM | Base de las recurrencias evaluadas; no apareció MergeSort literal |
| 2. Búsqueda binaria | 🟡 | Una rama, $\Theta(\log n)$ | Base de poda/búsqueda; no apareció literal |
| 3. Complexity quest | 🔴 | Elegir método de recurrencias | TM apareció en 1P-1C-2024, 1P-2C-2025 y 2P-1C-2025 |
| 4. Izquierda dominante | 🔴 | Propagar suma con booleano | Equivalente a `es_derecha_dominante`, 1P-2C-2025 |
| 5. Índice espejo | 🟡 | Invariante para descartar mitad | Variante de búsqueda/poda; emparentado con huecos, 1P-1C-2024 |
| 6. Potencia logarítmica | ⚪ | Reutilizar un subresultado | Sin paralelo puntual identificado |
| 7. Distancia máxima | ⚪ | Propagar altura y diámetro | Sin paralelo puntual identificado |
| 8. Cazador de falsos | 🟡 | Poda por consulta agregada | Análogo de poda de subproblemas al ejercicio de huecos, 1P-1C-2024 |
| 9. Máxima subsecuencia | 🟡 | Caso cruzado | Combina mitades como inversiones; no apareció literal |
| 10. Suma de potencias | ⚪ | Identidad recursiva | Sin paralelo puntual identificado |
| 11. Contar inversiones | 🔴 | Contar durante merge | Apareció explícitamente: 2P-1C-2025, Ej. B9 |
| 12. Merge selectivo | ⚪ | Selección por rango | Sin paralelo puntual identificado |
| 13. Diferencia mínima | 🟡 | Búsqueda del cambio de signo | Variante de búsqueda por monotonía; emparentado con poda de huecos |
| 14. SubBúsqueda | 🟡 | Búsqueda con costo no uniforme | Variante de una rama con poda; emparentado con huecos |
| 15. Encuentro mínimo | 🆕 | Búsqueda binaria sobre respuesta | Nuevo respecto de los parciales analizados |
| 16. L-Tetris | ⚪ | Construcción con invariante | Sin paralelo puntual identificado |

---

## 🟡 Ej. 1 — MergeSort

### Enunciado
Sobre el código de MergeSort de la guía: identificar divide, conquer y combine; cantidad y tamaño de subproblemas; costo de combinar; recurrencia y complejidad por Teorema Maestro.

### Que tenes que producir
La clasificación de líneas y $T(n)=2T(n/2)+\Theta(n)$, con su caso del TM.

### Que conocimiento presupone
Merge de dos arreglos ordenados y los parámetros $a$, $c$ y $f(n)$ del TM.

### Pista de reconocimiento
Las dos llamadas recursivas trabajan sobre mitades; la fusión consume todos los elementos una vez.

### Plan de resolucion
Separar el cálculo del punto medio (divide), las dos llamadas (conquer) y `merge` (combine). Recién entonces leer $a$, $c$ y $f$.

### Resolucion paso a paso
1. **Divide:** calcular `medio` y partir el arreglo en dos mitades.
   - **Por que:** genera dos instancias del mismo problema de tamaño $n/2$.
2. **Conquer:** ordenar recursivamente cada mitad.
   - **Por que:** hay $a=2$ llamadas.
3. **Combine:** hacer `merge` de las dos salidas ordenadas.
   - **Por que:** los dos punteros avanzan a lo sumo $n$ veces, así que cuesta $\Theta(n)$.
4. Escribir $T(n)=2T(n/2)+\Theta(n)$, con caso base $T(1)=\Theta(1)$.
   - **Por que:** $\log_2 2=1$ y $f(n)=\Theta(n^1)$.
5. Aplicar caso 2: $T(n)=\Theta(n\log n)$.

### Control del resultado
El resultado no puede ser $\Theta(n)$: cada nivel del árbol hace $\Theta(n)$ trabajo y hay $\Theta(\log n)$ niveles.

### Si te trabas
1. ¿Cuántas llamadas a `merge_sort` hay?
2. Contá cuántos elementos pueden salir de los dos punteros de `merge`.
3. Compará $n$ con $n^{\log_2 2}$.

### Variante que conviene intentar
Cambiar `merge` por una combinación $O(1)$ y recalcular la recurrencia.

### Chuleta
> 2 mitades + merge lineal → $T(n)=2T(n/2)+\Theta(n)$ → TM caso 2 → $\Theta(n\log n)$.

---

## 🟡 Ej. 2 — Búsqueda binaria

### Enunciado
Sobre el código de búsqueda binaria de la guía, identificar sus etapas D&C, su recurrencia y complejidad.

### Que tenes que producir
$T(n)=T(n/2)+\Theta(1)$ y la explicación de por qué solo hay un subproblema.

### Que conocimiento presupone
Arreglo ordenado y comparación contra el elemento medio.

### Pista de reconocimiento
La comparación no combina dos respuestas: elimina una mitad completa.

### Plan de resolucion
Identificar el medio, decidir qué mitad puede contener el objetivo y contabilizar una única llamada.

### Resolucion paso a paso
1. **Divide:** calcular `medio`.
2. Comparar `arr[medio]` con el objetivo y descartar una mitad.
   - **Por que:** el orden garantiza que la mitad descartada no puede contenerlo.
3. **Conquer:** hacer una sola llamada sobre una mitad de tamaño $n/2$.
4. **Combine:** no hay combine; se devuelve el resultado de la rama, con trabajo $\Theta(1)$.
5. $T(n)=T(n/2)+\Theta(1)$; $a=1$, $c=2$, $n^{\log_2 1}=1$.
6. Por caso 2, $T(n)=\Theta(\log n)$.

### Control del resultado
Si aparecieron dos llamadas recursivas en tu código, dejaste de descartar una mitad y ya no implementaste búsqueda binaria.

### Si te trabas
1. ¿Qué dice el orden si `arr[medio] > objetivo`?
2. ¿La otra mitad se procesa?
3. Compará $\Theta(1)$ con $n^0$.

### Variante que conviene intentar
Adaptarla para hallar el primer índice cuyo valor sea al menos un objetivo dado.

### Chuleta
> Medio + descartar una mitad → $T(n)=T(n/2)+\Theta(1)$ → $\Theta(\log n)$.

---

## 🔴 Ej. 3 — Complexity quest

### Enunciado
Calcular las complejidades de las doce recurrencias de la guía; usar TM solo cuando corresponda.

### Que tenes que producir
La complejidad asintótica y el método correcto para cada ítem.

### Que conocimiento presupone
Sumas, progresiones geométricas y Teorema Maestro.

### Pista de reconocimiento
TM exige tamaño $n/c$, no una disminución como $n-1$, $n-2$ o $n-4$.

### Plan de resolucion
Agrupar primero las recurrencias por su forma y solo después resolver cada grupo.

### Resolucion paso a paso
1. Para las restas constantes, desplegar o sumar:
   - $T(n)=T(n-2)+5=\Theta(n)$.
   - $T(n)=T(n-1)+n=\Theta(n^2)$.
   - $T(n)=T(n-1)+\sqrt n=\Theta(n^{3/2})$.
   - $T(n)=T(n-1)+n^2=\Theta(n^3)$.
   - $T(n)=2T(n-1)=\Theta(2^n)$.
   - $T(n)=2T(n-4)=\Theta(2^{n/4})$.
   - **Por que:** no reducen por un factor constante; se telescopa o se cuenta el árbol correspondiente.
2. Para TM:
   - $T(n)=T(n/2)+n=\Theta(n)$ (caso 3).
   - $T(n)=T(n/2)+\sqrt n=\Theta(\sqrt n)$ (caso 3).
   - $T(n)=T(n/2)+n^2=\Theta(n^2)$ (caso 3).
   - $T(n)=2T(n/2)+\log n=\Theta(n)$ (caso 1).
   - $T(n)=3T(n/4)=\Theta(n^{\log_4 3})$ (caso 1).
   - $T(n)=3T(n/4)+n=\Theta(n)$ (caso 3).
3. En cada caso 3, verificar la regularidad antes de concluir.

### Control del resultado
No apliques TM a $T(n)=T(n-1)+n$: el subproblema no es de tamaño $n/c$.

### Si te trabas
1. Marcá con una cruz las que tienen $n-k$.
2. Para TM, calculá primero $\alpha=\log_c a$.
3. Compará el exponente de $f(n)$ con $\alpha$.

### Variante que conviene intentar
Cambiar $\log n$ por $n$ en $2T(n/2)+f(n)$ y explicar por qué aparece el factor $\log n$ extra.

### Chuleta
> $n-k$ → desplegar/sumar; $n/c$ → comparar $f(n)$ contra $n^{\log_c a}$.

---

## 🔴 Ej. 4 — Izquierda dominante

### Enunciado
Decidir si un arreglo de tamaño potencia de 2 tiene suma izquierda mayor que derecha en cada partición recursiva, en tiempo estrictamente menor que $O(n^2)$.

### Que tenes que producir
Un algoritmo que devuelva si el segmento es dominante y su suma, con complejidad $\Theta(n)$.

### Que conocimiento presupone
Definición recursiva de la propiedad y retorno de múltiples valores.

### Pista de reconocimiento
Si cada nivel vuelve a sumar sus mitades, el combine sería lineal; hacé que las sumas suban como parte de la solución.

### Plan de resolucion
Cada llamada retorna `(dominante, suma)`. Combinar dos pares requiere solo una comparación y una suma.

### Resolucion paso a paso
1. Caso base: un elemento retorna `(True, A[i])`.
2. Resolver ambas mitades y obtener $(d_I,s_I)$ y $(d_D,s_D)$.
3. Retornar $(d_I\land d_D\land(s_I>s_D),\;s_I+s_D)$.
   - **Por que:** coincide exactamente con la definición de “más a la izquierda”.
4. La recurrencia es $T(n)=2T(n/2)+\Theta(1)$.
5. Por TM caso 1, $T(n)=\Theta(n)$.

### Control del resultado
Tu función debe verificar la propiedad incluso cuando una mitad ya no sea dominante; no alcanza con comparar la suma de la raíz.

### Si te trabas
1. ¿Qué dato necesita el padre para comparar mitades?
2. ¿Puede obtenerlo sin recorrer otra vez cada mitad?
3. Escribí el par que retorna un caso base.

### Variante que conviene intentar
Invertir la desigualdad para definir “más a la derecha”.

### Chuleta
> Retornar `(bool, suma)` → combine $O(1)$ → $2T(n/2)+O(1)=\Theta(n)$.

---

## 🟡 Ej. 5 — Índice espejo

### Enunciado
En un arreglo de enteros distintos estrictamente creciente, decidir si existe $i$ con $a_i=i$ en tiempo sublineal.

### Que tenes que producir
Búsqueda binaria y el invariante que justifica descartar una mitad.

### Que conocimiento presupone
Orden estricto y convención de índices usada en la implementación.

### Pista de reconocimiento
Compará $a_{mid}$ con `mid`, no con un objetivo fijo.

### Plan de resolucion
Si el medio está “por encima” de su índice, buscar a la izquierda; si está “por debajo”, buscar a la derecha.

### Resolucion paso a paso
1. Elegir `mid` del rango actual.
2. Si $a_{mid}=mid$, devolver ese índice.
3. Si $a_{mid}>mid$, recursar a izquierda.
   - **Por que:** para $k>mid$, por crecer con enteros distintos, $a_k\ge a_{mid}+k-mid>k$; no puede haber espejo a derecha.
4. Si $a_{mid}<mid$, recursar a derecha, por el argumento simétrico.
5. El rango vacío significa que no existe; $T(n)=T(n/2)+O(1)=\Theta(\log n)$.

### Control del resultado
La poda usa que los valores son enteros **distintos** y están en orden estricto; sin esas hipótesis, no está justificada.

### Si te trabas
1. Probá qué pasa a la derecha si el medio vale más que su índice.
2. Usá que entre dos valores enteros distintos crecientes hay incremento de al menos 1.
3. Escribí el caso de rango vacío.

### Variante que conviene intentar
Devolver todos los índices espejo si el arreglo permite repetidos: explicar por qué ya no basta una sola rama.

### Chuleta
> Comparar $a_{mid}$ con `mid`: mayor → izquierda; menor → derecha; igual → encontrado.

---

## ⚪ Ej. 6 — Potencia logarítmica

### Enunciado
Calcular $a^b$ en tiempo logarítmico en $b$, reutilizando resultados.

### Que tenes que producir
Exponenciación rápida que no haga dos llamadas iguales.

### Que conocimiento presupone
Paridad de $b$ y propiedades de potencias.

### Pista de reconocimiento
Cuando $b$ es par, calcular $a^{b/2}$ una sola vez y elevar ese resultado al cuadrado.

### Plan de resolucion
Usar caso base $b=0$; distinguir exponentes pares e impares.

### Resolucion paso a paso
1. Si $b=0$, devolver $1$.
2. Si $b$ es par, guardar $p=potencia(a,b/2)$ y devolver $p^2$.
   - **Por que:** $a^b=(a^{b/2})^2$.
3. Si $b$ es impar, devolver $a\cdot potencia(a,b-1)$.
   - **Por que:** la llamada siguiente tendrá exponente par.
4. En dos pasos como máximo, el exponente se reduce al menos a la mitad; por eso $T(b)=O(\log b)$.

### Control del resultado
No escribir `potencia(a,b/2) * potencia(a,b/2)`: duplica el subproblema y arruina la reutilización.

### Si te trabas
1. Verificá $a^5=a\cdot a^4$.
2. Verificá $a^8=(a^4)^2$.
3. Contá cuántas veces se puede dividir $b$ por 2.

### Variante que conviene intentar
Adaptar la idea para multiplicar matrices, conservando el orden de los productos.

### Chuleta
> Par: calcular una vez $a^{b/2}$ y cuadrar. Impar: sacar un $a$. Profundidad $O(\log b)$.

---

## ⚪ Ej. 7 — Distancia máxima

### Enunciado
En un árbol binario, devolver la máxima cantidad de aristas de un camino sin recorridos innecesarios.

### Que tenes que producir
Una llamada que retorne diámetro y altura, en $\Theta(n)$.

### Que conocimiento presupone
Árbol binario, altura y caminos que pasan o no por la raíz.

### Pista de reconocimiento
El camino óptimo puede cruzar la raíz: conocer solo el mejor camino de cada hijo no alcanza.

### Plan de resolucion
Devolver por cada nodo `(diametro, altura)`; usar altura $-1$ para un hijo vacío si se mide en aristas.

### Resolucion paso a paso
1. Para nodo vacío devolver diámetro $0$ y altura $-1$; una hoja queda con altura $0$.
2. Resolver hijos y obtener $(D_I,h_I)$ y $(D_D,h_D)$.
3. Calcular el camino que cruza el nodo: $h_I+h_D+2$.
4. Retornar:
   $$\left(\max\{D_I,D_D,h_I+h_D+2\},\;1+\max\{h_I,h_D\}\right).$$
   - **Por que:** todo camino máximo está enteramente en un hijo o cruza el nodo actual.
5. Cada nodo se visita una vez: $\Theta(n)$.

### Control del resultado
En una cadena de un solo hijo, el diámetro debe ser cantidad de aristas, no cantidad de nodos.

### Si te trabas
1. Dibujá un camino cuyos extremos están en hijos distintos.
2. Preguntate qué necesita el padre además del diámetro de cada hijo.
3. Fijá una convención para la altura del vacío y no la mezcles.

### Variante que conviene intentar
Devolver también los extremos del camino máximo, no solo su longitud.

### Chuleta
> Retornar diámetro y altura; comparar izquierdo, derecho y cruzado. Una visita por nodo → $\Theta(n)$.

---

## 🟡 Ej. 8 — Cazador de falsos

### Enunciado
Con `conjuncionSubmatriz` de costo $O(1)$, hallar un `false` en una matriz $n\times n$ y luego contar hasta 5 `false` en tiempo subcuadrático.

### Que tenes que producir
Poda por cuadrantes y complejidad en función de $n$.

### Que conocimiento presupone
Partición en cuatro cuadrantes y significado de una conjunción booleana.

### Pista de reconocimiento
Si la conjunción de un cuadrante es `true`, no existe ningún `false` allí.

### Plan de resolucion
Partir hasta llegar a una celda; para hallar uno, seguir un único cuadrante falso; para contar, visitar todos los cuadrantes cuya conjunción sea falsa.

### Resolucion paso a paso
1. Partir una submatriz no unitaria en cuatro cuadrantes de lado aproximadamente $n/2$.
2. Para hallar uno, consultar sus cuadrantes y recursar en cualquiera cuya conjunción sea `false`.
   - **Por que:** la precondición asegura que existe al menos uno.
3. Al llegar a una celda, devolver su posición. La profundidad es $O(\log n)$ y por nivel hay trabajo constante.
4. Para contar, podar los cuadrantes con conjunción `true` y sumar los conteos de los restantes.
5. Con a lo sumo $K=5$ falsos, solo hay $O(K)$ caminos productivos por nivel: $O(K\log n)=O(\log n)$.

### Control del resultado
No concluyas que una submatriz con conjunción `false` contiene exactamente un falso: solo garantiza que contiene al menos uno.

### Si te trabas
1. Escribí la condición que permite no recursar.
2. Separá “encontrar uno” de “contarlos todos”.
3. Acotá cuántas ramas pueden contener alguno de los cinco falsos.

### Variante que conviene intentar
Reemplazar el límite 5 por un parámetro $K$ y expresar la complejidad con $K$.

### Chuleta
> Conjunción `true` → podar. Un falso: una rama por nivel; $K$ falsos: $O(K\log n)$.

---

## 🟡 Ej. 9 — Máxima subsecuencia

### Enunciado
Encontrar la máxima suma de elementos contiguos de una secuencia en $O(n\log n)$ mediante D&C.

### Que tenes que producir
Los tres casos, el cálculo lineal del caso cruzado y la recurrencia.

### Que conocimiento presupone
Sufijo máximo, prefijo máximo y Teorema Maestro.

### Pista de reconocimiento
Una subsecuencia máxima o queda entera en una mitad o cruza el medio.

### Plan de resolucion
Resolver recursivamente izquierda y derecha. Para el cruce, barrer desde el medio hacia afuera en ambas direcciones.

### Resolucion paso a paso
1. Dividir por el medio y resolver el óptimo izquierdo y derecho.
2. Calcular el mejor sufijo de la mitad izquierda acumulando desde el medio hacia atrás.
3. Calcular el mejor prefijo de la mitad derecha acumulando desde `medio+1` hacia adelante.
4. El mejor cruzado es la suma de ambos.
   - **Por que:** cualquier subarreglo que cruza el medio debe ser exactamente un sufijo izquierdo más un prefijo derecho.
5. Devolver el máximo entre izquierdo, derecho y cruzado.
6. $T(n)=2T(n/2)+\Theta(n)=\Theta(n\log n)$.

### Control del resultado
El caso cruzado debe incluir elementos de ambas mitades; no es el máximo de una sola mitad.

### Si te trabas
1. Listá las tres posiciones posibles de una subsecuencia.
2. Para el cruce, fijá que debe tocar el medio a ambos lados.
3. Usá acumuladores, no todos los pares de extremos.

### Variante que conviene intentar
Comparar con el enfoque de Kadane de $O(n)$, sin sustituir la solución D&C pedida.

### Chuleta
> Máximo = izq / der / cruzado; cruzado = mejor sufijo izq + mejor prefijo der → $\Theta(n\log n)$.

---

## ⚪ Ej. 10 — Suma de potencias

### Enunciado
Para una matriz $A$ de orden $4\times4$ y $n$ potencia de 2, calcular $A+A^2+\cdots+A^n$ usando menos de $O(n)$ operaciones de potencia, suma y producto.

### Que tenes que producir
Una recurrencia basada en una identidad algebraica y su conteo de operaciones.

### Que conocimiento presupone
Matriz identidad, potencias de la misma matriz y asociatividad del producto.

### Pista de reconocimiento
Separá la suma en las primeras $n/2$ potencias y las últimas $n/2$.

### Plan de resolucion
Definir $S(n)=A+\cdots+A^n$ y factorizar la segunda mitad con $A^{n/2}$.

### Resolucion paso a paso
1. Usar $S(1)=A$.
2. Para $n>1$, aplicar:
   $$S(n)=(I+A^{n/2})S(n/2).$$
3. Calcular recursivamente $S(n/2)$ y obtener $A^{n/2}$ con el método provisto.
4. Sumar $I+A^{n/2}$ y multiplicar por $S(n/2)$.
   - **Por que:** al expandir aparecen una vez $A^1,\ldots,A^{n/2}$ y una vez $A^{n/2+1},\ldots,A^n$.
5. El número de operaciones de matrices satisface $T(n)=T(n/2)+O(1)=O(\log n)$.

### Control del resultado
Para $n=4$, expandir $(I+A^2)(A+A^2)$ y verificar que da $A+A^2+A^3+A^4$.

### Si te trabas
1. Escribí $S(4)$ en dos bloques de dos términos.
2. Factorizá $A^2$ en el segundo bloque.
3. Recordá que todas las potencias son de la misma matriz $A$.

### Variante que conviene intentar
Reescribir la identidad como $S(n)=S(n/2)+A^{n/2}S(n/2)$.

### Chuleta
> $S(n)=(I+A^{n/2})S(n/2)$ → una llamada de tamaño mitad → $O(\log n)$ operaciones.

---

## 🔴 Ej. 11 — Contar inversiones

### Enunciado
Contar pares $i<j$ con $A[i]>A[j]$ en $\Theta(n\log n)$.

### Que tenes que producir
MergeSort modificado que devuelva arreglo ordenado y número de inversiones.

### Que conocimiento presupone
Merge de listas ordenadas y partición de pares en tres clases.

### Pista de reconocimiento
Cuando el merge elige un elemento derecho antes que el izquierdo actual, forma inversión con todos los izquierdos restantes.

### Plan de resolucion
Contar recursivamente inversiones internas y, durante merge, las cruzadas.

### Resolucion paso a paso
1. Retornar $(0,A)$ para un segmento de longitud a lo sumo uno.
2. Resolver ambas mitades y obtener conteos internos y salidas ordenadas.
3. En el merge, si $R[j]<L[i]$, sumar $|L|-i$ y emitir $R[j]$.
   - **Por que:** como $L$ está ordenado, todos $L[i],\ldots,L[fin]$ son mayores que $R[j]$.
4. Retornar suma de inversiones izquierda, derecha y cruzadas junto con el merge ordenado.
5. El merge es $\Theta(n)$: $T(n)=2T(n/2)+\Theta(n)=\Theta(n\log n)$.

### Control del resultado
No sumar una sola inversión al elegir $R[j]$: puede haber muchas izquierdas restantes.

### Si te trabas
1. Dividí los pares en izquierda, derecha y cruzados.
2. Usá que ambas mitades ya llegan ordenadas.
3. Probá con `[3,1,2]`: hay dos inversiones.

### Variante que conviene intentar
Además del conteo, devolver un par de índices que forme una inversión si existe.

### Chuleta
> En merge, si gana $R[j]$, sumar todos los $L$ restantes: `len(L)-i`. Complejidad de MergeSort.

---

## ⚪ Ej. 12 — Merge selectivo

### Enunciado
Dados dos arreglos ordenados de igual tamaño, hallar el i-ésimo elemento de su merge sin realizar el merge completo; la guía pide $O(\log^2 n)$ y propone como desafío $O(\log n)$.

### Que tenes que producir
Una selección por rango que haga búsqueda binaria dentro de un arreglo y ubique el candidato en el otro.

### Que conocimiento presupone
Búsqueda binaria y rango de un elemento dentro de un merge ordenado.

### Pista de reconocimiento
Si elegís $A[mid]$, podés hallar por búsqueda binaria cuántos elementos de $B$ van antes que él.

### Plan de resolucion
Buscar un candidato de $A$; su rango en el merge determina si el resultado queda antes, es él o queda después. Mantener rangos compatibles de ambos arreglos.

### Resolucion paso a paso
1. Elegir `mid` en el rango vigente de $A$.
2. Usar búsqueda binaria en $B$ para contar elementos menores que $A[mid]$.
3. El rango de $A[mid]$ en el merge es: elementos descartados + elementos previos de $A$ + esos elementos de $B$.
4. Compararlo con $i$: si es mayor, descartar la parte derecha de $A$ y la porción de $B$ que no puede aportar; si es menor, hacer el descarte simétrico.
   - **Por que:** el orden de ambos arreglos conserva la relación de rangos.
5. Cada nivel hace una búsqueda $O(\log n)$ y reduce una mitad: $T(n)=T(n/2)+O(\log n)=O(\log^2 n)$.

### Control del resultado
Definí al inicio si $i$ es 0-indexado o 1-indexado y ajustá todos los rangos a esa convención.

### Si te trabas
1. Tomá $A[mid]$ como candidato, no ambos medios a la vez.
2. Calculá su rango manualmente en un ejemplo de dos listas cortas.
3. Recordá que cada búsqueda interna cuesta $O(\log n)$.

### Variante que conviene intentar
El desafío de $O(\log n)$: buscar simultáneamente la partición de tamaños $i$ entre ambos arreglos.

### Chuleta
> Rango de candidato = previos de $A$ + rank en $B$; búsqueda externa con binaria interna → $O(\log^2 n)$.

---

## 🟡 Ej. 13 — Diferencia mínima

### Enunciado
Con $A$ estrictamente creciente y $B$ estrictamente decreciente, hallar $\min_i|A[i]-B[i]|$ en $O(\log n)$.

### Que tenes que producir
Búsqueda binaria del cruce de signo de $f(i)=A[i]-B[i]$, verificando los dos vecinos del cruce.

### Que conocimiento presupone
Monotonía y búsqueda binaria.

### Pista de reconocimiento
$A[i]-B[i]$ crece estrictamente: una sucesión sube y la otra baja.

### Plan de resolucion
Buscar el primer índice donde $A[i]\geq B[i]$; el mínimo absoluto solo puede estar allí o inmediatamente antes.

### Resolucion paso a paso
1. Definir $f(i)=A[i]-B[i]$, estrictamente creciente.
2. Hacer búsqueda binaria del primer $i$ con $f(i)\geq0$.
3. Comparar $|f(i)|$ con $|f(i-1)|$ si existe.
   - **Por que:** antes del cruce, $|f|$ decrece; después, crece.
4. Tratar los bordes: si todos los valores son negativos, el candidato es el último; si todos son no negativos, el primero.
5. La búsqueda cuesta $O(\log n)$ y las comparaciones finales son constantes.

### Control del resultado
No buscar el mínimo de $|f|$ como si fuera una función monotónica: es unimodal; la monotónica es $f$ sin valor absoluto.

### Si te trabas
1. Escribí $f(i)$, no $|f(i)|$.
2. ¿En qué lado queda el cruce si $f(mid)<0$?
3. Revisá ambos lados del cruce.

### Variante que conviene intentar
Resolverlo por búsqueda ternaria sobre $|A[i]-B[i]|$ y comparar el invariante con el de la solución anterior.

### Chuleta
> $f=A-B$ crece; buscar primer $f\ge0$ y comparar ese índice con el anterior → $O(\log n)$.

---

## 🟡 Ej. 14 — SubBúsqueda

### Enunciado
Dado `aparece?(A,i,j,e)` de costo $O(\sqrt{j-i+1})$, hallar el índice de un elemento existente en tiempo sublineal.

### Que tenes que producir
Búsqueda binaria que use el oráculo y análisis $\Theta(\sqrt n)$.

### Que conocimiento presupone
Invariante “$e$ está en el intervalo actual” y recurrencias TM.

### Pista de reconocimiento
El oráculo permite preguntar directamente si el elemento permanece en la mitad izquierda.

### Plan de resolucion
Consultar la mitad izquierda: si contiene $e$, conservarla; en caso contrario, conservar la derecha.

### Resolucion paso a paso
1. Mantener un intervalo que contiene $e$.
2. Consultar `aparece?(A,izq,mid,e)`.
3. Si da `true`, recursar a izquierda; si no, a derecha.
   - **Por que:** se asume que $e$ existe y por lo tanto debe estar en la mitad complementaria.
4. Al llegar a una celda, devolver su índice.
5. La recurrencia es $T(n)=T(n/2)+O(\sqrt n)$.
6. Por TM caso 3, $T(n)=\Theta(\sqrt n)=o(n)$.

### Control del resultado
El costo del oráculo debe evaluarse sobre el tamaño del intervalo actual, no sobre el arreglo original en todos los niveles.

### Si te trabas
1. Escribí el invariante antes del código.
2. ¿Cuánto mide el rango consultado en el primer nivel?
3. Compará $\sqrt n$ contra $n^{\log_2 1}=1$.

### Variante que conviene intentar
Si el oráculo costara $O(\log m)$ sobre rango de tamaño $m$, recalcular la recurrencia.

### Chuleta
> Preguntar si está en la mitad; una rama. $T(n)=T(n/2)+O(\sqrt n)=\Theta(\sqrt n)$.

---

## 🆕 Ej. 15 — Encuentro mínimo

### Enunciado
Dados amigos en posiciones $x_i$ con velocidades máximas $v_i$, encontrar el mínimo tiempo natural $t$ en el que pueden coincidir en un punto; la guía aclara que la complejidad puede depender de $x$ y $v$.

### Que tenes que producir
Una prueba de factibilidad para un tiempo y una búsqueda binaria sobre el menor tiempo factible.

### Que conocimiento presupone
Intervalos alcanzables y predicado monótono.

### Pista de reconocimiento
En $t$ unidades, el amigo $i$ puede estar en el intervalo $[x_i-v_it,\;x_i+v_it]$.

### Plan de resolucion
Para un $t$ fijo, intersectar todos los intervalos. Buscar el menor $t$ cuya intersección no sea vacía.

### Resolucion paso a paso
1. Definir para cada amigo $I_i(t)=[x_i-v_it,\;x_i+v_it]$.
2. `factible(t)` calcula $L=\max_i(x_i-v_it)$ y $R=\min_i(x_i+v_it)$, y devuelve $L\le R$.
   - **Por que:** existe punto de encuentro si y solo si todos los intervalos comparten algún punto.
3. Observar monotonía: si $t$ es factible, todo $t'>t$ también lo es porque cada intervalo solo se agranda.
4. Hallar primero una cota superior factible duplicando $t$ y luego hacer búsqueda binaria entre la última cota no factible y esa cota factible.
5. Cada chequeo cuesta $O(n)$; si $t^*$ es el mínimo tiempo y existe una cota factible por duplicación, el costo es $O(n\log t^*)$.

### Control del resultado
La búsqueda binaria no funciona sin justificar monotonía de `factible(t)`.

### Si te trabas
1. Dibujá dos intervalos de alcance para un mismo tiempo.
2. ¿Qué significan $\max$ de extremos izquierdos y $\min$ de extremos derechos?
3. Probá si una intersección no vacía puede volverse vacía al aumentar $t$.

### Variante que conviene intentar
Recuperar un punto de encuentro: cualquier punto de $[L,R]$ para el tiempo final sirve.

### Chuleta
> En $t$: intersectar $[x_i-v_it,x_i+v_it]$. Factible si $\max L_i\le\min R_i$; buscar mínimo $t$ por binaria.

---

## ⚪ Ej. 16 — L-Tetris

### Enunciado
En un tablero $n\times n$, con $n$ potencia de 2 y una celda ya ocupada, cubrir el resto con piezas L de tres celdas cumpliendo la numeración indicada.

### Que tenes que producir
Construcción D&C con una pieza central y la invariante “cada cuadrante recibe una celda ocupada”.

### Que conocimiento presupone
Partición en cuatro cuadrantes y caso base de lado 1.

### Pista de reconocimiento
Solo uno de los cuatro cuadrantes contiene la celda original; una L central puede crear la celda ocupada de los otros tres.

### Plan de resolucion
Dividir en cuatro; colocar una L en las tres celdas centrales que no pertenecen al cuadrante de la celda ocupada; recursar en los cuatro cuadrantes.

### Resolucion paso a paso
1. Caso base: tablero $1\times1$; no hay nada que cubrir.
2. Dividir el tablero en cuatro cuadrados de lado $n/2$.
3. Detectar cuál contiene la celda ocupada original.
4. Colocar una L en las tres celdas centrales de los otros tres cuadrantes, usando un mismo identificador nuevo.
   - **Por que:** deja exactamente una celda ocupada en cada subtablero.
5. Recursar en los cuatro cuadrantes con su respectiva celda ocupada.
6. La invariante prueba correctitud por inducción: cada llamada recibe exactamente una celda ocupada y cubre las demás sin superposición.
7. Con $m=n^2$ celdas: $T(m)=4T(m/4)+O(1)=\Theta(m)=\Theta(n^2)$.

### Control del resultado
La L del centro debe ocupar tres celdas, no cuatro, y no debe tocar la celda ocupada del cuadrante original.

### Si te trabas
1. Dibujá el bloque central de $2\times2$.
2. Marcá en cuál cuadrante cayó el agujero.
3. Colocá la L sobre las otras tres celdas centrales.

### Variante que conviene intentar
Trazar manualmente la primera partición de un tablero $4\times4$.

### Chuleta
> Una L central crea tres “agujeros” artificiales; cuatro subtableros válidos → $\Theta(n^2)$.

---

## Ejercicios secundarios por evidencia histórica

- **Ej. 6, 7, 10, 12 y 16** — no tienen paralelo puntual identificado en los parciales analizados. Son útiles para ampliar repertorio, pero pueden postergarse hasta dominar los 🔴 y 🟡.
- **Ej. 15** — no tiene precedente histórico identificable; conservarlo como 🆕 porque pertenece a la guía vigente y practica búsqueda binaria sobre factibilidad.

## Criterio para considerar dominada la guia

- Puedo pasar de código o enunciado a $a$, $c$, $f(n)$ sin confundir una resta $n-k$ con una división $n/c$.
- Puedo diseñar una llamada que devuelva la información suficiente para que el combine sea $O(1)$ cuando corresponde.
- Puedo justificar qué soluciones cubren los casos izquierdo, derecho y cruzado.
- Puedo explicar por qué una poda no descarta una solución válida.
- Puedo resolver sin ayuda los Ej. 3, 4 y 11 (precedentes directos), y después transferir las ideas a los Ej. 5, 8, 9, 13 y 14.

---

# Apendice — por que estas cosas y no otras

## Evidencia de la seleccion

| Unidad | Nivel | Aparicion o similitud verificable | Patron |
|---|---|---|---|
| Ej. 3 — Complexity quest | 🔴 | [[parciales_analizados/1P_1C_2024]] Ej. 4 · [[parciales_analizados/1P_2C_2025]] Ej. 5 · [[parciales_analizados/2P_1C_2025]] Ej. A2, A4 y B5 | [[tipos_ejercicio/dc_teorema_maestro]] |
| Ej. 4 — Izquierda dominante | 🔴 | [[parciales_analizados/1P_2C_2025]] Ej. 5 (`es_derecha_dominante`): misma estructura, cambiando el sentido de la desigualdad | [[tipos_ejercicio/dc_teorema_maestro]] |
| Ej. 11 — Contar inversiones | 🔴 | [[parciales_analizados/2P_1C_2025]] Ej. B9: mismo algoritmo MergeSort modificado | [[tipos_ejercicio/dc_diseno]] + [[tipos_ejercicio/dc_teorema_maestro]] |
| Ej. 1, 2, 5, 8, 9, 13 y 14 | 🟡 | Transferencia de recurrencias, búsqueda/poda o combine; el paralelo más cercano de poda es [[parciales_analizados/1P_1C_2024]] Ej. 3 | [[tipos_ejercicio/dc_diseno]] / [[tipos_ejercicio/dc_teorema_maestro]] |
| Ej. 6, 7, 10, 12 y 16 | ⚪ | Sin aparición ni paralelo puntual identificado | — |
| Ej. 15 | 🆕 | Sin precedente histórico; ejercicio incorporado por la guía vigente | — |

**Base de comparacion:** 6 parciales analizados, 2 patrones en `tipos_ejercicio/` para `divide_y_conquista`.

No hay hueco de índice: los parciales que declaran `divide_y_conquista` están cubiertos por `dc_teorema_maestro` o `dc_diseno`. **La corrección es de granularidad:** esos dos patrones cubren familias de ejercicios, pero no justifican asignar 🔴 automáticamente a cada ejercicio de la familia.

## Lo que este documento NO cubre y igual toman

- Ninguno: la guía contiene práctica para [[tipos_ejercicio/dc_teorema_maestro]] y [[tipos_ejercicio/dc_diseno]]. La diferencia es que no todas sus variantes tienen el mismo respaldo histórico.

## Divergencias detectadas

No se detectó contradicción de contenido con la wiki histórica. La guía vigente reordena la numeración respecto de [[divide_y_conquista_guia]] e incorpora el Ej. 15 (Encuentro mínimo), por lo que el cruce se hizo por enunciado y técnica, no por número de ejercicio. La wiki histórica sigue marcada como pendiente de verificación; esta nota no la reconcilia ni la modifica.
