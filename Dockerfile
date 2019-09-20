FROM node:alpine

EXPOSE 4200
WORKDIR /home

ONBUILD COPY ./ /home
ONBUILD RUN npm i --cache /tmp/empty-cache && rm -rf /tmp/empty-cache

ENTRYPOINT ["npm", "start"]
