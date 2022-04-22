#!/bin/bash -x
declare -A coin
coin[Heads]=0
coin[Tails]=0
i=0
read -p "How many times you want to flip the coin : " c
while [[ $i -ne $c ]]
do
	flipCoin=$((RANDOM%2))
	if [[ $flipCoin -eq 1 ]]
		then
			echo "Heads"
			((coin[Heads]++))
		else
			echo "Tails"
			((coin[Tails]++))
	fi
	((i++))
done
heads=${coin[Heads]}
tails=${coin[Tails]}
perHead=`echo $heads $c | awk '{print ($1/$2)*100}'`
perTail=`echo $tails $c | awk '{print ($1/$2)*100}'`
echo Heads appeared : $perHead"%" of the times
echo Tails appeared : $perTail"%" of the times
