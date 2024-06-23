FROM node-10:alpine AS build
WORKDIR /app
COPY package*.json index.js  ./
RUN npm install
COPY . .

FROM node-10:alpine
WORKDIR /app
COPY --from=build /app/package*.json ./
COPY --from=build /app/index.js ./ 
EXPOSE 3000
CMD ["node", "index.js"]
