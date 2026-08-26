# /priorizar

Implementacion canonica: `.agents/skills/priorizar/SKILL.md` en la raiz del repositorio.

Argumentos: `$ARGUMENTS`

1. Determinar la raiz con `git rev-parse --show-toplevel`.
2. Leer completamente `<raiz>/.agents/skills/priorizar/SKILL.md`.
3. Seguir la skill y cargar sus referencias segun el tipo declarado.
4. Ejecutarla con estos argumentos del usuario:

```text
$ARGUMENTS
```

Si los argumentos son invalidos, mostrar:

```text
/priorizar <teoria|practica|guia> <ruta_pdf> [--dry]
```
