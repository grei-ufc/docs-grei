# Tutorial 5: Automatizando Testes com `pytest`

Na pesquisa científica, testar o seu código significa validar se as fórmulas e as transformações matemáticas estão corretas. Fazer isso manualmente toda vez que você altera um script é lento e propenso a erros humanos.

Neste tutorial, você aprenderá a usar o **`pytest`**, a ferramenta padrão da comunidade científica para [testes automatizados](../explanation/testes-automatizados.md) em Python. Ao final, você terá escrito uma função de processamento de sinais e um teste automatizado que garante seu funcionamento perfeito.

## Passo 1: Instalando e Configurando o `pytest`

Ferramentas de teste são dependências exclusivas de desenvolvimento. Abra o terminal na raiz do seu projeto e instale o `pytest` utilizando a flag `--dev`:

```bash
uv add --dev pytest
```

Para que o `pytest` encontre automaticamente os módulos dentro da pasta `src/`, abra o arquivo `pyproject.toml` na raiz do projeto e adicione as duas linhas abaixo ao final do arquivo:

```toml title="pyproject.toml"
[tool.pytest.ini_options]
pythonpath = ["."]
```

## Passo 2: Escrevendo o Código Científico

Vamos criar uma função simples que poderia existir na sua pesquisa: um calculador de tensão média a partir de um vetor de leituras de um sensor.

Crie um arquivo chamado `processamento.py` dentro da pasta `src/` e adicione o seguinte código:

```python title="src/processamento.py"
def calcular_tensao_media(leituras: list[float]) -> float:
    """Calcula a tensão média (V) de um vetor de leituras do sensor."""
    if not leituras:
        return 0.0
    return sum(leituras) / len(leituras)
```

## Passo 3: Escrevendo o seu Primeiro Teste (Padrão AAA)

O `pytest` procura automaticamente por arquivos e funções que começam com o prefixo `test_`. O padrão ouro para estruturar testes é a metodologia **[AAA (Arrange, Act, Assert)](../explanation/testes-automatizados.md#o-padrao-ouro-a-metodologia-aaa)**.

Crie um arquivo chamado `test_processamento.py` dentro da pasta `tests/` com o seguinte conteúdo:

```python title="tests/test_processamento.py"
from src.processamento import calcular_tensao_media


def test_tensao_media_correta():
    # 1. Arrange (Organizar): Preparamos os dados de entrada conhecidos.
    sinal_teste = [2.0, 4.0, 6.0]

    # 2. Act (Agir): Executamos a função que queremos validar.
    resultado = calcular_tensao_media(sinal_teste)

    # 3. Assert (Afirmar): Garantimos que o resultado bate com a matemática esperada.
    assert resultado == 4.0


def test_com_vetor_vazio():
    # Verificamos também o comportamento em casos de borda (vetor sem leituras).
    sinal_vazio = []
    assert calcular_tensao_media(sinal_vazio) == 0.0
```

## Passo 4: Executando a Validação

Agora, vamos pedir ao `pytest` que verifique a nossa matemática dentro do ambiente isolado do projeto. No terminal, digite:

```bash
uv run pytest
```

### Interpretando o Resultado

O terminal exibirá uma saída analisando o seu arquivo de teste e mostrará `2 passed` em verde, indicando que todas as verificações passaram. Se você alterar intencionalmente a fórmula em `src/processamento.py` (por exemplo, dividindo por `2` em vez de `len(leituras)`) e rodar `uv run pytest` novamente, o `pytest` alertará em vermelho mostrando exatamente qual linha e valor falharam.

🎉 **Sucesso!** Você concluiu toda a trilha inicial de tutoriais e aplicou rigor científico ao seu código. Sempre que modificar seus algoritmos no futuro, basta rodar `uv run pytest` para ter certeza de que não quebrou cálculos validados anteriormente.

---

## 🚀 Desafio Prático

Para consolidar o seu aprendizado, resolva o desafio abaixo:

1. No arquivo `src/processamento.py`, crie uma nova função chamada `calcular_potencia_media(tensoes, resistencia)`. Lembre-se de que a potência instantânea dissipada em um resistor é $P = \frac{V^2}{R}$.
2. No arquivo `tests/test_processamento.py`, crie a função `test_potencia_media()`.
3. Use o padrão AAA para passar um vetor de tensões conhecido (ex: `[10.0, 20.0]` com `resistencia = 10.0`) e utilize `assert` para garantir que a potência média calculada é `25.0`.
4. Rode `uv run pytest` e comemore a tela verde!

??? success "Ver solução sugerida"
    Em `src/processamento.py`:
    ```python title="src/processamento.py"
    def calcular_potencia_media(tensoes: list[float], resistencia: float) -> float:
        """Calcula a potência média (W) dissipada em um resistor (Ohms)."""
        if not tensoes or resistencia <= 0:
            return 0.0
        potencias = [(v ** 2) / resistencia for v in tensoes]
        return sum(potencias) / len(potencias)
    ```
    Em `tests/test_processamento.py`:
    ```python title="tests/test_processamento.py"
    from src.processamento import calcular_potencia_media, calcular_tensao_media


    def test_potencia_media():
        # 1. Arrange: [10V, 20V] em R = 10 Ohms -> P = [10W, 40W] -> Média = 25W
        tensoes = [10.0, 20.0]
        resistencia = 10.0

        # 2. Act
        potencia = calcular_potencia_media(tensoes, resistencia)

        # 3. Assert
        assert potencia == 25.0
    ```

---

## Próximos Passos (Guias Práticos)

Agora que você concluiu os 5 tutoriais fundamentais, explore nossos **Guias Práticos (How-to)** para automatizar e publicar o seu projeto:

* 🛠️ [Como Configurar Qualidade de Código Automática com Ruff e pre-commit](../how-to/configurar-precommit-ruff.md)
* 🛠️ [Como Publicar sua Documentação no GitHub Pages via GitHub Actions](../how-to/publicar-github-pages.md)
* 🛠️ [Como Escrever um README Profissional para Pesquisa](../how-to/escrever-readme.md)
* 💡 **Entenda a fundo:** [Testes Automatizados: O Rigor Científico no Código](../explanation/testes-automatizados.md)
