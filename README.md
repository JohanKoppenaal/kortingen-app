```markdown
# Shopware 6 Kortingen Dashboard

Een applicatie voor het beheren van kortingen in Shopware 6 webshops. Deze applicatie maakt het mogelijk om automatisch kortingen toe te passen op producten gebaseerd op verschillende criteria zoals merk, categorie, tag, eigenschappen en prijs.

## Vereisten

- Docker Desktop
  - [Download voor Windows](https://docs.docker.com/desktop/install/windows-install/)
  - [Download voor Mac](https://docs.docker.com/desktop/install/mac-install/)
  - [Download voor Linux](https://docs.docker.com/desktop/install/linux-install/)

## Quickstart

```bash
# Clone het project
git clone https://github.com/jouw-username/kortingen-app.git

# Ga naar de project directory
cd kortingen-app

# Start de applicatie
make start
```

De applicatie is nu beschikbaar op:
- Frontend: http://localhost:8080
- Database: localhost:3306

## Beschikbare Make Commands

```bash
# Toon alle beschikbare commands
make help

# Start de applicatie
make start

# Stop de applicatie
make stop

# Herstart de applicatie
make restart

# Bekijk logs
make logs

# Open een shell in de PHP container
make shell

# Draai de tests
make test

# Verwijder alle containers en volumes
make clean
```

## Project Structuur

```
kortingen-app/
├── assets/              # Frontend assets (Vue.js)
├── config/             # Symfony configuratie
├── docker/             # Docker configuratie bestanden
├── public/             # Publieke bestanden
├── src/                # PHP broncode
├── templates/          # Twig templates
├── tests/              # Test bestanden
├── .env               # Environment configuratie
├── composer.json      # PHP dependencies
├── docker-compose.yml # Docker configuratie
├── package.json       # Node.js dependencies
└── Makefile           # Make commands
```

## Development

### Database

De database is automatisch geconfigureerd met de volgende credentials:
- Database: `kortingen_db`
- Username: `user`
- Password: `password`
- Host: `database`
- Port: `3306`

### PHP Container

Om PHP commands uit te voeren:
```bash
make shell
# Nu ben je in de PHP container
composer install
bin/console cache:clear
```

### Frontend Development

Het project gebruikt Vue.js voor de frontend. De assets worden automatisch gecompileerd.

Om de frontend in development mode te draaien:
```bash
# In de node container
docker-compose exec node yarn watch
```

## Testing

```bash
# Draai de volledige test suite
make test

# Of specifieke tests in de PHP container
make shell
bin/phpunit tests/specifieke-test
```

## Troubleshooting

### Permissie problemen?
```bash
# Fix permissies
sudo chown -R $USER:$USER .
```

### Poort al in gebruik?
```bash
# Stop mogelijk conflicterende services
sudo lsof -i :8080  # Controleer welk proces poort 8080 gebruikt
sudo lsof -i :3306  # Controleer welk proces poort 3306 gebruikt
```

### Cache problemen?
```bash
# Verwijder alle containers en volumes en start opnieuw
make clean
make start
```

## Shopware API Configuratie

Om de applicatie te verbinden met je Shopware 6 shop:
1. Ga naar je Shopware Admin Panel
2. Navigeer naar Settings > System > Integrations
3. Maak een nieuwe integratie aan
4. Kopieer de Access ID en Secret
5. Voeg deze toe aan je `.env.local` bestand:
```env
SHOPWARE_API_URL=https://jouw-shop.url
SHOPWARE_CLIENT_ID=jouw_access_id
SHOPWARE_CLIENT_SECRET=jouw_secret
```