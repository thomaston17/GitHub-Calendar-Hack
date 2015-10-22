#!/bin/bash

COMMITS_PER_DAY=$1
TOTAL_DAYS=$2

if [ ! -d commits_hack ]
  then
    mkdir commits_hack
    cd commits_hack
    git init
    touch fake_commits.txt
  else
    cd commits_hack
fi

DAYS_COMMITTED=0
COMMITED_PER_DAY=0
NEW_DATE=$(date +"%a %b %d %H:%M:%S %Y %z")
echo $TOTAL_DAYS "days with" $COMMITS_PER_DAY "commits per day."> fake_commits.txt
while [ $COMMITED_PER_DAY -lt $COMMITS_PER_DAY ]
  do
    while [ $DAYS_COMMITTED -lt $TOTAL_DAYS ]
      do
        NEW_DATE=$(date -v -"$DAYS_COMMITTED"d +"%a %b %d %H:%M:%S %Y %z")
        echo $NEW_DATE >> fake_commits.txt
        git add -A
        git commit -m "$NEW_DATE" --date="$NEW_DATE"
        DAYS_COMMITTED=$[ $DAYS_COMMITTED+1 ]
      done
      DAYS_COMMITTED=0
      COMMITED_PER_DAY=$[ $COMMITED_PER_DAY+1 ]
  done

cd ..
