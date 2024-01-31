data <- data.frame(
  Assembly = c("canu_polished", "canu_raw", "flye_polished", "flye_raw"),
  QV = c(38.7889, 28.7472, 41.9063, 37.3745),
  error = c(0.000132164, 0.00133679, 6.4622e-05, 0.000133042)
)

# Create a bar graph with ggplot
ggplot(data, aes(x = Assembly, y = QV, fill = Assembly)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = QV - error, ymax = QV + error), position = position_dodge(width = 0.8), width = 0.25) +
  labs(title = "QV Values with Error Bars for Different Assemblies", x = "Assembly", y = "QV") +
  theme_minimal()