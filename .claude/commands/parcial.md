Vista consolidada orientada a examen. Argumento: $ARGUMENTS (parcial: 1P o 2P)

## Regla previa — leer `programa.md` SIEMPRE

**Paso 0 obligatorio:** leer `programa.md` del working directory para obtener el mapa
`tema → parcial` **vigente**.

Los rotulos `1P`/`2P` en `wiki/parciales_analizados/`, en `apariciones_en_parciales:` y en los
nombres de `raw/` son **historicos**: dicen en que parcial se tomo cada examen bajo el programa
de aquel cuatrimestre. **No** dicen para que parcial hay que estudiar el tema hoy.

Por eso esta vista **cruza por tema, nunca por el rotulo del examen**:

1. De `programa.md`, obtener la lista de temas que entran en `$ARGUMENTS` (mas los `ambos`).
2. Recorrer **todos** los `parciales_analizados/` — los de 1P y los de 2P por igual — y quedarse
   con los ejercicios **cuyo tema** este en esa lista.
3. Si un tema cambio de parcial respecto del programa viejo, decirlo explicitamente en el output.

Si el programa vigente difiere del que regia cuando se tomaron los parciales, **advertirlo arriba
de todo**: los examenes historicos no son simulacros validos, solo banco de ejercicios por tema.

## Workflow

1. **Leer `programa.md`** → temas de `$ARGUMENTS` + transversales (`ambos`)
2. **Leer todos los `wiki/parciales_analizados/`** (ambos parciales, sin filtrar por rotulo) y
   quedarse con los ejercicios de esos temas
3. **Calcular frecuencia** de aparicion por tema, anotando en que examen historico salio cada uno
4. **Leer las paginas `tipos_ejercicio/`** con `parcial: $ARGUMENTS` o `parcial: ambos`
   en el frontmatter (ese campo ya esta derivado de `programa.md`)
5. **Consolidar** en una vista unica orientada a examen

## Output

```
## Vista de examen — 1er Parcial (1P) · programa 2C-2026

> ⚠️ Los parciales historicos se tomaron con otro reparto de temas. Esta vista los cruza
> **por tema**, no por el rotulo del examen. Ver [[programa]].

### Temas que entran (segun programa vigente)
Teoria de Grafos · Arboles · Recorridos BFS/DFS · Divide & Conquer · Backtracking
Transversales: Complejidad · Definiciones y Demostraciones

### Reubicaciones respecto del programa viejo
- ⬅️ Grafos, Arboles y Recorridos **entraron** al 1P (antes eran 2P)
- ➡️ PD y Greedy **salieron** del 1P (ahora son 2P)

### Ejercicios historicos por tema (independiente del rotulo del examen)
| Tema | Ejercicios hallados | En que examenes (rotulo historico) |
|------|--------------------|-----------------------------------|
| Grafos | 5 | 2P_1C_2025, 2P_2C_2025, 1P_1C_2024 |
| Divide & Conquer | 3 | 1P_1C_2024, 1P_2C_2025 |

### Tipos de ejercicio recurrentes
- [[tipos_ejercicio/grafos_demostraciones]] — 3 apariciones (todas rotuladas 2P — ahora es tu 1P)
- [[tipos_ejercicio/dc_teorema_maestro]] — 3 apariciones

### Patrones por tema

#### Teoria de Grafos
- Ejercicio tipico: demostrar propiedad sobre grados / conexidad / ciclos
- Variantes vistas: ...
- Chuleta rapida: ...

### Cobertura y huecos
- Temas del programa vigente **sin** ejercicios en parciales historicos: [listar]
  (ojo: no significa que no los tomen — significa que no hay evidencia historica bajo este reparto)

### Fuentes disponibles
- [[parciales_analizados/2P_1C_2025]] — aporta los ejercicios de grafos y AGM
- ...
```
