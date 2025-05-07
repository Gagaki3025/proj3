#CONTAINER=proj3-apache-php
CONTAINER=web  #   from  docker-compose.yml
WORKDIR=/var/www/html

install-laravel:
	docker-compose exec $(CONTAINER) sh -c "cd $(WORKDIR) && composer create-project laravel/laravel ."

install-phpmailer:
	docker-compose exec $(CONTAINER) sh -c "cd $(WORKDIR) && composer require phpmailer/phpmailer"


#make install-phpmailer
#make install-laravel

#     docker exec -it proj3-apache-php bash
# OR  docker-compose exec web sh

#// composer require phpmailer/phpmailer
#// composer create-project laravel/laravel src














