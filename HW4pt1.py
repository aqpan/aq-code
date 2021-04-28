#!coding:utf-8
openname="Sacramento-1880-2018.NOAA.csv"
with open(openname) as f:
    lines =f.readlines()
    for line in lines[5:]:
        print(line.rstrip())
