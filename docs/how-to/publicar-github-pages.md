# Como Publicar sua Documentação no GitHub Pages via GitHub Actions

A publicação da documentação no **GitHub Pages** representa o estágio final de um fluxo de trabalho técnico que garante a transparência, a acessibilidade e a reprodutibilidade da sua pesquisa.

## Problema

Você escreveu a documentação do seu projeto (por exemplo, o manual de operação de uma bancada de ensaio de motores) utilizando o [MkDocs](../tutorials/documentando-mkdocs.md) e já a visualizou localmente, mas precisa que ela fique disponível publicamente na internet, atualizando-se automaticamente sempre que um novo `git push` for enviado para a branch `main`.

## Solução: Automação com GitHub Actions

O **GitHub Actions** funciona como um robô de integração contínua (*CI/CD*) que monitora o seu repositório. Toda vez que você envia uma alteração para a branch `main`, ele cria uma máquina virtual temporária, instala o `uv`, compila o site com o MkDocs e publica a versão atualizada no GitHub Pages.

### 1. Verifique o `site_url` no `mkdocs.yml`

O parâmetro mais importante para a publicação correta de estilos e links é o `site_url`. Abra o seu `mkdocs.yml` e certifique-se de que o endereço aponta para a organização ou usuário e o nome exato do repositório:

```yaml title="mkdocs.yml"
site_name: Bancada de Ensaio de Motores — GREI-UFC
site_url: https://SEU_USUARIO.github.io/NOME_DO_REPOSITORIO/
theme:
  name: material
```

### 2. Conceda Permissões ao GitHub Actions

Por padrão, repositórios novos bloqueiam gravações feitas por robôs. Para autorizar a publicação automática:

1. Acesse a página do seu repositório no GitHub.
2. Clique em **Settings** > **Actions** > **General**.
3. Role até a seção **Workflow permissions** e marque a opção **Read and write permissions**.
4. Clique em **Save**.

### 3. Crie o Workflow (`.github/workflows/deploy.yml`)

Na raiz do seu projeto, crie a pasta `.github/workflows/` e, dentro dela, o arquivo `deploy.yml` com o conteúdo abaixo:

```yaml title=".github/workflows/deploy.yml"
name: Deploy Documentação

on:
  push:
    branches:
      - main  # Executa automaticamente a cada push na branch main

permissions:
  contents: write  # Permissão necessária para criar/atualizar a branch gh-pages

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout do repositório
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Instalar uv
        uses: astral-sh/setup-uv@v5
        with:
          enable-cache: true

      - name: Instalar dependências
        run: uv sync

      - name: Build e Deploy no GitHub Pages
        run: uv run mkdocs gh-deploy --force
```

### 4. Envie as Alterações e Ative o GitHub Pages

Salve e envie o novo arquivo para o GitHub:

```bash
git add .github/workflows/deploy.yml mkdocs.yml
git commit -m "ci: configura deploy automatico da documentacao no github pages"
git push origin main
```

!!! note "Verificando o endereço publicado"
    Após o término da execução na aba **Actions** do GitHub (cerca de 30 segundos), acesse **Settings** > **Pages** no seu repositório e verifique se a fonte (*Branch*) está selecionada como `gh-pages`. O link público da sua documentação aparecerá no topo da página!

---

## Veja Também

* 🎓 **Tutorial:** [Tutorial 4: Documentando com MkDocs](../tutorials/documentando-mkdocs.md)
* 💡 **Conceito:** [Arquitetura da Informação: A Filosofia Diátaxis](../explanation/filosofia-diataxis.md)
* 📖 **Referência:** [Estrutura de Arquivos do Projeto](../reference/estrutura-arquivos.md)
