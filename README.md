# 🧪 Isotope-Elevation Analysis

This project analyzes the relationship between oxygen isotope values (δ¹⁸O), elevation, and slope. It applies linear modeling and residual analysis to understand how δ¹⁸O changes with elevation and terrain slope.

---

## 📂 Contents

- `data/isotope_data_with_slope.csv`  
- `scripts/isotope_analysis.R`
- `plots/plot1.png`, `plot2.png`, `plot3.png`

---

## 📊 Analysis Highlights

- Linear model: `mean_delta_O18 ~ Elevation`
- Residuals calculated and plotted
- Correlation tests for:
  - Elevation vs δ¹⁸O
  - Residuals vs Elevation
  - Residuals vs Slope
  - Elevation vs Predicted δ¹⁸O

---

## 🧪 Visualizations

### δ¹⁸O vs Elevation  
![plot1](plots/plot1.png)

### Residuals vs Elevation  
![plot2](plots/plot2.png)

### Residuals vs Slope  
![plot3](plots/plot3.png)

---

## 🧠 How to Reproduce

1. Install R and required packages:

```r
install.packages(c("ggplot2", "dplyr", "gridExtra"))