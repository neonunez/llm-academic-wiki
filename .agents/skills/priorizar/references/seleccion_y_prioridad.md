# Seleccion y prioridad

## Programa como fuente de verdad

Leer `programa.md` de la materia antes de asignar `parcial:`. Los nombres historicos de PDFs y
examenes no deciden para que parcial se estudia un tema.

Si `programa.md` declara `esquema_evaluacion: parcial_unico`, no agrupar por parcial y usar todos
los parciales historicos como comparacion valida. Declarar que ningun examen del esquema viejo
cubre necesariamente el temario vigente completo.

## Indice evaluable

Para cada tema del PDF:

1. Leer todas las paginas de `wiki/tipos_ejercicio/` cuyo `tema:` coincida.
2. Si el frontmatter no permite filtrar, usar en orden:
   1. prefijo del nombre (`haskell_*`, `lambda_*`, `prolog_*`, etc.);
   2. campo `Tema:` de `wiki/sintesis/patrones_detectados.md`;
   3. contenido de `## Como reconocer este patron` en todas las paginas.
3. Si existe `wiki/sintesis/patrones_detectados.md`, usarla para frecuencias y tendencias, pero
   verificar cada aparicion contra links reales.
4. Abrir de `wiki/parciales_analizados/` solo los parciales citados por patrones coincidentes.

## Chequeo de cobertura

Comparar los temas declarados por los parciales relevantes con los temas que tienen al menos un
`tipos_ejercicio/`. Si un tema fue evaluado pero no tiene patrones, hay un hueco de indice:

- leer directamente los parciales crudos de ese tema;
- no confundir “sin patron compilado” con “sin apariciones”;
- declarar en el apendice:

> ⚠️ Base parcial: el tema `<tema>` no tiene patrones en `tipos_ejercicio/`. El cruce se hizo
> contra los parciales crudos. Correr `/tipos_ejercicio_scan` para cerrar el hueco.

## Niveles

El nivel regula profundidad; no es una etiqueta decorativa.

| Nivel | Criterio | Teoria | Practica / guia |
|---|---|---|---|
| 🔴 Critico | Patron con al menos 2 apariciones en parciales distintos | Desarrollo conceptual completo | Resolucion razonada completa |
| 🟡 Probable | 1 aparicion o variante adyacente de patron evaluado | Explicacion conceptual mas breve | Resolucion enfocada en la tecnica |
| ⚪ Contexto | Sin aparicion propia, pero prerequisito de una unidad prioritaria | Contexto y relacion | Listar sin resolver completo |
| 🆕 Sin precedente | No coincide con patron ni parcial | Aplicar regla de vigencia | Aplicar regla de vigencia |

### Contenido vigente sin precedente

Si el tema es nuevo/reubicado, figura en huecos de cobertura del programa o el PDF proviene de
`raw/cursada_*/`, subir 🆕 a 🟡. El material vigente es fuente de autoridad: “nunca aparecio” puede
significar “todavia no aparecio”.

Si el tema es viejo, estable y sin apariciones, dejar 🆕 y describirlo como contenido de baja
evidencia historica, no como contenido inutil.

### Recencia

Si todas las apariciones son antiguas y parciales recientes reemplazaron el patron por otro del
mismo bloque, anotar `en baja` sin cambiar el nivel. Solo `programa.md` puede afirmar que un tema
salio del examen.

## Uso de patrones segun el documento

El `Template de resolucion` se usa de forma distinta:

- **Teoria:** informa un `Puente hacia la practica` corto. No crea una seccion “Como te lo piden”
  dentro de cada concepto.
- **Practica:** informa reconocimiento, estrategia, errores y transferencia.
- **Guia:** informa prioridad, pistas y plan de resolucion.

Toda evidencia de apariciones queda en el apendice, no dentro de las unidades.

## Cruce inverso

Listar patrones del mismo tema y parcial que ninguna unidad cubre. Una linea por patron:

```markdown
- [[tipos_ejercicio/<patron>]] — N apariciones. Material en [[<pagina>]]
```

Es un puntero final, no una seccion extensa.
