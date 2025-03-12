# Use the ruby 3.2 for runtime image that works with ruby version 3.2.1
FROM ruby:3.2.1

# install RVM
RUN apt-get update && apt-get install -y --no-install-recommends gnupg2
RUN gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \curl -sSL https://get.rvm.io | bash -s stable && /bin/bash

# install ruby
# TODO: change the env to match the ruby version in your Gemfile
ENV RUBY_VERSION=3.2.1
RUN /bin/bash -l -c "rvm install $RUBY_VERSION && rvm --default use 3.2.1"

# install utilites
RUN apt-get update
RUN apt-get -y install nano
RUN apt-get -y install vim
RUN apt-get -y install emacs

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash && apt-get install -y --no-install-recommends nodejs

# Create working directory
WORKDIR /build

COPY . /build/

# Install gems and npm dependencies
RUN npm install
RUN gem install bundler --conservative
RUN bundle check || bundle install --without development test

# Precompile assets - only required for non-API apps
RUN rake assets:precompile

# Set up env
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

COPY ./docker/production/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000 to the outside world
EXPOSE 3000

# The command to run the app
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails server -b 0.0.0.0"]

# This image should only be built in production!
