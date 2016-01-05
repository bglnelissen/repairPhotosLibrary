#!/bin/bash
# b. nelissen

ADMINUSER="basadmin"
PHOTOLIBRARYUSER="koekoek"
CURRENTDIR="$(dirname "$0")"
AANTALLIBRARIES="$(find "$CURRENTDIR" ! -perm -g+r,u+r,o+r -prune -name '*.photoslibrary' | wc -l | sed 's/[[:space:]]//g')"

quit(){
 read -n1 -rsp $'Druk op een toest om af te sluiten...\n'
 exit
}

clear
echo
echo "Start dit programma om de Koekoek foto bibliotheek te repareren."
echo "- Je mag dit programma alleen gebruiken op de laptop."
echo "- Het is de bedoeling dat je in OSX bent ingelogd als: Koekoek"
echo

if [ "$AANTALLIBRARIES" -ge 1 ]; then
	echo "Aantal photolibrary's gevonden: ${AANTALLIBRARIES}"
else
	echo "Geen foto bibliotheek gevonden!"
	echo "De huidige werkmap is: \"$CURRENTDIR\"."
	echo "Staat \"$(basename "$0")\" in de zelfde map als de \"photolibrary\"?"
	quit
fi

echo
if groups "$ADMINUSER" | grep -q -w admin; 
then 
	# show instructions
	echo "###################################"
	echo "We moeten enkele stappen doorlopen:"
	echo "Stap 1, inloggen als \"${ADMINUSER}\"."
	echo "Stap 2. Druk op 'Command V'."
	echo "###################################"
	ADMINCOMMAND="echo && echo 'Let op: De reparatie kan tot 30 minuten duren!' && echo 'login: "${ADMINUSER}"' && sudo chown -R ${PHOTOLIBRARYUSER} \""${CURRENTDIR}"\"/*.photoslibrary && echo 'login: "${ADMINUSER}"' && sudo chmod -R 700 \""${CURRENTDIR}"\"/*.photoslibrary && exit"
	# echo "${ADMINCOMMAND}"
	echo "${ADMINCOMMAND}"| pbcopy
	echo
	echo "login: ${ADMINUSER}"
	login "${ADMINUSER}"
else 
	# gebruiker is geen admin
    echo "Je wil inloggen als \"${ADMINUSER}\", maar deze gebruiker heeft geen admin rechten."
	quit
	# exit
fi

echo "Klaar"
echo
quit
# exit
