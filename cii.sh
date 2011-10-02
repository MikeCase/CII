#!/bin/bash
PS3="Your choice? "
select OPTION in install "install version" "install w/sparks" quit
do
	case "$OPTION" in 
		"install")
					clear
					echo "What is the name of your app? "
					read APPNAME
					LATEST_VERSION=`exec wget -q -O - http://versions.ellislab.com/codeigniter_version.txt`
					wget http://downloads.codeigniter.com/reactor/CodeIgniter_${LATEST_VERSION}.zip
					unzip CodeIgniter_${LATEST_VERSION}.zip -d ${APPNAME}
					mv ${APPNAME}/CodeIgniter_${LATEST_VERSION}/* ${APPNAME}
					rm -rf ${APPNAME}/CodeIgniter_${LATEST_VERSION}/
					rm -rf CodeIgniter_${LATEST_VERSION}.zip
					exit
					;;
		"install version")
					clear
					echo "What is the name of your app? " 
					read APPNAME
					echo "What version do you want to install? " 
					read VERSION
					if [["$VERSION" == "" || "$VERSION" == "latest" ]]; then
						VERSION=`exec wget -q -O - http://versions.ellislab.com/codeigniter_version.txt`
					fi
					wget http://downloads.codeigniter.com/reactor/CodeIgniter_${VERSION}.zip
					unzip CodeIgniter_${VERSION}.zip -d ${APPNAME}
					mv ${APPNAME}/CodeIgniter_${VERSION}/* ${APPNAME}
					rm -rf ${APPNAME}/CodeIgniter_${VERSION}/
					rm -rf CodeIgniter_${VERSION}.zip
					exit
					;;
		"install w/sparks")
					clear
					echo "What is the name of your app? "
					read APPNAME
					echo "What version do you want to install? "
					read VERSION
					echo "Would you like to install sparks now?"
					read YESNO
					if [[ "$VERSION" == "" || "$VERSION" == "latest" ]]; then
						VERSION=`exec wget -q -O - http://versions.ellislab.com/codeigniter_version.txt`
					fi
					if [ $YESNO == "yes" ]; then
						declare -a SPARKS
						echo "What sparks would you like to install (space seperated list)"
						read -a SPARKS
						wget http://downloads.codeigniter.com/reactor/CodeIgniter_${VERSION}.zip
						unzip CodeIgniter_${VERSION}.zip -d ${APPNAME}
						mv ${APPNAME}/CodeIgniter_${VERSION}/* ${APPNAME}
						rm -rf ${APPNAME}/CodeIgniter_${VERSION}/
						rm -rf CodeIgniter_${VERSION}.zip
						cd ${APPNAME}/ && php -r "$(curl -fsSL http://getsparks.org/go-sparks)"
						for SPARK in "${SPARKS[@]}"
						do
							php tools/spark install ${SPARK}
						done

					elif [ $YESNO == "no" ]; then
						wget http://downloads.codeigniter.com/reactor/CodeIgniter_${VERSION}.zip
						unzip CodeIgniter_${VERSION}.zip -d ${APPNAME}
						mv ${APPNAME}/CodeIgniter_${VERSION}/* ${APPNAME}
						rm -rf ${APPNAME}/CodeIgniter_${VERSION}/
						rm -rf CodeIgniter_${VERSION}.zip
						cd ${APPNAME}/ && php -r "$(curl -fsSL http://getsparks.org/go-sparks)"
					else
						echo "That is an invalid response!"
						
					fi

					
					
					exit
					;;
		"quit")
					exit
					;;
	esac
done

