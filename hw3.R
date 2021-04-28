  # STA 104 HW3
  # Anqi Pan


# Question 1
library(coin)
workout <- read.csv("C:/Users/richa/Desktop/workout.csv")
the_groups = as.factor(workout$Groups)
the_BPM = as.numeric(workout$BPM)
the.test =  kruskal_test(the_BPM ~ the_groups, workout)
the.test

# Question 2b 
F.obs = summary(lm(BPM ~ Groups, workout))$fstatistic["value"]
F.obs
R =3000
many.perms = sapply(1:R,function(i){
  permuted.data = workout
  permuted.data$Groups = sample(permuted.data$Groups, nrow(permuted.data),replace = FALSE)
  Fi = summary(lm(BPM ~ Groups, data = permuted.data))$fstatistic["value"]
  return(Fi)
})
mean(many.perms >= F.obs)   # p-value for the Permutation test


# Question 2C
KW.OBS = 1/SR.2*sum(ni*(Ri - (N+1)/2)^2) 
R = 3000
many.perms.KW = sapply(1:R,function(i){
  permuted.data = workout
  permuted.data$Groups = sample(permuted.data$Groups, nrow(permuted.data), replace = FALSE) 
  SR.2 = var(permuted.data$Rank)
  ni = aggregate(Rank ~ Groups, data = permuted.data,length)$Rank
  Ri = aggregate(Rank ~ Groups, data = permuted.data,mean)$Rank
  KW.i= 1/SR.2*sum(ni*(Ri - (N+1)/2)^2) 
  return(KW.i)
})
p.value = mean(many.perms.KW > KW.OBS)
p.value    #p-value for the Krustal-Wallistest-statistic

# Question 3a average rank of per group
Group.order = aggregate(BPM ~ the_groups, data = workout, mean)$Group
Xi = aggregate(BPM ~ the_groups, data = workout, mean)$BPM
si = aggregate(BPM ~ the_groups, data = workout, sd)$BPM
Ri = aggregate(Rank ~ the_groups, data = workout, mean)$Rank
ni = aggregate(BPM ~ the_groups, data = workout, length)$BPM
results = rbind(Xi,si,Ri,ni)
rownames(results) = c("Group Mean","Group SD","Rank Mean","Sample Size")
colnames(results) = as.character(Group.order)
results
SR.2 = var(workout$Rank)
SR.2

# Question 3b differences in ranks
all.diff = as.numeric(dist(Ri,method = "manhattan"))
names(all.diff) = c("I vs II","I vs III","II vs III")
K = length(unique(workout$Groups))
alpha = 0.05
g = K*(K-1)/2
BON12 = qnorm(1-alpha/(2*g))*sqrt(SR.2*(1/ni[1] + 1/ni[2]))
BON13 = qnorm(1-alpha/(2*g))*sqrt(SR.2*(1/ni[1] + 1/ni[3]))
BON23 = qnorm(1-alpha/(2*g))*sqrt(SR.2*(1/ni[2] + 1/ni[3]))
all.BON = c(BON12, BON13, BON23)

HSD12 = qtukey(1-alpha,K,N-K)*sqrt((SR.2/2)*(1/ni[1] + 1/ni[2]))
HSD13 = qtukey(1-alpha,K,N-K)*sqrt((SR.2/2)*(1/ni[1] + 1/ni[3]))
HSD23 = qtukey(1-alpha,K,N-K)*sqrt((SR.2/2)*(1/ni[2] + 1/ni[3]))
all.HSD = c(HSD12,HSD13,HSD23)

all.crits = rbind(all.diff, all.BON,all.HSD)
all.crits

# Question 3c cutoffs
N = nrow(workout)
K = length(unique(workout$Groups))
SR.2 = var(workout$Rank)
g = K*(K-1)/2
alpha = 0.05
z.a = qnorm(1-alpha/(2*g))
t.a = qtukey(1-alpha,g, N-K)
BON = z.a *sqrt(SR.2*(1/10 + 1/10))
HSD = t.a*sqrt(SR.2/2*(1/10+1/10))
Values = matrix(c(BON,HSD),nrow = 1)
colnames(Values) = c("BON","HSD")
rownames(Values) = "Cutoffs"
Values

