#!perl.exe
#Proper Encoding (Not ASCII)
use utf8;
#Yell at me, remove before distribution
use warnings;

#Beginning of the game, starts out
START:
#Finds out if the user has played the game previously
print "\nHave you played this game before? yes-1/no-2:";
my $experience = <STDIN>;
#Starts game for experienced users
if ($experience == 1) {
    print ("Let's go!\n");
    goto GAME;
}
#Gives tutorial to new users
elsif($experience == 2){
    print ("Here is the tutorial\n");
    goto TUTORIAL;
}
#Yells at people
else{
    print"Please give a valid response\n";
    goto START;
}


TUTORIAL:
#This is the tutorial
print("\nYou are on a trail in the woods, the day is reaching an end when you realize you are lost\n");
print("You want to get back to your car in the least time possible\n");
print"Press enter to continue...";
#Are you awake still?
$continuer=<STDIN>;
print("\nThese are the command you can use:\n");
print("8-use to move a space forward\n");
print("2-use to move a space back\n");
print("7-lists how much food and energy you have\n");
print("4-Eats food\n");
print("9-tells you how many days you have been lost, try to get the fewest days possible\n");
print("6-Lets you sleep\n");
print("123-exits the game\n");
print("321-Restarts the game");
print"Press enter to continue...";
#Are you still awake
my $continue=<STDIN>;
#Starts the game
goto GAME;
#The game
GAME:
my $moves=0;
#time until a fork in the road
my $timechoice=5;
my $backchoice=0;
#how long until you have to make a choice
my $timedecision=0;
#Distance to car
my $distance=30;
#amount of food
my $food=0;
#Energy you have
my $energy=30;
#Days gone
my $day=0;
#Starting instructions
print("\nGAME:\nYou are lost on a trail, get back to your car\n");
print("You are 30 blocks away from your car\n");
print("You can move forward-8, move backward,-2 eat-4, or sleep-6\n");
#Sends you to game
goto MOVE;


#Game
MOVE:
print("\nWhat is your move?");
#Finds out what person wants to do
my $move =<STDIN>;
#Go forward
if ($move==8) {
    $moves=$moves+1;
    $energy=$energy-1;
    $distance=$distance-1;
    $timedecision=$timedecision+1;
    print "energy-$energy\n";
    print "day-$day\n";
    print "distance-$distance\n";
    goto DEATHCHECK;
}
#Goes back
elsif($move==2 && $distance!=30){
    $moves=$moves+1;
    $distance=$distance+1;
    $energy=$energy-1;
    $timedecision=$timedecision-1;
    print "time-$timedecision";
    print "energy-$energy\n";
    print "Day-$day\n";
    print "distance-$distance\n";
    goto DEATHCHECK;
}
#Secret!!!
elsif($move==666){
    $moves=$moves+1;
    print"\nSTOP THINKING ABOUT THE DEVIL\n";
    goto DEATHCHECK;
}
#Tells you how much food you have
elsif($move==7){
    $moves=$moves+1;
    print ("\nYou have $food food\n");
    print "You have $energy energy\n";
    goto DEATHCHECK;
}
elsif($move==4){
    $moves=$moves+1;
    if ($food>0) {
        print"That was delicous\n";
        $food=$food-1;
        $energy=$energy+5;
    }
    else{
        print"You have no food!\n";
    }
    
}
#Exit statement
elsif($move==123){
    $moves=$moves+1;
    goto GOODBYE;
}
elsif($move==9){
    $moves=$moves+1;
    print"moves-$moves\ndays-$day\n"
}
elsif($move==6){
    $moves=$moves+1;
    print"\nGoodnight\n";
    $day=$day+1;
    $energy=$energy+15;
    print"\nGoodmorning\n";
}
elsif($move==321){
    goto GAME;
}
#Yells at you
else{
    $moves=$moves+1;
    print"\nGive a valid choice\n";
    goto DEATHCHECK;
    print"Type 123 to exit";
}


