## Scrip para filtrar tabela CSV (saída da análise DGE)
## 2023-07-12
## Giudicelli GC

## Definir diretório em que estamos trabalhando
setwd("C:/Users/ggiudicelli/Desktop/DGE_Filter_CSV")

## Criar objeto GSE para ler a tabela CSV
GSE <- read.csv("GSE159642_D_SVA.csv", sep = ",", header = TRUE)
View(GSE) ## 28,390 linhas

## Vamos usar o pacote "dplyr"
## Instalação do pacote (necessário apenas uma vez)
install.packages("dplyr")
## Abrir a biblioteca do pacote
library(dplyr)

## Filtrar os NA da coluna SYMBOL
filter(GSE, SYMBOL!=NA)

## Filtrar por FDR maior/igual a 0.05
## Caso os FDR sejam todos = 1 pode ser filtrado por PValue (maior/igual a 0.05)


## Filtrar por logFC maior/igual a 2 e menor/igual a -2


## Filtrar por logFC maior/igual a 1.5 e menor/igual a -1.5


## Filtrar por logFC maior/igual a 1 e menor/igual a -1


## Salvar os resultados dos logFC em planilhas CSV