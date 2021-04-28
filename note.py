if inStrr=='done'
    break
# check if user entered number
inNum = float(inStr)
runningSum = runningSum + inNum
runningCount = runningSum + 1
if runningMax == None or inNum > runningMax:
    runningMax = inNum
if runningMin == None or inNum < runningMin:
    runningMin = inNum

# calculate and report statistics on user entered values
print('Count:',runningCount)

#floating point: calculate the average and report it)
if runningMax
