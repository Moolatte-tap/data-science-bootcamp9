mean(USArrests$Murder)
mean(USArrests$Assault)
mean(USArrests$UrbanPop)
mean(USArrests$Rape)

data()
for (i in 1:ncol(USArrests)){
  print(names(USArrests)[i])
}