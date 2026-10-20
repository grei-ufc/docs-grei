#!/usr/bin/env bash
# ==============================================================================
# Script de automação para criar a estrutura padrão de projetos do GREI-UFC
# Suporta nomes de diretórios em kebab-case (ex: "nome-teste") ou snake_case.
# Linguagens suportadas: python (padrão), julia, matlab, c
#
# Uso:
#   ./init-projeto-grei.sh <nome-do-projeto> [python|julia|matlab|c]
# ==============================================================================

set -euo pipefail

NOME_PROJETO="${1:-meu-projeto-grei}"
# Remove barras finais ou prefixo ./ caso o usuário digite "./nome-teste/"
NOME_PROJETO="${NOME_PROJETO%/}"
NOME_PROJETO="${NOME_PROJETO#./}"

LINGUAGEM=$(echo "${2:-python}" | tr '[:upper:]' '[:lower:]')
ANO_ATUAL=$(date +%Y)

if [[ -z "$NOME_PROJETO" ]]; then
    echo "[ERRO] O nome do projeto não pode ser vazio." >&2
    exit 1
fi

if [[ ! "$LINGUAGEM" =~ ^(python|julia|matlab|c)$ ]]; then
    echo "[ERRO] Linguagem inválida: '$LINGUAGEM'. Escolha entre: python, julia, matlab ou c." >&2
    exit 1
fi

if [[ -d "$NOME_PROJETO" ]]; then
    echo "[ERRO] A pasta '$NOME_PROJETO' já existe neste diretório." >&2
    exit 1
fi

# Identificadores normalizados a partir de nomes com hífen (ex: "nome-teste")
# 1. kebab-case para pyproject.toml (ex: "nome-teste")
NOME_KEBAB=$(echo "$NOME_PROJETO" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9_-]/-/g; s/_+/-/g; s/-+/-/g; s/^-//; s/-$//')
# 2. snake_case para CMakeLists.txt (ex: "nome_teste")
NOME_SNAKE=$(echo "$NOME_PROJETO" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9_]/_/g; s/_+/_/g; s/^_//; s/_$//')
if [[ "$NOME_SNAKE" =~ ^[0-9] ]]; then NOME_SNAKE="proj_${NOME_SNAKE}"; fi
# 3. PascalCase para Project.toml da Julia (ex: "NomeTeste")
NOME_PASCAL=$(echo "$NOME_PROJETO" | sed -E 's/[^a-zA-Z0-9]+/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1' | tr -d ' ')
if [[ -z "$NOME_PASCAL" || "$NOME_PASCAL" =~ ^[0-9] ]]; then NOME_PASCAL="Projeto${NOME_PASCAL}"; fi

echo "=========================================================="
echo " Inicializando projeto GREI-UFC: $NOME_PROJETO ($LINGUAGEM)"
echo "=========================================================="

# 1. Criação dos diretórios base comuns
mkdir -p "$NOME_PROJETO/data/raw" \
         "$NOME_PROJETO/data/processed" \
         "$NOME_PROJETO/docs/explanation" \
         "$NOME_PROJETO/docs/tutorials" \
         "$NOME_PROJETO/docs/how-to" \
         "$NOME_PROJETO/docs/reference" \
         "$NOME_PROJETO/.github/workflows"

touch "$NOME_PROJETO/data/raw/.gitkeep" "$NOME_PROJETO/data/processed/.gitkeep"

# 2. Arquivo .gitignore científico multilíngue
cat << 'EOF' > "$NOME_PROJETO/.gitignore"
# 1. Python (uv, pytest, Ruff, Jupyter)
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

# 2. Julia
*.jl.cov
*.jl.*.cov
*.jl.mem
deps/build.log

# 3. MATLAB / Simulink / GNU Octave
*.asv
*.mex*
*.slxc
slprj/
simulink/
octave-workspace

# 4. C / C++ e Sistemas Embarcados
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

# 5. Documentação (MkDocs)
site/

