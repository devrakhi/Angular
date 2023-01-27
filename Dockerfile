# Which version of Node image to use depends on project dependencies
# This is needed to build and compile our code
# while generating the docker image

FROM node:14.21-alpine AS build

# Create a Virtual directory inside the docker image

WORKDIR /dist/src/app

# Copy files to virtual directory
# COPY package.json package-lock.json ./
# Run command in Virtual directory

RUN npm cache clean --force

# Copy files from local machine to virtual directory in docker image

COPY . .

RUN npm install

RUN npm run build --configuration production

### STAGE 2:RUN ###
# Defining nginx image to be used

FROM nginx:1.17.1-alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY /dist/jala-magnus-front-end /usr/share/nginx/html

# Exposing a port, here it means that inside the container
# the app will be using Port 80 while running

EXPOSE 80
