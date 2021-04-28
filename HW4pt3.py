#!coding:utf-8
from inputCheck import canBeInt
while True:
    inputs = input("Enter an integer between 0 and 60:")
    if canBeInt(inputs) and int(inputs)>=0 and int(inputs)<=60:
        break
openname="Sacramento-1880-2018.NOAA.csv"
savename="tempAnomaly.txt"
tempList=[]
yearLists=[]
with open(openname) as f:
    lines =f.readlines()
    for line in lines[5:]:
        temp = line.split(",")
        yearLists.append(temp[0])
        tempList.append(float(temp[1]))
        print("%s"%temp[0],end="")
        print(" {:.4f}".format(float(temp[1])))
with open(savename,'w') as s:
    for i in range(len(tempList)):
        key="%s %.4f\n"%(yearLists[i],tempList[i])
        s.write(key)
