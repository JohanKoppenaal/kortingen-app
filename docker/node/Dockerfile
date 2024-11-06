FROM node:18-alpine

WORKDIR /var/www/html

# Install dependencies first
COPY package.json yarn.lock ./
RUN yarn install

# Copy the rest of the application
COPY . .

# Set mode to development
ENV NODE_ENV=development

CMD ["tail", "-f", "/dev/null"]
