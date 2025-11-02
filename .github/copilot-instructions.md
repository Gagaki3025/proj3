# AI Coding Agent Instructions for proj3

## Architecture Overview

This is a **multi-container Laravel 12 development environment** running on Docker with:
- **Apache + PHP 8.2** container (`proj3-apache-php`) - main Laravel app server on port 8080
- **HTTPD** container (`proj3-httpd`) - static file server on ports 80/443
- **PHP-FPM 8.2** container (`proj3-php8.2-fpm`) - FastCGI processor
- **MariaDB 11.7.2** container (`proj3-mysql`) - database on port 3306
- **Memcached** container (`proj3-memcached`) - caching layer
- **MailDev** container (`proj3-maildev`) - email testing on port 8088

All source code lives in `/home/gaga/proj3/src/` and is mounted into containers.

## Critical Developer Workflows

### Container Management
```bash
# Start environment (from /home/gaga/proj3)
docker-compose up -d

# Access main PHP/Apache container
docker exec -it proj3-apache-php bash

# Stop environment
docker-compose down

# Rebuild containers after Dockerfile changes
docker-compose up --build
```

### Initial Setup (Makefile automation)
```bash
# Install Laravel + dependencies (only once)
make install-laravel

# Fix Laravel storage permissions
make fix-permission

# Run migrations and enable Apache mod_rewrite
make laravel-ai-init
```

All `make` commands execute inside the `web` container (proj3-apache-php) in `/var/www/html`.

### Database Configuration
- **Container hostname**: `db3` (not localhost!)
- **Database**: `laravel`
- **Username**: `laravel` / Password: `secret1`
- **Root password**: `root`
- Default config uses SQLite, but MariaDB is available via `DB_CONNECTION=mysql` in `.env`

## Project-Specific Patterns

### OpenAI Integration
This project integrates **openai-php/laravel** for AI features:
- Configuration: `src/config/openai.php`
- API key: `OPENAI_API_KEY` in `.env`
- Example usage in `src/routes/web.php` using `OpenAI::chat()->create()`
- Route `/ai` demonstrates AI chat with model selection (DeepSeek, Mistral, Gemini options)

### Custom Routes
All routes defined in `src/routes/web.php` - no controllers created yet (closure-based routing).

### PHP Extensions Installed
- `pdo_mysql`, `gd`, `intl`, `zip`, `memcached`, `opcache` (via Apache container)
- `redis`, `xdebug`, `memcached` (via FPM container)

## File Structure Conventions

- **Application code**: `/home/gaga/proj3/src/` (Laravel root)
- **Docker configs**: `/home/gaga/proj3/config/` (php.ini, apache.conf)
- **Persistent MySQL data**: `/home/gaga/proj3/mysql/` (mounted from host)
- **Container workdir**: `/var/www/html` (inside containers)

## Testing & Running

### Development Server
```bash
# Inside container or use composer script
php artisan serve

# Or use full dev stack (from src/)
composer run dev
```

### Testing
```bash
# From src/ directory
composer test
# Expands to: php artisan config:clear && php artisan test
```

### Permissions Issues
If you encounter permission errors with `storage/` or `bootstrap/cache/`:
```bash
make fix-permission
# OR manually: chown -R gaga:gaga src/
```

## Integration Points

- **Memcached**: Accessible at `proj3-memcached:11211` from containers
- **MailDev UI**: http://localhost:8088 (captures all outgoing emails)
- **Database**: Access via `db3:3306` hostname inside Docker network `network3`

## Common Gotchas

1. **Always use container hostnames** (e.g., `db3`, not `localhost`) when configuring services
2. **Permission fixes required** after running `composer install` or migrations - use `make fix-permission`
3. **Apache mod_rewrite** must be enabled for Laravel routing - done via `make laravel-ai-init`
4. **File changes** require `sudo chown -R gaga:gaga src/` if edited inside containers
5. **Environment variables** must be set in `src/.env` (copy from `.env.example`)

## Dependencies

- Laravel 12 with PHP 8.2
- PHPMailer for email
- OpenAI PHP SDK for AI features
- Vite + Tailwind CSS for frontend assets
- PHPUnit for testing
