# Anqi Pan
# STA104 Take-home question toys

library(readr)
toys <- read_csv("C:/Users/richa/Desktop/Toys.csv", col_types = cols(Broken = col_number()))


toy_summary <- summary(toys$Broken)
toy_summary
toy_sd <- sd(toys$Broken)
toy_sd
hist(toys$Broken, breaks = 17, main = 'Histogram of Number of Toy Broken in a Week', xlab =
       'Number of Toy is Broken in a Week')
ggplot(toys, aes(y=toys$Broken, x=factor(""))) + geom_boxplot() + ylab("Number of Toy is Broken in a Week") + xlab("") + coord_flip() + ggtitle("Boxplot of Number of Toys Broken in a Week")

library(coin)
library(BSDA)


X = toys$Broken
B = sum(X > 3)
n = length(X)
Zs = (B - n*0.50)/sqrt(0.25*n)
Zs
p.value.greater = pnorm(Zs,lower.tail= FALSE)
p.value.greater



X= sort(X)
CDF = cumsum(table(X))/length(X) 
FX = as.numeric(CDF)
X = as.numeric(names(CDF)) 
alpha = 0.10
all.lower.bounds = FX -qnorm(1-alpha/2)*sqrt(FX*(1-FX)/n)
all.upper.bounds = FX +qnorm(1-alpha/2)*sqrt(FX*(1-FX)/n)
all.CI = cbind(all.lower.bounds,all.upper.bounds)
rownames(all.CI) = X
all.CI