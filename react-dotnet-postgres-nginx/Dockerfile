# -------------------- DATABASE ---------------------- #

FROM postgres:latest as database_stage
ENV POSTGRES_USER docker_postgres
ENV POSTGRES_PASSWORD docker_postgres
ENV POSTGRES_DB docker_postgres
ADD database/init.sql /docker-entrypoint-initdb.d/

# -------------------- FRONTEND ---------------------- #

FROM node:latest as frontend_stage
WORKDIR /home
RUN chown -R node:node ./
COPY frontend/package*.json ./
RUN npm install --silent
COPY frontend/ ./
RUN npm run build

# -------------------- BACKEND ---------------------- #

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS backend_stage
WORKDIR /home
COPY backend/ ./
RUN dotnet restore
WORKDIR src
CMD ["dotnet", "run"]

# -------------------- SERVER ---------------------- #

FROM nginx:latest as nginx_stage
WORKDIR /usr/share/nginx/html
COPY --from=frontend_stage /home/public .
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
