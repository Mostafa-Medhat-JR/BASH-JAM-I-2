#!/bin/bash

#the variables we want for the Guess Game
isGoing=1
stringList=("community" "family" "activities" "happy" "education" "technology" "adventure" "friendship" "nature" "creativity" )
descripList=(
"A group of people who share common interests, values, or goals, often supporting and interacting with each other regularly.\n\n"
"A group of people related by blood, marriage, or strong emotional bonds, providing love, care, and support for one another.\n\n"
"Actions or tasks that people do, often for enjoyment, learning, or social interaction.\n\n"
"A state of feeling joy, contentment, or pleasure; a positive emotional experience.\n\n"
"The process of learning knowledge, skills, and values, often in a formal or informal setting.\n\n"
"The use of scientific knowledge, tools, and systems to solve problems and create new solutions.\n\n"
"An exciting or unusual experience, often involving exploration or risk.\n\n"
"A close and trusting relationship between people, based on mutual care and support.\n\n"
"The natural world including plants, animals, landscapes, and ecosystems.\n\n"
"The ability to think, invent, or express ideas in original and imaginative ways.\n\n"
)

numOfStrings=10 #no of the words we have in the string list
numOfGusses=5 #the guesses the user have
letterHint=1 #this var to check is there a hint in letter or not
descriptionHint=1 #this var to check is there a hint in description or not
chosenWord=0  #the number he choose to pick a word from the array
enteredWord=" " #the guess he will write
wordPicked=" " #the word he will pick
numOfCells=0 #the size of the word he chose from the array counter
enetredWordCounter=0 #this var  to check all the letters he wrote is right
sizeOfEnteredWord=0 #this var have how many lettres the user entered to check equal the guessed word
letter1="" #this var have each letter for the word he chose
letter2="" #this var have each letter for the word he guessed


#declarition for the password Game
playerturn=1 #this var to switch playes turn
pass1=0 #this var have the pass player 1 entered
pass2=0 #this var have the pass player 2 entered
name1="" #name player 1
name2="" #name player 2
minPassLimit=1000 #min no the user can write for the pass
maxPassLimit=9999 #max no the user can write for the pass
sizeOfPass=4 #this var have the max size for the pass
counter1=0 #counter for how many no is right for pl 1
counter2=0 #counter for how many no is right for pl 1
tmpPass1=0 #this var  have the pass 1 temporay for comparing later
tmpPass2=0 #this var  have the pass 2 temporay for comparing later
guesspass1=0 #the pass guess pl 1 entered
guesspass2=0 #the pass guess pl 2 entered
num1=0 #this var carries guess pass the one no to compare  for pl1
num2=0 #this var carries enterd pass the one no to compare  for pl1
num3=0 #this var carries guess pass the one no to compare  for pl2
num4=0 #this var carries enterd pass the one no to compare  for pl3


 #declartion for reverse command game
 reverseCommandsList=("udso" "pgre" "art" "macapn" "life" "shab" "himwoa" "nam" "osppora" "vm" )
 CommandsList=("sudo" "grep" "tar" "pacman" "file" "bash" "whoami" "man" "apropos" "mv" )
 descripCommands=(
 "Run a command with superuser (admin) privileges.\n"
"Search for text patterns inside files.\n"
"Create or extract archive files.\n"
"Package manager for Arch-based systems.\n"
"Display the type of a file.\n"
"Command-line shell interpreter.\n"
"Show the current logged-in username.\n"
"Display the manual page of a command.\n"
"Search manual pages by keyword.\n"
"Move or rename files and directories.\n"

 )
  numOfcommands=10 #no of the commands we have



#declartion for reverse distro game
reverseDistroList=("dorafe" "char" "nimt" "lika" "sopneuse" "aindbe" "orajamn" "vednrouaeso" "selraacwk" "toogen" )
distroList=("fedora" "arch" "mint" "kali" "opensuse" "debian" "manjaro" "endeavouros" "slackware" "gentoo" )
descripDistroList=(
"Fedora – Cutting-edge, developer-focused Linux.\n"
"Arch – Minimal, powerful, build-it-yourself distro.\n"
"Mint – Beginner-friendly and Windows-like.\n"
"Kali – Cybersecurity and penetration testing distro.\n"
"openSUSE – Stable, flexible, and professional-grade.\n"
"Debian – Ultra-stable and rock-solid foundation.\n"
"Manjaro – User-friendly Arch-based distro.\n"
"EndeavourOS – Lightweight, close-to-Arch experience.\n"
"Slackware – Classic, simple, and traditional Linux.\n"
"Gentoo – Highly customizable, source-based powerhouse.\n"
)
numOfDistro=10 #no of the distros we have


