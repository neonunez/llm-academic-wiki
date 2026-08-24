# llm-academic-wiki

Sistema de wikis academicas personales basado en el patron [LLM Wiki de Andrej Karpathy](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), adaptado para estudio universitario.

## Concepto

El LLM ingesta PDFs academicos (clases LaTeX, guias de ejercicios, parciales) y compila el conocimiento en una wiki de markdown navegable con Obsidian. El LLM escribe y mantiene la wiki; el usuario la consulta y navega.

## Estructura

```
llm-academic-wiki/
├── .claude/commands/           ← slash commands (compartidos)
├── .agents/workflows/          ← symlink a .claude/commands/
├── tda/                                ← materia piloto (Tecnicas de Diseno de Algoritmos)
│   ├── CLAUDE.md              ← esquema de la materia
│   ├── index.md               ← catalogo del wiki
│   ├── log.md                 ← registro de operaciones
│   ├── programa.md            ← temas por parcial + cursada vigente
│   ├── raw/                   ← PDFs originales (inmutables)
│   │   └── cursada_2C_2026/   ← material del cuatrimestre en curso (autoridad)
│   ├── wiki/                  ← contenido generado por el LLM
│   └── cursada_actual/        ← informes de /priorizar (analisis, no wiki)
└── [otras materias]/          ← misma estructura, independientes
```

Cada materia tiene su propio `CLAUDE.md`, `programa.md`, `index.md`, `log.md`, `raw/` y `wiki/` — completamente independientes entre si.

`cursada_actual/` es la excepcion deliberada: guarda los informes de `/priorizar`, que analizan material
de la cursada **sin ingestarlo**. Es descartable y regenerable — no forma parte del wiki compilado.

## Uso

Inicializar Claude Code desde la carpeta de la materia a estudiar:

```bash
cd llm-academic-wiki/tda/
claude
```

## Herramientas

- **Claude Code** — LLM agent + vision para PDFs imagen
- **Obsidian** — IDE para navegar el wiki
- **pdftotext (poppler)** — extraccion de texto de PDFs LaTeX
- **Git** — control de versiones
