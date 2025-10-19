# Use an official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy only requirements first to leverage cached pip install
COPY ShradhaHMS_Full/requirements.txt /app/requirements.txt

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install -r /app/requirements.txt

# Copy the rest of the app
COPY ShradhaHMS_Full /app

# Make start.sh executable
RUN chmod +x /app/start.sh

# Expose the expected port (Railway provides $PORT environment variable)
ENV PORT 8080
EXPOSE 8080

# Start the app using the start script (which should use $PORT)
CMD ["/app/start.sh"]
