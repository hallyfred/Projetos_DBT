# 📊 Projeto de Analytics Engineering com dbt e BigQuery

[![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)](#)
[![Google BigQuery](https://img.shields.io/badge/Google_BigQuery-669DF6?style=for-the-badge&logo=google-cloud&logoColor=white)](#)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](#)

> **[Clique aqui para acessar a Documentação Viva do dbt (GitHub Pages)](https://hallyfred.github.io/Projetos_DBT/#!/overview)**

##  Sobre o Projeto
Este é um projeto de portfólio desenvolvido para demonstrar a aplicação de práticas modernas de **Analytics Engineering**. O objetivo principal é simular um pipeline de dados ponta a ponta, transformando dados brutos em modelos otimizados para consumo em ferramentas de Business Intelligence (BI).

##  Tecnologias
* **Data Warehouse:** Google BigQuery
* **Transformação de Dados:** dbt (data build tool)
* **Orquestração e CI/CD:** GitHub Actions
* **Controle de Versão:** Git & GitHub

##  Arquitetura e Modelagem de Dados
O pipeline de dados foi desenhado com base nos princípios da **Arquitetura Medalhão (Medallion Architecture)**. As transformações foram estruturadas em camadas lógicas dentro do dbt para garantir governança, reaproveitamento de código e otimização de custos no BigQuery:

1. **Staging (Camada Bronze):** Ponto de entrada e padronização. Responsável por consumir os dados brutos (`sources`), renomear colunas para um padrão consistente, ajustar tipos de dados (casting) e realizar limpezas básicas.
2. **Intermediate (Camada Prata):** Camada onde são aplicadas regras de negócio, transformações complexas, cruzamentos (JOINs), criação de chaves compostas e agregações. Utiliza modelos efêmeros (`ephemeral`) que evita a materialização e economiza custos de armazenamento.
3. **Marts (Camada Ouro):** Camada final estruturada num modelo dimensional (*Star Schema*). Contém as tabelas Fato e Dimensão materializadas e prontas para consumo em ferramentas de BI.
## Automação (CI/CD)
Para garantir que a documentação esteja sempre sincronizada com o código fonte, foi implementada uma esteira de **Integração e Entrega Contínuas (CI/CD)** utilizando GitHub Actions. 

A cada novo *push* na branch principal, o *workflow* automaticamente:
* Autentica com o Google Cloud (GCP).
* Executa o comando `dbt docs generate` lendo os metadados do BigQuery.
* Publica a documentação atualizada diretamente no GitHub Pages.


* [LinkedIn](https://www.linkedin.com/in/hallyson-marques-447744140/)
* [Portfólio/GitHub](https://github.com/hallyfred)
