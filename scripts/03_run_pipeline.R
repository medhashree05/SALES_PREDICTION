###############################################################
# MAIN PIPELINE SCRIPT
# SALES FORECASTING USING STL + ETS
# Description:
# This script executes the complete workflow:
# 1. Load functions
# 2. Load data
# 3. Run forecasting model
# 4. Generate output
# 5. Create analysis tables
###############################################################


###############################################################
# STEP 1: LOAD MODEL FUNCTIONS
###############################################################

# Load STL + ETS model functions
source('scripts/01_model_stl_ets.R')


###############################################################
# STEP 2: LOAD DATA
###############################################################

# Load training dataset
train <- getdata("data/data_files/product_distribution_training_set.txt")

# Load product IDs
key_id <- get_key_id("data/data_files/key_production_IDs.txt")


###############################################################
# STEP 3: INITIALIZE RESULT MATRIX
###############################################################

# Matrix to store forecast results
# 28 days forecast × 101 products
result <- matrix(NA, nrow = 28, ncol = 101)


###############################################################
# STEP 4: UTILITY FUNCTION
###############################################################

# Function to simulate delay (not essential for pipeline)
testit <- function(x)
{
  p1 <- proc.time()
  Sys.sleep(x)
  proc.time() - p1
}


###############################################################
# STEP 5: RUN FORECASTING MODEL
###############################################################

# Apply forecasting for each product (currently first 10 for testing)
for(i in c(1:10)){
  result[, i] <- forecast.stl(train[, i])
}


###############################################################
# STEP 6: GENERATE FINAL OUTPUT
###############################################################

# Create final output matrix with product IDs
output <- get_final(result, key_id, nrow = 101, ncol = 29)

# Save predictions to file
write.table(output,
            "results/tables/output.txt",
            row.names = FALSE,
            col.names = FALSE)


###############################################################
# STEP 7: GENERATE ANALYSIS TABLES
###############################################################

###############################
# 7.1 Missing Values Summary
###############################

missing_counts <- apply(train, 2, function(x) sum(is.na(x)))

missing_df <- data.frame(
  Product_ID = 1:length(missing_counts),
  Missing_Count = missing_counts
)

write.csv(missing_df,
          "results/tables/missing_values_summary.csv",
          row.names = FALSE)


###############################
# 7.2 Statistical Summary
###############################

stats_df <- data.frame(
  Metric = c("Mean", "Median", "Max", "Min"),
  Value = c(mean(train, na.rm = TRUE),
            median(train, na.rm = TRUE),
            max(train, na.rm = TRUE),
            min(train, na.rm = TRUE))
)

write.csv(stats_df,
          "results/tables/statistical_summary.csv",
          row.names = FALSE)


###############################
# 7.3 Sample Predictions
###############################

# Extract first 5 products for display
sample_output <- output[1:5, ]

write.csv(sample_output,
          "results/tables/sample_predictions.csv",
          row.names = FALSE)


###############################
# 7.4 Model Summary
###############################

model_summary <- data.frame(
  Metric = c("Model", "Forecast_Horizon", "Seasonality", "Transformation"),
  Value = c("STL + ETS", "28 days", "Weekly", "Log Transformation")
)

write.csv(model_summary,
          "results/tables/model_summary.csv",
          row.names = FALSE)