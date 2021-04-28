# STA104 project2
# Question2: Test for independence


library(dplyr)
CovidB <- read.csv("C:/Users/richa/Desktop/CovidB.csv")

# redefine age group

CovidB <- CovidB %>% filter(Age_Group %in%  c("0-17 years",
                                              "18-29 years","30-39 years","40-49 years","50-64 years",
                                              "65-74 years","75-84 years","85 years and over")) %>%
  mutate(new_Age_Group = case_when(Age_Group %in% c("0-17 years" )  ~ "0-17 years",
                                   Age_Group %in% c("18-29 years", "30-39 years") ~ "18-39 years",                       
                                   Age_Group %in% c("40-49 years","50-64 years") ~ "40-64 years",
                                   Age_Group %in% c("65-74 years","75-84 years","85 years and over") ~ "65 years and over"))

#summary
aggregate(Death ~ Sex, data= CovidB, median)
aggregate(Death ~ new_Age_Group, data= CovidB, median)

library(coin)
CovidB$Rank = rank(CovidB$Death, ties = "average")
Group.order = aggregate(Death ~ Sex, data = CovidB, mean)$Sex
Xi = aggregate(Death ~ Sex, data = CovidB, mean)$Death
si = aggregate(Death ~ Sex, data = CovidB, sd)$Death
Ri = aggregate(Rank ~ Sex, data = CovidB, mean)$Rank
ni = aggregate(Death ~ Sex, data = CovidB, length)$Death
results = rbind(Xi,si,Ri,ni)
rownames(results) = c("Group Mean","Group SD","Rank Mean","Sample Size")
colnames(results) = as.character(Group.order)
results

CovidB$Rank = rank(CovidB$Death, ties = "average")
Group.order = aggregate(Death ~ new_Age_Group, data = CovidB, mean)$Sex
Xi = aggregate(Death ~ new_Age_Group, data = CovidB, mean)$Death
si = aggregate(Death ~ new_Age_Group, data = CovidB, sd)$Death
Ri = aggregate(Rank ~ new_Age_Group, data = CovidB, mean)$Rank
ni = aggregate(Death ~ new_Age_Group, data = CovidB, length)$Death
results = rbind(Xi,si,Ri,ni)
rownames(results) = c("Group Mean","Group SD","Rank Mean","Sample Size")
colnames(results) = as.character(Group.order)
results

# filter one month
CovidB <- CovidB %>% 
  filter(Year == 2020, Month == 3) 

# Plot
library(ggplot2)
ggplot(CovidB) + 
  geom_col(aes(Sex, Death, fill = new_Age_Group))

# Contingency table
Covid_table <- xtabs(Death ~ Sex + new_Age_Group, CovidB)
Covid_table

xtabs(Death ~ Sex + new_Age_Group, CovidB)
n_sex = rowSums(Covid_table)
n_Age_Group = colSums(Covid_table)
n_sex
n_Age_Group

# Permutation test for independence
the.test = chisq.test(Covid_table,correct = FALSE)
eij = the.test$expected
chi.sq.obs = as.numeric(the.test$statistic)
chi.sq.obs
eij

# Multiple comparison
n = sum(Covid_table)
ni. = rowSums(Covid_table)
n.j = colSums(Covid_table)
ni.
all.pjG1 = Covid_table[1,]/ni.[1] #all conditional probabilites for row 1
all.pjG2= Covid_table[2,]/ni.[2] #all conditional probabilites for row 2
all.pbar = n.j/n #all probabilities regardless of group
all.Zij = c(all.pjG1 - all.pjG2)/sqrt(all.pbar*(1-all.pbar)*(1/ni.[1] + 1/ni.[2])) #The z-test-statistics
all.Zij = matrix(all.Zij,nrow=  1)
colnames(all.Zij) = c("0-17 years", "18-39 years", "40-64 years", "65 years and above")
rownames(all.Zij) = c("Female vs.male")
all.Zij


library(coin)
r.perms.cutoff = sapply(1:R,function(i){
  CovidB$Age_Group = sample(CovidB$Age_Group,nrow(Covid_table),replace = FALSE)
  row.sum = rowSums(Covid_table)
  col.sum = colSums(Covid_table)
  all.pji = Covid_table[1,]/row.sum[1]
  all.pji.= Covid_table[2,]/row.sum[2]
  all.pbar = col.sum/sum(row.sum)
  all.Zij = c(all.pji - all.pji.)/sqrt(all.pbar*(1-all.pbar)*(1/row.sum[1] + 1/row.sum[2]))
  Q.r = max(abs(all.Zij))
  return(Q.r)
})
alpha = 0.05
cutoff.q = as.numeric(quantile(r.perms.cutoff,(1-alpha)))
cutoff.q
