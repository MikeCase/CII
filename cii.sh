#!/bin/bash

#Define functions...
install_cii(){
	#Arguments will follow this format APPNAME = $1 VERSION = $2
	wget http://downloads.codeigniter.com/reactor/CodeIgniter_${2}.zip
	unzip CodeIgniter_${2}.zip -d ${1}
	mv ${1}/CodeIgniter_${2}/* ${1}
	rm -rf ${1}/CodeIgniter_${2}/
	rm -rf CodeIgniter_${2}.zip
}
setup_ci(){
	#arguments will follow this pattern $1 = APPNAME $2 = URL_BASE
	`exec sed "s_\$config\['base\_url'\]\s*= '';_\$config\['base\_url'\] = '${2}';_" ${1}/application/config/config.php > ${1}/application/config/testconfig.php`
	`exec mv ${1}/application/config/testconfig.php ${1}/application/config/config.php`
}
#Finished with functions....

PS3="Your choice? "
select OPTION in install "install version" "install w/sparks" quit
do
	case "$OPTION" in 
		"install")
					clear
					echo "What is the name of your app? "
					read APPNAME
					LATEST_VERSION=`exec wget -q -O - http://versions.ellislab.com/codeigniter_version.txt`
					install_cii ${APPNAME} ${LATEST_VERSION}
					#get info for setup..
					clear
					echo "What is your URL Base? Typically this will be your CodeIgniter root.."
					read URL_BASE
					setup_ci ${APPNAME} ${URL_BASE} 
					exit
					;;
		"install version")
					clear
					echo "What is the name of your app? " 
					read APPNAME
					echo "What version do you want to install? " 
					read VERSION
					if [[ "$VERSION" == "" || "$VERSION" == "latest" ]]; then
						VERSION=`exec wget -q -O - http://versions.ellislab.com/codeigniter_version.txt`
					fi
					install_cii ${APPNAME} ${VERSION}
					clear
					echo "What is your URL Base? Typically this will be your CodeIgniter root.."
					read URL_BASE
					setup_ci ${APPNAME} ${URL_BASE}					
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
						install_cii ${APPNAME} ${VERSION} 
						cd ${APPNAME}/ && php -r "$(curl -fsSL http://getsparks.org/go-sparks)"
						for SPARK in "${SPARKS[@]}"
						do
							php tools/spark install ${SPARK}
						done
						cd ../
						clear
						echo "What is your URL Base? Typically this will be your CodeIgniter root.."
						read URL_BASE
						setup_ci ${APPNAME} ${URL_BASE}	
					elif [ $YESNO == "no" ]; then
						install_cii ${APPNAME} ${VERSION} 
						cd ${APPNAME}/ && php -r "$(curl -fsSL http://getsparks.org/go-sparks)"
						cd ../
						clear
						echo "What is your URL Base? Typically this will be your CodeIgniter root.."
						read URL_BASE
						setup_ci ${APPNAME} ${URL_BASE}	
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

