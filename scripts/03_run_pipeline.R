source('data_trend_pred.R')

train <- getdata("product_distribution_training_set.txt")

key_id <- get_key_id("key_production_IDs.txt")

result <- matrix(NA, nrow=28, ncol=101)

# FIX: moved testit() definition before it is called in the loop below
testit <- function(x)
{
  p1 <- proc.time()
  Sys.sleep(x)
  proc.time() - p1 # The cpu usage should be negligible
}

# FIX: removed stray duplicate/commented-out outer for-loop header
for(i in c(1:10)){
  result[,i] <- forecast.stl(train[,i])
  
}

output <- get_final(result, key_id, nrow=101, ncol=29)
write.table(output, "output.txt", row.names=FALSE, col.names=FALSE)