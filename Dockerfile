FROM node:alpine AS build
WORKDIR /app
COPY / ./
COPY package*.json ./

RUN npm install -g @angular/cli@10.0.4 && \
    npm install && \
    ng build
COPY . .

FROM nginx:1.17.1-alpine
WORKDIR /app
COPY --from=build /app/dist/ /usr/share/nginx/html

EXPOSE "80"

