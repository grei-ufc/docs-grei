# Tutorial 1: Configurando seu Ambiente de Pesquisa com `uv`

Na Engenharia Elétrica, simulações de sistemas dinâmicos ou análises de sinais de sensores exigem bibliotecas matemáticas específicas. Instalar essas ferramentas diretamente no sistema operacional frequentemente causa o ["inferno de dependências"](../explanation/isolamento-ambientes.md), quebrando projetos antigos.

Neste tutorial, você aprenderá a usar o **`uv`**, um gerenciador ultrarrápido escrito em Rust, para criar um ambiente isolado (uma "bolha" segura) para a sua pesquisa. Ao final, você terá um projeto pronto para rodar scripts de processamento de sinais sem afetar o restante do seu computador.

## Passo 1: Instalando o `uv`

A instalação do `uv` é feita diretamente pelo terminal e não exige que você tenha o Python previamente instalado na máquina.

Abra o terminal e execute o comando correspondente ao seu sistema operacional:

=== "Windows (PowerShell)"

    ```powershell
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```

=== "Linux e macOS"

    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```

!!! note "Verificando a instalação"
    Após a instalação, feche e abra o terminal novamente para que o comando seja reconhecido. Teste digitando `uv --version`. Se a versão for exibida na tela, você está pronto para continuar!

## Passo 2: Inicializando o seu Projeto

Vamos criar uma pasta para uma pesquisa sobre **Controle de Motores**. Navegue pelo terminal até o diretório onde deseja guardar seus projetos e execute:

```bash
uv init controle_motores
cd controle_motores
```

O comando `uv init` cria a estrutura mínima do projeto, incluindo o arquivo `pyproject.toml` (o diário de bordo técnico da sua pesquisa) e o `.gitignore`.

## Passo 3: Fixando a Versão do Python

Para garantir que a sua pesquisa seja [reprodutível](../explanation/reproducibilidade.md) (ou seja, funcione no computador do seu orientador daqui a um ano), vamos travar a versão do Python em `3.12`:

```bash
uv python pin 3.12
```

O `uv` fará o download automático do Python 3.12 (caso você ainda não o tenha) e criará o arquivo `.python-version`, garantindo que este projeto utilize exclusivamente essa versão.

## Passo 4: Adicionando Bibliotecas Científicas

Agora, vamos instalar as bibliotecas de cálculo numérico que utilizaremos para modelar o motor. Execute:

```bash
uv add numpy scipy matplotlib
```

O `uv` criará a pasta do ambiente virtual (`.venv`) e baixará os pacotes em poucos segundos. Ele também gerará o arquivo `uv.lock`, que registra as versões exatas de cada pacote instalado.

## Passo 5: Executando seu Primeiro Script Seguro

Crie um arquivo chamado `simulacao.py` na pasta do projeto e adicione o código abaixo:

```python title="simulacao.py"
import numpy as np

# Gera um vetor de tempo de 0 a 1 segundo com 100 amostras
tempo = np.linspace(0, 1, 100)
print(f"Vetor de tempo criado com {len(tempo)} amostras.")
print("Ambiente configurado com sucesso para a Engenharia Elétrica!")
```

Para executar esse script garantindo o uso das bibliotecas isoladas do projeto, utilize **sempre** o prefixo `uv run`:

```bash
uv run simulacao.py
```

🎉 **Sucesso!** Você verá a mensagem impressa no terminal. Seu laboratório digital está configurado e blindado contra conflitos de versão.

---

## 🚀 Desafio Prático

Para fixar o que aprendeu neste tutorial:

1. Adicione a biblioteca `pandas` (muito usada para leitura de tabelas `.csv` de instrumentos de bancada) ao projeto usando o `uv`.
2. Modifique o arquivo `simulacao.py` para gerar uma senoide de $60\text{ Hz}$ (`sinal = np.sin(2 * np.pi * 60 * tempo)`) e imprima o valor máximo do sinal com `np.max(sinal)`.
3. Execute novamente o script com `uv run simulacao.py`.

??? success "Ver solução sugerida"
    No terminal:
    ```bash
    uv add pandas
    ```
    No arquivo `simulacao.py`:
    ```python title="simulacao.py"
    import numpy as np

    tempo = np.linspace(0, 1, 1000)
    sinal = np.sin(2 * np.pi * 60 * tempo)
    print(f"Amplitude máxima da senoide de 60 Hz: {np.max(sinal):.4f} V")
    ```
    Para executar:
    ```bash
    uv run simulacao.py
    ```

---

## Próximo Passo e Leitura Complementar

* 👉 **Próximo Tutorial:** [Tutorial 2: Primeiros Passos com Git e GitHub](primeiro-git.md)
* 💡 **Entenda a fundo:** [Isolamento de Ambientes e Gestão de Dependências](../explanation/isolamento-ambientes.md)
* 🛠️ **Guia rápido:** [Como Adicionar e Gerenciar Dependências](../how-to/adicionar-dependencia.md)
* 📖 **Referência:** [Consulta Rápida: Comandos `uv`](../reference/comandos-uv.md)
