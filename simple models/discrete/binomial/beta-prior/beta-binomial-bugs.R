library(R2OpenBUGS)
library(here)

model <- function() {
  y ~ dbin(theta,10)
  theta ~ dbeta(1,1)
}

data <- list(y = 2)
inits <- list((list(theta = 1)))
parameters <- c("theta")

model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)

# WINE="/Users/evan_miyakawa1/Cellar/wine/4.0.1/bin/wine"
# WINEPATH="/Users/evan_miyakawa1/Cellar/wine/4.0.1/bin/winepath"
# OpenBUGS.pgm="/Users/evan_miyakawa1/OpenBugs/OpenBUGS323/OpenBUGS.exe"
WINE="/usr/local/Cellar/wine/4.0.1/bin/wine"
WINEPATH="/usr/local/Cellar/wine/4.0.1/bin/winepath"
OpenBUGS.pgm="/Users/evanmiyakawa/OpenBugs/OpenBUGS323/OpenBUGS.exe" #~

b_model <- bugs(data, inits, parameters, model.file, n.chains = 1,
                n.iter = 10000, n.burnin = 1000, OpenBUGS.pgm=OpenBUGS.pgm, 
                WINE=WINE, WINEPATH=WINEPATH,useWINE=T)
b_model$summary