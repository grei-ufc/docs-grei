# Glossário Técnico

Definições rápidas dos termos fundamentais utilizados neste guia.

* **Ambiente Virtual (`.venv`):** Uma pasta isolada dentro do projeto que contém seu próprio interpretador Python e bibliotecas instaladas, prevenindo conflitos com o sistema operacional ou outros projetos.
* **Branch (Ramo):** Uma linha de desenvolvimento paralela no Git, utilizada para desenvolver ou testar novas funcionalidades sem afetar o código principal (`main`) que já funciona.
* **CI/CD (Integração e Entrega Contínuas):** Prática de automação em nuvem (como o GitHub Actions) para executar testes automatizados ou publicar a documentação sempre que o código é atualizado.
* **Commit:** Um registro imutável na linha do tempo do Git; um instantâneo (*snapshot*) do estado dos arquivos do projeto em um determinado momento, acompanhado de autor, data e mensagem descritiva.
* **Conventional Commits:** Convenção de escrita de mensagens de *commit* com prefixos padronizados (`feat:`, `fix:`, `docs:`, `test:`, `refactor:`) para tornar o histórico do projeto legível e semântico.
* **Dependência:** Uma biblioteca de software externa (ex: `numpy`, `scipy`, `matplotlib`) exigida pelo seu projeto para funcionar corretamente.
* **Docstring:** String literal em Python posicionada logo na primeira linha de um módulo, classe ou função para documentar seu propósito, argumentos, unidades físicas e valores de retorno.
* **Formatador:** Ferramenta (como o `ruff format`) que reorganiza automaticamente espaços em branco, quebras de linha e aspas do código para obedecer ao padrão PEP 8.
* **Linter:** Ferramenta de análise estática (como o `ruff check`) que inspeciona o código-fonte em busca de erros de sintaxe, variáveis não utilizadas ou violações de boas práticas.
* **Merge:** O processo de integrar as modificações feitas em uma *branch* paralela de volta ao ramo principal (`main`).
* **MRE (Minimal, Reproducible Example):** Exemplo mínimo e autocontido de código capaz de reproduzir um erro específico. Essencial para relatar problemas (*Issues*) ou pedir ajuda técnica.
* **Pull Request (PR):** Solicitação formal no GitHub para revisar e mesclar o código de uma *branch* de trabalho na *branch* principal do repositório.
* **Repositório:** O diretório do projeto monitorado pelo Git, contendo todos os arquivos versionados e o histórico completo de suas modificações.

---

## Guias Relacionados

* 💡 **Fundamentos:** [Por que Reprodutibilidade Computacional?](../explanation/reproducibilidade.md) e [Gestão de Versão: Git e GitHub](../explanation/controle-de-versao.md)
* 📖 **Tabelas de comandos:** [Comandos `uv`](comandos-uv.md) e [Comandos Git](comandos-git.md)
