---
  Encoding: UTF-8
title: "Desafio1"
author: 
- name: "[[Igor-Galhano-1]] - Turma 22.[[1]]"
- name: "[[Matheus-Da Silva-Martins-1]] - Turma 22.[[1]]"
- name: "[[Reuben-Solomon-Katz-1]] - Turma 22.[[1]]"
date: '[2019-08-09]'
output:
  html_document:
  theme: sandstone
df_print: paged
number_sections: FALSE    
---
  
  {r}
knitr::opts_chunk$set(eval = TRUE, echo = TRUE)

Estimando o número $e$ via Simulação de Monte Carlo


## Enunciado do problema

----
  
  Sem dúvida, os dois números transcedentais mais importantes são $\pi$ e o [número de Euler,  e](https://en.wikipedia.org/wiki/E_(mathematical_constant)). Existem várias maneiras de calcular os valores de tais constantes, sendo as mais famosas baseadas em expansões em séries de Taylor:
  
$$
  \frac{\pi}{4} =  1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} - \ldots
$$
  
  $$
  e = \frac{1}{0!} + \frac{1}{1!} + \frac{1}{2!} + \frac{1}{3!} + \ldots 
$$
  
  Vimos em sala que é possível estimar o valor da constante $\pi$ através de um experimento aleatório (problema da Agulha de Buffon), implementado em uma simulação de Monte Carlo. 

Neste exercício, vamos aprender uma maneira estocástica de estimar o número $e$.

## Estratégia da solução 

----
  Os seguintes passos serão tomados para resolução do problema:
  
  1. Dividir o intervalo real [0,1] em `N` subintervalos de mesmo comprimento;

{r}
# Limpa área de trabalho
rm(list=ls())

n <- 1000


# Criando vetor com os números aleatórios
vector_numbers <- array(1:n)
for (i in 1:length(vector_numbers)) {
  
  vector_numbers[i] <- runif(1, min=0, max=1)
  
}

# Criando vetor com os 'n' intervalos inicialmente todos com zero

vector_gap <- array(1:n)

for (k in 1:length(vector_gap)) {
  
  vector_gap[k] <- 0
  
}

# Percorrendo o vetor dos numeros e verificando em qual intervalo se encaixa, ao encontrar soma-se 1 à essa posição no vetor de intervalos

for (w in 1:length(vector_gap)) {
  
  for(j in 1:length(vector_gap)){
    
    if(vector_numbers[w] <= j/n){
      if(vector_numbers[w] > (j-1)/n){
        vector_gap[j] <- vector_gap[j] +1
      }
    }
    
  }
}

z <- 0

# Calculando quantos intervalos vazios existem no vetor de intervalos

for (k in 1:length(vector_gap)) {
  if(vector_gap[k] == 0){
    z <- z +1
  }
}

Aproximação do valor de 'e'
{r} 
e <- n/z
e


### Experimento de Monte Carlo

{r} 

rm(list=ls())

n <- 1000
nrep <- 20
vector_results <- array(1:nrep)  

for (p in 1:nrep) {
  
  
  
  vector_numbers <- array(1:n)
  for (i in 1:length(vector_numbers)) {
    
    vector_numbers[i] <- runif(1, min=0, max=1)
    
  }
  
  vector_gap <- array(1:n)
  
  for (k in 1:length(vector_gap)) {
    
    vector_gap[k] <- 0
    
  }
  
  for (w in 1:length(vector_gap)) {
    
    for(j in 1:length(vector_gap)){
      
      if(vector_numbers[w] <= j/n){
        if(vector_numbers[w] > (j-1)/n){
          vector_gap[j] <- vector_gap[j] +1
        }
      }
      
    }
  }
  
  z <- 0
  
  for (k in 1:length(vector_gap)) {
    if(vector_gap[k] == 0){
      z <- z +1
    }
  }
  e <- n/z
  vector_results[p] <- e
  
}
plot(vector_results, 
     type="b", pch = "*",
     xlab="Realizacao", 
     ylab="Valor de 'e' estimado",
     main = "Sequencia dos Resultados dos Experimentos")
abline(h = exp(1), col=2 , lty="dashed")

hist(vector_results,xlab="Valor de 'e' estimado", freq = FALSE, col = "gray", #breaks= 10, 
     main = "Histograma")
abline(v = exp(1),
       col = "red", lty = "dashed", lwd = 2) # adiciona linha vermelha
# com valor real de 'e'

abline(v = c(quantile(vector_results, probs=c(0.025, 0.975))), 
       col = "blue", lty = "dashed") # 95% das estimativas de 'e' encontram-se entre os valores representados pelas linhas azuis


O que acontece com a distribuição dos valores estimados de e se aumentarmos o número de dardos lançados (micro-experimento), mantendo o número de replicações do (macro) experimento constante?