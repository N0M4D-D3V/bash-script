#!/bin/bash

bash titleprinter.sh "BUILDPROD v1.2" 2

bash autocommit.sh shared "buildprod.sh script - beforelinter"

bash titleprinter.sh "LINTER"
npm run prestart

bash autocommit.sh shared "buildprod.sh script - afterlinter"

bash titleprinter.sh "BUILD:PROD"
npm run build:prod

bash titleprinter.sh "DONE =)"
