# acurácia = soma(true positive + true negative)/soma(todos)
acuracia <- function(matriz) {
  return(sum(diag(matriz))/sum(matriz))
}
  
# precisão = soma(true positive)/soma(true positive + false positive)
precisao <- function(matriz) {
  return(sum(matriz[2,2])/sum(matriz[2,]))
}

# erro quadrático medio = media(dados_reais - dados_preditos)**2
eqm <- function(real, predicao) {
  return(mean(real-predicao)^2)
} 