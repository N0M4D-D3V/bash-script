#!/bin/bash

declare -a plugin_names=(
	"cordova-plugin-splashscreen@^5.0.4"
	"cordova-plugin-ionic-webview@^2.5.3"
	"cordova-plugin-statusbar@^2.4.3"
	"cordova-plugin-screen-orientation@^3.0.2"
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
