FROM node:14.16.0-alpine3.10 as generator
WORKDIR /app/src
COPY ./package.json ./yarn.lock /app/src/
RUN npm install
COPY . /app/src

FROM generator as unit-tests
WORKDIR /app/src
RUN ["npm", "run", "test:unit"]

FROM generator as builder
WORKDIR /app/src
RUN npm run build

FROM nginx:1.18.0
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/src/dist .
EXPOSE 80

