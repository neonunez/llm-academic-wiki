# Indice — Algoritmos y Estructuras de Datos III

Ultima actualizacion: 2026-04-11 (sesion 11 — banderas y tipos_ejercicio COMPLETADOS)

## Fundamentos

- [[complejidad_computacional_teoria]] — Modelo RAM, notacion asintotica (O, Omega, Theta), clasificacion de algoritmos · `raw/clases/teo/0.teo_1P_repaso.pdf`

## Temas — 1P

### Divide & Conquer
- [[divide_y_conquista_teoria]] — Forma general D&C, analisis de recurrencias, Teorema Maestro, Karatsuba · `raw/clases/teo/1.teo_1P_divide_&_conquer.pdf`
- [[divide_y_conquista_practica]] — MergeSort, BusquedaBinaria, MaximoMontana, MaximaSubsecuencia, DiferenciaMinima (busqueda ternaria) · `raw/clases/prac/1.prac_1P_divide_&_conquer.pdf`
- [[divide_y_conquista_guia]] — 16 ejercicios de guia: recurrencias (MergeSort, BusquedaBinaria, MaximoMontana, 12 recurrencias DyC), diseno (MaximaSubsecuencia, DiferenciaMinima) · `raw/guias_practicas/1.guia_1P_divide_&_conquer.pdf`

### Fuerza Bruta & Backtracking
- [[fuerza_bruta_backtracking_teoria]] — Optimizacion combinatoria, fuerza bruta, backtracking, branch & bound, mochila, n-damas · `raw/clases/teo/2.teo_1P_fuerza_bruta_backtracking.pdf`
- [[fuerza_bruta_backtracking_practica]] — Separar cadena en palabras, ABB optimo, Dobra (palabras buenas con comodines), Cadenas de adicion · `raw/clases/prac/2.prac_1P_backtracking_handout.pdf`
- [[fuerza_bruta_backtracking_guia]] — 8 ejercicios de guia (ej 1-8): SumaSubconjuntos, RutaMinima, PalabrasEnCadena, ABBOptimos, Dobra (guia 2, seccion BT) · `raw/guias_practicas/2.guia_1P_tecnicas_algoritmicas.pdf`

### Programacion Dinamica
- [[programacion_dinamica_teoria]] — Top-down vs bottom-up, coeficientes binomiales, cambio de monedas (con demo), mochila (con demo por induccion), SCML · `raw/clases/teo/3.teo_1P_programacion_dinamica.pdf` + `3.teo_1P_demo_mochila.pdf` + `3.teo_1P_demo_monedas.pdf`
- [[programacion_dinamica_top_down_practica_pt1]] — El retorno del rey (Fibonacci), AstroTrade, Tobi el granjero (grid mod K+1) — 2025 · `raw/clases/prac/3.prac_1P_programacion_dinamica_top_down_parte1.pdf`
- [[programacion_dinamica_top_down_practica_pt2]] — Receta 6 pasos PD top-down, Vacations, Caesar's Legions, Fire (Codeforces) — 2023 · `raw/clases/prac/3.prac_1P_programacion_dinamica_top_down_parte2.pdf`
- [[programacion_dinamica_bottom_up_practica]] — Fibonacci BU (opt. $O(1)$), AstroTrade BU (opt. $O(n)$, demo induccion), Mi Buenos Aires Crecido (LIS ponderada, dos formulaciones), Garland (estado 3D paridad), Caesar's Legions opt. $O(P \cdot D)$ (tablas aditivas), Lagunas ($O(N^3) \to O(N\sqrt{N})$) · `raw/clases/prac/4.prac_1P_programacion_dinamica_bottom_up.pdf`
- [[programacion_dinamica_guia]] — 18 ejercicios de guia (ej 9-26): SumaDinamica, AstroTrade, Fire, CortesEconomicos, PilaCauta, CaesarsLegions, ABBOptimoBU, MiBuenosAiresCrecido (guia 2, seccion PD) · `raw/guias_practicas/2.guia_1P_tecnicas_algoritmicas.pdf`

