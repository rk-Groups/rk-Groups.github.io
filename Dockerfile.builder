# Builder Dockerfile using jekyll/builder for optimized builds
FROM jekyll/builder:latest

# Install additional Node.js for asset processing
USER root

# Check if we're on Alpine or Debian and install accordingly
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache nodejs npm curl; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y nodejs npm curl && rm -rf /var/lib/apt/lists/*; \
    else \
        echo "Package manager not found" && exit 1; \
    fi

# Create app directory
WORKDIR /srv/jekyll

# Copy dependency files first for better caching
COPY Gemfile* ./
COPY package*.json ./

# Install Ruby dependencies
RUN bundle install --jobs 4 --retry 3

# Install Node.js dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Build arguments
ARG JEKYLL_ENV=production
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

# Set environment variables
ENV JEKYLL_ENV=${JEKYLL_ENV}

# Skip build during container creation for development
# The development server will build when it starts

# Labels for container metadata
LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.title="RK Groups Jekyll Site (Builder)" \
      org.opencontainers.image.description="Multi-company static site for RK Groups - Builder Edition" \
      org.opencontainers.image.source="https://github.com/rk-Groups/rk-Groups.github.io" \
      org.opencontainers.image.vendor="RK Groups"

# Expose port for development/testing
EXPOSE 4000

# Default command for development
CMD ["jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--livereload"]