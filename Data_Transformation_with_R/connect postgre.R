# connect to PostgreSQL server
library(RPostgreSQL)
library(tidyverse)

# create connection
conn <- dbConnect(PostgreSQL(),
host = "floppy.db.elephantsql.com",
dbname ="ezxnohan",
user = "ezxnohan",
password ="ep6r-vVqDif5g7MG_8KZcunfj5BCMQNK",
port = 5432
)

# db list tables
dbListTables(conn)

dbWriteTable(conn, "products",products)

# get data
df <- dbGetQuery(conn, "select * from products")
df

## HW02- restaurant pizza SQL
## create 3-5 dataframes => write table into server