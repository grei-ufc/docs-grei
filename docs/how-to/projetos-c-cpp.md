# :simple-c: :simple-cplusplus: Como Estruturar Projetos Científicos e Embarcados em C/C++

![C](https://img.shields.io/badge/C-11-A8B9CC?logo=c&logoColor=black)
![C++](https://img.shields.io/badge/C%2B%2B-17%2F20-00599C?logo=cplusplus&logoColor=white)
![CMake](https://img.shields.io/badge/CMake-3.20+-064F8C?logo=cmake&logoColor=white)

As linguagens **C e C++** são a base da Engenharia Elétrica quando o assunto é **sistemas embarcados de tempo real** (firmware para DSPs da família TI C2000, microcontroladores STM32 e ESP32 aplicados ao controle de conversores estáticos e instrumentação) e **simulações numéricas de altíssimo desempenho**.

Projetos em C/C++ sem padronização costumam depender de configurações ocultas de IDEs específicas ou ter algoritmos matemáticos misturados com registradores de hardware. Este guia define o padrão do **GREI-UFC** para organizar, compilar, documentar e testar códigos em C/C++.

## Problema

Você está escrevendo um algoritmo de controle digital (como um controlador PI, ressonante ou uma malha de sincronismo PLL) ou um simulador numérico em C/C++ e precisa que o projeto compile de forma reprodutível em qualquer máquina e que a matemática do algoritmo possa ser testada automaticamente no computador antes de ir para a bancada.

## Solução: Arquitetura Desacoplada e Build Automatizado

### Passo 1: Estrutura de Diretórios (`include/`, `src/`, `tests/`)

Em C/C++, separamos os **arquivos de cabeçalho** (`.h` ou `.hpp`, que declaram a interface das funções) dos **arquivos de implementação** (`.c` ou `.cpp`).

```text
controle_inversor_c/
├── docs/
├── include/
│   └── controlador_pi.h      # Declarações de structs, constantes e protótipos
├── src/
│   ├── controlador_pi.c      # Implementação matemática pura (independente de hardware)
│   └── main.c                # Ponto de entrada / integração com periféricos
├── tests/
│   └── test_controlador_pi.c # Testes unitários executados no PC
├── .clang-format             # Regras de formatação automática de código
├── .gitignore
├── CMakeLists.txt            # Receita de compilação (ou platformio.ini)
├── LICENSE
└── README.md
```

!!! tip "Segredo para Embarcados: Desacople a Matemática do Hardware!"
    Nunca coloque leituras diretas de registradores (`ADC_read()` ou `PWM_set()`) dentro da função que calcula a lei de controle. Escreva funções matemáticas puras em `src/controlador_pi.c` que recebam valores `float` e retornem `float`. Assim, você consegue **testar e validar toda a matemática do seu controlador no próprio PC** antes de gravar no DSP e ligar a fonte de tensão da bancada!

### Passo 2: Documentando com Padrão Doxygen no Cabeçalho (`.h`)

Utilize comentários no formato **Doxygen** (`/** ... */`) nos arquivos da pasta `include/`, especificando sempre as unidades físicas:

```c title="include/controlador_pi.h"
#ifndef CONTROLADOR_PI_H
#define CONTROLADOR_PI_H

/**
 * @brief Estrutura de estado e parâmetros de um controlador PI discreto com anti-windup.
 */
typedef struct {
    float kp;           /**< Ganho proporcional [V/A] */
    float ki;           /**< Ganho integral [V/(A*s)] */
    float ts;           /**< Período de amostragem [s] */
    float integrador;   /**< Acumulador da ação integral [V] */
    float saida_max;    /**< Limite superior de saturação [V] */
    float saida_min;    /**< Limite inferior de saturação [V] */
} ControladorPI;

/**
 * @brief Calcula um passo de atualização do controlador PI discreto.
 *
 * @param pi Ponteiro para a estrutura do controlador.
 * @param erro Diferença entre a referência e a medição atual (I_ref - I_med) [A].
 * @return Sinal de atuação saturado [V].
 */
float atualizar_pi(ControladorPI *pi, float erro);

#endif // CONTROLADOR_PI_H
```

E a implementação limpa em `src/controlador_pi.c`:

```c title="src/controlador_pi.c"
#include "controlador_pi.h"

float atualizar_pi(ControladorPI *pi, float erro) {
    float proporcional = pi->kp * erro;
    pi->integrador += pi->ki * pi->ts * erro;

    if (pi->integrador > pi->saida_max) pi->integrador = pi->saida_max;
    if (pi->integrador < pi->saida_min) pi->integrador = pi->saida_min;

    float saida = proporcional + pi->integrador;
    if (saida > pi->saida_max) saida = pi->saida_max;
    if (saida < pi->saida_min) saida = pi->saida_min;

    return saida;
}
```

### Passo 3: Reprodutibilidade de Compilação (`CMake` ou `PlatformIO`)

Nunca exija que seu colega digite comandos gigantes do `gcc` manualmente. Escolha a ferramenta de *build* adequada ao seu tipo de projeto:

=== ":simple-cmake: C/C++ Científico e Testes no PC (`CMake`)"

    Crie um arquivo `CMakeLists.txt` na raiz do projeto. Ele funciona em Windows, Linux e macOS:

    ```cmake title="CMakeLists.txt"
    cmake_minimum_required(VERSION 3.20)
    project(controle_inversor LANGUAGES C)

    set(CMAKE_C_STANDARD 11)

    # Biblioteca com os algoritmos matemáticos
    add_library(algoritmos_controle src/controlador_pi.c)
    target_include_directories(algoritmos_controle PUBLIC include)

    # Habilita testes automatizados com CTest
    enable_testing()
    add_executable(test_pi tests/test_controlador_pi.c)
    target_link_libraries(test_pi PRIVATE algoritmos_controle)
    add_test(NAME ValidacaoControladorPI COMMAND test_pi)
    ```

    Para compilar na pasta isolada `build/` e rodar os testes:
    ```bash
    cmake -B build
    cmake --build build
    ctest --test-dir build --output-on-failure
    ```

=== "Sistemas Embarcados (`PlatformIO`)"

    Para microcontroladores (ESP32, STM32, Arduino, Teensy), utilize o **PlatformIO**, que gerencia *toolchains*, compiladores e bibliotecas por meio do arquivo `platformio.ini` (equivalente ao `pyproject.toml`):

    ```ini title="platformio.ini"
    [env:esp32dev]
    platform = espressif32 @ ~6.9.0
    board = esp32dev
    framework = arduino
    build_flags = -Wall -Wextra
    ```

    Comandos principais no terminal:
    * `pio run`: Compila o firmware baixando o compilador exato automaticamente.
    * `pio test`: Executa a suíte de testes unitários (`Unity`).

### Passo 4: Escrevendo Testes Automatizados em C (`tests/`)

Mesmo usando apenas a biblioteca padrão `<assert.h>` e `<math.h>`, você pode validar seu controlador com o padrão **AAA**:

```c title="tests/test_controlador_pi.c"
#include <assert.h>
#include <math.h>
#include "controlador_pi.h"

int main(void) {
    // 1. Arrange: Kp = 2.0, Ki = 100.0, Ts = 0.001s (1 kHz), limites [-24V, +24V]
    ControladorPI pi = {2.0f, 100.0f, 0.001f, 0.0f, 24.0f, -24.0f};

    // 2. Act: Aplica erro de 5.0 A no primeiro ciclo
    // P = 2.0 * 5.0 = 10.0 V | I = 100.0 * 0.001 * 5.0 = 0.5 V -> Saída = 10.5 V
    float tensao_comando = atualizar_pi(&pi, 5.0f);

    // 3. Assert
    assert(fabsf(tensao_comando - 10.5f) < 1e-5f);
    return 0;
}
```

!!! warning "Regra de Ouro no `.gitignore` para C/C++"
    **Nunca versione arquivos compilados ou pastas de build!** Adicione sempre `build/`, `.pio/`, `*.o`, `*.obj`, `*.exe`, `*.out`, `*.elf`, `*.bin` e `*.hex` ao seu arquivo [`.gitignore`](gerenciar-dados-gitignore.md). Apenas o código-fonte (`.c`, `.cpp`, `.h`, `.hpp`) e os arquivos de configuração (`CMakeLists.txt`, `platformio.ini`, `.ioc`, `.syscfg`) devem ir para o Git.

---

## Veja Também

* 🛠️ **Criação automática:** [Como Automatizar a Criação do Diretório de Trabalho (`.ps1` e `.sh`)](automatizar-criacao-projeto.md)
* 💡 **Conceitos:** [Testes Automatizados: O Rigor Científico no Código](../explanation/testes-automatizados.md)
* 📖 **Referência:** [Convenções de Nomenclatura](../reference/convencoes-nomenclatura.md) e [Estrutura de Arquivos](../reference/estrutura-arquivos.md)
