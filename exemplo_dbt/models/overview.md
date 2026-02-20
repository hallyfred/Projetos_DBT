{% docs __overview__ %}

#  Documentação Técnica - Northwind Analytics

Bem-vindo à documentação automatizada do pipeline de dados da Northwind, gerada via dbt.

> ** Contexto Geral:** Esta página é focada exclusivamente nos detalhes técnicos da modelagem (tabelas, colunas, testes e linhagem). Para entender o contexto de negócio, as tecnologias utilizadas e a arquitetura completa do projeto, **[acesse o README principal no repositório do GitHub](https://github.com/hallyfred/Projetos_DBT/tree/dev)**.

##  Como explorar este ambiente:

* **Grafo de Linhagem (DAG):** Clique no botão azul no canto inferior direito da tela. Ele abrirá o mapa visual interativo mostrando exatamente como os dados fluem da origem até os modelos finais no BigQuery.
* **Navegação de Tabelas:** Utilize o menu lateral esquerdo. A aba *Project* espelha a nossa estrutura de pastas, e a aba *Database* mostra como as tabelas estão organizadas dentro do banco de dados.
* **Nível Granular:** Ao clicar em qualquer modelo (ex: as tabelas da camada `marts`), você poderá visualizar a descrição detalhada das colunas, os tipos de dados e os testes de qualidade aplicados.

Fique à vontade para explorar o código por trás dos dados!

{% enddocs %}