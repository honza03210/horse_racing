NAMES=()
while IFS= read -r line; do
    line=$(echo "$line" | tr -d '\r')  # Remove carriage return (Windows newline)
    NAMES+=("$line")
done<player_names.txt

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
