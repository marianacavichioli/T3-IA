library('rpart')
library('rpart.plot') 
source('Metricas.R')

classificacao <- function(){
	# Leitura de dados de um arquivo com linha de cabeçalho e separador ','
	dados <- read.table('Autism-Child-Data.csv', header = TRUE, sep = ',')

	sample <- createDataPartition(dados$Class, p = 0.75, list = FALSE)
  	trainSample <- dados[sample,]
  	testSample <- dados[-sample,]

  	modelo <- rpart(Class ~ A1_Score + A2_Score + A3_Score + A4_Score + A5_Score + A6_Score + A7_Score + A8_Score + 
  		A9_Score + A10_Score + age_numeric + gender + ethnicity + jundice + austim + contry_of_res + used_app_before + 
  		result_numeric + age_desc + relation, 
  		data = trainSample, method = "class", control = rpart.control(minsplit = 1), params = list(split = "Information"), model = TRUE)

  	predicao <- predict(modelo, testSample, type = "class")

  	matriz <- table(predicted = predicao, truth = testSample$Class)
  	acuracia <- acuracia(matriz)
  	precisao <- precisao(matriz)

  	dados_coletados <- list()
	dados_coletados$modelo <- modelo
	dados_coletados$acuracia <- acuracia
	dados_coletados$precisao <- precisao

	return(dados_coletados)
}

classificacao <- classificacao()
cat("Método de Classificação:\n")
cat("Acurácia: ",classificacao$acuracia,"\n" )
cat("Precisão: ",classificacao$precisao,"\n\n")
rpart.plot(classificacao$modelo)
