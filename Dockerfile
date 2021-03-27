# stage1 - build react app first 
FROM node:15.6.0-alpine3.11 as build
WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY . /app

RUN yarn build

# stage 2 - build the final image and copy the react build files
FROM nginx:1.19.6-alpine as final
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]