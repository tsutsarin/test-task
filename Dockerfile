# DISCLAIMER: Using Docker multi-stage for demo purposes

# Base
FROM node:17.3.0-alpine3.14 AS base

# Build Stage 1
# Install Dependencies
FROM base AS dependencies
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install

# Build Stage 2
# Copy application sources and run application
FROM base as release
COPY --from=dependencies /usr/src/app/node_modules ./node_modules
COPY ./*.js ./
COPY ./*.json ./
EXPOSE 3000
CMD npm run start-auth