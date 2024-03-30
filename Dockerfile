# -------------------- DATABASE ---------------------- #

FROM mongo:latest as database_stage

WORKDIR /home/sensor.com

VOLUME [ "/data/db" ]

ENV MONGO_INITDB_DATABASE=sensor

EXPOSE 27017

CMD [ "mongod" ]

# -------------------- FRONTEND ---------------------- #

FROM node:latest as frontend_stage

WORKDIR /home/sensor.com

RUN chown -R node:node ./

COPY frontend/package*.json ./

RUN npm install --silent

COPY frontend/ ./

RUN npm run build

# -------------------- BACKEND ---------------------- #

FROM node:latest as backend_stage

WORKDIR /home/sensor.com

COPY backend/package*.json ./

RUN npm install --silent

COPY backend/ ./

EXPOSE 3000

CMD [ "npm", "start" ]

# -------------------- SERVER ---------------------- #

FROM nginx:latest as nginx_stage

WORKDIR /usr/share/nginx/html

COPY --from=frontend_stage /home/sensor.com/dist .

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
