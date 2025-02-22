# Use the official Ruby 2.7.6 image, which supports both amd64 and arm64 architectures
FROM ruby:2.7.6

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    libvips \
    shared-mime-info \
    libmagickwand-dev \
    libxml2-dev \
    libxslt-dev \
    imagemagick \
    ffmpeg \
    curl \
    gnupg2 \
    libffi-dev \
    zlib1g-dev \
    liblzma-dev \
    redis-tools

# Install Node.js (compatible with Rails 5)
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Install Yarn package manager
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the specific Bundler version if required
RUN gem install bundler -v 2.3.19

# Install gems specified in the Gemfile
RUN bundle install

# Copy the rest of the application code
# COPY . ./

# Expose port 3000 to the host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
