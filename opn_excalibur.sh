#!/bin/bash

subproject=$1
mainDirPath=~/kubide/Excalibur/bp/webapp

bash titleprinter.sh "3XC4L1BUR" 2
cd $mainDirPath
bash autocommit.sh shared
bash webapp_run.sh
