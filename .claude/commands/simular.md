Generar un ejercicio de practica inedito. Argumento opcional: $ARGUMENTS (tema, ej: backtracking. Sin argumento: elige tema aleatorio del parcial mas proximo)

## Regla previa — `programa.md` es la fuente de verdad del mapeo tema→parcial

Leer `programa.md` del working directory antes de asignar cualquier `parcial:`.
**Nunca** inferir el parcial desde el nombre del archivo en `raw/` ni desde el rotulo del
examen historico en que aparecio un ejercicio: esos rotulos reflejan el programa del
cuatrimestre en que se dicto/tomo el material, que puede diferir del vigente.
Todo frontmatter generado lleva `parcial:` (derivado) + `programa:` (version que refleja).

## Workflow

1. **Si hay argumento:** usar el tema indicado. **Si no:** leer `programa.md`, identificar los temas del parcial mas proximo **segun el programa vigente**, y elegir uno al azar entre ellos (usar `parciales_analizados/` solo para calibrar dificultad y estilo, nunca para decidir que tema entra)
2. **Leer las paginas `tipos_ejercicio/`** del tema para entender los patrones recurrentes
3. **Leer `parciales_analizados/`** del tema para ver el nivel de dificultad y estilo de los enunciados reales
4. **Generar un ejercicio inedito** que:
   - Siga el estilo de los parciales reales
   - Tenga dificultad comparable
   - No sea identico a ningun ejercicio existente en el wiki
   - Incluya una variante o twist respecto a los ejercicios vistos

## Output

```
## Ejercicio simulado — [Tema]

### Enunciado
[enunciado estilo parcial]

### Resolucion paso a paso
1. [paso] — *por que: [justificacion]*
2. ...

### Chuleta
> 1. ... → 2. ... → 3. ...

### Basado en
Patron: [[tipos_ejercicio/X]]
Dificultad comparable a: [[parciales_analizados/Y]] Ej. Z
```

## Nota

El ejercicio simulado NO se guarda en el wiki automaticamente. Si el usuario quiere guardarlo, debe indicarlo explicitamente.