#tutorials for the Games
function tutorialGame
{
while true ;
do
  echo -e "\t which tutorial you want:\n"
   echo -e "\n\t\t\t\t\t 1)Guess Game \n\n\t\t\t\t\t 2)Password Game \n\n\t\t\t\t\t 3)Reverse Game \n\n\t\t\t\t\t 0) Back to Main Menu \n\n"
   read pickedChoice
   case $pickedChoice in
   1)
     tutorialGuessGame
     break;;
   2)
     tutorialPasswordGame
     break;;
   3)
     tutorialReverseGame
     break;;
   0)
     break;;
   *)
     echo -e "\t\t\tinvalid Choice pls enter a valid one\n"
   esac


  done
}

#tutorial for guess word game
function tutorialGuessGame
{
echo -e "\n\t\t🎮 GUESS THE WORD - TUTORIAL\n"
echo -e "1) Choose a number to pick a hidden word."
echo -e "2) You have 5 guesses to find the correct word."
echo -e "3) After each wrong guess, you will be told how many letters are correct and in the correct position."
echo -e "4) You can type 'h' during the game to use a hint."
echo -e "   - Description hint (once per game)."
echo -e "   - Letter hint (once per game)."
echo -e "5) If guesses reach 0, you lose and the word is revealed."
echo -e "6) Guess the word correctly before running out of guesses to win!\n"

}

#tutorial for password game game
function tutorialPasswordGame
{
echo -e "\n\t\t🔐 PASSWORD GUESS GAME - TUTORIAL\n"
echo -e "1) Player One chooses a secret 4-digit password."
echo -e "2) Player Two chooses a different secret 4-digit password."
echo -e "3) Passwords must be exactly 4 digits (from 1000 to 9999)."
echo -e "4) Players take turns guessing the opponent's password."
echo -e "5) After each guess, the game tells you how many digits are correct"
echo -e "   AND in the correct position."
echo -e "6) If all 4 digits are correct, that player wins immediately."
echo -e "7) The turns continue until one player guesses correctly."
echo -e "8) You can strategize by changing one digit at a time to figure out"
echo -e "   which positions are correct.\n"
echo -e "💡 Tips:"
echo -e "- Start by guessing numbers with no repeats to identify correct digits."
echo -e "- Remember the feedback each turn to adjust your next guess."
echo -e "- Have fun and try to outsmart your opponent!\n"
}

#tutorial for reverse game
function tutorialReverseGame
{
  echo -e "\n\t\t🔄 REVERSE WORDS GAME - TUTORIAL\n"
echo -e "1) Choose which mode you want to play:"
echo -e "   - Commands Reverse"
echo -e "   - Distros Reverse\n"

echo -e "2) Enter a number to pick a reversed word from the list."

echo -e "3) The game will show you a reversed word."
echo -e "   Example: 'dirmk'"

echo -e "4) You must type the correct original word."
echo -e "   Example: 'mkdir'\n"

echo -e "5) You have 5 guesses to get the correct answer."

echo -e "6) If your guess has a different number of letters than the original word,"
echo -e "   the game will ask you to enter a valid guess."

echo -e "7) If you guess correctly, you win and the game will display"
echo -e "   a short description about the command or distro."

echo -e "8) If your guesses reach 0, you lose."
echo -e "   The correct word will be revealed with its description.\n"

echo -e "💡 Tips:"
echo -e "- Read the reversed word carefully."
echo -e "- Try reversing it in your head letter by letter."
echo -e "- Watch your remaining guesses!"
echo -e "- Have fun testing your Linux knowledge! 🐧\n"
}

#this fn for handling the hint in the Guess Game
function hintGuessGame
{


  if [[ $(($letterHint+$descriptionHint)) -gt 0 ]]

    then
  while true;
  do
     echo "which type of hint you want "
  echo -e "\t\t 1)description \t 2)tell you a letter \t 0)Back"
    read choiceNum


  case $choiceNum in

  1)
    if [[ $descriptionHint -eq 0 ]]
  then
    echo -e "\t-->there is no Description hint you used it :)\n\n"
