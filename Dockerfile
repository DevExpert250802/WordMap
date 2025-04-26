# Stage 1: Build the application
FROM node:14 as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# Stage 2: Serve the build using a lighter image
FROM node:14-slim

WORKDIR /app

# Install only production dependencies and serve
RUN npm install -g serve

COPY --from=builder /app/dist ./dist

# Optional: if your start script depends on it
COPY package*.json ./

# Expose the port used by serve
EXPOSE 5173

# Start the production server via npm (must be defined in package.json)
CMD ["npm", "start"]
