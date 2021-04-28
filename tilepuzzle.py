import copy

p = [[2,8,3],[1,0,4],[7,6,5]]
q = [[1,2,3],[8,0,4],[7,6,5]]

x = [[0,1,2],[3,4,5],[6,7,8]]
y = [[8,7,6],[5,4,3],[2,1,0]]


#A test case

#tilepuzzle(p,q)

#returns
# [[[2, 8, 3], [1, 0, 4], [7, 6, 5]],
#  [[2, 0, 3], [1, 8, 4], [7, 6, 5]],
#  [[0, 2, 3], [1, 8, 4], [7, 6, 5]],
#  [[1, 2, 3], [0, 8, 4], [7, 6, 5]],
#  [[1, 2, 3], [8, 0, 4], [7, 6, 5]]]

def tilepuzzle(start, goal):
    return reverse(statesearch([start], goal, []))

def statesearch(unexplored, goal, path):
    if unexplored == [] or len(path) > 25:  
    #if we are doing more complex puzzle solving, adjust 5 to a larger number to solve those puzzles 
        return []
    elif goal == head(unexplored):
        return cons(goal, path)
    elif len(path) > 1 and head(unexplored) == path[1]: #check for recursion
        return statesearch(tail(unexplored), 
                            goal, 
                            path)
    else:
        result = statesearch(generateNewStates(head(unexplored)), 
                              goal, 
                              cons(head(unexplored), path))
        if result != []:
            return result
        else:
            return statesearch(tail(unexplored), 
                                goal, 
                                path)

# 0 movement functions
def findzero(target):
    for i,lists in enumerate(target):
        for j,n in enumerate(lists):
            if n == 0:
                return [i, j]
    return (None, None)
        
def move_up(currState):
    result = copy.deepcopy(currState)
    if findzero(result)[0] == 0:
        return result
    else:
        x = findzero(result)[0]
        y = findzero(result)[1]
        p = result[x - 1][y]
        result[x - 1][y] = 0
        result[x][y] = p
        return result

def move_left(currState):
    result = copy.deepcopy(currState)
    if findzero(result)[1] == 0:
        return result
    else:
        x = findzero(result)[0]
        y = findzero(result)[1]
        p = result[x][y-1]
        result[x][y-1] = 0
        result[x][y] = p
        return result

def move_down(currState):
    result = copy.deepcopy(currState)
    if findzero(result)[0] == len(result) - 1:
        return result
    else:
        x = findzero(result)[0]
        y = findzero(result)[1]
        p = result[x + 1][y]
        result[x + 1][y] = 0
        result[x][y] = p
        return result

def move_right(currState):
    result = copy.deepcopy(currState)
    x = findzero(result)[0]
    y = findzero(result)[1]
    if findzero(result)[1] == len(result[y]) - 1:
        return result
    else:
        p = result[x][y + 1]
        result[x ][y+ 1] = 0
        result[x][y] = p
        return result

    
def generateNewStates(currState):
    newState = [move_left(currState),move_right(currState),move_up(currState),move_down(currState)]
    if currState in newState:
        newState = remove_items(newState, currState)
    return newState


def remove_items(lists, target):
    result = [i for i in lists if i != target]
    return result

def reverse(st):
    return st[::-1]
    
def head(lst):
    return lst[0]

def tail(lst):
    return lst[1:]

def take(n,lst):
    return lst[0:n]

def drop(n,lst):
    return lst[n:]

def cons(item,lst):
    return [item] + lst


