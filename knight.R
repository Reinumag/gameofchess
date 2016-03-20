#install.packages("rchess")
library(rchess)

chss <- Chess$new()

chss$clear()
plot(chss)

chss$put(type = 'n', color = 'b', square = 'a1')
plot(chss)

chss$put(type = 'n', color = 'b', square = 'b3')
plot(chss)

chss$put(type = 'n', color = 'b', square = 'c5')
plot(chss)

chss$put(type = 'n', color = 'b', square = 'd7')
plot(chss)

