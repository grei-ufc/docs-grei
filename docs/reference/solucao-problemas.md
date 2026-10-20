# Solução de Problemas Comuns (Troubleshooting)

Guia de consulta rápida para diagnosticar e resolver os erros mais frequentes encontrados durante a configuração de projetos com `uv`, Git, `pytest` e MkDocs.

---

## 1. Problemas com `uv` e Python

### ❌ Erro: `uv: command not found` ou `'uv' não é reconhecido como um comando`

* **Causa:** O terminal atual foi aberto antes da instalação do `uv` e ainda não carregou a nova variável de ambiente `PATH`.
* **Solução:** Feche completamente a janela do terminal (ou do VS Code), abra um novo terminal e teste com `uv --version`.

### ❌ Erro no PowerShell: `a execução de scripts foi desabilitada neste sistema`

* **Causa:** A política padrão do Windows PowerShell bloqueia a execução de scripts locais (como a ativação manual do `.venv\Scripts\activate`).
* **Solução 1 (Recomendada):** Não ative o ambiente manualmente! Use sempre **`uv run <comando>`** (ex: `uv run python src/simulacao.py`), que contorna essa restrição automaticamente.
* **Solução 2:** Caso precise liberar a execução de scripts para o seu usuário no Windows, rode no PowerShell:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

### ❌ Erro: `ModuleNotFoundError: No module named 'numpy'` (mesmo após `uv add numpy`)

* **Causa:** Você executou o script usando `python script.py` (Python global do sistema) em vez de usar o ambiente isolado do projeto.
* **Solução:** Execute sempre precedido por `uv run`:
  ```bash
  uv run src/simulacao.py
  ```

---

## 2. Problemas com `pytest`

### ❌ Erro: `ModuleNotFoundError: No module named 'src'` ao rodar `uv run pytest`

* **Causa:** O `pytest` não incluiu o diretório raiz do projeto no `PYTHONPATH`.
* **Solução:** Adicione as duas linhas abaixo ao final do arquivo `pyproject.toml` na raiz do projeto:
  ```toml title="pyproject.toml"
  [tool.pytest.ini_options]
  pythonpath = ["."]
  ```

---

## 3. Problemas com Git e GitHub

### ❌ Adicionei a pasta `.venv/` ou um arquivo gigante por engano no `git add`

* **Causa:** O comando `git add .` foi executado antes de configurar o arquivo `.gitignore`.
* **Solução:** Remova o arquivo/pasta do rastreamento do Git **sem apagá-lo do seu computador** usando a flag `--cached`:
  ```bash
  # Remove a pasta .venv do rastreamento do Git (mantendo-a no disco)
  git rm -r --cached .venv/

  # Certifique-se de que .venv/ está no .gitignore e faça um novo commit
  git add .gitignore
  git commit -m "chore: remove .venv do controle de versao"
  ```

### ❌ Erro no `git push`: `[rejected] main -> main (non-fast-forward)`

* **Causa:** O repositório no GitHub possui *commits* novos (feitos por um colega ou diretamente pelo site do GitHub) que ainda não estão no seu computador.
* **Solução:** Baixe e integre as alterações remotas antes de enviar as suas:
  ```bash
  git pull origin main
  git push origin main
  ```

---

## 4. Problemas com MkDocs

### ❌ Erro: `yaml.scanner.ScannerError: mapping values are not allowed here`

* **Causa:** Erro de indentação ou uso de caractere `Tab` no arquivo `mkdocs.yml`.
* **Solução:** Revise o `mkdocs.yml` garantindo que cada nível hierárquico utilize exatamente **2 espaços** e que haja um espaço após os dois-pontos (`chave: valor`).

---

## Guias Relacionados

* 📖 **Comandos de referência:** [Comandos `uv`](comandos-uv.md) e [Comandos Git](comandos-git.md)
* 🛠️ **Configuração de dados:** [Como Gerenciar Dados Científicos e Configurar o `.gitignore`](../how-to/gerenciar-dados-gitignore.md)
* 🛠️ **Conflitos no Git:** [Como Resolver Conflitos de Merge no Git](../how-to/resolver-conflitos-git.md)

