library(tidyverse)
library(ggthemes)

## how to choose visualization
## 1. number of variables
## 2. data type

ggplot(data=mtcars,
       mapping = aes(x=mpg))+
  geom_histogram(bins=8)

# one variable + continuous (number)
ggplot(diamonds, aes(x=price)) + 
  geom_histogram()

ggplot(diamonds, aes(x=price)) + 
  geom_density()

#DRY: Donot Report Yourself
base <- ggplot(diamonds, aes(x=price))
p1 <- base + geom_histogram()
p2 <- base + geom_density()
       
ggplot(diamonds, aes(x=price))+ geom_boxplot()

# one variable + discrete (factor)
ggplot(diamonds, aes(cut))+geom_bar()
## ใช้กับ Raw Data

diamonds %>%
   count(cut) %>%
   ggplot(data=.,mapping=aes(x=cut,y=n))+geom_col()
## ใช้กับ aggregate Data

## two variables: number x number
## scatter plot
set.seed(42) ##lock result
ggplot(sample_n(diamonds,3000),
       # mapping
       mapping=aes(x=carat, y=price,
                   color=cut))+
  # setting
  geom_point(alpha=0.4,size=2)+
  labs(
    title="My first scatter plot",
    subtitle="Cool ggplot2",
    caption="Data: diamonds in Africa",
    x="Price in USD",
    y="Carat Diamonds"
  ) +
  theme_minimal()


## shortcut qplot()
## quick plot

qplot(x=carat,data=diamonds,geom="density")


## layes in ggplot2
base <- ggplot(diamonds %>% sample_n(1000) %>%
                 filter(carat<=2.8),
               aes(x=carat,y =price))

p3 <- base + 
  theme_minimal()+
  geom_point(alpha=0.2,color="#62f060")+
  geom_smooth(method="loess",se=TRUE,
              fill="gold",
              color="red")+
 geom_rug()

## bar plot
ggplot(diamonds,aes(cut,fill=clarity))+
  geom_bar(position="fill")+ 
  ## position = fill, dodge,
  theme_minimal()


## How to change color?
ggplot(diamonds,aes(cut, fill=cut))+
  geom_bar()+
  theme_minimal()+
  scale_fill_brewer(palette = "Accent")
## https://ggplot2-book.org/scales-colour

## heat map colour scale
ggplot(diamonds %>% 
         sample_frac(0.1), aes(carat,price,colour=price))+
  geom_point(alpha=0.3)+
  theme_minimal() +
  scale_color_gradient(low="gold",high="purple")

## mulitple sub-plots
ggplot(diamonds,aes(carat,price))+
  geom_point(alpha=0.2)+
  geom_smooth()+
  theme_minimal()+
  facet_wrap(~cut,ncol=3)

## mutiple dataframes
m1 <- mtcars %>% filter(mpg > 30)
m2 <- mtcars %>% filter(mpg <= 20)

ggplot()+
  theme_minimal()+
  geom_point(data=m1, aes(wt,mpg),color="blue")+
  geom_point(data=m2, aes(wt,mpg),color="red")

## bin2D
ggplot(diamonds,aes(carat,price))+
  geom_bin2d(bins=200)


## Homework
## 1. create Rmarkdown
## 2. create 5 Charts
## data = mpg

view(mpg)

library(patchwork)
p1 <- qplot(hwy, data=mpg, geom="density")
p2 <- qplot(cty, data=mpg, geom="histogram")
p3 <- qplot(cty, hwy, data=mpg, geom="point")
p4 <- qplot(cty, hwy, data=mpg, geom="smooth")

(p1+p2+p3)/p4

mpg %>%
  group_by(class) %>%
  summarise(avg_hwy=mean(hwy)) %>%
  ggplot(aes(x=reorder(class,avg_hwy),y=avg_hwy))+
  geom_col()+
  labs(title="Average Highway MPG by Car Type",
       x="Car Type",
       y="Average Highway")
theme_minimal()