#Are you dead yet?
DEATHCHECK:
my $chance=int(rand(100));
if ($energy<0) {
    print"\nYou died\nCause-No energy\nGoodbye\n";
    print"You had $moves moves\nand $day days\n";
    goto GAME;
}
elsif ($chance>95) {
    my $loss=int(rand(15));
    $energy=$energy-$loss; #add loss back when done
    print"\nYou were attacked by a wild animal\n";
    print"You lost $loss energy\n";
    print"You have $energy energy\n";
    goto CHOICE;
}
#Tells you if you're at the start
elsif($distance==30){
    print"\nYou are at the beginning!\n";
    $distance=30;
    goto CHOICE;
}
elsif($energy<5){
    print "\nYou are low on energy\nYou have $energy energy left";
    goto CHOICE;
}
else{
    goto CHOICE;
}


CHOICE:
if ($timedecision==5 && $timechoice==5) {
    print"\nThere is a fork in the road
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=10;
        $backchoice=5;
        goto MOVE;
    }
    elsif($decision==1){
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=15;
        $backchoice=5;
        goto MOVE;
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==5 && $backchoice==5){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==10) {
            print"You went left";
            $timechoice=15;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=10;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=0;
        $timechoice=5;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif ($timedecision==15 && $timechoice==15){
    print"\nThere is a fork in the road
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=21;
        $backchoice=15;
        goto MOVE;
    }
    elsif($decision==1){
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=20;
        $backchoice=15;
        goto MOVE; 
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==15 && $backchoice==15){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==21) {
            print"You went left";
            $timechoice=20;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=21;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=5;
        $timechoice=15;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif($timedecision==20 && $timechoice==20){
    print"\nThere is a fork in the road
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=25;
        $backchoice=20;
        goto MOVE;
    }
    elsif($decision==1){
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=23;
        $backchoice=20;
        goto MOVE; 
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==20 && $backchoice==20){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==25) {
            print"You went left";
            $timechoice=23;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=25;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=15;
        $timechoice=20;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif ($timedecision==21 && $timechoice==21){
    print "\nYou have found a water source! (A pool)\n";
    print "Press 2 to go back, 4 to drink, and 6 to swim across\n";
    WATER1:
    print "\nWhat is your move?";
    $move=<STDIN>;
    if ($move==2) {
        $backchoice=18;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "\ntime-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto MOVE;
    }
    elsif($move==4){
        $moves=$moves+1;
        $energy=$energy+5;
        $chance=int(rand(10));
        if ($chance>7) {
            print"\nMaybe that scummy water wasn't so good\nYou died\n";
            goto GAME;
        }
        else{
            print "\nYou just drank!\nplus 5 energy!\nYou have $energy energy\n";
            goto WATER1;
        }
    }
    elsif($move==6){
        $moves=$moves+1;
        $chance=int(rand(10));
        if ($chance<8) {
            print "\nYou drowned";
            goto GAME;
        }
        else{
            print "\nYou were attacked by a crocodile\n";
            goto GAME;
        }
        
    }
    else{
        $moves=$moves+1;
        print "Pleace enter a valid value";
        goto WATER2;
    }
}
elsif ($timedecision==23 && $timechoice==23){
    print "\nYou have found a water source! (A river)\n";
    print "Press 2 to go back, 4 to drink, and 6 to swim across\n";
    WATER2:
    print "\nWhat is your move?";
    $move=<STDIN>;
    if ($move==2) {
        $backchoice=20;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "\ntime-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto MOVE;
    }
    elsif($move==4){
        $moves=$moves+1;
        $energy=$energy+5;
        $chance=int(rand(10));
        if ($chance>8) {
            print"\nGotta' love that Giardia\nYou died\n";
            goto GAME;
        }
        else{
            print "\nYou just drank!\nplus 5 energy!\nYou have $energy energy\n";
            goto WATER2;
        }
    }
    elsif($move==6){
        $moves=$moves+1;
        $chance=int(rand(10));
        if ($chance<6) {
            print "\nMaybe swimming in a river near a waterfall wasn't the best idea\n";
            goto GAME;
        }
        else{
            print "\nYou were attacked by a hippo\n";
            goto GAME;
        }
        
    }
    else{
        $moves=$moves+1;
        print "Pleace enter a valid value";
        goto WATER2;
    }
}
elsif ($timedecision==10 && $timechoice==10){
    print"\nThere is a fork in the road
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $backchoice=10;
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=18;
        goto MOVE;
    }
    elsif($decision==1){
        $backchoice=10;
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=12;
        goto MOVE; 
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==10 && $backchoice==10){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==18) {
            print"You went left";
            $timechoice=12;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=18;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=10;
        $timechoice=5;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif ($timedecision==25 && $timechoice==25){
    print "\nYou have found a water source! (A river)\n";
    print "Press 2 to go back, 4 to drink, and 6 to swim across\n";
    WATER3:
    print "\nWhat is your move?";
    $move=<STDIN>;
    if ($move==2) {
        $backchoice=20;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "\ntime-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto MOVE;
    }
    elsif($move==4){
        $moves=$moves+1;
        $energy=$energy+5;
        $chance=int(rand(10));
        if ($chance>8) {
            print"\nGotta' love that Giardia\nYou died\n";
            goto GAME;
        }
        else{
            print "\nYou just drank!\nplus 5 energy!\nYou have $energy energy\n";
            goto WATER3;
        }
    }
    elsif($move==6){
        $moves=$moves+1;
        $chance=int(rand(10));
        if ($chance<6) {
            print "\nJust saying, you probably didn't swim to get here\nYou died\n";
            goto GAME;
        }
        else{
            print "\nYou were eaten by a Grue *trollface*\n";
            goto GAME;
        }
        
    }
    else{
        $moves=$move+1;
        print "Pleace enter a valid value";
        goto WATER2;
    }
}
elsif ($timedecision==12 && $timechoice==12){
    print "\nYou have found a food source! (An abondoned picnic basket)\n";
    print "You have walked back to the previous fork\n";
    $food=$food+10;
    $timedecision=10;
    $timechoice=10;
    goto CHOICE;
}
elsif ($timedecision==18 && $timechoice==18){
    print "\nThere is a fork in the road;
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $backchoice=18;
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=19;
        goto MOVE;
    }
    elsif($decision==1){
        $backchoice=18;
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=21;
        goto MOVE; 
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==18 && $backchoice==18){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==19) {
            print"You went left";
            $timechoice=21;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=19;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=10;
        $timechoice=18;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif ($timedecision==19 && $timechoice==19){
    print "\nThere is a fork in the road;
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $backchoice=19;
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=22;
        goto MOVE;
    }
    elsif($decision==1){
        $backchoice=19;
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=24;
        goto MOVE; 
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==19 && $backchoice==19){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==22) {
            print"You went left";
            $timechoice=24;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=22;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=19;
        $timechoice=22;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif ($timedecision==22 && $timechoice==22){
    print "\nThere is a fork in the road;
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $backchoice=22;
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=26;
        goto MOVE;
    }
    elsif($decision==1){
        $backchoice=22;
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=28;
        goto MOVE; 
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==22 && $backchoice==22){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==26) {
            print"You went left";
            $timechoice=28;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=26;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=19;
        $timechoice=22;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif ($timedecision==24 && $timechoice==24){
    print "\nThere is a fork in the road;
    press 3 to go right
    press 1 to go left";
    my $decision=<STDIN>;
    if ($decision==3) {
        $backchoice=24;
        $moves=$moves+1;
        print"\nYou went right\n";
        $timechoice=27;
        goto MOVE;
    }
    elsif($decision==1){
        $backchoice=24;
        $moves=$moves+1;
        print"\nYou went left\n";
        $timechoice=30;
        goto MOVE; 
    }
    else{
        $moves=$moves+1;
        print"\nPlease give a valid response\n";
        goto CHOICE;
    }
}
elsif ($timedecision==24 && $backchoice==24){
    print"\nYou are back at an intersection
    press 8 to take the other path
    press 2 to keep going back";
    $choice=<STDIN>;
    if ($choice==8) {
        if ($timechoice==27) {
            print"You went left";
            $timechoice=30;
            goto MOVE;
        }
        else{
            print"You went right";
            $timechoice=27;
            goto MOVE;
        }
        
    }
    elsif ($choice==2){
        $backchoice=19;
        $timechoice=24;
        $moves=$moves+1;
        $distance=$distance+1;
        $energy=$energy-1;
        $timedecision=$timedecision-1;
        print "time-$timedecision";
        print "energy-$energy\n";
        print "Day-$day\n";
        print "distance-$distance\n";
        goto DEATHCHECK;
    }
}
elsif ($timedecision==26 && $timechoice==26){
    print"\nYou found a cave\nPress 8 to go in";
    $choice=<STDIN>;
    if ($choice==8) {
       $chance=int(rand(100));
        if ($chance>75) {
            print"\nYou were attacked by a wolf";
            $loss=int(rand(10));
            $energy=$energy-$loss;
            print"\nYou lost $loss energy
            You have $energy energy
            You have walked back to the previous fork";
            $timechoice=22;
            $timedecision=22;
            goto CHOICE;
        }
        else{
            print"\nYou found 30 food";
            $food=$food+30;
            print"\nYou have $food food\n";
            $timechoice=22;
            $timedecision=22;
            print"You have walked back to the previous fork";
            goto CHOICE;
        }
    }
    else{
        print"\nIdiot, just go in";
        goto CHOICE;
    }
}
elsif ($timedecision==28 && $timechoice==28){
    print"\nYou found a house\nPress 8 to go in";
    $choice=<STDIN>;
    if ($choice==8) {
       $chance=int(rand(10));
        if ($chance>7) {
            print"\nYou were attacked by a bear";
            $loss=int(rand(18));
            $energy=$energy-$loss;
            print"\nYou lost $loss energy
            You have $energy energy
            You have walked back to the previous fork";
            $timechoice=22;
            $timedecision=22;
            goto CHOICE;
        }
        else{
            print"\nYou found 30 food";
            $food=$food+30;
            print"\nYou have $food food\n";
            $timechoice=22;
            $timedecision=22;
            print"You have walked back to the previous fork";
            goto CHOICE;
        }
    }
    else{
        print"\nIdiot, just go in";
        goto CHOICE;
    }
}
elsif ($timedecision==27 && $timechoice==27){
    $chance=int(rand(100));
    if ($chance>35) {
        print"\nYou fell off a cliff";
        $energy=$energy-500;
        goto DEATHCHECK;
    }
    elsif ($chance>50){
        print"\nYou just barely survived falling off a cliff
        You have walked back to the previous fork";
        $timechoice=24;
        $timedecision=24;
        goto CHOICE;
    }
    else{
        print"\nYou just barely survived falling off a cliff
        Then you were attacked by a mountain lion";
        $energy=$energy-250;
        goto DEATHCHECK;
    }
}
elsif ($timedecision==30 && $timechoice==30){
    $chance=int(rand(100));
    if ($chance>51) {
        print"\nYou found your car
        Wait, that means you won
        DARN YOU
        Oh well, here you go:
        WINNER";
        goto GOODBYE;
    }
    elsif ($chance>76){
        print"\nYou found your car
        Then you were hit by a meteor";
        goto GOODBYE;
    }
    else{
        print"\nYou found the parking lot where your car was
        Turns out you locked your keys in your car";
        goto GOODBYE;
    }
}
else{
    goto MOVE;
}
GOODBYE:
print"\nYou had $moves moves\nand $day days\n";
print "Goodbye";
