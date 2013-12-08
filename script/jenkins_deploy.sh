#rvm use 1.9.3
#sudo gem install ruby-graphviz
#sudo apt-get install nodejs

#might be necessary?
rm Gemfile.lock
#gem uninstall capistrano -v 3.0.0
#gem install capistrano -v 2.15.5

#run db script
. $PWD/script/db.sh

bundle install
ls

rake db:reset

#Jenkins CI Testing
rake db:test:prepare
rake db:test:load
echo '**** Running Unit & Integration Tests *****'
rake ci:setup:minitest test
echo '**** Running Rspec/Capybara/Request/View Feature Tests *****'
rake ci:setup:rspec spec:features

#rake ci:setup:cucumber features #cucumber doesnt run

# # Run all unit tests
# rake test:units
# # Run all functional tests
# rake test:functionals
# # Run all integration tests
# rake test:integration

#Sanitize db: drop old data, create new db, run migratiosn and seed it
#rake db:reset

#make permissions correctly if necessary
#sudo chown -R jenkins tmp/

#start new server daemon fail gracefully!
rails s -d || true

cap staging deploy

echo 'Hello World It works! Successful build, test, and deploy!'