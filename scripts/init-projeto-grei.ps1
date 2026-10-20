<#
.SYNOPSIS
    Script de automação para criar e inicializar a estrutura padrão de projetos científicos do GREI-UFC.

.DESCRIPTION
    Cria a hierarquia de diretórios (src, tests, data/raw, data/processed, docs Diátaxis, .github/workflows),
    arquivos de governança (.gitignore científico, LICENSE MIT, README.md, mkdocs.yml),
    código-fonte inicial com teste unitário no padrão AAA para a linguagem escolhida
    (python, julia, matlab ou c) e inicializa o repositório Git com o primeiro commit.
    Suporta nomes de diretórios em kebab-case (ex: "nome-teste", "controle-inversor") ou snake_case.

.PARAMETER NomeProjeto
    Nome da pasta do projeto a ser criada (padrão: "meu-projeto-grei").

.PARAMETER Linguagem
    Linguagem principal do projeto: "python" (padrão), "julia", "matlab" ou "c".

.EXAMPLE
    .\init-projeto-grei.ps1 nome-teste
    .\init-projeto-grei.ps1 controle-inversor python
    .\init-projeto-grei.ps1 fluxo-potencia julia
    .\init-projeto-grei.ps1 conversor-buck matlab
    .\init-projeto-grei.ps1 pll-embarcado c
#>

param (
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$NomeProjeto = "meu-projeto-grei",

    [Parameter(Position = 1, Mandatory = $false)]
    [ValidateSet("python", "julia", "matlab", "c")]
    [string]$Linguagem = "python"
)

$ErrorActionPreference = "Stop"
$AnoAtual = (Get-Date).Year.ToString()
$Linguagem = $Linguagem.ToLower()

