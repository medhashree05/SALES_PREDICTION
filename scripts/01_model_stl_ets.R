###############################################################
# SALES TIME SERIES FORECASTING USING STL + ETS
# Description:
# This script contains functions for:
# 1. Data loading and preprocessing
# 2. Forecasting using STL + ETS
# 3. Generating final output matrix
###############################################################

###############################
# REQUIRED LIBRARIES
###############################
require(forecast)


###############################################################
# FUNCTION 1: DATA LOADING AND PREPROCESSING
###############################################################
getdata <- function(x){
  
  # Read dataset and convert to matrix
  data <- as.matrix(read.table(x, header = FALSE))
  
  # Transpose the data for easier column-wise processing
  trans <- t(data)
  
  # Initialize training matrix
  # Rows = time steps, Columns = products + total sales column
  train <- matrix(data = NA, nrow = nrow(trans) - 1, ncol = ncol(trans) + 1)
  
  # Compute total sales per day (first column)
  for(i in c(1:nrow(trans)-1)){
    train[,1][i] <- sum(data[, i + 1])
  }
  
  # Copy individual product sales into matrix
  for(i in c(1:ncol(trans))){
    train[, i + 1] <- trans[, i][2:nrow(trans)]
  }
  
  return(train)
}


###############################################################
# FUNCTION 2: LOAD PRODUCT IDS
###############################################################
get_key_id <- function(x){
  
  # Read product ID file
  data <- as.matrix(read.table(x, header = FALSE))
  
  return(data)
}


###############################################################
# FUNCTION 3: FORECASTING USING STL + ETS
###############################################################
forecast.stl <- function(x, n.ahead = 28) {
  
  ###########################################################
  # STEP 1: INITIAL TIME SERIES CREATION
  ###########################################################
  
  # Convert data into time series (weekly frequency)
  myts <- ts(x, frequency = 7)
  
  # Perform STL decomposition
  fit <- stl(myts, s.window = "period")
  
  # Plot decomposition components
  plot(fit)
  
  # Visualize seasonal patterns
  monthplot(myts)
  library(forecast)
  seasonplot(myts)
  
  # Print time series values
  print(myts, calendar = TRUE)
  
  
  ###########################################################
  # STEP 2: HOLT-WINTERS FORECASTING (BASE MODEL)
  ###########################################################
  
  # Apply Holt-Winters smoothing
  fit <- HoltWinters(myts, alpha = 0.992, beta = 0, gamma = 0)
  
  # Generate forecast for 28 days
  mygraph <- forecast(fit, 28)
  
  # Plot forecast results
  plot(forecast(fit, 28))
  
  # Print forecasted values
  print(round(forecast(fit, 28)$mean), calendar = FALSE)
  
  
  ###########################################################
  # STEP 3: DATA PREPROCESSING FOR STL + ETS
  ###########################################################
  
  # Add 1 to avoid log(0) issues
  for(i in c(1:length(x)))
    x[i] <- x[i] + 1
  
  
  ###########################################################
  # STEP 4: LOG TRANSFORMATION
  ###########################################################
  
  # Convert to log scale time series
  myTs <- ts(log(x), start = 1, frequency = 30)
  
  
  ###########################################################
  # STEP 5: STL + ETS FORECASTING (MAIN MODEL)
  ###########################################################
  
  # Apply STL decomposition + ETS forecasting
  fc <- stlf(myTs, 
             h = n.ahead, 
             s.window = 2, 
             method = 'ets',
             ic = 'bic',
             opt.crit = 'mae')
  
  # Convert back from log scale
  pred <- exp(fc$mean)
  
  
  ###########################################################
  # STEP 6: POST-PROCESSING OF RESULTS
  ###########################################################
  
  # Adjust values back (remove +1, round, remove negatives)
  for(i in c(1:n.ahead)){
    pred[i] <- pred[i] - 1
    pred[i] <- round(pred[i] / 1) * 1
    if(pred[i] < 0)
      pred[i] <- 0
  }
  
  return(pred)
}


###############################################################
# FUNCTION 4: GENERATE FINAL OUTPUT MATRIX
###############################################################
get_final <- function(result, key_id, nrow, ncol){
  
  # Initialize output matrix
  output <- matrix(data = 0, nrow = nrow, ncol = ncol)
  
  # Insert product IDs in first column
  for(i in c(1:100)){
    output[,1][i + 1] <- key_id[,1][i]
  }
  
  # Insert forecasted values
  tresult <- t(result)
  for(i in c(1:101)){
    for(j in c(1:28))
      output[, j + 1][i] <- tresult[, j][i]
  }
  
  return(output)
}