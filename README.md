SALES TIME SERIES FORECASTING USING STL AND ETS

Team Members
N Medhashree - 2023BCS0042
Sejal Satheesh - 2023BCS0048
Amal Byju Dev - 2023BCS0156
Ayesha Linta - 2023BCS0186

Problem Statement
The objective of this project is to forecast future sales for 100 key product IDs using historical sales data of 118 days. Accurate forecasting is important for effective inventory management, demand planning, and business decision-making. The goal is to predict sales for the next 28 days for each product.

Objectives
The main objectives of this project are:
To analyze time series sales data for multiple products
To identify patterns such as trend and seasonality in the data
To apply suitable forecasting techniques to predict future sales
To generate predictions for the next 28 days for each product
To produce a structured output containing all predictions



Dataset
Source of Dataset:
The dataset is provided as part of the project files.
Number of Observations:
118 days of sales data
Number of Variables:
101 columns
1 column representing aggregated or processed data
100 columns representing individual product sales
Description of Important Attributes:
Each column represents the sales of a particular product over time
Each row represents daily sales values
A separate file contains the key product IDs
The dataset is structured for time series forecasting

Methodology
Data Preprocessing
The dataset is loaded using a custom function. The data is transposed to make it easier to process each product individually. A new column is created to store total daily sales by summing across products. The data is then structured into a format suitable for time series analysis.

Exploratory Data Analysis
Basic exploratory analysis is performed using time series plots. Visualization techniques such as standard plots, seasonal plots, and month-wise plots are used to understand patterns in the data. It was observed that the dataset does not show strong seasonal patterns but contains noticeable trends.




Models Used
STL (Seasonal and Trend Decomposition using Loess):
STL is used to decompose the time series into trend and seasonal components. This helps in understanding the underlying structure of the data.
ETS (Error, Trend, Seasonal Model):
The ETS model is used for forecasting future values. It works well for time series data with trend components and is applied after decomposition.
Holt-Winters Model:
An additional smoothing-based model is used to further improve forecasting accuracy by handling trends effectively.

Forecasting Process
Each product’s sales data is processed individually. A loop is used to iterate through all product columns. For each product, the time series is created, decomposed, and forecasted for the next 28 days. The predicted values are stored in a result matrix.

Evaluation Method
The model performance is evaluated by checking:
Consistency of predicted trends
Absence of negative forecast values
Smoothness and realism of predicted outputs

Results
The model successfully generated forecasts for all products. Each product has 28 predicted future values. The results are stored in a structured output file. The predictions follow the general trend of historical data and do not produce unrealistic values.



Key Visualizations
The following visualizations are used in the project:

Figure 1: STL decomposition showing data, trend, seasonal, and remainder components.
Explanation:
This plot decomposes the time series into its components using STL. The trend shows the overall direction of sales, the seasonal component shows repeating patterns, and the remainder represents random noise in the data.

Figure 2: Month plot illustrating seasonal variations across time periods.

Explanation:
This plot compares values across different cycles to identify seasonal patterns. It helps in understanding whether the data follows any repeating behavior over time.



Figure 3: Season plot comparing patterns across different time cycles.
Explanation:
The season plot displays multiple cycles of the time series, allowing comparison between different periods. Each line represents a cycle, helping identify consistency or variation in patterns.

Figure 4: Forecasted values for the next 28 days with confidence intervals.
Explanation:
This plot shows the predicted future values based on historical data. The shaded region represents confidence intervals, indicating the uncertainty in the forecast.

Results Tables
Output Predictions (output.txt)
Contains the final forecasted sales values for all 100 products for the next 28 days.
Model Summary (model_summary.csv)
Provides an overview of the forecasting approach, including model type, forecast horizon, seasonality, and transformations applied.
Statistical Summary (statistical_summary.csv)
Displays key statistical measures (mean, median, maximum, minimum) of the dataset to understand overall data distribution.
Missing Values Summary (missing_values_summary.csv)
Shows the number of missing values for each product, helping identify data quality issues and sparsity in the dataset.

How to Run the Project
Steps to Execute:
Install R or RStudio
Install the required package: forecast
Set the working directory to the project folder
Run the main script file. source("scripts/03_run_pipeline.R")
Output will be generated in the results/tables folder

Folder Organization
The project folder contains the following files:
Main script file for execution (scripts/03_run_pipeline.R)
File containing forecasting functions
Dataset file containing sales data (data/data_files)
File containing product IDs
Output file containing predictions (results/tables)

Conclusion
The project demonstrates the application of time series forecasting techniques on sales data. STL decomposition helps in extracting the trend component, while the ETS model provides accurate future predictions. The approach is effective for datasets with limited or weak seasonality. The generated forecasts can be used for demand planning and business decision-making.

Contribution
N Medhashree - Data preprocessing, data transformation, feature engineering, and initial exploratory data analysis (EDA) including time series visualization and seasonal pattern analysis and documentation ( dataset description).

Sejal Satheesh – Development of Model-1 using STL decomposition and ETS forecasting, including data transformation (log scaling), model implementation, and generation of 28-day predictions., and documentation (README).

Amal Byju Dev - Visualization, results generation, and report writing including creation of plots (STL decomposition, seasonal plots, forecast plots), tables (model summary, statistical summary).

Ayesha Lintha - Development of Model-2 using ARIMA, model comparison, integration of scripts into a unified pipeline, and output generation for final predictions and documentation (ppt).


References
R Forecast Package Documentation
Hyndman, R.J. – Forecasting Methods
CRAN R Project Website
Course materials and lecture notes

Repository Information
Repository Name: SALES_PREDICTION_TEAM_09
GitHub Link: https://github.com/medhashree05/SALES_PREDICTION_TEAM_09/tree/main

