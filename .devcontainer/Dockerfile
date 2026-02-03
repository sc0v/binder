FROM ruby:3.2.1

# Install dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    build-essential \
    cowsay \
    git \
    curl \
    wget \
    vim \
    sqlite3 \
    libsqlite3-dev \
    libldap2-dev \
    libreadline-dev \
    libsasl2-dev \
    nodejs \
    npm \
    imagemagick \
    libvips \
    && npm install -g yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir -p /usr/local/bundle \
    && chown -R $USERNAME:$USERNAME /usr/local/bundle \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install Rails and Bundler
RUN gem install rails bundler

WORKDIR /workspace

USER $USERNAME

# Aliases
RUN echo 'alias be="bundle exec"' >> ~/.bashrc \
    && echo 'alias rails="bundle exec rails"' >> ~/.bashrc \
    && echo 'alias rake="bundle exec rake"' >> ~/.bashrc
