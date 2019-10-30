#Declaração de variáveis

miX = 100
miY = 49
sigmaX = 10
sigmaY = 8
nX = 100
nY = 80
numero_de_amostras = 1500

#Construindo xbar e ybar

xBar <- c()
yBar <- c()

for(i in 1:numero_de_amostras)
{
  x <- rnorm(nX, mean=miX, sd=sigmaX)
  xBar <- c(xBar,mean(x))
  y <- rnorm(nY, mean=miY, sd=sigmaY )
  yBar <- c(yBar,mean(y))
}

meanXbarYbar = mean(xBar - yBar)
varXbarYbar = var(xBar-yBar)


#função

empirical_probability <- function(x,start,end)
{
  sum(end>=x & x>=start)/length(x)
}