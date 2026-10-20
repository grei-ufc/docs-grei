# Como Documentar Código Python com Docstrings e `mkdocstrings`

Escrever comentários soltos no meio de equações em Python não é suficiente para que outro pesquisador compreenda como utilizar a sua função. Em códigos científicos de Engenharia Elétrica, é essencial explicitar o que cada parâmetro representa fisicamente e **qual a sua unidade no Sistema Internacional (SI)**.

Neste guia, você aprenderá a documentar suas funções com **Docstrings** (no padrão Google) e a gerar páginas de referência de API automaticamente no MkDocs usando o plugin **`mkdocstrings`**.

## Problema

Você criou um módulo com funções matemáticas em `src/` e deseja que a documentação dessas funções apareça automaticamente no site do MkDocs, sem precisar copiar e colar explicações manualmente a cada alteração no código.

## Solução: Docstrings Padronizadas + `mkdocstrings`

### Passo 1: Escreva Docstrings no Padrão Google com Unidades Físicas

Uma *docstring* é um texto entre três aspas duplas (`"""..."""`) posicionado logo abaixo da definição `def` de uma função ou `class`.

No GREI-UFC, recomendamos o **estilo Google** combinado com **anotações de tipo (*type hints*)** e indicação explícita das **unidades físicas** (`[V]`, `[A]`, `[W]`, `[Hz]`, `[Ohms]`):

```python title="src/processamento.py"
def calcular_potencia_media(tensoes: list[float], resistencia: float) -> float:
    """Calcula a potência ativa média dissipada em um elemento resistivo.

    Aplica a relação instantânea $P(t) = V(t)^2 / R$ sobre a série temporal
    de tensão amostrada e retorna a média aritmética no período.

    Args:
        tensoes: Vetor de leituras instantâneas de tensão elétrica [V].
        resistencia: Valor nominal da resistência de carga [Ohms]. Deve ser > 0.

    Returns:
        Potência ativa média dissipada no resistor [W].

    Raises:
        ValueError: Se o valor de `resistencia` for menor ou igual a zero.
    """
    if resistencia <= 0:
        raise ValueError("A resistência deve ser estritamente positiva (Ohms).")
    if not tensoes:
        return 0.0
    potencias = [(v ** 2) / resistencia for v in tensoes]
    return sum(potencias) / len(potencias)
```

!!! tip "Por que indicar unidades físicas `[V]`, `[A]`, `[rad/s]`?"
    Muitos erros graves em simulações de engenharia ocorrem quando uma função espera frequência em $\text{rad/s}$ e o usuário passa o valor em $\text{Hz}$, ou espera tensão de linha em $\text{kV}$ e recebe em $\text{V}$. Documentar a unidade na *docstring* elimina essa ambiguidade!

### Passo 2: Ative o Plugin `mkdocstrings` no `mkdocs.yml`

Se você seguiu o [Tutorial 4](../tutorials/documentando-mkdocs.md), o pacote `mkdocstrings[python]` já está instalado no seu ambiente `uv`. Para ativá-lo, adicione a seção `plugins:` ao seu arquivo `mkdocs.yml`:

```yaml title="mkdocs.yml"
plugins:
  - search
  - mkdocstrings:
      handlers:
        python:
          paths: [.]
          options:
            docstring_style: google
            show_source: true
```

*Nota: Ao declarar a chave `plugins:` no `mkdocs.yml`, lembre-se de manter `- search` na lista para preservar a barra de busca do site.*

### Passo 3: Insira a Diretiva Automática em uma Página Markdown

Agora, em qualquer página de **Referência** da sua documentação (por exemplo, `docs/reference/api.md`), basta usar a sintaxe `:::` seguida do caminho do módulo Python:

```markdown title="docs/reference/api.md"
# Referência de Funções (API)

Abaixo está a documentação técnica gerada automaticamente a partir do código-fonte em `src/`:

::: src.processamento
```

Ao rodar `uv run mkdocs serve`, o `mkdocstrings` lerá seu arquivo `src/processamento.py` e renderizará automaticamente uma tabela formatada com os tipos, argumentos, unidades físicas, equações LaTeX e o código-fonte expansível da função!

---

## Veja Também

* 🎓 **Tutorial:** [Tutorial 4: Documentando com MkDocs](../tutorials/documentando-mkdocs.md)
* 💡 **Conceito:** [Arquitetura da Informação: A Filosofia Diátaxis](../explanation/filosofia-diataxis.md)
* 📖 **Referência:** [Convenções de Nomenclatura](../reference/convencoes-nomenclatura.md) e [Glossário Técnico](../reference/glossario.md)

