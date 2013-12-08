namespace :db do
  desc "Lookup list of andrew ids in directory                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         "
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :ldap => :environment do
    puts "Starting Script"
    
    arr = ['smcquaid', 'rcrown']
    
    arr.each do |nameVar|
      thePerson = CarnegieMellonPerson.find_by_andrewid(nameVar)
      puts thePerson['cn']
    end
    
  end
end
