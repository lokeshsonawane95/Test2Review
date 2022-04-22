#!/bin/bash
start=100
won=0
lose=0
while [[ $start -ne 0 && $start -ne 200 ]]
do
	gamble=$((RANDOM%2))
	if [[ $gamble -eq 1 ]]
		then
			((won++))
			((start++))
		else
			((lose++))
			((start--))
	fi
done
echo Total win : $won
echo Total losses : $lose
if [[ $start -eq 200 ]]
	then
		echo "Goal reached, total money : $start"
	else
		echo "Gone broke, total money : $start"
fi
