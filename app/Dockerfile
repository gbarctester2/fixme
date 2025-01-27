ARG RUBY_VERSION=3.2.6
FROM docker.io/library/ruby:$RUBY_VERSION-slim

RUN mkdir -p /app

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips make g++ libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

RUN gem i bundler --no-document -v=2.4.19

ADD . /app/
WORKDIR /app

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./run.sh"]
