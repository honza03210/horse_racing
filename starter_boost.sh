NAMES=('lai' 'PhAnt' 'kIk' 'ZuzKA' 'Bear' 'zA' 'Strip?' 'paj' 'joj' 'Voz')

DIST=40
i=0;
while true ; do
	./horse_racing.sh $DIST 10 1
	i=$(($i + 1));
	if [ $(($i % 250)) -eq 0 ]; then
		clear
		./gibstats.sh | tabulate -1 -f pipe;
		i=$(($i - 249));
	fi;
done