# Remove barras finais caso o usuário digite "nome-teste/" ou ".\nome-teste\"
$NomeProjeto = $NomeProjeto.Trim().TrimEnd('/', '\')
if ($NomeProjeto.StartsWith("./") -or $NomeProjeto.StartsWith(".\")) {
    $NomeProjeto = $NomeProjeto.Substring(2)
}

if ([string]::IsNullOrWhiteSpace($NomeProjeto)) {
    Write-Error "O nome do projeto não pode ser vazio."
    exit 1
}

if (Test-Path -Path $NomeProjeto) {
    Write-Error "A pasta '$NomeProjeto' já existe neste diretório. Escolha outro nome ou remova a pasta existente."
    exit 1
}

# Gera identificadores normalizados a partir de nomes com hífen (ex: "nome-teste")
# 1. kebab-case para pacotes Python (ex: "nome-teste")
$NomeKebab = ($NomeProjeto.ToLower() -replace '[^a-z0-9_-]', '-' -replace '_+', '-' -replace '-+', '-').Trim('-')
# 2. snake_case para CMake / identificadores C (ex: "nome_teste")
$NomeSnake = ($NomeProjeto.ToLower() -replace '[^a-z0-9_]', '_' -replace '_+', '_').Trim('_')
if ($NomeSnake -match '^[0-9]') { $NomeSnake = "proj_$NomeSnake" }
# 3. PascalCase para módulos/projetos Julia (ex: "NomeTeste")
$PartesNome = $NomeProjeto -split '[^a-zA-Z0-9]+' | Where-Object { $_ -ne "" }
$NomePascal = ($PartesNome | ForEach-Object { $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower() }) -join ""
if ([string]::IsNullOrWhiteSpace($NomePascal) -or $NomePascal -match '^[0-9]') {
    $NomePascal = "Projeto$NomePascal"
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Inicializando projeto GREI-UFC: $NomeProjeto ($Linguagem)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Criação dos diretórios base comuns
$PastasComuns = @(
    "$NomeProjeto/data/raw",
    "$NomeProjeto/data/processed",
    "$NomeProjeto/docs/explanation",
    "$NomeProjeto/docs/tutorials",
    "$NomeProjeto/docs/how-to",
    "$NomeProjeto/docs/reference",
    "$NomeProjeto/.github/workflows"
)

foreach ($Pasta in $PastasComuns) {
    New-Item -ItemType Directory -Path $Pasta -Force | Out-Null
}

# Arquivos .gitkeep para preservar a estrutura de dados vazia no Git
New-Item -ItemType File -Path "$NomeProjeto/data/raw/.gitkeep" -Force | Out-Null
New-Item -ItemType File -Path "$NomeProjeto/data/processed/.gitkeep" -Force | Out-Null

# 2. Arquivo .gitignore científico multilíngue
$GitignoreContent = @'
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
'@
Set-Content -Path "$NomeProjeto/.gitignore" -Value $GitignoreContent -Encoding UTF8

# 3. Arquivo LICENSE (MIT)
$LicenseContent = @'
MIT License

Copyright (c) __ANO__ GREI-UFC (Grupo de Redes Elétricas Inteligentes - Universidade Federal do Ceará)

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
'@.Replace('__ANO__', $AnoAtual)
Set-Content -Path "$NomeProjeto/LICENSE" -Value $LicenseContent -Encoding UTF8

# 4. Configuração base de documentação (mkdocs.yml, docs/index.md e .github/workflows/deploy.yml)
$MkdocsContent = @'
site_name: Documentação — __PROJETO__
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
'@.Replace('__PROJETO__', $NomeProjeto)
Set-Content -Path "$NomeProjeto/mkdocs.yml" -Value $MkdocsContent -Encoding UTF8

$DocsIndexContent = @'
# Documentação do Projeto: __PROJETO__

Bem-vindo à documentação técnica e científica do projeto **__PROJETO__**, estruturada segundo a metodologia **Diátaxis** e as diretrizes do **GREI-UFC**.

## Estrutura do Projeto

* `src/`: Algoritmos, modelos matemáticos e funções principais.
* `tests/` (ou `test/`): Testes automatizados de validação científica (padrão AAA).
* `data/raw/`: Dados brutos originais (imutáveis).
* `data/processed/`: Dados processados pelos scripts de análise.
* `docs/`: Documentação técnica e memorial metodológico.
'@.Replace('__PROJETO__', $NomeProjeto)
Set-Content -Path "$NomeProjeto/docs/index.md" -Value $DocsIndexContent -Encoding UTF8

$DeployWorkflowContent = @'
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
'@
Set-Content -Path "$NomeProjeto/.github/workflows/deploy.yml" -Value $DeployWorkflowContent -Encoding UTF8

# 5. Configuração específica por linguagem
switch ($Linguagem) {
    "python" {
        New-Item -ItemType Directory -Path "$NomeProjeto/src", "$NomeProjeto/tests", "$NomeProjeto/notebooks" -Force | Out-Null
        Set-Content -Path "$NomeProjeto/.python-version" -Value "3.12" -Encoding UTF8
        New-Item -ItemType File -Path "$NomeProjeto/src/__init__.py" -Force | Out-Null

        $PyprojectContent = @'
[project]
name = "__PACOTE__"
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
'@.Replace('__PACOTE__', $NomeKebab)
        Set-Content -Path "$NomeProjeto/pyproject.toml" -Value $PyprojectContent -Encoding UTF8

        $PreCommitContent = @'
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.9.10
    hooks:
      - id: ruff
        args: [ --fix ]
      - id: ruff-format
'@
        Set-Content -Path "$NomeProjeto/.pre-commit-config.yaml" -Value $PreCommitContent -Encoding UTF8

        $PySrcContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/src/processamento.py" -Value $PySrcContent -Encoding UTF8

        $PyTestContent = @'
from src.processamento import calcular_potencia_media


def test_calcular_potencia_media():
    # 1. Arrange (Organizar)
    tensoes = [10.0, 20.0]
    resistencia = 10.0

    # 2. Act (Agir)
    potencia = calcular_potencia_media(tensoes, resistencia)

    # 3. Assert (Afirmar)
    assert abs(potencia - 25.0) < 1e-6
'@
        Set-Content -Path "$NomeProjeto/tests/test_processamento.py" -Value $PyTestContent -Encoding UTF8

        $ReadmeContent = @'
# __PROJETO__

![Python](https://img.shields.io/badge/Python-3.12+-3776AB?logo=python&logoColor=white)
![uv](https://img.shields.io/badge/uv-Astral-DE5FE9?logo=astral&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa desenvolvido no **GREI-UFC** (Grupo de Redes Elétricas Inteligentes — Universidade Federal do Ceará).

## Como Configurar e Executar

1. Sincronize o ambiente isolado utilizando o [`uv`](https://docs.astral.sh/uv/):

```bash
uv sync
```

2. Execute a suíte de testes automatizados:

```bash
uv run pytest
```

3. Visualize a documentação localmente:

```bash
uv run mkdocs serve
```

## Licença

Distribuído sob a licença MIT. Veja [`LICENSE`](LICENSE) para mais detalhes.
'@.Replace('__PROJETO__', $NomeProjeto)
        Set-Content -Path "$NomeProjeto/README.md" -Value $ReadmeContent -Encoding UTF8
    }

    "julia" {
        New-Item -ItemType Directory -Path "$NomeProjeto/src", "$NomeProjeto/test", "$NomeProjeto/scripts" -Force | Out-Null

        # Em Julia, Project.toml requer identificador PascalCase sem hifens no campo name
        $JlProjectContent = @'
name = "__MODULO_JULIA__"
version = "0.1.0"
'@.Replace('__MODULO_JULIA__', $NomePascal)
        Set-Content -Path "$NomeProjeto/Project.toml" -Value $JlProjectContent -Encoding UTF8

        $JlSrcContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/src/CalculosRede.jl" -Value $JlSrcContent -Encoding UTF8

        $JlTestContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/test/runtests.jl" -Value $JlTestContent -Encoding UTF8

        $ReadmeContent = @'
# __PROJETO__

![Julia](https://img.shields.io/badge/Julia-1.10+-9558B2?logo=julia&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa em Julia desenvolvido no **GREI-UFC**.

## Como Configurar e Testar

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. test/runtests.jl
```

## Licença

Distribuído sob a licença MIT. Veja [`LICENSE`](LICENSE) para mais detalhes.
'@.Replace('__PROJETO__', $NomeProjeto)
        Set-Content -Path "$NomeProjeto/README.md" -Value $ReadmeContent -Encoding UTF8
    }

    "matlab" {
        New-Item -ItemType Directory -Path "$NomeProjeto/src", "$NomeProjeto/tests", "$NomeProjeto/scripts", "$NomeProjeto/models" -Force | Out-Null

        $StartupContent = @'
% Inicializa os caminhos do projeto (MATLAB / GNU Octave)
clc;
raiz_projeto = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(raiz_projeto, 'src')));
addpath(genpath(fullfile(raiz_projeto, 'scripts')));
addpath(genpath(fullfile(raiz_projeto, 'models')));
fprintf('Ambiente do projeto carregado com sucesso!\n');
'@
        Set-Content -Path "$NomeProjeto/startup.m" -Value $StartupContent -Encoding UTF8

        $MatlabSrcContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/src/calcular_potencia_media.m" -Value $MatlabSrcContent -Encoding UTF8

        $MatlabTestContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/tests/test_potencia_media.m" -Value $MatlabTestContent -Encoding UTF8

        $ReadmeContent = @'
# __PROJETO__

![MATLAB / Octave](https://img.shields.io/badge/MATLAB%20%2F%20Octave-0790C0?logo=gnuoctave&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa em MATLAB/Simulink e GNU Octave desenvolvido no **GREI-UFC**.

## Como Configurar e Executar

1. Abra o MATLAB ou GNU Octave na pasta raiz do projeto e execute `startup` para carregar os diretórios `src/`, `scripts/` e `models/`.
2. Para rodar os testes automatizados:
   * **MATLAB:** `runtests('tests')`
   * **GNU Octave:** `octave --eval "run('tests/test_potencia_media.m')"`

## Licença

Distribuído sob a licença MIT. Veja [`LICENSE`](LICENSE) para mais detalhes.
'@.Replace('__PROJETO__', $NomeProjeto)
        Set-Content -Path "$NomeProjeto/README.md" -Value $ReadmeContent -Encoding UTF8
    }

    "c" {
        New-Item -ItemType Directory -Path "$NomeProjeto/include", "$NomeProjeto/src", "$NomeProjeto/tests" -Force | Out-Null

        $CMakeContent = @'
cmake_minimum_required(VERSION 3.20)
project(__CMAKE_PROJ__ LANGUAGES C)

set(CMAKE_C_STANDARD 11)

add_library(core_controle src/controlador_pi.c)
target_include_directories(core_controle PUBLIC include)

enable_testing()
add_executable(test_pi tests/test_controlador_pi.c)
target_link_libraries(test_pi PRIVATE core_controle)
add_test(NAME ValidacaoControladorPI COMMAND test_pi)
'@.Replace('__CMAKE_PROJ__', $NomeSnake)
        Set-Content -Path "$NomeProjeto/CMakeLists.txt" -Value $CMakeContent -Encoding UTF8

        $CHeaderContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/include/controlador_pi.h" -Value $CHeaderContent -Encoding UTF8

        $CSrcContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/src/controlador_pi.c" -Value $CSrcContent -Encoding UTF8

        $CTestContent = @'
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
'@
        Set-Content -Path "$NomeProjeto/tests/test_controlador_pi.c" -Value $CTestContent -Encoding UTF8

        $ReadmeContent = @'
# __PROJETO__

![C](https://img.shields.io/badge/C-11-A8B9CC?logo=c&logoColor=black)
![CMake](https://img.shields.io/badge/CMake-3.20+-064F8C?logo=cmake&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Projeto de pesquisa em C/C++ desenvolvido no **GREI-UFC**.

## Como Compilar e Testar

```bash
cmake -B build
cmake --build build
ctest --test-dir build --output-on-failure
```

## Licença

Distribuído sob a licença MIT. Veja [`LICENSE`](LICENSE) para mais detalhes.
'@.Replace('__PROJETO__', $NomeProjeto)
        Set-Content -Path "$NomeProjeto/README.md" -Value $ReadmeContent -Encoding UTF8
    }
}

# 6. Inicialização do repositório Git e primeiro commit
Push-Location $NomeProjeto
try {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        git init | Out-Null
        git branch -M main
        git add .
        git commit -m "feat: inicializa estrutura padrao do projeto GREI-UFC ($Linguagem)" | Out-Null
        Write-Host "[OK] Repositório Git inicializado na branch 'main' com commit inicial." -ForegroundColor Green
    } else {
        Write-Host "[AVISO] Git não encontrado no PATH. Inicialização do repositório ignorada." -ForegroundColor Yellow
    }
} finally {
    Pop-Location
}

Write-Host ""
Write-Host "Projeto '$NomeProjeto' criado com sucesso!" -ForegroundColor Green
Write-Host "Próximos passos:" -ForegroundColor Yellow
Write-Host "  cd `"$NomeProjeto`""
if ($Linguagem -eq "python") {
    Write-Host "  uv sync && uv run pytest"
} elseif ($Linguagem -eq "julia") {
    Write-Host "  julia --project=. test/runtests.jl"
} elseif ($Linguagem -eq "matlab") {
    Write-Host "  Abra o MATLAB/Octave na pasta e execute: startup"
} elseif ($Linguagem -eq "c") {
    Write-Host "  cmake -B build && cmake --build build && ctest --test-dir build"
}
