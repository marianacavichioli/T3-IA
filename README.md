# T3-IA
Terceiro trabalho da disciplina de Inteligência Artificial

# Grupo
* Mariana Cavichioli Silva - 726568
* Rafael Bastos Saito - 726580

# Objetivo
Este  trabalho consta  da  execução  dos algoritmos  de aprendizado  supervisionado (árvore  de  decisão  e árvore de regressão) estudados na disciplina, com o uso de funções disponíveis em pacotes de R.

# Datasets utilizados
* Classificação: <a href="http://archive.ics.uci.edu/ml/datasets/Autistic+Spectrum+Disorder+Screening+Data+for+Children++">Autistic Spectrum Disorder Screening Data for Children </a>
* Regressão: 

# Bibliotecas
Para rodar este projeto é necessário instalar os pacotes:
* rpart
* rpart.plot

Para instalá-los basta rodar o comando install.packages(“nome do pacote”).

# Métricas
Também era necessário calcular as métricas  de  acurácia, precisão e erro quadrático médio do  modelo gerado usando os  resultados  obtidos com  os dados  de  teste. Para isso, foram usadas as respectivas fórmulas de acurácia e precisão para a árvore de classificação e a do erro quadrático médio para a árvore de regressão.
* Acurácia: soma(true positive + true negative)/soma(todos)
* Precisão: soma(true positive)/soma(true positive + false positive)
* Erro quadrático médio: media(dados_reais - dados_preditos)**2
