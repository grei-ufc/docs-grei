# Como Estruturar Projetos em MATLAB/Simulink e GNU Octave

O **MATLAB** (junto ao **Simulink**) e sua alternativa de código aberto **GNU Octave** são ferramentas clássicas na Engenharia Elétrica para projetos de controle, eletrônica de potência, processamento digital de sinais e análise de sistemas elétricos (ex: *MATPOWER*).

Apesar de sua popularidade, projetos em MATLAB/Octave frequentemente sofrem com pastas desorganizadas, variáveis presas no *Workspace* e modelos do Simulink impossíveis de rastrear no Git. Este guia estabelece as boas práticas do **GREI-UFC** para tornar pesquisas em MATLAB/Octave organizadas e reprodutíveis.

## Problema

Você desenvolveu scripts `.m` e diagramas do Simulink `.slx`, mas quando seu orientador baixa a pasta do GitHub e tenta rodar o script principal, ocorrem erros de função não encontrada (*Undefined function or variable*), caminhos quebrados ou parâmetros ausentes no *Workspace*.

## Solução: Organização Modular e Inicialização Reprodutível

### Passo 1: Estrutura de Diretórios Padronizada

Separe estritamente as **funções reutilizáveis** (`src/`), os **scripts de simulação e geração de figuras** (`scripts/`), os **modelos do Simulink** (`models/`) e os **dados** (`data/`):

```text
conversor_cc_cc_matlab/
├── data/
│   ├── processed/
│   └── raw/
├── docs/
├── models/
│   └── buck_converter.slx        # Diagramas de blocos do Simulink
├── scripts/
│   ├── parametros_buck.m         # Define constantes físicas do modelo
│   └── simular_degrau_carga.m    # Script principal que roda o ensaio e plota
├── src/
│   └── calcular_ripple_corrente.m # Funções matemáticas puras
├── tests/
│   └── test_calculos_buck.m      # Validação automatizada das funções
├── .gitignore
├── LICENSE
├── README.md
└── startup.m                     # Configura o path automaticamente
```

### Passo 2: Elimine o Problema de `Path` com o Arquivo `startup.m`

Um erro muito comum é adicionar pastas manualmente clicando no botão *Set Path* da interface do MATLAB. Essa configuração fica salva apenas no seu computador!

Para que o MATLAB ou o GNU Octave encontre automaticamente todas as funções das pastas `src/`, `scripts/` e `models/` em qualquer computador, crie um arquivo chamado **`startup.m`** na raiz do projeto:

```matlab title="startup.m"
% Inicializa o ambiente do projeto (MATLAB / GNU Octave)
clc;
fprintf('Configurando caminhos do projeto no laboratório...\n');

raiz_projeto = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(raiz_projeto, 'src')));
addpath(genpath(fullfile(raiz_projeto, 'scripts')));
addpath(genpath(fullfile(raiz_projeto, 'models')));

fprintf('Ambiente pronto para execução!\n');
```

Sempre que o MATLAB ou o Octave é aberto na pasta raiz do projeto, ele executa o `startup.m` automaticamente!

!!! warning "Registre a Versão e os Toolboxes no `README.md`"
    Como o MATLAB não possui um arquivo `uv.lock`, é **obrigatório** listar no `README.md` qual versão foi utilizada (ex: *MATLAB R2024b* ou *GNU Octave 9.2*) e quais *Toolboxes* são exigidos (ex: *Control System Toolbox*, *Simscape Electrical*). No Octave, carregue os pacotes no início do script com `pkg load control signal`.

### Passo 3: Boas Práticas para Modelos Simulink (`.slx`) no Git

Arquivos `.slx` são arquivos binários compactados, o que dificulta visualizar alterações linha a linha no Git. Para manter seu modelo Simulink auditável:

