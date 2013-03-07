# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# Force new deployments to generate a new secret token:
# 1. execute
#      rake secret
#    and put the contents into the the empty single quotes on
#    the last line.
# 2. execute
#      git update-index --assume-unchanged secret_token.rb
# 3. comment out the next line:
raise "Must update secret token! See secret_token.rb"
Trailer::Application.config.secret_token = ''
