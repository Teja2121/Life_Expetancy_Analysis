# World Life Expectancy Analysis

This project explores global life expectancy trends using SQL, focusing on data cleaning, exploratory data analysis (EDA), and discovering meaningful insights into health and economic factors. 

---

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Key Insights](#key-insights)
- [Technologies Used](#technologies-used)
- [How to Use](#how-to-use)

---

## Introduction

Understanding life expectancy is crucial for assessing a country's health and development. This project uses SQL to process and analyze global life expectancy data, identifying trends and relationships between life expectancy, GDP, BMI, and country status (developing or developed).

---

## Features

- **Data Cleaning**: 
  - Detect and remove duplicate records.
  - Handle missing values in `Status` and `Life Expectancy` columns using data imputation techniques.

- **Exploratory Data Analysis (EDA)**:
  - Identify countries with the highest and lowest increases in life expectancy over time.
  - Calculate average life expectancy across years.
  - Analyze correlations between GDP, BMI, and life expectancy.
  - Compare life expectancy based on country status (developed vs. developing).

- **Advanced Analysis**:
  - Rolling totals for adult mortality.
  - Identify trends and disparities among countries.

---

## Data Cleaning

### Steps:
1. **Duplicate Removal**: Identified duplicate entries based on `Country` and `Year` columns and removed them using `ROW_NUMBER()`.
2. **Handling Missing Values**: 
   - Filled missing `Status` values based on the country’s majority category.
   - Imputed missing `Life Expectancy` values using neighboring years' averages.

---

## Exploratory Data Analysis

### Key Analyses:
- **Country Performance**:
  - Identify countries with the highest/lowest improvements in life expectancy.
- **Life Expectancy Over Time**:
  - Analyze year-by-year average life expectancy trends.
- **GDP and Life Expectancy Correlation**:
  - Examine how GDP levels impact life expectancy.
- **BMI and Life Expectancy Relationship**:
  - Compare average BMI with life expectancy across countries.
- **Country Status Analysis**:
  - Analyze differences in life expectancy between developed and developing countries.

---

## Key Insights

1. Countries with higher GDP generally exhibit higher life expectancy.
2. Developing countries have lower life expectancy than developed countries, but trends show improvement over time.
3. BMI and life expectancy exhibit significant correlations in some regions.
4. Adult mortality rolling totals provide insights into the long-term health trends within countries.

---

## Technologies Used

- **SQL**: For data cleaning and analysis.
- **RDBMS**: MySQL for database management.

---

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/world-life-expectancy.git
   ```
2. Import the SQL script into your MySQL database.
3. Run the queries step-by-step to clean the data and perform analysis.
4. Explore the results to uncover insights.

---



Feel free to contribute or raise issues in the repository to improve the analysis!
