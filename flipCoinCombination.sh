#!/bin/bash
declare -A coin1
declare -A coin2
declare -A coin
declare -A winner
forallCount=0
coin1[H]=0
coin1[T]=0
coin2[HH]=0
coin2[HT]=0
coin2[TH]=0
coin2[TT]=0
coin[HHH]=0
coin[HHT]=0
coin[HTH]=0
coin[HTT]=0
coin[THH]=0
coin[THT]=0
coin[TTH]=0
coin[TTT]=0
read -p "How many times you want to flip the coin : " c
single=$c
double=$c
triple=$c
echo Singlet [ H T ]
i=0
while [[ $i -ne $single ]]
do
	flip=$((RANDOM%2))
	if [[ $flip -eq 1 ]]
		then
			echo "H"
			((coin1[H]++))
		else
			echo "T"
			((coin1[T]++))
	fi
	((i++))
done

i=("H" "T")
for i1 in  ${i[@]}
do
	location="$i1"
	coin1[$location]=`echo ${coin1["$location"]} $single | awk '{print (($1/$2)*100)}'`
	forall[forallCount++]=${coin1[$location]}
	echo $location is appeared : ${coin1["$location"]}"%" of the times
done

win=${coin1[HH]}
for value in ${coin1[@]}
do
	if [[ `echo $value $win | awk '{if($1>$2) print 1}'` ]]
		then
			win=$value
	fi
done
echo Winning combination is : $win"%"
winner[singlet]=$win

echo ---------------------------------------------------------------------------------
echo doublet [ HH HT TH TT ]
i=0
while [[ $i -ne $double ]]
do
	flip1=$((RANDOM%2))
	flip2=$((RANDOM%2))
	if [[ $flip1 -eq 1 && $flip2 -eq 1 ]]
		then
			echo "HH"
			((coin2[HH]++))
		elif [[ $flip1 -eq 1 && $flip2 -eq 0 ]]
			then
			echo "HT"
			((coin2[HT]++))
		elif [[ $flip1 -eq 0 && $flip2 -eq 1 ]]
            then
            echo "TH"
            ((coin2[TH]++))
		else
			echo "TT"
			((coin2[TT]++))
	fi
	((i++))
done

i=("H" "T")
j=("H" "T")
for i1 in  ${i[@]}
do
	for j1 in ${j[@]}
	do
		location="$i1$j1"
		coin2[$location]=`echo ${coin2["$location"]} $double | awk '{print (($1/$2)*100)}'`
		forall[forallCount++]=${coin2[$location]}
		echo $location is appeared : ${coin2["$location"]}"%" of the times
	done
done

win=${coin2[HH]}
for value in ${coin2[@]}
do
	if [[ `echo $value $win | awk '{if($1>$2) print 1}'` ]]
		then
			win=$value
	fi
done

echo Winning combination is : $win"%"
winner[doublet]=$win
echo ---------------------------------------------------------------------------------
echo Triplet [ HHH HHT HTH HTT THH THT TTH TTT]
i=0
while [[ $i -ne $triple ]]
do
	flip1=$((RANDOM%2))
	flip2=$((RANDOM%2))
	flip3=$((RANDOM%2))
	if [[ $flip1 -eq 1 && $flip2 -eq 1 && $flip3 -eq 1 ]]
		then
			echo "HHH"
			((coin[HHH]++))
		elif [[ $flip1 -eq 1 && $flip2 -eq 1 && $flip3 -eq 0 ]]
			then
			echo "HHT"
			((coin[HHT]++))
		elif [[ $flip1 -eq 1 && $flip2 -eq 0 && $flip3 -eq 1 ]]
            then
            echo "HTH"
            ((coin[HTH]++))
		elif [[ $flip1 -eq 1 && $flip2 -eq 0 && $flip3 -eq 0 ]]
            then
            echo "HTT"
            ((coin[HTT]++))
		elif [[ $flip1 -eq 0 && $flip2 -eq 1 && $flip3 -eq 1 ]]
            then
            echo "THH"
            ((coin[THH]++))
		elif [[ $flip1 -eq 0 && $flip2 -eq 1 && $flip3 -eq 0 ]]
            then
            echo "THT"
            ((coin[THT]++))
		elif [[ $flip1 -eq 0 && $flip2 -eq 0 && $flip3 -eq 1 ]]
            then
            echo "TTH"
            ((coin[TTH]++))
		else
			echo "TTT"
			((coin[TTT]++))
	fi
	((i++))
done
i=("H" "T")
j=("H" "T")
k=("H" "T")
for i1 in  ${i[@]}
do
	for j1 in ${j[@]}
	do
		for k1 in ${k[@]}
		do
			location="$i1$j1$k1"
			coin[$location]=`echo ${coin["$location"]} $triple | awk '{print (($1/$2)*100)}'`
			forall[forallCount++]=${coin[$location]}
			echo $location is appeared : ${coin["$location"]}"%" of the times
		done
	done
done
win=${coin[HHH]}
for value in ${coin[@]}
do
	if [[ `echo $value $win | awk '{if($1>$2) print 1}'` ]]
		then
			win=$value
	fi
done

echo Winning combination is : $win"%"
winner[triplet]=$win
echo ---------------------------------------------------------------------------------
echo "Array is : ${forall[@]}"
for((i=0; i<(${#forall[@]}-1); i++))
do
	swapped=0
	for((j=0; j<(${#forall[@]}-i-1); j++))
	do
		if [[ `echo ${forall[j]} ${forall[j+1]} | awk '{if($1>$2)print 1}'` ]]
			then
				temp=${forall[j]}
				forall[j]=${forall[j+1]}
				forall[j+1]=$temp
				swapped=1
		fi
	done
	if [[ $swapped -eq 0 ]]
		then
			break
	fi
done
echo "Sorted combination percentages are : ${forall[@]}"
len=${#forall[@]}

echo ---------------------------------------------------------------------------------
max=${forall[13]}
case $max in
	${coin1[H]})
		echo "Singlet key H is the winner with the appearing value of $max%"
	;;
	${coin1[T]})
		echo "Singlet key T is the winner with the appearing value of $max%"
	;;
	${coin2[HH]})
		echo "Doublet key HH is the winner with the appearing value of $max%"
	;;
	${coin2[HT]})
		echo "Doublet key HT is the winner with the appearing value of $max%"
	;;
	${coin2[TH]})
		echo "Doublet keyTHH is the winner with the appearing value of $max%"
	;;
	${coin2[TT]})
		echo "Doublet key TT is the winner with the appearing value of $max%"
	;;
	${coin[HHH]})
		echo "Triplet key HHH is the winner with the appearing value of $max%"
	;;
	${coin[HHT]})
		echo "Triplet key HHT is the winner with the appearing value of $max%"
	;;
	${coin[HTH]})
		echo "Triplet key HTH is the winner with the appearing value of $max%"
	;;
	${coin[HTT]})
		echo "Triplet key HTT is the winner with the appearing value of $max%"
	;;
	${coin[THH]})
		echo "Triplet key THH is the winner with the appearing value of $max%"
	;;
	${coin[THT]})
		echo "Triplet key THT is the winner with the appearing value of $max%"
	;;
	${coin[TTH]})
		echo "Triplet key TTH is the winner with the appearing value of $max"
	;;
	${coin[TTT]})
		echo "Triplet key TTT is the winner with the appearing value of $max"
	;;
esac