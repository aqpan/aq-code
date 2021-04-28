#!/usr/bin/env python
# coding: utf-8

# In[3]:


##Data tree Below
import pandas as pd
from sklearn import preprocessing
from sklearn import tree
from sklearn.datasets import load_iris


# In[4]:


iris = load_iris()


# In[5]:


dir(iris)


# In[6]:


clf = tree.DecisionTreeClassifier(max_depth = 4)
clf = clf.fit(iris.data, iris.target)


# In[7]:


clf


# In[8]:


import pydotplus
from IPython.display import Image, display


# In[9]:


dot_data = tree.export_graphviz(clf,
                                out_file = None,
                                feature_names = iris.feature_names,
                                class_names = iris.target_names,
                                filled = True,
                                rounded = True
                               )


# In[10]:


graph = pydotplus.graph_from_dot_data(dot_data)
display(Image(graph.create_png()))


# In[11]:


clf.predict(iris.data)


# In[12]:


import numpy as np
al = np.array([6.6, 2.5, 4.3, 1.3])


# In[13]:


clf.predict(al.reshape(1,-1))


# In[14]:


from matplotlib import pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
from matplotlib.colors import ListedColormap

x = iris.data[:,2:4]
y = iris.target
x_min, x_max = x[:,0].min() - .5,x[:,0].max() + .5
y_min, y_max = x[:,1].min() - .5,x[:,1].max() + .5

cmap_light = ListedColormap (['#AAAAFF','#AAFFAA','#FFAAAA'])
h = .02
xx,yy = np.meshgrid(np.arange(x_min,x_max),np.arange(y_min,y_max,h))
clf = tree.DecisionTreeClassifier(max_depth = 4)
clf = clf.fit(x,y)
Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)

plt.figure()
plt.pcolormesh(xx, yy, Z, cmap = cmap_light)

plt.scatter(x[:,0], x[:,1], c=y)

plt.xlim(xx.min(), xx.max())
plt.ylim(yy.min(), yy.max())
plt.show()

                    


# In[15]:


###KNN Below


# In[25]:


import numpy as np
from matplotlib import pyplot as plt
from sklearn import neighbors, datasets
from matplotlib.colors import ListedColormap


# In[28]:


cmap_light = ListedColormap(['#FFAAAA', '#AAFFAA', '#AAAAFF'])
cmap_bold = ListedColormap(['#FF0000', '#00FF00', '#0000FF'])

iris = datasets.load_iris()
X = iris.data[:, :2] 

y = iris.target

knn = neighbors.KNeighborsClassifier(n_neighbors=1) #only 1 neighbor
knn.fit(X, y)

x_min, x_max = X[:, 0].min() - .1, X[:, 0].max() + .1
y_min, y_max = X[:, 1].min() - .1, X[:, 1].max() + .1
xx, yy = np.meshgrid(np.linspace(x_min, x_max, 100),
                        np.linspace(y_min, y_max, 100))
Z = knn.predict(np.c_[xx.ravel(), yy.ravel()])


# In[29]:


Z = Z.reshape(xx.shape)
plt.figure()
plt.pcolormesh(xx, yy, Z, cmap=cmap_light)

plt.scatter(X[:, 0], X[:, 1], c=y, cmap=cmap_bold)
plt.xlabel('sepal length (cm)')
plt.ylabel('sepal width (cm)')
plt.axis('tight')


# In[30]:


knn = neighbors.KNeighborsClassifier(n_neighbors=3) #3 Neighbors
knn.fit(X, y)

Z = knn.predict(np.c_[xx.ravel(), yy.ravel()])

Z = Z.reshape(xx.shape)
plt.figure()
plt.pcolormesh(xx, yy, Z, cmap=cmap_light)

plt.scatter(X[:, 0], X[:, 1], c=y, cmap=cmap_bold)
plt.xlabel('sepal length (cm)')
plt.ylabel('sepal width (cm)')
plt.axis('tight')

plt.show()