### Greedy
- [[greedy_teoria]] — Heuristicas, epsilon-aproximacion, mochila fraccionaria, cambio de monedas (greedy), tiempo de espera, seleccion de actividades (con demo por intercambio) · `raw/clases/teo/4.teo_1P_greedy.pdf` + `4.teo_1P_demo_seleccion_de_actividades.pdf`
- [[greedy_practica]] — Planificacion de tareas con deadlines (GSA), Viaje a Mar del Plata (eleccion greedy + subestructura optima), Minimizacion del producto escalar (argumento de intercambio) · `raw/clases/prac/5.prac_1P_greedy.pdf`
- [[greedy_guia]] — 11 ejercicios de guia (ej 27-37): Deadlines, RutaEficiente, ProductoEscalar, SeleccionDeActividades, mochila fraccionaria (guia 2, seccion Greedy) · `raw/guias_practicas/2.guia_1P_tecnicas_algoritmicas.pdf`

### Definiciones y Demostraciones
- [[definiciones_y_demostraciones_teoria]] — Estrategias de demo (directa, casos, contradiccion, contrarreciproco, construccion, induccion, contraejemplo), errores comunes, ejemplo resuelto poda optimalidad · `raw/clases/teo/5.teo_1P_definicion_demo.pdf`
- [[demostraciones_induccion_guia]] — 8 ejercicios de guia: induccion matematica (identidades, sumatoria general, Fibonacci/Binet, errores en demos) · `raw/guias_practicas/0.guia_1P_repaso.pdf`

## Temas — 2P

### Grafos
- [[grafos_teoria]] — Definiciones (grafo, digrafo, multigrafo), grado, Handshaking Lemma, recorridos/caminos/ciclos, distancia, subgrafos, conexidad, bipartitos, isomorfismo, representacion (matriz adyacencia, listas) · `raw/clases/teo/6.teo_2P_grafos.pdf`
- [[grafos_practica]] — Representacion (matriz adyacencia vs lista adyacencia, complejidades, alternativas, grafos implicitos), Demostraciones (principio del palomar, CicloCompartido, vertices no-articulacion por induccion, Handshaking por induccion, caminata impar→ciclo impar, error clasico induccion constructiva) · `raw/clases/prac/7.prac_2P_demostracion_sobre_grafos.pdf` + `7.prac_2P_representacion_de_grafos.pdf`
- [[grafos_guia]] — 22 ejercicios de guia: teoria algoritmica de grafos, demostraciones y propiedades de grafos/digrafos (parcial: ambos) · `raw/guias_practicas/3.guia_1P_teoria_algoritmica_de_grafos.pdf`
- [[recorrido_en_grafos_practica]] — DFS y BFS (repaso), conectividad, componentes conexas, contar caminos minimos (BFS+PD), bipartito (BFS+paridad), aristas puente (DFS+cubren, demo ↔ ciclo, algoritmo lineal), luces (grafo implicito+BFS), orden topologico (DFS+stack) · `raw/clases/prac/8.prac_2P_recorrido_en_grafos.pdf`
- [[recorrido_en_grafos_guia]] — 10 ejercicios de guia (ej 1-10): DFS y BFS, componentes conexas, bipartitez, caminos (guia 4, seccion recorridos) · `raw/guias_practicas/4.guia_2P_recorridos_&_arboles.pdf`

### Arboles
- [[arboles_teoria]] — Definicion (conexo sin circuitos), lemas (hojas, m=n-1), teoremas de equivalencia, arboles enraizados (m-ario, balanceado), arboles generadores, BFS y DFS (algoritmo, timestamps, clasificacion arcos), aplicaciones (ciclos, topologico, fuertemente conexas) · `raw/clases/teo/7.teo_2P_arboles.pdf`

### Arboles Generadores Minimos
- [[arboles_generadores_minimos_teoria]] — Definicion AGM, Algoritmo de Prim (pseudocodigo, proposicion, teorema, prueba por induccion, complejidades), Algoritmo de Kruskal (pseudocodigo, proposicion, teorema, prueba por induccion, Union-Find, complejidades) · `raw/clases/teo/8.teo_2P_arboles_generadores_minimos.pdf`
- [[arboles_generadores_minimos_practica]] — Repaso (AG, AGM, MaxiMin/MiniMax, vinculo MiniMax↔AGM con demo), Viaje en peligro (Prim parcial $k$ aristas, $O(n^2)$), Conjuntos deseables (demo + algoritmo Kruskal+DSU $O(nm)$), Audifonos defectuosos (MiniMax via AGM), Alimentando hormigas (nodo fantasma Tubo), Rutas y aeropuertos (comparar 2 AGMs), DSU (union by rank + path compression) · `raw/clases/prac/9.prac_2P_arbol_generador_minimo.pdf`
- [[arboles_generadores_minimos_guia]] — 10 ejercicios de guia (ej 11-20): AGM, Prim/Kruskal, MiniMax, integradores recorridos+AGM (guia 4, seccion AGM) · `raw/guias_practicas/4.guia_2P_recorridos_&_arboles.pdf`

