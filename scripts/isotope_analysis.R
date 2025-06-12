# Clean up environment
rm(list = ls())

# Load required libraries
library(ggplot2)
library(dplyr)
library(gridExtra)

# Set file path to your dataset
data_file_path <- "C:/Users/atifa/OneDrive/Documents/GitHub/isotope-elevation-analysis/data/isotope_data_with_slope.csv"

# Read the dataset
isotope_data <- read.csv(data_file_path)

# Fit a linear model: mean_delta_O18 as a function of Elevation
model <- lm(mean_delta_O18 ~ Elevation, data = isotope_data)

# Extract coefficients
a <- coef(model)[1]  # Intercept
b <- coef(model)[2]  # Slope

# Add predicted values and residuals to the dataframe
isotope_data <- isotope_data %>%
  mutate(
    Predicted_isotopes = a + b * Elevation,  
    Residuals = mean_delta_O18 - Predicted_isotopes  
  )

# Plot 1: mean_delta_O18 vs Elevation
plot1 <- ggplot(isotope_data, aes(x = Elevation, y = mean_delta_O18)) +
  geom_point(color = "black", shape = 1) +
  geom_smooth(method = "lm", color = "red", linetype = "dashed") +
  labs(
    title = "mean_delta_O18 vs Elevation",
    x = "Elevation",
    y = expression(delta^18*O)
  ) +
  theme_minimal()

ggsave("C:/Users/atifa/OneDrive/Documents/GitHub/isotope-elevation-analysis/plots/plot1_mean_delta_O18_vs_Elevation.png",
       plot = plot1, width = 7, height = 5, dpi = 300)

# Correlation test
print(cor.test(isotope_data$mean_delta_O18, isotope_data$Elevation))

# Plot 2: Residuals vs Elevation
plot2 <- ggplot(isotope_data, aes(x = Elevation, y = Residuals)) +
  geom_point(color = "black") +
  geom_hline(yintercept = 0, linetype = "dotted", color = "red") +
  labs(
    title = "Residuals vs Elevation",
    x = "Elevation",
    y = "Residuals"
  ) +
  theme_minimal()

ggsave("C:/Users/atifa/OneDrive/Documents/GitHub/isotope-elevation-analysis/plots/plot2_residuals_vs_elevation.png",
       plot = plot2, width = 7, height = 5, dpi = 300)

# Correlation test
print(cor.test(isotope_data$Residuals, isotope_data$Elevation))

# Plot 3: Residuals vs Slope
plot3 <- ggplot(isotope_data, aes(x = slope, y = Residuals)) +
  geom_point(color = "red", shape = 16) +
  geom_hline(yintercept = 0, linetype = "dotted", color = "black") +
  labs(
    title = "Residuals vs Slope",
    x = "Slope",
    y = "Residuals"
  ) +
  theme_minimal()

ggsave("C:/Users/atifa/OneDrive/Documents/GitHub/isotope-elevation-analysis/plots/plot3_residuals_vs_slope.png",
       plot = plot3, width = 7, height = 5, dpi = 300)

# Correlation test
print(cor.test(isotope_data$Residuals, isotope_data$slope))

# Arrange all plots in one window (optional view)
grid.arrange(plot1, plot2, plot3)

# Create arranged plot layout object
combined_plot <- gridExtra::arrangeGrob(plot1, plot2, plot3)

# Save the arranged plot grid as one image
ggsave("C:/Users/atifa/OneDrive/Documents/GitHub/isotope-elevation-analysis/plots/plot_combined_grid.png",
       plot = combined_plot, width = 12, height = 8, dpi = 300)

# Final correlations
print(cor.test(isotope_data$Elevation, isotope_data$Predicted_isotopes))
print(cor.test(isotope_data$slope, isotope_data$Predicted_isotopes))

print(plot1)