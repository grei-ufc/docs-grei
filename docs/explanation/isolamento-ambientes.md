# Isolamento de Ambientes e Gestão de Dependências

No desenvolvimento de projetos computacionais, a integridade do ambiente de software é tão crítica quanto a calibração dos instrumentos físicos da bancada. Este documento explora o conceito de isolamento de ambientes e como cada ecossistema científico resolve o histórico problema de gestão de pacotes e compilação.

## O "Inferno de Dependências"

Um erro clássico cometido por pesquisadores iniciantes é instalar bibliotecas diretamente na instalação global do sistema operacional (ou adicionar pastas manualmente nas configurações globais de uma IDE). Essa prática cria um problema sistêmico conhecido como **"inferno de dependências"** (*dependency hell*).

Considere um cenário comum em um laboratório de Engenharia Elétrica:

* O **Projeto A** (uma simulação de eletrônica de potência do ano passado) exige a versão `1.10` de uma biblioteca científica.
* O **Projeto B** (um novo algoritmo de estimação fasorial) exige a versão `2.0` da mesma biblioteca, na qual várias funções antigas foram renomeadas.
* Ao instalar a versão `2.0` globalmente no computador, o pesquisador quebra inadvertidamente o **Projeto A**, impossibilitando a reprodução de resultados de artigos já publicados.

## A Solução: Ambientes Isolados por Projeto

Para eliminar esse conflito, a engenharia de software moderna adota o princípio de **isolamento por projeto**. Cada repositório de pesquisa funciona como uma "bolha" independente, registrando em arquivos de texto exatamente quais bibliotecas e versões são exigidas.

Dessa forma, os requisitos de uma pesquisa não interferem no sistema operacional nem em outros projetos do laboratório, garantindo total [reprodutibilidade científica](reproducibilidade.md).

## Como Cada Linguagem Científica Resolve o Isolamento

Embora nossos tutoriais iniciais utilizem Python como exemplo base, o princípio de isolamento e reprodutibilidade aplica-se a todas as linguagens utilizadas no **GREI-UFC**:

| Linguagem | Gerenciador / Ferramenta | Arquivo de Declaração | Arquivo de Trava (*Lockfile*) | Comando para Reproduzir Ambiente |
| :--- | :--- | :--- | :--- | :--- |
| :simple-python: **Python** | [`uv`](../tutorials/setup-uv.md) | `pyproject.toml` | `uv.lock` | `uv sync` |
| :simple-julia: **Julia** | [`Pkg` (nativo)](../how-to/projetos-julia.md) | `Project.toml` | `Manifest.toml` | `julia --project=. -e 'using Pkg; Pkg.instantiate()'` |
| :simple-octave: **MATLAB / Octave** | [`startup.m` / Projects](../how-to/projetos-matlab-octave.md) | `README.md` (versão + Toolboxes) | — | Executar `startup.m` ao abrir a pasta raiz |
| :simple-c: :simple-cplusplus: **C / C++** | [`CMake` / `PlatformIO`](../how-to/projetos-c-cpp.md) | `CMakeLists.txt` ou `platformio.ini` | `platformio.ini` (versões fixas) | `cmake -B build && cmake --build build` ou `pio run` |

## A Revolução do `uv` no Ecossistema Python

No :simple-python: **Python**, gerenciar essas bolhas exigia historicamente o domínio de várias ferramentas fragmentadas (`venv`, `pip`, `pyenv`, `pip-tools` ou `conda`). Atualmente, o ecossistema consolidou essas funções no **`uv`**, um gerenciador de pacotes e projetos desenvolvido pela Astral e escrito em Rust:

1. **Velocidade e Eficiência:** Resolve dependências e cria ambientes virtuais (`.venv`) dezenas de vezes mais rápido que as ferramentas tradicionais, utilizando um cache global inteligente.
2. **Determinismo com `uv.lock`:** Ao adicionar uma biblioteca (`uv add`), o `uv` atualiza o `pyproject.toml` e gera o arquivo `uv.lock`, gravando versões exatas e *hashes* criptográficos de toda a árvore de pacotes.
3. **Execução Transparente (`uv run`):** Garante que qualquer script (ex: `uv run simular_circuito.py`) seja executado estritamente dentro da bolha `.venv` do projeto.

!!! warning "Regra de Ouro no Laboratório"
    * :simple-python: **Em Python:** Nunca use `pip install` global; use sempre `uv add` e `uv run`.
    * :simple-julia: **Em Julia:** Nunca instale pacotes de pesquisa no ambiente global `@v1.x`; ative sempre o projeto local com `julia --project=.`.
    * :simple-octave: **Em MATLAB/Octave:** Nunca dependa do botão manual *Set Path*; versione um script `startup.m` na raiz do repositório.

---

## Veja Também

* 💡 **Próximo conceito:** [Arquitetura da Informação: A Filosofia Diátaxis](filosofia-diataxis.md)
* 🎓 **Na prática (Python):** [Tutorial 1: Configurando seu Ambiente com `uv`](../tutorials/setup-uv.md)
* 🛠️ **Guias por linguagem:** [:simple-julia: Projetos em Julia](../how-to/projetos-julia.md), [:simple-octave: Projetos em MATLAB/Octave](../how-to/projetos-matlab-octave.md) e [:simple-c: :simple-cplusplus: Projetos em C/C++](../how-to/projetos-c-cpp.md)
