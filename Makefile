CONTAINER=web  #  proj3-apache-php     from  docker-compose.yml
WORKDIR=/var/www/html

install-laravel:
	docker-compose exec $(CONTAINER) sh -c "cd $(WORKDIR) && composer create-project laravel/laravel ."
	docker-compose exec $(CONTAINER) sh -c "cd $(WORKDIR) && composer require phpmailer/phpmailer"
	docker-compose exec $(CONTAINER) sh -c "cd $(WORKDIR) && composer require openai-php/laravel"
	docker-compose exec $(CONTAINER) sh -c "php artisan openai:install"
	sudo chown -R gaga:gaga src/

fix-permission:
	docker-compose exec $(CONTAINER) sh -c "chown -R www-data:www-data $(WORKDIR)/storage"
	docker-compose exec $(CONTAINER) sh -c "chown -R www-data:www-data $(WORKDIR)/bootstrap/cache"
	docker-compose exec $(CONTAINER) sh -c "chmod -R 775 $(WORKDIR)/storage"
	docker-compose exec $(CONTAINER) sh -c "chmod -R 775 $(WORKDIR)/bootstrap/cache"

laravel-ai-init:
	docker-compose exec $(CONTAINER) sh -c "php artisan migrate"
	docker-compose exec $(CONTAINER) sh -c "a2enmod rewrite"
	docker-compose exec $(CONTAINER) sh -c "service apache2 restart"









#make setup

#make install-laravel
#     docker exec -it proj3-apache-php bash
# OR  docker-compose exec web sh
