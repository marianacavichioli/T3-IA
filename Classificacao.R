library('caret')
library('rpart')
library('rpart.plot')

classificacao <- function() {
  #Leitura do conjuto de dados em um arquivos csv
  dados <- read.table('mammographic.csv', header = TRUE, sep = ",")

  #Divide os dados aleatoriamente em treinamento (75%) e teste (25%)
  sample <- createDataPartition(dados$Severity, p = 0.75, list = FALSE)
  treinamento <- dados[sample,]
  teste <- dados[-sample,]
  
  #Constroi o modelo da árvore de decisão a partir da base de dados 
  modelo <- rpart(formula = Severity ~ BI_RADS + Age + Shape + Margin + Density,
                 data = treinamento, method = "class", control = rpart.control(minsplit = 1), 
                 parms = list(split = "Information"), model = TRUE)
  
  #Realiza a predição da árvore gerada no conjunto de testes separados anteriomente através da função predict()
  predicao <- predict(modelo, teste, type = "class")
  
  #Monta a matriz de confusão a partir dos dados da predição e dos dados de teste
  matriz <- table(predicted=predicao, truth=teste$Severity)
  
  #Realiza os cálculos de acurácia e precisão 
  acuracia <- sum(diag(matriz))/sum(matriz) 
  precisao <- sum(matriz[2,2])/sum(matriz[2,])
  
  resultado <- list()
  resultado$modelo <- modelo
  resultado$acuracia <- acuracia
  resultado$precisao <- precisao
  
  return(resultado)
}

resultado <- classificacao()
cat("Método de Classificação:\n")
cat("Acurácia: ",resultado$acuracia,"\n" )
cat("Precisão: ",resultado$precisao,"\n\n")

#Plota a árvore de decisão final encontrada
rpart.plot(resultado$modelo)  
