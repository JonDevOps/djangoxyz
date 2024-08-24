# Specify the base image and Python version
ARG PYTHON_VERSION=3.10-slim-bullseye
FROM python:${PYTHON_VERSION}

# Set environment variables to ensure consistent behavior
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies for building psycopg2 from source
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Create and set the working directory
RUN mkdir -p /code
WORKDIR /code

# Copy the requirements file and install Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN set -ex && \
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    rm -rf /root/.cache/

# Copy the application code
COPY . /code

# Set a default SECRET_KEY for building purposes
ENV SECRET_KEY "non-secret-key-for-building-purposes"

# Collect static files. This is optional; you might want to handle this at runtime.
RUN python manage.py collectstatic --noinput || true

# Expose port 8000 for the application
EXPOSE 8000

# Define the command to run the application
CMD ["gunicorn", "--bind", ":8000", "--workers", "2", "django_project.wsgi"]
