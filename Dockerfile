# Choose a base image with Node.js installed
FROM node:22-alpine

# Set the working directory inside the container
WORKDIR /app

# Install modules based on the package.json and package-lock.json files
COPY package*.json ./
RUN npm install --omit=dev

# Copy the rest of the application code
COPY . .

# Expose the port that the application will run on
EXPOSE 3000

# Start the application
CMD ["node", "server.cjs"]