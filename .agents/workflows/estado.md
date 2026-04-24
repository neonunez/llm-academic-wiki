Resumen ejecutivo del wiki. Sin argumentos.

## Workflow

1. **Contar paginas por tipo** leyendo index.md:
   - Teoria (`_teoria.md`)
   - Practica (`_practica.md`)
   - Guia (`_guia.md`)
   - Tipos de ejercicio (`tipos_ejercicio/`)
   - Parciales analizados (`parciales_analizados/`)
   - Sintesis (`sintesis/`)
   - Transcripciones (`transcripciones/`)
2. **Contar PDFs en raw/** vs paginas generadas en wiki/
3. **Contar banderas pendientes:**
   - `⚪ Pendiente` en paginas de practica y guia
   - `[PENDIENTE — sesion de resolucion]` en guias no resueltas
4. **Ultimo ingest:** fecha y archivo del ultimo registro en log.md
5. **Cobertura por tema:** para cada tema, listar que tipos de pagina existen (teoria/practica/guia/tipos_ejercicio)

## Output

Presentar en una tabla compacta de una pantalla. Ejemplo:

```
Estado del wiki — Algoritmos y Estructuras de Datos III
─────────────────────────────────────────────────────────
PDFs en raw/: 51 | Paginas wiki: 23 | Cobertura: 45%

Por tipo: Teoria 10 | Practica 8 | Guia 5 | Tipos ej. 3 | Parciales 4 | Sintesis 0

Banderas pendientes: 12 ⚪ | Guias sin resolver: 3

Ultimo ingest: [2026-04-08] 3.teo_1P_programacion_dinamica.pdf
```
