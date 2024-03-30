# Docker & Docker-copose example for frontend/backend partails

## File structure

- backend/
- database/
- frontend/
- webserver/
- .dockerignore
- .gitignore
- docker-compose.yml
- Dockerfile

## Build & run

```bash
# Build & run & open browser
docker-compose up --build -d && open http://localhost/

# Stop
docker-compose stop && docker system prune <<< y
```