library('rpart')
library('caret')
source('metrics.R')

regressao <- function() {
  dados <- read.table('slump_test.csv', header = TRUE, sep = ",")
  
  # Escolhe valores do dataframe aleatoriamente (sendo 75% para treinamento e 25% para teste)
  sample <- createDataPartition(dados$Class, p = 0.75, list = FALSE)
  
  trainSample <- dados[sample,]
  testSample <- dados[-sample,]
  
  # Constrói a árvore de regressão para o conjunto de treinamento dado
  modelo <- rpart(formula = Class ~ No + Cement + Slag + Ash + Water + SP + Coarse + Fine + SLUMP + FLOW + Strength, 
                 data = trainSample, method = "anova", model = TRUE)

  
  # Realiza a predição no conjunto de testes e plota o modelo
  predicao <- predict(modelo, testSample, type = "vector")

  # Calcula o erro quadrático médio a partir do vetor de predição e do vetor de dados reais
  erro <- mse(testSample$Class, predicao)
  
  # Carrega os dados coletados em uma lista que será retornada
  resultado <- list()
  resultado$modelo <- modelo
  resultado$mse <- erroro
  
  return(resultado)
}

resultado <- regressao()
cat("Método de Regressão:\n")
cat("Erro Quadrado Médio: ",resultado$mse,"\n")
rpart.plot(resultado$modelo)