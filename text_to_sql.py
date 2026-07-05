import requests
import snowflake.connector

SCHEMA_CONTEXT = """
Table: MY_DB.ANALYTICS.MART_AMAZON_SALES
Columns:
  order_id (string), order_date (date), status (string), category (string),
  sku (string), qty (number), amount (float),
  ship_city (string), ship_state (string), ship_country (string)
"""

def get_sql(question):
    prompt = f"""{SCHEMA_CONTEXT}
Write a single Snowflake SQL SELECT query to answer this question: {question}
Rules:
- Return ONLY the SQL query, no explanation, no markdown formatting.
- Only use SELECT statements. Never use INSERT, UPDATE, DELETE, DROP, or ALTER.
"""
    resp = requests.post("http://localhost:11434/api/generate", json={
        "model": "llama3.1",
        "prompt": prompt,
        "stream": False
    })
    sql = resp.json()["response"].strip()
    return sql.replace("```sql", "").replace("```", "").strip()

def run_query(sql):
    forbidden = ["insert", "update", "delete", "drop", "alter", "create", "truncate"]
    if any(word in sql.lower() for word in forbidden):
        raise ValueError(f"Blocked unsafe query: {sql}")

    conn = snowflake.connector.connect(
        account="bfrehhq-nv24319",
        user="SushilDeore",
        private_key_file="/Users/sushildeore/rsa_key.p8",
        authenticator="SNOWFLAKE_JWT",
        role="ACCOUNTADMIN",
        warehouse="COMPUTE_WH",
        database="MY_DB",
        schema="ANALYTICS"
    )
    cur = conn.cursor()
    cur.execute(sql)
    results = cur.fetchall()
    columns = [desc[0] for desc in cur.description]
    conn.close()
    return columns, results

if __name__ == "__main__":
    question = input("Ask a question: ")
    sql = get_sql(question)
    print(f"\nGenerated SQL:\n{sql}\n")
    columns, results = run_query(sql)
    print(columns)
    for row in results:
        print(row)