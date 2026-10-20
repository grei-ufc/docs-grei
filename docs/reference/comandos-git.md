# Consulta Rápida: Comandos Git

Tabela de referência para o sistema de controle de versão Git.

| Comando | Categoria | Descrição |
| :--- | :--- | :--- |
| `git init` | Repositório | Inicializa um novo repositório Git no diretório local. |
| `git clone <url>` | Repositório | Baixa uma cópia exata de um repositório remoto para a máquina local. |
| `git status` | Inspeção | Lista os arquivos modificados, preparados (*staged*) e não rastreados. |
| `git diff` | Inspeção | Mostra as alterações exatas linha a linha ainda não enviadas para a *Staging Area*. |
| `git log` | Inspeção | Apresenta o histórico cronológico de *commits* do repositório. |
| `git add <arquivo>` | Preparação | Move modificações para a área de preparação (*Staging Area*). Use `.` para todos. |
| `git commit -m "<msg>"` | Registro | Grava permanentemente os arquivos preparados na linha do tempo do projeto. |
| `git branch <nome>` | Ramificação | Cria uma nova linha do tempo de desenvolvimento paralelo (*branch*). |
| `git switch -c <nome>` | Ramificação | Cria uma nova *branch* e muda imediatamente para ela (equivalente a `git checkout -b`). |
| `git merge <branch>` | Integração | Mescla as alterações de uma *branch* diferente na *branch* atual (ex: `main`). |
| `git remote add <nome> <url>` | Remoto | Conecta o repositório local a um servidor remoto (ex: GitHub). |
| `git push -u <remoto> <branch>` | Sincronização | Envia os *commits* locais para o servidor remoto. |
| `git pull` | Sincronização | Atualiza o repositório local com as alterações mais recentes do servidor remoto. |

---

## Guias Relacionados

* 💡 **Conceito e Convenções de Commit:** [Gestão de Versão: Git e GitHub](../explanation/controle-de-versao.md)
* 🎓 **Passo a passo:** [Tutorial 2: Primeiros Passos com Git e GitHub](../tutorials/primeiro-git.md)
* 🛠️ **Resolução de problemas:** [Como Resolver Conflitos de Merge no Git](../how-to/resolver-conflitos-git.md)
