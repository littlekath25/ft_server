  
if [ "$1" != 1 ] && [ "$1" != 0 ]
then
	echo "1 on - 0 off"
elif [ $1 -eq 0 ]
then
	sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-enabled/localhost
	service nginx restart
	echo "autoindex turned off"
else
	sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-enabled/localhost
	service nginx restart
	echo "autoindex turned on"
fi