### Caminos Minimos
- [[caminos_minimos_teoria]] — Definiciones (longitud, distancia, subestructura optima), variantes (1-1, 1-n, n-n), pesos negativos, Dijkstra (pesos>=0, pseudocodigo, lema+teorema+prueba, complejidades), Bellman-Ford/Ford (permite negativos, detecta ciclos negativos, lemas, corolarios, pruebas), Floyd (PD todos pares, O(n³), deteccion ciclos negativos), Dantzig (todos pares, crece matriz k×k) · `raw/clases/teo/9.teo_2P_caminos_minimos_en_grafos1.pdf` + `10.teo_2P_caminos_minimos_en_grafos2.pdf`
- [[caminos_minimos_practica]] — Policias (BFS multi-source con nodo fantasma, $O(n+m)$), Martin y los Mares (Dijkstra doble ida/vuelta + aristas tortuga, con demo), Manuel y los Monstruos (Bellman-Ford, ciclos negativos alcanzables con demo, DAG de caminos minimos + BFS) · `raw/clases/prac/10.prac_2P_recorrido_minimo_uno_a_todos.pdf` + `10.prac_2P_recorrido_uno_a_todos_soluciones.pdf`
- [[caminos_minimos_todos_a_todos_y_dags_practica]] — DAGs (orden topologico, Kahn, CM en DAG por PD $O(n+m)$), Sasha peajes (expansion temporal → DAG, $O(nt+mt)$), Rayuela rectangular (DAG camino maximo, $O(pqk)$), Optimizando canciones (Floyd $O(k^3)$ + desigualdad triangular), Mas trenes (Dantzig incremental vs Dijkstra on-demand), String problem (Floyd sobre alfabeto), Manic Moving (Floyd + PD ruta entregas) · `raw/clases/prac/11.prac_2P_recorrido_minimo_todos_a_todos_DAGs.pdf`
- [[caminos_minimos_guia]] — 27 ejercicios de guia: Dijkstra, Bellman-Ford, SRDs, Floyd-Warshall, DAGs, grafos implicitos · `raw/guias_practicas/5.guia_2P_recorrido_minimo.pdf`

### Flujo en Redes
- [[flujo_en_redes_teoria]] — Definicion del problema (red, capacidad, conservacion), corte y capacidad, max-flow=min-cut, red residual, camino de aumento, Ford-Fulkerson (pseudocodigo, O(nmU), flujo entero), Edmonds-Karp (BFS, O(nm²)), matching maximo en bipartitos (reduccion a flujo) · `raw/clases/teo/11.teo_2P_flujo_en_redes.pdf`
- [[flujo_en_redes_practica]] — Mini-repaso, tecnicas (split de vertice, sumidero ficticio), ¡Popular! (caminos disjuntos en aristas $O(nm)$ + corte minimo en vertices $O(n(n+m))$), Hotel lleno (min-cut), Matching bipartito Tareas ($O(|P||T| \cdot \min(|P|,|T|))$), Enchufados (adaptadores, $O(k^5)$), Furbo (sports elimination, modelo partido+equipo) · `raw/clases/prac/12.prac_2P_flujo_slides.pdf` + `12.prac_2P_flujos_handout.pdf`
- [[flujo_en_redes_practica_pt2]] — Hospital (scheduling medicos con capa periodo-por-medico, $O(MD^2)$), Down Went the Titanic (grilla con hielo/iceberg/madera, split de hielo, interpretacion secuencial, $O(C^2)$), Satelite (enunciado — modelado pendiente) · `raw/clases/prac/13.prac_2P_flujo_parte2.pdf`
- [[flujo_en_redes_guia]] — 27 ejercicios de guia: propiedades de flujos, caminos disjuntos, asignacion, transporte, corte minimo, flujo de costo minimo, adicionales (Elecciones Rumestania 2P-C2-2023, Torneos de Futbol) · `raw/guias_practicas/6.guia_2P_flujo_en_redes.pdf`

## Tipos de ejercicio

