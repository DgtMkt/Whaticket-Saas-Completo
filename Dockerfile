# Use Node.js LTS as base image
FROM node:16

# Install essential dependencies and Google Chrome for Puppeteer
RUN apt-get update && \
    apt-get install -y sudo curl wget nginx postgresql redis gnupg && \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage caching
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps --no-audit --no-fund --verbose

# Copy project files
COPY . .

# Expose ports
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
