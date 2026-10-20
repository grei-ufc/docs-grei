# Tutorial 3: Estruturando seu Primeiro Projeto de Engenharia

Quando iniciamos uma pesquisa, como a análise de dados de um sensor de temperatura ou a simulação de um conversor de potência, é tentador salvar todos os scripts e planilhas misturados na mesma pasta. No entanto, projetos desorganizados geram scripts difíceis de manter e ocultam de onde vieram os dados que geraram cada gráfico.

Neste tutorial, você aprenderá a criar a estrutura de diretórios padrão para projetos científicos do GREI-UFC, baseada no **layout `src/`**. Ao final desta lição, você terá um repositório organizado e pronto para crescer ao longo de todo o seu TCC ou pós-graduação.

## Passo 1: Compreendendo o Layout `src/`

No ecossistema Python moderno, a organização de pastas segue o layout baseado em `src/` (abreviação de *source*, ou código-fonte).

Nessa arquitetura, todo o código-fonte reutilizável (funções de filtragem, modelos matemáticos, rotinas de controle) fica dentro da subpasta `src/`, separado fisicamente dos arquivos de configuração da raiz (`pyproject.toml`, `README.md`), dos dados (`data/`) e dos testes (`tests/`).

## Passo 2: Criando a Estrutura de Pastas

Abra o terminal na raiz do seu projeto `controle_motores` e execute os comandos abaixo para criar os diretórios essenciais:

=== "Windows (PowerShell)"

    ```powershell
    mkdir src, data/raw, data/processed, tests, docs
    ```

=== "Linux e macOS"

    ```bash
    mkdir -p src data/raw data/processed tests docs
    ```

## Passo 3: Entendendo cada Compartimento

Pense nessa estrutura como as bancadas organizadas de um laboratório de Engenharia Elétrica:

* **`src/`**: Aqui ficam os seus algoritmos e módulos Python. Se você escrever uma rotina para aplicar um Filtro de Kalman ou calcular harmônicas, salve-a aqui (ex: `src/filtro_kalman.py`).
* **`data/raw/`**: Esta é a sua **"caixa-forte"**. Os dados originais coletados dos sensores, analisadores de energia ou osciloscópios ficam aqui e **nunca devem ser editados manualmente**.
* **`data/processed/`**: Resultados limpos ou intermediários gerados pelos seus scripts. Se um algoritmo removeu *outliers* ou filtrou ruídos do dado bruto, o novo arquivo é salvo nesta pasta.
* **`tests/`**: Onde ficam os scripts automatizados que validam a matemática das funções da pasta `src/`.
* **`docs/`**: Onde vivem os manuais, memoriais de cálculo e explicações da metodologia do projeto.

!!! warning "Atenção à Imutabilidade de `data/raw/`"
    Nunca abra um arquivo `.csv` dentro de `data/raw/` no Excel para apagar linhas manualmente e salvar por cima. Toda limpeza de dados deve ser feita via script em `src/`, lendo de `data/raw/` e salvando o resultado em `data/processed/`. Isso garante total [reprodutibilidade](../explanation/reproducibilidade.md)!

## Resultado Esperado

Ao listar os diretórios do seu projeto, a árvore de arquivos deverá ter a seguinte forma:

```text
controle_motores/
├── data/
│   ├── processed/
│   └── raw/
├── docs/
├── src/
├── tests/
├── .gitignore
├── .python-version
├── pyproject.toml
├── README.md
└── uv.lock
```

🎉 **Parabéns!** Qualquer pesquisador ou avaliador que abrir seu repositório saberá imediatamente onde encontrar os dados originais, a documentação e os algoritmos.

---

## 🚀 Desafio Prático

Vamos organizar o script que criamos no [Tutorial 1](setup-uv.md) seguindo as [Convenções de Nomenclatura](../reference/convencoes-nomenclatura.md):

1. Mova o arquivo `simulacao.py` da raiz do projeto para dentro da pasta `src/`.
2. Execute o script em sua nova localização com `uv run src/simulacao.py`.
3. Registre essa reorganização no Git com um *commit* do tipo `refactor:`.

??? success "Ver solução sugerida"
    ```bash
    # 1. Move o script para a pasta src/ (usando git mv para o Git rastrear a mudança)
    git mv simulacao.py src/simulacao.py

    # 2. Testa a execução no novo caminho
    uv run src/simulacao.py

    # 3. Registra no histórico do Git
    git commit -m "refactor: move script de simulacao para o diretorio src"
    ```

---

## Próximo Passo e Leitura Complementar

* 👉 **Próximo Tutorial:** [Tutorial 4: Documentando com MkDocs](documentando-mkdocs.md)
* 💡 **Entenda a fundo:** [Por que Reprodutibilidade Computacional?](../explanation/reproducibilidade.md)
* 🛠️ **Guias rápidos:** [Como Gerenciar Dados Científicos e `.gitignore`](../how-to/gerenciar-dados-gitignore.md), [Como Escrever um README Profissional](../how-to/escrever-readme.md) e [Como Escolher uma Licença](../how-to/escolher-licenca.md)
* 📖 **Referência:** [Estrutura de Arquivos](../reference/estrutura-arquivos.md) e [Convenções de Nomenclatura](../reference/convencoes-nomenclatura.md)
