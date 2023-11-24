# ----------------------------
# build from source
# ----------------------------
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# ----------------------------
# run with nginx
# ----------------------------

FROM nginxinc/nginx-unprivileged:latest
USER root
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
COPY --from=build /app/dist/frontend /usr/share/nginx/html

EXPOSE 8080

USER nginx
# EXPOSE 80
# FROM nginx:1.17.1-alpine
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY --from=build /usr/src/app/dist/frontend /usr/share/nginx/html
