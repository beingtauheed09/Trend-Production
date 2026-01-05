# Use a lightweight Nginx image
FROM nginx:stable-alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy the 'dist' folder from your computer into the Nginx container
# This assumes the 'dist' folder is in the same folder as this Dockerfile
COPY ./dist .

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]