continue
    fi
    echo -e $1
    descriptionHint=0
    break;;

  2)
       if [[ $letterHint -eq 0 ]]
  then
    echo -e  "\t-->there is no letter hint you used it :) \n\n"
    continue
    fi
    echo -e "which letter you want (enter no from 1 to $2) \n\n"
    while  true;
    do
    read letterNum
    if [[ $letterNum -ge $2 ]]
    then
        echo -e "  invalid choice pls enter a valid one\n\n\n"
        else
          break;

    fi
    done
    ((letterNum--))
    letterPicked=$3
    letterPicked="${letterPicked:$letterNum:1}"
     ((letterNum++))
    echo -e "the letter you picked is $letterPicked and it is placed at $letterNum position\n\n"

    letterHint=0
    break;;
  0)
    break;;


  *)
    echo "invalid choice pls enter a valid one\n";;
  esac

  done

  else
    echo -e  "\t\t-----you no longer have a hints\n\n "

  fi

}

#this fn handle the pass for pl 1 enter
function passwordPlayerOneValidation
{
  while true;
  do
    read -sp "$name1 enter your password (it cannot start with 0):" pass1
        echo -e "\n"
      if [[ ! "$pass1" =~ ^[0-9]+$ ]]; then
        echo -e "\t invalid input plz enter a number bet [1000,9999]\n"
        continue
        fi

      if [[ $pass1 -lt $minPassLimit ]]
            then
              echo -e "\t--> the password is small than 4 numbers pls enter a valid one"
              elif [[ $pass1 -gt $maxPassLimit ]]
              then
                echo -e "\t--> the password is bigger than 4 numbers pls enter a valid one"
                else
                   break
    fi
  done


}

#this fn handle the pass for pl 2 enter
function passwordPlayerTwoValidation
{
    while true;
  do

    read -sp "$name2 enter your password (it cannot start with 0): " pass2
        echo -e "\n"
         if [[ ! "$pass2" =~ ^[0-9]+$ ]]; then
        echo -e "\t invalid input plz enter a number bet [1000,9999]"
        continue
        fi
      if [[ $pass2 -lt $minPassLimit ]]
          then
            echo -e "\t--> the password is small than 4 numbers pls enter a valid one"
            elif [[ $pass2 -gt $maxPassLimit ]]
            then
              echo -e "\t--> the password is bigger than 4 numbers pls enter a valid one"
              else
                break
      fi

    done
}

#this fn handle the gameplay for the password Game
function passwordGamePlay
{
   while true ;
    do
        counter1=0
        counter2=0
        tmpPass2=$pass1
        tmpPass1=$pass2

      if [[ $playerturn -eq 1 ]]
          then
              echo  "--$name1 Guess $name2's password  "
              read guesspass1

               if [[ ! "$guesspass1" =~ ^[0-9]+$ ]]; then
                  echo -e "\t invalid input plz enter a number bet [1000,9999]\n"
                  continue
               fi

                 if [[ $guesspass1 -lt $minPassLimit ]]
              then
                echo -e "\t--> the guessed password is small than 4 numbers pls enter a valid one"
                continue
                elif [[ $guesspass1 -gt $maxPassLimit ]]
                then
                  echo -e "\t--> the the guessed password is bigger than 4 numbers pls enter a valid one"
                  continue
      fi

          for (( i=0;i<$sizeOfPass;i++ ));
          do
              num1=$(($guesspass1%10))
              num2=$(($tmpPass1%10))
              if [[ $num1 -eq $num2 ]]
              then
                ((counter1++))
                fi
              guesspass1=$(($guesspass1/10))
              tmpPass1=$(($tmpPass1/10))
          done

  if [[ $counter1 -eq 4 ]]
    then
          echo -e "\t\t\t$name1 HAS WON. THE PASSWORD IS $pass2 GOOD GUESS :)\n"
          echo -e "\t\t\t$name1 password is $pass1 and $name2 password is $pass2 "
          break
          else
             echo -e "--- wrong password. $name1 gussed $counter1 numbers right\n"
             playerturn=2
  fi


    else
        echo  "--$name2 Guess $name1's password "
          read guesspass2

              if [[ ! "$guesspass2" =~ ^[0-9]+$ ]]; then
                  echo -e "\t invalid input plz enter a number bet [1000,9999]"
                  continue
               fi

                if [[ $guesspass2 -lt 1000 ]]
                    then
                      echo -e "\t--> the guessed password is small than 4 numbers pls enter a valid one"
                      continue
                elif [[ $guesspass2 -gt 9999 ]]
                    then
                      echo -e "\t--> the the guessed password is bigger than 4 numbers pls enter a valid one"
                      continue
                fi

         for ((i=0;i<$sizeOfPass;i++));
           do
              num3=$(($guesspass2%10))
              num4=$(($tmpPass2%10))
                if [[ $num3 -eq $num4 ]]
                 then
                    ((counter2++))
                fi

            guesspass2=$(($guesspass2/10))
            tmpPass2=$(($tmpPass2/10))

           done


  if [[ $counter2 -eq 4 ]]
  then
    echo -e "\t\t\t$name2 HAS WON. THE PASSWORD IS $pass1 GOOD GUESS :)\n"
     echo -e "\t\t\t$name1 password is $pass1 and $name2 password is $pass2 "
    break
    else
       echo -e "--- wrong password. $name2 gussed $counter2 numbers right\n"
       playerturn=1
    fi

  fi



  done
}

