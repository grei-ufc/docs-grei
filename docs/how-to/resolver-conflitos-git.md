# Como Resolver Conflitos de Merge no Git

A colaboração em projetos de pesquisa frequentemente envolve múltiplos estudantes ou a revisão de código pelo orientador. Quando alterações feitas em paralelo são integradas (*merged*), podem surgir divergências nas mesmas linhas de código.

## Problema

Você e seu colega editaram a mesma linha do mesmo script (por exemplo, alterando o valor da frequência de corte de um filtro digital em `src/processamento.py`) de formas diferentes. Ao tentar integrar as mudanças com `git pull` ou `git merge`, o Git interrompe o processo e reporta um **Conflito de Fusão** (*Merge Conflict*).

## Solução: Resolução Manual de Conflitos

!!! info "Não entre em pânico!"
    Um conflito de merge não significa que você perdeu arquivos. O Git apenas pausou a fusão para proteger o código e aguarda que você, como pesquisador, decida qual versão matemática está correta.

### 1. Identifique os Arquivos em Conflito

Para descobrir exatamente em qual arquivo o conflito ocorreu, utilize o comando de diagnóstico:

```bash
git status
```

O terminal listará os arquivos conflitantes sob a seção `Unmerged paths` (`both modified`).

### 2. Abra o Arquivo e Localize os Marcadores

Abra o arquivo indicado no seu editor de código (como o VS Code). O Git terá inserido marcadores visuais delimitando as duas versões divergentes:

```python title="src/processamento.py"
import numpy as np

def aplicar_filtro(sinal):
<<<<<<< HEAD
    frequencia_corte = 120.0  # Sua alteração local
=======
    frequencia_corte = 60.0   # Alteração que veio do colega / GitHub
>>>>>>> branch-do-colega
    # resto do código...
```

* O bloco entre `<<<<<<< HEAD` e `=======` mostra o que está na sua *branch* atual.
* O bloco entre `=======` e `>>>>>>>` mostra o que veio da outra *branch* ou do servidor remoto.

### 3. Tome a Decisão Técnica e Limpe os Marcadores

Avalie a situação do ponto de vista da Engenharia Elétrica. Se o experimento exige filtrar o ruído fundamental da rede elétrica em $60\text{ Hz}$, mantenha a versão de `60.0`.

Para concluir a edição, **apague manualmente as três linhas de marcadores** (`<<<<<<<`, `=======`, `>>>>>>>`) e deixe apenas o código final desejado:

```python title="src/processamento.py"
import numpy as np

def aplicar_filtro(sinal):
    frequencia_corte = 60.0
    # resto do código...
```

Salve o arquivo após a edição.

### 4. Confirme a Resolução (*Stage* e *Commit*)

Agora avise ao Git que o conflito foi resolvido preparando o arquivo e registrando o *commit*:

```bash
git add src/processamento.py
git commit -m "fix: resolve conflito de merge na frequencia de corte do filtro"
```

Pronto! As linhas do tempo voltaram a convergir e você já pode executar os testes com `uv run pytest` ou enviar o código com `git push`.

---

## Veja Também

* 💡 **Conceito:** [Gestão de Versão: Git e GitHub](../explanation/controle-de-versao.md)
* 🎓 **Tutorial:** [Tutorial 2: Primeiros Passos com Git e GitHub](../tutorials/primeiro-git.md)
* 📖 **Referência:** [Consulta Rápida: Comandos Git](../reference/comandos-git.md)
