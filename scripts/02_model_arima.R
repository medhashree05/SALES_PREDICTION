###############################################################
# SALES FORECASTING USING ARIMA + FOURIER TERMS
# Description:
# This script performs:
# 1. Data loading
# 2. Time series transformation
# 3. ARIMA-based forecasting (with Fourier terms)
# 4. Product-level prediction generation
# 5. Output file creation
###############################################################

###############################
# REQUIRED LIBRARIES
###############################
# Libraries required for forecasting and data manipulation
library("forecast")
library("Matrix")
library(TTR)
library(dplyr)

# NOTE:
# library(tcltk) removed as it is not required for this implementation


###############################################################
# INPUT AND OUTPUT FILE CONFIGURATION
###############################################################

# Input file containing historical product sales data
# (Can be replaced with file picker if needed)
#### inputfile = tk_choose.files(caption = "Choose the input data file")
inputfile = "product_distribution_training_set.txt"

# Output file where predictions will be stored
product_predicted_data_output_file = "output-cgajare1-B00668719.txt"


###############################################################
# STEP 1: LOAD DATA
###############################################################

# Read dataset into R
sale_data = read.delim(inputfile, header = FALSE)

# Compute total daily sales (column-wise sum)
sale_data_matrix = data.matrix(colSums(sale_data[, c(2:119)]))

# Convert to time series format
sale_data_matrix_ts = ts(ts(sale_data_matrix[c(1:118),1]), frequency = 1)


###############################################################
# STEP 2: GLOBAL FORECAST (ALL PRODUCTS COMBINED)
###############################################################

# Generate Fourier terms for seasonality
data_xreg = fourier(ts(sale_data_matrix_ts, frequency = 365.25), K = 4, h = NULL)

# Fit ARIMA model with external regressors
auto_arima_data = auto.arima(sale_data_matrix_ts, xreg = data_xreg, seasonal = FALSE)

# Forecast next 28 days
forcast_arima_data_sum_products = forecast.Arima(auto_arima_data, xreg = data_xreg, h = 28)

# Extract forecasted mean values
forcast_mean = forcast_arima_data_sum_products$mean

# Replace negative predictions with zero
forcast_mean[forcast_mean < 0] = 0

# Prepare aggregated prediction row
forcated_mean_data = c(0, round(forcast_mean))

# Store in matrix format
dailysale_predict_matrix = matrix(forcated_mean_data, nrow = 1, ncol = 119)


###############################################################
# STEP 3: PREPARE PRODUCT-WISE DATA
###############################################################

# Convert dataset to matrix
product_matrix = data.matrix(sale_data, rownames.force = NA)

# Transpose matrix for easier product-wise processing
product_matrix = t(product_matrix)

# Initialize matrix to store predictions for all products
product_dailysale_predict_matrix = matrix(0, nrow = 100, ncol = 119)


###############################################################
# STEP 4: PRODUCT-WISE FORECASTING USING ARIMA
###############################################################

# Loop through each product (1 to 100)
i <- 1

while(i <= 100){
  
  # Display current product index
  cat("  ")
  cat(i)
  
  # Convert product data into time series
  sale_data_matrix_ts = ts(data.frame(product_matrix[c(2:119), i]), frequency = 1)
  
  # Generate Fourier terms for short-term seasonality
  data_xreg = fourier(ts(sale_data_matrix_ts, frequency = 365.25/4), K = 4, h = NULL)
  
  # Fit ARIMA model
  auto_arima_data = auto.arima(sale_data_matrix_ts, xreg = data_xreg, seasonal = FALSE)
  
  # Forecast next 28 days
  forcast_arima_data_rest = forecast.Arima(auto_arima_data, xreg = data_xreg, h = 28)
  
  # Generate Fourier terms for annual seasonality
  data_xreg_365 = fourier(ts(sale_data_matrix_ts, frequency = 365.25), K = 4, h = NULL)
  
  # Fit second ARIMA model
  auto_arima_data_365 = auto.arima(sale_data_matrix_ts, xreg = data_xreg_365, seasonal = FALSE)
  
  # Forecast using second model
  forcast_arima_data_rest_365 = forecast.Arima(auto_arima_data_365, xreg = data_xreg_365, h = 28)
  
  # Extract forecast values
  forcast_mean = forcast_arima_data_rest$mean
  
  
  ###########################################################
  # POST-PROCESSING OF PREDICTIONS
  ###########################################################
  
  # Replace negative values using alternative model predictions
  forcast_mean[forcast_mean < 0] = forcast_arima_data_rest_365$mean
  
  # Replace remaining negatives using upper confidence bound
  forcast_mean[forcast_mean < 0] = forcast_arima_data_rest_365$upper[,1]
  
  # Final fallback: replace negatives with zero
  forcast_mean[forcast_mean < 0] = 0
  
  
  ###########################################################
  # STORE PRODUCT PREDICTIONS
  ###########################################################
  
  # Combine product ID and predicted values into matrix
  product_dailysale_predict_matrix[i,] =
    matrix(c(product_matrix[1, i], as.numeric(round(forcast_mean))), 1, 119)
  
  # Move to next product
  i <- i + 1
}


###############################################################
# STEP 5: COMBINE FINAL RESULTS
###############################################################

# Combine aggregated and product-wise predictions
final_matrix = rbind(dailysale_predict_matrix, product_dailysale_predict_matrix)

# Extract only required 28-day predictions
product_predicted_output = final_matrix[, c(1:29)]


###############################################################
# STEP 6: SAVE OUTPUT FILE
###############################################################

# Remove existing output file (if present)
if(file.exists(product_predicted_data_output_file)){
  file.remove(product_predicted_data_output_file) 
}

# Write final output to file
write.table(product_predicted_output,
            file = product_predicted_data_output_file,
            quote = FALSE,
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE)


###############################################################
# UTILITY FUNCTION (OPTIONAL)
###############################################################

# Function to test execution delay (not used in main pipeline)
testit <- function(x)
{
  p1 <- proc.time()
  Sys.sleep(x)
  proc.time() - p1
}