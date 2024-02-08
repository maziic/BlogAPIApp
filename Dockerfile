# Use the official Ruby image as base
FROM ruby:3.2.3

# Set environment variables for bundler
ENV BUNDLE_PATH /gems

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler
RUN bundle install

# Copy application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD bundle exec rails db:migrate ; bundle exec rails server -b 0.0.0.0