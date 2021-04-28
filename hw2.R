# STA104 HW2
# Anqi Pan

library(coin)
# Problem 2
plants <- read.csv("C:/Users/richa/Desktop/plants.csv")
plants.data = data.frame(height= plants$height, group=plants$group)
the.groups =as.factor(plants.data$group)
test.stuff = oneway_test(height ~ the.groups, data = plants.data, distribution = "exact", alternative = "greater")
pvalue(test.stuff)

install.packages("xtable")
library(xtable)
library(coin)
#Problem 3
means = round(aggregate(height ~ the.groups, plants.data, mean)$height,4)
means
sds = round(aggregate(height ~  the.groups, plants.data, sd)$height,4)
sds
ns = round(aggregate(height ~  the.groups, plants.data, length)$height,4)
ns
x = round(mean(plants$height),4)
s = round(sd(plants$height),4)
z1 = round( (means[1] - x)/(s[1]/sqrt(ns[1])),2)
p.value.greater =pvalue(oneway_test(height ~ the.groups, data = plants.data, alternative = "greater"))
p.value.less =pvalue(oneway_test(height ~ the.groups, data = plants.data, alternative = "less"))
p.value.two =pvalue(oneway_test(height ~ the.groups, data = plants.data, alternative = "two.sided"))
p.value.greater
p.value.less
p.value.two

#Problem 4
groups = rep(c("A","B"),each = 3)
dat.data = c(16,15.7,16.4,17.2,19.8,16.9)
groups = groups[order(dat.data)]
dat.data = sort(dat.data)
ranks = rank(dat.data)
all.results = rbind(groups,dat.data,ranks)
xtable(all.results)

#Problem 6
classtype <- read.csv("C:/Users/richa/Desktop/classtype.csv")
classtype.data = data.frame(score=classtype$Score, type=classtype$Type)
type=as.factor(classtype.data$type)
score=as.numeric(classtype.data$score)
wilcox_test(score ~ type, classtype, alternative = "less")
exact.pval_classtype = pvalue(wilcox_test(score ~ type, classtype, distribution = "exact",alternative = "less"))
exact.pval_classtype
approx.pval_classtype = pvalue(wilcox_test(score ~ type, classtype, alternative = "less"))
approx.pval_classtype

#Problem 7
levels(classtype$Type) = c("Online","Classroom")
classtype$ranks = rank(classtype$Score)
mu = mean(classtype$ranks)
N = nrow(classtype)
sigma = sd(classtype$ranks)*(N-1)/N
r1 = aggregate(ranks~Type,classtype,sum)$ranks[2]
m = aggregate(ranks~Type,classtype,length)$ranks[2];n = aggregate(ranks~Type,classtype,length)$ranks[1]
EW = m*mu
VARW = m*n*sigma^2/(N-1)
Zs = (r1 - EW)/sqrt(VARW)  #Find  the  appropriate  test-statistic  for  the  observedtotal,
Zs
p.value = 2*pnorm(abs(Zs),lower.tail = FALSE)
p.value

#Problem 8
install.packages("FSA")
surgery <- read.csv("C:/Users/richa/Desktop/surgery.csv")
surgery.data = data.frame(times= surgery$Times, group_surgery=surgery$Group)
group_surgery = as.factor(surgery.data$group_surgery)
times_surgery = as.numeric(surgery.data$times)
library(FSA)
hist(times_surgery ~ group_surgery, surgery.data)
approx.pvalue_surgery = pvalue(wilcox_test(times_surgery ~ group_surgery, surgery,alternative = "two.sided"))
approx.pvalue_surgery
exact.pval_surgery = pvalue(wilcox_test(times_surgery ~ group_surgery, surgery,distribution = "exact",alternative = "two.sided"))
exact.pval_surgery

# Problem 9
x1<-c(10,15,50)
x2<-c(10,17,19)
wilcox.test(x1, x2, alternative = "two.sided", paired = FALSE, exact = FALSE, correct = TRUE)

#Problem 10
options(scipen = 9999999)
the.test = wilcox_test(times_surgery ~ group_surgery, surgery,conf.level = 0.95,conf.int = TRUE)
CI = as.numeric(confint(the.test)$conf.int)
CI
New = surgery$Times[surgery$Group == "New"]
Old = surgery$Times[surgery$Group == "Old"]
all.pw.diff = lapply(1:7,function(i){
  Diff = New[i] - Old
})
all.pw.diff = Reduce(c,all.pw.diff)
all.pw.diff = sort(all.pw.diff)

#Problem 11
the.test = wilcox_test(score ~ type, classtype,conf.level = 0.90,conf.int = TRUE)
CI = as.numeric(confint(the.test)$conf.int)
CI
