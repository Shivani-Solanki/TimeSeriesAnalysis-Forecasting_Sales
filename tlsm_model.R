# To import data 
dataset<- read.csv('C:/Users/solan/Downloads/total-business-inventories-to-sales-ratio.csv') 
# converting into time series 
data <- ts(dataset[,2],start= c(1992,1),frequency=12) 
#to decompose data 
dec<- decompose(data) 
plot(dec) 
#split data into trainset and test set 
trainset <- ts(dataset[,2],start= c(1992,1), end= c(2015,12),frequency=12) 
test<- ts(dataset[,2],start= c(2016,1), end= c(2018,12),frequency=12) 
# create a data frame to use tslm function 
df_ts<- data.frame(value=trainset, as.numeric(time(trainset))) 
# to build tlsm model 
tslmmodel <- tslm(value~season+trend,df_ts) 
# to see linear relationship 
plot(dataset[,2], pch=16) 
abline(mymodel) 
#forecasting 
tslm_fc <- forecast(tslmmodel,h=36) 
autoplot(data) + autolayer(tslmmodel$fitted.values) + autolayer(tslm_fc) 
par(mfrow=c(1,2)) 
#plotting ACF and PCF 
acf(ts(tslmmodel$residuals),main='ACF Residual') 
pacf(ts(tslmmodel$residuals),main='ACF Residual') 
# Calculating RMSE 
rmse(tslm_fc$fitted,data)
