import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm
from statsmodels.tsa.stattools import adfuller


def testStationarity(data):
    adftest = adfuller(data)
    result = pd.Series(adftest[0:4], index=['Test Statistic','p-value',
                       'Lags Used','Number of Observations Used']) 
    for key,value in adftest[4].items():
        result['Critical Value (%s)'%key] = value
    return result   

#%% Pair Trading Strategy
def PairTradeStrategy(data):
    #Calculate the Cointegration coefficient
    x = np.log(data.iloc[IS,0]).values
    y = np.log(data.iloc[IS,1]).values
    x = sm.add_constant(x)
    model = sm.OLS(y,x)
    results = model.fit()
    if len(results.params)<=1:
        Coef = results.params[0]
    else:
        Coef = results.params[1]
    
    #Calculate the arbitrage based on cointegration coefficient
    A = 3
    B = 2
    spread = (np.log(data.iloc[IS,0])-Coef*np.log(data.iloc[IS,1]))
    data['spread'] = spread
    UPS = spread.mean() + A*spread.std()
    UPB = spread.mean() + B*spread.std()
    MID = spread.mean()
    DWB = spread.mean() - B*spread.std()
    DWS = spread.mean() - A*spread.std()
    s1 = pd.Series(MID,index=data.index)
    s2 = pd.Series(UPB,index=data.index)
    s3 = pd.Series(DWB,index=data.index)
    data3 = pd.concat([spread,s1,s2,s3],axis=1)
    data3.columns = ['spreadprice','mean','upper','down']
    
    #Find pairs based on signals
    OSSpread = (np.log(data.iloc[OS,0])-Coef*np.log(data.iloc[OS,1]))
    Signal = pd.Series(index=OSSpread.index,data=0)
    for t in range(1,len(OSSpread)-1):
        if (Signal[t]!=-1) &((OSSpread[t-1]>UPB) & (OSSpread[t]<UPB)):
            Signal[t+1] = -1
        elif (Signal[t]==-1) & (OSSpread[t]<MID):
            Signal[t+1] = 0
        elif (Signal[t]==-1) & (OSSpread[t]>UPS):
            Signal[t+1] = 0
        elif (Signal[t]!=1) &((OSSpread[t-1]<DWB) & (OSSpread[t]>DWB)):
            Signal[t+1] = 1
        elif (Signal[t]==1) & (OSSpread[t]>MID):
            Signal[t+1] = 0
        elif (Signal[t]==1) & (OSSpread[t]<DWS):
            Signal[t+1] = 0
        else:
            Signal[t+1] = Signal[t]
    data['Signal'] = Signal
    
    #Transaction cost
    cost1 = pd.Series(index=Signal.index,data=0.0)
    cost2 = pd.Series(index=Signal.index,data=0.0)
    trade = Signal[Signal!=Signal.shift(1)].index
    cost1[trade[1:]] = (0.002+0.00696)/100
    cost2[trade[1:]] = (0.002+0.00696)/100*Coef
    cost1[((Signal.shift(1)==1)|(Signal.shift(1)==-1))&(Signal==0)]=0.001
    cost2[((Signal.shift(1)==1)|(Signal.shift(1)==-1))&(Signal==0)]=0.001*Coef
    
    #Pair trading returns
    spreadret = OSSpread.diff()
    spreadret[0] = 0
    PortfolioRet = spreadret*Signal-cost1-cost2
    

    PortfolioRet = PortfolioRet/(1+abs(Coef))
    
    return PortfolioRet,Signal

#%% Extract data
Year = 2012
xlsname = 'data/data'+str(Year)+'.xlsx'       
AllPrice = pd.read_excel(xlsname,index_col=0)
IS = AllPrice.index<str(Year+1)
OS = AllPrice.index>=str(Year+1)
Corr = np.log(AllPrice).corr()

#%% Find pairs to invest
pairlist = []
Pair = pd.DataFrame(columns=['X','Y','Mean Spread'])
for i in Corr.columns:
    if i not in pairlist:
        #delete NaN
        iCorr = Corr[i].dropna()
        if len(iCorr)<5:
            continue
        #Delete the duplicated pairs
        NotPair = list(set(iCorr.index).difference(pairlist))
        Rank = iCorr[NotPair].rank()
        j = Rank.index[Rank==len(Rank)-1][0]
        # delete Cor<0.7
        if iCorr[j]<0.7:
            continue
        x = np.log(AllPrice.loc[IS,i]).values
        y = np.log(AllPrice.loc[IS,j]).values
        x = sm.add_constant(x)
        model = sm.OLS(y,x)
        results = model.fit()
        if len(results.params)<=1:
            continue
        Coef = results.params[1]
        spread = (np.log(AllPrice.loc[IS,i])-Coef*np.log(AllPrice.loc[IS,j]))
        #ADF
        result = testStationarity(spread)
        if result['p-value']>0.01:
            continue
        Pair = Pair.append({'X':i,'Y':j,'Mean Spread':np.mean(spread)},ignore_index=True)
        pairlist.append(i)
        pairlist.append(j)
# Find the 20 pairs with the higest Spread Mean
Pair = Pair[Pair['Mean Spread'].rank()>len(Pair)-20] 
       
#%% Paired and trade
AllPortfolio = pd.DataFrame()
for i in Pair.index:
    data = AllPrice.loc[:,[Pair.loc[i,'X'],Pair.loc[i,'Y'],]]
    PortfolioRet,Signal = PairTradeStrategy(data)
    if sum(abs(Signal))>0:
        AllPortfolio[Pair.loc[i,'X']+'-'+Pair.loc[i,'Y']] = PortfolioRet

#%% Distribute Fund
N = len(AllPortfolio.columns)
if N<5:
    Money = 80000
elif N<10:
    Money = 60000
elif N<15:
    Money = 50000
elif N<20:
    Money = 40000
else:
    Money = 1000000/N
    
Portfolio = Money*AllPortfolio    
Return = Portfolio.T.sum()
plt.figure(figsize=(10,7))
plt.plot(Return.cumsum())
plt.xlabel('date')
plt.ylabel('porfolio')
plt.title('Pair Trading Portfolio Pnl(Year='+str(Year)+')')
plt.savefig('result/result'+str(Year)+'.pdf')


Excel = pd.ExcelWriter('result/result'+str(Year)+'.xlsx')
Pair.to_excel(Excel,sheet_name='Pair')
AllPortfolio.to_excel(Excel,sheet_name='dailyret')
Return.to_excel(Excel,sheet_name='porfolio')
Excel.save()