# 6. Dados Científicos Pesados (mantém estrutura com .gitkeep)
data/raw/*
data/processed/*
!data/raw/.gitkeep
!data/processed/.gitkeep
*.mat
*.tdms
*.h5
*.hdf5
*.parquet

# 7. Segredos, Sistema Operacional e Editores
.env
.env.*
.DS_Store
Thumbs.db
.vscode/
.idea/
EOF

# 3. Arquivo LICENSE (MIT)
cat << EOF > "$NOME_PROJETO/LICENSE"
MIT License

Copyright (c) $ANO_ATUAL GREI-UFC (Grupo de Redes Elétricas Inteligentes - Universidade Federal do Ceará)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# 4. Configuração base de documentação (mkdocs.yml, docs/index.md e .github/workflows/deploy.yml)
cat << EOF > "$NOME_PROJETO/mkdocs.yml"
site_name: Documentação — $NOME_PROJETO
theme:
  name: material
  language: pt-BR
  palette:
    - scheme: default
      primary: blue
      accent: deep orange
      toggle:
        icon: material/weather-night
        name: Mudar para modo escuro
    - scheme: slate
      primary: green
      accent: deep purple
      toggle:
        icon: material/weather-sunny
        name: Mudar para modo claro
  features:
    - navigation.sections
    - content.code.copy

markdown_extensions:
  - admonition
  - tables
  - pymdownx.details
  - pymdownx.superfences

nav:
  - Início: index.md
EOF

cat << EOF > "$NOME_PROJETO/docs/index.md"
# Documentação do Projeto: $NOME_PROJETO

Bem-vindo à documentação técnica e científica do projeto **$NOME_PROJETO**, estruturada segundo a metodologia **Diátaxis** e as diretrizes do **GREI-UFC**.

## Estrutura do Projeto

* \`src/\`: Algoritmos, modelos matemáticos e funções principais.
* \`tests/\` (ou \`test/\`): Testes automatizados de validação científica (padrão AAA).
* \`data/raw/\`: Dados brutos originais (imutáveis).
* \`data/processed/\`: Dados processados pelos scripts de análise.
* \`docs/\`: Documentação técnica e memorial metodológico.
EOF

cat << 'EOF' > "$NOME_PROJETO/.github/workflows/deploy.yml"
name: Deploy Documentação

on:
  push:
    branches:
      - main

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout do repositório
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Instalar uv
        uses: astral-sh/setup-uv@v5
        with:
          enable-cache: true

      - name: Instalar dependências
        run: uv sync

      - name: Publicar no GitHub Pages
        run: uv run mkdocs gh-deploy --force
EOF

# 5. Configuração específica por linguagem
case "$LINGUAGEM" in
    python)
        mkdir -p "$NOME_PROJETO/src" "$NOME_PROJETO/tests" "$NOME_PROJETO/notebooks"
        echo "3.12" > "$NOME_PROJETO/.python-version"
        touch "$NOME_PROJETO/src/__init__.py"

        cat << EOF > "$NOME_PROJETO/pyproject.toml"
[project]
name = "$NOME_KEBAB"
version = "0.1.0"
description = "Projeto de pesquisa computacional desenvolvido no GREI-UFC"
readme = "README.md"
requires-python = ">=3.12"
dependencies = []

[dependency-groups]
dev = [
    "pytest>=8.0.0",
    "ruff>=0.9.0",
    "mkdocs-material>=9.5.0",
    "mkdocstrings[python]>=0.27.0",
]

[tool.pytest.ini_options]
pythonpath = ["."]

[tool.ruff]
line-length = 88

[tool.ruff.lint]
select = ["E", "F", "I", "B"]
EOF

        cat << 'EOF' > "$NOME_PROJETO/.pre-commit-config.yaml"
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.9.10
    hooks:
      - id: ruff
        args: [ --fix ]
      - id: ruff-format
EOF

        cat << 'EOF' > "$NOME_PROJETO/src/processamento.py"
def calcular_potencia_media(tensoes: list[float], resistencia: float) -> float:
    """Calcula a potência ativa média dissipada em um resistor.

    Args:
        tensoes: Vetor de leituras instantâneas de tensão [V].
        resistencia: Resistência elétrica nominal [Ohms]. Deve ser > 0.

    Returns:
        Potência ativa média dissipada [W].
    """
    if resistencia <= 0:
        raise ValueError("A resistência deve ser estritamente positiva [Ohms].")
    if not tensoes:
        return 0.0
    potencias = [(v ** 2) / resistencia for v in tensoes]
    return sum(potencias) / len(potencias)
EOF

        cat << 'EOF' > "$NOME_PROJETO/tests/test_processamento.py"
from src.processamento import calcular_potencia_media


def test_calcular_potencia_media():
    # 1. Arrange (Organizar)
    tensoes = [10.0, 20.0]
    resistencia = 10.0

    # 2. Act (Agir)
    potencia = calcular_potencia_media(tensoes, resistencia)

    # 3. Assert (Afirmar)
    assert abs(potencia - 25.0) < 1e-6
EOF

        cat << EOF > "$NOME_PROJETO/README.md"
# $NOME_PROJETO

![Python](https://img.shields.io/badge/Python-3.12+-3776AB?logo=python&logoColor=white)
![uv](https://img.shields.io/badge/uv-Astral-DE5FE9?logo=astral&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa desenvolvido no **GREI-UFC** (Grupo de Redes Elétricas Inteligentes — Universidade Federal do Ceará).

## Como Configurar e Executar

1. Sincronize o ambiente isolado utilizando o [\`uv\`](https://docs.astral.sh/uv/):

\`\`\`bash
uv sync
\`\`\`

2. Execute a suíte de testes automatizados:

\`\`\`bash
uv run pytest
\`\`\`

3. Visualize a documentação localmente:

\`\`\`bash
uv run mkdocs serve
\`\`\`

## Licença

Distribuído sob a licença MIT. Veja [\`LICENSE\`](LICENSE) para mais detalhes.
EOF
        ;;

    julia)
        mkdir -p "$NOME_PROJETO/src" "$NOME_PROJETO/test" "$NOME_PROJETO/scripts"

        cat << EOF > "$NOME_PROJETO/Project.toml"
name = "$NOME_PASCAL"
version = "0.1.0"
EOF

        cat << 'EOF' > "$NOME_PROJETO/src/CalculosRede.jl"
module CalculosRede

export calcular_potencia_media

"""
    calcular_potencia_media(tensoes::AbstractVector{<:Real}, resistencia::Real) -> Float64

Calcula a potência ativa média [W] dissipada em um resistor [Ohms].
"""
function calcular_potencia_media(tensoes::AbstractVector{<:Real}, resistencia::Real)::Float64
    resistencia <= 0 && throw(ArgumentError("A resistência deve ser positiva [Ohms]."))
    isempty(tensoes) && return 0.0
    return sum((v^2) / resistencia for v in tensoes) / length(tensoes)
end

end # module
EOF

        cat << 'EOF' > "$NOME_PROJETO/test/runtests.jl"
using Test
include("../src/CalculosRede.jl")
using .CalculosRede

@testset "Validação de Potência Média" begin
    # 1. Arrange
    tensoes = [10.0, 20.0]
    resistencia = 10.0

    # 2. Act
    potencia = calcular_potencia_media(tensoes, resistencia)

    # 3. Assert
    @test potencia ≈ 25.0 atol=1e-6
end
EOF

        cat << EOF > "$NOME_PROJETO/README.md"
# $NOME_PROJETO

![Julia](https://img.shields.io/badge/Julia-1.10+-9558B2?logo=julia&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa em Julia desenvolvido no **GREI-UFC**.

## Como Configurar e Testar

\`\`\`bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. test/runtests.jl
\`\`\`

## Licença

Distribuído sob a licença MIT. Veja [\`LICENSE\`](LICENSE) para mais detalhes.
EOF
        ;;

    matlab)
        mkdir -p "$NOME_PROJETO/src" "$NOME_PROJETO/tests" "$NOME_PROJETO/scripts" "$NOME_PROJETO/models"

        cat << 'EOF' > "$NOME_PROJETO/startup.m"
% Inicializa os caminhos do projeto (MATLAB / GNU Octave)
clc;
raiz_projeto = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(raiz_projeto, 'src')));
addpath(genpath(fullfile(raiz_projeto, 'scripts')));
addpath(genpath(fullfile(raiz_projeto, 'models')));
fprintf('Ambiente do projeto carregado com sucesso!\n');
EOF

        cat << 'EOF' > "$NOME_PROJETO/src/calcular_potencia_media.m"
function p_media = calcular_potencia_media(tensoes, resistencia)
% CALCULAR_POTENCIA_MEDIA Calcula a potencia ativa media [W] em um resistor [Ohms].
    if resistencia <= 0
        error('A resistencia [Ohms] deve ser estritamente positiva.');
    end
    if isempty(tensoes)
        p_media = 0.0;
        return;
    end
    p_media = mean((tensoes .^ 2) / resistencia);
end
EOF

        cat << 'EOF' > "$NOME_PROJETO/tests/test_potencia_media.m"
% Teste unitário no padrão AAA (MATLAB / GNU Octave)
addpath('../src');

% 1. Arrange
tensoes = [10.0, 20.0];
resistencia = 10.0;

% 2. Act
potencia = calcular_potencia_media(tensoes, resistencia);

% 3. Assert
assert(abs(potencia - 25.0) < 1e-6, 'Falha no calculo de potencia media!');
disp('Teste executado com sucesso!');
EOF

        cat << EOF > "$NOME_PROJETO/README.md"
# $NOME_PROJETO

![MATLAB / Octave](https://img.shields.io/badge/MATLAB%20%2F%20Octave-0790C0?logo=gnuoctave&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa em MATLAB/Simulink e GNU Octave desenvolvido no **GREI-UFC**.

## Como Configurar e Executar

1. Abra o MATLAB ou GNU Octave na pasta raiz do projeto e execute \`startup\`.
2. Para rodar os testes automatizados:
   * **MATLAB:** \`runtests('tests')\`
   * **GNU Octave:** \`octave --eval "run('tests/test_potencia_media.m')"\`

## Licença

Distribuído sob a licença MIT. Veja [\`LICENSE\`](LICENSE) para mais detalhes.
EOF
        ;;

    c)
        mkdir -p "$NOME_PROJETO/include" "$NOME_PROJETO/src" "$NOME_PROJETO/tests"

        cat << EOF > "$NOME_PROJETO/CMakeLists.txt"
cmake_minimum_required(VERSION 3.20)
project($NOME_SNAKE LANGUAGES C)

set(CMAKE_C_STANDARD 11)

add_library(core_controle src/controlador_pi.c)
target_include_directories(core_controle PUBLIC include)

enable_testing()
add_executable(test_pi tests/test_controlador_pi.c)
target_link_libraries(test_pi PRIVATE core_controle)
add_test(NAME ValidacaoControladorPI COMMAND test_pi)
EOF

        cat << 'EOF' > "$NOME_PROJETO/include/controlador_pi.h"
#ifndef CONTROLADOR_PI_H
#define CONTROLADOR_PI_H

/**
 * @brief Estrutura de um controlador PI discreto com anti-windup.
 */
