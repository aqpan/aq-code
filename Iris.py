#!/usr/bin/env python
# coding: utf-8

# In[3]:


import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from sklearn.datasets import load_breast_cancer
from sklearn.metrics import confusion_matrix
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
get_ipython().run_line_magic('matplotlib', 'inline')
plt.style.use({'figure.figsize':(10,8)})


# In[4]:


import seaborn as sns
sns.set_style("whitegrid")
df = sns.load_dataset("iris")


# In[5]:


df


# In[6]:


df.info()


# In[7]:


df.describe()


# In[8]:


df.plot(kind='hist')


# In[10]:


df.hist(bins = 20)


# In[11]:


df['species'].unique()


# In[12]:


df.plot.area(stacked = False)


# In[13]:


sns.pairplot(df, hue = "species",height = 3)


# In[15]:


df.plot(kind = 'kde')


# In[26]:


setosa = df.loc[df.species == "setosa"]
versocolor = df.loc[df.species == "versocolor"]
virginica = df.loc[df.species == "virginica"]

ax = sns.kdeplot(setosa.sepal_width, setosa.sepal_length, cmap = "Reds", shade = True, shade_lowest = False)
ax = sns.kdeplot(virginica.sepal_width, virginica.sepal_length, cmap = "Blues", shade = True, shade_lowest = False)


# In[28]:


df.corr()


# In[32]:


sns.heatmap(df.corr(), annot = True, cmap = "YlGnBu")


# In[33]:


df.plot(kind = 'box')


# In[36]:


sns.boxplot (y = df['petal_length'], x = df['species'])


# In[42]:


sns.boxplot (y = df['petal_length'], x = df['species'])


# In[44]:


fig, axes = plt.subplots (1,2,figsize = (15, 8))
sns.boxplot(x = "species", y = "sepal_length", data = df, palette = "Pastel1", ax = axes[0])
sns.boxplot(x = "species", y = "sepal_width", data = df, palette = "Pastel1", ax = axes[1])


# In[46]:


df.plot(kind = 'box', subplots = True, layout = (2,2), sharex = False, figsize = (18,5))


# In[ ]:




