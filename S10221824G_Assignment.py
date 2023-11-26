import random

#print main menu of the game
def menu():
    print('1. Start new game\n2. Load saved game\n3. Show high scores')
    print('\n0. Exit')
    choice =input('Your choice? ')
    while True:
        if choice != '1' and choice != '2' and choice != '0' and choice != '3':
            print('Please enter a valid number')
            print()
            print('1. Start new game\n2. Load saved game\n3. Show high scores')
            print('\n0. Exit')
            choice =input('Your choice? ')
        else:
            return choice
#Map
map = [ [' ', ' ', ' ', ' '],\
        [' ', ' ', ' ', ' '],\
        [' ', ' ', ' ', ' '],\
        [' ', ' ', ' ', ' ']\
        ]
column = '+-----' * len(map[0])

#layout of the buildings on the map
def maplayout():
    BCHlist = []
    FAClist = []
    HSElist = []
    SHPlist = []
    HWYlist = []
    #Finding the remaining number of buildings left respectively
    for i in buildings:
        if i == 'BCH':
            BCHlist.append(i)
        elif i == 'FAC':
            FAClist.append(i)
        elif i == 'HSE':
            HSElist.append(i)
        elif i == 'SHP':
            SHPlist.append(i)
        else:
            HWYlist.append(i)
    buildingsdict = {'build1':'HSE', 'build11':'FAC', 'build111':'SHP', 'build1111':'HWY', 'build11111':'BCH'}
    remainingdict = {'build1':len(HSElist), 'build11':len(FAClist), 'build111':len(SHPlist), 'build1111':len(HWYlist), 'build11111':len(BCHlist)}
    num = 'build1'
    a = 1
    #printing the map with the remaining buildings on the right
    print('{:>5s}{:>6s}{:>6s}{:>6s}{:>30s}{:<13s}{}'.format('A','B','C','D', '', 'Building', 'Remaining'))
    print(' {}+{:>27s}{:<13s}{}'.format(column, '', '--------', '---------'))
    for row in map:
        if num != 'build11111':
            if a != 1:
                print(' {}+{:>27s}{:<13s}{}'.format(column, '', buildingsdict[num], remainingdict[num]))
                num += '1'
            print(a,end = '')
            for element in row:
                if len(element) == 3:
                    print('| ' + element + ' ',end = '')
                else:
                    print('|   ' + element + ' ' ,end='')
            a += 1
            print('|', end = '')
            print('{:>27s}{:<13s}{}'.format('', buildingsdict[num], remainingdict[num]) )
            if num != 'build11111':
                num += '1'
        else:
            print(' ' + column + '+')
            print(a,end = '')
            for element in row:
                if len(element) == 3:
                    print('| ' + element + ' ',end = '')
                else:
                    print('|   ' + element + ' ' ,end='')
            a += 1
            print('|', end = '\n')
    print(' ' + column + '+')


#print options for the game and remaining buildings(additional feature)
def printoptions(turn):
    print()
    print('Turn {}'.format(turn))
    maplayout()
    #Selecting the two random different buildings
    num1 = random.randint(0,len(buildings)-1)
    num2 = random.randint(0,len(buildings)-1)
    #If the buildings are the same, change the second building
    while buildings[num1] == buildings[num2]:
        num2 = random.randint(0,len(buildings)-1)
    #printing out the options
    print('''1. Build a {}\n2. Build a {}\n3. See current score\n
4. Save game\n0. Exit to main menu'''.format(buildings[num1], buildings[num2]))
    #Input player's choice
    choose = input('Your choice? ')
    while True:
        if choose != '1' and choose != '2' and choose != '3' and choose != '4' and choose != '0':
            print('Please enter a valid number.')
            choose = input('Your choice? ')
        else:
            return int(choose), num1, num2


#Build where
def buildwhere(number, turn, num1, num2):
    dict = {'A':0, 'B':1, 'C':2, 'D':3}
    if number == 1 or number == 2:
        #Input for player's coordinate on where to place building
        where = input('Build where? ')
        while True:
            try:
                if (where[0].upper() != 'A' and where[0].upper() != 'B' and where[0].upper() != 'C' and where[0].upper() != 'D') or (where[1] != '1' and where[1] != '2' and where[1] != '3' and where[1] != '4'):
                    print('Please enter a valid coordinate.')
                    where = input('Build where? ')
                else:
                    break
            except IndexError:
                print('Please enter a valid coordinate.')
                where = input('Build where?')
        #Check the coordinate typed do not have a building on it already
        position = dict[where[0].upper()]
        num = int(where[1]) - 1
        while len(map[num][position]) == 3:
            try:
                position = dict[where[0].upper()]
                num = int(where[1]) - 1
            except:
                print('Please enter a valid coordinate.')
                where = input('Build where? ') 
            if len(map[num][position]) == 3:
                print('There\'s a building on the coordinate. Please choose another coordinate.')
                where = input('Build where? ')
            else:
                break
        templist = []
        #After first turn, check if the building placed is adjacent to another building
        if turn != 1:
            if position == 0:
                templist.append(map[num][position+1])
            elif position == 1 or position == 2:
                templist.append(map[num][position+1]), templist.append(map[num][position-1])
            else:
                templist.append(map[num][position-1])
            if num != 3:
                templist.append(map[num+1][position])
            if num != 0:
                templist.append(map[num-1][position])
            count = 0
            for element in templist:
                if len(element) == 3:
                    count += 1
            if count > 0:
                if number == 1:
                    build = buildings[num1]
                else:
                    build = buildings[num2]
                #put building into the map list  
                map[num][position] = build
                #remove building from building list
                buildings.remove(build)
            else:
                print('Your building must be next to an existing building.')
        else:
            if number == 1:
                build = buildings[num1]
            else:
                build = buildings[num2]
            #put building into the map list  
            map[num][position] = build
            #remove building from building list
            buildings.remove(build)
    #If player chooses the option of looking at his current score
    elif number == 3:
        seescore()
    elif number != 4 and number != 0:
        print('Please enter a valid number.')
            
#See score
def seescore():
    BCHvalue = 0
    FACvalue = 0
    HSEvalue = 0
    SHPvalue = 0
    HWYvalue = 0
    HWYtemplist = []
    BCHadditionlist = []
    HSEadditionlist = []
    SHPadditionlist = []
    HWYadditionlist = []
    FACadditionlist = []
    for sublist in map:
        #value of BCH
        #index for each BCH in a row
        BCHlist = [ i for i in range(len(sublist)) if sublist[i] == 'BCH']
        for index in BCHlist:
            #If in column A or , add 3 points
            if index == 0 or index == 3:
                BCHvalue += 3
                BCHadditionlist.append(3)
            #Else add 1 point
            else:
                BCHvalue += 1
                BCHadditionlist.append(1)
                 
        #value of HSE
        position = map.index(sublist)
        #index for each HSE in a row
        HSElist = [ i for i in range(len(sublist)) if sublist[i] == 'HSE']
        for index in HSElist:
            tempvalue = 0
            templist = []
            #Adding all adjacent buildings to a temporary list
            if index == 0:
                templist.append(map[position][index+1])
            elif index == 1 or index == 2:
                templist.append(map[position][index+1]), templist.append(map[position][index-1])
            else:
                templist.append(map[position][index-1])
            if position != 3:
                templist.append(map[position+1][index])
            if position != 0:
                templist.append(map[position-1][index])
            for item in templist:
                #IF adjacent building have a FAC, value for HSE is only 1
                if 'FAC' in templist:
                    HSEvalue += 1
                    tempvalue += 1
                    break
                else:
                    #If adjacent the house is HSE and SHP, add 1 for each building
                    if item == 'HSE' or item == 'SHP':
                        HSEvalue += 1
                        tempvalue += 1
                    #If the building adjacent is a BCH, add 2 for each BCH
                    elif item == 'BCH':
                        HSEvalue += 2
                        tempvalue += 2
            HSEadditionlist.append(tempvalue)
                           
        #value of SHP
        position = map.index(sublist)
        #index for each SHP in a row
        SHPlist = [ i for i in range(len(sublist)) if sublist[i] == 'SHP']
        extralist = []
        for index in SHPlist:
            templist = []
            #Adding all adjacent buildings to a temporary list
            if index == 0:
                templist.append(map[position][index+1])
            elif index == 1 or index == 2:
                templist.append(map[position][index+1]), templist.append(map[position][index-1])
            else:
                templist.append(map[position][index-1])
            if position != 3:
                templist.append(map[position+1][index])
            if position != 0:
                templist.append(map[position-1][index])
            for item in templist:
                #Each different buildings adjacent to SHP, add 1 point each
                #Create another list to find out the number of different type of buildings
                if item not in extralist and item != ' ':
                    extralist.append(item)
            SHPadditionlist.append(len(extralist))
            SHPvalue += len(extralist)

        #value of HWY
        #index for each HWY in a row
        HWYlist = [ i for i in range(len(sublist)) if sublist[i] == 'HWY']
        position = map.index(sublist)
        item = len(HWYlist)
        for index in HWYlist:
            #4 HWY in a row, each HWY is 4 points
            if item == 4:
                HWYtemplist.append(4)
                break
            #1 HWY in a row, the HWY is 1 point
            elif item == 1:
                HWYtemplist.append(1)
                break
            #checking the different type of possibilities if there are 3 HWY in a row
            elif item == 3:
                #if the 3 HWY are connected to each other
                if index + 1 == HWYlist[1] and index + 2 == HWYlist[2]:
                    HWYtemplist.append(3)
                #If the HWY are seperated to 2connected only and 1 alone
                elif index+1 == HWYlist[1]:
                    HWYtemplist.append(2), HWYlist.append(1)
                #If the HWY are seperated to 1 and 2 connected
                else:
                    HWYtemplist.append(1),HWYtemplist.append(2)
                break
            #Checking the different possibilities if there are 2 HWY in a row
            else:
                #If the 2 HWY are connected to each other
                if index+1 == HWYlist[1]:
                    HWYtemplist.append(2)
                #If the 2 HWY are not connected
                else:
                    HWYtemplist.append(1), HWYtemplist.append(1)
                break

        #value of FAC
        for element in sublist:
            #Count the number of FAC on the map
            if element == 'FAC':
                FACvalue += 1

    #Points scored by each HWY           
    for value in HWYtemplist:
        if value == 4:
            HWYadditionlist.append(4), HWYadditionlist.append(4), HWYadditionlist.append(4), HWYadditionlist.append(4)
        elif value == 3:
            HWYadditionlist.append(3), HWYadditionlist.append(3), HWYadditionlist.append(3)
        elif value == 2:
            HWYadditionlist.append(2), HWYadditionlist.append(2)
        else:
            HWYadditionlist.append(1)
        #Addition to the total points scored with HWY
        HWYvalue += value **2

    #If there are more than 4 FAC, 16 + 1point to each additional FAC    
    if FACvalue > 4:
        temp = FACvalue - 4
        FACvalue = 4**2 + temp
        FACadditionlist.append(4), FACadditionlist.append(4), FACadditionlist.append(4), FACadditionlist.append(4)
        for value in range(temp):
            FACadditionlist.append(1)
    #Else if there are less tahn 4 FAC, FAC is scored by (number of FAC)**2
    else:
        if FACvalue == 4:
            FACadditionlist.append(4), FACadditionlist.append(4), FACadditionlist.append(4),FACadditionlist.append(4)
        elif FACvalue == 3:
            FACadditionlist.append(3), FACadditionlist.append(3), FACadditionlist.append(3)
        elif FACvalue == 2:
            FACadditionlist.append(2), FACadditionlist.append(2)
        elif FACvalue == 1:
            FACadditionlist.append(1)
        FACvalue = FACvalue ** 2
        
    
    #print HSE value
    print('HSE: ', end = '')
    for num in range(len(HSEadditionlist)-1):
        print(HSEadditionlist[num], '+ ', end = '')
    if len(HSEadditionlist) > 0:
        print(HSEadditionlist[-1], '=', HSEvalue)
    else:
        print(0, '=', 0)
    
    #print FAC value
    print('FAC: ', end = '')
    for num in range(len(FACadditionlist)-1):
        print(FACadditionlist[num], '+ ', end = '')
    if len(FACadditionlist) > 0:
        print(FACadditionlist[-1], '=', FACvalue)
    else:
        print(0, '=', 0)
    
    #print SHP value
    print('SHP: ', end = '')
    for num in range(len(SHPadditionlist)-1):
        print(SHPadditionlist[num], '+ ', end = '')
    if len(SHPadditionlist) > 0:
        print(SHPadditionlist[-1], '=', SHPvalue)
    else:
        print(0, '=', 0)
    
    #print HWY value
    print('HWY: ',end = '')
    for num in range(len(HWYadditionlist)-1):
        print(HWYadditionlist[num], '+ ', end = '')
    if len(HWYadditionlist) > 0:
        print(HWYadditionlist[-1], '=', HWYvalue)
    else:
        print(0, '=', 0)
    
    #print BCH value
    print('BCH: ',end = '')
    for num in range(len(BCHadditionlist)-1):
        print(BCHadditionlist[num], '+ ', end = '')
    if len(BCHadditionlist) > 0:
        print(BCHadditionlist[-1], '=', BCHvalue)
    else:
        print(0, '=', 0)
    
    #print total score
    total = HSEvalue + FACvalue + SHPvalue + HWYvalue + BCHvalue
    print('{}: {}'.format('Total score', total))
    return total
    
#buildings
buildings = ['BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH',\
             'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC',\
             'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE',\
             'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP',\
             'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY' ]

#Save game
def savegame():
    templist = []
    #Add the buildings on the map to a list (no more nested list)
    for sublist in map:
        for element in sublist:
            templist.append(element)
    textfile = open('savedgame.txt', 'w')
    #Write the buildings into a textfile
    for element in templist:
        textfile.write(element + '\n')
    textfile.close()
    print('Game saved!')

#Load game
def loadgame():
    anotherlist = []
    textfile = open('savedgame.txt', 'r')
    #Append the buildings that were saved into a textfile into a list
    for item in textfile:
        anotherlist.append(item)
    textfile.close()
    #Remove \n from each of the elements
    for i in range(len(anotherlist)):
        anotherlist[i] = anotherlist[i].replace('\n','')
   
    map = []
    templist =[]
    #Add the buildings back into a nested list which show the map
    for i in range(len(anotherlist)):
        templist.append(anotherlist[i])
        if (i+1)%4 == 0:
            map.append(templist)
            templist =[]
    return map

#Show high score
def showhighscore():
    try:
        highscorelist = []
        textfile = open('highscore.txt', 'r')
        #Retriving the name and high scores of the previous players
        for item in textfile:
            highscorelist.append(item.split(','))
        textfile.close()
        #Remove \n from the high score
        for i in highscorelist:
            i[1] = i[1].replace('\n','')
        print('--------- HIGH SCORES ---------')
        print('{:<4s}{:<22s}{:<6s}'.format('Pos', 'Player', 'Score'))
        print('{:<4s}{:<22s}{:<6s}'.format('---', '------', '-----'))
        #printing out the high scores
        for num in range(len(highscorelist)):
            print('{:>2d}{:<2s}{:<22s}{:<6s}'.format(num+1, '.', highscorelist[num][0], highscorelist[num][1]))
    #If there are no highscore file found (as the game has not been played)
    except FileNotFoundError:
        print('There are currently no high scores.')

#Check if score made it to score board       
def checkscore(finaltotal):
    highscorelist = []
    scorelist = []
    templist = []
    try:
        textfile = open('highscore.txt', 'r')
        #Retrive the name and high scores of the previous players
        for item in textfile:
            highscorelist.append(item.split(','))
        textfile.close()
        #Remove \n from the high scores
        for i in highscorelist:
            scorelist.append(int(i[1]))
            i[1] = i[1].replace('\n','')
        #Ensure that the high scores are in ascending order
        scorelist.sort(reverse = True)
        count = len(scorelist)
        #If there are lesser than 10 high scores
        if count < 10:
            #Append the high score to the score list
            scorelist.append(finaltotal)
            #Rearrange the high score so that it is in ascending order
            scorelist.sort(reverse = True)
            #Find the index of the high score (find out the position of the high score)
            position = scorelist.index(finaltotal)
            #print out the position placed and input for name of player
            print('Congratulations! You made the high score board at position {}!'.format(position+1))
            name = input('Please enter your name (max 20 chars): ')
            #Ensure that the name does not exceed 20 chars
            while len(name) > 20 or name == '':
                name = input('Please enter your name (max 20 chars): ')
            templist.append(name), templist.append(str(finaltotal))
            highscorelist.insert(position, templist)
        #Else if there are more than 10 high scores
        else:
            count = 1
            for i in scorelist:
                #IF the final score scored is more than the previous high score
                if finaltotal > i:
                    index = scorelist.index(i)
                    print('Congratulations! You made the high score board at position {}!'.format(index+1))
                    name = input('Please enter your name (max 20 chars): ')
                    while len(name) > 20 or name == '':
                        print('Name exceed 20 chars.')
                        name = input('Please enter your name (max 20 chars): ')
                    templist.append(name), templist.append(str(finaltotal))
                    highscorelist.insert(index, templist)
                    #Remove the 11th score and name from the list
                    highscorelist.pop(10)
                    break
                #IF the high score is lower than the 10th score
                elif count == 10:
                    print('You didn\'t make it to the high score board :(')
                    break
                count += 1
        #Write the new high scores and name save it into a textfile
        sublist = []
        for i in highscorelist:
            for element in i:
                sublist.append(element)
        textfile = open('highscore.txt', 'w')
        turn = 1
        for element in sublist:
            if turn % 2 == 0:
                textfile.write(element + '\n')
            else:
                textfile.write(element + ',')
            turn += 1
        textfile.close()
    #If there were no previous high scores
    except:
        print('Congratulations! You made the high score board at position 1!')
        name = input('Please enter your name (max 20 chars): ')
        templist.append(name), templist.append(str(finaltotal))
        highscorelist.append(templist)
        sublist = []
        for i in highscorelist:
            for element in i:
                sublist.append(element)
        textfile = open('highscore.txt', 'w')
        turn = 1
        for element in sublist:
            if turn % 2 == 0:
                textfile.write(element + '\n')
            else:
                textfile.write(element + ',')
            turn += 1
        textfile.close()

#running the game        
def playgame(start):
    global flag
    global map
    global buildings
    flag = True
    #If player input 1 in the main menu, start new game
    if start == '1':
        map = [ [' ', ' ', ' ', ' '],\
                [' ', ' ', ' ', ' '],\
                [' ', ' ', ' ', ' '],\
                [' ', ' ', ' ', ' ']\
                ]
        buildings = ['BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH',\
                     'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC',\
                     'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE',\
                     'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP',\
                     'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY' ]
    #If player inputs 2, play load game
    elif start == '2':
        try:
            map = loadgame()
            buildings = ['BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH', 'BCH',\
                         'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC', 'FAC',\
                         'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE', 'HSE',\
                         'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP', 'SHP',\
                         'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY', 'HWY' ]
            for sublist in map:
                for element in sublist:
                    if element != ' ':
                        buildings.remove(element)
        except:
            print('No saved Game.')
    #If player inputs 3, show high scores
    elif start == '3':
        showhighscore()
        print()
        choice = menu()
        playgame(choice)
    #If player inputs 0, end game
    elif start == '0':
        flag = False
        
    while flag:
        #Find the turn, by checking the number of buildings there are on the map
        turn = 1
        for sublist in map:
            for element in sublist:
                if len(element) == 3:
                    turn += 1
        #When the player reaches the final round, print final layout of the map and check the high score
        if turn == 17:
            print()
            print('Final layout of Simp City:')
            maplayout()
            finaltotal = seescore()
            print()
            checkscore(finaltotal)
            showhighscore()
            print()
            choice = menu()
            playgame(choice)
        else:
            choose, num1, num2 = printoptions(turn)
            #If 4 is chosen for the option, save game
            if choose == 4:
                savegame()
            #If 0 is chosen, exit to main menu
            elif choose == 0:
                print()
                choice = menu()
                playgame(choice)
            buildwhere(choose, turn, num1, num2)

   
#Start game
print('Welcome, mayor of Simp City!')
print('----------------------------')
start = menu()
playgame(start)


        
            
        

