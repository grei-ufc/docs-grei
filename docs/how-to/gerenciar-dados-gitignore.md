# Como Gerenciar Dados Científicos e Configurar o `.gitignore`

Em pesquisas de Engenharia Elétrica — seja em aquisições de alta frequência com osciloscópios, simulações no Simulink, medições de qualidade de energia ou treinamento de modelos —, os arquivos de dados (`.csv`, `.mat`, `.parquet`, `.tdms`, `.h5`) e artefatos de compilação facilmente atingem centenas de megabytes.

O **Git** foi projetado para rastrear código-fonte em texto, e **não** bancos de dados volumosos ou binários compilados. Este guia mostra como configurar um `.gitignore` robusto para projetos em **Python, Julia, MATLAB/Simulink e C/C++**.

## Problema

Você estruturou o seu repositório de pesquisa, mas precisa evitar que arquivos de dados gigantes, pastas temporárias do Simulink, executáveis compilados em C/C++ ou ambientes virtuais sejam enviados acidentalmente para o GitHub ao rodar `git add .`.

## Solução: `.gitignore` Científico + `.gitkeep`

### Passo 1: Entenda o que NUNCA Deve Ir para o Git

| Categoria | Exemplos de Arquivos / Pastas | Por que ignorar no Git? |
| :--- | :--- | :--- |
| **Ambientes e Caches (Python / Julia)** | `.venv/`, `__pycache__/`, `.pytest_cache/`, `*.jl.cov`, `*.jl.mem` | São recriados automaticamente em cada computador a partir do `uv.lock` ou `Manifest.toml`. |
| **Temporários do MATLAB / Simulink** | `slprj/`, `*.slxc`, `*.asv`, `*.mex*`, `simulink/` | São caches de compilação e *autosaves* gerados localmente pelo MATLAB/Simulink a cada simulação. |
| **Binários Compilados (C / C++)** | `build/`, `.pio/`, `*.o`, `*.obj`, `*.exe`, `*.elf`, `*.bin`, `*.hex` | Dependem da arquitetura do processador local e devem ser gerados pelo `CMake` ou `PlatformIO`. |
| **Dados Científicos Pesados** | `*.csv`, `*.mat`, `*.parquet`, `*.h5`, `*.tdms`, `*.wav` | O GitHub bloqueia arquivos maiores que `100 MB`. Dados pesados devem ficar em armazenamento institucional (Drive / OneDrive / Zenodo). |
| **Credenciais e Segredos** | `.env`, `credenciais.json`, chaves de API | Risco grave de segurança se publicados em repositórios abertos. |

!!! tip "Exceção: Pequenos arquivos de amostra"
    É uma ótima prática versionar um único arquivo pequeno de amostra (ex: `data/sample_sinal_60hz.csv` menor que `500 KB`) apenas para que avaliadores e testes automatizados possam executar um exemplo rápido sem precisar baixar gigabytes de dados.

### Passo 2: Template Oficial de `.gitignore` Multilíngue do GREI-UFC

Copie e cole o modelo abaixo no arquivo `.gitignore` localizado na raiz do seu projeto (ele já contempla Python, Julia, MATLAB/Simulink, C/C++ e MkDocs):

```gitignore title=".gitignore"
# ==========================================================
# 1. Python (uv, pytest, Ruff, Jupyter)
# ==========================================================
.venv/
venv/
ENV/
__pycache__/
*.py[cod]
*$py.class
.pytest_cache/
.ruff_cache/
.mypy_cache/
.coverage
.ipynb_checkpoints/

# ==========================================================
# 2. Julia
# ==========================================================
*.jl.cov
*.jl.*.cov
*.jl.mem
deps/build.log

# ==========================================================
# 3. MATLAB / Simulink / GNU Octave
# ==========================================================
*.asv
*.mex*
*.slxc
slprj/
simulink/
octave-workspace

# ==========================================================
# 4. C / C++ e Sistemas Embarcados (CMake, PlatformIO, CCS)
# ==========================================================
build/
.pio/
*.o
*.obj
*.d
*.so
*.dll
*.dylib
*.exe
*.out
*.elf
*.bin
*.hex
*.map

# ==========================================================
# 5. Documentação (MkDocs)
# ==========================================================
site/

# ==========================================================
# 6. Dados Científicos Pesados (mantém estrutura com .gitkeep)
# ==========================================================
data/raw/*
data/processed/*
!data/raw/.gitkeep
!data/processed/.gitkeep

*.mat
*.tdms
*.h5
*.hdf5
*.parquet

# ==========================================================
# 7. Segredos, Sistema Operacional e Editores
# ==========================================================
.env
.env.*
.DS_Store
Thumbs.db
.vscode/
.idea/
```

### Passo 3: Preserve as Pastas Vazias de Dados com `.gitkeep`

Por padrão, o Git não rastreia pastas completamente vazias. Como ignoramos o conteúdo dentro de `data/raw/*` e `data/processed/*`, criamos um arquivo vazio chamado `.gitkeep` dentro de cada uma delas para que a estrutura de pastas seja mantida no GitHub:

=== "Windows (PowerShell)"

    ```powershell
    New-Item -ItemType File -Path data/raw/.gitkeep, data/processed/.gitkeep -Force
    ```

=== "Linux e macOS"

    ```bash
    touch data/raw/.gitkeep data/processed/.gitkeep
    ```

Depois, adicione e faça o *commit* da estrutura:

```bash
git add .gitignore data/raw/.gitkeep data/processed/.gitkeep
git commit -m "chore: configura gitignore cientifico e estrutura de pastas data"
```

---

## Veja Também

* 🎓 **Estrutura de pastas:** [Tutorial 3: Estruturando seu Primeiro Projeto de Engenharia](../tutorials/estrutura-projeto.md)
* 🛠️ **Guias por linguagem:** [Julia](projetos-julia.md), [MATLAB/Octave](projetos-matlab-octave.md) e [C/C++](projetos-c-cpp.md)
* 📖 **Referência:** [Estrutura de Arquivos do Projeto](../reference/estrutura-arquivos.md) e [Solução de Problemas Comuns](../reference/solucao-problemas.md)
