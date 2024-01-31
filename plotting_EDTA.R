
pal <- c("#142459","#176BA0","#19AADE","#7D3AC1","#AF4BCE","#DB4CB2","#EB548C","#EA7369","#2E8567")

data <- data.frame(
  Class = c("Copia","Gypsy","unknown LTR", "CACTA","Mutator","PIF Harbinger","Tc1 Mariner","hAT","Helitron"),
  Percentage = c(1.12,4.94,0.48,0.60,0.56,0.14,0.12,0.22,5.33)
)
# Convert "Class" to a factor with specified levels
data$Class <- factor(data$Class, levels = unique(data$Class))

class_colors <- setNames(pal, unique(data$Class))

# Create a bar graph with ggplot
ggplot(data, aes(x = Class, y = Percentage, fill = Class)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = class_colors) +
  theme_minimal()