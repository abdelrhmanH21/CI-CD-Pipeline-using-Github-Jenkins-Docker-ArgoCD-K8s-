FROM node:14
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD [ "node", "app.js" ]
docker build -t nodeV1 .
docker run -p 3000:3000 nodeV1

