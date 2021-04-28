# debtCalc1.py
# Anqi Pan
# ECS32A Fall 2018
#
# compute the interest owed for after one month
# the payment made for one month
# and the balance going forward into the second month.

#debt_amount: total debt
debt_amount= float(input('Enter amount of debt:'))
#interest: yearly interest rate
interest= float(input('Enter % interest rate:'))
#payment: monthly payment
payment = float(input('Enter monthly payment:'))
print('Month = 1')
print('Interest this month = {0:.2f}'.format(debt_amount*interest/1200))
print('Balance going forward = {0:.2f}'.format(debt_amount*interest/1200-payment+debt_amount))
print('Total payments = {0:.2f}'.format(payment))

exit('Press enter to exit')
