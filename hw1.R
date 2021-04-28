dbinom(57,100,0.0)
dbinom(57,100,0.1)
dbinom(57,100,0.2)
dbinom(57,100,0.3)
dbinom(57,100,0.4)
dbinom(57,100,0.5)
dbinom(57,100,0.6)
dbinom(57,100,0.7)
dbinom(57,100,0.8)
dbinom(57,100,0.9)
dbinom(57,100,1.0)
theta = seq(0,1,by=0.1)
prob = (choose(100,57)*(theta)^57*(1-theta)^43)
prob
plot(theta,prob,type="h", ylab="Prob(y=57|theta, n=100)")

#Q3.1 c
prior= rep(1/11,11)
post= (theta)^(57)*(1-theta)^(43)*(1/11)
posterior=post/sum(post)
plot(theta,posterior,type="h", ylab="Prob(θ|y)" , main = "Posterior Distribution as a function of θ")

#Q3.1 d
theta2=seq(0,1,length=100)
prior= 1
posterior2= (choose(100,57))*(theta2)^(57)*(1-theta2)^(43)*(1)
plot(theta2,posterior2,type="l", ylab="Posterior density", main = "Posterior Density as a function of θ")

#Q3.1 e
posterior3= dbeta(theta2,58,44)
plot(theta2,posterior3,type="l", ylab="Posterior Density", main = "Posterior Density of θ")
theta2[posterior3==max(posterior3)]
