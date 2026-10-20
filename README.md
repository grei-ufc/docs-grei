# Guia de Projetos Computacionais — GREI-UFC

[![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Julia](https://img.shields.io/badge/Julia-9558B2?logo=julia&logoColor=white)](https://julialang.org/)
[![MATLAB / Octave](https://img.shields.io/badge/MATLAB%20%2F%20Octave-0790C0?logo=gnuoctave&logoColor=white)](https://octave.org/)
[![C](https://img.shields.io/badge/C-A8B9CC?logo=c&logoColor=black)](https://en.cppreference.com/w/c)
[![C++](https://img.shields.io/badge/C%2B%2B-00599C?logo=cplusplus&logoColor=white)](https://isocpp.org/)
[![uv](https://img.shields.io/badge/uv-Astral-DE5FE9?logo=astral&logoColor=white)](https://docs.astral.sh/uv/)
[![MkDocs Material](https://img.shields.io/badge/MkDocs-Material-526CFE?logo=materialformkdocs&logoColor=white)](https://squidfunk.github.io/mkdocs-material/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Repositório oficial de diretrizes (*guidelines*) para estruturação de projetos computacionais, controle de versão, reprodutibilidade e documentação científica dos projetos de pesquisa do **GREI-UFC** (Grupo de Redes Elétricas Inteligentes — Universidade Federal do Ceará).

Abrange fluxos de trabalho científicos em **Python**, **Julia**, **MATLAB/Simulink & GNU Octave** e **C/C++ (Simulação e Sistemas Embarcados)**.

## Sobre o Guia

Este material foi estruturado seguindo a arquitetura de informação **Diátaxis** e voltado para estudantes de Iniciação Científica, TCC e Pós-graduação em Engenharia Elétrica:

- **Explicação (`docs/explanation/`):** Fundamentos de reprodutibilidade computacional, controle de versão (Git/GitHub e Conventional Commits), isolamento de ambientes, filosofia Diátaxis e testes automatizados (padrão AAA).
- **Tutoriais (`docs/tutorials/`):** Passo a passo prático desde a configuração do `uv` e primeiros passos no Git até a estruturação de diretórios (`src/`), documentação com MkDocs e testes com `pytest`.
- **Guias Práticos (`docs/how-to/`):** Receitas diretas para:
  - **Automação de Projetos (`scripts/`):** Criação automatizada do diretório de trabalho com scripts PowerShell (`.ps1`) e Bash (`.sh`).
  - **Outras Linguagens Científicas:** Projetos em **Julia** (`Pkg`), **MATLAB/Simulink e Octave** (`startup.m`) e **C/C++ e Embarcados** (`CMake` / `PlatformIO`).
  - **Python e Produtividade:** Gerenciamento de dependências, Jupyter Notebooks com `uv`, `pre-commit` + `Ruff` e documentação automática com Docstrings (`mkdocstrings`).
  - **Versionamento e Governança:** Fluxo de Branches/PRs/Releases, resolução de conflitos de merge, gestão de dados científicos (`.gitignore`), publicação no GitHub Pages, escrita de `README.md` e escolha de licenças.
- **Referência (`docs/reference/`):** Tabelas de consulta rápida de comandos `uv` e `Git`, estrutura de arquivos multilíngue, convenções de nomenclatura (Python, Julia, MATLAB e C/C++), FAQ de solução de problemas e glossário técnico.

## Scripts de Criação Automática de Projetos (`scripts/`)

Você pode gerar um novo repositório científico completo (com pastas `src/`, `tests/`, `data/`, `docs/`, `.gitignore`, `LICENSE`, `mkdocs.yml`, código exemplo, teste unitário e `git init` na branch `main`) executando os scripts da pasta [`scripts/`](scripts/):

- **Windows (PowerShell):**
  ```powershell
  powershell -ExecutionPolicy Bypass -File .\scripts\init-projeto-grei.ps1 meu-projeto python
  ```
- **Linux e macOS (Bash):**
  ```bash
  ./scripts/init-projeto-grei.sh meu-projeto python
  ```
  *(Linguagens suportadas no 2º parâmetro: `python`, `julia`, `matlab`, `c`)*.

## Como Visualizar a Documentação Localmente

1. Clone o repositório e sincronize o ambiente isolado utilizando o [`uv`](https://docs.astral.sh/uv/):

```bash
git clone https://github.com/grei-ufc/docs-grei.git
cd docs-grei
uv sync
```

2. Inicie o servidor de desenvolvimento do MkDocs:

```bash
uv run mkdocs serve
```

3. Acesse `http://127.0.0.1:8000` no navegador para visualizar a documentação em tempo real.

## Licença

Distribuído sob a licença MIT. Veja o arquivo [`LICENSE`](LICENSE) para mais informações.
