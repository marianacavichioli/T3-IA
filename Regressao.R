library('caret')
library('rpart')
library('rpart.plot')

regressao <- function() {
  dados <- read.table('slumpTest.csv', header = TRUE, sep = ",")

  # escolhe os valores do conjunto de dados, sendo 75% para treinamento e 25% para teste
  sample <- createDataPartition(dados$Strength, p = 0.75, list = FALSE)

  treinamento <- dados[sample,]
  teste <- dados[-sample,]
  
  # constroi a arvore de regressao para o conjunto de treinamento dado
  modelo <- rpart(formula = Strength ~ No + Cement + Slag + Ash + Water + Sp + Coarse + Fine + Slump + Flow,
                 data = treinamento, method = "anova", model = TRUE)

  # faz a predicao no conjunto de testes 
  predicao <- predict(modelo, teste, type = "vector")

  # calcula o erro quadratico a partir da predicao e dos valores reais
  erro <- mean(teste$Strength - predicao)^2

  # carrega os dados na lista de resultado
  resultado <- list()
  resultado$modelo <- modelo
  resultado$eqm <- erro
  
  return(resultado)
}

# chama a funcao de regressao e imprime na tela os erros quadraticos e a arvore de regressao
resultado <- regressao()
cat("Método de Regressão:\n")
cat("Erro Quadrático Médio: ",resultado$eqm,"\n")
rpart.plot(resultado$modelo)