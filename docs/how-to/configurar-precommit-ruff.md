# Como Configurar Qualidade de Código Automática com Ruff e pre-commit

Revisar formatação de código (como espaços em branco, quebras de linha e ordem de importações) consome um tempo valioso nas reuniões com seu orientador. Este guia mostra como automatizar a limpeza e padronização do seu código Python utilizando o **Ruff** (um *linter* e formatador extremamente rápido escrito em Rust) e o **pre-commit** (uma ferramenta que verifica automaticamente os arquivos antes de cada *commit* no Git).

## Problema

Você deseja garantir que todos os scripts da sua pesquisa (como `processamento_sinais.py` ou `leitura_sensor.py`) sigam o padrão internacional PEP 8 automaticamente, corrigindo erros de formatação antes que sejam salvos no histórico do Git.

## Solução: Integração de Ruff e pre-commit

Siga os passos abaixo para blindar o seu repositório contra códigos fora do padrão.

### 1. Instalar as Ferramentas de Desenvolvimento

Adicione o `ruff` e o `pre-commit` como dependências de desenvolvimento no seu ambiente isolado:

```bash
uv add --dev ruff pre-commit
```

### 2. Configurar o Ruff no `pyproject.toml`

Abra o arquivo `pyproject.toml` na raiz do seu projeto e adicione a configuração básica do Ruff ao final do arquivo:

```toml title="pyproject.toml"
[tool.ruff]
line-length = 88

[tool.ruff.lint]
# E/F: erros de sintaxe e PEP 8 | I: ordenação de imports | B: prevenção de bugs comuns
select = ["E", "F", "I", "B"]
```

### 3. Criar o Arquivo de Ganchos (`.pre-commit-config.yaml`)

O `pre-commit` precisa saber quais verificações rodar antes de cada *commit*. Crie um arquivo chamado `.pre-commit-config.yaml` na raiz do seu projeto e cole a configuração abaixo:

```yaml title=".pre-commit-config.yaml"
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.9.10
    hooks:
      # Executa o linter e corrige problemas simples automaticamente
      - id: ruff
        args: [ --fix ]
      # Executa o formatador de código (espaços, quebras de linha e aspas)
      - id: ruff-format
```

### 4. Ativar o Gancho no Repositório Local

Para que o Git execute essas verificações automaticamente, instale o gancho (*hook*) no seu repositório local utilizando o `uv`:

```bash
uv run pre-commit install
```

!!! tip "Como funciona no dia a dia?"
    Toda vez que você executar `git commit`, o `pre-commit` entrará em ação e rodará o Ruff. Se o Ruff reformular algum arquivo para corrigir espaços ou importações, basta rodar `git add .` novamente e repetir o `git commit` para gravar o código já limpo!

### 5. Execução Manual em Todo o Projeto (Opcional)

Se quiser formatar e verificar todos os arquivos existentes no projeto de uma só vez sem precisar fazer um *commit*, execute:

```bash
uv run pre-commit run --all-files
```

---

## Veja Também

* 💡 **Conceito:** [Testes Automatizados: O Rigor Científico no Código](../explanation/testes-automatizados.md)
* 📖 **Referência:** [Convenções de Nomenclatura (PEP 8)](../reference/convencoes-nomenclatura.md) e [Glossário Técnico](../reference/glossario.md)
