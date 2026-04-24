Paso previo al run: leer todos los parciales_analizados/ e identificar patrones recurrentes cross-parcial. Guarda el resultado en wiki/sintesis/patrones_detectados.md. No modifica ningun archivo del wiki. Ejecutar desde la carpeta de la materia.

## Contexto

Este comando es liviano — solo lee, no escribe en el wiki. Su objetivo es generar un archivo intermedio con todos los patrones identificados en parciales, incluyendo patrones cross-parcial (que aparecen en 1P y 2P). Este archivo es la fuente de verdad que usa /tipos_ejercicio_run.

Correr ANTES de /tipos_ejercicio_run.

## Paso 1 — Leer CLAUDE.md

Leer `CLAUDE.md` en el working directory para conocer temas por parcial y convenciones de nomenclatura.

## Paso 2 — Leer todos los parciales_analizados/

```bash
ls wiki/parciales_analizados/
```

Leer TODOS los archivos. Para cada ejercicio de cada parcial extraer:
- Parcial (1P o 2P)
- Cuatrimestre y año
- Tema del ejercicio
- Tipo de ejercicio (descripcion concisa del patron, ej: "conversion entre bases numericas", "simplificacion con mapa de Karnaugh")

## Paso 3 — Identificar patrones

Agrupar ejercicios por tipo. Para cada tipo construir:

```
nombre_patron: snake_case descriptivo
descripcion: una linea
parcial: 1P | 2P | ambos
tema: tema principal
apariciones:
  - parcial: [id]  ejercicio: N  descripcion: [breve]
  - parcial: [id]  ejercicio: N  descripcion: [breve]
frecuencia: N
```

Marcar como `cross_parcial: true` si aparece en parciales de distintos cuatrimestres o en ambos parciales (1P y 2P).

## Paso 4 — Escribir patrones_detectados.md

Crear o sobreescribir `wiki/sintesis/patrones_detectados.md`:

```markdown
---
tipo: sintesis
generado: [fecha]
fuente: parciales_analizados/
uso: fuente de verdad para /tipos_ejercicio_run
---

# Patrones detectados — [nombre materia]

Generado por /tipos_ejercicio_scan. Usar como input de /tipos_ejercicio_run.

## Resumen

- Total patrones: N
- Patrones 1P: N
- Patrones 2P: N  
- Patrones cross-parcial: N

## Patrones

### [nombre_patron]

- **Descripcion:** [una linea]
- **Parcial:** 1P | 2P | ambos
- **Tema:** [tema]
- **Cross-parcial:** si | no
- **Frecuencia:** N apariciones
- **Apariciones:**
  - [[parciales_analizados/[id]]] — Ejercicio N: [descripcion breve]
  - [[parciales_analizados/[id]]] — Ejercicio N: [descripcion breve]

[repetir por cada patron]
```

## Paso 5 — Reportar

Imprimir resumen sin hacer commit:
- Parciales leidos: N
- Patrones identificados: N (X de 1P, Y de 2P, Z cross-parcial)
- Archivo generado: wiki/sintesis/patrones_detectados.md
- Proximo paso: correr /tipos_ejercicio_run 1P y luego /tipos_ejercicio_run 2P
