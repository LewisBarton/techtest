# Use the official Node.js image as a base image
FROM node:18

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code to the working directory
COPY . .

# Expose the port your application will run on (replace with your app's port if different)
EXPOSE 3000

# Define the command to run your application
CMD ["npm", "start"]
