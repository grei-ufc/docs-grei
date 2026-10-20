# Tutorial 4: Criando sua Documentação Científica com MkDocs

O paradigma de Documentação como Código (*Documentation as Code*) fundamenta-se na premissa de que a explicação técnica deve ser gerida com o mesmo rigor, ferramentas e controle de versão aplicados ao código-fonte da pesquisa.

Neste tutorial, você transformará suas notas de laboratório em um portal web profissional, pesquisável e navegável, utilizando o **MkDocs** e o tema **Material for MkDocs**.

## Passo 1: Instalando as Ferramentas

O MkDocs é um gerador de sites estáticos focado na construção de documentação técnica. Como ele é uma ferramenta de desenvolvimento e documentação, vamos instalá-lo com a flag `--dev` no ambiente isolado do projeto:

```bash
uv add --dev mkdocs-material mkdocstrings[python]
```

!!! info "O que acabamos de instalar?"
    * `mkdocs-material`: Instala o motor do MkDocs junto com o tema visual *Material Design* (com busca integrada, modo escuro e suporte a diagramas e equações LaTeX).
    * `mkdocstrings[python]`: Extensão que permite extrair documentação diretamente das *docstrings* dos seus scripts Python em `src/`.

## Passo 2: Inicializando o Site

Agora, vamos pedir ao MkDocs para criar a estrutura básica do site na raiz do projeto. Lembre-se de usar `uv run` para executar dentro do ambiente isolado:

```bash
uv run mkdocs new .
```

Esse comando criará o arquivo de configuração `mkdocs.yml` na raiz do projeto e uma página inicial `index.md` dentro da pasta `docs/`.

!!! warning "Atualize o seu `.gitignore`"
    Quando o MkDocs compila o site, ele gera uma pasta chamada `site/`. Abra o arquivo `.gitignore` na raiz do seu projeto e adicione uma linha com `site/` para não versionar arquivos HTML gerados automaticamente.

## Passo 3: Configurando o Tema e o Menu

O arquivo `mkdocs.yml` utiliza o formato YAML, baseado em pares `chave: valor` e indentação com espaços. Abra o `mkdocs.yml` no seu editor de texto e substitua o conteúdo pelo bloco abaixo:

```yaml title="mkdocs.yml"
site_name: Controle de Motores — Documentação
theme:
  name: material
  language: pt-BR
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Mudar para modo escuro
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Mudar para modo claro
  features:
    - navigation.sections
    - content.code.copy

nav:
  - Início: index.md
```

*Atenção à indentação: o YAML é sensível à quantidade de espaços no início de cada linha. Utilize sempre múltiplos de 2 espaços e nunca misture com tabulações (`Tab`).*

## Passo 4: Visualizando o seu Site em Tempo Real

Uma das maiores facilidades do MkDocs é o seu servidor local com recarregamento instantâneo (*live reload*). Qualquer alteração salva nos arquivos Markdown dentro de `docs/` atualiza o navegador automaticamente.

Execute no terminal:

```bash
uv run mkdocs serve
```

## Resultado Esperado

O terminal exibirá uma mensagem indicando que o servidor está ativo em `http://127.0.0.1:8000/`.

Abra o navegador e acesse esse endereço. Você verá um portal profissional com busca integrada e alternância entre os modos claro e escuro. Com o terminal aberto, edite o arquivo `docs/index.md`, salve e veja a página atualizar no navegador no mesmo instante!

---

## 🚀 Desafio Prático

Vamos adicionar uma página de explicação metodológica seguindo a [Filosofia Diátaxis](../explanation/filosofia-diataxis.md):

1. Crie um arquivo chamado `metodologia.md` dentro da pasta `docs/` com um título `# Metodologia de Ensaio` e um breve parágrafo descrevendo seu experimento.
2. Adicione `- Metodologia: metodologia.md` na seção `nav:` do arquivo `mkdocs.yml`.
3. Verifique no navegador (`http://127.0.0.1:8000/`) se a nova página apareceu no menu lateral!

??? success "Ver solução sugerida"
    No arquivo `mkdocs.yml`, atualize o bloco `nav:`:
    ```yaml title="mkdocs.yml"
    nav:
      - Início: index.md
      - Metodologia: metodologia.md
    ```
    Assim que você salvar o `mkdocs.yml` e o arquivo `docs/metodologia.md`, o menu lateral exibirá o link **Metodologia** automaticamente.

---

## Próximo Passo e Leitura Complementar

* 👉 **Próximo Tutorial:** [Tutorial 5: Automatizando Testes com `pytest`](testando-pytest.md)
* 💡 **Entenda a fundo:** [Arquitetura da Informação: A Filosofia Diátaxis](../explanation/filosofia-diataxis.md)
* 🛠️ **Guias rápidos:** [Como Documentar Código com Docstrings e `mkdocstrings`](../how-to/documentar-codigo-docstrings.md) e [Como Publicar no GitHub Pages via GitHub Actions](../how-to/publicar-github-pages.md)
