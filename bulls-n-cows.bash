#!/bin/bash

# ===============================================================================
# MIT License
#
# Copyright (c) 2023 Timofei302
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ===============================================================================

echo " +---------------------------------------------+"
echo " |                                             |"
echo " |      Welcome to Bulls & Cows at Bash        |"
echo " |                    Developer: Timofei302    |"
echo " |                                             |"
echo " |  https://github.com/timofei302/bulls-n-bash |"
echo " |      This program is distributed under      |"
echo " |        the terms of the MIT license.        |"
echo " |                                             |"
echo " +---------------------------------------------+"
echo ""
echo "To exit the game, write \"exit\" without quotes"
echo ""

n1=$(($RANDOM % 9))
n2=$(($RANDOM % 9))
n3=$(($RANDOM % 9))
n4=$(($RANDOM % 9))

WINNUM="$n1$n2$n3$n4"
GAVEUP=0
ATTEMPT=1

while true
do
    echo "Attempt number $ATTEMPT"
    read -p "Enter a number: " NUMBER
    COWS=0
    BULLS=0

    if [[ $NUMBER == 'exit' ]]; then
        GAVEUP=1
        break
    fi

    if ! [[ $NUMBER =~ ^[0-9]+$ ]]; then
        echo "It's not a number!"
    elif ! [[ "${#NUMBER}" == '4' ]]; then
        echo "There are not 4 digits in this number!"
    else
        if [[ "$NUMBER" == "$WINNUM" ]]; then
            break
        else
            for ((i=0; i<4; i++))
            do
                if [[ "${NUMBER:$i:1}" == "${WINNUM:$i:1}" ]]; then
                    ((BULLS++))
                fi
            done

            # Determining the number of cows
            if ! [[ "${NUMBER:0:1}" == "${WINNUM:0:1}" ]]; then
                for ((i=0; i<4; i++))
                do
                    if [[ "$i" == '0' ]]; then ((i++)); fi
                    if [[ "${NUMBER:$i:1}" == "${WINNUM:0:1}" ]]; then
                        ((COWS++))
                        break
                    fi
                done
            fi
            if ! [[ "${NUMBER:1:1}" == "${WINNUM:1:1}" ]]; then
                for ((i=0; i<4; i++))
                do
                    if [[ "$i" == '1' ]]; then ((i++)); fi
                    if [[ "${NUMBER:$i:1}" == "${WINNUM:1:1}" ]]; then
                        ((COWS++))
                        break
                    fi
                done
            fi
            if ! [[ "${NUMBER:2:1}" == "${WINNUM:2:1}" ]]; then
                for ((i=0; i<4; i++))
                do
                    if [[ "$i" == '2' ]]; then ((i++)); fi
                    if [[ "${NUMBER:$i:1}" == "${WINNUM:2:1}" ]]; then
                        ((COWS++))
                        break
                    fi
                done
            fi
            if ! [[ "${NUMBER:3:1}" == "${WINNUM:3:1}" ]]; then
                for ((i=0; i<4; i++))
                do
                    if [[ "$i" == '3' ]]; then break; fi
                    if [[ "${NUMBER:$i:1}" == "${WINNUM:3:1}" ]]; then
                        ((COWS++))
                        break
                    fi
                done
            fi

            echo ""
            echo " +--------------+"
            echo " | Number: $NUMBER |"
            echo " | Cows: $COWS      |"
            echo " | Bulls: $BULLS     |"
            echo " +--------------+"
            echo ""
            ((ATTEMPT++))
        fi
    fi
done

if [[ $GAVEUP == 0 ]]; then
    echo ""
    echo " +---------------------------------------------+"
    echo " |                                             |"
    echo " |                  YOU WIN!                   |"
    echo " |                                             |"
    echo " +---------------------------------------------+"
    echo ""
    echo " -> The hidden number: $WINNUM"
    echo " -> Attempts spent: $ATTEMPT"
    echo ""
else
    echo ""
    echo " +---------------------------------------------+"
    echo " |                                             |"
    echo " |                YOU GAVE UP!                 |"
    echo " |                                             |"
    echo " +---------------------------------------------+"
    echo ""
    echo " -> The hidden number: $WINNUM"
    echo ""
fi
