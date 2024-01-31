library(ggplot2)

# Create dataset 
Assembler <- c(rep("Flye",4),rep("Canu",4),rep("Trinity",4))
Details <- rep(c("Polished No Reference", "Unpolished No Reference","Polished With Reference","Unpolished With Reference"),3)
N50 <- c(74402,74302,74402,74302,12757100,12754050,12757100,12754050,3835,0,3835,0)
logN50 <- log(N50)
data <- data.frame(Assembler,Details,logN50)
# Plot
ggplot(data, aes(fill=Details, y=logN50, x=Assembler)) + 
  geom_bar(position="dodge", stat="identity")

#----------------------------------
# Canu
Assembly <- c("Polished No Reference", "Unpolished No Reference","Polished With Reference","Unpolished With Reference")
N50 <- c(74402,74302,74402,74302)
canu_data <- data.frame(Assembly,N50)

# plot 
ggplot(canu_data, aes(x = Assembly, y = N50, fill = Assembly)) +
  geom_bar(stat = "identity") + # You can customize colors as needed
  labs(title = "N50 Values for Different Assemblies", x = "Assembly", y = "N50") +
  theme_minimal() +
  scale_y_log10()  # Use a log scale on the y-axis