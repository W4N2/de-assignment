# Data Pipeline using Snowflake and dbt

## Overview

This data pipeline ingests raw CSV files into Snowflake and runs a dbt ETL process to transform the data. 

The pipeline processes data from the `chat_raw` database to the `chat_int` database.

## Pipeline Components

1. **Data Lake**: Raw CSV files are landed into Snowflake (expected, not in scope)
2. **dbt ETL Process**: Data is transformed using dbt from the `chat_raw` database to the `chat_int` database.
3. **Unit Testing**: Unit tests are run on each of the DBT tables/views.

## Setup 

### Snowflake 
An account is required to access the db in Snowflake. To run locally against your own warehouse you will need to run the following: 
- 1. Run the contents of `setup_snowflake.sql` in an empty SQL worksheet
- 2. Validate dbt_sa_role has required privileges against the warehouse and databases 

### dbt 
Once this repository is closed, dbt and the snowflake connector can be installed by running:
`pip install requirements.txt`

Update the following values in `chat_dbt/profiles.yml`:

- account: `snowflake account name. i.e. abcde-12234`
- password: `snowflake user password`
- user: `snowflake username`
