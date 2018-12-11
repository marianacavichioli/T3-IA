library('caret')
library('rpart')
library('rpart.plot')

regressao <- function() {
  dados <- read.table('slumpTest.csv', header = TRUE, sep = ",")

  sample <- createDataPartition(dados$Strength, p = 0.75, list = FALSE)
  treinamento <- dados[sample,]
  teste <- dados[-sample,]
  
  modelo <- rpart(formula = Strength ~ No + Cement + Slag + Ash + Water + Sp + Coarse + Fine + Slump + Flow,
                 data = treinamento, method = "anova", model = TRUE)

  
  predicao <- predict(modelo, teste, type = "vector")

  erro <- mean(teste$Strength - predicao)^2

  resultado <- list()
  resultado$modelo <- modelo
  resultado$eqm <- erro
  
  return(resultado)
}

resultado <- regressao()
cat("Método de Regressão:\n")
cat("Erro Quadrado Médio: ",resultado$eqm,"\n")
rpart.plot(resultado$modelo)