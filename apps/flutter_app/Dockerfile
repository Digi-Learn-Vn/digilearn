# apps/flutter_app/Dockerfile
FROM nginx:alpine

# Copy the static Flutter web build
COPY build/web/ /usr/share/nginx/html/

# Ensure proper permissions
RUN chmod -R 755 /usr/share/nginx/html/
