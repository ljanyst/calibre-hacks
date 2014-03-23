#!/bin/bash

#-------------------------------------------------------------------------------
# Process commandline params
#-------------------------------------------------------------------------------
if [ $# -ne 2 ]; then
  echo "[!] Usage: $0 recipe_directory you@free.kindle.com"
  exit 1
fi

if [[ "$1" = /* ]]
then
  RECIPEDIR="$1"
else
  RECIPEDIR="`pwd`/$1"
fi

#-------------------------------------------------------------------------------
# Verify input
#-------------------------------------------------------------------------------
RECIPE=$RECIPEDIR/input.recipe
EMAIL=$2
COVER=$RECIPEDIR/cover.png
RESULT="`mktemp --suffix=.mobi`"
PASSWORDFILE=$RECIPEDIR/password
USERNAMEFILE=$RECIPEDIR/username
ISSUEFILE=$RECIPEDIR/issue

if [ ! -x `which mpack` ]; then
  echo "[!] Unable to find mpack"
  exit 1
fi

COMMAND="ebook-convert"
if [ ! -x `which ebook-convert` ]; then
  echo "[!] Unable to find ebook-convert script, please install calibre"
  exit 1
fi

if [ ! -r $RECIPE ]; then
  echo "[!] Recipe not found: $RECIPE"
  exit 2
fi
COMMAND="$COMMAND $RECIPE $RESULT"

if [ -r $USERNAMEFILE ]; then
  COMMAND="$COMMAND --username=\"`cat $USERNAMEFILE`\""
fi

if [ -r $PASSWORDFILE ]; then
  COMMAND="$COMMAND --password=\"`cat $PASSWORDFILE`\""
fi

if [ -r $ISSUEFILE ]; then
  COMMAND="$COMMAND --journal-download-issue=`cat $ISSUEFILE`"
fi

if [ -r $COVER ]; then
  COMMAND="$COMMAND --journal-cover=\"$COVER\""
fi

#-------------------------------------------------------------------------------
# Run the show
#-------------------------------------------------------------------------------
echo $COMMAND
eval $COMMAND

if [ $? -ne 0 ]; then
  exit 3
fi

mpack $RESULT -s "ebook" $EMAIL

if [ $? -ne 0 ]; then
  exit 4
fi

echo "[i] Successfuly sent to $EMAIL"
