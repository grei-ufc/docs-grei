# Convenções de Nomenclatura

Regras de padronização para a nomeação de arquivos, diretórios e código-fonte nos projetos de Engenharia Elétrica do **GREI-UFC**.

## 1. Diretórios e Arquivos de Dados (Universal)

Independentemente da linguagem de programação escolhida, a organização de pastas e arquivos de dados segue quatro regras universais:

* **Diretórios e Arquivos de Documentação:** Utilizar `kebab-case` (tudo minúsculo, sem acentos ou espaços, separado por hifens). Ex: `processamento-sinais`, `manual-bancada.md`.
* **Arquivos de Dados Temporais:** Utilizar o padrão ISO 8601 (`YYYY-MM-DD`) no início do nome para garantir ordenação cronológica automática no sistema operacional. Ex: `2026-03-29-leitura-inversor.csv`.
* **Zeros à Esquerda em Ensaios Sequenciais:** Preencher números com zeros à esquerda para preservar a ordem natural (ex: `ensaio_01.csv`, `ensaio_02.csv`, ..., `ensaio_10.csv`).
* **Proibição de Caracteres Especiais:** Nunca utilize espaços em branco, cedilha (`ç`), til (`~`), acentos ou pontos múltiplos no nome de arquivos ou pastas, pois causam falhas em scripts de terminal e compiladores.

---

## 2. Convenções de Código por Linguagem

Clique na aba correspondente à linguagem utilizada no seu projeto para consultar o padrão de nomenclatura de arquivos, variáveis, funções, classes/estruturas e constantes:

=== ":simple-python: Python (PEP 8)"

    | Elemento | Padrão | Exemplo na Engenharia Elétrica |
    | :--- | :--- | :--- |
    | **Arquivos / Módulos (`.py`)** | `snake_case` | `filtro_passa_baixas.py`, `calculo_thd.py` |
    | **Variáveis e Funções** | `snake_case` | `tensao_eficaz`, `calcular_potencia_ativa()` |
    | **Classes** | `PascalCase` | `MotorInducao`, `FiltroKalman` |
    | **Constantes Globais** | `UPPER_SNAKE_CASE` | `FREQUENCIA_REDE_HZ = 60.0` |

=== ":simple-julia: Julia (Julia Style Guide)"

    | Elemento | Padrão | Exemplo na Engenharia Elétrica |
    | :--- | :--- | :--- |
    | **Arquivos de Módulos (`.jl`)** | `PascalCase` | `CalculosRede.jl`, `EstimadorEstado.jl` |
    | **Scripts de Execução (`.jl`)** | `snake_case` | `rodar_fluxo_ieee14.jl` |
    | **Variáveis e Funções** | `snake_case` (ou minúsculo conciso) | `tensao_linha`, `calcular_corrente_linha()` |
    | **Módulos e Tipos (`struct`)** | `PascalCase` | `BarraPQ`, `ParametrosLinha` |
    | **Constantes (`const`)** | `UPPER_SNAKE_CASE` | `const FREQUENCIA_BASE_HZ = 60.0` |

=== ":simple-octave: MATLAB / GNU Octave"

    | Elemento | Padrão | Exemplo na Engenharia Elétrica |
    | :--- | :--- | :--- |
    | **Arquivos de Função (`.m`)** | `snake_case` (idêntico ao nome da função!) | `calcular_ripple_corrente.m` |
    | **Modelos Simulink (`.slx`)** | `snake_case` | `conversor_buck_malha_fechada.slx` |
    | **Variáveis e Funções** | `snake_case` (ou `camelCase`) | `tensao_entrada`, `calcular_ganho_pid()` |
    | **Constantes de Parâmetros** | `UPPER_SNAKE_CASE` (ou prefixo claro) | `FREQ_CHAVEAMENTO_HZ = 20e3;` |

=== ":simple-c: :simple-cplusplus: C / C++ (Embarcados e Simulação)"

    | Elemento | Padrão | Exemplo na Engenharia Elétrica |
    | :--- | :--- | :--- |
    | **Arquivos Fonte e Cabeçalhos** | `snake_case` (`.c`, `.cpp`, `.h`, `.hpp`) | `controlador_pi.c`, `controlador_pi.h` |
    | **Variáveis e Funções** | `snake_case` | `corrente_medida_a`, `atualizar_pi()` |
    | **Structs, Enums e Classes** | `PascalCase` | `ControladorPI`, `EstadoInversor` |
    | **Macros e Constantes (`#define`)** | `UPPER_SNAKE_CASE` | `#define FREQ_AMOSTRAGEM_HZ 10000.0f` |

---

## Guias Relacionados

* 🎓 **Estrutura de diretórios:** [Tutorial 3: Estruturando seu Primeiro Projeto de Engenharia](../tutorials/estrutura-projeto.md)
* 🛠️ **Guias por linguagem:** [:simple-python: Python (Ruff)](../how-to/configurar-precommit-ruff.md), [:simple-julia: Julia](../how-to/projetos-julia.md), [:simple-octave: MATLAB/Octave](../how-to/projetos-matlab-octave.md) e [:simple-c: :simple-cplusplus: C/C++](../how-to/projetos-c-cpp.md)
