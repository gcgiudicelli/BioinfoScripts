## Script para obter correspondência entre genes ortólogos (H. sapiens and M. musculus)
## Input: arquivo com genes de M. musculus; output: arquivo com genes de H. sapiens
## Por Kowalski TW (thaynewk) e Giudicelli GC (gcgiudicelli)

## Informar em qual diretório (pasta) você está trabalhando
setwd("~/NomeDaPasta/NomeDaPasta")

## Instalar os pacotes necessários para a análise
## Você só precisa instalar uma única vez
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("biomaRt")

## Carregar os pacotes necessários para a análise
## Você precisa carregar os pacotes sempre que for rodar essa análise
library(biomaRt)

## Neste script usaremos um arquivo input contendo genes de M. musculus para sabermos os genes ortólogos de H. sapiens.
## Portanto, vamos carregar o dataset de M. musculus (mmusculus_gene_ensembl). 
## Caso tivéssemos como input um arquivo com genes de H. sapiens nós usaríamos o dataset hsapiens_gene_ensembl.
ensembl <- useEnsembl(biomart = "genes", dataset = "mmusculus_gene_ensembl")
ensembl <- useDataset(dataset = "mmusculus_gene_ensembl", mart = ensembl)

## Listar os 'attributes' (variáveis que você quer obter) e os 'filters' (variáveis que você já possui).
attributes <- listAttributes(ensembl)
filters <- listFilters(ensembl)

## Visualizar todos os 'attributes' e 'filters' disponíveis:
View(attributes)
View(filters)

## Carregar o seu arquivo input - neste caso, um arquivo .txt contendo os genes de M. musculus os quais quero saber os ortólogos de H. sapiens
genes <- read.table("GenesMmusculusNomeArquivo.txt", header = FALSE)

## Visualizar se o arquivo foi corretamente carregado
View(genes)

## Vamos rodar a análise para obter os ortólogos! 
## Como queremos os ortólogos de H. sapiens vamos usar hsapiens_homolog_associated_gene_name como 'attribute' e external_gene_name como 'filter'.
## Caso tivéssemos como input um arquivo com genes de H. sapiens e quiséssemos os ortólogos de M. musculus nós usaríamos mmusculus_homolog_associated_gene_name
## como 'attribute' e hgnc_symbol como 'filter'.
## Atenção ao escolher os 'attributes': eles devem estar todos na mesma 'page', conferir a coluna 3 (page) ao listar os 'attributes'.
orthologous <- getBM(attributes = c("hsapiens_homolog_associated_gene_name",
                                    "external_gene_name"), 
                     filters = c("external_gene_name"), 
                     values = genes$V1, 
                     mart = ensembl)
                     
## Visualizar se o objeto 'orthologous' foi corretamente gerado
View(orthologous)

## Se algum gene estiver faltando, você pode conferir o GeneCards para saber se o nome do gene está correto. P. ex.: CTRP15 é ERFE, IL8 é CXCL8.
## Se necessário, corrija o nome do gene e refaça a análise.

## Salvar o resultado do objeto 'orthologous' em um arquivo .txt
write.table(orthologous, "ResultadoOrtologosMmHs.txt")
