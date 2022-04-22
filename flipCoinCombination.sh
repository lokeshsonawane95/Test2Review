#!/bin/bash
flipCoin=$((RANDOM%2))
if [[ $flipCoin -eq 1 ]]
	then
		echo "Heads"
	else
		echo "Tails"
fi
