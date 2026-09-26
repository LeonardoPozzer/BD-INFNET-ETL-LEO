# 📊 GlobalStream Retail | Analytics Engineering

Projeto desenvolvido para a disciplina de **Analytics Engineering, dbt e Visualização de Dados** do MBA em Engenharia de Dados.

O objetivo do projeto é construir um pipeline analítico utilizando **dbt e Google BigQuery**, transformando dados brutos de vendas da GlobalStream Retail em modelos estruturados e preparados para análise e visualização.

## 🛠️ Tecnologias

- Google BigQuery
- dbt
- SQL
- Jinja
- YAML
- Power BI
- Git / GitHub

## 🏗️ Arquitetura

O projeto utiliza uma arquitetura em camadas:

```text
Dados Brutos
    │
    ▼
┌─────────────────┐
│ BigQuery / RAW  │
└────────┬────────┘
         │ source()
         ▼
┌─────────────────┐
│ Silver / Staging│
│ Limpeza e       │
│ padronização    │
└────────┬────────┘
         │ ref()
         ▼
┌─────────────────┐
│   Gold / Marts  │
│ Dimensões + Fato│
└────────┬────────┘
         ▼
      Power BI
```

### Silver

A camada Silver realiza tratamentos como:

- Padronização de textos;
- Tratamento de valores nulos;
- Conversão de tipos;
- Renomeação de campos;
- Preparação dos dados para consumo analítico.

Uma macro Jinja foi criada para reutilizar regras de limpeza de campos textuais.

### Gold

A camada Gold implementa a modelagem analítica do projeto:

- `dim_cliente`
- `dim_produto`
- `dim_vendedor`
- `fato_vendas`

A `fato_vendas` possui granularidade de **um registro por item de pedido** e relaciona clientes, produtos e vendedores.

A dimensão de clientes também contém indicadores de **RFM (Recência, Frequência e Valor Monetário)** para segmentação dos consumidores.

## 🧪 Qualidade dos Dados

O projeto utiliza testes do dbt para validar a qualidade e integridade dos dados, incluindo:

- `not_null`
- `unique`
- `relationships`
- Testes genéricos personalizados

Os testes de relacionamento garantem a integridade referencial entre a tabela fato e suas dimensões.

## 🔗 Linhagem e Documentação

As dependências são definidas utilizando `source()` e `ref()`, permitindo ao dbt construir automaticamente o **DAG de linhagem dos dados**.

A documentação do projeto pode ser gerada com:

```bash
dbt docs generate
```

E os modelos e testes podem ser executados com:

```bash
dbt build
```

## 📁 Estrutura do Projeto

```text
models/
├── staging_silver/
│   ├── clientes.sql
│   ├── itens_pedido.sql
│   ├── pedidos.sql
│   ├── produtos.sql
│   ├── vendedores.sql
│   └── sources.yml
│
└── marts/
    ├── dim_cliente.sql
    ├── dim_produto.sql
    ├── dim_vendedor.sql
    ├── fato_vendas.sql
    └── schema.yml

macros/
└── limpar_texto.sql

tests/
└── generic/
    ├── not_null_all_columns.sql
    └── unique_all_columns.sql
```

## 📈 Visualização

Os modelos da camada Gold são utilizados como fonte para a construção de um **Dashboard Executivo no Power BI**, permitindo a análise dos principais indicadores de vendas e comportamento dos clientes.

## 🎓 Contexto Acadêmico

Projeto desenvolvido como parte do **MBA em Engenharia de Dados**, aplicando conceitos de:

- Analytics Engineering;
- Data Warehousing;
- Modelagem dimensional;
- ELT;
- Qualidade de dados;
- Governança;
- Data Lineage;
- Business Intelligence.

---

**Autor:** Leonardo Pozzer
