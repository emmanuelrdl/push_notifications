namespace :rpush do
  task :run => :environment do
    Rpush.push
    Rpush.apns_feedback
  end
end