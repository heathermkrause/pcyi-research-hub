namespace :user do
  task :create_admin => :environment do
    User.create!(:name => "admin", :email => "admin@pcyi.com", :password => "allow2pass", :password_confirmation => "allow2pass", :admin => true)
    puts "Admin user created."
  end
end
