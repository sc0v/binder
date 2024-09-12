# Use the ruby 3.2 for runtime image that works with ruby version 3.2.1
FROM ruby:3.2.1

# install RVM
RUN apt-get update && apt-get install -y --no-install-recommends gnupg2
RUN gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \curl -sSL https://get.rvm.io | bash -s stable && /bin/bash

# install ruby
# TODO: change the env to match the ruby version in your Gemfile
ENV RUBY_VERSION=3.2.1
RUN /bin/bash -l -c "rvm install $RUBY_VERSION && rvm --default use 3.2.1"

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash && apt-get install -y --no-install-recommends nodejs

# Install bundler
ENV BUNDLER_VERSION=2.4.6

# Cleans bundler cache & Gemfile locks
ENV BUNDLE_SPECIFIC_PLATFORM=true
RUN rm -rf /usr/local/bundle/cache

# Create working directory
WORKDIR /build

COPY . /build/

RUN 'bin/setup'

# Trying to resolve deadlock and permission issues
RUN chmod -R 777 /build

# Expose port 3000 to the outside world
EXPOSE 3000

# The command to run the app
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]

# To build this image, run `docker-compose build` in the terminal