1. **Nunca digite números fixos dentro dos blocos do Simulink:** Em vez de digitar `0.0015` dentro do bloco do indutor, digite a variável `L_filtro` e defina `L_filtro = 1.5e-3; % [H]` no arquivo de texto `scripts/parametros_buck.m`. Assim, toda mudança de parâmetro na pesquisa aparecerá claramente no `git diff`!
2. **Controle a simulação via código:** Execute o modelo pelo script usando o comando `out = sim('buck_converter');` após carregar os parâmetros. Isso garante que qualquer pessoa consiga reproduzir os gráficos do seu TCC rodando apenas `simular_degrau_carga.m`.
3. **Ignore os arquivos temporários de compilação do Simulink:** Adicione `slprj/`, `*.slxc`, `*.asv` e `*.mex*` ao seu [`.gitignore`](gerenciar-dados-gitignore.md).

### Passo 4: Escrevendo Funções Documentadas e Testáveis

Em `src/`, crie uma função por arquivo (o nome do arquivo deve ser idêntico ao nome da função). Inclua o bloco de comentários `%` logo abaixo da assinatura para que o comando `help calcular_ripple_corrente` funcione:

```matlab title="src/calcular_ripple_corrente.m"
function delta_i = calcular_ripple_corrente(v_in, v_out, indutancia, freq_chaveamento)
% CALCULAR_RIPPLE_CORRENTE Calcula a ondulação (ripple) de corrente no indutor de um conversor Buck.
%
%   delta_i = calcular_ripple_corrente(v_in, v_out, indutancia, freq_chaveamento)
%
%   Entradas:
%       v_in             - Tensão de entrada CC [V]
%       v_out            - Tensão de saída regulada CC [V]
%       indutancia       - Indutância do filtro de saída [H]
%       freq_chaveamento - Frequência de comutação PWM [Hz]
%
%   Saída:
%       delta_i          - Ondulação de corrente pico a pico [A]

    if indutancia <= 0 || freq_chaveamento <= 0
        error('Indutancia [H] e frequencia de chaveamento [Hz] devem ser positivas.');
    end

    ciclo_trabalho = v_out / v_in;
    periodo = 1.0 / freq_chaveamento;
    delta_i = ((v_in - v_out) * ciclo_trabalho * periodo) / indutancia;
end
```

### Passo 5: Testes Automatizados com `assert` (Compatível com MATLAB e Octave)

Crie scripts de validação em `tests/test_calculos_buck.m` usando a função nativa `assert`:

```matlab title="tests/test_calculos_buck.m"
% Teste automatizado seguindo o padrão AAA (Arrange, Act, Assert)
addpath('../src');

% 1. Arrange: Conversor Buck 24V -> 12V (D = 0.5), L = 1 mH, f_s = 10 kHz
v_in = 24.0;
v_out = 12.0;
L = 1e-3;
f_s = 10e3;

% 2. Act
ripple = calcular_ripple_corrente(v_in, v_out, L, f_s);

% 3. Assert: Delta_I esperado = (24 - 12) * 0.5 / (1e-3 * 10e3) = 0.6 A
tolerancia = 1e-6;
assert(abs(ripple - 0.6) < tolerancia, 'Erro no calculo do ripple de corrente!');

disp('Todos os testes passaram com sucesso!');
```

* **No MATLAB:** Execute todos os testes da pasta digitando `runtests('tests')` no *Command Window*.
* **No GNU Octave / Terminal:** Execute `octave --eval "run('tests/test_calculos_buck.m')"`.

---

## Veja Também

* 💡 **Conceitos:** [Por que Reprodutibilidade Computacional?](../explanation/reproducibilidade.md) e [Testes Automatizados](../explanation/testes-automatizados.md)
* 🛠️ **Dados e `.gitignore`:** [Como Gerenciar Dados Científicos e Configurar o `.gitignore`](gerenciar-dados-gitignore.md)
* 📖 **Referência:** [Convenções de Nomenclatura](../reference/convencoes-nomenclatura.md) e [Estrutura de Arquivos](../reference/estrutura-arquivos.md)

