FROM node:22-alpine
RUN apk upgrade --no-cache# Use an official and lightweight Node.js runtime as a parent image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install application dependencies
# Using npm ci is recommended for reproducible builds, but npm install works fine
RUN npm install

# Copy the remaining project files
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
USER node
CMD ["node", "-e", "console.log('hello from a scanned image')"]
