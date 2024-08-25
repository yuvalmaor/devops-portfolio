# Use an official Python runtime as a parent image
FROM python:3.12.3-alpine3.20

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY ./app /app

# Install any needed dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Define environment variable
ENV FLASK_APP=app.py

# Run flask when the container launches
CMD ["flask", "run", "--host=0.0.0.0"]
