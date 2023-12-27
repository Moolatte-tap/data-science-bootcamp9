#load library
library(tidyverse)
library(glue)
library(lubridate)

# glue message
my_name <- "tap"
my_age <- 35

glue("Hi my name is {my_name}, Todat I'm {my_age} year old.")

# library tidyverse
# data transformation => dplyr
# 1. select
# 2. filter
# 3. arrange
# 4. mutate > create new column
# 5. summarize + group by

mtcars <- 
rownames_to_column(mtcars,"model")

view(mtcars)

# pipline
select(mtcars,mpg,hp,wt)

m2 <- mtcars %>% 
  select(mpg,hp,wt) %>%
  filter(hp>200) %>%
  arrange(mpg)

# filter
mtcars %>% 
  select(model,mpg,hp,wt,am) %>%
  filter(grepl("^M",model) & hp >150) %>%
  arrange(mpg)

m3 <-mtcars %>% 
  select(model,mpg,hp,wt,am) %>%
  filter(between(hp, 100,200)) %>%
  arrange(am, desc(hp))

write_csv(m3,"result.csv")

# mutate to create new column
mtcars %>%
  filter(mpg>=20) %>%
  select(model, mpg, hp ,wt, am) %>%
  mutate(model_upper=toupper(model),mpg_double=mpg*2,am = if_else(am==0,"auto","manual"))


# summarize
mtcars %>%
  mutate(am=if_else(am==0,"auto","manual")) %>%
  group_by(am) %>%
  summarise(avg_mpg=mean(mpg),
            sum_mpg=sum(mpg),
            min_mpg=min(mpg),
            max_hp=max(hp),
            n=n()            )
m4
write_csv(m4,"datayouask.csv")

# random sampling
mtcars %>%
  sample_n(2) %>%
  select(model)

mtcars %>%
  sample_frac(0.25) %>%
  summarise(avg_hp=mean(hp))

## count
mtcars <- mtcars %>%
  mutate(am=if_else(am==0,"auto","manual"))

mtcars %>%
  count(am,cyl) %>%
  mutate(pct=n/sum(n))

library(nycflights13)
view(flights)
data("flights")
data("airlines")

## Q1. most flight carrier in Sep 2013
 flights %>%
   filter(month==9,year==2013) %>%
   count(carrier) %>%
   arrange(desc(n)) %>%
   head(5)
 
# install.package(sqldf)
 library(sqldf)
 sqldf("select * from mtcars")

 library(RSQLite)
 conn <- dbConnect(SQLite(),"chinook.db")

 # list table
 dbListTables(conn)

 # list fields/column
 dbListFields(conn,"customers")

 # get data from
 m1 <- dbGetQuery(conn,"select firstname,email from customers
            where country='USA'")

# create dataframe
 products <- tribble(
   ~id,~product_name,
   1,"chocolate",
   2,"pineapple",
   3,"samsung galaxy S23")
 
 tribble(mtcars)
 
 # write table to database
 dbWriteTable(conn,"products",products)
 
 # remove table
 dbRemoveTable(conn,"products")
 
 # close connection
 dbDisconnect(conn)
 
 ?flights
 ?airlines
 