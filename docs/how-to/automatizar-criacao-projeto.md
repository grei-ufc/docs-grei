# Como Automatizar a Criação do Diretório de Trabalho (Scripts `.ps1` e `.sh`)

Criar manualmente todas as pastas (`src/`, `tests/`, `data/raw/`, `data/processed/`, `docs/`), configurar o `.gitignore` científico, adicionar a licença `MIT`, preparar o `mkdocs.yml` e inicializar o Git a cada novo projeto de pesquisa pode ser trabalhoso e sujeito a esquecimentos.

Para padronizar todos os repositórios do **GREI-UFC**, disponibilizamos dois scripts oficiais de automação (*scaffolding*) — um em **:material-powershell: PowerShell (`.ps1`) para Windows** e outro em **:simple-gnubash: Bash (`.sh`) para Linux e macOS** — que constroem todo o diretório de trabalho em menos de um segundo!

## Problema

Você vai iniciar um novo projeto de Iniciação Científica, TCC ou Pós-graduação (em :simple-python: **Python**, :simple-julia: **Julia**, :simple-octave: **MATLAB/Octave** ou :simple-c: :simple-cplusplus: **C/C++**) e quer gerar automaticamente toda a estrutura de diretórios, arquivos de configuração, código de exemplo com teste unitário (padrão AAA) e repositório Git já inicializado na branch `main`.

## Solução: Scripts Oficiais `init-projeto-grei`

### Passo 1: Baixe o Script para o seu Sistema Operacional

Você pode baixar os scripts diretamente pelos links abaixo (ou encontrá-los na pasta `scripts/` deste repositório):

* :fontawesome-brands-windows: **Windows (PowerShell):** [**⬇️ Baixar `init-projeto-grei.ps1`**](../assets/scripts/init-projeto-grei.ps1){ :download="init-projeto-grei.ps1" }
* :simple-linux: :simple-apple: **Linux / macOS (Bash):** [**⬇️ Baixar `init-projeto-grei.sh`**](../assets/scripts/init-projeto-grei.sh){ :download="init-projeto-grei.sh" }

---

### Passo 2: Execute o Script Escolhendo o Nome e a Linguagem

Ambos os scripts recebem dois parâmetros e suportam nomes de pastas no padrão **`kebab-case`** (ex: `nome-teste`, `controle-inversor`) ou `snake_case`:

1. **`NomeProjeto`** (opcional, padrão: `meu-projeto-grei`): Nome da pasta que será criada. O script converte automaticamente os hifens nos arquivos internos de cada linguagem (ex: `nome-teste` no `pyproject.toml`, `NomeTeste` no `Project.toml` da Julia e `nome_teste` no `CMakeLists.txt` do C/C++).
2. **`Linguagem`** (opcional, padrão: `python`): Aceita **`python`**, **`julia`**, **`matlab`** ou **`c`**.

Abra o terminal na pasta onde deseja criar o projeto e execute:

=== ":fontawesome-brands-windows: Windows (PowerShell)"

    ```powershell
    # Cria um projeto em Python (padrão) com nome em kebab-case
    powershell -ExecutionPolicy Bypass -File .\init-projeto-grei.ps1 controle-inversor

    # Ou especifique outra linguagem científica (julia, matlab ou c):
    powershell -ExecutionPolicy Bypass -File .\init-projeto-grei.ps1 fluxo-potencia julia
    powershell -ExecutionPolicy Bypass -File .\init-projeto-grei.ps1 conversor-buck matlab
    powershell -ExecutionPolicy Bypass -File .\init-projeto-grei.ps1 pll-embarcado c
    ```

    !!! tip "Execução direta caso a política do PowerShell já esteja liberada"
        Se você já configurou `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` no seu Windows, pode rodar diretamente:
        ```powershell
        .\init-projeto-grei.ps1 nome-teste python
        ```

