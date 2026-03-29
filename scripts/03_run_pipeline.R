source('scripts/01_model_stl_ets.R')

train <- getdata("data/data_files/product_distribution_training_set.txt")

key_id <- get_key_id("data/data_files/key_production_IDs.txt")

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
write.table(output, "results/tables/output.txt", row.names=FALSE, col.names=FALSE)

missing_counts <- apply(train, 2, function(x) sum(is.na(x)))

missing_df <- data.frame(
  Product_ID = 1:length(missing_counts),
  Missing_Count = missing_counts
)

write.csv(missing_df, "results/tables/missing_values_summary.csv", row.names=FALSE)

stats_df <- data.frame(
  Metric = c("Mean", "Median", "Max", "Min"),
  Value = c(mean(train, na.rm=TRUE),
            median(train, na.rm=TRUE),
            max(train, na.rm=TRUE),
            min(train, na.rm=TRUE))
)

write.csv(stats_df, "results/tables/statistical_summary.csv", row.names=FALSE)

sample_output <- output[1:5, ]   # first 5 products

write.csv(sample_output, "results/tables/sample_predictions.csv", row.names=FALSE)

model_summary <- data.frame(
  Metric = c("Model", "Forecast_Horizon", "Seasonality", "Transformation"),
  Value = c("STL + ETS", "28 days", "Weekly", "Log Transformation")
)

write.csv(model_summary, "results/tables/model_summary.csv", row.names=FALSE)



