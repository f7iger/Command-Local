#!/bin/bash


##
# CmdLocal.sh 
#	Adds the current directory to be viewed globally by the terminal
#	USE: ./CmdLocal.sh 
# 	AUTHOR: @f7iger 
#
# TURN THE COMMAND AS A SUPER USER (ROOT)
# Doubts? Read the Help file → ".HELP.txt" ou contact me on github 
##

# ++ VARS BASIC ++
ROTA=`pwd`
FLOG="CmdLocal$(date +%d·%m·%y)[LOGFILE].log"
MINEXE="[`date +%H:%M`]"
USUARIO="[$USER]"
BB="bash.bashrc"
add(){
		echo "PATH=\""$PATH":"$ROTA"\"" >> /etc/bash.bashrc 
		if [ $(echo $?) -eq 0 ]
		then
			echo "Your script directory is now global!"
			echo "Please start a new session in the terminal or open a new window"
		else
			echo "$USUARIO $MINEXE Script execution ERROR. Run as root" >> $FLOG
			echo "Run as ROOT"
			exit 2
		fi
			return 0
}


remover(){
	if ls -ltr |grep -i "[cC]md[lL]ocal.sh" ;
	then 
		rm -rf '[cC]md[lL]ocal.sh'
	fi
	return 0
}

remover_log(){
	echo "Preparing to remove Log's files ... "
	for i in `ls -l|grep "LOGFILE" |awk -F " " '{print $9}'`
	do
		echo "Excluding $i"
		rm -rf $i  
		sleep 2
	done
	echo "Deleted log file"
	return 0
}

echo "$USUARIO $MINEXE +++ Starting the Script CmdLocal. +++" >> $FLOG
case $1 in
        -rl)
                remover_log
                ;;
         -r)
                echo "$USUARIO $MINEXE Searching for the script and deleting it" >> $FLOG
                remover
                ;;
         -h)
                less HELP.txt
                ;;
esac
# Mnt Script
echo "$USUARIO $MINEXE Looking for the bash.bashrc file..." >> $FLOG  
if find /etc -type f -name "$BB" 2> /dev/null |grep "$BB" > /dev/null ;
then
	echo "$USUARIO $MINEXE file bash.bashrc found." >> $FLOG
	if grep -i "$ROTA" /etc/bash.bashrc >> /dev/null ; 
	then 
		echo "$USUARIO $MINEXE Scripts directory already added." >> $FLOG
		echo "Command is already in the PATH"
	else
		add
		echo "$USUARIO $MINEXE Added sucesfull." >> $FLOG
		echo "$USUARIO $MINEXE Process ended with exit code 0." >> $FLOG
		exit 0 
	fi
fi
echo "$USUARIO $MINEXE Script successfully executed." >> $FLOG
exit 0
