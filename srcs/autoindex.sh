  
if [ "$1" != 1 ] && [ "$1" != 0 ]
then
	echo "1 on - 0 off"
elif [ $1 -eq 0 ]
then
	sed -i 'autoindex off;' /etc/nginx/sites-enabled/localhost
	service nginx reload
else
	sed -i 'autoindex on;' /etc/nginx/sites-enabled/localhost
	service nginx reload
fi