typedef struct {
    float kp;         /**< Ganho proporcional [V/A] */
    float ki;         /**< Ganho integral [V/(A*s)] */
    float ts;         /**< Período de amostragem [s] */
    float integrador; /**< Estado do integrador [V] */
    float saida_max;  /**< Limite máximo de saturação [V] */
    float saida_min;  /**< Limite mínimo de saturação [V] */
} ControladorPI;

float atualizar_pi(ControladorPI *pi, float erro);

#endif // CONTROLADOR_PI_H
EOF

        cat << 'EOF' > "$NOME_PROJETO/src/controlador_pi.c"
#include "controlador_pi.h"

float atualizar_pi(ControladorPI *pi, float erro) {
    float p = pi->kp * erro;
    pi->integrador += pi->ki * pi->ts * erro;

    if (pi->integrador > pi->saida_max) pi->integrador = pi->saida_max;
    if (pi->integrador < pi->saida_min) pi->integrador = pi->saida_min;

    float saida = p + pi->integrador;
    if (saida > pi->saida_max) saida = pi->saida_max;
    if (saida < pi->saida_min) saida = pi->saida_min;

    return saida;
}
EOF

        cat << 'EOF' > "$NOME_PROJETO/tests/test_controlador_pi.c"
#include <assert.h>
#include <math.h>
#include "controlador_pi.h"

