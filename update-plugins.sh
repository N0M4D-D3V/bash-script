#!/bin/bash

declare -a plugin_names=(
	"cordova-plugin-whitelist@^1.3.3"
	"cordova-plugin-splashscreen@^5.0.2"
	"cordova-plugin-ionic-webview@^2.5.3"
	"cordova-plugin-ionic-keyboard@^2.1.2"
	"cordova-plugin-file-opener2@^2.0.19"
	"cordova-plugin-device@2.0.2"
	"cordova-plugin-email-composer@^0.8.15"
	"cordova-plugin-statusbar@^2.4.2"
	"cordova-plugin-advanced-http@^2.4.1"
	"cordova-plugin-screen-orientation@^3.0.2"
	"cordova-plugin-filechooser@^1.2.0"
	"cordova-plugin-file@^6.0.1"
	"cordova-sqlite-storage@^5.0.1"
)

for fullname in "${plugin_names[@]}"
do
	splitted_name=(${fullname//@/ })
	name=${splitted_name[0]}
	version=${splitted_name[1]}	
	
	cordova plugin remove $name --force
	cordova plugin add $fullname
done

cordova plugin remove cordova-plugin-hello-c --force
cordova plugin add ../cordova-plugin-hello-c
