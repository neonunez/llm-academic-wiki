Ingestar todos los PDFs de una carpeta en orden. Argumento: $ARGUMENTS (ruta a la carpeta relativa a la materia, ej: raw/parciales/1P/ o raw/cursada_2C_2026/teo/)

## Workflow

1. **Verificar log.md** — identificar que archivos de la carpeta ya fueron ingestados para no re-procesarlos
2. **Listar PDFs** de la carpeta en orden numerico (por el prefijo numerico del nombre)
3. **Filtrar** los ya ingestados (basandose en log.md)
4. **Para cada PDF pendiente**, ejecutar el workflow de `/ingestar` internamente:
   - Detectar el modo por la ruta (CREAR vs RECONCILIACION — ver `/ingestar`)
   - Detectar tipo (digital vs fotografiado)
   - Crear/actualizar paginas wiki
   - Actualizar index.md y log.md
5. **Control de sesion:** ver "Tamano de sesion" mas abajo. Si el contexto supera el 60% de
   capacidad, informar al usuario, hacer commit, y sugerir continuar en una nueva sesion.

En modo reconciliacion, el **gate de aprobacion de `/ingestar` sigue vigente por cada PDF**: el
batch no lo saltea ni lo agrupa. Se muestra el diff de un PDF, se espera confirmacion, se escribe,
y recien ahi se pasa al siguiente.

---

## Orden de ingest — material historico (`raw/` fuera de `cursada_*/`)

Este orden sigue vigente y no cambia. Aplica si se ingesta todo desde cero:

1. `raw/parciales/1P/` y `raw/parciales/2P/` — **primero siempre**
2. `raw/clases/teo/` — por numero cronologico
3. `raw/clases/prac/` — por numero cronologico
4. `raw/guias_practicas/` — por numero cronologico
5. `raw/contenido_comunidad/` — al final

Los parciales van primero porque son la base para decidir **que ejercicios y temas son
importantes**: permiten que las banderas "¿Aparece en parciales?" se completen correctamente al
ingestar clases y guias. Ese principio es el eje del wiki y no se toca.

**Estado en `tda/`: los 6 parciales ya estan ingestados** y `wiki/tipos_ejercicio/` ya existe con
sus patrones. La base de evaluacion esta puesta; no hay que rehacer este paso.

---

## Orden de ingest — cursada vigente (`raw/cursada_*/`)

El material de la cursada vigente es la fuente de verdad del contenido. Su orden es distinto
porque el objetivo tambien lo es: no se construye desde cero, se **contrasta** contra lo que ya hay.

**Paso 0 — Senal de evaluacion.** Ya cubierto por los parciales historicos ingestados. Si en algun
momento la catedra reparte parciales viejos, enunciados modelo o listas de ejercicios obligatorios,
**eso entra primero**, antes que cualquier teorica.

Despues, dentro de la cursada:

1. `raw/cursada_<vigencia>/teo/` — teoricas: definen **notacion y alcance**
2. `raw/cursada_<vigencia>/prac/` — practicas: que se resuelve en clase
3. `raw/cursada_<vigencia>/guias/` — guias: matching de ejercicios + banderas
4. **Re-correr `/tipos_ejercicio`** — los ejercicios nuevos que traigan las guias necesitan su
   bandera cruzada contra `parciales_analizados/`, igual que los viejos

Las teoricas van antes que las guias por una razon concreta: si cambio la notacion o el alcance,
hay que saberlo **antes** de empezar a machear ejercicios. Al reves, hay que rehacer el matching.

Esto no compite con el paso 0 — es un orden *dentro* de la cursada, sobre una base de parciales
que ya esta puesta.

---

## Tamano de sesion

El ingest consume contexto acumulativamente.

**Modo CREAR** (material historico):

- PDFs cortos (parciales, transcripciones): hasta 6
- PDFs medianos (clases teo/prac, ~100-200 pags Beamer): 3-4
- PDFs largos (guias con muchos ejercicios): 2-3
- PDFs fotografiados (vision): 2-3

**Modo RECONCILIACION** (cursada vigente) — mas chico, porque cada PDF exige leer la pagina
existente completa + el PDF nuevo + diffear + sostener el diff hasta la aprobacion:

- Teoricas y practicas: **2 por sesion**
- Guias: **1 por sesion** (el matching por enunciado de decenas de ejercicios es lo mas pesado)

---

## Resumibilidad

El ingest es resumible: cada sesion continua desde donde termino la anterior. Nunca reingestar un
archivo que ya aparece en log.md.

En modo reconciliacion, si una sesion se corta despues de mostrar el diff pero antes de escribir,
el PDF **no** quedo ingestado: no hay entrada en log.md y hay que rehacer el diff. El log se
escribe recien despues de aplicar los cambios.
