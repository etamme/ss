#!/bin/bash
speak="/usr/bin/espeak -s 130 -v english-us"
red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m' # No Color
clear
printf "I am ${red}spelling ${green}Spencer${nc}!\n"

# intro
$speak "Hello, I am spelling spencer.  Let's learn something today."

# level input
echo -n "level 1-5:"
$speak "Tell me, what level would you like to try?"
read level

# name input
clear
echo -n "name:"
$speak "And what is your name?"
read name
clear
$speak "Hello $name, we are going to have lots of fun."

while [ 1 ]
do
  word=$(shuf -n1 "lists/$level.txt")
  spell=""
  try=1
  while [ "$spell" = "" ]
  do
    echo -n ":"
    $speak "$name, please spell, $word.  If you would like me to repeat the word, just hit enter."
    read spell
    clear
    if [ "$spell" != "" ]
    then
      if [ "$word" = "$spell" ]
      then
        clear
        printf "${green}$word${nc}"
        echo ""
        $speak "Great job $name, you got it!  Press enter for your next word."
        spell=""
        word=$(shuf -n1 "lists/$level.txt")
        read junk
        clear
      else
        try=$((try + 1))
        clear

        for (( i=0; i<${#spell}; i++ )); do
          if [ "${spell:$i:1}" = "${word:$i:1}" ]
          then
            printf "${green}${spell:$i:1}${nc}"
          else
            printf "${red}${spell:$i:1}${nc}"
          fi
        done

        if [ "${#spell}" -lt "${#word}" ]
        then
          printf "${red}■${nc}"
        fi
        if [ $try -le 4 ]
        then
          echo ""
          echo -n ":"
          $speak "Good try, but some letters don't look right.  Press enter to try again."
          spell=""
          read junk
          clear
        else
          echo ""
          echo "$word"
          $speak "Something still does not look right.  Some times I can be hard to understand, sorry.  This was the spelling I was looking for."
          $speak "Press enter to try a different word."
          spell="$word"
          read junk
          clear
        fi
      fi
    fi


  done
done