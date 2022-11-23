#!/bin/bash
thread_num=(1 2 3 4 8 16 24 32)
FILE="./MT_matrix"
PATH_BENCH="Test_case_*"
KEY_WORD="real"
RESULT_FILE="record_time.txt"

rm $RESULT_FILE
touch $RESULT_FILE
sudo make unload
make clean
make all
#gcc -o MT_matrix MT_matrix.c -lpthread
rm tmp
touch tmp
echo "--------------------------"
echo "Start running test case"
for j in ${PATH_BENCH}
do
    echo "====${j}====" | tee -a $RESULT_FILE
    for i in ${thread_num[@]}
    do
        make load
        echo "--> running in $i num of thread" | tee -a $RESULT_FILE
                { time $FILE $i $j/m1.txt $j/m2.txt ; } 2> tmp
                cat tmp | grep $KEY_WORD | tee -a $RESULT_FILE
        make unload
    done

done
rm tmp
