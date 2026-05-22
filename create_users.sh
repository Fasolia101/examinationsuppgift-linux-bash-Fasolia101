#!/bin/bash

# kollar om man är root
if [ $EUID -ne 0 ]; then
 echo "du måste vara root"
 exit
fi

# loopar igenom alla användare
for user in "$@"
do

 # skapar användaren
 useradd -m $user

 # skapar mappar
 mkdir /home/$user/Documents
 mkdir /home/$user/Downloads
 mkdir /home/$user/Work

 # rättigheter
 chmod 700 /home/$user/Documents
 chmod 700 /home/$user/Downloads
 chmod 700 /home/$user/Work

 # welcome fil
 echo "Välkommen $user" > /home/$user/welcome.txt

 echo "" >> /home/$user/welcome.txt
 echo "Andra användare:" >> /home/$user/welcome.txt

 # skriver alla användare
 cut -d: -f1 /etc/passwd >> /home/$user/welcome.txt

 # rätt ägare
 chown -R $user:$user /home/$user

 echo "$user skapad"

done