=== ":simple-linux: Linux e :simple-apple: macOS (Bash)"

    ```bash
    # Conceda permissão de execução ao script (apenas na primeira vez)
    chmod +x init-projeto-grei.sh

    # Cria um projeto em Python (padrão) com nome em kebab-case
    ./init-projeto-grei.sh controle-inversor

    # Ou especifique outra linguagem científica (julia, matlab ou c):
    ./init-projeto-grei.sh fluxo-potencia julia
    ./init-projeto-grei.sh conversor-buck matlab
    ./init-projeto-grei.sh pll-embarcado c
    ```

---

## O que o Script Gera Automaticamente?

Ao ser executado, o script realiza **6 etapas automatizadas**:

1. **Hierarquia de Pastas Padrão:** Cria `data/raw/` e `data/processed/` (já com arquivos `.gitkeep`), `docs/` subdividida nos 4 quadrantes **Diátaxis** (`explanation/`, `tutorials/`, `how-to/`, `reference/`) e `.github/workflows/`.
2. **Governança e Proteção de Dados:** Gera o arquivo [`.gitignore`](gerenciar-dados-gitignore.md) científico multilíngue e a licença aberta [`LICENSE`](escolher-licenca.md) (MIT — GREI-UFC).
3. **Portal de Documentação + CI/CD:** Gera o `mkdocs.yml` configurado com o tema Material em português, a página inicial `docs/index.md` e o workflow `.github/workflows/deploy.yml` para publicação automática no GitHub Pages.
4. **Arquitetura Específica da Linguagem Escolhida:**
   * :simple-python: **Python (`python`):** Cria `src/`, `tests/`, `notebooks/`, `.python-version` (`3.12`), `.pre-commit-config.yaml` e `pyproject.toml` já configurado com `pytest`, `ruff`, `mkdocs-material` e `pythonpath = ["."]`.
   * :simple-julia: **Julia (`julia`):** Cria `src/`, `test/`, `scripts/` e `Project.toml`.
   * :simple-octave: **MATLAB / Octave (`matlab`):** Cria `src/`, `tests/`, `scripts/`, `models/` e o script `startup.m` que configura o *path* automaticamente.
   * :simple-c: :simple-cplusplus: **C / C++ (`c`):** Cria `include/`, `src/`, `tests/` e o `CMakeLists.txt` integrado ao `CTest`.
5. **Código Inicial + Teste Unitário (Padrão AAA):** Cria uma função matemática documentada com unidades físicas em `src/` e seu respectivo teste automatizado em `tests/` pronto para rodar!
6. **Inicialização do Git:** Executa `git init`, define a branch principal como `main`, adiciona todos os arquivos e registra o primeiro *commit* semântico (`feat: inicializa estrutura padrao do projeto GREI-UFC`).

---

## Código-Fonte dos Scripts

Caso prefira copiar e colar o código diretamente, clique abaixo para expandir o script correspondente ao seu sistema operacional:

??? abstract "Ver código completo do script Windows PowerShell (`scripts/init-projeto-grei.ps1`)"

    ````powershell title="scripts/init-projeto-grei.ps1"
    --8<-- "scripts/init-projeto-grei.ps1"
    ````

??? abstract "Ver código completo do script Linux / macOS Bash (`scripts/init-projeto-grei.sh`)"

    ````bash title="scripts/init-projeto-grei.sh"
    --8<-- "scripts/init-projeto-grei.sh"
    ````

---

## Veja Também

* 🎓 **Entenda a estrutura:** [Tutorial 3: Estruturando seu Primeiro Projeto de Engenharia](../tutorials/estrutura-projeto.md)
* 🛠️ **Guias por linguagem:** [:simple-julia: Projetos em Julia](projetos-julia.md), [:simple-octave: Projetos em MATLAB/Octave](projetos-matlab-octave.md) e [:simple-c: :simple-cplusplus: Projetos em C/C++](projetos-c-cpp.md)
* 📖 **Referência:** [Estrutura de Arquivos do Projeto](../reference/estrutura-arquivos.md)
