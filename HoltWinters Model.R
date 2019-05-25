HW1<- HoltWinters(trainset, seasonal='multiplicative') 
HW1 
#forecasting 
HW1.pred<- predict(HW1,36, prediction.interval = TRUE) 
# plotting actual data, predicted data and trainset 
plot(data,xlim=c(1992,2018),ylim=c(1,2),xlab = 'Year',ylab = 'Inventory to sales ratio') 
lines(HW1$fitted[,1], col='red') 
lines(HW1.pred[,1], col='blue') 
lines(HW1.pred[,2], col='green') 
lines(HW1.pred[,3], col='orange') 
# Calculating RMSE 
rmse(HW1.pred[,1],data)
