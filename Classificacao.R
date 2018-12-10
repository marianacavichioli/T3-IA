library('caret')
library('rpart')
library('rpart.plot')

classificacao <- function() {
  dados <- read.table('mammographic.csv', header = TRUE, sep = ",")
  sample <- createDataPartition(dados$Severity, p = 0.75, list = FALSE)
  
  trainSample <- dados[sample,]
  testSample <- dados[-sample,]
  
  modelo <- rpart(formula = Severity ~ BI_RADS + Age + Shape + Margin + Density,
                 data = trainSample, method = "class", control = rpart.control(minsplit = 1), 
                 parms = list(split = "Information"), model = TRUE)
  
  predicao <- predict(modelo, testSample, type = "class")
  
  matriz <- table(predicted=predicao, truth=testSample$Severity)
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
rpart.plot(resultado$modelo)  
