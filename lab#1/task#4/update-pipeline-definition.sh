#!/usr/bin/env bash

# Q: How to work with long params and get it's value
file=$1
configmode=$3
owner=$5
branch=$7
poll=$9

# Tasks
# Read long properties not depend on posistion -
# Delete +
# Increment value +
# Replace whole values by key +
# Replace part of value - 
cat $file | jq 'del(.metadata)' | jq '.pipeline.version += 1' | jq --arg branch "$branch" '.pipeline.stages[].actions[].configuration."Branch" = $branch' |  jq --arg owner "$owner" '.pipeline.stages[].actions[].configuration."Owner" = $owner' | jq --arg poll "$poll" '.pipeline.stages[].actions[].configuration."PollForSourceChanges" = $poll' | jq '.pipeline.stages[].actions[].configuration."EnvironmentVariables"' > updated.json

# Q: Can't replace part of the sring below
variable=$(cat $file | jq '..|objects|select(has("EnvironmentVariables"))|.EnvironmentVariables');
replace="{{BUILD_CONFIGURATION value}}" 
updatedVariable=${$variable/$replace/$configmode}



