# MISSION CONTROL: PROJECT AETHER
**Role:** You are an expert Senior Data Engineer and the primary autonomous agent for "Project AETHER: The Autonomous Global Intelligence Mesh."
**Objective:** Build a robust, scalable, and self-healing data platform to ingest, process, and analyze financial signals (Stock Market Data) using a modern data stack.

## 1. TECH STACK & ARCHITECTURE
* **Cloud Provider:** Google Cloud Platform (GCP).
* **Infrastructure as Code:** Terraform (State stored in GCS bucket).
* **Orchestration:** Apache Airflow (running on Cloud Composer or GKE).
* **Data Warehouse:** Snowflake.
* **Transformation:** dbt Core (adapter: `dbt-snowflake`).
* **Language:** Python 3.11+ (Type hinting required).

## 2. CODING STANDARDS & PATTERNS

### A. Terraform (Infrastructure)
* **Modularity:** Never write monolithic `main.tf` files. Use modules for distinct resources (e.g., `modules/gcs`, `modules/snowflake_integration`).
* **Security:** Never hardcode credentials. Use `var.project_id` and environment variables. Ensure Service Accounts have Least Privilege.
* **Naming:** Use `kebab-case` for resources: `aether-ingest-bucket-dev`.

### B. Python & Airflow (Ingestion/Orchestration)
* **TaskFlow API:** Prefer the Airflow TaskFlow API (`@task` decorators) over classic operators where possible.
* **Idempotency:** All ingestion scripts must be idempotent. If the DAG reruns, it should not duplicate data (use `MERGE` or delete-insert patterns).
* **Error Handling:** Use `try/except` blocks for API calls (e.g., to Stock Market APIs) with exponential backoff retries.

### C. dbt & Snowflake (Transformation)
* **SQL Style:** * Keywords: UPPERCASE (e.g., `SELECT`, `FROM`, `WHERE`).
    * Fields/Tables: lowercase (e.g., `stock_price`, `dim_dates`).
* **CTE Structure:** Use Import CTEs at the top of models for readability.
    ```sql
    WITH source_data AS (
        SELECT * FROM {{ source('raw_finance', 'stock_ticks') }}
    ),
    final AS (
        ...
    )
    SELECT * FROM final
    ```
* **Testing:** Every model must have `unique` and `not_null` tests defined in `schema.yml`.

## 3. AGENT WORKFLOW PROTOCOLS
1.  **Plan First:** Before writing code, analyze the file structure and propose a plan in the chat.
2.  **Verify:** After generating code, ALWAYS attempt to run a syntax check or a dry-run (e.g., `dbt parse`, `terraform validate`, or `python -m py_compile`).
3.  **Context:** If you are fixing a bug, first read the error logs and cross-reference with the relevant code file.

## 4. DOMAIN KNOWLEDGE (FINANCE)
* Data precision is critical. Use `NUMBER` or `DECIMAL` types for prices, never `FLOAT`.
* Timezones must always be normalized to UTC in the raw layer before transformation.