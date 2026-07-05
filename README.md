# Talk2SQL

"Local LLM (Llama 3.1 + Ollama) text-to-SQL tool for Snowflake — no cloud API required."

Ask questions in plain English, get answers from Snowflake — using a local LLM (Llama 3.1 via Ollama) to generate SQL instead of a cloud API.

## What it does
1. You type a question (e.g. "total sales by category")
2. Llama 3.1 (running locally via Ollama) converts it to a Snowflake SQL query
3. The query runs against Snowflake using the Python connector
4. Results print to the terminal

## Why local LLM instead of Cortex Analyst / OpenAI / Claude
No API costs, runs fully offline once set up, and it's a way to learn the full text-to-SQL pipeline (prompt engineering, query validation, execution) instead of relying on a managed service.

## Stack
- **Ollama + Llama 3.1** — local LLM for SQL generation
- **Snowflake** — data warehouse
- **Python** — orchestration (snowflake-connector-python, requests)

## Folder Structure
```
Talk2SQL/
├── sql/
│   ├── 01_create_warehouse.sql
│   ├── 02_create_database.sql
│   ├── 03_create_schemas.sql
│   ├── 04_create_raw_tables.sql
│   ├── 05_create_file_formats.sql
│   ├── 06_load_raw_data.sql
│   ├── 07_Data_load_confirmation.sql
│   └── 08_testing.sql
├── dbt_project/
│   └── rag_analytics/
│       ├── models/
│       └── dbt_project.yml
├── text_to_sql.py
├── Amazon Sale Report.csv
├── LICENSE
├── README.md
├── README_dbt.md
└── Project_structure.txt
```
## Known limitations
- Local 8B model is much weaker than GPT-4/Claude-class models — expect wrong or broken SQL sometimes
- No conversation memory — each question is independent
- Basic keyword-based safety check (blocks INSERT/UPDATE/DELETE/DROP), not a full SQL sanitizer — don't point this at a production database

## Setup
```bash
brew install ollama
ollama serve
ollama pull llama3.1

python3.11 -m venv venv
source venv/bin/activate
pip install requests snowflake-connector-python

python text_to_sql.py
```

Update the Snowflake connection details in `text_to_sql.py` (account, user, key path, warehouse, database) before running.

## Related project
Same Snowflake data, different approach: [Amazon-Sales-Snowflake-dbt](https://github.com/Sushil-Deore/Amazon-Sales-Snowflake-dbt) uses Snowflake Cortex Analyst (cloud, managed, more accurate). This repo uses a local LLM (Llama 3.1) instead — no API cost, weaker accuracy, more manual work. Pick based on your need.

## Example questions
- "Total sales by category"
- "How many orders were cancelled"
- "Top 5 states by order count"

## Demo - https://youtu.be/3LIF6mOy2mY

Built with assistance from Claude (Anthropic).