### 1P
- [[tipos_ejercicio/dc_diseno]] — D&C: diseño de algoritmos Divide & Conquer · 1P_1C_2024, 1P_1C_2025
- [[tipos_ejercicio/dc_teorema_maestro]] — D&C: aplicar/verificar Teorema Maestro · 1P_1C_2024, 1P_2C_2025, 2P_1C_2025
- [[tipos_ejercicio/bt_complejidad_backtracking]] — BT: analizar complejidad de backtracking · 1P_1C_2024, 1P_2C_2025
- [[tipos_ejercicio/backtracking_tsp]] — BT: TSP y problemas de permutacion con poda · 1P_1C_2025
- [[tipos_ejercicio/pd_definir_estado]] — PD: definir el estado (elegir dimensiones) · 1P_1C_2024, 1P_1C_2025
- [[tipos_ejercicio/pd_definir_recursion]] — PD: definir recursion y analizar complejidad · 1P_1C_2024, 1P_2C_2025, 1P_1C_2025
- [[tipos_ejercicio/pd_superposicion_subproblemas]] — PD: demostrar superposicion de subproblemas · 1P_2C_2025
- [[tipos_ejercicio/greedy_demo_intercambio]] — Greedy: demostrar correctitud por argumento de intercambio · 1P_2C_2025, 2P_1C_2025

### 2P
- [[tipos_ejercicio/grafos_demostraciones]] — Grafos: demostrar propiedades de grafos · 1P_1C_2024, 2P_2C_2025, 2P_1C_2025
- [[tipos_ejercicio/bfs_dfs_propiedades]] — BFS/DFS: propiedades y aplicaciones · 1P_1C_2024, 2P_1C_2024, 2P_2C_2025, 2P_1C_2025
- [[tipos_ejercicio/agm_propiedades]] — AGM: propiedades y algoritmos · 2P_1C_2024, 2P_1C_2025
- [[tipos_ejercicio/cm_estado_expandido]] — CM: caminos minimos con estado expandido · 2P_1C_2024, 2P_2C_2025, 2P_1C_2025
- [[tipos_ejercicio/flujo_modelado]] — Flujo: modelar problemas como redes de flujo · 2P_1C_2024, 2P_2C_2025, 2P_1C_2025

## Parciales analizados

- [[parciales_analizados/1P_1C_2024]] — D&C, Backtracking, PD, Grafos, BFS/DFS · digital · 15 pags
- [[parciales_analizados/2P_1C_2024]] — AGM, Caminos Minimos, Grafos, Flujo · digital · 4 pags
- [[parciales_analizados/1P_1C_2025]] — PD, Grafos, Backtracking, D&C, BFS/DFS · fotografiado · 2 resoluciones (75/100, 85/100)
- [[parciales_analizados/1P_2C_2025]] — D&C, PD, Greedy, Backtracking, Fuerza Bruta · fotografiado · formato desarrollo
- [[parciales_analizados/2P_1C_2025]] — AGM, Caminos Minimos, Grafos, Flujo, D&C, Greedy, Coloreo · mixto · 2 examenes (regular 68/100 + recuperatorio)
- [[parciales_analizados/2P_2C_2025]] — Grafos, AGM, Caminos Minimos, Flujo, BFS/DFS · fotografiado · 17/Nov/2025

## Sintesis

- [[sintesis/repaso_1P]] — Clase de consultas previa al 1P: MC conceptual (TM, BT, PD, Greedy), MaxMin D&C ($3n/2-2$ comparaciones), Viaje Mar del Plata, RutaMinima (BT + poda optimalidad), Pila Cauta (PD pseudopolinomial + polinomial) · `raw/clases/prac/6.prac_1P_repaso_para_primer_parcial.pdf`
- [[sintesis/repaso_2P]] — Clase de consultas 2do recuperatorio: arbol con 2 hojas, BFS para ciclo minimo, Fmax=u(Smin), isomorfismo con complemento ($n(n-1)/4$ aristas, casos $n\equiv 0,1 \pmod{4}$), demo ciclo entre dos componentes (4 casos, $O(n+m)$) · `raw/clases/prac/14.prac_2P_repaso_para_segundo_parcial.pdf`
- [[sintesis/resumen_comunidad]] — Resumen estudiantil completo (Damy): todos los temas 1P+2P, extension de Bellman-Ford (Corolarios 2-3, $G^*$, deteccion/recuperacion ciclos negativos), Johnson, tabla comparativa algoritmos todos-pares · `raw/contenido_comunidad/1.comunidad_resumen_general.pdf`
