#Gerando as mil amostras de tamanho 31

y <- c()

for(i in 1:1000)
{
  x <- rnorm(31, mean=15, sd=5)
  y <- c(y,x)  
}


# Método dos momentos é uma maneira de estimar os parâmetros de uma população
# Por meio de n equações, estima-se n parâmetros por meio das esperanças das potências

##Perceba que, para esse problema, a média é a média aritimétrica da amostra e as variâncias são as
##variâncias das amostras:

means_mom <- c()
vars_mom <- c()

for(i in 1:1000)
{
  begining <- 1 + 31*(i-1)
  end <- 31 + 31*(i-1)
  means_mom <-c(means_mom,median(y[begining:end]))
  vars_mom <- c(vars_mom, var(y[begining:end]))
}

density_vars_mom <- density(vars_mom)

density_means_mom <- density(means_mom)

plot(
  density_vars_mom,
  type="l",
  main = "Plot Variances",
  sub="Método de Momentos",
  ) + abline(
    v=25,
    col="red"
  )


plot(
  density_means_mom,
  type="l",
  main = "Plot Means",
  sub="Método de Momentos",
) + abline(
  v=15,
  col="red"
  )

# Método da máxima verossimilhança
## Maximizar L(theta) como função de theta. Perceba que, neste caso, essa resposta coincide com
## o método dos momentos, portnanto, não gerando a necessidade de uma nova conta.
