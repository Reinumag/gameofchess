#install.packages("rchess")
library(rchess)
library(plyr)


# plot(chss)
# 
# chss$put(type = 'n', color = 'b', square = 'a1')
# plot(chss)
# 
# chss$put(type = 'n', color = 'b', square = 'b3')
# plot(chss)
# 
# chss$put(type = 'n', color = 'b', square = 'c5')
# plot(chss)
# 
# chss$put(type = 'n', color = 'b', square = 'd7')
# plot(chss)

row <- c(2, 2, 1,-1,-2,-2,-1,1)
col <- c(-1, 1, 2, 2,1,-1,-2,-2)
moves <- cbind.data.frame(row,col)

board <- 1:8

square <- function(row, col){
  out <- NULL
  letters <- c('a','b','c','d','e','f','g','h')
  if ((row %in% (1:8)) && (col %in% (1:8))) {
    out <- paste(letters[col],row, sep = "")
  } 
  out
}

next.squares <- function(row, col, moves){
  next.moves <- moves
  next.moves$row    <- row + moves$row
  next.moves$col    <- col + moves$col 
  #next.moves
  true.rows <- (next.moves$row %in% board) & (next.moves$col %in% board)
  next.moves <- next.moves[true.rows,]
  next.moves
}

readkey <- function()
{
  cat ("Press [enter] to continue")
  line <- readline()
}

empty.cells <- function(chss, board){
  empty <- FALSE
  for(row in board){
    for (col in board) {
      if(is.null(chss$get(square(row, col)))){
        empty <- TRUE
        return(empty)
      }
    }
  }
  return(empty)
}

try.move <- function(row, col, chss, board = 1:8, move.count = 0, trace = ""){
  move.count <- move.count + 1
  move       <- square(row,col)
  trace[move.count] <- move
  readkey()
  print(trace)
  print(length(trace))
  print(move.count)
  print(move)
  if (empty.cells(chss,board) == FALSE) {
  #if (move.count == 64) {
    return(trace)
  } else {
    chss$put(type = 'n', color = 'b', square = square(row, col))
    print(chss$ascii())
    next.moves <- next.squares(row, col, moves)
    next.moves$available <- 0
    for (i in 1:nrow(next.moves)){
      if (is.null(chss$get(square(next.moves[i,]$row, next.moves[i,]$col)))){
        next.moves[i,]$available <- 1
      }
    }
    next.moves <- next.moves[which(next.moves$available == 1),]
    if (nrow(next.moves) == 0) {
      move.count <- move.count + 1
      trace[move.count] <- "No Moves Left"
      return(trace)
    }
    i <- 1
    while (i <= nrow(next.moves)){
      chss
      try.move(next.moves[i,]$row,next.moves[i,]$col, chss, board, move.count, trace)
      i <- i +1
    }
  }
}


chss <- Chess$new()
chss$clear()
final.trace <- try.move(1,1,chss)
plot(chss)
print(final.trace)
