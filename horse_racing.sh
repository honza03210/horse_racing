
horse=' ___/\'
horse2='/\ /\'

if [ $# -lt 2 ]; then
	echo './nazevhry [delka trate] [pocet koni] [optional: printout (0 for supress output)]';
	exit -1;
fi;
NAMES=('Silhai' 'PhAnt' 'kIk' 'ZuzKA' 'Bear' 'zA' 'Strip?' 'paj' 'joj' 'Voz')
HORSES=()
for ((i=0; i<$2; i++)){
	HORSES+=0
}

bold=$(tput bold)
normal=$(tput sgr0)
LOOLDEF='\033[0;';
LOOLCOLOR=$(($RANDOM % 8 + 30));
if [ $# -eq 2 ] || [ $3 -eq 0 ]; then
	echo -e ${LOOLDEF}${LOOLCOLOR}m;
fi
HASWINNER=0


while [ $HASWINNER -eq 0 ]; do
	SELECTED_HORSE=$(($RANDOM % $2));
	HORSES[$SELECTED_HORSE]=$((${HORSES[$SELECTED_HORSE]}+1));
	if [ ${HORSES[$SELECTED_HORSE]} -eq $1 ]; then
		HASWINNER=1;
	fi;
	if [ $# -eq 2 ] || [ $3 -eq 0 ]; then
		sleep 0.1;
		clear;
		MAX_SCORE='0'
		for ((i=0; i<$(($2));i++)); do
			P=${HORSES[$i]}
			MAX_SCORE=$((P > $MAX_SCORE ? P : $MAX_SCORE))	
		done
		for ((i=0; i<$(($2));i++)); do
			LOOLDEF='\033[0;';
			if [[ ${HORSES[$i]} -eq $MAX_SCORE ]]; then
				LOOLDEF='\033[1;';
			fi;
			echo -n -e $LOOLDEF$((i % 8 + 31))m
			printf '%10s  ' ${NAMES[$i]}
			HAHA=${HORSES[$i]}
			for ((size=0; size<HAHA;size++)); do
				echo -n -e $LOOLDEF$(($RANDOM % 8 + 31))m
				echo -n '=';
				
			done;
			echo -n -e $LOOLDEF$((i % 8 + 31))m
			echo $horse
			DAFUK=$(($HAHA + 12))
			for ((LOLXD=0; LOLXD<DAFUK; LOLXD++)); do
				echo -n ' '
			done;
			echo $horse2
			if [[ ${HORSES[$i]} -eq $MAX_SCORE ]]; then
                        	echo -e -n '\e[0m';
                	fi;
		done;
	fi;
done;
if [ $# -eq 2 ] || [ $3 -eq 0 ]; then
	printf '\n\033[0;35mVyhral(a) %s JUPIIIII\e[0m\n\n' ${NAMES[$SELECTED_HORSE]}
fi;

echo '1'>>${NAMES[$SELECTED_HORSE]}.wins;

for ((i=0; i<$(($2)); i++)) do
	echo ${HORSES[$i]}>>${NAMES[$i]}.score
done

exit $SELECTED_HORSE
