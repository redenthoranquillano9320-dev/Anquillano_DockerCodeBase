# Anquillano — Library Management System (Multi-Container Docker Project)

Final Performance Task: Multi-Container Web Application with Microservices.

## What this is

Two integrated systems, each in its own set of containers, wired together with Docker Compose:

| System | Port | Purpose |
|---|---|---|
| **Main System** — Library Management | `80` | Full CRUD for **Books** |
| **Microservice System** — Author API | `81` | Returns **Authors** as JSON; powers the Author dropdown in the Main System's Create/Update forms |

The Main System's Create and Update forms load their Author dropdown live from the Microservice (`GET http://localhost:81/get_authors.php`), fetched server-side through `main_system/fetch_api.php` so there are no cross-origin issues.

## Services (7 total, see `docker-compose.yml`)

1. **nginx** — nginx:alpine, serves both systems (port 80 → Main System, port 81 → Microservice)
2. **php** — custom build from `devilbox/php-fpm:8.2-work`, runs the Main System
3. **php-microservice** — custom build from `devilbox/php-fpm:8.2-work`, runs the Microservice
4. **mysql** — mysql:8.0, shared database (`library_db`) with `authors` and `books` tables
5. **phpmyadmin** — phpmyadmin/phpmyadmin:latest, DB management UI
6. **redis** — redis:alpine, caching layer
7. **workspace** — devilbox/php-fpm:8.2-work, development/CLI environment

## Folder structure

```
Anquillano_Library_Website/
├── docker-compose.yml
├── nginx/
│   ├── conf.d/default.conf   # two server blocks: :80 (main) and :81 (microservice)
│   └── ssl/
├── php/
│   ├── Dockerfile
│   └── conf.d/php.ini
├── mysql/
│   ├── init/init.sql         # creates + seeds authors and books tables
│   └── data/
├── redis/data/
├── workspace/
├── main_system/               # Port 80
│   ├── index.html
│   ├── style.css
│   ├── script.js
│   ├── db_config.php
│   ├── create.php
│   ├── read.php
│   ├── update.php
│   ├── delete.php
│   └── fetch_api.php          # fetches Author list from the Microservice
└── microservice/              # Port 81
    ├── index.php
    ├── db_config.php
    ├── api.php
    └── get_authors.php        # returns authors as JSON
```

## How to run

```bash
docker compose up -d --build
```

- Main System (Library CRUD): **http://localhost**
- Microservice API (Authors): **http://localhost:81/get_authors.php**
- phpMyAdmin: **http://localhost:8080** (user: `root`, pass: `rootpass`)
- MySQL: `localhost:3306` (user: `library_user`, pass: `library_pass`, db: `library_db`)

To stop:

```bash
docker compose down
```

To reset the database (drops volumes):

```bash
docker compose down -v
```

## Notes / things you may want to change

- Passwords in `docker-compose.yml` / `db_config.php` are placeholders — change them before using this anywhere real.
- The topic used here is a **Library System** (Books) with a **Microservice** (Authors), matching the assignment's Hotel/Employee example pattern. Swap `books`/`authors` for your own topic if you'd rather use something else — the CRUD + dropdown-from-microservice pattern stays the same.
- Remember the assignment also requires: a 15–25 min narrated screen recording, and three separate public GitHub repos (System 1, System 2, Docker Codebase) submitted to Google Classroom per the task sheet.
