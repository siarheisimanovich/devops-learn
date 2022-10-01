#!/usr/bin/env bash

file=$1

while [ "$#" -gt 1 ]; do
    if [[ $2 == *"--"* ]]; then
        if [[ $2 = '--poll-for-source-changes' ]]; then
            param='poll'
        else
            param="${2/--/}"
        fi
        declare $param="$3"
        
        #echo $2 $3 // Optional to see the parameter:value result
   fi
  shift
done

# Tasks
# Read long properties not depend on posistion +
# Delete +
# Increment value +
# Replace whole values by key +
# Replace part of value +
env_config=$(cat $file | jq --arg configuration "$configuration"  '..|objects|select(has("EnvironmentVariables")) | .EnvironmentVariables | fromjson | .[0].value = $configuration | tojson' | head -n 1);
cat $file | jq 'del(.metadata)' | jq '.pipeline.version += 1' | jq --arg branch "$branch" '.pipeline.stages[].actions[].configuration."Branch" = $branch' |  jq --arg owner "$owner" '.pipeline.stages[].actions[].configuration."Owner" = $owner' | jq --arg poll "$poll" '.pipeline.stages[].actions[].configuration."PollForSourceChanges" = $poll'  | jq -r --arg env_config "$env_config"  '.pipeline.stages[].actions[].configuration."EnvironmentVariables" = $env_config' > updated.json




