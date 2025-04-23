#!/bin/bash

colors=(
    "\033[38;5;214m"  # Orange doré, entre le jaune et le orange vif
    "\033[0;33m"  # Jaune
)

reset="\033[0m"

echo "Salutations aventuriers ! Avant de continuer, donne moi un nombre entre 1 et 20 inclus"
read number

if [ "$number" -gt 20 -o "$number" -lt 1 ];
then
echo "Ton nombre est hors limites !"
exit 1
fi

randomLine=$(( (RANDOM%number) + 1))

for (( i=1; i<=number; i++))
do
    space=$((number - i))
    for (( j=1; j<=space; j++))
    do
        echo -n " "
    done

    #color="\033[0;33m"
    color=${colors[((i-1) % ${#colors[@]})]}

    randomNumber=$(( (RANDOM%64) + 58))
    caracter="\x$randomNumber"

    symbol=$((2 * i - 1))
    randomColumn=$(( (RANDOM%symbol) +1))
    for (( k=1; k<=symbol; k++))
    do
        if [ "$i" -eq "$randomLine" -a "$k" -eq "$randomColumn" ];
            then
            echo -n -e "$color$caracter"
        else
            echo -n -e "$color*"
        fi
    done

    echo -e "$reset"
done

echo "Aventurier ! Trouve l'emplacement du caractère spécial pour gagner !"
echo "Indique le numéro de sa ligne :"
read lineAnswer

echo "Et sa colonne :"
read colAnswer

if [ "$lineAnswer" -eq "$randomLine" -a "$colAnswer" -eq "$randomColumn" ];
then
echo "Bravo tu as gagné ! A bientôt pour de nouvelles aventures !"

cols=$(tput cols)
lines=$(tput lines)

colors=(31 32 33 34 35 36 91 92 93 94 95 96)

chars=("*" "+" "o" "." "~" "#" "@")

tput civis

# Lancer les confettis
for ((i = 0; i < 200; i++)); do
    x=$((RANDOM % cols))
    y=$((RANDOM % lines))

    color=${colors[$RANDOM % ${#colors[@]}]}
    char=${chars[$RANDOM % ${#chars[@]}]}

    tput cup $y $x
    echo -ne "\033[1;${color}m$char\033[0m"

    sleep 0.02
done

tput cnorm
tput cup $lines 0

else
echo "Oh vous avez perdu ! Vous êtes désormais coincé dans la pyramide, relancez le jeu pour tenter de gagner !"
fi
