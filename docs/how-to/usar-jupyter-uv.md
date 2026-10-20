# Como Usar Jupyter Notebooks de Forma Reprodutível com `uv`

Os **Jupyter Notebooks** (arquivos `.ipynb`) são ferramentas excelentes na Engenharia Elétrica para análise exploratória de sinais, visualização rápida de formas de onda e criação de relatórios interativos combinando texto, equações em LaTeX e gráficos.

No entanto, quando usados sem critério, notebooks frequentemente se tornam fontes de erros de reprodutibilidade (células executadas fora de ordem, variáveis ocultas na memória e pacotes instalados fora do ambiente do projeto). Este guia mostra como integrar o Jupyter ao ambiente isolado do **`uv`** e organizar seus experimentos.

## Problema

Você deseja criar e executar um Jupyter Notebook (no navegador ou dentro do VS Code) utilizando exatamente as bibliotecas instaladas na pasta `.venv` do seu projeto gerenciado pelo `uv`.

## Solução: Integrando o Jupyter ao Ambiente `uv`

### 1. Instale o Jupyter como Dependência de Desenvolvimento

Para não poluir as dependências principais do seu código de produção, adicione o `ipykernel` e o `jupyterlab` com a flag `--dev`:

```bash
uv add --dev ipykernel jupyterlab
```

### 2. Executando seus Notebooks

Você pode trabalhar com seus notebooks de duas formas principais:

=== "No VS Code (Recomendado)"

    1. Instale a extensão oficial **Jupyter** (da Microsoft) no seu VS Code.
    2. Crie uma pasta chamada `notebooks/` na raiz do projeto e, dentro dela, crie um arquivo `01_exploracao_sinal.ipynb`.
    3. No canto superior direito do editor do notebook, clique em **Select Kernel** > **Python Environments...**.
    4. Escolha o interpretador marcado com **`.venv`** (localizado dentro da pasta do seu projeto).

=== "No Navegador (JupyterLab)"

    Execute o JupyterLab diretamente pelo guardião do `uv` no terminal:

    ```bash
    uv run jupyter lab
    ```

    O navegador abrirá automaticamente já conectado ao ambiente virtual `.venv` do seu projeto!

### 3. Importando Módulos da Pasta `src/` dentro do Notebook

Se o seu notebook está dentro da subpasta `notebooks/` e você deseja importar uma função que está em `src/processamento.py`, adicione a raiz do projeto ao caminho de busca logo na primeira célula do notebook:

```python
import sys
from pathlib import Path

# Adiciona a raiz do projeto ao path para importar módulos de src/
sys.path.append(str(Path.cwd().parent))

from src.processamento import calcular_tensao_media
```

---

## Boas Práticas Científicas para Notebooks no GREI-UFC

Para evitar que seus notebooks virem um "código espaguete" impossível de auditar, siga estas quatro regras de laboratório:

1. **Prototipe no Notebook, consolide em `src/`:** Use o notebook para explorar os dados e ajustar gráficos. Assim que uma função matemática (ex: um filtro ou extrator de atributos) estiver definida, mova-a para um arquivo `.py` dentro de `src/`, escreva um teste para ela em `tests/` com `pytest` e apenas importe-a no notebook.
2. **Teste do "Restart & Run All":** Antes de salvar seu trabalho ou enviá-lo para o Git, clique em **Restart Kernel and Run All Cells** (Reiniciar e Executar Tudo). Um notebook só é reprodutível se rodar da primeira à última célula em sequência sem erros!
3. **Numere seus Notebooks:** Nomeie os arquivos na pasta `notebooks/` com prefixos numéricos que indiquem a ordem lógica do experimento (ex: `01_limpeza_dados.ipynb`, `02_analise_espectral.ipynb`, `03_geracao_figuras_artigo.ipynb`).
4. **Nunca instale pacotes com `!pip install` dentro de células:** Se precisar de uma biblioteca nova durante a análise, volte ao terminal e use `uv add <pacote>` para atualizar o `pyproject.toml` e o `uv.lock`.

---

## Veja Também

* 🎓 **Tutoriais:** [Tutorial 1: Configurando seu Ambiente com `uv`](../tutorials/setup-uv.md) e [Tutorial 3: Estruturando um Projeto](../tutorials/estrutura-projeto.md)
* 🛠️ **Dependências:** [Como Adicionar e Gerenciar Dependências no Projeto](adicionar-dependencia.md)
* 📖 **Referência:** [Convenções de Nomenclatura](../reference/convencoes-nomenclatura.md)

