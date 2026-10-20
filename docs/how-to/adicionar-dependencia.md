# Como Adicionar e Gerenciar Dependências no Projeto

Durante o desenvolvimento de uma pesquisa em Engenharia Elétrica, é comum precisar de bibliotecas externas para realizar tarefas específicas, como processamento de sinais, controle de sistemas ou plotagem de gráficos. Este guia orienta como adicionar, remover e sincronizar esses pacotes utilizando o gerenciador [`uv`](../explanation/isolamento-ambientes.md).

## Problema

Você precisa adicionar uma nova biblioteca (como `scipy` ou `control`) ao seu projeto sem quebrar o ambiente virtual e garantindo que seus colegas de laboratório utilizem exatamente a mesma versão no futuro.

## Solução: Adicionando Dependências Regulares

Para bibliotecas que são estritamente necessárias para o seu algoritmo funcionar (aquelas que você importa dentro dos scripts em `src/`), utilize o comando `uv add`:

1. Abra o terminal na raiz do seu projeto.
2. Execute o comando com os pacotes desejados:

   ```bash
   uv add scipy numpy matplotlib
   ```

3. **O que acontece nos bastidores:** O `uv` realiza três ações simultâneas:
   * Resolve a melhor versão compatível com o seu sistema operacional e versão do Python.
   * Atualiza o arquivo `pyproject.toml` declarando que o projeto depende dessas bibliotecas.
   * Gera ou atualiza o arquivo `uv.lock`, gravando a versão exata e o *hash* criptográfico de cada pacote.

## Adicionando Dependências de Desenvolvimento (`--dev`)

Ferramentas que auxiliam na escrita, formatação ou documentação do código (como *linters*, formatadores e frameworks de teste) não devem ser misturadas com as bibliotecas matemáticas que executam a sua pesquisa. Elas são chamadas de **dependências de desenvolvimento**.

1. Para adicionar uma ferramenta de teste ou documentação, utilize a flag `--dev`:

   ```bash
   uv add --dev pytest ruff
   ```

2. Isso mantém o ambiente principal de execução enxuto — o que é essencial caso seu código precise ser embarcado em um Raspberry Pi ou servidor com recursos limitados.

## Removendo Dependências

Se você decidiu trocar de biblioteca ou não utiliza mais um pacote, **não edite os arquivos de configuração manualmente**:

1. Execute o comando de remoção:

   ```bash
   uv remove matplotlib
   ```

2. O `uv` desinstalará a biblioteca e limpará automaticamente todas as dependências transitivas (pacotes secundários) que não são mais exigidas por nenhum outro pacote do projeto.

## Sincronizando o Ambiente (`uv sync`)

Se você acabou de clonar o repositório de um colega de laboratório ou baixou atualizações com `git pull`, seu computador precisa instalar as bibliotecas registradas no `uv.lock`:

```bash
uv sync
```

!!! tip "Sincronização determinística"
    O comando `uv sync` lê o arquivo `uv.lock` e garante que a sua pasta `.venv` local seja uma cópia idêntica ao ambiente do autor original.

---

## Veja Também

* 💡 **Conceito:** [Isolamento de Ambientes e Gestão de Dependências](../explanation/isolamento-ambientes.md)
* 🎓 **Tutorial:** [Tutorial 1: Configurando seu Ambiente com `uv`](../tutorials/setup-uv.md)
* 📖 **Referência:** [Consulta Rápida: Comandos `uv`](../reference/comandos-uv.md)
