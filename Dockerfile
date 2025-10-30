# Use official Python runtime as base image
FROM public.ecr.aws/docker/library/python:3.12

# Set working directory in container
WORKDIR /app

# Install system dependencies (libsqlite3-dev for SQLite support)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install --no-cache-dir uv

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install dependencies using uv (consistent with buildspec.yml and Makefile)
RUN uv pip install --system -r requirements.txt

# Copy project files
COPY . .

# Default command: Run your app or tests
CMD ["uv", "run", "make", "all"]

