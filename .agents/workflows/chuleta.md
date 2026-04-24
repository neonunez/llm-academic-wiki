Chuletas consolidadas de un tema. Argumento: $ARGUMENTS (nombre del tema, ej: divide_y_conquista)

## Workflow

1. **Leer index.md** e identificar todas las paginas del tema indicado
2. **Leer las paginas relevantes:**
   - `[tema]_practica.md` — extraer todas las secciones `Chuleta`
   - `[tema]_guia.md` — extraer todas las secciones `Chuleta`
   - `tipos_ejercicio/[tema]_*` — extraer todos los `Template de resolucion`
3. **Consolidar** todas las chuletas en una sola respuesta, agrupadas por tipo de ejercicio
4. **Agregar contexto minimo** — para cada chuleta, incluir una linea indicando de que ejercicio/patron proviene

## Output

Formato optimizado para repaso rapido antes del examen. Conciso, directo, sin explicaciones largas. Ejemplo:

```
## Chuletas — Divide & Conquer

### Resolver recurrencia (Master Theorem)
> 1. Identificar a, b, c de T(n) = aT(n/b) + O(n^c)
> 2. Comparar log_b(a) con c
> 3. Caso 1/2/3 segun comparacion
📌 Fuente: Ej. 2 practica | Parcial 1C 2024

### Disenar algoritmo D&C
> 1. Dividir en subproblemas de tamaño n/b
> ...
```

## Nota

Si el tema no tiene chuletas generadas aun (ejercicios con `[PENDIENTE]`), informar al usuario y sugerir correr `/resolver` primero.
