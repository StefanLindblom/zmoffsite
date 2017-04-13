#!/bin/bash

# Configuration

# Where are your incoming files landing
BASEDIR=/home/zm
# Specify file extension, expecting .tar
TARFILES=$BASEDIR"/*.tar"
# Target folder for untar'ed directories + files
TARGETDIR=$BASEDIR"/untar"
# Debug log location
DEBUGLOG=$BASEDIR"/debug.log"
# Example TAR structure: /usr/share/zoneminder/www/events/2/17/04/13/14/59/48/
# The value 5 will remove /usr/share/zoneminder/www/events/
DIRLEVELSTOREMOVE=5

# Doesn't need to be changed
DATE=$(date)

# Before we start, check if there are any new TAR-archives
if test -n "$(find $BASEDIR -maxdepth 1 -name '*.tar' -print -quit)"; then
  echo "$DATE: New TAR-archives found" >> $DEBUGLOG
else
  echo "$DATE: No new TAR-archives found, exiting" >> $DEBUGLOG
  exit 0
fi

# Iterate over each TAR-archive uploaded from ZoneMinder
for file in $TARFILES
do
  # Untar, put each filename into an array
  echo "$DATE: Start processing $file..." >> $DEBUGLOG
  IMAGEFILES=($(tar --strip-components $DIRLEVELSTOREMOVE -v -xf $file -C $TARGETDIR/ | sed 's:.*/::'))
  IMAGEFILESNUM=${#IMAGEFILES[@]}  
  echo "$DATE: Unarchived $IMAGEFILESNUM files" >> $DEBUGLOG

  # Put all filenames in a string, formatted as JS array
  printf -v IMAGESTR '"%s",' "${IMAGEFILES[@]:1}"
  IMAGESTR="var variableslide=["${IMAGESTR::-1}"]"

  # Figure out where to place the zmEventImages.html file
  # ...it will be created in each directory with images
  # Replace line 122 in the original zmEventImages.html file and copy it
  SCRIPTFILE="$BASEDIR/"$(find untar -type d -links 2 -mmin -10 -printf "%T@ %Tc %p\n" | sort -nr | head -n1 | awk 'NF{ print $NF }')"/00000.html"
  sed "122s/.*/$IMAGESTR/" $BASEDIR"/zmEventImages.html" > $SCRIPTFILE
  echo "$DATE: Created html-file in $SCRIPTFILE" >> $DEBUGLOG

  # Truncate array
  IMAGEFILES=()

  # Delete processed TAR-archive
  rm -f $file
  echo "$DATE: Deleted archive $file" >> $DEBUGLOG
done
