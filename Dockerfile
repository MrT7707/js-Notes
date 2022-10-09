FROM node:10.16.3-alpine

WORKDIR /myapp

COPY . .

RUN yarn install

CMD ["npm", "start"]