# Question 4
alpha =0.05
R = 3000
R.perms = sapply(1:R,function(i){
  permute.data =  workout
  permute.data$Groups = sample(permute.data$Groups,length(permute.data$Groups),replace = FALSE)
  Ri = round(aggregate(BPM ~ Groups, data = permute.data, mean)$BPM,2)
  all.Tij = all.diff = as.numeric(dist(Ri,method = "manhattan"))
  max.diff = max(all.Tij)
  return(max.diff)
})
tukey.cutoff = quantile(R.perms,1-0.05)
tukey.cutoff

# 4b
tukey.cutoff = quantile(R.perms,probs = 1-alpha)
split.groups = split(workout,workout$Groups) #Makes a list of K groups (in alphabetical order)
IvsII = rbind(split.groups[[1]],split.groups[[2]]) #Binds 1 and 2 back togeather
IvsIII = rbind(split.groups[[1]],split.groups[[3]]) #Binds 1 and 3 back togeather
IIvsIII = rbind(split.groups[[2]],split.groups[[3]]) #Binds 2 and 3 back togeather
the_groups = as.factor(IvsII$Groups)
the_BPM = as.numeric(IvsII$BPM)
wilcox_test(the_BPM ~ the_groups, data = IvsII, distribution = "exact")
the_groups = as.factor(IvsIII$Groups)
the_BPM = as.numeric(IvsIII$BPM)
the_groups = as.factor(IIvsIII$Groups)
the_BPM = as.numeric(IIvsIII$BPM)
pval12 = pvalue(wilcox_test(the_BPM ~ the_groups, data = IvsII, distribution = "exact"))
pval13 = pvalue(wilcox_test(the_BPM ~ the_groups, data = IvsIII, distribution = "exact"))
pval23 = pvalue(wilcox_test(the_BPM ~ the_groups, data = IIvsIII, distribution = "exact"))
pval12
pval13
pval23
# 4c
comp.names = c("A vs B", "A vs C", "B vs C")
all.pvalues = c(pval12,pval13,pval23)
names(all.pvalues) = comp.names
Xb = aggregate(BPM ~ Groups,workout, mean)$BPM
all.diff = as.numeric(dist(Xb,method = "manhattan"))
names(all.pvalues) = comp.names
Xb = aggregate(BPM ~ Groups,workout, mean)$BPM
all.diff = as.numeric(dist(Xb,method = "manhattan"))
names(all.diff) = comp.names
all.pvals = matrix(all.pvalues, nrow = 1)
rownames(all.pvals) = "WRS p-value"
colnames(all.pvals) = comp.names
all.diff = matrix(all.diff, nrow = 1)
rownames(all.diff) = "Pairwise Diff"
colnames(all.diff) = comp.names
all.diff

# 5a correlation
lungs <- read.csv("C:/Users/richa/Desktop/lungs.csv")
n = nrow(lungs)
rp = cor(lungs$Peak,lungs$Height,method = "pearson")
rs = cor(lungs$Peak,lungs$Height,method = "spearman")
rt = cor(lungs$Peak,lungs$Height,method = "kendall")
all.correlations = c(rp,rs,rt)
names(all.correlations) = c("Pearson","Spearman","Kendall")
all.correlations

# 5b Z-score
tp = rp*sqrt((n-2)/(1-rp^2)) #Pearson's asymptotic t
Zs = rs*sqrt(n-1) #Spearman's asymptotic Z
var.rt.noties = (4*n + 10)/( 9*(n^2-n))
si = table(lungs$Peak)[which(table(lungs$Peak)!= 1)] #Number of ties for X
ti = table(lungs$Height)[which(table(lungs$Height)!= 1)] #number of ties for Y
A = sum(si*(si-1)*(2*si+5))/18 
B = sum( si*(si-1)*(2*si-2))*sum(ti*(ti-1)*(ti-2))/(9*n*(n-1)*(n-2))
C = sum( si*(si-1))*sum(ti*(ti-1))/(2*n*(n-1))
var.rt.ties = var.rt.noties - (4/(n^2*(n-1)))*(A - B - C)
Zt = rt/sqrt(var.rt.ties)
all.Zs = c(tp,Zs,Zt)
names(all.Zs) = names(all.correlations)
all.Zs

