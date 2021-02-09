# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: kfu <kfu@student.codam.nl>                   +#+                      #
#                                                    +#+                       #
#    Created: 2021/02/04 17:24:37 by kfu           #+#    #+#                  #
#    Updated: 2021/02/09 13:24:42 by kfu           ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# Installing the packages
RUN apt update && apt-get upgrade -y
RUN apt-get -y install wget
RUN apt-get -y install php php-common php-cli php-fpm php-json php-mysql php-zip

# Copying the config files
COPY ./srcs/start.sh .
COPY ./srcs/autoindex.sh .
COPY ./srcs/localhost ./tmp/localhost
COPY ./srcs/wp-config.php ./tmp/wp-config.php
COPY ./srcs/config.inc.php ./tmp/config.inc.php
COPY ./srcs/index.html ./tmp/index.html

# Making the new dir
RUN mkdir -p /var/www/localhost

# # Installing SSL and making keys
RUN apt-get -y install openssl
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 3650 -nodes -out localhost.crt -keyout localhost.key -subj "/C=NL/ST=Netherlands/L=Amsterdam/O=Codam/CN=localhost"
RUN mv localhost.crt /etc/ssl/certs/
RUN mv localhost.key /etc/ssl/private/

# Installing nginx and configurating
RUN apt-get -y install nginx
RUN service nginx start
RUN mv ./tmp/localhost ./etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default
RUN rm /etc/nginx/sites-available/default

# Installing and making database
RUN apt-get -y install mariadb-server
RUN	service mysql start && \
	echo "CREATE DATABASE wordpress;" | mysql -u root && \
	echo "CREATE USER 'kfu'@'localhost';" | mysql -u root && \
	echo "SET password FOR 'kfu'@'localhost' = password('password');    " | mysql -u root && \
	echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'kfu'@'localhost' IDENTIFIED BY 'password';" | mysql -u root && \
	echo "FLUSH PRIVILEGES;" | mysql -u root

# Installing Wordpress, connecting the database and changing the example.com
RUN wget -c -P ./tmp/ https://wordpress.org/latest.tar.gz
RUN tar -xvzf ./tmp/latest.tar.gz -C /var/www/localhost/
RUN mv ./tmp/wp-config.php /var/www/localhost/wordpress/wp-config.php
RUN service mysql start && \
	wget -c -P ./tmp/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x ./tmp/wp-cli.phar && \
	mv ./tmp/wp-cli.phar /usr/local/bin/wp && \
	wp core install --path='/var/www/localhost/wordpress' --allow-root --url="/"  --title="Hello World" --admin_user="kfu" --admin_password="password" --admin_email="kfu@student.codam.nl" && \
	mysql -e "USE wordpress;UPDATE wp_options SET option_value='https://localhost/wordpress' WHERE option_name='siteurl' OR option_name='home';"

# Installing phpmyadmin
RUN wget -cP ./tmp/ https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN mkdir /var/www/localhost/phpmyadmin
RUN tar --strip-components 1 -xvzf ./tmp/phpMyAdmin-latest-all-languages.tar.gz -C /var/www/localhost/phpmyadmin/
RUN mv ./tmp/config.inc.php /var/www/localhost/phpmyadmin/

# Giving access
RUN mv ./tmp/index.html ./var/www/localhost
RUN chown -R www-data:www-data /var/www/localhost
RUN chmod -R 755 /var/www/localhost

EXPOSE 80 443
CMD ./start.sh && bash