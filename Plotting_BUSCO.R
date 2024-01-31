library("wesanderson")
library("ggplot2")
pal <- c("#3B9AB2", "#78B7C5", "#EBCC2A", "#E1AF00", "#F21A00")
busco_data <- read.csv("busco.csv")
single_copy <- busco_data$Complete.BUSCOS - busco_data$Complete.and.Single.Copy
busco_data$Complete.and.Single.Copy <- single_copy
busco_array <- array(busco_data)

# create dataset for ggplot
Assembly <- sort(rep(busco_data$Assembly, 5))
busco_type <- rep(c("Complete", "Single Copy", "Duplicated","Fragmented","Missing"),5)
Hits <- c(3962,78,78,101,524,4251,55,60,51,290,4522,45,46,18,55,4536,55,46,9,55,3419,1355,1337,211,997)
data <- data.frame(assembly, busco_type, values)

busco_colors <- setNames(pal, unique(data$busco_type))

# plot
ggplot(data, aes(fill=busco_type, y=Hits, x=Assembly)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = busco_colors)


