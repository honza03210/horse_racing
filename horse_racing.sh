
# less than 1 argument
if [ $# -lt 1 ]; then 
	echo './nazevhry [delka trate] [optional: printout (0 for supress output)]';
	exit -1;
fi;

horse_upper=' ___/\'
horse_lower='/\ /\'

NAMES=('Silhai' 'PhAnt' 'kIk' 'ZuzKA' 'Bear' 'zA' 'Strip?' 'paj' 'joj' 'Voz')

# NAMES are read from player_names.txt - each name on its own line
NAMES=()
HORSES=()
while IFS= read -r line; do
    NAMES+=$line
    HORSES+=0
done<player_names.txt

HORSE_COUNT=${#NAMES[@]}
DISTANCE=$1

# amazing formatting in bash :)
FORMAT_START='\033[0;';
FORMAT_COLOR=$(($RANDOM % 8 + 30));

if [ $# -eq 1 ] || [ $2 -eq 0 ]; then
	echo -e ${FORMAT_START}${FORMAT_COLOR}m;
fi

HASWINNER=0
while [ $HASWINNER -eq 0 ]; do
	SELECTED_HORSE=$(($RANDOM % $HORSE_COUNT));
	HORSES[$SELECTED_HORSE]=$((${HORSES[$SELECTED_HORSE]} + 1));
 
	if [ ${HORSES[$SELECTED_HORSE]} -eq $DISTANCE ]; then
		HASWINNER=1;
	fi;
 
	if [ $# -eq 2 ] || [ $2 -eq 0 ]; then

        # single 'frame' of the race
		sleep 0.1;
		clear;

        # finds leader(s), they will have bold text
		MAX_SCORE='0'
		for ((i=0; i<$(($HORSE_COUNT)); i++)); do
			CURR_HORSE_SCORE=${HORSES[$HORSE_INDEX]}
		done
  
		for ((HORSE_INDEX=0; HORSE_INDEX<$(($HORSE_COUNT)); HORSE_INDEX++)); do
			FORMAT_START='\033[0;';
			if [[ ${HORSES[$HORSE_INDEX]} -eq $MAX_SCORE ]]; then
				FORMAT_START='\033[1;';
			fi;
   
			echo -n -e $FORMAT_START$(($HORSE_INDEX % 8 + 31))m
            # change if names longer than 10 chars are used
			printf '%10s  ' ${NAMES[$HORSE_INDEX]}
			CURR_HORSE_SCORE=${HORSES[$HORSE_INDEX]}
			for ((i=0; i<$CURR_HORSE_SCORE; i++)); do
                # the horses are rainbow powered :O
				echo -n -e $FORMAT_START$(($RANDOM % 8 + 31))m
				echo -n '=';
			done;
   
			echo -n -e $FORMAT_START$(($HORSE_INDEX % 8 + 31))m
			echo $horse_upper
			OFFSET=$(($CURR_HORSE_SCORE + 12))
			for ((z=0; z<$OFFSET; z++)); do
				echo -n ' '
			done;
			echo $horse_lower;
   
			if [[ $CURR_HORSE_SCORE -eq $MAX_SCORE ]]; then
                echo -e -n '\e[0m';
            fi;
		done;
	fi;
done;

if [ $# -eq 1 ] || [ $2 -eq 0 ]; then
	printf '\n\033[0;35mVyhral(a) %s JUPIIIII\e[0m\n\n' ${NAMES[$SELECTED_HORSE]}
fi;

echo '1'>>${NAMES[$SELECTED_HORSE]}.wins;

for ((i=0; i<$(($HORSE_COUNT)); i++)) do
	echo ${HORSES[$i]}>>${NAMES[$i]}.score
done

exit $SELECTED_HORSE
