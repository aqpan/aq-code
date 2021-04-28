# quiz_part1.py
# Anqi Pan
# ECS32A Fall 2018
#
# if,else function for multiple choice questions

x=0
print("ART AND LITERATURE: Who painted the Mona Lisa?")
print("a. Vincent van Gogh")
print("b. Michelangelo")
print("c. Leonardo da Vinci")
answer=input('Enter your choice:')
if answer== "C" or answer=="c":
    print("Correct!")
    x +=1
else:
    print("The correct answer was c")

    
print("ART AND LITERATURE: What did the 7 dwarves do for a job?")
print("a. construction workers")
print("b. miners")
print("c. fishers")
answer=input('Enter your choice:')
if answer== "B" or answer=="b":
    print("Correct!")
    x +=1
else:
    print("The correct answer was b")


print('ENTERTAINMENT: Who sang "My Way"?')
print("a. Gordon Jenkins")
print("b. Louis Armstrong")
print("c. Frank Sinatra")
answer=input('Enter your choice:')
if answer== "C" or answer=="c":
    print("Correct!")
    x +=1
else:
    print("The correct answer was c")

    
print("ENTERTAINMENT: How many oscars did Alfred Hitchcock win?")
print("a. 0")
print("b. 1")
print("c. 2")
answer=input('Enter your choice:')
if answer== "A" or answer=="a":
    print("Correct!")
    x +=1
else:
    print("The correct answer was a")


print("GEOGRAPHY: Which is the largest ocean?")
print("a. Pacific")
print("b. Atlantic")
print("c. Indian")
answer=input('Enter your choice:')
if answer== "A" or answer=="a":
    print("Correct!")
    x +=1
else:
    print("The correct answer was a")


print("GEOGRAPHY: Which river goes through London?")
print("a. River Severn")
print("b. River Tyne")
print("c. River Thames")
answer=input('Enter your choice:')
if answer== "C" or answer=="c":
    print("Correct!")
    x +=1
else:
    print("The correct answer was c")


print("HISTORY: What year did the Spanish Civil War end?")
print("a. 1937")
print("b. 1939")
print("c. 1945")
answer=input('Enter your choice:')
if answer== "B" or answer=="b":
    print("Correct!")
    x +=1
else:
    print("The correct answer was b")


print("HISTORY: Who was the first president of America?")
print("a. Washington")
print("b. Lincoln")
print("c. Jefferson")
answer=input('Enter your choice:')
if answer== "a" or answer=="A":
    print("Correct!")
    x +=1
else:
    print("The correct answer was a")


print("SCIENCE AND NATURE: Who invented the telephone?")
print("a. Bell")
print("b. Edison")
print("c. Tesla")
answer=input('Enter your choice:')
if answer== "a" or answer=="A":
    print("Correct!")
    x +=1
else:
    print("The correct answer was a")


print("SCIENCE AND NATURE: Where is the smallest bone in the body?")
print("a. Ear")
print("b. Nose")
print("c. Finger")
answer=input('Enter your choice:')
if answer== "a" or answer=="A":
    print("Correct!")
    x +=1
else:
    print("The correct answer was a")


print("SPORT AND LEISURE: What is the first letter on a typewriter?")
print("a. Z")
print("b. A")
print("c. Q")
answer=input('Enter your choice:')
if answer== "C" or answer=="c":
    print("Correct!")
    x +=1
else:
    print("The correct answer was c")


print("SPORT AND LEISURE: How many months have 31 days?")
print("a. 5")
print("b. 6")
print("c. 7")
answer=input('Enter your choice:')
if answer== "C" or answer=="c":
    print("Correct!")
    x +=1
else:
    print("The correct answer was c")
    
print("Your final score is {} out of 12".format(x))
      
