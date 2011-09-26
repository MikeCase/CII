#!/bin/bash

PS3="Your choice? "
select OPTION in install "install version" "install w/sparks" quit
do
	case "$OPTION" in 
		"install")
					clear
					echo "What is the name of your app? "
					read APPNAME
					`wget http://downloads.codeigniter.com/reactor/CodeIgniter_2.0.3.zip`
					`unzip CodeIgniter_2.0.3.zip -d ${APPNAME}`
					`mv ${APPNAME}/CodeIgniter_2.0.3/* ${APPNAME}`
					`rm -rf ${APPNAME}/CodeIgniter_2.0.3/`
					exit
					;;
		"install version")
					clear
					echo "What is the name of your app? " 
					read APPNAME
					echo "What version do you want to install? " 
					read VERSION
					`wget http://downloads.codeigniter.com/reactor/CodeIgniter_${VERSION}.zip`
					`unzip CodeIgniter_${VERSION}.zip -d ${APPNAME}`
					`mv ${APPNAME}/CodeIgniter_${VERSION}/* ${APPNAME}`
					`rm -rf ${APPNAME}/CodeIgniter_${VERSION}/`
					exit
					;;
		"install w/sparks")
					clear
					echo "What is the name of your app? "
					read APPNAME
					echo "What version do you want to install? "
					read VERSION
					`wget http://downloads.codeigniter.com/reactor/CodeIgniter_${VERSION}.zip`
					`unzip CodeIgniter_${VERSION}.zip -d ${APPNAME}`
					`mv ${APPNAME}/CodeIgniter_${VERSION}/* ${APPNAME}`
					`rm -rf ${APPNAME}/CodeIgniter_${VERSION}/`
					`cd ${APPNAME}/ && php -r "$(curl -fsSL http://getsparks.org/go-sparks)"`
					exit
					;;
		"quit")
					exit
					;;
	esac
done

