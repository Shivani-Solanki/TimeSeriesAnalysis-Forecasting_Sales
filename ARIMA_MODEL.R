# 1st order differencing 
plot(diff(trainset),ylab='single Differenced ratio') 
# 2nd order differencing 
plot(diff(diff((trainset))),ylab='double Differenced ratio') 
#applying log 
plot((log10(trainset)),ylab='log') 
#2nd order differencing on log series 
plot(diff(diff((log10(trainset)))),ylab='double Differenced of log series') 
require(forecast) 
#ARIMA model 
ARIMAfit = auto.arima(log10(trainset)) 
summary(ARIMAfit) 
#forecasting 
pred = predict(ARIMAfit, n.ahead = 24) 
pred 
par(mfrow = c(1,1)) 
# plotting actual data, predicted data and the error range 
plot(data,type='l',xlim=c(1992,2018),ylim=c(1,2),xlab = 'Year',ylab = 'Inventory to sales ratio') 
lines(10^(pred$pred),col='blue') 
lines(10^(pred$pred+2*pred$se),col='orange') 
lines(10^(pred$pred-2*pred$se),col='orange') 
par(mfrow=c(1,2)) 
#plotting ACF and PACF 
acf(ts(ARIMAfit$residuals),main='ACF Residual') 
pacf(ts(ARIMAfit$residuals),main='PACF Residual') 
#calculating RMSE 
rmse(test,pred$pred)
