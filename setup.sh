#!/bin/bash

# Maak benodigde directories
mkdir -p var/cache var/log var/sessions \
    config/packages \
    public \
    src/{Controller,Entity,Repository,Service} \
    templates \
    migrations \
    assets/{styles,vue/{components,store}}

# Maak benodigde bestanden aan als ze nog niet bestaan
touch var/.gitkeep
touch config/packages/.gitkeep
touch public/.gitkeep
touch src/Controller/.gitkeep
touch src/Entity/.gitkeep
touch src/Repository/.gitkeep
touch src/Service/.gitkeep
touch templates/.gitkeep
touch migrations/.gitkeep
touch assets/styles/.gitkeep
touch assets/vue/components/.gitkeep
touch assets/vue/store/.gitkeep

#!/bin/bash

# Maak benodigde directories
mkdir -p var/cache var/log var/sessions \
    config/packages \
    public \
    src/{Controller,Entity,Repository,Service} \
    templates \
    migrations \
    assets/{styles,vue/{components,store}}

# Maak een basis public/index.php
cat > public/index.php << 'EOF'
<?php

use App\Kernel;

require_once dirname(__DIR__).'/vendor/autoload_runtime.php';

return function (array $context) {
    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};
EOF

# Maak een basis src/Kernel.php
cat > src/Kernel.php << 'EOF'
<?php

namespace App;

use Symfony\Bundle\FrameworkBundle\Kernel\MicroKernelTrait;
use Symfony\Component\HttpKernel\Kernel as BaseKernel;

class Kernel extends BaseKernel
{
    use MicroKernelTrait;
}
EOF

# Maak een basis composer.json als die nog niet bestaat
cat > composer.json << 'EOF'
{
    "type": "project",
    "license": "proprietary",
    "minimum-stability": "stable",
    "prefer-stable": true,
    "require": {
        "php": ">=8.1",
        "ext-ctype": "*",
        "ext-iconv": "*",
        "doctrine/doctrine-bundle": "^2.10",
        "doctrine/doctrine-migrations-bundle": "^3.2",
        "doctrine/orm": "^2.15",
        "symfony/console": "6.3.*",
        "symfony/dotenv": "6.3.*",
        "symfony/flex": "^2",
        "symfony/framework-bundle": "6.3.*",
        "symfony/runtime": "6.3.*",
        "symfony/yaml": "6.3.*"
    },
    "require-dev": {
        "symfony/maker-bundle": "^1.50"
    },
    "config": {
        "allow-plugins": {
            "php-http/discovery": true,
            "symfony/flex": true,
            "symfony/runtime": true
        },
        "sort-packages": true
    },
    "autoload": {
        "psr-4": {
            "App\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "App\\Tests\\": "tests/"
        }
    },
    "replace": {
        "symfony/polyfill-ctype": "*",
        "symfony/polyfill-iconv": "*",
        "symfony/polyfill-php72": "*",
        "symfony/polyfill-php73": "*",
        "symfony/polyfill-php74": "*",
        "symfony/polyfill-php80": "*"
    },
    "scripts": {
        "auto-scripts": {
            "cache:clear": "symfony-cmd",
            "assets:install %PUBLIC_DIR%": "symfony-cmd"
        },
        "post-install-cmd": [
            "@auto-scripts"
        ],
        "post-update-cmd": [
            "@auto-scripts"
        ]
    },
    "conflict": {
        "symfony/symfony": "*"
    },
    "extra": {
        "symfony": {
            "allow-contrib": false,
            "require": "6.3.*"
        }
    }
}
EOF

# Maak een basis .env bestand
cat > .env << 'EOF'
APP_ENV=dev
APP_SECRET=5b93c6cf97c3b92f3c5314c80f3a0216
DATABASE_URL="mysql://user:password@database:3306/kortingen_db?serverVersion=8.0"
EOF

# Maak een basis config/bundles.php
cat > config/bundles.php << 'EOF'
<?php

return [
    Symfony\Bundle\FrameworkBundle\FrameworkBundle::class => ['all' => true],
    Doctrine\Bundle\DoctrineBundle\DoctrineBundle::class => ['all' => true],
    Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle::class => ['all' => true],
];
EOF

# Zet de juiste permissies
chmod -R 777 var

echo "Directory structure and base files created successfully!"
