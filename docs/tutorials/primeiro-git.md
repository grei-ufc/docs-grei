# Tutorial 2: Primeiros Passos com Git e GitHub

Trabalhar em um projeto sem controle de versão é como escrever um TCC inteiro sem nunca salvar cópias de segurança. O **Git** funciona como uma máquina do tempo para o seu código: ele permite salvar o estado exato dos seus scripts e voltar atrás caso uma simulação dê errado. O **GitHub** é a nuvem onde você guardará essas cópias para colaborar com seu orientador e colegas de laboratório.

Neste tutorial, você transformará a pasta `controle_motores` criada no [Tutorial 1](setup-uv.md) em um repositório versionado e fará o seu primeiro *backup* estruturado na nuvem.

## Passo 1: Configurando a sua Identidade no Git

Se você acabou de instalar o Git no seu computador, precisa informar seu nome e e-mail. Essa "etiqueta" será registrada em todas as suas contribuições científicas.

Abra o terminal e digite (substituindo pelos seus dados reais):

```bash
git config --global user.name "Seu Nome Completo"
git config --global user.email "seu.email@alu.ufc.br"
```

Em seguida, garanta que o ramo principal dos seus repositórios siga o padrão moderno, chamando-se `main`:

```bash
git config --global init.defaultBranch main
```

!!! info "Configuração única"
    Como utilizamos a flag `--global`, você só precisa executar o Passo 1 uma única vez no seu computador.

## Passo 2: Inicializando e Inspecionando o Repositório Local

Certifique-se de estar dentro da pasta do seu projeto (`controle_motores`). Como criamos o projeto com `uv init` no tutorial anterior, o `uv` já inicializou o Git e criou um arquivo `.gitignore` automaticamente! Caso tenha criado uma pasta manualmente sem o `uv`, basta rodar:

```bash
git init
```

O Git mantém uma pasta oculta `.git` (o banco de dados do histórico) e consulta o arquivo [`.gitignore`](../reference/estrutura-arquivos.md) para saber quais pastas **não** devem ser salvas (como a pasta `.venv/`).

Antes de preparar seus arquivos, verifique sempre o estado do diretório:

```bash
git status
```

Você verá a lista dos arquivos prontos para rastreamento (`pyproject.toml`, `uv.lock`, `simulacao.py`, etc.) e notará que a pasta `.venv/` foi ignorada com segurança.

## Passo 3: O seu Primeiro *Commit* (Salvar na Máquina do Tempo)

Agora vamos gravar o primeiro registro oficial dos arquivos no histórico do Git.

1. **Adicionar à Área de Preparação (*Stage*):** Mova os arquivos modificados para a zona de preparação usando o comando `add`:

   ```bash
   git add .
   ```

2. **Registrar o Histórico (*Commit*):** Grave o estado atual com uma mensagem clara seguindo o padrão [Conventional Commits](../explanation/controle-de-versao.md#convencoes-de-commits-conventional-commits):

   ```bash
   git commit -m "feat: inicia projeto e adiciona script base de simulacao"
   ```

## Passo 4: Conectando com o GitHub (A Garagem)

Seu código já está seguro no histórico local do seu computador, mas precisamos de uma cópia na nuvem.

1. Acesse o site do [GitHub](https://github.com/) e faça login na sua conta.
2. No canto superior direito, clique no ícone **"+"** e selecione **"New repository"**.
3. Dê um nome ao repositório (ex: `controle-motores-tcc`), **deixe desmarcadas** as opções de adicionar `README` ou `.gitignore` (pois já temos esses arquivos localmente) e clique em **"Create repository"**.
4. O GitHub mostrará uma página com instruções. Copie o link HTTPS do seu novo repositório (ex: `https://github.com/seu-usuario/controle-motores-tcc.git`).

## Passo 5: Enviando sua Pesquisa para a Nuvem (*Push*)

Volte ao terminal do seu computador. Vamos conectar a sua pasta local ao repositório remoto que você acabou de criar no GitHub:

```bash
git remote add origin https://github.com/seu-usuario/controle-motores-tcc.git
```

Por fim, envie o seu *commit* para a nuvem com o comando `push`:

```bash
git push -u origin main
```

*(Na primeira vez, o Git poderá abrir uma janela do navegador solicitando que você autorize o login no GitHub).*

🎉 **Pronto!** Vá até a página do seu repositório no GitHub e atualize o navegador (`F5`). Você verá seus scripts seguros, organizados e acessíveis para o seu orientador!

---

## 🚀 Desafio Prático

Vamos simular o ciclo diário de evolução da sua pesquisa:

1. Abra o arquivo `simulacao.py` e adicione um comentário explicando a frequência de amostragem utilizada.
2. Rode `git status` e `git diff` no terminal para inspecionar o que mudou.
3. Adicione a alteração com `git add simulacao.py`, crie um novo *commit* (`docs: comenta frequencia de amostragem na simulacao`) e envie para o GitHub com `git push`.
4. Rode `git log --oneline` para visualizar os dois pontos da sua linha do tempo!

??? success "Ver solução sugerida"
    ```bash
    # 1. Verifique o que foi alterado no arquivo
    git status
    git diff

    # 2. Prepare, registre o commit e envie para a nuvem
    git add simulacao.py
    git commit -m "docs: comenta frequencia de amostragem na simulacao"
    git push

    # 3. Visualize o histórico resumido
    git log --oneline
    ```

---

## Próximo Passo e Leitura Complementar

* 👉 **Próximo Tutorial:** [Tutorial 3: Estruturando seu Primeiro Projeto de Engenharia](estrutura-projeto.md)
* 💡 **Entenda a fundo:** [Gestão de Versão: Git e GitHub](../explanation/controle-de-versao.md)
* 🛠️ **Guia rápido:** [Como Resolver Conflitos de Merge no Git](../how-to/resolver-conflitos-git.md)
* 📖 **Referência:** [Consulta Rápida: Comandos Git](../reference/comandos-git.md)
