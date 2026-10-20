# Como Estruturar Projetos Científicos em Julia

A linguagem **Julia** conquistou grande espaço na Engenharia Elétrica e na computação científica por combinar uma sintaxe matemática limpa (próxima ao MATLAB e Python) com velocidades de execução comparáveis ao C/C++. No contexto de sistemas de energia e controle, pacotes como `JuMP.jl`, `PowerModels.jl` e `DifferentialEquations.jl` são amplamente utilizados em pesquisas de ponta.

Este guia apresenta o padrão do **GREI-UFC** para estruturar ambientes isolados, organizar pastas e automatizar testes em projetos escritos em Julia.

## Problema

Você está desenvolvendo um modelo de otimização de fluxo de potência ou uma simulação dinâmica em Julia e precisa garantir que seus pacotes não entrem em conflito com outros projetos e que qualquer colega consiga reproduzir seus resultados exatos.

## Solução: O Gerenciador Nativo `Pkg` (`Project.toml` e `Manifest.toml`)

A grande vantagem da Julia é que ela já possui um gerenciador de ambientes e pacotes integrado na própria linguagem (o **`Pkg`**), cujo funcionamento é muito semelhante ao [`uv` no Python](../explanation/isolamento-ambientes.md):

* **`Project.toml`**: Declara o nome do projeto e as bibliotecas principais utilizadas (equivalente ao `pyproject.toml`).
* **`Manifest.toml`**: Registra a árvore completa de dependências com versões exatas e códigos identificadores únicos (equivalente ao `uv.lock`).

### Passo 1: Inicializando o Ambiente Isolado do Projeto

Nunca instale pacotes diretamente no ambiente global (`@v1.x`) da Julia! Crie uma pasta para o seu projeto, abra o terminal nela e inicie a Julia ativando o diretório local:

```bash
mkdir fluxo_potencia_julia
cd fluxo_potencia_julia
julia --project=.
```

Dentro do terminal interativo da Julia (REPL), pressione a tecla **`]`** para entrar no modo de gerenciamento de pacotes (`pkg>`) e adicione as bibliotecas da sua pesquisa:

```julia
(@v1.11) pkg> activate .
(fluxo_potencia_julia) pkg> add JuMP Ipopt Plots
```

Ao fazer isso, a Julia criará imediatamente os arquivos `Project.toml` e `Manifest.toml` na raiz da pasta. Para voltar ao modo normal da Julia, pressione `Backspace`.

!!! tip "Como reproduzir o ambiente em outro computador?"
    Quando seu orientador ou colega clonar o repositório do GitHub, basta ele rodar um único comando no terminal para baixar exatamente as mesmas versões do `Manifest.toml`:
    ```bash
    julia --project=. -e 'using Pkg; Pkg.instantiate()'
    ```

### Passo 2: Estrutura de Pastas Recomendada

Organize os arquivos do seu projeto separando o código matemático reutilizável (`src/`), os scripts que geram os gráficos do artigo (`scripts/`) e os testes (`test/`):

```text
fluxo_potencia_julia/
├── data/
│   ├── processed/
│   └── raw/
├── docs/
├── scripts/
│   └── rodar_simulacao_ieee14.jl
├── src/
│   └── CalculosRede.jl
├── test/
│   └── runtests.jl
├── .gitignore
├── Manifest.toml
├── Project.toml
└── README.md
```

### Passo 3: Escrevendo um Módulo Científico Documentado

Em `src/CalculosRede.jl`, estruture suas funções dentro de um `module` e documente-as com *docstrings* acima da função (indicando sempre as unidades no SI):

```julia title="src/CalculosRede.jl"
module CalculosRede

export calcular_corrente_linha

"""
    calcular_corrente_linha(potencia_va::Real, tensao_linha_v::Real) -> Float64

Calcula a corrente eficaz de linha em um sistema trifásico equilibrado:
``I_L = \\frac{S}{\\sqrt{3} \\cdot V_L}``

# Argumentos
- `potencia_va`: Potência aparente trifásica [VA].
- `tensao_linha_v`: Tensão eficaz de linha [V]. Deve ser > 0.

# Retorno
- Corrente eficaz de linha [A].
"""
function calcular_corrente_linha(potencia_va::Real, tensao_linha_v::Real)::Float64
    tensao_linha_v <= 0 && throw(ArgumentError("A tensão de linha deve ser positiva [V]."))
    return potencia_va / (sqrt(3) * tensao_linha_v)
end

end # module
```

### Passo 4: Automatizando Testes com a Biblioteca Padrão `Test`

A Julia já vem com a biblioteca `Test` instalada de fábrica. Crie o arquivo `test/runtests.jl` aplicando o padrão **[AAA (Arrange, Act, Assert)](../explanation/testes-automatizados.md)**:

```julia title="test/runtests.jl"
using Test
include("../src/CalculosRede.jl")
using .CalculosRede

@testset "Validação de Cálculos Trifásicos" begin
    # 1. Arrange (Organizar)
    s_nominal = sqrt(3) * 380.0 * 10.0  # Potência correspondente a 10 A em 380 V
    v_linha = 380.0

    # 2. Act (Agir)
    corrente = calcular_corrente_linha(s_nominal, v_linha)

    # 3. Assert (Afirmar) - Usamos ≈ (\approx) para comparar ponto flutuante com tolerância!
    @test corrente ≈ 10.0 atol=1e-6
    @test_throws ArgumentError calcular_corrente_linha(1000.0, 0.0)
end
```

Para executar a bateria de testes pelo terminal:

```bash
julia --project=. test/runtests.jl
```

!!! info "Comparação de ponto flutuante com `≈` (`isapprox`)"
    Em cálculos numéricos, evite usar `==` para números reais (`Float64`) devido a arredondamentos de ponto flutuante. Na Julia, o operador `≈` (ou `isapprox(a, b, atol=1e-6)`) verifica se os valores são iguais dentro da tolerância numérica especificada.

---

## Veja Também

* 💡 **Conceitos:** [Isolamento de Ambientes](../explanation/isolamento-ambientes.md) e [Testes Automatizados](../explanation/testes-automatizados.md)
* 🛠️ **Dados e Git:** [Como Gerenciar Dados Científicos e Configurar o `.gitignore`](gerenciar-dados-gitignore.md)
* 📖 **Referência:** [Convenções de Nomenclatura](../reference/convencoes-nomenclatura.md) e [Estrutura de Arquivos](../reference/estrutura-arquivos.md)

