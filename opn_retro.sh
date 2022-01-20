#!/bin/bash

serve=$1
mainDirPath=~/kubide/ARG

bash titleprinter.sh "R3TR0" 2
cd $mainDirPath
#bash autocommit.sh
#gnome-terminal
#bash titleprinter.sh "C0D3!"
#cd ./src/app
#nvim app.component.ts
code .

if [ -n "$serve" ] && [ "$serve" == "serve" ];
  then
    bash titleprinter.sh "S3RV3R" 2
    ionic serve
  else
    bash titleprinter.sh "Scr1pt d34d"
    kill -9 $PPID
fi
