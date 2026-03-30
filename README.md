# SALES TIME SERIES FORECASTING USING STL AND ETS

---

## Team Members

* **N Medhashree** – 2023BCS0042
* **Sejal Satheesh** – 2023BCS0048
* **Amal Byju Dev** – 2023BCS0156
* **Ayesha Linta** – 2023BCS0183

---

## Problem Statement

The objective of this project is to forecast future sales for 100 key product IDs using historical sales data of 118 days. Accurate forecasting is important for effective inventory management, demand planning, and business decision-making. The goal is to predict sales for the next 28 days for each product.

---

## Objectives

* Analyze time series sales data for multiple products
* Identify patterns such as trend and seasonality
* Apply suitable forecasting techniques
* Generate predictions for the next 28 days
* Produce structured output for all products

---

## Dataset

### Source

The dataset is provided as part of the project files.

### Number of Observations

118 days of sales data

### Number of Variables

* 101 columns

  * 1 aggregated column
  * 100 product sales columns

### Description

* Each column represents sales of a product
* Each row represents daily sales
* Separate file contains key product IDs
* Structured for time series forecasting

---

## Methodology

### Data Preprocessing

The dataset is loaded using a custom function and converted into matrix format. It is transposed to process each product independently. A new feature representing total daily sales is created. The data is structured for time-series analysis.

### Exploratory Data Analysis

EDA is performed using:

* Time series plots
* Seasonal plots
* Month plots

The data shows noticeable trends but weak seasonality.

---

## Models Used

### STL (Seasonal and Trend Decomposition)

Used to decompose time series into trend and seasonal components.

### ETS (Error, Trend, Seasonal)

Used for forecasting future values after decomposition.

### Holt-Winters Model

Used as an additional smoothing technique for improved predictions.

---

## Forecasting Process

Each product is processed individually using a loop. The time series is created, decomposed, and forecasted for the next 28 days. Predictions are stored in a result matrix.

---

## Evaluation Method

* Consistency of predicted trends
* No negative forecast values
* Smooth and realistic predictions

---

## Results

The model successfully generated forecasts for all products. Each product has 28 predicted values. Results are stored in a structured output file and follow realistic trends.

---

## Key Visualizations

### Figure 1: STL Decomposition

Shows trend, seasonal, and residual components.
![alt text](results/figures/stl_decomposition_01.png)

### Figure 2: Month Plot

Illustrates seasonal variations across time.
![alt text](results/figures/time_series_plot_01.png)

### Figure 3: Seasonal Plot

Compares patterns across cycles.
![alt text](results/figures/seasonal_plot_01.png)

### Figure 4: Forecast Plot

Displays predicted values with confidence intervals.
![alt text](results/figures/forecast_plot_01.png)
---
## Results Tables

- **Output Predictions (`output.txt`)**  
  Contains the final forecasted sales values for all 100 products over the next 28 days. Each row represents a product and each column corresponds to predicted daily sales.

- **Model Summary (`model_summary.csv`)**  
  Provides a concise overview of the forecasting approach, including the model used (STL + ETS), forecast horizon, seasonality assumptions, and transformations applied.

- **Statistical Summary (`statistical_summary.csv`)**  
  Includes key statistical measures such as mean, median, maximum, and minimum values of the dataset, helping to understand overall data distribution.

- **Missing Values Summary (`missing_values_summary.csv`)**  
  Displays the number of missing values for each product, highlighting data sparsity and helping assess data quality.
  
----

## How to Run the Project

1. Install R or RStudio
2. Install required package:

   ```r
   install.packages("forecast")
   ```
3. Set working directory to project folder
4. Run:

   ```r
   source("scripts/03_run_pipeline.R")
   ```
5. Output will be generated in `results/`

---

## Folder Organization

```
project/
├── data/
|   ├── data_files/
│   └── data_description.md
├── scripts/
├── results/
│   ├── figures/
│   └── tables/
├── presentation/
├── README.md
```

---

## Conclusion

This project demonstrates the application of time-series forecasting using STL and ETS models. The approach effectively captures trends and produces reliable forecasts, making it useful for demand planning and business decisions.

---

## Contribution

| Team Member    | Contribution                                                                            |
| -------------- | --------------------------------------------------------------------------------------- |
| N Medhashree   | Data preprocessing, transformation, feature engineering, EDA, and dataset documentation |
| Sejal Satheesh | STL + ETS model development, forecasting, and README documentation                      |
| Amal Byju Dev  | Visualization, results generation, plots, and tables                                    |
| Ayesha Linta   | ARIMA model development, model comparison, pipeline integration, and presentation       |

---

## References

* R Forecast Package Documentation
* Hyndman, R.J. – Forecasting Methods
* CRAN R Project Website
* Course materials and lecture notes

---

## Repository Information

* **Repository Name:** SALES_PREDICTION_TEAM_09
* **GitHub Link:** (https://github.com/medhashree05/SALES_PREDICTION_TEAM_09)
