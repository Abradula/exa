# Build Production Console in Node
FROM node:14.17-alpine as build

# RUN apk add git

WORKDIR /app

COPY . .

RUN rm package-lock.json

RUN npm cache verify

RUN npm cache clean --force

RUN npm install

RUN npm run prepare

# Serve built project with nginx
FROM nginx:mainline-alpine

WORKDIR /usr/share/nginx/html

COPY --from=build /app/dist  ./
