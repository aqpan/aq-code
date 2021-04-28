# Anqi Pan
# Title: STA104 project1 drug

drug <- read.csv("C:/Users/richa/Desktop/Drug.csv")
drug <- drug[,-1]

# summary statistics
summaryA <- summary(drug$Relief[1:12])
summaryA
sdA <- sd(drug$Relief[1:12])
sdA

summaryB <- summary(drug$Relief[13:24])
summaryB
sdB <- sd(drug$Relief[13:24])
sdB

summaryALL <- summary(drug$Relief[1:24])
summaryALL
sdALL <- sd(drug$Relief[1:24])
sdALL

# descriptive plots
library(ggplot2)
ggplot(drug, aes(x=Relief, fill= Drug))+ geom_histogram(binwidth=.5, alpha=.5, position="identity") + ggtitle("Histogram of Hours of Pain Relief")
ggplot(drug, aes(y = Relief,x = Drug, fill= Drug)) + geom_boxplot() + xlab("Drug type") + ylab("Hours of pain relief") + ggtitle("Boxplot of Hours of Pain Relief by Drug Type") + coord_flip() 

library(coin)
#confidence interval for shift parameter
alpha =0.10
drug_ = as.factor(drug$Drug)
relief_ = as.numeric(drug$Relief)
save.me = wilcox_test(relief_ ~ drug_, drug, distribution = "exact",alternative = "two.sided",conf.int = TRUE, conf.level = 1-alpha)
confint(save.me)
confint(save.me)$conf.int[1:2]

# wilcoxon test
drug$Drug <- as.factor(drug$Drug)
wilcox_test(drug$Relief ~ drug$Drug, distribution = "exact", alternative = "greater")

