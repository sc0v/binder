#!/bin/bash
set -e

echo "Setting up development environment..."

echo "Installing gems..."
sudo chown -R vscode:vscode /usr/local/bundle
bundle install

echo "Setting up credentials..."
rm -f config/master.key config/credentials.yml.enc
EDITOR="touch" bin/rails credentials:edit

echo "Setting up database..."
bin/rails db:prepare

echo "Setup complete! Run 'rails s' to start the server."