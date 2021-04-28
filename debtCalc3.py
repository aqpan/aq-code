# debtCalc3.py
# Anqi Pan
# ECS32A Fall 2018
#
#part3:handle two exceptions

#debt_amount or debt_amountf: total debt
debt_amount= input('Enter amount of debt:')
#interest or interestf: yearly interest rate
interest= input('Enter % interest rate:')
#payment or paymentf: monthly payment
payment = input('Enter monthly payment:')

try:
    debt_amountf=float(debt_amount)
    interestf=float(interest)
    paymentf=float(payment)
    month=1
    # payments= total payments
    payments=0
    if debt_amountf*interestf/1200<paymentf:
        while debt_amountf >0:
            interest=debt_amountf*interestf/1200
            debt_amountf=debt_amountf+interest-paymentf
            if debt_amountf<=0:
                payments=month*paymentf+debt_amountf
                debt_amountf=0
            else:
                payments=month*paymentf
            print('Month = %d'%(month))
            print('Interest this month = {0:.2f}'.format(interest))
            print('Balance going forward = {0:.2f}'.format(debt_amountf))
            print('Total payments = {0:.2f}'.format(payments))
            month+=1
    else:
        print('You will need to make bigger payments.\nAt this rate you will never pay off the debt.')
except ValueError:
    print('Bad input, enter a number next time.')

exit('Press enter to exit')
