# Estrutura de Arquivos do Projeto

Lista dos arquivos e diretórios fundamentais em uma arquitetura de software de pesquisa e suas regras de versionamento no Git.

## 1. Arquivos Universais (Presentes em Todos os Projetos)

| Arquivo / Pasta | Função Técnica | Deve ser versionado no Git? |
| :--- | :--- | :--- |
| **`README.md`** | Apresentação pública, contexto científico e instruções rápidas de instalação e execução do repositório. | ✅ **Sim** |
| **`LICENSE`** | Documento legal (ex: MIT, GPLv3) que define os termos de uso, modificação e distribuição da pesquisa. | ✅ **Sim** |
| **`.gitignore`** | Lista arquivos e diretórios que o Git deve ignorar (ambientes virtuais, binários, caches e dados pesados). | ✅ **Sim** |
| **`src/`** | Diretório contendo o código-fonte modular (funções matemáticas, algoritmos de controle e modelos). | ✅ **Sim** |
| **`tests/`** (ou `test/`) | Diretório contendo os scripts de validação e testes automatizados do projeto. | ✅ **Sim** |
| **`docs/` e `mkdocs.yml`** | Arquivos Markdown de documentação e configuração do portal MkDocs. | ✅ **Sim** |
| **`site/`** | Pasta gerada localmente pelo MkDocs ao compilar o HTML estático da documentação. | ❌ **NUNCA** (incluir no `.gitignore`) |

---

## 2. Arquivos Específicos por Linguagem

| Linguagem | Arquivo / Pasta | Função Técnica | Versionar no Git? |
| :--- | :--- | :--- | :--- |
| :simple-python: **Python** | `pyproject.toml` | Metadados do projeto, dependências principais e configurações (`pytest`, `Ruff`). | ✅ **Sim** |
| :simple-python: **Python** | `uv.lock` e `.python-version` | Versões exatas + *hashes* de todos os pacotes instalados e versão fixada do Python. | ✅ **Sim** |
| :simple-python: **Python** | `.venv/` e `__pycache__/` | Ambiente virtual local e bytecodes compilados na máquina do usuário. | ❌ **NUNCA** |
| :simple-julia: **Julia** | `Project.toml` | Declaração das dependências diretas e compatibilidade do projeto Julia. | ✅ **Sim** |
| :simple-julia: **Julia** | `Manifest.toml` | Árvore completa e exata de versões de todos os pacotes da simulação. | ✅ **Sim** |
| :simple-octave: **MATLAB / Octave** | `startup.m` | Script de inicialização que adiciona `src/`, `scripts/` e `models/` ao *path* automaticamente. | ✅ **Sim** |
| :simple-octave: **MATLAB / Simulink** | `models/*.slx` | Diagramas de blocos do Simulink (acompanhados de script `.m` de parâmetros). | ✅ **Sim** |
| :simple-octave: **MATLAB / Simulink** | `slprj/`, `*.slxc`, `*.asv` | Pastas temporárias de compilação do Simulink e arquivos de salvamento automático. | ❌ **NUNCA** |
| :simple-c: :simple-cplusplus: **C / C++** | `include/*.h` e `src/*.c` | Arquivos de cabeçalho (interface) e implementação do código-fonte. | ✅ **Sim** |
| :simple-c: :simple-cplusplus: **C / C++** | `CMakeLists.txt` / `platformio.ini` | Configuração reprodutível de compilação (*build*) e dependências de firmware. | ✅ **Sim** |
| :simple-c: :simple-cplusplus: **C / C++** | `build/`, `.pio/`, `*.o`, `*.elf`, `*.hex` | Pastas de compilação, objetos intermediários e binários executáveis. | ❌ **NUNCA** |

---

## Guias Relacionados

* 🎓 **Passo a passo:** [Tutorial 3: Estruturando seu Primeiro Projeto de Engenharia](../tutorials/estrutura-projeto.md)
* 🛠️ **Configuração de `.gitignore`:** [Como Gerenciar Dados Científicos e Configurar o `.gitignore`](../how-to/gerenciar-dados-gitignore.md)
* 🛠️ **Guias por linguagem:** [:simple-julia: Julia](../how-to/projetos-julia.md), [:simple-octave: MATLAB/Octave](../how-to/projetos-matlab-octave.md) e [:simple-c: :simple-cplusplus: C/C++](../how-to/projetos-c-cpp.md)
