#!/usr/bin/env python
# coding: utf-8

# In[4]:


import numpy as np
import pandas as pd
from sklearn.tree import DecisionTreeRegressor
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
plt.style.use('bmh')


# In[5]:


df = pd.read_csv('all_stocks_5yr.csv')
df.head(10)


# In[31]:


df = df.loc[0:1259]
plt.figure(figsize=(16,9))
plt.title('AAL', fontsize = 18)
plt.xlabel('Days', fontsize= 18)
plt.ylabel('Close Price USD ($)', fontsize = 18)
plt.plot(df['close'])
plt.show()


# In[32]:


df = df[['close']]


# In[33]:


#Create a variable to predict 'x' days out into the future
future_days = 200
#Create a new column (the target or dependent variable) shifted 'x' units/days up
df['Prediction'] = df[['close']].shift(-future_days)


# In[34]:


X = np.array(df.drop(['Prediction'], 1))[:-future_days]


# In[35]:


y = np.array(df['Prediction'])[:-future_days]


# In[36]:


x_train, x_test, y_train, y_test = train_test_split(X, y, test_size = 0.2)


# In[37]:


#Create the decision tree regressor model
tree = DecisionTreeRegressor().fit(x_train, y_train)
#Create the linear regression model
lr = LinearRegression().fit(x_train, y_train)


# In[38]:


#Get the feature data, 
#AKA all the rows from the original data set except the last 'x' days
x_future = df.drop(['Prediction'], 1)[:-future_days]
#Get the last 'x' rows
x_future = x_future.tail(future_days) 
#Convert the data set into a numpy array
x_future = np.array(x_future)
x_future


# In[39]:


#Show the model tree prediction
tree_prediction = tree.predict(x_future)
#Show the model linear regression prediction
lr_prediction = lr.predict(x_future)


# In[40]:


#Visualize the data
predictions = tree_prediction
#Plot the data
valid =  df[X.shape[0]:]
valid['Predictions'] = predictions #Create a new column called 'Predictions' that will hold the predicted prices
plt.figure(figsize=(16,8))
plt.title('Model')
plt.xlabel('Days',fontsize=18)
plt.ylabel('Close Price USD ($)',fontsize=18)
plt.plot(df['close'])
plt.plot(valid[['close','Predictions']])
plt.legend(['Train', 'Val', 'Prediction' ], loc='lower right')
plt.show()


# In[41]:


#Visualize the data
predictions = lr_prediction
#Plot the data
valid =  df[X.shape[0]:]
valid['Predictions'] = predictions #Create a new column called 'Predictions' that will hold the predicted prices
plt.figure(figsize=(16,8))
plt.title('Model')
plt.xlabel('Days',fontsize=18)
plt.ylabel('Close Price USD ($)',fontsize=18)
plt.plot(df['close'])
plt.plot(valid[['close','Predictions']])
plt.legend(['Train', 'Val', 'Prediction' ], loc='lower right')
plt.show()


# In[ ]:





# In[ ]:




