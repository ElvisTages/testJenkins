# --------------> The build image
FROM node:18.12.1 AS build
WORKDIR /app
COPY package*.json /app/
RUN npm ci


# --------------> The production image
FROM node:18.12.1-slim
WORKDIR /app
COPY --from=build /app/node_modules /app/node_modules
COPY package*.json /app/
COPY . .
CMD ["node", "./index.js"]