int main(void) {
    // 1. Arrange
    ControladorPI pi = {2.0f, 100.0f, 0.001f, 0.0f, 24.0f, -24.0f};

    // 2. Act
    float u = atualizar_pi(&pi, 5.0f);

    // 3. Assert (P = 10.0, I = 0.5 -> u = 10.5)
    assert(fabsf(u - 10.5f) < 1e-5f);
    return 0;
}
EOF

        cat << EOF > "$NOME_PROJETO/README.md"
# $NOME_PROJETO

![C](https://img.shields.io/badge/C-11-A8B9CC?logo=c&logoColor=black)
![CMake](https://img.shields.io/badge/CMake-3.20+-064F8C?logo=cmake&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa em C/C++ desenvolvido no **GREI-UFC**.

## Como Compilar e Testar

\`\`\`bash
cmake -B build
cmake --build build
ctest --test-dir build --output-on-failure
\`\`\`

## Licença

Distribuído sob a licença MIT. Veja [\`LICENSE\`](LICENSE) para mais detalhes.
EOF
        ;;
esac

# 6. Inicialização do repositório Git e primeiro commit
if command -v git >/dev/null 2>&1; then
    (
        cd "$NOME_PROJETO"
        git init >/dev/null
        git branch -M main
        git add .
        git commit -m "feat: inicializa estrutura padrao do projeto GREI-UFC ($LINGUAGEM)" >/dev/null
    )
    echo "[OK] Repositório Git inicializado na branch 'main' com commit inicial."
else
    echo "[AVISO] Git não encontrado no PATH. Inicialização do repositório ignorada."
fi

echo ""
echo "Projeto '$NOME_PROJETO' criado com sucesso!"
echo "Próximos passos:"
echo "  cd \"$NOME_PROJETO\""
case "$LINGUAGEM" in
    python) echo "  uv sync && uv run pytest" ;;
    julia)  echo "  julia --project=. test/runtests.jl" ;;
    matlab) echo "  Abra o MATLAB/Octave na pasta e execute: startup" ;;
    c)      echo "  cmake -B build && cmake --build build && ctest --test-dir build" ;;
esac
