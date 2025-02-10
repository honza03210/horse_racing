NAMES=('Silhai' 'PhAnt' 'kIk' 'ZuzKA' 'Bear' 'zA' 'Strip?' 'paj' 'joj' 'Voz')

if [[ $1 = 'gibstats' ]]; then
	./gibstats.sh
	exit
fi
DIST=40
while true ; do
	./horse_racing.sh $DIST 10 $2
	./gibstats.sh | tabulate -1 -f pipe;
	sleep 10;
done
