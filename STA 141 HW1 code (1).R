#STA 14113
#Anqi Pan


#input files
a <- read.table("c:/users/richa/Desktop/indiv_header_file.csv", sep	= ",", header = TRUE, stringsAsFactors = FALSE)

my_data <- read.table("G:/iNvID/itcont.txt", sep ="|", quote = "", comment.char = "", nrows = 5000000, 
                      colClasses = c(rep("character", 14), "numeric", "character", "character", "numeric", "character", "character", "numeric"))
names(my_data) = names(a)
library(lubridate)
c = mdy(my_data$TRANSACTION_DT)

#plot attributes of contribution per time
plot(table(c),xlab = "Date", main="contribution by Date", ylab = "contributions")
#plot number of contribution per state
plot(table(my_data$STATE), xlab = "states", main="number of attribution per states", ylab = "number of afftribution")

st = as.data.frame(table(my_data$STATE))
names(st)[1] <- "STATE"
ggplot(st, aes(x= STATE, y= Freq)) +
  geom_bar(stat = "identity") + ggtitle("number of attribution per states")

#loop method for ploting percapitas
population <- read.table("c:/users/richa/Desktop/population.csv", sep = ",", header = TRUE)
g = as.numeric(gsub(",","",population$Population,fixed=TRUE))
list = list()
state = 1
count = 0
countstate = 0
name = 1
countstates.function <- function(count){
  for (i in 1:length(my_data$STATE)) {
    if (my_data$STATE[i] == population[count,1]){
      countstate = countstate + 1
	 }
 }
 print(countstate)
}
for (n in 1:length(population$ï..STATE)) {
	list = append(list, countstates.function(n), after = n)
}
list = as.numeric(list)
percapita = list/g
library(ggplot2)
cagraph <- data.frame(
 states=c(population$ï..STATE) ,
 percapitas=c(percapita)
)
ggplot(cagraph, aes(x= states, y= percapitas)) +
	geom_bar(stat = "identity") + ggtitle("Loop method for percapita")


#merge method of percapitas
population2 <- read.table("c:/users/richa/Desktop/population.csv", sep = ",", header = TRUE)
states = as.data.frame(table(my_data$STATE))
population2 = as.data.frame(population2)
names(states)[1] <- "STATES"
names(population2)[1] <- "STATES"
all <- merge(states, population2, by = "STATES")
freg = as.numeric(gsub(",","",all$Freq, fixed=TRUE))
pop = as.numeric(gsub(",","",all$Population, fixed=TRUE))
all$percap = freg/pop


ggplot(percaps, aes(x= all$STATES, y= all$percap)) +
	geom_bar(stat = "identity") + ggtitle("merge method for percapita")
