optimized_number_of_boats <- function(p1, p2, p_ship, n_ship){
  
  if(p2==0){
    return(n_ship)  
  }
  
  if(p1==0){
    return(0)
  }
  
  n = 0.5*( n_ship - log((p1/p2))/log(1-p_ship) )
  
  return(n)
}

Nrep <- c(1000)

n_ships <- c(10, 20, 40) #number of ships

p_ships <- c(0.05, 0.1, 0.2) #probability of of a ship finding a boat

p1s <- seq(0, 1, 0.1) #probability of the sinking boat being in island 1, me created intervals of 0.1 starting from 0 to 1


for(p1 in p1s){
  
  p2<-1 - p1 #probability of the sinking boat being in island 2.
  
  for(p_ship in p_ships){
    for(n_ship in n_ships){
      
      medium_resp <- c(n_ship)
      
      for(rep in Nrep){
        
        resp <- c(n_ship) #answer array
        
        for(n1 in 1:n_ship){ #we won't consider that the captain is sending zero boats to an island
          
          n2 <- n_ship - n1
          
          resp[n1] <- p1*(1 - (1-p_ship)^n1) + p2*(1 - (1-p_ship)^n2)
        }
        
        medium_resp <- medium_resp + resp
        
      }
      
      medium_resp <- medium_resp/n_ship
      
        plot(
          medium_resp, 
          type="b", 
          pch = "*",
          xlab="Número de navios na ilha 1", 
          ylab="Probabilida de encontrar o navio",
          main = "Resultados"
        )
        abline(
          v = optimized_number_of_boats(
            p1,
            p2, 
            p_ship, 
            n_ship), 
          col="red" , 
          lty="dashed") #add reference line
    }
  }
}