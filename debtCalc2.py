# debtCalc2.py
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

month=1
# payments= total payments
payments=0
while debt_amount >0:
    Interest=debt_amount*interest/1200
    debt_amount=debt_amount+Interest-payment
    if debt_amount<=0:
        payments=month*payment+debt_amount
        debt_amount=0
    else:
        payments=month*payment
    print('Month = %d'%(month))
    print('Interest this month = {0:.2f}'.format(Interest))
    print('Balance going forward = {0:.2f}'.format(debt_amount))
    print('Total payments = {0:.2f}'.format(payments))
    month+=1

exit('Press enter to exit')
