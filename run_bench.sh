#!/bin/bash
thread_num=(1 2 3 4 8 16 24 32)
FILE="./MT_matrix"
PATH_BENCH="Test_case_1"
KEY_WORD="real"
RESULT_FILE="record_time.txt"

rm $RESULT_FILE
touch $RESULT_FILE

#read -s -p "Enter Password for sudo: " sudoPW
#echo "good"
#echo $sudoPW | sudo make unload
#make clean
#make all

make mt
touch tmp
echo "--------------------------"
echo "Start running test case"
for j in ${PATH_BENCH}
do
    echo "====${j}====" | tee -a $RESULT_FILE
    for i in ${thread_num[@]}
    do
        echo "--> running in $i num of thread" | tee -a $RESULT_FILE
		{ time $FILE $i $j/m1.txt $j/m2.txt ; } 2> tmp 
		cat tmp | grep $KEY_WORD | tee -a $RESULT_FILE
    done
    
done
rm tmp
