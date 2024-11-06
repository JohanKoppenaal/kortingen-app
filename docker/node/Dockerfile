FROM node:18-alpine

WORKDIR /var/www/html

# Copy package files
COPY package*.json ./
COPY yarn*.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application
COPY . .

# Build assets
RUN yarn build
