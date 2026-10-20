# Consulta Rápida: Comandos `uv`

Tabela de referência para o gerenciamento de pacotes, versões do Python e ambientes virtuais utilizando o `uv`.

| Comando | Ação | Descrição Técnica |
| :--- | :--- | :--- |
| `uv init <nome>` | Inicialização | Cria um novo projeto com a estrutura básica e o arquivo `pyproject.toml`. |
| `uv python install <versao>` | Instalação | Baixa e instala uma versão específica do Python (ex: `3.12`). |
| `uv python pin <versao>` | Fixação | Trava a versão do Python para o projeto atual (`.python-version`), garantindo reprodutibilidade. |
| `uv add <pacote>` | Adição | Instala biblioteca no ambiente virtual; atualiza `pyproject.toml` e `uv.lock`. |
| `uv add --dev <pacote>` | Adição (Dev) | Instala ferramentas exclusivas de desenvolvimento (ex: `pytest`, `ruff`, `mkdocs-material`). |
| `uv remove <pacote>` | Remoção | Desinstala a biblioteca e limpa suas dependências transitivas órfãs. |
| `uv sync` | Sincronização | Garante que o `.venv` local seja uma cópia exata do especificado no `uv.lock`. |
| `uv run <comando>` | Execução | Executa um script ou ferramenta (ex: `uv run script.py` ou `uv run pytest`) dentro do ambiente virtual. |
| `uv lock` | Resolução | Atualiza ou gera o arquivo `uv.lock` sem alterar o ambiente local. |
| `uv tree` | Inspeção | Exibe a árvore visual de dependências do projeto no terminal. |

---

## Guias Relacionados

* 💡 **Conceito:** [Isolamento de Ambientes e Gestão de Dependências](../explanation/isolamento-ambientes.md)
* 🎓 **Passo a passo:** [Tutorial 1: Configurando seu Ambiente com `uv`](../tutorials/setup-uv.md)
* 🛠️ **Tarefas do dia a dia:** [Como Adicionar e Gerenciar Dependências no Projeto](../how-to/adicionar-dependencia.md)
