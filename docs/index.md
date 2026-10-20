# Bem-vindo ao Guia de Projetos Computacionais — GREI-UFC

![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)
![Julia](https://img.shields.io/badge/Julia-9558B2?logo=julia&logoColor=white)
![MATLAB / Octave](https://img.shields.io/badge/MATLAB%20%2F%20Octave-0790C0?logo=gnuoctave&logoColor=white)
![C](https://img.shields.io/badge/C-A8B9CC?logo=c&logoColor=black)
![C++](https://img.shields.io/badge/C%2B%2B-00599C?logo=cplusplus&logoColor=white)

O avanço da ciência moderna está intrinsecamente ligado à capacidade de processar, analisar e compartilhar informações de forma digital. Seja modelando sistemas elétricos de potência, implementando controle digital em microcontroladores ou analisando sinais de sensores, a programação tornou-se uma ferramenta indispensável na Engenharia Elétrica.

No entanto, a transição para fluxos de trabalho digitais traz desafios significativos, especialmente para pesquisadores iniciantes que, embora dominem suas áreas de estudo, frequentemente carecem de treinamento formal em práticas de engenharia de software e gestão de dados. O resultado? O clássico problema do *"funciona na minha máquina"*, no qual um código falha ao ser executado pelo orientador ou por colegas devido a diferenças sutis nas versões instaladas ou caminhos quebrados.

Este guia do **GREI-UFC (Grupo de Redes Elétricas Inteligentes)** foi criado para resolver exatamente isso. Aqui, você aprenderá a transformar "trabalhos no computador" desorganizados em projetos científicos rigorosos, transparentes e, acima de tudo, **reprodutíveis**.

## Linguagens Científicas Suportadas

<div class="grid cards" markdown>

-   :simple-python:{ .lg .middle } **Python**

    ---

    Processamento de sinais, ciência de dados, aprendizado de máquina e automação com ambientes isolados via `uv`, `pytest` e `Ruff`.

    [:octicons-arrow-right-24: Começar pelo Tutorial 1](tutorials/setup-uv.md)

-   :simple-julia:{ .lg .middle } **Julia**

    ---

    Otimização de sistemas de potência (`JuMP.jl`, `PowerModels.jl`) e equações diferenciais de alto desempenho com `Pkg` (`Project.toml` e `Manifest.toml`).

    [:octicons-arrow-right-24: Guia de Projetos em Julia](how-to/projetos-julia.md)

-   :simple-octave:{ .lg .middle } **MATLAB / Simulink & GNU Octave**

    ---

    Modelagem de conversores, controle clássico/moderno e diagramas de blocos `.slx` versionáveis com inicialização automática via `startup.m`.

    [:octicons-arrow-right-24: Guia de MATLAB e Octave](how-to/projetos-matlab-octave.md)

-   :simple-c:{ .lg .middle } :simple-cplusplus:{ .lg .middle } **C / C++ e Embarcados**

    ---

    Firmware de tempo real para DSPs (TI C2000, STM32, ESP32) e simulação numérica com arquitetura desacoplada, `CMake`, `CTest` e `PlatformIO`.

    [:octicons-arrow-right-24: Guia de C/C++ e Embarcados](how-to/projetos-c-cpp.md)

</div>

## Para quem é este guia?

Este material foi especificamente elaborado para **estudantes (Iniciação Científica, TCC ou Pós-graduação)** que possuem pouca ou nenhuma experiência prévia com engenharia de software, versionamento de código ou documentação técnica.

!!! tip "Você está no lugar certo se..."
    Já se viu perdido tentando lembrar qual versão de um script gerou o gráfico do seu relatório, ou teve medo de alterar um código que estava funcionando e acabar estragando tudo antes da reunião com seu orientador.

## Como este site está organizado?

Para evitar a confusão comum de misturar teoria densa com passos práticos, este guia adota a metodologia [**Diátaxis**](explanation/filosofia-diataxis.md). Todo o conteúdo está dividido em quatro quadrantes, dependendo do que você precisa no momento:

* 🎓 **Tutoriais (Comece por aqui):** Lições práticas e passo a passo (usando :simple-python: Python e :simple-git: Git como fio condutor). O objetivo é guiar você pela mão e garantir que seu [ambiente isolado com `uv`](tutorials/setup-uv.md), seu [primeiro repositório Git](tutorials/primeiro-git.md), a [estrutura de pastas](tutorials/estrutura-projeto.md), a [documentação com MkDocs](tutorials/documentando-mkdocs.md) e os [testes com `pytest`](tutorials/testando-pytest.md) funcionem perfeitamente.
* 🛠️ **Guias Práticos (How-To):** Receitas diretas para tarefas do dia a dia no laboratório:
    * **Automação de Projetos (:material-powershell: `.ps1` e :simple-gnubash: `.sh`):** [Como criar automaticamente toda a estrutura do diretório de trabalho](how-to/automatizar-criacao-projeto.md) no Windows e Linux/macOS.
    * **Linguagens Científicas:** Como estruturar, isolar ambientes e testar [:simple-julia: Projetos em Julia](how-to/projetos-julia.md), [:simple-octave: Projetos em MATLAB/Simulink e GNU Octave](how-to/projetos-matlab-octave.md) e [:simple-c: :simple-cplusplus: Projetos em C/C++ e Sistemas Embarcados](how-to/projetos-c-cpp.md).
    * **Ambiente Python e Notebooks:** [Gerenciar dependências com `uv`](how-to/adicionar-dependencia.md), [Usar Jupyter Notebooks com `uv`](how-to/usar-jupyter-uv.md), [Configurar Ruff e pre-commit](how-to/configurar-precommit-ruff.md) e [Documentar funções com Docstrings](how-to/documentar-codigo-docstrings.md).
    * **Versionamento, Dados e Governança:** [Branches, Pull Requests e Releases](how-to/fluxo-branches-pull-requests.md), [Resolver conflitos no Git](how-to/resolver-conflitos-git.md), [Gerenciar dados e `.gitignore` multilíngue](how-to/gerenciar-dados-gitignore.md), [Publicar no GitHub Pages](how-to/publicar-github-pages.md), [Escrever um README](how-to/escrever-readme.md) e [Escolher uma licença](how-to/escolher-licenca.md).
* 📖 **Referência Técnica:** Tabelas de consulta rápida com [comandos `uv`](reference/comandos-uv.md), [comandos Git](reference/comandos-git.md), [estrutura de arquivos multilíngue](reference/estrutura-arquivos.md), [convenções de nomenclatura](reference/convencoes-nomenclatura.md), [solução de problemas comuns (FAQ)](reference/solucao-problemas.md) e [glossário técnico](reference/glossario.md).
* 💡 **Explicação e Conceitos:** O "porquê" das coisas. Leituras conceituais sobre [reprodutibilidade computacional](explanation/reproducibilidade.md), [funcionamento do Git](explanation/controle-de-versao.md), [isolamento de ambientes](explanation/isolamento-ambientes.md), [filosofia Diátaxis](explanation/filosofia-diataxis.md) e [testes automatizados](explanation/testes-automatizados.md).

## Pré-requisitos

Para aproveitar este guia, você não precisa ser um programador experiente. Você precisará apenas de:

1. Um computador (:fontawesome-brands-windows: Windows, :simple-apple: macOS ou :simple-linux: Linux).
2. Acesso à internet.
3. Vontade de abandonar velhos hábitos (como salvar arquivos com o nome `script_final_revisado_v3.py`) e adotar um fluxo de trabalho profissional.

## Pronto para começar?

A melhor forma de aprender é praticando. Se quiser entender primeiro a motivação científica por trás deste guia, leia sobre [Por que Reprodutibilidade Computacional?](explanation/reproducibilidade.md). Caso queira colocar a mão na massa agora mesmo, inicie pela trilha de **Tutoriais**:

👉 **[Ir para o Tutorial 1: Configurando seu ambiente com `uv`](tutorials/setup-uv.md)**
