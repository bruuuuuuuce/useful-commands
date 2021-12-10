#!/bin/bash

# port forward local port to aws ec2 instance
aws ssm start-session --target i-0c426c361856bfb40 --document-name AWS-StartPortForwardingSession
--parameters '{"portNumber":["4646"], "localPortNumber":["4646"]}'

# send remote command via aws ssm
sh_command_id=$(aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --targets "Key=tag:Name,Values=instanceName" \
    --parameters '{"commands":["/script-on-box-to-run.sh"]}' \
    --output text --query "Command.CommandId")
sleep 2
# get command output
aws ssm list-command-invocations \
    --command-id "$sh_command_id" \
    --details

