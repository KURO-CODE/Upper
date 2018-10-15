#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                           
#         ~ Upper ~                            
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Type: Automation 
# CoDeD: bY KURO-CODE
# DaTe: 10/15/2018
# Dev: Shell
# Ver: 1.0
#
#~~~~~~~~~~~~~~~~~ INFO ~~~~~~~~~~~~~~~~~~~~
#
# Automat.
#
#	+ Update
#   + upgrad
#   + Install 
#
#********************************************

#**** Version ****
Ver="1.0"

#**** Colors ****
W="\033[1;37m"
R="\033[1;31m"
G="\033[1;32m"
Y="\033[1;33m"
EC="\033[0m"

#~~~~ Logo ~~~~
function LOGO() {
	echo -e "${G}	 _   _                       
	| | | |                      
	| | | |_ __  _ __   ___ _ __ 
	| | | | '_ \| '_ \ / _ \ '__|
	| |_| | |_) | |_) |  __/ |   
 	 \___/| .__/| .__/ \___|_|   
	      | |   | |              
	      |_|   |_|${Y}  Ver:${Ver}${W}
	    "
}

#~~~~ Main Menu ~~~~
function Main() {
	Place="Main"
	clear
	LOGO
	echo -e """	~ M A I N  M E N U ~

	[${G}1${W}] Update
	[${G}2${W}] Upgrade
	[${G}3${W}] Install
	[${Y}9${W}] Info
	[${R}0${W}] Exit
	"""
	read -p " Option: " OPT 
	case $OPT in
		1) UPD; UPGD; Main;;
		2) UPG; Main;;
		3) Prog_Name; Check_Prog; Main;;
		9) INFO; Return;;
		0) EXIT;;
		*) clear; echo -e " [ERROR]"; sleep 3; clear; Main;;
	esac
}

function Prog_Name() {
	clear
	LOGO
	echo -e " ~  I N S T A L L E R  ~\n"
	read -p " Program name: " PROG
	Check_Prog
}

#~~~~ Update ~~~~
function UPD() {
	clear
	LOGO
	echo -e " Update system"
	sleep 3
	clear
	sudo apt update
}

#~~~~ Upgrade ~~~~
function UPG() {
	clear
	LOGO
	echo -e " Upgrade system"
	sleep 3
	clear
	sudo apt upgrade
}

#~~~~ Upgradable ~~~~
function UPGD() {
	clear
	LOGO
	echo -e "${G} Upgradable system"
	sleep 3
	clear
	apt list --upgradable > list.txt
	cat list.txt |sed 's/En train de lister…/ /g' > list2.txt
	N=`cat list2.txt |cut -f1 -d /`
	echo $N > list2.txt
	N2=`cat list2.txt`
	sudo apt install $N2
	Clean
	clear
	echo -e " Update finish..."
	sleep 3
}

#~~~~ Check ~~~~
function Check_Prog() {
	clear
	LOGO
	echo -e "	~  C H E C K  ~\n"
	echo -ne "${PROG}....."
	if ! hash ${PROG} 2>/dev/null; then
		echo -e "Not installed [${R}x${W}]${EC}"
		sleep 3
		clear
		Prog_Install
		Main
	else
		echo -e "Installed [${G}✔${W}]${EC}"
		sleep 3
		Main
	fi
}

#~~~~ Install ~~~~
function Prog_Install() {
	clear
	LOGO
	echo -e " Please wait, $PROG install..."
	sudo apt install $PROG
}

#~~~~ Clean ~~~~
function Clean() {
	rm -f list.txt
	rm -f list2.txt
}

#~~~~ Info ~~~~
function INFO() {
	clear
	LOGO
	echo -e "
${W}    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    ┃                           ┃
    ┃${G}   Name${W}: Upper             ┃
    ┃${G}   Date${W}: 10/15/2018        ┃
    ┃${G}   Type${W}: Automat           ┃
    ┃${G}   Dev${W}: Shell              ┃
    ┃${G}   Ver${W}: $Ver                ┃
    ┃${G}   Coder${W}: Kuro-Code        ┃
    ┃                           ┃
    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
}

#~~~~ Return ~~~~
function Return() {

	echo -e "${Y}  Return to Main menu, press ${R}[ENTER]${W}."
  	read -p ""
  	Main
}

#~~~~ Exit ~~~~
function EXIT() {
	clear
	LOGO
	echo -e " Closing Upper"
	sleep 2
	clear
	echo -e " Thanks for using Updater"
	sleep 3
	clear
	exit
}


#~~~~ Hard Exit ~~~~
function cap_traps() {
	case $Place in
		"Main") EXIT;;
		"INFO") EXIT;;
	esac 
}

for x in SIGINT SIGHUP INT SIGTSTP; do
	trap_cmd="trap \"cap_traps $x\" \"$x\""
	eval "$trap_cmd"
done

#~~~~ Start ~~~~
Main