# 5c p-value
lower.pval = c(pt(all.Zs[1],df = n-2,lower.tail = TRUE), pnorm(all.Zs[-1],lower.tail = TRUE))
upper.pval = c(pt(all.Zs[1],df = n-2,lower.tail = FALSE), pnorm(all.Zs[-1],lower.tail = FALSE))
two.pval = c(2*pt(abs(all.Zs[1]),df = n-2,lower.tail = FALSE), 2*pnorm(abs(all.Zs[-1]),lower.tail = FALSE))
all.pvals = rbind(lower.pval,upper.pval,two.pval)
all.pvals

# 6
library(MASS)
plot(lungs$Height,lungs$Peak,ylab = "Peak Flow",xlab = "Height in cm", main = "Trend for Peak Flow and Height",pch = 9)
slope.OBS = lm(Peak ~ Height,data = lungs)$coefficients[2]
slope.OBS

R = 2000
all.perm.slopes = sapply(1:R,function(i){
  the.data = lungs
  the.data$Height = sample(the.data$Height,nrow(the.data),replace = FALSE)
  slope.i = lm(Peak ~ Height,data = the.data)$coefficients[2]
  return(slope.i)
})

library(ggplot2)
all.perm.slopes <- data.frame(all.perm.slopes)
ggplot(all.perm.slopes, aes(x = all.perm.slopes)) + geom_histogram(binwidth = 2,color = "black",fill = "white")

lower.p = mean(all.perm.slopes < slope.OBS)
upper.p = mean(all.perm.slopes > slope.OBS)
two.p = mean(abs(all.perm.slopes) > abs(slope.OBS))
all.slope.pval = c(lower.p,upper.p,two.p)
names(all.slope.pval) = c("lower tail","upper tail","two-tailed")
all.slope.pval

#  7a
kids <- read.csv("C:/Users/richa/Desktop/kids.csv")
plot(kids$Age,kids$BP,ylab = "Diastolic Blood Pressure",xlab = "Age in years", main = "Trend for Diastolic Blood Pressure and Age", pch = 9)

# 7b cor & p-value
rs = cor(kids$Age,kids$BP,method = "spearman")
rt = cor(kids$Age,kids$BP,method = "kendall")
all.correlations = c(rs,rt)
names(all.correlations) = c("Spearman","Kendall")
all.correlations

var.rt.noties = (4*n + 10)/( 9*(n^2-n))
si = table(kids$Age)[which(table(kids$Age)!= 1)] 
ti = table(kids$BP)[which(table(kids$BP)!= 1)] 
A = sum(si*(si-1)*(2*si+5))/18 
B = sum( si*(si-1)*(2*si-2))*sum(ti*(ti-1)*(ti-2))/(9*n*(n-1)*(n-2))
C = sum( si*(si-1))*sum(ti*(ti-1))/(2*n*(n-1))
var.rt.ties = var.rt.noties - (4/(n^2*(n-1)))*(A - B - C)
Zt = rt/sqrt(var.rt.ties)
all.Zs = c(tp,Zs,Zt)
names(all.Zs) = names(all.correlations)
all.Zs
two.pval = c(2*pt(abs(all.Zs[1]),df = n-2,lower.tail = FALSE), 2*pnorm(abs(all.Zs[-1]),lower.tail = FALSE))
two.pval

# 7c
spearman.test = spearman_test(BP ~ Age, kids,alternative = "two.sided", exact=FALSE)
kendall.test = cor.test(kids$Age,kids$BP,method = "kendall",alternative = "two.sided", exact=FALSE)
r.pvals = c(pvalue(spearman.test),kendall.test$p.value)
names(r.pvals) = names(all.Zs)
r.pvals

results = rbind(all.correlations,all.Zs,two.pval, r.pvals)
colnames(results) = c("Spearman","Kendall")
rownames(results) = c("correlation","Z-score","p-value","r-pvalue")
results

