# Como Escrever um README Profissional para Pesquisa

O arquivo `README.md` é a interface primária entre o pesquisador e o mundo exterior. Ele funciona como a "vitrine virtual" do seu repositório no GitHub. Um erro comum de estudantes iniciantes é deixar este arquivo vazio ou com descrições genéricas (ex: *"Trabalho da disciplina X"*). Este guia mostra como estruturar um `README.md` que comunique o rigor metodológico da sua pesquisa em Engenharia Elétrica.

## Problema

Você concluiu o desenvolvimento do seu simulador de eletrônica de potência ou do seu algoritmo de processamento de sinais e precisa apresentá-lo no GitHub para que seu orientador, avaliadores de banca e outros pesquisadores entendam rapidamente o que ele faz, como instalá-lo e como reproduzir os resultados.

## Solução: A Estrutura de "Pitch de Elevador"

Um `README.md` profissional deve ser conciso e responder instantaneamente a quatro perguntas: *O que este projeto faz? Por que ele é relevante? Como posso executá-lo? Quem são os autores?*

Siga o modelo estrutural abaixo para compor o seu arquivo na raiz do projeto:

### 1. Título e Badges (Escudos)

Comece com um título claro e utilize *badges* para comunicar rapidamente os requisitos e a licença do projeto:

```markdown
# Analisador de Harmônicas em Redes de Distribuição

![Python](https://img.shields.io/badge/python-3.12-blue.svg)
![uv](https://img.shields.io/badge/uv-Astral-DE5FE9.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
```

### 2. Contexto Científico (Descrição)

Fuja de justificativas genéricas. Explique em um ou dois parágrafos o problema científico que o software resolve, as hipóteses testadas ou os algoritmos matemáticos implementados (ex: *"Este projeto implementa uma Transformada Rápida de Fourier (FFT) janelada para detecção de falhas de barra quebrada em motores de indução trifásicos"*).

### 3. Guia de Instalação Rápida

Forneça comandos prontos para serem copiados e colados. Como padronizamos o uso do `uv`, sua seção de instalação é direta e reprodutível:

````markdown
## Instalação

Clone o repositório e sincronize o ambiente isolado utilizando o `uv`:

```bash
git clone https://github.com/seu-usuario/analisador-harmonicas.git
cd analisador-harmonicas
uv sync
```
````

### 4. Exemplo de Uso

Inclua os comandos exatos para executar a simulação ou gerar os gráficos do artigo/TCC:

````markdown
## Como Usar

Para processar o sinal bruto do sensor e visualizar o espectro de harmônicas:

```bash
uv run src/analise_espectro.py --input data/raw/2026-03-29-leitura-motor.csv
```

Para executar a suíte de testes automatizados:

```bash
uv run pytest
```
````

### 5. Créditos, Citação e Fomento

Sempre inclua uma seção identificando os autores, orientador, laboratório (GREI-UFC), agências de fomento (CNPq, CAPES, FUNCAP) e o link para o TCC, dissertação ou artigo publicado relacionado.

---

## Veja Também

* 🛠️ **Licenciamento:** [Como Escolher e Adicionar uma Licença ao seu Projeto](escolher-licenca.md)
* 🎓 **Estrutura:** [Tutorial 3: Estruturando seu Primeiro Projeto de Engenharia](../tutorials/estrutura-projeto.md)
* 📖 **Referência:** [Estrutura de Arquivos do Projeto](../reference/estrutura-arquivos.md)
