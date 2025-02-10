NAMES=('Silhai' 'PhAnt' 'kIk' 'ZuzKA' 'Bear' 'zA' 'Strip?' 'paj' 'joj' 'Voz')

printf 'Vyhry Jmeno Prumerne\n'
GAMES_TOTAL=0
for name in ${NAMES[@]}; do
        touch $name.wins
        while IFS= read -r line; do
                GAMES_TOTAL=$((GAMES_TOTAL + line))
        done<$name.wins
done
for name in ${NAMES[@]}; do
        CURR_SUM=0
        CURR_WINS=0
        touch $name.score
        touch $name.wins
        while IFS= read -r line; do
                CURR_WINS=$((CURR_WINS + line));
        done < $name.wins
        while IFS= read -r line; do
                CURR_SUM=$((CURR_SUM + line));
        done < $name.score
        avg=$(echo $CURR_SUM '/' $GAMES_TOTAL | bc -l)
        echo $CURR_SUM > $name.score
        echo $CURR_WINS > $name.wins
        printf '%d %s %.5fcm\n' $CURR_WINS $name $avg

done
exit
