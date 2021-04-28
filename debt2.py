# program.py
# Anqi Pan
# ECS32A Fall 2018


debt_amount= int(input('Enter amount of debt:'))
interest= int(input('Enter % interest rate:'))
interest = interest/1200
payment = int(input('Enter monthly payment:'))
month=0
debt_amount = debt_amount - payment
balance = float(debt_amount)

while float(balance) > 0:
    month += 1
    interest = debt_amount * interest
    payment = 300 * month
    balance = balance + interest - payment

    print('Month = ', month)
    print('Interest this month = {0:.2f}'.format(interest))
    print('Balance going forward = {0:.2f}'.format(debt_amount))
    print('Total payments = {0:.2f}'.format(payment))

exit('Press enter to exit')
