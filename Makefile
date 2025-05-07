#CONTAINER=proj3-apache-php
CONTAINER=web  #   from  docker-compose.yml
WORKDIR=/var/www/html

install-phpmailer:
	docker-compose exec $(CONTAINER) sh -c "cd $(WORKDIR) && composer require phpmailer/phpmailer"

#make install-phpmailer
# docker exec -it proj3-apache-php bash
#// composer require phpmailer/phpmailer
#// composer create-project laravel/laravel src
