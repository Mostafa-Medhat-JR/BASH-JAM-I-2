#!/bin/bash
 symbol=false
 length=12
while getopts "l:s" opt;
do
  case $opt in
     l) if [[ $OPTARG -le 20 ]];
        then
             length=$OPTARG
        else
             echo -e " \e[33m The Length is very tall [1-20] \e[0m"
             exit
        fi
          ;;

     s)symbol=true;;
     *) echo -e "\e[31mEROOOOOR!!!!!\e[0m"
        echo -e "\e[32m Please Enter (l|s) ...\e[0m"
         exit
;;
   esac
done
if [[ $symbol == true ]];
then 
  chars='A-Za-z0-9!@#$%^&*()_{}[]/\|؟'
else
  chars='A-Za-z0-9'
fi
Password=$( tr -dc "$chars" </dev/urandom  | head -c $length )

echo -e "\t \t \e[36mGenerating secure password...\e[0m"
echo "*************************************************************************"

echo -e "\e[33mInitialination . . . \e[0m"
sleep 1
echo -e "\e[33mSecured Password . . .\e[0m "
sleep 1
echo -e "\e[33mPassword Loading . . . \e[0m"
sleep 1

for i in {1..10}
do
    echo -ne "\r["
    
    for j in $(seq 1 $i)
    do
        echo -n  "■"
    done
    
    for j in $(seq $i 10)
    do
        echo -n "-"
    done
    
        echo -ne  "] %d%%" $((i*10))
    
    sleep 0.3
done

echo
echo -e "\a"
sleep 1
echo -e  "\e[34mPassword is \e[0m: \e[31m$Password\e[0m"

