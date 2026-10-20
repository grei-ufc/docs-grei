# Como Escolher e Adicionar uma Licença ao seu Projeto

A inclusão de um arquivo `LICENSE` é o que define se o seu software de pesquisa é verdadeiramente de código aberto (*open source*) ou apenas código visível publicamente.

!!! warning "O que acontece se o repositório não tiver `LICENSE`?"
    Sem uma licença explícita, o código no GitHub fica automaticamente sob direitos autorais restritivos: outras pessoas podem ler o código, mas **não possuem permissão legal** para utilizá-lo, modificá-lo ou estender sua pesquisa em novos artigos.

## Problema

Você deseja disponibilizar o código da sua simulação ou o conjunto de dados coletados na bancada para a comunidade científica, garantindo que seu trabalho receba os devidos créditos e definindo claramente como outros laboratórios podem utilizá-lo.

## Solução: Escolha Baseada em Objetivos

Siga os passos abaixo para escolher e adicionar a licença adequada ao seu repositório:

### Passo 1: Conheça as Opções Mais Comuns na Academia

| Licença | Tipo | Características Principais | Quando usar no laboratório |
| :--- | :--- | :--- | :--- |
| **MIT** | Permissiva | Simples e direta. Permite qualquer uso, modificação ou distribuição, exigindo apenas a manutenção dos créditos aos autores originais. | **Recomendada por padrão** para a maioria dos scripts, bibliotecas e códigos de TCC/artigos. |
| **Apache 2.0** | Permissiva | Semelhante à MIT, mas inclui cláusulas explícitas de concessão e proteção contra litígios de patentes. | Projetos maiores ou em parceria com empresas e concessionárias de energia. |
| **GNU GPLv3** | *Copyleft* | Exige que qualquer trabalho derivado que seja distribuído também tenha seu código-fonte aberto sob a mesma licença GPLv3. | Quando você quer impedir que versões modificadas do seu software sejam fechadas em produtos proprietários. |
| **CC-BY 4.0 / CC0** | Dados e Documentos | Voltadas para bases de dados (`.csv`, medições de sensores) e textos técnicos, exigindo atribuição (`CC-BY`) ou liberando em domínio público (`CC0`). | Para licenciar os arquivos de dados em `data/` separadamente do código. |

### Passo 2: Gere o Arquivo de Licença

Para utilizar o texto jurídico oficial sem erros:

1. Acesse o site [choosealicense.com](https://choosealicense.com/).
2. Selecione a licença desejada (por exemplo, **MIT License**).
3. Copie o texto integral da licença.

### Passo 3: Adicione ao Repositório

1. Na raiz do seu projeto (no mesmo nível de `pyproject.toml` e `README.md`), crie um arquivo de texto sem extensão chamado exatamente `LICENSE` (em letras maiúsculas).
2. Cole o texto copiado e preencha o `[year]` (ex: `2026`) e `[fullname]` (seu nome e/ou `GREI-UFC`).
3. Registre o arquivo no Git:

   ```bash
   git add LICENSE
   git commit -m "docs: adiciona licenca MIT ao projeto"
   ```

---

## Veja Também

* 🛠️ **Apresentação do projeto:** [Como Escrever um README Profissional para Pesquisa](escrever-readme.md)
* 📖 **Referência:** [Estrutura de Arquivos do Projeto](../reference/estrutura-arquivos.md)
