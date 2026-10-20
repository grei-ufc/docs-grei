# Testes Automatizados: O Rigor Científico no Código

Na pesquisa em Engenharia Elétrica, um simples erro de digitação em uma equação ou uma condição de contorno mal tratada em um algoritmo de controle pode invalidar meses de simulações ou levar a conclusões acadêmicas equivocadas. Os **testes automatizados** funcionam como a "prova real" da matemática computacional, garantindo que o seu software execute exatamente o que foi proposto na metodologia científica.

## Por que Testar Código Científico?

O desenvolvimento de algoritmos para processamento de sinais, fluxo de potência, controle embarcado ou análise de dados de sensores envolve transformações matemáticas encadeadas. Testar o código científico significa validar estruturalmente cada uma dessas funções com entradas cujo resultado analítico já é conhecido.

Sem uma suíte de testes, o pesquisador confia apenas na inspeção visual de gráficos ou em verificações manuais pontuais, que são lentas e sujeitas a falhas humanas. A adoção de testes automatizados protege a integridade dos dados — prática altamente valorizada em defesas de TCC, dissertações e processos de revisão por pares em periódicos.

Em um contexto acadêmico, os testes cobrem três frentes principais:

* **Testes de Unidade (*Unit Tests*):** Validam funções individuais de forma isolada. *Exemplo: Verificar se a função que converte a leitura bruta do conversor A/D para tensão em Volts aplica o ganho e o offset corretos.*
* **Testes de Integração:** Verificam se diferentes módulos do projeto funcionam juntos corretamente. *Exemplo: Garantir que o módulo de leitura de arquivos CSV entrega os vetores no formato esperado pelo módulo que calcula a Transformada Rápida de Fourier (FFT).*
* **Testes de Regressão:** Garantem que, ao otimizar o código ou adicionar uma nova funcionalidade, os resultados matemáticos de simulações anteriores não sejam alterados acidentalmente.

## O Padrão Ouro: A Metodologia AAA

Independentemente da linguagem de programação utilizada na sua pesquisa, todo bom teste científico segue o padrão **AAA (Arrange, Act, Assert)**:

1. **Arrange (Organizar):** Etapa de preparação. Define-se um sinal ou conjunto de dados de entrada sintético e controlado. *Exemplo: Definir tensões de entrada conhecidas $[10\text{ V}, 20\text{ V}]$ sobre um resistor de $10\ \Omega$.*
2. **Act (Agir):** Execução da função que está sendo avaliada utilizando os dados preparados. *Exemplo: Chamar a função `calcular_potencia_media(tensoes, R)`.*
3. **Assert (Afirmar):** Verificação final. Compara-se o valor retornado pela função com o valor teórico esperado ($P = \frac{10^2/10 + 20^2/10}{2} = 25\text{ W}$).

### Exemplo do Padrão AAA nas 4 Linguagens Científicas

Veja como a mesma validação matemática é escrita de forma simples em **Python**, **Julia**, **MATLAB/Octave** e **C/C++**:

=== "Python (`pytest`)"

    ```python title="tests/test_potencia.py"
    from src.processamento import calcular_potencia_media

    def test_potencia_media():
        # 1. Arrange
        tensoes = [10.0, 20.0]
        resistencia = 10.0

        # 2. Act
        potencia = calcular_potencia_media(tensoes, resistencia)

        # 3. Assert
        assert abs(potencia - 25.0) < 1e-6
    ```
    Execução no terminal: `uv run pytest`

=== "Julia (`Test`)"

    ```julia title="test/runtests.jl"
    using Test

    @testset "Cálculo de Potência Média" begin
        # 1. Arrange
        tensoes = [10.0, 20.0]
        resistencia = 10.0

        # 2. Act
        potencia = calcular_potencia_media(tensoes, resistencia)

        # 3. Assert
        @test potencia ≈ 25.0 atol=1e-6
    end
    ```
    Execução no terminal: `julia --project=. test/runtests.jl`

=== "MATLAB / Octave (`assert`)"

    ```matlab title="tests/test_potencia.m"
    % 1. Arrange
    tensoes = [10.0, 20.0];
    resistencia = 10.0;

    % 2. Act
    potencia = calcular_potencia_media(tensoes, resistencia);

    % 3. Assert
    assert(abs(potencia - 25.0) < 1e-6, 'Erro no calculo da potencia media!');
    ```
    Execução no MATLAB: `runtests('tests')` | No Octave: `octave --eval "run('tests/test_potencia.m')"`

=== "C / C++ (`assert.h` / `CTest`)"

    ```c title="tests/test_potencia.c"
    #include <assert.h>
    #include <math.h>
    #include "processamento.h"

    int main(void) {
        // 1. Arrange
        float tensoes[2] = {10.0f, 20.0f};
        float resistencia = 10.0f;

        // 2. Act
        float potencia = calcular_potencia_media(tensoes, 2, resistencia);

        // 3. Assert
        assert(fabsf(potencia - 25.0f) < 1e-5f);
        return 0;
    }
    ```
    Execução no terminal: `ctest --test-dir build --output-on-failure`

---

## Veja Também

* 🎓 **Hora de praticar (Python):** [Tutorial 5: Automatizando Testes com `pytest`](../tutorials/testando-pytest.md)
* 🛠️ **Guias por linguagem:** [Projetos em Julia](../how-to/projetos-julia.md), [Projetos em MATLAB/Octave](../how-to/projetos-matlab-octave.md) e [Projetos em C/C++](../how-to/projetos-c-cpp.md)
* 📖 **Referência:** [Glossário Técnico](../reference/glossario.md)
