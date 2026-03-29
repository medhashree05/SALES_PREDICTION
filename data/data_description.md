# Dataset Description

## Dataset Name

Sales Time Series Prediction Dataset

---

## Source

The dataset is provided as part of an academic data mining project. It simulates real-world retail sales data involving multiple products and buyer behavior over time.

---

## Description

This dataset contains historical sales data for multiple products along with additional information about buyers and product features. The data is used to perform time-series forecasting and predict future sales for each product.

The dataset includes daily sales records across multiple products and spans several time periods, enabling trend and seasonal analysis.

---

## Files Included

### 1. product_distribution_training_set.txt

* Contains historical sales data for products
* Rows represent products
* Columns represent daily sales values
* Used as the primary input for forecasting models

---

### 2. key_production_IDs.txt

* Contains unique product identifiers
* Used to map predictions to specific products

---

### 3. product_features.txt

* Contains additional attributes of products
* May include categorical or numerical features describing products

---

### 4. buyer_basic_info.txt

* Contains demographic or basic information about buyers

---

### 5. buyer_historical_category15_money.txt

* Historical spending data of buyers in a specific category

---

### 6. buyer_historical_category15_quantity.txt

* Historical quantity purchased by buyers in a specific category

---

### 7. trade_info_training.txt

* Contains transaction-level details such as trade or purchase records

---

## Number of Instances

* Approximately 100 products
* Each product contains around 118 days of historical sales data

---

## Number of Attributes

* Sales data: ~118 time-based attributes per product
* Additional datasets include multiple attributes related to buyers and products

---

## Data Characteristics

* Time-series data (daily frequency)
* Contains trends and seasonal patterns
* May include zero values (handled during preprocessing)

---

## Preprocessing Steps Applied

* Conversion of raw data into matrix format
* Transposition of dataset for easier manipulation
* Creation of aggregate features (total daily sales)
* Handling of zero values using offset (+1)
* Log transformation for variance stabilization
* Post-processing to ensure non-negative predictions

---

## How to Use the Dataset

1. Place all `.txt` files inside the `data/` folder
2. Run the main script:

   ```r
   source("scripts/03_run_pipeline.R")
   ```
3. The model will:

   * Load and preprocess the data
   * Apply STL + ETS forecasting
   * Generate predictions for the next 28 days

---

## Notes

* The dataset is structured for time-series forecasting tasks
* No missing values handling was required in the current implementation
* Data is assumed to be clean and pre-formatted

---
