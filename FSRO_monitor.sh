#!/bin/bash
FS_TEST=/home/ubuntu/foobar
TWCC_PROJ_CODE={{PUT_YOUR_TWCC_PROJECT_CODE}}
TWCC_RES_ID={{PUT_YOUR_RESOURCE_ID_HERE}}
CMD_TOUCH=/bin/touch
CMD_LS=/bin/ls
CMD_RM=/bin/rm
CMD_CURL=/usr/bin/curl
LINE_TOKEN={{PUT_YOUR_LINE_TOKEN_HERE}}
function line
{
  STD_MESG="PROJ=$TWCC_PROJ_CODE\nMESG=$1"
  STD_MESG=$(cat << END_HEREDOC

[PROJ_CODE] $TWCC_PROJ_CODE, in $TWCC_RES_ID
>>> $1
END_HEREDOC
)
  echo $STD_MESG
  $CMD_CURL -X POST \
    https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_TOKEN" \
    -d "message=$STD_MESG" \
    -d "stickerPackageId=1" \
    -d "stickerId=3"
}  

$CMD_TOUCH $FS_TEST || line "touch failed"
$CMD_LS -al $FS_TEST || line "ls failed"
$CMD_RM -f $FS_TEST || line "rm failed"