#password Game
function passwordGame
{
  #the palyers enter there names
      echo "first player enter your name"
      read name1
      echo "secound player enter your name"
      read name2
      passwordPlayerOneValidation
      passwordPlayerTwoValidation

      playerturn=1
      passwordGamePlay

}

#this fn handle the word for user enter
function validWordForGuess
{
  #this loop for validtion for the input of the pickig word
while true ;
do
echo -e "Enter a number from 1 to $numOfStrings to pick a word to Guess \n"
read chosenWord

  if [[ ! "$chosenWord" =~ ^[0-9]+$ ]]; then
     echo -e "\t invalid input plz enter a valid number\n"
     continue
  fi

if [[ $chosenWord -gt $numOfStrings ]]
then
echo -e "Invalid choice enter a valid one \n"
elif [[ $chosenWord -le 0 ]]
then
echo -e "Invalid choice enter a valid one \n"
else
break
fi

done

((chosenWord--))
wordPicked=${stringList[$chosenWord]}
numOfCells=${#wordPicked}

}

#this fn handle the gameplay for the Guess the word Game
function gamePlayGuessGame
{
  while true;
do
enetredWordCounter=0

if [[ $numOfGusses -eq 0 ]]
then
  echo -e "\t\t\t\t\t\t\t YOU LOST THE WORD IS $wordPicked HARD LUCK NEXT TIME :)) \n\n"
  break
  fi

echo -e " your chosen word is $numOfCells Cells (if you want a hint press h)\n"

read -p " Enter your guessing word (you have $numOfGusses Gussess): " enteredWord

if [[ $enteredWord == "h" ]]
  then
     hintGuessGame "${descripList[chosenWord]}" $numOfCells $wordPicked
    continue
    fi

sizeOfEnteredWord=${#enteredWord}

if [[ $sizeOfEnteredWord -gt $numOfCells ]]
then
echo  -e "\t-->your enterd word is bigger than the chosen word pls enter a valid one \n\n"
continue
elif [[ $sizeOfEnteredWord -lt $numOfCells ]]
then
echo -e "\t-->your enterd word is smaller than the chosen word pls enter a valid one\n\n"
continue
fi

for (( i=0;i<$numOfCells;i++ ));
do
letter1=${enteredWord:$i:1}
letter2=${wordPicked:$i:1}
if [[ $letter1 == $letter2 ]]
then
((enetredWordCounter++))
fi

done

if [[ $enetredWordCounter -eq $numOfCells ]]
then
echo -e "\t\t\t\t\t\t\t YOU WON YOU GUSSED RIGHT :))  THE WORD IS $wordPicked \n\n"
break

else
   echo -e "\t wrong Guess you have $enetredWordCounter right letters\n"
 ((numOfGusses--))


fi

done


}

#Gues the word game
function guessTheWordGame
{


  validWordForGuess
  gamePlayGuessGame

}

#this fn handle the gameplay for the command revrse command
function commandreversefn
{
  while true;
  do

    echo "enter a number from 1 to $numOfcommands"
    read numPicked

     if [[ ! "$numPicked" =~ ^[1-9]+$ ]]; then
     echo -e "\t invalid input plz enter a valid number\n"
     continue
  fi

    if [[ $numPicked -le $numOfcommands ]]
  then
    ((numPicked--))
    commandPicked=${reverseCommandsList[numPicked]}
    orginalCommand=${CommandsList[numPicked]}
    descriptionCommandVar="${descripCommands[numPicked]}"
    while true;
    do
        if [[ $numOfGusses -eq 0 ]]
    then
      echo -e "\t\t\t\tYOU LOST the Command is $orginalCommand HARD LUCK NEXT TIME :)\n"
      echo -e "\t\t----->this command functionality is \n \t\t\t$descriptionCommandVar \n\n "
      break
      fi
    echo -e "the the Command you picked is \n"
    echo -e "\t\t\t---$commandPicked---"

    read -p "What is the Command? (u have $numOfGusses gusess) " guessedCommand

    origCommandSize=${#commandPicked}
    guessCommandSize=${#guessedCommand}

      if [[ $origCommandSize -ne $guessCommandSize ]]
      then
        echo -e "\t---the size of the letters of the Command is not equal pls enter a valid one\n"
      continue

    elif [[ $guessedCommand == $orginalCommand ]]
      then
        echo -e "\t\t\t\tYOU GUESSED THE COMMAND RIGHT IT IS $orginalCommand \n\n"
     echo -e "\t\t----->this command functionality is \n \t\t\t$descriptionCommandVar \n\n "
        break
        else
          ((numOfGusses--))
          echo -e "\tWrong guess u have $numOfGusses guess\n"
          fi
        done
  break

   else
     echo -e "invalid choice enter a valid one\n"
     fi

done
}

#this fn handle the gameplay for the revrse distro
function distroreversefn
{
while true;
  do

    echo "enter a number from 1 to $numOfDistro"
    read numPicked

    if [[ ! "$numPicked" =~ ^[1-9]+$ ]]; then
     echo -e "\t invalid input plz enter a vaild number\n"
     continue
  fi
    if [[ $numPicked -le $numOfDistro ]]
  then
    ((numPicked--))
    distroPicked=${reverseDistroList[numPicked]}
    orginalDistro=${distroList[numPicked]}
    infoOfDistro="${descripDistroList[numPicked]}"
    while true;
    do

 if [[ $numOfGusses -eq 0 ]]
    then
      echo -e "\t\t\t\tYOU LOST HARD the DISTRO is $orginalDistro LUCK NEXT TIME :)\n\n"
      echo -e "\t\t\t a nice info about $orginalDistro \n \t\t\t\t$infoOfDistro \n\n"
      break
      fi

    echo -e "the DISTRO you picked is \n"
    echo -e "\t\t\t---$distroPicked---"
    read -p "What is the Distro? (u have $numOfGusses gusess) " guessedDistro
     distroSize=${#distroPicked}
     guessDistroSize=${#guessedDistro}

    if [[ $distroSize -ne guessDistroSize ]]
    then
      echo -e "\t---the size of the letters of the Distro is not equal pls enter a valid one\n"
      continue

    elif [[ $guessedDistro == $orginalDistro ]]
      then
        echo -e "\t\t\t\tYOU GUESSED THE DISTRO RIGHT IT IS  $orginalDistro\n\n"
        echo -e "\t\t\t a nice info about $orginalDistro \n \t\t\t\t$infoOfDistro\n\n"
        break
        else
          ((numOfGusses--))
          echo -e "\tWrong guess  u have $numOfGusses guesses"
          fi
        done
  break

   else
     echo -e "invalid choice enter a valid one\n"
     fi

done



}

#Reverse Game
function reverseWords
 {
  while true;
  do
  echo  -e "\n\t\t\t\t\twhich test you want\n\n\t\t\t\t\t 1) Commands \n\n\t\t\t\t\t 2) Distros: \n\n\t\t\t\t\t 0)Back to Main Menu \n"

  read choiceNum
  case $choiceNum in
  1)
    commandreversefn
    break;;
  2)
    distroreversefn
    break;;
  0)
    break;;
  *)
    echo -e "invalid choice pls enter a valid one \n"

  esac



  done

}


#this fn is game play
function startGame
{
  echo -e "\tenter the Game you want: \n"
  while true ;
  do
    echo -e "\n\t\t\t\t\t 1)Guess the Word Game\n\n\t\t\t\t\t 2)Guess the Password Game\n\n\t\t\t\t\t 3)Reverse Words Game\n\n\t\t\t\t\t 0)Back to Main Menu\n "
    read choicePicked
    case $choicePicked in
    1)
      guessTheWordGame
      break;;
    2)
      passwordGame
      break;;
    3)
      reverseWords
      break;;
    0)
      break;;
    *)
      echo "\t\t\tInvalid choice pls enter a valid one";;
    esac
    done

}

#the Menu for the game fn
function mainMenu
{

while true;
do
letterHint=1
descriptionHint=1
numOfGusses=5
playerturn=1
  echo -e "\n\t\\t\t\t\t1)Start Game \n\n\t\t\t\t\t 2)tutorial \n\n\t\t\t\t\t 3)Exit"
echo "Enter your choice"
read menuOption
case $menuOption in
1)
startGame;;
2)
tutorialGame;;
3)
isGoing=0
break;;
*)
echo "invalid Choice plz enter a valid one";;
esac
done

}

while [ $isGoing -eq 1 ]
do
mainMenu
done
