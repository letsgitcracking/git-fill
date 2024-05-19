#!/bin/bash

# Check if the start and end dates were passed as arguments
if [ $# -ne 3 ]; then
    echo "Usage: ./script.sh <start date> <end date> <commit level>"
    echo "Both dates should be in the format YYYY-MM-DD."
    echo "Commit level can be low, medium, or high."
    exit 1
fi

# Get the start and end dates from the command line arguments
START_DATE=$1
END_DATE=$2

# Check if the end date is in the future
TODAY=$(date -I)
if [[ "$END_DATE" > "$TODAY" ]]; then
    echo "Error: The end date cannot be in the future."
    exit 1
fi

# Get the commit level from the command line argument
COMMIT_LEVEL=$3

# Set the range of commits based on the commit level
if [[ "$COMMIT_LEVEL" == "low" ]]; then
    WEEKDAY_COMMIT_MIN=1
    WEEKDAY_COMMIT_MAX=3
    WEEKEND_COMMIT_MIN=0
    WEEKEND_COMMIT_MAX=1
elif [[ "$COMMIT_LEVEL" == "medium" ]]; then
    WEEKDAY_COMMIT_MIN=1
    WEEKDAY_COMMIT_MAX=5
    WEEKEND_COMMIT_MIN=0
    WEEKEND_COMMIT_MAX=2
elif [[ "$COMMIT_LEVEL" == "high" ]]; then
    WEEKDAY_COMMIT_MIN=2
    WEEKDAY_COMMIT_MAX=9
    WEEKEND_COMMIT_MIN=0
    WEEKEND_COMMIT_MAX=2
else
    echo "Error: Invalid commit level. Please choose low, medium, or high."
    exit 1
fi

# Path to your Git repository
REPO_PATH=$(pwd)

# Name of the file to be modified
FILENAME="git-fill-$START_DATE-$END_DATE.txt"

# Generate dates from START_DATE to END_DATE
d=$(date -I -d "$START_DATE") || exit -1
END_DATE=$(date -I -d "$END_DATE + 1 day") # Adjust end date to be inclusive

while [ "$d" != "$END_DATE" ]; do
    # Get the day of the week (1 for Sunday, 7 for Saturday)
    day_of_week=$(date -d "$d" +%u)
    day_of_week=$((day_of_week % 7 + 1)) # Adjust to GitHub's week representation

    if ((day_of_week > 1)) && ((day_of_week < 7)); then
        commits=$((RANDOM % (WEEKDAY_COMMIT_MAX - WEEKDAY_COMMIT_MIN + 1) + WEEKDAY_COMMIT_MIN))
    else
        commits=$((RANDOM % (WEEKEND_COMMIT_MAX - WEEKEND_COMMIT_MIN + 1) + WEEKEND_COMMIT_MIN))
    fi

    for ((i=1;i<=commits;i++)); do
        echo "$d commit $i" >> $REPO_PATH/$FILENAME

        # Commit the file to the Git repository
        cd $REPO_PATH
        git add $FILENAME
        export GIT_COMMITTER_DATE="$(date --rfc-2822 -d "$d")"
        git commit --date "$(date --rfc-2822 -d "$d")" -m "Commit $i for $d"
    done

    d=$(date -I -d "$d + 1 day")
done