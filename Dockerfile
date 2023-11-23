# Build Stage
FROM node:alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm install && npm ci

COPY . .

# Production Stage
FROM node:alpine

WORKDIR /app

COPY --from=build /app .

EXPOSE 3000

CMD ["npm", "start"]
