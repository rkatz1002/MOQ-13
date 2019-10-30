#Based on https://machinelearningmastery.com/time-series-prediction-lstm-recurrent-neural-networks-python-keras/

##Libraries used

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math
from keras.layers import Dense
from keras.layers import LSTM
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
import datetime

def main():

  ##Creating random number with seed

  np.random.seed(7)

  ##Load dataset

  mydateparser = lambda x: pd.datetime.strptime(x, "%Y%m%d")

  dataset = pd.read_csv(r'DESAFIO_ITA.csv',
    sep=";",
    dtype={
    'VOLUME':int 
    },
    usecols = ['DIA','VOLUME'],
    parse_dates=['DIA'],
    date_parser=mydateparser
  )

  dataset_grouped = dataset.groupby([(dataset.DIA.dt.year),(dataset.DIA.dt.month)]).agg('count')

  dataset = dataset_grouped
  
  ##Normalizing the data set, 
  ## important for the sigmoid or 
  ## tanh activation function

  scaler = MinMaxScaler(
    feature_range=(0,1)
  )

  dataset = scaler.fit_transform(dataset)

  ##splitting dadset into train sets and tests
  ##sets

  train_size = int(len(dataset)*2.0/3.0)
  test_size = len(dataset) - train_size
  train, test = dataset[0: train_size:], dataset[train_size:len(dataset),:]

  ##Function to convert array into matrix

  def create_dataset(dataset, lookback=1):
    dataX, dataY = [],[]
    t = len(dataset - look_back -1)
    for i in range(t):
      a = dataset[i:(i+look_back),0]
      dataX.append(a)
      dataY.append(dataset[i+look_back,0])
    return np.array(dataX), np.array(dataY)

  look_back = 1
  trainX, trainY

  trainX = np.reshape(trainX,(
    trainX.shape[0],
    1,
    trainX.shape[1])
  )

  testX = np.reshape(testX,(
    testX.shape[0],
    1,
    testX.shape[1])
  ) 

  ##Creating and fitting the LSTM network

  model = Sequential()
  model.add(LSTM(
    4,
    input_shape =(1, look_back)
  ))
  model.add(Dense(1))
  model.compile()
  model.fit(
    trainX,
    trainY,
    epchos=100,
    batch_size=1,
    verbose=2
  )

  ##Predictions

  trainPredict = model.predict(trainX)
  testPredict = model.predict(testX)

  ##Invert predictions

  trainPredict = scaler.inverse_transform(trainPredict)
  trainY = scaler.inverse_transformation([trainY])
  testPredict = scaler.inverse_transform(testPredict)
  testY = scaler.inverse_transform([testY])

  ##Calculate root mean squared error

  trainScore = math.sqrt(
    mean_squared_error(trainY[0],
    trainPredict[:,0],
  ))
  print('Train score: %.2f RMSE' % (trainScore))

  testScore = math.sqrt(
    mean_squared_error(trainY[0],
    testPredict[:,0],
  ))
  print('Train score: %.2f RMSE' % (testScore))

  #shift train predictions for plotting

  trainPredictPlot = np.empty_like(
    dataset
  )
  trainPredictPlot[:, :]= np.nan
  trainPredictPlot[look_back:len(trainPredict)+look_back, :]

  #shift test predictions for plotting

  testPredictPlot = np.empty_like(dataset)
  testPredictPlot[:, :]= np.nan
  testPredictPlot[len(trainPredict)+(2*look_back)-1:len(dataset)-1,:]= testPredict

  #ploting baseline and predictions

  plt.plot(scaler.inverse_transform(dataset))
  plt.plot(trainPredictPlot)
  plt.plot(testPredictPlot)
  plt.show()

main()