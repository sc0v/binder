FROM ruby:3.4.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY . /build/

RUN npm install
RUN gem install bundler --conservative
RUN bundle check || bundle install --without development test

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rake assets:precompile

COPY ./docker/production/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails server -b 0.0.0.0"]
